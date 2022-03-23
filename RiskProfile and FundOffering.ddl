-- Generated by Oracle SQL Developer Data Modeler 21.1.0.092.1221
--   at:        2022-03-23 12:01:23 GMT
--   site:      Oracle Database 12c
--   type:      Oracle Database 12c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE rm_answers (
    answer_id                               INTEGER NOT NULL,
    answer_text                             VARCHAR2(100),
    question_id                             INTEGER,
    risk_weight                             INTEGER,
    answer                                  VARCHAR2(100), 
 
    rm_customer_answers_customer_answer_id  INTEGER NOT NULL
)
LOGGING;

ALTER TABLE rm_answers ADD CONSTRAINT rm_answers_pk PRIMARY KEY ( answer_id );

CREATE TABLE rm_asset_classes (
    asset_class_id                INTEGER NOT NULL,
    fee_structure_id              INTEGER,
    asset_class_name              VARCHAR2(50),
    risk_low_end                  NUMBER,
    risk_high_end                 NUMBER,
    rm_fund_assets_fund_asset_id  INTEGER NOT NULL
)
LOGGING;

ALTER TABLE rm_asset_classes ADD CONSTRAINT rm_asset_classes_pk PRIMARY KEY ( asset_class_id );

CREATE TABLE rm_asset_objective (
    asset_objective_id                    INTEGER NOT NULL,
    asset_objective_name                  VARCHAR2(50),
    rm_potential_funds_fund_id            NUMBER(6) NOT NULL, 

    rm_customer_assets_customer_asset_id  INTEGER NOT NULL
)
LOGGING;

ALTER TABLE rm_asset_objective ADD CONSTRAINT rm_asset_objective_pk PRIMARY KEY ( asset_objective_id );

CREATE TABLE rm_customer_answers (
    customer_answer_id  INTEGER NOT NULL,
    customer_id         INTEGER,
    question_id         INTEGER,
    answer_id           INTEGER
)
LOGGING;

ALTER TABLE rm_customer_answers ADD CONSTRAINT rm_customer_answers_pk PRIMARY KEY ( customer_answer_id );

CREATE TABLE rm_customer_assets (
    customer_asset_id         INTEGER NOT NULL,
    customer_id               INTEGER,
    asset_objective_id        INTEGER,
    total                     INTEGER,
    rm_customers_customer_id  INTEGER NOT NULL
)
LOGGING;

ALTER TABLE rm_customer_assets ADD CONSTRAINT rm_customer_assets_pk PRIMARY KEY ( customer_asset_id );

CREATE TABLE rm_customers (
    customer_id                             INTEGER NOT NULL,
    contact_last_name                       VARCHAR2(50),
    contact_first_name                      VARCHAR2(50),
    age                                     INTEGER,
    marital_status                          VARCHAR2(20),
    gender                                  VARCHAR2(10),
    number_of_dependents                    INTEGER,
    country                                 VARCHAR2(50),
    state                                   VARCHAR2(50),
    city                                    VARCHAR2(50),
    street                                  VARCHAR2(50),
    zip                                     INTEGER, 

    rm_customer_answers_customer_answer_id  INTEGER NOT NULL
)
LOGGING;

ALTER TABLE rm_customers ADD CONSTRAINT rm_customers_pk PRIMARY KEY ( customer_id );

CREATE TABLE rm_engagement_frequencies (
    frequency_id              INTEGER NOT NULL,
    frequency_name            VARCHAR2(50),
    rm_customers_customer_id  INTEGER NOT NULL
)
LOGGING;

ALTER TABLE rm_engagement_frequencies ADD CONSTRAINT rm_engagement_frequencies_pk PRIMARY KEY ( frequency_id );

CREATE TABLE rm_engagement_type (
    engagement_type_id        INTEGER NOT NULL,
    engagement_type_name      VARCHAR2(50),
    rm_customers_customer_id  INTEGER NOT NULL
)
LOGGING;

ALTER TABLE rm_engagement_type ADD CONSTRAINT rm_engagement_type_pk PRIMARY KEY ( engagement_type_id );

CREATE TABLE rm_fee_structures (
    fee_structure_id                 NUMBER(6) NOT NULL,
    flat_fee                         NUMBER(8, 2),
    percentage_fee                   NUMBER(8, 4), 
 
    rm_asset_classes_asset_class_id  INTEGER NOT NULL
)
LOGGING;

ALTER TABLE rm_fee_structures ADD CONSTRAINT rm_fee_structures_pk PRIMARY KEY ( fee_structure_id );

CREATE TABLE rm_fund_assets (
    fund_asset_id    INTEGER NOT NULL,
    fund_id          INTEGER,
    asset_class_id   INTEGER,
    percent_of_fund  NUMBER(8, 2)
)
LOGGING;

ALTER TABLE rm_fund_assets ADD CONSTRAINT rm_fund_assets_pk PRIMARY KEY ( fund_asset_id );

CREATE TABLE rm_fund_targets (
    target_id           INTEGER NOT NULL,
    fund_id             INTEGER,
    engagement_type_id  INTEGER,
    frequency_id        INTEGER,
    target_description  VARCHAR2(100)
)
LOGGING;

