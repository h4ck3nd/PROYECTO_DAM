--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-04-17 00:40:47

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 16393)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
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


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16392)
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_seq OWNER TO postgres;

--
-- TOC entry 4906 (class 0 OID 0)
-- Dependencies: 217
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- TOC entry 4742 (class 2604 OID 16396)
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- TOC entry 4900 (class 0 OID 16393)
-- Dependencies: 218
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, nombre, apellidos, email, usuario, password_hash, fecha_nacimiento, estado, fecha_registro, rol, ultimo_login, cookie) FROM stdin;
37	Rafa	Apellido Rafa	rafa@test.com	rafa	scrypt:32768:8:1$QtgQ9Uau3ZtnYwJ4$329ec7ebc0dc1f272232863677e417fb1a8ee30f23db65d01da37ed199c08f8b039298db6eecb6471d3f36092ae2f57cda6a3de4c1eff633ab957b63ff9df857	2025-04-07	t	2025-04-07 13:49:29.190633	user	\N	\N
2	Administrador	Apellido Gomez	admin@test.com	admin	scrypt:32768:8:1$KvvW9no5z1d2Q4IJ$035fd07f40ba6d35184d894da564d7a8dc6384b7b9275d4e6bc60bfd2acc5b27dbe127c101638019024213800fd0f2d44c9d45761fee63f2c8436d888f57f659	2025-04-04	t	2025-04-04 10:58:11.211446	admin	\N	\N
41	Test	Apellido	test@test.com	test	scrypt:32768:8:1$HrcD5O6Huk5jIA3i$07e71ef0704e896e14c9bbc559967ee6126f37b34291e1455d13d392be45071ddfad98ab094290ae7b5d8271cf3a5cf00c49cba32081865b407f2daf36c05878	2025-04-15	t	2025-04-15 15:58:35.749923	user	\N	6133cc23-9090-4704-995c-a3db3745ca27
1	Usuario	Apellido	user@test.com	user	scrypt:32768:8:1$Re3iEBxNOfxnXJ7u$d323a406af11c97448950e9bdab84459b048fcec158eb8d637cb68ecd8f70988873cd048bd964676af5980a40f95efc6e96b823fa72354d743f63b197429f743	2025-04-04	t	2025-04-04 10:56:33.350794	user	\N	26530b30-954d-4f25-b5fa-049a7a6bd836
38	Designer	Administrador	designer@test.com	designer	scrypt:32768:8:1$2rlA6NSJODopohOW$3160944304eb1e416b34332a92587cda761ed6ce71a62f71cc9db04b57b24171bf634ae2aa9b64e7686ee75322940a0810e08ed05531c21d34da3247ac1635e1	2025-04-12	t	2025-04-12 16:35:43.087273	designer	\N	d3d3796e-b694-4e9a-87c7-81495896e8cc
\.


--
-- TOC entry 4907 (class 0 OID 0)
-- Dependencies: 217
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 41, true);


--
-- TOC entry 4747 (class 2606 OID 16409)
-- Name: usuarios usuarios_cookie_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_cookie_key UNIQUE (cookie);


--
-- TOC entry 4749 (class 2606 OID 16405)
-- Name: usuarios usuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (email);


--
-- TOC entry 4751 (class 2606 OID 16403)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 4753 (class 2606 OID 16407)
-- Name: usuarios usuarios_usuario_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_usuario_key UNIQUE (usuario);


-- Completed on 2025-04-17 00:40:47

--
-- PostgreSQL database dump complete
--

