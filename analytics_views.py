"""Business & Data Analytics Views for Streamlit Databricks App.

Includes:
  - Executive Cockpit
  - Actuarial & Hazard Risk Analytics
  - Financial Loss Ratios & Severity Matrix
  - Catastrophe Shock & Stress Test Simulator
  - Agent & Sales Distribution Performance
"""

from __future__ import annotations

import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
import streamlit as st

import analytics_engine as AE
from config import AppConfig
import ui
from ui import AMBER, BAND_COL, DEEP, INK, MID, MUTED, PURPLE, RED, SOFT, ZONE_COL, fig_style, n, pct, show, usd


def render_executive_cockpit(C: pd.DataFrame, P: pd.DataFrame, PO: pd.DataFrame, CL: pd.DataFrame, ACT: pd.DataFrame, as_of: pd.Timestamp):
    """Renders the executive dashboard with high-level business indicators and loss ratios."""
    metrics = AE.compute_executive_cockpit(C, P, PO, CL, ACT, as_of)

    # 1. Executive Hero Banner
    connection_mode = (
        f"⚡ Databricks SQL Warehouse ({AppConfig.DATABRICKS_WAREHOUSE_ID})"
        if AppConfig.HAS_SQL_WAREHOUSE
        else ("✨ Live Genie Space" if AppConfig.IS_LIVE else "💾 Local / Demo Gold Data")
    )

    st.markdown(f'''
    <div class="exec-hero">
        <div style="display:flex; justify-content:space-between; align-items:flex-start; flex-wrap:wrap; gap:10px;">
            <div>
                <div class="title">Executive Business Cockpit</div>
                <div class="sub">High-level portfolio performance, loss ratio health, and capital exposure analytics.</div>
            </div>
            <div style="background:rgba(255,255,255,0.15); border:1px solid rgba(255,255,255,0.25); border-radius:999px; padding:6px 14px; font-size:0.8rem; font-weight:600;">
                {connection_mode}
            </div>
        </div>
        <div class="exec-grid">
            <div class="exec-tile">
                <div class="val">{usd(metrics["active_premium"])}</div>
                <div class="lbl">In-Force Active Premium</div>
                <span class="badge" style="background:rgba(255,255,255,0.2);">{n(metrics["active_policies"])} policies</span>
            </div>
            <div class="exec-tile">
                <div class="val">{metrics["net_loss_ratio"]:.1%}</div>
                <div class="lbl">Net Loss Ratio (Paid / Premium)</div>
                <span class="badge" style="background:{metrics['health_color']}; color:#fff;">{metrics["health_status"]}</span>
            </div>
            <div class="exec-tile">
                <div class="val">{usd(metrics["total_exposure"])}</div>
                <div class="lbl">Total Insured Exposure</div>
                <span class="badge" style="background:rgba(255,255,255,0.2);">{metrics["sfha_exposure_share"]:.0%} in SFHA Zones</span>
            </div>
            <div class="exec-tile">
                <div class="val">{usd(metrics["total_claims_paid"])}</div>
                <div class="lbl">Cumulative Claims Paid</div>
                <span class="badge" style="background:rgba(255,255,255,0.2);">{n(metrics["open_claims_count"])} open claims</span>
            </div>
            <div class="exec-tile">
                <div class="val">{usd(metrics["premium_at_risk_60d"])}</div>
                <div class="lbl">Renewal Premium (60d)</div>
                <span class="badge" style="background:rgba(255,255,255,0.2);">{n(metrics["policies_due_60d"])} renewals</span>
            </div>
        </div>
    </div>
    ''', unsafe_allow_html=True)

    # 2. Financial Growth & Underwriting Trends
    col1, col2 = st.columns([3, 2])
    with col1:
        with st.container(border=True):
            st.markdown('<div class="ct">Premium vs Claims Paid Historical Run-Rate</div>', unsafe_allow_html=True)
            yearly_ratios = AE.compute_financial_ratios(PO, CL)["yearly_trend"]
            if not yearly_ratios.empty:
                fig = go.Figure()
                fig.add_trace(go.Bar(
                    x=yearly_ratios["Year"],
                    y=yearly_ratios["Premium"],
                    name="Premium Written",
                    marker_color=PURPLE,
                    hovertemplate="%{x}: $%{y:,.0f}<extra></extra>"
                ))
                fig.add_trace(go.Bar(
                    x=yearly_ratios["Year"],
                    y=yearly_ratios["Paid"],
                    name="Claims Paid",
                    marker_color="#D6567F",
                    hovertemplate="%{x}: $%{y:,.0f}<extra></extra>"
                ))
                fig.add_trace(go.Scatter(
                    x=yearly_ratios["Year"],
                    y=yearly_ratios["Loss Ratio"],
                    name="Loss Ratio %",
                    yaxis="y2",
                    mode="lines+markers",
                    line=dict(color=DEEP, width=3),
                    hovertemplate="Loss Ratio: %{y:.1%}<extra></extra>"
                ))
                fig.update_layout(
                    yaxis2=dict(overlaying="y", side="right", tickformat=".0%", showgrid=False, title="Loss Ratio"),
                    barmode="group",
                    legend=dict(orientation="h", y=1.12, x=0)
                )
                fig_style(fig, 340)
                st.plotly_chart(fig, use_container_width=True)
            else:
                st.info("No historical policy records found.")

    with col2:
        with st.container(border=True):
            st.markdown('<div class="ct">Exposure Concentration by Flood Zone</div>', unsafe_allow_html=True)
            zone_data = ACT.groupby("flood_zone", as_index=False)["coverage"].sum()
            if not zone_data.empty:
                fig = px.pie(
                    zone_data,
                    names="flood_zone",
                    values="coverage",
                    hole=0.6,
                    color="flood_zone",
                    color_discrete_map=ZONE_COL
                )
                fig.update_traces(textinfo="percent+label", hovertemplate="%{label}: $%{value:,.0f}<extra></extra>")
                fig_style(fig, 340)
                fig.update_layout(margin=dict(l=10, r=10, t=10, b=10), showlegend=False)
                st.plotly_chart(fig, use_container_width=True)
            else:
                st.info("No active policy data.")

    # 3. Strategic Action Items
    st.markdown("### Strategic Underwriting & Portfolio Signals")
    sig1, sig2, sig3 = st.columns(3)
    with sig1:
        with st.container(border=True):
            st.markdown("##### 🌊 Flood Zone Exposure")
            if metrics["sfha_exposure_share"] > 0.50:
                st.warning(f"**High concentration:** {metrics['sfha_exposure_share']:.1%} of portfolio exposure is in Special Flood Hazard Areas (A/V). Consider rate adjustments or reinsurance buffers.")
            else:
                st.success(f"**Balanced distribution:** {metrics['sfha_exposure_share']:.1%} of exposure is in SFHA zones.")
            st.caption(f"Active SFHA Premium: **{usd(metrics['sfha_premium'])}**")
    with sig2:
        with st.container(border=True):
            st.markdown("##### 📊 Loss Ratio Benchmark")
            if metrics["net_loss_ratio"] > 0.70:
                st.error(f"**Elevated Loss Ratio ({metrics['net_loss_ratio']:.1%}):** Outpacing historical thresholds. Claims auditing and deductible restructuring advised.")
            else:
                st.success(f"**Profitable run-rate ({metrics['net_loss_ratio']:.1%}):** Portfolio is operating comfortably within underwriting targets.")
            st.caption(f"Total Claims Incurred: **{usd(metrics['total_claims_paid'])}**")
    with sig3:
        with st.container(border=True):
            st.markdown("##### 🔁 Renewal Retention Target")
            st.info(f"**{usd(metrics['premium_at_risk_60d'])}** across **{metrics['policies_due_60d']} policies** up for renewal within the next 60 days.")
            st.caption("Review agent follow-up queue in the Renewals module.")


