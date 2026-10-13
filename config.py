"""Centralized configuration for Insurance Dashboard.

Works seamlessly across:
  1. Local Development ("Build Here"): Reads from .env or environment variables.
  2. Databricks Apps ("Run on Databricks"): Auto-detects Databricks App runtime credentials and app.yaml injections.
"""

from __future__ import annotations

import os
from pathlib import Path
from typing import Optional


def _load_dotenv_if_present(env_path: Optional[Path] = None) -> None:
    """Lightweight .env loader that populates os.environ without requiring external packages."""
    if env_path is None:
        env_path = Path(__file__).resolve().parent / ".env"
    if not env_path.is_file():
        return

    try:
        with open(env_path, "r", encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                if not line or line.startswith("#") or "=" not in line:
                    continue
                key, val = line.split("=", 1)
                key = key.strip()
                val = val.strip().strip("\"'").strip()
                if key and key not in os.environ:
                    os.environ[key] = val
    except Exception:
        pass


class _Config:
    """Centralized configuration values for the application."""

    def __init__(self):
        self.reload()

    def reload(self) -> None:
        _load_dotenv_if_present()

        # --- Databricks Connection Settings ---
        self.DATABRICKS_HOST: str = os.getenv("DATABRICKS_HOST", "").strip().rstrip("/")
        self.DATABRICKS_TOKEN: str = os.getenv("DATABRICKS_TOKEN", "").strip()
        self.DATABRICKS_CONFIG_PROFILE: str = os.getenv("DATABRICKS_CONFIG_PROFILE", "").strip()
        self.DATABRICKS_WAREHOUSE_ID: str = os.getenv("DATABRICKS_WAREHOUSE_ID", "").strip()

        # --- Genie & Unity Catalog Settings ---
        self.GENIE_SPACE_ID: str = os.getenv("GENIE_SPACE_ID", "").strip()
        self.GOLD_CATALOG: str = os.getenv("GOLD_CATALOG", "insurance_dev_gold").strip()
        self.GOLD_SCHEMA: str = os.getenv("GOLD_SCHEMA", "gold_schema").strip()

        # --- Caching & Business Logic ---
        self.CACHE_TTL_SECONDS: int = int(os.getenv("CACHE_TTL_SECONDS", "3600"))
        self.AS_OF_DATE: str = os.getenv("AS_OF_DATE", "").strip()

        # --- Server Settings ---
        self.PORT: int = int(os.getenv("PORT", "8000"))
        self.SERVER_ADDRESS: str = os.getenv("SERVER_ADDRESS", "0.0.0.0")

    @property
    def FULL_SCHEMA(self) -> str:
        return f"{self.GOLD_CATALOG}.{self.GOLD_SCHEMA}"

    def update_schema(self, catalog: str, schema: str) -> None:
        """Dynamically updates the target catalog and schema at runtime."""
        self.GOLD_CATALOG = catalog.strip()
        self.GOLD_SCHEMA = schema.strip()

    def list_available_catalogs(self) -> list[str]:
        """Discovers Unity Catalog catalogs via Databricks SDK if connected."""
        try:
            w = self.get_workspace_client()
            cats = [c.name for c in w.catalogs.list()]
            return sorted(set(cats)) if cats else [self.GOLD_CATALOG]
        except Exception:
            return sorted(set([self.GOLD_CATALOG, "synthetic", "main", "hive_metastore"]))

    def list_available_schemas(self, catalog_name: Optional[str] = None) -> list[str]:
        """Discovers schemas within a specified catalog via Databricks SDK."""
        target_cat = catalog_name or self.GOLD_CATALOG
        try:
            w = self.get_workspace_client()
            schemas = [s.name for s in w.schemas.list(catalog_name=target_cat)]
            return sorted(set(schemas)) if schemas else [self.GOLD_SCHEMA]
        except Exception:
            return sorted(set([self.GOLD_SCHEMA, "gold2", "default"]))

    @property
    def IS_DATABRICKS_APP(self) -> bool:
        """True when executing inside the managed Databricks Apps runtime."""
        return any(
            k in os.environ
            for k in ("DATABRICKS_APP_ID", "DATABRICKS_APP_NAME", "DATABRICKS_APP_PORT")
        )

    @property
    def IS_LIVE(self) -> bool:
        """True when a Genie Space ID or SQL Warehouse is configured for live querying."""
        return bool(self.GENIE_SPACE_ID or self.DATABRICKS_WAREHOUSE_ID)

    @property
    def HAS_SQL_WAREHOUSE(self) -> bool:
        """True when a Databricks SQL Warehouse ID is configured."""
        return bool(self.DATABRICKS_WAREHOUSE_ID)

    def get_workspace_client(self):
        """Returns a configured WorkspaceClient instance.

        Prioritizes:
          1. Databricks App runtime environment (automatic OAuth / Service Principal).
          2. Explicit DATABRICKS_HOST and DATABRICKS_TOKEN if provided locally.
          3. DATABRICKS_CONFIG_PROFILE from ~/.databrickscfg if provided.
          4. Default WorkspaceClient discovery.
        """
        from databricks.sdk import WorkspaceClient

        kwargs = {}
        if self.DATABRICKS_HOST:
            kwargs["host"] = self.DATABRICKS_HOST
        if self.DATABRICKS_TOKEN:
            kwargs["token"] = self.DATABRICKS_TOKEN
        if self.DATABRICKS_CONFIG_PROFILE:
            kwargs["profile"] = self.DATABRICKS_CONFIG_PROFILE

        return WorkspaceClient(**kwargs)

    def execute_sql(self, sql: str):
        """Directly executes a SQL statement on the Databricks SQL Warehouse if configured."""
        if not self.HAS_SQL_WAREHOUSE:
            return None
        from genie_client import statement_to_df
        w = self.get_workspace_client()
        res = w.statement_execution.execute_statement(
            warehouse_id=self.DATABRICKS_WAREHOUSE_ID,
            statement=sql,
            wait_timeout="50s",
        )
        return statement_to_df(w, res)

    def summary(self) -> dict[str, str]:
        """Summary of current configuration for diagnostics and logging."""
        if self.HAS_SQL_WAREHOUSE:
            mode = f"Direct Databricks SQL Warehouse ({self.DATABRICKS_WAREHOUSE_ID})"
        elif self.IS_LIVE:
            mode = "Live Databricks Genie Space"
        else:
            mode = "Built-in Demo Data (Offline)"

        env_type = "Databricks Apps Runtime" if self.IS_DATABRICKS_APP else "Local Development"
        return {
            "Runtime Environment": env_type,
            "Operation Mode": mode,
            "Databricks Host": self.DATABRICKS_HOST or ("Auto-detected (Databricks App)" if self.IS_DATABRICKS_APP else "Not set"),
            "SQL Warehouse ID": self.DATABRICKS_WAREHOUSE_ID or "Not set (optional)",
            "Genie Space ID": self.GENIE_SPACE_ID or "Not configured (demo mode)",
            "Target Schema": self.FULL_SCHEMA,
            "Cache TTL (seconds)": str(self.CACHE_TTL_SECONDS),
            "As-Of Date": self.AS_OF_DATE or "Dynamic (Today)",
        }


# Singleton configuration instance & class-style alias
config = _Config()
AppConfig = config


def test_connection():
    """CLI utility to verify connectivity and print configuration status."""
    print("=" * 60)
    print(" Insurance Dashboard - Configuration & Connectivity Check")
    print("=" * 60)
    for k, v in config.summary().items():
        print(f"  {k:<24}: {v}")
    print("=" * 60)

    if not config.IS_LIVE and not config.DATABRICKS_HOST:
        print("[INFO] Running in Demo Mode (offline mock data).")
        print("       To connect to Databricks locally, copy .env.example to .env and set credentials.")
        return

    print("\n[TEST] Attempting authentication to Databricks...")
    try:
        w = config.get_workspace_client()
        me = w.current_user.me()
        user_name = getattr(me, "user_name", "unknown")
        print(f"[SUCCESS] Connected to Databricks workspace as: {user_name}")

        if config.GENIE_SPACE_ID:
            print(f"[TEST] Checking access to Genie Space: {config.GENIE_SPACE_ID}...")
            try:
                space = w.genie.get_space(config.GENIE_SPACE_ID)
                title = getattr(space, "title", "Untitled Space")
                print(f"[SUCCESS] Genie Space verified: '{title}'")
            except Exception as e:
                print(f"[WARNING] Could not access Genie Space ({e}). Check space ID & permissions.")
    except Exception as e:
        print(f"[ERROR] Databricks authentication failed: {e}")
        print("        Ensure DATABRICKS_HOST and DATABRICKS_TOKEN are valid in your .env file.")


if __name__ == "__main__":
    test_connection()
