--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22
-- Dumped by pg_dump version 12.22

-- Started on 2025-04-04 14:24:43

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 221 (class 1255 OID 33416)
-- Name: set_default_role(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_default_role() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF NEW.id_role IS NULL THEN
			SELECT id_role INTO NEW.id_role FROM role WHERE default_role = TRUE LIMIT 1;
		END IF;
		RETURN NEW;
	END;
$$;


ALTER FUNCTION public.set_default_role() OWNER TO postgres;

--
-- TOC entry 222 (class 1255 OID 41588)
-- Name: trigger_iden_insert(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_iden_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF NEW.resource_identifier IS NULL THEN
	SELECT identifier FROM resource_identifier INTO NEW.resource_identifier WHERE default_identifier = TRUE LIMIT 1;
	END IF;
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.trigger_iden_insert() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 214 (class 1259 OID 33406)
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 33404)
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO postgres;

--
-- TOC entry 2946 (class 0 OID 0)
-- Dependencies: 213
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- TOC entry 215 (class 1259 OID 41575)
-- Name: permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permission (
    permission character varying(50) NOT NULL,
    resource_type character varying(50),
    resource_identifier character varying(50),
    permission_id integer NOT NULL,
    deleted_at timestamp without time zone
);


ALTER TABLE public.permission OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 41590)
-- Name: permission_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.permission_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permission_permission_id_seq OWNER TO postgres;

--
-- TOC entry 2947 (class 0 OID 0)
-- Dependencies: 217
-- Name: permission_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.permission_permission_id_seq OWNED BY public.permission.permission_id;


--
-- TOC entry 205 (class 1259 OID 25202)
-- Name: profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profile (
    id_profile integer NOT NULL,
    id_user integer NOT NULL,
    fullname character varying(100) NOT NULL,
    alamat character varying(100) NOT NULL,
    notelp integer NOT NULL,
    foto_profil character varying(255)
);


ALTER TABLE public.profile OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 25200)
-- Name: profile_id_profile_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.profile_id_profile_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profile_id_profile_seq OWNER TO postgres;

--
-- TOC entry 2948 (class 0 OID 0)
-- Dependencies: 204
-- Name: profile_id_profile_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.profile_id_profile_seq OWNED BY public.profile.id_profile;


--
-- TOC entry 216 (class 1259 OID 41580)
-- Name: resource_identifier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_identifier (
    identifier_id integer NOT NULL,
    identifier character varying(20) NOT NULL,
    default_identifier boolean DEFAULT false
);


ALTER TABLE public.resource_identifier OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 25234)
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    id_role integer NOT NULL,
    nama_role character varying(50) NOT NULL,
    default_role boolean DEFAULT false,
    deleted_at timestamp without time zone
);


ALTER TABLE public.role OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 41619)
-- Name: role_hierarchy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_hierarchy (
    parent_role_id integer NOT NULL,
    child_role_id integer NOT NULL
);


ALTER TABLE public.role_hierarchy OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 25232)
-- Name: role_id_role_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.role_id_role_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.role_id_role_seq OWNER TO postgres;

--
-- TOC entry 2949 (class 0 OID 0)
-- Dependencies: 208
-- Name: role_id_role_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.role_id_role_seq OWNED BY public.role.id_role;


--
-- TOC entry 218 (class 1259 OID 41599)
-- Name: role_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_permission (
    id_role integer NOT NULL,
    id_permission integer NOT NULL
);


ALTER TABLE public.role_permission OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 25222)
-- Name: user_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role (
    id_user_role integer NOT NULL,
    id_user integer NOT NULL,
    id_role integer NOT NULL
);


ALTER TABLE public.user_role OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 25193)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id_users integer NOT NULL,
    username character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(10) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    password_salt character varying(50),
    password_last_changed timestamp without time zone,
    password_expired boolean DEFAULT false,
    id_role integer,
    deleted_at timestamp without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 41614)
