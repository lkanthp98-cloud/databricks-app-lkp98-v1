-- Unity Catalog Setup Script for insurance_dev_gold.gold_schema
CREATE CATALOG IF NOT EXISTS insurance_dev_gold;
USE CATALOG insurance_dev_gold;
CREATE SCHEMA IF NOT EXISTS gold_schema;
USE SCHEMA gold_schema;

-- Table: gold_claim_report
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.gold_claim_report (
    claim_id STRING,
    policy_id STRING,
    state STRING,
    community_name STRING,
    date_of_loss TIMESTAMP,
    year_of_loss BIGINT,
    amount_paid_on_building_claim DOUBLE,
    amount_paid_on_contents_claim DOUBLE,
    amount_paid_on_icc_claim DOUBLE,
    total_building_insurance_coverage DOUBLE,
    total_contents_insurance_coverage DOUBLE,
    claim_id_uuid STRING,
    policy_id_uuid STRING
);

-- Sample seed data for gold_claim_report
INSERT INTO insurance_dev_gold.gold_schema.gold_claim_report VALUES
('CLM-2024-80001', 'POL-2024-77520-0001', 'TX', 'Baytown', '2024-09-12 00:00:00', 2024, 17250.0, 0.0, 0.0, 250000.0, 100000.0, 'uuid-CLM-2024-80001', 'uuid-POL-2024-77520-0001'),
('CLM-2026-80002', 'POL-2025-70001-0006', 'LA', 'Metairie', '2026-09-02 00:00:00', 2026, 0.0, 0.0, 0.0, 100000.0, 100000.0, 'uuid-CLM-2026-80002', 'uuid-POL-2025-70001-0006'),
('CLM-2020-80003', 'POL-2020-33101-0045', 'FL', 'Miami', '2020-11-20 00:00:00', 2020, 60200.0, 0.0, 0.0, 100000.0, 50000.0, 'uuid-CLM-2020-80003', 'uuid-POL-2020-33101-0045'),
('CLM-2025-80004', 'POL-2024-33101-0049', 'FL', 'Miami', '2025-08-02 00:00:00', 2025, 7830.0, 0.0, 0.0, 100000.0, 50000.0, 'uuid-CLM-2025-80004', 'uuid-POL-2024-33101-0049'),
('CLM-2026-80005', 'POL-2025-29577-0051', 'SC', 'Myrtle Beach', '2026-04-22 00:00:00', 2026, 7740.0, 0.0, 0.0, 350000.0, 100000.0, 'uuid-CLM-2026-80005', 'uuid-POL-2025-29577-0051'),
('CLM-2019-80006', 'POL-2019-33101-0053', 'FL', 'Miami', '2019-08-29 00:00:00', 2019, 10040.0, 0.0, 0.0, 100000.0, 25000.0, 'uuid-CLM-2019-80006', 'uuid-POL-2019-33101-0053'),
('CLM-2024-80007', 'POL-2024-33101-0101', 'FL', 'Miami', '2024-10-26 00:00:00', 2024, 14170.0, 0.0, 0.0, 150000.0, 75000.0, 'uuid-CLM-2024-80007', 'uuid-POL-2024-33101-0101'),
('CLM-2022-80008', 'POL-2021-29401-0113', 'SC', 'Charleston', '2022-01-06 00:00:00', 2022, 20350.0, 0.0, 0.0, 150000.0, 75000.0, 'uuid-CLM-2022-80008', 'uuid-POL-2021-29401-0113'),
('CLM-2024-80009', 'POL-2023-29401-0115', 'SC', 'Charleston', '2024-03-20 00:00:00', 2024, 14610.0, 0.0, 0.0, 150000.0, 75000.0, 'uuid-CLM-2024-80009', 'uuid-POL-2023-29401-0115'),
('CLM-2020-80010', 'POL-2020-33101-0121', 'FL', 'Miami', '2020-10-23 00:00:00', 2020, 9010.0, 0.0, 0.0, 200000.0, 50000.0, 'uuid-CLM-2020-80010', 'uuid-POL-2020-33101-0121'),
('CLM-2018-80011', 'POL-2018-77520-0129', 'TX', 'Baytown', '2018-06-01 00:00:00', 2018, 72390.0, 0.0, 0.0, 200000.0, 25000.0, 'uuid-CLM-2018-80011', 'uuid-POL-2018-77520-0129'),
('CLM-2021-80012', 'POL-2020-77520-0131', 'TX', 'Baytown', '2021-02-27 00:00:00', 2021, 30760.0, 0.0, 0.0, 200000.0, 25000.0, 'uuid-CLM-2021-80012', 'uuid-POL-2020-77520-0131'),
('CLM-2025-80013', 'POL-2024-77550-0149', 'TX', 'Galveston', '2025-03-12 00:00:00', 2025, 23110.0, 0.0, 0.0, 150000.0, 50000.0, 'uuid-CLM-2025-80013', 'uuid-POL-2024-77550-0149'),
('CLM-2025-80014', 'POL-2025-77550-0150', 'TX', 'Galveston', '2025-10-12 00:00:00', 2025, 22990.0, 0.0, 0.0, 150000.0, 50000.0, 'uuid-CLM-2025-80014', 'uuid-POL-2025-77550-0150'),
('CLM-2023-80015', 'POL-2023-33101-0153', 'FL', 'Miami', '2023-09-06 00:00:00', 2023, 26750.0, 0.0, 0.0, 150000.0, 100000.0, 'uuid-CLM-2023-80015', 'uuid-POL-2023-33101-0153'),
('CLM-2026-80016', 'POL-2026-33101-0158', 'FL', 'Miami', '2026-07-10 00:00:00', 2026, 0.0, 0.0, 0.0, 150000.0, 100000.0, 'uuid-CLM-2026-80016', 'uuid-POL-2026-33101-0158'),
('CLM-2025-80017', 'POL-2025-77520-0176', 'TX', 'Baytown', '2025-12-16 00:00:00', 2025, 5120.0, 0.0, 0.0, 150000.0, 50000.0, 'uuid-CLM-2025-80017', 'uuid-POL-2025-77520-0176'),
('CLM-2019-80018', 'POL-2018-33101-0177', 'FL', 'Miami', '2019-01-22 00:00:00', 2019, 3730.0, 0.0, 0.0, 100000.0, 100000.0, 'uuid-CLM-2019-80018', 'uuid-POL-2018-33101-0177'),
('CLM-2020-80019', 'POL-2019-33101-0178', 'FL', 'Miami', '2020-02-16 00:00:00', 2020, 25900.0, 0.0, 0.0, 100000.0, 100000.0, 'uuid-CLM-2020-80019', 'uuid-POL-2019-33101-0178'),
('CLM-2024-80020', 'POL-2023-33101-0182', 'FL', 'Miami', '2024-04-12 00:00:00', 2024, 6110.0, 0.0, 0.0, 100000.0, 100000.0, 'uuid-CLM-2024-80020', 'uuid-POL-2023-33101-0182'),
('CLM-2025-80021', 'POL-2025-70001-0186', 'LA', 'Metairie', '2025-07-25 00:00:00', 2025, 26830.0, 0.0, 0.0, 150000.0, 100000.0, 'uuid-CLM-2025-80021', 'uuid-POL-2025-70001-0186'),
('CLM-2025-80022', 'POL-2025-29401-0194', 'SC', 'Charleston', '2025-05-21 00:00:00', 2025, 7700.0, 0.0, 0.0, 250000.0, 50000.0, 'uuid-CLM-2025-80022', 'uuid-POL-2025-29401-0194'),
('CLM-2021-80023', 'POL-2020-70001-0213', 'LA', 'Metairie', '2021-05-16 00:00:00', 2021, 78240.0, 0.0, 0.0, 350000.0, 50000.0, 'uuid-CLM-2021-80023', 'uuid-POL-2020-70001-0213'),
('CLM-2024-80024', 'POL-2023-70001-0216', 'LA', 'Metairie', '2024-05-31 00:00:00', 2024, 4370.0, 0.0, 0.0, 350000.0, 50000.0, 'uuid-CLM-2024-80024', 'uuid-POL-2023-70001-0216'),
('CLM-2026-80025', 'POL-2025-70001-0218', 'LA', 'Metairie', '2026-02-11 00:00:00', 2026, 0.0, 0.0, 0.0, 350000.0, 50000.0, 'uuid-CLM-2026-80025', 'uuid-POL-2025-70001-0218');