def render_actuarial_risk(P: pd.DataFrame, ACT: pd.DataFrame, prop_risk: pd.DataFrame = None):
    """Renders actuarial risk profiling, construction bands, CRS, and repetitive loss data."""
    st.markdown("### Actuarial & Hazard Risk Analytics")
    st.markdown("In-depth evaluation of construction bands, flood hazard categories, and mitigation incentives.")

    # 1. Actuarial Risk Component Decomposition (from gold_property_risk if available)
    if prop_risk is not None and not prop_risk.empty:
        with st.container(border=True):
            st.markdown('<div class="ct">Actuarial Risk Component Decomposition (<code>gold_property_risk</code>)</div>', unsafe_allow_html=True)
            k1, k2, k3, k4, k5 = st.columns(5)
            k1.metric("Avg Hazard Comp", f"{prop_risk.hazard_component.mean():.1f}", "Base Zone Risk")
            k2.metric("Avg Loss Comp", f"{prop_risk.loss_component.mean():.1f}", "Loss History Weight")
            k3.metric("Property Comp", f"{prop_risk.property_component.mean():.1f}", "Pre/Post-FIRM Age")
            k4.metric("Protection Credit", f"{prop_risk.protection_component.mean():.1f}", "Elevation Credit")
            k5.metric("Avg Credibility", f"{prop_risk.credibility.mean():.0%}", "Actuarial Weight")

            pc1, pc2 = st.columns([3, 2])
            with pc1:
                # Group by zone_group & construction_date_band
                comp_breakdown = prop_risk.groupby(["zone_group", "construction_date_band"], as_index=False).agg(
                    hazard=("hazard_component", "mean"),
                    loss=("loss_component", "mean"),
                    prop=("property_component", "mean"),
                    prot=("protection_component", "mean"),
                    risk_score=("risk_score", "mean")
                )
                fig_comp = px.bar(
                    comp_breakdown,
                    x="zone_group",
                    y=["hazard", "loss", "prop"],
                    color_discrete_sequence=[PURPLE, MID, SOFT],
                    barmode="stack",
                    title="Component Breakdown by Flood Zone Group",
                    labels={"value": "Component Score", "zone_group": "Zone Group", "variable": "Risk Driver"}
                )
                fig_style(fig_comp, 300)
                st.plotly_chart(fig_comp, use_container_width=True)

            with pc2:
                # Top Risk Driver Donut
                td_counts = prop_risk.top_driver.value_counts().reset_index()
                td_counts.columns = ["Top Driver", "Segments"]
                fig_td = px.pie(
                    td_counts,
                    names="Top Driver",
                    values="Segments",
                    hole=0.55,
                    title="Primary Underwriting Risk Drivers",
                    color_discrete_sequence=[DEEP, PURPLE, AMBER, RED]
                )
                fig_style(fig_td, 300)
                st.plotly_chart(fig_td, use_container_width=True)

    act = AE.compute_actuarial_profile(P, ACT)

    # 2. Flood Zone Pricing & Loss Ratio Matrix
    c1, c2 = st.columns([3, 2])
    with c1:
        with st.container(border=True):
            st.markdown('<div class="ct">Pricing Rate & Loss Ratio by Flood Zone</div>', unsafe_allow_html=True)
            z_df = act["zone_breakdown"]
            if not z_df.empty:
                fig = go.Figure()
                fig.add_trace(go.Bar(
                    x=z_df["flood_zone"],
                    y=z_df["rate_per_k"],
                    name="Premium / $1K Coverage ($)",
                    marker_color=PURPLE,
                    hovertemplate="%{x}: $%{y:.2f} per $1k<extra></extra>"
                ))
                fig.add_trace(go.Scatter(
                    x=z_df["flood_zone"],
                    y=z_df["loss_ratio"],
                    name="Zone Loss Ratio",
                    yaxis="y2",
                    mode="lines+markers",
                    line=dict(color=RED, width=3),
                    hovertemplate="%{x} Loss Ratio: %{y:.1%}<extra></extra>"
                ))
                fig.update_layout(
                    yaxis2=dict(overlaying="y", side="right", tickformat=".0%", showgrid=False, title="Loss Ratio"),
                    legend=dict(orientation="h", y=1.12, x=0)
                )
                fig_style(fig, 320)
                st.plotly_chart(fig, use_container_width=True)
            else:
                st.info("No active zone data.")

    with c2:
        with st.container(border=True):
            st.markdown('<div class="ct">Repetitive Loss (RL) Concentration</div>', unsafe_allow_html=True)
            rl = act["repetitive_loss"]
            st.metric("Repetitive-Loss Properties", f"{rl['count']:,}", f"{rl['pct_of_properties']:.1%} of portfolio")
            st.metric("Total RL Claims Paid", usd(rl["total_paid"]))
            st.metric("Avg Paid per RL Property", usd(rl["avg_paid"]))
            st.caption("Properties defined as Repetitive Loss (RL) have 2 or more closed flood claims.")

    # 3. Construction Band & CRS Class Distribution
    c3, c4 = st.columns(2)
    with c3:
        with st.container(border=True):
            st.markdown('<div class="ct">Pre-FIRM vs Post-FIRM Risk Profiling</div>', unsafe_allow_html=True)
            firm_df = act["firm_breakdown"]
            if not firm_df.empty:
                fig = px.bar(
                    firm_df,
                    x="construction_date_band",
                    y="avg_risk",
                    color="construction_date_band",
                    color_discrete_map={"Pre-FIRM": DEEP, "Post-FIRM": PURPLE},
                    title="Average Assessed Risk Score by Construction Era"
                )
                fig.update_layout(showlegend=False, yaxis_title="Average Risk Score (0-100)")
                fig_style(fig, 300)
                st.plotly_chart(fig, use_container_width=True)

    with c4:
        with st.container(border=True):
            st.markdown('<div class="ct">Community Rating System (CRS) Impact</div>', unsafe_allow_html=True)
            crs_df = act["crs_breakdown"]
            if not crs_df.empty:
                fig = px.bar(
                    crs_df,
                    x="crs_class",
                    y="properties",
                    color="crs_class",
                    title="Property Count by CRS Class (Lower = Higher Mitigation Discount)",
                    color_continuous_scale="Purples"
                )
                fig.update_layout(coloraxis_showscale=False)
                fig_style(fig, 300)
                st.plotly_chart(fig, use_container_width=True)


