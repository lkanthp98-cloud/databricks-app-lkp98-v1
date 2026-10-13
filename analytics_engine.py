"""Business & Data Analytics Engine for Property & Flood Insurance.

Provides:
  1. Executive KPIs (GWP, Net Loss Ratio, Exposure, Renewal At-Risk).
  2. Actuarial Risk & Hazard Profiling (SFHA Zones, Pre/Post-FIRM, CRS discounts).
  3. Financial Profitability & Loss Ratios (State/Year matrices, Severity breakdown).
  4. Interactive Catastrophe Stress Test Simulator.
  5. Agent Performance & Distribution Metrics.
  6. Catastrophe & Disaster Analysis (FEMA incident correlation & HMA grants).
  7. Pushdown SQL generation for direct execution on Databricks SQL Warehouses.
"""

from __future__ import annotations

from typing import Any, Dict, Optional, Tuple

import numpy as np
import pandas as pd

from config import AppConfig


# ==============================================================================
# 1. Direct Databricks SQL Pushdown Queries
# ==============================================================================

def get_sql_queries(catalog: str = None, schema: str = None) -> Dict[str, str]:
    """Generates optimized Databricks SQL pushdown queries for warehouse execution."""
    c = catalog or AppConfig.GOLD_CATALOG
    s = schema or AppConfig.GOLD_SCHEMA
    t = f"{c}.{s}"

    return {
        "portfolio_summary": f"""
            SELECT 
                COUNT(DISTINCT customer_id) AS total_customers,
                SUM(active_policies) AS total_active_policies,
                SUM(premium_active) AS total_active_premium,
                SUM(insured_value_active) AS total_insured_exposure,
                SUM(claims_total) AS total_claims_count,
                SUM(claims_paid_total) AS total_claims_paid
            FROM {t}.gold_customer_profile
        """,
        "loss_ratio_by_state": f"""
            SELECT 
                po.state,
                COUNT(DISTINCT po.policy_id) AS total_policies,
                SUM(po.total_insurance_premium) AS total_premium,
                COALESCE(SUM(cl.amount_paid_on_building_claim + cl.amount_paid_on_contents_claim + cl.amount_paid_on_icc_claim), 0) AS total_claims_paid,
                ROUND(COALESCE(SUM(cl.amount_paid_on_building_claim + cl.amount_paid_on_contents_claim + cl.amount_paid_on_icc_claim), 0) 
                      / NULLIF(SUM(po.total_insurance_premium), 0) * 100, 2) AS loss_ratio_pct
            FROM {t}.gold_policy_report po
            LEFT JOIN {t}.gold_claim_report cl ON po.policy_id = cl.policy_id
            GROUP BY po.state
            ORDER BY total_premium DESC
        """,
        "risk_by_flood_zone": f"""
            SELECT 
                flood_zone,
                COUNT(*) AS total_properties,
                AVG(assessed_risk_score) AS avg_risk_score,
                SUM(active_premium) AS total_active_premium,
                SUM(active_building_coverage + active_contents_coverage) AS total_exposure,
                SUM(claims_total) AS total_claims,
                SUM(claims_paid_total) AS total_claims_paid
            FROM {t}.gold_property_profile
            GROUP BY flood_zone
            ORDER BY total_exposure DESC
        """,
        "disaster_correlation": f"""
            SELECT 
                d.incident_type,
                COUNT(f.claim_key) AS total_claims,
                SUM(f.amount_paid_on_building_claim + f.amount_paid_on_contents_claim + f.amount_paid_on_icc_claim) AS total_paid
            FROM {t}.dim_disaster_declaration d
            JOIN {t}.fact_nfip_claim f ON d.disaster_key = f.disaster_key
            GROUP BY d.incident_type
            ORDER BY total_paid DESC
        """
    }


def query_pushdown_or_compute(query_key: str, fallback_fn) -> pd.DataFrame:
    """Attempts direct SQL pushdown on Databricks SQL Warehouse; falls back to analytical computation."""
    if AppConfig.HAS_SQL_WAREHOUSE:
        try:
            queries = get_sql_queries()
            if query_key in queries:
                df = AppConfig.execute_sql(queries[query_key])
                if df is not None and not df.empty:
                    return df
        except Exception:
            pass  # Fall back to localized DataFrame aggregation
    return fallback_fn()


# ==============================================================================
# 2. Executive Cockpit Metrics
# ==============================================================================

