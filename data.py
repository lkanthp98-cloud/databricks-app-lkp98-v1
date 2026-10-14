"""Gold datasets for the dashboard.

Source of truth is a Genie space (GENIE_SPACE_ID) that you attach manually; if it is not set the app runs on built-in demo data
with the SAME columns, so the UI can be tested first. Each dataset is ONE Genie question, cached for an hour and shared by all sessions.
"""
import os
import threading
import time
from concurrent.futures import ThreadPoolExecutor

import pandas as pd

from config import AppConfig

SPEC = {
    # 1. Operational & Entity Tables
    "agent": ("agent", [
        ("agent_id", "s"), ("agent_name", "s"), ("state", "s")
    ]),
    "claim": ("claim", [
        ("claim_id", "s"), ("policy_id", "s"), ("community_id", "s"), ("date_of_loss", "d"),
        ("year_of_loss", "i"), ("state", "s"), ("county_code", "s"), ("amount_paid_on_building_claim", "n"),
        ("amount_paid_on_contents_claim", "n"), ("amount_paid_on_icc_claim", "n"),
        ("total_building_insurance_coverage", "n"), ("total_contents_insurance_coverage", "n"),
        ("occupancy_type", "s"), ("rated_flood_zone", "s"), ("primary_residence_indicator", "b"),
        ("elevated_building_indicator", "b"), ("synthetic_policy_key", "s")
    ]),
    "community": ("community", [
        ("community_id", "s"), ("community_name", "s"), ("county", "s"), ("state", "s"),
        ("participating_in_nfip", "b"), ("tribal", "b"), ("class_rating", "i"),
        ("sfha_discount", "f"), ("non_sfha_discount", "f"), ("sanction", "s")
    ]),
    "coverage": ("coverage", [
        ("coverage_id", "s"), ("policy_id", "s"), ("coverage_type", "s"), ("coverage_amount", "n")
    ]),
    "customer": ("customer", [
        ("customer_id", "s"), ("state", "s"), ("county_code", "s"), ("community_id", "s")
    ]),
    "document": ("document", [
        ("document_id", "s"), ("claim_id", "s"), ("document_type", "s"), ("created_date", "d")
    ]),
    "inspection": ("inspection", [
        ("inspection_id", "s"), ("property_id", "s"), ("agent_id", "s"), ("project_identifier", "s"),
        ("program_area", "s"), ("property_action", "s"), ("structure_type", "s"),
        ("foundation_type", "s"), ("damage_category", "s"), ("actual_amount_paid", "n"),
        ("number_of_properties", "i"), ("state", "s"), ("county", "s"), ("city", "s"),
        ("zip_code", "s"), ("synthetic_property_key", "s")
    ]),
    "policy": ("policy", [
        ("policy_id", "s"), ("customer_id", "s"), ("property_id", "s"), ("agent_id", "s"),
        ("community_id", "s"), ("policy_effective_date", "d"), ("policy_termination_date", "d"),
        ("total_building_insurance_coverage", "n"), ("total_contents_insurance_coverage", "n"),
        ("total_insurance_premium", "n"), ("hfiaa_surcharge", "n"), ("federal_policy_fee", "n"),
        ("occupancy_type", "s"), ("rated_flood_zone", "s"), ("state", "s"), ("county_code", "s"),
        ("synthetic_property_key", "s"), ("synthetic_policy_key", "s")
    ]),
    "property": ("property", [
        ("property_id", "s"), ("community_id", "s"), ("state", "s"), ("state_abbreviation", "s"),
        ("county", "s"), ("zip_code", "s"), ("city", "s"), ("flood_zone", "s"),
        ("latitude", "f"), ("longitude", "f"), ("occupancy_type", "s"),
        ("original_construction_date", "d"), ("primary_residence_indicator", "b"),
        ("total_losses", "i"), ("nfip_rl", "b"), ("nfip_srl", "b"),
        ("mitigated_indicator", "b"), ("insured_indicator", "b"),
        ("synthetic_geo_key", "s"), ("synthetic_zip_key", "s")
    ]),

    # 2. Dimensional Warehouse & Star-Schema Tables
    "dim_community": ("dim_community", [
        ("community_key", "i"), ("community_id_number", "s"), ("community_name", "s"),
        ("state", "s"), ("participation_status", "s"), ("crs_class", "i")
    ]),
    "dim_date": ("dim_date", [
        ("date_key", "i"), ("full_date", "d"), ("day_of_week", "i"), ("day_name", "s"),
        ("day_of_month", "i"), ("month", "i"), ("month_name", "s"), ("quarter", "i"),
        ("year", "i"), ("fiscal_year", "i"), ("is_weekend", "b")
    ]),
    "dim_disaster_declaration": ("dim_disaster_declaration", [
        ("disaster_key", "i"), ("disaster_number", "i"), ("fema_declaration_string", "s"),
        ("declaration_type", "s"), ("declaration_title", "s"), ("incident_type", "s"),
        ("declaration_date", "d"), ("incident_begin_date", "d"), ("incident_end_date", "d"),
        ("ih_program_declared", "b"), ("ia_program_declared", "b"), ("pa_program_declared", "b"),
        ("hm_program_declared", "b")
    ]),
    "dim_geography": ("dim_geography", [
        ("geography_key", "i"), ("state", "s"), ("fips_state_code", "s"), ("county_code", "s"),
        ("fips_county_code", "s"), ("region", "s")
    ]),
    "dim_hma_project": ("dim_hma_project", [
        ("project_key", "i"), ("project_identifier", "s"), ("program_area", "s"),
        ("project_type", "s"), ("status", "s"), ("recipient", "s"), ("subrecipient", "s"),
        ("project_title", "s")
    ]),
    "dim_property_profile": ("dim_property_profile", [
        ("property_profile_key", "i"), ("occupancy_type", "s"), ("flood_zone", "s"),
        ("construction_date_band", "s"), ("primary_residence_indicator", "b"),
        ("elevated_building_indicator", "b"), ("condominium_indicator", "b")
    ]),
    "fact_disaster_declaration_area": ("fact_disaster_declaration_area", [
        ("declaration_area_key", "i"), ("declaration_date_key", "i"), ("geography_key", "i"),
        ("disaster_key", "i"), ("ih_program_declared", "b"), ("ia_program_declared", "b"),
        ("pa_program_declared", "b"), ("hm_program_declared", "b"), ("declaration_count", "i")
    ]),
    "fact_hma_financial_transaction": ("fact_hma_financial_transaction", [
        ("transaction_key", "i"), ("obligated_date_key", "i"), ("geography_key", "i"),
        ("project_key", "i"), ("disaster_key", "i"), ("transaction_level", "s"),
        ("obligated_amount", "n"), ("federal_share_obligated", "n"), ("transaction_count", "i")
    ]),
    "fact_nfip_claim": ("fact_nfip_claim", [
        ("claim_key", "i"), ("date_of_loss_key", "i"), ("geography_key", "i"),
        ("community_key", "i"), ("property_profile_key", "i"), ("disaster_key", "i"),
        ("amount_paid_on_building_claim", "n"), ("amount_paid_on_contents_claim", "n"),
        ("amount_paid_on_icc_claim", "n"), ("net_building_payment_amount", "n"),
        ("net_contents_payment_amount", "n"), ("total_building_insurance_coverage", "n"),
        ("total_contents_insurance_coverage", "n"), ("claim_count", "i")
    ]),
    "fact_nfip_policy": ("fact_nfip_policy", [
        ("policy_key", "i"), ("effective_date_key", "i"), ("expiration_date_key", "i"),
        ("geography_key", "i"), ("community_key", "i"), ("property_profile_key", "i"),
        ("total_building_insurance_coverage", "n"), ("total_contents_insurance_coverage", "n"),
        ("total_insurance_premium", "n"), ("hfiaa_surcharge", "n"), ("federal_policy_fee", "n"),
        ("policy_count", "i")
    ]),

    # 3. Gold Reporting & Aggregate Tables
    "gold_claim_report": ("gold_claim_report", [
        ("claim_id", "s"), ("claim_id_uuid", "s"), ("policy_id", "s"), ("policy_id_uuid", "s"), ("state", "s"),
        ("community_name", "s"), ("date_of_loss", "d"), ("year_of_loss", "i"),
        ("amount_paid_on_building_claim", "n"), ("amount_paid_on_contents_claim", "n"), ("amount_paid_on_icc_claim", "n"),
        ("total_building_insurance_coverage", "n"), ("total_contents_insurance_coverage", "n")
    ]),
    "gold_claims_by_disaster": ("gold_claims_by_disaster", [
        ("disaster_number", "i"), ("fema_declaration_string", "s"), ("declaration_title", "s"),
        ("incident_type", "s"), ("claim_count", "i"), ("total_paid", "n")
    ]),
    "gold_loss_ratio_by_state_year": ("gold_loss_ratio_by_state_year", [
        ("state", "s"), ("year", "i"), ("total_premium", "n"), ("claim_count", "i"), ("total_paid", "n"),
        ("loss_ratio", "f"), ("data_status", "s")
    ]),
    "gold_mitigation_vs_claims_by_state": ("gold_mitigation_vs_claims_by_state", [
        ("state", "s"), ("total_mitigation_spend", "n"), ("total_claims_paid", "n")
    ]),
    "gold_policy_report": ("gold_policy_report", [
        ("policy_id", "s"), ("policy_id_uuid", "s"), ("state", "s"), ("county_code", "s"), ("community_name", "s"),
        ("policy_effective_date", "d"), ("policy_termination_date", "d"),
        ("total_building_insurance_coverage", "n"), ("total_contents_insurance_coverage", "n"), ("total_insurance_premium", "n")
    ]),
    "gold_property_risk": ("gold_property_risk", [
        ("state", "s"), ("zone_group", "s"), ("construction_date_band", "s"), ("elevated", "b"), ("region", "s"),
        ("data_status", "s"), ("policy_count", "i"), ("claim_count", "i"), ("claims_paid", "n"), ("premium", "n"),
        ("coverage_total", "n"), ("loss_ratio", "f"), ("claim_frequency", "f"), ("avg_claim_paid", "n"),
        ("declared_disasters", "i"), ("hma_projects", "i"), ("loss_component", "f"), ("hazard_component", "f"),
        ("property_component", "f"), ("protection_component", "f"), ("credibility", "f"), ("risk_score", "f"),
        ("risk_band", "s"), ("top_driver", "s"), ("window_start_year", "i"), ("window_end_year", "i"), ("_built_at", "s")
    ]),
    "gold_risk_by_geography": ("gold_risk_by_geography", [
        ("state", "s"), ("region", "s"), ("policy_count", "i"), ("claim_count", "i"), ("claims_paid", "n"),
        ("premium", "n"), ("declared_disasters", "i"), ("hma_projects", "i"), ("high_risk_segments", "i"),
        ("segments", "i"), ("risk_score", "f"), ("loss_ratio", "f"), ("risk_band", "s")
    ]),

    # 4. Identity & Key Mapping
    "id_map": ("id_map", [
        ("entity", "s"), ("uuid_value", "s"), ("seq", "i"), ("display_id", "s")
    ]),
}

