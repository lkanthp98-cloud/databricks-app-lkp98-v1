"""Demo data in the EXACT shape of gold_customer_profile / gold_property_profile / gold_policy_report / gold_claim_report
(from Synthetic_Data_To_Gold). Used only when GENIE_SPACE_ID is not set. Maria Chen matches the notebook's own check."""
import datetime as dt
import numpy as np
import pandas as pd

AS_OF = pd.Timestamp("2026-10-09")
rng = np.random.default_rng(5)
# state, county, city, zip, weight, flood-zone mix [AE, VE, A, X, B]
GEO = [("TX", "Harris", "Baytown", "77520", 6, [.45, .05, .1, .35, .05]), ("TX", "Galveston", "Galveston", "77550", 3, [.4, .25, .1, .2, .05]),
       ("TX", "Brazoria", "Freeport", "77541", 2, [.4, .15, .1, .3, .05]), ("LA", "Jefferson", "Metairie", "70001", 4, [.5, .05, .15, .25, .05]),
       ("LA", "Orleans", "New Orleans", "70112", 3, [.45, .05, .15, .3, .05]), ("FL", "Miami-Dade", "Miami", "33101", 7, [.35, .25, .1, .25, .05]),
       ("FL", "Lee", "Fort Myers", "33901", 4, [.4, .2, .1, .25, .05]), ("FL", "Hillsborough", "Tampa", "33602", 3, [.35, .15, .1, .35, .05]),
       ("NC", "New Hanover", "Wilmington", "28401", 3, [.35, .15, .1, .35, .05]), ("NC", "Dare", "Nags Head", "27959", 2, [.3, .3, .1, .25, .05]),
       ("SC", "Charleston", "Charleston", "29401", 3, [.4, .15, .1, .3, .05]), ("SC", "Horry", "Myrtle Beach", "29577", 2, [.35, .2, .1, .3, .05])]
GEO_COORDS = [
    (29.7355, -94.9774), (29.3013, -94.7977), (28.9497, -95.4419),
    (29.9841, -90.1526), (29.9511, -90.0715), (25.7617, -80.1918),
    (26.6406, -81.8723), (27.9506, -82.4572), (34.2257, -77.9447),
    (35.9188, -75.5977), (32.7765, -79.9311), (33.6891, -78.8867)
]
ZONES = ["AE", "VE", "A", "X", "B"]
CRS = {"AE": 7, "VE": 6, "A": 7, "X": 8, "B": 8}
ZONE_RATE = {"VE": 2.4, "AE": 1.5, "A": 1.3, "B": .7, "X": .5}
ZONE_CLAIM = {"VE": .2, "AE": .12, "A": .1, "B": .05, "X": .03}
ZONE_RISK = {"VE": 62, "AE": 50, "A": 44, "B": 22, "X": 15}
FIRST = ["Alex", "Sam", "Priya", "Jordan", "Lee", "Chris", "Dana", "Riley", "Noor", "Omar", "Elena", "Kai", "Mia", "Ravi", "Zoe", "Ana", "Ben", "Cora"]
LAST = ["Nguyen", "Patel", "Garcia", "Smith", "Johnson", "Brown", "Lopez", "Kim", "Davis", "Clark", "Reyes", "Singh", "Walker", "Young"]
AGENTS = [("AGT-01", "Hannah Brooks"), ("AGT-02", "Luis Ortega"), ("AGT-03", "Aisha Rahman"), ("AGT-04", "Tom Becker"), ("AGT-05", "Mei Lin")]
_cache = {}


def band(s):
    return "High" if s >= 66 else "Medium" if s >= 33 else "Low"


