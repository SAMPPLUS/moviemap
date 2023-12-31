--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0
-- Dumped by pg_dump version 16.0

-- Started on 2023-11-13 17:35:53

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
-- TOC entry 6 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


--
-- TOC entry 2 (class 3079 OID 19871)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 5808 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 221 (class 1259 OID 20947)
-- Name: locationimages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.locationimages (
    id integer NOT NULL,
    location_id integer,
    file_name text,
    type integer,
    description character varying(240),
    created_at timestamp without time zone DEFAULT now(),
    CONSTRAINT locationimages_type_check CHECK (((type = 1) OR (type = 2)))
);


--
-- TOC entry 222 (class 1259 OID 20953)
-- Name: locationimages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.locationimages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5809 (class 0 OID 0)
-- Dependencies: 222
-- Name: locationimages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.locationimages_id_seq OWNED BY public.locationimages.id;


--
-- TOC entry 223 (class 1259 OID 20954)
-- Name: locations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.locations (
    id integer NOT NULL,
    movie_id integer,
    description text,
    "time" timestamp without time zone,
    submitted_user integer,
    geo public.geography(Point,4326),
    title character varying(255),
    sequence_order integer,
    main_img_path text
);


--
-- TOC entry 224 (class 1259 OID 20959)
-- Name: locations_id_serial; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.locations_id_serial
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5810 (class 0 OID 0)
-- Dependencies: 224
-- Name: locations_id_serial; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.locations_id_serial OWNED BY public.locations.id;


--
-- TOC entry 225 (class 1259 OID 20960)
-- Name: movies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.movies (
    id integer NOT NULL,
    tmdb_id integer,
    title text,
    director text,
    release_date date,
    overview text,
    poster_path text
);


--
-- TOC entry 226 (class 1259 OID 20965)
-- Name: movies_id_serial; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.movies_id_serial
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5811 (class 0 OID 0)
-- Dependencies: 226
-- Name: movies_id_serial; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.movies_id_serial OWNED BY public.movies.id;


--
-- TOC entry 227 (class 1259 OID 20966)
-- Name: test; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.test (
    id integer NOT NULL,
    text text,
    geog public.geography(Point,4326)
);


--
-- TOC entry 228 (class 1259 OID 20971)
-- Name: test_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.test_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5812 (class 0 OID 0)
-- Dependencies: 228
-- Name: test_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.test_id_seq OWNED BY public.test.id;


--
-- TOC entry 229 (class 1259 OID 20972)
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying,
    role character varying,
    created_at timestamp without time zone
);


--
-- TOC entry 5631 (class 2604 OID 20977)
-- Name: locationimages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locationimages ALTER COLUMN id SET DEFAULT nextval('public.locationimages_id_seq'::regclass);


--
-- TOC entry 5633 (class 2604 OID 20978)
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_serial'::regclass);


--
-- TOC entry 5634 (class 2604 OID 20979)
-- Name: movies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movies ALTER COLUMN id SET DEFAULT nextval('public.movies_id_serial'::regclass);


--
-- TOC entry 5635 (class 2604 OID 20980)
-- Name: test id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test ALTER COLUMN id SET DEFAULT nextval('public.test_id_seq'::regclass);


--
-- TOC entry 5641 (class 2606 OID 20982)
-- Name: locationimages locationimages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locationimages
    ADD CONSTRAINT locationimages_pkey PRIMARY KEY (id);


--
-- TOC entry 5643 (class 2606 OID 20984)
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- TOC entry 5645 (class 2606 OID 20986)
-- Name: movies movies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (id);


--
-- TOC entry 5647 (class 2606 OID 20988)
-- Name: movies movies_tmdb_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_tmdb_id_key UNIQUE (tmdb_id);


--
-- TOC entry 5649 (class 2606 OID 20990)
-- Name: test test_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (id);


--
-- TOC entry 5651 (class 2606 OID 20992)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 5652 (class 2606 OID 20993)
-- Name: locationimages locationimages_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locationimages
    ADD CONSTRAINT locationimages_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- TOC entry 5653 (class 2606 OID 20998)
-- Name: locations locations_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id);


--
-- TOC entry 5654 (class 2606 OID 21003)
-- Name: locations locations_submitted_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_submitted_user_fkey FOREIGN KEY (submitted_user) REFERENCES public.users(id);


-- Completed on 2023-11-13 17:35:53

--
-- PostgreSQL database dump complete
--

