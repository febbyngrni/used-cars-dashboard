PGDMP      *    
            |         	   used_cars    16.2    16.2                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    18070 	   used_cars    DATABASE     �   CREATE DATABASE used_cars WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE used_cars;
                postgres    false            �            1259    18100    ads    TABLE     �  CREATE TABLE public.ads (
    ads_id integer NOT NULL,
    product_id integer NOT NULL,
    user_id integer NOT NULL,
    title character varying(100) NOT NULL,
    date_posted timestamp without time zone NOT NULL,
    status character varying(100) NOT NULL,
    description text DEFAULT 'No Description'::text,
    CONSTRAINT ads_status_check CHECK (((status)::text = ANY ((ARRAY['Active'::character varying, 'Inactive'::character varying])::text[])))
);
    DROP TABLE public.ads;
       public         heap    postgres    false            �            1259    18121    bidding    TABLE     �  CREATE TABLE public.bidding (
    bid_id integer NOT NULL,
    ads_id integer NOT NULL,
    bid_date timestamp without time zone NOT NULL,
    bid_price numeric NOT NULL,
    status character varying(100),
    CONSTRAINT bidding_bid_price_check CHECK ((bid_price > (0)::numeric)),
    CONSTRAINT bidding_status_check CHECK (((status)::text = ANY ((ARRAY['Sent'::character varying, 'Rejected'::character varying, 'Accepted'::character varying])::text[])))
);
    DROP TABLE public.bidding;
       public         heap    postgres    false            �            1259    18071    city    TABLE     �   CREATE TABLE public.city (
    kota_id integer NOT NULL,
    nama_kota character varying(100) NOT NULL,
    location point NOT NULL
);
    DROP TABLE public.city;
       public         heap    postgres    false            �            1259    18091    products    TABLE     �  CREATE TABLE public.products (
    product_id integer NOT NULL,
    brand character varying(100) NOT NULL,
    model character varying(100) NOT NULL,
    body_type character varying(100) NOT NULL,
    year integer NOT NULL,
    price numeric NOT NULL,
    type character varying(100),
    CONSTRAINT products_price_check CHECK ((price > (0)::numeric)),
    CONSTRAINT products_type_check CHECK (((type)::text = ANY ((ARRAY['Automatic'::character varying, 'Manual'::character varying])::text[])))
);
    DROP TABLE public.products;
       public         heap    postgres    false            �            1259    18076    users    TABLE     D  CREATE TABLE public.users (
    user_id integer NOT NULL,
    kota_id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    phone character varying(100) NOT NULL,
    rating numeric NOT NULL,
    CONSTRAINT users_rating_check CHECK ((rating > (0)::numeric))
);
    DROP TABLE public.users;
       public         heap    postgres    false            
          0    18100    ads 
   TABLE DATA           c   COPY public.ads (ads_id, product_id, user_id, title, date_posted, status, description) FROM stdin;
    public          postgres    false    218   �                 0    18121    bidding 
   TABLE DATA           N   COPY public.bidding (bid_id, ads_id, bid_date, bid_price, status) FROM stdin;
    public          postgres    false    219   �<                 0    18071    city 
   TABLE DATA           <   COPY public.city (kota_id, nama_kota, location) FROM stdin;
    public          postgres    false    215   PK       	          0    18091    products 
   TABLE DATA           Z   COPY public.products (product_id, brand, model, body_type, year, price, type) FROM stdin;
    public          postgres    false    217   �L                 0    18076    users 
   TABLE DATA           W   COPY public.users (user_id, kota_id, first_name, last_name, phone, rating) FROM stdin;
    public          postgres    false    216   �N       o           2606    18108    ads ads_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_pkey PRIMARY KEY (ads_id);
 6   ALTER TABLE ONLY public.ads DROP CONSTRAINT ads_pkey;
       public            postgres    false    218            q           2606    18110    ads ads_title_key 
   CONSTRAINT     M   ALTER TABLE ONLY public.ads
    ADD CONSTRAINT ads_title_key UNIQUE (title);
 ;   ALTER TABLE ONLY public.ads DROP CONSTRAINT ads_title_key;
       public            postgres    false    218            s           2606    18129    bidding bidding_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.bidding
    ADD CONSTRAINT bidding_pkey PRIMARY KEY (bid_id);
 >   ALTER TABLE ONLY public.bidding DROP CONSTRAINT bidding_pkey;
       public            postgres    false    219            g           2606    18075    city city_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (kota_id);
 8   ALTER TABLE ONLY public.city DROP CONSTRAINT city_pkey;
       public            postgres    false    215            m           2606    18099    products products_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);
 @   ALTER TABLE ONLY public.products DROP CONSTRAINT products_pkey;
       public            postgres    false    217            i           2606    18085    users users_phone_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_phone_key;
       public            postgres    false    216            k           2606    18083    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    216            w           2606    18130    bidding fk_ads_bidding    FK CONSTRAINT     �   ALTER TABLE ONLY public.bidding
    ADD CONSTRAINT fk_ads_bidding FOREIGN KEY (ads_id) REFERENCES public.ads(ads_id) ON DELETE RESTRICT;
 @   ALTER TABLE ONLY public.bidding DROP CONSTRAINT fk_ads_bidding;
       public          postgres    false    4719    218    219            u           2606    18116    ads fk_productl_ads    FK CONSTRAINT     �   ALTER TABLE ONLY public.ads
    ADD CONSTRAINT fk_productl_ads FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON DELETE RESTRICT;
 =   ALTER TABLE ONLY public.ads DROP CONSTRAINT fk_productl_ads;
       public          postgres    false    218    217    4717            v           2606    18111    ads fk_user_ads    FK CONSTRAINT     �   ALTER TABLE ONLY public.ads
    ADD CONSTRAINT fk_user_ads FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE RESTRICT;
 9   ALTER TABLE ONLY public.ads DROP CONSTRAINT fk_user_ads;
       public          postgres    false    216    218    4715            t           2606    18086    users fk_user_city    FK CONSTRAINT     �   ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_user_city FOREIGN KEY (kota_id) REFERENCES public.city(kota_id) ON DELETE RESTRICT;
 <   ALTER TABLE ONLY public.users DROP CONSTRAINT fk_user_city;
       public          postgres    false    215    216    4711            
      x�u\ے�H�}&��?`3y�[��q���vo?�K��Q��%���_���N8z|)��H��� �P�P�����t{�.��R-Oۏ�v��߿o�m�����Mބ�j®�w��۾mǩx�_��k��zZ���j>]���	��S�r{�]���vXN��v������E��x~Z/�mY����V믺zx���]���\}_�+��a��/����ߎ�������]�23n�a��]��������*��q;mǥ��G�|��	>��]a����M3��w�]�.��u��·�]��B��N�~��_���.q{�,�ۗ�y}zZ�S�����f��ӆ?���َ�l�q�np��j�q[ֺ��7<#X�&:�jμz0��y=��dSu��T������
�r�e��i��M3��cîw�PM�v��pZx�_i��� v���g��v^�L�m���v�o�Y����x>l�r�Vx������O��#�c]�K����NRvE������suY�7��t���w).ھ�M�]w���Ƙ6�� �<��C���t �q;�����	�>����I�������]2p���.�~�-�+�m�Pp��
ք���M����
�.�~�� ����r��w����1���9����� ���}���GaQ�C�"�����R�A^���1K`J����r���`tL>׀ϵ�f�uMb�4n���)6���;)��h���������!�8�3���A�'��s}��?n�eC����/끾���N�X|��ٞ�2lC����W�a�����6��B_��v}��-��"��������+x�ؔ!t�] �ԑ�r�#�_�qC�g�h�q���|]���]f�l���<�X�`�r��du뺜���w��P���F[B����.�wǺ���tj�iS2]���~���/�t���)���(����r����\�.CSt=��ӊ绰�\�t��м	�
�.N����nnZ3��O:�,k��
��Շ�O��CMZ���P�L i��L@�{�߇�
 }�|"����g�;��C�Ĺ
��n��uӍ�G>B�]Mx�Ӷ����v_ l�'���68��|B�YaV� ����T�}�#9A�ϝ6<��G��eUW�!,�U��m�Tt�P^+��f��t!��K�0�#�;����b��9��^��7;J�O �pJ�h�����-e9b�I�t>�a�Qܮl۰p�K�h�!�9-g	6�m@����l�g;��_(A�&d!�7�-����уm�&N<�z��eOg
�xL<���o����	��W�<�A����S���,��)ĊǾ^ӹ4-:"�$ �f��8���l�pn��(���9�C��!)�6HL,���a�~xyF�C�뾬����#�⇢W��su����î�~j��:*�|�'������	��@�3�W��x�f'X�X 
�X�,&�A��l_�L�&�c�o���o��v�t>a�F�� �8J�*��QQ�i�7H���=��Y���5�K |H&rܣ:݀�
S}������6�J!4��{�)=SxNN|v�w�2��(d�xǔ���N�+�/�Z��
�~ܵsC�'Lv��M��|��ղ[]ɂ��֒+02���o����1?$^B�;��hX[|�Tq�.n��[) �r=�y�����1�	����x1�'n���ĥ���O�䪎��8���A���qF�	�bbR�F��ó�v�=�X��0�]rt���vKe*Gǜ7nr$����,�,�J�*�d��p�
��4��S�r��֓CA��f^�p������ҋ�#�-���j���ɗ��fJ 0+��w�eB]��n�R��[=%� <���c�_����\�I;�o0%�cĶN,�9�|����4�����l���Hy��
�(G��� g��''ʻfP�v�ʀ�Zd�p��٩�CU�h��PR�w��7�

�f؅Pw���d�(�]�S�g����$���^%�Hl'�g1�(3C���2�Sb��$(�v����!��Dɺ�)��d΄H���?ʶ3��9U;�ѳ;�ϟ��1\kd��{"�a|1_�}] S���@|�7H�`���ԭ�����HNh
���*��@�N?�~���\책��A�?`��̘��Nao�Y��!�DG:�u�Q=g�޸K"�u@L�x	0��"�?�u���+K+����c�vL���CѶ�y�[� ?�yp[��&Y&�L���m����]�g���r ��D�9��33Q-�(U���VF6s��Y��4�)>2@��5�z���0�Z�������,���{frM�0i��R�yE��'Q�L6���ZHC7etU3iq��FX<3ߠA��p�t���b�,Xt*H���.$��J������GT#�aZT�b��&J��2A�e��U�Y<R�P=y�"� �E��C� U�$d���,����)V��;밌����**��b܆]3�}�]�&c�/��2eJA�6�s�g*j]�q���iX��f��nvU�C��L�d��27PGC���1S��żi?��io9�E]�e��a+��%l�5�Zs�Y��g���e�(X/`x��eW�Ԕӑd�`��Og�F�k� g	���W�4���t����:"&����l$F�M���4��u�����mRYi��Ӧ��3��^�Oh�����}S�b<H��Hd*{�}̻���~h���H�b���3_}2�8z�O�&��`�!�fS"ߙq�_Wc�%�H�Au�VNnPOB!7Na�8� >hh���[���Е3d5V��*JYR��o��Ĥ~7��
%����W���DՋK��S�9
@e6���N\�@�Sʣ'����5�b����2b�H�"j��	�2A��u����3�>�EMQ�>�t�n���	��	'[Ȋ(U���V�N�!I�/���Gd0�Q>>�rWPKj�������X�}�e	M�����5M�W��wISI@�M��&�c��CR%)���t�n`+�j��[)-v�P��\�S�O3�<���
RT��g{Ǩ�Y����?X��ϛ��T$H�������Ꟁ�+�m��T�����х�SO����R�c�b�b
,g|��I������GσLeB�=*�]_�	 ����A.�%�g�#]R���s�'��.#�X��oi x9x����-�V"�ʹ��]�=뺍q���E�	�O���7k~ÿ��J��BIq.�:���iF	��+�L7b
吱n����{���~�!��KWֲxw��>&\0�F�WQ�3����Q��*I[��Usĺ�/���f���3�h�M��#� ,����Jƺ#CI��
�X��]��Y�_�J����=�J�jZ�FE0�L�i��c'�������vr��f��`�����%\:#�NP��5\���q� �8�E�`�%�QLhpx�6��P����!�5K�+9���O�_	��tgB.8ӱ<�b�jSY�0���R#+��y ~r���\�;٠L9T~������<HJx���vtXq��3��E�R
Ӿ�����wZ�)���*!�ax���g;��$F����^�p����l側)��H-z����P��k���ۡ��7������5zV9~Z<R��)�~8�/�18��U�Dl���)t�'����L��:�����ؘV��|(�
\��rX۠`��%���~b=���N}���T���z��ó���ډ9@���X���6ך�z�W�8���].�*V!F����r�حu�N�+ ,D�r��9���W�$�$C��}U�*��l'������a�ѱ�T�7�Ǯ�acc��+'Y��<����pU�S$��$��}#�1�6��^��l�]?�sl��� ��Bԣy�X0&
N��G�m�iV�X�m�I��˳�J�>	�i=5α�^0Se}��|����W?�ZL#���$���Ä��w�]~s��YŽv��v|G.�]┏�4n�GW��Z� �  (� LI�n�us=�M,��u��

%��#�8���>uC��F�G��$b����5\��h��ˁ[��`w-O�З2�S��p�!7*�5Hk
'��:��O��+�{Zdp:�JU��U�_.�W7y�d�Մ:<���QX�}�9箓
D	���+O�V����G��s��/�vT�J��Ѻ��إYä�6P�ҠE��JcL�|��{�<���Dt�3�/�|YЪD��4ЌU,�Z';Ѡ�ӠV�%�ZT��A,�Gb^S7��8��1�bmBG���v��e�2)֬%����4�dX�2��6���}��TُH2�*��wJ���m� ������	�a�A��u4��I���`��Otd�*2W�|L��~	����G�b��q�4@��D�g۴�;�w��t��=����/Cx�T�P�o�z�I ��%��u�Ci�:�F ����wC�c�5T�3�#���Nm=n6��*�d`3�P�8H���NC!��8�	F�b3E���pfd�'��mI�@��O�(�Zl�ED^�v��*��-&�lvڈ] �4����n���R�O£��!�19p���pF�j�;��bV1��h@3wQvq��[E�=�9P
�B�F���I�����:�u;L�p7�Agbu�S�?}Iy��Q�P�`vxHz"��������X\�3�n��!���!�Q<Q�ԩ<�D�C[�f�:=)R@;j��3Bҗ]�n��UX3�kz�y�Ⱥ*���F���56w���Qտ(<r`|��W~<䎩K�)MH7�x�:���ĮE�L#K�Ģm.�S�E�^bi��q�~�gK�y9kf'?˙���ҵ~�h�F>�(2�(2�[�+��y:� P�F�F�����%'M�C}���=��C�OSWG��%%�#k�0���)S�+͊G�3݈:�:[��a�A�5!X��~wد.�%è9K����u��i*�M}}?����pS���������W�n+�n�Q��c@��H��Zq cp���	�M��jh���}�G��(j�O�\H2�v�! ��YH�Ì#�PLY8#�8j���f���Ǚ�yC?���-�Mu*:U��Xs\jEk�tԝ�ʜ�u�S��I�����0��.��P�k���wNt�BNr���ey"L��1��T�)`�|�cߒ E7���T��/K��5R��e9�����B� ۃ�G�5�$t��QZ�pj���5�fhRK��(S��B
�Fώ�
b��x�7)"�����$-ҝ�0r�yYU���)4����GL����]�\�����	`K������܄43�_FW�t'�%y@����T�4/�g�\�ͦ�3�Bb���.:�	[�[z@N���ǈ\�x� �������&��>��0�b����>��tG�{ow@� T���L�2�a@����Cz�t'���.��#��SnٽM��^Ǧc��l��h]^�뛛���m7/o*��"�<�d[�({lE���N$Mf��q\�퀍�m�`�p0^���'���=&7�[x��i�� C$V;QJI�4��Ц2�g����F`Y�ԑڧ`�z��~��eg���yn��E�S������s�ri&D`�����rr�"���.@��c�.~����)^�XyC��F�`m��#W���4Üf���F�6�a��^����E4�����U�`˔�+����c)��\=�y��ȱ̎���k������R\�P!#���A.��f�}�nHe�Z&��Q�%b�׉:�tkJk�#	PEa̴8B>^�#*�&�Is�2�#ڀv��卢ՙQ�I_ltP�`�-�,��\����w������]=�&��{l����@Ͼ+z*�83A��M>��3mr1)�<�2���<�m�#,�̨ZWk�Ә�%:8u�'a��ԍL�+�To��CL�)wHq�SF�8��r�\����˄���e ��t��D�D��7�����~�)W�J��u*�r�RW�̀՞��������z���`�a�Ld���H��S�ֺ�Z�#a*!��8#���Q�Kf�ӯf�qf���*�	5f�ƀ��S��+��JDԀ���R�&E����)/A%�*���ν���/|1X��s��ᕦ$ʗb�������٠�>�F#��2'�9�"���S',c�/�=�!�,�͆�\� �&n�Jjղ�#�y�݊Q����bS�Ӡ��J�8Sj��W�x�t��>|�G�!$��M���Nb;$�ȏ`J#܃tU\63����_�.��"^���t,������FH��W^̤���ʽ+�5ӑ��G���c;�jN��LF�ΫI9G�~se�F�����fG�X��}-���5��4�r65v cL�^�yqUX�1����s��C.���.��걟ccz�i�۶KznN#9���}%��b���G�A��2IFt�{��*܅��� ��]n��Ro�]�cj��[� ������(�B��|�Ǥ�I���5���K8!��ٍa��)���)SR5����E�����#�Q3k�s���m!�-�ͮy�{����q�;��w������	7ҶS~�l4U�|��}�k&W=��Y�ؽ1h�� �^���&�A|BޛJY����r�4Q԰������w��q���|�z�d9��@a�[IXn�H�7��կ�{���D�����u"An�N
g>mx �T�T.dm3z��U|��nؤa��^* [��f#|��7�\yxtE��Ow�5��{�$n� U	N��]Lbh� ��r�>�E�9�?�1ݏ�3��j�{3J�>�.W�N��r����梅)�r�U:�����"ZRS\�����=4��0h��(�H>���S'Hg��Hj�g��(��4���y&Zȸ.]�߷�2n˷|�4J
3*��齢J�Y9s�?�B���A�#�%Zy}�{�iY��.�S3��6��j��$�\�y|ٮn��k��cS�����m�'P�y�q*������Ά�j_/��a'�{lS]���H��ќ��#�_��jBAu�քWt.^b��',6cq�9�t��ɿ�_C0SF�X��o����tD#��� �z�{�X��]�H�p�\��??�$y��� 54�@�N'�y��|�U��u3�S&�ȸ�����K�_�5�:-'4M��Т@�[��~w�[�]4캈]�6�}�0@��~�����<��p�|�΢Dtu��uY���i�         �  x�mZ9�$�r��OQ�0��%�R�6l��¿��=��ke�	8��-����M��w��"_�|�Tw��J�Tj�����������u~\�K|K�*�	���uX��y���m���>�K�R�h���w=d3o�������������o#��ſžT�ı�Vm�a?���v�"�K�'�c����7��sE���C�Ac��	�MG��I��+�����o��"��*�c��?W�M�<�`ї �h߭Tǁ���%c�zl"�[�����i:�&v�������q����������vs����d�����XZ��y,k{���of��n��3�ɗ�OA$c��z���^�G&����pQ��؇������o1�y��c��G4i����������/)�q�EcF�5u�~�-�� ����QXC��1^�����B�,��[���c�,��(w�p����)eo.��e�����jY�訾�����?����a�P��]�uv��r���z������zw�d�o9Q�����J�^z��5�#'@������x��7�W��[w����}�#�fg��5���E6��=p�g��L�Op&����U�?���)��Ԭa�Qw@\E�ʐ%'}▝�^�{���E�>�خ��z�q,y�P^]eq�'j�D�:V��Zk�a�R%�+�O$�k����i�g䦛�Y)��*��Y�����NhL4b��x�>!Y8Se����%��cuy��G�;#@ld�:��UT�X��~e���.�������%�vVJ�1�g
��$�����A!�u���yp��]�"]] ���I�oq�HA=H�R^t���Ū����6�I�A��E��B#��C��Dv��!�hC��q_`�p)x�A�~0�+����^^���ץ,�;�����6�%�:�
0o{�ȼ=�4
�*X(�EjCgm�c�����^LZ�F�
)��C@�5`�>���&��t$_�[�Ws�Rv ɲ��rB��)S��%�T ��	��J\�4V��@�̗;�+�I�
���E��26�����5����#;o=���;5�1� ��6*���m��z_�ξ���Ԗk�z��RA�A�%�KKk���ș��,f(�({�-��ka��g���S���bW����u�#���<�8�x��;��a�LY����CI�2
���� ���<�Y�)? 6���~�nu*a�	���%��Z�7� .,�Ɏ��TQ�q��j��]��4��et�Z���ɐWG''TZIB=����ė4�+�	ct���q�0�1�|{�I�{88�6t9V?5�_����G	�4�h���,Ƃ�0��FE���[�����Vj�9���l��Do��>��)kہE�;e�Bh�;�|��ʛ*�F��L�粭M�!I�h�D/n8���-��ޑ��0���ږS���kHH�y�XC}4H���\S�r<Z7Μà@A"�h���[;�;M���F����F��?�zd8�Gَ@I#J��~�����ₑ��'ᾍV/�� �v�5�o��<���9�w�%?o��{���k�-�wy��y&�q�#D= ���d�L{@��G� Z�~�?����LaU����y�\K�s�(�u�ЉS��0����  ,�\U����BRb��t��C���k��@�ۢ��-mz?�&D��(��8���l>��e�!���q�)�j����Q&�Fv:�q��q��D��,1X�ջ��eL ���M>�! }�$l����`��ʥ�SgC);uA���=���4�����5���RkG�+���Ԩ�A�s0~��Y`+AE��cM�ѷm��TӘr惺7�Ⱥ{w���wˢ�)���($����}�S�-�?8��z�e���W:=7v�x8G�l���{�F"�'�)hڱ��詤��Dc�O7�R���. (��������;ȍK	H�J�0I)�jm�y������ДŐ�(����&�=�U��8Y�f�ݑ�_̭�_�s�A�4��Z��o����ʔ��������-�l���TV������04�HM���lP;���?/7}K���J��&�s�x.���5�e�[��`�z���2���Mhn{u�L}��L���O^�B��o��d�p�0X�-��'�+]Xxpћ��?�n�v�sЄ�,��z�6�};�.pK�7r�HPaz�B��h"-���h����v��Ղ ,(��U�;��ɝHO��Ie�F���r�ya�5`~��q8S���D� ��!]
�A��qakZ��76�k��&n������c-˹���9� t�E�	��qiv��Y�� �F��-�3�k�r�����9�+����i�j���l��l�5:�-���K40=NI������S�����Wzu'�5�ا��b�4��!�8{�}�n8���JP�����;�n՜
\s�{ ��N.�vA"�&��;0�ؔW��-4_h�Fŕ�Ǻ2T~g��-�/C. F�V���a����P, ������ A�4�O����^w��x-���P&{DR��Z�0�u�1�n�(��={�^�/�����@�
hP0��	�X/�d�W������xG)/���c7��s�FTp�@G��=�0?6:���`��]d�¦��I?Vr�h�(��}��/!()O8��0# +����iD�JK���u�Q$1������O3t?��j����,EuM�z�ˠg�`�vi�-��O�8z�B��O�P��]���	�4��,��2PY�:���{x��P1z�@��8�/�íF퇮A)�a���@@D�V��`{��
�<��"{�I�(@�HB����ŅC�:�h'�����h?�9��!:%�'a ��ro��l5��N�����Ψo���͎1��� ��u�蹕��j����2J�����m��2�);�dt�c�w��@��g�u��o)QJ�pzeHr���@`mG�����c�|�sl���7�ǌ����4s���I2����C�ܓǅO�g���5��;�3��ȴ�#��)ɻè�lv��B�8��rz�_sr2f�/�X��A����}�Cb&,;d���h���r��9m|f$���d�_0��	�i�#��~|�`��b��j�_k�[�nQ;˼���|��
�d	����uK���O�r�l1�0����G,���a��w�ͮͩ�y�o��\�!���4m�4G�#U44�G�X~�����	�d�	LP@�1�_��O!t�̓0<us@����(0{��|8fq� �YG�B57��%-�ӊ���A�׋�Z����	)R�_s�u�lg5P��N�̌�V
d^E:�3P��0uK�y|c�C��e���j>���x���J*m�1��֑�p�����HL�f�?���|ݭ��;.T�@��'��Y��쟤g*t2�s�?��јR�Αy���oo���/�0
[Vt����B��d�?	8��/%'��A�]���Ч%�3J�/m���9�̦��;g�Y(�Ί�}�Y�=c���6����l׌��.X7�ρBsm��HY�zԓ��_���O�)WWrΟ���|©f9�]G8�,SB�!#Z��۪"Ƹ{r�B'��c�7NJޞH9
�3�1�H�x�h`k/1�_��?�ő-�         i  x�U�Mk�@�s�+z������~\��A�=z����F�����M"�%��y�n�|^zy���t��7�_��z��˕7��~Q|�߽t2��+�N�|�z�Dv�N��g�;���v��3'k��r��|5硛x��)s��q�<���I�Z�����rL��+.�n7t�'we G)f�1��m����K}3dk�R�V�y*�����㭮��B�S
4���~ju$�e�˕5��^~=��oںn&�s��e>���D]˩9^�Zz-
C���6�Kb*z�杜�k�}y�`@��wf[�H�*<�n���Mr����%���ߢ����~h�2Y6�h��U4�=��_SU�?��~      	     x����n�@���O��ڝ��D4RT)RUҴ�r�%�X�XS	��SBhwv����9g�x%<t������Gܶ;�����g\�
iA:#N?����W��E�u��w�>n�qݨ:�AZ���*���]ʙz9�:+g8]b��2�\��\��*FC�"�B�C�g�IL��Z�Q5NIF�⚰oq�m�~(��) ��g�Q��x:B�	�z��( �!>��%����a2=��Iy�@7
$;x~i�Ɛ�e`���W[��U���ܶ��_߾20���
Eo 2cQUk��>���U��Y�K3#�х5Y���妍p���G��(E��d�H� KiI*�.U�w),	G�d�:T��$��I��6���:�����P��
+X 4�?U/%�t3^d�L�Q4`��0�/7��2�K��U�����������p��-��ŀ |M�~��n|��Pc�/���-hG�j�� ��υk]a\A���	d�cX�����|��n�vu���S�n�y��$�\����oD�+���O����a�u         �  x�]SMo�0=ۿ"GV�+�?f�cA��j�R���]��l�l����[�8%R�_ޗAa ��:~R�m�c8�z��ye3�q�AJʯ)i�<�������<=r��-���Xg<`Vn�}�o2�k��s?��̟ܪ盀Qx��t�b>�kꖻaj�
ǐW��`�MA��tT>�WW�����&�MI�u �s1uܫ/�?qU0_^�a1��T,j����#�����tvGQ�c�sbQ�ԇ��m�>q�k�'�b�rC��(���/��wcqv�üm��V�9�C�"E�f'Ōj3�Ӱ�3��U�	��������Z�N�ޞ�����E5�ʾ�QTK�s7�(��6�K�Q4�����7����i}�ƢoR��b��(����U�D)oI̯j��J��G�v3oZ�N��K��[ �}^�H�q�qW�+��PI"�8*�KT��~w���(���F4ۢF�S���%��n�q2ْA�^��4,�E�i���z��i��䕍rvd��$��֌��e��fK(�ai� &�(襼 ���Ţ)ľ��(��V�佖�-*��`����056�,p/p_��(Y��(X��hٳ�څ�?H��oS�- �Є2�Q�=�7<�qޞ�l���H�������$��     