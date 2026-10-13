# Insurance Business & Data Analytics Application (Databricks Apps)

An enterprise-grade Property & Flood Insurance Analytics and Machine Learning application designed for **Databricks Apps**, powered by Unity Catalog and Databricks SQL Warehouses.

Developed following the principle: **"Build Here (Local Test & Verification) $\rightarrow$ Deploy at Databricks Apps"**. The developer only needs to provide warehouse ID, catalog, schema, and read access; all visual analytics, geospatial maps, and predictive ML models operate autonomously.

---

## 🏛️ Unity Catalog Gold Architecture (`insurance_dev_gold.gold_schema`)

The application natively consumes the following 7 tables from your Unity Catalog schema:

| Table Name | Primary Columns & Actuarial Metrics | Dashboard & Analytics Usage |
|---|---|---|
| **`gold_claim_report`** | `claim_id`, `claim_id_uuid`, `policy_id`, `state`, `community_name`, `date_of_loss`, `year_of_loss`, `amount_paid_on_building_claim`, `amount_paid_on_contents_claim`, `amount_paid_on_icc_claim`, `total_building_insurance_coverage`, `total_contents_insurance_coverage` | Claims severity breakdown, payout distributions, and claim lifecycle tracking. |
| **`gold_policy_report`** | `policy_id`, `policy_id_uuid`, `state`, `county_code`, `community_name`, `policy_effective_date`, `policy_termination_date`, `total_building_insurance_coverage`, `total_contents_insurance_coverage`, `total_insurance_premium` | Gross Written Premium (GWP), in-force exposure, and expiration/renewal monitoring. |
| **`gold_property_risk`** | `state`, `zone_group`, `construction_date_band`, `elevated`, `region`, `policy_count`, `claim_count`, `claims_paid`, `premium`, `coverage_total`, `loss_ratio`, `claim_frequency`, `avg_claim_paid`, `declared_disasters`, `hma_projects`, `loss_component`, `hazard_component`, `property_component`, `protection_component`, `credibility`, `risk_score`, `risk_band`, `top_driver`, `window_start_year`, `window_end_year` | Actuarial Risk & Hazard Profiling, component decomposition (hazard, loss, property, protection credits), and top risk driver analysis. |
| **`gold_risk_by_geography`** | `state`, `region`, `policy_count`, `claim_count`, `claims_paid`, `premium`, `declared_disasters`, `hma_projects`, `high_risk_segments`, `segments`, `risk_score`, `loss_ratio`, `risk_band` | Geospatial state choropleth maps and regional portfolio risk intelligence. |
| **`gold_loss_ratio_by_state_year`** | `state`, `year`, `total_premium`, `claim_count`, `total_paid`, `loss_ratio`, `data_status` | Multi-year historical loss ratio trajectories (2021–2026) and profitability benchmarking. |
| **`gold_claims_by_disaster`** | `disaster_number`, `fema_declaration_string`, `declaration_title`, `incident_type`, `claim_count`, `total_paid` | Historical FEMA disaster benchmarks (Hurricanes Ian, Ida, Laura, tropical storms) and Catastrophe stress-testing. |
| **`gold_mitigation_vs_claims_by_state`** | `state`, `total_mitigation_spend`, `total_claims_paid` | FEMA / HMA hazard mitigation grant investments vs cumulative claims paid, and loss abatement ROI. |

---

## 🚀 Application Modules & Features

1. **Executive Cockpit**: Net loss ratios, in-force active premium, capital exposure, and 60-day renewal watchlist.
2. **Geospatial Risk Map**: Interactive US State choropleth and coastal hazard bubble maps with dynamic intensity metrics.
3. **Underwriting Flow**: Plotly Sankey diagram tracing policyholders across flood zones, build types, claims, and renewals.
4. **ML Risk & Pricing**: Dual Random Forest models (`RandomForestClassifier` for claim probability, `RandomForestRegressor` for expected loss severity) with an interactive **What-If Underwriting Simulator**.
5. **Actuarial & Hazard Risk**: Actuarial component breakdown (`hazard_component`, `loss_component`, `property_component`, `protection_component`, `credibility`) and top risk drivers.
6. **Financial Loss Ratios**: State underwriting profitability matrix, multi-year trajectories, and claim payout components.
7. **Catastrophe Simulator**: Weather shock and hurricane landfall simulator evaluating capital reserves and reinsurance triggers.
8. **Agent & Sales Performance**: Agent production volume, premium written, and loss ratio rankings.
9. **Dynamic Catalog & Schema Switcher**: Built-in sidebar expander (`⚙️ Switch Catalog / Schema`) allowing live connection switching across any Unity Catalog or schema at runtime.

---

## 💻 Local Development ("Build Here")

Run 100% offline without needing active Databricks credentials:
```bash
# Install dependencies
pip install -r requirements.txt

# Run application locally (offline demo gold data)
streamlit run app.py
```

To test against your Databricks workspace locally:
```bash
# Copy environment configuration
cp .env.example .env

# Configure .env with your credentials:
# DATABRICKS_HOST=https://<your-workspace>.cloud.databricks.com
# DATABRICKS_TOKEN=<your-pat-token>
# DATABRICKS_WAREHOUSE_ID=<your-sql-warehouse-id>
# GOLD_CATALOG=insurance_dev_gold
# GOLD_SCHEMA=gold_schema

# Validate connectivity
python config.py

# Launch app connected to Databricks
streamlit run app.py
```

---

## ☁️ Deployment to Databricks Apps ("Run on Databricks")

1. In Databricks, navigate to **Compute** $\rightarrow$ **Apps** $\rightarrow$ **Create App**.
2. Upload this folder to the app directory.
3. Verify `app.yaml`:
   ```yaml
   command: [
     "streamlit",
     "run",
     "app.py",
     "--server.port", "8000",
     "--server.address", "0.0.0.0",
     "--server.headless", "true"
   ]
   env:
     - name: "GOLD_CATALOG"
       value: "insurance_dev_gold"
     - name: "GOLD_SCHEMA"
       value: "gold_schema"
     - name: "DATABRICKS_WAREHOUSE_ID"
       value: "<your-sql-warehouse-id>"
   ```
4. **Grant Permissions to the App Service Principal**:
   Run the following in a Databricks SQL Editor (replace `<app-service-principal-id>` with the application ID shown in the app details):
   ```sql
   GRANT USE CATALOG ON CATALOG insurance_dev_gold TO `<app-service-principal-id>`;
   GRANT USE SCHEMA, SELECT ON SCHEMA insurance_dev_gold.gold_schema TO `<app-service-principal-id>`;
   ```
   *(If using a SQL Warehouse, also grant `CAN USE` on the SQL Warehouse).*
5. Click **Deploy**. The app auto-detects the Databricks App runtime and loads directly from `insurance_dev_gold.gold_schema`.