-- Name: user_effective_permission_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.user_effective_permission_view AS
 SELECT u.id_users,
    u.username,
    r.id_role,
    r.nama_role,
    p.permission,
    p.resource_type,
    p.resource_identifier
   FROM ((((public.users u
     JOIN public.user_role ur ON ((u.id_users = ur.id_user)))
     JOIN public.role r ON ((ur.id_role = r.id_role)))
     JOIN public.role_permission rp ON ((r.id_role = rp.id_role)))
     JOIN public.permission p ON ((rp.id_permission = p.permission_id)));


ALTER TABLE public.user_effective_permission_view OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 33384)
-- Name: user_login_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_login_log (
    login_id integer NOT NULL,
    user_id integer NOT NULL,
    login_timestamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ip_address character varying(50),
    login_success boolean DEFAULT false,
    device_info character varying(50)
);


ALTER TABLE public.user_login_log OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 25220)
-- Name: user_role_id_user_role_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_role_id_user_role_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_role_id_user_role_seq OWNER TO postgres;

--
-- TOC entry 2950 (class 0 OID 0)
-- Dependencies: 206
-- Name: user_role_id_user_role_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_role_id_user_role_seq OWNED BY public.user_role.id_user_role;


--
-- TOC entry 202 (class 1259 OID 25191)
-- Name: users_id_users_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_users_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_users_seq OWNER TO postgres;

--
-- TOC entry 2951 (class 0 OID 0)
-- Dependencies: 202
-- Name: users_id_users_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_users_seq OWNED BY public.users.id_users;


--
-- TOC entry 211 (class 1259 OID 25242)
-- Name: veryfication; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.veryfication (
    id_verifikasi integer NOT NULL,
    id_user integer NOT NULL,
    kode_veryfikasi integer NOT NULL,
    status_veryfikasi character varying(50) NOT NULL,
    expired_at character varying(50)
);


ALTER TABLE public.veryfication OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 25240)
-- Name: veryfication_id_verifikasi_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.veryfication_id_verifikasi_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.veryfication_id_verifikasi_seq OWNER TO postgres;

--
-- TOC entry 2952 (class 0 OID 0)
-- Dependencies: 210
-- Name: veryfication_id_verifikasi_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.veryfication_id_verifikasi_seq OWNED BY public.veryfication.id_verifikasi;


--
-- TOC entry 2755 (class 2604 OID 33409)
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- TOC entry 2756 (class 2604 OID 41592)
-- Name: permission permission_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permission ALTER COLUMN permission_id SET DEFAULT nextval('public.permission_permission_id_seq'::regclass);


--
-- TOC entry 2748 (class 2604 OID 25205)
-- Name: profile id_profile; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profile ALTER COLUMN id_profile SET DEFAULT nextval('public.profile_id_profile_seq'::regclass);


--
-- TOC entry 2750 (class 2604 OID 25237)
-- Name: role id_role; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role ALTER COLUMN id_role SET DEFAULT nextval('public.role_id_role_seq'::regclass);


--
-- TOC entry 2749 (class 2604 OID 25225)
-- Name: user_role id_user_role; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role ALTER COLUMN id_user_role SET DEFAULT nextval('public.user_role_id_user_role_seq'::regclass);


--
-- TOC entry 2745 (class 2604 OID 25196)
-- Name: users id_users; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id_users SET DEFAULT nextval('public.users_id_users_seq'::regclass);


--
-- TOC entry 2752 (class 2604 OID 25245)
-- Name: veryfication id_verifikasi; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.veryfication ALTER COLUMN id_verifikasi SET DEFAULT nextval('public.veryfication_id_verifikasi_seq'::regclass);


--
-- TOC entry 2935 (class 0 OID 33406)
-- Dependencies: 214
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, migration, batch) FROM stdin;
\.


--
-- TOC entry 2936 (class 0 OID 41575)
-- Dependencies: 215
-- Data for Name: permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permission (permission, resource_type, resource_identifier, permission_id, deleted_at) FROM stdin;
view	home	*	1	\N
\.