ALTER TABLE rm_fund_targets ADD CONSTRAINT rm_fund_targets_pk PRIMARY KEY ( target_id );

CREATE TABLE rm_potential_funds (
    fund_id                       NUMBER(6) NOT NULL,
    fund_name                     VARCHAR2(50),
    fund_description              VARCHAR2(100),
    minimum_investment_required   NUMBER(18, 2),
    maximum_investment_allowed    NUMBER(18, 2),
    test                          INTEGER,
    rm_fund_targets_target_id     INTEGER NOT NULL,
    rm_fund_assets_fund_asset_id  INTEGER NOT NULL
)
LOGGING;

ALTER TABLE rm_potential_funds ADD CONSTRAINT rm_potential_funds_pk PRIMARY KEY ( fund_id );

CREATE TABLE rm_questions (
    question_id                             INTEGER NOT NULL,
    question_subject                        VARCHAR2(50),
    question_text                           VARCHAR2(100),
    rm_answers_answer_id                    INTEGER NOT NULL, 

    rm_customer_answers_customer_answer_id  INTEGER NOT NULL
)
LOGGING;

ALTER TABLE rm_questions ADD CONSTRAINT rm_questions_pk PRIMARY KEY ( question_id );

ALTER TABLE rm_answers
    ADD CONSTRAINT rm_ans_rm_cust_ans_fk FOREIGN KEY ( rm_customer_answers_customer_answer_id )
        REFERENCES rm_customer_answers ( customer_answer_id )
    NOT DEFERRABLE;


ALTER TABLE rm_asset_classes
    ADD CONSTRAINT rm_asset_classes_rm_fund_assets_fk FOREIGN KEY ( rm_fund_assets_fund_asset_id )
        REFERENCES rm_fund_assets ( fund_asset_id )
    NOT DEFERRABLE;

ALTER TABLE rm_asset_objective
    ADD CONSTRAINT rm_asset_objective_rm_customer_assets_fk FOREIGN KEY ( rm_customer_assets_customer_asset_id )
        REFERENCES rm_customer_assets ( customer_asset_id )
    NOT DEFERRABLE;

 
ALTER TABLE rm_asset_objective
    ADD CONSTRAINT rm_asset_objective_rm_potential_funds_fk FOREIGN KEY ( rm_potential_funds_fund_id )
        REFERENCES rm_potential_funds ( fund_id )
    NOT DEFERRABLE;

ALTER TABLE rm_customer_assets
    ADD CONSTRAINT rm_customer_assets_rm_customers_fk FOREIGN KEY ( rm_customers_customer_id )
        REFERENCES rm_customers ( customer_id )
    NOT DEFERRABLE;

ALTER TABLE rm_customers
    ADD CONSTRAINT rm_customers_rm_customer_answers_fk FOREIGN KEY ( rm_customer_answers_customer_answer_id )
        REFERENCES rm_customer_answers ( customer_answer_id )
    NOT DEFERRABLE;


ALTER TABLE rm_engagement_frequencies
    ADD CONSTRAINT rm_engagement_frequencies_rm_customers_fk FOREIGN KEY ( rm_customers_customer_id )
        REFERENCES rm_customers ( customer_id )
    NOT DEFERRABLE;


ALTER TABLE rm_engagement_type
    ADD CONSTRAINT rm_engagement_type_rm_customers_fk FOREIGN KEY ( rm_customers_customer_id )
        REFERENCES rm_customers ( customer_id )
    NOT DEFERRABLE;
 
ALTER TABLE rm_fee_structures
    ADD CONSTRAINT rm_fee_structures_rm_asset_classes_fk FOREIGN KEY ( rm_asset_classes_asset_class_id )
        REFERENCES rm_asset_classes ( asset_class_id )
    NOT DEFERRABLE;


ALTER TABLE rm_potential_funds
    ADD CONSTRAINT rm_potential_funds_rm_fund_assets_fk FOREIGN KEY ( rm_fund_assets_fund_asset_id )
        REFERENCES rm_fund_assets ( fund_asset_id )
    NOT DEFERRABLE;

 
ALTER TABLE rm_potential_funds
    ADD CONSTRAINT rm_potential_funds_rm_fund_targets_fk FOREIGN KEY ( rm_fund_targets_target_id )
        REFERENCES rm_fund_targets ( target_id )
    NOT DEFERRABLE;

ALTER TABLE rm_questions
    ADD CONSTRAINT rm_questions_rm_answers_fk FOREIGN KEY ( rm_answers_answer_id )
        REFERENCES rm_answers ( answer_id )
    NOT DEFERRABLE;

 
ALTER TABLE rm_questions
    ADD CONSTRAINT rm_questions_rm_customer_answers_fk FOREIGN KEY ( rm_customer_answers_customer_answer_id )
        REFERENCES rm_customer_answers ( customer_answer_id )
    NOT DEFERRABLE;



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            13
-- CREATE INDEX                             0
-- ALTER TABLE                             26
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- TSDP POLICY                              0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                  16
-- WARNINGS                                 0