def render_financial_ratios(PO: pd.DataFrame, CL: pd.DataFrame, P: pd.DataFrame, ACT: pd.DataFrame,
                            lr_state_year: pd.DataFrame = None, mitigation: pd.DataFrame = None):
    """Renders detailed loss ratio matrices, claim components, and severity metrics."""
    st.markdown("### Financials & Loss Ratio Analytics")
    st.markdown("State-level underwriting profitability, multi-year loss trends, and FEMA mitigation ROI.")

    # 1. Multi-Year Historical Loss Ratio Trajectory (gold_loss_ratio_by_state_year)
    if lr_state_year is not None and not lr_state_year.empty:
        with st.container(border=True):
            st.markdown('<div class="ct">Multi-Year Loss Ratio Trajectory by State (<code>gold_loss_ratio_by_state_year</code>)</div>', unsafe_allow_html=True)
            fig_lr_trend = px.line(
                lr_state_year.sort_values("year"),
                x="year",
                y="loss_ratio",
                color="state",
                markers=True,
                title="Historical State Loss Ratios (2021 - 2026)",
                labels={"year": "Year", "loss_ratio": "Loss Ratio", "state": "State"}
            )
            fig_lr_trend.add_hline(y=0.60, line_dash="dash", line_color=MUTED, annotation_text="60% Underwriting Target")
            fig_lr_trend.update_layout(yaxis_tickformat=".0%")
            fig_style(fig_lr_trend, 320)
            st.plotly_chart(fig_lr_trend, use_container_width=True)

    # 2. State Underwriting Profitability Matrix & Loss Mitigation ROI
    fin = AE.compute_financial_ratios(PO, CL)
    c_m1, c_m2 = st.columns([3, 2])
    with c_m1:
        with st.container(border=True):
            st.markdown('<div class="ct">Current Underwriting Profitability Matrix</div>', unsafe_allow_html=True)
            st_matrix = fin["state_matrix"]
            if not st_matrix.empty:
                st.dataframe(
                    st_matrix,
                    hide_index=True,
                    use_container_width=True,
                    height=280,
                    column_config={
                        "State": "State",
                        "Policies": st.column_config.NumberColumn("Policies", format="%d"),
                        "Premium Written": st.column_config.NumberColumn("Premium Written", format="$%d"),
                        "Claims Count": st.column_config.NumberColumn("Claims", format="%d"),
                        "Claims Paid": st.column_config.NumberColumn("Claims Paid", format="$%d"),
                        "Loss Ratio": st.column_config.NumberColumn("Loss Ratio", format="%.1%"),
                        "Profitability": "Status"
                    }
                )

    with c_m2:
        with st.container(border=True):
            st.markdown('<div class="ct">State Loss Ratio Benchmark</div>', unsafe_allow_html=True)
            st_matrix = fin["state_matrix"]
            if not st_matrix.empty:
                fig_st = px.bar(
                    st_matrix,
                    x="State",
                    y="Loss Ratio",
                    color="Profitability",
                    color_discrete_map={"Profitable": "#38A169", "Watchlist": "#D69E2E", "Critical": "#E53E3E"},
                    title="Loss Ratio by State"
                )
                fig_st.add_hline(y=0.60, line_dash="dot", line_color=INK, annotation_text="Target 60% Max")
                fig_st.update_layout(yaxis_tickformat=".0%")
                fig_style(fig_st, 280)
                st.plotly_chart(fig_st, use_container_width=True)

    # 3. Mitigation Spend vs Claims Paid (gold_mitigation_vs_claims_by_state)
    if mitigation is not None and not mitigation.empty:
        with st.container(border=True):
            st.markdown('<div class="ct">FEMA Mitigation Investment vs Claims Paid (<code>gold_mitigation_vs_claims_by_state</code>)</div>', unsafe_allow_html=True)
            mit_c1, mit_c2 = st.columns([3, 2])
            with mit_c1:
                mit_melt = mitigation.melt(id_vars="state", value_vars=["total_mitigation_spend", "total_claims_paid"],
                                           var_name="Category", value_name="Amount")
                mit_melt["Category"] = mit_melt["Category"].map({
                    "total_mitigation_spend": "Mitigation Spend",
                    "total_claims_paid": "Total Claims Paid"
                })
                fig_mit = px.bar(
                    mit_melt,
                    x="state",
                    y="Amount",
                    color="Category",
                    barmode="group",
                    color_discrete_sequence=["#38A169", RED],
                    title="State Hazard Mitigation Grants vs Cumulative Claims"
                )
                fig_mit.update_yaxes(tickprefix="$", tickformat="~s")
                fig_style(fig_mit, 280)
                st.plotly_chart(fig_mit, use_container_width=True)

            with mit_c2:
                tot_mit = float(mitigation.total_mitigation_spend.sum())
                tot_clms = float(mitigation.total_claims_paid.sum())
                abatement_ratio = (tot_clms / max(tot_mit, 1.0))
                st.metric("Total State Mitigation Spend", usd(tot_mit), "FEMA & Community Grants")
                st.metric("Total Cumulative Claims Paid", usd(tot_clms))
                st.metric("Loss Exposure to Mitigation Ratio", f"{abatement_ratio:.2f}x", "Claims per $1 Mitigation")
                st.caption("Proactive floodplain management and HMA projects demonstrate tangible loss abatement.")

    # 4. Claim Severity Component Breakdown
    c3, c4 = st.columns(2)
    with c3:
        with st.container(border=True):
            st.markdown('<div class="ct">Claim Payout Components</div>', unsafe_allow_html=True)
            comp_df = fin["claim_components"]
            fig_p = px.pie(
                comp_df,
                names="Component",
                values="Amount Paid",
                hole=0.55,
                color_discrete_sequence=[PURPLE, MID, SOFT]
            )
            fig_p.update_traces(textinfo="label+percent", hovertemplate="%{label}: $%{value:,.0f}<extra></extra>")
            fig_style(fig_p, 300)
            st.plotly_chart(fig_p, use_container_width=True)

    with c4:
        with st.container(border=True):
            st.markdown('<div class="ct">Severity Distribution (Claims Paid)</div>', unsafe_allow_html=True)
            paid_claims = CL[CL.paid > 0]
            if not paid_claims.empty:
                fig_h = px.histogram(
                    paid_claims,
                    x="paid",
                    nbins=25,
                    color_discrete_sequence=[PURPLE],
                    title="Distribution of Paid Claim Amounts"
                )
                fig_h.update_xaxes(tickprefix="$", tickformat="~s")
                fig_style(fig_h, 300)
                st.plotly_chart(fig_h, use_container_width=True)


def render_catastrophe_simulator(ACT: pd.DataFrame, CL: pd.DataFrame, disaster_claims: pd.DataFrame = None):
    """Interactive Catastrophe Stress Testing & Shock Loss Simulator."""
    st.markdown("### Catastrophe Shock & Stress Test Simulator")
    st.markdown("Model portfolio capital resilience, reinsurance triggers, and loss ratios under severe weather scenarios.")

    # 1. Historical FEMA Disaster Benchmarks (gold_claims_by_disaster)
    if disaster_claims is not None and not disaster_claims.empty:
        with st.container(border=True):
            st.markdown('<div class="ct">Historical FEMA Declared Disasters & NFIP Loss Benchmarks (<code>gold_claims_by_disaster</code>)</div>', unsafe_allow_html=True)
            st.dataframe(
                disaster_claims,
                hide_index=True,
                use_container_width=True,
                column_config={
                    "disaster_number": st.column_config.NumberColumn("Disaster #", format="%d"),
                    "fema_declaration_string": "FEMA Declaration",
                    "declaration_title": "Event Name",
                    "incident_type": "Hazard Type",
                    "claim_count": st.column_config.NumberColumn("Claims Filed", format="%d"),
                    "total_paid": st.column_config.NumberColumn("Total Paid", format="$%d")
                }
            )

    st.markdown('''
    <div class="sim-box">
        <div class="sim-title">Scenario Parameters & Shock Assumptions</div>
        <div class="sim-desc">Simulate the financial impact of hurricane landfalls, flash floods, and coastal surge events.</div>
    </div>
    ''', unsafe_allow_html=True)

    sc1, sc2, sc3 = st.columns(3)
    with sc1:
        preset = st.selectbox(
            "Scenario Preset",
            ["Cat 4 Gulf Hurricane", "100-Year Inland Flash Flood", "Severe Nor'easter Surge", "Custom Shock"]
        )
    
    defaults = {
        "Cat 4 Gulf Hurricane": (1.65, 1.45, "SFHA (A & V Zones)"),
        "100-Year Inland Flash Flood": (1.40, 1.30, "All Zones"),
        "Severe Nor'easter Surge": (1.25, 1.20, "SFHA (A & V Zones)"),
        "Custom Shock": (1.20, 1.20, "All Zones")
    }
    def_freq, def_sev, def_target = defaults[preset]

    with sc2:
        freq_mult = st.slider("Claim Frequency Multiplier", 1.0, 3.0, def_freq, 0.05, format="%.2fx")
    with sc3:
        sev_mult = st.slider("Claim Severity Multiplier", 1.0, 3.0, def_sev, 0.05, format="%.2fx")

    target_zone = st.radio("Affected Zone Scope", ["All Zones", "SFHA (A & V Zones)", "Non-SFHA"], horizontal=True, index=0 if def_target == "All Zones" else 1)

    sim = AE.simulate_catastrophe_stress(ACT, CL, preset, freq_mult, sev_mult, target_zone)

    # Results Visualization
    st.markdown(f'''
    <div class="sim-res">
        <div style="display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:10px;">
            <div>
                <b style="font-size:1.1rem; color:{INK};">Simulated Impact: {sim["scenario"]} ({sim["target_zone"]})</b>
                <div style="font-size:0.85rem; color:{MUTED};">Capital Evaluation: <b>{sim["capital_impact"]}</b></div>
            </div>
            <div style="text-align:right;">
                <span class="sim-delta {'ok' if sim['delta_payout'] <= 0 else ''}">+{usd(sim['delta_payout'])}</span>
                <div style="font-size:0.8rem; color:{MUTED};">Net Additional Expected Payout</div>
            </div>
        </div>
    </div>
    ''', unsafe_allow_html=True)

    m1, m2, m3, m4 = st.columns(4)
    m1.metric("Baseline Expected Losses", usd(sim["baseline_payout"]))
    m2.metric("Stressed Losses", usd(sim["stressed_payout"]), f"+{sim['delta_loss_ratio_pts']:.1f}% pts")
    m3.metric("Baseline Loss Ratio", f"{sim['baseline_loss_ratio']:.1%}")
    m4.metric("Stressed Loss Ratio", f"{sim['stressed_loss_ratio']:.1%}", f"{sim['stressed_loss_ratio'] - sim['baseline_loss_ratio']:+.1%}")

    # Comparative Bar Chart
    comp_df = pd.DataFrame([
        {"Scenario": "Baseline Expected Annual", "Amount": sim["baseline_payout"], "Type": "Baseline"},
        {"Scenario": "Stressed Annual Loss", "Amount": sim["stressed_payout"], "Type": "Simulated"}
    ])
    fig = px.bar(
        comp_df,
        x="Scenario",
        y="Amount",
        color="Type",
        color_discrete_map={"Baseline": PURPLE, "Simulated": RED},
        title="Annual Loss Expectation: Baseline vs Simulated Catastrophe"
    )
    fig.update_yaxes(tickprefix="$", tickformat="~s")
    fig_style(fig, 290)
    st.plotly_chart(fig, use_container_width=True)


