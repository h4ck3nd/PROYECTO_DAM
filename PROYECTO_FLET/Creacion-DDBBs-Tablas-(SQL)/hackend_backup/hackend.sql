--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-04-17 00:42:01

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
-- TOC entry 220 (class 1259 OID 24629)
-- Name: laboratorios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.laboratorios (
    lab_id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    flag character varying(255) NOT NULL,
    puntos integer NOT NULL
);


ALTER TABLE public.laboratorios OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 24645)
-- Name: laboratorios_dockerpwned; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.laboratorios_dockerpwned (
    lab_id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    flag character varying(255) NOT NULL,
    puntos integer NOT NULL
);


ALTER TABLE public.laboratorios_dockerpwned OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24644)
-- Name: laboratorios_dockerpwned_lab_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.laboratorios_dockerpwned_lab_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.laboratorios_dockerpwned_lab_id_seq OWNER TO postgres;

--
-- TOC entry 4983 (class 0 OID 0)
-- Dependencies: 223
-- Name: laboratorios_dockerpwned_lab_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.laboratorios_dockerpwned_lab_id_seq OWNED BY public.laboratorios_dockerpwned.lab_id;


--
-- TOC entry 219 (class 1259 OID 24628)
-- Name: laboratorios_lab_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.laboratorios_lab_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.laboratorios_lab_id_seq OWNER TO postgres;

--
-- TOC entry 4984 (class 0 OID 0)
-- Dependencies: 219
-- Name: laboratorios_lab_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.laboratorios_lab_id_seq OWNED BY public.laboratorios.lab_id;


--
-- TOC entry 226 (class 1259 OID 24654)
-- Name: laboratorios_ovalabs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.laboratorios_ovalabs (
    lab_id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    flag character varying(255) NOT NULL,
    puntos integer NOT NULL
);


ALTER TABLE public.laboratorios_ovalabs OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24653)
-- Name: laboratorios_ovalabs_lab_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.laboratorios_ovalabs_lab_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.laboratorios_ovalabs_lab_id_seq OWNER TO postgres;

--
-- TOC entry 4985 (class 0 OID 0)
-- Dependencies: 225
-- Name: laboratorios_ovalabs_lab_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.laboratorios_ovalabs_lab_id_seq OWNED BY public.laboratorios_ovalabs.lab_id;


--
-- TOC entry 218 (class 1259 OID 24591)
-- Name: profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profile (
    id integer NOT NULL,
    user_id integer NOT NULL,
    photo_path character varying(255)
);


ALTER TABLE public.profile OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 24590)
-- Name: profile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.profile_id_seq OWNER TO postgres;

--
-- TOC entry 4986 (class 0 OID 0)
-- Dependencies: 217
-- Name: profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.profile_id_seq OWNED BY public.profile.id;


--
-- TOC entry 222 (class 1259 OID 24638)
-- Name: validate_flag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.validate_flag (
    id integer NOT NULL,
    user_id integer NOT NULL,
    lab_id integer NOT NULL,
    flag character varying(255) NOT NULL,
    puntos integer NOT NULL
);


ALTER TABLE public.validate_flag OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 24664)
-- Name: validate_flag_dockerpwned; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.validate_flag_dockerpwned (
    id integer NOT NULL,
    user_id integer NOT NULL,
    lab_id integer NOT NULL,
    flag character varying(255) NOT NULL,
    puntos integer NOT NULL
);


ALTER TABLE public.validate_flag_dockerpwned OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 24663)
-- Name: validate_flag_dockerpwned_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.validate_flag_dockerpwned_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.validate_flag_dockerpwned_id_seq OWNER TO postgres;

--
-- TOC entry 4987 (class 0 OID 0)
-- Dependencies: 227
-- Name: validate_flag_dockerpwned_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.validate_flag_dockerpwned_id_seq OWNED BY public.validate_flag_dockerpwned.id;


--
-- TOC entry 221 (class 1259 OID 24637)
-- Name: validate_flag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.validate_flag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.validate_flag_id_seq OWNER TO postgres;

--
-- TOC entry 4988 (class 0 OID 0)
-- Dependencies: 221
-- Name: validate_flag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.validate_flag_id_seq OWNED BY public.validate_flag.id;