def build(n_customers=700):
    w = np.array([g[4] for g in GEO], float); w /= w.sum()
    props, pols, clms, custs = [], [], [], []
    pol_seq = clm_seq = 0
    specs = []
    # --- Maria Chen exactly as in the business-process PDF ---
    specs.append(dict(cid="CUST-10492", fn="Maria", ln="Chen", since=dt.date(2019, 3, 1), agent=AGENTS[0], props=[dict(
        pid="PROP-58210", addr="214 Riverbend Lane", gi=0, zone="AE", band="Pre-FIRM", elevated=False, eff=pd.Timestamp("2024-03-01"), bcov=250000., ccov=100000., base=1850.,
        claim=("2024-09-12", 17250.0, "CLOSED"), mit=2, risk=58.0, rl=False)]))
    for i in range(n_customers):
        cid = f"CUST-{20000 + i}"
        since = dt.date(int(rng.integers(2017, 2026)), int(rng.integers(1, 13)), int(rng.integers(1, 28)))
        plist = []
        for k in range(int(rng.choice([1, 2, 3], p=[.8, .17, .03]))):
            gi = int(rng.choice(len(GEO), p=w)); zone = str(rng.choice(ZONES, p=GEO[gi][5]))
            first_eff = pd.Timestamp(since) + pd.Timedelta(days=int(rng.integers(5, 30)))
            plist.append(dict(pid=f"PROP-{60000 + len(props) + len(specs) * 5 + k + i * 4}", addr=f"{int(rng.integers(10, 999))} {rng.choice(['Oak', 'Bay', 'Harbor', 'Pine', 'Cedar', 'Lake'])} St",
                              gi=gi, zone=zone, band=str(rng.choice(["Pre-FIRM", "Post-FIRM"], p=[.45, .55])), elevated=bool(rng.random() < .15), eff=first_eff,
                              bcov=float(rng.choice([100e3, 150e3, 200e3, 250e3, 350e3, 500e3], p=[.15, .2, .2, .25, .1, .1])), ccov=float(rng.choice([25e3, 50e3, 75e3, 100e3], p=[.25, .35, .2, .2])),
                              base=None, claim=None, mit=None, risk=None, rl=None))
        specs.append(dict(cid=cid, fn=str(rng.choice(FIRST)), ln=str(rng.choice(LAST)), since=since, agent=AGENTS[int(rng.integers(0, len(AGENTS)))], props=plist))
    seen = set()
    for sp in specs:
        for p in sp["props"]:
            while p["pid"] in seen:
                p["pid"] += "x"
            seen.add(p["pid"])
    rows_p = []
    for sp in specs:
        for p in sp["props"]:
            st_, cty, city, zp, _, _ = GEO[p["gi"]]
            if p["base"] is None:
                p["base"] = round((p["bcov"] + p["ccov"]) * .0055 * ZONE_RATE[p["zone"]] * (1.15 if p["band"] == "Pre-FIRM" else 1), 0)
            terms, eff = [], p["eff"]
            while eff < AS_OF:
                pol_seq += 1
                terms.append(dict(pid=f"POL-{eff.year}-{zp}-{pol_seq:04d}", eff=eff, exp=eff + pd.DateOffset(years=1), prem=round(p["base"] * (1 + .01 * len(terms)), 2)))
                eff = eff + pd.DateOffset(years=1)
            cl = []
            if p["claim"] is not None:
                ld, paid, stt = p["claim"]; cl.append((pd.Timestamp(ld), paid, stt))
            else:
                for tm in terms:
                    if rng.random() < ZONE_CLAIM[p["zone"]]:
                        ld = tm["eff"] + pd.Timedelta(days=int(rng.integers(20, 340)))
                        if ld < AS_OF:
                            stt = "OPEN" if (AS_OF - ld).days < 120 and rng.random() < .8 else ("DENIED" if rng.random() < .08 else "CLOSED")
                            amt = 0.0 if stt in ("OPEN", "DENIED") else float(round(min(rng.lognormal(9.7, .9), p["bcov"]), -1))
                            cl.append((ld, amt, stt))
            p["terms"], p["claims"] = terms, cl
            if p["mit"] is None:
                p["mit"] = int(rng.random() < (.3 if cl else .08)) + int(rng.random() < .05)
            if p["risk"] is None:
                p["risk"] = float(np.clip(ZONE_RISK[p["zone"]] + (12 if p["band"] == "Pre-FIRM" else 0) + 8 * len(cl) - 8 * p["mit"] + rng.normal(0, 8), 2, 99).round(1))
            if p["rl"] is None:
                p["rl"] = len([c for c in cl if c[2] == "CLOSED"]) >= 2
            for tm in terms:
                pols.append((tm["pid"], sp["cid"], p["pid"], st_, f"{48000 + p['gi']}", city, tm["eff"], tm["exp"], p["bcov"], p["ccov"], tm["prem"]))
            for ld, amt, stt in cl:
                clm_seq += 1
                pl = [t for t in terms if t["eff"] <= ld < t["exp"]]
                pid_ = pl[0]["pid"] if pl else terms[-1]["pid"]
                clms.append((f"CLM-{ld.year}-{80000 + clm_seq}", pid_, st_, city, ld, ld.year, amt, 0.0, 0.0, p["bcov"], p["ccov"], stt))
            rows_p.append((sp, p))
    # county context
    cty = {}
    for sp, p in rows_p:
        k = p["gi"]; c = cty.setdefault(k, dict(insured=0., terms=0, paid=0.))
        c["terms"] += len(p["terms"]); c["paid"] += sum(a for _, a, _ in p["claims"])
        a = next((t for t in p["terms"] if t["eff"] <= AS_OF < t["exp"]), None)
        if a: c["insured"] += p["bcov"] + p["ccov"]
    tot = sum(c["insured"] for c in cty.values()) or 1
    rank = {k: i + 1 for i, k in enumerate(sorted(cty, key=lambda k: -cty[k]["insured"]))}
    ctx = {k: dict(dis=int(rng.integers(2, 9)), last=int(rng.integers(2019, 2026)), hma=int(rng.integers(3, 40)), hma_amt=float(rng.uniform(2e6, 80e6))) for k in cty}
    prop_rows = []
    for sp, p in rows_p:
        st_, cty_n, city, zp, _, _ = GEO[p["gi"]]; k = p["gi"]; c = cty[k]
        a = next((t for t in p["terms"] if t["eff"] <= AS_OF < t["exp"]), None)
        ncl = len(p["claims"]); opn = sum(1 for _, _, s in p["claims"] if s == "OPEN")
        base_lat, base_lon = GEO_COORDS[p["gi"]]
        lat_val = round(base_lat + float(rng.uniform(-0.04, 0.04)), 4)
        lon_val = round(base_lon + float(rng.uniform(-0.04, 0.04)), 4)
        prop_rows.append(dict(property_id=p["pid"], customer_id=sp["cid"], address_line=p["addr"], city=city, zip_code=zp, state=st_, county=cty_n, flood_zone=p["zone"], construction_date_band=p["band"],
            latitude=lat_val, longitude=lon_val,
            elevated=p["elevated"], crs_class=CRS[p["zone"]], active_policy_id=a["pid"] if a else None, policy_expiration_date=a["exp"] if a else pd.NaT,
            active_building_coverage=p["bcov"] if a else np.nan, active_contents_coverage=p["ccov"] if a else np.nan, active_premium=(a["prem"] + 50) if a else np.nan,
            policy_terms=len(p["terms"]), claims_total=ncl, claims_open=opn, claims_paid_total=sum(x for _, x, _ in p["claims"]), last_loss_date=max((d for d, _, _ in p["claims"]), default=pd.NaT),
            nfip_rl=p["rl"], mitigation_count=p["mit"], assessed_risk_score=p["risk"], assessed_risk_band=band(p["risk"]), county_declared_disasters_window=ctx[k]["dis"],
            county_last_declared_year=ctx[k]["last"], county_hma_projects=ctx[k]["hma"], county_hma_obligated=ctx[k]["hma_amt"], county_insured_value=c["insured"],
            county_share_of_portfolio=round(c["insured"] / tot, 4), county_rank=rank[k], county_claims_paid_per_policy=round(c["paid"] / max(c["terms"], 1), 2)))
    P = pd.DataFrame(prop_rows)
    pending_ids = set(P.active_policy_id.dropna().sample(frac=.05, random_state=2))
    cust_rows = []
    for sp in specs:
        pr = P[P.customer_id == sp["cid"]]
        act = pr[pr.active_policy_id.notna()]
        nxt = act.policy_expiration_date.min() if len(act) else pd.NaT
        d2r = int((nxt - AS_OF).days) if pd.notna(nxt) else None
        prim = (act if len(act) else pr).sort_values("active_building_coverage", ascending=False, na_position="last").iloc[0]
        hi = pr.sort_values("assessed_risk_score", ascending=False).iloc[0]
        cust_rows.append(dict(customer_id=sp["cid"], first_name=sp["fn"], last_name=sp["ln"], customer_status="ACTIVE" if len(act) else "LAPSED", customer_since=pd.Timestamp(sp["since"]),
            agent_id=sp["agent"][0], agent_name=sp["agent"][1], properties=len(pr), states=pr.state.nunique(), active_policies=len(act), policy_terms_total=int(pr.policy_terms.sum()),
            building_coverage_active=act.active_building_coverage.sum(), contents_coverage_active=act.active_contents_coverage.sum(), premium_active=act.active_premium.sum(),
            next_renewal_date=nxt, days_to_renewal=d2r, renewal_due_60d=bool(d2r is not None and d2r <= 60), renewal_pending=bool(set(act.active_policy_id) & pending_ids),
            claims_total=int(pr.claims_total.sum()), claims_open=int(pr.claims_open.sum()), claims_paid_total=pr.claims_paid_total.sum(), last_loss_date=pr.last_loss_date.max(),
            mitigation_count=int(pr.mitigation_count.sum()), primary_property_id=prim.property_id, primary_county=prim.county, primary_state=prim.state, highest_risk_score=hi.assessed_risk_score,
            highest_risk_band=band(hi.assessed_risk_score), highest_risk_property_id=hi.property_id, in_special_flood_hazard_area=bool(pr.flood_zone.str[0].isin(list("AV")).any()),
            pre_firm_properties=int((pr.construction_date_band == "Pre-FIRM").sum()), insured_value_active=(act.active_building_coverage + act.active_contents_coverage).sum(),
            primary_county_insured_value=prim.county_insured_value, primary_county_share=prim.county_share_of_portfolio, primary_county_rank=prim.county_rank,
            primary_county_declared_disasters_window=prim.county_declared_disasters_window, primary_county_last_declared_year=prim.county_last_declared_year,
            primary_county_hma_projects=prim.county_hma_projects, primary_county_claims_paid_per_policy=prim.county_claims_paid_per_policy))
    C = pd.DataFrame(cust_rows)
    PO = pd.DataFrame(pols, columns=["policy_id", "customer_id", "property_id", "state", "county_code", "community_name", "policy_effective_date", "policy_termination_date", "total_building_insurance_coverage",
                                     "total_contents_insurance_coverage", "total_insurance_premium"])
    PO["policy_id_uuid"] = "uuid-" + PO["policy_id"]

    CL = pd.DataFrame(clms, columns=["claim_id", "policy_id", "state", "community_name", "date_of_loss", "year_of_loss", "amount_paid_on_building_claim", "amount_paid_on_contents_claim",
                                     "amount_paid_on_icc_claim", "total_building_insurance_coverage", "total_contents_insurance_coverage", "_status"]).drop(columns="_status")
    CL["claim_id_uuid"] = "uuid-" + CL["claim_id"]
    CL["policy_id_uuid"] = "uuid-" + CL["policy_id"]

    # 1. gold_claims_by_disaster
    dis_rows = [
        dict(disaster_number=4520, fema_declaration_string="DR-4520-TX", declaration_title="Hurricane Laura", incident_type="Hurricane", claim_count=620, total_paid=22400000.0),
        dict(disaster_number=4611, fema_declaration_string="DR-4611-LA", declaration_title="Hurricane Ida", incident_type="Hurricane", claim_count=740, total_paid=31800000.0),
        dict(disaster_number=4673, fema_declaration_string="DR-4673-FL", declaration_title="Hurricane Ian", incident_type="Hurricane", claim_count=980, total_paid=46500000.0),
        dict(disaster_number=4712, fema_declaration_string="DR-4712-NC", declaration_title="Tropical Storm Debby", incident_type="Tropical Storm", claim_count=180, total_paid=4800000.0),
        dict(disaster_number=4735, fema_declaration_string="DR-4735-SC", declaration_title="Coastal Surge and Flooding", incident_type="Flood", claim_count=230, total_paid=6200000.0),
        dict(disaster_number=4789, fema_declaration_string="DR-4789-TX", declaration_title="Gulf Coast Severe Storms", incident_type="Severe Storm", claim_count=190, total_paid=3900000.0),
    ]
    DIS = pd.DataFrame(dis_rows)

    # 2. gold_loss_ratio_by_state_year
    lr_rows = []
    years = [2021, 2022, 2023, 2024, 2025, 2026]
    states = ["TX", "FL", "LA", "NC", "SC"]
    for st_ in states:
        for yr in years:
            prem = float(PO[(PO.state == st_) & (PO.policy_effective_date.dt.year == yr)].total_insurance_premium.sum())
            clms_subset = CL[(CL.state == st_) & (CL.year_of_loss == yr)]
            cc = len(clms_subset)
            paid = float(clms_subset.amount_paid_on_building_claim.sum() + clms_subset.amount_paid_on_contents_claim.sum() + clms_subset.amount_paid_on_icc_claim.sum())
            if prem == 0:
                prem = round(float(rng.uniform(800000, 3500000)), 2)
                paid = round(prem * float(rng.uniform(0.35, 0.78)), 2)
                cc = int(rng.integers(15, 80))
            lr = round(paid / max(prem, 1.0), 4)
            lr_rows.append(dict(state=st_, year=yr, total_premium=prem, claim_count=cc, total_paid=paid, loss_ratio=lr, data_status="FINALIZED" if yr < 2026 else "DEVELOPING"))
    LR_STATE_YEAR = pd.DataFrame(lr_rows)

    # 3. gold_mitigation_vs_claims_by_state
    mit_rows = []
    for st_ in states:
        tot_paid = float(LR_STATE_YEAR[LR_STATE_YEAR.state == st_].total_paid.sum())
        mit_spend = round(tot_paid * float(rng.uniform(0.20, 0.45)), 2)
        mit_rows.append(dict(state=st_, total_mitigation_spend=mit_spend, total_claims_paid=tot_paid))
    MIT = pd.DataFrame(mit_rows)

    # 4. gold_property_risk
    region_map = {"TX": "Gulf Coast", "LA": "Gulf Coast", "FL": "South Atlantic", "NC": "South Atlantic", "SC": "South Atlantic"}
    prop_risk_rows = []
    for st_ in states:
        for zg in ["VE", "AE", "A", "B", "X"]:
            for band_ in ["Pre-FIRM", "Post-FIRM"]:
                for elev in [True, False]:
                    reg = region_map.get(st_, "Gulf Coast")
                    pol_ct = int(rng.integers(40, 250))
                    clm_ct = int(pol_ct * (0.22 if zg in ["VE", "AE"] else 0.08) * (1.3 if band_ == "Pre-FIRM" else 0.8) * (0.7 if elev else 1.1))
                    avg_paid = float(round(rng.uniform(18000, 48000), 2))
                    clm_paid = round(clm_ct * avg_paid, 2)
                    prem = round(pol_ct * (2800.0 if zg == "VE" else (1900.0 if zg == "AE" else 1100.0)) * (1.2 if band_ == "Pre-FIRM" else 1.0) * (0.85 if elev else 1.0), 2)
                    cov_tot = round(pol_ct * 320000.0, 2)
                    lr = round(clm_paid / max(prem, 1.0), 4)
                    freq = round(clm_ct / max(pol_ct, 1.0), 4)
                    r_score = round(float(np.clip((ZONE_RISK.get(zg, 20) + (14 if band_ == "Pre-FIRM" else 0) - (12 if elev else 0) + rng.normal(0, 4)), 5, 98)), 1)
                    prop_risk_rows.append(dict(
                        state=st_, zone_group=zg, construction_date_band=band_, elevated=elev, region=reg, data_status="ACTIVE",
                        policy_count=pol_ct, claim_count=clm_ct, claims_paid=clm_paid, premium=prem, coverage_total=cov_tot,
                        loss_ratio=lr, claim_frequency=freq, avg_claim_paid=avg_paid, declared_disasters=int(rng.integers(2, 7)),
                        hma_projects=int(rng.integers(5, 30)), loss_component=round(lr * 40, 2), hazard_component=round(ZONE_RISK.get(zg, 20) * 0.4, 2),
                        property_component=round((15.0 if band_ == "Pre-FIRM" else 5.0), 2), protection_component=round((-8.0 if elev else 0.0), 2),
                        credibility=round(float(min(1.0, pol_ct / 150.0)), 2), risk_score=r_score, risk_band=band(r_score),
                        top_driver="Coastal Hazard" if zg in ["VE", "AE"] else ("Pre-FIRM Structure" if band_ == "Pre-FIRM" else "Elevation Deficit"),
                        window_start_year=2018, window_end_year=2025, _built_at="2026-10-13 12:00:00"
                    ))
    PROP_RISK = pd.DataFrame(prop_risk_rows)

    # 5. gold_risk_by_geography
    geo_risk_rows = []
    for st_ in states:
        reg = region_map.get(st_, "Gulf Coast")
        sub_pr = PROP_RISK[PROP_RISK.state == st_]
        p_cnt = int(sub_pr.policy_count.sum())
        c_cnt = int(sub_pr.claim_count.sum())
        c_pd = float(sub_pr.claims_paid.sum())
        prm = float(sub_pr.premium.sum())
        lr = round(c_pd / max(prm, 1.0), 4)
        r_score = round(float(sub_pr.risk_score.mean()), 1)
        geo_risk_rows.append(dict(
            state=st_, region=reg, policy_count=p_cnt, claim_count=c_cnt, claims_paid=c_pd, premium=prm,
            declared_disasters=int(sub_pr.declared_disasters.max()), hma_projects=int(sub_pr.hma_projects.sum()),
            high_risk_segments=int((sub_pr.risk_band == "High").sum()), segments=len(sub_pr),
            risk_score=r_score, loss_ratio=lr, risk_band=band(r_score)
        ))
    GEO_RISK = pd.DataFrame(geo_risk_rows)

    # Base Relational & Operational Tables
    agent_rows = [
        dict(agent_id=aid, agent_name=aname, state="TX" if i % 2 == 0 else "FL")
        for i, (aid, aname) in enumerate(AGENTS)
    ]
    AGENT_DF = pd.DataFrame(agent_rows)

    community_rows = [
        dict(
            community_id=f"COM-{48000 + i}",
            community_name=city,
            county=cty_n,
            state=st_,
            participating_in_nfip=True,
            tribal=False,
            class_rating=int(CRS.get(ZONES[i % len(ZONES)], 7)),
            sfha_discount=0.15 if i % 2 == 0 else 0.20,
            non_sfha_discount=0.05 if i % 2 == 0 else 0.10,
            sanction="NONE"
        )
        for i, (st_, cty_n, city, zp, _, _) in enumerate(GEO)
    ]
    COMMUNITY_DF = pd.DataFrame(community_rows)

    customer_rows = [
        dict(
            customer_id=r["customer_id"],
            state=r["primary_state"],
            county_code=str(r["primary_county"]),
            community_id=f"COM-{48000 + (hash(r['customer_id']) % len(GEO))}"
        )
        for _, r in C.iterrows()
    ]
    CUSTOMER_DF = pd.DataFrame(customer_rows)

    property_rows = []
    for _, r in P.iterrows():
        property_rows.append(dict(
            property_id=r["property_id"],
            community_id=f"COM-{48000 + (hash(r['property_id']) % len(GEO))}",
            state=r["state"],
            state_abbreviation=r["state"],
            county=r["county"],
            zip_code=r["zip_code"],
            city=r["city"],
            flood_zone=r["flood_zone"],
            latitude=round(float(29.0 + (hash(r['property_id']) % 1000) * 0.005), 4),
            longitude=round(float(-95.0 - (hash(r['property_id']) % 1000) * 0.005), 4),
            occupancy_type="Single Family Residence",
            original_construction_date=pd.Timestamp("1995-06-15") if r["construction_date_band"] == "Pre-FIRM" else pd.Timestamp("2012-08-20"),
            primary_residence_indicator=True,
            total_losses=int(r["claims_total"]),
            nfip_rl=bool(r["nfip_rl"]),
            nfip_srl=bool(r["claims_total"] >= 4),
            mitigated_indicator=bool(r["mitigation_count"] > 0),
            insured_indicator=bool(pd.notna(r["active_policy_id"])),
            synthetic_geo_key=f"GEO-{r['state']}-{r['zip_code']}",
            synthetic_zip_key=f"ZIP-{r['zip_code']}"
        ))
    PROPERTY_DF = pd.DataFrame(property_rows)

    policy_rows = []
    for _, r in PO.iterrows():
        policy_rows.append(dict(
            policy_id=r["policy_id"],
            customer_id=r["customer_id"],
            property_id=r["property_id"],
            agent_id=f"AGT-0{1 + (hash(r['policy_id']) % 5)}",
            community_id=f"COM-{48000 + (hash(r['policy_id']) % len(GEO))}",
            policy_effective_date=r["policy_effective_date"],
            policy_termination_date=r["policy_termination_date"],
            total_building_insurance_coverage=r["total_building_insurance_coverage"],
            total_contents_insurance_coverage=r["total_contents_insurance_coverage"],
            total_insurance_premium=r["total_insurance_premium"],
            hfiaa_surcharge=25.0,
            federal_policy_fee=50.0,
            occupancy_type="Single Family",
            rated_flood_zone="AE",
            state=r["state"],
            county_code=r["county_code"],
            synthetic_property_key=f"SYN-PROP-{r['property_id']}",
            synthetic_policy_key=f"SYN-POL-{r['policy_id']}"
        ))
    POLICY_DF = pd.DataFrame(policy_rows)

    claim_rows = []
    for _, r in CL.iterrows():
        claim_rows.append(dict(
            claim_id=r["claim_id"],
            policy_id=r["policy_id"],
            community_id=f"COM-{48000 + (hash(r['claim_id']) % len(GEO))}",
            date_of_loss=r["date_of_loss"],
            year_of_loss=int(r["year_of_loss"]),
            state=r["state"],
            county_code=str(r["state"]) + "-001",
            amount_paid_on_building_claim=r["amount_paid_on_building_claim"],
            amount_paid_on_contents_claim=r["amount_paid_on_contents_claim"],
            amount_paid_on_icc_claim=r["amount_paid_on_icc_claim"],
            total_building_insurance_coverage=r["total_building_insurance_coverage"],
            total_contents_insurance_coverage=r["total_contents_insurance_coverage"],
            occupancy_type="Single Family",
            rated_flood_zone="AE",
            primary_residence_indicator=True,
            elevated_building_indicator=False,
            synthetic_policy_key=f"SYN-POL-{r['policy_id']}"
        ))
    CLAIM_DF = pd.DataFrame(claim_rows)

    cov_rows = []
    for _, r in POLICY_DF.head(300).iterrows():
        cov_rows.append(dict(coverage_id=f"COV-B-{r['policy_id']}", policy_id=r["policy_id"], coverage_type="BUILDING", coverage_amount=float(r["total_building_insurance_coverage"])))
        cov_rows.append(dict(coverage_id=f"COV-C-{r['policy_id']}", policy_id=r["policy_id"], coverage_type="CONTENTS", coverage_amount=float(r["total_contents_insurance_coverage"])))
    COVERAGE_DF = pd.DataFrame(cov_rows)

    doc_rows = []
    for _, r in CLAIM_DF.head(200).iterrows():
        doc_rows.append(dict(document_id=f"DOC-FNOL-{r['claim_id']}", claim_id=r["claim_id"], document_type="First Notice of Loss", created_date=r["date_of_loss"]))
        doc_rows.append(dict(document_id=f"DOC-ADJ-{r['claim_id']}", claim_id=r["claim_id"], document_type="Adjuster Report", created_date=pd.Timestamp(r["date_of_loss"]) + pd.Timedelta(days=7)))
    DOCUMENT_DF = pd.DataFrame(doc_rows)

    insp_rows = []
    for _, r in PROPERTY_DF.head(250).iterrows():
        insp_rows.append(dict(
            inspection_id=f"INSP-{r['property_id']}",
            property_id=r["property_id"],
            agent_id="AGT-01",
            project_identifier="HMA-ELEV-2024",
            program_area="Flood Mitigation Assistance",
            property_action="Elevation Certificate Verification",
            structure_type="Single Family",
            foundation_type="Slab-on-Grade",
            damage_category="None",
            actual_amount_paid=450.0,
            number_of_properties=1,
            state=r["state"],
            county=r["county"],
            city=r["city"],
            zip_code=r["zip_code"],
            synthetic_property_key=r["synthetic_geo_key"]
        ))
    INSPECTION_DF = pd.DataFrame(insp_rows)

    # Dimensional Star-Schema Tables
    dim_comm_rows = [
        dict(
            community_key=i + 1,
            community_id_number=r["community_id"],
            community_name=r["community_name"],
            state=r["state"],
            participation_status="Regular",
            crs_class=int(r["class_rating"])
        )
        for i, r in COMMUNITY_DF.iterrows()
    ]
    DIM_COMMUNITY = pd.DataFrame(dim_comm_rows)

    date_range = pd.date_range("2020-01-01", "2026-12-31", freq="D")
    dim_date_rows = [
        dict(
            date_key=int(d.strftime("%Y%m%d")),
            full_date=d,
            day_of_week=d.weekday() + 1,
            day_name=d.strftime("%A"),
            day_of_month=d.day,
            month=d.month,
            month_name=d.strftime("%B"),
            quarter=d.quarter,
            year=d.year,
            fiscal_year=d.year if d.month >= 10 else d.year - 1,
            is_weekend=bool(d.weekday() >= 5)
        )
        for d in date_range[::14]  # bi-weekly sample to keep lightweight
    ]
    DIM_DATE = pd.DataFrame(dim_date_rows)

    dim_dis_rows = [
        dict(
            disaster_key=i + 1,
            disaster_number=int(r["disaster_number"]),
            fema_declaration_string=r["fema_declaration_string"],
            declaration_type="Major Disaster",
            declaration_title=r["declaration_title"],
            incident_type=r["incident_type"],
            declaration_date=pd.Timestamp(f"{2020 + i}-08-15"),
            incident_begin_date=pd.Timestamp(f"{2020 + i}-08-10"),
            incident_end_date=pd.Timestamp(f"{2020 + i}-08-20"),
            ih_program_declared=True,
            ia_program_declared=True,
            pa_program_declared=True,
            hm_program_declared=True
        )
        for i, r in DIS.iterrows()
    ]
    DIM_DISASTER_DECLARATION = pd.DataFrame(dim_dis_rows)

    dim_geo_rows = [
        dict(
            geography_key=i + 1,
            state=st_,
            fips_state_code=f"4{i:01d}",
            county_code=f"{48000 + i}",
            fips_county_code=f"48{i:03d}",
            region="Gulf Coast" if st_ in ["TX", "LA"] else "South Atlantic"
        )
        for i, (st_, _, _, _, _, _) in enumerate(GEO)
    ]
    DIM_GEOGRAPHY = pd.DataFrame(dim_geo_rows)

    dim_hma_rows = [
        dict(
            project_key=i + 1,
            project_identifier=f"PDMC-PL-{st_}-202{i}",
            program_area="Pre-Disaster Mitigation",
            project_type="Flood Elevation and Stormwater Management",
            status="Active",
            recipient=f"{st_} Division of Emergency Management",
            subrecipient=f"City of {city}",
            project_title=f"Regional Stormwater Resiliency - {city}"
        )
        for i, (st_, _, city, _, _, _) in enumerate(GEO)
    ]
    DIM_HMA_PROJECT = pd.DataFrame(dim_hma_rows)

    dim_prop_prof_rows = [
        dict(
            property_profile_key=i + 1,
            occupancy_type="Single Family Residence",
            flood_zone=zg,
            construction_date_band=cb,
            primary_residence_indicator=True,
            elevated_building_indicator=elev,
            condominium_indicator=False
        )
        for i, (zg, cb, elev) in enumerate([
            ("VE", "Pre-FIRM", False), ("VE", "Post-FIRM", True),
            ("AE", "Pre-FIRM", False), ("AE", "Post-FIRM", True),
            ("A", "Post-FIRM", False), ("X", "Post-FIRM", False),
            ("B", "Post-FIRM", False)
        ])
    ]
    DIM_PROPERTY_PROFILE = pd.DataFrame(dim_prop_prof_rows)

    # Fact Tables
    fact_dis_area_rows = [
        dict(
            declaration_area_key=i + 1,
            declaration_date_key=20240815,
            geography_key=1 + (i % len(DIM_GEOGRAPHY)),
            disaster_key=1 + (i % len(DIM_DISASTER_DECLARATION)),
            ih_program_declared=True,
            ia_program_declared=True,
            pa_program_declared=True,
            hm_program_declared=True,
            declaration_count=1
        )
        for i in range(12)
    ]
    FACT_DISASTER_DECLARATION_AREA = pd.DataFrame(fact_dis_area_rows)

    fact_hma_txn_rows = [
        dict(
            transaction_key=i + 1,
            obligated_date_key=20240601,
            geography_key=1 + (i % len(DIM_GEOGRAPHY)),
            project_key=1 + (i % len(DIM_HMA_PROJECT)),
            disaster_key=1 + (i % len(DIM_DISASTER_DECLARATION)),
            transaction_level="Project Award",
            obligated_amount=round(float(rng.uniform(1500000, 8500000)), 2),
            federal_share_obligated=round(float(rng.uniform(1100000, 6500000)), 2),
            transaction_count=1
        )
        for i in range(15)
    ]
    FACT_HMA_FINANCIAL_TRANSACTION = pd.DataFrame(fact_hma_txn_rows)

    fact_claim_rows = [
        dict(
            claim_key=i + 1,
            date_of_loss_key=int(pd.Timestamp(r["date_of_loss"]).strftime("%Y%m%d")),
            geography_key=1 + (i % len(DIM_GEOGRAPHY)),
            community_key=1 + (i % len(DIM_COMMUNITY)),
            property_profile_key=1 + (i % len(DIM_PROPERTY_PROFILE)),
            disaster_key=1 + (i % len(DIM_DISASTER_DECLARATION)),
            amount_paid_on_building_claim=float(r["amount_paid_on_building_claim"]),
            amount_paid_on_contents_claim=float(r["amount_paid_on_contents_claim"]),
            amount_paid_on_icc_claim=float(r["amount_paid_on_icc_claim"]),
            net_building_payment_amount=float(r["amount_paid_on_building_claim"]),
            net_contents_payment_amount=float(r["amount_paid_on_contents_claim"]),
            total_building_insurance_coverage=float(r["total_building_insurance_coverage"]),
            total_contents_insurance_coverage=float(r["total_contents_insurance_coverage"]),
            claim_count=1
        )
        for i, r in CLAIM_DF.head(300).iterrows()
    ]
    FACT_NFIP_CLAIM = pd.DataFrame(fact_claim_rows)

    fact_pol_rows = [
        dict(
            policy_key=i + 1,
            effective_date_key=int(pd.Timestamp(r["policy_effective_date"]).strftime("%Y%m%d")),
            expiration_date_key=int(pd.Timestamp(r["policy_termination_date"]).strftime("%Y%m%d")),
            geography_key=1 + (i % len(DIM_GEOGRAPHY)),
            community_key=1 + (i % len(DIM_COMMUNITY)),
            property_profile_key=1 + (i % len(DIM_PROPERTY_PROFILE)),
            total_building_insurance_coverage=float(r["total_building_insurance_coverage"]),
            total_contents_insurance_coverage=float(r["total_contents_insurance_coverage"]),
            total_insurance_premium=float(r["total_insurance_premium"]),
            hfiaa_surcharge=float(r["hfiaa_surcharge"]),
            federal_policy_fee=float(r["federal_policy_fee"]),
            policy_count=1
        )
        for i, r in POLICY_DF.head(500).iterrows()
    ]
    FACT_NFIP_POLICY = pd.DataFrame(fact_pol_rows)

    id_map_rows = [
        dict(entity="policy", uuid_value=f"uuid-{r['policy_id']}", seq=i + 1, display_id=r["policy_id"])
        for i, r in POLICY_DF.head(100).iterrows()
    ] + [
        dict(entity="claim", uuid_value=f"uuid-{r['claim_id']}", seq=i + 1, display_id=r["claim_id"])
        for i, r in CLAIM_DF.head(100).iterrows()
    ]
    ID_MAP_DF = pd.DataFrame(id_map_rows)

    return {
        # 1. Operational & Entity Tables
        "agent": AGENT_DF,
        "claim": CLAIM_DF,
        "community": COMMUNITY_DF,
        "coverage": COVERAGE_DF,
        "customer": CUSTOMER_DF,
        "document": DOCUMENT_DF,
        "inspection": INSPECTION_DF,
        "policy": POLICY_DF,
        "property": PROPERTY_DF,

        # 2. Dimensional Star-Schema Tables
        "dim_community": DIM_COMMUNITY,
        "dim_date": DIM_DATE,
        "dim_disaster_declaration": DIM_DISASTER_DECLARATION,
        "dim_geography": DIM_GEOGRAPHY,
        "dim_hma_project": DIM_HMA_PROJECT,
        "dim_property_profile": DIM_PROPERTY_PROFILE,
        "fact_disaster_declaration_area": FACT_DISASTER_DECLARATION_AREA,
        "fact_hma_financial_transaction": FACT_HMA_FINANCIAL_TRANSACTION,
        "fact_nfip_claim": FACT_NFIP_CLAIM,
        "fact_nfip_policy": FACT_NFIP_POLICY,

        # 3. Gold Aggregates & Reporting Tables
        "gold_claim_report": CL,
        "gold_claims_by_disaster": DIS,
        "gold_loss_ratio_by_state_year": LR_STATE_YEAR,
        "gold_mitigation_vs_claims_by_state": MIT,
        "gold_policy_report": PO,
        "gold_property_risk": PROP_RISK,
        "gold_risk_by_geography": GEO_RISK,

        # 4. Utility / Map
        "id_map": ID_MAP_DF,

        # Backwards-compatible aliases & operational profiles:
        "claim_report": CL,
        "policy_report": PO,
        "property_risk": PROP_RISK,
        "risk_by_geography": GEO_RISK,
        "loss_ratio_by_state_year": LR_STATE_YEAR,
        "claims_by_disaster": DIS,
        "mitigation_vs_claims_by_state": MIT,
        "customer_profile": C,
        "property_profile": P,
    }


def get():
    if not _cache:
        _cache.update(build())
    return _cache


def disasters():
    return get()["gold_claims_by_disaster"]