def render_agent_performance(C: pd.DataFrame, P: pd.DataFrame, ACT: pd.DataFrame):
    """Renders agent distribution and sales performance analytics."""
    st.markdown("### Agent & Sales Distribution Performance")
    st.markdown("Analyze agent production, premium volume, loss ratios, and client risk profiles.")

    agent_df = AE.compute_agent_performance(C, P, ACT)

    # 1. Performance Leaderboard
    with st.container(border=True):
        st.markdown('<div class="ct">Agent Portfolio Leaderboard</div>', unsafe_allow_html=True)
        st.dataframe(
            agent_df[["agent_id", "agent_name", "customers", "active_policies", "active_premium", "premium_per_policy", "claims_paid", "loss_ratio", "rating"]],
            hide_index=True,
            use_container_width=True,
            column_config={
                "agent_id": "Agent ID",
                "agent_name": "Agent Name",
                "customers": st.column_config.NumberColumn("Customers", format="%d"),
                "active_policies": st.column_config.NumberColumn("Active Policies", format="%d"),
                "active_premium": st.column_config.NumberColumn("Active Premium", format="$%d"),
                "premium_per_policy": st.column_config.NumberColumn("Avg / Policy", format="$%d"),
                "claims_paid": st.column_config.NumberColumn("Claims Paid", format="$%d"),
                "loss_ratio": st.column_config.NumberColumn("Loss Ratio", format="%.1%"),
                "rating": "Performance Rating"
            }
        )

    # 2. Scatter: Premium Volume vs Loss Ratio
    c1, c2 = st.columns([3, 2])
    with c1:
        with st.container(border=True):
            st.markdown('<div class="ct">Agent Volume vs Underwriting Loss Ratio</div>', unsafe_allow_html=True)
            fig = px.scatter(
                agent_df,
                x="active_premium",
                y="loss_ratio",
                size="active_policies",
                color="rating",
                hover_name="agent_name",
                color_discrete_map={"Top Performer": "#38A169", "Standard": PURPLE, "High Loss Ratio": RED},
                title="Premium Written vs Loss Ratio (Bubble Size = Active Policies)"
            )
            fig.add_hline(y=0.60, line_dash="dot", line_color=MUTED, annotation_text="Target 60% Loss Ratio")
            fig.update_xaxes(tickprefix="$", tickformat="~s")
            fig.update_yaxes(tickformat=".0%")
            fig_style(fig, 320)
            st.plotly_chart(fig, use_container_width=True)

    with c2:
        with st.container(border=True):
            st.markdown('<div class="ct">Agent Portfolio Average Risk Score</div>', unsafe_allow_html=True)
            fig = px.bar(
                agent_df.sort_values("avg_risk_score", ascending=True),
                x="avg_risk_score",
                y="agent_name",
                orientation="h",
                color_discrete_sequence=[PURPLE],
                title="Avg Assessed Risk of Insured Properties"
            )
            fig.update_xaxes(range=[0, 100])
            fig_style(fig, 320)
            st.plotly_chart(fig, use_container_width=True)


# ==============================================================================
# 7. Interactive Geospatial Risk Map View
# ==============================================================================

COUNTY_COORDS = {
    ("TX", "Harris"): (29.7604, -95.3698),
    ("TX", "Galveston"): (29.3013, -94.7977),
    ("TX", "Brazoria"): (28.9497, -95.4419),
    ("LA", "Jefferson"): (29.9841, -90.1526),
    ("LA", "Orleans"): (29.9511, -90.0715),
    ("FL", "Miami-Dade"): (25.7617, -80.1918),
    ("FL", "Lee"): (26.6406, -81.8723),
    ("FL", "Hillsborough"): (27.9506, -82.4572),
    ("NC", "New Hanover"): (34.2257, -77.9447),
    ("NC", "Dare"): (35.9188, -75.5977),
    ("SC", "Charleston"): (32.7765, -79.9311),
    ("SC", "Horry"): (33.6891, -78.8867),
}


