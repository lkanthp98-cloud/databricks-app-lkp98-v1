"""Sample data generator and Unity Catalog seeder.

Use this script to:
  1. Export sample datasets to CSV / Parquet for the 7 Gold tables.
  2. Generate a ready-to-run Databricks SQL script (`seed_unity_catalog.sql`) to create and populate
     the tables directly in `insurance_dev_gold.gold_schema`.
"""

import os
from pathlib import Path
import pandas as pd
import mock_gold
from config import AppConfig

TABLES = [
    "gold_claim_report",
    "gold_policy_report",
    "gold_property_risk",
    "gold_risk_by_geography",
    "gold_loss_ratio_by_state_year",
    "gold_claims_by_disaster",
    "gold_mitigation_vs_claims_by_state",
]

def export_samples(output_dir: str = "sample_data"):
    out_path = Path(output_dir)
    out_path.mkdir(exist_ok=True, parents=True)
    
    datasets = mock_gold.get()
    print(f"Generating realistic sample data for {len(TABLES)} Gold tables into '{output_dir}/'...")
    
    for t in TABLES:
        if t in datasets:
            df = datasets[t]
            csv_file = out_path / f"{t}.csv"
            df.to_csv(csv_file, index=False)
            print(f"  -> Exported {t:<35}: {len(df):>4} rows -> {csv_file}")

    # Generate SQL DDL and seed script
    sql_file = out_path / "seed_unity_catalog.sql"
    cat = AppConfig.GOLD_CATALOG
    sch = AppConfig.GOLD_SCHEMA
    
    with open(sql_file, "w", encoding="utf-8") as f:
        f.write(f"-- Unity Catalog Setup Script for {cat}.{sch}\n")
        f.write(f"CREATE CATALOG IF NOT EXISTS {cat};\n")
        f.write(f"USE CATALOG {cat};\n")
        f.write(f"CREATE SCHEMA IF NOT EXISTS {sch};\n")
        f.write(f"USE SCHEMA {sch};\n\n")
        
        for t in TABLES:
            if t in datasets:
                df = datasets[t]
                f.write(f"-- Table: {t}\n")
                f.write(f"CREATE OR REPLACE TABLE {cat}.{sch}.{t} (\n")
                col_defs = []
                for col, dtype in df.dtypes.items():
                    if "int" in str(dtype).lower():
                        sql_t = "BIGINT"
                    elif "float" in str(dtype).lower():
                        sql_t = "DOUBLE"
                    elif "bool" in str(dtype).lower():
                        sql_t = "BOOLEAN"
                    elif "datetime" in str(dtype).lower():
                        sql_t = "TIMESTAMP"
                    else:
                        sql_t = "STRING"
                    col_defs.append(f"    {col} {sql_t}")
                f.write(",\n".join(col_defs))
                f.write("\n);\n\n")
                
                # Sample INSERT statement (first 25 rows)
                sample_df = df.head(25)
                f.write(f"-- Sample seed data for {t}\n")
                f.write(f"INSERT INTO {cat}.{sch}.{t} VALUES\n")
                row_strs = []
                for _, r in sample_df.iterrows():
                    vals = []
                    for v in r:
                        if pd.isna(v) or v is None:
                            vals.append("NULL")
                        elif isinstance(v, (int, float)):
                            vals.append(str(v))
                        elif isinstance(v, bool):
                            vals.append("TRUE" if v else "FALSE")
                        else:
                            s = str(v).replace("'", "''")
                            vals.append(f"'{s}'")
                    row_strs.append(f"({', '.join(vals)})")
                f.write(",\n".join(row_strs))
                f.write(";\n\n")
                
    print(f"  -> Generated Databricks DDL & Seed SQL script: {sql_file}")
    print("\n[Done] You can run 'seed_unity_catalog.sql' directly in a Databricks SQL Editor if you need to create sample tables in your workspace!")

if __name__ == "__main__":
    export_samples()
