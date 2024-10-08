PGDMP  !                     |            moviemap    16.0    16.0 3    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16398    moviemap    DATABASE     �   CREATE DATABASE moviemap WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE moviemap;
                sampeterson    false                        2615    2200    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                sampeterson    false            �           0    0    SCHEMA public    ACL     Q   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
                   sampeterson    false    6                        3079    29316    postgis 	   EXTENSION     ;   CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;
    DROP EXTENSION postgis;
                   false    6            �           0    0    EXTENSION postgis    COMMENT     ^   COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';
                        false    2            �            1259    30392 	   addresses    TABLE     :  CREATE TABLE public.addresses (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    street character varying(100) NOT NULL,
    city character varying(50) NOT NULL,
    state character varying(2) NOT NULL,
    zip character varying(10) NOT NULL,
    specificity character varying(16) NOT NULL
);
    DROP TABLE public.addresses;
       public         heap    sampeterson    false    6            �            1259    30395    addresses_id_seq    SEQUENCE     �   CREATE SEQUENCE public.addresses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.addresses_id_seq;
       public          sampeterson    false    221    6            �           0    0    addresses_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.addresses_id_seq OWNED BY public.addresses.id;
          public          sampeterson    false    222            �            1259    30396    locationimages    TABLE     @  CREATE TABLE public.locationimages (
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
       public         heap    sampeterson    false    6            �            1259    30403    locationimages_id_seq    SEQUENCE     �   CREATE SEQUENCE public.locationimages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.locationimages_id_seq;
       public          sampeterson    false    223    6            �           0    0    locationimages_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.locationimages_id_seq OWNED BY public.locationimages.id;
          public          sampeterson    false    224            �            1259    30404 	   locations    TABLE     �  CREATE TABLE public.locations (
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
    DROP TABLE public.locations;
       public         heap    sampeterson    false    6    2    2    6    2    6    2    6    2    6    6    2    6    2    6    2    6            �            1259    30411    locations_id_serial    SEQUENCE     �   CREATE SEQUENCE public.locations_id_serial
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.locations_id_serial;
       public          sampeterson    false    225    6            �           0    0    locations_id_serial    SEQUENCE OWNED BY     H   ALTER SEQUENCE public.locations_id_serial OWNED BY public.locations.id;
          public          sampeterson    false    226            �            1259    30412    movies    TABLE     �   CREATE TABLE public.movies (
    id integer NOT NULL,
    tmdb_id integer,
    title text,
    director text,
    release_date date,
    overview text,
    poster_path text
);
    DROP TABLE public.movies;
       public         heap    sampeterson    false    6            �            1259    30417    movies_id_serial    SEQUENCE     �   CREATE SEQUENCE public.movies_id_serial
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.movies_id_serial;
       public          sampeterson    false    227    6            �           0    0    movies_id_serial    SEQUENCE OWNED BY     B   ALTER SEQUENCE public.movies_id_serial OWNED BY public.movies.id;
          public          sampeterson    false    228            �            1259    30418    test    TABLE     l   CREATE TABLE public.test (
    id integer NOT NULL,
    text text,
    geog public.geography(Point,4326)
);
    DROP TABLE public.test;
       public         heap    sampeterson    false    2    2    6    2    6    2    6    2    6    6    2    6    2    6    2    6    6            �            1259    30423    test_id_seq    SEQUENCE     �   CREATE SEQUENCE public.test_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.test_id_seq;
       public          sampeterson    false    6    229            �           0    0    test_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.test_id_seq OWNED BY public.test.id;
          public          sampeterson    false    230            �            1259    30424    users    TABLE     �   CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying,
    role character varying,
    created_at timestamp without time zone
);
    DROP TABLE public.users;
       public         heap    sampeterson    false    6                       2604    30429    addresses id    DEFAULT     l   ALTER TABLE ONLY public.addresses ALTER COLUMN id SET DEFAULT nextval('public.addresses_id_seq'::regclass);
 ;   ALTER TABLE public.addresses ALTER COLUMN id DROP DEFAULT;
       public          sampeterson    false    222    221                       2604    30430    locationimages id    DEFAULT     v   ALTER TABLE ONLY public.locationimages ALTER COLUMN id SET DEFAULT nextval('public.locationimages_id_seq'::regclass);
 @   ALTER TABLE public.locationimages ALTER COLUMN id DROP DEFAULT;
       public          sampeterson    false    224    223                       2604    30431    locations id    DEFAULT     o   ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_serial'::regclass);
 ;   ALTER TABLE public.locations ALTER COLUMN id DROP DEFAULT;
       public          sampeterson    false    226    225            	           2604    30432 	   movies id    DEFAULT     i   ALTER TABLE ONLY public.movies ALTER COLUMN id SET DEFAULT nextval('public.movies_id_serial'::regclass);
 8   ALTER TABLE public.movies ALTER COLUMN id DROP DEFAULT;
       public          sampeterson    false    228    227            
           2604    30433    test id    DEFAULT     b   ALTER TABLE ONLY public.test ALTER COLUMN id SET DEFAULT nextval('public.test_id_seq'::regclass);
 6   ALTER TABLE public.test ALTER COLUMN id DROP DEFAULT;
       public          sampeterson    false    230    229            �          0    30392 	   addresses 
   TABLE DATA           T   COPY public.addresses (id, name, street, city, state, zip, specificity) FROM stdin;
    public          sampeterson    false    221   �<       �          0    30396    locationimages 
   TABLE DATA           i   COPY public.locationimages (id, location_id, file_name, type, description, created_at, main) FROM stdin;
    public          sampeterson    false    223   �<       �          0    30404 	   locations 
   TABLE DATA           �   COPY public.locations (id, movie_id, scene_desc, "time", submitted_user, geo, title, sequence_order, main_img_path, location_desc, g_streetview_embed_url, location_name, street, city, region, zip, specificity, country) FROM stdin;
    public          sampeterson    false    225   =@       �          0    30412    movies 
   TABLE DATA           c   COPY public.movies (id, tmdb_id, title, director, release_date, overview, poster_path) FROM stdin;
    public          sampeterson    false    227   2E                 0    29634    spatial_ref_sys 
   TABLE DATA           X   COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
    public          postgres    false    217   \G       �          0    30418    test 
   TABLE DATA           .   COPY public.test (id, text, geog) FROM stdin;
    public          sampeterson    false    229   yG       �          0    30424    users 
   TABLE DATA           ?   COPY public.users (id, username, role, created_at) FROM stdin;
    public          sampeterson    false    231   H       �           0    0    addresses_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.addresses_id_seq', 1, false);
          public          sampeterson    false    222            �           0    0    locationimages_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.locationimages_id_seq', 46, true);
          public          sampeterson    false    224            �           0    0    locations_id_serial    SEQUENCE SET     B   SELECT pg_catalog.setval('public.locations_id_serial', 12, true);
          public          sampeterson    false    226            �           0    0    movies_id_serial    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.movies_id_serial', 23, true);
          public          sampeterson    false    228            �           0    0    test_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.test_id_seq', 6, true);
          public          sampeterson    false    230                       2606    30435    addresses addresses_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.addresses DROP CONSTRAINT addresses_pkey;
       public            sampeterson    false    221                       2606    30437 "   locationimages locationimages_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.locationimages
    ADD CONSTRAINT locationimages_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.locationimages DROP CONSTRAINT locationimages_pkey;
       public            sampeterson    false    223                       2606    30439    locations locations_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.locations DROP CONSTRAINT locations_pkey;
       public            sampeterson    false    225                       2606    30441    movies movies_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.movies DROP CONSTRAINT movies_pkey;
       public            sampeterson    false    227                       2606    30443    movies movies_tmdb_id_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_tmdb_id_key UNIQUE (tmdb_id);
 C   ALTER TABLE ONLY public.movies DROP CONSTRAINT movies_tmdb_id_key;
       public            sampeterson    false    227                       2606    30445    test test_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.test DROP CONSTRAINT test_pkey;
       public            sampeterson    false    229                       2606    30447    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            sampeterson    false    231                       2606    30448 .   locationimages locationimages_location_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.locationimages
    ADD CONSTRAINT locationimages_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);
 X   ALTER TABLE ONLY public.locationimages DROP CONSTRAINT locationimages_location_id_fkey;
       public          sampeterson    false    5653    225    223                       2606    30453 !   locations locations_movie_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id);
 K   ALTER TABLE ONLY public.locations DROP CONSTRAINT locations_movie_id_fkey;
       public          sampeterson    false    5655    227    225                        2606    30458 '   locations locations_submitted_user_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_submitted_user_fkey FOREIGN KEY (submitted_user) REFERENCES public.users(id);
 Q   ALTER TABLE ONLY public.locations DROP CONSTRAINT locations_submitted_user_fkey;
       public          sampeterson    false    225    231    5661            �      x������ � �      �   �  x��UMo�6=k{�8�R��Q԰z
 P�R,K��������[�q� �B �ｙ�f:�P�ʡ��x�o�%.y�R�N�_�d�]�FV�����2)�� ,P(,�͵C�u��j6sG`MG<O�:��I�	�ƨ���q^D�&�WD��t.%H�D����\�#T��7 07�8 H�@���J򔒮��JU�i�R2>Y[K�J�>������Q�W�j�-)�� ��wxœ?���ei#}r�[˕J	�����R@) ���P�������r���S�m¾ﱔ&��<��S��wk��O��1�
�
�r��#I�(�����삞�����/��ˏ-1�P����C[�!���/�1���B_���ݕaZ���(����74�Yšz�5PZ�zѣ��( �L`����f$-���,ȬX3ƙ�m��-��҅��	e=�����9��� �|
�������%NS��Ї�6p�V����k~Y'������ge�P27����|�N����S�*坴QDp�	�LHS���E������q���$�������_W�/���pT墉=�?�Qs�0��� ��&*�^�v�W	k�U�I,�@)�")�u��!���7Ժ��	]�#��B�"�M���g��+�׶:i�@�
)s�RI�֬2��X���:I��y�v�jѱ�Oq����>u��C�oɳo��ݸ6&�t�r�j���PH1-�uܵ>q9a����:˱�ϔ>:�S�g����4��l��>��w��(6C^q)M���FS6��d����{��(�?�hh�4�e|S3SY��_q_h�k�R+�}�pB+���4�K[�,S�Ky>u�6�rQb~V�^Z�x��Ӆ�:�Kej&�j}J�"XC����;:V��      �   �  x��Vmo�6�����wW)J��_$C�u�aC���h��D�$e7�~G�m�AS`�H�y��{��I���7W+�΀o������v��J��Z��H�fPKWY5xe�Q#!���\�ӗ~&G^�N>'2�D#�~N$���(��������\^�$��X��r�
�Do�[4��M��ի�U��0{���&)˲U�/ʔ�,Y�Y��o�>��`pcejpc���<�^�9TF;Yy�G�V�r���N�6�7�=��g[�����jD�>��^G<k���r����n� o,^ <[)��CC�N���"��b���ZQ,Ve�f��Ś�0D�R� �aӪ��A��߫��^6RK-<:�Խ�DҢ���AދO�]o�����[����N�[P����j�h��/��;�� �/*���C��ޫCU(6�2��z1Z|`L��P��y�
��#jY!�t��Q{��0���jt��q�[��`K��FF3��f���9ܘ=����`лjU%]w��F�(O�ܤ�ݜ�)�;�Z{�}���rWR��RW�o�I�kҚ�iAL��v��僐���<��k��Eɳ�*Y/y��H���#����Š�v@��S����yl��v�u�
р��tU�#
��>�y�L%&}���K�H�`%q����C���G������|��Ǎ1M'����ܹ��׿���؎����ed��|F�bF����nx}s}y�W;��n�~of��3R�,N��#�$�H�g�~A��"�#�e��Y����%-yNY�be�����+x���i>˶I\p��<+�S���������|�� ��;�����`���V歱Z��L�O@��,e����9��Qk�=�2-�`W��0i��V9K��`�LN�G������ �`�5fFξRi�D��	�;)}_k���ko�f��rPY�\(��.O��u�M1,\�M(�O*�\�0Ha��c�Nr����VuȄ�El�~���h�y�ƐZ�C��ո��gpoC�k��������V�n/p#"�A����@¶�FIQ�!����,;����m�Ppg<�q���S[�IA���P���R�D�0��P������q�0~�_�����)eP��i��I�24%�d��,Gʤ�3��;�!ch��	��JR�y�Pd��MYf9����	@� e	���x��OgD�/,�a��
5��IO(�>>;;�)?      �     x����n�0���Sr����ޒ:i�]�)�\(r,NC�!e�y�]ho��,��ϼz�\m��������e�1�C����]U��7յ���Ѹjm������W��r9�-���$e��"�L�(�Yp�![�e!L�#�^��G���IoL �=I�9��7ސ����;��z�ш�B���Mw��!������p�)�I�s����Z��$���Di�y�M�PCl´��ǇE�����_nݗ6??��-��j�kFg�j~~q��6܄��>��Iť�[���V;+�X��f�����0|6/4�����}d�f�
vx0��ʄFb�Mq��Ǘ-
YÐbp������`�l�k'`UrL�o;��Ӱ�H
�NQ9�):���|��$���PM�J_x-
��x��a�&�w�S%����	\���=12X�)A�C�`��U���P��y�Ym9z�� =����=ai�h��jDM|�S�H�����W:�g�2��k6�w?�k����{\���=Ku<��4�F����            x������ � �      �   �   x���;�0Dk�0@�>%`T���9�I�q��������>�w�	e��J2��4=���^*��L%P3�%ucX�7F�\�Ӈg��<<3f82��3��A3����A0�0�&���g3}��N�Gx��W)���F2      �      x������ � �     