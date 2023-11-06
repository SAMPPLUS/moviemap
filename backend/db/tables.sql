--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0
-- Dumped by pg_dump version 16.0

-- Started on 2023-11-05 14:37:49

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: sampeterson
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO sampeterson;

--
-- TOC entry 2 (class 3079 OID 17585)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 5798 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 221 (class 1259 OID 18661)
-- Name: locations; Type: TABLE; Schema: public; Owner: sampeterson
--

CREATE TABLE public.locations (
    id integer NOT NULL,
    movie_id integer,
    description text,
    "time" timestamp without time zone,
    submitted_user integer,
    geo public.geography(Point,4326),
    title character varying(255)
);


ALTER TABLE public.locations OWNER TO sampeterson;

--
-- TOC entry 222 (class 1259 OID 18666)
-- Name: locations_id_serial; Type: SEQUENCE; Schema: public; Owner: sampeterson
--

CREATE SEQUENCE public.locations_id_serial
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.locations_id_serial OWNER TO sampeterson;

--
-- TOC entry 5799 (class 0 OID 0)
-- Dependencies: 222
-- Name: locations_id_serial; Type: SEQUENCE OWNED BY; Schema: public; Owner: sampeterson
--

ALTER SEQUENCE public.locations_id_serial OWNED BY public.locations.id;


--
-- TOC entry 223 (class 1259 OID 18667)
-- Name: movies; Type: TABLE; Schema: public; Owner: sampeterson
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


ALTER TABLE public.movies OWNER TO sampeterson;

--
-- TOC entry 224 (class 1259 OID 18672)
-- Name: movies_id_serial; Type: SEQUENCE; Schema: public; Owner: sampeterson
--

CREATE SEQUENCE public.movies_id_serial
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.movies_id_serial OWNER TO sampeterson;

--
-- TOC entry 5800 (class 0 OID 0)
-- Dependencies: 224
-- Name: movies_id_serial; Type: SEQUENCE OWNED BY; Schema: public; Owner: sampeterson
--

ALTER SEQUENCE public.movies_id_serial OWNED BY public.movies.id;


--
-- TOC entry 225 (class 1259 OID 18673)
-- Name: test; Type: TABLE; Schema: public; Owner: sampeterson
--

CREATE TABLE public.test (
    id integer NOT NULL,
    text text,
    geog public.geography(Point,4326)
);


ALTER TABLE public.test OWNER TO sampeterson;

--
-- TOC entry 226 (class 1259 OID 18678)
-- Name: test_id_seq; Type: SEQUENCE; Schema: public; Owner: sampeterson
--

CREATE SEQUENCE public.test_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.test_id_seq OWNER TO sampeterson;

--
-- TOC entry 5801 (class 0 OID 0)
-- Dependencies: 226
-- Name: test_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sampeterson
--

ALTER SEQUENCE public.test_id_seq OWNED BY public.test.id;


--
-- TOC entry 227 (class 1259 OID 18679)
-- Name: users; Type: TABLE; Schema: public; Owner: sampeterson
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying,
    role character varying,
    created_at timestamp without time zone
);


ALTER TABLE public.users OWNER TO sampeterson;

--
-- TOC entry 5626 (class 2604 OID 18684)
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: sampeterson
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_serial'::regclass);


--
-- TOC entry 5627 (class 2604 OID 18685)
-- Name: movies id; Type: DEFAULT; Schema: public; Owner: sampeterson
--

ALTER TABLE ONLY public.movies ALTER COLUMN id SET DEFAULT nextval('public.movies_id_serial'::regclass);


--
-- TOC entry 5628 (class 2604 OID 18686)
-- Name: test id; Type: DEFAULT; Schema: public; Owner: sampeterson
--

ALTER TABLE ONLY public.test ALTER COLUMN id SET DEFAULT nextval('public.test_id_seq'::regclass);


--
-- TOC entry 5633 (class 2606 OID 18688)
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: sampeterson
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- TOC entry 5635 (class 2606 OID 18690)
-- Name: movies movies_pkey; Type: CONSTRAINT; Schema: public; Owner: sampeterson
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (id);


--
-- TOC entry 5637 (class 2606 OID 18692)
-- Name: movies movies_tmdb_id_key; Type: CONSTRAINT; Schema: public; Owner: sampeterson
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_tmdb_id_key UNIQUE (tmdb_id);


--
-- TOC entry 5639 (class 2606 OID 18694)
-- Name: test test_pkey; Type: CONSTRAINT; Schema: public; Owner: sampeterson
--

ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (id);


--
-- TOC entry 5641 (class 2606 OID 18696)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: sampeterson
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 5642 (class 2606 OID 18697)
-- Name: locations locations_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sampeterson
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id);


--
-- TOC entry 5643 (class 2606 OID 18702)
-- Name: locations locations_submitted_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sampeterson
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_submitted_user_fkey FOREIGN KEY (submitted_user) REFERENCES public.users(id);


--
-- TOC entry 5797 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: sampeterson
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2023-11-05 14:37:49

--
-- PostgreSQL database dump complete
--

