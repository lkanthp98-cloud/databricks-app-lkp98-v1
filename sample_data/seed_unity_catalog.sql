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
('CLM-2024-80001', 'POL-2024-77520-0001', 'COM-48050', '2024-09-12 00:00:00', 2024, 'TX', 'TX-001', 17250.0, 0.0, 0.0, 250000.0, 100000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2024-77520-0001'),
('CLM-2021-80002', 'POL-2021-38103-0034', 'COM-48035', '2021-10-25 00:00:00', 2021, 'TN', 'TN-001', 0.0, 0.0, 0.0, 200000.0, 25000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2021-38103-0034'),
('CLM-2024-80003', 'POL-2024-40202-0042', 'COM-48024', '2024-05-11 00:00:00', 2024, 'KY', 'KY-001', 3040.0, 0.0, 0.0, 250000.0, 100000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2024-40202-0042'),
('CLM-2025-80004', 'POL-2024-11561-0049', 'COM-48051', '2025-08-02 00:00:00', 2025, 'NY', 'NY-001', 64070.0, 0.0, 0.0, 100000.0, 50000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2024-11561-0049'),
('CLM-2026-80005', 'POL-2025-11561-0050', 'COM-48001', '2026-05-17 00:00:00', 2026, 'NY', 'NY-001', 7840.0, 0.0, 0.0, 100000.0, 50000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2025-11561-0050'),
('CLM-2025-80006', 'POL-2025-33901-0096', 'COM-48038', '2025-03-02 00:00:00', 2025, 'FL', 'FL-001', 10580.0, 0.0, 0.0, 250000.0, 25000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2025-33901-0096'),
('CLM-2023-80007', 'POL-2022-90802-0114', 'COM-48010', '2023-07-17 00:00:00', 2023, 'CA', 'CA-001', 6490.0, 0.0, 0.0, 150000.0, 75000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2022-90802-0114'),
('CLM-2019-80008', 'POL-2019-19971-0120', 'COM-48038', '2019-06-17 00:00:00', 2019, 'DE', 'DE-001', 31510.0, 0.0, 0.0, 200000.0, 50000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2019-19971-0120'),
('CLM-2023-80009', 'POL-2022-19971-0123', 'COM-48022', '2023-03-05 00:00:00', 2023, 'DE', 'DE-001', 74830.0, 0.0, 0.0, 200000.0, 50000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2022-19971-0123'),
('CLM-2026-80010', 'POL-2025-19971-0126', 'COM-48028', '2026-02-06 00:00:00', 2026, 'DE', 'DE-001', 18800.0, 0.0, 0.0, 200000.0, 50000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2025-19971-0126'),
('CLM-2025-80011', 'POL-2025-77541-0136', 'COM-48017', '2025-10-14 00:00:00', 2025, 'TX', 'TX-001', 13880.0, 0.0, 0.0, 200000.0, 25000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2025-77541-0136'),
('CLM-2022-80012', 'POL-2022-11561-0152', 'COM-48020', '2022-09-16 00:00:00', 2022, 'NY', 'NY-001', 19910.0, 0.0, 0.0, 150000.0, 100000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2022-11561-0152'),
('CLM-2026-80013', 'POL-2026-21842-0158', 'COM-48047', '2026-06-17 00:00:00', 2026, 'MD', 'MD-001', 0.0, 0.0, 0.0, 150000.0, 100000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2026-21842-0158'),
('CLM-2022-80014', 'POL-2021-77541-0166', 'COM-48015', '2022-09-06 00:00:00', 2022, 'TX', 'TX-001', 44970.0, 0.0, 0.0, 100000.0, 25000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2021-77541-0166'),
('CLM-2023-80015', 'POL-2022-06604-0181', 'COM-48005', '2023-03-22 00:00:00', 2023, 'CT', 'CT-001', 1350.0, 0.0, 0.0, 100000.0, 100000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2022-06604-0181'),
('CLM-2021-80016', 'POL-2021-77541-0206', 'COM-48006', '2021-10-30 00:00:00', 2021, 'TX', 'TX-001', 30570.0, 0.0, 0.0, 150000.0, 75000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2021-77541-0206'),
('CLM-2026-80017', 'POL-2026-77541-0211', 'COM-48042', '2026-08-12 00:00:00', 2026, 'TX', 'TX-001', 0.0, 0.0, 0.0, 150000.0, 75000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2026-77541-0211'),
('CLM-2022-80018', 'POL-2021-29401-0214', 'COM-48042', '2022-10-05 00:00:00', 2022, 'SC', 'SC-001', 156360.0, 0.0, 0.0, 350000.0, 50000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2021-29401-0214'),
('CLM-2021-80019', 'POL-2021-74103-0237', 'COM-48012', '2021-12-08 00:00:00', 2021, 'OK', 'OK-001', 95250.0, 0.0, 0.0, 500000.0, 100000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2021-74103-0237'),
('CLM-2023-80020', 'POL-2022-21401-0245', 'COM-48022', '2023-06-14 00:00:00', 2023, 'MD', 'MD-001', 27970.0, 0.0, 0.0, 250000.0, 50000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2022-21401-0245'),
('CLM-2026-80021', 'POL-2025-21401-0248', 'COM-48000', '2026-05-10 00:00:00', 2026, 'MD', 'MD-001', 71070.0, 0.0, 0.0, 250000.0, 50000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2025-21401-0248'),
('CLM-2025-80022', 'POL-2025-21401-0254', 'COM-48018', '2025-06-13 00:00:00', 2025, 'MD', 'MD-001', 3030.0, 0.0, 0.0, 150000.0, 25000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2025-21401-0254'),
('CLM-2026-80023', 'POL-2025-21842-0257', 'COM-48051', '2026-08-12 00:00:00', 2026, 'MD', 'MD-001', 0.0, 0.0, 0.0, 500000.0, 75000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2025-21842-0257'),
('CLM-2026-80024', 'POL-2025-04101-0262', 'COM-48021', '2026-05-07 00:00:00', 2026, 'ME', 'ME-001', 0.0, 0.0, 0.0, 100000.0, 75000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2025-04101-0262'),
('CLM-2026-80025', 'POL-2026-11901-0270', 'COM-48030', '2026-06-26 00:00:00', 2026, 'NY', 'NY-001', 0.0, 0.0, 0.0, 200000.0, 75000.0, 'Single Family', 'AE', True, False, 'SYN-POL-POL-2026-11901-0270');

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
('COM-48005', 'Gulfport', 'Harrison', 'MS', True, False, 7, 0.2, 0.1, 'NONE'),
('COM-48006', 'Pascagoula', 'Jackson', 'MS', True, False, 6, 0.15, 0.05, 'NONE'),
('COM-48007', 'Mobile', 'Mobile', 'AL', True, False, 7, 0.2, 0.1, 'NONE'),
('COM-48008', 'Gulf Shores', 'Baldwin', 'AL', True, False, 8, 0.15, 0.05, 'NONE'),
('COM-48009', 'Miami', 'Miami-Dade', 'FL', True, False, 8, 0.2, 0.1, 'NONE'),
('COM-48010', 'Fort Myers', 'Lee', 'FL', True, False, 7, 0.15, 0.05, 'NONE'),
('COM-48011', 'Tampa', 'Hillsborough', 'FL', True, False, 6, 0.2, 0.1, 'NONE'),
('COM-48012', 'Savannah', 'Chatham', 'GA', True, False, 7, 0.15, 0.05, 'NONE'),
('COM-48013', 'Brunswick', 'Glynn', 'GA', True, False, 8, 0.2, 0.1, 'NONE'),
('COM-48014', 'Charleston', 'Charleston', 'SC', True, False, 8, 0.15, 0.05, 'NONE'),
('COM-48015', 'Myrtle Beach', 'Horry', 'SC', True, False, 7, 0.2, 0.1, 'NONE'),
('COM-48016', 'Wilmington', 'New Hanover', 'NC', True, False, 6, 0.15, 0.05, 'NONE'),
('COM-48017', 'Nags Head', 'Dare', 'NC', True, False, 7, 0.2, 0.1, 'NONE'),
('COM-48018', 'Virginia Beach', 'Virginia Beach', 'VA', True, False, 8, 0.15, 0.05, 'NONE'),
('COM-48019', 'Norfolk', 'Norfolk', 'VA', True, False, 8, 0.2, 0.1, 'NONE'),
('COM-48020', 'Annapolis', 'Anne Arundel', 'MD', True, False, 7, 0.15, 0.05, 'NONE'),
('COM-48021', 'Ocean City', 'Worcester', 'MD', True, False, 6, 0.2, 0.1, 'NONE'),
('COM-48022', 'Rehoboth Beach', 'Sussex', 'DE', True, False, 7, 0.15, 0.05, 'NONE'),
('COM-48023', 'Ocean City', 'Cape May', 'NJ', True, False, 8, 0.2, 0.1, 'NONE'),
('COM-48024', 'Atlantic City', 'Atlantic', 'NJ', True, False, 8, 0.15, 0.05, 'NONE');

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
('COV-B-POL-2023-33602-0004', 'POL-2023-33602-0004', 'BUILDING', 100000.0),
('COV-C-POL-2023-33602-0004', 'POL-2023-33602-0004', 'CONTENTS', 100000.0),
('COV-B-POL-2024-33602-0005', 'POL-2024-33602-0005', 'BUILDING', 100000.0),
('COV-C-POL-2024-33602-0005', 'POL-2024-33602-0005', 'CONTENTS', 100000.0),
('COV-B-POL-2025-33602-0006', 'POL-2025-33602-0006', 'BUILDING', 100000.0),
('COV-C-POL-2025-33602-0006', 'POL-2025-33602-0006', 'CONTENTS', 100000.0),
('COV-B-POL-2019-85001-0007', 'POL-2019-85001-0007', 'BUILDING', 250000.0),
('COV-C-POL-2019-85001-0007', 'POL-2019-85001-0007', 'CONTENTS', 50000.0),
('COV-B-POL-2020-85001-0008', 'POL-2020-85001-0008', 'BUILDING', 250000.0),
('COV-C-POL-2020-85001-0008', 'POL-2020-85001-0008', 'CONTENTS', 50000.0),
('COV-B-POL-2021-85001-0009', 'POL-2021-85001-0009', 'BUILDING', 250000.0),
('COV-C-POL-2021-85001-0009', 'POL-2021-85001-0009', 'CONTENTS', 50000.0),
('COV-B-POL-2022-85001-0010', 'POL-2022-85001-0010', 'BUILDING', 250000.0),
('COV-C-POL-2022-85001-0010', 'POL-2022-85001-0010', 'CONTENTS', 50000.0),
('COV-B-POL-2023-85001-0011', 'POL-2023-85001-0011', 'BUILDING', 250000.0),
('COV-C-POL-2023-85001-0011', 'POL-2023-85001-0011', 'CONTENTS', 50000.0),
('COV-B-POL-2024-85001-0012', 'POL-2024-85001-0012', 'BUILDING', 250000.0),
('COV-C-POL-2024-85001-0012', 'POL-2024-85001-0012', 'CONTENTS', 50000.0),
('COV-B-POL-2025-85001-0013', 'POL-2025-85001-0013', 'BUILDING', 250000.0);

-- Table: customer
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.customer (
    customer_id STRING,
    state STRING,
    county_code STRING,
    community_id STRING
);

-- Sample seed data for customer
INSERT INTO insurance_dev_gold.gold_schema.customer VALUES
('CUST-10492', 'TX', 'Harris', 'COM-48004'),
('CUST-20000', 'FL', 'Hillsborough', 'COM-48006'),
('CUST-20001', 'CO', 'Denver', 'COM-48022'),
('CUST-20002', 'TN', 'Shelby', 'COM-48026'),
('CUST-20003', 'NC', 'New Hanover', 'COM-48023'),
('CUST-20004', 'KY', 'Jefferson', 'COM-48020'),
('CUST-20005', 'NY', 'Nassau', 'COM-48013'),
('CUST-20006', 'WA', 'King', 'COM-48007'),
('CUST-20007', 'NY', 'Nassau', 'COM-48021'),
('CUST-20008', 'DE', 'Sussex', 'COM-48048'),
('CUST-20009', 'MA', 'Barnstable', 'COM-48026'),
('CUST-20010', 'TX', 'Galveston', 'COM-48043'),
('CUST-20011', 'DE', 'Sussex', 'COM-48037'),
('CUST-20012', 'FL', 'Lee', 'COM-48017'),
('CUST-20013', 'NY', 'Suffolk', 'COM-48027'),
('CUST-20014', 'CA', 'Los Angeles', 'COM-48029'),
('CUST-20015', 'CA', 'Los Angeles', 'COM-48019'),
('CUST-20016', 'DE', 'Sussex', 'COM-48034'),
('CUST-20017', 'CA', 'San Diego', 'COM-48014'),
('CUST-20018', 'CA', 'San Diego', 'COM-48028'),
('CUST-20019', 'NY', 'Nassau', 'COM-48014'),
('CUST-20020', 'MD', 'Worcester', 'COM-48040'),
('CUST-20021', 'CA', 'San Diego', 'COM-48033'),
('CUST-20022', 'CT', 'Fairfield', 'COM-48004'),
('CUST-20023', 'GA', 'Chatham', 'COM-48037');

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
('DOC-FNOL-CLM-2021-80002', 'CLM-2021-80002', 'First Notice of Loss', '2021-10-25 00:00:00'),
('DOC-ADJ-CLM-2021-80002', 'CLM-2021-80002', 'Adjuster Report', '2021-11-01 00:00:00'),
('DOC-FNOL-CLM-2024-80003', 'CLM-2024-80003', 'First Notice of Loss', '2024-05-11 00:00:00'),
('DOC-ADJ-CLM-2024-80003', 'CLM-2024-80003', 'Adjuster Report', '2024-05-18 00:00:00'),
('DOC-FNOL-CLM-2025-80004', 'CLM-2025-80004', 'First Notice of Loss', '2025-08-02 00:00:00'),
('DOC-ADJ-CLM-2025-80004', 'CLM-2025-80004', 'Adjuster Report', '2025-08-09 00:00:00'),
('DOC-FNOL-CLM-2026-80005', 'CLM-2026-80005', 'First Notice of Loss', '2026-05-17 00:00:00'),
('DOC-ADJ-CLM-2026-80005', 'CLM-2026-80005', 'Adjuster Report', '2026-05-24 00:00:00'),
('DOC-FNOL-CLM-2025-80006', 'CLM-2025-80006', 'First Notice of Loss', '2025-03-02 00:00:00'),
('DOC-ADJ-CLM-2025-80006', 'CLM-2025-80006', 'Adjuster Report', '2025-03-09 00:00:00'),
('DOC-FNOL-CLM-2023-80007', 'CLM-2023-80007', 'First Notice of Loss', '2023-07-17 00:00:00'),
('DOC-ADJ-CLM-2023-80007', 'CLM-2023-80007', 'Adjuster Report', '2023-07-24 00:00:00'),
('DOC-FNOL-CLM-2019-80008', 'CLM-2019-80008', 'First Notice of Loss', '2019-06-17 00:00:00'),
('DOC-ADJ-CLM-2019-80008', 'CLM-2019-80008', 'Adjuster Report', '2019-06-24 00:00:00'),
('DOC-FNOL-CLM-2023-80009', 'CLM-2023-80009', 'First Notice of Loss', '2023-03-05 00:00:00'),
('DOC-ADJ-CLM-2023-80009', 'CLM-2023-80009', 'Adjuster Report', '2023-03-12 00:00:00'),
('DOC-FNOL-CLM-2026-80010', 'CLM-2026-80010', 'First Notice of Loss', '2026-02-06 00:00:00'),
('DOC-ADJ-CLM-2026-80010', 'CLM-2026-80010', 'Adjuster Report', '2026-02-13 00:00:00'),
('DOC-FNOL-CLM-2025-80011', 'CLM-2025-80011', 'First Notice of Loss', '2025-10-14 00:00:00'),
('DOC-ADJ-CLM-2025-80011', 'CLM-2025-80011', 'Adjuster Report', '2025-10-21 00:00:00'),
('DOC-FNOL-CLM-2022-80012', 'CLM-2022-80012', 'First Notice of Loss', '2022-09-16 00:00:00'),
('DOC-ADJ-CLM-2022-80012', 'CLM-2022-80012', 'Adjuster Report', '2022-09-23 00:00:00'),
('DOC-FNOL-CLM-2026-80013', 'CLM-2026-80013', 'First Notice of Loss', '2026-06-17 00:00:00');

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
('INSP-PROP-60005', 'PROP-60005', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'FL', 'Hillsborough', 'Tampa', '33602', 'GEO-FL-33602'),
('INSP-PROP-60014', 'PROP-60014', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'AZ', 'Maricopa', 'Phoenix', '85001', 'GEO-AZ-85001'),
('INSP-PROP-60015', 'PROP-60015', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'CO', 'Denver', 'Denver', '80202', 'GEO-CO-80202'),
('INSP-PROP-60016', 'PROP-60016', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'TX', 'Harris', 'Baytown', '77520', 'GEO-TX-77520'),
('INSP-PROP-60023', 'PROP-60023', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'TN', 'Shelby', 'Memphis', '38103', 'GEO-TN-38103'),
('INSP-PROP-60032', 'PROP-60032', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'NC', 'New Hanover', 'Wilmington', '28401', 'GEO-NC-28401'),
('INSP-PROP-60033', 'PROP-60033', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'MI', 'Wayne', 'Detroit', '48226', 'GEO-MI-48226'),
('INSP-PROP-60041', 'PROP-60041', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'KY', 'Jefferson', 'Louisville', '40202', 'GEO-KY-40202'),
('INSP-PROP-60050', 'PROP-60050', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'NY', 'Nassau', 'Long Beach', '11561', 'GEO-NY-11561'),
('INSP-PROP-60059', 'PROP-60059', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'WA', 'King', 'Seattle', '98101', 'GEO-WA-98101'),
('INSP-PROP-60068', 'PROP-60068', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'NY', 'Nassau', 'Long Beach', '11561', 'GEO-NY-11561'),
('INSP-PROP-60077', 'PROP-60077', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'DE', 'Sussex', 'Rehoboth Beach', '19971', 'GEO-DE-19971'),
('INSP-PROP-60078', 'PROP-60078', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'WI', 'Milwaukee', 'Milwaukee', '53202', 'GEO-WI-53202'),
('INSP-PROP-60086', 'PROP-60086', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'MA', 'Barnstable', 'Barnstable', '02630', 'GEO-MA-02630'),
('INSP-PROP-60095', 'PROP-60095', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'FL', 'Miami-Dade', 'Miami', '33101', 'GEO-FL-33101'),
('INSP-PROP-60096', 'PROP-60096', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'TX', 'Galveston', 'Galveston', '77550', 'GEO-TX-77550'),
('INSP-PROP-60104', 'PROP-60104', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'DE', 'Sussex', 'Rehoboth Beach', '19971', 'GEO-DE-19971'),
('INSP-PROP-60113', 'PROP-60113', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'FL', 'Lee', 'Fort Myers', '33901', 'GEO-FL-33901'),
('INSP-PROP-60122', 'PROP-60122', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'NY', 'Suffolk', 'Riverhead', '11901', 'GEO-NY-11901'),
('INSP-PROP-60131', 'PROP-60131', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'CA', 'Los Angeles', 'Long Beach', '90802', 'GEO-CA-90802'),
('INSP-PROP-60140', 'PROP-60140', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'CA', 'Los Angeles', 'Long Beach', '90802', 'GEO-CA-90802'),
('INSP-PROP-60149', 'PROP-60149', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'DE', 'Sussex', 'Rehoboth Beach', '19971', 'GEO-DE-19971'),
('INSP-PROP-60150', 'PROP-60150', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'TX', 'Brazoria', 'Freeport', '77541', 'GEO-TX-77541'),
('INSP-PROP-60158', 'PROP-60158', 'AGT-01', 'HMA-ELEV-2024', 'Flood Mitigation Assistance', 'Elevation Certificate Verification', 'Single Family', 'Slab-on-Grade', 'None', 450.0, 1, 'CA', 'San Diego', 'San Diego', '92101', 'GEO-CA-92101');

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
('POL-2024-77520-0001', 'CUST-10492', 'PROP-58210', 'AGT-05', 'COM-48050', '2024-03-01 00:00:00', '2025-03-01 00:00:00', 250000.0, 100000.0, 1850.0, 25.0, 50.0, 'Single Family', 'AE', 'TX', '48000', 'SYN-PROP-PROP-58210', 'SYN-POL-POL-2024-77520-0001'),
('POL-2025-77520-0002', 'CUST-10492', 'PROP-58210', 'AGT-02', 'COM-48025', '2025-03-01 00:00:00', '2026-03-01 00:00:00', 250000.0, 100000.0, 1868.5, 25.0, 50.0, 'Single Family', 'AE', 'TX', '48000', 'SYN-PROP-PROP-58210', 'SYN-POL-POL-2025-77520-0002'),
('POL-2026-77520-0003', 'CUST-10492', 'PROP-58210', 'AGT-04', 'COM-48012', '2026-03-01 00:00:00', '2027-03-01 00:00:00', 250000.0, 100000.0, 1887.0, 25.0, 50.0, 'Single Family', 'AE', 'TX', '48000', 'SYN-PROP-PROP-58210', 'SYN-POL-POL-2026-77520-0003'),
('POL-2023-33602-0004', 'CUST-20000', 'PROP-60005', 'AGT-04', 'COM-48003', '2023-10-26 00:00:00', '2024-10-26 00:00:00', 100000.0, 100000.0, 1897.0, 25.0, 50.0, 'Single Family', 'AE', 'FL', '48011', 'SYN-PROP-PROP-60005', 'SYN-POL-POL-2023-33602-0004'),
('POL-2024-33602-0005', 'CUST-20000', 'PROP-60005', 'AGT-03', 'COM-48045', '2024-10-26 00:00:00', '2025-10-26 00:00:00', 100000.0, 100000.0, 1915.97, 25.0, 50.0, 'Single Family', 'AE', 'FL', '48011', 'SYN-PROP-PROP-60005', 'SYN-POL-POL-2024-33602-0005'),
('POL-2025-33602-0006', 'CUST-20000', 'PROP-60005', 'AGT-05', 'COM-48005', '2025-10-26 00:00:00', '2026-10-26 00:00:00', 100000.0, 100000.0, 1934.94, 25.0, 50.0, 'Single Family', 'AE', 'FL', '48011', 'SYN-PROP-PROP-60005', 'SYN-POL-POL-2025-33602-0006'),
('POL-2019-85001-0007', 'CUST-20001', 'PROP-60014', 'AGT-01', 'COM-48041', '2019-04-19 00:00:00', '2020-04-19 00:00:00', 250000.0, 50000.0, 825.0, 25.0, 50.0, 'Single Family', 'AE', 'AZ', '48047', 'SYN-PROP-PROP-60014', 'SYN-POL-POL-2019-85001-0007'),
('POL-2020-85001-0008', 'CUST-20001', 'PROP-60014', 'AGT-03', 'COM-48049', '2020-04-19 00:00:00', '2021-04-19 00:00:00', 250000.0, 50000.0, 833.25, 25.0, 50.0, 'Single Family', 'AE', 'AZ', '48047', 'SYN-PROP-PROP-60014', 'SYN-POL-POL-2020-85001-0008'),
('POL-2021-85001-0009', 'CUST-20001', 'PROP-60014', 'AGT-03', 'COM-48001', '2021-04-19 00:00:00', '2022-04-19 00:00:00', 250000.0, 50000.0, 841.5, 25.0, 50.0, 'Single Family', 'AE', 'AZ', '48047', 'SYN-PROP-PROP-60014', 'SYN-POL-POL-2021-85001-0009'),
('POL-2022-85001-0010', 'CUST-20001', 'PROP-60014', 'AGT-01', 'COM-48016', '2022-04-19 00:00:00', '2023-04-19 00:00:00', 250000.0, 50000.0, 849.75, 25.0, 50.0, 'Single Family', 'AE', 'AZ', '48047', 'SYN-PROP-PROP-60014', 'SYN-POL-POL-2022-85001-0010'),
('POL-2023-85001-0011', 'CUST-20001', 'PROP-60014', 'AGT-05', 'COM-48017', '2023-04-19 00:00:00', '2024-04-19 00:00:00', 250000.0, 50000.0, 858.0, 25.0, 50.0, 'Single Family', 'AE', 'AZ', '48047', 'SYN-PROP-PROP-60014', 'SYN-POL-POL-2023-85001-0011'),
('POL-2024-85001-0012', 'CUST-20001', 'PROP-60014', 'AGT-05', 'COM-48044', '2024-04-19 00:00:00', '2025-04-19 00:00:00', 250000.0, 50000.0, 866.25, 25.0, 50.0, 'Single Family', 'AE', 'AZ', '48047', 'SYN-PROP-PROP-60014', 'SYN-POL-POL-2024-85001-0012'),
('POL-2025-85001-0013', 'CUST-20001', 'PROP-60014', 'AGT-02', 'COM-48003', '2025-04-19 00:00:00', '2026-04-19 00:00:00', 250000.0, 50000.0, 874.5, 25.0, 50.0, 'Single Family', 'AE', 'AZ', '48047', 'SYN-PROP-PROP-60014', 'SYN-POL-POL-2025-85001-0013'),
('POL-2026-85001-0014', 'CUST-20001', 'PROP-60014', 'AGT-02', 'COM-48008', '2026-04-19 00:00:00', '2027-04-19 00:00:00', 250000.0, 50000.0, 882.75, 25.0, 50.0, 'Single Family', 'AE', 'AZ', '48047', 'SYN-PROP-PROP-60014', 'SYN-POL-POL-2026-85001-0014'),
('POL-2019-80202-0015', 'CUST-20001', 'PROP-60015', 'AGT-05', 'COM-48011', '2019-04-29 00:00:00', '2020-04-29 00:00:00', 350000.0, 100000.0, 3712.0, 25.0, 50.0, 'Single Family', 'AE', 'CO', '48046', 'SYN-PROP-PROP-60015', 'SYN-POL-POL-2019-80202-0015'),
('POL-2020-80202-0016', 'CUST-20001', 'PROP-60015', 'AGT-05', 'COM-48003', '2020-04-29 00:00:00', '2021-04-29 00:00:00', 350000.0, 100000.0, 3749.12, 25.0, 50.0, 'Single Family', 'AE', 'CO', '48046', 'SYN-PROP-PROP-60015', 'SYN-POL-POL-2020-80202-0016'),
('POL-2021-80202-0017', 'CUST-20001', 'PROP-60015', 'AGT-02', 'COM-48004', '2021-04-29 00:00:00', '2022-04-29 00:00:00', 350000.0, 100000.0, 3786.24, 25.0, 50.0, 'Single Family', 'AE', 'CO', '48046', 'SYN-PROP-PROP-60015', 'SYN-POL-POL-2021-80202-0017'),
('POL-2022-80202-0018', 'CUST-20001', 'PROP-60015', 'AGT-02', 'COM-48009', '2022-04-29 00:00:00', '2023-04-29 00:00:00', 350000.0, 100000.0, 3823.36, 25.0, 50.0, 'Single Family', 'AE', 'CO', '48046', 'SYN-PROP-PROP-60015', 'SYN-POL-POL-2022-80202-0018'),
('POL-2023-80202-0019', 'CUST-20001', 'PROP-60015', 'AGT-04', 'COM-48040', '2023-04-29 00:00:00', '2024-04-29 00:00:00', 350000.0, 100000.0, 3860.48, 25.0, 50.0, 'Single Family', 'AE', 'CO', '48046', 'SYN-PROP-PROP-60015', 'SYN-POL-POL-2023-80202-0019'),
('POL-2024-80202-0020', 'CUST-20001', 'PROP-60015', 'AGT-05', 'COM-48047', '2024-04-29 00:00:00', '2025-04-29 00:00:00', 350000.0, 100000.0, 3897.6, 25.0, 50.0, 'Single Family', 'AE', 'CO', '48046', 'SYN-PROP-PROP-60015', 'SYN-POL-POL-2024-80202-0020'),
('POL-2025-80202-0021', 'CUST-20001', 'PROP-60015', 'AGT-03', 'COM-48008', '2025-04-29 00:00:00', '2026-04-29 00:00:00', 350000.0, 100000.0, 3934.72, 25.0, 50.0, 'Single Family', 'AE', 'CO', '48046', 'SYN-PROP-PROP-60015', 'SYN-POL-POL-2025-80202-0021'),
('POL-2026-80202-0022', 'CUST-20001', 'PROP-60015', 'AGT-03', 'COM-48017', '2026-04-29 00:00:00', '2027-04-29 00:00:00', 350000.0, 100000.0, 3971.84, 25.0, 50.0, 'Single Family', 'AE', 'CO', '48046', 'SYN-PROP-PROP-60015', 'SYN-POL-POL-2026-80202-0022'),
('POL-2019-77520-0023', 'CUST-20001', 'PROP-60016', 'AGT-03', 'COM-48023', '2019-05-06 00:00:00', '2020-05-06 00:00:00', 150000.0, 100000.0, 791.0, 25.0, 50.0, 'Single Family', 'AE', 'TX', '48000', 'SYN-PROP-PROP-60016', 'SYN-POL-POL-2019-77520-0023'),
('POL-2020-77520-0024', 'CUST-20001', 'PROP-60016', 'AGT-01', 'COM-48009', '2020-05-06 00:00:00', '2021-05-06 00:00:00', 150000.0, 100000.0, 798.91, 25.0, 50.0, 'Single Family', 'AE', 'TX', '48000', 'SYN-PROP-PROP-60016', 'SYN-POL-POL-2020-77520-0024'),
('POL-2021-77520-0025', 'CUST-20001', 'PROP-60016', 'AGT-05', 'COM-48011', '2021-05-06 00:00:00', '2022-05-06 00:00:00', 150000.0, 100000.0, 806.82, 25.0, 50.0, 'Single Family', 'AE', 'TX', '48000', 'SYN-PROP-PROP-60016', 'SYN-POL-POL-2021-77520-0025');

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
('PROP-58210', 'COM-48018', 'TX', 'TX', 'Harris', '77520', 'Baytown', 'AE', 29.7416, -94.9766, 'Single Family Residence', '1995-06-15 00:00:00', True, 1, False, False, True, True, 'GEO-TX-77520', 'ZIP-77520'),
('PROP-60005', 'COM-48026', 'FL', 'FL', 'Hillsborough', '33602', 'Tampa', 'AE', 27.9661, -82.4222, 'Single Family Residence', '1995-06-15 00:00:00', True, 0, False, False, False, True, 'GEO-FL-33602', 'ZIP-33602'),
('PROP-60014', 'COM-48042', 'AZ', 'AZ', 'Maricopa', '85001', 'Phoenix', 'X', 33.4234, -112.1137, 'Single Family Residence', '2012-08-20 00:00:00', True, 0, False, False, False, True, 'GEO-AZ-85001', 'ZIP-85001'),
('PROP-60015', 'COM-48005', 'CO', 'CO', 'Denver', '80202', 'Denver', 'AE', 39.7211, -104.964, 'Single Family Residence', '2012-08-20 00:00:00', True, 0, False, False, False, True, 'GEO-CO-80202', 'ZIP-80202'),
('PROP-60016', 'COM-48016', 'TX', 'TX', 'Harris', '77520', 'Baytown', 'X', 29.7538, -94.9808, 'Single Family Residence', '1995-06-15 00:00:00', True, 0, False, False, False, True, 'GEO-TX-77520', 'ZIP-77520'),
('PROP-60023', 'COM-48001', 'TN', 'TN', 'Shelby', '38103', 'Memphis', 'AE', 35.1821, -90.0204, 'Single Family Residence', '2012-08-20 00:00:00', True, 1, False, False, False, True, 'GEO-TN-38103', 'ZIP-38103'),
('PROP-60032', 'COM-48050', 'NC', 'NC', 'New Hanover', '28401', 'Wilmington', 'B', 34.1966, -77.9339, 'Single Family Residence', '2012-08-20 00:00:00', True, 0, False, False, False, True, 'GEO-NC-28401', 'ZIP-28401'),
('PROP-60033', 'COM-48049', 'MI', 'MI', 'Wayne', '48226', 'Detroit', 'A', 42.3454, -83.0682, 'Single Family Residence', '2012-08-20 00:00:00', True, 0, False, False, True, True, 'GEO-MI-48226', 'ZIP-48226'),
('PROP-60041', 'COM-48014', 'KY', 'KY', 'Jefferson', '40202', 'Louisville', 'A', 38.2179, -85.7816, 'Single Family Residence', '2012-08-20 00:00:00', True, 1, False, False, False, True, 'GEO-KY-40202', 'ZIP-40202'),
('PROP-60050', 'COM-48037', 'NY', 'NY', 'Nassau', '11561', 'Long Beach', 'VE', 40.5903, -73.6651, 'Single Family Residence', '1995-06-15 00:00:00', True, 2, True, False, False, True, 'GEO-NY-11561', 'ZIP-11561'),
('PROP-60059', 'COM-48045', 'WA', 'WA', 'King', '98101', 'Seattle', 'AE', 47.625, -122.3105, 'Single Family Residence', '1995-06-15 00:00:00', True, 0, False, False, False, True, 'GEO-WA-98101', 'ZIP-98101'),
('PROP-60068', 'COM-48020', 'NY', 'NY', 'Nassau', '11561', 'Long Beach', 'AE', 40.5613, -73.659, 'Single Family Residence', '1995-06-15 00:00:00', True, 0, False, False, False, True, 'GEO-NY-11561', 'ZIP-11561'),
('PROP-60077', 'COM-48029', 'DE', 'DE', 'Sussex', '19971', 'Rehoboth Beach', 'VE', 38.7454, -75.0864, 'Single Family Residence', '1995-06-15 00:00:00', True, 0, False, False, False, True, 'GEO-DE-19971', 'ZIP-19971'),
('PROP-60078', 'COM-48033', 'WI', 'WI', 'Milwaukee', '53202', 'Milwaukee', 'A', 43.0004, -87.8723, 'Single Family Residence', '2012-08-20 00:00:00', True, 0, False, False, False, True, 'GEO-WI-53202', 'ZIP-53202'),
('PROP-60086', 'COM-48005', 'MA', 'MA', 'Barnstable', '02630', 'Barnstable', 'X', 41.7102, -70.3095, 'Single Family Residence', '1995-06-15 00:00:00', True, 0, False, False, False, True, 'GEO-MA-02630', 'ZIP-02630'),
('PROP-60095', 'COM-48030', 'FL', 'FL', 'Miami-Dade', '33101', 'Miami', 'X', 25.7392, -80.1657, 'Single Family Residence', '2012-08-20 00:00:00', True, 0, False, False, False, True, 'GEO-FL-33101', 'ZIP-33101'),
('PROP-60096', 'COM-48052', 'TX', 'TX', 'Galveston', '77550', 'Galveston', 'AE', 29.3346, -94.7985, 'Single Family Residence', '2012-08-20 00:00:00', True, 0, False, False, False, True, 'GEO-TX-77550', 'ZIP-77550'),
('PROP-60104', 'COM-48034', 'DE', 'DE', 'Sussex', '19971', 'Rehoboth Beach', 'X', 38.7115, -75.1139, 'Single Family Residence', '2012-08-20 00:00:00', True, 0, False, False, False, True, 'GEO-DE-19971', 'ZIP-19971'),
('PROP-60113', 'COM-48047', 'FL', 'FL', 'Lee', '33901', 'Fort Myers', 'AE', 26.6546, -81.8554, 'Single Family Residence', '2012-08-20 00:00:00', True, 1, False, False, False, True, 'GEO-FL-33901', 'ZIP-33901'),
('PROP-60122', 'COM-48005', 'NY', 'NY', 'Suffolk', '11901', 'Riverhead', 'VE', 40.9289, -72.6817, 'Single Family Residence', '2012-08-20 00:00:00', True, 0, False, False, False, True, 'GEO-NY-11901', 'ZIP-11901'),
('PROP-60131', 'COM-48046', 'CA', 'CA', 'Los Angeles', '90802', 'Long Beach', 'VE', 33.7946, -118.1666, 'Single Family Residence', '1995-06-15 00:00:00', True, 0, False, False, False, True, 'GEO-CA-90802', 'ZIP-90802'),
('PROP-60140', 'COM-48006', 'CA', 'CA', 'Los Angeles', '90802', 'Long Beach', 'AE', 33.7821, -118.1649, 'Single Family Residence', '1995-06-15 00:00:00', True, 1, False, False, False, True, 'GEO-CA-90802', 'ZIP-90802'),
('PROP-60149', 'COM-48005', 'DE', 'DE', 'Sussex', '19971', 'Rehoboth Beach', 'VE', 38.6961, -75.0588, 'Single Family Residence', '2012-08-20 00:00:00', True, 3, True, False, False, True, 'GEO-DE-19971', 'ZIP-19971'),
('PROP-60150', 'COM-48046', 'TX', 'TX', 'Brazoria', '77541', 'Freeport', 'AE', 28.91, -95.4552, 'Single Family Residence', '1995-06-15 00:00:00', True, 1, False, False, True, True, 'GEO-TX-77541', 'ZIP-77541'),
('PROP-60158', 'COM-48047', 'CA', 'CA', 'San Diego', '92101', 'San Diego', 'AE', 32.7518, -117.1923, 'Single Family Residence', '1995-06-15 00:00:00', True, 0, False, False, False, True, 'GEO-CA-92101', 'ZIP-92101');

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
(6, 'COM-48005', 'Gulfport', 'MS', 'Regular', 7),
(7, 'COM-48006', 'Pascagoula', 'MS', 'Regular', 6),
(8, 'COM-48007', 'Mobile', 'AL', 'Regular', 7),
(9, 'COM-48008', 'Gulf Shores', 'AL', 'Regular', 8),
(10, 'COM-48009', 'Miami', 'FL', 'Regular', 8),
(11, 'COM-48010', 'Fort Myers', 'FL', 'Regular', 7),
(12, 'COM-48011', 'Tampa', 'FL', 'Regular', 6),
(13, 'COM-48012', 'Savannah', 'GA', 'Regular', 7),
(14, 'COM-48013', 'Brunswick', 'GA', 'Regular', 8),
(15, 'COM-48014', 'Charleston', 'SC', 'Regular', 8),
(16, 'COM-48015', 'Myrtle Beach', 'SC', 'Regular', 7),
(17, 'COM-48016', 'Wilmington', 'NC', 'Regular', 6),
(18, 'COM-48017', 'Nags Head', 'NC', 'Regular', 7),
(19, 'COM-48018', 'Virginia Beach', 'VA', 'Regular', 8),
(20, 'COM-48019', 'Norfolk', 'VA', 'Regular', 8),
(21, 'COM-48020', 'Annapolis', 'MD', 'Regular', 7),
(22, 'COM-48021', 'Ocean City', 'MD', 'Regular', 6),
(23, 'COM-48022', 'Rehoboth Beach', 'DE', 'Regular', 7),
(24, 'COM-48023', 'Ocean City', 'NJ', 'Regular', 8),
(25, 'COM-48024', 'Atlantic City', 'NJ', 'Regular', 8);

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
(6, 'MS', '45', '48005', '48005', 'Gulf Coast'),
(7, 'MS', '46', '48006', '48006', 'Gulf Coast'),
(8, 'AL', '47', '48007', '48007', 'Gulf Coast'),
(9, 'AL', '48', '48008', '48008', 'Gulf Coast'),
(10, 'FL', '49', '48009', '48009', 'South Atlantic'),
(11, 'FL', '410', '48010', '48010', 'South Atlantic'),
(12, 'FL', '411', '48011', '48011', 'South Atlantic'),
(13, 'GA', '412', '48012', '48012', 'South Atlantic'),
(14, 'GA', '413', '48013', '48013', 'South Atlantic'),
(15, 'SC', '414', '48014', '48014', 'South Atlantic'),
(16, 'SC', '415', '48015', '48015', 'South Atlantic'),
(17, 'NC', '416', '48016', '48016', 'South Atlantic'),
(18, 'NC', '417', '48017', '48017', 'South Atlantic'),
(19, 'VA', '418', '48018', '48018', 'South Atlantic'),
(20, 'VA', '419', '48019', '48019', 'South Atlantic'),
(21, 'MD', '420', '48020', '48020', 'South Atlantic'),
(22, 'MD', '421', '48021', '48021', 'South Atlantic'),
(23, 'DE', '422', '48022', '48022', 'South Atlantic'),
(24, 'NJ', '423', '48023', '48023', 'Mid-Atlantic'),
(25, 'NJ', '424', '48024', '48024', 'Mid-Atlantic');

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
(6, 'PDMC-PL-MS-2025', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'MS Division of Emergency Management', 'City of Gulfport', 'Regional Stormwater Resiliency - Gulfport'),
(7, 'PDMC-PL-MS-2026', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'MS Division of Emergency Management', 'City of Pascagoula', 'Regional Stormwater Resiliency - Pascagoula'),
(8, 'PDMC-PL-AL-2027', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'AL Division of Emergency Management', 'City of Mobile', 'Regional Stormwater Resiliency - Mobile'),
(9, 'PDMC-PL-AL-2028', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'AL Division of Emergency Management', 'City of Gulf Shores', 'Regional Stormwater Resiliency - Gulf Shores'),
(10, 'PDMC-PL-FL-2029', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'FL Division of Emergency Management', 'City of Miami', 'Regional Stormwater Resiliency - Miami'),
(11, 'PDMC-PL-FL-20210', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'FL Division of Emergency Management', 'City of Fort Myers', 'Regional Stormwater Resiliency - Fort Myers'),
(12, 'PDMC-PL-FL-20211', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'FL Division of Emergency Management', 'City of Tampa', 'Regional Stormwater Resiliency - Tampa'),
(13, 'PDMC-PL-GA-20212', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'GA Division of Emergency Management', 'City of Savannah', 'Regional Stormwater Resiliency - Savannah'),
(14, 'PDMC-PL-GA-20213', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'GA Division of Emergency Management', 'City of Brunswick', 'Regional Stormwater Resiliency - Brunswick'),
(15, 'PDMC-PL-SC-20214', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'SC Division of Emergency Management', 'City of Charleston', 'Regional Stormwater Resiliency - Charleston'),
(16, 'PDMC-PL-SC-20215', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'SC Division of Emergency Management', 'City of Myrtle Beach', 'Regional Stormwater Resiliency - Myrtle Beach'),
(17, 'PDMC-PL-NC-20216', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'NC Division of Emergency Management', 'City of Wilmington', 'Regional Stormwater Resiliency - Wilmington'),
(18, 'PDMC-PL-NC-20217', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'NC Division of Emergency Management', 'City of Nags Head', 'Regional Stormwater Resiliency - Nags Head'),
(19, 'PDMC-PL-VA-20218', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'VA Division of Emergency Management', 'City of Virginia Beach', 'Regional Stormwater Resiliency - Virginia Beach'),
(20, 'PDMC-PL-VA-20219', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'VA Division of Emergency Management', 'City of Norfolk', 'Regional Stormwater Resiliency - Norfolk'),
(21, 'PDMC-PL-MD-20220', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'MD Division of Emergency Management', 'City of Annapolis', 'Regional Stormwater Resiliency - Annapolis'),
(22, 'PDMC-PL-MD-20221', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'MD Division of Emergency Management', 'City of Ocean City', 'Regional Stormwater Resiliency - Ocean City'),
(23, 'PDMC-PL-DE-20222', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'DE Division of Emergency Management', 'City of Rehoboth Beach', 'Regional Stormwater Resiliency - Rehoboth Beach'),
(24, 'PDMC-PL-NJ-20223', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'NJ Division of Emergency Management', 'City of Ocean City', 'Regional Stormwater Resiliency - Ocean City'),
(25, 'PDMC-PL-NJ-20224', 'Pre-Disaster Mitigation', 'Flood Elevation and Stormwater Management', 'Active', 'NJ Division of Emergency Management', 'City of Atlantic City', 'Regional Stormwater Resiliency - Atlantic City');

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
(1, 20240601, 1, 1, 1, 'Project Award', 4021906.69, 5733498.16, 1),
(2, 20240601, 2, 2, 2, 'Project Award', 4811650.18, 5510407.84, 1),
(3, 20240601, 3, 3, 3, 'Project Award', 2403138.45, 4755082.29, 1),
(4, 20240601, 4, 4, 4, 'Project Award', 6635434.7, 2729469.18, 1),
(5, 20240601, 5, 5, 5, 'Project Award', 3438340.85, 5451093.59, 1),
(6, 20240601, 6, 6, 6, 'Project Award', 1768170.11, 2641127.65, 1),
(7, 20240601, 7, 7, 1, 'Project Award', 5563118.96, 4987345.91, 1),
(8, 20240601, 8, 8, 2, 'Project Award', 6539135.44, 5702667.93, 1),
(9, 20240601, 9, 9, 3, 'Project Award', 2063362.84, 1287301.86, 1),
(10, 20240601, 10, 10, 4, 'Project Award', 3488946.56, 1536857.23, 1),
(11, 20240601, 11, 11, 5, 'Project Award', 3236288.51, 3722852.31, 1),
(12, 20240601, 12, 12, 6, 'Project Award', 7578340.87, 4998873.28, 1),
(13, 20240601, 13, 13, 1, 'Project Award', 2367618.42, 6096753.94, 1),
(14, 20240601, 14, 14, 2, 'Project Award', 5894542.45, 1976548.42, 1),
(15, 20240601, 15, 15, 3, 'Project Award', 5400381.06, 2145976.24, 1);

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
(2.0, 20211025.0, 2.0, 2.0, 2.0, 2.0, 0.0, 0.0, 0.0, 0.0, 0.0, 200000.0, 25000.0, 1.0),
(3.0, 20240511.0, 3.0, 3.0, 3.0, 3.0, 3040.0, 0.0, 0.0, 3040.0, 0.0, 250000.0, 100000.0, 1.0),
(4.0, 20250802.0, 4.0, 4.0, 4.0, 4.0, 64070.0, 0.0, 0.0, 64070.0, 0.0, 100000.0, 50000.0, 1.0),
(5.0, 20260517.0, 5.0, 5.0, 5.0, 5.0, 7840.0, 0.0, 0.0, 7840.0, 0.0, 100000.0, 50000.0, 1.0),
(6.0, 20250302.0, 6.0, 6.0, 6.0, 6.0, 10580.0, 0.0, 0.0, 10580.0, 0.0, 250000.0, 25000.0, 1.0),
(7.0, 20230717.0, 7.0, 7.0, 7.0, 1.0, 6490.0, 0.0, 0.0, 6490.0, 0.0, 150000.0, 75000.0, 1.0),
(8.0, 20190617.0, 8.0, 8.0, 1.0, 2.0, 31510.0, 0.0, 0.0, 31510.0, 0.0, 200000.0, 50000.0, 1.0),
(9.0, 20230305.0, 9.0, 9.0, 2.0, 3.0, 74830.0, 0.0, 0.0, 74830.0, 0.0, 200000.0, 50000.0, 1.0),
(10.0, 20260206.0, 10.0, 10.0, 3.0, 4.0, 18800.0, 0.0, 0.0, 18800.0, 0.0, 200000.0, 50000.0, 1.0),
(11.0, 20251014.0, 11.0, 11.0, 4.0, 5.0, 13880.0, 0.0, 0.0, 13880.0, 0.0, 200000.0, 25000.0, 1.0),
(12.0, 20220916.0, 12.0, 12.0, 5.0, 6.0, 19910.0, 0.0, 0.0, 19910.0, 0.0, 150000.0, 100000.0, 1.0),
(13.0, 20260617.0, 13.0, 13.0, 6.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 150000.0, 100000.0, 1.0),
(14.0, 20220906.0, 14.0, 14.0, 7.0, 2.0, 44970.0, 0.0, 0.0, 44970.0, 0.0, 100000.0, 25000.0, 1.0),
(15.0, 20230322.0, 15.0, 15.0, 1.0, 3.0, 1350.0, 0.0, 0.0, 1350.0, 0.0, 100000.0, 100000.0, 1.0),
(16.0, 20211030.0, 16.0, 16.0, 2.0, 4.0, 30570.0, 0.0, 0.0, 30570.0, 0.0, 150000.0, 75000.0, 1.0),
(17.0, 20260812.0, 17.0, 17.0, 3.0, 5.0, 0.0, 0.0, 0.0, 0.0, 0.0, 150000.0, 75000.0, 1.0),
(18.0, 20221005.0, 18.0, 18.0, 4.0, 6.0, 156360.0, 0.0, 0.0, 156360.0, 0.0, 350000.0, 50000.0, 1.0),
(19.0, 20211208.0, 19.0, 19.0, 5.0, 1.0, 95250.0, 0.0, 0.0, 95250.0, 0.0, 500000.0, 100000.0, 1.0),
(20.0, 20230614.0, 20.0, 20.0, 6.0, 2.0, 27970.0, 0.0, 0.0, 27970.0, 0.0, 250000.0, 50000.0, 1.0),
(21.0, 20260510.0, 21.0, 21.0, 7.0, 3.0, 71070.0, 0.0, 0.0, 71070.0, 0.0, 250000.0, 50000.0, 1.0),
(22.0, 20250613.0, 22.0, 22.0, 1.0, 4.0, 3030.0, 0.0, 0.0, 3030.0, 0.0, 150000.0, 25000.0, 1.0),
(23.0, 20260812.0, 23.0, 23.0, 2.0, 5.0, 0.0, 0.0, 0.0, 0.0, 0.0, 500000.0, 75000.0, 1.0),
(24.0, 20260507.0, 24.0, 24.0, 3.0, 6.0, 0.0, 0.0, 0.0, 0.0, 0.0, 100000.0, 75000.0, 1.0),
(25.0, 20260626.0, 25.0, 25.0, 4.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 200000.0, 75000.0, 1.0);

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
(13.0, 20250419.0, 20260419.0, 13.0, 13.0, 6.0, 250000.0, 50000.0, 874.5, 25.0, 50.0, 1.0),
(14.0, 20260419.0, 20270419.0, 14.0, 14.0, 7.0, 250000.0, 50000.0, 882.75, 25.0, 50.0, 1.0),
(15.0, 20190429.0, 20200429.0, 15.0, 15.0, 1.0, 350000.0, 100000.0, 3712.0, 25.0, 50.0, 1.0),
(16.0, 20200429.0, 20210429.0, 16.0, 16.0, 2.0, 350000.0, 100000.0, 3749.12, 25.0, 50.0, 1.0),
(17.0, 20210429.0, 20220429.0, 17.0, 17.0, 3.0, 350000.0, 100000.0, 3786.24, 25.0, 50.0, 1.0),
(18.0, 20220429.0, 20230429.0, 18.0, 18.0, 4.0, 350000.0, 100000.0, 3823.36, 25.0, 50.0, 1.0),
(19.0, 20230429.0, 20240429.0, 19.0, 19.0, 5.0, 350000.0, 100000.0, 3860.48, 25.0, 50.0, 1.0),
(20.0, 20240429.0, 20250429.0, 20.0, 20.0, 6.0, 350000.0, 100000.0, 3897.6, 25.0, 50.0, 1.0),
(21.0, 20250429.0, 20260429.0, 21.0, 21.0, 7.0, 350000.0, 100000.0, 3934.72, 25.0, 50.0, 1.0),
(22.0, 20260429.0, 20270429.0, 22.0, 22.0, 1.0, 350000.0, 100000.0, 3971.84, 25.0, 50.0, 1.0),
(23.0, 20190506.0, 20200506.0, 23.0, 23.0, 2.0, 150000.0, 100000.0, 791.0, 25.0, 50.0, 1.0),
(24.0, 20200506.0, 20210506.0, 24.0, 24.0, 3.0, 150000.0, 100000.0, 798.91, 25.0, 50.0, 1.0),
(25.0, 20210506.0, 20220506.0, 25.0, 25.0, 4.0, 150000.0, 100000.0, 806.82, 25.0, 50.0, 1.0);

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
('CLM-2021-80002', 'POL-2021-38103-0034', 'TN', 'Memphis', '2021-10-25 00:00:00', 2021, 0.0, 0.0, 0.0, 200000.0, 25000.0, 'uuid-CLM-2021-80002', 'uuid-POL-2021-38103-0034'),
('CLM-2024-80003', 'POL-2024-40202-0042', 'KY', 'Louisville', '2024-05-11 00:00:00', 2024, 3040.0, 0.0, 0.0, 250000.0, 100000.0, 'uuid-CLM-2024-80003', 'uuid-POL-2024-40202-0042'),
('CLM-2025-80004', 'POL-2024-11561-0049', 'NY', 'Long Beach', '2025-08-02 00:00:00', 2025, 64070.0, 0.0, 0.0, 100000.0, 50000.0, 'uuid-CLM-2025-80004', 'uuid-POL-2024-11561-0049'),
('CLM-2026-80005', 'POL-2025-11561-0050', 'NY', 'Long Beach', '2026-05-17 00:00:00', 2026, 7840.0, 0.0, 0.0, 100000.0, 50000.0, 'uuid-CLM-2026-80005', 'uuid-POL-2025-11561-0050'),
('CLM-2025-80006', 'POL-2025-33901-0096', 'FL', 'Fort Myers', '2025-03-02 00:00:00', 2025, 10580.0, 0.0, 0.0, 250000.0, 25000.0, 'uuid-CLM-2025-80006', 'uuid-POL-2025-33901-0096'),
('CLM-2023-80007', 'POL-2022-90802-0114', 'CA', 'Long Beach', '2023-07-17 00:00:00', 2023, 6490.0, 0.0, 0.0, 150000.0, 75000.0, 'uuid-CLM-2023-80007', 'uuid-POL-2022-90802-0114'),
('CLM-2019-80008', 'POL-2019-19971-0120', 'DE', 'Rehoboth Beach', '2019-06-17 00:00:00', 2019, 31510.0, 0.0, 0.0, 200000.0, 50000.0, 'uuid-CLM-2019-80008', 'uuid-POL-2019-19971-0120'),
('CLM-2023-80009', 'POL-2022-19971-0123', 'DE', 'Rehoboth Beach', '2023-03-05 00:00:00', 2023, 74830.0, 0.0, 0.0, 200000.0, 50000.0, 'uuid-CLM-2023-80009', 'uuid-POL-2022-19971-0123'),
('CLM-2026-80010', 'POL-2025-19971-0126', 'DE', 'Rehoboth Beach', '2026-02-06 00:00:00', 2026, 18800.0, 0.0, 0.0, 200000.0, 50000.0, 'uuid-CLM-2026-80010', 'uuid-POL-2025-19971-0126'),
('CLM-2025-80011', 'POL-2025-77541-0136', 'TX', 'Freeport', '2025-10-14 00:00:00', 2025, 13880.0, 0.0, 0.0, 200000.0, 25000.0, 'uuid-CLM-2025-80011', 'uuid-POL-2025-77541-0136'),
('CLM-2022-80012', 'POL-2022-11561-0152', 'NY', 'Long Beach', '2022-09-16 00:00:00', 2022, 19910.0, 0.0, 0.0, 150000.0, 100000.0, 'uuid-CLM-2022-80012', 'uuid-POL-2022-11561-0152'),
('CLM-2026-80013', 'POL-2026-21842-0158', 'MD', 'Ocean City', '2026-06-17 00:00:00', 2026, 0.0, 0.0, 0.0, 150000.0, 100000.0, 'uuid-CLM-2026-80013', 'uuid-POL-2026-21842-0158'),
('CLM-2022-80014', 'POL-2021-77541-0166', 'TX', 'Freeport', '2022-09-06 00:00:00', 2022, 44970.0, 0.0, 0.0, 100000.0, 25000.0, 'uuid-CLM-2022-80014', 'uuid-POL-2021-77541-0166'),
('CLM-2023-80015', 'POL-2022-06604-0181', 'CT', 'Bridgeport', '2023-03-22 00:00:00', 2023, 1350.0, 0.0, 0.0, 100000.0, 100000.0, 'uuid-CLM-2023-80015', 'uuid-POL-2022-06604-0181'),
('CLM-2021-80016', 'POL-2021-77541-0206', 'TX', 'Freeport', '2021-10-30 00:00:00', 2021, 30570.0, 0.0, 0.0, 150000.0, 75000.0, 'uuid-CLM-2021-80016', 'uuid-POL-2021-77541-0206'),
('CLM-2026-80017', 'POL-2026-77541-0211', 'TX', 'Freeport', '2026-08-12 00:00:00', 2026, 0.0, 0.0, 0.0, 150000.0, 75000.0, 'uuid-CLM-2026-80017', 'uuid-POL-2026-77541-0211'),
('CLM-2022-80018', 'POL-2021-29401-0214', 'SC', 'Charleston', '2022-10-05 00:00:00', 2022, 156360.0, 0.0, 0.0, 350000.0, 50000.0, 'uuid-CLM-2022-80018', 'uuid-POL-2021-29401-0214'),
('CLM-2021-80019', 'POL-2021-74103-0237', 'OK', 'Tulsa', '2021-12-08 00:00:00', 2021, 95250.0, 0.0, 0.0, 500000.0, 100000.0, 'uuid-CLM-2021-80019', 'uuid-POL-2021-74103-0237'),
('CLM-2023-80020', 'POL-2022-21401-0245', 'MD', 'Annapolis', '2023-06-14 00:00:00', 2023, 27970.0, 0.0, 0.0, 250000.0, 50000.0, 'uuid-CLM-2023-80020', 'uuid-POL-2022-21401-0245'),
('CLM-2026-80021', 'POL-2025-21401-0248', 'MD', 'Annapolis', '2026-05-10 00:00:00', 2026, 71070.0, 0.0, 0.0, 250000.0, 50000.0, 'uuid-CLM-2026-80021', 'uuid-POL-2025-21401-0248'),
('CLM-2025-80022', 'POL-2025-21401-0254', 'MD', 'Annapolis', '2025-06-13 00:00:00', 2025, 3030.0, 0.0, 0.0, 150000.0, 25000.0, 'uuid-CLM-2025-80022', 'uuid-POL-2025-21401-0254'),
('CLM-2026-80023', 'POL-2025-21842-0257', 'MD', 'Ocean City', '2026-08-12 00:00:00', 2026, 0.0, 0.0, 0.0, 500000.0, 75000.0, 'uuid-CLM-2026-80023', 'uuid-POL-2025-21842-0257'),
('CLM-2026-80024', 'POL-2025-04101-0262', 'ME', 'Portland', '2026-05-07 00:00:00', 2026, 0.0, 0.0, 0.0, 100000.0, 75000.0, 'uuid-CLM-2026-80024', 'uuid-POL-2025-04101-0262'),
('CLM-2026-80025', 'POL-2026-11901-0270', 'NY', 'Riverhead', '2026-06-26 00:00:00', 2026, 0.0, 0.0, 0.0, 200000.0, 75000.0, 'uuid-CLM-2026-80025', 'uuid-POL-2026-11901-0270');

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
('AL', 2021, 111047.01999999999, 1, 12670.0, 0.1141, 'FINALIZED'),
('AL', 2022, 119063.43, 4, 118780.0, 0.9976, 'FINALIZED'),
('AL', 2023, 127826.12000000002, 2, 21600.0, 0.169, 'FINALIZED'),
('AL', 2024, 140634.86, 7, 114060.0, 0.811, 'FINALIZED'),
('AL', 2025, 166764.34999999998, 5, 85980.0, 0.5156, 'FINALIZED'),
('AL', 2026, 132216.97999999998, 6, 115020.0, 0.8699, 'DEVELOPING'),
('AR', 2021, 18071.66, 3, 21310.0, 1.1792, 'FINALIZED'),
('AR', 2022, 22951.56, 0, 0.0, 0.0, 'FINALIZED'),
('AR', 2023, 25484.489999999998, 2, 32220.0, 1.2643, 'FINALIZED'),
('AR', 2024, 29031.51, 0, 0.0, 0.0, 'FINALIZED'),
('AR', 2025, 33182.53, 0, 0.0, 0.0, 'FINALIZED'),
('AR', 2026, 23317.64, 2, 12510.0, 0.5365, 'DEVELOPING'),
('AZ', 2021, 17504.300000000003, 0, 0.0, 0.0, 'FINALIZED'),
('AZ', 2022, 19464.73, 0, 0.0, 0.0, 'FINALIZED'),
('AZ', 2023, 26489.040000000005, 1, 9340.0, 0.3526, 'FINALIZED'),
('AZ', 2024, 30226.690000000002, 2, 41400.0, 1.3697, 'FINALIZED'),
('AZ', 2025, 33188.13, 4, 160110.0, 4.8243, 'FINALIZED'),
('AZ', 2026, 22051.87, 2, 0.0, 0.0, 'DEVELOPING'),
('CA', 2021, 106603.04, 4, 100200.0, 0.9399, 'FINALIZED'),
('CA', 2022, 127897.65000000001, 9, 139050.0, 1.0872, 'FINALIZED'),
('CA', 2023, 146176.73, 6, 140440.0, 0.9608, 'FINALIZED'),
('CA', 2024, 153539.09999999998, 7, 173370.0, 1.1292, 'FINALIZED'),
('CA', 2025, 173041.88999999998, 6, 40120.0, 0.2319, 'FINALIZED'),
('CA', 2026, 136611.96, 7, 142400.0, 1.0424, 'DEVELOPING'),
('CO', 2021, 24697.260000000002, 1, 65790.0, 2.6639, 'FINALIZED');

-- Table: gold_mitigation_vs_claims_by_state
CREATE OR REPLACE TABLE insurance_dev_gold.gold_schema.gold_mitigation_vs_claims_by_state (
    state STRING,
    total_mitigation_spend DOUBLE,
    total_claims_paid DOUBLE
);

-- Sample seed data for gold_mitigation_vs_claims_by_state
INSERT INTO insurance_dev_gold.gold_schema.gold_mitigation_vs_claims_by_state VALUES
('AL', 199712.36, 468110.0),
('AR', 16882.96, 66040.0),
('AZ', 79290.66, 210850.0),
('CA', 245560.85, 735580.0),
('CO', 77542.79, 192050.0),
('CT', 83256.98, 308570.0),
('DE', 52274.72, 241250.0),
('FL', 728279.25, 1627460.0),
('GA', 189829.54, 436320.0),
('IA', 51210.23, 117520.0),
('IL', 50313.72, 129010.0),
('IN', 73924.29, 262400.0),
('KS', 126463.2, 397140.0),
('KY', 60263.33, 164210.0),
('LA', 285961.73, 888740.0),
('MA', 104191.31, 260960.0),
('MD', 319548.4, 818530.0),
('ME', 19395.96, 62790.0),
('MI', 37194.67, 92820.0),
('MN', 52563.29, 157130.0),
('MO', 114977.42, 264090.0),
('MS', 168405.83, 555110.0),
('NC', 249210.88, 643980.0),
('NE', 17000.57, 63850.0),
('NJ', 185732.97, 485820.0);

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
('POL-2023-33602-0004', 'CUST-20000', 'PROP-60005', 'FL', '48011', 'Tampa', '2023-10-26 00:00:00', '2024-10-26 00:00:00', 100000.0, 100000.0, 1897.0, 'uuid-POL-2023-33602-0004'),
('POL-2024-33602-0005', 'CUST-20000', 'PROP-60005', 'FL', '48011', 'Tampa', '2024-10-26 00:00:00', '2025-10-26 00:00:00', 100000.0, 100000.0, 1915.97, 'uuid-POL-2024-33602-0005'),
('POL-2025-33602-0006', 'CUST-20000', 'PROP-60005', 'FL', '48011', 'Tampa', '2025-10-26 00:00:00', '2026-10-26 00:00:00', 100000.0, 100000.0, 1934.94, 'uuid-POL-2025-33602-0006'),
('POL-2019-85001-0007', 'CUST-20001', 'PROP-60014', 'AZ', '48047', 'Phoenix', '2019-04-19 00:00:00', '2020-04-19 00:00:00', 250000.0, 50000.0, 825.0, 'uuid-POL-2019-85001-0007'),
('POL-2020-85001-0008', 'CUST-20001', 'PROP-60014', 'AZ', '48047', 'Phoenix', '2020-04-19 00:00:00', '2021-04-19 00:00:00', 250000.0, 50000.0, 833.25, 'uuid-POL-2020-85001-0008'),
('POL-2021-85001-0009', 'CUST-20001', 'PROP-60014', 'AZ', '48047', 'Phoenix', '2021-04-19 00:00:00', '2022-04-19 00:00:00', 250000.0, 50000.0, 841.5, 'uuid-POL-2021-85001-0009'),
('POL-2022-85001-0010', 'CUST-20001', 'PROP-60014', 'AZ', '48047', 'Phoenix', '2022-04-19 00:00:00', '2023-04-19 00:00:00', 250000.0, 50000.0, 849.75, 'uuid-POL-2022-85001-0010'),
('POL-2023-85001-0011', 'CUST-20001', 'PROP-60014', 'AZ', '48047', 'Phoenix', '2023-04-19 00:00:00', '2024-04-19 00:00:00', 250000.0, 50000.0, 858.0, 'uuid-POL-2023-85001-0011'),
('POL-2024-85001-0012', 'CUST-20001', 'PROP-60014', 'AZ', '48047', 'Phoenix', '2024-04-19 00:00:00', '2025-04-19 00:00:00', 250000.0, 50000.0, 866.25, 'uuid-POL-2024-85001-0012'),
('POL-2025-85001-0013', 'CUST-20001', 'PROP-60014', 'AZ', '48047', 'Phoenix', '2025-04-19 00:00:00', '2026-04-19 00:00:00', 250000.0, 50000.0, 874.5, 'uuid-POL-2025-85001-0013'),
('POL-2026-85001-0014', 'CUST-20001', 'PROP-60014', 'AZ', '48047', 'Phoenix', '2026-04-19 00:00:00', '2027-04-19 00:00:00', 250000.0, 50000.0, 882.75, 'uuid-POL-2026-85001-0014'),
('POL-2019-80202-0015', 'CUST-20001', 'PROP-60015', 'CO', '48046', 'Denver', '2019-04-29 00:00:00', '2020-04-29 00:00:00', 350000.0, 100000.0, 3712.0, 'uuid-POL-2019-80202-0015'),
('POL-2020-80202-0016', 'CUST-20001', 'PROP-60015', 'CO', '48046', 'Denver', '2020-04-29 00:00:00', '2021-04-29 00:00:00', 350000.0, 100000.0, 3749.12, 'uuid-POL-2020-80202-0016'),
('POL-2021-80202-0017', 'CUST-20001', 'PROP-60015', 'CO', '48046', 'Denver', '2021-04-29 00:00:00', '2022-04-29 00:00:00', 350000.0, 100000.0, 3786.24, 'uuid-POL-2021-80202-0017'),
('POL-2022-80202-0018', 'CUST-20001', 'PROP-60015', 'CO', '48046', 'Denver', '2022-04-29 00:00:00', '2023-04-29 00:00:00', 350000.0, 100000.0, 3823.36, 'uuid-POL-2022-80202-0018'),
('POL-2023-80202-0019', 'CUST-20001', 'PROP-60015', 'CO', '48046', 'Denver', '2023-04-29 00:00:00', '2024-04-29 00:00:00', 350000.0, 100000.0, 3860.48, 'uuid-POL-2023-80202-0019'),
('POL-2024-80202-0020', 'CUST-20001', 'PROP-60015', 'CO', '48046', 'Denver', '2024-04-29 00:00:00', '2025-04-29 00:00:00', 350000.0, 100000.0, 3897.6, 'uuid-POL-2024-80202-0020'),
('POL-2025-80202-0021', 'CUST-20001', 'PROP-60015', 'CO', '48046', 'Denver', '2025-04-29 00:00:00', '2026-04-29 00:00:00', 350000.0, 100000.0, 3934.72, 'uuid-POL-2025-80202-0021'),
('POL-2026-80202-0022', 'CUST-20001', 'PROP-60015', 'CO', '48046', 'Denver', '2026-04-29 00:00:00', '2027-04-29 00:00:00', 350000.0, 100000.0, 3971.84, 'uuid-POL-2026-80202-0022'),
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
('AL', 'VE', 'Pre-FIRM', True, 'Gulf Coast', 'ACTIVE', 205, 41, 1066053.71, 585480.0, 65600000.0, 1.8208, 0.2, 26001.31, 4, 14, 72.83, 24.8, 15.0, -8.0, 1.0, 69.1, 'High', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('AL', 'VE', 'Pre-FIRM', False, 'Gulf Coast', 'ACTIVE', 126, 39, 1006893.81, 423360.0, 40320000.0, 2.3783, 0.3095, 25817.79, 5, 6, 95.13, 24.8, 15.0, 0.0, 0.84, 74.6, 'High', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('AL', 'VE', 'Post-FIRM', True, 'Gulf Coast', 'ACTIVE', 127, 15, 414345.0, 302260.0, 40640000.0, 1.3708, 0.1181, 27623.0, 2, 9, 54.83, 24.8, 5.0, -8.0, 0.85, 57.0, 'Medium', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('AL', 'VE', 'Post-FIRM', False, 'Gulf Coast', 'ACTIVE', 137, 26, 520799.24, 383600.0, 43840000.0, 1.3577, 0.1898, 20030.74, 3, 21, 54.31, 24.8, 5.0, 0.0, 0.91, 58.8, 'Medium', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('AL', 'AE', 'Pre-FIRM', True, 'Gulf Coast', 'ACTIVE', 143, 28, 1111350.52, 277134.0, 45760000.0, 4.0102, 0.1958, 39691.09, 5, 10, 160.41, 20.0, 15.0, -8.0, 0.95, 52.5, 'Medium', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('AL', 'AE', 'Pre-FIRM', False, 'Gulf Coast', 'ACTIVE', 67, 21, 555358.23, 152760.0, 21440000.0, 3.6355, 0.3134, 26445.63, 3, 12, 145.42, 20.0, 15.0, 0.0, 0.45, 58.3, 'Medium', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('AL', 'AE', 'Post-FIRM', True, 'Gulf Coast', 'ACTIVE', 145, 17, 755573.5, 234175.0, 46400000.0, 3.2265, 0.1172, 44445.5, 3, 9, 129.06, 20.0, 5.0, -8.0, 0.97, 41.8, 'Medium', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('AL', 'AE', 'Post-FIRM', False, 'Gulf Coast', 'ACTIVE', 227, 43, 1610616.6, 431300.0, 72640000.0, 3.7343, 0.1894, 37456.2, 2, 26, 149.37, 20.0, 5.0, 0.0, 1.0, 39.7, 'Medium', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('AL', 'A', 'Pre-FIRM', True, 'Gulf Coast', 'ACTIVE', 143, 10, 240449.7, 160446.0, 45760000.0, 1.4986, 0.0699, 24044.97, 5, 19, 59.94, 17.6, 15.0, -8.0, 0.95, 41.8, 'Medium', 'Pre-FIRM Structure', 2018, 2025, '2026-10-13 12:00:00'),
('AL', 'A', 'Pre-FIRM', False, 'Gulf Coast', 'ACTIVE', 70, 8, 217891.44, 92400.0, 22400000.0, 2.3581, 0.1143, 27236.43, 6, 15, 94.32, 17.6, 15.0, 0.0, 0.47, 52.2, 'Medium', 'Pre-FIRM Structure', 2018, 2025, '2026-10-13 12:00:00'),
('AL', 'A', 'Post-FIRM', True, 'Gulf Coast', 'ACTIVE', 76, 3, 142235.67, 71060.0, 24320000.0, 2.0016, 0.0395, 47411.89, 2, 29, 80.06, 17.6, 5.0, -8.0, 0.51, 31.4, 'Low', 'Elevation Deficit', 2018, 2025, '2026-10-13 12:00:00'),
('AL', 'A', 'Post-FIRM', False, 'Gulf Coast', 'ACTIVE', 208, 14, 353036.74, 228800.0, 66560000.0, 1.543, 0.0673, 25216.91, 6, 8, 61.72, 17.6, 5.0, 0.0, 1.0, 43.1, 'Medium', 'Elevation Deficit', 2018, 2025, '2026-10-13 12:00:00'),
('AL', 'B', 'Pre-FIRM', True, 'Gulf Coast', 'ACTIVE', 125, 9, 309400.65, 140250.0, 40000000.0, 2.2061, 0.072, 34377.85, 4, 26, 88.24, 8.8, 15.0, -8.0, 0.83, 29.0, 'Low', 'Pre-FIRM Structure', 2018, 2025, '2026-10-13 12:00:00'),
('AL', 'B', 'Pre-FIRM', False, 'Gulf Coast', 'ACTIVE', 73, 8, 242369.52, 96360.0, 23360000.0, 2.5153, 0.1096, 30296.19, 3, 11, 100.61, 8.8, 15.0, 0.0, 0.49, 38.3, 'Medium', 'Pre-FIRM Structure', 2018, 2025, '2026-10-13 12:00:00'),
('AL', 'B', 'Post-FIRM', True, 'Gulf Coast', 'ACTIVE', 211, 9, 218752.56, 197285.0, 67520000.0, 1.1088, 0.0427, 24305.84, 6, 22, 44.35, 8.8, 5.0, -8.0, 1.0, 9.3, 'Low', 'Elevation Deficit', 2018, 2025, '2026-10-13 12:00:00'),
('AL', 'B', 'Post-FIRM', False, 'Gulf Coast', 'ACTIVE', 228, 16, 579426.72, 250800.0, 72960000.0, 2.3103, 0.0702, 36214.17, 4, 9, 92.41, 8.8, 5.0, 0.0, 1.0, 23.1, 'Low', 'Elevation Deficit', 2018, 2025, '2026-10-13 12:00:00'),
('AL', 'X', 'Pre-FIRM', True, 'Gulf Coast', 'ACTIVE', 228, 16, 453318.88, 255816.0, 72960000.0, 1.7721, 0.0702, 28332.43, 5, 23, 70.88, 6.0, 15.0, -8.0, 1.0, 18.3, 'Low', 'Pre-FIRM Structure', 2018, 2025, '2026-10-13 12:00:00'),
('AL', 'X', 'Pre-FIRM', False, 'Gulf Coast', 'ACTIVE', 127, 14, 476470.68, 167640.0, 40640000.0, 2.8422, 0.1102, 34033.62, 4, 20, 113.69, 6.0, 15.0, 0.0, 0.85, 23.9, 'Low', 'Pre-FIRM Structure', 2018, 2025, '2026-10-13 12:00:00'),
('AL', 'X', 'Post-FIRM', True, 'Gulf Coast', 'ACTIVE', 147, 6, 169338.72, 137445.0, 47040000.0, 1.232, 0.0408, 28223.12, 3, 10, 49.28, 6.0, 5.0, -8.0, 0.98, 5.0, 'Low', 'Elevation Deficit', 2018, 2025, '2026-10-13 12:00:00'),
('AL', 'X', 'Post-FIRM', False, 'Gulf Coast', 'ACTIVE', 120, 8, 376112.8, 132000.0, 38400000.0, 2.8493, 0.0667, 47014.1, 3, 15, 113.97, 6.0, 5.0, 0.0, 0.8, 10.6, 'Low', 'Elevation Deficit', 2018, 2025, '2026-10-13 12:00:00'),
('AR', 'VE', 'Pre-FIRM', True, 'South Central', 'ACTIVE', 91, 18, 424684.62, 259896.0, 29120000.0, 1.6341, 0.1978, 23593.59, 2, 9, 65.36, 24.8, 15.0, -8.0, 0.61, 57.9, 'Medium', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('AR', 'VE', 'Pre-FIRM', False, 'South Central', 'ACTIVE', 54, 16, 361689.28, 181440.0, 17280000.0, 1.9934, 0.2963, 22605.58, 3, 9, 79.74, 24.8, 15.0, 0.0, 0.36, 73.4, 'High', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('AR', 'VE', 'Post-FIRM', True, 'South Central', 'ACTIVE', 179, 22, 801779.22, 426020.0, 57280000.0, 1.882, 0.1229, 36444.51, 2, 21, 75.28, 24.8, 5.0, -8.0, 1.0, 41.3, 'Medium', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('AR', 'VE', 'Post-FIRM', False, 'South Central', 'ACTIVE', 93, 18, 774279.0, 260400.0, 29760000.0, 2.9734, 0.1935, 43015.5, 2, 10, 118.94, 24.8, 5.0, 0.0, 0.62, 69.8, 'High', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00'),
('AR', 'AE', 'Pre-FIRM', True, 'South Central', 'ACTIVE', 66, 13, 234535.08, 127908.0, 21120000.0, 1.8336, 0.197, 18041.16, 3, 22, 73.34, 20.0, 15.0, -8.0, 0.44, 56.3, 'Medium', 'Coastal Hazard', 2018, 2025, '2026-10-13 12:00:00');

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
('AL', 'Gulf Coast', 2933, 351, 10819794.690000003, 4720371.0, 6, 314, 2, 20, 38.9, 2.2921, 'Medium'),
('AR', 'South Central', 2617, 273, 8417174.09, 3847232.0, 6, 292, 3, 20, 39.8, 2.1879, 'Medium'),
('AZ', 'Mountain West', 2782, 325, 10041948.999999998, 4318350.0, 6, 376, 2, 20, 39.7, 2.3254, 'Medium'),
('CA', 'Pacific', 3161, 402, 13002111.22, 5161187.0, 6, 336, 2, 20, 40.6, 2.5192, 'Medium'),
('CO', 'Mountain West', 2975, 355, 10927395.1, 4781211.0, 6, 325, 1, 20, 39.4, 2.2855, 'Medium'),
('CT', 'Northeast', 3302, 438, 16329091.79, 5495811.0, 6, 353, 1, 20, 39.7, 2.9712, 'Medium'),
('DE', 'South Atlantic', 3098, 379, 13832740.369999997, 4848360.0, 6, 406, 4, 20, 40.7, 2.8531, 'Medium'),
('FL', 'South Atlantic', 2841, 325, 10447020.77, 4240399.0, 6, 359, 1, 20, 40.4, 2.4637, 'Medium'),
('GA', 'South Atlantic', 2775, 357, 12081023.879999999, 4418258.0, 6, 334, 1, 20, 37.6, 2.7343, 'Medium'),
('IA', 'Midwest', 2978, 381, 13756072.9, 4868871.0, 6, 320, 3, 20, 40.1, 2.8253, 'Medium'),
('IL', 'Midwest', 2853, 383, 11854875.909999998, 4978535.0, 6, 417, 2, 20, 41.5, 2.3812, 'Medium'),
('IN', 'Midwest', 2690, 303, 10150144.830000002, 4093359.0, 6, 308, 2, 20, 40.2, 2.4797, 'Medium'),
('KS', 'Great Plains', 2700, 297, 9843516.1, 4103942.0, 6, 359, 2, 20, 41.7, 2.3986, 'Medium'),
('KY', 'South Central', 2924, 399, 10714281.51, 5095676.0, 6, 303, 2, 20, 38.4, 2.1026, 'Medium'),
('LA', 'Gulf Coast', 2946, 318, 10216888.96, 4472063.0, 6, 379, 1, 20, 39.0, 2.2846, 'Medium'),
('MA', 'Northeast', 3061, 354, 12242359.249999998, 4682738.0, 6, 311, 1, 20, 38.2, 2.6144, 'Medium'),
('MD', 'South Atlantic', 2964, 326, 11793531.83, 4512370.0, 6, 359, 1, 20, 39.2, 2.6136, 'Medium'),
('ME', 'Northeast', 2951, 407, 15326030.579999998, 5206113.0, 6, 337, 2, 20, 40.0, 2.9439, 'Medium'),
('MI', 'Midwest', 2760, 358, 11837102.58, 4582333.0, 6, 366, 1, 20, 40.4, 2.5832, 'Medium'),
('MN', 'Midwest', 2294, 289, 8871274.23, 3767519.0, 6, 324, 2, 20, 40.5, 2.3547, 'Medium'),
('MO', 'Midwest', 3299, 396, 12919651.27, 5231883.0, 6, 326, 3, 20, 41.5, 2.4694, 'Medium'),
('MS', 'Gulf Coast', 2678, 350, 9809745.36, 4531870.0, 6, 285, 2, 20, 41.7, 2.1646, 'Medium'),
('NC', 'South Atlantic', 2706, 349, 12421169.66, 4617575.0, 6, 347, 2, 20, 39.6, 2.69, 'Medium'),
('NE', 'Great Plains', 2431, 274, 9343920.89, 3633114.0, 6, 280, 3, 20, 40.2, 2.5719, 'Medium'),
('NJ', 'Mid-Atlantic', 2610, 338, 10850154.829999998, 4431318.0, 6, 304, 3, 20, 39.8, 2.4485, 'Medium');

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
('policy', 'uuid-POL-2023-33602-0004', 4, 'POL-2023-33602-0004'),
('policy', 'uuid-POL-2024-33602-0005', 5, 'POL-2024-33602-0005'),
('policy', 'uuid-POL-2025-33602-0006', 6, 'POL-2025-33602-0006'),
('policy', 'uuid-POL-2019-85001-0007', 7, 'POL-2019-85001-0007'),
('policy', 'uuid-POL-2020-85001-0008', 8, 'POL-2020-85001-0008'),
('policy', 'uuid-POL-2021-85001-0009', 9, 'POL-2021-85001-0009'),
('policy', 'uuid-POL-2022-85001-0010', 10, 'POL-2022-85001-0010'),
('policy', 'uuid-POL-2023-85001-0011', 11, 'POL-2023-85001-0011'),
('policy', 'uuid-POL-2024-85001-0012', 12, 'POL-2024-85001-0012'),
('policy', 'uuid-POL-2025-85001-0013', 13, 'POL-2025-85001-0013'),
('policy', 'uuid-POL-2026-85001-0014', 14, 'POL-2026-85001-0014'),
('policy', 'uuid-POL-2019-80202-0015', 15, 'POL-2019-80202-0015'),
('policy', 'uuid-POL-2020-80202-0016', 16, 'POL-2020-80202-0016'),
('policy', 'uuid-POL-2021-80202-0017', 17, 'POL-2021-80202-0017'),
('policy', 'uuid-POL-2022-80202-0018', 18, 'POL-2022-80202-0018'),
('policy', 'uuid-POL-2023-80202-0019', 19, 'POL-2023-80202-0019'),
('policy', 'uuid-POL-2024-80202-0020', 20, 'POL-2024-80202-0020'),
('policy', 'uuid-POL-2025-80202-0021', 21, 'POL-2025-80202-0021'),
('policy', 'uuid-POL-2026-80202-0022', 22, 'POL-2026-80202-0022'),
('policy', 'uuid-POL-2019-77520-0023', 23, 'POL-2019-77520-0023'),
('policy', 'uuid-POL-2020-77520-0024', 24, 'POL-2020-77520-0024'),
('policy', 'uuid-POL-2021-77520-0025', 25, 'POL-2021-77520-0025');

