PGDMP  :                
    {            moviemap    14.9 (Homebrew)    16.0 ,    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16385    moviemap    DATABASE     j   CREATE DATABASE moviemap WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE moviemap;
                sampeterson    false                        2615    2200    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                sampeterson    false            �           0    0    SCHEMA public    ACL     Q   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
                   sampeterson    false    6                        3079    19709    postgis 	   EXTENSION     ;   CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;
    DROP EXTENSION postgis;
                   false    6            �           0    0    EXTENSION postgis    COMMENT     ^   COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';
                        false    2            �            1259    20752    locationimages    TABLE     �   CREATE TABLE public.locationimages (
    id integer NOT NULL,
    location_id integer,
    path text,
    type integer,
    description character varying(240),
    CONSTRAINT locationimages_type_check CHECK (((type = 1) OR (type = 2)))
);
 "   DROP TABLE public.locationimages;
       public         heap    sampeterson    false    6            �            1259    20758    locationimages_id_seq    SEQUENCE     �   CREATE SEQUENCE public.locationimages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.locationimages_id_seq;
       public          sampeterson    false    215    6            �           0    0    locationimages_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.locationimages_id_seq OWNED BY public.locationimages.id;
          public          sampeterson    false    216            �            1259    20759 	   locations    TABLE     '  CREATE TABLE public.locations (
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
    DROP TABLE public.locations;
       public         heap    sampeterson    false    6    2    2    6    2    6    6    2    6    2    6    2    6    2    6    2    6            �            1259    20764    locations_id_serial    SEQUENCE     �   CREATE SEQUENCE public.locations_id_serial
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.locations_id_serial;
       public          sampeterson    false    6    217            �           0    0    locations_id_serial    SEQUENCE OWNED BY     H   ALTER SEQUENCE public.locations_id_serial OWNED BY public.locations.id;
          public          sampeterson    false    218            �            1259    20765    movies    TABLE     �   CREATE TABLE public.movies (
    id integer NOT NULL,
    tmdb_id integer,
    title text,
    director text,
    release_date date,
    overview text,
    poster_path text
);
    DROP TABLE public.movies;
       public         heap    sampeterson    false    6            �            1259    20770    movies_id_serial    SEQUENCE     �   CREATE SEQUENCE public.movies_id_serial
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.movies_id_serial;
       public          sampeterson    false    6    219            �           0    0    movies_id_serial    SEQUENCE OWNED BY     B   ALTER SEQUENCE public.movies_id_serial OWNED BY public.movies.id;
          public          sampeterson    false    220            �            1259    20771    test    TABLE     l   CREATE TABLE public.test (
    id integer NOT NULL,
    text text,
    geog public.geography(Point,4326)
);
    DROP TABLE public.test;
       public         heap    sampeterson    false    6    2    2    6    2    6    6    2    6    2    6    2    6    2    6    2    6            �            1259    20776    test_id_seq    SEQUENCE     �   CREATE SEQUENCE public.test_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.test_id_seq;
       public          sampeterson    false    221    6            �           0    0    test_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.test_id_seq OWNED BY public.test.id;
          public          sampeterson    false    222            �            1259    20777    users    TABLE     �   CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying,
    role character varying,
    created_at timestamp without time zone
);
    DROP TABLE public.users;
       public         heap    sampeterson    false    6                       2604    20782    locationimages id    DEFAULT     v   ALTER TABLE ONLY public.locationimages ALTER COLUMN id SET DEFAULT nextval('public.locationimages_id_seq'::regclass);
 @   ALTER TABLE public.locationimages ALTER COLUMN id DROP DEFAULT;
       public          sampeterson    false    216    215                       2604    20783    locations id    DEFAULT     o   ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_serial'::regclass);
 ;   ALTER TABLE public.locations ALTER COLUMN id DROP DEFAULT;
       public          sampeterson    false    218    217                       2604    20784 	   movies id    DEFAULT     i   ALTER TABLE ONLY public.movies ALTER COLUMN id SET DEFAULT nextval('public.movies_id_serial'::regclass);
 8   ALTER TABLE public.movies ALTER COLUMN id DROP DEFAULT;
       public          sampeterson    false    220    219                       2604    20785    test id    DEFAULT     b   ALTER TABLE ONLY public.test ALTER COLUMN id SET DEFAULT nextval('public.test_id_seq'::regclass);
 6   ALTER TABLE public.test ALTER COLUMN id DROP DEFAULT;
       public          sampeterson    false    222    221            �          0    20752    locationimages 
   TABLE DATA           R   COPY public.locationimages (id, location_id, path, type, description) FROM stdin;
    public          sampeterson    false    215   1       �          0    20759 	   locations 
   TABLE DATA           �   COPY public.locations (id, movie_id, description, "time", submitted_user, geo, title, sequence_order, main_img_path) FROM stdin;
    public          sampeterson    false    217   !1       �          0    20765    movies 
   TABLE DATA           c   COPY public.movies (id, tmdb_id, title, director, release_date, overview, poster_path) FROM stdin;
    public          sampeterson    false    219   �1       
          0    20021    spatial_ref_sys 
   TABLE DATA           X   COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
    public          sampeterson    false    211   4       �          0    20771    test 
   TABLE DATA           .   COPY public.test (id, text, geog) FROM stdin;
    public          sampeterson    false    221   <4       �          0    20777    users 
   TABLE DATA           ?   COPY public.users (id, username, role, created_at) FROM stdin;
    public          sampeterson    false    223   �4       �           0    0    locationimages_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.locationimages_id_seq', 1, false);
          public          sampeterson    false    216            �           0    0    locations_id_serial    SEQUENCE SET     A   SELECT pg_catalog.setval('public.locations_id_serial', 6, true);
          public          sampeterson    false    218            �           0    0    movies_id_serial    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.movies_id_serial', 23, true);
          public          sampeterson    false    220            �           0    0    test_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.test_id_seq', 6, true);
          public          sampeterson    false    222                       2606    20787 "   locationimages locationimages_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.locationimages
    ADD CONSTRAINT locationimages_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.locationimages DROP CONSTRAINT locationimages_pkey;
       public            sampeterson    false    215                       2606    20789    locations locations_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.locations DROP CONSTRAINT locations_pkey;
       public            sampeterson    false    217                       2606    20791    movies movies_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.movies DROP CONSTRAINT movies_pkey;
       public            sampeterson    false    219                       2606    20793    movies movies_tmdb_id_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_tmdb_id_key UNIQUE (tmdb_id);
 C   ALTER TABLE ONLY public.movies DROP CONSTRAINT movies_tmdb_id_key;
       public            sampeterson    false    219                       2606    20795    test test_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.test DROP CONSTRAINT test_pkey;
       public            sampeterson    false    221                       2606    20797    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            sampeterson    false    223                       2606    20798 .   locationimages locationimages_location_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.locationimages
    ADD CONSTRAINT locationimages_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);
 X   ALTER TABLE ONLY public.locationimages DROP CONSTRAINT locationimages_location_id_fkey;
       public          sampeterson    false    217    4374    215                        2606    20803 !   locations locations_movie_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id);
 K   ALTER TABLE ONLY public.locations DROP CONSTRAINT locations_movie_id_fkey;
       public          sampeterson    false    4376    217    219            !           2606    20808 '   locations locations_submitted_user_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_submitted_user_fkey FOREIGN KEY (submitted_user) REFERENCES public.users(id);
 Q   ALTER TABLE ONLY public.locations DROP CONSTRAINT locations_submitted_user_fkey;
       public          sampeterson    false    217    4382    223            �      x������ � �      �   �   x�u���0���)� 
