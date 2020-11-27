SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';

SET default_tablespace = '';

SET default_with_oids = false;

CREATE TABLE public._customers (
    person_id smallint,
    account_number character varying(1) DEFAULT NULL::character varying,
    taxable smallint,
    deleted smallint
);

CREATE TABLE public._people (
    person_id SERIAL PRIMARY KEY,
    first_name character varying(18) DEFAULT NULL::character varying,
    last_name character varying(18) DEFAULT NULL::character varying,
    photo_url character varying(44) DEFAULT NULL::character varying,
    phone_number character varying(8) DEFAULT NULL::character varying,
    email character varying(23) DEFAULT NULL::character varying,
    address_1 character varying(56) DEFAULT NULL::character varying,
    address_2 character varying(1) DEFAULT NULL::character varying,
    city character varying(1) DEFAULT NULL::character varying,
    state character varying(1) DEFAULT NULL::character varying,
    zip character varying(1) DEFAULT NULL::character varying,
    country character varying(1) DEFAULT NULL::character varying
);

CREATE TABLE public._users (
    username character varying(15) DEFAULT NULL::character varying,
    password character varying(256) DEFAULT NULL::character varying,
    salt character varying(64) DEFAULT NULL::character varying,
    user_type character varying(18) DEFAULT NULL::character varying,
    person_id smallint,
    deleted smallint
);

ALTER TABLE public._users 
   ADD CONSTRAINT check_types 
   CHECK (user_type = 'CUSTOMER' OR user_type = 'AGENT' OR user_type = 'ADMIN'  OR user_type = 'SUPERADMIN');


CREATE TABLE public._loan_types (
    loan_type_id SERIAL PRIMARY KEY,
    name character varying(10) DEFAULT NULL::character varying,
    description character varying(21) DEFAULT NULL::character varying,
    term smallint,
    term_period_type character varying(7) DEFAULT NULL::character varying,
    percent_charge1 numeric(3,2) DEFAULT NULL::numeric,
    period_charge1 smallint,
    period_type1 character varying(4) DEFAULT NULL::character varying,
    percent_charge2 numeric(3,2) DEFAULT NULL::numeric,
    period_charge2 smallint,
    period_type2 character varying(5) DEFAULT NULL::character varying,
    percent_charge3 numeric(3,2) DEFAULT NULL::numeric,
    period_charge3 smallint,
    period_type3 character varying(4) DEFAULT NULL::character varying,
    percent_charge4 numeric(3,2) DEFAULT NULL::numeric,
    period_charge4 smallint,
    period_type4 character varying(4) DEFAULT NULL::character varying,
    percent_charge5 numeric(3,2) DEFAULT NULL::numeric,
    period_charge5 smallint,
    period_type5 character varying(4) DEFAULT NULL::character varying,
    percent_charge6 numeric(3,2) DEFAULT NULL::numeric,
    period_charge6 smallint,
    period_type6 character varying(4) DEFAULT NULL::character varying,
    percent_charge7 numeric(3,2) DEFAULT NULL::numeric,
    period_charge7 smallint,
    period_type7 character varying(4) DEFAULT NULL::character varying,
    percent_charge8 numeric(3,2) DEFAULT NULL::numeric,
    period_charge8 smallint,
    period_type8 character varying(4) DEFAULT NULL::character varying,
    percent_charge9 numeric(3,2) DEFAULT NULL::numeric,
    period_charge9 smallint,
    period_type9 character varying(4) DEFAULT NULL::character varying,
    percent_charge10 numeric(3,2) DEFAULT NULL::numeric,
    period_charge10 smallint,
    period_type10 character varying(4) DEFAULT NULL::character varying,
    added_by smallint,
    date_added smallint,
    modified_by smallint,
    date_modified smallint
);



CREATE TABLE public._loans (
    loan_id SERIAL PRIMARY KEY,
    account character varying(16) DEFAULT NULL::character varying,
    description character varying(20) DEFAULT NULL::character varying,
    remarks character varying(37) DEFAULT NULL::character varying,
    loan_type_id smallint,
    customer_id smallint,
    loan_amount numeric(8,2) DEFAULT NULL::numeric,
    loan_balance numeric(7,2) DEFAULT NULL::numeric,
    loan_status character varying(8) DEFAULT NULL::character varying,
    loan_agent_id smallint,
    loan_approved_by_id smallint,
    loan_reviewed_by_id smallint,
    loan_applied_date bigint,
    loan_payment_date bigint,
    misc_fees character varying(49) DEFAULT NULL::character varying,
    delete_flag smallint
);

CREATE TABLE public._loan_payments (
    loan_payment_id SERIAL PRIMARY KEY,
    account character varying(1) DEFAULT NULL::character varying,
    loan_id smallint,
    customer_id smallint,
    balance_amount numeric(8,2) DEFAULT NULL::numeric,
    paid_amount numeric(7,2) DEFAULT NULL::numeric,
    teller_id smallint,
    date_paid bigint,
    date_modified bigint,
    modified_by smallint,
    remarks character varying(4) DEFAULT NULL::character varying,
    delete_flag smallint
);

CREATE TABLE public._financial_status (
    financial_status_id SERIAL PRIMARY KEY,
    person_id smallint,
    income_sources character varying(46) DEFAULT NULL::character varying
);