def compute_executive_cockpit(C: pd.DataFrame, P: pd.DataFrame, PO: pd.DataFrame, CL: pd.DataFrame, ACT: pd.DataFrame, as_of: pd.Timestamp) -> Dict[str, Any]:
    """Computes executive-level business analytics, loss ratios, and portfolio health indicators."""
    total_customers = len(C)
    active_customers = int((C.customer_status == "ACTIVE").sum())
    total_properties = len(P)
    active_policies = len(ACT)

    # Financial Exposure & Premium
    gwp_total = float(PO.total_insurance_premium.sum()) if not PO.empty else 0.0
    active_premium = float(ACT.active_premium.sum()) if not ACT.empty else 0.0
    total_exposure = float(ACT.coverage.sum()) if not ACT.empty else 0.0
    avg_premium_per_policy = active_premium / max(active_policies, 1)

    # Claims & Loss Ratio
    total_claims_count = len(CL)
    total_claims_paid = float(CL.paid.sum()) if not CL.empty else 0.0
    open_claims_count = int(P.claims_open.fillna(0).sum())
    
    # Net Loss Ratio: Paid Claims / Written Premium
    net_loss_ratio = (total_claims_paid / max(gwp_total, 1.0)) if gwp_total > 0 else 0.0

    # Flood Zone Exposure (A & V zones)
    is_sfha = ACT.flood_zone.fillna("").astype(str).str[:1].isin(["A", "V"])
    sfha_exposure = float(ACT[is_sfha].coverage.sum())
    sfha_exposure_share = sfha_exposure / max(total_exposure, 1.0)
    sfha_premium = float(ACT[is_sfha].active_premium.sum())

    # Renewals At Risk (Next 30 and 60 days)
    days_to_exp = (ACT.policy_expiration_date - as_of).dt.days
    ren_30d = ACT[days_to_exp.between(0, 30)]
    ren_60d = ACT[days_to_exp.between(0, 60)]

    premium_at_risk_30d = float(ren_30d.active_premium.sum())
    premium_at_risk_60d = float(ren_60d.active_premium.sum())
    policies_due_30d = len(ren_30d)
    policies_due_60d = len(ren_60d)

    # Portfolio Health Assessment
    if net_loss_ratio < 0.45:
        health_status = "Highly Profitable"
        health_color = "#38A169"  # Green
    elif net_loss_ratio < 0.65:
        health_status = "Healthy / Balanced"
        health_color = "#3182CE"  # Blue
    elif net_loss_ratio < 0.85:
        health_status = "Elevated Risk"
        health_color = "#D69E2E"  # Amber
    else:
        health_status = "Unfavorable Loss Ratio"
        health_color = "#E53E3E"  # Red

    return {
        "total_customers": total_customers,
        "active_customers": active_customers,
        "total_properties": total_properties,
        "active_policies": active_policies,
        "gwp_total": gwp_total,
        "active_premium": active_premium,
        "total_exposure": total_exposure,
        "avg_premium_per_policy": avg_premium_per_policy,
        "total_claims_count": total_claims_count,
        "total_claims_paid": total_claims_paid,
        "open_claims_count": open_claims_count,
        "net_loss_ratio": net_loss_ratio,
        "health_status": health_status,
        "health_color": health_color,
        "sfha_exposure": sfha_exposure,
        "sfha_exposure_share": sfha_exposure_share,
        "sfha_premium": sfha_premium,
        "policies_due_30d": policies_due_30d,
        "policies_due_60d": policies_due_60d,
        "premium_at_risk_30d": premium_at_risk_30d,
        "premium_at_risk_60d": premium_at_risk_60d,
    }


# ==============================================================================
# 3. Actuarial & Risk Profiling
# ==============================================================================

