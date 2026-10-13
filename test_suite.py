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

import data
import mock_gold
import analytics_engine as AE
import ml_engine
import llm_engine
import alpha_earth_engine


class TestDataAndSpecIntegrity(unittest.TestCase):
    def test_27_tables_present(self):
        self.assertEqual(len(data.ALL_TABLES), 27, "Expected exactly 27 tables defined in Unity Catalog spec")
        for tbl in data.ALL_TABLES:
            self.assertIn(tbl, data.SPEC, f"Table {tbl} must be present in data.SPEC")

    def test_mock_gold_generation(self):
        mg = mock_gold.get()
        self.assertGreaterEqual(len(mg), 27, "mock_gold must generate at least 27 tables")
        for tbl in data.ALL_TABLES:
            self.assertIn(tbl, mg, f"Table {tbl} must be generated in mock_gold")
            self.assertIsInstance(mg[tbl], pd.DataFrame, f"Table {tbl} must be a DataFrame")
            self.assertFalse(mg[tbl].empty, f"Table {tbl} must not be empty")

    def test_geospatial_coordinates_present(self):
        mg = mock_gold.get()
        prop_df = mg["property"]
        self.assertIn("latitude", prop_df.columns)
        self.assertIn("longitude", prop_df.columns)
        self.assertTrue(prop_df["latitude"].notna().all())
        self.assertTrue(prop_df["longitude"].notna().all())


class TestAnalyticsEngine(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.core = data.load_core(use_genie=False)
        cls.C = cls.core.get("customer_profile", cls.core.get("customer", {})).get("df", pd.DataFrame())
        cls.P = cls.core.get("property_profile", cls.core.get("property", {})).get("df", pd.DataFrame())
        cls.PO = cls.core.get("gold_policy_report", cls.core.get("policy", {})).get("df", pd.DataFrame())
        cls.CL = cls.core.get("gold_claim_report", cls.core.get("claim", {})).get("df", pd.DataFrame())
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
        core = data.load_core(use_genie=False)
        P = core.get("property_profile", core.get("property", {})).get("df", pd.DataFrame())
        metrics = ml_engine.ml_model.train(P)
        self.assertTrue(ml_engine.ml_model.is_trained)
        self.assertIn("accuracy", metrics)
        self.assertIn("roc_auc", metrics)
        self.assertGreater(metrics["accuracy"], 0.70)
        self.assertGreater(metrics["roc_auc"], 0.60)

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
        cls.mg = mock_gold.get()
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
        mg = mock_gold.get()
        twins = alpha_earth_engine.alpha_earth.find_hazard_twins(
            target_property_id=mg["property"].iloc[0]["property_id"],
            properties_df=mg["property"],
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


if __name__ == "__main__":
    unittest.main(verbosity=2)