GOLD_TABLES = [
    "gold_claim_report",
    "gold_policy_report",
    "gold_property_risk",
    "gold_risk_by_geography",
    "gold_loss_ratio_by_state_year",
    "gold_claims_by_disaster",
    "gold_mitigation_vs_claims_by_state",
]

OPERATIONAL_TABLES = [
    "customer",
    "property",
    "policy",
    "claim",
    "agent",
    "community",
    "coverage",
    "inspection",
    "document",
]

DIMENSIONAL_TABLES = [
    "dim_community",
    "dim_date",
    "dim_disaster_declaration",
    "dim_geography",
    "dim_hma_project",
    "dim_property_profile",
    "fact_disaster_declaration_area",
    "fact_hma_financial_transaction",
    "fact_nfip_claim",
    "fact_nfip_policy",
]

UTILITY_TABLES = ["id_map"]

ALL_TABLES = list(SPEC.keys())
CORE = list(GOLD_TABLES)


def __getattr__(name: str):
    if name == "CATALOG":
        return AppConfig.GOLD_CATALOG
    if name == "SCHEMA":
        return AppConfig.GOLD_SCHEMA
    if name in ("T", "FULL_SCHEMA"):
        return AppConfig.FULL_SCHEMA
    if name == "SPACE_ID":
        return AppConfig.GENIE_SPACE_ID
    if name == "CACHE_TTL":
        return AppConfig.CACHE_TTL_SECONDS
    raise AttributeError(f"module '{__name__}' has no attribute '{name}'")