--
-- TOC entry 230 (class 1259 OID 24671)
-- Name: validate_flag_ovalabs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.validate_flag_ovalabs (
    id integer NOT NULL,
    user_id integer NOT NULL,
    lab_id integer NOT NULL,
    flag character varying(255) NOT NULL,
    puntos integer NOT NULL
);


ALTER TABLE public.validate_flag_ovalabs OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 24670)
-- Name: validate_flag_ovalabs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.validate_flag_ovalabs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.validate_flag_ovalabs_id_seq OWNER TO postgres;

--
-- TOC entry 4989 (class 0 OID 0)
-- Dependencies: 229
-- Name: validate_flag_ovalabs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.validate_flag_ovalabs_id_seq OWNED BY public.validate_flag_ovalabs.id;


--
-- TOC entry 232 (class 1259 OID 32849)
-- Name: writeups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.writeups (
    id integer NOT NULL,
    lab_id integer NOT NULL,
    user_id integer NOT NULL,
    url_writeup text NOT NULL,
    username text DEFAULT 'desconocido'::text NOT NULL
);


ALTER TABLE public.writeups OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 41038)
-- Name: writeups_dockerpwned; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.writeups_dockerpwned (
    id integer NOT NULL,
    lab_id integer NOT NULL,
    user_id integer NOT NULL,
    url_writeup text NOT NULL,
    username text DEFAULT 'desconocido'::text NOT NULL
);


ALTER TABLE public.writeups_dockerpwned OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 41037)
-- Name: writeups_dockerpwned_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.writeups_dockerpwned_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.writeups_dockerpwned_id_seq OWNER TO postgres;

--
-- TOC entry 4990 (class 0 OID 0)
-- Dependencies: 233
-- Name: writeups_dockerpwned_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.writeups_dockerpwned_id_seq OWNED BY public.writeups_dockerpwned.id;


--
-- TOC entry 231 (class 1259 OID 32848)
-- Name: writeups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.writeups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.writeups_id_seq OWNER TO postgres;

--
-- TOC entry 4991 (class 0 OID 0)
-- Dependencies: 231
-- Name: writeups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.writeups_id_seq OWNED BY public.writeups.id;


--
-- TOC entry 4783 (class 2604 OID 24632)
-- Name: laboratorios lab_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laboratorios ALTER COLUMN lab_id SET DEFAULT nextval('public.laboratorios_lab_id_seq'::regclass);


--
-- TOC entry 4785 (class 2604 OID 24648)
-- Name: laboratorios_dockerpwned lab_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laboratorios_dockerpwned ALTER COLUMN lab_id SET DEFAULT nextval('public.laboratorios_dockerpwned_lab_id_seq'::regclass);


--
-- TOC entry 4786 (class 2604 OID 24657)
-- Name: laboratorios_ovalabs lab_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laboratorios_ovalabs ALTER COLUMN lab_id SET DEFAULT nextval('public.laboratorios_ovalabs_lab_id_seq'::regclass);


--
-- TOC entry 4782 (class 2604 OID 24594)
-- Name: profile id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profile ALTER COLUMN id SET DEFAULT nextval('public.profile_id_seq'::regclass);


--
-- TOC entry 4784 (class 2604 OID 24641)
-- Name: validate_flag id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.validate_flag ALTER COLUMN id SET DEFAULT nextval('public.validate_flag_id_seq'::regclass);


--
-- TOC entry 4787 (class 2604 OID 24667)
-- Name: validate_flag_dockerpwned id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.validate_flag_dockerpwned ALTER COLUMN id SET DEFAULT nextval('public.validate_flag_dockerpwned_id_seq'::regclass);


--
-- TOC entry 4788 (class 2604 OID 24674)
-- Name: validate_flag_ovalabs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.validate_flag_ovalabs ALTER COLUMN id SET DEFAULT nextval('public.validate_flag_ovalabs_id_seq'::regclass);


--
-- TOC entry 4789 (class 2604 OID 32852)
-- Name: writeups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.writeups ALTER COLUMN id SET DEFAULT nextval('public.writeups_id_seq'::regclass);


