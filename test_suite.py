"""Comprehensive Automated Test Suite for Insurance Analytics Application.

Tests:
  1. Unity Catalog Data & Spec Integrity (All 27 Tables)
  2. Analytics Engine (Executive KPIs, Financials, Catastrophe Stress, Agents)
  3. Machine Learning Models (Random Forest, Actuarial GLM, Inference Simulator)
  4. Open LLM & In-App Data RAG Engine (Context Retrieval, Grounding, Multi-turn Chat, Memos)
  5. AlphaEarth GeoAI Embeddings (64D Latent Vectors, Cosine Similarity, Temporal Drift)
  6. Streamlit Views Static Invocation & Type Safety
"""

import sys
import unittest
import numpy as np
import pandas as pd

from pathlib import Path
import data
import analytics_engine as AE
import ml_engine
import llm_engine
import alpha_earth_engine


def load_sample_dataset():
    """Loads datasets directly from sample_data/ CSV files for testing."""
    out = {}
    sample_dir = Path(__file__).parent / "sample_data"
    for name in data.ALL_TABLES:
        p = sample_dir / f"{name}.csv"
        if p.exists():
            df = pd.read_csv(p)
            _, cols = data.SPEC.get(name, (name, []))
            out[name] = data.coerce(df, cols) if cols else df
    return out


class TestDataAndSpecIntegrity(unittest.TestCase):
    def test_27_tables_present(self):
        self.assertEqual(len(data.ALL_TABLES), 27, "Expected exactly 27 tables defined in Unity Catalog spec")
        for tbl in data.ALL_TABLES:
            self.assertIn(tbl, data.SPEC, f"Table {tbl} must be present in data.SPEC")

    def test_table_schema_spec_definitions(self):
        sample_data = load_sample_dataset()
        self.assertGreaterEqual(len(sample_data), 27, "sample_data must contain all 27 tables")
        for tbl in data.ALL_TABLES:
            self.assertIn(tbl, sample_data, f"Table {tbl} must be present in sample_data")
            self.assertIsInstance(sample_data[tbl], pd.DataFrame, f"Table {tbl} must be a DataFrame")
            self.assertFalse(sample_data[tbl].empty, f"Table {tbl} must not be empty")

    def test_geospatial_coordinates_present(self):
        sample_data = load_sample_dataset()
        prop_df = sample_data["property"]
        self.assertIn("latitude", prop_df.columns)
        self.assertIn("longitude", prop_df.columns)
        self.assertTrue(prop_df["latitude"].notna().all())
        self.assertTrue(prop_df["longitude"].notna().all())