-- Table: gold_policy_report
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.gold_policy_report (
    policy_id STRING,
    state STRING,
    county_code STRING,
    community_name STRING,
    policy_effective_date TIMESTAMP,
    policy_termination_date TIMESTAMP,
    total_building_insurance_coverage DOUBLE,
    total_contents_insurance_coverage DOUBLE,
    total_insurance_premium DOUBLE,
    policy_id_uuid STRING
);

-- Sample seed data for gold_policy_report
INSERT INTO insurance_dev_gold.gold_schema.gold_policy_report VALUES
('POL-2024-77520-0001', 'TX', '48000', 'Baytown', '2024-03-01 00:00:00', '2025-03-01 00:00:00', 250000.0, 100000.0, 1850.0, 'uuid-POL-2024-77520-0001'),
('POL-2025-77520-0002', 'TX', '48000', 'Baytown', '2025-03-01 00:00:00', '2026-03-01 00:00:00', 250000.0, 100000.0, 1868.5, 'uuid-POL-2025-77520-0002'),
('POL-2026-77520-0003', 'TX', '48000', 'Baytown', '2026-03-01 00:00:00', '2027-03-01 00:00:00', 250000.0, 100000.0, 1887.0, 'uuid-POL-2026-77520-0003'),
('POL-2023-70001-0004', 'LA', '48003', 'Metairie', '2023-10-26 00:00:00', '2024-10-26 00:00:00', 100000.0, 100000.0, 1897.0, 'uuid-POL-2023-70001-0004'),
('POL-2024-70001-0005', 'LA', '48003', 'Metairie', '2024-10-26 00:00:00', '2025-10-26 00:00:00', 100000.0, 100000.0, 1915.97, 'uuid-POL-2024-70001-0005'),
('POL-2025-70001-0006', 'LA', '48003', 'Metairie', '2025-10-26 00:00:00', '2026-10-26 00:00:00', 100000.0, 100000.0, 1934.94, 'uuid-POL-2025-70001-0006'),
('POL-2019-29401-0007', 'SC', '48010', 'Charleston', '2019-04-19 00:00:00', '2020-04-19 00:00:00', 250000.0, 50000.0, 825.0, 'uuid-POL-2019-29401-0007'),
('POL-2020-29401-0008', 'SC', '48010', 'Charleston', '2020-04-19 00:00:00', '2021-04-19 00:00:00', 250000.0, 50000.0, 833.25, 'uuid-POL-2020-29401-0008'),
('POL-2021-29401-0009', 'SC', '48010', 'Charleston', '2021-04-19 00:00:00', '2022-04-19 00:00:00', 250000.0, 50000.0, 841.5, 'uuid-POL-2021-29401-0009'),
('POL-2022-29401-0010', 'SC', '48010', 'Charleston', '2022-04-19 00:00:00', '2023-04-19 00:00:00', 250000.0, 50000.0, 849.75, 'uuid-POL-2022-29401-0010'),
('POL-2023-29401-0011', 'SC', '48010', 'Charleston', '2023-04-19 00:00:00', '2024-04-19 00:00:00', 250000.0, 50000.0, 858.0, 'uuid-POL-2023-29401-0011'),
('POL-2024-29401-0012', 'SC', '48010', 'Charleston', '2024-04-19 00:00:00', '2025-04-19 00:00:00', 250000.0, 50000.0, 866.25, 'uuid-POL-2024-29401-0012'),
('POL-2025-29401-0013', 'SC', '48010', 'Charleston', '2025-04-19 00:00:00', '2026-04-19 00:00:00', 250000.0, 50000.0, 874.5, 'uuid-POL-2025-29401-0013'),
('POL-2026-29401-0014', 'SC', '48010', 'Charleston', '2026-04-19 00:00:00', '2027-04-19 00:00:00', 250000.0, 50000.0, 882.75, 'uuid-POL-2026-29401-0014'),
('POL-2019-27959-0015', 'NC', '48009', 'Nags Head', '2019-04-29 00:00:00', '2020-04-29 00:00:00', 350000.0, 100000.0, 3712.0, 'uuid-POL-2019-27959-0015'),
('POL-2020-27959-0016', 'NC', '48009', 'Nags Head', '2020-04-29 00:00:00', '2021-04-29 00:00:00', 350000.0, 100000.0, 3749.12, 'uuid-POL-2020-27959-0016'),
('POL-2021-27959-0017', 'NC', '48009', 'Nags Head', '2021-04-29 00:00:00', '2022-04-29 00:00:00', 350000.0, 100000.0, 3786.24, 'uuid-POL-2021-27959-0017'),
('POL-2022-27959-0018', 'NC', '48009', 'Nags Head', '2022-04-29 00:00:00', '2023-04-29 00:00:00', 350000.0, 100000.0, 3823.36, 'uuid-POL-2022-27959-0018'),
('POL-2023-27959-0019', 'NC', '48009', 'Nags Head', '2023-04-29 00:00:00', '2024-04-29 00:00:00', 350000.0, 100000.0, 3860.48, 'uuid-POL-2023-27959-0019'),
('POL-2024-27959-0020', 'NC', '48009', 'Nags Head', '2024-04-29 00:00:00', '2025-04-29 00:00:00', 350000.0, 100000.0, 3897.6, 'uuid-POL-2024-27959-0020'),
('POL-2025-27959-0021', 'NC', '48009', 'Nags Head', '2025-04-29 00:00:00', '2026-04-29 00:00:00', 350000.0, 100000.0, 3934.72, 'uuid-POL-2025-27959-0021'),
('POL-2026-27959-0022', 'NC', '48009', 'Nags Head', '2026-04-29 00:00:00', '2027-04-29 00:00:00', 350000.0, 100000.0, 3971.84, 'uuid-POL-2026-27959-0022'),
('POL-2019-77520-0023', 'TX', '48000', 'Baytown', '2019-05-06 00:00:00', '2020-05-06 00:00:00', 150000.0, 100000.0, 791.0, 'uuid-POL-2019-77520-0023'),
('POL-2020-77520-0024', 'TX', '48000', 'Baytown', '2020-05-06 00:00:00', '2021-05-06 00:00:00', 150000.0, 100000.0, 798.91, 'uuid-POL-2020-77520-0024'),
('POL-2021-77520-0025', 'TX', '48000', 'Baytown', '2021-05-06 00:00:00', '2022-05-06 00:00:00', 150000.0, 100000.0, 806.82, 'uuid-POL-2021-77520-0025');