--
-- TOC entry 4791 (class 2604 OID 41041)
-- Name: writeups_dockerpwned id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.writeups_dockerpwned ALTER COLUMN id SET DEFAULT nextval('public.writeups_dockerpwned_id_seq'::regclass);


--
-- TOC entry 4963 (class 0 OID 24629)
-- Dependencies: 220
-- Data for Name: laboratorios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.laboratorios (lab_id, nombre, flag, puntos) FROM stdin;
1	foro-xss	FLAG{lo_lograste}	10
2	amashop	FLAG{amashop_flag}	20
3	hacking_community	FLAG{flag_bac}	10
4	separo	FLAG{separo_flag}	15
\.


--
-- TOC entry 4967 (class 0 OID 24645)
-- Dependencies: 224
-- Data for Name: laboratorios_dockerpwned; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.laboratorios_dockerpwned (lab_id, nombre, flag, puntos) FROM stdin;
1	r00tless	FLAG{r00tless_flag}	50
\.


--
-- TOC entry 4969 (class 0 OID 24654)
-- Dependencies: 226
-- Data for Name: laboratorios_ovalabs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.laboratorios_ovalabs (lab_id, nombre, flag, puntos) FROM stdin;
1	test_ova	FLAG{test_flag}	50
\.


--
-- TOC entry 4961 (class 0 OID 24591)
-- Dependencies: 218
-- Data for Name: profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profile (id, user_id, photo_path) FROM stdin;
2	2	uploads/admin.png
5	1	uploads/hacker.png
\.


--
-- TOC entry 4965 (class 0 OID 24638)
-- Dependencies: 222
-- Data for Name: validate_flag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.validate_flag (id, user_id, lab_id, flag, puntos) FROM stdin;
1	1	1	FLAG{lo_lograste}	10
2	2	1	FLAG{lo_lograste}	10
4	1	3	FLAG{flag_bac}	10
5	1	2	FLAG{amashop_flag}	20
6	38	1	FLAG{lo_lograste}	10
8	41	3	FLAG{flag_bac}	10
9	1	4	FLAG{separo_flag}	15
10	38	2	FLAG{amashop_flag}	20
11	38	4	FLAG{separo_flag}	15
\.


--
-- TOC entry 4971 (class 0 OID 24664)
-- Dependencies: 228
-- Data for Name: validate_flag_dockerpwned; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.validate_flag_dockerpwned (id, user_id, lab_id, flag, puntos) FROM stdin;
2	1	1	FLAG{r00tless_flag}	50
\.


--
-- TOC entry 4973 (class 0 OID 24671)
-- Dependencies: 230
-- Data for Name: validate_flag_ovalabs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.validate_flag_ovalabs (id, user_id, lab_id, flag, puntos) FROM stdin;
1	1	1	FLAG{test_flag}	50
\.


--
-- TOC entry 4975 (class 0 OID 32849)
-- Dependencies: 232
-- Data for Name: writeups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.writeups (id, lab_id, user_id, url_writeup, username) FROM stdin;
2	2	1	https://dise0.gitbook.io/h4cker_b00k/herramientas-tecnicas/hackingweb/sql-injection	user
3	3	1	http://test.com/bac_writeup_update	user
5	1	2	http://test.com/xss_writeup	admin
6	4	1	http://test.com/open_redirect_writeup	user
1	1	1	https://dise0.gitbook.io/h4cker_b00k/herramientas-tecnicas/hackingweb/xss-cross-site-scripting	user
9	4	38	http://test.com/open_redirect_writeup_designer	designer
\.


--
-- TOC entry 4977 (class 0 OID 41038)
-- Dependencies: 234
-- Data for Name: writeups_dockerpwned; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.writeups_dockerpwned (id, lab_id, user_id, url_writeup, username) FROM stdin;
1	1	1	https://dise0.gitbook.io/h4cker_b00k/my-ctfs/ctf-r00tless-hard	user
\.


--
-- TOC entry 4992 (class 0 OID 0)
-- Dependencies: 223
-- Name: laboratorios_dockerpwned_lab_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.laboratorios_dockerpwned_lab_id_seq', 1, true);


