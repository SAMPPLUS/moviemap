PGDMP      .                 |            moviemap    14.9 (Homebrew)    16.0     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16385    moviemap    DATABASE     j   CREATE DATABASE moviemap WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE moviemap;
                sampeterson    false            �          0    27459    movies 
   TABLE DATA           c   COPY public.movies (id, tmdb_id, title, director, release_date, overview, poster_path) FROM stdin;
    public          sampeterson    false    219   $       �          0    27471    users 
   TABLE DATA           ?   COPY public.users (id, username, role, created_at) FROM stdin;
    public          sampeterson    false    223   N       �          0    27453 	   locations 
   TABLE DATA           �   COPY public.locations (id, movie_id, scene_desc, "time", submitted_user, geo, title, sequence_order, main_img_path, location_desc, g_streetview_embed_url) FROM stdin;
    public          sampeterson    false    217   k       �          0    27445    locationimages 
   TABLE DATA           i   COPY public.locationimages (id, location_id, file_name, type, description, created_at, main) FROM stdin;
    public          sampeterson    false    215   �       
          0    26714    spatial_ref_sys 
   TABLE DATA           X   COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
    public          sampeterson    false    211   �       �          0    27465    test 
   TABLE DATA           .   COPY public.test (id, text, geog) FROM stdin;
    public          sampeterson    false    221   �       �           0    0    locationimages_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.locationimages_id_seq', 41, true);
          public          sampeterson    false    216            �           0    0    locations_id_serial    SEQUENCE SET     B   SELECT pg_catalog.setval('public.locations_id_serial', 12, true);
          public          sampeterson    false    218            �           0    0    movies_id_serial    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.movies_id_serial', 23, true);
          public          sampeterson    false    220            �           0    0    test_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.test_id_seq', 6, true);
          public          sampeterson    false    222            �     x����n�0���Sr����ޒ:i�]�)�\(r,NC�!e�y�]ho��,��ϼz�\m��������e�1�C����]U��7յ���Ѹjm������W��r9�-���$e��"�L�(�Yp�![�e!L�#�^��G���IoL �=I�9��7ސ����;��z�ш�B���Mw��!������p�)�I�s����Z��$���Di�y�M�PCl´��ǇE�����_nݗ6??��-��j�kFg�j~~q��6܄��>��Iť�[���V;+�X��f�����0|6/4�����}d�f�
vx0��ʄFb�Mq��Ǘ-
YÐbp������`�l�k'`UrL�o;��Ӱ�H
�NQ9�):���|��$���PM�J_x-
��x��a�&�w�S%����	\���=12X�)A�C�`��U���P��y�Ym9z�� =����=ai�h��jDM|�S�H�����W:�g�2��k6�w?�k����{\���=Ku<��4�F����      �      x������ � �      �   ~  x���Qo�0ǟ�S������o������d/�l���_��������������EQ�fmw���@ծX�#"�:@�AE 5"ϔ��!%Tjʎ������@��Q�UBU*I��#9���C0_[2ߗ�-��l�Fn��l=j����vu�G���$1�2I�a�V$��A�IyU��n�7�*I���衣��*��u�s����B�.Q��^���䶯�CH��\y���Y�R���Dy��D�Ra��1�ZO�d�^��jW?7._�UV��m!��BP�F���Q\x��1�%�z�,�&I�e>��������.`�"6���d�s�r�1�/Щ9��Z�Yw
=�Br���[�"zg��-��`�J���      �   �  x�u�Ko�0���P/�Q�.K�R$H�@����LFj�(�����uR'uA�ٝ!�
 )�#�ɉ���Elr㣓NU?n
(��x��6>l���]�� `K	����J;�^�W��;�5�B�"'댎&�u45%�րMKk�e2%�Ҭ�+D@��Bt,DF���Z��-��*#��= � �'0���
E�Y�ZQ���W9��mѸu#A�l���!k���Z��� ���ᙇ�� * 劼@_ μy\TJ*'>�΃4@(��rw�v��7}X��6|�o����=41������}_���Mٍ�SzQFW�������挐'Q�2����_W��V���>|�X1�6���0�.��1�!�9�m����.���i������8��2$��+8��m��l�$	�0�M�5���5�]�������r�?����[-]K��T�Ü�- �$H��@l�$6�6�����M�M܉8��6
�V�����2��r��S�߿Jk��ʐ"�O�^�i~+,��6��QޡM2����b&>5��S���r���4nQ�AD�U�R�8[�}���\��8�{�N���Q޳4%P��Y1M��v�L;r �L-�D*�l�L�5��6�K i�n]EN�����Z,�P�%�      
      x������ � �      �   �   x���;�0Dk�0@�>%`T���9�I�q��������>�w�	e��J2��4=���^*��L%P3�%ucX�7F�\�Ӈg��<<3f82��3��A3����A0�0�&���g3}��N�Gx��W)���F2     