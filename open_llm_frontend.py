"""Open Source LLM Frontend for Insurance Analytics.

Provides a dedicated studio interface for querying internal application data
using Local Open LLMs (Ollama, vLLM) and Databricks Open Foundation Models (Llama 3.3, DBRX, Mixtral).
"""

from __future__ import annotations

from typing import Any, Dict, List, Optional
import pandas as pd
import streamlit as st

from config import AppConfig
from llm_engine import copilot, InAppDataRAG, OPEN_LLM_MODELS
from ui import AMBER, BAND_COL, DEEP, INK, MID, MUTED, PURPLE, RED, SOFT, fig_style, n, pct, usd


def render_open_llm_frontend(
    SRC: Dict[str, Any],
    C: pd.DataFrame,
    P: pd.DataFrame,
    PO: pd.DataFrame,
    CL: pd.DataFrame,
    ACT: pd.DataFrame
):
    """Renders the dedicated Open LLM Studio tab interface."""
    # Initialize RAG Engine on current active application data
    rag = InAppDataRAG(src_dict=SRC, C=C, P=P, PO=PO, CL=CL, ACT=ACT)
    indexed_stats = rag.get_indexed_table_summary()
    tot_indexed_rows = sum(indexed_stats.values())

    # 1. Header Hero Banner
    st.markdown(f"""
    <div style="background:linear-gradient(135deg, #1C1948 0%, #2A247A 50%, #4038A8 100%);
                border-radius:24px; padding:28px 32px; color:#FFFFFF; margin-bottom:20px;
                box-shadow: 0 10px 30px rgba(28,25,72,0.15);">
        <div style="display:flex; justify-content:space-between; align-items:flex-start; flex-wrap:wrap; gap:14px;">
            <div>
                <div style="font-size:0.85rem; font-weight:700; text-transform:uppercase; letter-spacing:1px; color:#A5B4FC; margin-bottom:6px;">
                    Enterprise In-App AI · Open Source LLM Studio
                </div>
                <div style="font-size:2rem; font-weight:800; letter-spacing:-0.5px; margin-bottom:8px;">
                    🤖 Open Source LLM Frontend
                </div>
                <div style="font-size:0.95rem; color:#E0E7FF; max-width:750px; line-height:1.5;">
                    Autonomous in-application intelligence operating directly on your internal <b>{len(indexed_stats)} Unity Catalog tables</b>.
                    Query, audit, and reason across your portfolio using local Open LLMs (Ollama) or Databricks Foundation Models with zero external data leaks.
                </div>
            </div>
            <div style="text-align:right;">
                <div style="background:rgba(255,255,255,0.15); border:1px solid rgba(255,255,255,0.25); border-radius:12px; padding:8px 16px; display:inline-block; margin-bottom:8px;">
                    <span style="font-size:1.1rem; font-weight:800;">{tot_indexed_rows:,}</span>
                    <span style="font-size:0.8rem; color:#E0E7FF;"> records indexed</span>
                </div>
                <div style="font-size:0.75rem; color:#C7D2FE;">Catalog: <code>{AppConfig.GOLD_CATALOG}.{AppConfig.GOLD_SCHEMA}</code></div>
            </div>
        </div>
    </div>
    """, unsafe_allow_html=True)

    # 2. Open Model Architecture & Connection Control
    with st.container(border=True):
        c1, c2, c3, c4 = st.columns([3, 2, 2, 1.5])
        with c1:
            model_options = [m[0] for m in OPEN_LLM_MODELS]
            model_labels = {m[0]: m[1] for m in OPEN_LLM_MODELS}
            selected_model = st.selectbox(
                "Active Open Source LLM Architecture",
                options=model_options,
                format_func=lambda x: model_labels.get(x, x),
                index=0,
                key="open_llm_studio_model_sel",
                help="Choose between local Open LLMs via Ollama, Databricks Foundation Models, or embedded In-App engine."
            )
        with c2:
            st.caption("Runtime Provider")
            if "ollama" in selected_model:
                st.markdown("**Local Ollama Server** (`localhost:11434`)")
            elif "databricks" in selected_model:
                st.markdown("**Databricks Model Serving** (Open Weights)")
            elif "in-app" in selected_model:
                st.markdown("**Embedded Actuarial Engine** (Pure Python)")
            else:
                st.markdown("**Custom Endpoint** (vLLM / Groq)")
        with c3:
            st.caption("Endpoint Health")
            test_clicked = st.button("⚡ Test Connection", key="btn_test_llm_conn", use_container_width=True)
            if test_clicked:
                with st.spinner("Pinging endpoint..."):
                    res = copilot.test_connection(selected_model)
                    if res["ok"]:
                        st.success(f"{res['message']}")
                    else:
                        st.warning(f"{res['message']}")
            else:
                st.markdown(f"Status: `Ready`")
        with c4:
            st.caption("Settings")
            show_settings = st.checkbox("⚙️ Config", value=False, key="chk_open_llm_settings")

        if show_settings:
            st.markdown("---")
            sc1, sc2, sc3 = st.columns([3, 2, 2])
            with sc1:
                new_url = st.text_input(
                    "Ollama / vLLM Endpoint URL",
                    value=copilot.custom_endpoint_url or "http://localhost:11434/v1",
                    help="Default Ollama endpoint: http://localhost:11434/v1"
                )
                if new_url != copilot.custom_endpoint_url:
                    copilot.custom_endpoint_url = new_url
            with sc2:
                new_key = st.text_input(
                    "Bearer Token / API Key (Optional)",
                    value=copilot.api_key,
                    type="password",
                    help="Optional for private or gated Open LLM endpoints"
                )
                if new_key != copilot.api_key:
                    copilot.api_key = new_key
            with sc3:
                temperature = st.slider("Temperature", 0.0, 1.0, 0.2, step=0.05, help="Lower = more deterministic actuarial answers")

    # 3. Studio Functional Tabs
    tab_chat, tab_memos, tab_inspector = st.tabs([
        "💬 In-App Data Chat",
        "📑 Document & Memo Generator",
        "📊 Data Knowledge Store (27 Tables)"
    ])

    # -------------------------------------------------------------
    # TAB 1: In-App Data Chat
    # -------------------------------------------------------------
    with tab_chat:
        st.markdown("#### Conversational Data Intelligence")
        st.markdown("Ask anything about your customers, properties, hazard zones, or claims. Responses are grounded in your internal database.")

        # Quick Prompt Starters
        st.markdown("<div style='font-size:0.85rem; font-weight:600; color:#4B5563; margin-bottom:6px;'>⚡ Quick Data Queries</div>", unsafe_allow_html=True)
        q1, q2, q3, q4, q5 = st.columns(5)
        starter_query = None
        if q1.button("🏆 Top 5 Claims", use_container_width=True, key="sq_claims"):
            starter_query = "Show top 5 claims by total settlement and identify the communities affected"
        if q2.button("🌊 Coastal VE Surge", use_container_width=True, key="sq_ve"):
            starter_query = "Analyze Pre-FIRM properties in VE coastal surge flood zones and their structural vulnerability"
        if q3.button("👤 Customer CUST-1001", use_container_width=True, key="sq_c1001"):
            starter_query = "Provide complete underwriting risk dossier and claim history for customer CUST-1001"
        if q4.button("🏛️ State Mitigation ROI", use_container_width=True, key="sq_mit"):
            starter_query = "What is our mitigation grant investment vs paid claims by state?"
        if q5.button("📊 Loss Ratio Health", use_container_width=True, key="sq_lr"):
            starter_query = "Evaluate our portfolio net loss ratio against the 65% target and recommend rate actions"

        # Session State Chat History
        if "llm_studio_messages" not in st.session_state:
            st.session_state["llm_studio_messages"] = [
                {
                    "role": "assistant",
                    "content": f"Hello! I am your **In-Application Open LLM Copilot** operating directly on your **{len(indexed_stats)} Unity Catalog tables** (`{AppConfig.GOLD_CATALOG}.{AppConfig.GOLD_SCHEMA}`). Ask me any question about your policyholders, claims, hazard zones, or underwriting guidelines.",
                    "citations": []
                }
            ]

        # Display Chat History
        chat_container = st.container()
        with chat_container:
            for msg in st.session_state["llm_studio_messages"]:
                with st.chat_message(msg["role"]):
                    st.markdown(msg["content"])
                    if msg.get("citations"):
                        with st.expander("🔍 Retrieved Internal Data Evidence & Citations", expanded=False):
                            for cit in msg["citations"]:
                                st.markdown(f"**Table:** `{cit['table']}` — *{cit['description']}*")
                                if isinstance(cit.get("df"), pd.DataFrame) and not cit["df"].empty:
                                    st.dataframe(cit["df"], hide_index=True, use_container_width=True)

        # Clear Chat Button
        c_clear, _ = st.columns([2, 8])
        with c_clear:
            if st.button("🗑️ Clear Chat History", key="btn_clear_chat"):
                st.session_state["llm_studio_messages"] = []
                st.rerun()

        # Chat Input Box
        user_input = st.chat_input("Ask a question about your portfolio, policies, claims, or customers...") or starter_query

        if user_input:
            # 1. Append user message
            st.session_state["llm_studio_messages"].append({"role": "user", "content": user_input})
            with st.chat_message("user"):
                st.markdown(user_input)

            # 2. Retrieve data context via InAppDataRAG
            with st.chat_message("assistant"):
                with st.spinner(f"Retrieving data from Unity Catalog and generating answer with {model_labels.get(selected_model, selected_model).split('(')[0].strip()}..."):
                    context_str, citations = rag.retrieve_context(user_input)
                    answer = copilot.generate_rag_response(
                        query=user_input,
                        context_str=context_str,
                        model_name=selected_model,
                        history=st.session_state["llm_studio_messages"]
                    )
                    st.markdown(answer)
                    if citations:
                        with st.expander("🔍 Retrieved Internal Data Evidence & Citations", expanded=True):
                            for cit in citations:
                                st.markdown(f"**Table:** `{cit['table']}` — *{cit['description']}*")
                                if isinstance(cit.get("df"), pd.DataFrame) and not cit["df"].empty:
                                    st.dataframe(cit["df"], hide_index=True, use_container_width=True)

            # 3. Append assistant message to history
            st.session_state["llm_studio_messages"].append({
                "role": "assistant",
                "content": answer,
                "citations": citations
            })

    # -------------------------------------------------------------
    # TAB 2: Document & Memo Generator
    # -------------------------------------------------------------
    with tab_memos:
        st.markdown("#### Automated Actuarial & Claims Document Generator")
        st.markdown("Produce publication-ready memorandums and briefs grounded in your customer and claims records.")

        doc_type = st.radio(
            "Document Category",
            ["Underwriting Memorandum", "Claims Loss Investigation Brief"],
            horizontal=True,
            key="open_llm_doc_type"
        )

        if doc_type == "Underwriting Memorandum":
            if C.empty:
                st.info("No customer records in dataset.")
            else:
                cust_options = {
                    r.customer_id: f"{r.customer_id} — {r.first_name} {r.last_name} ({r.highest_risk_band} Tier · {r.properties} structures)"
                    for r in C.itertuples()
                }
                sel_c = st.selectbox(
                    "Select Target Policyholder",
                    options=list(cust_options.keys()),
                    format_func=lambda x: cust_options.get(x, x),
                    key="doc_sel_cust"
                )
                c_row = C[C["customer_id"] == sel_c].iloc[0].to_dict()
                p_sub = P[P["customer_id"] == sel_c] if not P.empty else pd.DataFrame()
                cl_sub = CL[CL["policy_id"].isin(p_sub["active_policy_id"].dropna())] if not CL.empty and not p_sub.empty else pd.DataFrame()

                if st.button("✨ Generate Underwriting Memorandum", type="primary", key="btn_doc_gen_memo"):
                    with st.spinner("Synthesizing underwriting memo..."):
                        memo_res = copilot.generate_underwriting_memo(c_row, p_sub, cl_sub, selected_model)
                        st.session_state[f"doc_memo_out_{sel_c}"] = memo_res

                if f"doc_memo_out_{sel_c}" in st.session_state:
                    memo_content = st.session_state[f"doc_memo_out_{sel_c}"]
                    with st.container(border=True):
                        st.markdown(memo_content)
                        st.download_button(
                            "📥 Download Memorandum (.md)",
                            data=memo_content,
                            file_name=f"Underwriting_Memorandum_{sel_c}.md",
                            mime="text/markdown",
                            key=f"dl_memo_btn_{sel_c}"
                        )

        else:
            if CL.empty:
                st.info("No claim records in dataset.")
            else:
                cl_options = {
                    r.claim_id: f"{r.claim_id} — {r.community_name}, {r.state} (${(float(getattr(r, 'amount_paid_on_building_claim', 0) or 0) + float(getattr(r, 'amount_paid_on_contents_claim', 0) or 0) + float(getattr(r, 'amount_paid_on_icc_claim', 0) or 0)):,.0f} paid)"
                    for r in CL.itertuples()
                }
                sel_cl = st.selectbox(
                    "Select Target Claim",
                    options=list(cl_options.keys()),
                    format_func=lambda x: cl_options.get(x, x),
                    key="doc_sel_claim"
                )
                cl_row = CL[CL["claim_id"] == sel_cl].iloc[0].to_dict()

                if st.button("📑 Generate Loss Investigation Brief", type="primary", key="btn_doc_gen_clm"):
                    with st.spinner("Synthesizing adjuster brief..."):
                        narr_res = copilot.generate_claim_loss_narrative(cl_row, selected_model)
                        st.session_state[f"doc_clm_out_{sel_cl}"] = narr_res

                if f"doc_clm_out_{sel_cl}" in st.session_state:
                    clm_content = st.session_state[f"doc_clm_out_{sel_cl}"]
                    with st.container(border=True):
                        st.markdown(clm_content)
                        st.download_button(
                            "📥 Download Claims Brief (.md)",
                            data=clm_content,
                            file_name=f"Claims_Investigation_{sel_cl}.md",
                            mime="text/markdown",
                            key=f"dl_clm_btn_{sel_cl}"
                        )

    # -------------------------------------------------------------
    # TAB 3: Data Knowledge Store Inspector
    # -------------------------------------------------------------
    with tab_inspector:
        st.markdown("#### In-Memory Unity Catalog Knowledge Store")
        st.markdown(f"The Open LLM has real-time vector & relational indexing across all **{len(indexed_stats)} tables** in `{AppConfig.GOLD_CATALOG}.{AppConfig.GOLD_SCHEMA}`.")

        # Grid of Table Counts
        kpi_cols = st.columns(4)
        for i, (tbl_name, count) in enumerate(indexed_stats.items()):
            with kpi_cols[i % 4]:
                st.metric(tbl_name, f"{count:,} rows")

        # Interactive Table Search
        st.markdown("---")
        st.markdown("##### 🔎 Live Data Store Preview")
        preview_table = st.selectbox(
            "Select Table to Inspect",
            options=list(indexed_stats.keys()),
            key="inspector_table_sel"
        )
        if preview_table in ["customer", "property", "policy", "claim"]:
            df_to_show = {"customer": C, "property": P, "policy": PO, "claim": CL}[preview_table]
        else:
            df_to_show = SRC.get(preview_table, {}).get("df", pd.DataFrame())

        if not df_to_show.empty:
            st.dataframe(df_to_show.head(10), hide_index=True, use_container_width=True)
            st.caption(f"Showing top 10 records of {len(df_to_show):,} rows in <code>{preview_table}</code>", unsafe_allow_html=True)
        else:
            st.info(f"No records available in {preview_table}.")