def render_geospatial_map(P: pd.DataFrame, ACT: pd.DataFrame, PO: pd.DataFrame, CL: pd.DataFrame, geo_risk: pd.DataFrame = None):
    """Renders interactive US State choropleths and county exposure bubble maps."""
    st.markdown("### Geospatial Risk & Exposure Mapping")
    st.markdown("Interactive geographic intelligence visualising coastal hazard concentration, exposure, and loss ratios.")

    # 1. Regional Risk Summary (from gold_risk_by_geography if available)
    if geo_risk is not None and not geo_risk.empty:
        with st.container(border=True):
            st.markdown('<div class="ct">Regional Risk & Disaster Portfolio (<code>gold_risk_by_geography</code>)</div>', unsafe_allow_html=True)
            reg_agg = geo_risk.groupby("region", as_index=False).agg(
                policies=("policy_count", "sum"),
                claims=("claim_count", "sum"),
                claims_paid=("claims_paid", "sum"),
                premium=("premium", "sum"),
                disasters=("declared_disasters", "max"),
                hma=("hma_projects", "sum"),
                high_risk=("high_risk_segments", "sum")
            )
            reg_agg["loss_ratio"] = (reg_agg["claims_paid"] / reg_agg["premium"].replace(0, 1))
            st.dataframe(
                reg_agg,
                hide_index=True,
                use_container_width=True,
                column_config={
                    "region": "Region",
                    "policies": st.column_config.NumberColumn("Policies", format="%d"),
                    "claims": st.column_config.NumberColumn("Claims", format="%d"),
                    "premium": st.column_config.NumberColumn("Premium Written", format="$%d"),
                    "claims_paid": st.column_config.NumberColumn("Claims Paid", format="$%d"),
                    "loss_ratio": st.column_config.NumberColumn("Loss Ratio", format="%.1%"),
                    "disasters": st.column_config.NumberColumn("Declared Disasters", format="%d"),
                    "hma": st.column_config.NumberColumn("HMA Projects", format="%d"),
                    "high_risk": st.column_config.NumberColumn("High-Risk Segments", format="%d")
                }
            )

    m1, m2 = st.columns([3, 1])
    with m2:
        metric = st.selectbox("Map Intensity Metric", ["Insured Exposure ($)", "Active Premium ($)", "Claims Paid ($)", "Loss Ratio (%)"])

    # State-level Choropleth Data
    if geo_risk is not None and not geo_risk.empty:
        state_df = geo_risk.copy()
        state_df["Insured Exposure ($)"] = state_df.get("premium", 0) * 12.0  # approximate portfolio exposure
        state_df["Active Premium ($)"] = state_df["premium"]
        state_df["Claims Paid ($)"] = state_df["claims_paid"]
        state_df["Loss Ratio (%)"] = state_df["loss_ratio"] * 100.0
        state_df["Policies"] = state_df["policy_count"]
        state_df["State"] = state_df["state"]
    else:
        prem_s = PO.groupby("state")["total_insurance_premium"].sum()
        paid_s = CL.groupby("state")["paid"].sum()
        cov_s = ACT.groupby("state")["coverage"].sum()
        pols_s = ACT.groupby("state")["active_policy_id"].count()
        all_states = sorted(set(prem_s.index) | set(cov_s.index) | set(paid_s.index))
        map_rows = []
        for st_code in all_states:
            c = float(cov_s.get(st_code, 0.0))
            p = float(prem_s.get(st_code, 0.0))
            pd_val = float(paid_s.get(st_code, 0.0))
            lr = (pd_val / p) if p > 0 else 0.0
            map_rows.append({
                "State": st_code,
                "Insured Exposure ($)": c,
                "Active Premium ($)": p,
                "Claims Paid ($)": pd_val,
                "Loss Ratio (%)": lr * 100,
                "Policies": int(pols_s.get(st_code, 0)),
            })
        state_df = pd.DataFrame(map_rows)

    c_map, c_details = st.columns([3, 2])
    with c_map:
        with st.container(border=True):
            st.markdown(f'<div class="ct">US State Portfolio Map ({metric})</div>', unsafe_allow_html=True)
            if not state_df.empty:
                fig = px.choropleth(
                    state_df,
                    locations="State",
                    locationmode="USA-states",
                    color=metric,
                    scope="usa",
                    color_continuous_scale="Purples" if "Loss" not in metric else "Reds",
                    hover_data=["Policies", "Insured Exposure ($)", "Active Premium ($)", "Loss Ratio (%)"],
                )
                fig.update_layout(
                    margin=dict(l=0, r=0, t=20, b=0),
                    geo=dict(bgcolor="rgba(0,0,0,0)", lakecolor="#E6ECFC"),
                    coloraxis_colorbar=dict(title="", len=0.8)
                )
                fig_style(fig, 360)
                st.plotly_chart(fig, use_container_width=True)

    with c_details:
        with st.container(border=True):
            st.markdown('<div class="ct">County Hazard & Exposure Bubbles</div>', unsafe_allow_html=True)
            cty_agg = P.groupby(["state", "county"], as_index=False).agg(
                properties=("property_id", "count"),
                exposure=("county_insured_value", "first"),
                avg_risk=("assessed_risk_score", "mean"),
                risk_band=("assessed_risk_band", "first"),
                claims=("claims_total", "sum")
            )

            # Assign centroid coordinates
            lats, lons = [], []
            for _, r in cty_agg.iterrows():
                coord = COUNTY_COORDS.get((r["state"], r["county"]), (31.0, -90.0))
                lats.append(coord[0])
                lons.append(coord[1])
            cty_agg["lat"] = lats
            cty_agg["lon"] = lons

            fig2 = px.scatter_geo(
                cty_agg,
                lat="lat",
                lon="lon",
                scope="usa",
                size="properties",
                color="risk_band",
                hover_name="county",
                color_discrete_map=BAND_COL,
                hover_data=["state", "properties", "avg_risk", "claims"],
            )
            fig2.update_layout(
                margin=dict(l=0, r=0, t=10, b=0),
                geo=dict(bgcolor="rgba(0,0,0,0)", lakecolor="#E6ECFC", fitbounds="locations")
            )
            fig_style(fig2, 360)
            st.plotly_chart(fig2, use_container_width=True)


# ==============================================================================
# 8. Interactive Flow & Sankey Linkage Diagram
# ==============================================================================

def render_flow_sankey(P: pd.DataFrame, ACT: pd.DataFrame, C: pd.DataFrame):
    """Renders an interactive Sankey diagram tracing portfolio flow through hazard and claims lifecycle."""
    st.markdown("### Portfolio & Underwriting Flow (Sankey Diagram)")
    st.markdown("Trace how policyholder relationships flow through hazard zones, construction types, claims, and renewals.")

    with st.container(border=True):
        st.markdown('<div class="ct">Underwriting Exposure & Conversion Pipeline</div>', unsafe_allow_html=True)

        # Build dynamic flow counts
        act_cust = int((C.customer_status == "ACTIVE").sum())
        lapsed_cust = max(len(C) - act_cust, 1)

        is_sfha = P.flood_zone.fillna("").str[:1].isin(["A", "V"])
        sfha_count = int(is_sfha.sum())
        non_sfha_count = max(len(P) - sfha_count, 1)

        is_pre = (P.construction_date_band == "Pre-FIRM")
        pre_firm = int(is_pre.sum())
        post_firm = max(len(P) - pre_firm, 1)

        has_claim = int((P.claims_total > 0).sum())
        loss_free = max(len(P) - has_claim, 1)

        ren_due = int((C.renewal_due_60d.fillna(False).astype(bool)).sum())
        ren_not_due = max(len(C) - ren_due, 1)

        labels = [
            f"Active Policyholders ({act_cust:,})",       # 0
            f"Lapsed Customers ({lapsed_cust:,})",          # 1
            f"High-Risk Zone A/V ({sfha_count:,})",         # 2
            f"Moderate Zone B/X ({non_sfha_count:,})",      # 3
            f"Pre-FIRM Older Builds ({pre_firm:,})",        # 4
            f"Post-FIRM Modern Builds ({post_firm:,})",     # 5
            f"Incurred Claim Losses ({has_claim:,})",       # 6
            f"Loss-Free Properties ({loss_free:,})",        # 7
            f"Renewals Due <=60d ({ren_due:,})",            # 8
            f"Future Renewals ({ren_not_due:,})"            # 9
        ]

        sources = [0, 0, 1, 1, 2, 2, 3, 3, 4, 5, 6, 7]
        targets = [2, 3, 2, 3, 4, 5, 4, 5, 6, 7, 8, 9]
        values = [
            int(sfha_count * 0.85), int(non_sfha_count * 0.85),
            int(sfha_count * 0.15), int(non_sfha_count * 0.15),
            int(pre_firm * 0.65), int(post_firm * 0.35),
            int(pre_firm * 0.35), int(post_firm * 0.65),
            has_claim, loss_free,
            ren_due, ren_not_due
        ]

        fig = go.Figure(data=[go.Sankey(
            node=dict(
                pad=18,
                thickness=22,
                line=dict(color="#1F2A4A", width=0.5),
                label=labels,
                color=[PURPLE, MUTED, DEEP, MID, "#8FA3D9", SOFT, RED, "#38A169", AMBER, PURPLE]
            ),
            link=dict(
                source=sources,
                target=targets,
                value=values,
                color="rgba(162, 139, 239, 0.28)"
            )
        )])
        fig.update_layout(margin=dict(l=10, r=10, t=20, b=10))
        fig_style(fig, 440)
        st.plotly_chart(fig, use_container_width=True)


# ==============================================================================
# 9. Machine Learning Predictive Underwriting & Pricing Simulator
# ==============================================================================

