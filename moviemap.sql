--
-- PostgreSQL database dump
--

-- Dumped from database version 14.10 (Homebrew)
-- Dumped by pg_dump version 14.10 (Homebrew)

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
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: sampeterson
--

CREATE TABLE public.addresses (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    street character varying(100) NOT NULL,
    city character varying(50) NOT NULL,
    state character varying(2) NOT NULL,
    zip character varying(10) NOT NULL,
    specificity character varying(16) NOT NULL
);


ALTER TABLE public.addresses OWNER TO sampeterson;

--
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: sampeterson
--

CREATE SEQUENCE public.addresses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.addresses_id_seq OWNER TO sampeterson;

--
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sampeterson
--

ALTER SEQUENCE public.addresses_id_seq OWNED BY public.addresses.id;


--
-- Name: locationimages; Type: TABLE; Schema: public; Owner: sampeterson
--

CREATE TABLE public.locationimages (
    id integer NOT NULL,
    location_id integer,
    file_name text,
    type integer,
    description character varying(240),
    created_at timestamp without time zone DEFAULT now(),
    main boolean,
    CONSTRAINT locationimages_type_check CHECK (((type = 1) OR (type = 2)))
);


ALTER TABLE public.locationimages OWNER TO sampeterson;

--
-- Name: locationimages_id_seq; Type: SEQUENCE; Schema: public; Owner: sampeterson
--

CREATE SEQUENCE public.locationimages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.locationimages_id_seq OWNER TO sampeterson;

--
-- Name: locationimages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sampeterson
--

ALTER SEQUENCE public.locationimages_id_seq OWNED BY public.locationimages.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: sampeterson
--

CREATE TABLE public.locations (
    id integer NOT NULL,
    movie_id integer,
    scene_desc text,
    "time" timestamp without time zone,
    submitted_user integer,
    geo public.geography(Point,4326),
    title character varying(255),
    sequence_order integer,
    main_img_path text,
    location_desc text,
    g_streetview_embed_url text,
    location_name character varying(255),
    street character varying(100),
    city character varying(50),
    region character varying(50),
    zip character varying(10),
    specificity character varying(16) DEFAULT 'hide'::character varying NOT NULL,
    country character varying,
    CONSTRAINT valid_specificity CHECK (((specificity)::text = ANY (ARRAY[('hide'::character varying)::text, ('street'::character varying)::text, ('city'::character varying)::text, ('region'::character varying)::text, ('country'::character varying)::text])))
);


ALTER TABLE public.locations OWNER TO sampeterson;

--
-- Name: locations_id_serial; Type: SEQUENCE; Schema: public; Owner: sampeterson
--

CREATE SEQUENCE public.locations_id_serial
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.locations_id_serial OWNER TO sampeterson;

--
-- Name: locations_id_serial; Type: SEQUENCE OWNED BY; Schema: public; Owner: sampeterson
--

ALTER SEQUENCE public.locations_id_serial OWNED BY public.locations.id;


--
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
-- Name: movies_id_serial; Type: SEQUENCE; Schema: public; Owner: sampeterson
--

CREATE SEQUENCE public.movies_id_serial
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.movies_id_serial OWNER TO sampeterson;

--
-- Name: movies_id_serial; Type: SEQUENCE OWNED BY; Schema: public; Owner: sampeterson
--

ALTER SEQUENCE public.movies_id_serial OWNED BY public.movies.id;


--
-- Name: test; Type: TABLE; Schema: public; Owner: sampeterson
--

CREATE TABLE public.test (
    id integer NOT NULL,
    text text,
    geog public.geography(Point,4326)
);


ALTER TABLE public.test OWNER TO sampeterson;

--
-- Name: test_id_seq; Type: SEQUENCE; Schema: public; Owner: sampeterson
--

CREATE SEQUENCE public.test_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.test_id_seq OWNER TO sampeterson;

--
-- Name: test_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sampeterson
--

ALTER SEQUENCE public.test_id_seq OWNED BY public.test.id;


--
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
-- Name: addresses id; Type: DEFAULT; Schema: public; Owner: sampeterson
--

ALTER TABLE ONLY public.addresses ALTER COLUMN id SET DEFAULT nextval('public.addresses_id_seq'::regclass);


--
-- Name: locationimages id; Type: DEFAULT; Schema: public; Owner: sampeterson
--

ALTER TABLE ONLY public.locationimages ALTER COLUMN id SET DEFAULT nextval('public.locationimages_id_seq'::regclass);


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: sampeterson
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_serial'::regclass);


--
-- Name: movies id; Type: DEFAULT; Schema: public; Owner: sampeterson
--

ALTER TABLE ONLY public.movies ALTER COLUMN id SET DEFAULT nextval('public.movies_id_serial'::regclass);


--
-- Name: test id; Type: DEFAULT; Schema: public; Owner: sampeterson
--

ALTER TABLE ONLY public.test ALTER COLUMN id SET DEFAULT nextval('public.test_id_seq'::regclass);


--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: sampeterson
--