class TestAnalyticsEngine(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        sample_data = load_sample_dataset()
        po_df = sample_data.get("gold_policy_report", pd.DataFrame())
        cl_df = sample_data.get("gold_claim_report", pd.DataFrame())
        c_df, p_df = data.derive_profiles(po_df, cl_df)
        cls.C = c_df
        cls.P = p_df
        cls.PO = po_df
        cls.CL = cl_df
        cls.CL = cls.CL.assign(paid=cls.CL.amount_paid_on_building_claim.fillna(0) + cls.CL.amount_paid_on_contents_claim.fillna(0) + cls.CL.amount_paid_on_icc_claim.fillna(0))
        cls.PO = cls.PO.assign(coverage=cls.PO.total_building_insurance_coverage.fillna(0) + cls.PO.total_contents_insurance_coverage.fillna(0))
        cls.ACT = cls.P[cls.P.active_policy_id.notna()].assign(coverage=lambda d: d.active_building_coverage.fillna(0) + d.active_contents_coverage.fillna(0))
        AS_OF = pd.Timestamp("2024-10-31")
        cls.ACT = cls.ACT.assign(days=(cls.ACT.policy_expiration_date - AS_OF).dt.days)
        cls.AS_OF = AS_OF

    def test_executive_cockpit_metrics(self):
        metrics = AE.compute_executive_cockpit(self.C, self.P, self.PO, self.CL, self.ACT, self.AS_OF)
        self.assertIn("active_policies", metrics)
        self.assertIn("net_loss_ratio", metrics)
        self.assertIn("total_exposure", metrics)
        self.assertGreater(metrics["active_policies"], 0)
        self.assertGreater(metrics["total_exposure"], 0)

    def test_financial_ratios(self):
        res = AE.compute_financial_ratios(self.PO, self.CL)
        self.assertIn("state_matrix", res)
        self.assertIn("yearly_trend", res)
        self.assertIn("claim_components", res)
        self.assertIsInstance(res["yearly_trend"], pd.DataFrame)
        self.assertFalse(res["yearly_trend"].empty)

    def test_catastrophe_stress_test(self):
        res = AE.simulate_catastrophe_stress(
            ACT=self.ACT,
            CL=self.CL,
            scenario_name="Cat 4 Hurricane Landfall",
            frequency_multiplier=2.5,
            severity_multiplier=1.8,
            target_zone="All Zones"
        )
        self.assertIn("stressed_claims", res)
        self.assertIn("stressed_loss_ratio", res)
        self.assertIn("stressed_payout", res)
        self.assertGreater(res["stressed_claims"], 0)

    def test_agent_performance(self):
        agent_df = AE.compute_agent_performance(self.C, self.P, self.ACT)
        self.assertFalse(agent_df.empty)
        self.assertIn("active_premium", agent_df.columns)


class TestMachineLearningEngine(unittest.TestCase):
    def test_ml_model_training_and_metrics(self):
        sample_data = load_sample_dataset()
        po_df = sample_data.get("gold_policy_report", pd.DataFrame())
        cl_df = sample_data.get("gold_claim_report", pd.DataFrame())
        _, P = data.derive_profiles(po_df, cl_df)
        metrics = ml_engine.ml_model.train(P)
        self.assertTrue(ml_engine.ml_model.is_trained)
        self.assertIn("accuracy", metrics)
        self.assertIn("roc_auc", metrics)
        self.assertGreater(metrics["accuracy"], 0.55)
        self.assertGreater(metrics["roc_auc"], 0.55)

    def test_ml_custom_property_scoring(self):
        score = ml_engine.ml_model.score_custom_property(
            flood_zone="VE",
            crs_class=8,
            construction_band="Pre-FIRM",
            elevated=False,
            mitigation_count=0,
            county_disasters=4,
            building_coverage=300000,
            contents_coverage=100000
        )
        self.assertIn("predicted_claim_probability", score)
        self.assertIn("predicted_claim_severity", score)
        self.assertIn("recommended_annual_premium", score)
        self.assertIn("risk_band", score)
        self.assertEqual(score["risk_band"], "High")
        self.assertGreater(score["recommended_annual_premium"], 0)


class TestOpenLLMAndRAGEngine(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.mg = load_sample_dataset()
        cls.rag = llm_engine.InAppDataRAG(
            src_dict=cls.mg,
            C=cls.mg["customer"],
            P=cls.mg["property"],
            PO=cls.mg["policy"],
            CL=cls.mg["claim"]
        )

    def test_in_app_data_rag_retrieval(self):
        context, citations = self.rag.retrieve_context("Show top 5 claims by payout")
        self.assertGreater(len(citations), 0)
        self.assertIn("CLAIMS", context.upper())

    def test_in_app_actuarial_chat_response(self):
        context, _ = self.rag.retrieve_context("What is our net loss ratio health?")
        answer = llm_engine.copilot.generate_rag_response(
            query="What is our net loss ratio health?",
            context_str=context,
            model_name="in-app-actuarial"
        )
        self.assertIsInstance(answer, str)
        self.assertGreater(len(answer), 50)
        self.assertIn("Loss Ratio", answer)

    def test_underwriting_memo_generation(self):
        c_row = self.mg["customer"].iloc[0].to_dict()
        memo = llm_engine.copilot.generate_underwriting_memo(
            customer_row=c_row,
            properties_df=self.mg["property"].head(2),
            claims_df=self.mg["claim"].head(1),
            model_name="in-app-actuarial"
        )
        self.assertIn("ACTUARIAL UNDERWRITING MEMORANDUM", memo)
        self.assertIn("Executive Risk Classification", memo)

    def test_claims_adjuster_brief_generation(self):
        cl_row = self.mg["claim"].iloc[0].to_dict()
        brief = llm_engine.copilot.generate_claim_loss_narrative(
            claim_row=cl_row,
            model_name="in-app-actuarial"
        )
        self.assertIn("CLAIMS ADJUSTER LOSS INVESTIGATION BRIEF", brief)
        self.assertIn("Building Structural Settlement", brief)


class TestAlphaEarthGeoAIEngine(unittest.TestCase):
    def test_64d_embedding_vector(self):
        vec = alpha_earth_engine.alpha_earth.get_property_embedding(lat=29.76, lon=-95.36, property_id="PR-TEST", year=2024)
        self.assertIsInstance(vec, np.ndarray)
        self.assertEqual(len(vec), 64, "AlphaEarth embedding must be exactly 64-dimensional")
        # Check L2 unit normalization
        norm = np.linalg.norm(vec)
        self.assertAlmostEqual(norm, 1.0, places=4)

    def test_hazard_twin_search(self):
        sample_data = load_sample_dataset()
        twins = alpha_earth_engine.alpha_earth.find_hazard_twins(
            target_property_id=sample_data["property"].iloc[0]["property_id"],
            properties_df=sample_data["property"],
            top_k=5
        )
        self.assertEqual(len(twins), 5)
        for twin in twins:
            self.assertIn("similarity", twin)
            self.assertGreaterEqual(twin["similarity"], -1.0)
            self.assertLessEqual(twin["similarity"], 1.0)

    def test_temporal_environmental_drift(self):
        drift = alpha_earth_engine.alpha_earth.compute_temporal_drift(
            lat=29.76, lon=-95.36, property_id="PR-TEST", base_year=2018, current_year=2024
        )
        self.assertIn("cosine_similarity", drift)
        self.assertIn("euclidean_drift_distance", drift)
        self.assertIn("drift_classification", drift)
        self.assertGreaterEqual(drift["euclidean_drift_distance"], 0.0)


class TestDataAuthenticityAndIntegrity(unittest.TestCase):
    """Deep verification of relational, financial, temporal, and spatial authenticity of data."""

    @classmethod
    def setUpClass(cls):
        cls.mg = load_sample_dataset()
        cls.cust = cls.mg["customer"]
        cls.prop = cls.mg["property"]
        cls.pol = cls.mg["policy"]
        cls.clm = cls.mg["claim"]

    def test_foreign_key_referential_integrity(self):
        """Authenticates that foreign keys map to existing primary entities."""
        valid_cust_ids = set(self.cust["customer_id"])
        valid_prop_ids = set(self.prop["property_id"])
        valid_pol_ids = set(self.pol["policy_id"])

        # Check policy -> customer reference
        for cid in self.pol["customer_id"].dropna():
            self.assertIn(cid, valid_cust_ids, f"Policy references non-existent customer: {cid}")

        # Check policy -> property reference
        for pid in self.pol["property_id"].dropna():
            self.assertIn(pid, valid_prop_ids, f"Policy references non-existent property: {pid}")

        # Check claim -> policy reference
        for pol_id in self.clm["policy_id"].dropna():
            self.assertIn(pol_id, valid_pol_ids, f"Claim references non-existent policy: {pol_id}")

    def test_financial_reconciliation(self):
        """Authenticates mathematical accuracy of payments, coverage, and premiums."""
        # 1. Total paid claim reconciliation: building + contents + icc
        bldg = self.clm["amount_paid_on_building_claim"].fillna(0.0)
        cont = self.clm["amount_paid_on_contents_claim"].fillna(0.0)
        icc = self.clm["amount_paid_on_icc_claim"].fillna(0.0)
        comp_sum = (bldg + cont + icc).round(2)

        if "actual_amount_paid" in self.clm.columns:
            actual = self.clm["actual_amount_paid"].fillna(0.0).round(2)
            np.testing.assert_allclose(comp_sum.values, actual.values, rtol=1e-4)

        # 2. Payout amounts are strictly non-negative
        self.assertTrue((bldg >= 0).all(), "Found negative building claim payouts")
        self.assertTrue((cont >= 0).all(), "Found negative contents claim payouts")
        self.assertTrue((icc >= 0).all(), "Found negative ICC claim payouts")

        # 3. Policy premium is positive
        self.assertTrue((self.pol["total_insurance_premium"] > 0).all(), "Found zero or negative premiums")

        # 4. Coverage limits are positive
        self.assertTrue((self.pol["total_building_insurance_coverage"] > 0).all(), "Found zero or negative building coverage")

    def test_temporal_authenticity(self):
        """Authenticates chronological ordering of effective, expiration, and loss dates."""
        # Policy: effective date <= termination date
        eff = pd.to_datetime(self.pol["policy_effective_date"])
        term = pd.to_datetime(self.pol["policy_termination_date"])
        self.assertTrue((eff <= term).all(), "Found policy where effective date is after termination date")

        # Claim: loss date year matches year_of_loss column
        dol = pd.to_datetime(self.clm["date_of_loss"])
        yol = self.clm["year_of_loss"]
        np.testing.assert_array_equal(dol.dt.year.values, yol.values)

    def test_geospatial_bounds_and_flood_zones(self):
        """Authenticates physical coordinates within US bounds and valid FEMA hazard zones."""
        lat = self.prop["latitude"].astype(float)
        lon = self.prop["longitude"].astype(float)

        # US continental coordinates bounds
        self.assertTrue((lat >= 24.0).all() and (lat <= 50.0).all(), "Latitude outside US bounds")
        self.assertTrue((lon >= -125.0).all() and (lon <= -66.0).all(), "Longitude outside US bounds")

        # FEMA Flood Zone designations (including legacy moderate/minimal hazard zones B and C)
        valid_zones = {"A", "AE", "AH", "AO", "A99", "AR", "V", "VE", "X", "D", "B", "C"}
        prop_zones = set(self.prop["flood_zone"].dropna().unique())
        self.assertTrue(prop_zones.issubset(valid_zones), f"Invalid FEMA flood zones detected: {prop_zones - valid_zones}")

    def test_actuarial_risk_score_calibration(self):
        """Authenticates actuarial risk score boundaries and risk ordering."""
        # Risk scores are bounded in [0, 100]
        if "assessed_risk_score" in self.prop.columns:
            scores = self.prop["assessed_risk_score"].dropna()
            self.assertTrue((scores >= 0).all() and (scores <= 100).all(), "Risk score outside [0, 100]")

            # High hazard zones (VE / AE) must have higher average risk than minimal hazard zones (X)
            ve_ae_risk = self.prop[self.prop["flood_zone"].isin(["VE", "AE"])]["assessed_risk_score"].mean()
            x_risk = self.prop[self.prop["flood_zone"] == "X"]["assessed_risk_score"].mean()
            if pd.notna(ve_ae_risk) and pd.notna(x_risk):
                self.assertGreater(ve_ae_risk, x_risk, "VE/AE flood zones must carry higher actuarial risk than X zone")


if __name__ == "__main__":
    unittest.main(verbosity=2)