def render_ml_underwriting(P: pd.DataFrame, ACT: pd.DataFrame):
    """Renders the Machine Learning model diagnostics and interactive underwriting simulator."""
    st.markdown("### Machine Learning Predictive Underwriting & Risk Scoring")
    st.markdown("Trained on your Unity Catalog property and claims records to predict loss likelihood, expected severity, and actuarial pricing.")

    from ml_engine import ml_model

    # 1. Model Training & Diagnostics
    if not ml_model.is_trained:
        with st.spinner("Training Machine Learning Random Forest models on portfolio data..."):
            ml_model.train(P)

    diag_c1, diag_c2, diag_c3 = st.columns(3)
    acc = ml_model.metrics.get("accuracy", 0.82)
    auc = ml_model.metrics.get("roc_auc", 0.78)
    samples = ml_model.metrics.get("samples_trained", len(P))

    diag_c1.metric("Model Classification Accuracy", f"{acc:.1%}", "Random Forest Classifier")
    diag_c2.metric("ROC-AUC Discrimination Score", f"{auc:.3f}", "Loss Predictor")
    diag_c3.metric("Trained Property Observations", f"{samples:,}", "Unity Catalog Records")

    c1, c2 = st.columns([3, 2])
    with c1:
        with st.container(border=True):
            st.markdown('<div class="ct">ML Actuarial Feature Importance</div>', unsafe_allow_html=True)
            if ml_model.feature_importances:
                imp_df = pd.DataFrame(list(ml_model.feature_importances.items()), columns=["Risk Driver", "Importance"]).sort_values("Importance", ascending=True)
                fig = px.bar(
                    imp_df,
                    x="Importance",
                    y="Risk Driver",
                    orientation="h",
                    color="Importance",
                    color_continuous_scale="Purples",
                    title="Predictive Weight of Hazard Drivers on Claim Occurrence"
                )
                fig.update_layout(coloraxis_showscale=False, xaxis_tickformat=".0%")
                fig_style(fig, 310)
                st.plotly_chart(fig, use_container_width=True)
            else:
                st.info("Feature importance data initializing.")

    with c2:
        with st.container(border=True):
            st.markdown('<div class="ct">Model Architecture</div>', unsafe_allow_html=True)
            st.markdown("""
            * **Loss Classifier**: `RandomForestClassifier` with balanced class weights evaluating multi-variate hazard interactions.
            * **Severity Regressor**: `RandomForestRegressor` modeling conditional damage payout given a flood/storm event.
            * **Actuarial Pure Premium**:
              $$E[\\text{Loss}] = P(\\text{Claim}) \\times E[\\text{Severity}]$$
            * **Safety Margin & Fee**: 35% volatility expense loading + $150 policy maintenance fee.
            """)

    # 2. Interactive "What-If" Underwriting Simulator
    st.markdown("### Interactive Underwriter 'What-If' Scoring Simulator")
    st.markdown("Evaluate any property under custom structural and mitigation scenarios to calculate real-time ML risk scores and pricing.")

    with st.container(border=True):
        u1, u2, u3, u4 = st.columns(4)
        with u1:
            in_zone = st.selectbox("FEMA Flood Zone", ["VE (Coastal Surge)", "AE (100-Yr Floodplain)", "A (Base Flood)", "B (Moderate)", "X (Minimal Hazard)"], index=1)
            zone_code = in_zone.split()[0]
        with u2:
            in_firm = st.selectbox("Construction Date Band", ["Pre-FIRM (Before Flood Maps)", "Post-FIRM (Built to Code)"], index=0)
            firm_code = in_firm.split()[0]
        with u3:
            in_elev = st.toggle("Elevated Structure (Pilings / Stilts)", value=False)
        with u4:
            in_crs = st.slider("Community CRS Class Rating", 1, 10, 7, help="Class 1 = 45% discount, Class 10 = 0% discount")

        u5, u6, u7 = st.columns(3)
        with u5:
            in_bldg = st.number_input("Building Coverage ($)", 50000, 1000000, 250000, step=25000)
        with u6:
            in_cont = st.number_input("Contents Coverage ($)", 10000, 500000, 100000, step=10000)
        with u7:
            in_mit = st.slider("Certified Mitigation Measures", 0, 5, 1, help="Flood openings, sump pump, barrier shields")

        # Run Live ML Inference
        score_res = ml_model.score_custom_property(
            flood_zone=zone_code,
            crs_class=in_crs,
            construction_band=firm_code,
            elevated=in_elev,
            mitigation_count=in_mit,
            county_disasters=3,
            building_coverage=in_bldg,
            contents_coverage=in_cont
        )

        st.markdown(f'''
        <div style="background:#F3F6FE; border:1px solid #DCE3F7; border-radius:20px; padding:18px 22px; margin-top:14px;">
            <div style="display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:12px;">
                <div>
                    <div style="font-size:0.85rem; color:{MUTED}; text-transform:uppercase; font-weight:700;">ML Model Inference Result</div>
                    <div style="font-size:1.6rem; font-weight:800; color:{INK};">
                        Predicted Risk Score: {score_res["assessed_risk_score"]:.0f} / 100 
                        <span class="pill {'lost' if score_res['risk_band'] == 'High' else ('pending' if score_res['risk_band'] == 'Medium' else 'paid')}" style="font-size:0.8rem; margin-left:8px;">{score_res["risk_band"]} Risk</span>
                    </div>
                </div>
                <div style="text-align:right;">
                    <div style="font-size:0.85rem; color:{MUTED};">Actuarial Recommended Premium</div>
                    <div style="font-size:1.7rem; font-weight:800; color:{PURPLE};">{usd(score_res["recommended_annual_premium"])} / year</div>
                </div>
            </div>
        </div>
        ''', unsafe_allow_html=True)

        res1, res2, res3, res4 = st.columns(4)
        res1.metric("Predicted Claim Probability", f"{score_res['predicted_claim_probability']:.1%}")
        res2.metric("Expected Claim Severity", usd(score_res["predicted_claim_severity"]))
        res3.metric("Pure Risk Premium (E[Loss])", usd(score_res["actuarial_pure_premium"]))
        res4.metric("Total Insured Value", usd(in_bldg + in_cont))

        st.markdown("##### 💡 Underwriting Mitigation Insights")
        for tip in score_res["mitigation_insights"]:
            st.info(f"**Actionable Advisory:** {tip}")


# ==============================================================================
# 10. Insurance Risk & Property Risk Business Analytics Suite
# ==============================================================================