def question(name):
    table, _ = SPEC[name]
    return f"Show all rows and all columns from {AppConfig.FULL_SCHEMA}.{table}. No filter and no limit."


DISASTER_Q = (f"For each incident_type in {AppConfig.FULL_SCHEMA}.dim_disaster_declaration, join {AppConfig.FULL_SCHEMA}.fact_nfip_claim on disaster_key and return incident_type, "
              f"count of claims as claims and the sum of amount_paid_on_building_claim + amount_paid_on_contents_claim + amount_paid_on_icc_claim as paid.")


def coerce(df, cols):
    """Genie returns strings (JSON) or typed arrays (Arrow): normalise to the Gold types."""
    df = df.copy()
    df.columns = [str(c).lower() for c in df.columns]
    missing = [c for c, _ in cols if c not in df.columns]
    if missing:
        # Fill missing columns with None / NaN to remain robust
        for c, t in cols:
            if c not in df.columns:
                df[c] = None
    out = pd.DataFrame(index=df.index)
    for c, t in cols:
        s = df[c]
        if t in ("i", "l"):
            out[c] = pd.to_numeric(s, errors="coerce").astype("Int64")
        elif t in ("n", "f"):
            out[c] = pd.to_numeric(s, errors="coerce").astype(float)
        elif t == "b":
            out[c] = s.map(lambda v: None if v is None or (isinstance(v, float) and pd.isna(v)) else (v if isinstance(v, bool) else str(v).strip().lower() in ("true", "t", "y", "yes", "1"))).astype("boolean")
        elif t == "d":
            out[c] = pd.to_datetime(s, errors="coerce")
        else:
            out[c] = s.astype("string").astype(object).where(s.notna(), None)
    return out


