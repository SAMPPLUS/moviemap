PGDMP                       |            moviemap    14.9 (Homebrew)    16.0 ,    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
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
                   sampeterson    false    6                        3079    26402    postgis 	   EXTENSION     ;   CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;
    DROP EXTENSION postgis;
                   false    6            �           0    0    EXTENSION postgis    COMMENT     ^   COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';
                        false    2            �            1259    27445    locationimages    TABLE     @  CREATE TABLE public.locationimages (
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
       public         heap    sampeterson    false    6            �            1259    27452    locationimages_id_seq    SEQUENCE     �   CREATE SEQUENCE public.locationimages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.locationimages_id_seq;
       public          sampeterson    false    6    215            �           0    0    locationimages_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.locationimages_id_seq OWNED BY public.locationimages.id;
          public          sampeterson    false    216            �            1259    27453 	   locations    TABLE     _  CREATE TABLE public.locations (
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
    g_streetview_embed_url text
);
    DROP TABLE public.locations;
       public         heap    sampeterson    false    2    6    2    6    2    6    2    6    2    6    2    6    2    6    2    6    6            �            1259    27458    locations_id_serial    SEQUENCE     �   CREATE SEQUENCE public.locations_id_serial
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.locations_id_serial;
       public          sampeterson    false    217    6            �           0    0    locations_id_serial    SEQUENCE OWNED BY     H   ALTER SEQUENCE public.locations_id_serial OWNED BY public.locations.id;
          public          sampeterson    false    218            �            1259    27459    movies    TABLE     �   CREATE TABLE public.movies (
    id integer NOT NULL,
    tmdb_id integer,
    title text,
    director text,
    release_date date,
    overview text,
    poster_path text
);
    DROP TABLE public.movies;
       public         heap    sampeterson    false    6            �            1259    27464    movies_id_serial    SEQUENCE     �   CREATE SEQUENCE public.movies_id_serial
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.movies_id_serial;
       public          sampeterson    false    6    219            �           0    0    movies_id_serial    SEQUENCE OWNED BY     B   ALTER SEQUENCE public.movies_id_serial OWNED BY public.movies.id;
          public          sampeterson    false    220            �            1259    27465    test    TABLE     l   CREATE TABLE public.test (
    id integer NOT NULL,
    text text,
    geog public.geography(Point,4326)
);
    DROP TABLE public.test;
       public         heap    sampeterson    false    6    2    6    2    6    2    6    2    6    2    6    2    6    2    6    2    6            �            1259    27470    test_id_seq    SEQUENCE     �   CREATE SEQUENCE public.test_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.test_id_seq;
       public          sampeterson    false    221    6            �           0    0    test_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.test_id_seq OWNED BY public.test.id;
          public          sampeterson    false    222            �            1259    27471    users    TABLE     �   CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying,
    role character varying,
    created_at timestamp without time zone
);
    DROP TABLE public.users;
       public         heap    sampeterson    false    6                       2604    27476    locationimages id    DEFAULT     v   ALTER TABLE ONLY public.locationimages ALTER COLUMN id SET DEFAULT nextval('public.locationimages_id_seq'::regclass);
 @   ALTER TABLE public.locationimages ALTER COLUMN id DROP DEFAULT;
       public          sampeterson    false    216    215                       2604    27477    locations id    DEFAULT     o   ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_serial'::regclass);
 ;   ALTER TABLE public.locations ALTER COLUMN id DROP DEFAULT;
       public          sampeterson    false    218    217                       2604    27478 	   movies id    DEFAULT     i   ALTER TABLE ONLY public.movies ALTER COLUMN id SET DEFAULT nextval('public.movies_id_serial'::regclass);
 8   ALTER TABLE public.movies ALTER COLUMN id DROP DEFAULT;
       public          sampeterson    false    220    219                       2604    27479    test id    DEFAULT     b   ALTER TABLE ONLY public.test ALTER COLUMN id SET DEFAULT nextval('public.test_id_seq'::regclass);
 6   ALTER TABLE public.test ALTER COLUMN id DROP DEFAULT;
       public          sampeterson    false    222    221            �          0    27445    locationimages 
   TABLE DATA                 public          sampeterson    false    215   �/       �          0    27453 	   locations 
   TABLE DATA                 public          sampeterson    false    217   �2       �          0    27459    movies 
   TABLE DATA                 public          sampeterson    false    219   B5       
          0    26714    spatial_ref_sys 
   TABLE DATA                 public          sampeterson    false    211   �7       �          0    27465    test 
   TABLE DATA                 public          sampeterson    false    221   �7       �          0    27471    users 
   TABLE DATA                 public          sampeterson    false    223   �8       �           0    0    locationimages_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.locationimages_id_seq', 42, true);
          public          sampeterson    false    216            �           0    0    locations_id_serial    SEQUENCE SET     B   SELECT pg_catalog.setval('public.locations_id_serial', 12, true);
          public          sampeterson    false    218            �           0    0    movies_id_serial    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.movies_id_serial', 23, true);
          public          sampeterson    false    220            �           0    0    test_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.test_id_seq', 6, true);
          public          sampeterson    false    222                       2606    27481 "   locationimages locationimages_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.locationimages
    ADD CONSTRAINT locationimages_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.locationimages DROP CONSTRAINT locationimages_pkey;
       public            sampeterson    false    215                       2606    27483    locations locations_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.locations DROP CONSTRAINT locations_pkey;
       public            sampeterson    false    217                       2606    27485    movies movies_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.movies DROP CONSTRAINT movies_pkey;
       public            sampeterson    false    219                       2606    27487    movies movies_tmdb_id_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_tmdb_id_key UNIQUE (tmdb_id);
 C   ALTER TABLE ONLY public.movies DROP CONSTRAINT movies_tmdb_id_key;
       public            sampeterson    false    219                       2606    27489    test test_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.test DROP CONSTRAINT test_pkey;
       public            sampeterson    false    221                       2606    27491    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            sampeterson    false    223                        2606    27492 .   locationimages locationimages_location_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.locationimages
    ADD CONSTRAINT locationimages_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);
 X   ALTER TABLE ONLY public.locationimages DROP CONSTRAINT locationimages_location_id_fkey;
       public          sampeterson    false    217    4375    215            !           2606    27497 !   locations locations_movie_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES public.movies(id);
 K   ALTER TABLE ONLY public.locations DROP CONSTRAINT locations_movie_id_fkey;
       public          sampeterson    false    217    219    4377            "           2606    27502 '   locations locations_submitted_user_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_submitted_user_fkey FOREIGN KEY (submitted_user) REFERENCES public.users(id);
 Q   ALTER TABLE ONLY public.locations DROP CONSTRAINT locations_submitted_user_fkey;
       public          sampeterson    false    217    4383    223            �   �  x����n�6����ͦB�3�R�(�H�j�@���@�d��6
$i���M���EW� �x�����jy}�ۍ�Zެ�ö�&n���o�$~?_|��߃9t&N��Ԟ�!/ӟ�]�(c������p{z&�?}VM|��}�/OQ�� �PPj*�+�'�.?.?�xr���ܙ�H�U���yk��n-DCI�`�����_|�h����*�B�D�
��{�45�/M�U�¬���A��6�sq�F�s6��T�:yt�6d��~]+0{dĺ'�\6U��v�x݌��m`x  ��;J;<�P �J���,���o�]}Pk���y��RP�x�o���ƮZӦ���m�S!P�6V�4m�~���ӰE;l��O�^�.�.�.��T��:�&k�|~��ru�a����UZ�ͱIկ]�Ƕ�Uu�X�[_UC�]�ž�}��\�q�8�w{��{�u��iI�4]�?w�S�:) �\r�u\�l�j�zfv��Q��������t�Ӕ�
��0+��^ ^r
H��@n�$�x�d�SR/7i㓌}���_w'-�0�M�M���K��&73�t�jXJ:n�Mnt��G�T�ױ�L�=�g�{��u�D��Y�5��g��V��!y�8�Z^\.V�=v��:�l�˙7��� *ї�
1Ϡ3��^y� �L�D:7���m�NlTh"}����q�|A^�5����Y��1^p$Ӻ���&FH/��z�@�]"�P�y+���_Oy!t      �   �  x��U[o�0~�8{b�2j0О�H��nZҾ;�M����n�~��uUժi���c�;߹�,.���+X\��B��5ʰn�p�j�g�W�%|�Fpyu~��;ت�n�m�Q��ܵ����6|�r�8Fo:�� t��,�"��1g,+�|��<�y��<��(+�����E�P��,����x���(��ӒM'<-�2K8K�(a���
V^kU�����Sl�F�S��t��-&e�^&�<�N�2�@6g��g�C�������z���eof?&��Kq�JYi���_��@�Z�;m�'Y�	�*� 6�z��N_�м��󜲀�|^L�	�r>�E19KƇ��'Ό��j��6(��>��C3��i��Y��<et��$X^��O4��F5���Tmݚ�L�h�폊�N9o@Tء��7�jt!,Uv�ء_#=��5Z�\�x����ƚ�!\z-���^T\k��p���ѐ��$;�)cDǻ��9O'%KJN�V\$I:K��'"\���a�ŵ�%C��Xh�6�J+M�P�Z��eh�t��?��6�+����	7ė�׸4(��{z��/��O����B�@��%��� ��֬q���m��`W#������Z�C���VX��F�$]Zb�o����	�����>�ON~�.�      �   L  x��R�n1��+F\R�I�4pJI
Q
ɶE�y����k���,��3!.T�byƞ73�|�]n
���4mi��j�7�n��]n����ժ�b�-z�����۳��X��4Z��d�b��0�|͐KI�H�������:���t:M�Y�����;5|@G�6�$G�R��!��7{m���/���!�jt�|���ʐ�q�S}�(`dh]��Di�$u �;�8��JO�6
AjcU��16��phjQakUf��a6CO�2N�a�}������-�Vꦎ��RS9�ʾ5U�Y��O�0���`{���o��6��I�4̗��4
�#]|J��F��������x2/e�Tp�_%�b8W�}��A�35P�o���G�LЃy�d�p�U)����E�$��y��i��o����2�I���U�c��y�Pi�ƣ�6�`�Fj(,��M�+�T�� ��)�	�ٷ6As�*f0���Fǒz�@�6R��D�^I~�ѱ�G@�=P��3p�"(��>bct:�ɗ(���i�;϶�4�ʥ����B�G���i+�C�O9;�<HT�      
   
   x���          �   �   x��Ͻj�@���Oq[ZE��Ȥ�u`0.4I��C C���Ǵ[�K�Eӏ��ioo7L�Ww�}�O�/ׯ�{��h{��[7�q�6���C`����@�Z$�
r�X�e�����i��I$��7��`�Y�SDN�|�����?z[�j�E+���Â<2-T[
U��2�H������Io�E{������M��      �   
   x���         