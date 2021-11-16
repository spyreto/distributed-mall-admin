--
-- PostgreSQL database dump
--

-- Dumped from database version 10.14 (Ubuntu 10.14-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.14 (Ubuntu 10.14-0ubuntu0.18.04.1)

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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO spirosdim;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: spirosdim
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO spirosdim;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: spirosdim
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO spirosdim;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: spirosdim
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO spirosdim;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: spirosdim
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO spirosdim;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: spirosdim
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO spirosdim;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: spirosdim
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: authtoken_token; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.authtoken_token (
    key character varying(40) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.authtoken_token OWNER TO spirosdim;

--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO spirosdim;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: spirosdim
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO spirosdim;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: spirosdim
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO spirosdim;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: spirosdim
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO spirosdim;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: spirosdim
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO spirosdim;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: spirosdim
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO spirosdim;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: spirosdim
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO spirosdim;

--
-- Name: main_bag; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.main_bag (
    product_ptr_id integer NOT NULL,
    type character varying(15) NOT NULL,
    color character varying(15) NOT NULL,
    material character varying(15) NOT NULL
);


ALTER TABLE public.main_bag OWNER TO spirosdim;

--
-- Name: main_clothingproduct; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.main_clothingproduct (
    product_ptr_id integer NOT NULL,
    size integer NOT NULL,
    color character varying(15) NOT NULL,
    material character varying(15) NOT NULL
);


ALTER TABLE public.main_clothingproduct OWNER TO spirosdim;

--
-- Name: main_company; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.main_company (
    id integer NOT NULL,
    description text NOT NULL,
    name character varying(50) NOT NULL,
    slug character varying(48) NOT NULL,
    category_id integer,
    owner_id integer NOT NULL
);


ALTER TABLE public.main_company OWNER TO spirosdim;

--
-- Name: main_company_id_seq; Type: SEQUENCE; Schema: public; Owner: spirosdim
--

CREATE SEQUENCE public.main_company_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_company_id_seq OWNER TO spirosdim;

--
-- Name: main_company_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: spirosdim
--

ALTER SEQUENCE public.main_company_id_seq OWNED BY public.main_company.id;


--
-- Name: main_companycategory; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.main_companycategory (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    slug character varying(48) NOT NULL,
    lft integer NOT NULL,
    rght integer NOT NULL,
    tree_id integer NOT NULL,
    level integer NOT NULL,
    parent_id integer,
    CONSTRAINT main_companycategory_level_check CHECK ((level >= 0)),
    CONSTRAINT main_companycategory_lft_check CHECK ((lft >= 0)),
    CONSTRAINT main_companycategory_rght_check CHECK ((rght >= 0)),
    CONSTRAINT main_companycategory_tree_id_check CHECK ((tree_id >= 0))
);


ALTER TABLE public.main_companycategory OWNER TO spirosdim;

--
-- Name: main_companycategory_id_seq; Type: SEQUENCE; Schema: public; Owner: spirosdim
--

CREATE SEQUENCE public.main_companycategory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_companycategory_id_seq OWNER TO spirosdim;

--
-- Name: main_companycategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: spirosdim
--

ALTER SEQUENCE public.main_companycategory_id_seq OWNED BY public.main_companycategory.id;


--
-- Name: main_companylocation; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.main_companylocation (
    location_ptr_id integer NOT NULL,
    company_id integer NOT NULL
);


ALTER TABLE public.main_companylocation OWNER TO spirosdim;

--
-- Name: main_customer; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.main_customer (
    birth_date date,
    user_id integer NOT NULL,
    gender integer NOT NULL,
    phone_number character varying(128) NOT NULL,
    orange_points integer NOT NULL,
    device_id character varying(50) NOT NULL
);


ALTER TABLE public.main_customer OWNER TO spirosdim;

--
-- Name: main_customerlocation; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.main_customerlocation (
    location_ptr_id integer NOT NULL,
    customer_id integer NOT NULL
);


ALTER TABLE public.main_customerlocation OWNER TO spirosdim;

--
-- Name: main_favorite; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.main_favorite (
    id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    customer_id integer NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE public.main_favorite OWNER TO spirosdim;

--
-- Name: main_favorite_id_seq; Type: SEQUENCE; Schema: public; Owner: spirosdim
--

CREATE SEQUENCE public.main_favorite_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_favorite_id_seq OWNER TO spirosdim;

--
-- Name: main_favorite_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: spirosdim
--

ALTER SEQUENCE public.main_favorite_id_seq OWNED BY public.main_favorite.id;


--
-- Name: main_footwearproduct; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.main_footwearproduct (
    product_ptr_id integer NOT NULL,
    size character varying(15) NOT NULL,
    color character varying(15) NOT NULL,
    material character varying(15) NOT NULL
);


ALTER TABLE public.main_footwearproduct OWNER TO spirosdim;

--
-- Name: main_location; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.main_location (
    id integer NOT NULL,
    address character varying(200) NOT NULL,
    slug character varying(48) NOT NULL,
    geolocation character varying(100) NOT NULL
);


ALTER TABLE public.main_location OWNER TO spirosdim;

--
-- Name: main_location_id_seq; Type: SEQUENCE; Schema: public; Owner: spirosdim
--

CREATE SEQUENCE public.main_location_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_location_id_seq OWNER TO spirosdim;

--
-- Name: main_location_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: spirosdim
--

ALTER SEQUENCE public.main_location_id_seq OWNED BY public.main_location.id;


--
-- Name: main_manufacturer; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.main_manufacturer (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    slug character varying(64) NOT NULL
);


ALTER TABLE public.main_manufacturer OWNER TO spirosdim;

--
-- Name: main_manufacturer_id_seq; Type: SEQUENCE; Schema: public; Owner: spirosdim
--

CREATE SEQUENCE public.main_manufacturer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_manufacturer_id_seq OWNER TO spirosdim;

--
-- Name: main_manufacturer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: spirosdim
--

ALTER SEQUENCE public.main_manufacturer_id_seq OWNED BY public.main_manufacturer.id;


--
-- Name: main_offer; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.main_offer (
    id integer NOT NULL,
    is_open boolean NOT NULL,
    has_expired boolean NOT NULL,
    number_of_customers integer NOT NULL,
    start_date date,
    end_date date,
    discount_rate numeric(4,1) NOT NULL,
    discount_price numeric(8,2) NOT NULL,
    company_id integer NOT NULL,
    offer_id integer,
    product_id integer NOT NULL,
    CONSTRAINT main_offer_number_of_customers_check CHECK ((number_of_customers >= 0))
);


ALTER TABLE public.main_offer OWNER TO spirosdim;

--
-- Name: main_offer_id_seq; Type: SEQUENCE; Schema: public; Owner: spirosdim
--

CREATE SEQUENCE public.main_offer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_offer_id_seq OWNER TO spirosdim;

--
-- Name: main_offer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: spirosdim
--

ALTER SEQUENCE public.main_offer_id_seq OWNED BY public.main_offer.id;


--
-- Name: main_product; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.main_product (
    id integer NOT NULL,
    structure character varying(10) NOT NULL,
    name character varying(64) NOT NULL,
    slug character varying(64) NOT NULL,
    active boolean NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    description text NOT NULL,
    category_id integer,
    manufacturer_id integer,
    parent_id integer
);


ALTER TABLE public.main_product OWNER TO spirosdim;

--
-- Name: main_product_id_seq; Type: SEQUENCE; Schema: public; Owner: spirosdim
--

CREATE SEQUENCE public.main_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_product_id_seq OWNER TO spirosdim;

--
-- Name: main_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: spirosdim
--

ALTER SEQUENCE public.main_product_id_seq OWNED BY public.main_product.id;


--
-- Name: main_productcategory; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.main_productcategory (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    slug character varying(48) NOT NULL,
    type integer NOT NULL,
    lft integer NOT NULL,
    rght integer NOT NULL,
    tree_id integer NOT NULL,
    level integer NOT NULL,
    parent_id integer,
    CONSTRAINT main_productcategory_level_check CHECK ((level >= 0)),
    CONSTRAINT main_productcategory_lft_check CHECK ((lft >= 0)),
    CONSTRAINT main_productcategory_rght_check CHECK ((rght >= 0)),
    CONSTRAINT main_productcategory_tree_id_check CHECK ((tree_id >= 0))
);


ALTER TABLE public.main_productcategory OWNER TO spirosdim;

--
-- Name: main_productcategory_id_seq; Type: SEQUENCE; Schema: public; Owner: spirosdim
--

CREATE SEQUENCE public.main_productcategory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_productcategory_id_seq OWNER TO spirosdim;

--
-- Name: main_productcategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: spirosdim
--

ALTER SEQUENCE public.main_productcategory_id_seq OWNED BY public.main_productcategory.id;


--
-- Name: main_productimage; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.main_productimage (
    id integer NOT NULL,
    image character varying(100) NOT NULL,
    thumbnail character varying(100),
    product_id integer NOT NULL
);


ALTER TABLE public.main_productimage OWNER TO spirosdim;

--
-- Name: main_productimage_id_seq; Type: SEQUENCE; Schema: public; Owner: spirosdim
--

CREATE SEQUENCE public.main_productimage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_productimage_id_seq OWNER TO spirosdim;

--
-- Name: main_productimage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: spirosdim
--

ALTER SEQUENCE public.main_productimage_id_seq OWNED BY public.main_productimage.id;


--
-- Name: main_sale; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.main_sale (
    id integer NOT NULL,
    quantity integer NOT NULL,
    selling_price numeric(6,2) NOT NULL,
    status integer NOT NULL,
    paid_with_money boolean NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    date_added timestamp with time zone NOT NULL,
    company_id integer NOT NULL,
    product_id integer NOT NULL,
    customer_id integer NOT NULL,
    CONSTRAINT main_sale_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE public.main_sale OWNER TO spirosdim;

--
-- Name: main_sale_id_seq; Type: SEQUENCE; Schema: public; Owner: spirosdim
--

CREATE SEQUENCE public.main_sale_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_sale_id_seq OWNER TO spirosdim;

--
-- Name: main_sale_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: spirosdim
--

ALTER SEQUENCE public.main_sale_id_seq OWNED BY public.main_sale.id;


--
-- Name: main_salesproduct; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.main_salesproduct (
    id integer NOT NULL,
    price numeric(8,2) NOT NULL,
    quantity integer NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    company_id integer NOT NULL,
    product_id integer NOT NULL,
    CONSTRAINT main_salesproduct_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE public.main_salesproduct OWNER TO spirosdim;

--
-- Name: main_salesproduct_id_seq; Type: SEQUENCE; Schema: public; Owner: spirosdim
--

CREATE SEQUENCE public.main_salesproduct_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_salesproduct_id_seq OWNER TO spirosdim;

--
-- Name: main_salesproduct_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: spirosdim
--

ALTER SEQUENCE public.main_salesproduct_id_seq OWNED BY public.main_salesproduct.id;


--
-- Name: main_seller; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.main_seller (
    user_id integer NOT NULL
);


ALTER TABLE public.main_seller OWNER TO spirosdim;

--
-- Name: main_user; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.main_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    email character varying(254) NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    is_seller boolean NOT NULL,
    is_customer boolean NOT NULL
);


ALTER TABLE public.main_user OWNER TO spirosdim;

--
-- Name: main_user_groups; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.main_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.main_user_groups OWNER TO spirosdim;

--
-- Name: main_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: spirosdim
--

CREATE SEQUENCE public.main_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_user_groups_id_seq OWNER TO spirosdim;

--
-- Name: main_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: spirosdim
--

ALTER SEQUENCE public.main_user_groups_id_seq OWNED BY public.main_user_groups.id;


--
-- Name: main_user_id_seq; Type: SEQUENCE; Schema: public; Owner: spirosdim
--

CREATE SEQUENCE public.main_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_user_id_seq OWNER TO spirosdim;

--
-- Name: main_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: spirosdim
--

ALTER SEQUENCE public.main_user_id_seq OWNED BY public.main_user.id;


--
-- Name: main_user_user_permissions; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.main_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.main_user_user_permissions OWNER TO spirosdim;

--
-- Name: main_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: spirosdim
--

CREATE SEQUENCE public.main_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_user_user_permissions_id_seq OWNER TO spirosdim;

--
-- Name: main_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: spirosdim
--

ALTER SEQUENCE public.main_user_user_permissions_id_seq OWNED BY public.main_user_user_permissions.id;


--
-- Name: main_wallet; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.main_wallet (
    product_ptr_id integer NOT NULL,
    type character varying(15) NOT NULL,
    type_of_closing character varying(15) NOT NULL,
    color character varying(15) NOT NULL,
    material character varying(15) NOT NULL
);


ALTER TABLE public.main_wallet OWNER TO spirosdim;

--
-- Name: main_watch; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.main_watch (
    product_ptr_id integer NOT NULL,
    display character varying(15) NOT NULL,
    mechanism character varying(15) NOT NULL,
    band_material character varying(15) NOT NULL,
    band_color character varying(15) NOT NULL,
    face_color character varying(15) NOT NULL,
    water_resistance integer NOT NULL
);


ALTER TABLE public.main_watch OWNER TO spirosdim;

--
-- Name: taggit_tag; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.taggit_tag (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(100) NOT NULL
);


ALTER TABLE public.taggit_tag OWNER TO spirosdim;

--
-- Name: taggit_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: spirosdim
--

CREATE SEQUENCE public.taggit_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taggit_tag_id_seq OWNER TO spirosdim;

--
-- Name: taggit_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: spirosdim
--

ALTER SEQUENCE public.taggit_tag_id_seq OWNED BY public.taggit_tag.id;


--
-- Name: taggit_taggeditem; Type: TABLE; Schema: public; Owner: spirosdim
--

CREATE TABLE public.taggit_taggeditem (
    id integer NOT NULL,
    object_id integer NOT NULL,
    content_type_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.taggit_taggeditem OWNER TO spirosdim;

--
-- Name: taggit_taggeditem_id_seq; Type: SEQUENCE; Schema: public; Owner: spirosdim
--

CREATE SEQUENCE public.taggit_taggeditem_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taggit_taggeditem_id_seq OWNER TO spirosdim;

--
-- Name: taggit_taggeditem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: spirosdim
--

ALTER SEQUENCE public.taggit_taggeditem_id_seq OWNED BY public.taggit_taggeditem.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: main_company id; Type: DEFAULT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_company ALTER COLUMN id SET DEFAULT nextval('public.main_company_id_seq'::regclass);


--
-- Name: main_companycategory id; Type: DEFAULT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_companycategory ALTER COLUMN id SET DEFAULT nextval('public.main_companycategory_id_seq'::regclass);


--
-- Name: main_favorite id; Type: DEFAULT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_favorite ALTER COLUMN id SET DEFAULT nextval('public.main_favorite_id_seq'::regclass);


--
-- Name: main_location id; Type: DEFAULT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_location ALTER COLUMN id SET DEFAULT nextval('public.main_location_id_seq'::regclass);


--
-- Name: main_manufacturer id; Type: DEFAULT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_manufacturer ALTER COLUMN id SET DEFAULT nextval('public.main_manufacturer_id_seq'::regclass);


--
-- Name: main_offer id; Type: DEFAULT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_offer ALTER COLUMN id SET DEFAULT nextval('public.main_offer_id_seq'::regclass);


--
-- Name: main_product id; Type: DEFAULT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_product ALTER COLUMN id SET DEFAULT nextval('public.main_product_id_seq'::regclass);


--
-- Name: main_productcategory id; Type: DEFAULT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_productcategory ALTER COLUMN id SET DEFAULT nextval('public.main_productcategory_id_seq'::regclass);


--
-- Name: main_productimage id; Type: DEFAULT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_productimage ALTER COLUMN id SET DEFAULT nextval('public.main_productimage_id_seq'::regclass);


--
-- Name: main_sale id; Type: DEFAULT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_sale ALTER COLUMN id SET DEFAULT nextval('public.main_sale_id_seq'::regclass);


--
-- Name: main_salesproduct id; Type: DEFAULT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_salesproduct ALTER COLUMN id SET DEFAULT nextval('public.main_salesproduct_id_seq'::regclass);


--
-- Name: main_user id; Type: DEFAULT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_user ALTER COLUMN id SET DEFAULT nextval('public.main_user_id_seq'::regclass);


--
-- Name: main_user_groups id; Type: DEFAULT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_user_groups ALTER COLUMN id SET DEFAULT nextval('public.main_user_groups_id_seq'::regclass);


--
-- Name: main_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.main_user_user_permissions_id_seq'::regclass);


--
-- Name: taggit_tag id; Type: DEFAULT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.taggit_tag ALTER COLUMN id SET DEFAULT nextval('public.taggit_tag_id_seq'::regclass);


--
-- Name: taggit_taggeditem id; Type: DEFAULT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.taggit_taggeditem ALTER COLUMN id SET DEFAULT nextval('public.taggit_taggeditem_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add Token	6	add_token
22	Can change Token	6	change_token
23	Can delete Token	6	delete_token
24	Can view Token	6	view_token
25	Can add Tag	7	add_tag
26	Can change Tag	7	change_tag
27	Can delete Tag	7	delete_tag
28	Can view Tag	7	view_tag
29	Can add Tagged Item	8	add_taggeditem
30	Can change Tagged Item	8	change_taggeditem
31	Can delete Tagged Item	8	delete_taggeditem
32	Can view Tagged Item	8	view_taggeditem
33	Can add user	9	add_user
34	Can change user	9	change_user
35	Can delete user	9	delete_user
36	Can view user	9	view_user
37	Can add company	10	add_company
38	Can change company	10	change_company
39	Can delete company	10	delete_company
40	Can view company	10	view_company
41	Can add location	11	add_location
42	Can change location	11	change_location
43	Can delete location	11	delete_location
44	Can view location	11	view_location
45	Can add manufacturer	12	add_manufacturer
46	Can change manufacturer	12	change_manufacturer
47	Can delete manufacturer	12	delete_manufacturer
48	Can view manufacturer	12	view_manufacturer
49	Can add product	13	add_product
50	Can change product	13	change_product
51	Can delete product	13	delete_product
52	Can view product	13	view_product
53	Can add bag	14	add_bag
54	Can change bag	14	change_bag
55	Can delete bag	14	delete_bag
56	Can view bag	14	view_bag
57	Can add clothing product	15	add_clothingproduct
58	Can change clothing product	15	change_clothingproduct
59	Can delete clothing product	15	delete_clothingproduct
60	Can view clothing product	15	view_clothingproduct
61	Can add customer	16	add_customer
62	Can change customer	16	change_customer
63	Can delete customer	16	delete_customer
64	Can view customer	16	view_customer
65	Can add footwear product	17	add_footwearproduct
66	Can change footwear product	17	change_footwearproduct
67	Can delete footwear product	17	delete_footwearproduct
68	Can view footwear product	17	view_footwearproduct
69	Can add seller	18	add_seller
70	Can change seller	18	change_seller
71	Can delete seller	18	delete_seller
72	Can view seller	18	view_seller
73	Can add wallet	19	add_wallet
74	Can change wallet	19	change_wallet
75	Can delete wallet	19	delete_wallet
76	Can view wallet	19	view_wallet
77	Can add watch	20	add_watch
78	Can change watch	20	change_watch
79	Can delete watch	20	delete_watch
80	Can view watch	20	view_watch
81	Can add sales product	21	add_salesproduct
82	Can change sales product	21	change_salesproduct
83	Can delete sales product	21	delete_salesproduct
84	Can view sales product	21	view_salesproduct
85	Can add product image	22	add_productimage
86	Can change product image	22	change_productimage
87	Can delete product image	22	delete_productimage
88	Can view product image	22	view_productimage
89	Can add product category	23	add_productcategory
90	Can change product category	23	change_productcategory
91	Can delete product category	23	delete_productcategory
92	Can view product category	23	view_productcategory
93	Can add offer	24	add_offer
94	Can change offer	24	change_offer
95	Can delete offer	24	delete_offer
96	Can view offer	24	view_offer
97	Can add company category	25	add_companycategory
98	Can change company category	25	change_companycategory
99	Can delete company category	25	delete_companycategory
100	Can view company category	25	view_companycategory
101	Can add sale	26	add_sale
102	Can change sale	26	change_sale
103	Can delete sale	26	delete_sale
104	Can view sale	26	view_sale
105	Can add customer location	27	add_customerlocation
106	Can change customer location	27	change_customerlocation
107	Can delete customer location	27	delete_customerlocation
108	Can view customer location	27	view_customerlocation
109	Can add company location	28	add_companylocation
110	Can change company location	28	change_companylocation
111	Can delete company location	28	delete_companylocation
112	Can view company location	28	view_companylocation
113	Can add favorite	29	add_favorite
114	Can change favorite	29	change_favorite
115	Can delete favorite	29	delete_favorite
116	Can view favorite	29	view_favorite
\.


--
-- Data for Name: authtoken_token; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.authtoken_token (key, created, user_id) FROM stdin;
c493e17c760e8e4be7e0b08e8a8f36b0f1977156	2020-07-16 07:50:28.816753+00	1
3182025133f470be96f708a5ae5e135c8c1a272d	2020-07-16 08:01:17.965309+00	2
8a1ea003a132d081b3d4d27c60b17c536c869e34	2020-07-16 08:09:43.65364+00	3
c4c4d49e48062ce525f2a84c0f7365b073bca0f9	2020-07-16 08:25:53.658332+00	4
4f81e1e63f948049354b6768a66794cb89a9a289	2020-07-16 08:25:53.669785+00	5
446fe4b78ee2a20c274da625687f16ff9c394da6	2020-07-16 08:25:53.681763+00	6
b587db925ba8b46aa2998ea80baac87ba2b7e123	2020-07-16 08:25:53.694176+00	7
545eb129ba5201321964aef9acb04df34c03dcee	2020-07-16 08:25:53.706289+00	8
28cfd271f7e3e88f50a4b3fba7798c0b3cf1c282	2020-07-16 08:25:53.718261+00	9
e9d3fa276a7f0819ab6eb92e15720818799aaa4d	2020-07-16 08:25:53.729661+00	10
7140a5fb62aeb455c66f320d19d03e759a865ae6	2020-07-16 08:32:48.762806+00	11
ec27dce41b02b41d791aaecef72c18bbcd125d8f	2020-07-26 07:06:55.135846+00	12
9b7c91d5b4037e20087aa6d2c28c5185ac5b70d8	2020-09-15 21:51:11.875057+00	68
828bbc217625c3cbd11fb6f92a62bb5f303a72ba	2020-09-15 22:40:23.900083+00	69
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2020-07-16 08:09:43.654581+00	3	kostasgri@gmail.com	1	[{"added": {}}]	9	1
2	2020-07-16 08:10:29.113833+00	3	kostasgri@gmail.com	2	[{"changed": {"fields": ["first_name", "last_name", "is_customer", "last_login"]}}]	9	1
3	2020-07-16 08:10:48.368781+00	3	kostasgri@gmail.com	1	[{"added": {}}]	18	1
4	2020-07-16 08:10:51.713508+00	3	kostasgri@gmail.com	2	[]	18	1
5	2020-07-16 08:11:06.015948+00	3	kostasgri@gmail.com	3		18	1
6	2020-07-16 08:13:27.723643+00	3	kostasgri@gmail.com	1	[{"added": {}}]	16	1
7	2020-07-16 09:20:30.416234+00	2	maria@gmail.com	1	[{"added": {}}]	18	1
8	2020-07-16 09:20:41.206099+00	2	maria@gmail.com	3		18	1
9	2020-07-16 09:22:25.251486+00	1	Sale object (1)	1	[{"added": {}}]	26	1
10	2020-07-16 09:23:18.013868+00	2	Sale object (2)	1	[{"added": {}}]	26	1
11	2020-07-16 09:24:11.946185+00	3	Sale object (3)	1	[{"added": {}}]	26	1
12	2020-07-16 09:25:07.697081+00	4	Sale object (4)	1	[{"added": {}}]	26	1
13	2020-07-16 09:26:18.161235+00	5	Sale object (5)	1	[{"added": {}}]	26	1
14	2020-07-16 09:30:43.426076+00	6	Sale object (6)	1	[{"added": {}}]	26	1
15	2020-07-16 14:50:03.28087+00	7	Sale object (7)	1	[{"added": {}}]	26	1
16	2020-07-26 09:15:49.279155+00	2	maria@gmail.com	2	[{"changed": {"fields": ["password"]}}]	9	1
17	2020-08-12 20:09:20.652054+00	13	Sale object (13)	2	[{"changed": {"fields": ["status"]}}]	26	1
18	2020-08-12 20:11:05.902667+00	14	Sale object (14)	2	[{"changed": {"fields": ["status"]}}]	26	1
19	2020-08-12 20:21:47.262086+00	19	Sale object (19)	2	[{"changed": {"fields": ["status"]}}]	26	1
20	2020-08-12 20:23:32.259184+00	20	Sale object (20)	2	[{"changed": {"fields": ["status"]}}]	26	1
21	2020-08-12 20:39:25.782749+00	21	Sale object (21)	2	[{"changed": {"fields": ["status"]}}]	26	1
22	2020-08-12 20:39:25.794877+00	20	Sale object (20)	2	[{"changed": {"fields": ["status"]}}]	26	1
23	2020-08-12 20:39:25.805914+00	19	Sale object (19)	2	[{"changed": {"fields": ["status"]}}]	26	1
24	2020-08-15 08:05:06.823434+00	24	Sale object (24)	2	[{"changed": {"fields": ["status"]}}]	26	1
25	2020-08-15 08:05:40.983751+00	23	Sale object (23)	2	[{"changed": {"fields": ["status"]}}]	26	1
26	2020-08-15 08:06:24.868111+00	25	Sale object (25)	2	[{"changed": {"fields": ["status"]}}]	26	1
27	2020-08-15 08:16:05.779347+00	29	Sale object (29)	2	[{"changed": {"fields": ["status"]}}]	26	1
28	2020-08-15 08:16:05.79011+00	28	Sale object (28)	2	[{"changed": {"fields": ["status"]}}]	26	1
29	2020-08-15 08:16:14.248784+00	27	Sale object (27)	2	[{"changed": {"fields": ["status"]}}]	26	1
30	2020-08-15 08:16:14.259856+00	26	Sale object (26)	2	[{"changed": {"fields": ["status"]}}]	26	1
31	2020-08-15 08:16:40.840243+00	2	maria@gmail.com	2	[{"changed": {"fields": ["orange_points"]}}]	16	1
32	2020-08-15 08:17:02.992821+00	30	Sale object (30)	2	[{"changed": {"fields": ["status"]}}]	26	1
33	2020-08-15 08:21:31.151917+00	2	maria@gmail.com	2	[{"changed": {"fields": ["orange_points"]}}]	16	1
34	2020-08-15 08:22:30.102764+00	34	Sale object (34)	2	[{"changed": {"fields": ["status"]}}]	26	1
35	2020-08-15 08:23:15.402174+00	33	Sale object (33)	2	[{"changed": {"fields": ["status"]}}]	26	1
36	2020-08-16 07:07:24.852606+00	2	Πολύκαστρο, Ελλάδα	2	[{"changed": {"fields": ["address", "slug", "geolocation"]}}]	28	1
37	2020-08-16 07:08:09.526586+00	1	Λαχανά 12, Πολύκαστρο, Ελλάδα	2	[{"changed": {"fields": ["address", "slug", "geolocation"]}}]	28	1
38	2020-08-17 19:41:02.006409+00	1	Ολυμπιάδος 5, Εύοσμος, Ελλάδα	2	[{"changed": {"fields": ["address", "geolocation"]}}]	28	1
39	2020-08-17 19:42:04.907512+00	2	Καραολή και Δημητρίου 22, Εύοσμος, Ελλάδα	2	[{"changed": {"fields": ["address", "geolocation"]}}]	28	1
40	2020-08-23 13:58:05.839826+00	12	Sale object (12)	3		26	1
41	2020-08-23 13:58:05.844585+00	11	Sale object (11)	3		26	1
42	2020-08-23 18:11:00.713133+00	2	maria@gmail.com	2	[{"changed": {"fields": ["orange_points"]}}]	16	1
43	2020-08-29 17:52:26.870163+00	2	maria@gmail.gg	2	[{"changed": {"fields": ["birth_date"]}}]	16	1
44	2020-08-31 14:31:26.1091+00	2	maria@gmail.com	2	[{"changed": {"fields": ["birth_date"]}}]	16	1
45	2020-09-05 20:44:30.002143+00	14	skatoylis@gmail.com	3		9	1
46	2020-09-05 20:46:10.25015+00	15		3		9	1
47	2020-09-05 20:47:34.641602+00	16	skatoylis@gmail.com	3		9	1
48	2020-09-05 20:50:06.799525+00	17	skatoylis@gmail.com	3		9	1
49	2020-09-06 07:28:53.907745+00	18	skatoylis@gmail.com	3		9	1
50	2020-09-06 11:24:59.610349+00	19	spiros@gmail.gr	3		9	1
51	2020-09-06 11:24:59.615568+00	20	spiros@gmail.com	3		9	1
52	2020-09-06 11:24:59.618409+00	21	spiros@gmail.gf	3		9	1
53	2020-09-06 11:24:59.620915+00	22	spiros@gmail.gl	3		9	1
54	2020-09-06 11:24:59.623277+00	23	spiros@gmail.gp	3		9	1
55	2020-09-06 11:24:59.62615+00	24	spiros@gmail.kk	3		9	1
56	2020-09-06 11:24:59.628859+00	25	spiros@gmail.pp	3		9	1
57	2020-09-06 11:34:33.458049+00	27	skatoylis@gmail.com	3		9	1
58	2020-09-06 11:34:33.462989+00	28	skatoylis@gmail.cg	3		9	1
59	2020-09-06 11:35:13.614973+00	29	skatoylis@gmail.cg	3		9	1
60	2020-09-06 11:36:16.488003+00	30	skatoylis@gmail.cg	3		9	1
61	2020-09-06 11:37:04.392022+00	31	skatoylis@gmail.cg	3		9	1
62	2020-09-06 11:37:31.761261+00	32	skatoylis@gmail.cg	3		9	1
63	2020-09-06 11:48:17.264396+00	33	skatoylis@gmail.cg	3		9	1
64	2020-09-06 11:49:08.853931+00	34	skatoylis@gmail.cg	3		9	1
65	2020-09-06 12:09:42.40812+00	35	skatoylis@gmail.cg	3		9	1
66	2020-09-06 12:09:58.996595+00	26	spiros@gmail.gr	3		9	1
67	2020-09-06 12:09:58.999393+00	36	spiros@gmail.gl	3		9	1
68	2020-09-06 12:09:59.002442+00	37	spiros@gmail.glp	3		9	1
69	2020-09-06 12:09:59.00452+00	38	spiros@gmail.mj	3		9	1
70	2020-09-06 12:09:59.006372+00	39	spiros@gmail.mk	3		9	1
71	2020-09-06 12:19:05.015439+00	40	spiros@gmail.gr	3		9	1
72	2020-09-06 12:19:05.021094+00	42	spiros@gmail.ll	3		9	1
73	2020-09-06 12:21:42.02015+00	43	spiros@gmail.gr	3		9	1
74	2020-09-06 12:21:42.0254+00	44	spiros@gmail.grm	3		9	1
75	2020-09-06 12:21:42.027743+00	45	spiros@gmail.gj	3		9	1
76	2020-09-06 12:24:45.264634+00	46	spiros@gmail.gr	3		9	1
77	2020-09-06 12:24:45.268014+00	47	spiros@gmail.grl	3		9	1
78	2020-09-06 12:24:45.270374+00	48	spiros@gmail.grj	3		9	1
79	2020-09-06 12:24:45.272438+00	49	spiros@gmail.lo	3		9	1
80	2020-09-06 12:40:20.080396+00	50	spiros@gmail.gk	3		9	1
81	2020-09-06 12:40:20.086117+00	51	spiros@gmail.mn	3		9	1
82	2020-09-06 12:40:20.088666+00	52	spiros@gmail.ko	3		9	1
83	2020-09-06 12:40:20.091012+00	53	spiros@gmail.nn	3		9	1
84	2020-09-06 12:40:20.093097+00	54	spiros@gmail.pp	3		9	1
85	2020-09-06 12:43:24.64754+00	55	spiros@gmail.gr	2	[{"changed": {"fields": ["password"]}}]	9	1
86	2020-09-06 12:59:44.191937+00	55	spiros@gmail.gr	3		9	1
87	2020-09-06 12:59:44.195618+00	56	spiros@gmail.com	3		9	1
88	2020-09-06 13:11:59.699203+00	57	spiros@gmail.gr	3		9	1
89	2020-09-06 13:11:59.70426+00	59	spiros@gmail.hh	3		9	1
90	2020-09-06 13:11:59.706328+00	60	spiros@gmail.yy	3		9	1
91	2020-09-06 13:11:59.708778+00	61	spiros@gmail.oo	3		9	1
92	2020-09-06 16:23:10.826324+00	1	Favorite object (1)	1	[{"added": {}}]	29	1
93	2020-09-06 16:23:26.761893+00	2	Favorite object (2)	1	[{"added": {}}]	29	1
94	2020-09-06 16:23:39.686599+00	3	Favorite object (3)	1	[{"added": {}}]	29	1
95	2020-09-06 16:23:57.973818+00	58	maria@gmail.ll	3		9	1
96	2020-09-06 16:24:12.282477+00	63	spiros@gmail.hh	3		9	1
97	2020-09-06 16:24:12.287636+00	64	spiros@gmail.gq	3		9	1
98	2020-09-06 16:46:50.769152+00	2	maria@gmail.com	2	[{"changed": {"fields": ["password"]}}]	9	1
99	2020-09-06 16:47:20.714872+00	2	maria@gmail.com	2	[{"changed": {"fields": ["password"]}}]	9	1
100	2020-09-06 16:48:56.744097+00	2	maria@gmail.com	2	[{"changed": {"fields": ["password"]}}]	9	1
101	2020-09-06 17:54:39.31841+00	41	Sale object (41)	3		26	1
102	2020-09-06 17:54:39.323865+00	40	Sale object (40)	3		26	1
103	2020-09-06 17:54:39.326264+00	39	Sale object (39)	3		26	1
104	2020-09-06 17:54:39.328606+00	38	Sale object (38)	3		26	1
105	2020-09-06 17:54:39.331195+00	37	Sale object (37)	3		26	1
106	2020-09-06 17:54:39.33418+00	36	Sale object (36)	3		26	1
107	2020-09-06 17:54:39.337144+00	35	Sale object (35)	3		26	1
108	2020-09-06 17:54:39.339699+00	32	Sale object (32)	3		26	1
109	2020-09-06 17:54:39.342108+00	31	Sale object (31)	3		26	1
110	2020-09-06 17:54:39.344658+00	22	Sale object (22)	3		26	1
111	2020-09-06 17:54:39.347041+00	20	Sale object (20)	3		26	1
112	2020-09-06 17:54:39.34964+00	19	Sale object (19)	3		26	1
113	2020-09-07 19:55:53.81947+00	17	Sale object (17)	3		26	1
114	2020-09-07 19:55:53.826579+00	16	Sale object (16)	3		26	1
115	2020-09-07 19:55:53.829095+00	15	Sale object (15)	3		26	1
116	2020-09-08 20:39:40.808697+00	4	Favorite object (4)	1	[{"added": {}}]	29	1
117	2020-09-08 20:40:11.048511+00	5	Favorite object (5)	1	[{"added": {}}]	29	1
118	2020-09-08 20:40:41.392434+00	6	Favorite object (6)	1	[{"added": {}}]	29	1
119	2020-09-09 16:36:55.832846+00	7	Favorite object (7)	1	[{"added": {}}]	29	1
120	2020-09-09 16:36:58.758613+00	7	Favorite object (7)	2	[]	29	1
121	2020-09-09 16:37:07.475212+00	8	Favorite object (8)	1	[{"added": {}}]	29	1
122	2020-09-09 16:37:39.587017+00	9	Favorite object (9)	1	[{"added": {}}]	29	1
123	2020-09-09 16:37:48.337318+00	10	Favorite object (10)	1	[{"added": {}}]	29	1
124	2020-09-09 16:37:57.016541+00	11	Favorite object (11)	1	[{"added": {}}]	29	1
125	2020-09-09 16:42:10.482757+00	12	Favorite object (12)	1	[{"added": {}}]	29	1
126	2020-09-09 16:42:15.600177+00	13	Favorite object (13)	1	[{"added": {}}]	29	1
127	2020-09-09 16:42:20.377572+00	14	Favorite object (14)	1	[{"added": {}}]	29	1
128	2020-09-09 16:42:25.429382+00	15	Favorite object (15)	1	[{"added": {}}]	29	1
129	2020-09-09 16:42:30.076516+00	16	Favorite object (16)	1	[{"added": {}}]	29	1
130	2020-09-09 16:42:35.020841+00	17	Favorite object (17)	1	[{"added": {}}]	29	1
131	2020-09-09 16:42:39.219659+00	18	Favorite object (18)	1	[{"added": {}}]	29	1
132	2020-09-12 22:26:48.553507+00	65	G@gmail.gr	3		9	1
133	2020-09-12 22:34:50.971758+00	66	g@mail.gr	3		9	1
134	2020-09-12 22:35:12.563444+00	13	ddjjmu128@gmail.com	3		9	1
135	2020-09-12 22:35:12.566866+00	41	skatoylis@gmail.cg	3		9	1
136	2020-09-12 22:35:12.569509+00	62	spiros@gmail.gj	3		9	1
137	2020-09-12 22:35:12.571807+00	67	h@mail.gr	3		9	1
138	2020-09-13 11:03:26.721296+00	69	Sale object (69)	3		26	1
139	2020-09-13 11:03:26.727395+00	68	Sale object (68)	3		26	1
140	2020-09-13 11:03:26.730245+00	67	Sale object (67)	3		26	1
141	2020-09-13 11:03:26.732999+00	66	Sale object (66)	3		26	1
142	2020-09-13 11:03:26.735956+00	65	Sale object (65)	3		26	1
143	2020-09-13 11:03:26.738648+00	64	Sale object (64)	3		26	1
144	2020-09-13 11:03:26.741258+00	63	Sale object (63)	3		26	1
145	2020-09-13 11:03:26.743754+00	62	Sale object (62)	3		26	1
146	2020-09-13 11:03:26.746155+00	61	Sale object (61)	3		26	1
147	2020-09-13 11:03:26.748834+00	60	Sale object (60)	3		26	1
148	2020-09-13 11:03:26.751522+00	59	Sale object (59)	3		26	1
149	2020-09-13 11:03:26.753974+00	58	Sale object (58)	3		26	1
150	2020-09-13 11:03:26.756458+00	57	Sale object (57)	3		26	1
151	2020-09-13 11:03:26.758491+00	56	Sale object (56)	3		26	1
152	2020-09-13 11:03:26.76053+00	55	Sale object (55)	3		26	1
153	2020-09-13 11:03:26.763104+00	54	Sale object (54)	3		26	1
154	2020-09-13 11:03:26.765822+00	53	Sale object (53)	3		26	1
155	2020-09-13 11:03:26.768494+00	52	Sale object (52)	3		26	1
156	2020-09-13 11:03:26.771238+00	51	Sale object (51)	3		26	1
157	2020-09-13 11:03:26.773813+00	50	Sale object (50)	3		26	1
158	2020-09-13 11:03:26.776113+00	49	Sale object (49)	3		26	1
159	2020-09-13 11:03:26.778368+00	48	Sale object (48)	3		26	1
160	2020-09-13 11:03:26.780932+00	47	Sale object (47)	3		26	1
161	2020-09-13 11:03:26.783661+00	46	Sale object (46)	3		26	1
162	2020-09-13 11:03:26.786397+00	45	Sale object (45)	3		26	1
163	2020-09-13 11:03:26.789144+00	44	Sale object (44)	3		26	1
164	2020-09-13 11:03:26.791765+00	43	Sale object (43)	3		26	1
165	2020-09-13 11:03:26.794499+00	42	Sale object (42)	3		26	1
166	2020-09-13 11:03:26.797111+00	18	Sale object (18)	3		26	1
167	2020-09-13 11:05:54.757888+00	30	Sale object (30)	3		26	1
168	2020-09-13 11:05:54.763657+00	29	Sale object (29)	3		26	1
169	2020-09-13 11:05:54.766177+00	28	Sale object (28)	3		26	1
170	2020-09-13 11:05:54.768729+00	27	Sale object (27)	3		26	1
171	2020-09-13 11:05:54.771512+00	26	Sale object (26)	3		26	1
172	2020-09-13 11:05:54.773845+00	25	Sale object (25)	3		26	1
173	2020-09-13 11:05:54.776078+00	24	Sale object (24)	3		26	1
174	2020-09-13 11:05:54.778585+00	23	Sale object (23)	3		26	1
175	2020-09-13 11:05:54.781369+00	21	Sale object (21)	3		26	1
176	2020-09-13 13:03:30.004238+00	90	Sale object (90)	2	[{"changed": {"fields": ["status"]}}]	26	1
177	2020-09-13 13:03:30.01777+00	89	Sale object (89)	2	[{"changed": {"fields": ["status"]}}]	26	1
178	2020-09-15 21:42:52.911016+00	1	Black & White offers Ugg Australia Classic Mini II 1016222 Black for 16.7%	2	[{"changed": {"fields": ["end_date"]}}]	24	1
179	2020-09-15 21:43:04.261484+00	2	Black & White offers Ugg Australia Classic Mini Logo 1108231 Grey for 18.8%	2	[{"changed": {"fields": ["end_date"]}}]	24	1
180	2020-09-15 21:43:16.010064+00	1	Black & White offers Ugg Australia Classic Mini II 1016222 Black for 16.7%	2	[{"changed": {"fields": ["is_open", "has_expired"]}}]	24	1
181	2020-09-15 22:30:36.073695+00	96	Sale object (96)	3		26	1
182	2020-09-15 22:30:36.079236+00	95	Sale object (95)	3		26	1
183	2020-09-15 22:30:36.08384+00	94	Sale object (94)	3		26	1
184	2020-09-15 22:30:36.088758+00	93	Sale object (93)	3		26	1
185	2020-09-15 22:30:36.093405+00	90	Sale object (90)	3		26	1
186	2020-09-15 22:30:36.098572+00	89	Sale object (89)	3		26	1
187	2020-09-15 22:30:36.103446+00	88	Sale object (88)	3		26	1
188	2020-09-15 22:30:36.107801+00	87	Sale object (87)	3		26	1
189	2020-09-15 22:30:36.11226+00	86	Sale object (86)	3		26	1
190	2020-09-15 22:30:36.116978+00	85	Sale object (85)	3		26	1
191	2020-09-15 22:30:36.121369+00	84	Sale object (84)	3		26	1
192	2020-09-15 22:30:57.23748+00	81	Sale object (81)	3		26	1
193	2020-09-15 22:30:57.24471+00	80	Sale object (80)	3		26	1
194	2020-09-15 22:30:57.253005+00	79	Sale object (79)	3		26	1
195	2020-09-15 22:30:57.257271+00	78	Sale object (78)	3		26	1
196	2020-09-15 22:30:57.261436+00	73	Sale object (73)	3		26	1
197	2020-09-15 22:30:57.265572+00	71	Sale object (71)	3		26	1
198	2020-09-15 22:31:17.854738+00	83	Sale object (83)	2	[{"changed": {"fields": ["customer", "status"]}}]	26	1
199	2020-09-15 22:31:27.412932+00	92	Sale object (92)	2	[{"changed": {"fields": ["status"]}}]	26	1
200	2020-09-15 22:31:47.37682+00	91	Sale object (91)	2	[{"changed": {"fields": ["customer", "status"]}}]	26	1
201	2020-09-15 22:31:59.779713+00	76	Sale object (76)	2	[{"changed": {"fields": ["customer", "status"]}}]	26	1
202	2020-09-15 22:32:14.150699+00	82	Sale object (82)	2	[{"changed": {"fields": ["customer", "status"]}}]	26	1
203	2020-09-15 22:32:41.117494+00	72	Sale object (72)	2	[{"changed": {"fields": ["customer", "status"]}}]	26	1
204	2020-09-15 22:32:54.929719+00	75	Sale object (75)	2	[{"changed": {"fields": ["customer", "status"]}}]	26	1
205	2020-09-15 22:33:12.703505+00	77	Sale object (77)	2	[{"changed": {"fields": ["status"]}}]	26	1
206	2020-09-15 22:33:12.725594+00	74	Sale object (74)	2	[{"changed": {"fields": ["status"]}}]	26	1
207	2020-09-15 22:33:12.74733+00	70	Sale object (70)	2	[{"changed": {"fields": ["status"]}}]	26	1
208	2020-09-15 22:33:12.767375+00	5	Sale object (5)	2	[{"changed": {"fields": ["status"]}}]	26	1
209	2020-09-15 22:33:12.789507+00	4	Sale object (4)	2	[{"changed": {"fields": ["status"]}}]	26	1
210	2020-09-15 22:33:31.571755+00	2	Black & White offers Ugg Australia Classic Mini Logo 1108231 Grey for 18.8%	3		24	1
211	2020-09-15 22:33:31.577148+00	1	Black & White offers Ugg Australia Classic Mini II 1016222 Black for 16.7%	3		24	1
212	2020-09-16 07:22:52.656737+00	101	Sale object (101)	1	[{"added": {}}]	26	1
213	2020-09-16 07:23:04.270131+00	92	Sale object (92)	2	[{"changed": {"fields": ["status"]}}]	26	1
214	2020-09-16 07:23:04.296614+00	91	Sale object (91)	2	[{"changed": {"fields": ["status"]}}]	26	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	authtoken	token
7	taggit	tag
8	taggit	taggeditem
9	main	user
10	main	company
11	main	location
12	main	manufacturer
13	main	product
14	main	bag
15	main	clothingproduct
16	main	customer
17	main	footwearproduct
18	main	seller
19	main	wallet
20	main	watch
21	main	salesproduct
22	main	productimage
23	main	productcategory
24	main	offer
25	main	companycategory
26	main	sale
27	main	customerlocation
28	main	companylocation
29	main	favorite
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2020-07-16 07:11:58.76051+00
2	taggit	0001_initial	2020-07-16 07:11:58.789504+00
3	taggit	0002_auto_20150616_2121	2020-07-16 07:11:58.825473+00
4	contenttypes	0002_remove_content_type_name	2020-07-16 07:11:58.843838+00
5	taggit	0003_taggeditem_add_unique_index	2020-07-16 07:11:58.85677+00
6	auth	0001_initial	2020-07-16 07:11:58.902491+00
7	auth	0002_alter_permission_name_max_length	2020-07-16 07:11:58.941923+00
8	auth	0003_alter_user_email_max_length	2020-07-16 07:11:58.951768+00
9	auth	0004_alter_user_username_opts	2020-07-16 07:11:58.962253+00
10	auth	0005_alter_user_last_login_null	2020-07-16 07:11:58.974366+00
11	auth	0006_require_contenttypes_0002	2020-07-16 07:11:58.978587+00
12	auth	0007_alter_validators_add_error_messages	2020-07-16 07:11:58.990092+00
13	auth	0008_alter_user_username_max_length	2020-07-16 07:11:59.000776+00
14	auth	0009_alter_user_last_name_max_length	2020-07-16 07:11:59.01098+00
15	auth	0010_alter_group_name_max_length	2020-07-16 07:11:59.020365+00
16	auth	0011_update_proxy_permissions	2020-07-16 07:11:59.03115+00
17	main	0001_initial	2020-07-16 07:11:59.50257+00
18	admin	0001_initial	2020-07-16 07:11:59.737228+00
19	admin	0002_logentry_remove_auto_add	2020-07-16 07:11:59.768488+00
20	admin	0003_logentry_add_action_flag_choices	2020-07-16 07:11:59.784371+00
21	authtoken	0001_initial	2020-07-16 07:11:59.825082+00
22	authtoken	0002_auto_20160226_1747	2020-07-16 07:11:59.905314+00
23	sessions	0001_initial	2020-07-16 07:11:59.92215+00
24	main	0002_auto_20200815_2059	2020-08-15 17:59:31.511902+00
25	main	0003_customer_device_id	2020-08-23 17:00:05.407597+00
26	main	0004_auto_20200906_1112	2020-09-06 08:12:23.059669+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
1aioe6mdnft2xqe2pix03jwcn0qlc0tm	MGQ3MGYwMTQ5MGQ0MjllOTNiYTcxNzg2Njc0NDBiNDI1MWVlYzljMDp7Il9hdXRoX3VzZXJfaWQiOiIxMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMjc1ZTFiYjllNDRiMTkwYTZhYzU4ODNkOWYyMTAzZTQyNzdmYzM5MSJ9	2020-07-30 14:50:14.749292+00
j5mkse4p7127oodymprdkdm4d172s2j8	MGQ3MGYwMTQ5MGQ0MjllOTNiYTcxNzg2Njc0NDBiNDI1MWVlYzljMDp7Il9hdXRoX3VzZXJfaWQiOiIxMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMjc1ZTFiYjllNDRiMTkwYTZhYzU4ODNkOWYyMTAzZTQyNzdmYzM5MSJ9	2020-08-02 08:19:35.426886+00
1z03fot06hkrrqnv1op0xdedve4alor7	YjM1ZTE4NjQzYzQ2ZmM0Yjc0YjgwNzEwZmNlMGJkMzZmYmVkYzg2ZDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYTlmZjcyYWNlMTliMDYxMTljNjY5ZDEzNjAzOGFlNTczNGY5Yjc0In0=	2020-08-09 09:15:49.299541+00
rbe93ta107ftlqyrry8ojneyqd6iyt50	YjM1ZTE4NjQzYzQ2ZmM0Yjc0YjgwNzEwZmNlMGJkMzZmYmVkYzg2ZDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYTlmZjcyYWNlMTliMDYxMTljNjY5ZDEzNjAzOGFlNTczNGY5Yjc0In0=	2020-08-26 20:09:11.224224+00
lufm2aewrox9uagizsxfikb1aqbqh7ph	YjM1ZTE4NjQzYzQ2ZmM0Yjc0YjgwNzEwZmNlMGJkMzZmYmVkYzg2ZDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYTlmZjcyYWNlMTliMDYxMTljNjY5ZDEzNjAzOGFlNTczNGY5Yjc0In0=	2020-08-30 07:06:46.983167+00
6p9fcj3nkr9svnobsyu6setj3f7xst73	YjM1ZTE4NjQzYzQ2ZmM0Yjc0YjgwNzEwZmNlMGJkMzZmYmVkYzg2ZDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYTlmZjcyYWNlMTliMDYxMTljNjY5ZDEzNjAzOGFlNTczNGY5Yjc0In0=	2020-08-31 19:39:10.776264+00
5vvis22zzdegqiqfujle2f44nj6cuoni	YjM1ZTE4NjQzYzQ2ZmM0Yjc0YjgwNzEwZmNlMGJkMzZmYmVkYzg2ZDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYTlmZjcyYWNlMTliMDYxMTljNjY5ZDEzNjAzOGFlNTczNGY5Yjc0In0=	2020-09-06 14:05:33.112589+00
w0deqrebzq7fwrlzs34olt4d0t5seca7	YjM1ZTE4NjQzYzQ2ZmM0Yjc0YjgwNzEwZmNlMGJkMzZmYmVkYzg2ZDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYTlmZjcyYWNlMTliMDYxMTljNjY5ZDEzNjAzOGFlNTczNGY5Yjc0In0=	2020-09-07 14:57:13.917049+00
vdnrqiwyvro4awrlr9a3r4lj0n6vpyc3	YjM1ZTE4NjQzYzQ2ZmM0Yjc0YjgwNzEwZmNlMGJkMzZmYmVkYzg2ZDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYTlmZjcyYWNlMTliMDYxMTljNjY5ZDEzNjAzOGFlNTczNGY5Yjc0In0=	2020-09-11 19:40:08.575406+00
z9v0pi02csweni9e2agh4k3jl4i6pgdt	YWQ4ODYxYzgwYWMxNDM3MzI1OTIyYzcxODJkNzYwNjcxNTU2NjMwNzp7Il9hdXRoX3VzZXJfaWQiOiIxMyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNGUwYjQxN2EzYTQzNWRjOGQwZjlhNGE0MzhkNGZkZTk3ODVjNzFkMCIsImNhdGVnb3J5X2lkIjozMn0=	2020-09-13 17:36:27.234092+00
up6y7bpr8kctf1eyh7t1f5k74nc7h1zc	YjM1ZTE4NjQzYzQ2ZmM0Yjc0YjgwNzEwZmNlMGJkMzZmYmVkYzg2ZDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzYTlmZjcyYWNlMTliMDYxMTljNjY5ZDEzNjAzOGFlNTczNGY5Yjc0In0=	2020-09-20 16:48:56.755492+00
\.


--
-- Data for Name: main_bag; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.main_bag (product_ptr_id, type, color, material) FROM stdin;
22	SHOULDER	black	LEATHER
23	CROSSBOY	yellow	LEATHER
24	TOTE	yellow	LEATHERETTE
25	BACKPACK	black	SYNTHETIC
\.


--
-- Data for Name: main_clothingproduct; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.main_clothingproduct (product_ptr_id, size, color, material) FROM stdin;
1	40	black	POLYESTER
2	40	red	POLYESTER
3	40	green	POLYESTER
4	40	purple	COTTON
5	40	green	COTTON
6	40	black	COTTON
7	40	white	COTTON
8	40	beige	WOOL
9	40	black	POLYESTER
10	40	brown	COTTON
12	40	white	POLYESTER
13	40	blue	COTTON
14	40	black	COTTON
11	40	black	POLYESTER
202	10	black	POLYESTER
203	20	black	POLYESTER
204	30	black	POLYESTER
205	40	black	POLYESTER
206	50	black	POLYESTER
207	60	black	POLYESTER
208	70	black	POLYESTER
209	10	white	POLYESTER
210	20	white	POLYESTER
211	30	white	POLYESTER
212	40	white	POLYESTER
213	50	white	POLYESTER
214	60	white	POLYESTER
215	70	white	POLYESTER
216	10	red	POLYESTER
217	20	red	POLYESTER
218	30	red	POLYESTER
219	40	red	POLYESTER
220	50	red	POLYESTER
221	60	red	POLYESTER
222	70	red	POLYESTER
223	10	green	POLYESTER
224	20	green	POLYESTER
225	30	green	POLYESTER
226	40	green	POLYESTER
227	50	green	POLYESTER
228	60	green	POLYESTER
229	70	green	POLYESTER
230	10	brown	COTTON
231	20	brown	COTTON
232	30	brown	COTTON
233	40	brown	COTTON
234	50	brown	COTTON
235	60	brown	COTTON
236	70	brown	COTTON
\.


--
-- Data for Name: main_company; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.main_company (id, description, name, slug, category_id, owner_id) FROM stdin;
1	Από το 1969 η Black & White έχει καταφέρει να ξεχωρίσει για τη state-of-art μόδα που προτείνει στη σύγχρονη γυναίκα. Tαυτισμένη με τη δημιουργικότητα, την καινοτομία και τις εμπνευσμένες σχεδιαστικές γραμμές αποτελεί must fashion item όχι μόνο για τον κόσμο του σήμερα αλλά κυρίως για αυτόν του αύριο.\r\n\r\nΓια το brand TSAKIRIS MALLAS τα υποδήματα δεν είναι απλά ένα χρηστικό προϊόν υψηλής αισθητικής. Είναι κάτι πολύ παραπάνω. Αποτελεί τη βάση ενός ερωτικού διαλόγου της γυναίκας με το σώμα της. Ενός διαλόγου μοναδικού όπου η αίσθηση που αντλείται από το υπόδημα έχει κυρίαρχη σημασία και καθορίζει κατά πολύ την αυτοεικόνα της. Έτσι τα υλικά κατασκευής παύουν να αποτελούν απλά στοιχεία σύνθεσης αλλά αντιμετωπίζονται ως σημεία επικοινωνίας με την γυναικεία ψυχοσύνθεση και ως τέτοια επιλέγονται με πολύ αυστηρά κριτήρια.	Black & White		3	11
2	centrifugus	Centrifugus		2	12
4	Κατάστημα αξεσουάρ μόδας.	Felix Culpa		1	68
\.


--
-- Data for Name: main_companycategory; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.main_companycategory (id, name, slug, lft, rght, tree_id, level, parent_id) FROM stdin;
1	Κατάστημα αξεσουάρ μόδας		1	2	1	0	\N
2	Κατάστημα ενδυμάτων		1	2	2	0	\N
3	Κατάστημα υποδημάτων		1	2	3	0	\N
\.


--
-- Data for Name: main_companylocation; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.main_companylocation (location_ptr_id, company_id) FROM stdin;
1	1
2	2
4	4
\.


--
-- Data for Name: main_customer; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.main_customer (birth_date, user_id, gender, phone_number, orange_points, device_id) FROM stdin;
1990-07-09	3	10	+306939872775	7499	0
1985-12-05	7	10	+306937416856	2500	0
1985-12-05	9	10	+306937416858	2300	0
1984-11-05	6	10	+306937416855	22450	0
1990-01-01	69	10	+306944455566	3000	goldfish_x86
1992-09-12	2	20	+306937416822	25860	0
1960-08-15	8	10	+306937416857	13500	0
1985-12-05	5	20	+306937416854	2800	0
1989-01-11	4	10	+306937416853	3370	0
1991-06-22	10	20	+306937416859	2960	0
\.


--
-- Data for Name: main_customerlocation; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.main_customerlocation (location_ptr_id, customer_id) FROM stdin;
\.


--
-- Data for Name: main_favorite; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.main_favorite (id, date_added, customer_id, product_id) FROM stdin;
72	2020-09-13 11:22:13.26192+00	2	17
\.


--
-- Data for Name: main_footwearproduct; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.main_footwearproduct (product_ptr_id, size, color, material) FROM stdin;
15		black	LEATHER
16		black	LEATHER
17		gray	LEATHER
18		brown	LEATHER
19		black	LEATHER
20		black	LEATHER
21		beige	LEATHER
38	17	black	LEATHER
39	17.5	black	LEATHER
40	18	black	LEATHER
41	18.5	black	LEATHER
42	19	black	LEATHER
43	19.5	black	LEATHER
44	20	black	LEATHER
45	20.5	black	LEATHER
46	21	black	LEATHER
47	21.5	black	LEATHER
48	22	black	LEATHER
49	22.5	black	LEATHER
50	23	black	LEATHER
51	23.5	black	LEATHER
52	24	black	LEATHER
53	24.5	black	LEATHER
54	25	black	LEATHER
55	25.5	black	LEATHER
56	26.5	black	LEATHER
57	26	black	LEATHER
58	27	black	LEATHER
59	27.5	black	LEATHER
60	28	black	LEATHER
61	28.5	black	LEATHER
62	29	black	LEATHER
63	29.5	black	LEATHER
64	30	black	LEATHER
65	30.5	black	LEATHER
66	31	black	LEATHER
67	31.5	black	LEATHER
68	32	black	LEATHER
69	32.5	black	LEATHER
70	33	black	LEATHER
71	33.5	black	LEATHER
72	34	black	LEATHER
73	34.5	black	LEATHER
74	35	black	LEATHER
75	35.5	black	LEATHER
76	36	black	LEATHER
77	36.5	black	LEATHER
78	37	black	LEATHER
79	37.5	black	LEATHER
80	38	black	LEATHER
81	38.5	black	LEATHER
82	39	black	LEATHER
83	39.5	black	LEATHER
84	40	black	LEATHER
85		brown	LEATHER
87	39	brown	LEATHER
88	39.5	brown	LEATHER
89	40	brown	LEATHER
90	40.5	brown	LEATHER
91	41	brown	LEATHER
92	41.5	brown	LEATHER
93	42	brown	LEATHER
94	42.5	brown	LEATHER
95	43	brown	LEATHER
96	43.5	brown	LEATHER
97	44	brown	LEATHER
98	44.5	brown	LEATHER
99	45	brown	LEATHER
100	45.5	brown	LEATHER
101	46	brown	LEATHER
102	46.5	brown	LEATHER
103	47	brown	LEATHER
104	47.5	brown	LEATHER
105	48	brown	LEATHER
106	48.5	brown	LEATHER
107	49	brown	LEATHER
108	17	black	LEATHER
109	17.5	black	LEATHER
110	18	black	LEATHER
111	18.5	black	LEATHER
112	19	black	LEATHER
113	19.5	black	LEATHER
114	20	black	LEATHER
115	20.5	black	LEATHER
116	21	black	LEATHER
117	21.5	black	LEATHER
118	22	black	LEATHER
119	22.5	black	LEATHER
120	23	black	LEATHER
121	23.5	black	LEATHER
122	24	black	LEATHER
123	24.5	black	LEATHER
124	25	black	LEATHER
125	25.5	black	LEATHER
126	26.5	black	LEATHER
127	26	black	LEATHER
128	27	black	LEATHER
129	27.5	black	LEATHER
130	28	black	LEATHER
131	28.5	black	LEATHER
132	29	black	LEATHER
133	29.5	black	LEATHER
134	30	black	LEATHER
135	30.5	black	LEATHER
136	31	black	LEATHER
137	31.5	black	LEATHER
138	32	black	LEATHER
139	32.5	black	LEATHER
140	33	black	LEATHER
141	33.5	black	LEATHER
142	34	black	LEATHER
143	34.5	black	LEATHER
144	35	black	LEATHER
145	35.5	black	LEATHER
146	36	black	LEATHER
147	36.5	black	LEATHER
148	37	black	LEATHER
149	37.5	black	LEATHER
150	38	black	LEATHER
151	38.5	black	LEATHER
152	39	black	LEATHER
153	39.5	black	LEATHER
154	40	black	LEATHER
155	17	gray	LEATHER
156	17.5	gray	LEATHER
157	18	gray	LEATHER
158	18.5	gray	LEATHER
159	19	gray	LEATHER
160	19.5	gray	LEATHER
161	20	gray	LEATHER
162	20.5	gray	LEATHER
163	21	gray	LEATHER
164	21.5	gray	LEATHER
165	22	gray	LEATHER
166	22.5	gray	LEATHER
167	23	gray	LEATHER
168	23.5	gray	LEATHER
169	24	gray	LEATHER
170	24.5	gray	LEATHER
171	25	gray	LEATHER
172	25.5	gray	LEATHER
173	26.5	gray	LEATHER
174	26	gray	LEATHER
175	27	gray	LEATHER
176	27.5	gray	LEATHER
177	28	gray	LEATHER
178	28.5	gray	LEATHER
179	29	gray	LEATHER
180	29.5	gray	LEATHER
181	30	gray	LEATHER
182	30.5	gray	LEATHER
183	31	gray	LEATHER
184	31.5	gray	LEATHER
185	32	gray	LEATHER
186	32.5	gray	LEATHER
187	33	gray	LEATHER
188	33.5	gray	LEATHER
189	34	gray	LEATHER
190	34.5	gray	LEATHER
191	35	gray	LEATHER
192	35.5	gray	LEATHER
193	36	gray	LEATHER
194	36.5	gray	LEATHER
195	37	gray	LEATHER
196	37.5	gray	LEATHER
197	38	gray	LEATHER
198	38.5	gray	LEATHER
199	39	gray	LEATHER
200	39.5	gray	LEATHER
201	40	gray	LEATHER
\.


--
-- Data for Name: main_location; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.main_location (id, address, slug, geolocation) FROM stdin;
1	Ολυμπιάδος 5, Εύοσμος, Ελλάδα	laxana-12-polykastro-ellada	40.66716720000001,22.9155
2	Καραολή και Δημητρίου 21, Εύοσμος, Ελλάδα	polykastro-ellada	40.6650524,22.9054523
4	Μαιάνδρου 62, Εύοσμος, Ελλάδα		40.67285,22.9057198
\.


--
-- Data for Name: main_manufacturer; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.main_manufacturer (id, name, slug) FROM stdin;
1	BodyTalk	bodytalk
2	Nike	nike
3	Superdry	superdry
4	ASOS	asos
5	Only	only
6	Adidas	adidas
7	Body Action	body-action
8	Columbia	columbia
9	Under Armour	under-armour
10	Levi's	levi-s
11	Jack & Jones	jack-jones
12	Ugg Australia	ugg-australia
13	Tommy Hilfiger	tommy-hilfiger
14	Tamaris	tamaris
15	Mourtzi	mourtzi
16	Replay	replay
17	Beverly Hills Polo Club	beverly-hills-polo-club
18	Trussardi	trussardi
19	National Geographic	national-geographic
20	Tru Virtu	tru-virtu
21	Lifeventure	lifeventure
22	Puma	puma
23	Verde	verde
24	Emporio Armani	emporio-armani
25	Casio	casio
26	timperland	timperland
27	Michael Kors	michael-kors
28	Daniel Wellington	daniel-wellington
29	Timberland	timberland
\.


--
-- Data for Name: main_offer; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.main_offer (id, is_open, has_expired, number_of_customers, start_date, end_date, discount_rate, discount_price, company_id, offer_id, product_id) FROM stdin;
3	t	f	0	2020-09-16	2020-09-29	10.3	280.00	4	307	33
4	t	f	0	2020-09-16	2020-09-30	14.7	145.00	4	309	32
5	t	f	0	2020-09-16	2020-09-30	23.5	65.00	1	167	11
6	t	f	0	2020-09-16	2020-09-29	19.4	25.00	1	209	25
7	t	f	0	2020-09-16	2020-09-30	27.3	80.00	1	175	12
\.


--
-- Data for Name: main_product; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.main_product (id, structure, name, slug, active, date_updated, description, category_id, manufacturer_id, parent_id) FROM stdin;
1	parent	BodyTalk 1182-908929 Black	bodytalk-1182-908929-black	t	2020-07-16 07:12:26.446502+00	Γυναικείο μπουφάν σε καπιτονέ ύφανση. Μπουφάν σε καπιτονέ ύφανση με mao γιακά και waffle τελειώματα στα μανίκια και το κάτω μέροs. Διαθέτει φερμουάρ. Με τσέπες στην μπροστινή πλευρά.Σύνθεση από 100% πολυεστέρα. Το μοντέλο φοράει μέγεθος Μ	17	1	\N
2	parent	Nike Sportswear Windrunner BV2906-661 Cedar	nike-sportswear-windrunner-bv2906-661-cedar	t	2020-07-16 07:12:26.658383+00	ΖΕΣΤΑΣΙΑ ΜΕ ΣΤΥΛ WINDRUNNER.\n\nΑψήφησε τις καιρικές συνθήκες με το γυναικείό μπουφάν με συνθετικό γέμισμα Nike Sportswear Windrunner Synthetic-Fill Jacket (BV2906-661) , που διαθέτει ανάλαφρη μόνωση και το εμβληματικό σχέδιο σε σχήμα Λ. Η κουκούλα του εξασφαλίζει κάλυψη σε κάθε σου περιπέτεια όταν κάνει κρύο.\n\nΑνάλαφρη αίσθηση ζεστασιάς\nΎφασμα από ταφτά με μαλακή, απαλή αίσθηση και συνθετικό γέμισμα για ανάλαφρη αίσθηση ζεστασιάς.\n\nΑσφαλής αποθήκευση\nΤσέπες με φερμουάρ για αποθήκευση αντικειμένων στις μετακινήσεις σου.\n\nΣτυλ Windrunner	17	2	\N
3	parent	Superdry Mountain Super Fuji W5000042A-04A Black	superdry-mountain-super-fuji-w5000042a-04a-black	t	2020-07-16 07:12:26.806713+00	Μπουφάν padded με ψηλό λαιμό & σταθερή κουκούλα με λάστιχο προσαρμογής & αποσπώμενη περιμετρική γούνα. Κλείσιμο με φερμουάρ & πατιλέτα με μεταλλικά clips. Δύο εξωτερικές τσέπες με φερμουάρ & εσωτερικές ελαστικές μανσέτες. Patch logo Superdry στο μανίκι.	17	3	\N
4	parent	ASOS DESIGN lace midi dress with ribbon tie and open back-Purple	asos-design-lace-midi-dress-with-ribbon-tie-and-open-back-purple	t	2020-07-16 07:12:26.895774+00	Βραδινό γυναικείο φόρεμα.	18	4	\N
5	parent	ASOS DESIGN one shoulder tulle maxi dress-Green	asos-design-one-shoulder-tulle-maxi-dress-green	t	2020-07-16 07:12:26.978642+00	Βραδινό γυναικείο φόρεμα.	18	4	\N
6	parent	Only 15189746 Black	only-15189746-black	t	2020-07-16 07:12:27.103783+00		18	5	\N
7	parent	Nike Sportswear Essential	nike-sportswear-essential	t	2020-07-16 07:12:27.167645+00		19	2	\N
8	parent	Only 15183712 Beige	only-15183712-beige	t	2020-07-16 07:12:27.262308+00	Πλεκτό ζιβάγκο μακρύ μανίκι με σχέδιο με κουμπιά	19	5	\N
9	parent	Adidas SST TP	adidas-sst-tp	t	2020-07-16 07:12:27.324434+00	Το μοντέλο είναι 188 εκ. Και φοράει μέγεθος M. Περίμετρος στήθους 85 εκ. Και περίμετρος μέσης 69 εκ..	21	6	\N
10	parent	Body Action 021842 Brown	body-action-021842-brown	t	2020-07-16 07:12:27.397005+00		22	7	\N
12	parent	Under Armour Sportstyle Wind	under-armour-sportstyle-wind	t	2020-07-16 07:12:27.656402+00	Loose: Fuller cut for complete comfort.\nLightweight, ripstop woven fabric is tough but comfortable.\nWind-resistant materials & construction shield you from the elements.\nMesh lining for greater breathability.\nGenerous, 3-panel hood construction with drawcord adjust.\nSecure, zip hand pockets.\nElastic cuffs help keep sleeves in place.\nEmbroidered logo.\n100% Polyester.	26	9	\N
13	parent	Levi's 501 Original 00501-0114	levi-s-501-original-00501-0114	t	2020-07-16 07:12:27.766383+00	• Levi's Stonewash 80684 00501-0114 SS20\n• Από το 1873, σταθερά στην μόδα\n• Κλείσιμο με κουμπιά\n• 5 τσέπες\n• Κατασκευασμένο απο ανθεκτικό ύφασμα	28	10	\N
14	parent	Jack & Jones 12150158 Black	jack-jones-12150158-black	t	2020-07-16 07:12:27.869199+00		28	11	\N
15	parent	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 07:12:28.763277+00	UGG Παπούτσι W CLASSIC MINI II BLUE Η κλασική μπότα φορέθηκε αρχικά από τους surfers για να ζεσταθούν μετά τις πρώτες πρωινές surf συνεδρίες και από τότε έχει γίνει εικονική για το μαλακό sheepskin και το διαρκή σχεδιασμό της. Αυτές οι ευπροσάρμοστες μπότες ζευγαρώνουν καλά με σχεδόν όλα.	24	12	\N
16	parent	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 07:12:28.854798+00	Η γάμπα του παπουτσιού προστατεύει από το κρύο, είναι Φυσικό δέρμα - Grain leather. Το σύνολο στηρίζεται πάνω στο τακούνι με ύψος 4 cm. Στο εσωτερικό των παπουτσιών δέρμα, ύφασμα. Στο εσωτερικό των παπουτσιών βρίσκονται οι πάτοι δέρμα. Η ανθεκτική σόλα είναι υλικό υψηλής ποιότητας. Η λεπτομέρεια είναι η διακόσμηση του μοντέλου ύφασμα. Το γυναικείο μοντέλο που είναι κατάλληλο για όλες τις καιρικές συνθήκες.	24	13	\N
29	standalone	Wallet Puma Pioneer 07347109 fuchsia	wallet-puma-pioneer-07347109-fuchsia	t	2020-07-16 07:12:31.692693+00		14	22	\N
30	standalone	Verde 18-1006 Bordeaux	verde-18-1006-bordeaux	t	2020-07-16 07:12:31.744428+00	Πορτοφόλι γυναικείο Verde 18-1006 μαύρο.Θέσεις για κάρτες. Θήκη για κέρματα. Θήκη για ταυτότητα. Ανοιγοκλείνει με κούμπωμα.	14	23	\N
31	standalone	Emporio Armani Chronograph	emporio-armani-chronograph	t	2020-09-15 22:07:04.857693+00		15	24	\N
32	standalone	Casio Collection A168WG-9EF	casio-collection-a168wg-9ef	t	2020-07-16 07:12:35.319542+00	Ανδρικό ρολόι από τη Casio από επιχρυσωμένο ανοξείδωτο ατσάλι με ψηφιακό καντράν και μπρασελέ.	15	25	\N
17	parent	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 07:12:28.95875+00	UGG δερμάτινο μποτάκι σε γκρί καστόρι με εσωτερική επένδυση γούνας που φέρει το λογότυπο της εταιρείας στο πλάι, στον αστράγαλο. Διαθέτει στην σόλα την τεχνολογία «treadlite by Ugg outsole» που την καθιστά εξαιρετικά ελαφριά και αδιάβροχη ενώ προσφέρει αυξημένη απορρόφηση των κραδασμών,ευκαμψία και αντοχή. Το πατάκι του εσωτερικά έχει την τεχνολογία «ENERG COMFORT SYSTEM» που συνδυάζει στρώματα αφρού και πολυαιθουράνη για την απόλυτη υποστήριξη στο πέλμα. Ιδιαιτερά άνετο και ζεστό,ιδανικό για στυλάτες χειμωνιάτικες εμφανίσεις	24	12	\N
18	parent	Tamaris 1-25515-23 305	tamaris-1-25515-23-305	t	2020-07-16 07:12:29.031841+00	Γυναικεία μπότα Tamaris σε κονιάκ δέρμα με αντιολισθητική σόλα για μεγαλύτερη σταθερότητα. Διαθέτει πλαινό φερμουάρ για εύκολη εφαρμογή και τακούνι 7 cm. Σε απλή και απέριττη γραμμή, αποτελεί την πιο εύκολη λύση για καθημερινές εμφανίσεις με στυλ.	25	14	\N
19	parent	Tommy Hilfiger Essential FW0FW04319-990 Black	tommy-hilfiger-essential-fw0fw04319-990-black	t	2020-07-16 07:12:29.165878+00	Γυναικείες μπότες ιππασίας της μάρκας Τοmmy Hilfiger σε μαύρο χρώμα και old time classic στυλ που θα ολοκληρώσει μοναδικά τις εμφανίσεις σας και θα κεντρίσει όλα τα βλεμματα με την θηλυκότητά τους και την κομψότητα που αποπνέουν. Δέρμα στο τερικό μέρος Ύφασμα και γνήσιο δέρμα εσωτερικά Φερμουάρ για τέλεια χρήση Ύψος μπότας: 39cm Ύψος τακουνιού: 3cm Περιφέρεια: 40cm Aντιολισθητική σόλα με κοψίματα	25	13	\N
20	parent	Tamaris 1-22437-23 001	tamaris-1-22437-23-001	t	2020-07-16 07:12:29.269507+00	Γυναικεία γόβα σε μαύρο χρώμα, της εταιρείας Tamaris. Κομψή και άνετη, με έξτρα μαλακό πάτο και τακούνι για το πιο άνετο περπάτημα. Με την τεχνολογία REMOVABLE SOCK. Το ύψος του τακουνιού είναι 9,5cm. Κατασκευασμένη από δέρμα. Θα τη βρείτε και σε μπορντό	26	14	\N
21	parent	Mourtzi 100400 Nude Leather	mourtzi-100400-nude-leather	t	2020-07-16 07:12:29.354764+00		26	15	\N
22	standalone	Replay FW3788.000.A0132D.098	replay-fw3788-000-a0132d-098	t	2020-07-16 07:12:30.281402+00	Τσάντα ώμου γυναικών σε σφυρήλατο οικολογικό δέρμα, εμπρόσθιο πτερύγιο με μακροεντολές REPLAY σε μέταλλο, ιμάντα σε μεταλλική αλυσίδα και οικολογικό δέρμα με μεταλλικά αστέρια. Πλάτος 25 cm, ύψος 17 cm, βάθος 7 cm.	10	16	\N
23	standalone	Beverly Hills Polo Club 657BHP0544	beverly-hills-polo-club-657bhp0544	t	2020-07-16 07:12:30.393883+00	Η γυναικεία τσάντα χιαστί, από την εταιρία Beverly Hills Polo Club, είναι κατασκευασμένη από συνθετικό δέρμα, επεξεργασμένο με τη μέθοδο Saffiano. Το δέρμα Saffiano έχει ανάγλυφη υφή που οφείλεται σε μηχανή που αποτυπώνει επάνω στο δέρμα (stamping method) αυτές τις χαρακτηριστικές γραμμές του δέρματος. Έχει μεγάλη αντοχή στο χρόνο και την βρωμιά ενώ η επεξεργασία του ολοκληρώνεται με επίστρωση στρώματος από κερί. Σαν αποτέλεσμα το δέρμα Saffiano είναι έχει μεγάλη αντοχή στις γρατζουνιές, απωθεί το νερό, ενώ καθαρίζεται πολύ εύκολα.	10	17	\N
24	standalone	Trussardi 75B00656-W050	trussardi-75b00656-w050	t	2020-07-16 07:12:30.575439+00	TRUSSARDI τσάντα χειρός σε μπεζ χρώμα. Κλείνει στο πάνω μέρος με φερμουάρ και περιλαμβάνει λουρί για να μπορεί να κρατηθεί και χιαστί. Εσωτερικά διαθέτει μία μεγάλη θήκη με φερμουάρ για διάφορα μικροαντικείμενα. Είναι διακοσμημένη στο μπροστινό μέρος με το λογότυπο της εταιρίας και ένα αποσπώμενο μπρελόκ. ΥΨΟΣ: 20cm ΠΛΑΤΟΣ: 30cm	10	18	\N
25	standalone	National Geographic N00704.06 Black	national-geographic-n00704-06-black	t	2020-07-16 07:12:30.663084+00	Ανδρικό τσαντάκι ώμου της εταιρείας NATIONAL GEOGRAPHIC κατασκευασμένο από ύφασμα. Πολύ προσεγμένη και ανθεκτική κατασκευή. Διαστάσεις 25 x 12,5 x 19,5 cm	12	19	\N
26	standalone	Tru Virtu Click & Slide Natural Brown	tru-virtu-click-slide-natural-brown	t	2020-07-16 07:12:31.517521+00	Τα High-Tech πορτοφόλια της εταιρείας Tru Virtu είναι κατασκευασμένα από ανοδιωμένο αλουμίνιο και υψηλής ποιότητας πολυμερές. Εξαιτίας της κατασκευής τους είναι πολύ ανθεκτικά αλλά πολύ ελαφριά ταυτόχρονα. Τα πορτοφόλια της Tru Virtu είναι το ιδανικό gadget για την καθημερινότητα σας καθώς σας προστατεύουν από τους εξής παράγοντες:\n\nΠαράνομο σκανάρισμα των προσωπικών σας δεδομένων (RFID scanning*)\nΑπομαγνητιμό των καρτών σας\nΕξωτερικούς παράγοντες: νερό (splash proof), σκόνη-άμμο, χιόνι και μηχανικό φορτίο	13	20	\N
27	standalone	Tommy Hilfiger Bifold Leather Black	tommy-hilfiger-bifold-leather-black	t	2020-09-15 22:14:17.651311+00		13	13	\N
28	standalone	Lifeventure RFiD Bi-Fold Wallet	lifeventure-rfid-bi-fold-wallet	t	2020-07-16 07:12:31.645213+00	Compact πορτοφόλι σε λεπτή γραμμή με RFiD για τον υποψιασμένο ταξιδιώτη. Ευρύχωρο, διαθέτει 6 θήκες για κάρτες, μια μεγάλη θήκη για χαρτονομίσματα και μια εξωτερική θήκη με φερμουάρ για κέρματα.	13	21	\N
34	standalone	Tommy Hilfiger 1791137	tommy-hilfiger-1791137	t	2020-09-15 22:11:48.327832+00		15	13	\N
36	standalone	Daniel Wellington Classic Petite Melrose 2 Black 32mm	daniel-wellington-classic-petite-melrose-2-black-32mm	t	2020-07-16 07:12:35.651646+00	Ένα λιτό, κομψό ρολόι Michael Kors από ροζ επιχρυσωμένο ανοξείδωτο ατσάλι.	16	28	\N
37	standalone	Daniel Wellington Classic Black Cornwall 36mm Rose Gold	daniel-wellington-classic-black-cornwall-36mm-rose-gold	t	2020-07-16 07:12:35.787079+00	Ο οίκος Daniel Wellington μας παρουσιάζει το Classic Black Cornwall. Ένα ρολόι από ανοξείδωτο ατσάλι, μαύρο καντράν και μαύρο υφασμάτινο λουράκι.	16	28	\N
38	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.394966+00		24	12	15
39	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.40439+00		24	12	15
40	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.412777+00		24	12	15
41	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.423362+00		24	12	15
42	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.432009+00		24	12	15
43	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.441143+00		24	12	15
44	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.450644+00		24	12	15
45	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.46057+00		24	12	15
46	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.470285+00		24	12	15
47	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.480538+00		24	12	15
48	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.491324+00		24	12	15
49	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.502206+00		24	12	15
50	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.512864+00		24	12	15
51	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.523032+00		24	12	15
52	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.532874+00		24	12	15
53	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.542741+00		24	12	15
54	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.552763+00		24	12	15
55	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.563848+00		24	12	15
56	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.574954+00		24	12	15
57	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.585019+00		24	12	15
58	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.595517+00		24	12	15
59	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.605556+00		24	12	15
60	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.61528+00		24	12	15
61	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.624465+00		24	12	15
62	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.633721+00		24	12	15
63	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.643456+00		24	12	15
64	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.653329+00		24	12	15
65	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.663312+00		24	12	15
66	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.673421+00		24	12	15
67	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.684609+00		24	12	15
68	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.694705+00		24	12	15
69	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.704818+00		24	12	15
70	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.715237+00		24	12	15
71	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.726085+00		24	12	15
72	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.73577+00		24	12	15
73	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.745888+00		24	12	15
74	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.756818+00		24	12	15
75	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.767124+00		24	12	15
76	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.776926+00		24	12	15
77	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.787295+00		24	12	15
78	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.797647+00		24	12	15
79	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.80683+00		24	12	15
80	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.816413+00		24	12	15
81	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.826729+00		24	12	15
82	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.837108+00		24	12	15
83	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.846977+00		24	12	15
84	child	Ugg Australia Classic Mini II 1016222 Black	ugg-australia-classic-mini-ii-1016222-black	t	2020-07-16 08:50:11.856924+00		24	12	15
85	parent	Timberland Bradstreet Plain Toe Tabac	timberland-bradstreet-plain-toe-tabac	t	2020-07-16 09:12:13.865249+00	Άνω μέρος κατασκευασμένο από premium δέρμα (από silver rated βυρσοδηψεία)\r\n100% βαμβακερά κορδόνια\r\nΠάτος Ortholite στο εσωτερικό με επένδυση από ύφασμα\r\nΕξωτερική σόλα από 15% ανακυκλωμένο λάστιχο\r\nSensor Flex τεχνολογία στη σόλα για ευελιξία και άνεση	32	29	\N
86	standalone			t	2020-07-16 09:12:13.869409+00		\N	\N	\N
87	child	Timberland Bradstreet Plain Toe Tabac	timberland-bradstreet-plain-toe-tabac	t	2020-07-16 09:13:50.030216+00		32	29	85
88	child	Timberland Bradstreet Plain Toe Tabac	timberland-bradstreet-plain-toe-tabac	t	2020-07-16 09:13:50.039038+00		32	29	85
89	child	Timberland Bradstreet Plain Toe Tabac	timberland-bradstreet-plain-toe-tabac	t	2020-07-16 09:13:50.049967+00		32	29	85
90	child	Timberland Bradstreet Plain Toe Tabac	timberland-bradstreet-plain-toe-tabac	t	2020-07-16 09:13:50.058402+00		32	29	85
91	child	Timberland Bradstreet Plain Toe Tabac	timberland-bradstreet-plain-toe-tabac	t	2020-07-16 09:13:50.067272+00		32	29	85
92	child	Timberland Bradstreet Plain Toe Tabac	timberland-bradstreet-plain-toe-tabac	t	2020-07-16 09:13:50.076391+00		32	29	85
93	child	Timberland Bradstreet Plain Toe Tabac	timberland-bradstreet-plain-toe-tabac	t	2020-07-16 09:13:50.085631+00		32	29	85
94	child	Timberland Bradstreet Plain Toe Tabac	timberland-bradstreet-plain-toe-tabac	t	2020-07-16 09:13:50.09371+00		32	29	85
95	child	Timberland Bradstreet Plain Toe Tabac	timberland-bradstreet-plain-toe-tabac	t	2020-07-16 09:13:50.10241+00		32	29	85
96	child	Timberland Bradstreet Plain Toe Tabac	timberland-bradstreet-plain-toe-tabac	t	2020-07-16 09:13:50.114056+00		32	29	85
97	child	Timberland Bradstreet Plain Toe Tabac	timberland-bradstreet-plain-toe-tabac	t	2020-07-16 09:13:50.12247+00		32	29	85
98	child	Timberland Bradstreet Plain Toe Tabac	timberland-bradstreet-plain-toe-tabac	t	2020-07-16 09:13:50.132806+00		32	29	85
99	child	Timberland Bradstreet Plain Toe Tabac	timberland-bradstreet-plain-toe-tabac	t	2020-07-16 09:13:50.143222+00		32	29	85
100	child	Timberland Bradstreet Plain Toe Tabac	timberland-bradstreet-plain-toe-tabac	t	2020-07-16 09:13:50.157295+00		32	29	85
101	child	Timberland Bradstreet Plain Toe Tabac	timberland-bradstreet-plain-toe-tabac	t	2020-07-16 09:13:50.166357+00		32	29	85
102	child	Timberland Bradstreet Plain Toe Tabac	timberland-bradstreet-plain-toe-tabac	t	2020-07-16 09:13:50.175783+00		32	29	85
103	child	Timberland Bradstreet Plain Toe Tabac	timberland-bradstreet-plain-toe-tabac	t	2020-07-16 09:13:50.185774+00		32	29	85
104	child	Timberland Bradstreet Plain Toe Tabac	timberland-bradstreet-plain-toe-tabac	t	2020-07-16 09:13:50.196667+00		32	29	85
105	child	Timberland Bradstreet Plain Toe Tabac	timberland-bradstreet-plain-toe-tabac	t	2020-07-16 09:13:50.205508+00		32	29	85
106	child	Timberland Bradstreet Plain Toe Tabac	timberland-bradstreet-plain-toe-tabac	t	2020-07-16 09:13:50.215561+00		32	29	85
107	child	Timberland Bradstreet Plain Toe Tabac	timberland-bradstreet-plain-toe-tabac	t	2020-07-16 09:13:50.224958+00		32	29	85
108	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.508729+00		24	13	16
109	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.519095+00		24	13	16
110	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.528898+00		24	13	16
111	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.537675+00		24	13	16
112	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.545799+00		24	13	16
113	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.555332+00		24	13	16
114	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.564855+00		24	13	16
115	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.573741+00		24	13	16
116	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.582052+00		24	13	16
117	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.590733+00		24	13	16
118	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.599371+00		24	13	16
119	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.608553+00		24	13	16
120	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.617827+00		24	13	16
121	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.625916+00		24	13	16
122	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.634697+00		24	13	16
123	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.642993+00		24	13	16
124	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.651846+00		24	13	16
125	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.660502+00		24	13	16
126	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.669299+00		24	13	16
127	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.67858+00		24	13	16
128	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.687878+00		24	13	16
129	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.698914+00		24	13	16
130	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.707673+00		24	13	16
131	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.718135+00		24	13	16
132	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.727944+00		24	13	16
133	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.738506+00		24	13	16
134	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.748733+00		24	13	16
135	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.75848+00		24	13	16
136	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.768378+00		24	13	16
137	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.777263+00		24	13	16
138	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.787163+00		24	13	16
139	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.797279+00		24	13	16
140	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.806841+00		24	13	16
141	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.816274+00		24	13	16
142	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.824811+00		24	13	16
143	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.834359+00		24	13	16
144	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.842893+00		24	13	16
145	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.85401+00		24	13	16
146	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.865055+00		24	13	16
147	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.876005+00		24	13	16
148	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.886965+00		24	13	16
149	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.89747+00		24	13	16
150	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.907233+00		24	13	16
151	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.917107+00		24	13	16
152	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.927716+00		24	13	16
153	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.937681+00		24	13	16
154	child	Tommy Hilfiger Corporate Ribbon Bikeboot FW0FW04326-990 Black	tommy-hilfiger-corporate-ribbon-bikeboot-fw0fw04326-990-black	t	2020-07-16 09:15:21.947933+00		24	13	16
155	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.066298+00		24	12	17
156	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.076597+00		24	12	17
157	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.086156+00		24	12	17
158	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.095443+00		24	12	17
159	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.104789+00		24	12	17
160	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.114592+00		24	12	17
161	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.123761+00		24	12	17
162	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.131948+00		24	12	17
163	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.14041+00		24	12	17
164	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.149413+00		24	12	17
165	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.157987+00		24	12	17
166	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.166769+00		24	12	17
167	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.176377+00		24	12	17
168	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.185532+00		24	12	17
169	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.195925+00		24	12	17
170	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.205378+00		24	12	17
171	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.214892+00		24	12	17
172	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.225353+00		24	12	17
173	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.236161+00		24	12	17
174	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.246397+00		24	12	17
175	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.256051+00		24	12	17
176	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.266909+00		24	12	17
177	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.28045+00		24	12	17
178	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.290532+00		24	12	17
179	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.300744+00		24	12	17
180	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.310992+00		24	12	17
181	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.320898+00		24	12	17
182	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.330724+00		24	12	17
183	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.34127+00		24	12	17
184	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.350155+00		24	12	17
185	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.360147+00		24	12	17
186	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.370272+00		24	12	17
187	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.380733+00		24	12	17
188	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.39096+00		24	12	17
189	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.401424+00		24	12	17
190	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.411944+00		24	12	17
191	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.422057+00		24	12	17
192	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.435362+00		24	12	17
193	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.452146+00		24	12	17
194	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.46191+00		24	12	17
195	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.471779+00		24	12	17
196	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.482658+00		24	12	17
197	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.493192+00		24	12	17
198	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.504114+00		24	12	17
199	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.513587+00		24	12	17
200	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.525055+00		24	12	17
201	child	Ugg Australia Classic Mini Logo 1108231 Grey	ugg-australia-classic-mini-logo-1108231-grey	t	2020-07-16 09:16:28.535248+00		24	12	17
11	parent	Columbia Bugaboo II	columbia-bugaboo-ii	t	2020-07-26 07:01:40.55327+00	Omni-HEAT™ θερμική αντανάκλαση\nOmni-TECH™ αδιάβροχο/διαπνέον, μερικώς θερμοκολλημένες ραφές\nΣύνδεση του εσωτερικού με το μπουφάν με φερμουάρ\nΑποσπώμενη, ρυθμιζόμενη κουκούλα θυέλλης\nΠλαινές τσέπες χεριών με φερμουάρ\nΡυθμιζόμενες μανσέτες\nΣτρίφωμα με ρυθμιζόμενο κορδόνι	26	8	\N
202	child	Columbia Bugaboo II	columbia-bugaboo-ii	t	2020-07-26 07:02:01.090484+00		26	8	11
203	child	Columbia Bugaboo II	columbia-bugaboo-ii	t	2020-07-26 07:02:01.102381+00		26	8	11
204	child	Columbia Bugaboo II	columbia-bugaboo-ii	t	2020-07-26 07:02:01.112508+00		26	8	11
205	child	Columbia Bugaboo II	columbia-bugaboo-ii	t	2020-07-26 07:02:01.126377+00		26	8	11
206	child	Columbia Bugaboo II	columbia-bugaboo-ii	t	2020-07-26 07:02:01.135857+00		26	8	11
207	child	Columbia Bugaboo II	columbia-bugaboo-ii	t	2020-07-26 07:02:01.145355+00		26	8	11
208	child	Columbia Bugaboo II	columbia-bugaboo-ii	t	2020-07-26 07:02:01.155311+00		26	8	11
209	child	Under Armour Sportstyle Wind	under-armour-sportstyle-wind	t	2020-07-26 07:02:41.624519+00		26	9	12
210	child	Under Armour Sportstyle Wind	under-armour-sportstyle-wind	t	2020-07-26 07:02:41.635302+00		26	9	12
211	child	Under Armour Sportstyle Wind	under-armour-sportstyle-wind	t	2020-07-26 07:02:41.645204+00		26	9	12
212	child	Under Armour Sportstyle Wind	under-armour-sportstyle-wind	t	2020-07-26 07:02:41.655285+00		26	9	12
213	child	Under Armour Sportstyle Wind	under-armour-sportstyle-wind	t	2020-07-26 07:02:41.666077+00		26	9	12
214	child	Under Armour Sportstyle Wind	under-armour-sportstyle-wind	t	2020-07-26 07:02:41.676243+00		26	9	12
215	child	Under Armour Sportstyle Wind	under-armour-sportstyle-wind	t	2020-07-26 07:02:41.685599+00		26	9	12
216	child	Nike Sportswear Windrunner BV2906-661 Cedar	nike-sportswear-windrunner-bv2906-661-cedar	t	2020-07-26 07:03:15.582486+00		17	2	2
217	child	Nike Sportswear Windrunner BV2906-661 Cedar	nike-sportswear-windrunner-bv2906-661-cedar	t	2020-07-26 07:03:15.592148+00		17	2	2
218	child	Nike Sportswear Windrunner BV2906-661 Cedar	nike-sportswear-windrunner-bv2906-661-cedar	t	2020-07-26 07:03:15.602069+00		17	2	2
219	child	Nike Sportswear Windrunner BV2906-661 Cedar	nike-sportswear-windrunner-bv2906-661-cedar	t	2020-07-26 07:03:15.611504+00		17	2	2
220	child	Nike Sportswear Windrunner BV2906-661 Cedar	nike-sportswear-windrunner-bv2906-661-cedar	t	2020-07-26 07:03:15.620894+00		17	2	2
221	child	Nike Sportswear Windrunner BV2906-661 Cedar	nike-sportswear-windrunner-bv2906-661-cedar	t	2020-07-26 07:03:15.631769+00		17	2	2
222	child	Nike Sportswear Windrunner BV2906-661 Cedar	nike-sportswear-windrunner-bv2906-661-cedar	t	2020-07-26 07:03:15.64194+00		17	2	2
223	child	Superdry Mountain Super Fuji W5000042A-04A Black	superdry-mountain-super-fuji-w5000042a-04a-black	t	2020-07-26 07:03:36.074693+00		17	3	3
224	child	Superdry Mountain Super Fuji W5000042A-04A Black	superdry-mountain-super-fuji-w5000042a-04a-black	t	2020-07-26 07:03:36.091799+00		17	3	3
225	child	Superdry Mountain Super Fuji W5000042A-04A Black	superdry-mountain-super-fuji-w5000042a-04a-black	t	2020-07-26 07:03:36.102626+00		17	3	3
226	child	Superdry Mountain Super Fuji W5000042A-04A Black	superdry-mountain-super-fuji-w5000042a-04a-black	t	2020-07-26 07:03:36.112403+00		17	3	3
227	child	Superdry Mountain Super Fuji W5000042A-04A Black	superdry-mountain-super-fuji-w5000042a-04a-black	t	2020-07-26 07:03:36.122597+00		17	3	3
228	child	Superdry Mountain Super Fuji W5000042A-04A Black	superdry-mountain-super-fuji-w5000042a-04a-black	t	2020-07-26 07:03:36.133164+00		17	3	3
229	child	Superdry Mountain Super Fuji W5000042A-04A Black	superdry-mountain-super-fuji-w5000042a-04a-black	t	2020-07-26 07:03:36.143174+00		17	3	3
230	child	Body Action 021842 Brown	body-action-021842-brown	t	2020-07-26 07:04:37.663951+00		22	7	10
231	child	Body Action 021842 Brown	body-action-021842-brown	t	2020-07-26 07:04:37.675159+00		22	7	10
232	child	Body Action 021842 Brown	body-action-021842-brown	t	2020-07-26 07:04:37.685063+00		22	7	10
233	child	Body Action 021842 Brown	body-action-021842-brown	t	2020-07-26 07:04:37.696086+00		22	7	10
234	child	Body Action 021842 Brown	body-action-021842-brown	t	2020-07-26 07:04:37.706108+00		22	7	10
235	child	Body Action 021842 Brown	body-action-021842-brown	t	2020-07-26 07:04:37.715462+00		22	7	10
236	child	Body Action 021842 Brown	body-action-021842-brown	t	2020-07-26 07:04:37.724458+00		22	7	10
33	standalone	Timberland Henniker II	timberland-henniker-ii	t	2020-09-15 22:01:25.107264+00	Ανδρικό ρολόι χειρός Timberland από καφέ ανοξείδωτο ατσάλι με λευκό καντράν και καφέ δερμάτινο λουράκι.	15	29	\N
35	standalone	Michael Kors Slim Runway Gold Rose Bracelet	michael-kors-slim-runway-gold-rose-bracelet	t	2020-09-15 22:21:00.118627+00		16	27	\N
\.


--
-- Data for Name: main_productcategory; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.main_productcategory (id, name, slug, type, lft, rght, tree_id, level, parent_id) FROM stdin;
1	Μόδα	moda	0	1	66	1	0	\N
19	Γυναικείες Μπλούζες	gunaikeies-mplouzes	10	42	43	1	3	8
18	Γυναικεία Φορέματα	gunaikeia-phoremata	10	40	41	1	3	8
17	Γυναικεία Μπουφάν	gunaikeia-mpouphan	10	34	35	1	3	8
16	Γυναικεία Ρολόγια	gunaikeia-rologia	40	51	52	1	2	5
15	Ανδρικά Ρολόγια	andrika-rologia	40	49	50	1	2	5
14	Γυναικεία Πορτοφόλια	gunaikeia-portopholia	35	62	63	1	3	11
13	Ανδρικά Πορτοφόλια	andrika-portopholia	35	60	61	1	3	11
12	Ανδρικές Τσάντες	andrikes-tsantes	30	55	56	1	2	4
11	Πορτοφόλια	portopholia	0	59	64	1	2	4
9	Γυναικεία Παπούτσια	gunaikeia-papoutsia	0	25	32	1	2	3
7	Ανδρικά Παπούτσια	andrika-papoutsia	0	3	10	1	2	2
6	Ανδρικά Ρούχα	andrika-roukha	0	11	22	1	2	2
33	Χειμερινές Ανδρικές Παντόφλες	kheimerines-andrikes-pantophles	20	8	9	1	3	7
31	Ανδρικά Μποτάκια	andrika-mpotakia	20	6	7	1	3	7
32	Ανδρικά Casual	andrika-casual	20	4	5	1	3	7
30	Ανδρικές Μπλούζες	andrikes-mplouzes	10	18	19	1	3	6
29	Ανδρικές Φόρμες	andrikes-phormes	10	20	21	1	3	6
28	Ανδρικά Παντελόνια	andrika-pantelonia	10	14	15	1	3	6
27	Ανδρικά Φούτερ	andrika-phouter	10	16	17	1	3	6
26	Ανδρικά Μπουφάν	andrika-mpouphan	10	12	13	1	3	6
2	Ανδρικά	andrika	0	2	23	1	1	1
25	Γόβες	gobes	20	26	27	1	3	9
24	Γυναικείες Μπότες	gunaikeies-mpotes	20	30	31	1	3	9
23	Γυναικεία Μποτάκια	gunaikeia-mpotakia	20	28	29	1	3	9
22	Γυναικείες Φόρμες	gunaikeies-phormes	10	44	45	1	3	8
21	Γυναικεία Παντελόνια	gunaikeia-pantelonia	10	38	39	1	3	8
20	Γυναικεία Παλτό	gunaikeia-palto	10	36	37	1	3	8
3	Γυναικεία	gunaikeia	0	24	47	1	1	1
4	Τσάντες & Πορτοφόλια	tsantes-portopholia	0	54	65	1	1	1
8	Γυναικεία Ρούχα	gunaikeia-roukha	0	33	46	1	2	3
10	Γυναικείες Τσάντες	gunaikeies-tsantes	30	57	58	1	2	4
5	Ρολόγια	rologia	0	48	53	1	1	1
\.


--
-- Data for Name: main_productimage; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.main_productimage (id, image, thumbnail, product_id) FROM stdin;
1	product-images/BodyTalk_1182-908929_Black1_xczGFAc.jpeg	product-thumbnails/BodyTalk_1182-908929_Black1_D9SPSiU.jpeg	1
2	product-images/BodyTalk_1182-908929_Black2_a0sY5OI.jpeg	product-thumbnails/BodyTalk_1182-908929_Black2_pwnB69t.jpeg	1
3	product-images/Nike_Sportswear_Windrunner_BV2906-661_Cedar1_3oOR8Br.jpeg	product-thumbnails/Nike_Sportswear_Windrunner_BV2906-661_Cedar1_mD3viN6.jpeg	2
4	product-images/Nike_Sportswear_Windrunner_BV2906-661_Cedar2_negTP2N.jpeg	product-thumbnails/Nike_Sportswear_Windrunner_BV2906-661_Cedar2_BePhGUP.jpeg	2
5	product-images/Nike_Sportswear_Windrunner_BV2906-661_Cedar3_kCA98f9.jpeg	product-thumbnails/Nike_Sportswear_Windrunner_BV2906-661_Cedar3_oG7sy2C.jpeg	2
6	product-images/Nike_Sportswear_Windrunner_BV2906-661_Cedar4_10WmwIg.jpeg	product-thumbnails/Nike_Sportswear_Windrunner_BV2906-661_Cedar4_Y6iC2x5.jpeg	2
7	product-images/Superdry_Mountain_Super_Fuji_W5000042A-30E_Green1_fSwToSx.jpeg	product-thumbnails/Superdry_Mountain_Super_Fuji_W5000042A-30E_Green1_Dy7z8Y0.jpeg	3
8	product-images/Superdry_Mountain_Super_Fuji_W5000042A-30E_Green2_3qBRFX5.jpeg	product-thumbnails/Superdry_Mountain_Super_Fuji_W5000042A-30E_Green2_VipvOxr.jpeg	3
9	product-images/ASOS_DESIGN_lace_midi_dress_with_ribbon_tie_and_open_back-Purple1_S6GR5vO.jpeg	product-thumbnails/ASOS_DESIGN_lace_midi_dress_with_ribbon_tie_and_open_back-Purple1_tZkFe0D.jpeg	4
10	product-images/ASOS_DESIGN_one_shoulder_tulle_maxi_dress-Green1_qap9s5H.jpeg	product-thumbnails/ASOS_DESIGN_one_shoulder_tulle_maxi_dress-Green1_TJmLSDE.jpeg	5
11	product-images/Only_15189746_Black1_oGnrlP5.jpeg	product-thumbnails/Only_15189746_Black1_4OH90MI.jpeg	6
12	product-images/Only_15189746_Black2_UAou9oU.jpeg	product-thumbnails/Only_15189746_Black2_88hXpmb.jpeg	6
13	product-images/Nike_Sportswear_Essential1_pc6REsU.jpeg	product-thumbnails/Nike_Sportswear_Essential1_FR6CPs1.jpeg	7
14	product-images/Only_15183712_Beige1_3RXxaA7.jpeg	product-thumbnails/Only_15183712_Beige1_iSXtVmw.jpeg	8
15	product-images/Only_15183712_Beige2_d5brQKW.jpeg	product-thumbnails/Only_15183712_Beige2_s4Q5O9N.jpeg	8
16	product-images/Adidas_SST_TP1_t7fxqgN.jpeg	product-thumbnails/Adidas_SST_TP1_zYA87eT.jpeg	9
17	product-images/Body_Action_021842_Brown1_YRyIn7z.jpeg	product-thumbnails/Body_Action_021842_Brown1_pjOXdpK.jpeg	10
18	product-images/Columbia_Bugaboo_II1_LrGCs1Z.jpeg	product-thumbnails/Columbia_Bugaboo_II1_4lsU9XE.jpeg	11
19	product-images/Columbia_Bugaboo_II2_rrTZyTx.jpeg	product-thumbnails/Columbia_Bugaboo_II2_XQwX6At.jpeg	11
20	product-images/Under_Armour_Sportstyle_Wind1.jpeg	product-thumbnails/Under_Armour_Sportstyle_Wind1.jpeg	12
21	product-images/Under_Armour_Sportstyle_Wind2.jpeg	product-thumbnails/Under_Armour_Sportstyle_Wind2.jpeg	12
22	product-images/Levis_501_Original_00501-01141_7nJ5E4m.jpeg	product-thumbnails/Levis_501_Original_00501-01141_Au1JAMl.jpeg	13
23	product-images/Levis_501_Original_00501-01142_6fJ7Zio.jpeg	product-thumbnails/Levis_501_Original_00501-01142_jhx0sDX.jpeg	13
24	product-images/Jack__Jones_12150158_Black1_ZqC9VlI.jpeg	product-thumbnails/Jack__Jones_12150158_Black1_Fwbk9S9.jpeg	14
25	product-images/Jack__Jones_12150158_Black2_J03D2ps.jpeg	product-thumbnails/Jack__Jones_12150158_Black2_UMThwyZ.jpeg	14
26	product-images/Ugg_Australia_Classic_Mini_II_1016222_Black1.jpeg	product-thumbnails/Ugg_Australia_Classic_Mini_II_1016222_Black1.jpeg	15
27	product-images/Ugg_Australia_Classic_Mini_II_1016222_Black3.jpeg	product-thumbnails/Ugg_Australia_Classic_Mini_II_1016222_Black3.jpeg	15
28	product-images/Tommy_Hilfiger_Corporate_Ribbon_Bikeboot_FW0FW04326-990_Black1_Ted79mj.jpeg	product-thumbnails/Tommy_Hilfiger_Corporate_Ribbon_Bikeboot_FW0FW04326-990_Black1_egrDJWT.jpeg	16
29	product-images/Tommy_Hilfiger_Corporate_Ribbon_Bikeboot_FW0FW04326-990_Black2_bGgcEbj.jpeg	product-thumbnails/Tommy_Hilfiger_Corporate_Ribbon_Bikeboot_FW0FW04326-990_Black2_NtqtFei.jpeg	16
30	product-images/Ugg_Australia_Classic_Mini_Logo_1108231_Grey1_F0xCywB.jpeg	product-thumbnails/Ugg_Australia_Classic_Mini_Logo_1108231_Grey1_nvYgni1.jpeg	17
31	product-images/Ugg_Australia_Classic_Mini_Logo_1108231_Grey2_NsN1ya6.jpeg	product-thumbnails/Ugg_Australia_Classic_Mini_Logo_1108231_Grey2_rnemOGe.jpeg	17
32	product-images/Tamaris_1-25515-23_3051_LA6ojwd.jpeg	product-thumbnails/Tamaris_1-25515-23_3051_fjBVXVC.jpeg	18
33	product-images/Tommy_Hilfiger_Essential_FW0FW04319-990_Black1_0eGEw7g.jpeg	product-thumbnails/Tommy_Hilfiger_Essential_FW0FW04319-990_Black1_nnpgSl1.jpeg	19
34	product-images/Tommy_Hilfiger_Essential_FW0FW04319-990_Black1_Hwsf1xA.jpeg	product-thumbnails/Tommy_Hilfiger_Essential_FW0FW04319-990_Black1_4to6RoI.jpeg	19
35	product-images/Tamaris_1-22437-23_0011_I0NbnFg.jpeg	product-thumbnails/Tamaris_1-22437-23_0011_KrfqZXF.jpeg	20
36	product-images/Tamaris_1-22437-23_0012_c4BhIk6.jpeg	product-thumbnails/Tamaris_1-22437-23_0012_FO7ZXcF.jpeg	20
37	product-images/Mourtzi_100400_Nude_Leather1_G4MhU7K.jpeg	product-thumbnails/Mourtzi_100400_Nude_Leather1_LJzlQ6X.jpeg	21
38	product-images/Mourtzi_100400_Nude_Leather2_Xbw3ieE.jpeg	product-thumbnails/Mourtzi_100400_Nude_Leather2_aXVIyYJ.jpeg	21
39	product-images/Replay_FW3788.000.A0132D.0981_1Pv3Eve.jpeg	product-thumbnails/Replay_FW3788.000.A0132D.0981_1HuHthO.jpeg	22
40	product-images/Beverly_Hills_Polo_Club_657BHP05441_3tUzcuT.jpeg	product-thumbnails/Beverly_Hills_Polo_Club_657BHP05441_x7kXHii.jpeg	23
41	product-images/Beverly_Hills_Polo_Club_657BHP05442_LHpinuC.jpeg	product-thumbnails/Beverly_Hills_Polo_Club_657BHP05442_9lHbEyu.jpeg	23
42	product-images/Trussardi_75B00656-W0501_kTZIMlU.jpeg	product-thumbnails/Trussardi_75B00656-W0501_AHMUHED.jpeg	24
43	product-images/Trussardi_75B00656-W0502_7QAlTgu.jpeg	product-thumbnails/Trussardi_75B00656-W0502_V6tgS8W.jpeg	24
44	product-images/National_Geographic_N00704.06_Black1_B2d8e4Q.jpeg	product-thumbnails/National_Geographic_N00704.06_Black1_FviGwKj.jpeg	25
45	product-images/National_Geographic_N00704.06_Black2_mDRXDM3.jpeg	product-thumbnails/National_Geographic_N00704.06_Black2_6iAJ2Ze.jpeg	25
46	product-images/Tru_Virtu_Click__Slide_Natural_Brown1_DhvFVyN.jpeg	product-thumbnails/Tru_Virtu_Click__Slide_Natural_Brown1_2dESAN1.jpeg	26
47	product-images/Tru_Virtu_Click__Slide_Natural_Brown2_cYzTxqa.jpeg	product-thumbnails/Tru_Virtu_Click__Slide_Natural_Brown2_UyuD12O.jpeg	26
48	product-images/Tommy_Hilfiger_Bifold_Leather_Black1_aqtg89k.jpeg	product-thumbnails/Tommy_Hilfiger_Bifold_Leather_Black1_ysOznVP.jpeg	27
49	product-images/Lifeventure_RFiD_Bi-Fold_Wallet1_scqipNg.jpeg	product-thumbnails/Lifeventure_RFiD_Bi-Fold_Wallet1_DcFw84h.jpeg	28
50	product-images/Wallet_Puma_Pioneer_07347109_fuchsia1_A1r9SPM.jpeg	product-thumbnails/Wallet_Puma_Pioneer_07347109_fuchsia1_6dl6ogx.jpeg	29
51	product-images/Verde_18-1006_Bordeaux1_ZQNp2Yd.jpeg	product-thumbnails/Verde_18-1006_Bordeaux1_geGb8lb.jpeg	30
52	product-images/Emporio_Armani_Chronograph1_zm2xdED.jpeg	product-thumbnails/Emporio_Armani_Chronograph1_Z7QMlFQ.jpeg	31
53	product-images/Emporio_Armani_Chronograph2.jpeg	product-thumbnails/Emporio_Armani_Chronograph2.jpeg	31
54	product-images/Casio_Collection_A168WG-9EF1_oB26IKj.jpeg	product-thumbnails/Casio_Collection_A168WG-9EF1_ezjTibM.jpeg	32
55	product-images/Timberland_Henniker_II1_OXl9pTm.jpeg	product-thumbnails/Timberland_Henniker_II1_7eVNYwd.jpeg	33
56	product-images/Tommy_Hilfiger_17911371_LxrKRMW.jpeg	product-thumbnails/Tommy_Hilfiger_17911371_qy7Rip9.jpeg	34
57	product-images/Tommy_Hilfiger_17911372_RsRXZRk.jpeg	product-thumbnails/Tommy_Hilfiger_17911372_LKDeSXl.jpeg	34
58	product-images/Michael_Kors_Slim_Runway_Gold_Rose_Bracelet1_BH8hGbr.jpg	product-thumbnails/Michael_Kors_Slim_Runway_Gold_Rose_Bracelet1_jg4Ntf8.jpg	35
59	product-images/Daniel_Wellington_Classic_Petite_Melrose_2_Black_32mm1_ndR9H5O.jpeg	product-thumbnails/Daniel_Wellington_Classic_Petite_Melrose_2_Black_32mm1_6WUrbxI.jpeg	36
60	product-images/Daniel_Wellington_Classic_Petite_Melrose_2_Black_32mm2_77k1Jh6.jpeg	product-thumbnails/Daniel_Wellington_Classic_Petite_Melrose_2_Black_32mm2_LA1x9OE.jpeg	36
61	product-images/Daniel_Wellington_Classic_Black_Cornwall_36mm_Rose_Gold1_T4qPsjb.jpeg	product-thumbnails/Daniel_Wellington_Classic_Black_Cornwall_36mm_Rose_Gold1_khzOum0.jpeg	37
62	product-images/Daniel_Wellington_Classic_Black_Cornwall_36mm_Rose_Gold2_icqkO42.jpeg	product-thumbnails/Daniel_Wellington_Classic_Black_Cornwall_36mm_Rose_Gold2_V7PV4pB.jpeg	37
63	product-images/20191009153740_timberland_bradstreet_plain_toe_a1k2j_tabac.jpeg	product-thumbnails/20191009153740_timberland_bradstreet_plain_toe_a1k2j_tabac.jpeg	85
64	product-images/20191016105735_53c64370.jpeg	product-thumbnails/20191016105735_53c64370.jpeg	85
65	product-images/Michael_Kors_Slim_Runway_Gold_Rose_Bracelet2.jpg	product-thumbnails/Michael_Kors_Slim_Runway_Gold_Rose_Bracelet2.jpg	35
\.


--
-- Data for Name: main_sale; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.main_sale (id, quantity, selling_price, status, paid_with_money, date_updated, date_added, company_id, product_id, customer_id) FROM stdin;
1	1	80.00	20	t	2020-07-12 09:22:13+00	2020-07-11 09:22:21+00	1	196	5
3	1	130.00	30	t	2020-07-14 06:23:49+00	2020-07-13 09:34:05+00	1	149	5
6	1	95.00	20	f	2020-07-16 09:30:30+00	2020-07-16 07:30:32+00	1	104	3
7	3	95.00	20	t	2020-07-16 14:49:58+00	2020-07-16 07:49:59+00	1	102	4
13	1	300.00	20	t	2020-08-12 20:09:20.645741+00	2020-08-12 20:09:20.645754+00	1	33	2
14	1	300.00	20	t	2020-08-12 20:11:05.895698+00	2020-08-12 20:11:05.895709+00	1	33	2
34	1	300.00	30	f	2020-08-15 08:22:30.096552+00	2020-08-15 08:22:30.096564+00	1	33	2
33	1	300.00	30	f	2020-08-15 08:23:15.397593+00	2020-08-15 08:23:15.397608+00	1	33	2
97	1	280.00	20	t	2020-09-15 22:04:19.36437+00	2020-09-15 22:04:19.364387+00	4	33	2
98	1	85.00	10	t	2020-09-15 22:24:30.059576+00	2020-09-15 22:24:30.059604+00	4	99	2
83	1	130.00	20	t	2020-09-15 22:31:17.85264+00	2020-09-15 22:31:17.852657+00	1	225	5
76	3	300.00	20	t	2020-09-15 22:31:59.777752+00	2020-09-15 22:31:59.777763+00	1	33	6
82	1	80.00	20	t	2020-09-15 22:32:14.149002+00	2020-09-15 22:32:14.149014+00	1	187	10
72	1	92.00	20	t	2020-09-15 22:32:41.115603+00	2020-09-15 22:32:41.115615+00	2	221	4
75	3	300.00	20	t	2020-09-15 22:32:54.928212+00	2020-09-15 22:32:54.928223+00	1	33	6
77	2	320.00	20	t	2020-09-15 22:33:12.698631+00	2020-09-15 22:33:12.698644+00	1	34	2
74	2	78.00	20	t	2020-09-15 22:33:12.721002+00	2020-09-15 22:33:12.721018+00	1	76	2
70	1	130.00	20	t	2020-09-15 22:33:12.742667+00	2020-09-15 22:33:12.742691+00	1	226	2
5	1	95.00	20	t	2020-09-15 22:33:12.762951+00	2020-09-15 22:33:12.762963+00	1	102	4
4	80	1.00	20	t	2020-09-15 22:33:12.784971+00	2020-09-15 22:33:12.784985+00	1	197	10
2	1	95.00	20	t	2020-09-15 22:34:36.465484+00	2020-09-15 22:34:36.465499+00	1	103	6
99	1	300.00	20	t	2020-09-15 22:43:12.093222+00	2020-09-15 22:43:12.093233+00	1	33	69
100	1	47.00	10	t	2020-09-15 22:45:10.251686+00	2020-09-15 22:45:10.251713+00	2	27	69
101	1	130.00	10	t	2020-09-16 07:22:52.655563+00	2020-09-16 07:22:52.655592+00	1	223	5
92	1	80.00	30	t	2020-09-16 07:23:04.265248+00	2020-09-16 07:23:04.265269+00	1	187	2
91	2	280.00	30	t	2020-09-16 07:23:04.292024+00	2020-09-16 07:23:04.292041+00	2	35	8
\.


--
-- Data for Name: main_salesproduct; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.main_salesproduct (id, price, quantity, date_updated, company_id, product_id) FROM stdin;
28	78.00	0	2020-07-16 08:50:57.044614+00	1	64
29	78.00	0	2020-07-16 08:50:57.050756+00	1	65
30	78.00	0	2020-07-16 08:50:57.056539+00	1	66
31	78.00	0	2020-07-16 08:50:57.063511+00	1	67
32	78.00	0	2020-07-16 08:50:57.070222+00	1	68
33	78.00	0	2020-07-16 08:50:57.077748+00	1	69
34	78.00	0	2020-07-16 08:50:57.084834+00	1	70
35	78.00	5	2020-07-16 08:50:57.091513+00	1	71
36	78.00	0	2020-07-16 08:50:57.098593+00	1	72
37	78.00	5	2020-07-16 08:50:57.107065+00	1	73
38	78.00	0	2020-07-16 08:50:57.114437+00	1	74
39	78.00	6	2020-07-16 08:50:57.12092+00	1	75
40	78.00	6	2020-07-16 08:50:57.127648+00	1	76
41	78.00	7	2020-07-16 08:50:57.134163+00	1	77
42	78.00	4	2020-07-16 08:50:57.141472+00	1	78
43	78.00	5	2020-07-16 08:50:57.148783+00	1	79
44	78.00	5	2020-07-16 08:50:57.154719+00	1	80
45	78.00	3	2020-07-16 08:50:57.160414+00	1	81
46	78.00	1	2020-07-16 08:50:57.169238+00	1	82
47	78.00	2	2020-07-16 08:50:57.176778+00	1	83
48	78.00	1	2020-07-16 08:50:57.184065+00	1	84
49	95.00	43	2020-07-16 09:13:50.021792+00	1	85
50	95.00	0	2020-07-16 09:13:50.033606+00	1	87
51	95.00	0	2020-07-16 09:13:50.043042+00	1	88
52	95.00	0	2020-07-16 09:13:50.053013+00	1	89
53	95.00	0	2020-07-16 09:13:50.061848+00	1	90
54	95.00	0	2020-07-16 09:13:50.070287+00	1	91
1	78.00	50	2020-07-16 08:50:56.861028+00	1	15
2	78.00	0	2020-07-16 08:50:56.868631+00	1	38
3	78.00	0	2020-07-16 08:50:56.874538+00	1	39
4	78.00	0	2020-07-16 08:50:56.880685+00	1	40
5	78.00	0	2020-07-16 08:50:56.886838+00	1	41
6	78.00	0	2020-07-16 08:50:56.893758+00	1	42
7	78.00	0	2020-07-16 08:50:56.900342+00	1	43
8	78.00	0	2020-07-16 08:50:56.9079+00	1	44
9	78.00	0	2020-07-16 08:50:56.914191+00	1	45
10	78.00	0	2020-07-16 08:50:56.921119+00	1	46
11	78.00	0	2020-07-16 08:50:56.928402+00	1	47
12	78.00	0	2020-07-16 08:50:56.935408+00	1	48
13	78.00	0	2020-07-16 08:50:56.942351+00	1	49
14	78.00	0	2020-07-16 08:50:56.949072+00	1	50
15	78.00	0	2020-07-16 08:50:56.955673+00	1	51
16	78.00	0	2020-07-16 08:50:56.961771+00	1	52
17	78.00	0	2020-07-16 08:50:56.968797+00	1	53
18	78.00	0	2020-07-16 08:50:56.975953+00	1	54
19	78.00	0	2020-07-16 08:50:56.983093+00	1	55
20	78.00	0	2020-07-16 08:50:56.989969+00	1	56
21	78.00	0	2020-07-16 08:50:56.997168+00	1	57
22	78.00	0	2020-07-16 08:50:57.004937+00	1	58
23	78.00	0	2020-07-16 08:50:57.012177+00	1	59
24	78.00	0	2020-07-16 08:50:57.018951+00	1	60
25	78.00	0	2020-07-16 08:50:57.025018+00	1	61
26	78.00	0	2020-07-16 08:50:57.032119+00	1	62
27	78.00	0	2020-07-16 08:50:57.038149+00	1	63
55	95.00	0	2020-07-16 09:13:50.07998+00	1	92
56	95.00	1	2020-07-16 09:13:50.088267+00	1	93
57	95.00	5	2020-07-16 09:13:50.096798+00	1	94
58	95.00	5	2020-07-16 09:13:50.104722+00	1	95
59	95.00	6	2020-07-16 09:13:50.116916+00	1	96
60	95.00	10	2020-07-16 09:13:50.125382+00	1	97
61	95.00	2	2020-07-16 09:13:50.136681+00	1	98
62	95.00	6	2020-07-16 09:13:50.150165+00	1	99
63	95.00	2	2020-07-16 09:13:50.160542+00	1	100
64	95.00	2	2020-07-16 09:13:50.169195+00	1	101
65	95.00	2	2020-07-16 09:13:50.179398+00	1	102
66	95.00	2	2020-07-16 09:13:50.189227+00	1	103
67	95.00	0	2020-07-16 09:13:50.199681+00	1	104
68	95.00	0	2020-07-16 09:13:50.209616+00	1	105
69	95.00	0	2020-07-16 09:13:50.218861+00	1	106
70	95.00	0	2020-07-16 09:13:50.229834+00	1	107
71	130.00	52	2020-07-16 09:15:21.498957+00	1	16
72	130.00	0	2020-07-16 09:15:21.512555+00	1	108
73	130.00	0	2020-07-16 09:15:21.522048+00	1	109
74	130.00	0	2020-07-16 09:15:21.532417+00	1	110
75	130.00	0	2020-07-16 09:15:21.540164+00	1	111
76	130.00	0	2020-07-16 09:15:21.549204+00	1	112
77	130.00	0	2020-07-16 09:15:21.558354+00	1	113
78	130.00	0	2020-07-16 09:15:21.568259+00	1	114
79	130.00	0	2020-07-16 09:15:21.576035+00	1	115
80	130.00	0	2020-07-16 09:15:21.585049+00	1	116
81	130.00	0	2020-07-16 09:15:21.593116+00	1	117
82	130.00	0	2020-07-16 09:15:21.602841+00	1	118
83	130.00	0	2020-07-16 09:15:21.611799+00	1	119
84	130.00	0	2020-07-16 09:15:21.6205+00	1	120
85	130.00	0	2020-07-16 09:15:21.629326+00	1	121
86	130.00	0	2020-07-16 09:15:21.637541+00	1	122
87	130.00	0	2020-07-16 09:15:21.646368+00	1	123
88	130.00	0	2020-07-16 09:15:21.654988+00	1	124
89	130.00	0	2020-07-16 09:15:21.66385+00	1	125
90	130.00	0	2020-07-16 09:15:21.672549+00	1	126
91	130.00	0	2020-07-16 09:15:21.68143+00	1	127
92	130.00	0	2020-07-16 09:15:21.692558+00	1	128
93	130.00	0	2020-07-16 09:15:21.702041+00	1	129
94	130.00	0	2020-07-16 09:15:21.710984+00	1	130
95	130.00	0	2020-07-16 09:15:21.721106+00	1	131
96	130.00	0	2020-07-16 09:15:21.7322+00	1	132
97	130.00	0	2020-07-16 09:15:21.741617+00	1	133
98	130.00	0	2020-07-16 09:15:21.751938+00	1	134
99	130.00	0	2020-07-16 09:15:21.761515+00	1	135
100	130.00	0	2020-07-16 09:15:21.771447+00	1	136
101	130.00	0	2020-07-16 09:15:21.780959+00	1	137
102	130.00	5	2020-07-16 09:15:21.790556+00	1	138
103	130.00	5	2020-07-16 09:15:21.800504+00	1	139
104	130.00	6	2020-07-16 09:15:21.810343+00	1	140
105	130.00	5	2020-07-16 09:15:21.819154+00	1	141
106	130.00	4	2020-07-16 09:15:21.828341+00	1	142
107	130.00	6	2020-07-16 09:15:21.837249+00	1	143
108	130.00	1	2020-07-16 09:15:21.847133+00	1	144
109	130.00	3	2020-07-16 09:15:21.857575+00	1	145
110	130.00	5	2020-07-16 09:15:21.868659+00	1	146
111	130.00	5	2020-07-16 09:15:21.879734+00	1	147
112	130.00	2	2020-07-16 09:15:21.890219+00	1	148
113	130.00	3	2020-07-16 09:15:21.900767+00	1	149
114	130.00	1	2020-07-16 09:15:21.910598+00	1	150
115	130.00	1	2020-07-16 09:15:21.920674+00	1	151
116	130.00	0	2020-07-16 09:15:21.930844+00	1	152
117	130.00	0	2020-07-16 09:15:21.940991+00	1	153
118	130.00	0	2020-07-16 09:15:21.950804+00	1	154
139	80.00	0	2020-07-16 14:39:38.866386+00	1	174
140	80.00	0	2020-07-16 14:39:38.874327+00	1	175
141	80.00	0	2020-07-16 14:39:38.880118+00	1	176
142	80.00	0	2020-07-16 14:39:38.885672+00	1	177
143	80.00	0	2020-07-16 14:39:38.891926+00	1	178
144	80.00	0	2020-07-16 14:39:38.898178+00	1	179
145	80.00	0	2020-07-16 14:39:38.905218+00	1	180
146	80.00	0	2020-07-16 14:39:38.912557+00	1	181
147	80.00	0	2020-07-16 14:39:38.919119+00	1	182
148	80.00	0	2020-07-16 14:39:38.926827+00	1	183
149	80.00	0	2020-07-16 14:39:38.932725+00	1	184
150	80.00	3	2020-07-16 14:39:38.9393+00	1	185
151	80.00	2	2020-07-16 14:39:38.945945+00	1	186
167	85.00	34	2020-09-15 22:36:13.587212+00	1	11
153	80.00	5	2020-07-16 14:39:38.95909+00	1	188
154	80.00	4	2020-07-16 14:39:38.965299+00	1	189
155	80.00	3	2020-07-16 14:39:38.9719+00	1	190
159	80.00	2	2020-09-13 13:17:39.259297+00	1	194
157	80.00	2	2020-07-16 14:39:38.985157+00	1	192
156	80.00	1	2020-09-13 13:17:11.104992+00	1	191
207	320.00	10	2020-07-26 07:05:03.863747+00	1	34
210	90.00	8	2020-07-26 07:14:12.590013+00	2	11
211	90.00	2	2020-07-26 07:14:12.605757+00	2	202
212	90.00	2	2020-07-26 07:14:12.617234+00	2	203
213	90.00	0	2020-07-26 07:14:12.623379+00	2	204
214	90.00	2	2020-07-26 07:14:12.629242+00	2	205
215	90.00	2	2020-07-26 07:14:12.635118+00	2	206
216	90.00	0	2020-07-26 07:14:12.645957+00	2	207
217	90.00	0	2020-07-26 07:14:12.652146+00	2	208
218	132.00	8	2020-07-26 07:14:39.457306+00	2	12
219	132.00	0	2020-07-26 07:14:39.470342+00	2	209
220	132.00	1	2020-07-26 07:14:39.477152+00	2	210
221	132.00	0	2020-07-26 07:14:39.483711+00	2	211
222	132.00	5	2020-07-26 07:14:39.489337+00	2	212
223	132.00	0	2020-07-26 07:14:39.495138+00	2	213
224	132.00	2	2020-07-26 07:14:39.501978+00	2	214
225	132.00	0	2020-07-26 07:14:39.508558+00	2	215
119	80.00	30	2020-07-16 14:39:38.72874+00	1	17
120	80.00	0	2020-07-16 14:39:38.739809+00	1	155
121	80.00	0	2020-07-16 14:39:38.746784+00	1	156
122	80.00	0	2020-07-16 14:39:38.753876+00	1	157
123	80.00	0	2020-07-16 14:39:38.760754+00	1	158
124	80.00	0	2020-07-16 14:39:38.768057+00	1	159
125	80.00	0	2020-07-16 14:39:38.775497+00	1	160
126	80.00	0	2020-07-16 14:39:38.781303+00	1	161
127	80.00	0	2020-07-16 14:39:38.787982+00	1	162
128	80.00	0	2020-07-16 14:39:38.794564+00	1	163
129	80.00	0	2020-07-16 14:39:38.800046+00	1	164
130	80.00	0	2020-07-16 14:39:38.807742+00	1	165
131	80.00	0	2020-07-16 14:39:38.813942+00	1	166
132	80.00	0	2020-07-16 14:39:38.820667+00	1	167
133	80.00	0	2020-07-16 14:39:38.827496+00	1	168
134	80.00	0	2020-07-16 14:39:38.833667+00	1	169
135	80.00	0	2020-07-16 14:39:38.840364+00	1	170
136	80.00	0	2020-07-16 14:39:38.846491+00	1	171
137	80.00	0	2020-07-16 14:39:38.853228+00	1	172
138	80.00	0	2020-07-16 14:39:38.859971+00	1	173
158	80.00	1	2020-09-13 13:17:52.767793+00	1	193
160	80.00	1	2020-07-16 14:39:39.005742+00	1	195
161	80.00	0	2020-07-16 14:39:39.0127+00	1	196
162	80.00	0	2020-07-16 14:39:39.019457+00	1	197
163	80.00	0	2020-07-16 14:39:39.025732+00	1	198
164	80.00	0	2020-07-16 14:39:39.031698+00	1	199
165	80.00	0	2020-07-16 14:39:39.038942+00	1	200
166	80.00	0	2020-07-16 14:39:39.045242+00	1	201
183	80.00	23	2020-07-26 07:03:15.569327+00	1	2
184	80.00	2	2020-07-26 07:03:15.585871+00	1	216
185	80.00	2	2020-07-26 07:03:15.595902+00	1	217
186	80.00	4	2020-07-26 07:03:15.605141+00	1	218
187	80.00	5	2020-07-26 07:03:15.61459+00	1	219
188	80.00	4	2020-07-26 07:03:15.624491+00	1	220
189	80.00	4	2020-07-26 07:03:15.635404+00	1	221
190	80.00	2	2020-07-26 07:03:15.645386+00	1	222
191	130.00	20	2020-07-26 07:03:36.056906+00	1	3
198	130.00	1	2020-07-26 07:03:36.146221+00	1	229
199	45.00	21	2020-07-26 07:04:37.651432+00	1	10
200	45.00	2	2020-07-26 07:04:37.667878+00	1	230
201	45.00	2	2020-07-26 07:04:37.678652+00	1	231
202	45.00	3	2020-07-26 07:04:37.689957+00	1	232
203	45.00	4	2020-07-26 07:04:37.699181+00	1	233
204	45.00	5	2020-07-26 07:04:37.709818+00	1	234
205	45.00	2	2020-07-26 07:04:37.718428+00	1	235
206	45.00	3	2020-07-26 07:04:37.727753+00	1	236
227	90.00	0	2020-07-26 07:15:25.853709+00	2	87
228	90.00	0	2020-07-26 07:15:25.860385+00	2	88
229	90.00	0	2020-07-26 07:15:25.867882+00	2	89
230	90.00	0	2020-07-26 07:15:25.874336+00	2	90
231	90.00	0	2020-07-26 07:15:25.880325+00	2	91
232	90.00	0	2020-07-26 07:15:25.886784+00	2	92
233	90.00	0	2020-07-26 07:15:25.894156+00	2	93
234	90.00	0	2020-07-26 07:15:25.900817+00	2	94
235	90.00	0	2020-07-26 07:15:25.907166+00	2	95
236	90.00	0	2020-07-26 07:15:25.914377+00	2	96
237	90.00	5	2020-07-26 07:15:25.921003+00	2	97
238	90.00	4	2020-07-26 07:15:25.927826+00	2	98
239	90.00	0	2020-07-26 07:15:25.934262+00	2	99
240	90.00	0	2020-07-26 07:15:25.940549+00	2	100
242	90.00	0	2020-07-26 07:15:25.954533+00	2	102
243	90.00	0	2020-07-26 07:15:25.960611+00	2	103
196	130.00	3	2020-09-13 12:02:03.978404+00	1	227
194	130.00	0	2020-09-13 12:01:13.433983+00	1	225
197	130.00	0	2020-09-13 12:11:42.629323+00	1	228
195	130.00	2	2020-09-13 12:12:00.465535+00	1	226
193	130.00	0	2020-09-13 12:12:11.896803+00	1	224
168	85.00	3	2020-09-15 22:36:13.598806+00	1	202
169	85.00	3	2020-09-15 22:36:13.608548+00	1	203
170	85.00	5	2020-09-15 22:36:13.616076+00	1	204
171	85.00	12	2020-09-15 22:36:13.624887+00	1	205
172	85.00	4	2020-09-15 22:36:13.633041+00	1	206
173	85.00	5	2020-09-15 22:36:13.641653+00	1	207
208	300.00	4	2020-09-15 22:40:55.217272+00	1	33
209	31.00	5	2020-09-15 22:37:16.872584+00	1	25
175	110.00	17	2020-09-15 22:43:51.378151+00	1	12
176	110.00	2	2020-09-15 22:43:51.390947+00	1	209
177	110.00	3	2020-09-15 22:43:51.400169+00	1	210
178	110.00	3	2020-09-15 22:43:51.40795+00	1	211
179	110.00	5	2020-09-15 22:43:51.416056+00	1	212
180	110.00	2	2020-09-15 22:43:51.425291+00	1	213
181	110.00	1	2020-09-15 22:43:51.433291+00	1	214
182	110.00	1	2020-09-15 22:43:51.442558+00	1	215
192	130.00	1	2020-09-16 07:22:52.653975+00	1	223
152	80.00	2	2020-09-16 07:23:04.259559+00	1	187
226	90.00	15	2020-07-26 07:15:25.842699+00	2	85
241	90.00	6	2020-07-26 07:15:25.947415+00	2	101
244	90.00	0	2020-07-26 07:15:25.967372+00	2	104
245	90.00	0	2020-07-26 07:15:25.973763+00	2	105
246	90.00	0	2020-07-26 07:15:25.983585+00	2	106
247	90.00	0	2020-07-26 07:15:25.990964+00	2	107
248	120.00	20	2020-07-26 07:16:06.815017+00	2	16
249	120.00	0	2020-07-26 07:16:06.822754+00	2	108
250	120.00	0	2020-07-26 07:16:06.828162+00	2	109
251	120.00	0	2020-07-26 07:16:06.835282+00	2	110
252	120.00	0	2020-07-26 07:16:06.840698+00	2	111
253	120.00	0	2020-07-26 07:16:06.847463+00	2	112
254	120.00	0	2020-07-26 07:16:06.854627+00	2	113
255	120.00	0	2020-07-26 07:16:06.860591+00	2	114
256	120.00	0	2020-07-26 07:16:06.868109+00	2	115
257	120.00	0	2020-07-26 07:16:06.874232+00	2	116
258	120.00	0	2020-07-26 07:16:06.880603+00	2	117
259	120.00	0	2020-07-26 07:16:06.886859+00	2	118
260	120.00	0	2020-07-26 07:16:06.892447+00	2	119
261	120.00	0	2020-07-26 07:16:06.899231+00	2	120
262	120.00	0	2020-07-26 07:16:06.906184+00	2	121
263	120.00	0	2020-07-26 07:16:06.911949+00	2	122
264	120.00	0	2020-07-26 07:16:06.918166+00	2	123
265	120.00	0	2020-07-26 07:16:06.924611+00	2	124
266	120.00	0	2020-07-26 07:16:06.93204+00	2	125
267	120.00	0	2020-07-26 07:16:06.937873+00	2	126
268	120.00	0	2020-07-26 07:16:06.945626+00	2	127
269	120.00	0	2020-07-26 07:16:06.952776+00	2	128
270	120.00	0	2020-07-26 07:16:06.959053+00	2	129
271	120.00	0	2020-07-26 07:16:06.965812+00	2	130
272	120.00	0	2020-07-26 07:16:06.971632+00	2	131
273	120.00	0	2020-07-26 07:16:06.978453+00	2	132
274	120.00	0	2020-07-26 07:16:06.984973+00	2	133
275	120.00	0	2020-07-26 07:16:06.99179+00	2	134
276	120.00	0	2020-07-26 07:16:06.998828+00	2	135
277	120.00	0	2020-07-26 07:16:07.005063+00	2	136
278	120.00	0	2020-07-26 07:16:07.011714+00	2	137
279	120.00	0	2020-07-26 07:16:07.018466+00	2	138
280	120.00	0	2020-07-26 07:16:07.025283+00	2	139
281	120.00	0	2020-07-26 07:16:07.032865+00	2	140
282	120.00	0	2020-07-26 07:16:07.039249+00	2	141
283	120.00	0	2020-07-26 07:16:07.046295+00	2	142
284	120.00	3	2020-07-26 07:16:07.05319+00	2	143
285	120.00	0	2020-07-26 07:16:07.060516+00	2	144
286	120.00	0	2020-07-26 07:16:07.066789+00	2	145
287	120.00	3	2020-07-26 07:16:07.072826+00	2	146
288	120.00	5	2020-07-26 07:16:07.079024+00	2	147
289	120.00	0	2020-07-26 07:16:07.084905+00	2	148
290	120.00	0	2020-07-26 07:16:07.091014+00	2	149
291	120.00	2	2020-07-26 07:16:07.097271+00	2	150
292	120.00	1	2020-07-26 07:16:07.104213+00	2	151
293	120.00	5	2020-07-26 07:16:07.110548+00	2	152
294	120.00	1	2020-07-26 07:16:07.116911+00	2	153
295	120.00	0	2020-07-26 07:16:07.122534+00	2	154
296	92.00	8	2020-07-26 07:16:52.75732+00	2	2
297	92.00	0	2020-07-26 07:16:52.769022+00	2	216
298	92.00	3	2020-07-26 07:16:52.774808+00	2	217
299	92.00	0	2020-07-26 07:16:52.780696+00	2	218
300	92.00	1	2020-07-26 07:16:52.787427+00	2	219
301	92.00	0	2020-07-26 07:16:52.793636+00	2	220
302	92.00	2	2020-07-26 07:16:52.800551+00	2	221
303	92.00	2	2020-07-26 07:16:52.806847+00	2	222
304	318.00	3	2020-07-26 07:17:10.236108+00	2	34
307	312.00	4	2020-09-15 22:03:23.846467+00	4	33
308	280.00	6	2020-09-15 22:07:15.912908+00	4	31
309	170.00	6	2020-09-15 22:09:42.359016+00	4	32
310	335.00	10	2020-09-15 22:12:05.704307+00	4	34
311	58.00	12	2020-09-15 22:14:31.170591+00	4	27
312	260.00	6	2020-09-15 22:21:14.576657+00	4	35
313	85.00	42	2020-09-15 22:23:21.609413+00	4	85
314	85.00	0	2020-09-15 22:23:21.622707+00	4	87
315	85.00	0	2020-09-15 22:23:21.631662+00	4	88
316	85.00	5	2020-09-15 22:23:21.640617+00	4	89
317	85.00	6	2020-09-15 22:23:21.649205+00	4	90
318	85.00	5	2020-09-15 22:23:21.657999+00	4	91
319	85.00	2	2020-09-15 22:23:21.666721+00	4	92
320	85.00	3	2020-09-15 22:23:21.675551+00	4	93
321	85.00	3	2020-09-15 22:23:21.68396+00	4	94
322	85.00	3	2020-09-15 22:23:21.692664+00	4	95
323	85.00	0	2020-09-15 22:23:21.701118+00	4	96
324	85.00	3	2020-09-15 22:23:21.709403+00	4	97
325	85.00	0	2020-09-15 22:23:21.71862+00	4	98
327	85.00	2	2020-09-15 22:23:21.736799+00	4	100
328	85.00	4	2020-09-15 22:23:21.745301+00	4	101
329	85.00	2	2020-09-15 22:23:21.753457+00	4	102
330	85.00	0	2020-09-15 22:23:21.761396+00	4	103
331	85.00	0	2020-09-15 22:23:21.769853+00	4	104
332	85.00	0	2020-09-15 22:23:21.77903+00	4	105
333	85.00	0	2020-09-15 22:23:21.78792+00	4	106
334	85.00	0	2020-09-15 22:23:21.796581+00	4	107
326	85.00	3	2020-09-15 22:24:30.05482+00	4	99
174	85.00	2	2020-09-15 22:36:13.650626+00	1	208
306	47.00	2	2020-09-15 22:45:10.244435+00	2	27
305	280.00	2	2020-09-16 07:23:04.28741+00	2	35
\.


--
-- Data for Name: main_seller; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.main_seller (user_id) FROM stdin;
11
12
68
\.


--
-- Data for Name: main_user; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.main_user (id, password, last_login, is_superuser, is_staff, is_active, date_joined, email, first_name, last_name, is_seller, is_customer) FROM stdin;
3	pbkdf2_sha256$150000$ffCqEbJ1y29S$4/XncdAw5eAV3xPk14KQ+Ynwvbn8LNDQwSUpAH1WY1k=	2020-07-16 08:10:18+00	f	f	t	2020-07-16 08:09:43+00	kostasgri@gmail.com	Κωνσταντίνος	Γρηγοριάδης	f	t
4	sdd1213	\N	f	f	t	2020-07-16 08:25:53.656087+00	giorgos@gmail.com	Γιώργος	Χρήστου	f	t
5	sdd1213	\N	f	f	t	2020-07-16 08:25:53.668558+00	dimitra@gmail.com	Δήμητρα	Παπαδοπούλου	f	t
6	sdd1213	\N	f	f	t	2020-07-16 08:25:53.680361+00	giannis@gmail.com	Γιάννης	Ρίζος	f	t
7	sdd1213	\N	f	f	t	2020-07-16 08:25:53.692377+00	dimitris@gmail.com	Δημήτρης	Λημνιός	f	t
8	sdd1213	\N	f	f	t	2020-07-16 08:25:53.70483+00	vieirinha@gmail.com	Adelino	Vieirinha	f	t
9	sdd1213	\N	f	f	t	2020-07-16 08:25:53.716727+00	swiderski@gmail.com	Karol	Swiderski	f	t
10	sdd1213	\N	f	f	t	2020-07-16 08:25:53.728037+00	ioannapap@gmail.com	Ιωάννα	Παπαδοπούλου	f	t
69	pbkdf2_sha256$150000$dvbRAtt0tGgb$GjTffjgBl63t1vdUAIDcKT6FJMGi2pfIkFWZKpzbsIo=	\N	f	f	t	2020-09-15 22:40:23.895597+00	spiros@gmail.com	Σπύρος	Δήμου	f	t
11	pbkdf2_sha256$150000$Iwxp2HJnQepj$oAD4Jq8D268Dkvy7oLNSj0O4Z3jC5Cd/fSH4o+cHqFc=	2020-09-16 07:23:27.772308+00	f	f	t	2020-07-16 08:32:48.636652+00	spirosdimou2@gmail.com	Σπύρος	Δήμου	t	f
1	pbkdf2_sha256$150000$uANgVafamsml$Cbpeu0+Pcx5YoBht0vGL6410WyRHdGOfNyGukqJ11J0=	2020-09-16 07:24:22.798266+00	t	t	t	2020-07-16 07:50:28.70176+00	spirosdimou2@hotmail.gr			f	f
2	pbkdf2_sha256$150000$iIieKvAzZjJ0$iorOV3GWUPYOxWREqEIpOsTkocYeLX/7GZ/RNOZQmxA=	\N	f	f	t	2020-07-16 08:01:17.963065+00	maria@gmail.com	Μαρία	Παπά	f	t
12	pbkdf2_sha256$150000$QbLbjvU11E21$5LnDOJ4i6EspXwjy4XujQb8Hk+impr85+uiiINRL8c0=	2020-09-02 16:14:13.721144+00	f	f	t	2020-07-26 07:06:55.012626+00	vasiliki@gmail.com	Βασιλική	Σπυρίδου	t	f
68	pbkdf2_sha256$150000$g65XX5ATGocF$VkVXVc8uuw8G/g7LXwgKcygJ2qSypZa45Sq1k1k9dx8=	2020-09-15 21:51:12.004167+00	f	f	t	2020-09-15 21:51:11.74239+00	ch.tzolis@gmail.com	Χρήστος	Τζόλης	t	f
\.


--
-- Data for Name: main_user_groups; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.main_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: main_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.main_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: main_wallet; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.main_wallet (product_ptr_id, type, type_of_closing, color, material) FROM stdin;
26	CARDS	CLIP	brown	LEATHER
28	TRAVEL	ZIPPER	gray	TEXTILE
29	OTHER	VELCRO	pink	TEXTILE
30	CLASSIC	CLASP	red	LEATHER
27	CLASSIC	CLIP	black	LEATHER
\.


--
-- Data for Name: main_watch; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.main_watch (product_ptr_id, display, mechanism, band_material, band_color, face_color, water_resistance) FROM stdin;
32	DIGITAL	SOLAR	METAL	gold	gold	5
36	ANALOG	BATERY	METAL	lightpink	black	5
37	ANALOG	BATERY	TEXTILE	black	black	5
33	ANALOG	BATERY	LEATHER	brown	beige	5
31	ANALOG	BATERY	METAL	silver	blue	5
34	ANALOG	BATERY	LEATHER	brown	blue	5
35	ANALOG	BATERY	METAL	lightpink	lightpink	5
\.


--
-- Data for Name: taggit_tag; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.taggit_tag (id, name, slug) FROM stdin;
1	μπουφάν ,	
2	 Bodytalk,	bodytalk
4	Αδιάβροχο,	_1
6	Αθλητικό,	_2
7	Nike,	nike
9	μπουφάν,	_3
10	assos,	assos
11	only,	only
12	adidas,	adidas
13	bugaboo,	bugaboo
15	αντιανεμικό,	_4
16	ugg,	ugg
18	Μποτάκια,	_5
19	Tommy Hilfiger,	tommy-hilfiger
20	Tamaris,	tamaris
22	δερμάτινες μπότες,	_6
24	γόβες,	_7
26	δερμάτινες,	_8
27	Mourzi,	mourzi
29	δερμάτινες γόβες,	_9
31	τσάντα ώμου,	_10
32	Replay,	replay
34	δερμάτινη τσάντα,	_11
35	 bags,	bags
36	Casual,	casual
38	Βραδινά,	_12
40	Γυναικεία,	_13
42	Επίσημα,	_14
44	Καθημερινά,	_15
46	Τσαντα χεριου,	_16
48	Τσαντες χιαστι,	_17
50	τσάντα χιαστή,	_18
51	Beverly Hills Polo Club,	beverly-hills-polo-club
52	Trussardi,	trussardi
54	δερματίνη,	_19
55	National Geographic,	national-geographic
56	backpack,	backpack
58	πορτοφόλι,	_20
60	κάρτες,	_21
61	Tru Virtu,	tru-virtu
62	Bifold,	bifold
63	Lifeventure,	lifeventure
64	Puma,	puma
65	Verde,	verde
67	χρονογράφος,	_22
68	Emporio Armani,	emporio-armani
70	ρολόι,	_23
71	casio,	casio
72	timperland,	timperland
73	Michael Kors,	michael-kors
75	γυναικείο,	_24
76	Daniel Wellington,	daniel-wellington
77	Timberland	timberland
78	dermatino	dermatino
80	bugaboo	bugaboo_1
81	Columbia	columbia
83	μπουφάν	_25
85	ρολόι	_26
86	roloi	roloi
88	Emporio Armani	emporio-armani_1
90	δερμάτινο	_27
92	tommy hilfiger	tommy-hilfiger_1
94	Bifold	bifold_1
96	πορτοφόλι	_28
98	Michael Kors	michael-kors_1
\.


--
-- Data for Name: taggit_taggeditem; Type: TABLE DATA; Schema: public; Owner: spirosdim
--

COPY public.taggit_taggeditem (id, object_id, content_type_id, tag_id) FROM stdin;
1	1	13	1
2	1	13	2
3	2	13	4
4	2	13	6
5	2	13	7
6	3	13	4
7	3	13	6
8	3	13	7
9	4	13	9
10	4	13	10
11	5	13	9
12	5	13	10
13	6	13	9
14	6	13	11
15	7	13	4
16	7	13	6
17	7	13	7
18	8	13	9
19	8	13	11
20	9	13	4
21	9	13	6
22	9	13	12
23	10	13	4
24	10	13	6
27	12	13	9
28	12	13	15
29	13	13	9
30	14	13	9
31	15	13	16
32	15	13	18
33	16	13	19
34	16	13	18
35	17	13	16
36	17	13	18
37	18	13	20
38	18	13	22
39	19	13	19
40	19	13	22
41	20	13	20
42	20	13	24
43	20	13	26
44	21	13	27
45	21	13	29
46	22	13	31
47	22	13	32
48	22	13	34
49	22	13	35
50	22	13	36
51	22	13	38
52	22	13	40
53	22	13	42
54	22	13	44
55	22	13	46
56	22	13	48
57	23	13	50
58	23	13	51
59	23	13	34
60	24	13	50
61	24	13	52
62	24	13	54
63	25	13	55
64	25	13	56
65	26	13	58
66	26	13	60
67	26	13	61
71	28	13	63
72	28	13	58
73	29	13	64
74	29	13	58
75	30	13	65
76	30	13	58
79	32	13	70
80	32	13	71
88	36	13	76
89	36	13	70
90	36	13	75
91	37	13	76
92	37	13	70
93	37	13	75
94	86	13	77
95	86	13	78
96	11	13	80
97	11	13	81
98	11	13	83
99	33	13	77
100	33	13	85
101	31	13	88
102	31	13	86
103	34	13	90
104	34	13	92
105	34	13	85
106	27	13	96
107	27	13	92
108	27	13	94
109	35	13	98
110	35	13	86
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: spirosdim
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: spirosdim
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: spirosdim
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 116, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: spirosdim
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 214, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: spirosdim
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 29, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: spirosdim
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 26, true);


--
-- Name: main_company_id_seq; Type: SEQUENCE SET; Schema: public; Owner: spirosdim
--

SELECT pg_catalog.setval('public.main_company_id_seq', 4, true);


--
-- Name: main_companycategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: spirosdim
--

SELECT pg_catalog.setval('public.main_companycategory_id_seq', 3, true);


--
-- Name: main_favorite_id_seq; Type: SEQUENCE SET; Schema: public; Owner: spirosdim
--

SELECT pg_catalog.setval('public.main_favorite_id_seq', 72, true);


--
-- Name: main_location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: spirosdim
--

SELECT pg_catalog.setval('public.main_location_id_seq', 4, true);


--
-- Name: main_manufacturer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: spirosdim
--

SELECT pg_catalog.setval('public.main_manufacturer_id_seq', 29, true);


--
-- Name: main_offer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: spirosdim
--

SELECT pg_catalog.setval('public.main_offer_id_seq', 7, true);


--
-- Name: main_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: spirosdim
--

SELECT pg_catalog.setval('public.main_product_id_seq', 236, true);


--
-- Name: main_productcategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: spirosdim
--

SELECT pg_catalog.setval('public.main_productcategory_id_seq', 33, true);


--
-- Name: main_productimage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: spirosdim
--

SELECT pg_catalog.setval('public.main_productimage_id_seq', 65, true);


--
-- Name: main_sale_id_seq; Type: SEQUENCE SET; Schema: public; Owner: spirosdim
--

SELECT pg_catalog.setval('public.main_sale_id_seq', 101, true);


--
-- Name: main_salesproduct_id_seq; Type: SEQUENCE SET; Schema: public; Owner: spirosdim
--

SELECT pg_catalog.setval('public.main_salesproduct_id_seq', 334, true);


--
-- Name: main_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: spirosdim
--

SELECT pg_catalog.setval('public.main_user_groups_id_seq', 1, false);


--
-- Name: main_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: spirosdim
--

SELECT pg_catalog.setval('public.main_user_id_seq', 69, true);


--
-- Name: main_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: spirosdim
--

SELECT pg_catalog.setval('public.main_user_user_permissions_id_seq', 1, false);


--
-- Name: taggit_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: spirosdim
--

SELECT pg_catalog.setval('public.taggit_tag_id_seq', 98, true);


--
-- Name: taggit_taggeditem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: spirosdim
--

SELECT pg_catalog.setval('public.taggit_taggeditem_id_seq', 110, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: authtoken_token authtoken_token_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_pkey PRIMARY KEY (key);


--
-- Name: authtoken_token authtoken_token_user_id_key; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_key UNIQUE (user_id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: main_bag main_bag_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_bag
    ADD CONSTRAINT main_bag_pkey PRIMARY KEY (product_ptr_id);


--
-- Name: main_clothingproduct main_clothingproduct_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_clothingproduct
    ADD CONSTRAINT main_clothingproduct_pkey PRIMARY KEY (product_ptr_id);


--
-- Name: main_company main_company_owner_id_key; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_company
    ADD CONSTRAINT main_company_owner_id_key UNIQUE (owner_id);


--
-- Name: main_company main_company_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_company
    ADD CONSTRAINT main_company_pkey PRIMARY KEY (id);


--
-- Name: main_companycategory main_companycategory_name_key; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_companycategory
    ADD CONSTRAINT main_companycategory_name_key UNIQUE (name);


--
-- Name: main_companycategory main_companycategory_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_companycategory
    ADD CONSTRAINT main_companycategory_pkey PRIMARY KEY (id);


--
-- Name: main_companylocation main_companylocation_company_id_key; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_companylocation
    ADD CONSTRAINT main_companylocation_company_id_key UNIQUE (company_id);


--
-- Name: main_companylocation main_companylocation_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_companylocation
    ADD CONSTRAINT main_companylocation_pkey PRIMARY KEY (location_ptr_id);


--
-- Name: main_customer main_customer_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_customer
    ADD CONSTRAINT main_customer_pkey PRIMARY KEY (user_id);


--
-- Name: main_customerlocation main_customerlocation_customer_id_key; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_customerlocation
    ADD CONSTRAINT main_customerlocation_customer_id_key UNIQUE (customer_id);


--
-- Name: main_customerlocation main_customerlocation_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_customerlocation
    ADD CONSTRAINT main_customerlocation_pkey PRIMARY KEY (location_ptr_id);


--
-- Name: main_favorite main_favorite_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_favorite
    ADD CONSTRAINT main_favorite_pkey PRIMARY KEY (id);


--
-- Name: main_footwearproduct main_footwearproduct_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_footwearproduct
    ADD CONSTRAINT main_footwearproduct_pkey PRIMARY KEY (product_ptr_id);


--
-- Name: main_location main_location_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_location
    ADD CONSTRAINT main_location_pkey PRIMARY KEY (id);


--
-- Name: main_manufacturer main_manufacturer_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_manufacturer
    ADD CONSTRAINT main_manufacturer_pkey PRIMARY KEY (id);


--
-- Name: main_offer main_offer_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_offer
    ADD CONSTRAINT main_offer_pkey PRIMARY KEY (id);


--
-- Name: main_product main_product_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_product
    ADD CONSTRAINT main_product_pkey PRIMARY KEY (id);


--
-- Name: main_productcategory main_productcategory_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_productcategory
    ADD CONSTRAINT main_productcategory_pkey PRIMARY KEY (id);


--
-- Name: main_productimage main_productimage_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_productimage
    ADD CONSTRAINT main_productimage_pkey PRIMARY KEY (id);


--
-- Name: main_sale main_sale_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_sale
    ADD CONSTRAINT main_sale_pkey PRIMARY KEY (id);


--
-- Name: main_salesproduct main_salesproduct_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_salesproduct
    ADD CONSTRAINT main_salesproduct_pkey PRIMARY KEY (id);


--
-- Name: main_seller main_seller_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_seller
    ADD CONSTRAINT main_seller_pkey PRIMARY KEY (user_id);


--
-- Name: main_user main_user_email_key; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_user
    ADD CONSTRAINT main_user_email_key UNIQUE (email);


--
-- Name: main_user_groups main_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_user_groups
    ADD CONSTRAINT main_user_groups_pkey PRIMARY KEY (id);


--
-- Name: main_user_groups main_user_groups_user_id_group_id_ae195797_uniq; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_user_groups
    ADD CONSTRAINT main_user_groups_user_id_group_id_ae195797_uniq UNIQUE (user_id, group_id);


--
-- Name: main_user main_user_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_user
    ADD CONSTRAINT main_user_pkey PRIMARY KEY (id);


--
-- Name: main_user_user_permissions main_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_user_user_permissions
    ADD CONSTRAINT main_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: main_user_user_permissions main_user_user_permissions_user_id_permission_id_96b9fadf_uniq; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_user_user_permissions
    ADD CONSTRAINT main_user_user_permissions_user_id_permission_id_96b9fadf_uniq UNIQUE (user_id, permission_id);


--
-- Name: main_wallet main_wallet_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_wallet
    ADD CONSTRAINT main_wallet_pkey PRIMARY KEY (product_ptr_id);


--
-- Name: main_watch main_watch_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_watch
    ADD CONSTRAINT main_watch_pkey PRIMARY KEY (product_ptr_id);


--
-- Name: taggit_tag taggit_tag_name_key; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.taggit_tag
    ADD CONSTRAINT taggit_tag_name_key UNIQUE (name);


--
-- Name: taggit_tag taggit_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.taggit_tag
    ADD CONSTRAINT taggit_tag_pkey PRIMARY KEY (id);


--
-- Name: taggit_tag taggit_tag_slug_key; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.taggit_tag
    ADD CONSTRAINT taggit_tag_slug_key UNIQUE (slug);


--
-- Name: taggit_taggeditem taggit_taggeditem_content_type_id_object_i_4bb97a8e_uniq; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.taggit_taggeditem
    ADD CONSTRAINT taggit_taggeditem_content_type_id_object_i_4bb97a8e_uniq UNIQUE (content_type_id, object_id, tag_id);


--
-- Name: taggit_taggeditem taggit_taggeditem_pkey; Type: CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.taggit_taggeditem
    ADD CONSTRAINT taggit_taggeditem_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: authtoken_token_key_10f0b77e_like; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX authtoken_token_key_10f0b77e_like ON public.authtoken_token USING btree (key varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: main_company_category_id_99274020; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_company_category_id_99274020 ON public.main_company USING btree (category_id);


--
-- Name: main_company_slug_3e49a6e4; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_company_slug_3e49a6e4 ON public.main_company USING btree (slug);


--
-- Name: main_company_slug_3e49a6e4_like; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_company_slug_3e49a6e4_like ON public.main_company USING btree (slug varchar_pattern_ops);


--
-- Name: main_companycategory_name_61e717a3_like; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_companycategory_name_61e717a3_like ON public.main_companycategory USING btree (name varchar_pattern_ops);


--
-- Name: main_companycategory_parent_id_426fc998; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_companycategory_parent_id_426fc998 ON public.main_companycategory USING btree (parent_id);


--
-- Name: main_companycategory_slug_15bb9a4e; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_companycategory_slug_15bb9a4e ON public.main_companycategory USING btree (slug);


--
-- Name: main_companycategory_slug_15bb9a4e_like; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_companycategory_slug_15bb9a4e_like ON public.main_companycategory USING btree (slug varchar_pattern_ops);


--
-- Name: main_companycategory_tree_id_6e69ca39; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_companycategory_tree_id_6e69ca39 ON public.main_companycategory USING btree (tree_id);


--
-- Name: main_favorite_customer_id_f33f7451; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_favorite_customer_id_f33f7451 ON public.main_favorite USING btree (customer_id);


--
-- Name: main_favorite_product_id_2dbba92b; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_favorite_product_id_2dbba92b ON public.main_favorite USING btree (product_id);


--
-- Name: main_location_slug_97efd6ed; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_location_slug_97efd6ed ON public.main_location USING btree (slug);


--
-- Name: main_location_slug_97efd6ed_like; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_location_slug_97efd6ed_like ON public.main_location USING btree (slug varchar_pattern_ops);


--
-- Name: main_manufacturer_slug_f7cced3d; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_manufacturer_slug_f7cced3d ON public.main_manufacturer USING btree (slug);


--
-- Name: main_manufacturer_slug_f7cced3d_like; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_manufacturer_slug_f7cced3d_like ON public.main_manufacturer USING btree (slug varchar_pattern_ops);


--
-- Name: main_offer_company_id_a3f9fd46; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_offer_company_id_a3f9fd46 ON public.main_offer USING btree (company_id);


--
-- Name: main_offer_offer_id_0623a5b0; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_offer_offer_id_0623a5b0 ON public.main_offer USING btree (offer_id);


--
-- Name: main_offer_product_id_500eb411; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_offer_product_id_500eb411 ON public.main_offer USING btree (product_id);


--
-- Name: main_product_category_id_c0d90f41; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_product_category_id_c0d90f41 ON public.main_product USING btree (category_id);


--
-- Name: main_product_manufacturer_id_0da06053; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_product_manufacturer_id_0da06053 ON public.main_product USING btree (manufacturer_id);


--
-- Name: main_product_parent_id_5367ad52; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_product_parent_id_5367ad52 ON public.main_product USING btree (parent_id);


--
-- Name: main_product_slug_85058272; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_product_slug_85058272 ON public.main_product USING btree (slug);


--
-- Name: main_product_slug_85058272_like; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_product_slug_85058272_like ON public.main_product USING btree (slug varchar_pattern_ops);


--
-- Name: main_productcategory_parent_id_ed19c5bc; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_productcategory_parent_id_ed19c5bc ON public.main_productcategory USING btree (parent_id);


--
-- Name: main_productcategory_slug_f1e1d37c; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_productcategory_slug_f1e1d37c ON public.main_productcategory USING btree (slug);


--
-- Name: main_productcategory_slug_f1e1d37c_like; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_productcategory_slug_f1e1d37c_like ON public.main_productcategory USING btree (slug varchar_pattern_ops);


--
-- Name: main_productcategory_tree_id_2d257ef4; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_productcategory_tree_id_2d257ef4 ON public.main_productcategory USING btree (tree_id);


--
-- Name: main_productimage_product_id_7c7e66ae; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_productimage_product_id_7c7e66ae ON public.main_productimage USING btree (product_id);


--
-- Name: main_sale_company_id_2d9466cc; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_sale_company_id_2d9466cc ON public.main_sale USING btree (company_id);


--
-- Name: main_sale_customer_id_4cb689a7; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_sale_customer_id_4cb689a7 ON public.main_sale USING btree (customer_id);


--
-- Name: main_sale_product_id_a5fc142c; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_sale_product_id_a5fc142c ON public.main_sale USING btree (product_id);


--
-- Name: main_salesproduct_company_id_df7ac0bc; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_salesproduct_company_id_df7ac0bc ON public.main_salesproduct USING btree (company_id);


--
-- Name: main_salesproduct_product_id_cc073be4; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_salesproduct_product_id_cc073be4 ON public.main_salesproduct USING btree (product_id);


--
-- Name: main_user_email_2597293b_like; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_user_email_2597293b_like ON public.main_user USING btree (email varchar_pattern_ops);


--
-- Name: main_user_groups_group_id_a337ba62; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_user_groups_group_id_a337ba62 ON public.main_user_groups USING btree (group_id);


--
-- Name: main_user_groups_user_id_df502602; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_user_groups_user_id_df502602 ON public.main_user_groups USING btree (user_id);


--
-- Name: main_user_user_permissions_permission_id_cd2b56a3; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_user_user_permissions_permission_id_cd2b56a3 ON public.main_user_user_permissions USING btree (permission_id);


--
-- Name: main_user_user_permissions_user_id_451ce57f; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX main_user_user_permissions_user_id_451ce57f ON public.main_user_user_permissions USING btree (user_id);


--
-- Name: taggit_tag_name_58eb2ed9_like; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX taggit_tag_name_58eb2ed9_like ON public.taggit_tag USING btree (name varchar_pattern_ops);


--
-- Name: taggit_tag_slug_6be58b2c_like; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX taggit_tag_slug_6be58b2c_like ON public.taggit_tag USING btree (slug varchar_pattern_ops);


--
-- Name: taggit_taggeditem_content_type_id_9957a03c; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX taggit_taggeditem_content_type_id_9957a03c ON public.taggit_taggeditem USING btree (content_type_id);


--
-- Name: taggit_taggeditem_content_type_id_object_id_196cc965_idx; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX taggit_taggeditem_content_type_id_object_id_196cc965_idx ON public.taggit_taggeditem USING btree (content_type_id, object_id);


--
-- Name: taggit_taggeditem_object_id_e2d7d1df; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX taggit_taggeditem_object_id_e2d7d1df ON public.taggit_taggeditem USING btree (object_id);


--
-- Name: taggit_taggeditem_tag_id_f4f5b767; Type: INDEX; Schema: public; Owner: spirosdim
--

CREATE INDEX taggit_taggeditem_tag_id_f4f5b767 ON public.taggit_taggeditem USING btree (tag_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authtoken_token authtoken_token_user_id_35299eff_fk_main_user_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_35299eff_fk_main_user_id FOREIGN KEY (user_id) REFERENCES public.main_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_main_user_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_main_user_id FOREIGN KEY (user_id) REFERENCES public.main_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_bag main_bag_product_ptr_id_63dcdd00_fk_main_product_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_bag
    ADD CONSTRAINT main_bag_product_ptr_id_63dcdd00_fk_main_product_id FOREIGN KEY (product_ptr_id) REFERENCES public.main_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_clothingproduct main_clothingproduct_product_ptr_id_a5c5aac6_fk_main_product_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_clothingproduct
    ADD CONSTRAINT main_clothingproduct_product_ptr_id_a5c5aac6_fk_main_product_id FOREIGN KEY (product_ptr_id) REFERENCES public.main_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_company main_company_category_id_99274020_fk_main_companycategory_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_company
    ADD CONSTRAINT main_company_category_id_99274020_fk_main_companycategory_id FOREIGN KEY (category_id) REFERENCES public.main_companycategory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_company main_company_owner_id_66a76e83_fk_main_seller_user_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_company
    ADD CONSTRAINT main_company_owner_id_66a76e83_fk_main_seller_user_id FOREIGN KEY (owner_id) REFERENCES public.main_seller(user_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_companycategory main_companycategory_parent_id_426fc998_fk_main_comp; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_companycategory
    ADD CONSTRAINT main_companycategory_parent_id_426fc998_fk_main_comp FOREIGN KEY (parent_id) REFERENCES public.main_companycategory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_companylocation main_companylocation_company_id_5fc6a2e4_fk_main_company_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_companylocation
    ADD CONSTRAINT main_companylocation_company_id_5fc6a2e4_fk_main_company_id FOREIGN KEY (company_id) REFERENCES public.main_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_companylocation main_companylocation_location_ptr_id_4e76ebbf_fk_main_loca; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_companylocation
    ADD CONSTRAINT main_companylocation_location_ptr_id_4e76ebbf_fk_main_loca FOREIGN KEY (location_ptr_id) REFERENCES public.main_location(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_customer main_customer_user_id_19b4dfa5_fk_main_user_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_customer
    ADD CONSTRAINT main_customer_user_id_19b4dfa5_fk_main_user_id FOREIGN KEY (user_id) REFERENCES public.main_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_customerlocation main_customerlocatio_customer_id_9dae6502_fk_main_cust; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_customerlocation
    ADD CONSTRAINT main_customerlocatio_customer_id_9dae6502_fk_main_cust FOREIGN KEY (customer_id) REFERENCES public.main_customer(user_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_customerlocation main_customerlocatio_location_ptr_id_b2af3a57_fk_main_loca; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_customerlocation
    ADD CONSTRAINT main_customerlocatio_location_ptr_id_b2af3a57_fk_main_loca FOREIGN KEY (location_ptr_id) REFERENCES public.main_location(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_favorite main_favorite_customer_id_f33f7451_fk_main_customer_user_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_favorite
    ADD CONSTRAINT main_favorite_customer_id_f33f7451_fk_main_customer_user_id FOREIGN KEY (customer_id) REFERENCES public.main_customer(user_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_favorite main_favorite_product_id_2dbba92b_fk_main_product_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_favorite
    ADD CONSTRAINT main_favorite_product_id_2dbba92b_fk_main_product_id FOREIGN KEY (product_id) REFERENCES public.main_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_footwearproduct main_footwearproduct_product_ptr_id_a8d8e404_fk_main_product_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_footwearproduct
    ADD CONSTRAINT main_footwearproduct_product_ptr_id_a8d8e404_fk_main_product_id FOREIGN KEY (product_ptr_id) REFERENCES public.main_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_offer main_offer_company_id_a3f9fd46_fk_main_company_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_offer
    ADD CONSTRAINT main_offer_company_id_a3f9fd46_fk_main_company_id FOREIGN KEY (company_id) REFERENCES public.main_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_offer main_offer_offer_id_0623a5b0_fk_main_salesproduct_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_offer
    ADD CONSTRAINT main_offer_offer_id_0623a5b0_fk_main_salesproduct_id FOREIGN KEY (offer_id) REFERENCES public.main_salesproduct(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_offer main_offer_product_id_500eb411_fk_main_product_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_offer
    ADD CONSTRAINT main_offer_product_id_500eb411_fk_main_product_id FOREIGN KEY (product_id) REFERENCES public.main_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_product main_product_category_id_c0d90f41_fk_main_productcategory_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_product
    ADD CONSTRAINT main_product_category_id_c0d90f41_fk_main_productcategory_id FOREIGN KEY (category_id) REFERENCES public.main_productcategory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_product main_product_manufacturer_id_0da06053_fk_main_manufacturer_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_product
    ADD CONSTRAINT main_product_manufacturer_id_0da06053_fk_main_manufacturer_id FOREIGN KEY (manufacturer_id) REFERENCES public.main_manufacturer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_product main_product_parent_id_5367ad52_fk_main_product_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_product
    ADD CONSTRAINT main_product_parent_id_5367ad52_fk_main_product_id FOREIGN KEY (parent_id) REFERENCES public.main_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_productcategory main_productcategory_parent_id_ed19c5bc_fk_main_prod; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_productcategory
    ADD CONSTRAINT main_productcategory_parent_id_ed19c5bc_fk_main_prod FOREIGN KEY (parent_id) REFERENCES public.main_productcategory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_productimage main_productimage_product_id_7c7e66ae_fk_main_product_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_productimage
    ADD CONSTRAINT main_productimage_product_id_7c7e66ae_fk_main_product_id FOREIGN KEY (product_id) REFERENCES public.main_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_sale main_sale_company_id_2d9466cc_fk_main_company_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_sale
    ADD CONSTRAINT main_sale_company_id_2d9466cc_fk_main_company_id FOREIGN KEY (company_id) REFERENCES public.main_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_sale main_sale_customer_id_4cb689a7_fk_main_customer_user_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_sale
    ADD CONSTRAINT main_sale_customer_id_4cb689a7_fk_main_customer_user_id FOREIGN KEY (customer_id) REFERENCES public.main_customer(user_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_sale main_sale_product_id_a5fc142c_fk_main_product_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_sale
    ADD CONSTRAINT main_sale_product_id_a5fc142c_fk_main_product_id FOREIGN KEY (product_id) REFERENCES public.main_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_salesproduct main_salesproduct_company_id_df7ac0bc_fk_main_company_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_salesproduct
    ADD CONSTRAINT main_salesproduct_company_id_df7ac0bc_fk_main_company_id FOREIGN KEY (company_id) REFERENCES public.main_company(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_salesproduct main_salesproduct_product_id_cc073be4_fk_main_product_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_salesproduct
    ADD CONSTRAINT main_salesproduct_product_id_cc073be4_fk_main_product_id FOREIGN KEY (product_id) REFERENCES public.main_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_seller main_seller_user_id_d9f284db_fk_main_user_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_seller
    ADD CONSTRAINT main_seller_user_id_d9f284db_fk_main_user_id FOREIGN KEY (user_id) REFERENCES public.main_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_user_groups main_user_groups_group_id_a337ba62_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_user_groups
    ADD CONSTRAINT main_user_groups_group_id_a337ba62_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_user_groups main_user_groups_user_id_df502602_fk_main_user_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_user_groups
    ADD CONSTRAINT main_user_groups_user_id_df502602_fk_main_user_id FOREIGN KEY (user_id) REFERENCES public.main_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_user_user_permissions main_user_user_permi_permission_id_cd2b56a3_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_user_user_permissions
    ADD CONSTRAINT main_user_user_permi_permission_id_cd2b56a3_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_user_user_permissions main_user_user_permissions_user_id_451ce57f_fk_main_user_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_user_user_permissions
    ADD CONSTRAINT main_user_user_permissions_user_id_451ce57f_fk_main_user_id FOREIGN KEY (user_id) REFERENCES public.main_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_wallet main_wallet_product_ptr_id_2fd46b7f_fk_main_product_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_wallet
    ADD CONSTRAINT main_wallet_product_ptr_id_2fd46b7f_fk_main_product_id FOREIGN KEY (product_ptr_id) REFERENCES public.main_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_watch main_watch_product_ptr_id_dacaaa06_fk_main_product_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.main_watch
    ADD CONSTRAINT main_watch_product_ptr_id_dacaaa06_fk_main_product_id FOREIGN KEY (product_ptr_id) REFERENCES public.main_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: taggit_taggeditem taggit_taggeditem_content_type_id_9957a03c_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.taggit_taggeditem
    ADD CONSTRAINT taggit_taggeditem_content_type_id_9957a03c_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: taggit_taggeditem taggit_taggeditem_tag_id_f4f5b767_fk_taggit_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: spirosdim
--

ALTER TABLE ONLY public.taggit_taggeditem
    ADD CONSTRAINT taggit_taggeditem_tag_id_f4f5b767_fk_taggit_tag_id FOREIGN KEY (tag_id) REFERENCES public.taggit_tag(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