def compute_actuarial_profile(P: pd.DataFrame, ACT: pd.DataFrame) -> Dict[str, Any]:
    """Profiles hazard risk, Pre-FIRM exposure, CRS classes, and repetitive loss concentrations."""
    # 1. Flood Zone Breakdown
    zone_agg = ACT.groupby("flood_zone", as_index=False).agg(
        policies=("active_policy_id", "count"),
        exposure=("coverage", "sum"),
        premium=("active_premium", "sum"),
        claims_paid=("claims_paid_total", "sum")
    )
    zone_agg["rate_per_k"] = (zone_agg["premium"] / zone_agg["exposure"] * 1000).fillna(0)
    zone_agg["loss_ratio"] = (zone_agg["claims_paid"] / zone_agg["premium"].replace(0, np.nan)).fillna(0)

    # 2. Pre-FIRM vs Post-FIRM
    firm_agg = P.groupby("construction_date_band", as_index=False).agg(
        properties=("property_id", "count"),
        avg_risk=("assessed_risk_score", "mean"),
        total_claims=("claims_total", "sum"),
        paid_total=("claims_paid_total", "sum"),
        elevated_count=("elevated", lambda s: s.fillna(False).astype(bool).sum())
    )
    firm_agg["elevation_pct"] = (firm_agg["elevated_count"] / firm_agg["properties"]).fillna(0)

    # 3. CRS Class (Community Rating System)
    crs_agg = P.dropna(subset=["crs_class"]).groupby("crs_class", as_index=False).agg(
        properties=("property_id", "count"),
        avg_risk=("assessed_risk_score", "mean"),
        claims_paid=("claims_paid_total", "sum")
    ).sort_values("crs_class")

    # 4. Repetitive Loss (RL) properties
    rl_props = P[P.nfip_rl.fillna(False).astype(bool)]
    rl_summary = {
        "count": len(rl_props),
        "pct_of_properties": len(rl_props) / max(len(P), 1),
        "total_paid": float(rl_props.claims_paid_total.sum()),
        "avg_paid": float(rl_props.claims_paid_total.mean()) if len(rl_props) else 0.0,
        "avg_claims_per_property": float(rl_props.claims_total.mean()) if len(rl_props) else 0.0,
    }

    return {
        "zone_breakdown": zone_agg,
        "firm_breakdown": firm_agg,
        "crs_breakdown": crs_agg,
        "repetitive_loss": rl_summary,
    }


# ==============================================================================
# 4. Financial Profitability & Loss Ratios
# ==============================================================================

def compute_financial_ratios(PO: pd.DataFrame, CL: pd.DataFrame) -> Dict[str, Any]:
    """Computes Loss Ratio matrices across states, historical years, and claim payout components."""
    # State-level Loss Ratio Matrix
    prem_st = PO.groupby("state")["total_insurance_premium"].sum()
    paid_st = CL.groupby("state")["paid"].sum()
    clms_st = CL.groupby("state")["claim_id"].count()
    pols_st = PO.groupby("state")["policy_id"].count()

    states = sorted(set(prem_st.index) | set(paid_st.index))
    state_rows = []
    for st in states:
        pr = float(prem_st.get(st, 0.0))
        pd_amt = float(paid_st.get(st, 0.0))
        lr = (pd_amt / pr) if pr > 0 else 0.0
        state_rows.append({
            "State": st,
            "Policies": int(pols_st.get(st, 0)),
            "Premium Written": pr,
            "Claims Count": int(clms_st.get(st, 0)),
            "Claims Paid": pd_amt,
            "Loss Ratio": lr,
            "Profitability": "Profitable" if lr < 0.60 else ("Watchlist" if lr < 0.85 else "Critical")
        })
    df_state = pd.DataFrame(state_rows).sort_values("Premium Written", ascending=False)

    # Yearly Historical Loss Ratio
    yearly_prem = PO.assign(year=PO.policy_effective_date.dt.year).groupby("year")["total_insurance_premium"].sum()
    yearly_paid = CL.groupby("year_of_loss")["paid"].sum()
    all_years = sorted(set(yearly_prem.index) | set(yearly_paid.index))
    
    year_rows = []
    for yr in all_years:
        pr = float(yearly_prem.get(yr, 0.0))
        pd_amt = float(yearly_paid.get(yr, 0.0))
        lr = (pd_amt / pr) if pr > 0 else 0.0
        year_rows.append({
            "Year": int(yr),
            "Premium": pr,
            "Paid": pd_amt,
            "Loss Ratio": lr
        })
    df_year = pd.DataFrame(year_rows).sort_values("Year")

    # Claim Severity Components
    bldg_total = float(CL.amount_paid_on_building_claim.fillna(0).sum())
    cont_total = float(CL.amount_paid_on_contents_claim.fillna(0).sum())
    icc_total = float(CL.amount_paid_on_icc_claim.fillna(0).sum())
    total_paid = bldg_total + cont_total + icc_total

    component_df = pd.DataFrame([
        {"Component": "Building Coverage", "Amount Paid": bldg_total, "Share": (bldg_total / total_paid) if total_paid else 0.0},
        {"Component": "Contents Coverage", "Amount Paid": cont_total, "Share": (cont_total / total_paid) if total_paid else 0.0},
        {"Component": "ICC (Compliance)", "Amount Paid": icc_total, "Share": (icc_total / total_paid) if total_paid else 0.0},
    ])

    return {
        "state_matrix": df_state,
        "yearly_trend": df_year,
        "claim_components": component_df,
    }


# ==============================================================================
# 5. Catastrophe Stress Test Simulator
# ==============================================================================

