-- Unity Catalog Setup Script for insurance_dev_gold.gold_schema
CREATE CATALOG IF NOT EXISTS insurance_dev_gold;
USE CATALOG insurance_dev_gold;
CREATE SCHEMA IF NOT EXISTS gold_schema;
USE SCHEMA gold_schema;

-- Table: agent
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.agent (
    agent_id STRING,
    agent_name STRING,
    state STRING
);

-- Sample seed data for agent
INSERT INTO insurance_dev_gold.gold_schema.agent VALUES
('AGT-01', 'Hannah Brooks', 'TX'),
('AGT-02', 'Luis Ortega', 'FL'),
('AGT-03', 'Aisha Rahman', 'TX'),
('AGT-04', 'Tom Becker', 'FL'),
('AGT-05', 'Mei Lin', 'TX');

-- Table: claim
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.claim (
    claim_id STRING,
    policy_id STRING,
    community_id STRING,
    date_of_loss TIMESTAMP,
    year_of_loss BIGINT,
    state STRING,
    county_code STRING,
    amount_paid_on_building_claim DOUBLE,
    amount_paid_on_contents_claim DOUBLE,
    amount_paid_on_icc_claim DOUBLE,
    total_building_insurance_coverage DOUBLE,
    total_contents_insurance_coverage DOUBLE,
    occupancy_type STRING,
    rated_flood_zone STRING,
    primary_residence_indicator BOOLEAN,
    elevated_building_indicator BOOLEAN,
    synthetic_policy_key STRING
);