--
-- TOC entry 2926 (class 0 OID 25202)
-- Dependencies: 205
-- Data for Name: profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profile (id_profile, id_user, fullname, alamat, notelp, foto_profil) FROM stdin;
1	1	WilliamWardana	Jl.Inpres	8783954	
\.


--
-- TOC entry 2937 (class 0 OID 41580)
-- Dependencies: 216
-- Data for Name: resource_identifier; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_identifier (identifier_id, identifier, default_identifier) FROM stdin;
1	*	t
\.


--
-- TOC entry 2930 (class 0 OID 25234)
-- Dependencies: 209
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role (id_role, nama_role, default_role, deleted_at) FROM stdin;
1	admin	f	\N
3	user	t	\N
4	Manager	f	\N
5	Super Admin	f	\N
\.


--
-- TOC entry 2940 (class 0 OID 41619)
-- Dependencies: 220
-- Data for Name: role_hierarchy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_hierarchy (parent_role_id, child_role_id) FROM stdin;
5	1
1	4
4	3
\.


--
-- TOC entry 2939 (class 0 OID 41599)
-- Dependencies: 218
-- Data for Name: role_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_permission (id_role, id_permission) FROM stdin;
1	1
\.


--
-- TOC entry 2933 (class 0 OID 33384)
-- Dependencies: 212
-- Data for Name: user_login_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_login_log (login_id, user_id, login_timestamp, ip_address, login_success, device_info) FROM stdin;
\.


--
-- TOC entry 2928 (class 0 OID 25222)
-- Dependencies: 207
-- Data for Name: user_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role (id_user_role, id_user, id_role) FROM stdin;
1	1	1
\.


--
-- TOC entry 2924 (class 0 OID 25193)
-- Dependencies: 203
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id_users, username, email, password, created_at, password_salt, password_last_changed, password_expired, id_role, deleted_at) FROM stdin;
4	CobaAjaDulu	cobacoba123@gmail.com	123	2025-03-22 21:54:53.054884	\N	2025-03-25 10:43:39.917894	f	3	\N
1	William	William@gmail.com	123	2025-03-14 00:24:33.60698	\N	2025-03-25 10:43:11.798112	f	1	2025-04-04 14:21:11.617077
3	Wardana	Wardana123@gmail.com	123	2025-03-22 21:53:55.481247	\N	2025-03-25 10:43:18.221277	f	3	\N
\.


--
-- TOC entry 2932 (class 0 OID 25242)
-- Dependencies: 211
-- Data for Name: veryfication; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.veryfication (id_verifikasi, id_user, kode_veryfikasi, status_veryfikasi, expired_at) FROM stdin;
1	1	123321	ongoing	\N
\.


--
-- TOC entry 2953 (class 0 OID 0)
-- Dependencies: 213
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 1, false);


--
-- TOC entry 2954 (class 0 OID 0)
-- Dependencies: 217
-- Name: permission_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permission_permission_id_seq', 1, true);


--
-- TOC entry 2955 (class 0 OID 0)
-- Dependencies: 204
-- Name: profile_id_profile_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.profile_id_profile_seq', 1, true);


--
-- TOC entry 2956 (class 0 OID 0)
-- Dependencies: 208
-- Name: role_id_role_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.role_id_role_seq', 5, true);


--
-- TOC entry 2957 (class 0 OID 0)
-- Dependencies: 206
-- Name: user_role_id_user_role_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_role_id_user_role_seq', 1, true);


--
-- TOC entry 2958 (class 0 OID 0)
-- Dependencies: 202
-- Name: users_id_users_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_users_seq', 4, true);


--
-- TOC entry 2959 (class 0 OID 0)
-- Dependencies: 210
-- Name: veryfication_id_verifikasi_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.veryfication_id_verifikasi_seq', 1, true);


--
-- TOC entry 2780 (class 2606 OID 33411)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 2782 (class 2606 OID 41594)
-- Name: permission permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permission
    ADD CONSTRAINT permission_pkey PRIMARY KEY (permission_id);


--
-- TOC entry 2761 (class 2606 OID 25209)
-- Name: profile profile_id_user_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_id_user_key UNIQUE (id_user);