--
-- TOC entry 4993 (class 0 OID 0)
-- Dependencies: 219
-- Name: laboratorios_lab_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.laboratorios_lab_id_seq', 4, true);


--
-- TOC entry 4994 (class 0 OID 0)
-- Dependencies: 225
-- Name: laboratorios_ovalabs_lab_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.laboratorios_ovalabs_lab_id_seq', 1, true);


--
-- TOC entry 4995 (class 0 OID 0)
-- Dependencies: 217
-- Name: profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.profile_id_seq', 5, true);


--
-- TOC entry 4996 (class 0 OID 0)
-- Dependencies: 227
-- Name: validate_flag_dockerpwned_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.validate_flag_dockerpwned_id_seq', 2, true);


--
-- TOC entry 4997 (class 0 OID 0)
-- Dependencies: 221
-- Name: validate_flag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.validate_flag_id_seq', 11, true);


--
-- TOC entry 4998 (class 0 OID 0)
-- Dependencies: 229
-- Name: validate_flag_ovalabs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.validate_flag_ovalabs_id_seq', 1, true);


--
-- TOC entry 4999 (class 0 OID 0)
-- Dependencies: 233
-- Name: writeups_dockerpwned_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.writeups_dockerpwned_id_seq', 2, true);


--
-- TOC entry 5000 (class 0 OID 0)
-- Dependencies: 231
-- Name: writeups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.writeups_id_seq', 10, true);


--
-- TOC entry 4800 (class 2606 OID 24652)
-- Name: laboratorios_dockerpwned laboratorios_dockerpwned_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laboratorios_dockerpwned
    ADD CONSTRAINT laboratorios_dockerpwned_pkey PRIMARY KEY (lab_id);


--
-- TOC entry 4802 (class 2606 OID 24661)
-- Name: laboratorios_ovalabs laboratorios_ovalabs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laboratorios_ovalabs
    ADD CONSTRAINT laboratorios_ovalabs_pkey PRIMARY KEY (lab_id);


--
-- TOC entry 4796 (class 2606 OID 24636)
-- Name: laboratorios laboratorios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laboratorios
    ADD CONSTRAINT laboratorios_pkey PRIMARY KEY (lab_id);


--
-- TOC entry 4794 (class 2606 OID 24596)
-- Name: profile profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_pkey PRIMARY KEY (id);


--
-- TOC entry 4808 (class 2606 OID 32858)
-- Name: writeups unique_lab_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.writeups
    ADD CONSTRAINT unique_lab_user UNIQUE (lab_id, user_id);


--
-- TOC entry 4812 (class 2606 OID 41047)
-- Name: writeups_dockerpwned unique_lab_user_dockerpwned; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.writeups_dockerpwned
    ADD CONSTRAINT unique_lab_user_dockerpwned UNIQUE (lab_id, user_id);


--
-- TOC entry 4804 (class 2606 OID 24669)
-- Name: validate_flag_dockerpwned validate_flag_dockerpwned_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.validate_flag_dockerpwned
    ADD CONSTRAINT validate_flag_dockerpwned_pkey PRIMARY KEY (id);


--
-- TOC entry 4806 (class 2606 OID 24676)
-- Name: validate_flag_ovalabs validate_flag_ovalabs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.validate_flag_ovalabs
    ADD CONSTRAINT validate_flag_ovalabs_pkey PRIMARY KEY (id);


--
-- TOC entry 4798 (class 2606 OID 24643)
-- Name: validate_flag validate_flag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.validate_flag
    ADD CONSTRAINT validate_flag_pkey PRIMARY KEY (id);


--
-- TOC entry 4814 (class 2606 OID 41045)
-- Name: writeups_dockerpwned writeups_dockerpwned_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.writeups_dockerpwned
    ADD CONSTRAINT writeups_dockerpwned_pkey PRIMARY KEY (id);


--
-- TOC entry 4810 (class 2606 OID 32856)
-- Name: writeups writeups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.writeups
    ADD CONSTRAINT writeups_pkey PRIMARY KEY (id);


-- Completed on 2025-04-17 00:42:01

--
-- PostgreSQL database dump complete
--

