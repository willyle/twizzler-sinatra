--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: groups; Type: TABLE; Schema: public; Owner: jasoncurran; Tablespace: 
--

CREATE TABLE groups (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE groups OWNER TO jasoncurran;

--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: jasoncurran
--

CREATE SEQUENCE groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE groups_id_seq OWNER TO jasoncurran;

--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jasoncurran
--

ALTER SEQUENCE groups_id_seq OWNED BY groups.id;


--
-- Name: relationships; Type: TABLE; Schema: public; Owner: jasoncurran; Tablespace: 
--

CREATE TABLE relationships (
    id integer NOT NULL,
    follower_id integer,
    followed_id integer
);


ALTER TABLE relationships OWNER TO jasoncurran;

--
-- Name: relationships_id_seq; Type: SEQUENCE; Schema: public; Owner: jasoncurran
--

CREATE SEQUENCE relationships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE relationships_id_seq OWNER TO jasoncurran;

--
-- Name: relationships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jasoncurran
--

ALTER SEQUENCE relationships_id_seq OWNED BY relationships.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: jasoncurran; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE schema_migrations OWNER TO jasoncurran;

--
-- Name: twizzles; Type: TABLE; Schema: public; Owner: jasoncurran; Tablespace: 
--

CREATE TABLE twizzles (
    id integer NOT NULL,
    user_id integer,
    content character varying,
    created_at character varying,
    updated_at character varying
);


ALTER TABLE twizzles OWNER TO jasoncurran;

--
-- Name: twizzles_id_seq; Type: SEQUENCE; Schema: public; Owner: jasoncurran
--

CREATE SEQUENCE twizzles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE twizzles_id_seq OWNER TO jasoncurran;

--
-- Name: twizzles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jasoncurran
--

ALTER SEQUENCE twizzles_id_seq OWNED BY twizzles.id;


--
-- Name: user_groups; Type: TABLE; Schema: public; Owner: jasoncurran; Tablespace: 
--

CREATE TABLE user_groups (
    id integer NOT NULL,
    group_id integer,
    user_id integer
);


ALTER TABLE user_groups OWNER TO jasoncurran;

--
-- Name: user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: jasoncurran
--

CREATE SEQUENCE user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_groups_id_seq OWNER TO jasoncurran;

--
-- Name: user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jasoncurran
--

ALTER SEQUENCE user_groups_id_seq OWNED BY user_groups.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: jasoncurran; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    username character varying,
    fname character varying,
    lname character varying,
    headline character varying,
    email character varying,
    password character varying
);


ALTER TABLE users OWNER TO jasoncurran;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: jasoncurran
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO jasoncurran;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jasoncurran
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jasoncurran
--

