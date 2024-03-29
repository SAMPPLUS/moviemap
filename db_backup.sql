PGDMP      2            
    {            moviemap    16.0    16.0 ,    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16398    moviemap    DATABASE     �   CREATE DATABASE moviemap WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE moviemap;
                postgres    false                        2615    2200    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                sampeterson    false            �           0    0    SCHEMA public    ACL     Q   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
                   sampeterson    false    6                        3079    19871    postgis 	   EXTENSION     ;   CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;
    DROP EXTENSION postgis;
                   false    6            �           0    0    EXTENSION postgis    COMMENT     ^   COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';
                        false    2            �            1259    20947    locationimages    TABLE     @  CREATE TABLE public.locationimages (
    id integer NOT NULL,
    location_id integer,
    file_name text,
    type integer,
    description character varying(240),
    created_at timestamp without time zone DEFAULT now(),
    main boolean,
    CONSTRAINT locationimages_type_check CHECK (((type = 1) OR (type = 2)))
);
 "   DROP TABLE public.locationimages;
       public         heap    sampeterson    false    6            �            1259    20953    locationimages_id_seq    SEQUENCE     �   CREATE SEQUENCE public.locationimages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.locationimages_id_seq;
       public          sampeterson    false    6    221            �           0    0    locationimages_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.locationimages_id_seq OWNED BY public.locationimages.id;
          public          sampeterson    false    222            �            1259    20954 	   locations    TABLE     '  CREATE TABLE public.locations (
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
       public         heap    sampeterson    false    2    2    6    2    6    2    6    2    6    2    6    2    6    6    2    6    6            �            1259    20959    locations_id_serial    SEQUENCE     �   CREATE SEQUENCE public.locations_id_serial
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.locations_id_serial;
       public          sampeterson    false    6    223            �           0    0    locations_id_serial    SEQUENCE OWNED BY     H   ALTER SEQUENCE public.locations_id_serial OWNED BY public.locations.id;
          public          sampeterson    false    224            �            1259    20960    movies    TABLE     �   CREATE TABLE public.movies (
    id integer NOT NULL,
    tmdb_id integer,
    title text,
    director text,
    release_date date,
    overview text,
    poster_path text
);
    DROP TABLE public.movies;
       public         heap    sampeterson    false    6            �            1259    20965    movies_id_serial    SEQUENCE     �   CREATE SEQUENCE public.movies_id_serial
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.movies_id_serial;
       public          sampeterson    false    225    6            �           0    0    movies_id_serial    SEQUENCE OWNED BY     B   ALTER SEQUENCE public.movies_id_serial OWNED BY public.movies.id;
          public          sampeterson    false    226            �            1259    20966    test    TABLE     l   CREATE TABLE public.test (
    id integer NOT NULL,
    text text,
    geog public.geography(Point,4326)
);
    DROP TABLE public.test;
       public         heap    sampeterson    false    6    2    2    6    2    6    2    6    2    6    2    6    2    6    6    2    6            �            1259    20971    test_id_seq    SEQUENCE     �   CREATE SEQUENCE public.test_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.test_id_seq;
       public          sampeterson    false    227    6            �           0    0    test_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.test_id_seq OWNED BY public.test.id;
          public          sampeterson    false    228            �            1259    20972    users    TABLE     �   CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying,
    role character varying,
    created_at timestamp without time zone
);
    DROP TABLE public.users;
       public         heap    sampeterson    false    6            �           2604    20977    locationimages id    DEFAULT     v   ALTER TABLE ONLY public.locationimages ALTER COLUMN id SET DEFAULT nextval('public.locationimages_id_seq'::regclass);
 @   ALTER TABLE public.locationimages ALTER COLUMN id DROP DEFAULT;
       public          sampeterson    false    222    221                       2604    20978    locations id    DEFAULT     o   ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_serial'::regclass);
 ;   ALTER TABLE public.locations ALTER COLUMN id DROP DEFAULT;
       public          sampeterson    false    224    223                       2604    20979 	   movies id    DEFAULT     i   ALTER TABLE ONLY public.movies ALTER COLUMN id SET DEFAULT nextval('public.movies_id_serial'::regclass);
 8   ALTER TABLE public.movies ALTER COLUMN id DROP DEFAULT;
       public          sampeterson    false    226    225                       2604    20980    test id    DEFAULT     b   ALTER TABLE ONLY public.test ALTER COLUMN id SET DEFAULT nextval('public.test_id_seq'::regclass);
 6   ALTER TABLE public.test ALTER COLUMN id DROP DEFAULT;
       public          sampeterson    false    228    227            �          0    20947    locationimages 
   TABLE DATA           i   COPY public.locationimages (id, location_id, file_name, type, description, created_at, main) FROM stdin;
    public          sampeterson    false    221   u1       �          0    20954 	   locations 
   TABLE DATA           �   COPY public.locations (id, movie_id, description, "time", submitted_user, geo, title, sequence_order, main_img_path) FROM stdin;
    public          sampeterson    false    223   �3       �          0    20960    movies 
   TABLE DATA           c   COPY public.movies (id, tmdb_id, title, director, release_date, overview, poster_path) FROM stdin;
    public          sampeterson    false    225   >5       �          0    20189    spatial_ref_sys 
   TABLE DATA           X   COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
    public          postgres    false    217   h7       �          0    20966    test 
   TABLE DATA           .   COPY public.test (id, text, geog) FROM stdin;
    public          sampeterson    false    227   �7       �          0    20972    users 
   TABLE DATA           ?   COPY public.users (id, username, role, created_at) FROM stdin;
    public          sampeterson    false    229   !8       �           0    0    locationimages_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.locationimages_id_seq', 31, true);
          public          sampeterson    false    222            �           0    0    locations_id_serial    SEQUENCE SET     B   SELECT pg_catalog.setval('public.locations_id_serial', 12, true);
          public          sampeterson    false    224            �           0    0    movies_id_serial    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.movies_id_serial', 23, true);
          public          sampeterson    false    226            �           0    0    test_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.test_id_seq', 6, true);
          public          sampeterson    false    228            	           2606    20982 "   locationimages locationimages_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.locationimages
    ADD CONSTRAINT locationimages_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.locationimages DROP CONSTRAINT locationimages_pkey;
       public            sampeterson    false    221                       2606    20984    locations locations_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.locations DROP CONSTRAINT locations_pkey;
       public            sampeterson    false    223                       2606    20986    movies movies_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.movies DROP CONSTRAINT movies_pkey;
       public            sampeterson    false    225                       2606    20988    movies movies_tmdb_id_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_tmdb_id_key UNIQUE (tmdb_id);
 C   ALTER TABLE ONLY public.movies DROP CONSTRAINT movies_tmdb_id_key;
       public            sampeterson    false    225                       2606    20990    test test_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.test DROP CONSTRAINT test_pkey;
       public            sampeterson    false    227                       2606    20992    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            sampeterson    false    229                       2606    20993 .   locationimages locationimages_location_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.locationimages
    ADD CONSTRAINT locationimages_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);
 X   ALTER TABLE ONLY public.locationimages DROP CONSTRAINT locationimages_location_id_fkey;
       public          sampeterson    false    221    5643    223                       2606    20998 !   locations locations_movie_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id);
 K   ALTER TABLE ONLY public.locations DROP CONSTRAINT locations_movie_id_fkey;
       public          sampeterson    false    223    225    5645                       2606    21003 '   locations locations_submitted_user_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_submitted_user_fkey FOREIGN KEY (submitted_user) REFERENCES public.users(id);
 Q   ALTER TABLE ONLY public.locations DROP CONSTRAINT locations_submitted_user_fkey;
       public          sampeterson    false    5651    223    229            �   T  x�u��n�0���S���(p�?K�R4H��C{@P4i�V�����O_�q;uB	j���Ȃ
 ��!-ɰ�g�%��7���p#�_����ޯb���
�( ]r��JW�����Y�.�AX�#�R�FI��^z^RK	�Z�#�Ŕ�$3KV����At"őqs�Z�1�xF�*ŵ�� B|��s�V K)� 5��FZ���I��,�M��}��|+������� @��	�z��@D L���g=@"Tlj#��ud}N,�l����1��q�X-��T�4�Sۍe�~��l-�R$H���	N�S�s3C
�֠�<�IK0Qn��x`�z]g �"���\�9�2��Dl$�B'�sT@M�<=w��{]g �"#@ɹ�͐yNP.�z{�B�w�u_�nӹ�a�ܷn�>��kɡ���Ku�C������[�hJ���y�1�?!�R�]|�������������LL>D���{�:�܏�??z熔��������;������`e��⌇<��~l{ȿ9�/Zҡ��`uP:��$*!�K���T.�8�c�K�M�޳dͩ2\h�޻j�X�]c�      �   U  x���O��0���)��]��?�G�x[O�l���Ve����i�L��{y)F���n\��lj��X�N����z�M$�$� J�6�} ҂T\h�P�30�P
}9�F'�$�T(��̈́�U�� %QB�i��εg��<��ߗ���e��:Ա>;y��Ihk)牡��;`nUߍ�p�&�wl���+w��"�D�`�΍����C����Ժ9[�g�S|�ʺ���!����ԊBT���d+	��Mrc�T&��#��XUv�|��f}%T�J",�?�FK�y���M�<P7�Y软_�{{�� �R9Pa�� @R��̘��E�߹)�,      �     x����n�0���Sr����ޒ:i�]�)�\(r,NC�!e�y�]ho��,��ϼz�\m��������e�1�C����]U��7յ���Ѹjm������W��r9�-���$e��"�L�(�Yp�![�e!L�#�^��G���IoL �=I�9��7ސ����;��z�ш�B���Mw��!������p�)�I�s����Z��$���Di�y�M�PCl´��ǇE�����_nݗ6??��-��j�kFg�j~~q��6܄��>��Iť�[���V;+�X��f�����0|6/4�����}d�f�
vx0��ʄFb�Mq��Ǘ-
YÐbp������`�l�k'`UrL�o;��Ӱ�H
�NQ9�):���|��$���PM�J_x-
��x��a�&�w�S%����	\���=12X�)A�C�`��U���P��y�Ym9z�� =����=ai�h��jDM|�S�H�����W:�g�2��k6�w?�k����{\���=Ku<��4�F����      �      x������ � �      �   �   x���;�0Dk�0@�>%`T���9�I�q��������>�w�	e��J2��4=���^*��L%P3�%ucX�7F�\�Ӈg��<<3f82��3��A3����A0�0�&���g3}��N�Gx��W)���F2      �      x������ � �     