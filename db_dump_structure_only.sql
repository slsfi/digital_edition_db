--
-- PostgreSQL database dump
--

-- Dumped from database version 10.14 (Debian 10.14-1.pgdg90+1)
-- Dumped by pg_dump version 13.3 (Debian 13.3-1.pgdg90+1)

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
-- Name: check_original_publication_date(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION public.check_original_publication_date() RETURNS trigger AS
    '
BEGIN
  IF NEW.original_publication_date ~* ''([0-9X]{1,4}-[0-9X]{2}-[0-9X]{2}T?[]?)([0-9]{2}:[0-9]{2}:[0-9]{2})?(\+[0-9]{2}:[0-9]{2})?([ ]BC)?''
  OR NEW.original_publication_date IS NULL
  THEN
    RETURN NEW;
  ELSE 
    RAISE EXCEPTION ''Invalid original_publication_date'';
  END IF;
END;
'
LANGUAGE plpgsql;


ALTER FUNCTION public.check_original_publication_date() OWNER TO root;

--
-- Name: check_subject_date_born(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION public.check_subject_date_born() RETURNS trigger AS
    '
BEGIN
  IF NEW.date_born ~* ''([0-9X]{1,4}-[0-9X]{2}-[0-9X]{2}T?[]?)([0-9]{2}:[0-9]{2}:[0-9]{2})?(\+[0-9]{2}:[0-9]{2})?([ ]BC)?''
  OR NEW.date_born IS NULL
  THEN
    RETURN NEW;
  ELSE 
    RAISE EXCEPTION ''Invalid date_born'';
  END IF;
END;
' 
LANGUAGE plpgsql;


ALTER FUNCTION public.check_subject_date_born() OWNER TO root;

--
-- Name: check_subject_date_deceased(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION public.check_subject_date_deceased() RETURNS trigger AS
    '
BEGIN
  IF NEW.date_deceased ~* ''([0-9X]{1,4}-[0-9X]{2}-[0-9X]{2}T?[]?)([0-9]{2}:[0-9]{2}:[0-9]{2})?(\+[0-9]{2}:[0-9]{2})?([ ]BC)?''
  OR NEW.date_deceased IS NULL
  THEN
    RETURN NEW;
  ELSE 
    RAISE EXCEPTION ''Invalid date_deceased'';
  END IF;
END;
'
LANGUAGE plpgsql;


ALTER FUNCTION public.check_subject_date_deceased() OWNER TO root;

--
-- Name: trigger_set_timestamp(); Type: FUNCTION; Schema: public; Owner: root
--

CREATE FUNCTION public.trigger_set_timestamp() RETURNS trigger AS
    '
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
'
LANGUAGE plpgsql;


ALTER FUNCTION public.trigger_set_timestamp() OWNER TO root;

--
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

--
-- Name: contributor; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.contributor (
    id bigint DEFAULT nextval('public.contributor_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT now(),
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
-- Name: correspondence_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.correspondence_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.correspondence_seq OWNER TO root;

--
-- Name: correspondence; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.correspondence (
    id bigint DEFAULT nextval('public.correspondence_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    legacy_id text,
    title text,
    description text,
    source_collection_id text,
    source_archive text,
    source_id text,
    material text,
    material_color text,
    material_type text,
    material_source text,
    material_quality text,
    material_state text,
    material_notes text,
    language text,
    date_sent text,
    page_count text,
    project_id bigint,
    correspondence_collection_id bigint,
    correspondence_collection_id_legacy bigint,
    material_pattern text,
    material_format text,
    leaf_count text,
    sheet_count text
);


ALTER TABLE public.correspondence OWNER TO root;

--
-- Name: correspondence_collection_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.correspondence_collection_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.correspondence_collection_seq OWNER TO root;

--
-- Name: correspondence_collection; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.correspondence_collection (
    id bigint DEFAULT nextval('public.correspondence_collection_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    title text,
    description text,
    source text,
    start_year text,
    end_year text,
    legacy_id bigint,
    category text,
    original_letter_amount bigint
);


ALTER TABLE public.correspondence_collection OWNER TO root;

--
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
-- Name: event_connection; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.event_connection (
    id bigint DEFAULT nextval('public.event_connection_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    subject_id bigint,
    tag_id bigint,
    location_id bigint,
    event_id bigint,
    work_manifestation_id bigint,
    correspondence_id bigint,
    type text
);


ALTER TABLE public.event_connection OWNER TO root;

--
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
-- Name: event_occurrence; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.event_occurrence (
    id bigint DEFAULT nextval('public.event_occurrence_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT now(),
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
    publication_song_id bigint,
    work_id bigint
);


ALTER TABLE public.event_occurrence OWNER TO root;

--
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
-- Name: event_relation; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.event_relation (
    id bigint DEFAULT nextval('public.event_relation_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    event_id bigint,
    related_event_id bigint,
    deleted smallint DEFAULT 0
);


ALTER TABLE public.event_relation OWNER TO root;

--
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
    date_born character varying(30),
    date_deceased character varying(30),
    project_id bigint,
    source text,
    alias text,
    previous_last_name text,
    translation_id bigint
);


ALTER TABLE public.subject OWNER TO root;

--
-- Name: work_manifestation_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.work_manifestation_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_manifestation_seq OWNER TO root;

--
-- Name: work_manifestation; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.work_manifestation (
    id bigint DEFAULT nextval('public.work_manifestation_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    title text,
    type text,
    description text,
    source text,
    linked_work_manifestation_id bigint,
    work_id bigint,
    work_manuscript_id bigint,
    translated_by text,
    journal text,
    publication_location text,
    publisher text,
    published_year text,
    volume text,
    total_pages bigint,
    "ISBN" text,
    legacy_id text
);


ALTER TABLE public.work_manifestation OWNER TO root;

--
-- Name: work_reference_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.work_reference_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_reference_seq OWNER TO root;

--
-- Name: work_reference; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.work_reference (
    id bigint DEFAULT nextval('public.work_reference_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    referenced_as text,
    reference text,
    referenced_pages text,
    source text,
    project_id bigint,
    work_manifestation_id bigint
);


ALTER TABLE public.work_reference OWNER TO root;

--
-- Name: get_manifestations_with_authors; Type: VIEW; Schema: public; Owner: root
--

CREATE VIEW public.get_manifestations_with_authors WITH (security_barrier='false') AS
 SELECT row_to_json(t.*) AS json_data,
    t.project_id
   FROM ( SELECT w_m.id,
            w_m.date_created,
            w_m.date_modified,
            w_m.deleted,
            w_m.title,
            w_m.type,
            w_m.description,
            w_m.source,
            w_m.linked_work_manifestation_id,
            w_m.work_id,
            w_m.work_manuscript_id,
            w_m.translated_by,
            w_m.journal,
            w_m.publication_location,
            w_m.publisher,
            w_m.published_year,
            w_m.volume,
            w_m.total_pages,
            w_m."ISBN",
            w_r.project_id,
            w_r.reference,
            ( SELECT array_to_json(array_agg(row_to_json(d.*))) AS array_to_json
                   FROM ( SELECT s.id,
                            s.date_created,
                            s.date_modified,
                            s.deleted,
                            s.type,
                            s.first_name,
                            s.last_name,
                            s.place_of_birth,
                            s.occupation,
                            s.preposition,
                            s.full_name,
                            s.description,
                            s.legacy_id,
                            s.date_born,
                            s.date_deceased,
                            s.project_id,
                            s.source,
                            s.alias,
                            s.previous_last_name
                           FROM (public.event_connection ec
                             JOIN public.subject s ON ((s.id = ec.subject_id)))
                          WHERE ((ec.deleted = 0) AND (ec.work_manifestation_id = w_m.id))) d) AS authors
           FROM (public.work_manifestation w_m
             JOIN public.work_reference w_r ON ((w_r.work_manifestation_id = w_m.id)))
          WHERE ((w_r.deleted = 0) AND (w_m.deleted = 0))
          ORDER BY w_m.title) t;


ALTER TABLE public.get_manifestations_with_authors OWNER TO root;

--
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
    source text,
    alias text,
    name_translation_id bigint,
    translation_id bigint
);


ALTER TABLE public.location OWNER TO root;

--
-- Name: media; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.media (
    id bigint NOT NULL,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    type text,
    description text,
    image bytea,
    pdf bytea,
    title_translation_id integer,
    description_translation_id integer,
    image_filename_front text,
    image_filename_back text,
    media_collection_id bigint,
    orig_date_year integer,
    orig_date date,
    art_technique_translation_id bigint,
    sort_order bigint,
    sub_group bigint,
    external_reference text,
    internal_reference text,
    art_location text,
    legacy_id bigint
);


ALTER TABLE public.media OWNER TO root;

--
-- Name: media_collection; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.media_collection (
    id bigint NOT NULL,
    title_translation_id bigint,
    description_translation_id bigint,
    project_id bigint,
    image_path character varying(512),
    deleted smallint DEFAULT 0,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    sort_order smallint
);


ALTER TABLE public.media_collection OWNER TO root;

--
-- Name: media_collection_reference_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.media_collection_reference_seq
    START WITH 19
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.media_collection_reference_seq OWNER TO root;

--
-- Name: media_collection_reference_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.media_collection_reference_seq OWNED BY public.media_collection.id;


--
-- Name: media_connection; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.media_connection (
    id bigint DEFAULT nextval('public.event_connection_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    subject_id bigint,
    tag_id bigint,
    location_id bigint,
    event_id bigint,
    media_id bigint NOT NULL,
    work_manifestation_id bigint,
    correspondence_id bigint,
    type text
);


ALTER TABLE public.media_connection OWNER TO root;

--
-- Name: media_reference_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.media_reference_seq
    START WITH 13328
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.media_reference_seq OWNER TO root;

--
-- Name: media_reference_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.media_reference_seq OWNED BY public.media.id;


--
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
    original_publication_date text,
    zts_id bigint
);


ALTER TABLE public.publication OWNER TO root;

--
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
    name text,
    legacy_id text
);


ALTER TABLE public.publication_collection OWNER TO root;

--
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
-- Name: publication_collection_introduction; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.publication_collection_introduction (
    id bigint DEFAULT nextval('public.publication_collection_intro_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    date_published_externally timestamp without time zone,
    deleted smallint DEFAULT 0,
    published bigint,
    legacy_id text,
    original_filename text
);


ALTER TABLE public.publication_collection_introduction OWNER TO root;

--
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
-- Name: publication_collection_title; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.publication_collection_title (
    id bigint DEFAULT nextval('public.publication_collection_title_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    date_published_externally timestamp without time zone,
    deleted smallint DEFAULT 0,
    published bigint,
    legacy_id text,
    original_filename text
);


ALTER TABLE public.publication_collection_title OWNER TO root;

--
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
-- Name: publication_comment; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.publication_comment (
    id bigint DEFAULT nextval('public.publication_comment_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT now(),
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
-- Name: publication_facsimile; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.publication_facsimile (
    id bigint DEFAULT nextval('public.publication_facsimile_seq'::regclass) NOT NULL,
    publication_facsimile_collection_id bigint,
    publication_id bigint,
    publication_manuscript_id bigint,
    publication_version_id bigint,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    page_nr integer NOT NULL,
    section_id bigint NOT NULL,
    priority bigint NOT NULL,
    type bigint NOT NULL
);


ALTER TABLE public.publication_facsimile OWNER TO root;

--
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
-- Name: publication_facsimile_collection; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.publication_facsimile_collection (
    id bigint DEFAULT nextval('public.publication_facsimile_collec_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    title text,
    number_of_pages bigint,
    start_page_number bigint,
    description text,
    folder_path text,
    page_comment text,
    external_url text
);


ALTER TABLE public.publication_facsimile_collection OWNER TO root;

--
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
-- Name: publication_facsimile_zone; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.publication_facsimile_zone (
    id bigint DEFAULT nextval('public.publication_facsimile_zone_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    publication_facsimile_id bigint
);


ALTER TABLE public.publication_facsimile_zone OWNER TO root;

--
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
-- Name: publication_group; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.publication_group (
    id bigint DEFAULT nextval('public.publication_group_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    published smallint DEFAULT 0,
    name text
);


ALTER TABLE public.publication_group OWNER TO root;

--
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
-- Name: publication_manuscript; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.publication_manuscript (
    id bigint DEFAULT nextval('public.publication_manuscript_seq'::regclass) NOT NULL,
    publication_id bigint,
    date_created timestamp without time zone DEFAULT now(),
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
-- Name: publication_song_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.publication_song_id_seq OWNED BY public.publication_song.id;


--
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
-- Name: publication_version; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.publication_version (
    id bigint DEFAULT nextval('public.publication_version_seq'::regclass) NOT NULL,
    publication_id bigint,
    date_created timestamp without time zone DEFAULT now(),
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
-- Name: review_comment; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.review_comment (
    id bigint DEFAULT nextval('public.review_comment_seq'::regclass) NOT NULL,
    publication_id bigint,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    comment text,
    "user" text,
    legacy_id text,
    review_comment_id bigint
);


ALTER TABLE public.review_comment OWNER TO root;

--
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
    source text,
    name_translation_id bigint
);


ALTER TABLE public.tag OWNER TO root;

--
-- Name: translation; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.translation (
    id bigint NOT NULL,
    neutral_text text,
    finonto integer,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    deleted smallint DEFAULT '0'::smallint
);


ALTER TABLE public.translation OWNER TO root;

--
-- Name: translation_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.translation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.translation_id_seq OWNER TO root;

--
-- Name: translation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.translation_id_seq OWNED BY public.translation.id;


--
-- Name: translation_text; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.translation_text (
    id bigint NOT NULL,
    translation_id bigint,
    language character varying(10),
    text text,
    field_name character varying(200) DEFAULT 'NULL::character varying'::character varying,
    table_name character varying(200) DEFAULT NULL::character varying,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    deleted smallint DEFAULT '0'::smallint
);


ALTER TABLE public.translation_text OWNER TO root;

--
-- Name: translation_text_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.translation_text_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.translation_text_id_seq OWNER TO root;

--
-- Name: translation_text_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.translation_text_id_seq OWNED BY public.translation_text.id;


--
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
-- Name: urn_lookup; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.urn_lookup (
    id bigint DEFAULT nextval('public.urn_lookup_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT now(),
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
-- Name: work_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.work_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_seq OWNER TO root;

--
-- Name: work; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.work (
    id bigint DEFAULT nextval('public.work_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    title text,
    description text,
    source text,
    work_collection_id bigint,
    legacy_id text
);


ALTER TABLE public.work OWNER TO root;

--
-- Name: work_collection_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.work_collection_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_collection_seq OWNER TO root;

--
-- Name: work_collection; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.work_collection (
    id bigint DEFAULT nextval('public.work_collection_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    title text,
    description text,
    source text
);


ALTER TABLE public.work_collection OWNER TO root;

--
-- Name: work_manuscript_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.work_manuscript_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_manuscript_seq OWNER TO root;

--
-- Name: work_manuscript; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.work_manuscript (
    id bigint DEFAULT nextval('public.work_manuscript_seq'::regclass) NOT NULL,
    date_created timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone,
    deleted smallint DEFAULT 0,
    title text,
    referenced_as text,
    description text,
    source text
);


ALTER TABLE public.work_manuscript OWNER TO root;

--
-- Name: media id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.media ALTER COLUMN id SET DEFAULT nextval('public.media_reference_seq'::regclass);


--
-- Name: media_collection id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.media_collection ALTER COLUMN id SET DEFAULT nextval('public.media_collection_reference_seq'::regclass);


--
-- Name: publication_song id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_song ALTER COLUMN id SET DEFAULT nextval('public.publication_song_id_seq'::regclass);


--
-- Name: translation id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.translation ALTER COLUMN id SET DEFAULT nextval('public.translation_id_seq'::regclass);


--
-- Name: translation_text id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.translation_text ALTER COLUMN id SET DEFAULT nextval('public.translation_text_id_seq'::regclass);

--
-- Name: publication_collection_introduction PRIMARY; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_collection_introduction
    ADD CONSTRAINT "PRIMARY" PRIMARY KEY (id);


--
-- Name: publication_collection_title PRIMARY1; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_collection_title
    ADD CONSTRAINT "PRIMARY1" PRIMARY KEY (id);


--
-- Name: event PRIMARY10; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT "PRIMARY10" PRIMARY KEY (id);


--
-- Name: location PRIMARY11; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.location
    ADD CONSTRAINT "PRIMARY11" PRIMARY KEY (id);


--
-- Name: subject PRIMARY12; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.subject
    ADD CONSTRAINT "PRIMARY12" PRIMARY KEY (id);


--
-- Name: tag PRIMARY13; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT "PRIMARY13" PRIMARY KEY (id);


--
-- Name: event_connection PRIMARY14; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_connection
    ADD CONSTRAINT "PRIMARY14" PRIMARY KEY (id);


--
-- Name: publication_facsimile_collection PRIMARY15; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_facsimile_collection
    ADD CONSTRAINT "PRIMARY15" PRIMARY KEY (id);


--
-- Name: publication_facsimile PRIMARY16; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_facsimile
    ADD CONSTRAINT "PRIMARY16" PRIMARY KEY (id);


--
-- Name: event_occurrence PRIMARY17; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_occurrence
    ADD CONSTRAINT "PRIMARY17" PRIMARY KEY (id);


--
-- Name: event_relation PRIMARY18; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_relation
    ADD CONSTRAINT "PRIMARY18" PRIMARY KEY (id);


--
-- Name: publication_facsimile_zone PRIMARY19; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_facsimile_zone
    ADD CONSTRAINT "PRIMARY19" PRIMARY KEY (id);


--
-- Name: project PRIMARY2; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT "PRIMARY2" PRIMARY KEY (id);


--
-- Name: review_comment PRIMARY20; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.review_comment
    ADD CONSTRAINT "PRIMARY20" PRIMARY KEY (id);


--
-- Name: urn_lookup PRIMARY21; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.urn_lookup
    ADD CONSTRAINT "PRIMARY21" PRIMARY KEY (id);


--
-- Name: publication_collection PRIMARY3; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_collection
    ADD CONSTRAINT "PRIMARY3" PRIMARY KEY (id);


--
-- Name: publication PRIMARY4; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication
    ADD CONSTRAINT "PRIMARY4" PRIMARY KEY (id);


--
-- Name: publication_version PRIMARY5; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_version
    ADD CONSTRAINT "PRIMARY5" PRIMARY KEY (id);


--
-- Name: publication_comment PRIMARY6; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_comment
    ADD CONSTRAINT "PRIMARY6" PRIMARY KEY (id);


--
-- Name: publication_group PRIMARY7; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_group
    ADD CONSTRAINT "PRIMARY7" PRIMARY KEY (id);


--
-- Name: publication_manuscript PRIMARY8; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_manuscript
    ADD CONSTRAINT "PRIMARY8" PRIMARY KEY (id);


--
-- Name: contributor PRIMARY9; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.contributor
    ADD CONSTRAINT "PRIMARY9" PRIMARY KEY (id);


--
-- Name: work_manifestation PRIMARY_MANIFESTATION; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.work_manifestation
    ADD CONSTRAINT "PRIMARY_MANIFESTATION" PRIMARY KEY (id);


--
-- Name: work_manuscript PRIMARY_MANUSCRIPT; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.work_manuscript
    ADD CONSTRAINT "PRIMARY_MANUSCRIPT" PRIMARY KEY (id);


--
-- Name: work PRIMARY_WORK; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.work
    ADD CONSTRAINT "PRIMARY_WORK" PRIMARY KEY (id);


--
-- Name: work_collection PRIMARY_WORK_COLLECTION; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.work_collection
    ADD CONSTRAINT "PRIMARY_WORK_COLLECTION" PRIMARY KEY (id);


--
-- Name: work_reference PRIMARY_WORK_REFERENCE; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.work_reference
    ADD CONSTRAINT "PRIMARY_WORK_REFERENCE" PRIMARY KEY (id);


--
-- Name: correspondence PRIMARY_correspondence; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.correspondence
    ADD CONSTRAINT "PRIMARY_correspondence" PRIMARY KEY (id);


--
-- Name: correspondence_collection PRIMARY_correspondence_COLLECTION; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.correspondence_collection
    ADD CONSTRAINT "PRIMARY_correspondence_COLLECTION" PRIMARY KEY (id);


--
-- Name: media_connection id; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.media_connection
    ADD CONSTRAINT id PRIMARY KEY (id);


--
-- Name: media_collection media_collection_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.media_collection
    ADD CONSTRAINT media_collection_pkey PRIMARY KEY (id);


--
-- Name: media media_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.media
    ADD CONSTRAINT media_pkey PRIMARY KEY (id);


--
-- Name: publication_song publication_song_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_song
    ADD CONSTRAINT publication_song_pkey PRIMARY KEY (id);


--
-- Name: translation translation_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.translation
    ADD CONSTRAINT translation_pkey PRIMARY KEY (id);


--
-- Name: translation_text translation_text_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.translation_text
    ADD CONSTRAINT translation_text_pkey PRIMARY KEY (id);


--
-- Name: contributor_deleted_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX contributor_deleted_idx ON public.contributor USING btree (deleted);


--
-- Name: correspondence_collection_deleted_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX correspondence_collection_deleted_idx ON public.correspondence_collection USING btree (deleted);


--
-- Name: correspondence_deleted_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX correspondence_deleted_idx ON public.correspondence USING btree (deleted);


--
-- Name: event_connection_deleted_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX event_connection_deleted_idx ON public.event_connection USING btree (deleted);


--
-- Name: event_deleted_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX event_deleted_idx ON public.event USING btree (deleted);


--
-- Name: event_occurrence_deleted_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX event_occurrence_deleted_idx ON public.event_occurrence USING btree (deleted);


--
-- Name: event_relation_deleted_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX event_relation_deleted_idx ON public.event_relation USING btree (deleted);


--
-- Name: facs_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX facs_id ON public.publication_facsimile USING btree (publication_facsimile_collection_id);


--
-- Name: fk_contributor_publication_collection_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_contributor_publication_collection_id_idx ON public.contributor USING btree (publication_collection_id);


--
-- Name: fk_contributor_publication_collection_introduction_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_contributor_publication_collection_introduction_id_idx ON public.contributor USING btree (publication_collection_introduction_id);


--
-- Name: fk_contributor_publication_collection_title_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_contributor_publication_collection_title_id_idx ON public.contributor USING btree (publication_collection_title_id);


--
-- Name: fk_contributor_publication_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_contributor_publication_id_idx ON public.contributor USING btree (publication_id);


--
-- Name: fk_contributor_publication_manuscript_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_contributor_publication_manuscript_id_idx ON public.contributor USING btree (publication_manuscript_id);


--
-- Name: fk_contributor_publication_version_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_contributor_publication_version_id_idx ON public.contributor USING btree (publication_version_id);


--
-- Name: fk_correspondence_correspondence_collection_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_correspondence_correspondence_collection_id_idx ON public.correspondence USING btree (correspondence_collection_id);


--
-- Name: fk_correspondence_project_id_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_correspondence_project_id_id_idx ON public.correspondence USING btree (project_id);


--
-- Name: fk_event_connection_correspondence_id; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_event_connection_correspondence_id ON public.event_connection USING btree (correspondence_id);


--
-- Name: fk_event_connection_event_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_event_connection_event_id_idx ON public.event_connection USING btree (event_id);


--
-- Name: fk_event_connection_location_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_event_connection_location_id_idx ON public.event_connection USING btree (location_id);


--
-- Name: fk_event_connection_subject_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_event_connection_subject_id_idx ON public.event_connection USING btree (subject_id);


--
-- Name: fk_event_connection_tag_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_event_connection_tag_id_idx ON public.event_connection USING btree (tag_id);


--
-- Name: fk_event_connection_work_manifestation_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_event_connection_work_manifestation_id_idx ON public.event_connection USING btree (work_manifestation_id);


--
-- Name: fk_event_occurrence_event_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_event_occurrence_event_id_idx ON public.event_occurrence USING btree (event_id);


--
-- Name: fk_event_occurrence_publication_comment_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_event_occurrence_publication_comment_id_idx ON public.event_occurrence USING btree (publication_comment_id);


--
-- Name: fk_event_occurrence_publication_facsimile_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_event_occurrence_publication_facsimile_id_idx ON public.event_occurrence USING btree (publication_facsimile_id);


--
-- Name: fk_event_occurrence_publication_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_event_occurrence_publication_id_idx ON public.event_occurrence USING btree (publication_id);


--
-- Name: fk_event_occurrence_publication_manuscript_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_event_occurrence_publication_manuscript_id_idx ON public.event_occurrence USING btree (publication_manuscript_id);


--
-- Name: fk_event_occurrence_publication_version_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_event_occurrence_publication_version_id_idx ON public.event_occurrence USING btree (publication_version_id);


--
-- Name: fk_event_relation_event_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_event_relation_event_id_idx ON public.event_relation USING btree (event_id);


--
-- Name: fk_location_project_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_location_project_id_idx ON public.location USING btree (project_id);


--
-- Name: fk_manifestation_manuscript_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_manifestation_manuscript_id_idx ON public.work_manifestation USING btree (work_manuscript_id);


--
-- Name: fk_manifestation_work_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_manifestation_work_id_idx ON public.work_manifestation USING btree (work_id);


--
-- Name: fk_publication_collection_project_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_publication_collection_project_id_idx ON public.publication_collection USING btree (project_id);


--
-- Name: fk_publication_collection_publication_collection_intro_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_publication_collection_publication_collection_intro_id_idx ON public.publication_collection USING btree (publication_collection_introduction_id);


--
-- Name: fk_publication_collection_publication_collection_title_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_publication_collection_publication_collection_title_id_idx ON public.publication_collection USING btree (publication_collection_title_id);


--
-- Name: fk_publication_facsimile_publication_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_publication_facsimile_publication_id_idx ON public.publication_facsimile USING btree (publication_id);


--
-- Name: fk_publication_facsimile_publication_manuscript_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_publication_facsimile_publication_manuscript_id_idx ON public.publication_facsimile USING btree (publication_manuscript_id);


--
-- Name: fk_publication_facsimile_publication_version_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_publication_facsimile_publication_version_id_idx ON public.publication_facsimile USING btree (publication_version_id);


--
-- Name: fk_publication_facsimile_zone_publication_facsimile_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_publication_facsimile_zone_publication_facsimile_id_idx ON public.publication_facsimile_zone USING btree (publication_facsimile_id);


--
-- Name: fk_publication_manuscript_publication_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_publication_manuscript_publication_id_idx ON public.publication_manuscript USING btree (publication_id);


--
-- Name: fk_publication_publication_collection_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_publication_publication_collection_id_idx ON public.publication USING btree (publication_collection_id);


--
-- Name: fk_publication_publication_comment_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_publication_publication_comment_id_idx ON public.publication USING btree (publication_comment_id);


--
-- Name: fk_publication_publication_group_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_publication_publication_group_id_idx ON public.publication USING btree (publication_group_id);


--
-- Name: fk_publication_version_publication_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_publication_version_publication_id_idx ON public.publication_version USING btree (publication_id);


--
-- Name: fk_review_comment_publication_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_review_comment_publication_id_idx ON public.review_comment USING btree (publication_id);


--
-- Name: fk_review_comment_review_comment_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_review_comment_review_comment_id_idx ON public.review_comment USING btree (review_comment_id);


--
-- Name: fk_subject_project_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_subject_project_id_idx ON public.subject USING btree (project_id);


--
-- Name: fk_tag_project_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_tag_project_id_idx ON public.tag USING btree (project_id);


--
-- Name: fk_urn_project_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_urn_project_id_idx ON public.urn_lookup USING btree (project_id);


--
-- Name: fk_work_reference_manifestation_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_work_reference_manifestation_id_idx ON public.work_reference USING btree (work_manifestation_id);


--
-- Name: fk_work_reference_project_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_work_reference_project_id_idx ON public.work_reference USING btree (project_id);


--
-- Name: fk_work_work_collection_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX fk_work_work_collection_id_idx ON public.work USING btree (work_collection_id);


--
-- Name: location_deleted_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX location_deleted_idx ON public.location USING btree (deleted);


--
-- Name: manifestation_deleted_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX manifestation_deleted_idx ON public.work_manifestation USING btree (deleted);


--
-- Name: manuscript_deleted_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX manuscript_deleted_idx ON public.work_manuscript USING btree (deleted);


--
-- Name: subject_deleted_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX subject_deleted_idx ON public.subject USING btree (deleted);


--
-- Name: tag_deleted_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX tag_deleted_idx ON public.tag USING btree (deleted);


--
-- Name: work_collection_deleted_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX work_collection_deleted_idx ON public.work_collection USING btree (deleted);


--
-- Name: work_deleted_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX work_deleted_idx ON public.work USING btree (deleted);


--
-- Name: work_reference_deleted_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX work_reference_deleted_idx ON public.work_reference USING btree (deleted);


--
-- Name: publication check_original_publication_date; Type: TRIGGER; Schema: public; Owner: root
--

CREATE TRIGGER check_original_publication_date BEFORE INSERT OR UPDATE ON public.publication FOR EACH ROW EXECUTE PROCEDURE public.check_original_publication_date();


--
-- Name: subject check_subject_date_born; Type: TRIGGER; Schema: public; Owner: root
--

CREATE TRIGGER check_subject_date_born BEFORE INSERT OR UPDATE ON public.subject FOR EACH ROW EXECUTE PROCEDURE public.check_subject_date_born();


--
-- Name: subject check_subject_date_deceased; Type: TRIGGER; Schema: public; Owner: root
--

CREATE TRIGGER check_subject_date_deceased BEFORE INSERT OR UPDATE ON public.subject FOR EACH ROW EXECUTE PROCEDURE public.check_subject_date_deceased();


--
-- Name: contributor fk_contributor_publication_collection_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.contributor
    ADD CONSTRAINT fk_contributor_publication_collection_id FOREIGN KEY (publication_collection_id) REFERENCES public.publication_collection(id);


--
-- Name: contributor fk_contributor_publication_collection_introduction_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.contributor
    ADD CONSTRAINT fk_contributor_publication_collection_introduction_id FOREIGN KEY (publication_collection_introduction_id) REFERENCES public.publication_collection_introduction(id);


--
-- Name: contributor fk_contributor_publication_collection_title_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.contributor
    ADD CONSTRAINT fk_contributor_publication_collection_title_id FOREIGN KEY (publication_collection_title_id) REFERENCES public.publication_collection_title(id);


--
-- Name: contributor fk_contributor_publication_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.contributor
    ADD CONSTRAINT fk_contributor_publication_id FOREIGN KEY (publication_id) REFERENCES public.publication(id);


--
-- Name: contributor fk_contributor_publication_manuscript_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.contributor
    ADD CONSTRAINT fk_contributor_publication_manuscript_id FOREIGN KEY (publication_manuscript_id) REFERENCES public.publication_manuscript(id);


--
-- Name: contributor fk_contributor_publication_version_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.contributor
    ADD CONSTRAINT fk_contributor_publication_version_id FOREIGN KEY (publication_version_id) REFERENCES public.publication_version(id);


--
-- Name: correspondence fk_correspondence_correspondence_collection_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.correspondence
    ADD CONSTRAINT fk_correspondence_correspondence_collection_id FOREIGN KEY (correspondence_collection_id) REFERENCES public.correspondence_collection(id);


--
-- Name: correspondence fk_correspondence_project_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.correspondence
    ADD CONSTRAINT fk_correspondence_project_id FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- Name: event_connection fk_event_connection_correspondence_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_connection
    ADD CONSTRAINT fk_event_connection_correspondence_id FOREIGN KEY (correspondence_id) REFERENCES public.correspondence(id) NOT VALID;


--
-- Name: event_connection fk_event_connection_event_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_connection
    ADD CONSTRAINT fk_event_connection_event_id FOREIGN KEY (event_id) REFERENCES public.event(id);


--
-- Name: event_connection fk_event_connection_location_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_connection
    ADD CONSTRAINT fk_event_connection_location_id FOREIGN KEY (location_id) REFERENCES public.location(id);


--
-- Name: event_connection fk_event_connection_subject_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_connection
    ADD CONSTRAINT fk_event_connection_subject_id FOREIGN KEY (subject_id) REFERENCES public.subject(id);


--
-- Name: event_connection fk_event_connection_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_connection
    ADD CONSTRAINT fk_event_connection_tag_id FOREIGN KEY (tag_id) REFERENCES public.tag(id);


--
-- Name: event_connection fk_event_connection_work_manifestation_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_connection
    ADD CONSTRAINT fk_event_connection_work_manifestation_id FOREIGN KEY (work_manifestation_id) REFERENCES public.work_manifestation(id);


--
-- Name: event_occurrence fk_event_occurrence_event_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_occurrence
    ADD CONSTRAINT fk_event_occurrence_event_id FOREIGN KEY (event_id) REFERENCES public.event(id);


--
-- Name: event_occurrence fk_event_occurrence_publication_comment_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_occurrence
    ADD CONSTRAINT fk_event_occurrence_publication_comment_id FOREIGN KEY (publication_comment_id) REFERENCES public.publication_comment(id);


--
-- Name: event_occurrence fk_event_occurrence_publication_facsimile_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_occurrence
    ADD CONSTRAINT fk_event_occurrence_publication_facsimile_id FOREIGN KEY (publication_facsimile_id) REFERENCES public.publication_facsimile(id);


--
-- Name: event_occurrence fk_event_occurrence_publication_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_occurrence
    ADD CONSTRAINT fk_event_occurrence_publication_id FOREIGN KEY (publication_id) REFERENCES public.publication(id);


--
-- Name: event_occurrence fk_event_occurrence_publication_manuscript_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_occurrence
    ADD CONSTRAINT fk_event_occurrence_publication_manuscript_id FOREIGN KEY (publication_manuscript_id) REFERENCES public.publication_manuscript(id);


--
-- Name: event_occurrence fk_event_occurrence_publication_song_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_occurrence
    ADD CONSTRAINT fk_event_occurrence_publication_song_id FOREIGN KEY (publication_song_id) REFERENCES public.publication_song(id);


--
-- Name: event_occurrence fk_event_occurrence_publication_version_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_occurrence
    ADD CONSTRAINT fk_event_occurrence_publication_version_id FOREIGN KEY (publication_version_id) REFERENCES public.publication_version(id);


--
-- Name: event_occurrence fk_event_occurrence_work_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_occurrence
    ADD CONSTRAINT fk_event_occurrence_work_id FOREIGN KEY (work_id) REFERENCES public.work(id) NOT VALID;


--
-- Name: event_relation fk_event_relation_event_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.event_relation
    ADD CONSTRAINT fk_event_relation_event_id FOREIGN KEY (event_id) REFERENCES public.event(id);


--
-- Name: location fk_location_project_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.location
    ADD CONSTRAINT fk_location_project_id FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- Name: work_manifestation fk_manifestation_manuscript_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.work_manifestation
    ADD CONSTRAINT fk_manifestation_manuscript_id FOREIGN KEY (work_manuscript_id) REFERENCES public.work_manuscript(id);


--
-- Name: work_manifestation fk_manifestation_work_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.work_manifestation
    ADD CONSTRAINT fk_manifestation_work_id FOREIGN KEY (work_id) REFERENCES public.work(id);


--
-- Name: publication_collection fk_publication_collection_project_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_collection
    ADD CONSTRAINT fk_publication_collection_project_id FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- Name: publication_collection fk_publication_collection_publication_collection_intro_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_collection
    ADD CONSTRAINT fk_publication_collection_publication_collection_intro_id FOREIGN KEY (publication_collection_introduction_id) REFERENCES public.publication_collection_introduction(id);


--
-- Name: publication_collection fk_publication_collection_publication_collection_title_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_collection
    ADD CONSTRAINT fk_publication_collection_publication_collection_title_id FOREIGN KEY (publication_collection_title_id) REFERENCES public.publication_collection_title(id);


--
-- Name: publication_facsimile fk_publication_facsimile_publication_facsimile_collection_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_facsimile
    ADD CONSTRAINT fk_publication_facsimile_publication_facsimile_collection_id FOREIGN KEY (publication_facsimile_collection_id) REFERENCES public.publication_facsimile_collection(id);


--
-- Name: publication_facsimile fk_publication_facsimile_publication_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_facsimile
    ADD CONSTRAINT fk_publication_facsimile_publication_id FOREIGN KEY (publication_id) REFERENCES public.publication(id);


--
-- Name: publication_facsimile fk_publication_facsimile_publication_manuscript_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_facsimile
    ADD CONSTRAINT fk_publication_facsimile_publication_manuscript_id FOREIGN KEY (publication_manuscript_id) REFERENCES public.publication_manuscript(id);


--
-- Name: publication_facsimile fk_publication_facsimile_publication_version_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_facsimile
    ADD CONSTRAINT fk_publication_facsimile_publication_version_id FOREIGN KEY (publication_version_id) REFERENCES public.publication_version(id);


--
-- Name: publication_facsimile_zone fk_publication_facsimile_zone_publication_facsimile_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_facsimile_zone
    ADD CONSTRAINT fk_publication_facsimile_zone_publication_facsimile_id FOREIGN KEY (publication_facsimile_id) REFERENCES public.publication_facsimile(id);


--
-- Name: publication_manuscript fk_publication_manuscript_publication_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_manuscript
    ADD CONSTRAINT fk_publication_manuscript_publication_id FOREIGN KEY (publication_id) REFERENCES public.publication(id);


--
-- Name: publication fk_publication_publication_collection_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication
    ADD CONSTRAINT fk_publication_publication_collection_id FOREIGN KEY (publication_collection_id) REFERENCES public.publication_collection(id);


--
-- Name: publication fk_publication_publication_comment_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication
    ADD CONSTRAINT fk_publication_publication_comment_id FOREIGN KEY (publication_comment_id) REFERENCES public.publication_comment(id);


--
-- Name: publication fk_publication_publication_group_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication
    ADD CONSTRAINT fk_publication_publication_group_id FOREIGN KEY (publication_group_id) REFERENCES public.publication_group(id);


--
-- Name: publication_song fk_publication_song_publication_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_song
    ADD CONSTRAINT fk_publication_song_publication_id FOREIGN KEY (publication_id) REFERENCES public.publication(id);


--
-- Name: publication_version fk_publication_version_publication_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.publication_version
    ADD CONSTRAINT fk_publication_version_publication_id FOREIGN KEY (publication_id) REFERENCES public.publication(id);


--
-- Name: review_comment fk_review_comment_publication_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.review_comment
    ADD CONSTRAINT fk_review_comment_publication_id FOREIGN KEY (publication_id) REFERENCES public.publication(id);


--
-- Name: review_comment fk_review_comment_review_comment_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.review_comment
    ADD CONSTRAINT fk_review_comment_review_comment_id FOREIGN KEY (review_comment_id) REFERENCES public.review_comment(id);


--
-- Name: subject fk_subject_project_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.subject
    ADD CONSTRAINT fk_subject_project_id FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- Name: tag fk_tag_project_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT fk_tag_project_id FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- Name: urn_lookup fk_urn_project_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.urn_lookup
    ADD CONSTRAINT fk_urn_project_id FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- Name: work_reference fk_work_reference_project_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.work_reference
    ADD CONSTRAINT fk_work_reference_project_id FOREIGN KEY (project_id) REFERENCES public.project(id);


--
-- Name: work_reference fk_work_reference_work_manifestation_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.work_reference
    ADD CONSTRAINT fk_work_reference_work_manifestation_id FOREIGN KEY (work_manifestation_id) REFERENCES public.work_manifestation(id);


--
-- Name: work fk_work_work_collection_id; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.work
    ADD CONSTRAINT fk_work_work_collection_id FOREIGN KEY (work_collection_id) REFERENCES public.work_collection(id);


--
-- Name: media_connection media_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.media_connection
    ADD CONSTRAINT media_id_fk FOREIGN KEY (media_id) REFERENCES public.media(id);