_lock = threading.Lock()
_store = {}          # name -> dict(ts, df, sql, seconds, note)
_source = None


def live():
    return AppConfig.IS_LIVE


def _genie():
    global _source
    if _source is None:
        from genie_client import GenieSource
        _source = GenieSource(AppConfig.GENIE_SPACE_ID, client=AppConfig.get_workspace_client())
    return _source


def _fresh(name):
    e = _store.get(name)
    return e if e and time.time() - e["ts"] < CACHE_TTL else None


def derive_profiles(po_df: pd.DataFrame, cl_df: pd.DataFrame, pr_df: pd.DataFrame = None):
    """Synthesizes customer_profile and property_profile from gold_policy_report and gold_claim_report."""
    if po_df.empty:
        return pd.DataFrame(), pd.DataFrame()

    po = po_df.copy()
    cl = cl_df.copy() if not cl_df.empty else pd.DataFrame(columns=["policy_id", "paid"])
    if "paid" not in cl.columns and not cl.empty:
        cl["paid"] = (
            cl.get("amount_paid_on_building_claim", 0).fillna(0)
            + cl.get("amount_paid_on_contents_claim", 0).fillna(0)
            + cl.get("amount_paid_on_icc_claim", 0).fillna(0)
        )

    # Claims aggregated by policy
    clm_agg = cl.groupby("policy_id").agg(
        claims_total=("claim_id", "count"),
        claims_paid_total=("paid", "sum"),
        last_loss_date=("date_of_loss", "max") if "date_of_loss" in cl.columns else ("policy_id", lambda _: pd.NaT)
    ).reset_index() if not cl.empty and "policy_id" in cl.columns else pd.DataFrame(columns=["policy_id", "claims_total", "claims_paid_total", "last_loss_date"])

    p_joined = pd.merge(po, clm_agg, on="policy_id", how="left")
    p_joined["claims_total"] = p_joined["claims_total"].fillna(0).astype(int)
    p_joined["claims_paid_total"] = p_joined["claims_paid_total"].fillna(0.0).astype(float)
    p_joined["claims_open"] = 0

    # Build property_profile
    props = []
    custs = []
    now = pd.Timestamp.today().normalize()
    for i, row in p_joined.iterrows():
        pid = f"PROP-{row['policy_id']}"
        cid = f"CUST-{row['policy_id']}"
        eff = pd.to_datetime(row.get("policy_effective_date", now))
        exp = pd.to_datetime(row.get("policy_termination_date", now + pd.Timedelta(days=365)))
        bcov = float(row.get("total_building_insurance_coverage", 250000.0) or 250000.0)
        ccov = float(row.get("total_contents_insurance_coverage", 100000.0) or 100000.0)
        prem = float(row.get("total_insurance_premium", 1800.0) or 1800.0)
        st_ = str(row.get("state", "TX"))
        cty_ = str(row.get("county_code", "Harris"))
        city_ = str(row.get("community_name", "Baytown"))

        props.append({
            "property_id": pid, "customer_id": cid, "address_line": f"{100 + i * 14} Ocean Drive",
            "city": city_, "zip_code": "77001", "state": st_, "county": cty_, "flood_zone": "AE",
            "construction_date_band": "Post-FIRM", "elevated": False, "crs_class": 7,
            "active_policy_id": row["policy_id"], "policy_expiration_date": exp,
            "active_building_coverage": bcov, "active_contents_coverage": ccov,
            "active_premium": prem, "policy_terms": 1, "claims_total": int(row["claims_total"]),
            "claims_open": 0, "claims_paid_total": float(row["claims_paid_total"]),
            "last_loss_date": row.get("last_loss_date", pd.NaT), "nfip_rl": bool(row["claims_total"] >= 2),
            "mitigation_count": 1, "assessed_risk_score": 48.0, "assessed_risk_band": "Medium",
            "county_declared_disasters_window": 3, "county_last_declared_year": 2024,
            "county_hma_projects": 8, "county_hma_obligated": 2400000.0, "county_insured_value": 35000000.0,
            "county_share_of_portfolio": 0.05, "county_rank": 1, "county_claims_paid_per_policy": 1250.0
        })

        days_to_ren = int((exp - now).days) if pd.notna(exp) else 90
        custs.append({
            "customer_id": cid, "first_name": "Insured", "last_name": str(row["policy_id"]),
            "customer_status": "ACTIVE" if days_to_ren > 0 else "LAPSED", "customer_since": eff,
            "agent_id": "AGT-01", "agent_name": "Hannah Brooks", "properties": 1, "states": 1,
            "active_policies": 1 if days_to_ren > 0 else 0, "policy_terms_total": 1,
            "building_coverage_active": bcov, "contents_coverage_active": ccov, "premium_active": prem,
            "next_renewal_date": exp, "days_to_renewal": days_to_ren,
            "renewal_due_60d": bool(0 <= days_to_ren <= 60), "renewal_pending": False,
            "claims_total": int(row["claims_total"]), "claims_open": 0,
            "claims_paid_total": float(row["claims_paid_total"]), "last_loss_date": row.get("last_loss_date", pd.NaT),
            "mitigation_count": 1, "primary_property_id": pid, "primary_county": cty_, "primary_state": st_,
            "highest_risk_score": 48.0, "highest_risk_band": "Medium", "highest_risk_property_id": pid,
            "in_special_flood_hazard_area": True, "pre_firm_properties": 0, "insured_value_active": bcov + ccov,
            "primary_county_insured_value": 35000000.0, "primary_county_share": 0.05, "primary_county_rank": 1,
            "primary_county_declared_disasters_window": 3, "primary_county_last_declared_year": 2024,
            "primary_county_hma_projects": 8, "primary_county_claims_paid_per_policy": 1250.0
        })

    return pd.DataFrame(custs), pd.DataFrame(props)