COPY public.addresses (id, name, street, city, state, zip, specificity) FROM stdin;
\.


--
-- Data for Name: locationimages; Type: TABLE DATA; Schema: public; Owner: sampeterson
--

COPY public.locationimages (id, location_id, file_name, type, description, created_at, main) FROM stdin;
14	7	1700123876478-ezgif-2-abfb9a8083.jpg	1	image caption!	2023-11-16 01:37:56.487094	\N
16	8	1700124094219-fe6854a5f6da51a47e3d412bc7d890e2.jpg	1	image caption! 1	2023-11-16 01:41:34.221209	\N
17	8	1700124097502-08.jpg	1	desc 2	2023-11-16 01:41:37.506519	\N
21	10	1700209808932-fff4c437b3be8493ff59f66c258db014.jpg	1	cap 1	2023-11-17 01:30:08.936648	t
22	10	1700209811173-ezgif-2-abfb9a8083.jpg	1	cap 2	2023-11-17 01:30:11.177138	f
29	12	1701240233038-FOB_05172017_Lynch_Ebiri_Lost_Highway_1997_25a_issue.jpg	1	in your house	2023-11-28 23:43:53.044122	t
30	12	1701240237554-BADBADNOTGOOD_&_Ghostface_Killah_-__Sour_Soul__official_album_artwork.jpg	1	killah	2023-11-28 23:43:57.557038	f
31	12	1701240247801-28976cbe01182f16e6c56172f4253408.jpg	2	how does she do it?	2023-11-28 23:44:07.803691	t
26	11	1700212772571-the-rake-lionel-terray-alaska-1964x.jpg	1	caption for this one	2023-11-17 02:19:32.573768	f
27	11	1700212774768-6219cfc3b39826e0e18fdac2f7bc787e.jpg	1	123123123123	2023-11-17 02:19:34.770582	t
41	11	1704500890047-ALAINDELON.jpg	1	alain delon 2	2024-01-05 17:28:10.058423	f
28	11	1700212778781-bf7c19e73fcfda75afb917bec789ca78.jpg	2	hello	2023-11-17 02:19:38.783154	f
42	11	1705094002967-editor-ss.jpeg	2	jhb	2024-01-12 14:13:22.972324	t
43	6	1706077361771-construction.jpg	1	Henry Spencer walks over a mound of dirt	2024-01-23 23:22:41.782218	t
44	6	1706078068210-Bevcent.jpg	2	The Beverly Center in Los Angeles, California	2024-01-23 23:34:28.212726	t
45	5	1706079589487-tunnel.jpg	1	Henry Spencer wanders towards a tunnel	2024-01-23 23:59:49.498533	t
46	5	1706080436765-Fourth_Street_Bridge_1930s.jpg	2	The 4th Street Viaduct in Los Angeles, California	2024-01-24 00:13:56.767165	t
\.


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: sampeterson
--

COPY public.locations (id, movie_id, scene_desc, "time", submitted_user, geo, title, sequence_order, main_img_path, location_desc, g_streetview_embed_url, location_name, street, city, region, zip, specificity, country) FROM stdin;
1	\N	\N	\N	\N	\N	hello there new world	\N	\N	\N	\N	\N	\N	\N	\N	\N	hide	\N
7	1	the description	\N	\N	0101000020E610000000000000000000000000000000000000	the title	\N	\N	\N	\N	\N	\N	\N	\N	\N	hide	\N
8	1	the description 2	\N	\N	0101000020E610000000000000000000000000000000000000	the title again	\N	\N	\N	\N	\N	\N	\N	\N	\N	hide	\N
10	1	Description	\N	\N	0101000020E610000089B5F8140023F9BF40683D7C99BA4740	Title	\N	\N	\N	\N	\N	\N	\N	\N	\N	hide	\N
12	1	This is michigan !	\N	\N	0101000020E610000001000000203455C08E938850D1884540	Michigan	\N	\N	\N	\N	\N	\N	\N	\N	\N	hide	\N
11	1	orem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed sem vitae arcu facilisis aliquet et quis nisi. Nunc malesuada tortor at orci porttitor viverra. 	\N	\N	0101000020E6100000010000C09BE855C07AC9735ECCED4440	The Battle in Shibuya	\N	\N	orem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed sem vitae arcu facilisis aliquet et quis nisi. Nunc malesuada tortor at orci porttitor viverra. Integer venenatis libero ac erat sagittis maximus. Ut ac egestas felis. Vivamus iaculis ante ac magna accumsan, eu iaculis diam iaculis. Morbi aliquam odio quis mauris semper laoreet. Phasellus nec tincidunt urna, in varius magna.		18th Street Bridge	South Lumber Street, Lower West Side	Chicago	Illinois	60607	street	US
6	19	On his walk home, Henry Spencer passes through a construction site.	\N	\N	0101000020E61000002836DD8C27985DC0DB803B80A3094140	The construction site	\N	/api/images/construction.jpg	The construction where this scene was filmed is now the location of the Beverly Center Shopping Center.	https://www.google.com/maps/embed?pb=!4v1706078195241!6m8!1m7!1sfMHOpRLIFMZhp4A2uHLOJg!2m2!1d34.07602388165158!2d-118.3766441245142!3f221.92986248850903!4f18.428747860185936!5f0.7820865974627469	Beverly Center	South San Vicente Boulevard	Los Angeles	California	90048	street	US
5	19	Beginning his walk home, Henry Spencer passes through a tunnel.	\N	\N	0101000020E610000093967748D18E5DC0DB35C5C643054140	The Tunnel	\N	/api/images/tunnel.jpg	This tunnel sits under the 4th Street viaduct in Los Angeles, California, where it provides crossing over the Los Angeles River. As of 2022, the tunnel appears much the same as it did in 1977, though its surroundings have changed. It is now fenced off, and a railway line no longer passes through it. Instead, a sidewalk leads to the parking lot that now sits on the other side.	https://www.google.com/maps/embed?pb=!4v1706079781410!6m8!1m7!1sFmYUSEP8-OyuqwHCBA8_Ig!2m2!1d34.04107625525651!2d-118.2314945060246!3f354.5424518999775!4f2.6189165491796302!5f2.565995679725523	4th Street Viaduct	508, South Santa Fe Avenue, Arts District	Los Angeles	California	90013	street	US
\.