def simulate_catastrophe_stress(
    ACT: pd.DataFrame,
    CL: pd.DataFrame,
    scenario_name: str,
    frequency_multiplier: float,
    severity_multiplier: float,
    target_zone: str = "All Zones"
) -> Dict[str, Any]:
    """Simulates the financial impact of severe weather / disaster shocks on portfolio capital and loss ratios.

    Args:
        ACT: Active policies dataframe
        CL: Claims dataframe
        scenario_name: Name of simulated event (e.g. "Cat 4 Hurricane", "100-Yr Flash Flood")
        frequency_multiplier: Multiplier on baseline claim count (e.g. 1.25 for +25%)
        severity_multiplier: Multiplier on average payout (e.g. 1.30 for +30%)
        target_zone: "All Zones", "SFHA (A & V Zones)", or "Non-SFHA"
    """
    total_written_premium = float(ACT.active_premium.sum())
    baseline_annual_claims = max(len(CL) / max(len(CL.year_of_loss.unique()), 1), 1)
    baseline_avg_severity = float(CL[CL.paid > 0].paid.mean()) if (CL.paid > 0).any() else 25000.0
    baseline_expected_annual_payout = baseline_annual_claims * baseline_avg_severity
    baseline_loss_ratio = (baseline_expected_annual_payout / max(total_written_premium, 1.0))

    # Zone vulnerability filtering
    if target_zone == "SFHA (A & V Zones)":
        zone_weight = float(ACT.flood_zone.fillna("").str[:1].isin(["A", "V"]).mean())
    elif target_zone == "Non-SFHA":
        zone_weight = float((~ACT.flood_zone.fillna("").str[:1].isin(["A", "V"])).mean())
    else:
        zone_weight = 1.0

    effective_freq_mult = 1.0 + (frequency_multiplier - 1.0) * zone_weight
    effective_sev_mult = 1.0 + (severity_multiplier - 1.0) * zone_weight

    stressed_claims_count = baseline_annual_claims * effective_freq_mult
    stressed_avg_severity = baseline_avg_severity * effective_sev_mult
    stressed_annual_payout = stressed_claims_count * stressed_avg_severity
    stressed_loss_ratio = (stressed_annual_payout / max(total_written_premium, 1.0))

    delta_loss_payout = stressed_annual_payout - baseline_expected_annual_payout
    delta_loss_ratio_pts = (stressed_loss_ratio - baseline_loss_ratio) * 100

    # Solvency / Underwriting capital buffer check
    capital_impact = "Manageable within Reserves" if stressed_loss_ratio < 0.70 else (
        "Reinsurance Triggered" if stressed_loss_ratio < 1.0 else "Capital Reserve Depletion Risk"
    )

    return {
        "scenario": scenario_name,
        "target_zone": target_zone,
        "baseline_payout": baseline_expected_annual_payout,
        "baseline_loss_ratio": baseline_loss_ratio,
        "stressed_payout": stressed_annual_payout,
        "stressed_loss_ratio": stressed_loss_ratio,
        "delta_payout": delta_loss_payout,
        "delta_loss_ratio_pts": delta_loss_ratio_pts,
        "capital_impact": capital_impact,
        "stressed_claims": int(stressed_claims_count),
        "stressed_severity": stressed_avg_severity,
    }


# ==============================================================================
# 6. Agent & Distribution Performance
# ==============================================================================

def compute_agent_performance(C: pd.DataFrame, P: pd.DataFrame, ACT: pd.DataFrame) -> pd.DataFrame:
    """Ranks and analyzes agent production volume, premium, loss ratios, and average property risk."""
    agent_group = C.groupby(["agent_id", "agent_name"], as_index=False).agg(
        customers=("customer_id", "count"),
        active_policies=("active_policies", "sum"),
        active_premium=("premium_active", "sum"),
        insured_value=("insured_value_active", "sum"),
        claims_total=("claims_total", "sum"),
        claims_paid=("claims_paid_total", "sum"),
        open_claims=("claims_open", "sum"),
        renewals_pending=("renewal_pending", lambda s: s.fillna(False).astype(bool).sum()),
        avg_risk_score=("highest_risk_score", "mean")
    )

    agent_group["loss_ratio"] = (agent_group["claims_paid"] / agent_group["active_premium"].replace(0, np.nan)).fillna(0)
    agent_group["premium_per_policy"] = (agent_group["active_premium"] / agent_group["active_policies"].replace(0, np.nan)).fillna(0)
    agent_group["rating"] = np.where(agent_group["loss_ratio"] < 0.50, "Top Performer",
                            np.where(agent_group["loss_ratio"] < 0.75, "Standard", "High Loss Ratio"))

    return agent_group.sort_values("active_premium", ascending=False)