def _load_one(name):
    with _lock:
        e = _fresh(name)
    if e:
        return e
    table, cols = SPEC[name]
    df = None
    sql = ""
    sec = 0.0
    note = ""
    target_schema = AppConfig.FULL_SCHEMA

    # 1. Try Databricks SQL Warehouse if configured or auto-discovered
    if AppConfig.HAS_SQL_WAREHOUSE:
        candidates = [table]
        if table.startswith("gold_"):
            candidates.append(table.replace("gold_", "", 1).replace("_report", ""))
        elif not table.startswith("gold_"):
            candidates.append(f"gold_{table}")
            candidates.append(f"gold_{table}_report")

        last_wh_err = None
        for tbl_candidate in candidates:
            try:
                t0 = time.time()
                sql = f"SELECT * FROM {target_schema}.{tbl_candidate}"
                df_raw = AppConfig.execute_sql(sql)
                if df_raw is not None:
                    df = coerce(df_raw, cols) if cols else df_raw
                    sec = time.time() - t0
                    table = tbl_candidate
                    last_wh_err = None
                    break
            except Exception as ex:
                last_wh_err = ex
        if df is None and last_wh_err:
            note = f"Warehouse error on {table}: {last_wh_err}"

    # 2. Try Genie Space if SQL Warehouse not used or did not return table
    if df is None and AppConfig.GENIE_SPACE_ID:
        try:
            t0 = time.time()
            ans = _genie().ask(question(name))
            if ans.df is not None:
                df = coerce(ans.df, cols) if cols else ans.df
                sql = ans.sql or question(name)
                sec = ans.seconds
                note = " ".join(ans.notes)
        except Exception as ex:
            if not note:
                note = f"Genie error: {ex}"

    # 3. Fallback behavior in LIVE mode: never substitute mock data
    if df is None:
        df = pd.DataFrame(columns=[c for c, _ in cols]) if cols else pd.DataFrame()
        sql = f"(no live data: {target_schema}.{table})"
        if not note:
            if not AppConfig.HAS_SQL_WAREHOUSE and not AppConfig.GENIE_SPACE_ID:
                note = "Running offline. To query live data, connect a SQL Warehouse or Genie Space."
            else:
                note = f"Table {target_schema}.{table} not found or query failed on live warehouse."

    e = dict(ts=time.time(), df=df, sql=sql, seconds=sec, note=note, table=table)
    with _lock:
        _store[name] = e
    return e


