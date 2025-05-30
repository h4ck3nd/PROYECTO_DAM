PGDMP  +                    }           appusers    17.4    17.4     '           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            (           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            )           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            *           1262    16388    appusers    DATABASE     n   CREATE DATABASE appusers WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'es-ES';
    DROP DATABASE appusers;
                     postgres    false            �            1259    16390    usuarios    TABLE     ?  CREATE TABLE public.usuarios (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    apellidos character varying(50) NOT NULL,
    email character varying(120) NOT NULL,
    usuario character varying(128) NOT NULL,
    password_hash character varying(255) NOT NULL,
    fecha_nacimiento date NOT NULL,
    estado boolean DEFAULT true,
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    rol character varying(10) DEFAULT 'user'::character varying,
    ultimo_login timestamp without time zone,
    cookie character varying(255)
);
    DROP TABLE public.usuarios;
       public         heap r       postgres    false            �            1259    16389    usuarios_id_seq    SEQUENCE     �   CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.usuarios_id_seq;
       public               postgres    false    218            +           0    0    usuarios_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;
          public               postgres    false    217            �           2604    16393    usuarios id    DEFAULT     j   ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);
 :   ALTER TABLE public.usuarios ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    217    218    218            $          0    16390    usuarios 
   TABLE DATA           �   COPY public.usuarios (id, nombre, apellidos, email, usuario, password_hash, fecha_nacimiento, estado, fecha_registro, rol, ultimo_login, cookie) FROM stdin;
    public               postgres    false    218   �       ,           0    0    usuarios_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.usuarios_id_seq', 5, true);
          public               postgres    false    217            �           2606    16406    usuarios usuarios_cookie_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_cookie_key UNIQUE (cookie);
 F   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_cookie_key;
       public                 postgres    false    218            �           2606    16402    usuarios usuarios_email_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (email);
 E   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_email_key;
       public                 postgres    false    218            �           2606    16400    usuarios usuarios_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_pkey;
       public                 postgres    false    218            �           2606    16404    usuarios usuarios_usuario_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_usuario_key UNIQUE (usuario);
 G   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_usuario_key;
       public                 postgres    false    218            $   j  x�}�KoT9F׷��v���}WD�h^��f �)���@�����&�F�@��U�}�9���rwk���tr�>~����v׶��m�_����j�����~&���4�������N?\~:'��\����h�2�g��	k�ű4��
;V�Ϊ�b�n��"�=
sgW�%�{i��IL�)6f"�e�ц�<�{�����U��i�C�pF��֒$��y�|�MONϧ�m����z�9��<��?��|_._˳?޽i�/��e��rH��#J.��2��\���B�@"q�=���;� E.ص�Eg��j�m�7&�LA�vਡ����������ӌy\��0��΁L�����G��C���o����{��ݿW�KLV�a���0P�bg�8�)���b3�l9d�h��x�&EM4��r����H:h����ᭌ��Cr�%�犁\������G��0�y-q��Ï�C4�UG�.�i��'�.p:�����n��z�=:�C�(�k������Wg���|��l�b�TS�vEM:�$�A���!I#ׂ�BdM��F����x��u��#+@�u�q������� 7+ �5�eD�̲V
��y���v�X,� %�#�     