ALTER TABLE ONLY groups ALTER COLUMN id SET DEFAULT nextval('groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jasoncurran
--

ALTER TABLE ONLY relationships ALTER COLUMN id SET DEFAULT nextval('relationships_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jasoncurran
--

ALTER TABLE ONLY twizzles ALTER COLUMN id SET DEFAULT nextval('twizzles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jasoncurran
--

ALTER TABLE ONLY user_groups ALTER COLUMN id SET DEFAULT nextval('user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jasoncurran
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: jasoncurran
--

COPY groups (id, name) FROM stdin;
1	white people
2	rappers
3	black people
4	men
5	women
6	reality tv
\.


--
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jasoncurran
--

SELECT pg_catalog.setval('groups_id_seq', 1, false);


--
-- Data for Name: relationships; Type: TABLE DATA; Schema: public; Owner: jasoncurran
--

COPY relationships (id, follower_id, followed_id) FROM stdin;
18	2	4
19	6	4
25	2	17
36	5	20
\.


--
-- Name: relationships_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jasoncurran
--

SELECT pg_catalog.setval('relationships_id_seq', 1, false);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: jasoncurran
--

COPY schema_migrations (version) FROM stdin;
20151019100422
20151019100538
20151019100702
20151019100835
20151019101010
\.


--
-- Data for Name: twizzles; Type: TABLE DATA; Schema: public; Owner: jasoncurran
--

COPY twizzles (id, user_id, content, created_at, updated_at) FROM stdin;
4	7	One Twizzle	2015-10-18 06:33:37 UTC	2015-10-18 06:33:37 UTC
5	7	Second Twizzle	2015-10-18 06:33:37 UTC	2015-10-18 06:33:37 UTC
6	7	This is a example of a really long Twizzle. This is a example of a really long Twizzle. This is a example of a really long Twizzle. This is a example of a really long Twizzle. This is a example of a really long Twizzle. This is a example of a really long Twizzle. This is a example of a really long Twizzle. This is a example of a really long Twizzle. This is a example of a really long Twizzle. 	2015-10-18 06:33:37 UTC	2015-10-18 06:33:37 UTC
7	7	Twizzle Fo Shizzle	2015-10-18 06:33:37 UTC	2015-10-18 06:33:37 UTC
15	10	I have blonde hair	2015-10-18 06:33:37 UTC	2015-10-18 06:33:37 UTC
16	2	I hate Kanye West	2015-10-18 06:33:37 UTC	2015-10-18 06:33:37 UTC
17	5	I ain't saying she's a gold digger.	2015-10-18 06:33:37 UTC	2015-10-18 06:33:37 UTC
18	5	I'm sorry Taylor, but Beyonce is the best	2015-10-18 06:33:37 UTC	2015-10-18 06:33:37 UTC
19	5	Through the Wire	2015-10-18 06:33:37 UTC	2015-10-18 06:33:37 UTC
20	4	Fire fire fire fire fire	2015-10-18 06:33:37 UTC	2015-10-18 06:33:37 UTC
21	3	My name is Alicia	2015-10-18 06:33:37 UTC	2015-10-18 06:33:37 UTC
22	2	This girl is on fire	2015-10-18 06:33:37 UTC	2015-10-18 06:33:37 UTC
25	0	sdsdsad	2015-10-18 06:33:37 UTC	2015-10-18 06:33:37 UTC
29	13	my balls are small	2015-10-18 06:36:54 UTC	2015-10-18 06:36:54 UTC
30	13	why are my twizzles appearing	2015-10-18 06:37:13 UTC	2015-10-18 06:37:13 UTC
32	5	This is an example of a really long tweet by Kanye West	2015-10-18 10:30:00 UTC	2015-10-18 10:30:00 UTC
33	4	why isnt this working	2015-10-18 10:39:13 UTC	2015-10-18 10:39:13 UTC
36	4	hello	2015-10-18 11:17:26 UTC	2015-10-18 11:17:26 UTC
38	17	Hi guys!	2015-10-18 15:52:52 UTC	2015-10-18 15:52:52 UTC
39	20	I like Jayden's Tweet's	2015-10-18 17:31:22 UTC	2015-10-18 17:31:22 UTC
40	20	cvcvcvcvcvcvcvcvcxvcxv	2015-10-19 02:20:33 UTC	2015-10-19 02:20:33 UTC
\.


--
-- Name: twizzles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jasoncurran
--

SELECT pg_catalog.setval('twizzles_id_seq', 1, false);


--
-- Data for Name: user_groups; Type: TABLE DATA; Schema: public; Owner: jasoncurran
--

COPY user_groups (id, group_id, user_id) FROM stdin;
1	1	1
2	1	2
3	1	4
4	1	9
5	1	10
6	2	3
7	2	5
8	2	7
9	3	3
10	3	5
11	3	7
12	4	2
13	4	3
14	4	5
15	4	7
16	5	1
17	5	4
18	5	6
19	5	9
20	5	10
21	6	6
\.


--
-- Name: user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jasoncurran
--

SELECT pg_catalog.setval('user_groups_id_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: jasoncurran
--

COPY users (id, username, fname, lname, headline, email, password) FROM stdin;
2	jonbonjovi	Jon	BonJovi	22222	jonbonjovi@gmail.com	password
3	rickross	Rick	Ross	33333	rickross@gmail.com	password
4	taylorswift	Taylor	Swift	44444	taylorswift@gmail.com	password
5	kanyewest	Kanye	West	55555	kanyewest@gmail.com	password
6	kimkardashian	Kim	Kardashian	66666	kimkardashian@gmail.com	password
7	snoopdogg	Snoop	Dogg	77777	snoopdogg@gmail.com	password
9	ladygaga	Lady	Gaga	99999	ladygaga@gmail.com	password
10	iggyazalea	Iggy	Azalea	1010101010	iggyazalea@gmail.com	password
17	amberrose	Amber	Rose	I like Wiz Khalifa	amberrose@gmail.com	password
20	willsmith	Will	Smith	Getting Jiggy With It	willsmith@gmail.com	password
25	justintimberlake	Justin	Timberlake	I'm bringing sexy back!	justintimberlake@gmail.com	password
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jasoncurran
--

SELECT pg_catalog.setval('users_id_seq', 1, false);


--
-- Name: groups_pkey; Type: CONSTRAINT; Schema: public; Owner: jasoncurran; Tablespace: 
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: relationships_pkey; Type: CONSTRAINT; Schema: public; Owner: jasoncurran; Tablespace: 
--

ALTER TABLE ONLY relationships
    ADD CONSTRAINT relationships_pkey PRIMARY KEY (id);


--
-- Name: twizzles_pkey; Type: CONSTRAINT; Schema: public; Owner: jasoncurran; Tablespace: 
--

ALTER TABLE ONLY twizzles
    ADD CONSTRAINT twizzles_pkey PRIMARY KEY (id);


--
-- Name: user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: jasoncurran; Tablespace: 
--

ALTER TABLE ONLY user_groups
    ADD CONSTRAINT user_groups_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: jasoncurran; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: jasoncurran; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: public; Type: ACL; Schema: -; Owner: jasoncurran
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM jasoncurran;
GRANT ALL ON SCHEMA public TO jasoncurran;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