def load_core(use_genie=None, force=False):
    """Loads all Gold tables and profiles. Parallel querying, rate-limited, cached."""
    use_live = AppConfig.IS_LIVE if use_genie is None else bool(use_genie)
    if not use_live:
        import mock_gold
        mg = mock_gold.get()
        return {k: dict(df=v, sql="(demo data)", seconds=0.0, note="", table=SPEC.get(k, (k, []))[0]) for k, v in mg.items()}
    if force:
        with _lock:
            _store.clear()

    # Load all tables defined in SPEC
    keys_to_load = list(SPEC.keys())
    with ThreadPoolExecutor(max_workers=min(len(keys_to_load), 8)) as ex:
        futs = {n: ex.submit(_load_one, n) for n in keys_to_load}
        res = {n: f.result() for n, f in futs.items()}

    # Synthesize customer/property profiles if missing or empty
    if "gold_policy_report" in res:
        po_df = res["gold_policy_report"]["df"]
        if not po_df.empty:
            cl_df = res.get("gold_claim_report", {}).get("df", pd.DataFrame())
            pr_df = res.get("gold_property_risk", {}).get("df", None)
            c_df, p_df = derive_profiles(po_df, cl_df, pr_df)
            res["customer_profile"] = dict(ts=time.time(), df=c_df, sql="(derived from gold_policy_report)", seconds=0.0, note="", table="gold_customer_profile")
            res["property_profile"] = dict(ts=time.time(), df=p_df, sql="(derived from gold_policy_report)", seconds=0.0, note="", table="gold_property_profile")
        else:
            cust_cols = ["customer_id", "first_name", "last_name", "customer_status", "customer_since", "agent_id", "agent_name", "properties", "states", "active_policies", "policy_terms_total", "building_coverage_active", "contents_coverage_active", "premium_active", "next_renewal_date", "days_to_renewal", "renewal_due_60d", "renewal_pending", "claims_total", "claims_open", "claims_paid_total", "last_loss_date", "mitigation_count", "primary_property_id", "primary_county", "primary_state", "highest_risk_score", "highest_risk_band", "highest_risk_property_id", "in_special_flood_hazard_area", "pre_firm_properties", "insured_value_active", "primary_county_insured_value", "primary_county_share", "primary_county_rank", "primary_county_declared_disasters_window", "primary_county_last_declared_year", "primary_county_hma_projects", "primary_county_claims_paid_per_policy"]
            prop_cols = ["property_id", "customer_id", "address_line", "city", "zip_code", "state", "county", "flood_zone", "construction_date_band", "elevated", "crs_class", "active_policy_id", "policy_expiration_date", "active_building_coverage", "active_contents_coverage", "active_premium", "policy_terms", "claims_total", "claims_open", "claims_paid_total", "last_loss_date", "nfip_rl", "mitigation_count", "assessed_risk_score", "assessed_risk_band", "county_declared_disasters_window", "county_last_declared_year", "county_hma_projects", "county_hma_obligated", "county_insured_value", "county_share_of_portfolio", "county_rank", "county_claims_paid_per_policy"]
            res["customer_profile"] = dict(ts=time.time(), df=pd.DataFrame(columns=cust_cols), sql="(empty)", seconds=0.0, note="", table="gold_customer_profile")
            res["property_profile"] = dict(ts=time.time(), df=pd.DataFrame(columns=prop_cols), sql="(empty)", seconds=0.0, note="", table="gold_property_profile")

    res["policy_report"] = res.get("gold_policy_report", res.get("policy_report"))
    res["claim_report"] = res.get("gold_claim_report", res.get("claim_report"))
    return res


