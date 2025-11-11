-- Minimal schema for user and course management
-- Generated from original mondb_schema.sql
-- Compatible with PostgreSQL

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;

-- ========================
-- TABLE DEFINITIONS
-- ========================

CREATE TABLE public.centers (
    id bigint PRIMARY KEY,
    name character varying(30) NOT NULL,
    address character varying(100) NOT NULL,
    cif character varying(9) NOT NULL,
    center_code character varying(8) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);

CREATE TABLE public.countries (
    id bigint PRIMARY KEY,
    name character varying(100) NOT NULL UNIQUE,
    iso_code character varying(10) NOT NULL UNIQUE,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

CREATE TABLE public.provinces (
    id bigint PRIMARY KEY,
    name character varying(100) NOT NULL,
    country_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT provinces_name_country_id_unique UNIQUE (name, country_id),
    CONSTRAINT provinces_country_id_foreign FOREIGN KEY (country_id)
        REFERENCES public.countries(id) ON DELETE CASCADE
);

CREATE TABLE public.cities (
    id bigint PRIMARY KEY,
    name character varying(255) NOT NULL,
    province_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT cities_name_province_id_unique UNIQUE (name, province_id),
    CONSTRAINT cities_province_id_foreign FOREIGN KEY (province_id)
        REFERENCES public.provinces(id) ON DELETE CASCADE
);

CREATE TABLE public.training_areas (
    id bigint PRIMARY KEY,
    name character varying(50) NOT NULL,
    description character varying(200),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);

CREATE TABLE public.courses (
    id bigint PRIMARY KEY,
    name character varying(150) NOT NULL,
    description character varying(200),
    training_area_id bigint NOT NULL,
    center_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    code character varying(10),
    study_type character varying(10) NOT NULL,
    CONSTRAINT courses_training_area_id_foreign FOREIGN KEY (training_area_id)
        REFERENCES public.training_areas(id) ON DELETE CASCADE,
    CONSTRAINT courses_center_id_foreign FOREIGN KEY (center_id)
        REFERENCES public.centers(id) ON DELETE CASCADE
);

CREATE TABLE public.document_types (
    id bigint PRIMARY KEY,
    name character varying(100) NOT NULL,
    abbreviation character varying(20) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);

CREATE TABLE public.roles (
    id bigint PRIMARY KEY,
    name character varying(50) NOT NULL,
    description character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);

CREATE TABLE public.users (
    id bigint PRIMARY KEY,
    password character varying(255) NOT NULL,
    status character(50) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);

CREATE TABLE public.emails (
    id bigint PRIMARY KEY,
    user_id bigint NOT NULL,
    email text NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    email_hash character varying(64) UNIQUE,
    CONSTRAINT emails_user_id_foreign FOREIGN KEY (user_id)
        REFERENCES public.users(id) ON DELETE CASCADE
);

CREATE TABLE public.users_data (
    id bigint PRIMARY KEY,
    name character varying(50) NOT NULL,
    last_name_1 character varying(50) NOT NULL,
    last_name_2 character varying(50),
    birthdate date NOT NULL,
    dni text UNIQUE,
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
    nie text,
    CONSTRAINT users_data_user_id_foreign FOREIGN KEY (user_id)
        REFERENCES public.users(id) ON DELETE CASCADE,
    CONSTRAINT users_data_city_id_foreign FOREIGN KEY (city_id)
        REFERENCES public.cities(id) ON DELETE RESTRICT,
    CONSTRAINT users_data_document_type_id_foreign FOREIGN KEY (document_type_id)
        REFERENCES public.document_types(id) ON DELETE RESTRICT
);

CREATE TABLE public.users_courses (
    id bigint PRIMARY KEY,
    academic_course character varying(10) NOT NULL,
    user_id bigint NOT NULL,
    course_id bigint NOT NULL,
    role_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone,
    year_level integer,
    is_withdrawn boolean,
    CONSTRAINT users_courses_user_id_foreign FOREIGN KEY (user_id)
        REFERENCES public.users(id) ON DELETE CASCADE,
    CONSTRAINT users_courses_course_id_foreign FOREIGN KEY (course_id)
        REFERENCES public.courses(id) ON DELETE CASCADE,
    CONSTRAINT users_courses_role_id_foreign FOREIGN KEY (role_id)
        REFERENCES public.roles(id) ON DELETE CASCADE
);

CREATE TABLE public.users_roles (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    PRIMARY KEY (user_id, role_id),
    CONSTRAINT users_roles_user_id_foreign FOREIGN KEY (user_id)
        REFERENCES public.users(id) ON DELETE CASCADE,
    CONSTRAINT users_roles_role_id_foreign FOREIGN KEY (role_id)
        REFERENCES public.roles(id) ON DELETE CASCADE
);