-- Sample seed data for claim
INSERT INTO insurance_dev_gold.gold_schema.claim VALUES
('CLM-2024-80001', 'POL-2024-77520-0001', 'COM-48009', '2024-09-12 00:00:00', 2024, 'TX', 'TX-001', 17250.0, 0.0, 0.0, 250000.0, 100000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2024-77520-0001'),
('CLM-2026-80002', 'POL-2025-70001-0006', 'COM-48010', '2026-09-02 00:00:00', 2026, 'LA', 'LA-001', 0.0, 0.0, 0.0, 100000.0, 100000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2025-70001-0006'),
('CLM-2020-80003', 'POL-2020-33101-0045', 'COM-48001', '2020-11-20 00:00:00', 2020, 'FL', 'FL-001', 60200.0, 0.0, 0.0, 100000.0, 50000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2020-33101-0045'),
('CLM-2025-80004', 'POL-2024-33101-0049', 'COM-48003', '2025-08-02 00:00:00', 2025, 'FL', 'FL-001', 7830.0, 0.0, 0.0, 100000.0, 50000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2024-33101-0049'),
('CLM-2026-80005', 'POL-2025-29577-0051', 'COM-48002', '2026-04-22 00:00:00', 2026, 'SC', 'SC-001', 7740.0, 0.0, 0.0, 350000.0, 100000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2025-29577-0051'),
('CLM-2019-80006', 'POL-2019-33101-0053', 'COM-48005', '2019-08-29 00:00:00', 2019, 'FL', 'FL-001', 10040.0, 0.0, 0.0, 100000.0, 25000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2019-33101-0053'),
('CLM-2024-80007', 'POL-2024-33101-0101', 'COM-48000', '2024-10-26 00:00:00', 2024, 'FL', 'FL-001', 14170.0, 0.0, 0.0, 150000.0, 75000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2024-33101-0101'),
('CLM-2022-80008', 'POL-2021-29401-0113', 'COM-48010', '2022-01-06 00:00:00', 2022, 'SC', 'SC-001', 20350.0, 0.0, 0.0, 150000.0, 75000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2021-29401-0113'),
('CLM-2024-80009', 'POL-2023-29401-0115', 'COM-48011', '2024-03-20 00:00:00', 2024, 'SC', 'SC-001', 14610.0, 0.0, 0.0, 150000.0, 75000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2023-29401-0115'),
('CLM-2020-80010', 'POL-2020-33101-0121', 'COM-48009', '2020-10-23 00:00:00', 2020, 'FL', 'FL-001', 9010.0, 0.0, 0.0, 200000.0, 50000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2020-33101-0121'),
('CLM-2018-80011', 'POL-2018-77520-0129', 'COM-48009', '2018-06-01 00:00:00', 2018, 'TX', 'TX-001', 72390.0, 0.0, 0.0, 200000.0, 25000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2018-77520-0129'),
('CLM-2021-80012', 'POL-2020-77520-0131', 'COM-48004', '2021-02-27 00:00:00', 2021, 'TX', 'TX-001', 30760.0, 0.0, 0.0, 200000.0, 25000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2020-77520-0131'),
('CLM-2025-80013', 'POL-2024-77550-0149', 'COM-48011', '2025-03-12 00:00:00', 2025, 'TX', 'TX-001', 23110.0, 0.0, 0.0, 150000.0, 50000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2024-77550-0149'),
('CLM-2025-80014', 'POL-2025-77550-0150', 'COM-48006', '2025-10-12 00:00:00', 2025, 'TX', 'TX-001', 22990.0, 0.0, 0.0, 150000.0, 50000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2025-77550-0150'),
('CLM-2023-80015', 'POL-2023-33101-0153', 'COM-48004', '2023-09-06 00:00:00', 2023, 'FL', 'FL-001', 26750.0, 0.0, 0.0, 150000.0, 100000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2023-33101-0153'),
('CLM-2026-80016', 'POL-2026-33101-0158', 'COM-48007', '2026-07-10 00:00:00', 2026, 'FL', 'FL-001', 0.0, 0.0, 0.0, 150000.0, 100000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2026-33101-0158'),
('CLM-2025-80017', 'POL-2025-77520-0176', 'COM-48008', '2025-12-16 00:00:00', 2025, 'TX', 'TX-001', 5120.0, 0.0, 0.0, 150000.0, 50000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2025-77520-0176'),
('CLM-2019-80018', 'POL-2018-33101-0177', 'COM-48011', '2019-01-22 00:00:00', 2019, 'FL', 'FL-001', 3730.0, 0.0, 0.0, 100000.0, 100000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2018-33101-0177'),
('CLM-2020-80019', 'POL-2019-33101-0178', 'COM-48004', '2020-02-16 00:00:00', 2020, 'FL', 'FL-001', 25900.0, 0.0, 0.0, 100000.0, 100000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2019-33101-0178'),
('CLM-2024-80020', 'POL-2023-33101-0182', 'COM-48006', '2024-04-12 00:00:00', 2024, 'FL', 'FL-001', 6110.0, 0.0, 0.0, 100000.0, 100000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2023-33101-0182'),
('CLM-2025-80021', 'POL-2025-70001-0186', 'COM-48002', '2025-07-25 00:00:00', 2025, 'LA', 'LA-001', 26830.0, 0.0, 0.0, 150000.0, 100000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2025-70001-0186'),
('CLM-2025-80022', 'POL-2025-29401-0194', 'COM-48003', '2025-05-21 00:00:00', 2025, 'SC', 'SC-001', 7700.0, 0.0, 0.0, 250000.0, 50000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2025-29401-0194'),
('CLM-2021-80023', 'POL-2020-70001-0213', 'COM-48000', '2021-05-16 00:00:00', 2021, 'LA', 'LA-001', 78240.0, 0.0, 0.0, 350000.0, 50000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2020-70001-0213'),
('CLM-2024-80024', 'POL-2023-70001-0216', 'COM-48001', '2024-05-31 00:00:00', 2024, 'LA', 'LA-001', 4370.0, 0.0, 0.0, 350000.0, 50000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2023-70001-0216'),
('CLM-2026-80025', 'POL-2025-70001-0218', 'COM-48005', '2026-02-11 00:00:00', 2026, 'LA', 'LA-001', 0.0, 0.0, 0.0, 350000.0, 50000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2025-70001-0218');

-- Table: community
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.community (
    community_id STRING,
    community_name STRING,
    county STRING,
    state STRING,
    participating_in_nfip BOOLEAN,
    tribal BOOLEAN,
    class_rating BIGINT,
    sfha_discount DOUBLE,
    non_sfha_discount DOUBLE,
    sanction STRING
);

-- Sample seed data for community
INSERT INTO insurance_dev_gold.gold_schema.community VALUES
('COM-48000', 'Baytown', 'Harris', 'TX', True, False, 7, 0.15, 0.05, 'NONE'),
('COM-48001', 'Galveston', 'Galveston', 'TX', True, False, 6, 0.2, 0.1, 'NONE'),
('COM-48002', 'Freeport', 'Brazoria', 'TX', True, False, 7, 0.15, 0.05, 'NONE'),
('COM-48003', 'Metairie', 'Jefferson', 'LA', True, False, 8, 0.2, 0.1, 'NONE'),
('COM-48004', 'New Orleans', 'Orleans', 'LA', True, False, 8, 0.15, 0.05, 'NONE'),
('COM-48005', 'Miami', 'Miami-Dade', 'FL', True, False, 7, 0.2, 0.1, 'NONE'),
('COM-48006', 'Fort Myers', 'Lee', 'FL', True, False, 6, 0.15, 0.05, 'NONE'),
('COM-48007', 'Tampa', 'Hillsborough', 'FL', True, False, 7, 0.2, 0.1, 'NONE'),
('COM-48008', 'Wilmington', 'New Hanover', 'NC', True, False, 8, 0.15, 0.05, 'NONE'),
('COM-48009', 'Nags Head', 'Dare', 'NC', True, False, 8, 0.2, 0.1, 'NONE'),
('COM-48010', 'Charleston', 'Charleston', 'SC', True, False, 7, 0.15, 0.05, 'NONE'),
('COM-48011', 'Myrtle Beach', 'Horry', 'SC', True, False, 6, 0.2, 0.1, 'NONE');

-- Table: coverage
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.coverage (
    coverage_id STRING,
    policy_id STRING,
    coverage_type STRING,
    coverage_amount DOUBLE
);

-- Sample seed data for coverage
INSERT INTO insurance_dev_gold.gold_schema.coverage VALUES
('COV-B-POL-2024-77520-0001', 'POL-2024-77520-0001', 'BUILDING', 250000.0),
('COV-C-POL-2024-77520-0001', 'POL-2024-77520-0001', 'CONTENTS', 100000.0),
('COV-B-POL-2025-77520-0002', 'POL-2025-77520-0002', 'BUILDING', 250000.0),
('COV-C-POL-2025-77520-0002', 'POL-2025-77520-0002', 'CONTENTS', 100000.0),
('COV-B-POL-2026-77520-0003', 'POL-2026-77520-0003', 'BUILDING', 250000.0),
('COV-C-POL-2026-77520-0003', 'POL-2026-77520-0003', 'CONTENTS', 100000.0),
('COV-B-POL-2023-70001-0004', 'POL-2023-70001-0004', 'BUILDING', 100000.0),
('COV-C-POL-2023-70001-0004', 'POL-2023-70001-0004', 'CONTENTS', 100000.0),
('COV-B-POL-2024-70001-0005', 'POL-2024-70001-0005', 'BUILDING', 100000.0),
('COV-C-POL-2024-70001-0005', 'POL-2024-70001-0005', 'CONTENTS', 100000.0),
('COV-B-POL-2025-70001-0006', 'POL-2025-70001-0006', 'BUILDING', 100000.0),
('COV-C-POL-2025-70001-0006', 'POL-2025-70001-0006', 'CONTENTS', 100000.0),
('COV-B-POL-2019-29401-0007', 'POL-2019-29401-0007', 'BUILDING', 250000.0),
('COV-C-POL-2019-29401-0007', 'POL-2019-29401-0007', 'CONTENTS', 50000.0),
('COV-B-POL-2020-29401-0008', 'POL-2020-29401-0008', 'BUILDING', 250000.0),
('COV-C-POL-2020-29401-0008', 'POL-2020-29401-0008', 'CONTENTS', 50000.0),
('COV-B-POL-2021-29401-0009', 'POL-2021-29401-0009', 'BUILDING', 250000.0),
('COV-C-POL-2021-29401-0009', 'POL-2021-29401-0009', 'CONTENTS', 50000.0),
('COV-B-POL-2022-29401-0010', 'POL-2022-29401-0010', 'BUILDING', 250000.0),
('COV-C-POL-2022-29401-0010', 'POL-2022-29401-0010', 'CONTENTS', 50000.0),
('COV-B-POL-2023-29401-0011', 'POL-2023-29401-0011', 'BUILDING', 250000.0),
('COV-C-POL-2023-29401-0011', 'POL-2023-29401-0011', 'CONTENTS', 50000.0),
('COV-B-POL-2024-29401-0012', 'POL-2024-29401-0012', 'BUILDING', 250000.0),
('COV-C-POL-2024-29401-0012', 'POL-2024-29401-0012', 'CONTENTS', 50000.0),
('COV-B-POL-2025-29401-0013', 'POL-2025-29401-0013', 'BUILDING', 250000.0);

-- Table: customer
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.customer (
    customer_id STRING,
    state STRING,
    county_code STRING,
    community_id STRING
);

-- Sample seed data for customer
INSERT INTO insurance_dev_gold.gold_schema.customer VALUES
('CUST-10492', 'TX', 'Harris', 'COM-48001'),
('CUST-20000', 'LA', 'Jefferson', 'COM-48000'),
('CUST-20001', 'NC', 'Dare', 'COM-48011'),
('CUST-20002', 'NC', 'New Hanover', 'COM-48000'),
('CUST-20003', 'LA', 'Orleans', 'COM-48005'),
('CUST-20004', 'NC', 'New Hanover', 'COM-48007'),
('CUST-20005', 'FL', 'Miami-Dade', 'COM-48009'),
('CUST-20006', 'SC', 'Horry', 'COM-48010'),
('CUST-20007', 'FL', 'Miami-Dade', 'COM-48011'),
('CUST-20008', 'FL', 'Miami-Dade', 'COM-48011'),
('CUST-20009', 'FL', 'Lee', 'COM-48003'),
('CUST-20010', 'TX', 'Harris', 'COM-48001'),
('CUST-20011', 'FL', 'Miami-Dade', 'COM-48011'),
('CUST-20012', 'TX', 'Brazoria', 'COM-48009'),
('CUST-20013', 'FL', 'Miami-Dade', 'COM-48000'),
('CUST-20014', 'SC', 'Charleston', 'COM-48004'),
('CUST-20015', 'SC', 'Charleston', 'COM-48007'),
('CUST-20016', 'FL', 'Miami-Dade', 'COM-48010'),
('CUST-20017', 'SC', 'Charleston', 'COM-48007'),
('CUST-20018', 'SC', 'Charleston', 'COM-48005'),
('CUST-20019', 'FL', 'Miami-Dade', 'COM-48003'),
('CUST-20020', 'FL', 'Miami-Dade', 'COM-48008'),
('CUST-20021', 'SC', 'Horry', 'COM-48010'),
('CUST-20022', 'FL', 'Miami-Dade', 'COM-48002'),
('CUST-20023', 'LA', 'Jefferson', 'COM-48001');

-- Table: document
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.document (
    document_id STRING,
    claim_id STRING,
    document_type STRING,
    created_date TIMESTAMP
);

-- Sample seed data for document
INSERT INTO insurance_dev_gold.gold_schema.document VALUES
('DOC-FNOL-CLM-2024-80001', 'CLM-2024-80001', 'First Notice of Loss', '2024-09-12 00:00:00'),
('DOC-ADJ-CLM-2024-80001', 'CLM-2024-80001', 'Adjuster Report', '2024-09-19 00:00:00'),
('DOC-FNOL-CLM-2026-80002', 'CLM-2026-80002', 'First Notice of Loss', '2026-09-02 00:00:00'),
('DOC-ADJ-CLM-2026-80002', 'CLM-2026-80002', 'Adjuster Report', '2026-09-09 00:00:00'),
('DOC-FNOL-CLM-2020-80003', 'CLM-2020-80003', 'First Notice of Loss', '2020-11-20 00:00:00'),
('DOC-ADJ-CLM-2020-80003', 'CLM-2020-80003', 'Adjuster Report', '2020-11-27 00:00:00'),
('DOC-FNOL-CLM-2025-80004', 'CLM-2025-80004', 'First Notice of Loss', '2025-08-02 00:00:00'),
('DOC-ADJ-CLM-2025-80004', 'CLM-2025-80004', 'Adjuster Report', '2025-08-09 00:00:00'),
('DOC-FNOL-CLM-2026-80005', 'CLM-2026-80005', 'First Notice of Loss', '2026-04-22 00:00:00'),
('DOC-ADJ-CLM-2026-80005', 'CLM-2026-80005', 'Adjuster Report', '2026-04-29 00:00:00'),
('DOC-FNOL-CLM-2019-80006', 'CLM-2019-80006', 'First Notice of Loss', '2019-08-29 00:00:00'),
('DOC-ADJ-CLM-2019-80006', 'CLM-2019-80006', 'Adjuster Report', '2019-09-05 00:00:00'),
('DOC-FNOL-CLM-2024-80007', 'CLM-2024-80007', 'First Notice of Loss', '2024-10-26 00:00:00'),
('DOC-ADJ-CLM-2024-80007', 'CLM-2024-80007', 'Adjuster Report', '2024-11-02 00:00:00'),
('DOC-FNOL-CLM-2022-80008', 'CLM-2022-80008', 'First Notice of Loss', '2022-01-06 00:00:00'),
('DOC-ADJ-CLM-2022-80008', 'CLM-2022-80008', 'Adjuster Report', '2022-01-13 00:00:00'),
('DOC-FNOL-CLM-2024-80009', 'CLM-2024-80009', 'First Notice of Loss', '2024-03-20 00:00:00'),
('DOC-ADJ-CLM-2024-80009', 'CLM-2024-80009', 'Adjuster Report', '2024-03-27 00:00:00'),
('DOC-FNOL-CLM-2020-80010', 'CLM-2020-80010', 'First Notice of Loss', '2020-10-23 00:00:00'),
('DOC-ADJ-CLM-2020-80010', 'CLM-2020-80010', 'Adjuster Report', '2020-10-30 00:00:00'),
('DOC-FNOL-CLM-2018-80011', 'CLM-2018-80011', 'First Notice of Loss', '2018-06-01 00:00:00'),
('DOC-ADJ-CLM-2018-80011', 'CLM-2018-80011', 'Adjuster Report', '2018-06-08 00:00:00'),
('DOC-FNOL-CLM-2021-80012', 'CLM-2021-80012', 'First Notice of Loss', '2021-02-27 00:00:00'),
('DOC-ADJ-CLM-2021-80012', 'CLM-2021-80012', 'Adjuster Report', '2021-03-06 00:00:00'),
('DOC-FNOL-CLM-2025-80013', 'CLM-2025-80013', 'First Notice of Loss', '2025-03-12 00:00:00');

-- Table: inspection
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.inspection (
    inspection_id STRING,
    property_id STRING,
    agent_id STRING,
    project_identifier STRING,
    program_area STRING,
    property_action STRING,
    structure_type STRING,
    foundation_type STRING,
    damage_category STRING,
    actual_amount_paid DOUBLE,
    number_of_properties BIGINT,
    state STRING,
    county STRING,
    city STRING,
    zip_code STRING,
    synthetic_property_key STRING
);

-- Sample seed data for inspection
INSERT INTO insurance_dev_gold.gold_schema.inspection VALUES
('INSP-PROP-58210', 'PROP-58210', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'TX', 'Harris', 'Baytown', '77520', 'GEO-TX-77520'),
('INSP-PROP-60005', 'PROP-60005', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'LA', 'Jefferson', 'Metairie', '70001', 'GEO-LA-70001'),
('INSP-PROP-60014', 'PROP-60014', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'SC', 'Charleston', 'Charleston', '29401', 'GEO-SC-29401'),
('INSP-PROP-60015', 'PROP-60015', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'NC', 'Dare', 'Nags Head', '27959', 'GEO-NC-27959'),
('INSP-PROP-60016', 'PROP-60016', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'TX', 'Harris', 'Baytown', '77520', 'GEO-TX-77520'),
('INSP-PROP-60023', 'PROP-60023', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'NC', 'New Hanover', 'Wilmington', '28401', 'GEO-NC-28401'),
('INSP-PROP-60032', 'PROP-60032', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'LA', 'Orleans', 'New Orleans', '70112', 'GEO-LA-70112'),
('INSP-PROP-60033', 'PROP-60033', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'FL', 'Lee', 'Fort Myers', '33901', 'GEO-FL-33901'),
('INSP-PROP-60041', 'PROP-60041', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'NC', 'New Hanover', 'Wilmington', '28401', 'GEO-NC-28401'),
('INSP-PROP-60050', 'PROP-60050', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'FL', 'Miami-Dade', 'Miami', '33101', 'GEO-FL-33101'),
('INSP-PROP-60059', 'PROP-60059', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'SC', 'Horry', 'Myrtle Beach', '29577', 'GEO-SC-29577'),
('INSP-PROP-60068', 'PROP-60068', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'FL', 'Miami-Dade', 'Miami', '33101', 'GEO-FL-33101'),
('INSP-PROP-60077', 'PROP-60077', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'FL', 'Miami-Dade', 'Miami', '33101', 'GEO-FL-33101'),
('INSP-PROP-60078', 'PROP-60078', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'FL', 'Hillsborough', 'Tampa', '33602', 'GEO-FL-33602'),
('INSP-PROP-60086', 'PROP-60086', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'FL', 'Lee', 'Fort Myers', '33901', 'GEO-FL-33901'),
('INSP-PROP-60095', 'PROP-60095', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'TX', 'Brazoria', 'Freeport', '77541', 'GEO-TX-77541'),
('INSP-PROP-60096', 'PROP-60096', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'TX', 'Harris', 'Baytown', '77520', 'GEO-TX-77520'),
('INSP-PROP-60104', 'PROP-60104', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'FL', 'Miami-Dade', 'Miami', '33101', 'GEO-FL-33101'),
('INSP-PROP-60113', 'PROP-60113', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'TX', 'Brazoria', 'Freeport', '77541', 'GEO-TX-77541'),
('INSP-PROP-60122', 'PROP-60122', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'FL', 'Miami-Dade', 'Miami', '33101', 'GEO-FL-33101'),
('INSP-PROP-60131', 'PROP-60131', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'SC', 'Charleston', 'Charleston', '29401', 'GEO-SC-29401'),
('INSP-PROP-60140', 'PROP-60140', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'SC', 'Charleston', 'Charleston', '29401', 'GEO-SC-29401'),
('INSP-PROP-60149', 'PROP-60149', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'FL', 'Miami-Dade', 'Miami', '33101', 'GEO-FL-33101'),
('INSP-PROP-60150', 'PROP-60150', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'TX', 'Harris', 'Baytown', '77520', 'GEO-TX-77520'),
('INSP-PROP-60158', 'PROP-60158', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'SC', 'Charleston', 'Charleston', '29401', 'GEO-SC-29401');

-- Table: policy
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.policy (
    policy_id STRING,
    customer_id STRING,
    property_id STRING,
    agent_id STRING,
    community_id STRING,
    policy_effective_date TIMESTAMP,
    policy_termination_date TIMESTAMP,
    total_building_insurance_coverage DOUBLE,
    total_contents_insurance_coverage DOUBLE,
    total_insurance_premium DOUBLE,
    hfiaa_surcharge DOUBLE,
    federal_policy_fee DOUBLE,
    occupancy_type STRING,
    rated_flood_zone STRING,
    state STRING,
    county_code STRING,
    synthetic_property_key STRING,
    synthetic_policy_key STRING
);

-- Sample seed data for policy
INSERT INTO insurance_dev_gold.gold_schema.policy VALUES
('POL-2024-77520-0001', 'CUST-10492', 'PROP-58210', 'AGT-03', 'COM-48001', '2024-03-01 00:00:00', '2025-03-01 00:00:00', 250000.0, 100000.0, 1850.0, 25.0, 50.0, 'Single Family', 'AE', 'TX', '48000', 'SYN-PROP-PROP-58210', 'SYN-POL-POL-2024-77520-0001'),
('POL-2025-77520-0002', 'CUST-10492', 'PROP-58210', 'AGT-02', 'COM-48000', '2025-03-01 00:00:00', '2026-03-01 00:00:00', 250000.0, 100000.0, 1868.5, 25.0, 50.0, 'Single Family', 'AE', 'TX', '48000', 'SYN-PROP-PROP-58210', 'SYN-POL-POL-2025-77520-0002'),
('POL-2026-77520-0003', 'CUST-10492', 'PROP-58210', 'AGT-02', 'COM-48010', '2026-03-01 00:00:00', '2027-03-01 00:00:00', 250000.0, 100000.0, 1887.0, 25.0, 50.0, 'Single Family', 'AE', 'TX', '48000', 'SYN-PROP-PROP-58210', 'SYN-POL-POL-2026-77520-0003'),
('POL-2023-70001-0004', 'CUST-20000', 'PROP-60005', 'AGT-05', 'COM-48000', '2023-10-26 00:00:00', '2024-10-26 00:00:00', 100000.0, 100000.0, 1897.0, 25.0, 50.0, 'Single Family', 'AE', 'LA', '48003', 'SYN-PROP-PROP-60005', 'SYN-POL-POL-2023-70001-0004'),
('POL-2024-70001-0005', 'CUST-20000', 'PROP-60005', 'AGT-02', 'COM-48007', '2024-10-26 00:00:00', '2025-10-26 00:00:00', 100000.0, 100000.0, 1915.97, 25.0, 50.0, 'Single Family', 'AE', 'LA', '48003', 'SYN-PROP-PROP-60005', 'SYN-POL-POL-2024-70001-0005'),
('POL-2025-70001-0006', 'CUST-20000', 'PROP-60005', 'AGT-05', 'COM-48001', '2025-10-26 00:00:00', '2026-10-26 00:00:00', 100000.0, 100000.0, 1934.94, 25.0, 50.0, 'Single Family', 'AE', 'LA', '48003', 'SYN-PROP-PROP-60005', 'SYN-POL-POL-2025-70001-0006'),
('POL-2019-29401-0007', 'CUST-20001', 'PROP-60014', 'AGT-02', 'COM-48007', '2019-04-19 00:00:00', '2020-04-19 00:00:00', 250000.0, 50000.0, 825.0, 25.0, 50.0, 'Single Family', 'AE', 'SC', '48010', 'SYN-PROP-PROP-60014', 'SYN-POL-POL-2019-29401-0007'),
('POL-2020-29401-0008', 'CUST-20001', 'PROP-60014', 'AGT-03', 'COM-48006', '2020-04-19 00:00:00', '2021-04-19 00:00:00', 250000.0, 50000.0, 833.25, 25.0, 50.0, 'Single Family', 'AE', 'SC', '48010', 'SYN-PROP-PROP-60014', 'SYN-POL-POL-2020-29401-0008'),
('POL-2021-29401-0009', 'CUST-20001', 'PROP-60014', 'AGT-05', 'COM-48009', '2021-04-19 00:00:00', '2022-04-19 00:00:00', 250000.0, 50000.0, 841.5, 25.0, 50.0, 'Single Family', 'AE', 'SC', '48010', 'SYN-PROP-PROP-60014', 'SYN-POL-POL-2021-29401-0009'),
('POL-2022-29401-0010', 'CUST-20001', 'PROP-60014', 'AGT-01', 'COM-48006', '2022-04-19 00:00:00', '2023-04-19 00:00:00', 250000.0, 50000.0, 849.75, 25.0, 50.0, 'Single Family', 'AE', 'SC', '48010', 'SYN-PROP-PROP-60014', 'SYN-POL-POL-2022-29401-0010'),
('POL-2023-29401-0011', 'CUST-20001', 'PROP-60014', 'AGT-05', 'COM-48002', '2023-04-19 00:00:00', '2024-04-19 00:00:00', 250000.0, 50000.0, 858.0, 25.0, 50.0, 'Single Family', 'AE', 'SC', '48010', 'SYN-PROP-PROP-60014', 'SYN-POL-POL-2023-29401-0011'),
('POL-2024-29401-0012', 'CUST-20001', 'PROP-60014', 'AGT-05', 'COM-48007', '2024-04-19 00:00:00', '2025-04-19 00:00:00', 250000.0, 50000.0, 866.25, 25.0, 50.0, 'Single Family', 'AE', 'SC', '48010', 'SYN-PROP-PROP-60014', 'SYN-POL-POL-2024-29401-0012'),
('POL-2025-29401-0013', 'CUST-20001', 'PROP-60014', 'AGT-01', 'COM-48011', '2025-04-19 00:00:00', '2026-04-19 00:00:00', 250000.0, 50000.0, 874.5, 25.0, 50.0, 'Single Family', 'AE', 'SC', '48010', 'SYN-PROP-PROP-60014', 'SYN-POL-POL-2025-29401-0013'),
('POL-2026-29401-0014', 'CUST-20001', 'PROP-60014', 'AGT-04', 'COM-48010', '2026-04-19 00:00:00', '2027-04-19 00:00:00', 250000.0, 50000.0, 882.75, 25.0, 50.0, 'Single Family', 'AE', 'SC', '48010', 'SYN-PROP-PROP-60014', 'SYN-POL-POL-2026-29401-0014'),
('POL-2019-27959-0015', 'CUST-20001', 'PROP-60015', 'AGT-03', 'COM-48007', '2019-04-29 00:00:00', '2020-04-29 00:00:00', 350000.0, 100000.0, 3712.0, 25.0, 50.0, 'Single Family', 'AE', 'NC', '48009', 'SYN-PROP-PROP-60015', 'SYN-POL-POL-2019-27959-0015'),
('POL-2020-27959-0016', 'CUST-20001', 'PROP-60015', 'AGT-02', 'COM-48002', '2020-04-29 00:00:00', '2021-04-29 00:00:00', 350000.0, 100000.0, 3749.12, 25.0, 50.0, 'Single Family', 'AE', 'NC', '48009', 'SYN-PROP-PROP-60015', 'SYN-POL-POL-2020-27959-0016'),
('POL-2021-27959-0017', 'CUST-20001', 'PROP-60015', 'AGT-01', 'COM-48000', '2021-04-29 00:00:00', '2022-04-29 00:00:00', 350000.0, 100000.0, 3786.24, 25.0, 50.0, 'Single Family', 'AE', 'NC', '48009', 'SYN-PROP-PROP-60015', 'SYN-POL-POL-2021-27959-0017'),
('POL-2022-27959-0018', 'CUST-20001', 'PROP-60015', 'AGT-05', 'COM-48009', '2022-04-29 00:00:00', '2023-04-29 00:00:00', 350000.0, 100000.0, 3823.36, 25.0, 50.0, 'Single Family', 'AE', 'NC', '48009', 'SYN-PROP-PROP-60015', 'SYN-POL-POL-2022-27959-0018'),
('POL-2023-27959-0019', 'CUST-20001', 'PROP-60015', 'AGT-05', 'COM-48005', '2023-04-29 00:00:00', '2024-04-29 00:00:00', 350000.0, 100000.0, 3860.48, 25.0, 50.0, 'Single Family', 'AE', 'NC', '48009', 'SYN-PROP-PROP-60015', 'SYN-POL-POL-2023-27959-0019'),
('POL-2024-27959-0020', 'CUST-20001', 'PROP-60015', 'AGT-05', 'COM-48009', '2024-04-29 00:00:00', '2025-04-29 00:00:00', 350000.0, 100000.0, 3897.6, 25.0, 50.0, 'Single Family', 'AE', 'NC', '48009', 'SYN-PROP-PROP-60015', 'SYN-POL-POL-2024-27959-0020'),
('POL-2025-27959-0021', 'CUST-20001', 'PROP-60015', 'AGT-05', 'COM-48011', '2025-04-29 00:00:00', '2026-04-29 00:00:00', 350000.0, 100000.0, 3934.72, 25.0, 50.0, 'Single Family', 'AE', 'NC', '48009', 'SYN-PROP-PROP-60015', 'SYN-POL-POL-2025-27959-0021'),
('POL-2026-27959-0022', 'CUST-20001', 'PROP-60015', 'AGT-05', 'COM-48008', '2026-04-29 00:00:00', '2027-04-29 00:00:00', 350000.0, 100000.0, 3971.84, 25.0, 50.0, 'Single Family', 'AE', 'NC', '48009', 'SYN-PROP-PROP-60015', 'SYN-POL-POL-2026-27959-0022'),
('POL-2019-77520-0023', 'CUST-20001', 'PROP-60016', 'AGT-01', 'COM-48009', '2019-05-06 00:00:00', '2020-05-06 00:00:00', 150000.0, 100000.0, 791.0, 25.0, 50.0, 'Single Family', 'AE', 'TX', '48000', 'SYN-PROP-PROP-60016', 'SYN-POL-POL-2019-77520-0023'),
('POL-2020-77520-0024', 'CUST-20001', 'PROP-60016', 'AGT-02', 'COM-48010', '2020-05-06 00:00:00', '2021-05-06 00:00:00', 150000.0, 100000.0, 798.91, 25.0, 50.0, 'Single Family', 'AE', 'TX', '48000', 'SYN-PROP-PROP-60016', 'SYN-POL-POL-2020-77520-0024'),
('POL-2021-77520-0025', 'CUST-20001', 'PROP-60016', 'AGT-01', 'COM-48010', '2021-05-06 00:00:00', '2022-05-06 00:00:00', 150000.0, 100000.0, 806.82, 25.0, 50.0, 'Single Family', 'AE', 'TX', '48000', 'SYN-PROP-PROP-60016', 'SYN-POL-POL-2021-77520-0025');

-- Table: property
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.property (
    property_id STRING,
    community_id STRING,
    state STRING,
    state_abbreviation STRING,
    county STRING,
    zip_code STRING,
    city STRING,
    flood_zone STRING,
    latitude DOUBLE,
    longitude DOUBLE,
    occupancy_type STRING,
    original_construction_date TIMESTAMP,
    primary_residence_indicator BOOLEAN,
    total_losses BIGINT,
    nfip_rl BOOLEAN,
    nfip_srl BOOLEAN,
    mitigated_indicator BOOLEAN,
    insured_indicator BOOLEAN,
    synthetic_geo_key STRING,
    synthetic_zip_key STRING
);

-- Sample seed data for property
INSERT INTO insurance_dev_gold.gold_schema.property VALUES
('PROP-58210', 'COM-48008', 'TX', 'TX', 'Harris', '77520', 'Baytown', 'AE', 33.02, -99.02, 'Single Family Residence', '1995-06-15 00:00:00', True, 1, False, False, True, True, 'GEO-TX-77520', 'ZIP-77520'),
('PROP-60005', 'COM-48009', 'LA', 'LA', 'Jefferson', '70001', 'Metairie', 'AE', 31.645, -97.645, 'Single Family Residence', '1995-06-15 00:00:00', True, 1, False, False, True, True, 'GEO-LA-70001', 'ZIP-70001'),
('PROP-60014', 'COM-48009', 'SC', 'SC', 'Charleston', '29401', 'Charleston', 'X', 33.225, -99.225, 'Single Family Residence', '2012-08-20 00:00:00', True, 0, False, False, False, True, 'GEO-SC-29401', 'ZIP-29401'),
('PROP-60015', 'COM-48009', 'NC', 'NC', 'Dare', '27959', 'Nags Head', 'AE', 30.465, -96.465, 'Single Family Residence', '2012-08-20 00:00:00', True, 0, False, False, False, True, 'GEO-NC-27959', 'ZIP-27959'),
('PROP-60016', 'COM-48009', 'TX', 'TX', 'Harris', '77520', 'Baytown', 'X', 32.885, -98.885, 'Single Family Residence', '1995-06-15 00:00:00', True, 0, False, False, False, True, 'GEO-TX-77520', 'ZIP-77520'),
('PROP-60023', 'COM-48009', 'NC', 'NC', 'New Hanover', '28401', 'Wilmington', 'AE', 30.345, -96.345, 'Single Family Residence', '2012-08-20 00:00:00', True, 0, False, False, False, True, 'GEO-NC-28401', 'ZIP-28401'),
('PROP-60032', 'COM-48005', 'LA', 'LA', 'Orleans', '70112', 'New Orleans', 'B', 31.205, -97.205, 'Single Family Residence', '2012-08-20 00:00:00', True, 0, False, False, False, True, 'GEO-LA-70112', 'ZIP-70112'),
('PROP-60033', 'COM-48008', 'FL', 'FL', 'Lee', '33901', 'Fort Myers', 'VE', 32.16, -98.16, 'Single Family Residence', '2012-08-20 00:00:00', True, 0, False, False, False, True, 'GEO-FL-33901', 'ZIP-33901'),
('PROP-60041', 'COM-48003', 'NC', 'NC', 'New Hanover', '28401', 'Wilmington', 'VE', 30.915, -96.915, 'Single Family Residence', '2012-08-20 00:00:00', True, 0, False, False, False, True, 'GEO-NC-28401', 'ZIP-28401'),
('PROP-60050', 'COM-48005', 'FL', 'FL', 'Miami-Dade', '33101', 'Miami', 'VE', 33.005, -99.005, 'Single Family Residence', '1995-06-15 00:00:00', True, 2, True, False, True, True, 'GEO-FL-33101', 'ZIP-33101'),
('PROP-60059', 'COM-48005', 'SC', 'SC', 'Horry', '29577', 'Myrtle Beach', 'AE', 32.385, -98.385, 'Single Family Residence', '1995-06-15 00:00:00', True, 1, False, False, False, True, 'GEO-SC-29577', 'ZIP-29577'),
('PROP-60068', 'COM-48001', 'FL', 'FL', 'Miami-Dade', '33101', 'Miami', 'AE', 29.345, -95.345, 'Single Family Residence', '1995-06-15 00:00:00', True, 1, False, False, False, True, 'GEO-FL-33101', 'ZIP-33101'),
('PROP-60077', 'COM-48006', 'FL', 'FL', 'Miami-Dade', '33101', 'Miami', 'VE', 33.21, -99.21, 'Single Family Residence', '1995-06-15 00:00:00', True, 0, False, False, False, True, 'GEO-FL-33101', 'ZIP-33101'),
('PROP-60078', 'COM-48004', 'FL', 'FL', 'Hillsborough', '33602', 'Tampa', 'A', 31.6, -97.6, 'Single Family Residence', '2012-08-20 00:00:00', True, 0, False, False, False, True, 'GEO-FL-33602', 'ZIP-33602'),
('PROP-60086', 'COM-48011', 'FL', 'FL', 'Lee', '33901', 'Fort Myers', 'X', 32.455, -98.455, 'Single Family Residence', '1995-06-15 00:00:00', True, 0, False, False, False, True, 'GEO-FL-33901', 'ZIP-33901'),
('PROP-60095', 'COM-48005', 'TX', 'TX', 'Brazoria', '77541', 'Freeport', 'X', 32.105, -98.105, 'Single Family Residence', '2012-08-20 00:00:00', True, 0, False, False, True, True, 'GEO-TX-77541', 'ZIP-77541'),
('PROP-60096', 'COM-48005', 'TX', 'TX', 'Harris', '77520', 'Baytown', 'AE', 31.885, -97.885, 'Single Family Residence', '2012-08-20 00:00:00', True, 0, False, False, False, True, 'GEO-TX-77520', 'ZIP-77520'),
('PROP-60104', 'COM-48008', 'FL', 'FL', 'Miami-Dade', '33101', 'Miami', 'A', 31.26, -97.26, 'Single Family Residence', '2012-08-20 00:00:00', True, 0, False, False, True, True, 'GEO-FL-33101', 'ZIP-33101'),
('PROP-60113', 'COM-48010', 'TX', 'TX', 'Brazoria', '77541', 'Freeport', 'AE', 33.61, -99.61, 'Single Family Residence', '2012-08-20 00:00:00', True, 0, False, False, True, True, 'GEO-TX-77541', 'ZIP-77541'),
('PROP-60122', 'COM-48000', 'FL', 'FL', 'Miami-Dade', '33101', 'Miami', 'VE', 31.74, -97.74, 'Single Family Residence', '2012-08-20 00:00:00', True, 1, False, False, False, True, 'GEO-FL-33101', 'ZIP-33101'),
('PROP-60131', 'COM-48004', 'SC', 'SC', 'Charleston', '29401', 'Charleston', 'AE', 29.94, -95.94, 'Single Family Residence', '1995-06-15 00:00:00', True, 0, False, False, False, True, 'GEO-SC-29401', 'ZIP-29401'),
('PROP-60140', 'COM-48008', 'SC', 'SC', 'Charleston', '29401', 'Charleston', 'AE', 33.14, -99.14, 'Single Family Residence', '1995-06-15 00:00:00', True, 2, True, False, True, True, 'GEO-SC-29401', 'ZIP-29401'),
('PROP-60149', 'COM-48005', 'FL', 'FL', 'Miami-Dade', '33101', 'Miami', 'VE', 29.285, -95.285, 'Single Family Residence', '2012-08-20 00:00:00', True, 1, False, False, True, True, 'GEO-FL-33101', 'ZIP-33101'),
('PROP-60150', 'COM-48011', 'TX', 'TX', 'Harris', '77520', 'Baytown', 'AE', 29.255, -95.255, 'Single Family Residence', '1995-06-15 00:00:00', True, 2, True, False, True, True, 'GEO-TX-77520', 'ZIP-77520'),
('PROP-60158', 'COM-48003', 'SC', 'SC', 'Charleston', '29401', 'Charleston', 'AE', 31.255, -97.255, 'Single Family Residence', '1995-06-15 00:00:00', True, 0, False, False, False, True, 'GEO-SC-29401', 'ZIP-29401');

-- Table: dim_community
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.dim_community (
    community_key BIGINT,
    community_id_number STRING,
    community_name STRING,
    state STRING,
    participation_status STRING,
    crs_class BIGINT
);

-- Sample seed data for dim_community
INSERT INTO insurance_dev_gold.gold_schema.dim_community VALUES
(1, 'COM-48000', 'Baytown', 'TX', 'Regular', 7),
(2, 'COM-48001', 'Galveston', 'TX', 'Regular', 6),
(3, 'COM-48002', 'Freeport', 'TX', 'Regular', 7),
(4, 'COM-48003', 'Metairie', 'LA', 'Regular', 8),
(5, 'COM-48004', 'New Orleans', 'LA', 'Regular', 8),
(6, 'COM-48005', 'Miami', 'FL', 'Regular', 7),
(7, 'COM-48006', 'Fort Myers', 'FL', 'Regular', 6),
(8, 'COM-48007', 'Tampa', 'FL', 'Regular', 7),
(9, 'COM-48008', 'Wilmington', 'NC', 'Regular', 8),
(10, 'COM-48009', 'Nags Head', 'NC', 'Regular', 8),
(11, 'COM-48010', 'Charleston', 'SC', 'Regular', 7),
(12, 'COM-48011', 'Myrtle Beach', 'SC', 'Regular', 6);

-- Table: dim_date
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.dim_date (
    date_key BIGINT,
    full_date TIMESTAMP,
    day_of_week BIGINT,
    day_name STRING,
    day_of_month BIGINT,
    month BIGINT,
    month_name STRING,
    quarter BIGINT,
    year BIGINT,
    fiscal_year BIGINT,
    is_weekend BOOLEAN
);

-- Sample seed data for dim_date
INSERT INTO insurance_dev_gold.gold_schema.dim_date VALUES
(20200101, '2020-01-01 00:00:00', 3, 'Wednesday', 1, 1, 'January', 1, 2020, 2019, False),
(20200115, '2020-01-15 00:00:00', 3, 'Wednesday', 15, 1, 'January', 1, 2020, 2019, False),
(20200129, '2020-01-29 00:00:00', 3, 'Wednesday', 29, 1, 'January', 1, 2020, 2019, False),
(20200212, '2020-02-12 00:00:00', 3, 'Wednesday', 12, 2, 'February', 1, 2020, 2019, False),
(20200226, '2020-02-26 00:00:00', 3, 'Wednesday', 26, 2, 'February', 1, 2020, 2019, False),
(20200311, '2020-03-11 00:00:00', 3, 'Wednesday', 11, 3, 'March', 1, 2020, 2019, False),
(20200325, '2020-03-25 00:00:00', 3, 'Wednesday', 25, 3, 'March', 1, 2020, 2019, False),
(20200408, '2020-04-08 00:00:00', 3, 'Wednesday', 8, 4, 'April', 2, 2020, 2019, False),
(20200422, '2020-04-22 00:00:00', 3, 'Wednesday', 22, 4, 'April', 2, 2020, 2019, False),
(20200506, '2020-05-06 00:00:00', 3, 'Wednesday', 6, 5, 'May', 2, 2020, 2019, False),
(20200520, '2020-05-20 00:00:00', 3, 'Wednesday', 20, 5, 'May', 2, 2020, 2019, False),
(20200603, '2020-06-03 00:00:00', 3, 'Wednesday', 3, 6, 'June', 2, 2020, 2019, False),
(20200617, '2020-06-17 00:00:00', 3, 'Wednesday', 17, 6, 'June', 2, 2020, 2019, False),
(20200701, '2020-07-01 00:00:00', 3, 'Wednesday', 1, 7, 'July', 3, 2020, 2019, False),
(20200715, '2020-07-15 00:00:00', 3, 'Wednesday', 15, 7, 'July', 3, 2020, 2019, False),
(20200729, '2020-07-29 00:00:00', 3, 'Wednesday', 29, 7, 'July', 3, 2020, 2019, False),
(20200812, '2020-08-12 00:00:00', 3, 'Wednesday', 12, 8, 'August', 3, 2020, 2019, False),
(20200826, '2020-08-26 00:00:00', 3, 'Wednesday', 26, 8, 'August', 3, 2020, 2019, False),
(20200909, '2020-09-09 00:00:00', 3, 'Wednesday', 9, 9, 'September', 3, 2020, 2019, False),
(20200923, '2020-09-23 00:00:00', 3, 'Wednesday', 23, 9, 'September', 3, 2020, 2019, False),
(20201007, '2020-10-07 00:00:00', 3, 'Wednesday', 7, 10, 'October', 4, 2020, 2020, False),
(20201021, '2020-10-21 00:00:00', 3, 'Wednesday', 21, 10, 'October', 4, 2020, 2020, False),
(20201104, '2020-11-04 00:00:00', 3, 'Wednesday', 4, 11, 'November', 4, 2020, 2020, False),
(20201118, '2020-11-18 00:00:00', 3, 'Wednesday', 18, 11, 'November', 4, 2020, 2020, False),
(20201202, '2020-12-02 00:00:00', 3, 'Wednesday', 2, 12, 'December', 4, 2020, 2020, False);

-- Table: dim_disaster_declaration
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.dim_disaster_declaration (
    disaster_key BIGINT,
    disaster_number BIGINT,
    fema_declaration_string STRING,
    declaration_type STRING,
    declaration_title STRING,
    incident_type STRING,
    declaration_date TIMESTAMP,
    incident_begin_date TIMESTAMP,
    incident_end_date TIMESTAMP,
    ih_program_declared BOOLEAN,
    ia_program_declared BOOLEAN,
    pa_program_declared BOOLEAN,
    hm_program_declared BOOLEAN
);

-- Sample seed data for dim_disaster_declaration
INSERT INTO insurance_dev_gold.gold_schema.dim_disaster_declaration VALUES
(1, 4520, 'DR-4520-TX', 'Major Disaster', 'Hurricane Laura', 'Hurricane', '2020-08-15 00:00:00', '2020-08-10 00:00:00', '2020-08-20 00:00:00', True, True, True, True),
(2, 4611, 'DR-4611-LA', 'Major Disaster', 'Hurricane Ida', 'Hurricane', '2021-08-15 00:00:00', '2021-08-10 00:00:00', '2021-08-20 00:00:00', True, True, True, True),
(3, 4673, 'DR-4673-FL', 'Major Disaster', 'Hurricane Ian', 'Hurricane', '2022-08-15 00:00:00', '2022-08-10 00:00:00', '2022-08-20 00:00:00', True, True, True, True),
(4, 4712, 'DR-4712-NC', 'Major Disaster', 'Tropical Storm Debby', 'Tropical Storm', '2023-08-15 00:00:00', '2023-08-10 00:00:00', '2023-08-20 00:00:00', True, True, True, True),
(5, 4735, 'DR-4735-SC', 'Major Disaster', 'Coastal Surge and Flooding', 'Flood', '2024-08-15 00:00:00', '2024-08-10 00:00:00', '2024-08-20 00:00:00', True, True, True, True),
(6, 4789, 'DR-4789-TX', 'Major Disaster', 'Gulf Coast Severe Storms', 'Severe Storm', '2025-08-15 00:00:00', '2025-08-10 00:00:00', '2025-08-20 00:00:00', True, True, True, True);

-- Table: dim_geography
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.dim_geography (
    geography_key BIGINT,
    state STRING,
    fips_state_code STRING,
    county_code STRING,
    fips_county_code STRING,
    region STRING
);

-- Sample seed data for dim_geography
INSERT INTO insurance_dev_gold.gold_schema.dim_geography VALUES
(1, 'TX', '40', '48000', '48000', 'Gulf Coast'),
(2, 'TX', '41', '48001', '48001', 'Gulf Coast'),
(3, 'TX', '42', '48002', '48002', 'Gulf Coast'),
(4, 'LA', '43', '48003', '48003', 'Gulf Coast'),
(5, 'LA', '44', '48004', '48004', 'Gulf Coast'),
(6, 'FL', '45', '48005', '48005', 'South Atlantic'),
(7, 'FL', '46', '48006', '48006', 'South Atlantic'),
(8, 'FL', '47', '48007', '48007', 'South Atlantic'),
(9, 'NC', '48', '48008', '48008', 'South Atlantic'),
(10, 'NC', '49', '48009', '48009', 'South Atlantic'),
(11, 'SC', '410', '48010', '48010', 'South Atlantic'),
(12, 'SC', '411', '48011', '48011', 'South Atlantic');

-- Table: dim_hma_project
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.dim_hma_project (
    project_key BIGINT,
    project_identifier STRING,
    program_area STRING,
    project_type STRING,
    status STRING,
    recipient STRING,
    subrecipient STRING,
    project_title STRING
);

-- Sample seed data for dim_hma_project
INSERT INTO insurance_dev_gold.gold_schema.dim_hma_project VALUES
(1, 'PDMC-PL-TX-2020', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'TX Division of Emergency Management', 'City of Baytown', 'Regional Stormwater Resiliency - Baytown'),
(2, 'PDMC-PL-TX-2021', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'TX Division of Emergency Management', 'City of Galveston', 'Regional Stormwater Resiliency - Galveston'),
(3, 'PDMC-PL-TX-2022', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'TX Division of Emergency Management', 'City of Freeport', 'Regional Stormwater Resiliency - Freeport'),
(4, 'PDMC-PL-LA-2023', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'LA Division of Emergency Management', 'City of Metairie', 'Regional Stormwater Resiliency - Metairie'),
(5, 'PDMC-PL-LA-2024', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'LA Division of Emergency Management', 'City of New Orleans', 'Regional Stormwater Resiliency - New Orleans'),
(6, 'PDMC-PL-FL-2025', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'FL Division of Emergency Management', 'City of Miami', 'Regional Stormwater Resiliency - Miami'),
(7, 'PDMC-PL-FL-2026', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'FL Division of Emergency Management', 'City of Fort Myers', 'Regional Stormwater Resiliency - Fort Myers'),
(8, 'PDMC-PL-FL-2027', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'FL Division of Emergency Management', 'City of Tampa', 'Regional Stormwater Resiliency - Tampa'),
(9, 'PDMC-PL-NC-2028', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'NC Division of Emergency Management', 'City of Wilmington', 'Regional Stormwater Resiliency - Wilmington'),
(10, 'PDMC-PL-NC-2029', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'NC Division of Emergency Management', 'City of Nags Head', 'Regional Stormwater Resiliency - Nags Head'),
(11, 'PDMC-PL-SC-20210', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'SC Division of Emergency Management', 'City of Charleston', 'Regional Stormwater Resiliency - Charleston'),
(12, 'PDMC-PL-SC-20211', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'SC Division of Emergency Management', 'City of Myrtle Beach', 'Regional Stormwater Resiliency - Myrtle Beach');

-- Table: dim_property_profile
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.dim_property_profile (
    property_profile_key BIGINT,
    occupancy_type STRING,
    flood_zone STRING,
    construction_date_band STRING,
    primary_residence_indicator BOOLEAN,
    elevated_building_indicator BOOLEAN,
    condominium_indicator BOOLEAN
);

-- Sample seed data for dim_property_profile
INSERT INTO insurance_dev_gold.gold_schema.dim_property_profile VALUES
(1, 'Single Family Residence', 'VE', 'Pre-FIRM', True, False, False),
(2, 'Single Family Residence', 'VE', 'Post-FIRM', True, True, False),
(3, 'Single Family Residence', 'AE', 'Pre-FIRM', True, False, False),
(4, 'Single Family Residence', 'AE', 'Post-FIRM', True, True, False),
(5, 'Single Family Residence', 'A', 'Post-FIRM', True, False, False),
(6, 'Single Family Residence', 'X', 'Post-FIRM', True, False, False),
(7, 'Single Family Residence', 'B', 'Post-FIRM', True, False, False);

-- Table: fact_disaster_declaration_area
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.fact_disaster_declaration_area (
    declaration_area_key BIGINT,
    declaration_date_key BIGINT,
    geography_key BIGINT,
    disaster_key BIGINT,
    ih_program_declared BOOLEAN,
    ia_program_declared BOOLEAN,
    pa_program_declared BOOLEAN,
    hm_program_declared BOOLEAN,
    declaration_count BIGINT
);

-- Sample seed data for fact_disaster_declaration_area
INSERT INTO insurance_dev_gold.gold_schema.fact_disaster_declaration_area VALUES
(1, 20240815, 1, 1, True, True, True, True, 1),
(2, 20240815, 2, 2, True, True, True, True, 1),
(3, 20240815, 3, 3, True, True, True, True, 1),
(4, 20240815, 4, 4, True, True, True, True, 1),
(5, 20240815, 5, 5, True, True, True, True, 1),
(6, 20240815, 6, 6, True, True, True, True, 1),
(7, 20240815, 7, 1, True, True, True, True, 1),
(8, 20240815, 8, 2, True, True, True, True, 1),
(9, 20240815, 9, 3, True, True, True, True, 1),
(10, 20240815, 10, 4, True, True, True, True, 1),
(11, 20240815, 11, 5, True, True, True, True, 1),
(12, 20240815, 12, 6, True, True, True, True, 1);

-- Table: fact_hma_financial_transaction
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.fact_hma_financial_transaction (
    transaction_key BIGINT,
    obligated_date_key BIGINT,
    geography_key BIGINT,
    project_key BIGINT,
    disaster_key BIGINT,
    transaction_level STRING,
    obligated_amount DOUBLE,
    federal_share_obligated DOUBLE,
    transaction_count BIGINT
);

-- Sample seed data for fact_hma_financial_transaction
INSERT INTO insurance_dev_gold.gold_schema.fact_hma_financial_transaction VALUES
(1, 20240601, 1, 1, 1, 'Project Award', 5512841.35, 3669186.45, 1),
(2, 20240601, 2, 2, 2, 'Project Award', 4440564.68, 3680619.57, 1),
(3, 20240601, 3, 3, 3, 'Project Award', 1695708.13, 3249824.54, 1),
(4, 20240601, 4, 4, 4, 'Project Award', 4990885.61, 6450889.08, 1),
(5, 20240601, 5, 5, 5, 'Project Award', 4378196.49, 1823230.52, 1),
(6, 20240601, 6, 6, 6, 'Project Award', 7317314.74, 1408498.46, 1),
(7, 20240601, 7, 7, 1, 'Project Award', 1889781.26, 6119550.48, 1),
(8, 20240601, 8, 8, 2, 'Project Award', 2922043.36, 3617966.14, 1),
(9, 20240601, 9, 9, 3, 'Project Award', 6791105.2, 3158977.76, 1),
(10, 20240601, 10, 10, 4, 'Project Award', 4926844.7, 1104545.91, 1),
(11, 20240601, 11, 11, 5, 'Project Award', 6033400.83, 2611392.42, 1),
(12, 20240601, 12, 12, 6, 'Project Award', 5250321.46, 1658556.95, 1),
(13, 20240601, 1, 1, 1, 'Project Award', 4054081.75, 5046779.05, 1),
(14, 20240601, 2, 2, 2, 'Project Award', 1520456.07, 6378404.7, 1),
(15, 20240601, 3, 3, 3, 'Project Award', 5060358.56, 4518317.94, 1);

-- Table: fact_nfip_claim
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.fact_nfip_claim (
    claim_key BIGINT,
    date_of_loss_key BIGINT,
    geography_key BIGINT,
    community_key BIGINT,
    property_profile_key BIGINT,
    disaster_key BIGINT,
    amount_paid_on_building_claim DOUBLE,
    amount_paid_on_contents_claim DOUBLE,
    amount_paid_on_icc_claim DOUBLE,
    net_building_payment_amount DOUBLE,
    net_contents_payment_amount DOUBLE,
    total_building_insurance_coverage DOUBLE,
    total_contents_insurance_coverage DOUBLE,
    claim_count BIGINT
);

-- Sample seed data for fact_nfip_claim
INSERT INTO insurance_dev_gold.gold_schema.fact_nfip_claim VALUES
(1.0, 20240912.0, 1.0, 1.0, 1.0, 1.0, 17250.0, 0.0, 0.0, 17250.0, 0.0, 250000.0, 100000.0, 1.0),
(2.0, 20260902.0, 2.0, 2.0, 2.0, 2.0, 0.0, 0.0, 0.0, 0.0, 0.0, 100000.0, 100000.0, 1.0),
(3.0, 20201120.0, 3.0, 3.0, 3.0, 3.0, 60200.0, 0.0, 0.0, 60200.0, 0.0, 100000.0, 50000.0, 1.0),
(4.0, 20250802.0, 4.0, 4.0, 4.0, 4.0, 7830.0, 0.0, 0.0, 7830.0, 0.0, 100000.0, 50000.0, 1.0),
(5.0, 20260422.0, 5.0, 5.0, 5.0, 5.0, 7740.0, 0.0, 0.0, 7740.0, 0.0, 350000.0, 100000.0, 1.0),
(6.0, 20190829.0, 6.0, 6.0, 6.0, 6.0, 10040.0, 0.0, 0.0, 10040.0, 0.0, 100000.0, 25000.0, 1.0),
(7.0, 20241026.0, 7.0, 7.0, 7.0, 1.0, 14170.0, 0.0, 0.0, 14170.0, 0.0, 150000.0, 75000.0, 1.0),
(8.0, 20220106.0, 8.0, 8.0, 1.0, 2.0, 20350.0, 0.0, 0.0, 20350.0, 0.0, 150000.0, 75000.0, 1.0),
(9.0, 20240320.0, 9.0, 9.0, 2.0, 3.0, 14610.0, 0.0, 0.0, 14610.0, 0.0, 150000.0, 75000.0, 1.0),
(10.0, 20201023.0, 10.0, 10.0, 3.0, 4.0, 9010.0, 0.0, 0.0, 9010.0, 0.0, 200000.0, 50000.0, 1.0),
(11.0, 20180601.0, 11.0, 11.0, 4.0, 5.0, 72390.0, 0.0, 0.0, 72390.0, 0.0, 200000.0, 25000.0, 1.0),
(12.0, 20210227.0, 12.0, 12.0, 5.0, 6.0, 30760.0, 0.0, 0.0, 30760.0, 0.0, 200000.0, 25000.0, 1.0),
(13.0, 20250312.0, 1.0, 1.0, 6.0, 1.0, 23110.0, 0.0, 0.0, 23110.0, 0.0, 150000.0, 50000.0, 1.0),
(14.0, 20251012.0, 2.0, 2.0, 7.0, 2.0, 22990.0, 0.0, 0.0, 22990.0, 0.0, 150000.0, 50000.0, 1.0),
(15.0, 20230906.0, 3.0, 3.0, 1.0, 3.0, 26750.0, 0.0, 0.0, 26750.0, 0.0, 150000.0, 100000.0, 1.0),
(16.0, 20260710.0, 4.0, 4.0, 2.0, 4.0, 0.0, 0.0, 0.0, 0.0, 0.0, 150000.0, 100000.0, 1.0),
(17.0, 20251216.0, 5.0, 5.0, 3.0, 5.0, 5120.0, 0.0, 0.0, 5120.0, 0.0, 150000.0, 50000.0, 1.0),
(18.0, 20190122.0, 6.0, 6.0, 4.0, 6.0, 3730.0, 0.0, 0.0, 3730.0, 0.0, 100000.0, 100000.0, 1.0),
(19.0, 20200216.0, 7.0, 7.0, 5.0, 1.0, 25900.0, 0.0, 0.0, 25900.0, 0.0, 100000.0, 100000.0, 1.0),
(20.0, 20240412.0, 8.0, 8.0, 6.0, 2.0, 6110.0, 0.0, 0.0, 6110.0, 0.0, 100000.0, 100000.0, 1.0),
(21.0, 20250725.0, 9.0, 9.0, 7.0, 3.0, 26830.0, 0.0, 0.0, 26830.0, 0.0, 150000.0, 100000.0, 1.0),
(22.0, 20250521.0, 10.0, 10.0, 1.0, 4.0, 7700.0, 0.0, 0.0, 7700.0, 0.0, 250000.0, 50000.0, 1.0),
(23.0, 20210516.0, 11.0, 11.0, 2.0, 5.0, 78240.0, 0.0, 0.0, 78240.0, 0.0, 350000.0, 50000.0, 1.0),
(24.0, 20240531.0, 12.0, 12.0, 3.0, 6.0, 4370.0, 0.0, 0.0, 4370.0, 0.0, 350000.0, 50000.0, 1.0),
(25.0, 20260211.0, 1.0, 1.0, 4.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 350000.0, 50000.0, 1.0);

-- Table: fact_nfip_policy
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.fact_nfip_policy (
    policy_key BIGINT,
    effective_date_key BIGINT,
    expiration_date_key BIGINT,
    geography_key BIGINT,
    community_key BIGINT,
    property_profile_key BIGINT,
    total_building_insurance_coverage DOUBLE,
    total_contents_insurance_coverage DOUBLE,
    total_insurance_premium DOUBLE,
    hfiaa_surcharge DOUBLE,
    federal_policy_fee DOUBLE,
    policy_count BIGINT
);

-- Sample seed data for fact_nfip_policy
INSERT INTO insurance_dev_gold.gold_schema.fact_nfip_policy VALUES
(1.0, 20240301.0, 20250301.0, 1.0, 1.0, 1.0, 250000.0, 100000.0, 1850.0, 25.0, 50.0, 1.0),
(2.0, 20250301.0, 20260301.0, 2.0, 2.0, 2.0, 250000.0, 100000.0, 1868.5, 25.0, 50.0, 1.0),
(3.0, 20260301.0, 20270301.0, 3.0, 3.0, 3.0, 250000.0, 100000.0, 1887.0, 25.0, 50.0, 1.0),
(4.0, 20231026.0, 20241026.0, 4.0, 4.0, 4.0, 100000.0, 100000.0, 1897.0, 25.0, 50.0, 1.0),
(5.0, 20241026.0, 20251026.0, 5.0, 5.0, 5.0, 100000.0, 100000.0, 1915.97, 25.0, 50.0, 1.0),
(6.0, 20251026.0, 20261026.0, 6.0, 6.0, 6.0, 100000.0, 100000.0, 1934.94, 25.0, 50.0, 1.0),
(7.0, 20190419.0, 20200419.0, 7.0, 7.0, 7.0, 250000.0, 50000.0, 825.0, 25.0, 50.0, 1.0),
(8.0, 20200419.0, 20210419.0, 8.0, 8.0, 1.0, 250000.0, 50000.0, 833.25, 25.0, 50.0, 1.0),
(9.0, 20210419.0, 20220419.0, 9.0, 9.0, 2.0, 250000.0, 50000.0, 841.5, 25.0, 50.0, 1.0),
(10.0, 20220419.0, 20230419.0, 10.0, 10.0, 3.0, 250000.0, 50000.0, 849.75, 25.0, 50.0, 1.0),
(11.0, 20230419.0, 20240419.0, 11.0, 11.0, 4.0, 250000.0, 50000.0, 858.0, 25.0, 50.0, 1.0),
(12.0, 20240419.0, 20250419.0, 12.0, 12.0, 5.0, 250000.0, 50000.0, 866.25, 25.0, 50.0, 1.0),
(13.0, 20250419.0, 20260419.0, 1.0, 1.0, 6.0, 250000.0, 50000.0, 874.5, 25.0, 50.0, 1.0),
(14.0, 20260419.0, 20270419.0, 2.0, 2.0, 7.0, 250000.0, 50000.0, 882.75, 25.0, 50.0, 1.0),
(15.0, 20190429.0, 20200429.0, 3.0, 3.0, 1.0, 350000.0, 100000.0, 3712.0, 25.0, 50.0, 1.0),
(16.0, 20200429.0, 20210429.0, 4.0, 4.0, 2.0, 350000.0, 100000.0, 3749.12, 25.0, 50.0, 1.0),
(17.0, 20210429.0, 20220429.0, 5.0, 5.0, 3.0, 350000.0, 100000.0, 3786.24, 25.0, 50.0, 1.0),
(18.0, 20220429.0, 20230429.0, 6.0, 6.0, 4.0, 350000.0, 100000.0, 3823.36, 25.0, 50.0, 1.0),
(19.0, 20230429.0, 20240429.0, 7.0, 7.0, 5.0, 350000.0, 100000.0, 3860.48, 25.0, 50.0, 1.0),
(20.0, 20240429.0, 20250429.0, 8.0, 8.0, 6.0, 350000.0, 100000.0, 3897.6, 25.0, 50.0, 1.0),
(21.0, 20250429.0, 20260429.0, 9.0, 9.0, 7.0, 350000.0, 100000.0, 3934.72, 25.0, 50.0, 1.0),
(22.0, 20260429.0, 20270429.0, 10.0, 10.0, 1.0, 350000.0, 100000.0, 3971.84, 25.0, 50.0, 1.0),
(23.0, 20190506.0, 20200506.0, 11.0, 11.0, 2.0, 150000.0, 100000.0, 791.0, 25.0, 50.0, 1.0),
(24.0, 20200506.0, 20210506.0, 12.0, 12.0, 3.0, 150000.0, 100000.0, 798.91, 25.0, 50.0, 1.0),
(25.0, 20210506.0, 20220506.0, 1.0, 1.0, 4.0, 150000.0, 100000.0, 806.82, 25.0, 50.0, 1.0);

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

-- Table: gold_mitigation_vs_claims_by_state
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.gold_mitigation_vs_claims_by_state (
    state STRING,
    total_mitigation_spend DOUBLE,
    total_claims_paid DOUBLE
);

-- Sample seed data for gold_mitigation_vs_claims_by_state
INSERT INTO insurance_dev_gold.gold_schema.gold_mitigation_vs_claims_by_state VALUES
('TX', 879116.04, 3257270.0),
('FL', 685869.7, 2309740.0),
('LA', 305452.73, 1185600.0),
('NC', 305296.12, 836660.0),
('SC', 301046.53, 999650.0);

-- Table: gold_policy_report
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.gold_policy_report (
    policy_id STRING,
    customer_id STRING,
    property_id STRING,
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
('POL-2024-77520-0001', 'CUST-10492', 'PROP-58210', 'TX', '48000', 'Baytown', '2024-03-01 00:00:00', '2025-03-01 00:00:00', 250000.0, 100000.0, 1850.0, 'uuid-POL-2024-77520-0001'),
('POL-2025-77520-0002', 'CUST-10492', 'PROP-58210', 'TX', '48000', 'Baytown', '2025-03-01 00:00:00', '2026-03-01 00:00:00', 250000.0, 100000.0, 1868.5, 'uuid-POL-2025-77520-0002'),
('POL-2026-77520-0003', 'CUST-10492', 'PROP-58210', 'TX', '48000', 'Baytown', '2026-03-01 00:00:00', '2027-03-01 00:00:00', 250000.0, 100000.0, 1887.0, 'uuid-POL-2026-77520-0003'),
('POL-2023-70001-0004', 'CUST-20000', 'PROP-60005', 'LA', '48003', 'Metairie', '2023-10-26 00:00:00', '2024-10-26 00:00:00', 100000.0, 100000.0, 1897.0, 'uuid-POL-2023-70001-0004'),
('POL-2024-70001-0005', 'CUST-20000', 'PROP-60005', 'LA', '48003', 'Metairie', '2024-10-26 00:00:00', '2025-10-26 00:00:00', 100000.0, 100000.0, 1915.97, 'uuid-POL-2024-70001-0005'),
('POL-2025-70001-0006', 'CUST-20000', 'PROP-60005', 'LA', '48003', 'Metairie', '2025-10-26 00:00:00', '2026-10-26 00:00:00', 100000.0, 100000.0, 1934.94, 'uuid-POL-2025-70001-0006'),
('POL-2019-29401-0007', 'CUST-20001', 'PROP-60014', 'SC', '48010', 'Charleston', '2019-04-19 00:00:00', '2020-04-19 00:00:00', 250000.0, 50000.0, 825.0, 'uuid-POL-2019-29401-0007'),
('POL-2020-29401-0008', 'CUST-20001', 'PROP-60014', 'SC', '48010', 'Charleston', '2020-04-19 00:00:00', '2021-04-19 00:00:00', 250000.0, 50000.0, 833.25, 'uuid-POL-2020-29401-0008'),
('POL-2021-29401-0009', 'CUST-20001', 'PROP-60014', 'SC', '48010', 'Charleston', '2021-04-19 00:00:00', '2022-04-19 00:00:00', 250000.0, 50000.0, 841.5, 'uuid-POL-2021-29401-0009'),
('POL-2022-29401-0010', 'CUST-20001', 'PROP-60014', 'SC', '48010', 'Charleston', '2022-04-19 00:00:00', '2023-04-19 00:00:00', 250000.0, 50000.0, 849.75, 'uuid-POL-2022-29401-0010'),
('POL-2023-29401-0011', 'CUST-20001', 'PROP-60014', 'SC', '48010', 'Charleston', '2023-04-19 00:00:00', '2024-04-19 00:00:00', 250000.0, 50000.0, 858.0, 'uuid-POL-2023-29401-0011'),
('POL-2024-29401-0012', 'CUST-20001', 'PROP-60014', 'SC', '48010', 'Charleston', '2024-04-19 00:00:00', '2025-04-19 00:00:00', 250000.0, 50000.0, 866.25, 'uuid-POL-2024-29401-0012'),
('POL-2025-29401-0013', 'CUST-20001', 'PROP-60014', 'SC', '48010', 'Charleston', '2025-04-19 00:00:00', '2026-04-19 00:00:00', 250000.0, 50000.0, 874.5, 'uuid-POL-2025-29401-0013'),
('POL-2026-29401-0014', 'CUST-20001', 'PROP-60014', 'SC', '48010', 'Charleston', '2026-04-19 00:00:00', '2027-04-19 00:00:00', 250000.0, 50000.0, 882.75, 'uuid-POL-2026-29401-0014'),
('POL-2019-27959-0015', 'CUST-20001', 'PROP-60015', 'NC', '48009', 'Nags Head', '2019-04-29 00:00:00', '2020-04-29 00:00:00', 350000.0, 100000.0, 3712.0, 'uuid-POL-2019-27959-0015'),
('POL-2020-27959-0016', 'CUST-20001', 'PROP-60015', 'NC', '48009', 'Nags Head', '2020-04-29 00:00:00', '2021-04-29 00:00:00', 350000.0, 100000.0, 3749.12, 'uuid-POL-2020-27959-0016'),
('POL-2021-27959-0017', 'CUST-20001', 'PROP-60015', 'NC', '48009', 'Nags Head', '2021-04-29 00:00:00', '2022-04-29 00:00:00', 350000.0, 100000.0, 3786.24, 'uuid-POL-2021-27959-0017'),
('POL-2022-27959-0018', 'CUST-20001', 'PROP-60015', 'NC', '48009', 'Nags Head', '2022-04-29 00:00:00', '2023-04-29 00:00:00', 350000.0, 100000.0, 3823.36, 'uuid-POL-2022-27959-0018'),
('POL-2023-27959-0019', 'CUST-20001', 'PROP-60015', 'NC', '48009', 'Nags Head', '2023-04-29 00:00:00', '2024-04-29 00:00:00', 350000.0, 100000.0, 3860.48, 'uuid-POL-2023-27959-0019'),
('POL-2024-27959-0020', 'CUST-20001', 'PROP-60015', 'NC', '48009', 'Nags Head', '2024-04-29 00:00:00', '2025-04-29 00:00:00', 350000.0, 100000.0, 3897.6, 'uuid-POL-2024-27959-0020'),
('POL-2025-27959-0021', 'CUST-20001', 'PROP-60015', 'NC', '48009', 'Nags Head', '2025-04-29 00:00:00', '2026-04-29 00:00:00', 350000.0, 100000.0, 3934.72, 'uuid-POL-2025-27959-0021'),
('POL-2026-27959-0022', 'CUST-20001', 'PROP-60015', 'NC', '48009', 'Nags Head', '2026-04-29 00:00:00', '2027-04-29 00:00:00', 350000.0, 100000.0, 3971.84, 'uuid-POL-2026-27959-0022'),
('POL-2019-77520-0023', 'CUST-20001', 'PROP-60016', 'TX', '48000', 'Baytown', '2019-05-06 00:00:00', '2020-05-06 00:00:00', 150000.0, 100000.0, 791.0, 'uuid-POL-2019-77520-0023'),
('POL-2020-77520-0024', 'CUST-20001', 'PROP-60016', 'TX', '48000', 'Baytown', '2020-05-06 00:00:00', '2021-05-06 00:00:00', 150000.0, 100000.0, 798.91, 'uuid-POL-2020-77520-0024'),
('POL-2021-77520-0025', 'CUST-20001', 'PROP-60016', 'TX', '48000', 'Baytown', '2021-05-06 00:00:00', '2022-05-06 00:00:00', 150000.0, 100000.0, 806.82, 'uuid-POL-2021-77520-0025');

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
('TX', 'VE', 'Pre-FIRM', True, 'Gulf Coast', 'ACTIVE', 183, 36, 857869.56, 522648.0, 58560000.0, 1.6414, 0.1967, 23829.71, 5, 17, 65.66, 24.8, 15.0, -8.0, 1.0, 69.4, 'High', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'VE', 'Pre-FIRM', False, 'Gulf Coast', 'ACTIVE', 196, 61, 1157973.98, 658560.0, 62720000.0, 1.7583, 0.3112, 18983.18, 5, 13, 70.33, 24.8, 15.0, 0.0, 1.0, 74.5, 'High', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'VE', 'Post-FIRM', True, 'Gulf Coast', 'ACTIVE', 204, 25, 1090859.25, 485520.0, 65280000.0, 2.2468, 0.1225, 43634.37, 5, 23, 89.87, 24.8, 5.0, -8.0, 1.0, 49.5, 'Medium', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'VE', 'Post-FIRM', False, 'Gulf Coast', 'ACTIVE', 235, 45, 1122336.45, 658000.0, 75200000.0, 1.7057, 0.1915, 24940.81, 5, 17, 68.23, 24.8, 5.0, 0.0, 1.0, 66.0, 'High', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'AE', 'Pre-FIRM', True, 'Gulf Coast', 'ACTIVE', 239, 47, 2084708.97, 463182.0, 76480000.0, 4.5008, 0.1967, 44355.51, 3, 24, 180.03, 20.0, 15.0, -8.0, 1.0, 45.7, 'Medium', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'AE', 'Pre-FIRM', False, 'Gulf Coast', 'ACTIVE', 195, 61, 1583375.78, 444600.0, 62400000.0, 3.5613, 0.3128, 25956.98, 3, 15, 142.45, 20.0, 15.0, 0.0, 1.0, 64.0, 'Medium', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'AE', 'Post-FIRM', True, 'Gulf Coast', 'ACTIVE', 223, 27, 494244.99, 360145.0, 71360000.0, 1.3723, 0.1211, 18305.37, 5, 16, 54.89, 20.0, 5.0, -8.0, 1.0, 35.2, 'Medium', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'AE', 'Post-FIRM', False, 'Gulf Coast', 'ACTIVE', 210, 40, 1552808.8, 399000.0, 67200000.0, 3.8918, 0.1905, 38820.22, 6, 20, 155.67, 20.0, 5.0, 0.0, 1.0, 47.5, 'Medium', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'A', 'Pre-FIRM', True, 'Gulf Coast', 'ACTIVE', 54, 3, 102543.42, 60588.0, 17280000.0, 1.6925, 0.0556, 34181.14, 3, 26, 67.7, 17.6, 15.0, -8.0, 0.36, 46.5, 'Medium', 'Pre-FIRM Structure', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'A', 'Pre-FIRM', False, 'Gulf Coast', 'ACTIVE', 45, 5, 206903.65, 59400.0, 14400000.0, 3.4832, 0.1111, 41380.73, 4, 13, 139.33, 17.6, 15.0, 0.0, 0.3, 58.4, 'Medium', 'Pre-FIRM Structure', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'A', 'Post-FIRM', True, 'Gulf Coast', 'ACTIVE', 172, 7, 189876.54, 160820.0, 55040000.0, 1.1807, 0.0407, 27125.22, 5, 18, 47.23, 17.6, 5.0, -8.0, 1.0, 34.8, 'Medium', 'Elevation Deficit', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'A', 'Post-FIRM', False, 'Gulf Coast', 'ACTIVE', 195, 13, 417751.62, 214500.0, 62400000.0, 1.9476, 0.0667, 32134.74, 6, 24, 77.9, 17.6, 5.0, 0.0, 1.0, 46.8, 'Medium', 'Elevation Deficit', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'B', 'Pre-FIRM', True, 'Gulf Coast', 'ACTIVE', 171, 12, 393397.32, 191862.0, 54720000.0, 2.0504, 0.0702, 32783.11, 5, 24, 82.02, 8.8, 15.0, -8.0, 1.0, 21.6, 'Low', 'Pre-FIRM Structure', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'B', 'Pre-FIRM', False, 'Gulf Coast', 'ACTIVE', 66, 7, 209200.18, 87120.0, 21120000.0, 2.4013, 0.1061, 29885.74, 2, 26, 96.05, 8.8, 15.0, 0.0, 0.44, 41.3, 'Medium', 'Pre-FIRM Structure', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'B', 'Post-FIRM', True, 'Gulf Coast', 'ACTIVE', 137, 6, 189579.84, 128095.0, 43840000.0, 1.48, 0.0438, 31596.64, 2, 29, 59.2, 8.8, 5.0, -8.0, 0.91, 7.9, 'Low', 'Elevation Deficit', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'B', 'Post-FIRM', False, 'Gulf Coast', 'ACTIVE', 146, 10, 300205.1, 160600.0, 46720000.0, 1.8693, 0.0685, 30020.51, 4, 8, 74.77, 8.8, 5.0, 0.0, 0.97, 27.0, 'Low', 'Elevation Deficit', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'X', 'Pre-FIRM', True, 'Gulf Coast', 'ACTIVE', 231, 16, 685983.68, 259182.0, 73920000.0, 2.6467, 0.0693, 42873.98, 3, 29, 105.87, 6.0, 15.0, -8.0, 1.0, 18.5, 'Low', 'Pre-FIRM Structure', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'X', 'Pre-FIRM', False, 'Gulf Coast', 'ACTIVE', 146, 16, 362235.2, 192720.0, 46720000.0, 1.8796, 0.1096, 22639.7, 3, 22, 75.18, 6.0, 15.0, 0.0, 0.97, 28.9, 'Low', 'Pre-FIRM Structure', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'X', 'Post-FIRM', True, 'Gulf Coast', 'ACTIVE', 108, 4, 117148.28, 100980.0, 34560000.0, 1.1601, 0.037, 29287.07, 6, 25, 46.4, 6.0, 5.0, -8.0, 0.72, 5.4, 'Low', 'Elevation Deficit', 2018, 2025, '2026-10-13 12:00:00'),
('TX', 'X', 'Post-FIRM', False, 'Gulf Coast', 'ACTIVE', 45, 3, 96288.99, 49500.0, 14400000.0, 1.9452, 0.0667, 32096.33, 5, 29, 77.81, 6.0, 5.0, 0.0, 0.3, 10.1, 'Low', 'Elevation Deficit', 2018, 2025, '2026-10-13 12:00:00'),
('FL', 'VE', 'Pre-FIRM', True, 'South Atlantic', 'ACTIVE', 177, 35, 894613.3, 505512.0, 56640000.0, 1.7697, 0.1977, 25560.38, 4, 24, 70.79, 24.8, 15.0, -8.0, 1.0, 62.6, 'Medium', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('FL', 'VE', 'Pre-FIRM', False, 'South Atlantic', 'ACTIVE', 59, 18, 650602.62, 198240.0, 18880000.0, 3.2819, 0.3051, 36144.59, 2, 12, 131.28, 24.8, 15.0, 0.0, 0.39, 75.8, 'High', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('FL', 'VE', 'Post-FIRM', True, 'South Atlantic', 'ACTIVE', 48, 5, 234165.15, 114240.0, 15360000.0, 2.0498, 0.1042, 46833.03, 6, 16, 81.99, 24.8, 5.0, -8.0, 0.32, 56.5, 'Medium', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('FL', 'VE', 'Post-FIRM', False, 'South Atlantic', 'ACTIVE', 140, 27, 1097558.37, 392000.0, 44800000.0, 2.7999, 0.1929, 40650.31, 2, 26, 112.0, 24.8, 5.0, 0.0, 0.93, 68.7, 'High', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('FL', 'AE', 'Pre-FIRM', True, 'South Atlantic', 'ACTIVE', 203, 40, 1008873.2, 393414.0, 64960000.0, 2.5644, 0.197, 25221.83, 6, 10, 102.58, 20.0, 15.0, -8.0, 1.0, 49.4, 'Medium', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00');

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
('TX', 'Gulf Coast', 3201, 444, 13215291.599999998, 5657022.0, 6, 418, 3, 20, 40.0, 2.3361, 'Medium'),
('FL', 'South Atlantic', 2711, 329, 9914126.819999998, 4261056.0, 6, 385, 2, 20, 40.1, 2.3267, 'Medium'),
('LA', 'Gulf Coast', 3061, 373, 11896527.970000003, 4975635.0, 6, 321, 2, 20, 39.1, 2.391, 'Medium'),
('NC', 'South Atlantic', 3208, 427, 13738459.150000002, 5316147.0, 6, 339, 1, 20, 38.1, 2.5843, 'Medium'),
('SC', 'South Atlantic', 3298, 399, 13648563.31, 5257703.0, 6, 360, 2, 20, 39.1, 2.5959, 'Medium');

-- Table: id_map
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.id_map (
    entity STRING,
    uuid_value STRING,
    seq BIGINT,
    display_id STRING
);

-- Sample seed data for id_map
INSERT INTO insurance_dev_gold.gold_schema.id_map VALUES
('policy', 'uuid-POL-2024-77520-0001', 1, 'POL-2024-77520-0001'),
('policy', 'uuid-POL-2025-77520-0002', 2, 'POL-2025-77520-0002'),
('policy', 'uuid-POL-2026-77520-0003', 3, 'POL-2026-77520-0003'),
('policy', 'uuid-POL-2023-70001-0004', 4, 'POL-2023-70001-0004'),
('policy', 'uuid-POL-2024-70001-0005', 5, 'POL-2024-70001-0005'),
('policy', 'uuid-POL-2025-70001-0006', 6, 'POL-2025-70001-0006'),
('policy', 'uuid-POL-2019-29401-0007', 7, 'POL-2019-29401-0007'),
('policy', 'uuid-POL-2020-29401-0008', 8, 'POL-2020-29401-0008'),
('policy', 'uuid-POL-2021-29401-0009', 9, 'POL-2021-29401-0009'),
('policy', 'uuid-POL-2022-29401-0010', 10, 'POL-2022-29401-0010'),
('policy', 'uuid-POL-2023-29401-0011', 11, 'POL-2023-29401-0011'),
('policy', 'uuid-POL-2024-29401-0012', 12, 'POL-2024-29401-0012'),
('policy', 'uuid-POL-2025-29401-0013', 13, 'POL-2025-29401-0013'),
('policy', 'uuid-POL-2026-29401-0014', 14, 'POL-2026-29401-0014'),
('policy', 'uuid-POL-2019-27959-0015', 15, 'POL-2019-27959-0015'),
('policy', 'uuid-POL-2020-27959-0016', 16, 'POL-2020-27959-0016'),
('policy', 'uuid-POL-2021-27959-0017', 17, 'POL-2021-27959-0017'),
('policy', 'uuid-POL-2022-27959-0018', 18, 'POL-2022-27959-0018'),
('policy', 'uuid-POL-2023-27959-0019', 19, 'POL-2023-27959-0019'),
('policy', 'uuid-POL-2024-27959-0020', 20, 'POL-2024-27959-0020'),
('policy', 'uuid-POL-2025-27959-0021', 21, 'POL-2025-27959-0021'),
('policy', 'uuid-POL-2026-27959-0022', 22, 'POL-2026-27959-0022'),
('policy', 'uuid-POL-2019-77520-0023', 23, 'POL-2019-77520-0023'),
('policy', 'uuid-POL-2020-77520-0024', 24, 'POL-2020-77520-0024'),
('policy', 'uuid-POL-2021-77520-0025', 25, 'POL-2021-77520-0025');