�������'�^.��a`���5��������a�U�ﺞ�����~��S	ڄd
�����\�5�I���BmQ�� ��B@��,Y���84�r�-�BZ(��}�����f����Y{�N~��M����'v�"���0@So�Q�a�í�m��F���,�C�{ �QOH      �     x����n�0���Sr����ޒ:i�]�)�\(r,NC�!e�y�]ho��,��ϼz�\m��������e�1�C����]U��7յ���Ѹjm������W��r9�-���$e��"�L�(�Yp�![�e!L�#�^��G���IoL �=I�9��7ސ����;��z�ш�B���Mw��!������p�)�I�s����Z��$���Di�y�M�PCl´��ǇE�����_nݗ6??��-��j�kFg�j~~q��6܄��>��Iť�[���V;+�X��f�����0|6/4�����}d�f�
vx0��ʄFb�Mq��Ǘ-
YÐbp������`�l�k'`UrL�o;��Ӱ�H
�NQ9�):���|��$���PM�J_x-
��x��a�&�w�S%����	\���=12X�)A�C�`��U���P��y�Ym9z�� =����=ai�h��jDM|�S�H�����W:�g�2��k6�w?�k����{\���=Ku<��4�F����      
      x������ � �      �   �   x���;�0Dk�0@�>%`T���9�I�q��������>�w�	e��J2��4=���^*��L%P3�%ucX�7F�\�Ӈg��<<3f82��3��A3����A0�0�&���g3}��N�Gx��W)���F2      �      x������ � �     