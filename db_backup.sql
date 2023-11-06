PGDMP  %                
    {            moviemap    14.9 (Homebrew)    16.0 $    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
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
                   sampeterson    false    6                        3079    17494    postgis 	   EXTENSION     ;   CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;
    DROP EXTENSION postgis;
                   false    6            �           0    0    EXTENSION postgis    COMMENT     ^   COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';
                        false    2            �            1259    18537 	   locations    TABLE     �   CREATE TABLE public.locations (
    id integer NOT NULL,
    movie_id integer,
    description text,
    "time" timestamp without time zone,
    submitted_user integer,
    geo public.geography(Point,4326),
    title character varying(255)
);
    DROP TABLE public.locations;
       public         heap    sampeterson    false    2    2    6    2    6    2    6    2    6    6    2    6    2    6    2    6    6            �            1259    18542    locations_id_serial    SEQUENCE     �   CREATE SEQUENCE public.locations_id_serial
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.locations_id_serial;
       public          sampeterson    false    6    215            �           0    0    locations_id_serial    SEQUENCE OWNED BY     H   ALTER SEQUENCE public.locations_id_serial OWNED BY public.locations.id;
          public          sampeterson    false    216            �            1259    18543    movies    TABLE     �   CREATE TABLE public.movies (
    id integer NOT NULL,
    tmdb_id integer,
    title text,
    director text,
    release_date date,
    overview text,
    poster_path text
);
    DROP TABLE public.movies;
       public         heap    sampeterson    false    6            �            1259    18548    movies_id_serial    SEQUENCE     �   CREATE SEQUENCE public.movies_id_serial
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.movies_id_serial;
       public          sampeterson    false    6    217            �           0    0    movies_id_serial    SEQUENCE OWNED BY     B   ALTER SEQUENCE public.movies_id_serial OWNED BY public.movies.id;
          public          sampeterson    false    218            �            1259    18549    test    TABLE     l   CREATE TABLE public.test (
    id integer NOT NULL,
    text text,
    geog public.geography(Point,4326)
);
    DROP TABLE public.test;
       public         heap    sampeterson    false    2    2    6    2    6    2    6    2    6    6    2    6    2    6    2    6    6            �            1259    18554    test_id_seq    SEQUENCE     �   CREATE SEQUENCE public.test_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.test_id_seq;
       public          sampeterson    false    6    219            �           0    0    test_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.test_id_seq OWNED BY public.test.id;
          public          sampeterson    false    220            �            1259    18555    users    TABLE     �   CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying,
    role character varying,
    created_at timestamp without time zone
);
    DROP TABLE public.users;
       public         heap    sampeterson    false    6                       2604    18560    locations id    DEFAULT     o   ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_serial'::regclass);
 ;   ALTER TABLE public.locations ALTER COLUMN id DROP DEFAULT;
       public          sampeterson    false    216    215                       2604    18561 	   movies id    DEFAULT     i   ALTER TABLE ONLY public.movies ALTER COLUMN id SET DEFAULT nextval('public.movies_id_serial'::regclass);
 8   ALTER TABLE public.movies ALTER COLUMN id DROP DEFAULT;
       public          sampeterson    false    218    217                       2604    18562    test id    DEFAULT     b   ALTER TABLE ONLY public.test ALTER COLUMN id SET DEFAULT nextval('public.test_id_seq'::regclass);
 6   ALTER TABLE public.test ALTER COLUMN id DROP DEFAULT;
       public          sampeterson    false    220    219            �          0    18537 	   locations 
   TABLE DATA           b   COPY public.locations (id, movie_id, description, "time", submitted_user, geo, title) FROM stdin;
    public          sampeterson    false    215   �&       �          0    18543    movies 
   TABLE DATA           c   COPY public.movies (id, tmdb_id, title, director, release_date, overview, poster_path) FROM stdin;
    public          sampeterson    false    217   J'                 0    17806    spatial_ref_sys 
   TABLE DATA           X   COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
    public          sampeterson    false    211   U(       �          0    18549    test 
   TABLE DATA           .   COPY public.test (id, text, geog) FROM stdin;
    public          sampeterson    false    219   r(       �          0    18555    users 
   TABLE DATA           ?   COPY public.users (id, username, role, created_at) FROM stdin;
    public          sampeterson    false    221   )       �           0    0    locations_id_serial    SEQUENCE SET     A   SELECT pg_catalog.setval('public.locations_id_serial', 3, true);
          public          sampeterson    false    216            �           0    0    movies_id_serial    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.movies_id_serial', 22, true);
          public          sampeterson    false    218            �           0    0    test_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.test_id_seq', 6, true);
          public          sampeterson    false    220                       2606    18564    locations locations_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.locations DROP CONSTRAINT locations_pkey;
       public            sampeterson    false    215                       2606    18566    movies movies_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.movies DROP CONSTRAINT movies_pkey;
       public            sampeterson    false    217                       2606    18568    movies movies_tmdb_id_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_tmdb_id_key UNIQUE (tmdb_id);
 C   ALTER TABLE ONLY public.movies DROP CONSTRAINT movies_tmdb_id_key;
       public            sampeterson    false    217                       2606    18570    test test_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.test DROP CONSTRAINT test_pkey;
       public            sampeterson    false    219                       2606    18572    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            sampeterson    false    221                       2606    18573 !   locations locations_movie_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id);
 K   ALTER TABLE ONLY public.locations DROP CONSTRAINT locations_movie_id_fkey;
       public          sampeterson    false    217    215    4367                       2606    18578 '   locations locations_submitted_user_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_submitted_user_fkey FOREIGN KEY (submitted_user) REFERENCES public.users(id);
 Q   ALTER TABLE ONLY public.locations DROP CONSTRAINT locations_submitted_user_fkey;
       public          sampeterson    false    215    221    4373            �   �   x�u��
� �>�O0��Z���S�y�^ʖсS�B_v�AKr�	�'��03��X�1#���5��pClL۞�>�W��ӛa��3N�1��ڵ��7�V ���wƪ��rFI�}+A썞�'G���i��':�U�@{�ڂ�RV��RX�Y:�(�6�B      �   �   x�U��N�0���S��v�c�&8l	�6^H��q;�ӓM�d�����\^�~��_�_U����0������+���Q�١6j�Go`{�Ω�j����r��9��G-�����+I�cI����|Ofȅ� H��DI&W���zǢ������jQ�nB�u̐�W����&&��h��VN���M㣶XK4m��6��Mbo=������魛���5��G�f�-���V����__�k�            x������ � �      �   �   x���;�0Dk�0@�>%`T���9�I�q��������>�w�	e��J2��4=���^*��L%P3�%ucX�7F�\�Ӈg��<<3f82��3��A3����A0�0�&���g3}��N�Gx��W)���F2      �      x������ � �     