-- Table: gold_property_risk
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.gold_property_risk (
    state STRING,
    zone_group STRING,
    construction_date_band STRING,
    elevated BOOLEAN,
    region STRING,
    data_status STRING,
    policy_count BIGINT,
    claim_count BIGINT,
    claims_paid DOUBLE,
    premium DOUBLE,
    coverage_total DOUBLE,
    loss_ratio DOUBLE,
    claim_frequency DOUBLE,
    avg_claim_paid DOUBLE,
    declared_disasters BIGINT,
    hma_projects BIGINT,
    loss_component DOUBLE,
    hazard_component DOUBLE,
    property_component DOUBLE,
    protection_component DOUBLE,
    credibility DOUBLE,
    risk_score DOUBLE,
    risk_band STRING,
    top_driver STRING,
    window_start_year BIGINT,
    window_end_year BIGINT,
    _built_at STRING
);

-- Sample seed data for gold_property_risk
INSERT INTO insurance_dev_gold.gold_schema.gold_property_risk VALUES
('TX', 'VE', 'Pre-FIRM', True, 'Gulf Coast', 'ACTIVE', 144, 28, 870413.04, 411264.0, 46080000.0, 2.1164, 0.1944, 31086.18, 6, 5, 84.66, 24.8, 15.0, -8.0, 0.96, 67.6, 'High', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'VE', 'Pre-FIRM', False, 'Gulf Coast', 'ACTIVE', 57, 17, 719104.59, 191520.0, 18240000.0, 3.7547, 0.2982, 42300.27, 6, 28, 150.19, 24.8, 15.0, 0.0, 0.38, 69.9, 'High', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'VE', 'Post-FIRM', True, 'Gulf Coast', 'ACTIVE', 206, 25, 895768.75, 490280.0, 65920000.0, 1.8271, 0.1214, 35830.75, 3, 16, 73.08, 24.8, 5.0, -8.0, 1.0, 52.8, 'Medium', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'VE', 'Post-FIRM', False, 'Gulf Coast', 'ACTIVE', 75, 14, 302129.66, 210000.0, 24000000.0, 1.4387, 0.1867, 21580.69, 2, 21, 57.55, 24.8, 5.0, 0.0, 0.5, 65.6, 'Medium', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'AE', 'Pre-FIRM', True, 'Gulf Coast', 'ACTIVE', 89, 17, 584572.37, 172482.0, 28480000.0, 3.3892, 0.191, 34386.61, 3, 29, 135.57, 20.0, 15.0, -8.0, 0.59, 51.1, 'Medium', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'AE', 'Pre-FIRM', False, 'Gulf Coast', 'ACTIVE', 164, 51, 2001725.01, 373920.0, 52480000.0, 5.3534, 0.311, 39249.51, 5, 29, 214.14, 20.0, 15.0, 0.0, 1.0, 64.0, 'Medium', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'AE', 'Post-FIRM', True, 'Gulf Coast', 'ACTIVE', 210, 25, 487495.5, 339150.0, 67200000.0, 1.4374, 0.119, 19499.82, 4, 11, 57.5, 20.0, 5.0, -8.0, 1.0, 39.9, 'Medium', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'AE', 'Post-FIRM', False, 'Gulf Coast', 'ACTIVE', 137, 26, 632087.56, 260300.0, 43840000.0, 2.4283, 0.1898, 24311.06, 2, 20, 97.13, 20.0, 5.0, 0.0, 0.91, 46.4, 'Medium', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'A', 'Pre-FIRM', True, 'Gulf Coast', 'ACTIVE', 125, 9, 227556.72, 140250.0, 40000000.0, 1.6225, 0.072, 25284.08, 3, 29, 64.9, 17.6, 15.0, -8.0, 0.83, 50.6, 'Medium', 'Pre-FIRM Structure', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'A', 'Pre-FIRM', False, 'Gulf Coast', 'ACTIVE', 188, 21, 506002.98, 248160.0, 60160000.0, 2.039, 0.1117, 24095.38, 6, 16, 81.56, 17.6, 15.0, 0.0, 1.0, 42.0, 'Medium', 'Pre-FIRM Structure', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'A', 'Post-FIRM', True, 'Gulf Coast', 'ACTIVE', 223, 9, 172037.97, 208505.0, 71360000.0, 0.8251, 0.0404, 19115.33, 5, 26, 33.0, 17.6, 5.0, -8.0, 1.0, 32.6, 'Low', 'Elevation Deficit', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'A', 'Post-FIRM', False, 'Gulf Coast', 'ACTIVE', 179, 12, 394848.24, 196900.0, 57280000.0, 2.0053, 0.067, 32904.02, 4, 11, 80.21, 17.6, 5.0, 0.0, 1.0, 41.6, 'Medium', 'Elevation Deficit', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'B', 'Pre-FIRM', True, 'Gulf Coast', 'ACTIVE', 142, 10, 311956.0, 159324.0, 45440000.0, 1.958, 0.0704, 31195.6, 2, 5, 78.32, 8.8, 15.0, -8.0, 0.95, 28.7, 'Low', 'Pre-FIRM Structure', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'B', 'Pre-FIRM', False, 'Gulf Coast', 'ACTIVE', 201, 22, 948908.4, 265320.0, 64320000.0, 3.5765, 0.1095, 43132.2, 3, 11, 143.06, 8.8, 15.0, 0.0, 1.0, 33.0, 'Medium', 'Pre-FIRM Structure', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'B', 'Post-FIRM', True, 'Gulf Coast', 'ACTIVE', 111, 4, 181512.24, 103785.0, 35520000.0, 1.7489, 0.036, 45378.06, 2, 11, 69.96, 8.8, 5.0, -8.0, 0.74, 13.7, 'Low', 'Elevation Deficit', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'B', 'Post-FIRM', False, 'Gulf Coast', 'ACTIVE', 168, 11, 505809.81, 184800.0, 53760000.0, 2.7371, 0.0655, 45982.71, 4, 26, 109.48, 8.8, 5.0, 0.0, 1.0, 15.3, 'Low', 'Elevation Deficit', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'X', 'Pre-FIRM', True, 'Gulf Coast', 'ACTIVE', 54, 3, 68452.89, 60588.0, 17280000.0, 1.1298, 0.0556, 22817.63, 2, 24, 45.19, 6.0, 15.0, -8.0, 0.36, 19.8, 'Low', 'Pre-FIRM Structure', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'X', 'Pre-FIRM', False, 'Gulf Coast', 'ACTIVE', 217, 24, 835178.64, 286440.0, 69440000.0, 2.9157, 0.1106, 34799.11, 6, 10, 116.63, 6.0, 15.0, 0.0, 1.0, 26.0, 'Low', 'Pre-FIRM Structure', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'X', 'Post-FIRM', True, 'Gulf Coast', 'ACTIVE', 225, 10, 401328.0, 210375.0, 72000000.0, 1.9077, 0.0444, 40132.8, 6, 19, 76.31, 6.0, 5.0, -8.0, 1.0, 6.9, 'Low', 'Elevation Deficit', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'X', 'Post-FIRM', False, 'Gulf Coast', 'ACTIVE', 239, 16, 356704.48, 262900.0, 76480000.0, 1.3568, 0.0669, 22294.03, 4, 19, 54.27, 6.0, 5.0, 0.0, 1.0, 13.8, 'Low', 'Elevation Deficit', 2018, 2025, '2026-10-13 12:00:00'),
('FL', 'VE', 'Pre-FIRM', True, 'South Atlantic', 'ACTIVE', 60, 12, 369649.56, 171360.0, 19200000.0, 2.1572, 0.2, 30804.13, 2, 28, 86.29, 24.8, 15.0, -8.0, 0.4, 60.9, 'Medium', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('FL', 'VE', 'Pre-FIRM', False, 'South Atlantic', 'ACTIVE', 236, 74, 1753971.68, 792960.0, 75520000.0, 2.2119, 0.3136, 23702.32, 2, 11, 88.48, 24.8, 15.0, 0.0, 1.0, 74.2, 'High', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('FL', 'VE', 'Post-FIRM', True, 'South Atlantic', 'ACTIVE', 165, 20, 601440.4, 392700.0, 52800000.0, 1.5316, 0.1212, 30072.02, 4, 15, 61.26, 24.8, 5.0, -8.0, 1.0, 51.5, 'Medium', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('FL', 'VE', 'Post-FIRM', False, 'South Atlantic', 'ACTIVE', 94, 18, 413165.16, 263200.0, 30080000.0, 1.5698, 0.1915, 22953.62, 5, 5, 62.79, 24.8, 5.0, 0.0, 0.63, 61.1, 'Medium', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('FL', 'AE', 'Pre-FIRM', True, 'South Atlantic', 'ACTIVE', 166, 33, 1461038.7, 321708.0, 53120000.0, 4.5415, 0.1988, 44273.9, 2, 18, 181.66, 20.0, 15.0, -8.0, 1.0, 51.6, 'Medium', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00');

-- Table: gold_risk_by_geography
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.gold_risk_by_geography (
    state STRING,
    region STRING,
    policy_count BIGINT,
    claim_count BIGINT,
    claims_paid DOUBLE,
    premium DOUBLE,
    declared_disasters BIGINT,
    hma_projects BIGINT,
    high_risk_segments BIGINT,
    segments BIGINT,
    risk_score DOUBLE,
    loss_ratio DOUBLE,
    risk_band STRING
);

-- Sample seed data for gold_risk_by_geography
INSERT INTO insurance_dev_gold.gold_schema.gold_risk_by_geography VALUES
('TX', 'Gulf Coast', 3154, 354, 11403592.850000001, 4776263.0, 6, 366, 2, 20, 39.1, 2.3876, 'Medium'),
('FL', 'South Atlantic', 3138, 431, 13127734.24, 5233672.0, 6, 356, 1, 20, 38.8, 2.5083, 'Medium'),
('LA', 'Gulf Coast', 2885, 335, 11194578.540000001, 4632072.0, 6, 368, 1, 20, 39.6, 2.4168, 'Medium'),
('NC', 'South Atlantic', 2806, 390, 14051751.519999998, 4849061.0, 6, 355, 1, 20, 39.1, 2.8978, 'Medium'),
('SC', 'South Atlantic', 3283, 401, 13931417.67, 5165473.0, 6, 357, 1, 20, 39.3, 2.697, 'Medium');

-- Table: gold_loss_ratio_by_state_year
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.gold_loss_ratio_by_state_year (
    state STRING,
    year BIGINT,
    total_premium DOUBLE,
    claim_count BIGINT,
    total_paid DOUBLE,
    loss_ratio DOUBLE,
    data_status STRING
);

-- Sample seed data for gold_loss_ratio_by_state_year
INSERT INTO insurance_dev_gold.gold_schema.gold_loss_ratio_by_state_year VALUES
('TX', 2021, 322089.55999999994, 17, 547960.0, 1.7013, 'FINALIZED'),
('TX', 2022, 366987.91, 15, 314730.0, 0.8576, 'FINALIZED'),
('TX', 2023, 443370.65, 19, 436820.0, 0.9852, 'FINALIZED'),
('TX', 2024, 514453.45, 26, 696750.0, 1.3543, 'FINALIZED'),
('TX', 2025, 575654.03, 32, 751260.0, 1.3051, 'FINALIZED'),
('TX', 2026, 434059.47000000003, 23, 509750.0, 1.1744, 'DEVELOPING'),
('FL', 2021, 353969.99, 11, 261010.0, 0.7374, 'FINALIZED'),
('FL', 2022, 405857.52999999997, 17, 269640.0, 0.6644, 'FINALIZED'),
('FL', 2023, 531080.19, 22, 482650.0, 0.9088, 'FINALIZED'),
('FL', 2024, 592799.48, 30, 575830.0, 0.9714, 'FINALIZED'),
('FL', 2025, 667417.24, 23, 442980.0, 0.6637, 'FINALIZED'),
('FL', 2026, 520634.74, 22, 277630.0, 0.5333, 'DEVELOPING'),
('LA', 2021, 158174.66000000003, 8, 207030.0, 1.3089, 'FINALIZED'),
('LA', 2022, 191043.93999999997, 5, 73070.0, 0.3825, 'FINALIZED'),
('LA', 2023, 226664.37, 5, 234220.0, 1.0333, 'FINALIZED'),
('LA', 2024, 260550.33, 11, 410640.0, 1.576, 'FINALIZED'),
('LA', 2025, 294306.1, 13, 251520.0, 0.8546, 'FINALIZED'),
('LA', 2026, 236571.63, 6, 9120.0, 0.0386, 'DEVELOPING'),
('NC', 2021, 142164.52000000002, 6, 172150.0, 1.2109, 'FINALIZED'),
('NC', 2022, 163223.68000000002, 9, 117500.0, 0.7199, 'FINALIZED'),
('NC', 2023, 177806.5, 6, 55050.0, 0.3096, 'FINALIZED'),
('NC', 2024, 202439.25, 7, 197600.0, 0.9761, 'FINALIZED'),
('NC', 2025, 225232.13000000003, 7, 127660.0, 0.5668, 'FINALIZED'),
('NC', 2026, 179354.89000000004, 11, 166700.0, 0.9294, 'DEVELOPING'),
('SC', 2021, 135942.68999999997, 6, 195080.0, 1.435, 'FINALIZED');

-- Table: gold_claims_by_disaster
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.gold_claims_by_disaster (
    disaster_number BIGINT,
    fema_declaration_string STRING,
    declaration_title STRING,
    incident_type STRING,
    claim_count BIGINT,
    total_paid DOUBLE
);

-- Sample seed data for gold_claims_by_disaster
INSERT INTO insurance_dev_gold.gold_schema.gold_claims_by_disaster VALUES
(4520, 'DR-4520-TX', 'Hurricane Laura', 'Hurricane', 620, 22400000.0),
(4611, 'DR-4611-LA', 'Hurricane Ida', 'Hurricane', 740, 31800000.0),
(4673, 'DR-4673-FL', 'Hurricane Ian', 'Hurricane', 980, 46500000.0),
(4712, 'DR-4712-NC', 'Tropical Storm Debby', 'Tropical Storm', 180, 4800000.0),
(4735, 'DR-4735-SC', 'Coastal Surge and Flooding', 'Flood', 230, 6200000.0),
(4789, 'DR-4789-TX', 'Gulf Coast Severe Storms', 'Severe Storm', 190, 3900000.0);

-- Table: gold_mitigation_vs_claims_by_state
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.gold_mitigation_vs_claims_by_state (
    state STRING,
    total_mitigation_spend DOUBLE,
    total_claims_paid DOUBLE
);

-- Sample seed data for gold_mitigation_vs_claims_by_state
INSERT INTO insurance_dev_gold.gold_schema.gold_mitigation_vs_claims_by_state VALUES
('TX', 1055396.56, 3257270.0),
('FL', 975296.03, 2309740.0),
('LA', 376806.7, 1185600.0),
('NC', 318727.96, 836660.0),
('SC', 342824.67, 999650.0);