--
-- TOC entry 2763 (class 2606 OID 25207)
-- Name: profile profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_pkey PRIMARY KEY (id_profile);


--
-- TOC entry 2784 (class 2606 OID 41585)
-- Name: resource_identifier resource_identifier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_identifier
    ADD CONSTRAINT resource_identifier_pkey PRIMARY KEY (identifier_id);


--
-- TOC entry 2788 (class 2606 OID 41623)
-- Name: role_hierarchy role_hierarchy_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_hierarchy
    ADD CONSTRAINT role_hierarchy_pkey PRIMARY KEY (parent_role_id, child_role_id);


--
-- TOC entry 2786 (class 2606 OID 41603)
-- Name: role_permission role_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT role_permission_pkey PRIMARY KEY (id_role, id_permission);


--
-- TOC entry 2771 (class 2606 OID 25239)
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id_role);


--
-- TOC entry 2778 (class 2606 OID 33390)
-- Name: user_login_log user_login_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_login_log
    ADD CONSTRAINT user_login_log_pkey PRIMARY KEY (login_id);


--
-- TOC entry 2765 (class 2606 OID 25231)
-- Name: user_role user_role_id_role_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_id_role_key UNIQUE (id_role);


--
-- TOC entry 2767 (class 2606 OID 25229)
-- Name: user_role user_role_id_user_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_id_user_key UNIQUE (id_user);


--
-- TOC entry 2769 (class 2606 OID 25227)
-- Name: user_role user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (id_user_role);


--
-- TOC entry 2759 (class 2606 OID 25199)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id_users);


--
-- TOC entry 2774 (class 2606 OID 25249)
-- Name: veryfication veryfication_id_user_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.veryfication
    ADD CONSTRAINT veryfication_id_user_key UNIQUE (id_user);


--
-- TOC entry 2776 (class 2606 OID 25247)
-- Name: veryfication veryfication_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.veryfication
    ADD CONSTRAINT veryfication_pkey PRIMARY KEY (id_verifikasi);


--
-- TOC entry 2772 (class 1259 OID 33415)
-- Name: unique_default_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unique_default_role ON public.role USING btree (default_role) WHERE (default_role = true);


--
-- TOC entry 2795 (class 2620 OID 41589)
-- Name: permission auto_insert_iden; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER auto_insert_iden BEFORE INSERT ON public.permission FOR EACH ROW EXECUTE FUNCTION public.trigger_iden_insert();


--
-- TOC entry 2794 (class 2620 OID 33417)
-- Name: users before_insert_user; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_user BEFORE INSERT ON public.users FOR EACH ROW EXECUTE FUNCTION public.set_default_role();


--
-- TOC entry 2789 (class 2606 OID 33391)
-- Name: user_login_log fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_login_log
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(id_users) ON DELETE CASCADE;


--
-- TOC entry 2793 (class 2606 OID 41629)
-- Name: role_hierarchy role_hierarchy_child_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_hierarchy
    ADD CONSTRAINT role_hierarchy_child_role_id_fkey FOREIGN KEY (child_role_id) REFERENCES public.role(id_role) ON DELETE CASCADE;


--
-- TOC entry 2792 (class 2606 OID 41624)
-- Name: role_hierarchy role_hierarchy_parent_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_hierarchy
    ADD CONSTRAINT role_hierarchy_parent_role_id_fkey FOREIGN KEY (parent_role_id) REFERENCES public.role(id_role) ON DELETE CASCADE;


--
-- TOC entry 2791 (class 2606 OID 41609)
-- Name: role_permission role_permission_id_permission_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT role_permission_id_permission_fkey FOREIGN KEY (id_permission) REFERENCES public.permission(permission_id);


--
-- TOC entry 2790 (class 2606 OID 41604)
-- Name: role_permission role_permission_id_role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permission
    ADD CONSTRAINT role_permission_id_role_fkey FOREIGN KEY (id_role) REFERENCES public.role(id_role);


-- Completed on 2025-04-04 14:24:43

--
-- PostgreSQL database dump complete
--