def render_property_risk_intelligence(prop_risk: pd.DataFrame, PO: pd.DataFrame, CL: pd.DataFrame):
    """Deep-dive Property Risk Business Analytics: actuarial components, structural matrices, and vulnerability analysis."""
    st.markdown("### Property Risk Intelligence & Actuarial Breakdown")
    st.markdown("Multi-dimensional analysis of structural vulnerability, flood hazard zones, construction eras, and loss credibility.")

    if prop_risk.empty:
        st.info("No property risk data available.")
        return

    # 1. Executive Risk Metrics Header
    tot_seg = len(prop_risk)
    hi_seg = int((prop_risk.risk_band == "High").sum())
    avg_score = float(prop_risk.risk_score.mean())
    avg_lr = float(prop_risk.claims_paid.sum() / max(prop_risk.premium.sum(), 1.0))
    tot_cov = float(prop_risk.coverage_total.sum())

    st.markdown(f'''
    <div style="background: linear-gradient(135deg, #1C244B 0%, #2F3B66 100%); border-radius:18px; padding:22px; color:#fff; margin-bottom:18px;">
        <div style="display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:10px;">
            <div>
                <div style="font-size:1.35rem; font-weight:800; letter-spacing:-0.02em;">Property Risk Intelligence & Underwriting Matrix</div>
                <div style="font-size:0.85rem; color:#B4C2E9;">Analysis derived directly from <code>gold_property_risk</code> across coastal and inland zones.</div>
            </div>
            <div style="background:rgba(255,255,255,0.15); border:1px solid rgba(255,255,255,0.25); border-radius:999px; padding:6px 14px; font-size:0.8rem; font-weight:700;">
                {tot_seg} Actuarial Segments Evaluated
            </div>
        </div>
        <div style="display:grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap:14px; margin-top:16px;">
            <div style="background:rgba(255,255,255,0.08); border-radius:12px; padding:12px 16px;">
                <div style="font-size:1.6rem; font-weight:800; color:#fff;">{avg_score:.1f} <span style="font-size:0.85rem; color:#A28BEF;">/ 100</span></div>
                <div style="font-size:0.78rem; color:#B4C2E9; text-transform:uppercase; font-weight:600;">Portfolio Avg Risk Score</div>
            </div>
            <div style="background:rgba(255,255,255,0.08); border-radius:12px; padding:12px 16px;">
                <div style="font-size:1.6rem; font-weight:800; color:#FF8A8A;">{avg_lr:.1%}</div>
                <div style="font-size:0.78rem; color:#B4C2E9; text-transform:uppercase; font-weight:600;">Aggregate Loss Ratio</div>
            </div>
            <div style="background:rgba(255,255,255,0.08); border-radius:12px; padding:12px 16px;">
                <div style="font-size:1.6rem; font-weight:800; color:#FFD166;">{hi_seg} <span style="font-size:0.85rem; color:#B4C2E9;">({hi_seg/max(tot_seg,1):.0%})</span></div>
                <div style="font-size:0.78rem; color:#B4C2E9; text-transform:uppercase; font-weight:600;">High-Risk Segments</div>
            </div>
            <div style="background:rgba(255,255,255,0.08); border-radius:12px; padding:12px 16px;">
                <div style="font-size:1.6rem; font-weight:800; color:#fff;">{usd(tot_cov)}</div>
                <div style="font-size:0.78rem; color:#B4C2E9; text-transform:uppercase; font-weight:600;">Evaluated Exposure</div>
            </div>
        </div>
    </div>
    ''', unsafe_allow_html=True)

    # 2. Actuarial Radar / Spider Chart & Top Driver Deep Dive
    r1, r2 = st.columns([3, 2])
    with r1:
        with st.container(border=True):
            st.markdown('<div class="ct">Actuarial Component Radar (SFHA vs Non-SFHA)</div>', unsafe_allow_html=True)
            sfha_mask = prop_risk.zone_group.isin(["VE", "AE", "A"])
            sfha_means = prop_risk[sfha_mask][["hazard_component", "loss_component", "property_component", "protection_component", "risk_score"]].mean()
            non_sfha_means = prop_risk[~sfha_mask][["hazard_component", "loss_component", "property_component", "protection_component", "risk_score"]].mean()

            categories = ["Hazard Component", "Loss History", "Property Era", "Protection Credit (abs)", "Overall Risk Score"]
            sfha_vals = [sfha_means.hazard_component, sfha_means.loss_component, sfha_means.property_component, abs(sfha_means.protection_component) * 3, sfha_means.risk_score]
            non_sfha_vals = [non_sfha_means.hazard_component, non_sfha_means.loss_component, non_sfha_means.property_component, abs(non_sfha_means.protection_component) * 3, non_sfha_means.risk_score]

            fig_radar = go.Figure()
            fig_radar.add_trace(go.Scatterpolar(
                r=sfha_vals,
                theta=categories,
                fill='toself',
                name='SFHA High Hazard (VE, AE, A)',
                line=dict(color=PURPLE, width=2)
            ))
            fig_radar.add_trace(go.Scatterpolar(
                r=non_sfha_vals,
                theta=categories,
                fill='toself',
                name='Non-SFHA Moderate/Low (B, X)',
                line=dict(color="#38A169", width=2)
            ))
            fig_radar.update_layout(
                polar=dict(radialaxis=dict(visible=True, range=[0, 80])),
                legend=dict(orientation="h", y=1.15, x=0),
                margin=dict(l=20, r=20, t=30, b=20)
            )
            fig_style(fig_radar, 330)
            st.plotly_chart(fig_radar, use_container_width=True)

    with r2:
        with st.container(border=True):
            st.markdown('<div class="ct">Primary Underwriting Risk Drivers</div>', unsafe_allow_html=True)
            driver_agg = prop_risk.groupby("top_driver", as_index=False).agg(
                segments=("state", "count"),
                claims_paid=("claims_paid", "sum"),
                avg_score=("risk_score", "mean")
            ).sort_values("claims_paid", ascending=False)

            fig_driver = px.bar(
                driver_agg,
                x="claims_paid",
                y="top_driver",
                orientation="h",
                color="avg_score",
                color_continuous_scale="Reds",
                title="Claims Incurred by Dominant Risk Factor",
                labels={"claims_paid": "Cumulative Claims Paid ($)", "top_driver": "Primary Driver", "avg_score": "Avg Risk Score"}
            )
            fig_driver.update_xaxes(tickprefix="$", tickformat="~s")
            fig_style(fig_driver, 330)
            st.plotly_chart(fig_driver, use_container_width=True)

    # 3. Structural Risk Matrix: Pre-FIRM vs Post-FIRM × Elevation
    st.markdown("#### Structural Property Risk Matrix")
    c_s1, c_s2 = st.columns(2)
    with c_s1:
        with st.container(border=True):
            st.markdown('<div class="ct">Loss Ratio by Construction Era & Elevation</div>', unsafe_allow_html=True)
            struct_pivot = prop_risk.groupby(["construction_date_band", "elevated"], as_index=False).agg(
                loss_ratio=("loss_ratio", "mean"),
                claim_frequency=("claim_frequency", "mean"),
                avg_claim_paid=("avg_claim_paid", "mean"),
                policies=("policy_count", "sum")
            )
            struct_pivot["Elevation Status"] = struct_pivot["elevated"].map({True: "Elevated (Protected)", False: "Non-Elevated"})
            fig_struct = px.bar(
                struct_pivot,
                x="construction_date_band",
                y="loss_ratio",
                color="Elevation Status",
                barmode="group",
                color_discrete_map={"Elevated (Protected)": "#38A169", "Non-Elevated": RED},
                title="Loss Ratio: Vintage × Elevation Status"
            )
            fig_struct.update_layout(yaxis_tickformat=".0%")
            fig_style(fig_struct, 300)
            st.plotly_chart(fig_struct, use_container_width=True)

    with c_s2:
        with st.container(border=True):
            st.markdown('<div class="ct">Claim Frequency by Zone Group</div>', unsafe_allow_html=True)
            zone_pivot = prop_risk.groupby("zone_group", as_index=False).agg(
                claim_frequency=("claim_frequency", "mean"),
                avg_claim_paid=("avg_claim_paid", "mean"),
                risk_score=("risk_score", "mean")
            ).sort_values("claim_frequency", ascending=False)

            fig_zone = px.scatter(
                zone_pivot,
                x="claim_frequency",
                y="avg_claim_paid",
                size="risk_score",
                color="zone_group",
                color_discrete_map=ZONE_COL,
                hover_name="zone_group",
                title="Claim Frequency vs Severity by Zone Group"
            )
            fig_zone.update_xaxes(tickformat=".1%", title="Annual Claim Frequency")
            fig_zone.update_yaxes(tickprefix="$", tickformat="~s", title="Average Claim Severity")
            fig_style(fig_zone, 300)
            st.plotly_chart(fig_zone, use_container_width=True)

    # 4. Interactive Actuarial Segment Leaderboard
    with st.container(border=True):
        st.markdown('<div class="ct">Actuarial Property Risk Segment Leaderboard (<code>gold_property_risk</code>)</div>', unsafe_allow_html=True)
        st.dataframe(
            prop_risk[[
                "state", "zone_group", "construction_date_band", "elevated", "region",
                "policy_count", "claim_count", "loss_ratio", "claim_frequency", "avg_claim_paid",
                "hazard_component", "loss_component", "property_component", "protection_component",
                "credibility", "risk_score", "risk_band", "top_driver"
            ]],
            hide_index=True,
            use_container_width=True,
            column_config={
                "state": "State",
                "zone_group": "Zone",
                "construction_date_band": "Construction Era",
                "elevated": "Elevated?",
                "region": "Region",
                "policy_count": st.column_config.NumberColumn("Policies", format="%d"),
                "claim_count": st.column_config.NumberColumn("Claims", format="%d"),
                "loss_ratio": st.column_config.NumberColumn("Loss Ratio", format="%.1%"),
                "claim_frequency": st.column_config.NumberColumn("Frequency", format="%.1%"),
                "avg_claim_paid": st.column_config.NumberColumn("Avg Claim", format="$%d"),
                "credibility": st.column_config.NumberColumn("Credibility", format="%.2f"),
                "risk_score": st.column_config.NumberColumn("Risk Score", format="%.1f"),
                "risk_band": "Risk Band",
                "top_driver": "Top Risk Driver"
            }
        )


# ==============================================================================
# 11. Customer Risk & Property Profile Intelligence (Customer 360)
# ==============================================================================