--
-- Data for Name: movies; Type: TABLE DATA; Schema: public; Owner: sampeterson
--

COPY public.movies (id, tmdb_id, title, director, release_date, overview, poster_path) FROM stdin;
1	\N	TEST	\N	\N	\N	\N
16	\N	hello world	\N	\N	\N	\N
19	985	Eraserhead	David Lynch	1977-03-19	First time father Henry Spencer tries to survive his industrial environment, his angry girlfriend, and the unbearable screams of his newly born mutant child.	https://image.tmdb.org/t/p/original/mxveW3mGVc0DzLdOmtkZsgd7c3B.jpg
23	16869	Inglourious Basterds	Quentin Tarantino	2009-08-19	In Nazi-occupied France during World War II, a group of Jewish-American soldiers known as "The Basterds" are chosen specifically to spread fear throughout the Third Reich by scalping and brutally killing Nazis. The Basterds, lead by Lt. Aldo Raine soon cross paths with a French-Jewish teenage girl who runs a movie theater in Paris which is targeted by the soldiers.	https://image.tmdb.org/t/p/original/7sfbEnaARXDDhKm0CZ7D7uc2sbo.jpg
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: sampeterson
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: test; Type: TABLE DATA; Schema: public; Owner: sampeterson
--

COPY public.test (id, text, geog) FROM stdin;
1	\N	0101000020E610000075029A081B9A5DC0F085C954C1F84040
2	\N	0101000020E6100000787AA52C43EC32C0E07A14AE47614740
3	\N	0101000020E610000075029A081B9A5DC0F085C954C1F84040
4	\N	0101000020E6100000F085C954C1F8404016FBCBEEC9CB4EC0
5	\N	0101000020E6100000531409C92BF75BC04A282E4A1B624440
6	\N	0101000020E61000004A282E4A1B624440ADEBF636D40851C0
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: sampeterson
--

COPY public.users (id, username, role, created_at) FROM stdin;
\.


--
-- Name: addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sampeterson
--

SELECT pg_catalog.setval('public.addresses_id_seq', 1, false);


--
-- Name: locationimages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sampeterson
--

SELECT pg_catalog.setval('public.locationimages_id_seq', 46, true);


--
-- Name: locations_id_serial; Type: SEQUENCE SET; Schema: public; Owner: sampeterson
--

SELECT pg_catalog.setval('public.locations_id_serial', 12, true);


--
-- Name: movies_id_serial; Type: SEQUENCE SET; Schema: public; Owner: sampeterson
--

SELECT pg_catalog.setval('public.movies_id_serial', 23, true);


--
-- Name: test_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sampeterson
--

SELECT pg_catalog.setval('public.test_id_seq', 6, true);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: sampeterson
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: locationimages locationimages_pkey; Type: CONSTRAINT; Schema: public; Owner: sampeterson
--

ALTER TABLE ONLY public.locationimages
    ADD CONSTRAINT locationimages_pkey PRIMARY KEY (id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: sampeterson
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: movies movies_pkey; Type: CONSTRAINT; Schema: public; Owner: sampeterson
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (id);


--
-- Name: movies movies_tmdb_id_key; Type: CONSTRAINT; Schema: public; Owner: sampeterson
--

ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_tmdb_id_key UNIQUE (tmdb_id);


--
-- Name: test test_pkey; Type: CONSTRAINT; Schema: public; Owner: sampeterson
--

ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: sampeterson
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: locationimages locationimages_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sampeterson
--

ALTER TABLE ONLY public.locationimages
    ADD CONSTRAINT locationimages_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- Name: locations locations_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sampeterson
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id);


--
-- Name: locations locations_submitted_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sampeterson
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_submitted_user_fkey FOREIGN KEY (submitted_user) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

