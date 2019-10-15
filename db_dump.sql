--
-- PostgreSQL database dump
--

-- Dumped from database version 10.7 (Debian 10.7-1.pgdg90+1)
-- Dumped by pg_dump version 11.3

-- Started on 2019-10-15 15:53:28

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
-- TOC entry 3221 (class 1262 OID 59403)
-- Name: digitaledition; Type: DATABASE; Schema: -; Owner: root
--

CREATE DATABASE digitaledition WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE digitaledition OWNER TO root;

\connect digitaledition

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
-- TOC entry 244 (class 1255 OID 59404)
-- Name: trigger_set_timestamp(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION public.trigger_set_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.trigger_set_timestamp() OWNER TO root;

--
-- TOC entry 196 (class 1259 OID 59405)
-- Name: contributor_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.contributor_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contributor_seq OWNER TO root;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 197 (class 1259 OID 59407)
-- Name: contributor; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.contributor (
    id bigint DEFAULT nextval('public.contributor_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT '2018-10-12 09:12:28.144759'::timestamp without time zone,
    date_modified timestamp without time zone,
    publication_collection_id bigint,
    publication_collection_introduction_id bigint,
    publication_collection_title_id bigint,
    publication_id bigint,
    publication_manuscript_id bigint,
    publication_version_id bigint,
    deleted smallint DEFAULT 0,
    type text,
    first_name text,
    last_name text,
    description text,
    prefix text
);


ALTER TABLE public.contributor OWNER TO root;

--
-- TOC entry 198 (class 1259 OID 59416)
-- Name: event_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.event_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_seq OWNER TO root;

--
-- TOC entry 199 (class 1259 OID 59418)
-- Name: event; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.event (
    id bigint DEFAULT nextval('public.event_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    type text,
    description text
);


ALTER TABLE public.event OWNER TO root;

--
-- TOC entry 200 (class 1259 OID 59427)
-- Name: event_connection_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.event_connection_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_connection_seq OWNER TO root;

--
-- TOC entry 201 (class 1259 OID 59429)
-- Name: event_connection; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.event_connection (
    id bigint DEFAULT nextval('public.event_connection_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT '2018-10-12 09:12:28.528531'::timestamp without time zone,
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    subject_id bigint,
    tag_id bigint,
    location_id bigint,
    event_id bigint
);


ALTER TABLE public.event_connection OWNER TO root;

--
-- TOC entry 202 (class 1259 OID 59435)
-- Name: event_occurrence_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.event_occurrence_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_occurrence_seq OWNER TO root;

--
-- TOC entry 203 (class 1259 OID 59437)
-- Name: event_occurrence; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.event_occurrence (
    id bigint DEFAULT nextval('public.event_occurrence_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT '2018-10-12 09:12:28.658718'::timestamp without time zone,
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    type text,
    description text,
    event_id bigint,
    publication_id bigint,
    publication_version_id bigint,
    publication_manuscript_id bigint,
    publication_facsimile_id bigint,
    publication_comment_id bigint,
    publication_facsimile_page bigint,
    publication_song_id bigint
);


ALTER TABLE public.event_occurrence OWNER TO root;

--
-- TOC entry 204 (class 1259 OID 59446)
-- Name: event_relation_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.event_relation_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_relation_seq OWNER TO root;

--
-- TOC entry 205 (class 1259 OID 59448)
-- Name: event_relation; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.event_relation (
    id bigint DEFAULT nextval('public.event_relation_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT '2018-10-12 09:12:28.729647'::timestamp without time zone,
    date_modified timestamp without time zone,
    event_id bigint,
    related_event_id bigint,
    deleted smallint DEFAULT 0
);


ALTER TABLE public.event_relation OWNER TO root;

--
-- TOC entry 206 (class 1259 OID 59454)
-- Name: location_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.location_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.location_seq OWNER TO root;

--
-- TOC entry 207 (class 1259 OID 59456)
-- Name: location; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.location (
    id bigint DEFAULT nextval('public.location_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    name text,
    country text,
    city text,
    description text,
    legacy_id text,
    latitude numeric(9,6),
    longitude numeric(9,6),
    project_id bigint,
    region text,
    source text
);


ALTER TABLE public.location OWNER TO root;

--
-- TOC entry 208 (class 1259 OID 59465)
-- Name: media; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.media (
    image bytea,
    pdf bytea
)
INHERITS (public.event);


ALTER TABLE public.media OWNER TO root;

--
-- TOC entry 209 (class 1259 OID 59474)
-- Name: media_connection; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.media_connection (
    media_id bigint NOT NULL
)
INHERITS (public.event_connection);


ALTER TABLE public.media_connection OWNER TO root;

--
-- TOC entry 210 (class 1259 OID 59480)
-- Name: project_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.project_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_seq OWNER TO root;

--
-- TOC entry 211 (class 1259 OID 59482)
-- Name: project; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.project (
    id bigint DEFAULT nextval('public.project_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    published bigint,
    name text
);


ALTER TABLE public.project OWNER TO root;

--
-- TOC entry 212 (class 1259 OID 59491)
-- Name: publication_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.publication_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.publication_seq OWNER TO root;

--
-- TOC entry 213 (class 1259 OID 59493)
-- Name: publication; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.publication (
    id bigint DEFAULT nextval('public.publication_seq'::regclass) NOT NULL,
    publication_collection_id bigint,
    publication_comment_id bigint,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    date_published_externally timestamp without time zone,
    deleted smallint DEFAULT 0,
    published bigint,
    legacy_id text,
    published_by text,
    original_filename text,
    name text,
    genre text,
    publication_group_id bigint,
    original_publication_date timestamp without time zone,
    zts_id bigint
);


ALTER TABLE public.publication OWNER TO root;

--
-- TOC entry 214 (class 1259 OID 59502)
-- Name: publication_collection_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.publication_collection_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.publication_collection_seq OWNER TO root;

--
-- TOC entry 215 (class 1259 OID 59504)
-- Name: publication_collection; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.publication_collection (
    id bigint DEFAULT nextval('public.publication_collection_seq'::regclass) NOT NULL,
    publication_collection_introduction_id bigint,
    publication_collection_title_id bigint,
    project_id bigint,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    date_published_externally timestamp without time zone,
    deleted smallint DEFAULT 0,
    published bigint,
    name text
);


ALTER TABLE public.publication_collection OWNER TO root;

--
-- TOC entry 216 (class 1259 OID 59513)
-- Name: publication_collection_intro_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.publication_collection_intro_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.publication_collection_intro_seq OWNER TO root;

--
-- TOC entry 217 (class 1259 OID 59515)
-- Name: publication_collection_introduction; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.publication_collection_introduction (
    id bigint DEFAULT nextval('public.publication_collection_intro_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT '2018-10-12 09:12:27.410734'::timestamp without time zone,
    date_modified timestamp without time zone,
    date_published_externally timestamp without time zone,
    deleted smallint DEFAULT 0,
    published bigint,
    legacy_id text,
    original_filename text
);


ALTER TABLE public.publication_collection_introduction OWNER TO root;

--
-- TOC entry 218 (class 1259 OID 59524)
-- Name: publication_collection_title_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.publication_collection_title_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.publication_collection_title_seq OWNER TO root;

--
-- TOC entry 219 (class 1259 OID 59526)
-- Name: publication_collection_title; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.publication_collection_title (
    id bigint DEFAULT nextval('public.publication_collection_title_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT '2018-10-12 09:12:27.501043'::timestamp without time zone,
    date_modified timestamp without time zone,
    date_published_externally timestamp without time zone,
    deleted smallint DEFAULT 0,
    published bigint,
    legacy_id text,
    original_filename text
);


ALTER TABLE public.publication_collection_title OWNER TO root;

--
-- TOC entry 220 (class 1259 OID 59535)
-- Name: publication_comment_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.publication_comment_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.publication_comment_seq OWNER TO root;

--
-- TOC entry 221 (class 1259 OID 59537)
-- Name: publication_comment; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.publication_comment (
    id bigint DEFAULT nextval('public.publication_comment_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT '2018-10-12 09:12:27.900523'::timestamp without time zone,
    date_modified timestamp without time zone,
    date_published_externally timestamp without time zone,
    deleted smallint DEFAULT 0,
    published bigint,
    legacy_id text,
    published_by text,
    original_filename text
);


ALTER TABLE public.publication_comment OWNER TO root;

--
-- TOC entry 222 (class 1259 OID 59546)
-- Name: publication_facsimile_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.publication_facsimile_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.publication_facsimile_seq OWNER TO root;

--
-- TOC entry 223 (class 1259 OID 59548)
-- Name: publication_facsimile; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.publication_facsimile (
    id bigint DEFAULT nextval('public.publication_facsimile_seq'::regclass) NOT NULL,
    publication_facsimile_collection_id bigint,
    publication_id bigint,
    publication_manuscript_id bigint,
    publication_version_id bigint,
    date_created timestamp without time zone DEFAULT '2018-10-12 09:12:28.630247'::timestamp without time zone,
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    page_nr integer NOT NULL,
    section_id bigint NOT NULL,
    priority bigint NOT NULL,
    type bigint NOT NULL
);


ALTER TABLE public.publication_facsimile OWNER TO root;

--
-- TOC entry 224 (class 1259 OID 59554)
-- Name: publication_facsimile_collec_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.publication_facsimile_collec_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.publication_facsimile_collec_seq OWNER TO root;

--
-- TOC entry 225 (class 1259 OID 59556)
-- Name: publication_facsimile_collection; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.publication_facsimile_collection (
    id bigint DEFAULT nextval('public.publication_facsimile_collec_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT '2018-10-12 09:12:28.558943'::timestamp without time zone,
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    title text,
    number_of_pages bigint,
    start_page_number bigint,
    description text,
    folder_path text,
    page_comment text,
    "external_uRL" text
);


ALTER TABLE public.publication_facsimile_collection OWNER TO root;

--
-- TOC entry 226 (class 1259 OID 59565)
-- Name: publication_facsimile_zone_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.publication_facsimile_zone_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.publication_facsimile_zone_seq OWNER TO root;

--
-- TOC entry 227 (class 1259 OID 59567)
-- Name: publication_facsimile_zone; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.publication_facsimile_zone (
    id bigint DEFAULT nextval('public.publication_facsimile_zone_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT '2018-10-12 09:12:28.758617'::timestamp without time zone,
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    publication_facsimile_id bigint
);


ALTER TABLE public.publication_facsimile_zone OWNER TO root;

--
-- TOC entry 228 (class 1259 OID 59573)
-- Name: publication_group_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.publication_group_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.publication_group_seq OWNER TO root;

--
-- TOC entry 229 (class 1259 OID 59575)
-- Name: publication_group; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.publication_group (
    id bigint DEFAULT nextval('public.publication_group_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT '2018-10-12 09:12:27.977918'::timestamp without time zone,
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    published smallint DEFAULT 0,
    name text
);


ALTER TABLE public.publication_group OWNER TO root;

--
-- TOC entry 230 (class 1259 OID 59585)
-- Name: publication_manuscript_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.publication_manuscript_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.publication_manuscript_seq OWNER TO root;

--
-- TOC entry 231 (class 1259 OID 59587)
-- Name: publication_manuscript; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.publication_manuscript (
    id bigint DEFAULT nextval('public.publication_manuscript_seq'::regclass) NOT NULL,
    publication_id bigint,
    date_created timestamp without time zone DEFAULT '2018-10-12 09:12:28.05304'::timestamp without time zone,
    date_modified timestamp without time zone,
    date_published_externally timestamp without time zone,
    deleted smallint DEFAULT 0,
    published bigint,
    legacy_id text,
    published_by text,
    original_filename text,
    name text,
    type bigint,
    section_id bigint,
    sort_order bigint
);


ALTER TABLE public.publication_manuscript OWNER TO root;

--
-- TOC entry 232 (class 1259 OID 59596)
-- Name: publication_song; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.publication_song (
    id integer NOT NULL,
    date_created timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    publication_id bigint,
    original_id text,
    name text,
    type text,
    number text,
    variant text,
    landscape text,
    place text,
    recorder_firstname text,
    recorder_lastname text,
    recorder_born_name text,
    performer_firstname text,
    performer_lastname text,
    performer_born_name text,
    note text,
    comment text,
    lyrics text,
    original_collection_location text,
    original_collection_signature text,
    original_publication_date text,
    page_number text,
    subtype text,
    volume text
);


ALTER TABLE public.publication_song OWNER TO root;

--
-- TOC entry 233 (class 1259 OID 59604)
-- Name: publication_song_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.publication_song_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.publication_song_id_seq OWNER TO root;

--
-- TOC entry 3222 (class 0 OID 0)
-- Dependencies: 233
-- Name: publication_song_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.publication_song_id_seq OWNED BY public.publication_song.id;


--
-- TOC entry 234 (class 1259 OID 59606)
-- Name: publication_version_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.publication_version_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.publication_version_seq OWNER TO root;

--
-- TOC entry 235 (class 1259 OID 59608)
-- Name: publication_version; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.publication_version (
    id bigint DEFAULT nextval('public.publication_version_seq'::regclass) NOT NULL,
    publication_id bigint,
    date_created timestamp without time zone DEFAULT '2018-10-12 09:12:27.808947'::timestamp without time zone,
    date_modified timestamp without time zone,
    date_published_externally timestamp without time zone,
    deleted smallint DEFAULT 0,
    published bigint,
    legacy_id text,
    published_by text,
    original_filename text,
    name text,
    type integer,
    section_id integer,
    sort_order bigint
);


ALTER TABLE public.publication_version OWNER TO root;

--
-- TOC entry 236 (class 1259 OID 59617)
-- Name: review_comment_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.review_comment_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.review_comment_seq OWNER TO root;

--
-- TOC entry 237 (class 1259 OID 59619)
-- Name: review_comment; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.review_comment (
    id bigint DEFAULT nextval('public.review_comment_seq'::regclass) NOT NULL,
    publication_id bigint,
    date_created timestamp without time zone DEFAULT '2018-10-12 09:12:28.800318'::timestamp without time zone,
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    comment text,
    "user" text,
    legacy_id text,
    review_comment_id bigint
);


ALTER TABLE public.review_comment OWNER TO root;

--
-- TOC entry 238 (class 1259 OID 59628)
-- Name: subject_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.subject_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subject_seq OWNER TO root;

--
-- TOC entry 239 (class 1259 OID 59630)
-- Name: subject; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.subject (
    id bigint DEFAULT nextval('public.subject_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    type text,
    first_name text,
    last_name text,
    place_of_birth text,
    occupation text,
    preposition text,
    full_name text,
    description text,
    legacy_id text,
    date_born timestamp without time zone,
    date_deceased timestamp without time zone,
    project_id bigint,
    source text
);


ALTER TABLE public.subject OWNER TO root;

--
-- TOC entry 240 (class 1259 OID 59639)
-- Name: tag_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.tag_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tag_seq OWNER TO root;

--
-- TOC entry 241 (class 1259 OID 59641)
-- Name: tag; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.tag (
    id bigint DEFAULT nextval('public.tag_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    type text,
    name text,
    description text,
    legacy_id text,
    project_id bigint,
    source text
);


ALTER TABLE public.tag OWNER TO root;

--
-- TOC entry 242 (class 1259 OID 59650)
-- Name: urn_lookup_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.urn_lookup_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.urn_lookup_seq OWNER TO root;

--
-- TOC entry 243 (class 1259 OID 59652)
-- Name: urn_lookup; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.urn_lookup (
    id bigint DEFAULT nextval('public.urn_lookup_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT '2018-10-12 09:12:28.862527'::timestamp without time zone,
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    urn text,
    url text,
    reference_text text,
    intro_reference_text text,
    project_id bigint,
    legacy_id text
);


ALTER TABLE public.urn_lookup OWNER TO root;

--
-- TOC entry 2904 (class 2604 OID 59661)
-- Name: media id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.media ALTER COLUMN id SET DEFAULT nextval('public.event_seq'::regclass);


--
-- TOC entry 2905 (class 2604 OID 59662)
-- Name: media date_created; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.media ALTER COLUMN date_created SET DEFAULT now();


--
-- TOC entry 2906 (class 2604 OID 59663)
-- Name: media deleted; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.media ALTER COLUMN deleted SET DEFAULT 0;


--
-- TOC entry 2907 (class 2604 OID 59664)
-- Name: media_connection id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.media_connection ALTER COLUMN id SET DEFAULT nextval('public.event_connection_seq'::regclass);


--
-- TOC entry 2908 (class 2604 OID 59665)
-- Name: media_connection date_created; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.media_connection ALTER COLUMN date_created SET DEFAULT '2018-10-12 09:12:28.528531'::timestamp without time zone;


--
-- TOC entry 2909 (class 2604 OID 59666)
-- Name: media_connection deleted; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.media_connection ALTER COLUMN deleted SET DEFAULT 0;


--
-- TOC entry 2946 (class 2604 OID 59667)
-- Name: publication_song id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_song ALTER COLUMN id SET DEFAULT nextval('public.publication_song_id_seq'::regclass);


--
-- TOC entry 3015 (class 2606 OID 60453)
-- Name: publication_collection_introduction PRIMARY; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_collection_introduction
    ADD CONSTRAINT "PRIMARY" PRIMARY KEY (id);


--
-- TOC entry 3017 (class 2606 OID 60455)
-- Name: publication_collection_title PRIMARY1; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_collection_title
    ADD CONSTRAINT "PRIMARY1" PRIMARY KEY (id);


--
-- TOC entry 2972 (class 2606 OID 60457)
-- Name: event PRIMARY10; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT "PRIMARY10" PRIMARY KEY (id);


--
-- TOC entry 2995 (class 2606 OID 60459)
-- Name: location PRIMARY11; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.location
    ADD CONSTRAINT "PRIMARY11" PRIMARY KEY (id);


--
-- TOC entry 3046 (class 2606 OID 60461)
-- Name: subject PRIMARY12; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.subject
    ADD CONSTRAINT "PRIMARY12" PRIMARY KEY (id);


--
-- TOC entry 3050 (class 2606 OID 60463)
-- Name: tag PRIMARY13; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT "PRIMARY13" PRIMARY KEY (id);


--
-- TOC entry 2975 (class 2606 OID 60465)
-- Name: event_connection PRIMARY14; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_connection
    ADD CONSTRAINT "PRIMARY14" PRIMARY KEY (id);


--
-- TOC entry 3027 (class 2606 OID 60467)
-- Name: publication_facsimile_collection PRIMARY15; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_facsimile_collection
    ADD CONSTRAINT "PRIMARY15" PRIMARY KEY (id);


--
-- TOC entry 3021 (class 2606 OID 60469)
-- Name: publication_facsimile PRIMARY16; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_facsimile
    ADD CONSTRAINT "PRIMARY16" PRIMARY KEY (id);


--
-- TOC entry 2982 (class 2606 OID 60471)
-- Name: event_occurrence PRIMARY17; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_occurrence
    ADD CONSTRAINT "PRIMARY17" PRIMARY KEY (id);


--
-- TOC entry 2991 (class 2606 OID 60473)
-- Name: event_relation PRIMARY18; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_relation
    ADD CONSTRAINT "PRIMARY18" PRIMARY KEY (id);


--
-- TOC entry 3029 (class 2606 OID 60475)
-- Name: publication_facsimile_zone PRIMARY19; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_facsimile_zone
    ADD CONSTRAINT "PRIMARY19" PRIMARY KEY (id);


--
-- TOC entry 3003 (class 2606 OID 60477)
-- Name: project PRIMARY2; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT "PRIMARY2" PRIMARY KEY (id);


--
-- TOC entry 3042 (class 2606 OID 60479)
-- Name: review_comment PRIMARY20; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.review_comment
    ADD CONSTRAINT "PRIMARY20" PRIMARY KEY (id);


--
-- TOC entry 3054 (class 2606 OID 60481)
-- Name: urn_lookup PRIMARY21; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.urn_lookup
    ADD CONSTRAINT "PRIMARY21" PRIMARY KEY (id);


--
-- TOC entry 3010 (class 2606 OID 60483)
-- Name: publication_collection PRIMARY3; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_collection
    ADD CONSTRAINT "PRIMARY3" PRIMARY KEY (id);


--
-- TOC entry 3005 (class 2606 OID 60485)
-- Name: publication PRIMARY4; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication
    ADD CONSTRAINT "PRIMARY4" PRIMARY KEY (id);


--
-- TOC entry 3039 (class 2606 OID 60487)
-- Name: publication_version PRIMARY5; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_version
    ADD CONSTRAINT "PRIMARY5" PRIMARY KEY (id);


--
-- TOC entry 3019 (class 2606 OID 60489)
-- Name: publication_comment PRIMARY6; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_comment
    ADD CONSTRAINT "PRIMARY6" PRIMARY KEY (id);


--
-- TOC entry 3032 (class 2606 OID 60491)
-- Name: publication_group PRIMARY7; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_group
    ADD CONSTRAINT "PRIMARY7" PRIMARY KEY (id);


--
-- TOC entry 3034 (class 2606 OID 60493)
-- Name: publication_manuscript PRIMARY8; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_manuscript
    ADD CONSTRAINT "PRIMARY8" PRIMARY KEY (id);


--
-- TOC entry 2963 (class 2606 OID 60495)
-- Name: contributor PRIMARY9; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.contributor
    ADD CONSTRAINT "PRIMARY9" PRIMARY KEY (id);


--
-- TOC entry 3001 (class 2606 OID 60497)
-- Name: media_connection id; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.media_connection
    ADD CONSTRAINT id PRIMARY KEY (id);


--
-- TOC entry 2999 (class 2606 OID 60499)
-- Name: media media_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.media
    ADD CONSTRAINT media_pkey PRIMARY KEY (id);


--
-- TOC entry 3037 (class 2606 OID 60501)
-- Name: publication_song publication_song_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_song
    ADD CONSTRAINT publication_song_pkey PRIMARY KEY (id);


--
-- TOC entry 2964 (class 1259 OID 60502)
-- Name: contributor_deleted_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX contributor_deleted_idx ON public.contributor USING btree (deleted);


--
-- TOC entry 2976 (class 1259 OID 60503)
-- Name: event_connection_deleted_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX event_connection_deleted_idx ON public.event_connection USING btree (deleted);


--
-- TOC entry 2973 (class 1259 OID 60504)
-- Name: event_deleted_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX event_deleted_idx ON public.event USING btree (deleted);


--
-- TOC entry 2983 (class 1259 OID 60505)
-- Name: event_occurrence_deleted_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX event_occurrence_deleted_idx ON public.event_occurrence USING btree (deleted);


--
-- TOC entry 2992 (class 1259 OID 60506)
-- Name: event_relation_deleted_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX event_relation_deleted_idx ON public.event_relation USING btree (deleted);


--
-- TOC entry 3022 (class 1259 OID 60507)
-- Name: facs_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX facs_id ON public.publication_facsimile USING btree (publication_facsimile_collection_id);


--
-- TOC entry 2965 (class 1259 OID 60508)
-- Name: fk_contributor_publication_collection_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_contributor_publication_collection_id_idx ON public.contributor USING btree (publication_collection_id);


--
-- TOC entry 2966 (class 1259 OID 60509)
-- Name: fk_contributor_publication_collection_introduction_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_contributor_publication_collection_introduction_id_idx ON public.contributor USING btree (publication_collection_introduction_id);


--
-- TOC entry 2967 (class 1259 OID 60510)
-- Name: fk_contributor_publication_collection_title_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_contributor_publication_collection_title_id_idx ON public.contributor USING btree (publication_collection_title_id);


--
-- TOC entry 2968 (class 1259 OID 60511)
-- Name: fk_contributor_publication_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_contributor_publication_id_idx ON public.contributor USING btree (publication_id);


--
-- TOC entry 2969 (class 1259 OID 60512)
-- Name: fk_contributor_publication_manuscript_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_contributor_publication_manuscript_id_idx ON public.contributor USING btree (publication_manuscript_id);


--
-- TOC entry 2970 (class 1259 OID 60513)
-- Name: fk_contributor_publication_version_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_contributor_publication_version_id_idx ON public.contributor USING btree (publication_version_id);


--
-- TOC entry 2977 (class 1259 OID 60514)
-- Name: fk_event_connection_event_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_event_connection_event_id_idx ON public.event_connection USING btree (event_id);


--
-- TOC entry 2978 (class 1259 OID 60515)
-- Name: fk_event_connection_location_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_event_connection_location_id_idx ON public.event_connection USING btree (location_id);


--
-- TOC entry 2979 (class 1259 OID 60516)
-- Name: fk_event_connection_subject_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_event_connection_subject_id_idx ON public.event_connection USING btree (subject_id);


--
-- TOC entry 2980 (class 1259 OID 60517)
-- Name: fk_event_connection_tag_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_event_connection_tag_id_idx ON public.event_connection USING btree (tag_id);


--
-- TOC entry 2984 (class 1259 OID 60518)
-- Name: fk_event_occurrence_event_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_event_occurrence_event_id_idx ON public.event_occurrence USING btree (event_id);


--
-- TOC entry 2985 (class 1259 OID 60519)
-- Name: fk_event_occurrence_publication_comment_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_event_occurrence_publication_comment_id_idx ON public.event_occurrence USING btree (publication_comment_id);


--
-- TOC entry 2986 (class 1259 OID 60520)
-- Name: fk_event_occurrence_publication_facsimile_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_event_occurrence_publication_facsimile_id_idx ON public.event_occurrence USING btree (publication_facsimile_id);


--
-- TOC entry 2987 (class 1259 OID 60521)
-- Name: fk_event_occurrence_publication_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_event_occurrence_publication_id_idx ON public.event_occurrence USING btree (publication_id);


--
-- TOC entry 2988 (class 1259 OID 60522)
-- Name: fk_event_occurrence_publication_manuscript_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_event_occurrence_publication_manuscript_id_idx ON public.event_occurrence USING btree (publication_manuscript_id);


--
-- TOC entry 2989 (class 1259 OID 60523)
-- Name: fk_event_occurrence_publication_version_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_event_occurrence_publication_version_id_idx ON public.event_occurrence USING btree (publication_version_id);


--
-- TOC entry 2993 (class 1259 OID 60524)
-- Name: fk_event_relation_event_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_event_relation_event_id_idx ON public.event_relation USING btree (event_id);


--
-- TOC entry 2996 (class 1259 OID 60525)
-- Name: fk_location_project_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_location_project_id_idx ON public.location USING btree (project_id);


--
-- TOC entry 3011 (class 1259 OID 60526)
-- Name: fk_publication_collection_project_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_publication_collection_project_id_idx ON public.publication_collection USING btree (project_id);


--
-- TOC entry 3012 (class 1259 OID 60527)
-- Name: fk_publication_collection_publication_collection_intro_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_publication_collection_publication_collection_intro_id_idx ON public.publication_collection USING btree (publication_collection_introduction_id);


--
-- TOC entry 3013 (class 1259 OID 60528)
-- Name: fk_publication_collection_publication_collection_title_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_publication_collection_publication_collection_title_id_idx ON public.publication_collection USING btree (publication_collection_title_id);


--
-- TOC entry 3023 (class 1259 OID 60529)
-- Name: fk_publication_facsimile_publication_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_publication_facsimile_publication_id_idx ON public.publication_facsimile USING btree (publication_id);


--
-- TOC entry 3024 (class 1259 OID 60530)
-- Name: fk_publication_facsimile_publication_manuscript_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_publication_facsimile_publication_manuscript_id_idx ON public.publication_facsimile USING btree (publication_manuscript_id);


--
-- TOC entry 3025 (class 1259 OID 60531)
-- Name: fk_publication_facsimile_publication_version_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_publication_facsimile_publication_version_id_idx ON public.publication_facsimile USING btree (publication_version_id);


--
-- TOC entry 3030 (class 1259 OID 60532)
-- Name: fk_publication_facsimile_zone_publication_facsimile_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_publication_facsimile_zone_publication_facsimile_id_idx ON public.publication_facsimile_zone USING btree (publication_facsimile_id);


--
-- TOC entry 3035 (class 1259 OID 60533)
-- Name: fk_publication_manuscript_publication_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_publication_manuscript_publication_id_idx ON public.publication_manuscript USING btree (publication_id);


--
-- TOC entry 3006 (class 1259 OID 60534)
-- Name: fk_publication_publication_collection_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_publication_publication_collection_id_idx ON public.publication USING btree (publication_collection_id);


--
-- TOC entry 3007 (class 1259 OID 60535)
-- Name: fk_publication_publication_comment_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_publication_publication_comment_id_idx ON public.publication USING btree (publication_comment_id);


--
-- TOC entry 3008 (class 1259 OID 60536)
-- Name: fk_publication_publication_group_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_publication_publication_group_id_idx ON public.publication USING btree (publication_group_id);


--
-- TOC entry 3040 (class 1259 OID 60537)
-- Name: fk_publication_version_publication_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_publication_version_publication_id_idx ON public.publication_version USING btree (publication_id);


--
-- TOC entry 3043 (class 1259 OID 60538)
-- Name: fk_review_comment_publication_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_review_comment_publication_id_idx ON public.review_comment USING btree (publication_id);


--
-- TOC entry 3044 (class 1259 OID 60539)
-- Name: fk_review_comment_review_comment_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_review_comment_review_comment_id_idx ON public.review_comment USING btree (review_comment_id);


--
-- TOC entry 3047 (class 1259 OID 60540)
-- Name: fk_subject_project_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_subject_project_id_idx ON public.subject USING btree (project_id);


--
-- TOC entry 3051 (class 1259 OID 60541)
-- Name: fk_tag_project_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_tag_project_id_idx ON public.tag USING btree (project_id);


--
-- TOC entry 3055 (class 1259 OID 60542)
-- Name: fk_urn_project_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_urn_project_id_idx ON public.urn_lookup USING btree (project_id);


--
-- TOC entry 2997 (class 1259 OID 60543)
-- Name: location_deleted_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX location_deleted_idx ON public.location USING btree (deleted);


--
-- TOC entry 3048 (class 1259 OID 60544)
-- Name: subject_deleted_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX subject_deleted_idx ON public.subject USING btree (deleted);


--
-- TOC entry 3052 (class 1259 OID 60545)
-- Name: tag_deleted_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX tag_deleted_idx ON public.tag USING btree (deleted);


--
-- TOC entry 3056 (class 2606 OID 60546)
-- Name: contributor fk_contributor_publication_collection_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.contributor
    ADD CONSTRAINT fk_contributor_publication_collection_id FOREIGN KEY (publication_collection_id) REFERENCES public.publication_collection(id);


--
-- TOC entry 3057 (class 2606 OID 60551)
-- Name: contributor fk_contributor_publication_collection_introduction_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.contributor
    ADD CONSTRAINT fk_contributor_publication_collection_introduction_id FOREIGN KEY (publication_collection_introduction_id) REFERENCES public.publication_collection_introduction(id);


--
-- TOC entry 3058 (class 2606 OID 60556)
-- Name: contributor fk_contributor_publication_collection_title_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.contributor
    ADD CONSTRAINT fk_contributor_publication_collection_title_id FOREIGN KEY (publication_collection_title_id) REFERENCES public.publication_collection_title(id);


--
-- TOC entry 3059 (class 2606 OID 60561)
-- Name: contributor fk_contributor_publication_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.contributor
    ADD CONSTRAINT fk_contributor_publication_id FOREIGN KEY (publication_id) REFERENCES public.publication(id);


--
-- TOC entry 3060 (class 2606 OID 60566)
-- Name: contributor fk_contributor_publication_manuscript_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.contributor
    ADD CONSTRAINT fk_contributor_publication_manuscript_id FOREIGN KEY (publication_manuscript_id) REFERENCES public.publication_manuscript(id);


--
-- TOC entry 3061 (class 2606 OID 60571)
-- Name: contributor fk_contributor_publication_version_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.contributor
    ADD CONSTRAINT fk_contributor_publication_version_id FOREIGN KEY (publication_version_id) REFERENCES public.publication_version(id);


--
-- TOC entry 3062 (class 2606 OID 60576)
-- Name: event_connection fk_event_connection_event_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_connection
    ADD CONSTRAINT fk_event_connection_event_id FOREIGN KEY (event_id) REFERENCES public.event(id);


--
-- TOC entry 3063 (class 2606 OID 60581)
-- Name: event_connection fk_event_connection_location_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_connection
    ADD CONSTRAINT fk_event_connection_location_id FOREIGN KEY (location_id) REFERENCES public.location(id);


--
-- TOC entry 3064 (class 2606 OID 60586)
-- Name: event_connection fk_event_connection_subject_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_connection
    ADD CONSTRAINT fk_event_connection_subject_id FOREIGN KEY (subject_id) REFERENCES public.subject(id);


--
-- TOC entry 3065 (class 2606 OID 60591)
-- Name: event_connection fk_event_connection_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_connection
    ADD CONSTRAINT fk_event_connection_tag_id FOREIGN KEY (tag_id) REFERENCES public.tag(id);


--
-- TOC entry 3066 (class 2606 OID 60596)
-- Name: event_occurrence fk_event_occurrence_event_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_occurrence
    ADD CONSTRAINT fk_event_occurrence_event_id FOREIGN KEY (event_id) REFERENCES public.event(id);


--
-- TOC entry 3067 (class 2606 OID 60601)
-- Name: event_occurrence fk_event_occurrence_publication_comment_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_occurrence
    ADD CONSTRAINT fk_event_occurrence_publication_comment_id FOREIGN KEY (publication_comment_id) REFERENCES public.publication_comment(id);


--
-- TOC entry 3068 (class 2606 OID 60606)
-- Name: event_occurrence fk_event_occurrence_publication_facsimile_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_occurrence
    ADD CONSTRAINT fk_event_occurrence_publication_facsimile_id FOREIGN KEY (publication_facsimile_id) REFERENCES public.publication_facsimile(id);


--
-- TOC entry 3069 (class 2606 OID 60611)
-- Name: event_occurrence fk_event_occurrence_publication_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_occurrence
    ADD CONSTRAINT fk_event_occurrence_publication_id FOREIGN KEY (publication_id) REFERENCES public.publication(id);


--
-- TOC entry 3070 (class 2606 OID 60616)
-- Name: event_occurrence fk_event_occurrence_publication_manuscript_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_occurrence
    ADD CONSTRAINT fk_event_occurrence_publication_manuscript_id FOREIGN KEY (publication_manuscript_id) REFERENCES public.publication_manuscript(id);


--
-- TOC entry 3072 (class 2606 OID 60772)
-- Name: event_occurrence fk_event_occurrence_publication_song_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_occurrence
    ADD CONSTRAINT fk_event_occurrence_publication_song_id FOREIGN KEY (publication_song_id) REFERENCES public.publication_song(id);


--
-- TOC entry 3071 (class 2606 OID 60626)
-- Name: event_occurrence fk_event_occurrence_publication_version_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_occurrence
    ADD CONSTRAINT fk_event_occurrence_publication_version_id FOREIGN KEY (publication_version_id) REFERENCES public.publication_version(id);


--
-- TOC entry 3073 (class 2606 OID 60631)
-- Name: event_relation fk_event_relation_event_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_relation
    ADD CONSTRAINT fk_event_relation_event_id FOREIGN KEY (event_id) REFERENCES public.event(id);


--
-- TOC entry 3074 (class 2606 OID 60636)
-- Name: location fk_location_project_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.location
    ADD CONSTRAINT fk_location_project_id FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- TOC entry 3079 (class 2606 OID 60641)
-- Name: publication_collection fk_publication_collection_project_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_collection
    ADD CONSTRAINT fk_publication_collection_project_id FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- TOC entry 3080 (class 2606 OID 60646)
-- Name: publication_collection fk_publication_collection_publication_collection_intro_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_collection
    ADD CONSTRAINT fk_publication_collection_publication_collection_intro_id FOREIGN KEY (publication_collection_introduction_id) REFERENCES public.publication_collection_introduction(id);


--
-- TOC entry 3081 (class 2606 OID 60651)
-- Name: publication_collection fk_publication_collection_publication_collection_title_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_collection
    ADD CONSTRAINT fk_publication_collection_publication_collection_title_id FOREIGN KEY (publication_collection_title_id) REFERENCES public.publication_collection_title(id);


--
-- TOC entry 3082 (class 2606 OID 60656)
-- Name: publication_facsimile fk_publication_facsimile_publication_facsimile_collection_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_facsimile
    ADD CONSTRAINT fk_publication_facsimile_publication_facsimile_collection_id FOREIGN KEY (publication_facsimile_collection_id) REFERENCES public.publication_facsimile_collection(id);


--
-- TOC entry 3083 (class 2606 OID 60661)
-- Name: publication_facsimile fk_publication_facsimile_publication_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_facsimile
    ADD CONSTRAINT fk_publication_facsimile_publication_id FOREIGN KEY (publication_id) REFERENCES public.publication(id);


--
-- TOC entry 3084 (class 2606 OID 60666)
-- Name: publication_facsimile fk_publication_facsimile_publication_manuscript_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_facsimile
    ADD CONSTRAINT fk_publication_facsimile_publication_manuscript_id FOREIGN KEY (publication_manuscript_id) REFERENCES public.publication_manuscript(id);


--
-- TOC entry 3085 (class 2606 OID 60671)
-- Name: publication_facsimile fk_publication_facsimile_publication_version_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_facsimile
    ADD CONSTRAINT fk_publication_facsimile_publication_version_id FOREIGN KEY (publication_version_id) REFERENCES public.publication_version(id);


--
-- TOC entry 3086 (class 2606 OID 60676)
-- Name: publication_facsimile_zone fk_publication_facsimile_zone_publication_facsimile_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_facsimile_zone
    ADD CONSTRAINT fk_publication_facsimile_zone_publication_facsimile_id FOREIGN KEY (publication_facsimile_id) REFERENCES public.publication_facsimile(id);


--
-- TOC entry 3087 (class 2606 OID 60681)
-- Name: publication_manuscript fk_publication_manuscript_publication_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_manuscript
    ADD CONSTRAINT fk_publication_manuscript_publication_id FOREIGN KEY (publication_id) REFERENCES public.publication(id);


--
-- TOC entry 3076 (class 2606 OID 60686)
-- Name: publication fk_publication_publication_collection_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication
    ADD CONSTRAINT fk_publication_publication_collection_id FOREIGN KEY (publication_collection_id) REFERENCES public.publication_collection(id);


--
-- TOC entry 3077 (class 2606 OID 60691)
-- Name: publication fk_publication_publication_comment_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication
    ADD CONSTRAINT fk_publication_publication_comment_id FOREIGN KEY (publication_comment_id) REFERENCES public.publication_comment(id);


--
-- TOC entry 3078 (class 2606 OID 60696)
-- Name: publication fk_publication_publication_group_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication
    ADD CONSTRAINT fk_publication_publication_group_id FOREIGN KEY (publication_group_id) REFERENCES public.publication_group(id);


--
-- TOC entry 3088 (class 2606 OID 60701)
-- Name: publication_song fk_publication_song_publication_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_song
    ADD CONSTRAINT fk_publication_song_publication_id FOREIGN KEY (publication_id) REFERENCES public.publication(id);


--
-- TOC entry 3089 (class 2606 OID 60706)
-- Name: publication_version fk_publication_version_publication_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_version
    ADD CONSTRAINT fk_publication_version_publication_id FOREIGN KEY (publication_id) REFERENCES public.publication(id);


--
-- TOC entry 3090 (class 2606 OID 60711)
-- Name: review_comment fk_review_comment_publication_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.review_comment
    ADD CONSTRAINT fk_review_comment_publication_id FOREIGN KEY (publication_id) REFERENCES public.publication(id);


--
-- TOC entry 3091 (class 2606 OID 60716)
-- Name: review_comment fk_review_comment_review_comment_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.review_comment
    ADD CONSTRAINT fk_review_comment_review_comment_id FOREIGN KEY (review_comment_id) REFERENCES public.review_comment(id);


--
-- TOC entry 3092 (class 2606 OID 60721)
-- Name: subject fk_subject_project_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.subject
    ADD CONSTRAINT fk_subject_project_id FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- TOC entry 3093 (class 2606 OID 60726)
-- Name: tag fk_tag_project_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT fk_tag_project_id FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- TOC entry 3094 (class 2606 OID 60731)
-- Name: urn_lookup fk_urn_project_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.urn_lookup
    ADD CONSTRAINT fk_urn_project_id FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- TOC entry 3075 (class 2606 OID 60736)
-- Name: media_connection media_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.media_connection
    ADD CONSTRAINT media_id_fk FOREIGN KEY (media_id) REFERENCES public.media(id);


-- Completed on 2019-10-15 15:53:28

--
-- PostgreSQL database dump complete
--