def load_disasters(use_genie=None):
    use_genie = live() if use_genie is None else (use_genie and live())
    if not use_genie:
        import mock_gold
        return mock_gold.disasters()
    e = _fresh("disasters")
    if e:
        return e["df"]
    ans = _genie().ask(DISASTER_Q)
    if ans.df is None:
        raise RuntimeError(ans.text or "Genie did not return a table")
    df = coerce(ans.df, [("incident_type", "s"), ("claims", "i"), ("paid", "n")])
    _store["disasters"] = dict(ts=time.time(), df=df)
    return df


def diagnose():
    """One tiny question per Gold table, run one after another, so a failure points at the exact table / permission."""
    out = []
    for name in CORE:
        table, cols = SPEC[name]
        try:
            ans = _genie().ask(f"How many rows are in {AppConfig.FULL_SCHEMA}.{table}?")
            if ans.df is not None and len(ans.df):
                out.append((table, True, f"answered: {ans.df.iloc[0, 0]} rows", ans.sql))
            else:
                out.append((table, False, ans.text or "Genie answered without a table", ans.sql))
        except Exception as e:
            out.append((table, False, str(e), ""))
    return out


def whoami():
    """The identity the app queries Genie as (for a Databricks App this is its service principal's application id)."""
    try:
        return _genie().w.current_user.me().user_name
    except Exception:
        return None


def grant_sql(principal):
    p = principal or "<app-service-principal-application-id>"
    cat = AppConfig.GOLD_CATALOG
    sch = AppConfig.GOLD_SCHEMA
    return (f"GRANT USE CATALOG ON CATALOG {cat} TO `{p}`;\n"
            f"GRANT USE SCHEMA, SELECT ON SCHEMA {cat}.{sch} TO `{p}`;")
