--
-- PostgreSQL database dump
--

\restrict KCFsIjDvj6r0tgHIKUBAvOlTp5QIpxMCY9MsuqzPdZhVS1ikMc0sFPT236YKalJ

-- Dumped from database version 14.19 (Ubuntu 14.19-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.19 (Ubuntu 14.19-0ubuntu0.22.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


--
-- Name: unaccent_immutable(text); Type: FUNCTION; Schema: public; Owner: tic
--

CREATE FUNCTION public.unaccent_immutable(text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $_$
SELECT unaccent($1);
$_$;


ALTER FUNCTION public.unaccent_immutable(text) OWNER TO tic;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.audit_logs (
    id bigint NOT NULL,
    affected_table character varying(50) NOT NULL,
    user_id bigint NOT NULL,
    register_id bigint NOT NULL,
    operation character varying(10) NOT NULL,
    old_values json,
    new_values json,
    ip_origin character varying(45),
    user_agent text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.audit_logs OWNER TO tic;

--
-- Name: audit_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.audit_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.audit_logs_id_seq OWNER TO tic;

--
-- Name: audit_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.audit_logs_id_seq OWNED BY public.audit_logs.id;


--
-- Name: cache; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache OWNER TO tic;

--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO tic;

--
-- Name: centers; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.centers (
    id bigint NOT NULL,
    name character varying(30) NOT NULL,
    address character varying(100) NOT NULL,
    cif character varying(9) NOT NULL,
    center_code character varying(8) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.centers OWNER TO tic;

--
-- Name: centers_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.centers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.centers_id_seq OWNER TO tic;

--
-- Name: centers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.centers_id_seq OWNED BY public.centers.id;


--
-- Name: cities; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.cities (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    province_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.cities OWNER TO tic;

--
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.cities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cities_id_seq OWNER TO tic;

--
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;


--
-- Name: companies; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.companies (
    id bigint NOT NULL,
    fiscal_name character varying(255),
    trade_name character varying(50) NOT NULL,
    cif text NOT NULL,
    phone_number character varying(255),
    email text NOT NULL,
    website character varying(255),
    sector character varying(250) NOT NULL,
    company_size character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    identification text NOT NULL,
    new_to_sbid boolean DEFAULT false NOT NULL
);


ALTER TABLE public.companies OWNER TO tic;

--
-- Name: companies_addresses; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.companies_addresses (
    id bigint NOT NULL,
    address character varying(100) NOT NULL,
    postal_code character varying(5) NOT NULL,
    city_id bigint NOT NULL,
    company_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    lat text,
    lon text
);


ALTER TABLE public.companies_addresses OWNER TO tic;

--
-- Name: companies_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.companies_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.companies_addresses_id_seq OWNER TO tic;

--
-- Name: companies_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.companies_addresses_id_seq OWNED BY public.companies_addresses.id;


--
-- Name: companies_addresses_backup; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.companies_addresses_backup (
    id bigint DEFAULT nextval('public.companies_addresses_id_seq'::regclass) NOT NULL,
    address text,
    postal_code text,
    city_id bigint NOT NULL,
    company_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.companies_addresses_backup OWNER TO tic;

--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.companies_id_seq OWNER TO tic;

--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.companies_id_seq OWNED BY public.companies.id;


--
-- Name: companies_backup; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.companies_backup (
    id bigint DEFAULT nextval('public.companies_id_seq'::regclass) NOT NULL,
    fiscal_name text NOT NULL,
    trade_name text NOT NULL,
    cif text NOT NULL,
    phone_number text,
    email text NOT NULL,
    website character varying(255),
    sector text,
    company_size character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.companies_backup OWNER TO tic;

--
-- Name: companies_responsibles; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.companies_responsibles (
    company_id bigint NOT NULL,
    company_responsible_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    charge character varying(255)
);


ALTER TABLE public.companies_responsibles OWNER TO tic;

--
-- Name: company_contacts; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.company_contacts (
    id bigint NOT NULL,
    name character varying(30) NOT NULL,
    last_name_1 character varying(30) NOT NULL,
    last_name_2 character varying(30) NOT NULL,
    dni text NOT NULL,
    email text NOT NULL,
    phone_number text,
    job character varying(30) NOT NULL,
    company_responsible boolean NOT NULL,
    document_type_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    charge character varying(50),
    identification text,
    company_id bigint NOT NULL
);


ALTER TABLE public.company_contacts OWNER TO tic;

--
-- Name: company_contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.company_contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.company_contacts_id_seq OWNER TO tic;

--
-- Name: company_contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.company_contacts_id_seq OWNED BY public.company_contacts.id;


--
-- Name: company_contacts_backup; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.company_contacts_backup (
    id bigint DEFAULT nextval('public.company_contacts_id_seq'::regclass) NOT NULL,
    name text NOT NULL,
    last_name_1 text,
    last_name_2 text,
    dni text,
    email text,
    phone_number text,
    job text,
    company_responsible boolean NOT NULL,
    document_type_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    charge character varying(50),
    identification text,
    company_id bigint NOT NULL
);


ALTER TABLE public.company_contacts_backup OWNER TO tic;

--
-- Name: completions; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.completions (
    id bigint NOT NULL,
    request_date date NOT NULL,
    effective_date date NOT NULL,
    reason character varying(200),
    agreement boolean DEFAULT false NOT NULL,
    sbid boolean DEFAULT false NOT NULL,
    processed boolean DEFAULT false NOT NULL,
    status_id bigint NOT NULL,
    agreement_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    description text
);


ALTER TABLE public.completions OWNER TO tic;

--
-- Name: completions_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.completions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.completions_id_seq OWNER TO tic;

--
-- Name: completions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.completions_id_seq OWNED BY public.completions.id;


--
-- Name: completions_backup; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.completions_backup (
    id bigint DEFAULT nextval('public.completions_id_seq'::regclass) NOT NULL,
    request_date date NOT NULL,
    effective_date date NOT NULL,
    reason character varying(200),
    agreement boolean DEFAULT false NOT NULL,
    sbid boolean DEFAULT false NOT NULL,
    processed boolean DEFAULT false NOT NULL,
    status_id bigint NOT NULL,
    agreement_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.completions_backup OWNER TO tic;

--
-- Name: convalidations; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.convalidations (
    id bigint NOT NULL,
    percentage integer NOT NULL,
    sbid boolean NOT NULL,
    tutor_validated boolean NOT NULL,
    in_progress boolean NOT NULL,
    missing_documentation boolean NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.convalidations OWNER TO tic;

--
-- Name: convalidations_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.convalidations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.convalidations_id_seq OWNER TO tic;

--
-- Name: convalidations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.convalidations_id_seq OWNED BY public.convalidations.id;


--
-- Name: countries; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.countries (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    iso_code character varying(10) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.countries OWNER TO tic;

--
-- Name: countries_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.countries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.countries_id_seq OWNER TO tic;

--
-- Name: countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.countries_id_seq OWNED BY public.countries.id;


--
-- Name: courses; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.courses (
    id bigint NOT NULL,
    name character varying(150) NOT NULL,
    description character varying(200),
    training_area_id bigint NOT NULL,
    center_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    code character varying(10),
    study_type character varying(10) NOT NULL
);


ALTER TABLE public.courses OWNER TO tic;

--
-- Name: courses_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.courses_id_seq OWNER TO tic;

--
-- Name: courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.courses_id_seq OWNED BY public.courses.id;


--
-- Name: cv_forms; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.cv_forms (
    id bigint NOT NULL,
    cv_file character varying(255) NOT NULL,
    student_looking_for_company boolean NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.cv_forms OWNER TO tic;

--
-- Name: cv_forms_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.cv_forms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cv_forms_id_seq OWNER TO tic;

--
-- Name: cv_forms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.cv_forms_id_seq OWNED BY public.cv_forms.id;


--
-- Name: document_types; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.document_types (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    abbreviation character varying(20) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.document_types OWNER TO tic;

--
-- Name: document_types_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.document_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.document_types_id_seq OWNER TO tic;

--
-- Name: document_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.document_types_id_seq OWNED BY public.document_types.id;


--
-- Name: emails; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.emails (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    email text NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    email_hash character varying(64)
);


ALTER TABLE public.emails OWNER TO tic;

--
-- Name: emails_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.emails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.emails_id_seq OWNER TO tic;

--
-- Name: emails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.emails_id_seq OWNED BY public.emails.id;


--
-- Name: emails_roles; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.emails_roles (
    email_id bigint NOT NULL,
    role_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.emails_roles OWNER TO tic;

--
-- Name: error_logs; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.error_logs (
    id bigint NOT NULL,
    level character varying(20) NOT NULL,
    message character varying(200) NOT NULL,
    context json,
    trace text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.error_logs OWNER TO tic;

--
-- Name: error_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.error_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.error_logs_id_seq OWNER TO tic;

--
-- Name: error_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.error_logs_id_seq OWNED BY public.error_logs.id;


--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO tic;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.failed_jobs_id_seq OWNER TO tic;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: fct_agreements; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.fct_agreements (
    id bigint NOT NULL,
    assignment_id bigint,
    tutor_id bigint NOT NULL,
    agreement_made boolean DEFAULT false NOT NULL,
    agreement_signed boolean DEFAULT false NOT NULL,
    agreement_canceled boolean DEFAULT false NOT NULL,
    start_date date NOT NULL,
    ss_management boolean DEFAULT false NOT NULL,
    schedule character varying(20) NOT NULL,
    studies_origin character varying(25) NOT NULL,
    modality character varying(20) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    user_course_id bigint,
    user_id bigint NOT NULL,
    company_id bigint NOT NULL,
    valid boolean DEFAULT false NOT NULL,
    address_id bigint,
    end_date date,
    extension boolean,
    notes text,
    workday character varying(200) NOT NULL
);


ALTER TABLE public.fct_agreements OWNER TO tic;

--
-- Name: fct_agreements_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.fct_agreements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fct_agreements_id_seq OWNER TO tic;

--
-- Name: fct_agreements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.fct_agreements_id_seq OWNED BY public.fct_agreements.id;


--
-- Name: fct_agreements_backup; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.fct_agreements_backup (
    id bigint DEFAULT nextval('public.fct_agreements_id_seq'::regclass) NOT NULL,
    assignment_id bigint,
    tutor_id bigint NOT NULL,
    agreement_made boolean DEFAULT false NOT NULL,
    agreement_signed boolean DEFAULT false NOT NULL,
    agreement_canceled boolean DEFAULT false NOT NULL,
    start_date date NOT NULL,
    ss_management boolean DEFAULT false NOT NULL,
    schedule character varying(20) NOT NULL,
    studies_origin character varying(25) NOT NULL,
    modality character varying(20) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    user_course_id bigint,
    fct_modality_id bigint,
    user_id bigint NOT NULL,
    company_id bigint NOT NULL,
    valid boolean DEFAULT false
);


ALTER TABLE public.fct_agreements_backup OWNER TO tic;

--
-- Name: fct_assignments; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.fct_assignments (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    company_id bigint NOT NULL,
    status_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    user_course_id bigint
);


ALTER TABLE public.fct_assignments OWNER TO tic;

--
-- Name: fct_assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.fct_assignments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fct_assignments_id_seq OWNER TO tic;

--
-- Name: fct_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.fct_assignments_id_seq OWNED BY public.fct_assignments.id;


--
-- Name: fct_documents; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.fct_documents (
    id bigint NOT NULL,
    filename character varying(50) NOT NULL,
    file character varying(255) NOT NULL,
    agreement_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.fct_documents OWNER TO tic;

--
-- Name: fct_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.fct_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fct_documents_id_seq OWNER TO tic;

--
-- Name: fct_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.fct_documents_id_seq OWNED BY public.fct_documents.id;


--
-- Name: fct_documents_backup; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.fct_documents_backup (
    id bigint DEFAULT nextval('public.fct_documents_id_seq'::regclass) NOT NULL,
    filename character varying(50) NOT NULL,
    file character varying(255) NOT NULL,
    agreement_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.fct_documents_backup OWNER TO tic;

--
-- Name: fct_extensions; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.fct_extensions (
    id bigint NOT NULL,
    agreement_id bigint NOT NULL,
    status_id bigint NOT NULL,
    request_date date NOT NULL,
    start_date date NOT NULL,
    new_end_date date NOT NULL,
    reason character varying(200),
    sbid boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.fct_extensions OWNER TO tic;

--
-- Name: fct_extensions_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.fct_extensions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fct_extensions_id_seq OWNER TO tic;

--
-- Name: fct_extensions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.fct_extensions_id_seq OWNED BY public.fct_extensions.id;


--
-- Name: fct_extensions_backup; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.fct_extensions_backup (
    id bigint DEFAULT nextval('public.fct_extensions_id_seq'::regclass) NOT NULL,
    agreement_id bigint NOT NULL,
    status_id bigint NOT NULL,
    request_date date NOT NULL,
    start_date date NOT NULL,
    new_end_date date NOT NULL,
    reason character varying(200),
    sbid boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.fct_extensions_backup OWNER TO tic;

--
-- Name: fct_offers; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.fct_offers (
    id bigint NOT NULL,
    company_id bigint NOT NULL,
    training_area_id bigint NOT NULL,
    description character varying(200),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.fct_offers OWNER TO tic;

--
-- Name: fct_offers_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.fct_offers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fct_offers_id_seq OWNER TO tic;

--
-- Name: fct_offers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.fct_offers_id_seq OWNED BY public.fct_offers.id;


--
-- Name: fct_registered_users; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.fct_registered_users (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    offer_id bigint NOT NULL,
    chosen boolean DEFAULT false NOT NULL,
    discarded boolean DEFAULT false NOT NULL,
    waiting boolean DEFAULT false NOT NULL,
    registration_date date,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.fct_registered_users OWNER TO tic;

--
-- Name: fct_registered_users_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.fct_registered_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fct_registered_users_id_seq OWNER TO tic;

--
-- Name: fct_registered_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.fct_registered_users_id_seq OWNED BY public.fct_registered_users.id;


--
-- Name: fct_schedules; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.fct_schedules (
    id bigint NOT NULL,
    agreement_id bigint NOT NULL,
    monday_morning character varying(50),
    monday_afternoon character varying(50),
    tuesday_morning character varying(50),
    tuesday_afternoon character varying(50),
    wednesday_morning character varying(50),
    wednesday_afternoon character varying(50),
    thursday_morning character varying(50),
    thursday_afternoon character varying(50),
    friday_morning character varying(50),
    friday_afternoon character varying(50),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.fct_schedules OWNER TO tic;

--
-- Name: fct_schedules_backup; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.fct_schedules_backup (
    id bigint NOT NULL,
    agreement_id bigint,
    monday_morning character varying(50),
    monday_afternoon character varying(50),
    tuesday_morning character varying(50),
    tuesday_afternoon character varying(50),
    wednesday_morning character varying(50),
    wednesday_afternoon character varying(50),
    thursday_morning character varying(50),
    thursday_afternoon character varying(50),
    friday_morning character varying(50),
    friday_afternoon character varying(50),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.fct_schedules_backup OWNER TO tic;

--
-- Name: fct_schedules_backup_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

ALTER TABLE public.fct_schedules_backup ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.fct_schedules_backup_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: fct_schedules_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.fct_schedules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fct_schedules_id_seq OWNER TO tic;

--
-- Name: fct_schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.fct_schedules_id_seq OWNED BY public.fct_schedules.id;


--
-- Name: fct_statuses; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.fct_statuses (
    id bigint NOT NULL,
    status character varying(50) NOT NULL,
    description character varying(200),
    "order" integer,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.fct_statuses OWNER TO tic;

--
-- Name: fct_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.fct_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fct_statuses_id_seq OWNER TO tic;

--
-- Name: fct_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.fct_statuses_id_seq OWNED BY public.fct_statuses.id;


--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


ALTER TABLE public.job_batches OWNER TO tic;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.jobs OWNER TO tic;

--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jobs_id_seq OWNER TO tic;

--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: login_logs; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.login_logs (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    success boolean NOT NULL,
    ip_origin character varying(45) NOT NULL,
    user_agent text NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.login_logs OWNER TO tic;

--
-- Name: login_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.login_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.login_logs_id_seq OWNER TO tic;

--
-- Name: login_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.login_logs_id_seq OWNED BY public.login_logs.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO tic;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO tic;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: provinces; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.provinces (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    country_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.provinces OWNER TO tic;

--
-- Name: provinces_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.provinces_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.provinces_id_seq OWNER TO tic;

--
-- Name: provinces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.provinces_id_seq OWNED BY public.provinces.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.roles OWNER TO tic;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO tic;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: training_areas; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.training_areas (
    id bigint NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(200),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.training_areas OWNER TO tic;

--
-- Name: training_areas_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.training_areas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.training_areas_id_seq OWNER TO tic;

--
-- Name: training_areas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.training_areas_id_seq OWNED BY public.training_areas.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    password character varying(255) NOT NULL,
    status character(50) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.users OWNER TO tic;

--
-- Name: users_courses; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.users_courses (
    id bigint NOT NULL,
    academic_course character varying(10) NOT NULL,
    user_id bigint NOT NULL,
    course_id bigint NOT NULL,
    role_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    year_level integer,
    is_withdrawn boolean
);


ALTER TABLE public.users_courses OWNER TO tic;

--
-- Name: COLUMN users_courses.year_level; Type: COMMENT; Schema: public; Owner: tic
--

COMMENT ON COLUMN public.users_courses.year_level IS 'Indica si el estudiante va a primero, segundo, etc.';


--
-- Name: users_courses_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.users_courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_courses_id_seq OWNER TO tic;

--
-- Name: users_courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.users_courses_id_seq OWNED BY public.users_courses.id;


--
-- Name: users_data; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.users_data (
    id bigint NOT NULL,
    name character varying(50) NOT NULL,
    last_name_1 character varying(50) NOT NULL,
    last_name_2 character varying(50),
    birthdate date NOT NULL,
    dni text,
    address text NOT NULL,
    postal_code text,
    social_security text,
    health_card text,
    phone_number text,
    user_id bigint NOT NULL,
    city_id bigint NOT NULL,
    document_type_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    identification character varying(64),
    lat text,
    lon text,
    social_security_path character varying(255),
    passport text,
    nie text
);


ALTER TABLE public.users_data OWNER TO tic;

--
-- Name: users_data_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.users_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_data_id_seq OWNER TO tic;

--
-- Name: users_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.users_data_id_seq OWNED BY public.users_data.id;


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: tic
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO tic;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tic
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: users_roles; Type: TABLE; Schema: public; Owner: tic
--

CREATE TABLE public.users_roles (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.users_roles OWNER TO tic;

--
-- Name: audit_logs id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.audit_logs ALTER COLUMN id SET DEFAULT nextval('public.audit_logs_id_seq'::regclass);


--
-- Name: centers id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.centers ALTER COLUMN id SET DEFAULT nextval('public.centers_id_seq'::regclass);


--
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- Name: companies id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.companies ALTER COLUMN id SET DEFAULT nextval('public.companies_id_seq'::regclass);


--
-- Name: companies_addresses id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.companies_addresses ALTER COLUMN id SET DEFAULT nextval('public.companies_addresses_id_seq'::regclass);


--
-- Name: company_contacts id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.company_contacts ALTER COLUMN id SET DEFAULT nextval('public.company_contacts_id_seq'::regclass);


--
-- Name: completions id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.completions ALTER COLUMN id SET DEFAULT nextval('public.completions_id_seq'::regclass);


--
-- Name: convalidations id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.convalidations ALTER COLUMN id SET DEFAULT nextval('public.convalidations_id_seq'::regclass);


--
-- Name: countries id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.countries ALTER COLUMN id SET DEFAULT nextval('public.countries_id_seq'::regclass);


--
-- Name: courses id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.courses ALTER COLUMN id SET DEFAULT nextval('public.courses_id_seq'::regclass);


--
-- Name: cv_forms id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.cv_forms ALTER COLUMN id SET DEFAULT nextval('public.cv_forms_id_seq'::regclass);


--
-- Name: document_types id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.document_types ALTER COLUMN id SET DEFAULT nextval('public.document_types_id_seq'::regclass);


--
-- Name: emails id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.emails ALTER COLUMN id SET DEFAULT nextval('public.emails_id_seq'::regclass);


--
-- Name: error_logs id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.error_logs ALTER COLUMN id SET DEFAULT nextval('public.error_logs_id_seq'::regclass);


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: fct_agreements id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_agreements ALTER COLUMN id SET DEFAULT nextval('public.fct_agreements_id_seq'::regclass);


--
-- Name: fct_assignments id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_assignments ALTER COLUMN id SET DEFAULT nextval('public.fct_assignments_id_seq'::regclass);


--
-- Name: fct_documents id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_documents ALTER COLUMN id SET DEFAULT nextval('public.fct_documents_id_seq'::regclass);


--
-- Name: fct_extensions id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_extensions ALTER COLUMN id SET DEFAULT nextval('public.fct_extensions_id_seq'::regclass);


--
-- Name: fct_offers id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_offers ALTER COLUMN id SET DEFAULT nextval('public.fct_offers_id_seq'::regclass);


--
-- Name: fct_registered_users id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_registered_users ALTER COLUMN id SET DEFAULT nextval('public.fct_registered_users_id_seq'::regclass);


--
-- Name: fct_schedules id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_schedules ALTER COLUMN id SET DEFAULT nextval('public.fct_schedules_id_seq'::regclass);


--
-- Name: fct_statuses id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_statuses ALTER COLUMN id SET DEFAULT nextval('public.fct_statuses_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: login_logs id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.login_logs ALTER COLUMN id SET DEFAULT nextval('public.login_logs_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: provinces id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.provinces ALTER COLUMN id SET DEFAULT nextval('public.provinces_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: training_areas id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.training_areas ALTER COLUMN id SET DEFAULT nextval('public.training_areas_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: users_courses id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.users_courses ALTER COLUMN id SET DEFAULT nextval('public.users_courses_id_seq'::regclass);


--
-- Name: users_data id; Type: DEFAULT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.users_data ALTER COLUMN id SET DEFAULT nextval('public.users_data_id_seq'::regclass);


--
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: centers centers_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.centers
    ADD CONSTRAINT centers_pkey PRIMARY KEY (id);


--
-- Name: cities cities_name_province_id_unique; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_name_province_id_unique UNIQUE (name, province_id);


--
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- Name: companies_addresses_backup companies_addresses_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.companies_addresses_backup
    ADD CONSTRAINT companies_addresses_backup_pkey PRIMARY KEY (id);


--
-- Name: companies_addresses companies_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.companies_addresses
    ADD CONSTRAINT companies_addresses_pkey PRIMARY KEY (id);


--
-- Name: companies_backup companies_backup_cif_key; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.companies_backup
    ADD CONSTRAINT companies_backup_cif_key UNIQUE (cif);


--
-- Name: companies_backup companies_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.companies_backup
    ADD CONSTRAINT companies_backup_pkey PRIMARY KEY (id);


--
-- Name: companies companies_cif_unique; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_cif_unique UNIQUE (cif);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: companies_responsibles companies_responsibles_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.companies_responsibles
    ADD CONSTRAINT companies_responsibles_pkey PRIMARY KEY (company_id, company_responsible_id);


--
-- Name: company_contacts_backup company_contacts_backup_email_key; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.company_contacts_backup
    ADD CONSTRAINT company_contacts_backup_email_key UNIQUE (email);


--
-- Name: company_contacts_backup company_contacts_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.company_contacts_backup
    ADD CONSTRAINT company_contacts_backup_pkey PRIMARY KEY (id);


--
-- Name: company_contacts company_contacts_email_unique; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.company_contacts
    ADD CONSTRAINT company_contacts_email_unique UNIQUE (email);


--
-- Name: company_contacts company_contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.company_contacts
    ADD CONSTRAINT company_contacts_pkey PRIMARY KEY (id);


--
-- Name: completions_backup completions_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.completions_backup
    ADD CONSTRAINT completions_backup_pkey PRIMARY KEY (id);


--
-- Name: completions completions_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.completions
    ADD CONSTRAINT completions_pkey PRIMARY KEY (id);


--
-- Name: convalidations convalidations_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.convalidations
    ADD CONSTRAINT convalidations_pkey PRIMARY KEY (id);


--
-- Name: countries countries_iso_code_unique; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_iso_code_unique UNIQUE (iso_code);


--
-- Name: countries countries_name_unique; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_name_unique UNIQUE (name);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- Name: cv_forms cv_forms_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.cv_forms
    ADD CONSTRAINT cv_forms_pkey PRIMARY KEY (id);


--
-- Name: document_types document_types_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.document_types
    ADD CONSTRAINT document_types_pkey PRIMARY KEY (id);


--
-- Name: emails emails_email_hash_unique; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.emails
    ADD CONSTRAINT emails_email_hash_unique UNIQUE (email_hash);


--
-- Name: emails emails_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.emails
    ADD CONSTRAINT emails_pkey PRIMARY KEY (id);


--
-- Name: emails_roles emails_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.emails_roles
    ADD CONSTRAINT emails_roles_pkey PRIMARY KEY (email_id, role_id);


--
-- Name: error_logs error_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.error_logs
    ADD CONSTRAINT error_logs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: fct_agreements_backup fct_agreements_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_agreements_backup
    ADD CONSTRAINT fct_agreements_backup_pkey PRIMARY KEY (id);


--
-- Name: fct_agreements fct_agreements_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_agreements
    ADD CONSTRAINT fct_agreements_pkey PRIMARY KEY (id);


--
-- Name: fct_assignments fct_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_assignments
    ADD CONSTRAINT fct_assignments_pkey PRIMARY KEY (id);


--
-- Name: fct_documents_backup fct_documents_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_documents_backup
    ADD CONSTRAINT fct_documents_backup_pkey PRIMARY KEY (id);


--
-- Name: fct_documents fct_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_documents
    ADD CONSTRAINT fct_documents_pkey PRIMARY KEY (id);


--
-- Name: fct_extensions_backup fct_extensions_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_extensions_backup
    ADD CONSTRAINT fct_extensions_backup_pkey PRIMARY KEY (id);


--
-- Name: fct_extensions fct_extensions_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_extensions
    ADD CONSTRAINT fct_extensions_pkey PRIMARY KEY (id);


--
-- Name: fct_offers fct_offers_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_offers
    ADD CONSTRAINT fct_offers_pkey PRIMARY KEY (id);


--
-- Name: fct_registered_users fct_registered_users_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_registered_users
    ADD CONSTRAINT fct_registered_users_pkey PRIMARY KEY (id);


--
-- Name: fct_schedules_backup fct_schedules_backup_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_schedules_backup
    ADD CONSTRAINT fct_schedules_backup_pkey PRIMARY KEY (id);


--
-- Name: fct_schedules fct_schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_schedules
    ADD CONSTRAINT fct_schedules_pkey PRIMARY KEY (id);


--
-- Name: fct_statuses fct_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_statuses
    ADD CONSTRAINT fct_statuses_pkey PRIMARY KEY (id);


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: login_logs login_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.login_logs
    ADD CONSTRAINT login_logs_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: provinces provinces_name_country_id_unique; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.provinces
    ADD CONSTRAINT provinces_name_country_id_unique UNIQUE (name, country_id);


--
-- Name: provinces provinces_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.provinces
    ADD CONSTRAINT provinces_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: training_areas training_areas_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.training_areas
    ADD CONSTRAINT training_areas_pkey PRIMARY KEY (id);


--
-- Name: users_courses users_courses_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.users_courses
    ADD CONSTRAINT users_courses_pkey PRIMARY KEY (id);


--
-- Name: users_data users_data_dni_unique; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.users_data
    ADD CONSTRAINT users_data_dni_unique UNIQUE (dni);


--
-- Name: users_data users_data_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.users_data
    ADD CONSTRAINT users_data_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users_roles users_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.users_roles
    ADD CONSTRAINT users_roles_pkey PRIMARY KEY (user_id, role_id);


--
-- Name: companies_backup_id_idx; Type: INDEX; Schema: public; Owner: tic
--

CREATE INDEX companies_backup_id_idx ON public.companies_backup USING btree (id);


--
-- Name: fct_agreements_backup_assignment_id_idx; Type: INDEX; Schema: public; Owner: tic
--

CREATE INDEX fct_agreements_backup_assignment_id_idx ON public.fct_agreements_backup USING btree (assignment_id);


--
-- Name: idx_companies_id; Type: INDEX; Schema: public; Owner: tic
--

CREATE INDEX idx_companies_id ON public.companies USING btree (id);


--
-- Name: idx_courses_area; Type: INDEX; Schema: public; Owner: tic
--

CREATE INDEX idx_courses_area ON public.courses USING btree (training_area_id, study_type);


--
-- Name: idx_fct_agreements_assign; Type: INDEX; Schema: public; Owner: tic
--

CREATE INDEX idx_fct_agreements_assign ON public.fct_agreements USING btree (assignment_id);


--
-- Name: idx_fct_assignments_user; Type: INDEX; Schema: public; Owner: tic
--

CREATE INDEX idx_fct_assignments_user ON public.fct_assignments USING btree (user_id, status_id);


--
-- Name: idx_user_data_last_name1_trgm; Type: INDEX; Schema: public; Owner: tic
--

CREATE INDEX idx_user_data_last_name1_trgm ON public.users_data USING gin (lower(public.unaccent_immutable((last_name_1)::text)) public.gin_trgm_ops);


--
-- Name: idx_user_data_last_name2_trgm; Type: INDEX; Schema: public; Owner: tic
--

CREATE INDEX idx_user_data_last_name2_trgm ON public.users_data USING gin (lower(public.unaccent_immutable((last_name_2)::text)) public.gin_trgm_ops);


--
-- Name: idx_user_data_name_trgm; Type: INDEX; Schema: public; Owner: tic
--

CREATE INDEX idx_user_data_name_trgm ON public.users_data USING gin (lower(public.unaccent_immutable((name)::text)) public.gin_trgm_ops);


--
-- Name: idx_users_courses_user_role; Type: INDEX; Schema: public; Owner: tic
--

CREATE INDEX idx_users_courses_user_role ON public.users_courses USING btree (user_id, role_id, academic_course);


--
-- Name: idx_users_data_lastname1_trgm; Type: INDEX; Schema: public; Owner: tic
--

CREATE INDEX idx_users_data_lastname1_trgm ON public.users_data USING gin (last_name_1 public.gin_trgm_ops);


--
-- Name: idx_users_data_lastname2_trgm; Type: INDEX; Schema: public; Owner: tic
--

CREATE INDEX idx_users_data_lastname2_trgm ON public.users_data USING gin (last_name_2 public.gin_trgm_ops);


--
-- Name: idx_users_data_name_trgm; Type: INDEX; Schema: public; Owner: tic
--

CREATE INDEX idx_users_data_name_trgm ON public.users_data USING gin (name public.gin_trgm_ops);


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: tic
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- Name: users_data_search_idx; Type: INDEX; Schema: public; Owner: tic
--

CREATE INDEX users_data_search_idx ON public.users_data USING gin (to_tsvector('spanish'::regconfig, (((((name)::text || ' '::text) || (last_name_1)::text) || ' '::text) || (last_name_2)::text)));


--
-- Name: audit_logs audit_logs_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: cities cities_province_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_province_id_foreign FOREIGN KEY (province_id) REFERENCES public.provinces(id) ON DELETE CASCADE;


--
-- Name: companies_addresses companies_addresses_city_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.companies_addresses
    ADD CONSTRAINT companies_addresses_city_id_foreign FOREIGN KEY (city_id) REFERENCES public.cities(id) ON DELETE RESTRICT;


--
-- Name: companies_addresses companies_addresses_company_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.companies_addresses
    ADD CONSTRAINT companies_addresses_company_id_foreign FOREIGN KEY (company_id) REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- Name: companies_responsibles companies_responsibles_company_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.companies_responsibles
    ADD CONSTRAINT companies_responsibles_company_id_foreign FOREIGN KEY (company_id) REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- Name: companies_responsibles companies_responsibles_company_responsible_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.companies_responsibles
    ADD CONSTRAINT companies_responsibles_company_responsible_id_foreign FOREIGN KEY (company_responsible_id) REFERENCES public.company_contacts(id) ON DELETE CASCADE;


--
-- Name: company_contacts company_contacts_company_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.company_contacts
    ADD CONSTRAINT company_contacts_company_id_foreign FOREIGN KEY (company_id) REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- Name: company_contacts company_contacts_document_type_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.company_contacts
    ADD CONSTRAINT company_contacts_document_type_id_foreign FOREIGN KEY (document_type_id) REFERENCES public.document_types(id) ON DELETE RESTRICT;


--
-- Name: completions completions_agreement_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.completions
    ADD CONSTRAINT completions_agreement_id_foreign FOREIGN KEY (agreement_id) REFERENCES public.fct_agreements(id) ON DELETE CASCADE;


--
-- Name: completions completions_status_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.completions
    ADD CONSTRAINT completions_status_id_foreign FOREIGN KEY (status_id) REFERENCES public.fct_statuses(id) ON DELETE RESTRICT;


--
-- Name: convalidations convalidations_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.convalidations
    ADD CONSTRAINT convalidations_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: courses courses_center_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_center_id_foreign FOREIGN KEY (center_id) REFERENCES public.centers(id) ON DELETE CASCADE;


--
-- Name: courses courses_training_area_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_training_area_id_foreign FOREIGN KEY (training_area_id) REFERENCES public.training_areas(id) ON DELETE CASCADE;


--
-- Name: cv_forms cv_forms_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.cv_forms
    ADD CONSTRAINT cv_forms_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: emails_roles emails_roles_email_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.emails_roles
    ADD CONSTRAINT emails_roles_email_id_foreign FOREIGN KEY (email_id) REFERENCES public.emails(id) ON DELETE CASCADE;


--
-- Name: emails_roles emails_roles_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.emails_roles
    ADD CONSTRAINT emails_roles_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: emails emails_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.emails
    ADD CONSTRAINT emails_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: fct_agreements fct_agreements_address_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_agreements
    ADD CONSTRAINT fct_agreements_address_id_foreign FOREIGN KEY (address_id) REFERENCES public.companies_addresses(id) ON DELETE SET NULL;


--
-- Name: fct_agreements fct_agreements_assignment_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_agreements
    ADD CONSTRAINT fct_agreements_assignment_id_foreign FOREIGN KEY (assignment_id) REFERENCES public.fct_assignments(id) ON DELETE CASCADE;


--
-- Name: fct_agreements_backup fct_agreements_backup_company_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_agreements_backup
    ADD CONSTRAINT fct_agreements_backup_company_id_foreign FOREIGN KEY (company_id) REFERENCES public.companies_backup(id) ON DELETE CASCADE;


--
-- Name: fct_agreements_backup fct_agreements_backup_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_agreements_backup
    ADD CONSTRAINT fct_agreements_backup_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: fct_agreements fct_agreements_company_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_agreements
    ADD CONSTRAINT fct_agreements_company_id_foreign FOREIGN KEY (company_id) REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- Name: fct_agreements fct_agreements_tutor_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_agreements
    ADD CONSTRAINT fct_agreements_tutor_id_foreign FOREIGN KEY (tutor_id) REFERENCES public.company_contacts(id) ON DELETE RESTRICT;


--
-- Name: fct_agreements fct_agreements_user_course_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_agreements
    ADD CONSTRAINT fct_agreements_user_course_id_foreign FOREIGN KEY (user_course_id) REFERENCES public.users_courses(id) ON DELETE CASCADE;


--
-- Name: fct_agreements fct_agreements_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_agreements
    ADD CONSTRAINT fct_agreements_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: fct_assignments fct_assignments_company_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_assignments
    ADD CONSTRAINT fct_assignments_company_id_foreign FOREIGN KEY (company_id) REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- Name: fct_assignments fct_assignments_status_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_assignments
    ADD CONSTRAINT fct_assignments_status_id_foreign FOREIGN KEY (status_id) REFERENCES public.fct_statuses(id) ON DELETE RESTRICT;


--
-- Name: fct_assignments fct_assignments_user_course_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_assignments
    ADD CONSTRAINT fct_assignments_user_course_id_foreign FOREIGN KEY (user_course_id) REFERENCES public.users_courses(id) ON DELETE CASCADE;


--
-- Name: fct_assignments fct_assignments_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_assignments
    ADD CONSTRAINT fct_assignments_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: fct_documents fct_documents_agreement_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_documents
    ADD CONSTRAINT fct_documents_agreement_id_foreign FOREIGN KEY (agreement_id) REFERENCES public.fct_agreements(id) ON DELETE CASCADE;


--
-- Name: fct_extensions fct_extensions_agreement_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_extensions
    ADD CONSTRAINT fct_extensions_agreement_id_foreign FOREIGN KEY (agreement_id) REFERENCES public.fct_agreements(id) ON DELETE CASCADE;


--
-- Name: fct_extensions fct_extensions_status_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_extensions
    ADD CONSTRAINT fct_extensions_status_id_foreign FOREIGN KEY (status_id) REFERENCES public.fct_statuses(id) ON DELETE RESTRICT;


--
-- Name: fct_offers fct_offers_company_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_offers
    ADD CONSTRAINT fct_offers_company_id_foreign FOREIGN KEY (company_id) REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- Name: fct_offers fct_offers_training_area_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_offers
    ADD CONSTRAINT fct_offers_training_area_id_foreign FOREIGN KEY (training_area_id) REFERENCES public.training_areas(id) ON DELETE CASCADE;


--
-- Name: fct_registered_users fct_registered_users_offer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_registered_users
    ADD CONSTRAINT fct_registered_users_offer_id_foreign FOREIGN KEY (offer_id) REFERENCES public.fct_offers(id) ON DELETE CASCADE;


--
-- Name: fct_registered_users fct_registered_users_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_registered_users
    ADD CONSTRAINT fct_registered_users_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: fct_schedules fct_schedules_agreement_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_schedules
    ADD CONSTRAINT fct_schedules_agreement_id_foreign FOREIGN KEY (agreement_id) REFERENCES public.fct_agreements(id) ON DELETE CASCADE;


--
-- Name: fct_schedules_backup fk_schedules_agreement; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.fct_schedules_backup
    ADD CONSTRAINT fk_schedules_agreement FOREIGN KEY (agreement_id) REFERENCES public.fct_agreements_backup(id) ON DELETE CASCADE;


--
-- Name: login_logs login_logs_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.login_logs
    ADD CONSTRAINT login_logs_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: provinces provinces_country_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.provinces
    ADD CONSTRAINT provinces_country_id_foreign FOREIGN KEY (country_id) REFERENCES public.countries(id) ON DELETE CASCADE;


--
-- Name: users_courses users_courses_course_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.users_courses
    ADD CONSTRAINT users_courses_course_id_foreign FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE CASCADE;


--
-- Name: users_courses users_courses_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.users_courses
    ADD CONSTRAINT users_courses_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: users_courses users_courses_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.users_courses
    ADD CONSTRAINT users_courses_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: users_data users_data_city_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.users_data
    ADD CONSTRAINT users_data_city_id_foreign FOREIGN KEY (city_id) REFERENCES public.cities(id) ON DELETE RESTRICT;


--
-- Name: users_data users_data_document_type_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.users_data
    ADD CONSTRAINT users_data_document_type_id_foreign FOREIGN KEY (document_type_id) REFERENCES public.document_types(id) ON DELETE RESTRICT;


--
-- Name: users_data users_data_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.users_data
    ADD CONSTRAINT users_data_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: users_roles users_roles_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.users_roles
    ADD CONSTRAINT users_roles_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: users_roles users_roles_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: tic
--

ALTER TABLE ONLY public.users_roles
    ADD CONSTRAINT users_roles_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict KCFsIjDvj6r0tgHIKUBAvOlTp5QIpxMCY9MsuqzPdZhVS1ikMc0sFPT236YKalJ