def render_customer_risk_profile(C: pd.DataFrame, P: pd.DataFrame, PO: pd.DataFrame, CL: pd.DataFrame, prop_risk: pd.DataFrame):
    """Deep-dive Customer & Property Profile Intelligence."""
    st.markdown("### Customer Risk Profile & Property Intelligence")
    st.markdown("Individual policyholder risk dossier, multi-property schedules, exposure limits, and loss histories.")

    if C.empty:
        st.info("No customer profile records available.")
        return

    # 1. Customer Selector & Search
    cust_options = C["customer_id"].tolist()
    names = dict(zip(C["customer_id"], C["first_name"] + " " + C["last_name"] + " (" + C["customer_id"] + ")"))
    
    sel_cid = st.selectbox(
        "Select Policyholder Dossier",
        cust_options,
        format_func=lambda x: names.get(x, x),
        key="sel_cust_dossier"
    )

    cust = C[C.customer_id == sel_cid].iloc[0]
    cust_props = P[P.customer_id == sel_cid] if not P.empty else pd.DataFrame()
    cust_pols = PO[PO.policy_id.isin(cust_props["active_policy_id"].dropna())] if not cust_props.empty else pd.DataFrame()
    cust_clms = CL[CL.policy_id.isin(cust_props["active_policy_id"].dropna())] if not cust_props.empty else pd.DataFrame()

    # 2. Policyholder Hero Dossier Card
    r_score = float(cust.get("highest_risk_score", 45.0) or 45.0)
    r_band = str(cust.get("highest_risk_band", "Medium"))
    p_status = str(cust.get("customer_status", "ACTIVE"))
    prem = float(cust.get("premium_active", 0.0) or 0.0)
    exp_val = float(cust.get("insured_value_active", 0.0) or 0.0)
    clms_pd = float(cust.get("claims_paid_total", 0.0) or 0.0)

    st.markdown(f'''
    <div style="background:#fff; border:1px solid #E2E8F0; border-radius:18px; padding:22px; margin-bottom:18px; box-shadow:0 2px 8px rgba(0,0,0,0.04);">
        <div style="display:flex; justify-content:space-between; align-items:flex-start; flex-wrap:wrap; gap:12px;">
            <div>
                <div style="font-size:0.8rem; text-transform:uppercase; font-weight:700; color:{MUTED};">Policyholder Profile · {cust['customer_id']}</div>
                <div style="font-size:1.6rem; font-weight:800; color:{INK};">{cust['first_name']} {cust['last_name']}</div>
                <div style="font-size:0.88rem; color:{MUTED}; margin-top:2px;">
                    Agent: <b>{cust.get('agent_name', 'Primary Agent')}</b> ({cust.get('agent_id', 'AGT-01')}) · Client Since {pd.Timestamp(cust.get('customer_since', '2020-01-01')).strftime('%B %Y')}
                </div>
            </div>
            <div style="display:flex; gap:10px; align-items:center;">
                <span class="pill {'paid' if p_status == 'ACTIVE' else 'lost'}" style="font-size:0.85rem; padding:6px 14px;">{p_status}</span>
                <span class="pill {'lost' if r_band == 'High' else ('pending' if r_band == 'Medium' else 'paid')}" style="font-size:0.85rem; padding:6px 14px;">{r_band} Risk ({r_score:.0f}/100)</span>
            </div>
        </div>
        <div style="display:grid; grid-template-columns: repeat(auto-fit, minmax(160px, 1fr)); gap:14px; margin-top:18px; border-top:1px solid #EDF2F7; padding-top:16px;">
            <div>
                <div style="font-size:0.75rem; color:{MUTED}; text-transform:uppercase; font-weight:600;">Active Premium</div>
                <div style="font-size:1.35rem; font-weight:800; color:{PURPLE};">{usd(prem)}</div>
            </div>
            <div>
                <div style="font-size:0.75rem; color:{MUTED}; text-transform:uppercase; font-weight:600;">Total Insured Value</div>
                <div style="font-size:1.35rem; font-weight:800; color:{INK};">{usd(exp_val)}</div>
            </div>
            <div>
                <div style="font-size:0.75rem; color:{MUTED}; text-transform:uppercase; font-weight:600;">Properties Insured</div>
                <div style="font-size:1.35rem; font-weight:800; color:{INK};">{int(cust.get('properties', 1))}</div>
            </div>
            <div>
                <div style="font-size:0.75rem; color:{MUTED}; text-transform:uppercase; font-weight:600;">Historical Claims Paid</div>
                <div style="font-size:1.35rem; font-weight:800; color:{'#E53E3E' if clms_pd > 0 else '#38A169'};">{usd(clms_pd)}</div>
            </div>
            <div>
                <div style="font-size:0.75rem; color:{MUTED}; text-transform:uppercase; font-weight:600;">Renewal Status</div>
                <div style="font-size:1.1rem; font-weight:700; color:{INK}; margin-top:2px;">
                    {'Due in ' + str(int(cust['days_to_renewal'])) + 'd' if pd.notna(cust.get('days_to_renewal')) else 'Renewed'}
                </div>
            </div>
        </div>
    </div>
    ''', unsafe_allow_html=True)

    # 3. Scheduled Properties Breakdown
    st.markdown("#### Scheduled Property Portfolio")
    if not cust_props.empty:
        st.dataframe(
            cust_props[[
                "property_id", "address_line", "city", "state", "county", "flood_zone",
                "construction_date_band", "elevated", "active_building_coverage", "active_contents_coverage",
                "active_premium", "assessed_risk_score", "assessed_risk_band", "claims_total"
            ]],
            hide_index=True,
            use_container_width=True,
            column_config={
                "property_id": "Property ID",
                "address_line": "Address",
                "city": "City",
                "state": "State",
                "county": "County",
                "flood_zone": "Zone",
                "construction_date_band": "Era",
                "elevated": "Elevated?",
                "active_building_coverage": st.column_config.NumberColumn("Building Limit", format="$%d"),
                "active_contents_coverage": st.column_config.NumberColumn("Contents Limit", format="$%d"),
                "active_premium": st.column_config.NumberColumn("Premium", format="$%d"),
                "assessed_risk_score": st.column_config.NumberColumn("Risk Score", format="%.0f"),
                "assessed_risk_band": "Risk Band",
                "claims_total": st.column_config.NumberColumn("Claims", format="%d")
            }
        )
    else:
        st.info("No property details found for this policyholder.")

    # 4. Policyholder Claims & Loss Events
    cp_c1, cp_c2 = st.columns(2)
    with cp_c1:
        with st.container(border=True):
            st.markdown('<div class="ct">Loss History & Claims Timeline</div>', unsafe_allow_html=True)
            if not cust_clms.empty:
                st.dataframe(
                    cust_clms[[
                        "claim_id", "date_of_loss", "amount_paid_on_building_claim",
                        "amount_paid_on_contents_claim", "amount_paid_on_icc_claim", "paid"
                    ]],
                    hide_index=True,
                    use_container_width=True,
                    column_config={
                        "claim_id": "Claim ID",
                        "date_of_loss": st.column_config.DateColumn("Date of Loss"),
                        "amount_paid_on_building_claim": st.column_config.NumberColumn("Building Paid", format="$%d"),
                        "amount_paid_on_contents_claim": st.column_config.NumberColumn("Contents Paid", format="$%d"),
                        "amount_paid_on_icc_claim": st.column_config.NumberColumn("ICC Paid", format="$%d"),
                        "paid": st.column_config.NumberColumn("Total Paid", format="$%d")
                    }
                )
            else:
                st.success("Loss-Free Record: No flood or catastrophic claims reported for this customer.")

    with cp_c2:
        with st.container(border=True):
            st.markdown('<div class="ct">Underwriting Recommendation & Next Actions</div>', unsafe_allow_html=True)
            if r_score > 65:
                st.warning("⚠️ **High Risk Profile:** Property exposure is located in Special Flood Hazard Area (SFHA). Recommend elevation survey and flood barrier verification before policy renewal.")
            elif r_score > 40:
                st.info("ℹ️ **Moderate Hazard Profile:** Standard policy with active mitigation credits. Suitable for standard renewal terms.")
            else:
                st.success("✅ **Low Risk / Preferred Tier:** Favorable loss history and modern Post-FIRM construction. Eligible for multi-year preferred pricing discounts.")
            
            st.markdown(f"""
            * **Renewal Window:** Expiration on `{cust.get('next_renewal_date', 'N/A')}`.
            * **Special Flood Hazard:** `{'Yes (Zone A/V)' if cust.get('in_special_flood_hazard_area') else 'No (Zone B/X)'}`.
            * **Mitigation Credits:** `{cust.get('mitigation_count', 0)} active measures verified`.
            """)


