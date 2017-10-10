--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.18
-- Dumped by pg_dump version 9.5.8

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
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


SET search_path = public, pg_catalog;

--
-- Name: group_concat(anyelement); Type: AGGREGATE; Schema: public; Owner: jetty
--

CREATE AGGREGATE group_concat(anyelement) (
    SFUNC = array_append,
    STYPE = anyarray,
    INITCOND = '{}'
);


ALTER AGGREGATE public.group_concat(anyelement) OWNER TO jetty;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: act_approve_task; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE act_approve_task (
    id_ bigint NOT NULL,
    approve_comment_ character varying(255),
    approve_result_ integer NOT NULL,
    approve_time_ timestamp without time zone,
    approve_user_ character varying(255),
    business_key_ character varying(255),
    proc_inst_id_ character varying(255),
    subject_ character varying(255),
    task_id_ character varying(255),
    task_name_ character varying(255)
);


ALTER TABLE act_approve_task OWNER TO jetty;

--
-- Name: act_evt_log; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE act_evt_log (
    log_nr_ integer NOT NULL,
    type_ character varying(64),
    proc_def_id_ character varying(64),
    proc_inst_id_ character varying(64),
    execution_id_ character varying(64),
    task_id_ character varying(64),
    time_stamp_ timestamp without time zone NOT NULL,
    user_id_ character varying(255),
    data_ bytea,
    lock_owner_ character varying(255),
    lock_time_ timestamp without time zone,
    is_processed_ smallint DEFAULT 0
);


ALTER TABLE act_evt_log OWNER TO jetty;

--
-- Name: act_evt_log_log_nr__seq; Type: SEQUENCE; Schema: public; Owner: jetty
--

CREATE SEQUENCE act_evt_log_log_nr__seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE act_evt_log_log_nr__seq OWNER TO jetty;

--
-- Name: act_evt_log_log_nr__seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jetty
--

ALTER SEQUENCE act_evt_log_log_nr__seq OWNED BY act_evt_log.log_nr_;


--
-- Name: act_ge_bytearray; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE act_ge_bytearray (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    name_ character varying(255),
    deployment_id_ character varying(64),
    bytes_ bytea,
    generated_ boolean
);


ALTER TABLE act_ge_bytearray OWNER TO jetty;

--
-- Name: act_ge_property; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE act_ge_property (
    name_ character varying(64) NOT NULL,
    value_ character varying(300),
    rev_ integer
);


ALTER TABLE act_ge_property OWNER TO jetty;

--
-- Name: act_hi_actinst; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE act_hi_actinst (
    id_ character varying(64) NOT NULL,
    proc_def_id_ character varying(64) NOT NULL,
    proc_inst_id_ character varying(64) NOT NULL,
    execution_id_ character varying(64) NOT NULL,
    act_id_ character varying(255) NOT NULL,
    task_id_ character varying(64),
    call_proc_inst_id_ character varying(64),
    act_name_ character varying(255),
    act_type_ character varying(255) NOT NULL,
    assignee_ character varying(255),
    start_time_ timestamp without time zone NOT NULL,
    end_time_ timestamp without time zone,
    duration_ bigint,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_hi_actinst OWNER TO jetty;

--
-- Name: act_hi_attachment; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE act_hi_attachment (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    user_id_ character varying(255),
    name_ character varying(255),
    description_ character varying(4000),
    type_ character varying(255),
    task_id_ character varying(64),
    proc_inst_id_ character varying(64),
    url_ character varying(4000),
    content_id_ character varying(64),
    time_ timestamp without time zone
);


ALTER TABLE act_hi_attachment OWNER TO jetty;

--
-- Name: act_hi_comment; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE act_hi_comment (
    id_ character varying(64) NOT NULL,
    type_ character varying(255),
    time_ timestamp without time zone NOT NULL,
    user_id_ character varying(255),
    task_id_ character varying(64),
    proc_inst_id_ character varying(64),
    action_ character varying(255),
    message_ character varying(4000),
    full_msg_ bytea
);


ALTER TABLE act_hi_comment OWNER TO jetty;

--
-- Name: act_hi_detail; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE act_hi_detail (
    id_ character varying(64) NOT NULL,
    type_ character varying(255) NOT NULL,
    proc_inst_id_ character varying(64),
    execution_id_ character varying(64),
    task_id_ character varying(64),
    act_inst_id_ character varying(64),
    name_ character varying(255) NOT NULL,
    var_type_ character varying(64),
    rev_ integer,
    time_ timestamp without time zone NOT NULL,
    bytearray_id_ character varying(64),
    double_ double precision,
    long_ bigint,
    text_ character varying(4000),
    text2_ character varying(4000)
);


ALTER TABLE act_hi_detail OWNER TO jetty;

--
-- Name: act_hi_identitylink; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE act_hi_identitylink (
    id_ character varying(64) NOT NULL,
    group_id_ character varying(255),
    type_ character varying(255),
    user_id_ character varying(255),
    task_id_ character varying(64),
    proc_inst_id_ character varying(64)
);


ALTER TABLE act_hi_identitylink OWNER TO jetty;

--
-- Name: act_hi_procinst; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE act_hi_procinst (
    id_ character varying(64) NOT NULL,
    proc_inst_id_ character varying(64) NOT NULL,
    business_key_ character varying(255),
    proc_def_id_ character varying(64) NOT NULL,
    start_time_ timestamp without time zone NOT NULL,
    end_time_ timestamp without time zone,
    duration_ bigint,
    start_user_id_ character varying(255),
    start_act_id_ character varying(255),
    end_act_id_ character varying(255),
    super_process_instance_id_ character varying(64),
    delete_reason_ character varying(4000),
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    name_ character varying(255)
);


ALTER TABLE act_hi_procinst OWNER TO jetty;

--
-- Name: act_hi_taskinst; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE act_hi_taskinst (
    id_ character varying(64) NOT NULL,
    proc_def_id_ character varying(64),
    task_def_key_ character varying(255),
    proc_inst_id_ character varying(64),
    execution_id_ character varying(64),
    name_ character varying(255),
    parent_task_id_ character varying(64),
    description_ character varying(4000),
    owner_ character varying(255),
    assignee_ character varying(255),
    start_time_ timestamp without time zone NOT NULL,
    claim_time_ timestamp without time zone,
    end_time_ timestamp without time zone,
    duration_ bigint,
    delete_reason_ character varying(4000),
    priority_ integer,
    due_date_ timestamp without time zone,
    form_key_ character varying(255),
    category_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_hi_taskinst OWNER TO jetty;

--
-- Name: act_hi_varinst; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE act_hi_varinst (
    id_ character varying(64) NOT NULL,
    proc_inst_id_ character varying(64),
    execution_id_ character varying(64),
    task_id_ character varying(64),
    name_ character varying(255) NOT NULL,
    var_type_ character varying(100),
    rev_ integer,
    bytearray_id_ character varying(64),
    double_ double precision,
    long_ bigint,
    text_ character varying(4000),
    text2_ character varying(4000),
    create_time_ timestamp without time zone,
    last_updated_time_ timestamp without time zone
);


ALTER TABLE act_hi_varinst OWNER TO jetty;

--
-- Name: act_id_group; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE act_id_group (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    name_ character varying(255),
    type_ character varying(255)
);


ALTER TABLE act_id_group OWNER TO jetty;

--
-- Name: act_id_info; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE act_id_info (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    user_id_ character varying(64),
    type_ character varying(64),
    key_ character varying(255),
    value_ character varying(255),
    password_ bytea,
    parent_id_ character varying(255)
);


ALTER TABLE act_id_info OWNER TO jetty;

--
-- Name: act_id_membership; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE act_id_membership (
    user_id_ character varying(64) NOT NULL,
    group_id_ character varying(64) NOT NULL
);


ALTER TABLE act_id_membership OWNER TO jetty;

--
-- Name: act_id_user; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE act_id_user (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    first_ character varying(255),
    last_ character varying(255),
    email_ character varying(255),
    pwd_ character varying(255),
    picture_id_ character varying(64)
);


ALTER TABLE act_id_user OWNER TO jetty;

--
-- Name: act_procdef_info; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE act_procdef_info (
    id_ character varying(64) NOT NULL,
    proc_def_id_ character varying(64) NOT NULL,
    rev_ integer,
    info_json_id_ character varying(64)
);


ALTER TABLE act_procdef_info OWNER TO jetty;

--
-- Name: act_re_deployment; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE act_re_deployment (
    id_ character varying(64) NOT NULL,
    name_ character varying(255),
    category_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    deploy_time_ timestamp without time zone
);


ALTER TABLE act_re_deployment OWNER TO jetty;

--
-- Name: act_re_model; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE act_re_model (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    name_ character varying(255),
    key_ character varying(255),
    category_ character varying(255),
    create_time_ timestamp without time zone,
    last_update_time_ timestamp without time zone,
    version_ integer,
    meta_info_ character varying(4000),
    deployment_id_ character varying(64),
    editor_source_value_id_ character varying(64),
    editor_source_extra_value_id_ character varying(64),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_re_model OWNER TO jetty;

--
-- Name: act_re_procdef; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE act_re_procdef (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    category_ character varying(255),
    name_ character varying(255),
    key_ character varying(255) NOT NULL,
    version_ integer NOT NULL,
    deployment_id_ character varying(64),
    resource_name_ character varying(4000),
    dgrm_resource_name_ character varying(4000),
    description_ character varying(4000),
    has_start_form_key_ boolean,
    has_graphical_notation_ boolean,
    suspension_state_ integer,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_re_procdef OWNER TO jetty;

--
-- Name: act_ru_event_subscr; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE act_ru_event_subscr (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    event_type_ character varying(255) NOT NULL,
    event_name_ character varying(255),
    execution_id_ character varying(64),
    proc_inst_id_ character varying(64),
    activity_id_ character varying(64),
    configuration_ character varying(255),
    created_ timestamp without time zone NOT NULL,
    proc_def_id_ character varying(64),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_ru_event_subscr OWNER TO jetty;

--
-- Name: act_ru_execution; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE act_ru_execution (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    proc_inst_id_ character varying(64),
    business_key_ character varying(255),
    parent_id_ character varying(64),
    proc_def_id_ character varying(64),
    super_exec_ character varying(64),
    act_id_ character varying(255),
    is_active_ boolean,
    is_concurrent_ boolean,
    is_scope_ boolean,
    is_event_scope_ boolean,
    suspension_state_ integer,
    cached_ent_state_ integer,
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    name_ character varying(255),
    lock_time_ timestamp without time zone
);


ALTER TABLE act_ru_execution OWNER TO jetty;

--
-- Name: act_ru_identitylink; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE act_ru_identitylink (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    group_id_ character varying(255),
    type_ character varying(255),
    user_id_ character varying(255),
    task_id_ character varying(64),
    proc_inst_id_ character varying(64),
    proc_def_id_ character varying(64)
);


ALTER TABLE act_ru_identitylink OWNER TO jetty;

--
-- Name: act_ru_job; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE act_ru_job (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    type_ character varying(255) NOT NULL,
    lock_exp_time_ timestamp without time zone,
    lock_owner_ character varying(255),
    exclusive_ boolean,
    execution_id_ character varying(64),
    process_instance_id_ character varying(64),
    proc_def_id_ character varying(64),
    retries_ integer,
    exception_stack_id_ character varying(64),
    exception_msg_ character varying(4000),
    duedate_ timestamp without time zone,
    repeat_ character varying(255),
    handler_type_ character varying(255),
    handler_cfg_ character varying(4000),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE act_ru_job OWNER TO jetty;

--
-- Name: act_ru_task; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE act_ru_task (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    execution_id_ character varying(64),
    proc_inst_id_ character varying(64),
    proc_def_id_ character varying(64),
    name_ character varying(255),
    parent_task_id_ character varying(64),
    description_ character varying(4000),
    task_def_key_ character varying(255),
    owner_ character varying(255),
    assignee_ character varying(255),
    delegation_ character varying(64),
    priority_ integer,
    create_time_ timestamp without time zone,
    due_date_ timestamp without time zone,
    category_ character varying(255),
    suspension_state_ integer,
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    form_key_ character varying(255)
);


ALTER TABLE act_ru_task OWNER TO jetty;

--
-- Name: act_ru_variable; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE act_ru_variable (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    type_ character varying(255) NOT NULL,
    name_ character varying(255) NOT NULL,
    execution_id_ character varying(64),
    proc_inst_id_ character varying(64),
    task_id_ character varying(64),
    bytearray_id_ character varying(64),
    double_ double precision,
    long_ bigint,
    text_ character varying(4000),
    text2_ character varying(4000)
);


ALTER TABLE act_ru_variable OWNER TO jetty;

--
-- Name: ad_login_log; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE ad_login_log (
    id bigint NOT NULL,
    account character varying(255),
    client_ip character varying(255),
    login_time timestamp without time zone,
    message character varying(100),
    success boolean
);


ALTER TABLE ad_login_log OWNER TO jetty;

--
-- Name: ad_menu; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE ad_menu (
    id bigint NOT NULL,
    description character varying(255),
    image character varying(100),
    level integer,
    name character varying(50) NOT NULL,
    parent_id bigint,
    sequence integer,
    url character varying(100)
);


ALTER TABLE ad_menu OWNER TO jetty;

--
-- Name: ad_permission; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE ad_permission (
    code character varying(20) NOT NULL,
    created_on timestamp without time zone,
    message_key character varying(200),
    parent_code character varying(20),
    permit character varying(60) NOT NULL,
    type integer
);


ALTER TABLE ad_permission OWNER TO jetty;

--
-- Name: ad_process_flow; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE ad_process_flow (
    execution_id character varying(255) NOT NULL,
    apply_by character varying(255),
    apply_on timestamp without time zone,
    news_id bigint,
    process_id character varying(255),
    state integer NOT NULL,
    updated_by bigint,
    updated_at timestamp without time zone
);


ALTER TABLE ad_process_flow OWNER TO jetty;

--
-- Name: ad_role; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE ad_role (
    id bigint NOT NULL,
    created_at timestamp without time zone,
    created_by bigint,
    updated_by bigint,
    updated_at timestamp without time zone,
    status integer,
    description character varying(200),
    name character varying(50)
);


ALTER TABLE ad_role OWNER TO jetty;

--
-- Name: ad_role_menu; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE ad_role_menu (
    role_id bigint NOT NULL,
    menu_id bigint NOT NULL
);


ALTER TABLE ad_role_menu OWNER TO jetty;

--
-- Name: ad_role_permission; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE ad_role_permission (
    role_id bigint NOT NULL,
    permission_code character varying(20) NOT NULL
);


ALTER TABLE ad_role_permission OWNER TO jetty;

--
-- Name: ad_user; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE ad_user (
    id bigint NOT NULL,
    created_at timestamp without time zone,
    created_by bigint,
    updated_by bigint,
    updated_at timestamp without time zone,
    status integer,
    account character varying(50) NOT NULL,
    email character varying(50),
    gender integer,
    mobile character varying(50),
    name character varying(50),
    password character varying(200),
    telephone character varying(50),
    approve_role integer
);


ALTER TABLE ad_user OWNER TO jetty;

--
-- Name: ad_user_permission; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE ad_user_permission (
    user_id bigint NOT NULL,
    permission_code character varying(20) NOT NULL
);


ALTER TABLE ad_user_permission OWNER TO jetty;

--
-- Name: ad_user_role; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE ad_user_role (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE ad_user_role OWNER TO jetty;

--
-- Name: cargo_discrepancy_event; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE cargo_discrepancy_event (
    id bigint NOT NULL,
    order_number character varying(32) NOT NULL,
    erp_number text,
    added_at timestamp without time zone,
    expired_at timestamp without time zone,
    event_push_url text NOT NULL,
    event_max_push_retry integer,
    event_push_retry_count integer,
    event_last_push_at timestamp without time zone,
    event_pushed boolean DEFAULT false,
    event_time timestamp without time zone,
    request_body text,
    response text,
    client_id bigint,
    owner_id bigint,
    order_discrepancy_id bigint
);


ALTER TABLE cargo_discrepancy_event OWNER TO jetty;

--
-- Name: confirm_discrepancy_event; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE confirm_discrepancy_event (
    id bigint NOT NULL,
    added_at timestamp without time zone,
    clientid bigint,
    erp_number character varying(255),
    event_last_push_at timestamp without time zone,
    event_max_push_retry integer,
    event_push_retry_count integer,
    event_push_url character varying(255),
    event_pushed boolean,
    event_time timestamp without time zone,
    expired_at timestamp without time zone,
    order_discrepancy_id bigint,
    order_number character varying(255),
    ownerid bigint,
    request_body character varying(255),
    response character varying(255)
);


ALTER TABLE confirm_discrepancy_event OWNER TO jetty;

--
-- Name: contact; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE contact (
    customer character varying(200),
    phone character varying(200)
);


ALTER TABLE contact OWNER TO jetty;

--
-- Name: department; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE department (
    code character varying(255) NOT NULL,
    full_code character varying(255),
    is_leaf boolean,
    level integer,
    name character varying(255),
    parent_code character varying(255)
);


ALTER TABLE department OWNER TO jetty;

--
-- Name: log; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE log (
    id bigint NOT NULL,
    key character varying(255),
    body text,
    remote_ip character varying(50),
    request_time timestamp without time zone,
    created_on timestamp without time zone
);


ALTER TABLE log OWNER TO jetty;

--
-- Name: news; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE news (
    id bigint NOT NULL,
    created_at timestamp without time zone,
    created_by bigint,
    updated_by bigint,
    updated_at timestamp without time zone,
    status integer,
    content text NOT NULL,
    hits integer,
    number character varying(50) NOT NULL,
    execution_id character varying(255),
    source character varying(200),
    title text NOT NULL,
    type integer NOT NULL,
    image_id character varying(255)
);


ALTER TABLE news OWNER TO jetty;

--
-- Name: news_attach; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE news_attach (
    id bigint NOT NULL,
    news_id bigint
);


ALTER TABLE news_attach OWNER TO jetty;

--
-- Name: news_picture; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE news_picture (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    news_id bigint,
    origin_name character varying(255) NOT NULL,
    sequence integer,
    size bigint,
    suffix character varying(255),
    image_id character varying(255)
);


ALTER TABLE news_picture OWNER TO jetty;

--
-- Name: news_temp_image; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE news_temp_image (
    id bigint NOT NULL,
    access_path character varying(255),
    created_at timestamp without time zone,
    name character varying(255) NOT NULL,
    origin_name character varying(255) NOT NULL,
    size bigint,
    suffix character varying(255),
    upload_path character varying(255),
    news_id bigint
);


ALTER TABLE news_temp_image OWNER TO jetty;

--
-- Name: process_flow; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE process_flow (
    execution_id character varying(255) NOT NULL,
    apply_by character varying(255),
    apply_on timestamp without time zone,
    news_id bigint,
    process_id character varying(255),
    state integer NOT NULL,
    updated_by bigint,
    updated_at timestamp without time zone
);


ALTER TABLE process_flow OWNER TO jetty;

--
-- Name: resource_bundle; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE resource_bundle (
    id bigint NOT NULL,
    country character varying(255),
    key character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    tooltip boolean,
    value text NOT NULL,
    variant boolean
);


ALTER TABLE resource_bundle OWNER TO jetty;

--
-- Name: resource_file; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE resource_file (
    id bigint NOT NULL,
    access_url character varying(255),
    created_at timestamp without time zone,
    extension character varying(255),
    file_id character varying(255),
    file_name character varying(255) NOT NULL,
    file_size bigint,
    local_path character varying(255),
    origin_name character varying(255) NOT NULL,
    source integer NOT NULL,
    type integer NOT NULL
);


ALTER TABLE resource_file OWNER TO jetty;

--
-- Name: resource_image; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE resource_image (
    id bigint NOT NULL,
    created_at timestamp without time zone,
    dir character varying(255),
    image_id character varying(255),
    name character varying(255) NOT NULL,
    origin_name character varying(255) NOT NULL,
    path character varying(255),
    size bigint,
    suffix character varying(255),
    source integer NOT NULL
);


ALTER TABLE resource_image OWNER TO jetty;

--
-- Name: result; Type: TABLE; Schema: public; Owner: jetty
--

CREATE TABLE result (
    customer character varying(200),
    phone character varying(200),
    start_time date,
    end_time date,
    amount numeric(15,2),
    revenue numeric(15,2),
    uy numeric(15,2)
);


ALTER TABLE result OWNER TO jetty;

--
-- Name: seq_act_approve_task; Type: SEQUENCE; Schema: public; Owner: jetty
--

CREATE SEQUENCE seq_act_approve_task
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_act_approve_task OWNER TO jetty;

--
-- Name: seq_admin_login; Type: SEQUENCE; Schema: public; Owner: jetty
--

CREATE SEQUENCE seq_admin_login
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_admin_login OWNER TO jetty;

--
-- Name: seq_admin_login_log; Type: SEQUENCE; Schema: public; Owner: jetty
--

CREATE SEQUENCE seq_admin_login_log
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_admin_login_log OWNER TO jetty;

--
-- Name: seq_admin_menu; Type: SEQUENCE; Schema: public; Owner: jetty
--

CREATE SEQUENCE seq_admin_menu
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_admin_menu OWNER TO jetty;

--
-- Name: seq_admin_permission; Type: SEQUENCE; Schema: public; Owner: jetty
--

CREATE SEQUENCE seq_admin_permission
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_admin_permission OWNER TO jetty;

--
-- Name: seq_admin_role; Type: SEQUENCE; Schema: public; Owner: jetty
--

CREATE SEQUENCE seq_admin_role
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_admin_role OWNER TO jetty;

--
-- Name: seq_admin_user; Type: SEQUENCE; Schema: public; Owner: jetty
--

CREATE SEQUENCE seq_admin_user
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_admin_user OWNER TO jetty;

--
-- Name: seq_cargo_discrepancy_event_id; Type: SEQUENCE; Schema: public; Owner: jetty
--

CREATE SEQUENCE seq_cargo_discrepancy_event_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_cargo_discrepancy_event_id OWNER TO jetty;

--
-- Name: seq_department; Type: SEQUENCE; Schema: public; Owner: jetty
--

CREATE SEQUENCE seq_department
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_department OWNER TO jetty;

--
-- Name: seq_k_user_id; Type: SEQUENCE; Schema: public; Owner: jetty
--

CREATE SEQUENCE seq_k_user_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_k_user_id OWNER TO jetty;

--
-- Name: seq_log_id; Type: SEQUENCE; Schema: public; Owner: jetty
--

CREATE SEQUENCE seq_log_id
    START WITH 1
    INCREMENT BY 5
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_log_id OWNER TO jetty;

--
-- Name: seq_login_history; Type: SEQUENCE; Schema: public; Owner: jetty
--

CREATE SEQUENCE seq_login_history
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_login_history OWNER TO jetty;

--
-- Name: seq_login_info; Type: SEQUENCE; Schema: public; Owner: jetty
--

CREATE SEQUENCE seq_login_info
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_login_info OWNER TO jetty;

--
-- Name: seq_login_log; Type: SEQUENCE; Schema: public; Owner: jetty
--

CREATE SEQUENCE seq_login_log
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_login_log OWNER TO jetty;

--
-- Name: seq_menu; Type: SEQUENCE; Schema: public; Owner: jetty
--

CREATE SEQUENCE seq_menu
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_menu OWNER TO jetty;

--
-- Name: seq_news; Type: SEQUENCE; Schema: public; Owner: jetty
--

CREATE SEQUENCE seq_news
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_news OWNER TO jetty;

--
-- Name: seq_news_attach; Type: SEQUENCE; Schema: public; Owner: jetty
--

CREATE SEQUENCE seq_news_attach
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_news_attach OWNER TO jetty;

--
-- Name: seq_news_picture; Type: SEQUENCE; Schema: public; Owner: jetty
--

CREATE SEQUENCE seq_news_picture
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_news_picture OWNER TO jetty;

--
-- Name: seq_news_temp_file; Type: SEQUENCE; Schema: public; Owner: jetty
--

CREATE SEQUENCE seq_news_temp_file
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_news_temp_file OWNER TO jetty;

--
-- Name: seq_news_temp_image; Type: SEQUENCE; Schema: public; Owner: jetty
--

CREATE SEQUENCE seq_news_temp_image
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_news_temp_image OWNER TO jetty;

--
-- Name: seq_permission; Type: SEQUENCE; Schema: public; Owner: jetty
--

CREATE SEQUENCE seq_permission
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_permission OWNER TO jetty;

--
-- Name: seq_resource_bundle; Type: SEQUENCE; Schema: public; Owner: jetty
--

CREATE SEQUENCE seq_resource_bundle
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_resource_bundle OWNER TO jetty;

--
-- Name: seq_resource_file; Type: SEQUENCE; Schema: public; Owner: jetty
--

CREATE SEQUENCE seq_resource_file
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_resource_file OWNER TO jetty;

--
-- Name: seq_resource_image; Type: SEQUENCE; Schema: public; Owner: jetty
--

CREATE SEQUENCE seq_resource_image
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_resource_image OWNER TO jetty;

--
-- Name: seq_role; Type: SEQUENCE; Schema: public; Owner: jetty
--

CREATE SEQUENCE seq_role
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_role OWNER TO jetty;

--
-- Name: seq_user; Type: SEQUENCE; Schema: public; Owner: jetty
--

CREATE SEQUENCE seq_user
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_user OWNER TO jetty;

--
-- Name: log_nr_; Type: DEFAULT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_evt_log ALTER COLUMN log_nr_ SET DEFAULT nextval('act_evt_log_log_nr__seq'::regclass);


--
-- Data for Name: act_approve_task; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY act_approve_task (id_, approve_comment_, approve_result_, approve_time_, approve_user_, business_key_, proc_inst_id_, subject_, task_id_, task_name_) FROM stdin;
1	我统一	2	2017-10-09 14:00:52.685	user2	NEWS-2-TOLCIUIENJA77NOUW2KKLB3S	5005	test	5013	支队领导审批
2	我拒绝	3	2017-10-09 14:01:16.657	user3	NEWS-2-TOLCIUIENJA77NOUW2KKLB3S	5005	test	5022	定密员审批
3	重新申请	1	2017-10-09 14:01:48.21	user1	NEWS-2-TOLCIUIENJA77NOUW2KKLB3S	5005	test	5030	申请被退回
4	aaa	2	2017-10-09 18:47:49.929	user2	NEWS-2-TOLCIUIENJA77NOUW2KKLB3S	5005	test	5037	支队领导审批
5	aaa	2	2017-10-09 18:48:02.61	user3	NEWS-2-TOLCIUIENJA77NOUW2KKLB3S	5005	test	7507	定密员审批
6	aaa	2	2017-10-09 18:48:22.813	user4	NEWS-2-TOLCIUIENJA77NOUW2KKLB3S	5005	test	7515	总队领导审批
\.


--
-- Data for Name: act_evt_log; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY act_evt_log (log_nr_, type_, proc_def_id_, proc_inst_id_, execution_id_, task_id_, time_stamp_, user_id_, data_, lock_owner_, lock_time_, is_processed_) FROM stdin;
\.


--
-- Name: act_evt_log_log_nr__seq; Type: SEQUENCE SET; Schema: public; Owner: jetty
--

SELECT pg_catalog.setval('act_evt_log_log_nr__seq', 1, false);


--
-- Data for Name: act_ge_bytearray; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY act_ge_bytearray (id_, rev_, name_, deployment_id_, bytes_, generated_) FROM stdin;
5002	1	/home/bert/Documents/github/acme/cqjz/target/classes/assets/bpm/actNews.bpmn	5001	\\x3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e0a3c646566696e6974696f6e7320786d6c6e733d22687474703a2f2f7777772e6f6d672e6f72672f737065632f42504d4e2f32303130303532342f4d4f44454c2220786d6c6e733a61637469766974693d22687474703a2f2f61637469766974692e6f72672f62706d6e2220786d6c6e733a62706d6e64693d22687474703a2f2f7777772e6f6d672e6f72672f737065632f42504d4e2f32303130303532342f44492220786d6c6e733a64633d22687474703a2f2f7777772e6f6d672e6f72672f737065632f44442f32303130303532342f44432220786d6c6e733a64693d22687474703a2f2f7777772e6f6d672e6f72672f737065632f44442f32303130303532342f44492220786d6c6e733a746e733d22687474703a2f2f736f75726365666f7267652e6e65742f62706d6e2f646566696e6974696f6e732f5f32303137313030362220786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612220786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e63652220786d6c6e733a79616f7169616e673d22687474703a2f2f62706d6e2e736f75726365666f7267652e6e6574222065787072657373696f6e4c616e67756167653d22687474703a2f2f7777772e77332e6f72672f313939392f5850617468222069643d225f323031373130303622206e616d653d22244445465f4e414d452422207461726765744e616d6573706163653d22687474703a2f2f736f75726365666f7267652e6e65742f62706d6e2f646566696e6974696f6e732f5f32303137313030362220747970654c616e67756167653d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61223e0a20203c70726f636573732069643d226163745f6e6577735f617070726f766522206973436c6f7365643d2266616c73652220697345786563757461626c653d2274727565222070726f63657373547970653d224e6f6e65223e0a202020203c73746172744576656e742069643d225f3222206e616d653d22e5bc80e5a78b222f3e0a202020203c656e644576656e742069643d225f3322206e616d653d22e7bb93e69d9f222f3e0a202020203c757365725461736b2061637469766974693a61737369676e65653d22237b6170706c79557365727d222061637469766974693a6578636c75736976653d2274727565222069643d227374657030312d303122206e616d653d22e68f90e4baa4e794b3e8afb7222f3e0a202020203c757365725461736b2061637469766974693a63616e64696461746547726f7570733d22313031222061637469766974693a6578636c75736976653d2274727565222069643d2273746570303222206e616d653d22e694afe9989fe9a286e5afbce5aea1e689b9222f3e0a202020203c73657175656e6365466c6f772069643d225f362220736f757263655265663d227374657030312d303122207461726765745265663d22737465703032222f3e0a202020203c757365725461736b2061637469766974693a63616e64696461746547726f7570733d22313032222061637469766974693a6578636c75736976653d2274727565222069643d2273746570303322206e616d653d22e5ae9ae5af86e59198e5aea1e689b9222f3e0a202020203c757365725461736b2061637469766974693a63616e64696461746547726f7570733d22313033222061637469766974693a6578636c75736976653d2274727565222069643d2273746570303422206e616d653d22e680bbe9989fe9a286e5afbce5aea1e689b9222f3e0a202020203c73657175656e6365466c6f772069643d225f31322220736f757263655265663d225f3222207461726765745265663d227374657030312d3031222f3e0a202020203c6578636c7573697665476174657761792067617465776179446972656374696f6e3d22556e737065636966696564222069643d225f313322206e616d653d224578636c757369766547617465776179222f3e0a202020203c73657175656e6365466c6f772069643d225f31342220736f757263655265663d2273746570303222207461726765745265663d225f3133222f3e0a202020203c73657175656e6365466c6f772069643d225f313522206e616d653d22e5908ce6848f2220736f757263655265663d225f313322207461726765745265663d22737465703033223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b616374696f6e3d3d276167726565277d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a202020203c6578636c7573697665476174657761792067617465776179446972656374696f6e3d22556e737065636966696564222069643d225f313622206e616d653d224578636c757369766547617465776179222f3e0a202020203c73657175656e6365466c6f772069643d225f31372220736f757263655265663d2273746570303322207461726765745265663d225f3136222f3e0a202020203c73657175656e6365466c6f772069643d225f313822206e616d653d22e5908ce6848f2220736f757263655265663d225f313622207461726765745265663d22737465703034223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b616374696f6e3d3d276167726565277d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a202020203c6578636c7573697665476174657761792067617465776179446972656374696f6e3d22556e737065636966696564222069643d225f313922206e616d653d224578636c757369766547617465776179222f3e0a202020203c73657175656e6365466c6f772069643d225f32302220736f757263655265663d2273746570303422207461726765745265663d225f3139222f3e0a202020203c73657175656e6365466c6f772069643d225f323122206e616d653d22e5908ce6848f2220736f757263655265663d225f313922207461726765745265663d225f33223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b616374696f6e3d3d276167726565277d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a202020203c757365725461736b2061637469766974693a61737369676e65653d22237b6170706c79557365727d222061637469766974693a6173796e633d2266616c7365222061637469766974693a6578636c75736976653d2274727565222069643d227374657030312d303222206e616d653d22e794b3e8afb7e8a2abe98080e59b9e222f3e0a202020203c73657175656e6365466c6f772069643d225f3422206e616d653d22e68b92e7bb9d2220736f757263655265663d225f313322207461726765745265663d227374657030312d3032223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b616374696f6e3d3d2772656a656374277d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d225f3522206e616d653d22e68b92e7bb9d2220736f757263655265663d225f313922207461726765745265663d227374657030312d3032223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b616374696f6e3d3d2772656a656374277d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d225f3722206e616d653d22e68b92e7bb9d2220736f757263655265663d225f313622207461726765745265663d227374657030312d3032223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b616374696f6e3d3d2772656a656374277d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a202020203c6578636c7573697665476174657761792067617465776179446972656374696f6e3d22556e737065636966696564222069643d225f3822206e616d653d224578636c757369766547617465776179222f3e0a202020203c73657175656e6365466c6f772069643d225f392220736f757263655265663d227374657030312d303222207461726765745265663d225f38222f3e0a202020203c73657175656e6365466c6f772069643d225f313022206e616d653d22e794b3e8afb72220736f757263655265663d225f3822207461726765745265663d22737465703032223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b616374696f6e3d3d276170706c79277d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d225f313122206e616d653d22e692a4e994802220736f757263655265663d225f3822207461726765745265663d225f33223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b616374696f6e3d3d2763616e63656c277d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a20203c2f70726f636573733e0a20203c62706d6e64693a42504d4e4469616772616d20646f63756d656e746174696f6e3d226261636b67726f756e643d233343334634313b636f756e743d313b686f72697a6f6e74616c636f756e743d313b6f7269656e746174696f6e3d303b77696474683d3834322e343b6865696768743d313139352e323b696d61676561626c6557696474683d3833322e343b696d61676561626c654865696768743d313138352e323b696d61676561626c65583d352e303b696d61676561626c65593d352e30222069643d224469616772616d2d5f3122206e616d653d224e6577204469616772616d223e0a202020203c62706d6e64693a42504d4e506c616e652062706d6e456c656d656e743d226163745f6e6577735f617070726f7665223e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d225f32222069643d2253686170652d5f32223e0a20202020202020203c64633a426f756e6473206865696768743d2233322e30222077696474683d2233322e302220783d22302e302220793d223133352e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d2233322e30222077696474683d2233322e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d225f33222069643d2253686170652d5f33223e0a20202020202020203c64633a426f756e6473206865696768743d2233322e30222077696474683d2233322e302220783d223833352e302220793d223133352e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d2233322e30222077696474683d2233322e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227374657030312d3031222069643d2253686170652d7374657030312d3031223e0a20202020202020203c64633a426f756e6473206865696768743d2235352e30222077696474683d2238352e302220783d2238302e302220793d223132352e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d2235352e30222077696474683d2238352e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d22737465703032222069643d2253686170652d737465703032223e0a20202020202020203c64633a426f756e6473206865696768743d2235352e30222077696474683d2238352e302220783d223232352e302220793d223132352e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d2235352e30222077696474683d2238352e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d22737465703033222069643d2253686170652d737465703033223e0a20202020202020203c64633a426f756e6473206865696768743d2235352e30222077696474683d2238352e302220783d223432302e302220793d223132352e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d2235352e30222077696474683d2238352e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d22737465703034222069643d2253686170652d737465703034223e0a20202020202020203c64633a426f756e6473206865696768743d2235352e30222077696474683d2238352e302220783d223632352e302220793d223132352e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d2235352e30222077696474683d2238352e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d225f3133222069643d2253686170652d5f3133222069734d61726b657256697369626c653d2266616c7365223e0a20202020202020203c64633a426f756e6473206865696768743d2233322e30222077696474683d2233322e302220783d223332352e302220793d223133352e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d2233322e30222077696474683d2233322e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d225f3136222069643d2253686170652d5f3136222069734d61726b657256697369626c653d2266616c7365223e0a20202020202020203c64633a426f756e6473206865696768743d2233322e30222077696474683d2233322e302220783d223532302e302220793d223133352e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d2233322e30222077696474683d2233322e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d225f3139222069643d2253686170652d5f3139222069734d61726b657256697369626c653d2266616c7365223e0a20202020202020203c64633a426f756e6473206865696768743d2233322e30222077696474683d2233322e302220783d223733302e302220793d223133352e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d2233322e30222077696474683d2233322e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227374657030312d3032222069643d2253686170652d7374657030312d3032223e0a20202020202020203c64633a426f756e6473206865696768743d2235352e30222077696474683d2238352e302220783d223330302e302220793d223239302e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d2235352e30222077696474683d2238352e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d225f38222069643d2253686170652d5f38222069734d61726b657256697369626c653d2266616c7365223e0a20202020202020203c64633a426f756e6473206865696768743d2233322e30222077696474683d2233322e302220783d223233302e302220793d223330302e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d2233322e30222077696474683d2233322e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f3132222069643d2242504d4e456467655f5f31322220736f75726365456c656d656e743d225f322220746172676574456c656d656e743d227374657030312d3031223e0a20202020202020203c64693a776179706f696e7420783d2233322e302220793d223135312e30222f3e0a20202020202020203c64693a776179706f696e7420783d2238302e302220793d223135322e35222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f3135222069643d2242504d4e456467655f5f31352220736f75726365456c656d656e743d225f31332220746172676574456c656d656e743d22737465703033223e0a20202020202020203c64693a776179706f696e7420783d223335372e302220793d223135312e30222f3e0a20202020202020203c64693a776179706f696e7420783d223432302e302220793d223135322e35222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f3134222069643d2242504d4e456467655f5f31342220736f75726365456c656d656e743d227374657030322220746172676574456c656d656e743d225f3133223e0a20202020202020203c64693a776179706f696e7420783d223331302e302220793d223135322e35222f3e0a20202020202020203c64693a776179706f696e7420783d223332352e302220793d223135312e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f3137222069643d2242504d4e456467655f5f31372220736f75726365456c656d656e743d227374657030332220746172676574456c656d656e743d225f3136223e0a20202020202020203c64693a776179706f696e7420783d223530352e302220793d223135322e35222f3e0a20202020202020203c64693a776179706f696e7420783d223532302e302220793d223135312e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f3138222069643d2242504d4e456467655f5f31382220736f75726365456c656d656e743d225f31362220746172676574456c656d656e743d22737465703034223e0a20202020202020203c64693a776179706f696e7420783d223535322e302220793d223135312e30222f3e0a20202020202020203c64693a776179706f696e7420783d223632352e302220793d223135322e35222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f3230222069643d2242504d4e456467655f5f32302220736f75726365456c656d656e743d227374657030342220746172676574456c656d656e743d225f3139223e0a20202020202020203c64693a776179706f696e7420783d223731302e302220793d223135322e35222f3e0a20202020202020203c64693a776179706f696e7420783d223733302e302220793d223135312e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f3231222069643d2242504d4e456467655f5f32312220736f75726365456c656d656e743d225f31392220746172676574456c656d656e743d225f33223e0a20202020202020203c64693a776179706f696e7420783d223736322e302220793d223135312e30222f3e0a20202020202020203c64693a776179706f696e7420783d223833352e302220793d223135312e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f34222069643d2242504d4e456467655f5f342220736f75726365456c656d656e743d225f31332220746172676574456c656d656e743d227374657030312d3032223e0a20202020202020203c64693a776179706f696e7420783d223334352e302220793d223136332e30222f3e0a20202020202020203c64693a776179706f696e7420783d223334352e302220793d223235352e30222f3e0a20202020202020203c64693a776179706f696e7420783d223334352e302220793d223239302e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f35222069643d2242504d4e456467655f5f352220736f75726365456c656d656e743d225f31392220746172676574456c656d656e743d227374657030312d3032223e0a20202020202020203c64693a776179706f696e7420783d223735302e302220793d223136332e30222f3e0a20202020202020203c64693a776179706f696e7420783d223735302e302220793d223235352e30222f3e0a20202020202020203c64693a776179706f696e7420783d223338352e302220793d223331372e35222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f36222069643d2242504d4e456467655f5f362220736f75726365456c656d656e743d227374657030312d30312220746172676574456c656d656e743d22737465703032223e0a20202020202020203c64693a776179706f696e7420783d223136352e302220793d223135322e35222f3e0a20202020202020203c64693a776179706f696e7420783d223232352e302220793d223135322e35222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f37222069643d2242504d4e456467655f5f372220736f75726365456c656d656e743d225f31362220746172676574456c656d656e743d227374657030312d3032223e0a20202020202020203c64693a776179706f696e7420783d223534302e302220793d223136332e30222f3e0a20202020202020203c64693a776179706f696e7420783d223534302e302220793d223235352e30222f3e0a20202020202020203c64693a776179706f696e7420783d223338352e302220793d223331372e35222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f39222069643d2242504d4e456467655f5f392220736f75726365456c656d656e743d227374657030312d30322220746172676574456c656d656e743d225f38223e0a20202020202020203c64693a776179706f696e7420783d223330302e302220793d223331372e35222f3e0a20202020202020203c64693a776179706f696e7420783d223236322e302220793d223331362e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f3131222069643d2242504d4e456467655f5f31312220736f75726365456c656d656e743d225f382220746172676574456c656d656e743d225f33223e0a20202020202020203c64693a776179706f696e7420783d223234362e302220793d223333322e30222f3e0a20202020202020203c64693a776179706f696e7420783d223831302e302220793d223336302e30222f3e0a20202020202020203c64693a776179706f696e7420783d223835312e302220793d223136372e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f3130222069643d2242504d4e456467655f5f31302220736f75726365456c656d656e743d225f382220746172676574456c656d656e743d22737465703032223e0a20202020202020203c64693a776179706f696e7420783d223234362e302220793d223330302e30222f3e0a20202020202020203c64693a776179706f696e7420783d223234362e302220793d223138302e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a202020203c2f62706d6e64693a42504d4e506c616e653e0a20203c2f62706d6e64693a42504d4e4469616772616d3e0a3c2f646566696e6974696f6e733e0a	f
5003	1	/home/bert/Documents/github/acme/cqjz/target/classes/assets/bpm/actNews.act_news_approve.png	5001	\\x89504e470d0a1a0a0000000d494844520000036d00000172080600000066ed32ad000049224944415478daeddd099c5575fdff7150b34d4bcbf64cdbadd4322d5b2cb1cca084b4bc779c7b6760f4a7a328288b9812e028b982a180e2823b2aa9b9e1c62e200a810a28a1a0a0228280ca26ab72feef377ea7ff34cebedc39e7ceebf9787c1e77e6cec2f0b9e7f33de773cf39df6f9b3600000000806488a268aff28fcbca26eff2c163d94eb5fccc8f151f2bff7e000000004033b86361f45a8fa193a2bfffebe52d675df3e4767fdc63d8e468c7e3d0c9d173cbb6ae084ddabd7e5e165e307ad1a61ec326453daf9ebafdca875eda72dda32f6dd4f3a7904d0000000068426eb47a0cffa041bbf85fffd9d8534dd979b7ced974e1bdaffde7dc1b66bf75f67533ded3f75ce2efbd79eca275bd474cdbde63f8e36edc5eea73ed53eff71cf6f88ec6eeb1b96fad292bbb6b57320a000000004ddbb49decc6abe7f0a9dbcfbe6ee6fb6ede7a0d9f129d73e3ecf7ae7870fe163771675e31e1c0d737462fb839eb73cd53dbfdf8c1d9b8c7c3e324fdfc8e466e30190500000080a66dda06b9691bf5c4aa75335e797f911bb24bee9ab7e58a07166c1a70fbb35bdc9485ef1bddebeaa93b2e9d3ce786593b9abbde239ed8d1c0f98c9b3f3fe3ca49079351000000006842afae8d96f83eb59ee567cf867e709fdab9373dbbf5c23be66cea79d5e3db43d3d6ce5f5bbc72dbeab7a268997fe6c27be66feab9e3deb7c951ef6ba6bf4f3601000000a009a911dbb56768d42e7960c9964b463fb3d5973afa8c5acfaba7ed38ab76d5d4d59bfcbd3d873ffec159b69133dfbf5ccd9abfef8a716f6c3ee7ba99eff71c3e65fb88e92bd69051000000006862675f3be33d3769e75cffef6d3bceb8a901eb75d5d4ed6ae89ee9f9c14c91a34283d77ec08d33de1bfcf06b9b07de3a7bab2fa99cf0dc9ad71d678d98febebe7e3cd9040000008026d6fbea69dbd574bdd763e8c4ebfbdefccc56355fe31565635f8866f7bdf969cf1cd94bf18ff20947fa5cfbd4f6f36f7d7acb15e3976dd6f37d868c5bff9667931cfcd092cd6413000000009a909aae07dc8ccd89a2797abc65f043abd79f7ded53eff5bd65f67b1fdcdb36c567dc462bce535ca82e6dd2b937cfd9dacb974efa5eb6b096db59239ef0f75d4146010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006087288a7659bc78f1dd3366cc787fe2c489d1f8f1e38906c4840913a2a953a7ae5614b10db13db00d319e520bd402a8196a064093f160396ddab468e5ca95d1962d5b8846c4aa55aba22953a6acd5e0791cdb10c136c4784a500ba066a819004dc2ef6e315836e9a0b965fcf8f10bd88608b621c653825a003543cd006812be1c8181ae694303e636b621826d88f194a01640cd5033009a84af8566906bf20133621b22d886184f096a01d40c350320a703e68635cba3c5b36e8ae64fb86047f8633fc700c980c936c436046a815a003543cd0068e10173fd3bcba2e7c7f68fe63edce77fc2cff96b0c92346d6c436c43a016a8055033d40c80161c3097ce7ff043836579bc3e7f0c83244d1bdb10db10a8056a01d40c3503a02507cc05932fad76c0f4d7182469dad886d886402d500ba066a819002d38603e3fbeacda01d35f6390a469631bcaab6d680f46466a815aa016a8196a863aca2feddab5dba5b0b0b0fdf1c71f3f50f1a86281629b220ab1545f1fafb85851545252f2b116f943a328fad8d8b1637b0e1f3e7ce6a04183d6f4eedd7b9bfe981d7f645151d1f69e3d7b6e1e3060c0cbe79f7ffebd679c71c6110c980c98346d6c43ad701b3ad2c3a5e268766fd402b5402d5033d40c75947ca954ea8bea77cad488bd54a141ab4b2c578c50ec9b933ff48d37de38f8b6db6e9b7ee69967be7fda69a74537dd74533463c68c68f9f2e5d1a64d9b22dbba756be4c51d67cd9a158d1a352aeadab5ebf6eeddbbbfd5b76fdf0bf41fddadb50f989ea9a9ba01d35f6390a469631bca8b6dc83bd7771443c2233b596a815aa016a8196a863a4af099b5828282733299ccbbf56cd62ac7369f7d6bb6336feac5769b3c79f2b86eddba6d1f3c7870346fdebc1dcd595dcd9f3f3f1a3e7c7874d24927bddbab57afa35bf380b968faf06a074c7f8d4192a68d6d28f1dbd0919576aaedd9c9520bd402b540cd5033d45162cfae7d4b8dd6dcca0d984f605d7bedb53b4e602d5bb6ecbf27b0fce813584f3ffd7474cb2db7443d7af4f850f3a606f059c5fe4d7e76edca2baf5ceb7f70ce9c395163bcf0c20bd119679cf1de29a79cf2508b5ddbd9c203e65bcbe645cf8f3befc39725e8397f8d4192a68d6d28d1dbd091d5ec4c8f64274b2d500bd4023543cd5047c9a2c6ea67d96c7655c586ab4f9f3e3b1ab2f7de7bafce3d907ba8be7dfb566eded6ebf737cd6bb87efdfac3fbf5ebb775e8d0a1d1ba75eba2a6e0ee53bf6fdbe9a79f3e25df2e97acebc2964b66dffaa101d3cf3140d2b4b10d257a1baa6d27eaafaf0fef92825aa016a8056a869aa18e62deb06532998de54d969ab768cc9831f56ad62a7becb1c7a2f27940ca2f976c74e3e6336c6ed82ebbecb246fd71d5193162c4d6534e396582af116d5503e6e6cdd1a227477cf8b2043de7af3148d2b4b10d25721baaebbb9e5cd6422d500bd4023543cd504731e74b22d5b0bd5df152c8850b1736490ff4ca2baf44ddbb77af7cc6ad61974afa1e365f12e9336ccdd1b095bbe28a2b36161515ddd95a06ccf5ef2c8b164e1f56edf5e4fe9abf878192a68d6d2851db507d2f53f14e7615ef8e520bd402b540cd700c421dc54f98ce7f6ec586cdf7a83525ffbe8a8d9bef716bd0ad639e74c4f7b035d52591355d2aa944acd51fdb2eaf07cccd9ba3e58b2645cf3dd6b7dac1b23cfc3dfe5edef1a269631b4ac436d4d0fb0a8e0c3b59de1da516a8056a819ae118843a8a11cf1259f192c8a63ac356d519b74a974a0eaad71feacb223d4ba46788cc054f4ea284acc887fbdbaa1a306b7b678b77bc68dad88612bb0d35f64670ee47a016a8056a819ae118843a8a11afc356715a7fdfc3d69c7c8f5bc5fbdb7c59669dff58afc3e669fd7369e0c0815ea0eeac7c1c30ebf2ce564def783160d2b4b10dc5721baabc736dabe8121e6b52f9fbb81f815aa016a8056a866310ea2826bc7076c55922ebb3c45943fdf5af7fadd8b88da8d31faa9ffb9817ceced559b6720b162cd8a2aef6d5a44f4a52d580d9d0c1b23c183069dad88662b70d55b573bdc14368786c5bc3ceb5aaef2bff7dbc3b4a2d500bd40235c3e43dd4510b09f7b2bd54de40795aff5c70df55a1695b5ea7ab0fb5719ee59bed9a73f291ea949494acf4d49a717c11f5b7edd1d00193a0696bec4e9788d53654d5e52b5dc24e33aa61275b71e75a1e9d2bfddef5ade1ddd1babe39472d500b1c42523349a8191d64ef9bc9647e441dc59b9ab1f18ac36afa1e4fbd5f71f2915cf6431517e0d6df5954eb7f68f8f0e1336fbae9a6a8250c1932648efed081313d55bac03707d6d6bc3160d2b4d1b425671baacb005e879d6b753bcf8a3bd9aabe3eb28a9d70abb8ac4563e934ed18bbd5364b16b5402d70c049cd24e118c453b587d9ffeed3e371f5b86a8c3aca6d1d953744e3ab3b49e43ea4fcfb468e1c99d33e68d4a851159bb68b6bfd0f0d1a3468cd8c19335aa4697beaa9a796ea0fbd3ba62ff4925090efe8b15f75a72d193069da1af30e0fdb506eb7a1ba0ce075d8b9d6b693dda98e3bd78aff4e5ecf00563e9efa1210c5a9d51d88520bd4421b66c3a3661272a6adc2a56d5178a3ffd45a2e71a38e5aa869ab108f563e2ef373e55fcf753fe44b312bfc6d936bfd0ff5eedd7bdbf2e5cb5ba4695bbd7af55bded063fa42afaaf84287e6ada4f2bb290c98346d8d7987876da8650e546b1ac0ebb873ad6927fb623d76ae9577b2edf374c7b9bc52de9728efc7500bd4426bab056a263f8e41b2d9ec57aba8a18a6ff47f8b3a8a65d3f6dfe3b2f2f14e9f2f2a7f3ed7fd90d76dabf0772dadf53f545c5cbc63edb496e0d959f4476e4ad20bed26532f747b064c9ab6a67887876da8c50f543f3480b7a9ff14cc55ed64ebb373cdfbcb5a6a184f67319e520bada916a899fc3906a9e1352a8fbb1587e85b7f471dc5ae8efe7b5ca678affcf35cf743fef72afe3d75fa0fb5a4f0876e55787d84358a958a658a57140b3538cdd7a3ef7dfbb762bae271c5b882828287f578bfbe7e971e6f57dcacb84ecf5fa5e7ae505ca6cf2f0cd378f6d5f37df45c0fc569fafc649f355364f47ccaef5e6532993fe8f1775ef45bf18b3abcd04ffbe7183069da1af30e0f3bdd781ca896c731c71c3321ec1847d4f3e5dea98a77435f0ccfd747f9e29ede896c566c08e3e2aaf0cefbd270d9d4a27039ce731ac39ef5819ce229df07e34b2cbc8d859dd118c5bd619cbc4371ab3ebed163a5e26afdec503dfe238c9717292ed073033c66eab9b3f5712f3d76d763578f9b7a3c418fc57aaed063a73e3e561f76d4c71d3c7ea6d3e923f4dcaff4f1cff5dc4ff4f141e5f77ed4369eeafbfe442d500bd5d4c2161f2368bb5aa7c7b72bd4c3ebe158e165c58b8aff683b9a57a12666289ed0cf4dd1e3441f3b281e715df85e24c53dfa78b48f21f43db754a88d118a613e96d0f70c565c1a8e2776d487e26ffaf8affa7a6f1f57f8deb3f21a519ca88f3b2bb2fab8c0f73bf958a1bc4e1447e9e3df280e57bdfcd25761f8c0deb592cd660f48a552dfd773dfa943cdcc5674a2669a3ec68d1b1775ead46977e5f7cb7e2d747c78b08f0dfd1afab85151ead7beb6d7483fbbedcf7ffef3e698d411518768c13ea86e4d5b972e5db6b7e099b6d53ed3565a5afa918e1d3b7e4283d5a7159f73a1a848f6517c3b0c603f0c0700bff040e783033759dec98703878c9eebe201d34d999e3bd34d9a0f3c14e779b0f541899e1be2a62e0cca378581faae30783f1c06f4c9a139acedc5f58e641b03264d5b63dee1f10e9b6da8e9a33183f611471c11edbaebae513d2e2ba9e95dd11beaf9aea867fe3a46e3dece1d3a74f8687171f1273d1992c6a9bdbcf867b824675f5f7aa3e7f67343e419cc7cd0e76dc96f06f8e042078347faddf8302bd6b1e1cda942375ca1f17203d6d50d993eee19ded43a571ff7d7e3f91e337da0aa8f2f0f8dddd51e37c341edad6e00432378afbefe6038101ea7e726e971aae249bfd1160e9e9fab2de7fab9f73da6ea91ed975af8502d2876f531820fa4b5bdef595e0f8aaf8463856ff8e05af13d373ee535a138d48d91e2d7a151fa5d689c8e0e8dd45f426395098dd609a1f13a3534626786c6ececf0e6ef80f2fa505c121aba216ef0ca6b4471436800478586f0ee708c515e27634303e937a09f086fb6b8c17cc60d6778a3fac5bad44c08b6f3268ccd9b3747da7e9ce3f58a37c26b313b1c1b8e096f7e5d1b5efb77ab797dde0d8dfedee11eb7f2336d2d56479c69fbf0196b8f03bee5c9c7f28939d3d6bb77ef4d2d754fdbca952b17c5f89eb69a4e77b7e32c493c0f3292186c43b138bbf0df01bc19ee3fa8cb4eb67d9b3cbe71bc86bc4f663ca5165a532d5033c938d356c7d76849a5d7669b9b78bfb956cd3d66d451cbd751e5f12d59f7b49d77de790b5b6af6c8b163c73e12c7d923fdce48a5177953384bb73ff72371a6ad29dfe1611b6af103d50f0de0f5d8c95637057355337dd5b493cdeb45513deb5d150736f7717f27b5d0da6a819ac9bb7bda16557c43bfaa6344ea2836c7614ff9ec7a55e35ba2668f1c3870e09d2db54e5bfffefdc7c4719db60a53b9ae77b3e64b31aafb5e064c9ab6c6bcc3c336d46207aad50ee055ecfcaa9a81abb63573dad671277b489b3c9fe1abc278ea03cfebfd39e329b5d01a6b819ac9bba6cd673d1779bf5e8f97973aca6d2dd5f46654f9f724679db6eeddbbffb46bd7aedb73b90278f9a59c994ce6d53aac0fd31267dabee8094c6a5b589b0193a6adb1eff0b00de5fc40b5d601bc9acb4c2abf6bd9a54ded337a55b593ed5cc5bba1c7e5f34e33dc8777534d079ed402b5d01a6a819ac9af63101fbfd6b37ea8a318f2f159f9f1da69a79d16e5b21f3af3cc33b75768da8aeaf407eb8756cd9b372fa71ddb8c19337c69e492066ef0b1c18049d3d6987778d88612b30d7967b8bec2652d15779e354dc15cddf7b173a516a8056a819a69bdc720d4514c84c9489696374fbe643117dc775578737f792d0bb3ff7ffdfaf53b6ff0e0c1db73d9b49d72ca29be34f22c064c225f9b36b6a1bcdb86da57b193eddca6f61bc22b7f5fab5f3b875aa016a8056a866310ea28466fb20f2a6fa0faf4e99393b36d7dfbf6add8b4d57d4908dff45a5a5aba7efefcf93969d866ce9ce9296f97d4b9ab64c064c064a74bc4631baaee7e84faeca4d9b9520bd402b540cd700c421dc544b82d6a7d79133566cc9866ed831e7becb1ff9968c8cbf8d4eb0feed6ad5b87eeddbb6f5db76e5db3fea11b376e5c91c96416569cb2960193a069e3754fd036d4d09de491ec5ca9056a815aa0663806a18e6279b6edbf139264b3d968e1c285cdd207bdf2ca2b91d7c8aed0b40d6ad01f7ceaa9a7de3f64c890cdcd785a707dd7ae5d7d2fdb6d0c98044d1bdb5082b7a1faee2cd9b9520bd402b540cd5033d4514cf9aac3828282672b4e4ae275d49a7a5db66eddbabd5ffe6ff8dff3bfdba03fd837e3e9978d1d3e7cf8966668dcd6f7eddbf79f5ecba2c17f20032603263b5d223edb50f9e2a5b55dd672481b6e10a716a8056a819aa166a8a358f35a7b152f9374e3d65467dc7c86ad62c3169615dbbf517fb01bb7d2d2d2472ebffcf20defbefb6e935d1279fae9a77be291bbf3e13e36064c9a36b621b6a13abedbe9af2f67e74a2d500bd4023543cd5047f1974ea78facd8b8f95249dfe3d6989359be87add22591dbeab9be5fcd8d5b7171f1a8534f3d75eddcb973df6beca423e11eb6dbf2e90c1b03264d1bdb10db50859de8fa2a76b255adc5036a815a003543cd5047096adcca67959c33674ebda7f5efdfbf7fc54947cacfb035fd65ad9e2ca4a8a868d980010316ab79abcf25939b66cd9af5a8ef91f32c91f932e90803264d1bdb10db502d3bd9f29d6987368d9b118c0350825a0035d37a8f41a8a316e64b172bdee356f192c991234746ea73a2e5cb97479b366dfaa0f1d1a3ef597363376ad4a8ff5938bbe23d6c8dbe24b226e1c6bc6e8585852f75eedc79f5e0c183e74c9932e5d5152b56acdcba75eb8e3f548fabf5872e1a376edc587594633299ccaba1593b2bdf2e8764c0a469631b621baa46f9bba0651a33fdef1fc36e8f5aa016a8056a869aa18e92c93d5098557253e506ac9eb1cdb344e6f48a43fd838728faa981bb33749fe5ff093f2ef03d6bfadac5fadacf7c8925032641d3c636d4cab621bf3bea77d3b6e6e3e5e0d402b5402d5033d40c75d4da781d37bd0643d4e72cad67b3b6dc0b67ab37da8f2c32603260b20d11f1db86f6d0e0fe4e2693d99311925aa016a8056a869aa18ef2834f48a9093b43b1359cb05a54459336d927b01445f97eb521032641d346247e1bd2a0fd465151d1971821a9056a815aa066a819ea286fceb8ed16ae2c7483b6948c30603260d2b411c93f507d3993c97c8311925aa016a8056a869aa18ef2835e8731e567d50a0b0bdfe74c1a032603264d1b91f06d4883f97c0de6df6784a416a8056a819aa166a8a3e4f3a48c55cc0679349961c064c0641b22927d7661762693399811925aa016a8056a869aa18e92cd4b978519202b4f34328cec30603260b20d11c93e509d56585878182324b5402d500bd40c35431d2597678eac61d6c8056488019301936d8848f62561e3d3e9f4918c90d402b5402d5033d40c75944c61b6c8a76a9ad69fe9fc19301930d98688046f430505050f6a20efc808492d500bd4023543cd5047c9e4a9fbebb016dba9648a019301936d8848eed985bb146946486a815aa016a8196a863a4aae542af52d3566c785b5d7c6ebe3cd8af72a346d63c852424c9c389141ae69639306cc6d6c434492b7210decb7141414746684a416a8056a819aa166a8a3bc69e0765693b641afc7177c8fa1a2873e1f41661262ead4a9cb57ae5cc940d744b16cd9b2d11a3017b00d1149de86b473bd4683f9298c90d402b5402d5033d40c75941fb2d9ec014c3e926093264dfad3e38f3fbee6cd37dfdcc880d7b877b73c584e9830e155c5716c43f1884d9b36b10d35ec5dd12bfc0e1c2324e329b5402d5033d40c75941ff41a7451d3763b99483015f8d1e3c78f9fe553eabe169a685038770b5a5bc316e76d68e4c89151369b8dc68d1bc73654ff81fde282828273181d194fa9056a819aa166a8a3fca0d760a8a2179900101ba9546a370d4ccb8f3ffef83564a34103fb00ed64cf2713a016a805803aca0f3a267ac20b6d930900711a986e0bb3226d201bf5a79debd9dac95e4a26402d500b0075947c6565653be998687d2a95fa34d90010979dc34915d720c964323f222bf5ce61775f464126402d500b0075947ccafff7744cb4884c0088cb8e612f0d4cef545a38721899a97fe3ab3c5e4f26402d500b007594174d5b56c743ff241300e2b263b8b352c3e6584e66ea9dc7225f624a26402d500b0075947ccaff3f7c992a990010879dc23155346ce5710819aa572eff525050700f9900b5402d00d4515e346d8fa7d3e923c90480961e8cf655acaaa1691b4196ea95cf3f6a07fb309900b5402d00d451e2b5f56cdaa954ea33a402408b2a2c2c1c5f43c3e658d5ae5dbb5dc8549df3f91be56c229900b5402d00d451b26532996f2bff4bc8048016555252f2b170bdfc59bed1d90d9c1ed7556edcf4dccfc8569d77b03f57ce9e2413a016a805803a4a36e5be40f12f3201208e03d4b1be14c38d5ab8d7ad1fd772d72b7f07299e2113a016a805803a4a7cd37c99f2df974c00881d356bbd1443c8448307f8fd34c02f2013a016a805803a4a7cd33c41af417b3201208e03d4702fe649261a2693c9eca31cbe4226402d500b007594f863a2b78b8b8b3f4f2600c44eb834f26832d1306a78bfa0417e059900b5402d00d45172a552a9af2bf74bc9048058f265181aa8be4f261a269bcd7e4a395c4b26402d500b007594e886f92fcafd036402401c793d928d1d3b76fc04a9681835bcbb2a875bc904a8056a01a08e924b79bfa8a0a06000990010c701eacb8ae564a2d1797cbfacac6c2732016a815a00a8a36452c3f618b78b0088a5c2c2c2c3580fa64976b01b8a8b8b3f4926402d500b007594d8bcaff49bd96402401c07a862356ea3c844a3f3b8ba73e7ce9f2513a016a805803a4a64cef7e6ca2300711ea4ce535c40261a9dc7a5d96cf6ab6402d402b5005047c9535050f027cfa64d2600c475c770b306a913c844a3f3b83093c97c9b4c805aa01600ea289139bf8037b101c479909a5a5858783899681c35bef3b2d9ec016402d402b5005047893c1e7a48c743c7900900711da45e4fa5525f23138dcee3cc4c26f35332016a815a00a8a344e6fc0d8e8700c452870e1d3eaa416a33d30a375e6161e114ce5802d402401d254f5151d197743cb48a4c0088a5542af55d0d528bc844e3796d974c26f37b32016a815a00a8a364d1b1d01f1563c90480582a2c2c6ccf20d5643bd8fbb8161ea01600ea2891f91ea0e3a18bc80480b8366da769901a41269a2497776ad03f9e4c805aa01600ea2859742c74bfe238320120ae83d420ed18ce26134db283bd91a513006a01a08e12793cf45a2a95fa3a990010d741ea5fbcb3d434b473bdca672ec904a8056a01a08e9243cddae7742cf436990010e79dc2b3994ce66032d178dab95eae7cf62213a016a805803a4a0e4ff8a2a66d229900105b1aa4d668b0da934c34c90ef6efdac1fe8d4c805aa01600ea2851c7427d95efcbc80480584aa5529f71d346269a6cd0efe79d2c9900b5402d00d45172a839be87495f00c4962f8bd44ee11932d134b473edad417f309900b5402d00d451a21ae4c53a26fa369900104bda19a4fcee129968b21dec69be719c4c805aa01600ea28197c8b889ab6b5fab02dd90010d71dc2d99ef29f4c340de5f2444fd14c26402d500b007594983cff56799e422600c4564141c1358aae64a2c99ae0420dfe779009500bd402401d2526cf7e03fb1f6402406c69901aa7c1aa3d9968b281ff1835c1f79109500bd402401d25e65868b4725d442600c479a05aa41dc277c84493ed60db2ba78f9209500bd402401d25e65868a18e85be472600c4525959d94e1aa83677e8d0e1a364a3c976b0872ba78f9309500bd402401dc55f369bfd9472bcdec7446403402ca552a9af69a05a4a269a4e2693f9a9723a934c805aa01600ea28318df174320120b63448b563b6a4261ffc0f545ee79209500bd402401dc55f4141412fc550320120ce03d509da19dc4c269a8e17e6f4b5f16402d402b500504789688c4729c7256402406c69901aa8c66d009968d29ceecd25a700b500504789c9f17fb2d9ec016402409c07aadb15c564a2e9141616eea59cae2213a016a805803a8ab7e2e2e24f2abf1bdab56bb70bd90010e7a6edc9743afd4b32d1f43b0032016a815a00a8a378f3311013bd004842d3b6a2a8a8e84b64a2e9a452a99d95d7f7c804a8056a01a08e627f1c7486e26a320120b63a76ecf8090d541bf5615bb2d1e43b81ada5a5a51f2113a016a805803a8a756e6f2e2c2c3c894c00882d0d523ff0cdb764a25976026bbd58279900b5402d00d451ac73fb9ce220320120b60a0a0a8e563c4c269a6527f0667171f1e7c904a8056a01a08ee229954a7d5cb97d578fbb920d0071de09f83aee6164a25972fb4a2693d9874c805aa01600ea28b6793d54f1349900106b85858557141414f42213cd92db1714fb9109500bd402401dc536afa7a969bb8e4c0088350d540f68c03a864c343d35c3cf6632991f9109500bd402401dc5f63868a4e254320120ee83d5736ada0e2413cd92db2795db9f9309500bd402401dc5b71956fc844c0088fb4e6043a74e9d7627134d4f3bd749e974fa0832016a815a00a8a3f8e9d0a1c3473d09494949c9c7c80680d8f22c541aac569189e6e159393399cc1fc804a8056a01a08ee247f93c58c74173c90480580b3326fd9b4c34db0ef69ec2c2c2bf9009500bd402401dc5f238a85439bd914c0088350d54851ab046938966cbef28ed64b36402d402b5005047b16c84af5174231300e23e58fd4d3b818bc944b3e5f77ae5f72432016a815a00a8a3f839fef8e36731b90b80240c569ee6f66432d16cf91da69d417732016a815a00a8a378292d2dfd882721e9d8b1e327c8068058f34c541ab07e4b269a2dbf97151414f42113a016a805803a8a17e5f287cae97c320120f6d4b02dc96432df2013cdb6833d5f3b85016402d402b5005047b13b063a51712b9900106beddab5db4583d5663f928d66dbc19ecb3d8300b5005047b16cda862b9f3dc8048058f319369f692313cdba83ed51505030844c805aa01600ea28764ddb538a5f910900b1964ea78fd46035914c34eb0ef6144f274c26402d500b0075141fa9546a671d036de8d4a9d3ee640340ac794149cf1e49269a7507db4539be994c805aa01600ea2856b9fc8172f9229900908401eb620d587dc944b3e638ad1cff934c805aa01600ea283e0a0a0a3a2b9777900900b1e7815f83d6f164a25977b01d95e307c904a8056a01a08e6295cb2b741c741699009084a6eddf8a43c944b3ee147ea71c8f2313a016a805803a8ad531d0b4743a7d0499009084016b752a95fa1c9968d61dec61de319009500bd402401dc5435959d94ecae5ba9292923dc8068058cb66b39fd2c0bf9e4c347b637c8862369900b5402d00d4513ca452a9ef2a8f2f930900b1575050f043c53c32d1bcc2ec54cf9309500bd402401dc5a6f9cd2897779109004918b08e553c40269a5758c09c77f3402d500b007514130505058315e79009004918b07a29869089666f8ebfac584626402d500b0075149b3c4ef6a42e6402401206ace11ab0ba9389e695c964f654aedf2613a016a805803a8a85b6cae19ace9d3b7f96540088bd8282828715479389e6555252f231ed1c369109500bd402401dc5e2f8e79bcae12b6402402268c05a904aa5be4f269add4eca75441ad05a1517177fbeb0b0f024bf51e45ae8d0a1c347c90a50b7da51cdfccaf5a3c7418a318a85aea376eddaed42861a46f94c2b87f792090049e04b033676ecd8f113a4a279f90055b9de4c26d09aa452a9af6bbbefa998aa66ed1d1d24dde903a54e9d3aed4e7680ffa9955dfd06aa2707538d9cabc79b154ff91248afa5aa98aee76fd4e35f554b7fd2c7fb9596967e84cc359c727989a21f9900908401cb37322f2713cd2fac87b7964c20dfe960f2406debe729e6285628aed34166071f94921d501f855f48a7d3bf565d94eae3cbf5f89062912f75d4e72f783667d5cba57a3c51dff74b3db717596bb6d762bcc7263201200903d661da313c49269a5fb8bce54d32817c535656b6930f2e3d75b6a72077f860d4e38bbf4686d0daf8ca0aafa3a6f88beaa1af1e6fd1e30c4f7aa158a57842315235d3478f9dbcc0339739e69e72ff969b68320120090356b106ac51642227b9de5bf11a99403ef059338d1dedb54d5f1bcea6cd5594e920f4876407ada80ebea8edbe9d6ae1143dfe43f14878e36293ef17573ddce74bf0f478821e7fa1efff0c598b874c26b38f5e93d7c90480a43412be84e9023291939dfbb77c090c994082b7e1dd74f099d2767c47b8cf669ad779f422bf6407f9cab33466b3d903b4bd1fa7edfd6f7abc4df16f5feeae5819eed7bc5e8f67792666d5c3b7396b167f7aadfeac78904c00484ad376b3df01241339d941ecaf7c3f472690b046ed73da6eff2fcc56b7369c4938994b8a9087fbc32fa7d3e923f478aab6ef2bf4f8a86271b8d76cbe6719d4e3c58a2e1acf7fe675d2c85a72e975fcbbaf0e20130092b2939aaa81eb7032d1fcb4833f58f99e4d2690806d751f8d0b3d14533ce3a3b6db7feaf1784fa6437690f037213eee8972c219e3febe3d408fb3f4b8ce97f97a9b0f13e7f4d2e31f7d85846267329797c73f8feaf5ee4826002465d07a5d3ba4af91899ce4fa179eb2994c208ec299e0fe8a673c618e2749f0412b6ba921a1cdd957b4fdfe5607e5a7e9f14a6ddf8f7911652f71a3785ef12fc5857abeb31e0f2d2929d983acb5ba7df29bde4ec80480d82b5f378cd9dd7243070fbf51be279209c4445b6d933f575c16a61b5fe289143c1539630292c0eb8b6632991f69bb55ef5530408fb72b9e56acf752368ac97afe1aaf13a8effb83efbd64db4685a67e059900909441ebbb4c8c913b5e0bc6f7039109b4142fc4abedf0286d8723146fe8e3796adacef7812fd9415cdf5cf0ccbbe974fa483d9eae6d76a81ec7295ef559336fc37abc3bdc9f54accf7fc265bca88d9759607f0c2031c274dd63c944cef27d8ca77f2613c8a5e2e2e24f7ad6bb7016c2333e4e0fb3dc7d93ec2066dbe941be77d2934368bcbc335caabb41b14c9f4ff29b0de15ecbf6a954eaeb9c3543239a366f637f27130092d244f85aff11642237c2c1c86832811cd4f65e9e15d6d3597bc647dfcfe375a4bca614d9410b6aeb7ba8b52dfe4ed15ddbe6703d8ef7fa958a77bdd69f3ebfcbcbd0689bcdeaf1904e9d3aed4edad00c4d9b67c33d964c0048caa035483bc8b3c944ce0ea4bb7889053281e6e083616d5f67f83e1ec51a5f32a6c8e8f94f931de4785bf47a7e3ff6f6e7cb6ffd66953e7f369c357bddf7f6eaf3abbcbd663299dfeb715f3774640e393cfe59e65972c90480a40c5a9e3deb383291b37c972aae251368c283e3ef87c57e6787457e6ff0e2be5e0c98eca099b5f5416f68bace084dd8c4d094f9acd91c376ba169cbb889733347da108371f38bda265793090089e1773ebd761899c859d3e6039ba164028d3950f6a2be8a4bb53dbde829ccbd08b0d75a642d2934075f9ee8cb14c3e58a1784cb17e786c66c69b8bcd1973976f7658f610919ce9a21b63c93a827b321130092d444acd1e0b52799c85993dcc7d3ab9309d487677cf4c1b0eaf56a5fd213d6981ae8331764074dc1137a78620f4ff0a1edeacc30e1c7a4b0bdf992c667c2c42065e1dedc833c71089943428f7dfa292e21130012413be8cfb869231339df510c2413a88dd79fd2c1f19fb5bddca6784bf194ef3fcd6432df263b68284f85ef29f1b52d158529f2ef0e53e66f0c53e87b2afd619e5a3f4cb1bf771bce9a21cf781667458a4c0048045f16e9774fc9444e9bb6816edcc804aae23752c26435f77bc6472fc7a1038bae4545455f223ba82b9f35f322d2e112b09e6171e9c961b1e9f561f1e93bc262d4055ea3cf6f129039b4a27df1ab2c79022031fc2e93e21e3291d31dc520af8f452650619bd85b75d82d4ce0b0c635e97b874a4a4af6203ba889b7116d33876a7be9acc70bbded844b677dd6ec152ff3a0c72bc3d22ebf4da5525f216b68edc27228efb4e10c3280040d5c67bb892013396d9487fa667d32d1eab783efa9f6fa2a662956296e527462c64754e6c96514dfd2f6f1476d37bd3cfbacc690297a5ca1c775de86f4384a8ffdf598561ca8efff389903aa1d7f8ff2fd9a6402409206ae6b7ce91599c81d1f7079da7f32d1ea786af49fea40e162c50b5e48d80d7c3a9d3e82191f619e10cab382faf2586f27da46eed5e37c3d6e522c563cea59423d667bbbd1e75f266b40838e7dce510c26130092d4408cf34c6164227794ef5b7c291399c87feddab5dbc597a4792af4b06ed57f7c099ba74e273bad779bf044325e47cf9749ebf17a3d4e55bc19ee61fcb7279e09ebee1d97cd660fe0ec2bd0e4c73e776b5f5c4826002469e05aa48383ef90899ce67cb46ffc2713f9c99339e858e01837e75eb8553143f157eaac750913cafc5caffb099e56dc33d5e97141386bf6b2e211c53ff43da7e8b11d13cd0039dd0fbfac1afd2e990090089e5d4c03d7e60e1d3a7c946c340fdfecac1cef5b7142091fbcf9a09eece48f70595be77060bed60b0d7be207267dc86f3e6be666dcf7227afd453d8e543c11ee515ca398199af7be7afc8be2078cb740cbf2fed8f782b66112120049a103caafe960622999683ebe6e5e398eaa0acf5ca5c7257ef79d590213593f5ff13a568a09e100fd5e45310bd5e71fbff9924ea77fa9d7f744d5eda57a7c20dc97e8b3662f291ed2e797fb5e557ddfaff5f117c81a10db7afe8d2f4926130012c397e478063232d17c7c2f4a581729aa2198bd33398dda7743233ed3973efa2c8acf9a32535ff29596967e44afe57e7a7dffe459751537ea359e1e2e717ddb0b9b2b6ed6f3e7eaf158bde6df57ec4ae680c41dfb9ce5097dc80480c408f75adc4c269a7f075143c3b6c9efe293a558bf7e8784c9433c89c852c5304f2ee24be3c84e221befcfa9e60ed36bf87f7ec344e3e0837a7c319c355ba818e359e5f43d27e9e35f1517177f9eac01f943b57da7af8a2013009274303a50072703c844b3ef207c5fdbfa6a9ab63232142f6ec67cf98ca7e3f7b4fc61f2888bf4f94fda700f44521ab35dc33a78c78633a35e03efc970c6ecadf0b19ffbabcf94fa7b7da68dcc01ade2d8e745df5f4a26002469e0ba9d779b7296eb4155ddd3c6bd6cb139c8ffb82f8bf399e77039dcbf7d199c2f97233bf1e5b360be874cafd7c93e3be6b3649e11379c357b31dc7b7699cfaaf9ec1a67b581d6ad53a74ebbfb4d54d6c60490b446e249df5c4f269a9f0ffe2b376dbefc8accb49c308358915e8b7f85894426eac0bf5b369bfd2ad9890fcfb6e877c5f5dafc3934d29e8d714698c8677598adf106df87e6c6dbf71d72d60c4055c29b3c4f920900496bda56b036504ef37d5b85a6ed25ee896a91d7e0cb3ab0efea45e5c342c6f7eb60bf8bd7d4223b2d4bafc117f55a1cee1918bd7e995ea787c3cc8c9bc225aaf77be6c6702fee2f3a77eefc59b206a03e34c6f4d0f8319c4c00480c2f00ac816b631beed1c9e541e9b794f36de1d2c8ee6424373299ccb77d1626ccfee7fb996ef5bd4eae01b2935b3e6ba66d7f7faf59a6c7bf85d7626638d3b952312dac75e6d9dd3a7a0d34dedc00d054fce6a9dff821130012c3971b79363c3291f31d86efb9798f333bcddea81dac6dfcef8af9caf732eda4af4aa7d347d200e486cfe07b4911c5a9cafd103d3ea2581cce9afd272c307fb13e2ed1e3cfa90700393af699aff1e7876402406268d03ada971f91899c376d8728efdb7cc6816c341ddf541e9a842b15af8649282e511cda86b3c9cdc26b1066b3d903b43da794e77ee1f2df59e1b2d337bd78ade23a1d24f5f678e333cddcfc0fa0a5842b8cdee5cd3b00496b1ecef07a53f9f07f89a26897c58b17df3d63c68cf7274e9c188d1f3f9e68404c9830219a3a75ea6a4551529a065f421716415ea598ed4beebce83115dea40df157c212085dbd20ad1e1f53ae97f8f2ea7026d313b95ce47b03dd2433232a80981ef7fcc2330393090089120ebe7ae5c3ffc50ddbb469d3a2952b57465bb66c211a11ab56ad8aa64c99b2560ddc71316d203ead9d6e4671b7ef83d2763c49d15d1fef4d55372aaf5ef2e087ca655ab9ec1f960399adcfd7e971b9e271c5b51e333299cc1ff4f84dce9a014812cf0eacb8864c004894b07ed131f9f07ff119361ab6266ddcb68c1f3f7e418c1a8a2f867ba31e0b97de3de07ba1983db0febc9c8172f75bd5fe6961f1f0b18a577cd64cf19c9ebb478f177afd4635673f75934cd600e4c971cf4d5ed3914c0048dae0f59c0edc0ecc87ff8b2f89a4d96ada50d3b6ad851bb56fa981e8e3f574146f6b5b1de519078b8b8b3f49f5d6ccf76da8e1fa91f2a7d41d7f9ee20ec5d35e5056f18662b26284a7bed6f774d0f77ea3acac6c27320720cf8f7be67a922a3201206983d7864e9d3aed9e0fff17df8f45a3d5e44d5bd402dbe4418a0bfc8642682e46a8a9388a8592abd4d69784aaf1fa9d2ff9f1fda961edb9d77ca3bd9e9ba7afdda58f077a01717dfe936c36fb29d206a035f23dd01e1b53a9d4ae640340621417177fde1337e4cbffa7ae4ddb8635cba3c5b36e8ae64fb86047f8633f4793d6324d9bef894aa7d3bf0e53c2fb12bd856a302ef314f06d98f1b1bc563fa9fcfc583929547eca14a3f5f9b37ed3c54b1928262aaed67367ea5bdaebe37d396b0600ffcb977b6b7c7c864c004814cff0964f3328d5a5695bffceb2e8f9b1fda3b90ff7f99ff073fe1a8d5add9bb6f2e6a021af95973ad0cffe312ca0bc325cb6d7cfeb06b6e2926cab038a7d7c56d193aa784d39e5648262a9df1956cc51fc339c85ccf8f29e7c394b0e00393aee39d5fb1d32012051c2bbf6a35b53d3b674fe831f6ad8cae3f5f96368d4ead8b485866d932fc9abebebe3cbf20a3f70977eee1dcf44e833436e545a53dda552a9dddc7085d92f2f088dd89cd098b9419be0862d346e4785fc70c611001a4963eaf55eb6844c0048dae0f5371d185edc9a9ab605932fadb669f3d768d46a6fdac2c4169b149127b3a8e58d812fe87b4a158f86191fc7284ed4f37be5736df9d2449f8554c3f57b37a6be74315cc2e84b1937844b1b47fb524777b1bef491c95500a07985ab3a0e25130092628f30788dcca7696febd2b43d3fbeacdaa6cd5fa351abb969f314fb8a6da161db11951b30cf42a8e77aeb6b4f78c647cf5aa8a624e5334cf956483e7ba8ffdf219ee4234cf6e1b388f3c259b3d7f4f9784f0ee233929e2c24ac23c7593300c8314f3ee2b1d99391900d004970a4c207e2477b4162afd544d346d35697a6adaa862d346d277941e63041c65c2fc2ec854b7d96291f66e8f2593337a29e16dfd3e37b36cb305dfe1b61fafc67c274fae7f92ca4a7d9f774fb0c3500101fbea2c16faa9109004969d8de510cf1e371c71df7a60f465b53d3e6d922ab6bdafc351ab5aa9bb6ea1a368776823eabf4926290e217499db5d00b488799c58ad59cfd3d2c30fd5c5870dab35a8e0d0b519fee373bbc40751bce9a014022f80d462fac4d260024a5613bda9fecbcf3ce7f50d3b65d8f7f6a4d4ddba2e9c3ab6ddafc351ab50f376d6a54cea9ae610be1cb4df6484863b6b3fe3fdf5473f6073df6d2df7ead2744f1d941edd0d7e971b6e2767d6d803e4ffb0ca27ee6e30c1f00906cbe4ac2133c9109008969d8caedb2cb2e4755f57c3e376d6f2d9b173d3feebc0f5f1aa9e7fc351ab50f376d35346b15e3b8386d0b6e227db3b976d05df47891e25f8ae7c359b3256ac61ed3d7aef02c627afc8d1ab3af304c00405e376d33d3e9f42fc9048044356c95bebe5ed1be35346d8e25b36ffd50d3e6e768d2aa6dda666432192fe67cb9e23e7dbea88aa6edb65cbfde3e6ba6f896fea6a3c3c427d7e9718a1edf0c3355cef2dfe5f5df3c118abe762037a00340ebd3ae5dbb5d3c732fb3f402486ac356ae7d9b3c38e356a7a66df3e668d193233e7c69a49ef3d768d4eab64e9b67824ca7d3bdd50cf992c25b7dd94973bdae6a18f754c3f573df57e7252a42e3f89fb0ecc062c5237a6e88174dd5df74445151d197287d004039bf69e7fd06990090e486ad62e3b6aa4d82cfb8d5d6b4ad7f6759b470fab06aef69f3d7fc3d346b35376d3e5be59bb9cbef73abcf02dbd5f1bba0fa3ddfd18eb5a37ee75961398a698a958a35beacc5cd61585bf02f7adcbf43870e1fa5cc0100b5099369dd46260024bd61abf873abda24f48c5bb54ddbe6cdd1f24593a2e71eeb5b6dc3561efe1e7f2f67ddaa6eda3c9d7d5818bae2ec91d7d7f535eadcb9f3673dc3a47ee604c5a5faf87ec58270d6ec253df7b01effe105b9d59c1d9e4aa5be483903001ad9b40d53f4241300f2a161abf8f389bcc7adaaa6adb6b36b9c75ab7bd356c32c92d32abe0ea5a5a51f51b3f55d3ddf498dd7d97abc212cb4bd5abfe31ddf23a7e76f519cabcfffacc71f70d60c00d08c4ddb74bf11482600c4b561f31a525ddad4be9654e5ef4be43d6e55356d7539bb56d359379ab6f191d7230b8b49573773e4dbda195ea6c707142f86b3669eace421356583f578723a9dfe757171f1e7295100402e79ed50ed87d66b5ff629b20120ae0ddb0d8a283cb6ada161abeafbca7f5f62ceb855d5b435b4612b0f9ab61db347aeaa6dca7f356517eaf1583569df4ba552bb528e008038d03ee9fbda3f2d241300e2d8b05997d0884535346e151bb6f2e85ce9f7ae6f53cf336e61a28ab372bde0725da7fc27eaddb4adf4658d858585efd7d0b81d42190200e246fbae22c59d6402401c1bb6ea1ab28a8d5b555f1f59456357e74b253528ee1566fe5b1e0ee4f7a569cb9f7bdafcfa2a7a844b2537556cdaf4fc49942200206ebc248ca20f990010c786adb6c66da73a366c15ff9d6a6795f402c73a701f182699a878f685a62d4fd7690b0dfaa961cd344f4e3290720400c48df65753b48ffa2d990010d786ada6c6edc57a346c951bb7f6959ab5db2a9f75290fafbd45d3969f4d5ba5a67d37ed14f7a324010031d356c7236b3399cc9ea402409c1bb69a1ab7fa346ce5765c2ab9f7de7bf7d42038a69ae9dfff1bb94e0a4d5bcb346d0000c4514141c177743cb2984c0068097b84666b443d7fce9744563ec3f66278beeebf64a79dcef5cf1e7becb1db6b9b51503141f148b8846eb4d7e6f242ccfa78b83ebe5c71b13e2e0beb75f55274f3f4f07aecacc702cf4698c964fee0cb1af43d87e9e39fea6b3ff4599d542af575c5577c995ea74e9d76f73a5f346d346d00005468da740871fcdd6402404ba9ef74fc359d69ab693980ffb1f3ce3b7748a7d3919aa5755e8f4b0dd342c5baea9ab6d07c1da7ef39c64d983ff78415faf87437696ed6f4f1798a8bdcc4b999535ce7e6ce4d9ee25e7ddfc3a1f99ba698a998a358e077ce14af7b3afaf0376cf1bf49a345d3060080e9b860908f35c8048038346e4d714f5b5d1a373788abd4b8750cb308eee7b35f6ec83299cc08355755356f2f29d628b68619259f0b330fdead1811262f395391d5eff8bde260c53ec5c5c59f6c484238d346d306004085a66da28f2fc80480b8376ed54deb5fd5ec9135356eb59ed9f3641461bafff5a1615b5afeb5d2d2d28fe8eb5f5473b6bf9e6fa7c794a2ab3eeeafb85271bb62ace269c5ab8a77c3e4264bf57dcfaa311cef3556f4f9307d3e401f9fa6482b7ea33850cf7fd90b3ad3b4d1b40100502eac31ba1799001097c66d55150d556debb0d5b68e5bb943aaf9fd550a53c1fb0cdab38df94fa909fbb87ecfde8a83f43b7f57f881ee8af3f5bbafd2f3fff43b688ab98a377c7964e7ce9da3eeddbb477dfbf68d2ebae8a268d8b061d14d37dd14dd73cf3dd1638f3d164d9f3e3d9a3b776eb478f1e268f5ead5d1a64d9b68cc68da0000792893c97c43c706af9109007152be0076c5c6aa4b9bda6789acaa71eb5ca921f4ef3dae014dd76eb94ec2238f3c12bdfefaebd182050ba259b3664513274e8c1e78e08168d4a851d135d75c130d1a34283aefbcf3a25ebd7a45a5a5a551369b8d4e3ae9a4a8478f1e51fffefda34b2fbd34bafaeaaba35b6fbd35baefbefb76342c3367ce8ce6cf9f1fbdf6da6bd1db6fbf1d6ddebc99a60d0080980b57f5dc472600c48d1bacf56dfeffa592151bb29aa6f5afeefb1adcb0b594fa5e1ee906ecadb7de8a5e7df5d5e8f9e79f8f66cc98118d1b372ebaf7de7ba35b6eb925baeaaaaba24b2eb924ead7af5f74e6996746279e78e28e46efe4934f8e7af7ee1d9595954583070f8eaebdf6dae8f6db6f8f1e7cf0c168f2e4c9d1ecd9b3a3175e78215ab66c59b476ed5a9a360000722ccc50dd9f4c0088a3f655346e9ddbd43ec948e5ef2b3f73777492fef3b9b8a76de3c68dd1aa55ab765c62e94b2d7dc9a52fbdbcfbeebba31b6fbc311a3a746874e1851746e79e7b6ed4ad5bb7a84b972e51717171d4b56bd7e8ecb3cf8e2eb8e08268c89021d1f5d75f1f8d1e3d3a7af8e187a32953a644cf3cf34cb468d1a268c58a15d1860d1b68da0000688470affc1fc90480b8aaee1eb7fa347e896bd872d5b43524dc84b9197353e6e6cc4d9a9b35376d6ededcc4b9997353e7e6ce4d9e9b3d377d6efedc04ba197453e8e6b0f2fd796e22dd4cd2b40100f0dfa66d952741231300e2aca18dd7916d12dab0c5b9696b48f8b24a5f5ee9cb2c7db9a52fbbf4e597be0cd39763fab24c5f9ee9cb347db9a62fdbf4e59bbe8cd39773fab24e5fdee9cb3c7db9a72ffbf4e59fbe0cd49783fab2d0badc9f47d30600481a356b5ff3246564024012d4b7014b74c3966f4d5b7dc30d98274af184299e38c513a8381f9e50c513ab7882154fb4e209573cf18a276071a3e709593c318b2768f1442d9eb0c513b77802174fe4e2d9373399cc4f3d0b97beff5394150020eed4b01dab1843260024c58e05b1dbd47ea9e4216d1236e9084d5be3c34b1e78e983caf7e7798904376b5e32a14f9f3e5e73efdf8ac58585855e407d4b5862616e5872e19f5e82c14b31842519ec775eaac14b3678e906ca100090e3a66da0f74b64024092d47606cd5f5f9ef4868da62d3713917811732f66ee45cdc3e2e65ee4fc342f7aeec5cfbd08ba1743f73a7d5e1c3d2c92fe6e5834fde97063f8ed6151f5fe5e64ddd3328745d7f7f7fd075e8c9db205003494f6270f2bfe44260024b1715b5f45e356d5fa6e346d4493ded3565c5cfcc94c26b38fe260c5efb523cd2acef43ba18a118abb159315cf29962bb62ad6285e52cc503ca4b8593f3358718e9ac29314c7280e53ece705ddcbcaca76a2cc0100a67dc68a6c36fb55320120c98d5bfb0a0d5b636699a469a3696b362525257ba452a96fa949fb99e268ed804b1467292e518c54dcaf78420ddb0b7a5cadd8e6c7f0f9135e505571bdd7e951f45674f1d4cf8a43f5fc37f5bb3fcd90000079d9b07d59b1924c0048b2f2336b65a1813b269ffe73346dad77ca7f9f69f319b770e6edb07026ee249f99f3193a7d7c8b2f97d18e7ca6e265c5da70466f7938c337399cf1f399bf813e13e83382e1cce08f3d1359c78e1d3fc1100200f1a6f1bea3c6f147c90480a4f319b728df1a369a3616d7ae2fdf3b575454f4a56c367b403a9d3ec2f7d6f91e3bdf6b17eeb9bb3ddc83f774b827cff7e66d54bca67846314e71877e66a8efe9f3bd7de11e3fdfeb77a0dfedf53d800c3900903b1a7bcf535c482600e4833df2f13f45d346d3d6dc3c1ba667c5f4d937c551fa38a338437181e26a356b772926e96bf3c22c9b5bc2ac9b8bc32c9c8ff8ac9fe272c5b9fafce43035f5aff433dfd3efff9c6267320d000d6eda1ed0f8fa17320100346d346da833af6fe775eec27a777f5073d659d14b07161729aef3fd777a9ca658a05815eecf7b4bf1a262ba0f401437e8fb2e55f4519ce0cb7f143ff77d7fbeff4fff4c5b320d003b9ab6d715fb920900a069a36943b3f1fd799d3b77feac1ab2efa6d3e95f7ada6a1d80fc9fe2af8a418a9bbc68ace229c5227dfd9d707fde0ac5f38ac7f5dc3d8a6bd4d8fd5dd14351a468afaf1de28319fdeeddc834807c535c5cfc79bfe945260080a68da60db1d3ae5dbb5dd4947d41f103af79a7384e71aaa29f9ebb42314a4ddc63fa7cb6e215c506c5e6f08ef41cc504c568afb517ee07395d51a0f8ad7eee876af2bed2a143878f92690071a6f1aa83d70a25130040d346d386bc505252f231af6394c9647e944ea78fd4c1cef18a6e6ad4ca14c3431337513157b12c3479eb154b14b33c3b9be236fdcc10c5df74a0748aef23511ceee6d14da49b49320d20874ddbdf7c29399900009a369a36b45a9d3a75da3d954a7d5d07453ff13bda6ada8a153d3d539be25ac5bfd4ac4d51ccd7c76f86fbf3de562c543ca99f79505fbb517199e26c3d77a2a293e217fada77f4bb3fd386fbf3003490c7205f2540260080a68da60da8bbb6994c664fc5b73d714a68d04e74c3161ab71bddc8b9a10b8ddddba1d15ba9f88f62aae25e4fd8121a433788c56e18dd38ba817423499a0184a6ed154fd044260080a68da60d68465ef2c09309e8f1fbe974fad76acefeac03b152455fc53f14b77ae984b084c29270c9e6967009e7dc7049e73ff57357a9293c5fd1bdf003bfd3f30779c9062fdd40a681fce2099c54df6bda70b61e0068da68da80f8f124299e2cc593a678f2943089cae9615295616ad8eef4e404fafab3fa7ca96253988cc593b2ccf6242d9eacc593b678f29630898b277369a7afedafdffd452fc64ea681f80a6fcc4c261300107313274ea4d16adad8a4a66d1b5b16f2517171f1273399cc3e8a8315bf0fcb22787984bf7bb9042f9be0e513c2320a2bc2b20a6b142f2966281e52dcacef1bac38c7cb327879062fd3e0e51afcaebf976f20d3406e785914d5efe5640200626eead4a9cb57ae5c49b3d544b16cd9b2d16ada16b065013bb4f542e6be5f46cdd9cf1447eb20b1447196e212c548c5fd8a2774e0f84258207d5b5830dd0ba74ff342ea8aebf5f58b15bd155df4fc1f1587eaf96fea777f9a34030d6eda7c5974964c0040cc4d9a34e94f8f3ffef89a37df7c73234d57e3ceb0b9619b3061c2ab8ae3d8b28086f1fd798acfe940f27b3aa0fc95e258c5c96ad6cef51901c52dfadac37a6ea6e265c5da707fde1b7a7e9ebe3e4971973ebf5a7181e20c45465f3b4af163fdeeaf75ecd8f113641ad8d1b4bda47ad98f4c004002a8c9387afcf8f1b37c599fefc7221a14cedd021a36a0451abd5d8b8a8abe94cd660f48a7d347a8394be940f4343d0e500cd581e91d8a718a6714af293686782d3ce7afdde1eff5cf849f4df977f977fa77fbdf20d3c8b3baf9b4b6f5755c920c00008058f2d9369f75f3d9379f85f3d9b87056ce67e7aef6d93a9fb5f3d93b9fc50b67f3d686b37b337db6cf67fdc2d9bf737d36309c15fc95cf12fa6ca1cf1a9269c495df94f025c8640200000079c367267c1f9defa7f37d75bebf2edc6777b1efbbf3fd773e080ef7e3ad0af7e7bd15eed77b22dcbf3732dccfe7fbfa4a7c9f9feff7f37d7fbeffaf0d53af2347bced6a1bbc924c000000a0d5f265679e11d333637a864ccf94e919333d639f67d0f44c9a6146cd196186cd3561c6cd156106cec73d23a767e6f40c9d61a6ce22cfdc1966f0dcc7337a92693484b6afdbfdc6039900000000eac16bdb798d3baf75e735efc2da775e03af9fd7c4f3da785e23cf6be58535f3368435f4967a4d3dafade735f6bcd65e5873eff4b006df6fbd269fd7e6f31a7d641a3e03eced8c4c00000000cd4c8dd8c7d594edad38c88b25177ea0bbe27c1d945fe569dd1513157315cbc2fd79eb154b14b3148f286e55fc43d15751aa9ffb733a9dfeb57ef7f78b8b8b3fcffd7979b7cdece6869fd71500000088a94e9d3aedae03f6afab39fb89a2830ee08b153d15172aae53dcab98aaf88f6265b83fef6dc542c593fa9907d514dea8b84c71b69e3b51d1491fff3c93c97c5bb1671beecf8badb09cc6536402000000c81f6dd5e47d46cdda7774b0ff0b37686ed4dcb085c6ed4637726ee84263f77668f4ded4d7e62ba6e8e37f29ae0d8da11bc462378c6e1cdd40ba9124cdb9a19c9fe9b3b0640200000068c5dab56bb78b9ab52f287ea0385cf117c5296a16fea618a2a6ed36c5a3e112cd25e192cdcde112ceb9e192ced18ae18a32fd4c37c5f1e974fac84c26f3a36c36fbd59292928f91e9faf372156ebac904000000807af124299e2cc593a678f2943089cae961529561a1899ba098a3783d34791bc2a42cb33d498b276bf1a42d9ebc254ce2e2c95cda85e6f10b6e265b7b9e3d3ba91b5fb63800000000cd2e4caab1afe2103565edbd2c42581ee1ef5e2ec1cb2678f984b08c829753d8aae7ded1e322dfd7a518a3b84931c8cb317859062fcfe0651abc5c83976df0f20df9922f2f2cafffe3bb9ea994ad07000000401cb5f542e65ed0dc13a7283aaa493b41d14771a91a9a1b140f28a62b5ef402e9e1febc5561e1f4696121754fd872913eeea5e89cc964fea0f8a9e21bd96cf65371fdcffbffec4b52d90c00000000e40d4f8daff89c9ab3ef8599178f559cac06e85cc5e5e11e312f9df06fc5627dbe2e2cadf0867e669e3e9fa4b84b9f5fadb840718622a3af1da5f8b17ef7d7bc74432efe2fe172d36b795501000000b4f6466f5735475f56b376a0e2378ab4e2343569031443f5b53b14e314cf285e536cf4658b8a57154f2bc62a6e575ca9e8af9fe9aa48a5d3e923b2d9ec014545455f6ac8258ee14c6229af1000000000d493ef37f359379f7dcb6432bfd763d6d3f3abc91aa818a1b85b3159f19c62b9efcf53ac55bcac98a9ef7dd867fdf43858718e3e3e49718ce230c57e8abdc2242e87906d00000000c80135799f5683f64d3562872afea8c6ac8ba2b7e2623d7f7db8ffee097dfe8262b53e8e7275292600000000a09eba77effe51b20000000000000000000000000000000000000000000000000000000000000000000000000000000000f9e9ff010d9af93be04627a50000000049454e44ae426082	t
5017	1	hist.var-task_approve	\N	\\xaced00057372001e636f6d2e6d616e6167652e626173652e6163742e416374417070726f76654dc9bea77e0ca0310200034c0007636f6d6d656e747400124c6a6176612f6c616e672f537472696e673b4c000770726f6365737374002b4c636f6d2f6d616e6167652f626173652f64617461626173652f656e756d732f41637450726f636573733b4c000675736572496471007e00017870740009e68891e7bb9fe4b8807e720029636f6d2e6d616e6167652e626173652e64617461626173652e656e756d732e41637450726f6365737300000000000000001200007872000e6a6176612e6c616e672e456e756d0000000000000000120000787074000541475245457400057573657232	\N
5026	1	hist.var-task_approve	\N	\\xaced00057372001e636f6d2e6d616e6167652e626173652e6163742e416374417070726f76654dc9bea77e0ca0310200034c0007636f6d6d656e747400124c6a6176612f6c616e672f537472696e673b4c000770726f6365737374002b4c636f6d2f6d616e6167652f626173652f64617461626173652f656e756d732f41637450726f636573733b4c000675736572496471007e00017870740009e68891e68b92e7bb9d7e720029636f6d2e6d616e6167652e626173652e64617461626173652e656e756d732e41637450726f6365737300000000000000001200007872000e6a6176612e6c616e672e456e756d0000000000000000120000787074000652454a4543547400057573657233	\N
5033	1	hist.var-task_approve	\N	\\xaced00057372001e636f6d2e6d616e6167652e626173652e6163742e416374417070726f76654dc9bea77e0ca0310200034c0007636f6d6d656e747400124c6a6176612f6c616e672f537472696e673b4c000770726f6365737374002b4c636f6d2f6d616e6167652f626173652f64617461626173652f656e756d732f41637450726f636573733b4c000675736572496471007e0001787074000ce9878de696b0e794b3e8afb77e720029636f6d2e6d616e6167652e626173652e64617461626173652e656e756d732e41637450726f6365737300000000000000001200007872000e6a6176612e6c616e672e456e756d000000000000000012000078707400054150504c597400057573657231	\N
7503	1	hist.var-task_approve	\N	\\xaced00057372001e636f6d2e6d616e6167652e626173652e6163742e416374417070726f76654dc9bea77e0ca0310200034c0007636f6d6d656e747400124c6a6176612f6c616e672f537472696e673b4c000770726f6365737374002b4c636f6d2f6d616e6167652f626173652f64617461626173652f656e756d732f41637450726f636573733b4c000675736572496471007e000178707400036161617e720029636f6d2e6d616e6167652e626173652e64617461626173652e656e756d732e41637450726f6365737300000000000000001200007872000e6a6176612e6c616e672e456e756d0000000000000000120000787074000541475245457400057573657232	\N
7511	1	hist.var-task_approve	\N	\\xaced00057372001e636f6d2e6d616e6167652e626173652e6163742e416374417070726f76654dc9bea77e0ca0310200034c0007636f6d6d656e747400124c6a6176612f6c616e672f537472696e673b4c000770726f6365737374002b4c636f6d2f6d616e6167652f626173652f64617461626173652f656e756d732f41637450726f636573733b4c000675736572496471007e000178707400036161617e720029636f6d2e6d616e6167652e626173652e64617461626173652e656e756d732e41637450726f6365737300000000000000001200007872000e6a6176612e6c616e672e456e756d0000000000000000120000787074000541475245457400057573657233	\N
7519	1	hist.var-task_approve	\N	\\xaced00057372001e636f6d2e6d616e6167652e626173652e6163742e416374417070726f76654dc9bea77e0ca0310200034c0007636f6d6d656e747400124c6a6176612f6c616e672f537472696e673b4c000770726f6365737374002b4c636f6d2f6d616e6167652f626173652f64617461626173652f656e756d732f41637450726f636573733b4c000675736572496471007e000178707400036161617e720029636f6d2e6d616e6167652e626173652e64617461626173652e656e756d732e41637450726f6365737300000000000000001200007872000e6a6176612e6c616e672e456e756d0000000000000000120000787074000541475245457400057573657234	\N
12502	1	/home/facheng/source/fc/acme/cqjz/target/classes/assets/bpm/actNews.bpmn	12501	\\x3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d3822207374616e64616c6f6e653d22796573223f3e0a3c646566696e6974696f6e7320786d6c6e733d22687474703a2f2f7777772e6f6d672e6f72672f737065632f42504d4e2f32303130303532342f4d4f44454c2220786d6c6e733a61637469766974693d22687474703a2f2f61637469766974692e6f72672f62706d6e2220786d6c6e733a62706d6e64693d22687474703a2f2f7777772e6f6d672e6f72672f737065632f42504d4e2f32303130303532342f44492220786d6c6e733a64633d22687474703a2f2f7777772e6f6d672e6f72672f737065632f44442f32303130303532342f44432220786d6c6e733a64693d22687474703a2f2f7777772e6f6d672e6f72672f737065632f44442f32303130303532342f44492220786d6c6e733a746e733d22687474703a2f2f736f75726365666f7267652e6e65742f62706d6e2f646566696e6974696f6e732f5f32303137313030362220786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612220786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e63652220786d6c6e733a79616f7169616e673d22687474703a2f2f62706d6e2e736f75726365666f7267652e6e6574222065787072657373696f6e4c616e67756167653d22687474703a2f2f7777772e77332e6f72672f313939392f5850617468222069643d225f323031373130303622206e616d653d22244445465f4e414d452422207461726765744e616d6573706163653d22687474703a2f2f736f75726365666f7267652e6e65742f62706d6e2f646566696e6974696f6e732f5f32303137313030362220747970654c616e67756167653d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61223e0a20203c70726f636573732069643d226163745f6e6577735f617070726f766522206973436c6f7365643d2266616c73652220697345786563757461626c653d2274727565222070726f63657373547970653d224e6f6e65223e0a202020203c73746172744576656e742069643d225f3222206e616d653d22e5bc80e5a78b222f3e0a202020203c656e644576656e742069643d225f3322206e616d653d22e7bb93e69d9f222f3e0a202020203c757365725461736b2061637469766974693a61737369676e65653d22237b6170706c79557365727d222061637469766974693a6578636c75736976653d2274727565222069643d227374657030312d303122206e616d653d22e68f90e4baa4e794b3e8afb7222f3e0a202020203c757365725461736b2061637469766974693a63616e64696461746547726f7570733d22313031222061637469766974693a6578636c75736976653d2274727565222069643d2273746570303222206e616d653d22e694afe9989fe9a286e5afbce5aea1e689b9222f3e0a202020203c73657175656e6365466c6f772069643d225f362220736f757263655265663d227374657030312d303122207461726765745265663d22737465703032222f3e0a202020203c757365725461736b2061637469766974693a63616e64696461746547726f7570733d22313032222061637469766974693a6578636c75736976653d2274727565222069643d2273746570303322206e616d653d22e5ae9ae5af86e59198e5aea1e689b9222f3e0a202020203c757365725461736b2061637469766974693a63616e64696461746547726f7570733d22313033222061637469766974693a6578636c75736976653d2274727565222069643d2273746570303422206e616d653d22e680bbe9989fe9a286e5afbce5aea1e689b9222f3e0a202020203c73657175656e6365466c6f772069643d225f31322220736f757263655265663d225f3222207461726765745265663d227374657030312d3031222f3e0a202020203c6578636c7573697665476174657761792067617465776179446972656374696f6e3d22556e737065636966696564222069643d225f313322206e616d653d224578636c757369766547617465776179222f3e0a202020203c73657175656e6365466c6f772069643d225f31342220736f757263655265663d2273746570303222207461726765745265663d225f3133222f3e0a202020203c73657175656e6365466c6f772069643d225f313522206e616d653d22e5908ce6848f2220736f757263655265663d225f313322207461726765745265663d22737465703033223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b616374696f6e3d3d276167726565277d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a202020203c6578636c7573697665476174657761792067617465776179446972656374696f6e3d22556e737065636966696564222069643d225f313622206e616d653d224578636c757369766547617465776179222f3e0a202020203c73657175656e6365466c6f772069643d225f31372220736f757263655265663d2273746570303322207461726765745265663d225f3136222f3e0a202020203c73657175656e6365466c6f772069643d225f313822206e616d653d22e5908ce6848f2220736f757263655265663d225f313622207461726765745265663d22737465703034223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b616374696f6e3d3d276167726565277d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a202020203c6578636c7573697665476174657761792067617465776179446972656374696f6e3d22556e737065636966696564222069643d225f313922206e616d653d224578636c757369766547617465776179222f3e0a202020203c73657175656e6365466c6f772069643d225f32302220736f757263655265663d2273746570303422207461726765745265663d225f3139222f3e0a202020203c73657175656e6365466c6f772069643d225f323122206e616d653d22e5908ce6848f2220736f757263655265663d225f313922207461726765745265663d225f33223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b616374696f6e3d3d276167726565277d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a202020203c757365725461736b2061637469766974693a61737369676e65653d22237b6170706c79557365727d222061637469766974693a6173796e633d2266616c7365222061637469766974693a6578636c75736976653d2274727565222069643d227374657030312d303222206e616d653d22e794b3e8afb7e8a2abe98080e59b9e222f3e0a202020203c73657175656e6365466c6f772069643d225f3422206e616d653d22e68b92e7bb9d2220736f757263655265663d225f313322207461726765745265663d227374657030312d3032223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b616374696f6e3d3d2772656a656374277d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d225f3522206e616d653d22e68b92e7bb9d2220736f757263655265663d225f313922207461726765745265663d227374657030312d3032223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b616374696f6e3d3d2772656a656374277d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d225f3722206e616d653d22e68b92e7bb9d2220736f757263655265663d225f313622207461726765745265663d227374657030312d3032223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b616374696f6e3d3d2772656a656374277d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a202020203c6578636c7573697665476174657761792067617465776179446972656374696f6e3d22556e737065636966696564222069643d225f3822206e616d653d224578636c757369766547617465776179222f3e0a202020203c73657175656e6365466c6f772069643d225f392220736f757263655265663d227374657030312d303222207461726765745265663d225f38222f3e0a202020203c73657175656e6365466c6f772069643d225f313022206e616d653d22e794b3e8afb72220736f757263655265663d225f3822207461726765745265663d22737465703032223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b616374696f6e3d3d276170706c79277d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d225f313122206e616d653d22e692a4e994802220736f757263655265663d225f3822207461726765745265663d225f33223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b616374696f6e3d3d2763616e63656c277d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a20203c2f70726f636573733e0a20203c62706d6e64693a42504d4e4469616772616d20646f63756d656e746174696f6e3d226261636b67726f756e643d233343334634313b636f756e743d313b686f72697a6f6e74616c636f756e743d313b6f7269656e746174696f6e3d303b77696474683d3834322e343b6865696768743d313139352e323b696d61676561626c6557696474683d3833322e343b696d61676561626c654865696768743d313138352e323b696d61676561626c65583d352e303b696d61676561626c65593d352e30222069643d224469616772616d2d5f3122206e616d653d224e6577204469616772616d223e0a202020203c62706d6e64693a42504d4e506c616e652062706d6e456c656d656e743d226163745f6e6577735f617070726f7665223e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d225f32222069643d2253686170652d5f32223e0a20202020202020203c64633a426f756e6473206865696768743d2233322e30222077696474683d2233322e302220783d22302e302220793d223133352e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d2233322e30222077696474683d2233322e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d225f33222069643d2253686170652d5f33223e0a20202020202020203c64633a426f756e6473206865696768743d2233322e30222077696474683d2233322e302220783d223833352e302220793d223133352e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d2233322e30222077696474683d2233322e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227374657030312d3031222069643d2253686170652d7374657030312d3031223e0a20202020202020203c64633a426f756e6473206865696768743d2235352e30222077696474683d2238352e302220783d2238302e302220793d223132352e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d2235352e30222077696474683d2238352e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d22737465703032222069643d2253686170652d737465703032223e0a20202020202020203c64633a426f756e6473206865696768743d2235352e30222077696474683d2238352e302220783d223232352e302220793d223132352e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d2235352e30222077696474683d2238352e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d22737465703033222069643d2253686170652d737465703033223e0a20202020202020203c64633a426f756e6473206865696768743d2235352e30222077696474683d2238352e302220783d223432302e302220793d223132352e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d2235352e30222077696474683d2238352e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d22737465703034222069643d2253686170652d737465703034223e0a20202020202020203c64633a426f756e6473206865696768743d2235352e30222077696474683d2238352e302220783d223632352e302220793d223132352e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d2235352e30222077696474683d2238352e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d225f3133222069643d2253686170652d5f3133222069734d61726b657256697369626c653d2266616c7365223e0a20202020202020203c64633a426f756e6473206865696768743d2233322e30222077696474683d2233322e302220783d223332352e302220793d223133352e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d2233322e30222077696474683d2233322e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d225f3136222069643d2253686170652d5f3136222069734d61726b657256697369626c653d2266616c7365223e0a20202020202020203c64633a426f756e6473206865696768743d2233322e30222077696474683d2233322e302220783d223532302e302220793d223133352e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d2233322e30222077696474683d2233322e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d225f3139222069643d2253686170652d5f3139222069734d61726b657256697369626c653d2266616c7365223e0a20202020202020203c64633a426f756e6473206865696768743d2233322e30222077696474683d2233322e302220783d223733302e302220793d223133352e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d2233322e30222077696474683d2233322e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227374657030312d3032222069643d2253686170652d7374657030312d3032223e0a20202020202020203c64633a426f756e6473206865696768743d2235352e30222077696474683d2238352e302220783d223330302e302220793d223239302e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d2235352e30222077696474683d2238352e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d225f38222069643d2253686170652d5f38222069734d61726b657256697369626c653d2266616c7365223e0a20202020202020203c64633a426f756e6473206865696768743d2233322e30222077696474683d2233322e302220783d223233302e302220793d223330302e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d2233322e30222077696474683d2233322e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f3132222069643d2242504d4e456467655f5f31322220736f75726365456c656d656e743d225f322220746172676574456c656d656e743d227374657030312d3031223e0a20202020202020203c64693a776179706f696e7420783d2233322e302220793d223135312e30222f3e0a20202020202020203c64693a776179706f696e7420783d2238302e302220793d223135322e35222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f3135222069643d2242504d4e456467655f5f31352220736f75726365456c656d656e743d225f31332220746172676574456c656d656e743d22737465703033223e0a20202020202020203c64693a776179706f696e7420783d223335372e302220793d223135312e30222f3e0a20202020202020203c64693a776179706f696e7420783d223432302e302220793d223135322e35222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f3134222069643d2242504d4e456467655f5f31342220736f75726365456c656d656e743d227374657030322220746172676574456c656d656e743d225f3133223e0a20202020202020203c64693a776179706f696e7420783d223331302e302220793d223135322e35222f3e0a20202020202020203c64693a776179706f696e7420783d223332352e302220793d223135312e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f3137222069643d2242504d4e456467655f5f31372220736f75726365456c656d656e743d227374657030332220746172676574456c656d656e743d225f3136223e0a20202020202020203c64693a776179706f696e7420783d223530352e302220793d223135322e35222f3e0a20202020202020203c64693a776179706f696e7420783d223532302e302220793d223135312e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f3138222069643d2242504d4e456467655f5f31382220736f75726365456c656d656e743d225f31362220746172676574456c656d656e743d22737465703034223e0a20202020202020203c64693a776179706f696e7420783d223535322e302220793d223135312e30222f3e0a20202020202020203c64693a776179706f696e7420783d223632352e302220793d223135322e35222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f3230222069643d2242504d4e456467655f5f32302220736f75726365456c656d656e743d227374657030342220746172676574456c656d656e743d225f3139223e0a20202020202020203c64693a776179706f696e7420783d223731302e302220793d223135322e35222f3e0a20202020202020203c64693a776179706f696e7420783d223733302e302220793d223135312e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f3231222069643d2242504d4e456467655f5f32312220736f75726365456c656d656e743d225f31392220746172676574456c656d656e743d225f33223e0a20202020202020203c64693a776179706f696e7420783d223736322e302220793d223135312e30222f3e0a20202020202020203c64693a776179706f696e7420783d223833352e302220793d223135312e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f34222069643d2242504d4e456467655f5f342220736f75726365456c656d656e743d225f31332220746172676574456c656d656e743d227374657030312d3032223e0a20202020202020203c64693a776179706f696e7420783d223334352e302220793d223136332e30222f3e0a20202020202020203c64693a776179706f696e7420783d223334352e302220793d223235352e30222f3e0a20202020202020203c64693a776179706f696e7420783d223334352e302220793d223239302e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f35222069643d2242504d4e456467655f5f352220736f75726365456c656d656e743d225f31392220746172676574456c656d656e743d227374657030312d3032223e0a20202020202020203c64693a776179706f696e7420783d223735302e302220793d223136332e30222f3e0a20202020202020203c64693a776179706f696e7420783d223735302e302220793d223235352e30222f3e0a20202020202020203c64693a776179706f696e7420783d223338352e302220793d223331372e35222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f36222069643d2242504d4e456467655f5f362220736f75726365456c656d656e743d227374657030312d30312220746172676574456c656d656e743d22737465703032223e0a20202020202020203c64693a776179706f696e7420783d223136352e302220793d223135322e35222f3e0a20202020202020203c64693a776179706f696e7420783d223232352e302220793d223135322e35222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f37222069643d2242504d4e456467655f5f372220736f75726365456c656d656e743d225f31362220746172676574456c656d656e743d227374657030312d3032223e0a20202020202020203c64693a776179706f696e7420783d223534302e302220793d223136332e30222f3e0a20202020202020203c64693a776179706f696e7420783d223534302e302220793d223235352e30222f3e0a20202020202020203c64693a776179706f696e7420783d223338352e302220793d223331372e35222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f39222069643d2242504d4e456467655f5f392220736f75726365456c656d656e743d227374657030312d30322220746172676574456c656d656e743d225f38223e0a20202020202020203c64693a776179706f696e7420783d223330302e302220793d223331372e35222f3e0a20202020202020203c64693a776179706f696e7420783d223236322e302220793d223331362e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f3131222069643d2242504d4e456467655f5f31312220736f75726365456c656d656e743d225f382220746172676574456c656d656e743d225f33223e0a20202020202020203c64693a776179706f696e7420783d223234362e302220793d223333322e30222f3e0a20202020202020203c64693a776179706f696e7420783d223831302e302220793d223336302e30222f3e0a20202020202020203c64693a776179706f696e7420783d223835312e302220793d223136372e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d225f3130222069643d2242504d4e456467655f5f31302220736f75726365456c656d656e743d225f382220746172676574456c656d656e743d22737465703032223e0a20202020202020203c64693a776179706f696e7420783d223234362e302220793d223330302e30222f3e0a20202020202020203c64693a776179706f696e7420783d223234362e302220793d223138302e30222f3e0a20202020202020203c62706d6e64693a42504d4e4c6162656c3e0a202020202020202020203c64633a426f756e6473206865696768743d22302e30222077696474683d22302e302220783d22302e302220793d22302e30222f3e0a20202020202020203c2f62706d6e64693a42504d4e4c6162656c3e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a202020203c2f62706d6e64693a42504d4e506c616e653e0a20203c2f62706d6e64693a42504d4e4469616772616d3e0a3c2f646566696e6974696f6e733e0a	f
12503	1	/home/facheng/source/fc/acme/cqjz/target/classes/assets/bpm/actNews.act_news_approve.png	12501	\\x89504e470d0a1a0a0000000d494844520000036d00000172080600000066ed32ad000053f34944415478daed9d079c54d5d9ffd79e448d9a688cf1b5259aa831468d2596183436a2609d59777617d057b16241d1880d2556505430d87baf31c44213c186624345141454441054c045402cf7fffbcd7b2eff71ddceceeebdbbdfefe7f37ceecc9d3bb3b3cf9ce79cf3bbe79ce79494d4c04903c6ac73f2d5a3362ea98313af18b1761445abc8ae966d5102000000000000c545e26be899b7bcfc8d8ea31e79e5cb59ef45d1f09e578ff956cfafab76dde9831f9bfa858e2b0e7dffdbcf2ebde7d5c57a3ce8a4ab9e3c082f020000000000148973ee9cb0e8c1095f574980ddd8efbe37163ff45134f3e4414fe9697443e175573db968f6d0573e9953f54df449cfc1cf7cd7f3ead1d1c4f9d1cc93ae1a5986170100000000008a8084d96da75ef3cc77a75d3ff6db1b1f7f6fc1654f7cf495ce1d73da75cf7ea763b782eb46caaebf6ffcfcf9f7bc1d550d7d7bc1171e9dbbf7b52fe75f3ae493399e3289370100000000009a913e7dfa2c2bb1f5bb879effa46ae89bf3beb8eadfef2cf0089a14d8b493063ee991b6ee41b0ddd0ebdab1df9d3cf0a968d657d1c743267c5975c68d2f7e7bf12353beb2e0d3ebfbfbb3f0280000000000403323c1f54f8fb28d993c77dea02193bfbc7ad8fb8b6e1f33fbf393af1efd5d7ccd89578cd8b2dfa39f7e3ee0e1098b2ed3eb173e3479f10dc33f58d8ebdae7bf9bf155f43a5e040000000000687eb1b6ce1523667fd6f7deb716dff8ccac05af4d8f26f7bee945271f7974fc27d1f81bc7451f57bbfe5f53e7441f0c7ceaf3859317441ff47d60ea82efa268c2c837e6ccd46b3fc3a3000000000000cd2bda9cb6bfdf99b7bcfacdf9f7beeb242427e8b850c7e3c67ef4cde7e7dcfea2b3499ee06baf7b3e7ab7f72de3beb96ed894b93a37f6fc3b5ff16b39d91dbdae1d6ba1f7121e05000000000068664eb872d416fdee7d6df1c58fccb018bbf7d46b9ffb66ceb7d17b275d955fcf76c189578cd82e08bccefd1fffdca9fefbc83ebae7b9d9f36f7df6f32fc3754c8f0400000000002816125debcbb63b69e0933b179ceb52ed9ab5e3ec903a9ef4c827d12bf74d89def7081b59230100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000202d4451b4fc942953ee1f3b76ecb723478e8c860f1f8e35c1468c18118d1933e65359056588f24019a23e25168805206688190068365c593efdf4d3d1ac59b3a2afbefa0a5b0a9b3d7b76347af4e879aa3c0fa10c619421ea538c5800628698018066c177b7a82c9bb5d2fc6af8f0e1132943186588fa1423168098216600a059f074042abae63555985f538630ca10f529462c003143cc0040b3e0b9d05472cd5e614694218c32447d8a110b40cc103300d0a215e6fcb933a229e36e8e268c383f6f7eec73549054989421ca10100bc4021033c40c00b472855935677af4e6d0b3a3f18ff6fa9ef99c5fa39244b451862843402c100b40cc103300d08a15e6b409fff9416519db471386504922da2843942120168805206688190068cd0a73e2a84b6aad30fd1a9524a28d3244190262815800628698018056ac30df1cdea7d60ad3af514922da28436daa0cad4ecd482c100bc4023143cc10476d8b0e1d3a2c5f5656b6cfa1871eda57f6b86ca2ec6b59146c9a5e1f2ebb4856d1ad5bb71fb5ca178da2e84743870e3d79d0a0412ff4ebd76fee29a79cf2b5be4cfe4b5654547c77f2c9272f3ae79c73de3befbcf31e3ae1841376a3c2a4c244b45186da6119dac3d5a56c3f9a37628158201688196286384a3f994ce697d23b7d24c4de2d10680db119b2c1b20d5be48b7efcf1c77fbafdf6db9f3df1c413bf3df6d863a39b6fbe391a3b766c3463c68c68e1c2859159bc7871e4cd1dc78d1b17dd71c71dd131c71cf35d8f1e3d3eebddbbf7f9fa475769ef15a63335d55661fa352a49441b65a84d942137ae736403c29146965820168805628698218e523cb2565a5afa8f5c2ef76523c55a75fbdaa36f451b7993165b65d4a851c38e3ffef8effaf7ef1fbdfefaeb7971d650264c98100d1a34283ae28823beecd9b3e77eedb9c29cfceca05a2b4cbf46258968a30ca5be0ced51ad51dd8746965820168805628698218e523bbab6b184d6f8ea02cc0358d75e7b6d7e006bfaf4e94b06b07cf400d6cb2fbf1cdd7aebadd149279df403f12601f8aa6c8b661f5dbbf2ca2be7f90fbef6da6bd1d2f0f6db6f47279c70c237471d75d47f5b6d6e672b57989f4d7f3d7a73d8b93f9c96a0737e8d4a12d146194a7519daa396c6740f1a59628158201688196286384a1712567f2e2f2f9f5d28b87af5ea951764df7cf34d8335903554efdebdab8bb72a7d7ef3fc865555557f3debacb3165f75d555d1175f7c113507569ffabcaf8f3beeb8d16d6dba644337b69cfad26d3fa8307d8e0a12d146194a7519aaaf11f5eb55e12e29100bc402b140cc1033c451c2055b2e975b108b2c89b768c890218d126bd579e28927a2380f483c5d72a9859b47d82cd82ebdf4d2a5fa72b53178f0e0c5471d75d408cf116d5715e6a245d1e4e706ff705a82cef9352a49441b65289565a8a1773d99d6422c100bc4023143cc104709c7532225d83e2f9c0a3969d2a466d140efbfff7ed4a3478fea236e4d9b2ae9356c9e12e911b66208b6982baeb862414545c5ddeda5c2ac9a333d9af4ecc05ae793fb355f43458968a30ca5aa0c35769a8a1bd9d9dc1d25168805628198a10f421c258f90ce7f7ca160f31ab5e6c49f5728dcbcc6ad494bc79c74c46bd89a6b4a645d5325e58879fab21dda7485b968513463f293d11b4ff4aeb5b28ccdd7f85aee7821da2843a928434d5d57b0476864b93b4a2c100bc40231431f84384a10ce12593825b2b946d86a1a71ab3655b25fa3bea8a7453a4ba43344b6044e4e2287cc6c0bebdb6aaa30ebbbb3c51d2f441b6528b56568691782b31e81582016880562863e08719420bc0f5b615a7faf612b265ee356b8becdd3321bfc65bd0f9bd3fab7247dfbf6f50675a7b6c50ab32177b6eabae345858968a30c25b20c556f5c9791750dc7baa87e1deb1188056281582066e883104709c11b671766896ccc16674de5f4d34f2f146e831bf445f5be1f79e3ec961a658b993871e25752b51fa43d29494d1566532bcbd8a830116d94a1c495a19a1ad71b5d8586e3327534ae355d177f1e77478905628158206648de431cb512612ddbbbb180725aff96c0baab40b4cd68d0ec4315ce53bdd8ae98c9476aa35bb76eb39c5a33893fa2bedbea4dad303144dbd236ba58a2ca504dd357ba864633aaa3912d6c5c63eb52ed73abdac3ddd186de9c23168805ba90c44c1a62469dec0d73b9dc56c451b291181b2edba5ae6b9c7abf30f9484beaa1c20db8f53d2beafd87060d1af4c2cd37df1cb50603060c784d5fb46f42874a277a71607de28d0a13d186684b4f196a4805de80c6b5b6c6b3b091ade9f51b6a6884dbc5b416d5a54fab613cbebe2c59c402b14087939849431fc4a9da43f6bf87753ca411b3c688a3968da358100daf6d90c83a24beee861b6e68511d74c71d77148ab68beafd87faf5eb3777ecd8b1ad22da9e7ffef969faa2f727f4879e1a02728e8e67d5366c498589685b9a3b3c94a1962d430da9c01bd0b8d6d7c82edbc0c6b5f0efb4e90c60717dea2920b2a36beb88120bc44209d9f08899948cb4154c6d8bc28dfea3eb99e2461cb592682bb0c7abf7cb7c2e7ebda5f590a762167cb751f5fe43a79c72cad73366cc6815d1f6e9a79f7ee6829ed01f7a76e10f1dc45bb7ea7753a830116d4b73878732d43a1dd5ba2af00636ae7535b2ef34a271addec8eed3461bce19d5fc3e557e3f80582016da5b2c10336da30f525e5efe3f35c450e18dfe8d89a3448ab625fdb2b8bed3f3c9f1f996d643deb7ade07b4dabf71faaacacccef9dd61a383b8bbee4c234fdd01699faa1f7a1c244b435c71d1eca50ab77547f508197343e05734d8d6c631ad7363fada58efa741cf529b1d09e628198693b7d903a7ea3d8ee976dab4bf7248e1217474bfa65b26fe2e72dad87fcf70abf4f83fea1d6247cd1c532ef8f3057364b365df6be6c922aa7093a7aeddb8bb267654fc9869596963eaae3bff5fa7d3ade29bb45769dce5fad7357c82ed5f30b421acfde3adf4be74e921dabe7477ad44c96d3f98cef5ee572b9bfebb8a737fd96edd4801ffa65bf8f0a13d1b6347778687493d1518ded80030e18111ac6c18dfcb997ade16ee83be17c638837f77423b248363fd48bb3c39df76961dad4e4301de70dd561afba23277bdeeb603cc5c2652c344643640f857af22ed96d7a7c93eb4ad9bff4deab74bc3cd49717caced7b9735c67eadc697adc53c71e3a1ee37a53c7c374acd4b932d79d7a7ca01e76d2e38eae3fb3d9ec6e3af7173dde51e7b6d3e3ade3b51ff5d5a7ba6e7f628158a82516be721f41e5ea0b1d3f2f88878f425fe13dd93bb2b7548e5e2f8889b1b267f4bed13a8e74df41f698e3c26b91640fe8f13dee43e89a5b0b6263b06ca0fb12baa6bfec92d09fc8c787ec4c3d3e5daf9fe27e85d79ec531223b5c8fbbc8caf5b8d4eb9ddc5788e344b6971eef2efbabe26567cfc270c7deb1525e5efe874c26b3b9cefdb60131f392ac3331d3fc366cd8b0a873e7ceabcabfbff26fa1fee19fdc37f46fe87ea3acbb7ffbfa7e23bdf7eb830e3a685142e2086b80b5a20e6a9868ebdab5eb77ad38d2f6a947daba77efbe42a74e9d7ea2ca6a35d95a0e1405c906b24d4205f6c7d001d8c9159d3b0716596ee443c721a7735d5d615a94e9dc891669ee78c8ce7565eb4e89ce0db0a80b95f2cda1a2be2f54de8f860a7d541087f5fdb86e48be2e4685f9e5975fe6ad252aa769d3a621da5af10e8f1becc696a1d75e7b8d86b51e5b9a4a7bb7dd768b565c71c5a811d34aeaba2b7a6323ef8a3af3d701aaf796ebd8b1e34a9595952b3b1992eaa935bdf9679892b3a1a7dee8dca61644ce60e64e9fcb926f06b873a1cee01ebe1b1fb2621d186e4e95597005e16501768c05991e9f1c6e6a9da1c767eb789eeb4c7754f5f8b220ecfee57a33746a6fb3000c42f021bdfe9fd0111ea6734fea3846f69c6fb485cef31bf5f95ceffbd675aa8ecdf2fbbff7de7b8dbafef9e79f8fe6cc99432c243416642bba8fe08eb4cafb1a713cc8d60d7d855fbb732ddbccc2278e09d90e1646b25d8350da3308a7fd82903a3808ab5c105a8705e175741062270661765ab8f97b4e1c1fb28b83a01b608117c788ecc62000ef0882f0fed0c788e364681090be01fd4cb8d96281f98a0567b851fd4e43622618757e33daa2458b22951ffbb84af671f82d5e0a7dc321e1e6d7b5e1b7ffb296dfe7cb20f4d70b6bdce291b6568b2346da7e3862ed7ac04b9edc974fcd48db29a79cb2b0b5d6b4cd9a356b7282d7b4d535dcdda198a324b367cfce07e74b2fbd144d9e3c397afae9a7a3fbefbf3f7feede7befadf57d1f7ffc71fe1a7fcf86fe2d5fbfd5565bd52b227ddda5975e9a7ffec1071fe49f3ff2c82389eb64a4d11a5b86ecfbcd37dfbc51ef993a756abe72a8eb9a5b6eb9255a6fbdf596fce68f3efa68d4bf7ffffcdff32690d5af9f397366be2cbcf2ca2bd1d5575f9dbfce65b5aebfe1efe0eb965b6eb93aaf8bcbb23bd34de9883761746149055e84f5070d6964f72969c30bc7ebf0fba862d4a7b1ef1b7abdcbadaf7ff3cd37ebbceed9679f8df6df7fffe8e1871fce67fdf27b8e38e2884494796281986948bf62debc794b62e4d4534fa5fda865a4ad81bfd1d46abfcdd716f1beb956cb1a33e2a8f5e3a87afd96ae356de79e7beea4d6ca1e3974e8d0c792983dd27746aafdc80bc328dd162db51ec981e98df7d658638d68d75d77cd57383ee73d1d6a7b4f5555553472e4c8e89a6bae898e3aeaa8fcf5279c70429d7fc795dfde7bef9dff5b0f3ef860ad15b33b33fe3c57deae9cfd78a59556ca8b4a46da9a7e87a72965c8bedf77df7da3b7df7e3b7af1c5176b15d94e5debe3e38f3fbea483e906b2be8eae1bbadb6ebbadde46346e400f3ef8e0258f2fb8e0821aaff50d087f0f5feb72e69b1077dd7557b4eaaaabe6cb784d23cbfebcebaebbee7bcf37da68a3e6eea8fea0026f44235b5b0ae69a327dd5d5c8b6e94d519df5ae868ecdc3cdbdbed39dc0b85cba9cefb8e38ef91858618515f2f561f5eb5de7b903eb3ad365d1f5a0e3e4cc33cffc4187afb00cba8359f8fc8a2bae4844992716889986b41da3478fced7ef6fbdf5569d3769693f1ad4c64f2ebca15f531f91384a4c3fec798faed754bfa52a7b64dfbe7def6ead7ddace3efbec2149dca7ad20956b95c59aa762d4766d31449bc59783f2c73ffef192512ddfb5aaad127465e6d70e3cf0c07c85ecbbc1fe8cda3effa69b6e8a36d860832515f1baebae9b1f35f3637770eabbd3356ad4a8fcb53becb003d32397f20e4f63ca903b996e84e24afbdc73cfcd77386b6b40ddd0c5423bdc39acb5a18e6f0a78ba6c7c9d8f6e140b3ba935fd9d95575e397fa3c065d465a3b6ebdc89feecb3cfbed798fab13a28b5bec753417dfce8a38ff2dfa553a74ef9c7cdd051adb502afa1f1ab2903577d7be62cd3c04676db92369ee1aba03e75c7f37a3f2f467d1afbd99db9c2721e97e3c23ad153217d7ecb2db7cc8f9ab933eaba739b6db6c9770a3d925dd374c9b83cfa3a9761774e6bbbd1d5d2659e582066ea32976f8b9d3df7dc738920f346c2b41f4b25da3cea39d9ed7a237e5ee2a86563a9ae9b51f135e9d9a7ad478f1edb1f73cc31dfb5e40ee0f154ce5c2ef74103f687698d91b65f3a81497d1b6b1743b4f9f3e22905f170be1f0f1c38303ff5209eda50dd3ceae2eb3cf21557a06badb556adeb37fc7a5c01c67faba4600a64e108dbe5975fbea4428eef62fbb9ef487ba46ee79d7746b42d45a7a8316528ee6cfaf7f61490ba1ac37874d4bfad3ba6b59587f82ea7a7dec6d34eaadf01adade18defacfa6fc45378dd69aee9cead6f26f8b91be835d75c33ead2a5cb0faeb5b9e1bef8e28bf3efb9f2ca2bf3c778ba4b7cc3e0f0c30f6f6a47b5de0abc966926d5ef5a762da93fa3574d8d6c971aee861ed2961bcdb00eefe6ba3a9e4b5b9fc665cc37b57c03ca77ece3b25893a872dde79870b9f28db1b853eaba2d2e639e4e56fd7d1b6fbc71a4b293bf3e2eef167eb57d9f962cf3c402315397adb6da6ad1eebbeffebdbafbbcf3cea3fd588a3e88fbaf8d8c1fe22881b87f16f7d77c23a325f5d089279ef85d8168ab68d017d69b66fb2e7e4b3276ec584f8d9cdac4029f188a39d2e64ad09592a7237a0a80cd02aa7af290b842b2628f2b423f76c7a4ae4e7d3c4217dfa9f2637f7e7c8d477136dd74d32515afbf8bbf832b70df8d2e29d2bab63624da1ad4296a681972a3e5bb405e8770f4d1472f1981adab318c7f370bfe9e3d7bd67aad3bab6e38d75e7bedfc94cbe38f3f3e7fde8feb9ae6e2b2e8c6369e0ee3c775ada77063ea69b5f11dde9230d5b37af92fec84fbe8d1614f6df1da88fad65614a90cb931ac2a98d652d878d69582b9b6eb685c9bb93e8deb3b8f2894d4b3fe372e7b165f8e8fb8936a73dd66aba9ccbbfe73bde87872ccb8fef34c85249479628198a92f3eec7b8b1ed7f3b5955bda8f16eb8310470921242399168b274f596c09acbb0a6eeecfa86763f6ffcf59679d756efffefdbf6b49d176d45147796ae4a9edb99351db8278af437340c6e22d9e7260015553e6408fbe79c8bff05a0babfa3a2cf15d289b3b23f5dd49f3285e5c195a14faaeb32b67445bcb94a1f8b78d47dbea1ae1f4eb1e41f01497b8c1abe9f7f5eb2e3b9ea2e206d30d792cc83d5536febddda8566f185de1b89cf9354fd52c096b286bfb5b85773a4b0aa6df78d4b07a798e479be3ffd965afa4010bd58b5c86f6a9a191ed5252ff82f0ead7b5fbbd738a559f16de8c8a6708d49615d2a302f16882059ecbaeb3c6f9796dd38e3d65dda2d053b57cc3a42ed1d6d2659e582066ea3397770ba958b80c1932245f57574fd241fbd1627d10e2283937d9fbc502aa57af5e2d32dad6bb77ef42d1d6f02d21bce8b57bf7ee5513264c6811c1f6c20b2f38e5edd406abca7622dae2bb42f154c5b8a289137fb8b3d090113a77281a32cd2eae089d0d2d1667355deb4ade95b1055a2ce03ce2e385fbf5654e43b4356f1972d9f0ddc29282e9b3b57516dd20c7d345dc417563fadbdffeb6d66c5b6e78bddec1bfb13bb1fe0c2777a85ef6e2e9b1be7b198f56c47fb3b63ba5f1eb6ea03db5c5776ddda8c7dfb1fad4dd78f4238e0177961d07f1945077aaebf25b11cb506deb111ad348d3b816a13e8deba6be7dfb2e293b7565d2f3bab53873aecba56f5cf97c5db3074a0aa68db9b3e898f2fb9250e6890562a6ae72e829815e9f1697df786a703cca45fbd16a7d10e2280184655155b18872d92a264f3cf1c4f7120d791b9f467d6175c83bf6e8d163f1175f7c51d42fba60c18299b95c6e5261ca5a44dbf73b1ef1a89947b25cc9c4eb2daaaf372bb478e1afd7bef9d8b163c7064d0328146d75a5f22d090b92e3e90eaec09dd5b2fad404445b71cb90ef4cc6771ae3e9b03565d12b098bc1e33b93f17a003ff61496da3274c50d6d3ce5366e586b2b4bfeeef1a844493d53d2fc19be0bea86df8d7b5dd7c51df078b4c437245cfe4ac296163e16aecf68e132d4d446720f1ad7e2d5a7f1ddf7b853e835350d798fe3c471b5c5165b7c6f16426dc9800ab3f0b953e88e6f12ca3cb140ccd436ad3e6ebfe3b6bbb0fcbbcf5058bfd37eb44a1f84384ac668db928424e5e5e5d1a449938aa283de7ffffdc87b641788b67e4dfac2471f7df4bf070c18b0a888c38255c71c738cd7b2dd4e27e3ab3a3bdc25215148e17cf433ce38237f7e9d75d65932cae2bbbdae443d75d295525c69c529ff4b6a989a50bdd35297188ca71bc48bf24b42c6a9f87b6eb7dd7688b6229721fb3fbec3585151b16471b6d722c6bfb1d38ec7bfbf5f8ba77155ff6c7f56fc9edab268c5c23cde4ea02464cbabebfbc56533be6b5a97797d846f2a342413604d8d7ddc28b772196a6c6349e35ac4fad4eb553cc2565846e26424256166803b8485c945e28e5d49582be32955713284da6635c4eb829c8c247eec1186249479628198a9ed866ebc0edefd06b7dfee1fb82d29a9613f43da8f56eb831047ad8c671d969696be5a9894c4fba835f7be6cc71f7ffcb7f1dff0dff3df6dd217f6623c7dd8d04183067d5504e156d5bb77ef7bbd974593bf603b106d3657867565066c4c46b5fa2aa7c2cab5a149520adf5b53f626445bcb9521df01f5307ef5e4344b3bda5b5359aa6fe3568fc836e4f33dd5b6be6b3d7db7ae118c8494a178f3d2faa6b56c5bc202f156a94f5d2e7db7dff5544dd3896b1267b5d569f1f4f3eaf5a5cfd5f7bd5ba2cc130bc44c128cf683384a33de6baf709aa4855b738db87984ad50b0856dc5b658aa2f6ce1d6bd7bf7c72ebbecb2f90eb4e69a1279dc71c739f1c8fd6d611d5b922bccb66088362c4565a8bebb9d7e7d068d2bb1402c100bc40c31431c259f6c36bb47a170f35449df1c5f9ac12caf61ab3625f2eb46eeef57b770abacacbce3e8a38f9e377efcf86f9636e94858c3767b5b1a61a3c244b451862843058d68550d8d6c4d7bf100b1402c003143cc104729126e71564967706f6c5affb3cf3ebb30e9483cc2d6fcd35a9d2ca4a2a262fa39e79c3345e2ad315326178e1b37ee71af917396c8b69274840a13d14619a20cd5d3c8c68d69c792a5cb084607142316809869bf7d10e2a895f1d4c5c2356e855326bd4e5a3a279a3163467e4a705ef8e8e8356b16764e1457b87176e11ab6a59e1259176161def1656565ef76e9d2e5d3fefdfbbf367af4e80f66ce9c396bf1e2c5f92faae3a7faa293870d1b36548a72482e97fb2088b553dbda74482a4c441b658832540bf15dd03eaa33fdf70fa0d923168805628198216688a374620d14b24a2eac2ec01a695f3b4b648bce38d41fdc56769604dcdd417dc6ff848f13bd664daf5da4d7feec2996549818a28d32d4ceca90ef8efa6edae2b6381d9c5820168805628698218eda1bdec74dbfc100e99c698d146b33bc71b6b4d1a678910a930a93328425af0cadaeca7d4e2e975b831a925820168805628698218eda061e9092083b41b6380c584dae41a48df20096aca2adcf36a4c2c4106d58eacb902aed8f2b2a2ad6a18624168805628198216688a33633e2b64a98596881360d8f5061526122dab0f47754dfcbe572bfa68624168805628198216688a3b6817e8721f1a85a5959d9b78ca45161526122dab094972155e61354996f4e0d492c100bc4023143cc1047e9c749196bc806b91f9ea1c2a4c2a40c61e91e5d782997cbfd891a925820168805628698218ed28db72e0b1920ab271a198877a830a930294358ba3baa4f979595ed420d492c100bc4023143cc1047e9c59923ebc81a39110f516152615286b0744f091b9ecd66f7a08624168805628198216688a37412b2453e5f575a7fd2f9536152615286b01497a1d2d2d2ffa822ef440d492c100bc4023143cc1047e9c4a9fb1bb017dbd1788a0a930a933284a57774e13e59961a925820168805628698218ed24b2693d958c2ec90b0f7da703d5e24fba640b40dc14b2961e4c8915472cd6b0b55617e4d19c2d25c8654b1df5a5a5ada851a925820168805628698218eda8c805b4e226dbe7e8fb5bdc65076929e0fc6332961cc98313366cd9a4545d74c367dfaf47b54614ea40c61692e436a5caf51657e143524b1402c100bc40c31431cb50dcacbcbff40f29114f3e4934feeffd4534fcdfde4934f1650e12ddddd2d579623468cf8407608652819b670e142ca50d3ee8a5ee13b70d490d4a7c402b140cc1033c451db40bf415789b63bf1448a5180ef377cf8f0711e52f75c68ac4966df4d6c6f822dc965e8861b6e88cacbcba361c38651861a5fb15f545a5afa0f6a47ea5362815820668819e2a86da0dfe02a594f3c0100892193c9aca28a69c6a1871e3a176f34a9623f478dec7978028805620180386a1ba84ff48c37dac6130090a48ae9f69015693ede683c6a5c4f53237b099e0062815800208ed24f9f3e7d96559fa82a93c9ac86370020298dc311857b90e472b9adf04aa37dd8c3d328f004100bc4020071947ee4ffcdd4279a8c270020290dc39aaa98e654db3872209e69bcf0951fafc713402c100b00c4519b106de5ea0fdd8b270020290dc3ddd5049b6d069e69b41f2b3cc5144f00b1402c001047e947febfdcd354f1040024a15138a006c116dbb678a851be3cb8b4b4f4013c01c402b100401cb509d1f654369bdd034f00406b57461bca66d721da06e3a546f9735f35b08fe2092016880500e228f52ce36cda994ce667b802005a95b2b2b2e1750836dbec0e1d3a2c8fa71aeccfdde5b39178028805620180384a37b95c6e13f97f2a9e008056a55bb76e3f0af3e54ff542670b381dbfa82edc74eecf78abc10dec8ef2d97378028805620180384a37f27da9ec413c010049aca00ef4540c0bb5b0d6ed2ce67237ca7f5bcb5ec113402c100b00c451ea45f3a5f27f6f3c0100894362ada76c009e687205bfa92af88978028805620180384abd681ea1df601f3c010049aca00679334f3cd13472b9dc06f2e1fb78028805620180384a7d9fe8f3cacaca5fe00900481c616ae47e78a26948f0aead4a7e269e0062815800208ed24b2693d948be9f8627002091781a862aaacdf144d3282f2fffa97c380f4f00b1402c001047a916cc07cbf78fe009004822de8f6441a74e9d7e822b9a8604ef8af2e1623c01c402b100401ca517f9fdc2d2d2d273f0040024b182fa956c069e586a3f7edba74f9f65f104100bc4020071944e24d89e60b908002492b2b2b25dd80fa6591ad8f99595952be3092016880500e228b57e9fe59bd9780200925841554ab8dd812796da8f9f76e9d2e5e778028805620180384aa5cfd763e6110024b9923a57763e9e586a3f4e2b2f2fff1f3c01c402b100401ca58fd2d2d2fd9d4d1b4f0040521b865b54491d862796da8f9372b9dc2678028805620180384aa5cfcfe726360024b9921a535656f6573cb17448f8be5e5e5efe073c01c402b100401ca5b23ff45ff5870ec0130090d44aeaa34c26b33e9e586a3fbe90cbe5b6c713402c100b00c4512a7dfe31fd210048241d3b765c4995d422d20a2f3d656565a319b10420160088a3f4515151b18efa43b3f1040024924c26f33b555293f1c4d2e3bd5d72b9dcde78028805620180384a17ea0bed2b1b8a27002091949595ed4325d56c0decc3cc850720160088a354fafb1cf5872ec413009054d176ac2aa9c178a2597c79b72afd43f104100bc4020071942ed417fab7ec103c010049ada4faa961380d4f344b037b135b2700100b00c4512afb431f6632998df0040024b5927a903b4bcd831ad7ab3d728927805820160088a3f420b1b696fa429fe309004872a3f06a2e97fb139e587ad4b85e267ff6c413402c100b00c4517a70c21789b691780200128b2aa9b9aaacd6c013cdd2c0fe530dec9978028805620180384a555fa8b7fc7d299e00804492c9647e66d186279aadd23fcb8d2c9e0062815800208ed283c4f103247d0180c4e269916a145ec113cd831ad75354e9f7c713402c100b00c451aa04f214f58936c113009048d418647c77094f345b037bac178ee3092016880500e2281d78898844db3c3d5c066f0040521b84d39cf21f4f340ff2e5e14ed18c27805820160088a3d4f8f96ff2f3683c010089a5b4b4f41ad93178a2d94470992affbbf004100bc4020071941a3ffb06f6e5780200128b2aa961aaacf6c113cd56f11f2011fc309e0062815800208e52d317ba47beaec0130090e48a6ab21a84dfe289666b60f7914f1fc713402c100b00c4516afa4293d417da0c4f004022e9d3a7cfb2aaa81675ecd87125bcd16c0dec5fe5d3a7f004100bc4020071947ccacbcb7f2a1f57b94f8437002091643299f555514dc313cd472e97db5e3e7d014f00b1402c001047a911c6cfe20900482caaa43a902da9d92bff2de5d7f178028805620180384a3ea5a5a53d6557e1090048724575981a835bf044f3e18d393d371e4f00b1402c001047a910c677c8c7ddf00400241655527d25dccec113cdead3f598720a402c001047a9f1f15be5e5e57fc0130090e48aea4e59259e683ecacacad6944f67e3092016880500e228d9545656ae2cffceefd0a1c3f2780300922cda9ecb66b33be389e66f00f004100bc4020071946cdc0722d10b00a441b4cdaca8a858074f341f994c6639f9f51b3c01c402b100401c25be1f7482ec5f780200124ba74e9d7ea28a6a811e2e83379abd1158dcbd7bf715f004100bc40200719468dfde52565676049e0080c4a24aeaf75e7c8b278ad208ccf3669d78028805620180384ab46fdf906d8d270020b1949696ee277b144f14a511f8a4b2b2f21778028805620180384a26994ce6c7f2ed973aae88370020c98d80e7710fc41345f1edfbb95c6e033c01c402b100401c25d6af3bc85ec613009068cacacaae282d2ded89278ae2dbb7659be2092016880500e228b17e3d56a2ed3a3c0100894615d523aab00ec013cd8fc4f0abb95c6e2b3c01c402b100401c25b61f7483ec683c010049afacde9068db124f14c5b7cfc9b73be2092016880500e228b96258b61d9e0080a43702f33b77eebc2a9e687ed4b83e99cd6677c313402c100b00c451f2e8d8b1e34a4e42d2ad5bb71fe10d00482cce42a5ca6a369e280ececa99cbe5fe8e27805820160088a3e4217ffe49fda0f1780200124dc898f4229e285a03fb405959d9c178028805620180384a643fa8bb7c7a139e008044a38aaa4c15d63d78a268febd438d6c399e0062815800208e122984af911d8f270020e995d5996a042ec21345f3eff5f2ef1178028805620180384a1e871e7ae83892bb00401a2a2ba7b93d124f14cdbf03d518f4c013402c100b00c451b2e8debdfb0a4e42d2a953a79fe00d004834ce44a50aeb6f78a268febdb4b4b4b4179e0062815800208e92857cf947f974029e0080c423c1363597cbfd1a4f14ad813d4f8dc23978028805620180384a5c1fe870d96d780200124d870e1d965765b5c847bc51b406f60cd60c02100b00c4512245db20f9f3243c010089c6236c1e69c313456d604f2a2d2d1d8027805820160088a3c489b6e7657fc113009068b2d9ec1eaaac46e289a236b047399d309e0062815800208e92432693594e7da0f99d3b775e156f0040a2f18692ce1e89278adac076958f6fc113402c100b00c451a27cf97bf9f21d3c010069a8b02e5285d51b4f14d5c759f9f85e3c01c402b100401c2587d2d2d22ef2e55d780200128f2b7e555a87e289a236b09de4e3ffe0092016880500e22851bebc42fda053f10400a441b4bd28db014f14b551d8533e1e8627805820160088a344f5819ece66b3bbe10900484385f5692693590b4f14b581ddc50d039e0062815800208e92419f3e7d96952fbfe8d6addbea780300124d7979f94f55f157e189a20be36d652fe1092016880500e22819643299dfc98fefe10900483ca5a5a57f94bd8e278a4bc84ef5269e0062815800208e12237e73f2e57d780200d250611d287b044f1497b0813977f3805820160088a384505a5ada5ff60f3c010069a8b07aca06e089a28be35fc9a6e3092016880500e228317e1ce5a42e780200d250610d5285d5034f14975c2eb7867cfd399e0062815800208e12c132f2e1dc2e5dbafc1c570040e2292d2d7d54b61f9e282eddba75fb911a878578028805620180384a44ffe737f2e1fb78020052812aac89994c66733c51749695af23dc00ed95cacaca5f9495951de11b458e858e1d3bae8457001a163b8a99bf387e74ec271b229be438ead0a1c3f278a869c89f59f9f0213c010069c053031674ead4e927b8a2b8b8832a5f2fc213d09ec864321ba9dc9f2c1b23b136479da4bbdd51eadcb9f3aa7807e07bb1b2a26fa03a399862e40c1d6f913def2990de4b55f6accedfa4e3e98aa5fdf578d3eeddbbaf80e79a8e7c79b1ec2c3c010069a8b0bc9079069e283e613fbc797802da3aea4c6ea9b27eaeec35d94cd975ea647674a714ef00f151b676369bdd5571d15d8f2fd3f1bfb2c99eeaa8e76f3b9bb3e2e5121d0fd7753bebdc9a78ad68bfc570d74d780200d25061eda286e1393c517cc2f4964ff004b435faf4e9b3ac3b974e9ded14e43677465dbff8353c04ed0dcfacf03e6ab283150fbd75bc55c7b14e7a219b2d7b46768362a6978e9dbdc133d31c5b1ef9fe338b683c010069a8b02a5561dd81275ac4d7ebc93ec413d016f0a899ea8e7d54a6af0da369e3657dd409fd23de81761407bf54b9efa058384ac7cb658f851b170bbd5e5cf1f0b0a7e0e978988e3be9fa9fe1b56490cbe536d06ff2119e0080b408094f613a1f4fb448e3beb1a7c0e0094871195e459dcf8ccaf15d619dcdd3dee7d19bfce21d68ab384b637979f91f54de0f51793f53c7db652f7ababb6c5658af79bd8ea73a13b3e2611346cd928f7eab8364ffc113009016d1768bef00e289166920b690bfdfc0139032a1b696caedff866c75f3c248c2914c298236d81efe2a9bcdeea6e3d12adf57e8f8b86c4a586b36c1590675bc48d655f5f99fbd4f1a5e4b2ffa1dffe9d901780200d2d2488d51c5f5573c517cd4c0ff49fe7e094f400acaea06aa174e928d76c64795db7b753cd4c974f00ea4fc26c48f9d28278c189fede5013a8ed3f10b4ff375990f89737aeab8af6748c896c3736db2fff3b87eef4e780200d252697da406697d3cd122bedec9299bf104249130127cb6ec1527cc719204775ad94b0d522aced655f9fd9b3ae5c7ea78a5caf713de44d95bdcc8de943d28bb40e7bbe8b843b76edd56c76bedae4dfec4e5044f0040e289f70d23bb5bcba0cec3eef2f7483c0109611995c91d65978674e3539d48c1a9c8a913200d787fd15c2eb795caadb457e9393ade297b5956e5ad6c64a374fe1aef13a8ebfeeeb597946d2810f533f10400a4a5d2fa1d89315a0eef05e3f54078025a0b6fc4ab72b897cae160d9c77afcba44db79eef8e21d48eacd0567decd66b37be8789ccaec553a0e937de0513397611def0feb932af57c3ba6f1427d789b05da6300480d215df7503cd162fe3ec0e99ff104b4249595952b3beb5d188570c6c7674396bbdfe01d485839ddda6b279d1c42f5e5dd61aaee7cd9743d7fd2371bc25acb7d3299cc468c9ac152883697b17fe20900488b88f05cffc178a265089d917bf004b4406cafe9acb04e67ed8c8f5ecfe37da4bca714de81566419afa15659dc53d6436573908ec3bd7fa5ec4beff5a7e7f7791b1a95d9721db7eddcb9f3aab80d8a20da9c0df7403c010069a9b4faa9813c0d4fb45847baabb758c013500cdc1956f93ac1eb7864733d654c96d3f9d5f00eb47059f47e7edbb8fc79faad6f56e9f9ab61d4ec23afedd5f3ab5d5e73b9dcde3a6e684187e7a005fb3fd39d25174f00405a2a2d67cf3a044fb498bfbbcbaec513d08c9de3cdc366bf2f854d7e6ff4e6bede0c18ef409159c69dde20ba4e08226c6410651e357bcd622d88b69c459cc51c6e8304d49bbf5499fc144f00406af09d4fef1d86275a4cb4b96373159e80a5e9287b535fd9252a4fef3885b93701f65e8bec2505c5c0d3133d4d314c573c3f4c5f1c1f84d9b430bdd1d31c7b78da63d842865133482cce24ea6436780200d22422e6aaf25a034fb49848eee5f4ea78021a83333eba33ac78fd97a7f4843da6fa7ae402ef4073e0841e4eece1041f2a572786841f4f86f2e6298daf84c4207dc2dadcad9d3804cf414afb3e67c92ec61300900ad440ffcca20d4fb47843d1174f407d78ff29758e0f5279b95df699ec79af3fcde5729be01d682a4e85ef94f82a4b152145fefd2165fe829042dfa9f4073ab57e48b1bf5e09a366d0c670166759064f00402af0b448df3dc5132d2adafa5ab8e109a809df4809c96afeed8c8fde8e431d8b632a2a2ad6c13bd0503c6ae64da4c314b093c3e6d2a3c266d35561f3e9bbc266d4a5dea3cf3709f01cb4a3b6f803b63c0180d4e0bb4cb207f0448b3614fdbc3f169e808232b19ee2f0f890c061ae63d26b87ba75ebb63ade81ba70195199d941e5a58b8e17b8ec84a9b31e357bdfdb3ce87865d8dae56f994c665dbc06ed9db01dca9c12469001204515d769161178a24585f2555eac8f27da7d39d84cb1d75b364e365b76b3ac33191fa13a4e2e23db58e5635f959b9ece3eab3a64b48e3375fcc26548c73b743c5bc7ac6c4b5dff633c07506bfdbb97d76be209004853c5758da75ee18996c31d2ea7fdc713ed0ea746df5e1d858b646f7b23610bf86c36bb1b191fc1382194b3827a7aaccb89cac8433a4ed071a16c8aec716709759ded72a3e7bfc26b004deafbfc43d61f4f00409a04c430670ac3132d87fc7daba732e189b64f870e1d96f79434a7420ffb56bde5296c4e9d8e77da6f99702219efa3e769d23a5eafe318d927610de38b4e3c13f6dd3ba4bcbcfc0f8cbe02347bdfe77eb5c565780200d254714d56e7e0b778a2457d7e8f17fee389b6899339a82f7080c5b9376e958d959d4e9cb52f4242991df5bb1fe6b4e2ce54a7e3c4306af69eec31d9e5bae6281d3b906806a045dbe1f714a3bfc31300900a9c5d4c15d7a28e1d3bae84378a83173bcbc71b16269470e7cd9d7abcd37608d3daba848ef93c6f34ecc40f247d68db78d4cc62dc6b11bdffa28e37c89e096b14e7ca5e08e2bdb78e07cb7e4f7d0bd0bab83df65ad012929000405a5087727d7526a6e189e2e179f3f27154933973958e537df79d2c81a98c9f75bd8f956c44e8a03f24ab64a3fab6876fbe64b3d99df5fb1eaeb8bd44c747c2ba448f9abd2bfbaf9e5fe6b5aaba6e573d5e1baf0124369e77f794643c0100a9c153729c810c4f140faf4509fb22457518d93bd323d47e1784f80b9efae851148f9a92a92ffd74efde7d05fd969beaf7dddf59756537e9377e364c71fddc1b9bcb6ed1f933743c50bff9e6b215f11c40eafa3ea73aa10f9e0080d410d65adc82278adf40d421d816fa2e3e5e4af4efb76d481ee22422d364039d5cc453e3f04e2a85f75a8ab95df41bfeaf6f98a81efc8f8eef8451b349b221ce2aa76b8ed0e3bf545656fe02af01b41d14db777b56049e0080347546fbaa73720e9e287a03e1756d55b588b63e782859588c79fa8cd3f13b2d7f481e71a19e6f57c21a88b408b315c33e7807869151ef81f75c1831fb2c3cf6b9d33d52ea6b3dd286e700da45dfe71daf2fc5130090a68aeb4eee36b598affbd5b4a68db56c89e9e4ffd8d3e23cf21ca6c3bde869709e2e8777928b47c1bc864cbfd7911e1df3289933e28651b377c2dab34b3daae6d13546b501da379d3b775ed53751d91b1300d226249ef3e27a3c517cdcf9af2eda3cfd0acfb41e218358857e8b0743229191eaf81f5f5e5efe3f78273938dba2ef8aebb73928086967631c1b12f97c1ab235dee8756816de5e77c8a81900d444b8c9f31c9e0080b489b699ec0dd4a2febebd40b4bdcb9aa856f90d7ea58efd31de543e6c64fc6f75f6bb7a4f2dbcd3bae837f8a57e8bbf3a03a3f72fd3eff468c8ccb8304c51fdb7333786b5b83b75e9d2e5e7780d001a83ea9893547f0cc21300901abc01b02aae0525acd169c94ee9c6f2f9d7616a640f3cd232e472b94d3c0a13b2ff793dd36d5eebe418c03b2d8b47cd54f6b7f09e653a9e197e8b17c248e72cd9d361af336777ebe43dd0b8b90100cd856f9efac60f9e0080d4e0e946ce8687275abcc1f09a9b6f18d929ba50fb93caf83f6513e4efe96aa4afce66b37b20005a068fe07b4b11d9d1f2fd001d1f934d09a3666f850de62fd2e36e3aee483c00400bf57d26a8fef9239e0080d4a04a6b3f4f3fc2132d2edab695dfbff68803de683ebca83c88842b651f84241417cb76286134b928780fc2f2f2f23fa83c67e4e7b3c2f4df7161dae927debc56769d3a49a7b8bef148338bff01a0b508338cbee4e61d00a44d3c9ce0fda6dac2ff1245d1f253a64cb97fecd8b1df8e1c39321a3e7c38d6041b3162443466cc984f651569110d9e421736419e2d7bc953eebce93111deac8278ddb005c231de9056c727e4eba99e5e1d46329dc8e542af0db44826232a0024b4dfb3933303e309004815a1f3d5b32dfc2f166c4f3ffd74346bd6ace8abafbec296c266cf9e1d8d1e3d7a9e04dc21091510aba9d1cdc9eef73a2895e327653df4783da27aa9fcea2d0ffe285f66e5cbb3c376202fe9f9173ace903d25bbd675462e97fbbb8ebf61d40c00d284b303cbaec11300902ac2fe4507b485ffc5236c08b666156e5f0d1f3e7c628204c52fc3daa827c2d4bb47bc168aec818dc7db19c8777f53ec1f1b360f1f2a7bdfa366b23774ee011d2ff0fe8d1267db5b24e335006823fd9e9bbda7239e0080b4555e6fa8e3b6655bf85f3c2512b1d5bc26d1f6752b0bb58d25207a793f1dd9e72aab7738e3606565e5ca446fdd78dd8604d756f29f5c77e8b9b2bb642f7b4359d9c7b251b2c14e7dad6b3aeada5ff7e9d367593c07006dbcdf33de49aaf00400a4adf29adfb973e755dbc2ffe2f55808ad66176d512b94c9ad65e7fb8642101783252af662a3e41a59c6534225bcf6f4941faf4f0d7bcf7de885f63af7ba5ebb4f8ffb7a03713ddfaebcbcfca7b80d00da235e03edba3193c9ac8837002035545656fec2891bdacaffd350d1367fee8c68cab89ba30923cecf9b1ffb1c22ad75449bd74465b3d95d434a784fd19b248171a953c09790f1318ed595e59f6de49332f9a78fec1e3d7fd5375dbc95816ca4ec5f3a77a22ed9478f3764d40c00e0fb78bab7eac757f00400a40a67786b4b19941a22daaae64c8fde1c7a7634fed15edf339ff36b08b5868bb6581c34e5b7f256077aefbe6103e55961dade59de37b01d87e432ea506ce051452755f19e72f2c908d934df1996bd26bb378c42e63cbda7ad8c920300b450bfe768b73b7802005245b86b7f4f7b126dd326fce707822db68f260c41a83550b405c1b6d053f21afafb785a5ed9ff719fde37c799083d3264a1d29ee22e93c9ac62c115b25f9e1f84d86b419859a08db0600bc26dafe01f461c01009612d5a9d77bdb123c010069abbcce54c7f0a2f624da268ebaa456d1e6d7106af58bb690d862a12c72328b7a6e0cacad6bbacb1e0f191f87c80ed7f935db726c796aa2472125b8f6b630f5d4c53085d15319e787a98df778aaa355aca73e925c0500a0b884591d3be00900480bab87caeb86b694f6b621a2edcde17d6a156d7e0da156b768738a7dd9d741b0e5adba007316429d3b45af3de38c8fce5a285192f108535b0b248f1eeaffdbd6493e42b20f8f22be1e46cd3ed4f3e14e0ee21149270b09fbc8316a0600d0c238f988eb662723c11b009006f690b923be9f3724f65e4d8836445b43445b4d822d88b623bc2173489031de9b307be3528f32b5850c5d1e35b310755a7ca7c77736cb902effe3903eff95904eff5c8f423acdbed3ed53d500002407cf68f04d353c010069116c7364037c3ce490433e7167b43d8936678bac4db4f935845acda2ad36c1665323e851a57765fd643ba5356ba137900e99c52a25cefe1936987e236c38edac9643c346d4c7f9668737a82e61d40c002015f806a337d6c613009016c1b69f9f2cb7dc727f9768fb4ec7fddb93689bfceca05a459b5f43a8fd50b449a8fca336c116ccd34d564f89305b4effcf6f24cefeae634f7df76b9d10c5a3836ad0bfd0f125d99d7aed1c3dcf7a0451eff931d5070040baf12c092778c21300901ac116b3fcf2cbef55d3f9b62cda3e9bfe7af4e6b0737f383552e7fc1a42ed87a2ad0eb156688724a92c58447ab1b91ae8ae3a5e287b50f66618359b2a31f6845ebbc259c474dc5dc26c5daa090080362dda5ec866b33be30900489560abf67a956c9ff620da6c535fbaed07a2cde71069b58ab6b1b95cce9b395f267b58cf27d720da6e6fe9dfdba366b28df59df60b894faed371b48e9f844c95e3fcbdbcff9b13a1e8b52d59800e00d0fee8d0a1c3f2cedc4b965e0048ab608bd9a7a40d8cb83548b42d5a144d7e6ef00fa746ea9c5f43a8356c9f366782cc66b3a7480c794ae16d9e7652acdf5582710d09ae1dbdaece5b5404e1f856d876608aec319d1be04d53f59d76aba8a85887d007008018dfb473bb81270020cd82ad50b8cd2e49f1885b7da2ad6acef468d2b3036b5dd3e6d77c0d62ad6ed1e6d12a2fe68ed7b9356683eddaf05d507dce6fd5b076d2679e1ab6a3785a364b36d7d35a2c0ec3de8207ebb845c78e1d5722cc0100a03e4232addbf10400a45db015be6f76494a47dc6a156d8b164533263f19bdf144ef5a055b6cbec6d732ea56b368733afbb0317461f6c8eb1bfa1b75e9d2e5e7ce30a9f71c26bb448fff2d9b1846cdded5b94775bcdc1b724b9cfd3593c9fc9270060080a5146d036527e30900680b82adf0fda95ce3569368ab6f748d51b7868bb63ab2483e5df83b74efde7d0589addfe97c6709afd374bc316cb4fda93e638ed7c8e9fcadb233f4fc201d7fcfa81900001451b43deb1b81780200922ad8bc8754d792faf792aa7e5d2ad7b8d524da1a32ba56d7a81ba26d78e4fdc8c266d2b5658efc5c8de1a53a3e227b278c9a3959c97f25cafaeb7864369bddb5b2b2f21784280000b424de3b54ed5095dab29fe20d0048aa60bb511685e3327508b69aae8b3f2f35236e3589b6a60ab6d8106df9ec91b3eb4bf92f5176818e074aa46d96c96456241c01002009a84dda5cedd3243c010049146ca66b1062511dc2ad50b0c5d6a5dae756953472c42d24aa38b5a5375c6e68ca7facd1a26d96a7359695957d5b8770db9630040080a4a1b6ab4276379e0080240ab6da0459a170abe9f51b6a10760d9e2aa94a71cd90f96f46e8c86f88686b3b6bdafcfbca4e0a532517168a369d3f8250040080a4e12d6164bdf004002451b0d527dc966da0602bfc3bb56695f406c7eab8f70d49260a475f106d6d749fb620d08f0e7ba63939495fc21100009286daabd16aa3fe86270020a982ad2ee1f64e23045b75e1b64f35b1767bf55197d8bcf716a2ad6d8ab66aa27d15358a9b12920000903096517f645e2e975b0357004092055b5dc2ad31822d263f5572bdf5d63b5995e0905ad2bf2fb196760aa2ad75441b00004012292d2dfdadfa2353f00400b406ab07b135b891eff394c8ea236cef84f30dff9065973dc3ef3df0c003bfab2fa3a06c84ecb13085ee1eefcde58d98f578901e5f26bb488ffb84fdba7aca8e777a781dbbe858ea6c84b95ceeef9ed6a06b76d1e3edf5da1f3daa93c9643692adeb697a9d3b775ed5fb7c21da106d00000005a24d5d8843efc71300d05a34361d7f5d236d756d07f03d965b6eb98ed96c369258fac2fb7149304d927d519b680be2eb105d738045989f3b61851e1f679166b1a6c7e7ca2eb488b398935d67716791277b48d73d1ac4dfd3b21764afc926face99ec23a7a30fdfe12bffcde6122bd3a64d6b11513475ea54441b0000401150bfa09ffb1a7802009220dc9a634d5b43849b05e26c09b74e218be0a61efdb220cbe5728325ae6a126fefcae6ca16878c926f84cc83f7cb0687e42527cacaf5197bcbfe24dba0b2b272e5a638a43947daec97adb6daaace6bbefcf2cbfc75975e7a69fef9071f7c907ffec8238fd4f9b9071e78e0f79e575454d478ed7befbd17cd9e3d3bfff8b5d75e8bde7cf3cde8a69b6ecabf67f4e8d18836000080ba45db48f72ff00400245db8d596d6bfa6ec917509b77a47f69c8c22a4fbaf0a826d5afc5af7eedd57d0ebbf9438db42e73be898911da3c767cbae94dd291b2a7b59f681eccb90dc649aae7b55c270b8f758d1f3817a7e8e1e1f2bcbca76976da9f3bff286cecd29da244ea3bdf7de3b7afdf5d7a3071f7c305ab870618dd75948d97f1e31bbe5965bf28f575a69a568f2e4c9355e3f6fdebc25d7c7a2cd7fa3aaaaea07d7c622d082edde7bef8d565e79e525ef39f5d453bf77edc71f7fbce43b5a4c7aa4d0e2f1eaabaf8eba75eb967fcfe1871f8e680300807643d863744d3c010049116eb36b1054f5edc356df3e6e31dbd6f2f9351252c17b04edd5a5f9a724c27eaccf594fb6b53e73cfb2ffa387ec3c7df6d53a7fafefa0c9c6cb3ef6f4c82e5dba443d7af4887af7ee1d5d78e185d1c08103a39b6fbe397ae08107a2279e78227af6d967a3f1e3c74753a64c893efdf4d31f08318f626db0c106d11d77dc91f7c7baebae9b173e7ebcc20a2bd4296efc59a3468dca5fbbc30e3bd478cd679f7d967fdd534c478e1c19dd76db6df9e7975f7e79fe78d24927d5faf943860cc95fe3f7c542af26f1e8ef6981f7e8a38fe647e9e2ff31fe8d116d0000d01ec8e572bf56dfe0433c01004922de00bb5058752da93f4b644dc2ad4b3541e8cf3da409a26b959676c2638f3d167df4d147d1c48913a371e3c6e5058e459745d835d75c13f5ebd72f3af7dc73a39e3d7b46ddbb778fcacbcba3238e38222f96ce3efbecbcd8db7efbeda31b6fbc31da74d34da38d36da282f7ed65c73cda86fdfbed1e79f7f1e2d5ab46889488ac59647b52c8e5e79e595fcf333cf3c333f52b7f3ce3b7f6f1a64fffefdf3c7c71f7f3cead4a953f4f0c30fe79f5bcc79a4acfac859fcf973e6ccc98bb62bafbc32da6ebbed96883d8fc4559f7af9e28b2fe6aff5ff6c01b7cd36db2c796dcf3df744b4010040bb20ccea79184f0040d2b0c0aa2af9ff53250b05595d69fd6bbbaec982adb568ecf4480b300b268b1f8bb0b163c746bffef5aff3e2ceebd92cea2ebef8e2bcd8f114434f2ff4393ff6ba340bc05d76d9253afdf4d3f362cfd70e1830205a679d75f2237cd3a74fcf4f878cff9e05a0c5d4165b6c911791bede02cfbeb768ac3e8d321681166d3e5a907aaaa68598855f4debe53c02e7e3db6fbf9d1f712b09a36b2561440fd1060000ed8190a1fa6c3c010049649f1a845b9792fa938c54bf2e1eb9db2f4dff7c73ac69b3b8f1885610b1d11a6bac11adb5d65a4b5e5fb060417edaa1a7587aadd97aebad17dd7df7dd7981b4f5d65b47a79c724ad4b163c77c7291e38f3f3eeadab56b545959191d79e491d161871d965f2777d04107e547f7060f1e1c0d1a34285a7ffdf5a3bbeeba2bbf0e6ee6cc99d1fcf9f3f37fcbe26cdf7df75df2bdbc0ecec2af244cddace9bbfb3b3dfffcf379d1f997bffce57b6be7106d0000d05e086be5f7c5130090546a5be3d618e1973ac1d65ca2cda35ab1c8d97ffffd97ac57abe95a4f45b478b238f3357ecf0d37dc9017669e76195f6731b6faeaab4793264d8ad65e7bede8befbee8b36d96493fc68dbb1c71e1bedb4d34ed179e79d179d76da69d131c71c931779167bfedcbdf6da2b3f0af7e73fff392f0a9decc4ebf36ebffdf625ebf32c222d264b42664a0b3f8fc4dd7ffffdd1c61b6fbc643aa5a74d22da0000a09d88b6d94e8286270020c9345578ed519252c1d65ca2ad70d42a166db5599c2dd2a35916707eece98bbbeebaeb9211b29a9285f875272dd972cb2df3a37ade32207e6f7ced15575c915f13e7efe0b5701b6eb8615e7cdd79e79dd1b5d75e9b3fd7a74f9ffcc89e47f13c6dd389583a77ee9c7fec299b9eaae9f5799b6db659de3cfdd3dfc1d3413d2d345e9f8768030080b684c4dafa4e52862700200d345680a55ab01543b4c5fbafd5665e7716efa3e6eb3d6ae6512e3f76c290ead7bff5d65bf99139af6bf3c85ce1085e9ca4c4c9536afa5bfedcf81a9ba7607a8a659c8cc402cc89523efcf0c368c28409d10b2fbc90175c4e7662e1e64c9a975c72497ed4ceeff348a0c59d13b238318bd7e7792d9f47fffcfd9cc0c5dfc56bf372b9dcf6cec2a5eb7f4a58010040d291603b5036044f00405ac86f885d52ff54c96d4b529674a425449b47cf1a7a7de13e6b7eafd7a8156bc36baf59b32dede758347aeb034fb1f4544b6f89e0a997de22c162cd42af57af5ede73ef45d994b2b2326fa0fe55d862617cd872e15e6fc1e0ad18c2960c664f6fd5e02d1bbc7503610800002d2cdafaba5dc213009026ea1b41f3eb33d22ed89a5bb461354f8ff426e6deccdc9b9a87cdcdbdc9f9b1def4dc9b9f7b13746f86ee7dfabc397ad824fdcbb069facb6161f89d6153f5b3bdc9bad332874dd7b7f0fa036fc64ed802004053517bf2a86c7f3c010069146e553508b79af67743b461cdbaa6adb2b272e55c2eb781ec4fb2bdd59096cb4ef49d50d960d9fdb251b2376433648b657365efcac6cafe2bbb45efe92ffb8744e111b20364bbc836f586ee7dfaf4599630070000a33663667979f9ffe0090048b370dba740b02d4d9649441ba2ad6874ebd66df54c26b3b144da9f65fba901ee263b5576b1ec06d9bf65cf48b0bdade3a7b2af7d0ccf9ff186aab2ebbd4f8fec145957a77e96eda0f3bfd167af46950000d02605dbaf64b3f00400a4997864ad4f107007b4a57f0ed1d676445b63f1489b47dcc2c8db2e6124ee088fcc79844e8f6ff5741935e42fc8de93cd0b237a33c208dfa830e2e791bfbe1e09f488601819dcc699c83a75eaf413aa10008064a3fabe93eaf1c7f10400a41d8fb8456d4db021dadab7686b0a5e3b575151b14e7979f91fb2d9ec6e5e5be735765e6b17d6dcdd19d6e0bd1cd6e4796dde02d987b25764c36477e93d57794d9fd7f685357e5eebb7a5eff67a0d20550e0040cba1baf75cd905780200da02abb7c57f0ad186682b36ce86e9ac981e7d93eda5c739d909b2f365ff9258bb4ff6a45e7b3d64d9fc2a64dd9c12b2703ee6513fd965b233f4fcc8909afa2f7acf66fafcb564cbe1690080268bb64754bf1e8c270000106d88366830dedfcefbdc85fdeefe2e71d645d6531d8b0b65d779fd9d8e4fcb26ca6687f5799fc9de913deb0e88ec465d7789ac97ec304fff91ede8757f5effa73fb30c9e0600c88bb68f641be2090000441ba20d8a86d7e775e9d2e5e71264bfcb66b33b3b6db53a20ff2b3b5dd64f76b3378d953d2f9bacd7e784f57933656fca9ed2b90764d748d8fd537692ac42b68f5edbd69d197df62a781a00da1a959595bff04d2f3c0100806843b441e2e8d0a1c3f212656bcb7eef3def6487c88e969da57357c8ee90887b42cf5f92bd2f9b2f5b14ee48bf261b21bbc77bed85f520c7c94a657fd3fbfe2891b76ec78e1d57c2d3009064545f75f45ea178020000d18668833641b76edd7ee47d8c72b9dc56d96c760f75760e951d2fa1d647362888b891b2f1b2e941e455c9a6cac6393b9bec76bd6780ec4c75948ef23a12d95f2d1e2d222d26f13400b4a0683bd353c9f1040000a20dd106ed96ce9d3baf9ac9643652a7683bdfd19668ab949dec4c6db26b650f4aac8d964dd0e34fc2fabccf659364cfe93dffd16b37c92e959da67387cb3acb76d26bbfd567ffac84f57900d0445c077996009e000040b421da001ace32b95c6e0dd9264e9c1204dae1166c41b8dd642167411784dde741e8cd92bd251b237bc8095b8230b440acb460b470b480b490c4cd001044dbfb4ed084270000106d88368022e22d0f9c4c40c7cdb3d9ecae126707a923d65dd65b76b9ec366f9d10b650981aa66c7e15a6708e0f533aefd5fbae96283c4fd6a3ecffd853e7b7f6960ddeba014f03b42d9cc049f13db784d17a0000441ba20d207938498a93a538698a93a784242ac785a42a0325d8ee767202bdfeaa9e4f932d0cc9589c94e525276971b216276d71f29690c4c5c95c3ae8b52df4d9bff466ec781a20b9841b33a3f0040040c21939722442ab796da144dbd7942c688b545656ae9ccbe53690fd49b677d816c1db23fcd3db2578db046f9f10b6519819b655982b7b573656f65fd92dbaaebfec1fde96c1db33789b066fd7e0bbfedebe014f03b40cde1645f17b199e0000483863c68c99316bd62cc45633d9f4e9d3ef91689b48c902c8b38c3732f77a1989b33fcbf65327b19bec54d9c5b21b64ff963da38ee3db6183f4afc386e9de38fd696fa42ebb5eaf5f243b45d655e7f795eda0f3bfd167af869b019a2cda3c2dba1c4f0000249c279f7c72ffa79e7a6aee279f7cb200d1b574236c166c23468cf8407608250ba069787d9e6c2d7524375387f22fb20365474aac9de11101d9ad7aed519d7b41f69e6c5e589ff7b1cebfaed79f94dda7e7ff929d2f3b4196d36b7bc9b6d167afdfa953a79fe06980bc687b57f1b2299e000048011219fb0d1f3e7c9ca7f5793d16d624b3ef2622d8005a45e8ad585151b14e7979f91fb2d9ec6e12671975448fd5f11cd955ea98de251b267b45f6a16c41b00fc339bf7697aff57bc27b33fe2c7fa63fdb7f034f431b8b9bd554d6bf604a320000000024128fb679d4cda36f1e85f3685c1895f3e8dcbf3c5ae7513b8fde79142f8ce6cd0ba37b2f78b4cfa37e61f4ef0c8f068651c1bf7894d0a3851e35c4d390547c53c25390f10400000000b4193c32e175745e4fe775755e5f17d6d95de475775e7fe74e70588f373baccffb2cacd77b26acdfbb21ace7f3babe6e5ee7e7f57e5ef7e7f57f25a45e8716c2655765f04a3c0100000000ed164f3b73464c67c674864c67ca74c64c67ec73064d67d20c1935c7860c9b7343c6cd992103e753cec8e9cc9cced019327556387367c8e0b981337ae269680a2a5f77fac6039e00000000006804dedbce7bdc79af3bef7917f6bef31e7867794f3cef8de73df2bc575ed8336f7ed8436f9af7d4f3de7ade63cf7bed853df78e0b7bf0fdcd7bf2796f3eefd187a7c123c02e67780200000000a0c84888fd58a26c3dd9d6de2cb9ecffe8213b4f9df2ab9dd65d3652365e363daccfab924d958d933d26bb4d76b9acb7acbbde7750369bdd559fbd796565e52f589fd7e6cacc2a16fcfcae000000000009a573e7ceabaac3be91c4d976b28eeac057ca4e965d20bb4ef6906c8cec2dd9acb03eef73d924d9737acf7f240a6f925d2a3b4de70e9775d6e31d73b9dc26b2354a589f9758c2761acfe3090000000080b6c33212793f9358fbad3afb3b59a059a859b005e17693859c055d10769f07a1f7895e9b201badc70fcaae0dc2d002b1d282d1c2d102d2421237b70cf2f9891e85c5130000000000ed980e1d3a2c2fb1b6b6ecf7b2bfca0e961d25b170a66c8044dbedb2c7c314cda961cae6a23085737c98d2798f6c90ac8fde73bcecd06c36bb472e97dbaabcbcfc7fba75ebf6233cdd78bc5d8545379e00000000008046e124294e96e2a4294e9e1292a81c1792aa0c0c226e84ec35d94741e4cd0f49595e729216276b71d216276f09495c9ccca543108f6b5b4cb6773f3b3ba9852f250e00000000008a4e48aab1a16c5b89b27dbc2d42d81ee19fde2ec1db2678fb84b08d82b75358ac7373749cec755db221b29b65fdbc1d83b765f0f60cdea6c1db3578db066fdfd056fce58de5f53f7ee94ca5941e00000000004822cb7823736f68eec429b24e126987c97ac92e91a0b951f688ec59d93bde203daccf9b1d364e7f3a6ca4ee842d17ea714f59975c2ef777d9f6b25f979797ff34a9ffbcff674f49a5180000000000409bc1a9f1656b499c6d16322f1e283b5202e80cd965618d98b74e78513645cfbf085b2b7cacf7bcaee74fcaeed3f37fc9ce979d20cbe9b5bd64dbe8b3d7f7d60d2df1bf84e9a6d7f2ab0200000000407b177a2b4a1cfd4a626d4bd9eeb2acec5889b4736457e9b5bb64c364afc83e942df0b445d907b29765436577caae949dadf71c23cb64b3d9ddcacbcbff505151b14e53a6388691c4eefc420000000000008dc4ebcd3ceae6d1b75c2eb7b78ee54ecf2f91d557365876bf6c94ec0dd90cafcf93cd93bd277b41d73eea513f1dfbcbfea1c747c80e90ed22db54b66648e2b22dde060000000000680124f2569340fb8d84d80eb27d25ccbaca4e915da4f3d787f577cfe8f9dbb24ff5386aa9a998000000000000d0487af4e8b1125e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000689bfc3f40396191774aaad00000000049454e44ae426082	t
\.


--
-- Data for Name: act_ge_property; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY act_ge_property (name_, value_, rev_) FROM stdin;
schema.version	5.21.0.0	1
schema.history	create(5.21.0.0)	1
next.dbid	15001	7
\.


--
-- Data for Name: act_hi_actinst; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY act_hi_actinst (id_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, duration_, tenant_id_) FROM stdin;
5007	act_news_approve:1:5004	5005	5005	_2	\N	\N	开始	startEvent	\N	2017-10-09 14:00:21.053	2017-10-09 14:00:21.069	16	
5010	act_news_approve:1:5004	5005	5005	step01-01	5011	\N	提交申请	userTask	user1	2017-10-09 14:00:21.069	2017-10-09 14:00:21.16	91	
5020	act_news_approve:1:5004	5005	5005	_13	\N	\N	ExclusiveGateway	exclusiveGateway	\N	2017-10-09 14:00:52.652	2017-10-09 14:00:52.658	6	
5012	act_news_approve:1:5004	5005	5005	step02	5013	\N	支队领导审批	userTask	\N	2017-10-09 14:00:21.16	2017-10-09 14:00:52.652	31492	
5028	act_news_approve:1:5004	5005	5005	_16	\N	\N	ExclusiveGateway	exclusiveGateway	\N	2017-10-09 14:01:16.638	2017-10-09 14:01:16.639	1	
5021	act_news_approve:1:5004	5005	5005	step03	5022	\N	定密员审批	userTask	\N	2017-10-09 14:00:52.658	2017-10-09 14:01:16.638	23980	
5035	act_news_approve:1:5004	5005	5005	_8	\N	\N	ExclusiveGateway	exclusiveGateway	\N	2017-10-09 14:01:48.194	2017-10-09 14:01:48.194	0	
5029	act_news_approve:1:5004	5005	5005	step01-02	5030	\N	申请被退回	userTask	user1	2017-10-09 14:01:16.639	2017-10-09 14:01:48.194	31555	
7505	act_news_approve:1:5004	5005	5005	_13	\N	\N	ExclusiveGateway	exclusiveGateway	\N	2017-10-09 18:47:49.85	2017-10-09 18:47:49.865	15	
5036	act_news_approve:1:5004	5005	5005	step02	5037	\N	支队领导审批	userTask	\N	2017-10-09 14:01:48.194	2017-10-09 18:47:49.849	17161655	
7513	act_news_approve:1:5004	5005	5005	_16	\N	\N	ExclusiveGateway	exclusiveGateway	\N	2017-10-09 18:48:02.588	2017-10-09 18:48:02.589	1	
7506	act_news_approve:1:5004	5005	5005	step03	7507	\N	定密员审批	userTask	\N	2017-10-09 18:47:49.865	2017-10-09 18:48:02.588	12723	
7521	act_news_approve:1:5004	5005	5005	_19	\N	\N	ExclusiveGateway	exclusiveGateway	\N	2017-10-09 18:48:22.771	2017-10-09 18:48:22.771	0	
7522	act_news_approve:1:5004	5005	5005	_3	\N	\N	结束	endEvent	\N	2017-10-09 18:48:22.771	2017-10-09 18:48:22.771	0	
7514	act_news_approve:1:5004	5005	5005	step04	7515	\N	总队领导审批	userTask	\N	2017-10-09 18:48:02.589	2017-10-09 18:48:22.771	20182	
7525	act_news_approve:1:5004	7523	7523	_2	\N	\N	开始	startEvent	\N	2017-10-09 18:57:19.681	2017-10-09 18:57:19.683	2	
7530	act_news_approve:1:5004	7523	7523	step02	7531	\N	支队领导审批	userTask	\N	2017-10-09 18:57:19.714	\N	\N	
7528	act_news_approve:1:5004	7523	7523	step01-01	7529	\N	提交申请	userTask	user1	2017-10-09 18:57:19.683	2017-10-09 18:57:19.714	31	
10003	act_news_approve:1:5004	10001	10001	_2	\N	\N	开始	startEvent	\N	2017-10-10 12:59:10.717	2017-10-10 12:59:10.73	13	
10009	act_news_approve:1:5004	10001	10001	step02	10010	\N	支队领导审批	userTask	\N	2017-10-10 12:59:10.789	\N	\N	
10007	act_news_approve:1:5004	10001	10001	step01-01	10008	\N	提交申请	userTask	user1	2017-10-10 12:59:10.73	2017-10-10 12:59:10.789	59	
\.


--
-- Data for Name: act_hi_attachment; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY act_hi_attachment (id_, rev_, user_id_, name_, description_, type_, task_id_, proc_inst_id_, url_, content_id_, time_) FROM stdin;
\.


--
-- Data for Name: act_hi_comment; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) FROM stdin;
5018	comment	2017-10-09 14:00:52.634	\N	5013	5005	AddComment	我统一	\\xe68891e7bb9fe4b880
5027	comment	2017-10-09 14:01:16.62	\N	5022	5005	AddComment	我拒绝	\\xe68891e68b92e7bb9d
5034	comment	2017-10-09 14:01:48.179	\N	5030	5005	AddComment	重新申请	\\xe9878de696b0e794b3e8afb7
7504	comment	2017-10-09 18:47:49.513	\N	5037	5005	AddComment	aaa	\\x616161
7512	comment	2017-10-09 18:48:02.57	\N	7507	5005	AddComment	aaa	\\x616161
7520	comment	2017-10-09 18:48:22.757	\N	7515	5005	AddComment	aaa	\\x616161
\.


--
-- Data for Name: act_hi_detail; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY act_hi_detail (id_, type_, proc_inst_id_, execution_id_, task_id_, act_inst_id_, name_, var_type_, rev_, time_, bytearray_id_, double_, long_, text_, text2_) FROM stdin;
\.


--
-- Data for Name: act_hi_identitylink; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, proc_inst_id_) FROM stdin;
5006	\N	starter	user1	\N	5005
5014	101	candidate	\N	5013	\N
5023	102	candidate	\N	5022	\N
5038	101	candidate	\N	5037	\N
7508	102	candidate	\N	7507	\N
7516	103	candidate	\N	7515	\N
7524	\N	starter	user1	\N	7523
7532	101	candidate	\N	7531	\N
10002	\N	starter	user1	\N	10001
10011	101	candidate	\N	10010	\N
\.


--
-- Data for Name: act_hi_procinst; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY act_hi_procinst (id_, proc_inst_id_, business_key_, proc_def_id_, start_time_, end_time_, duration_, start_user_id_, start_act_id_, end_act_id_, super_process_instance_id_, delete_reason_, tenant_id_, name_) FROM stdin;
5005	5005	NEWS-2-TOLCIUIENJA77NOUW2KKLB3S	act_news_approve:1:5004	2017-10-09 14:00:21.053	2017-10-09 18:48:22.773	17281720	user1	_2	_3	\N	\N		\N
7523	7523	NEWS-3-VG3DRKGIYCDFDUX2RGZEZ2UX	act_news_approve:1:5004	2017-10-09 18:57:19.681	\N	\N	user1	_2	\N	\N	\N		\N
10001	10001	NEWS-4-XNBJ3BO6JZ5VJOM6SKQUBWJN	act_news_approve:1:5004	2017-10-10 12:59:10.717	\N	\N	user1	_2	\N	\N	\N		\N
\.


--
-- Data for Name: act_hi_taskinst; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY act_hi_taskinst (id_, proc_def_id_, task_def_key_, proc_inst_id_, execution_id_, name_, parent_task_id_, description_, owner_, assignee_, start_time_, claim_time_, end_time_, duration_, delete_reason_, priority_, due_date_, form_key_, category_, tenant_id_) FROM stdin;
5011	act_news_approve:1:5004	step01-01	5005	5005	提交申请	\N	\N	\N	user1	2017-10-09 14:00:21.074	\N	2017-10-09 14:00:21.151	77	completed	50	\N	\N	\N	
5013	act_news_approve:1:5004	step02	5005	5005	支队领导审批	\N	\N	\N	\N	2017-10-09 14:00:21.16	\N	2017-10-09 14:00:52.649	31489	completed	50	\N	\N	\N	
5022	act_news_approve:1:5004	step03	5005	5005	定密员审批	\N	\N	\N	\N	2017-10-09 14:00:52.658	\N	2017-10-09 14:01:16.635	23977	completed	50	\N	\N	\N	
5030	act_news_approve:1:5004	step01-02	5005	5005	申请被退回	\N	\N	\N	user1	2017-10-09 14:01:16.639	\N	2017-10-09 14:01:48.191	31552	completed	50	\N	\N	\N	
5037	act_news_approve:1:5004	step02	5005	5005	支队领导审批	\N	\N	\N	\N	2017-10-09 14:01:48.194	\N	2017-10-09 18:47:49.831	17161637	completed	50	\N	\N	\N	
7507	act_news_approve:1:5004	step03	5005	5005	定密员审批	\N	\N	\N	\N	2017-10-09 18:47:49.865	\N	2017-10-09 18:48:02.584	12719	completed	50	\N	\N	\N	
7515	act_news_approve:1:5004	step04	5005	5005	总队领导审批	\N	\N	\N	\N	2017-10-09 18:48:02.589	\N	2017-10-09 18:48:22.768	20179	completed	50	\N	\N	\N	
7531	act_news_approve:1:5004	step02	7523	7523	支队领导审批	\N	\N	\N	\N	2017-10-09 18:57:19.714	\N	\N	\N	\N	50	\N	\N	\N	
7529	act_news_approve:1:5004	step01-01	7523	7523	提交申请	\N	\N	\N	user1	2017-10-09 18:57:19.684	\N	2017-10-09 18:57:19.712	28	completed	50	\N	\N	\N	
10010	act_news_approve:1:5004	step02	10001	10001	支队领导审批	\N	\N	\N	\N	2017-10-10 12:59:10.789	\N	\N	\N	\N	50	\N	\N	\N	
10008	act_news_approve:1:5004	step01-01	10001	10001	提交申请	\N	\N	\N	user1	2017-10-10 12:59:10.732	\N	2017-10-10 12:59:10.782	50	completed	50	\N	\N	\N	
\.


--
-- Data for Name: act_hi_varinst; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY act_hi_varinst (id_, proc_inst_id_, execution_id_, task_id_, name_, var_type_, rev_, bytearray_id_, double_, long_, text_, text2_, create_time_, last_updated_time_) FROM stdin;
5016	5005	5005	5013	task_approve	serializable	0	5017	\N	\N	\N	\N	2017-10-09 14:00:52.623	2017-10-09 14:00:52.623
5025	5005	5005	5022	task_approve	serializable	0	5026	\N	\N	\N	\N	2017-10-09 14:01:16.612	2017-10-09 14:01:16.612
5032	5005	5005	5030	task_approve	serializable	0	5033	\N	\N	\N	\N	2017-10-09 14:01:48.172	2017-10-09 14:01:48.172
7502	5005	5005	5037	task_approve	serializable	0	7503	\N	\N	\N	\N	2017-10-09 18:47:49.449	2017-10-09 18:47:49.449
7510	5005	5005	7507	task_approve	serializable	0	7511	\N	\N	\N	\N	2017-10-09 18:48:02.556	2017-10-09 18:48:02.556
7518	5005	5005	7515	task_approve	serializable	0	7519	\N	\N	\N	\N	2017-10-09 18:48:22.746	2017-10-09 18:48:22.746
5019	5005	5005	\N	action	string	5	\N	\N	\N	agree	\N	2017-10-09 14:00:52.64	2017-10-09 18:48:22.78
5008	5005	5005	\N	applyUser	string	1	\N	\N	\N	user1	\N	2017-10-09 14:00:21.053	2017-10-09 18:48:22.78
5009	5005	5005	\N	act_var_subject	string	2	\N	\N	\N	test	\N	2017-10-09 14:00:21.053	2017-10-09 18:48:22.78
7526	7523	7523	\N	applyUser	string	0	\N	\N	\N	user1	\N	2017-10-09 18:57:19.681	2017-10-09 18:57:19.681
7527	7523	7523	\N	act_var_subject	string	0	\N	\N	\N	aa	\N	2017-10-09 18:57:19.681	2017-10-09 18:57:19.681
10004	10001	10001	\N	applyUser	string	0	\N	\N	\N	user1	\N	2017-10-10 12:59:10.717	2017-10-10 12:59:10.717
10005	10001	10001	\N	PROCESS_subject	string	0	\N	\N	\N	test	\N	2017-10-10 12:59:10.718	2017-10-10 12:59:10.718
10006	10001	10001	\N	PROCESS_type	string	0	\N	\N	\N	NEWS_11	\N	2017-10-10 12:59:10.718	2017-10-10 12:59:10.718
\.


--
-- Data for Name: act_id_group; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY act_id_group (id_, rev_, name_, type_) FROM stdin;
100	1	职员	DEFAULT
101	1	支队领导	DEFAULT
102	1	定密员	DEFAULT
103	1	总队领导	DEFAULT
\.


--
-- Data for Name: act_id_info; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY act_id_info (id_, rev_, user_id_, type_, key_, value_, password_, parent_id_) FROM stdin;
\.


--
-- Data for Name: act_id_membership; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY act_id_membership (user_id_, group_id_) FROM stdin;
user1	100
user2	101
user3	102
user4	103
\.


--
-- Data for Name: act_id_user; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY act_id_user (id_, rev_, first_, last_, email_, pwd_, picture_id_) FROM stdin;
user1	1	张三	\N	\N	\N	\N
user2	1	李四	\N	\N	\N	\N
user3	1	王五	\N	\N	\N	\N
user4	1	赵六	\N	\N	\N	\N
\.


--
-- Data for Name: act_procdef_info; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY act_procdef_info (id_, proc_def_id_, rev_, info_json_id_) FROM stdin;
\.


--
-- Data for Name: act_re_deployment; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY act_re_deployment (id_, name_, category_, tenant_id_, deploy_time_) FROM stdin;
5001	SpringAutoDeployment	\N		2017-10-09 13:59:44.88
12501	SpringAutoDeployment	\N		2017-10-10 13:33:38.369
\.


--
-- Data for Name: act_re_model; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY act_re_model (id_, rev_, name_, key_, category_, create_time_, last_update_time_, version_, meta_info_, deployment_id_, editor_source_value_id_, editor_source_extra_value_id_, tenant_id_) FROM stdin;
\.


--
-- Data for Name: act_re_procdef; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY act_re_procdef (id_, rev_, category_, name_, key_, version_, deployment_id_, resource_name_, dgrm_resource_name_, description_, has_start_form_key_, has_graphical_notation_, suspension_state_, tenant_id_) FROM stdin;
act_news_approve:1:5004	1	http://sourceforge.net/bpmn/definitions/_20171006	\N	act_news_approve	1	5001	/home/bert/Documents/github/acme/cqjz/target/classes/assets/bpm/actNews.bpmn	/home/bert/Documents/github/acme/cqjz/target/classes/assets/bpm/actNews.act_news_approve.png	\N	f	t	1	
act_news_approve:2:12504	1	http://sourceforge.net/bpmn/definitions/_20171006	\N	act_news_approve	2	12501	/home/facheng/source/fc/acme/cqjz/target/classes/assets/bpm/actNews.bpmn	/home/facheng/source/fc/acme/cqjz/target/classes/assets/bpm/actNews.act_news_approve.png	\N	f	t	1	
\.


--
-- Data for Name: act_ru_event_subscr; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY act_ru_event_subscr (id_, rev_, event_type_, event_name_, execution_id_, proc_inst_id_, activity_id_, configuration_, created_, proc_def_id_, tenant_id_) FROM stdin;
\.


--
-- Data for Name: act_ru_execution; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY act_ru_execution (id_, rev_, proc_inst_id_, business_key_, parent_id_, proc_def_id_, super_exec_, act_id_, is_active_, is_concurrent_, is_scope_, is_event_scope_, suspension_state_, cached_ent_state_, tenant_id_, name_, lock_time_) FROM stdin;
7523	2	7523	NEWS-3-VG3DRKGIYCDFDUX2RGZEZ2UX	\N	act_news_approve:1:5004	\N	step02	t	f	t	f	1	2		\N	\N
10001	2	10001	NEWS-4-XNBJ3BO6JZ5VJOM6SKQUBWJN	\N	act_news_approve:1:5004	\N	step02	t	f	t	f	1	2		\N	\N
\.


--
-- Data for Name: act_ru_identitylink; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY act_ru_identitylink (id_, rev_, group_id_, type_, user_id_, task_id_, proc_inst_id_, proc_def_id_) FROM stdin;
7524	1	\N	starter	user1	\N	7523	\N
7532	1	101	candidate	\N	7531	\N	\N
10002	1	\N	starter	user1	\N	10001	\N
10011	1	101	candidate	\N	10010	\N	\N
\.


--
-- Data for Name: act_ru_job; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY act_ru_job (id_, rev_, type_, lock_exp_time_, lock_owner_, exclusive_, execution_id_, process_instance_id_, proc_def_id_, retries_, exception_stack_id_, exception_msg_, duedate_, repeat_, handler_type_, handler_cfg_, tenant_id_) FROM stdin;
\.


--
-- Data for Name: act_ru_task; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY act_ru_task (id_, rev_, execution_id_, proc_inst_id_, proc_def_id_, name_, parent_task_id_, description_, task_def_key_, owner_, assignee_, delegation_, priority_, create_time_, due_date_, category_, suspension_state_, tenant_id_, form_key_) FROM stdin;
7531	1	7523	7523	act_news_approve:1:5004	支队领导审批	\N	\N	step02	\N	\N	\N	50	2017-10-09 18:57:19.714	\N	\N	1		\N
10010	1	10001	10001	act_news_approve:1:5004	支队领导审批	\N	\N	step02	\N	\N	\N	50	2017-10-10 12:59:10.789	\N	\N	1		\N
\.


--
-- Data for Name: act_ru_variable; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY act_ru_variable (id_, rev_, type_, name_, execution_id_, proc_inst_id_, task_id_, bytearray_id_, double_, long_, text_, text2_) FROM stdin;
7526	1	string	applyUser	7523	7523	\N	\N	\N	\N	user1	\N
7527	1	string	act_var_subject	7523	7523	\N	\N	\N	\N	aa	\N
10004	1	string	applyUser	10001	10001	\N	\N	\N	\N	user1	\N
10005	1	string	PROCESS_subject	10001	10001	\N	\N	\N	\N	test	\N
10006	1	string	PROCESS_type	10001	10001	\N	\N	\N	\N	NEWS_11	\N
\.


--
-- Data for Name: ad_login_log; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY ad_login_log (id, account, client_ip, login_time, message, success) FROM stdin;
1	admin	0:0:0:0:0:0:0:1	2017-08-21 09:21:59.333	\N	t
52	admin	0:0:0:0:0:0:0:1	2017-08-21 10:48:25.916	\N	t
102	admin	0:0:0:0:0:0:0:1	2017-08-21 10:51:31.84	\N	t
152	admin	0:0:0:0:0:0:0:1	2017-08-21 11:03:13.848	\N	t
202	admin	0:0:0:0:0:0:0:1	2017-08-21 11:06:31.784	\N	t
252	admin	0:0:0:0:0:0:0:1	2017-08-21 11:07:28.914	\N	t
302	admin	0:0:0:0:0:0:0:1	2017-08-21 11:08:34.888	\N	t
352	admin	0:0:0:0:0:0:0:1	2017-08-21 15:17:17.64	\N	t
402	admin	0:0:0:0:0:0:0:1	2017-08-21 15:44:13.187	\N	t
452	admin	0:0:0:0:0:0:0:1	2017-08-21 15:45:17.615	\N	t
502	admin	0:0:0:0:0:0:0:1	2017-08-22 09:50:00.458	\N	t
503	admin	0:0:0:0:0:0:0:1	2017-08-22 11:39:07.388	\N	t
504	admin	0:0:0:0:0:0:0:1	2017-08-22 13:36:28.576	\N	t
552	admin	0:0:0:0:0:0:0:1	2017-08-23 13:35:45.05	\N	t
602	admin	0:0:0:0:0:0:0:1	2017-08-24 17:11:56.524	\N	t
603	admin	0:0:0:0:0:0:0:1	2017-08-24 18:47:24.453	\N	t
604	admin	0:0:0:0:0:0:0:1	2017-08-24 19:39:09.38	\N	t
652	admin	0:0:0:0:0:0:0:1	2017-08-25 09:33:58.193	\N	t
653	admin	0:0:0:0:0:0:0:1	2017-08-25 10:08:30.551	\N	t
702	admin	0:0:0:0:0:0:0:1	2017-08-25 11:04:51.036	\N	t
752	admin	0:0:0:0:0:0:0:1	2017-08-25 11:13:36.536	\N	t
802	admin	0:0:0:0:0:0:0:1	2017-08-25 11:53:20.29	\N	t
852	admin	127.0.0.1	2017-08-25 13:41:39.868	用户或密码错误.	f
853	admin	127.0.0.1	2017-08-25 13:41:41.212	\N	t
902	admin	0:0:0:0:0:0:0:1	2017-08-25 13:43:32.76	\N	t
952	admin	0:0:0:0:0:0:0:1	2017-08-25 13:44:28.263	\N	t
1002	admin	0:0:0:0:0:0:0:1	2017-08-25 13:46:01.309	\N	t
1052	admin	0:0:0:0:0:0:0:1	2017-08-25 13:49:18.119	\N	t
1102	admin	0:0:0:0:0:0:0:1	2017-08-25 14:35:44.161	\N	t
1152	admin	0:0:0:0:0:0:0:1	2017-08-25 15:31:50.65	\N	t
1202	admin	0:0:0:0:0:0:0:1	2017-08-25 15:34:43.47	\N	t
1252	admin	0:0:0:0:0:0:0:1	2017-08-25 15:35:47.791	\N	t
1302	admin	0:0:0:0:0:0:0:1	2017-08-25 15:37:20.692	\N	t
1352	admin	0:0:0:0:0:0:0:1	2017-08-25 15:38:25.872	\N	t
1402	admin	0:0:0:0:0:0:0:1	2017-08-25 15:39:40.857	\N	t
1452	admin	0:0:0:0:0:0:0:1	2017-08-25 15:42:17.124	\N	t
1502	admin	0:0:0:0:0:0:0:1	2017-08-25 15:58:18.441	\N	t
1552	admin	0:0:0:0:0:0:0:1	2017-08-25 16:07:08.36	\N	t
1602	admin	0:0:0:0:0:0:0:1	2017-08-25 16:33:42.158	\N	t
1652	admin	0:0:0:0:0:0:0:1	2017-08-25 16:39:51.789	\N	t
1702	admin	0:0:0:0:0:0:0:1	2017-08-25 16:41:26.36	\N	t
1752	admin	0:0:0:0:0:0:0:1	2017-08-25 16:47:43.523	\N	t
1802	admin	0:0:0:0:0:0:0:1	2017-08-25 17:29:34.272	\N	t
1852	admin	127.0.0.1	2017-08-31 19:58:49.146	\N	t
1902	admin	127.0.0.1	2017-08-31 20:12:02.971	\N	t
1952	admin	127.0.0.1	2017-08-31 20:18:32.66	用户或密码错误.	f
1953	admin	127.0.0.1	2017-08-31 20:18:33.551	\N	t
1954	admin	127.0.0.1	2017-08-31 20:23:21.012	\N	t
2002	admin	127.0.0.1	2017-08-31 20:29:13.155	\N	t
2052	admin	127.0.0.1	2017-08-31 20:33:50.178	用户或密码错误.	f
2053	admin	127.0.0.1	2017-08-31 20:33:51.335	\N	t
2054	admin	0:0:0:0:0:0:0:1	2017-08-31 20:39:37.963	\N	t
2102	admin	0:0:0:0:0:0:0:1	2017-08-31 20:44:19.734	\N	t
2152	admin	0:0:0:0:0:0:0:1	2017-08-31 20:46:20.941	\N	t
2202	admin	0:0:0:0:0:0:0:1	2017-08-31 20:48:01.535	\N	t
2252	admin	0:0:0:0:0:0:0:1	2017-08-31 20:50:03.954	\N	t
2302	admin	0:0:0:0:0:0:0:1	2017-08-31 20:52:39.524	\N	t
2352	admin	0:0:0:0:0:0:0:1	2017-08-31 20:53:47.398	\N	t
2402	admin	0:0:0:0:0:0:0:1	2017-08-31 20:54:57.621	\N	t
2403	admin	127.0.0.1	2017-08-31 20:56:10.387	\N	t
2404	admin	0:0:0:0:0:0:0:1	2017-08-31 20:57:11.582	\N	t
2452	admin	0:0:0:0:0:0:0:1	2017-08-31 21:00:26.494	\N	t
2502	admin	0:0:0:0:0:0:0:1	2017-08-31 21:01:38.025	\N	t
2552	admin	0:0:0:0:0:0:0:1	2017-08-31 21:03:41.571	\N	t
2602	admin	127.0.0.1	2017-09-04 09:36:18.971	用户或密码错误.	f
2603	admin	127.0.0.1	2017-09-04 09:36:20.059	\N	t
2652	admin	127.0.0.1	2017-09-04 09:45:12.531	\N	t
2653	admin	0:0:0:0:0:0:0:1	2017-09-04 10:49:37.188	\N	t
2654	admin	0:0:0:0:0:0:0:1	2017-09-04 13:37:10.698	\N	t
2702	admin	127.0.0.1	2017-09-06 11:03:20.217	\N	t
2752	admin	127.0.0.1	2017-09-06 11:15:58.883	\N	t
2802	admin	0:0:0:0:0:0:0:1	2017-09-06 14:17:06.83	\N	t
2852	admin	0:0:0:0:0:0:0:1	2017-09-06 22:02:56.799	\N	t
2902	admin	127.0.0.1	2017-09-18 09:59:41.574	\N	t
2952	admin	127.0.0.1	2017-09-18 11:00:19.329	\N	t
3002	admin	127.0.0.1	2017-09-18 13:24:41.823	\N	t
3003	admin	127.0.0.1	2017-09-18 13:30:47.528	\N	t
3052	admin	127.0.0.1	2017-09-19 09:43:53.165	\N	t
3102	admin	127.0.0.1	2017-09-20 09:34:16.414	\N	t
3152	admin	127.0.0.1	2017-09-20 15:12:40.662	\N	t
3202	admin	127.0.0.1	2017-09-20 15:16:45.091	\N	t
3252	admin	127.0.0.1	2017-09-20 18:33:47.1	\N	t
3302	admin	192.168.3.14	2017-09-22 15:15:28.869	\N	t
3303	admin	192.168.3.14	2017-09-22 15:15:53.205	\N	t
3304	admin	192.168.3.14	2017-09-22 15:16:08.027	\N	t
3352	admin	127.0.0.1	2017-09-27 10:40:08.149	\N	t
3402	admin	127.0.0.1	2017-09-27 13:59:17.408	\N	t
3452	admin	127.0.0.1	2017-09-27 14:02:20.049	\N	t
3502	admin	127.0.0.1	2017-09-27 14:09:49.275	\N	t
3552	admin	127.0.0.1	2017-09-27 14:13:06.204	\N	t
3602	admin	127.0.0.1	2017-09-27 14:16:05.149	\N	t
3652	admin	127.0.0.1	2017-09-27 14:20:26.133	\N	t
3702	admin	127.0.0.1	2017-09-27 14:21:47.74	\N	t
3752	admin	127.0.0.1	2017-09-27 14:22:56.779	\N	t
3802	admin	127.0.0.1	2017-09-29 10:02:15.877	\N	t
3852	admin	127.0.0.1	2017-09-29 10:58:05.816	\N	t
3853	admin	127.0.0.1	2017-09-29 16:03:03.132	\N	t
3902	admin	127.0.0.1	2017-10-09 10:12:32.766	\N	t
3903	user1	127.0.0.1	2017-10-09 10:14:04.482	\N	t
3904	admin	127.0.0.1	2017-10-09 10:14:14.168	\N	t
3905	admin	127.0.0.1	2017-10-09 10:14:23.163	\N	t
3906	user2	127.0.0.1	2017-10-09 10:14:32.807	\N	t
3907	user3	127.0.0.1	2017-10-09 10:14:38.718	\N	t
3908	admin	127.0.0.1	2017-10-09 10:15:43.507	\N	t
3909	user1	127.0.0.1	2017-10-09 10:16:00.784	\N	t
3910	admin	127.0.0.1	2017-10-09 10:17:13.744	\N	t
3911	user1	127.0.0.1	2017-10-09 10:17:30.956	\N	t
3912	user2	0:0:0:0:0:0:0:1	2017-10-09 10:18:50.35	\N	t
3913	user3	0:0:0:0:0:0:0:1	2017-10-09 10:19:16.079	\N	t
3952	user3	127.0.0.1	2017-10-09 11:27:20.195	\N	t
3953	user1	127.0.0.1	2017-10-09 11:27:35.49	\N	t
4002	user1	0:0:0:0:0:0:0:1	2017-10-09 13:46:41.336	用户或密码错误.	f
4003	user1	0:0:0:0:0:0:0:1	2017-10-09 13:46:44.464	用户或密码错误.	f
4052	user2	0:0:0:0:0:0:0:1	2017-10-09 13:56:17.39	\N	t
4102	user1	0:0:0:0:0:0:0:1	2017-10-09 14:00:11.928	\N	t
4103	user2	127.0.0.1	2017-10-09 14:00:37.408	\N	t
4104	user3	0:0:0:0:0:0:0:1	2017-10-09 14:01:08.42	\N	t
4105	user1	0:0:0:0:0:0:0:1	2017-10-09 14:01:22.853	\N	t
4152	user1	127.0.0.1	2017-10-09 14:50:46.543	\N	t
4153	admin	127.0.0.1	2017-10-09 14:50:56.166	\N	t
4154	user1	127.0.0.1	2017-10-09 14:51:23.554	\N	t
4202	user1	127.0.0.1	2017-10-09 14:52:46.576	\N	t
4252	user1	127.0.0.1	2017-10-09 14:57:24.717	\N	t
4302	user1	127.0.0.1	2017-10-09 14:58:43.549	\N	t
4303	user1	127.0.0.1	2017-10-09 14:59:00.556	\N	t
4304	user2	127.0.0.1	2017-10-09 14:59:06.023	\N	t
4305	admin	127.0.0.1	2017-10-09 15:00:28.537	\N	t
4306	user1	127.0.0.1	2017-10-09 15:08:10.953	\N	t
4352	user1	0:0:0:0:0:0:0:1	2017-10-09 18:25:24.536	\N	t
4402	user1	0:0:0:0:0:0:0:1	2017-10-09 18:34:33.041	\N	t
4403	user1	0:0:0:0:0:0:0:1	2017-10-09 18:34:46.44	\N	t
4404	user1	0:0:0:0:0:0:0:1	2017-10-09 18:37:31.906	\N	t
4452	user1	0:0:0:0:0:0:0:1	2017-10-09 18:41:49.603	\N	t
4453	user2	0:0:0:0:0:0:0:1	2017-10-09 18:47:42.886	\N	t
4454	user3	0:0:0:0:0:0:0:1	2017-10-09 18:47:56.474	\N	t
4455	user4	0:0:0:0:0:0:0:1	2017-10-09 18:48:16.07	\N	t
4456	user1	0:0:0:0:0:0:0:1	2017-10-09 18:48:56.33	\N	t
4502	user1	127.0.0.1	2017-10-10 10:00:07.822	\N	t
4552	user1	127.0.0.1	2017-10-10 12:51:23.518	\N	t
4602	user1	127.0.0.1	2017-10-10 12:58:49.264	\N	t
4652	admin	0:0:0:0:0:0:0:1	2017-10-10 13:43:13.905	用户或密码错误.	f
4653	admin	0:0:0:0:0:0:0:1	2017-10-10 13:43:16.214	\N	t
4654	admin	192.168.8.113	2017-10-10 13:45:50.882	\N	t
\.


--
-- Data for Name: ad_menu; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY ad_menu (id, description, image, level, name, parent_id, sequence, url) FROM stdin;
1	\N	\N	1	系统设置	\N	1	\N
2	\N	\N	2	角色管理	1	1	role.list
3	\N	\N	2	用户管理	1	2	user.list
4	\N	\N	2	菜单管理	1	3	menu.list
5	\N	\N	2	机构管理	1	4	depart.list
6	\N	\N	1	新闻管理	\N	2	\N
8	\N	\N	2	新闻列表	6	2	news.list
7	\N	\N	2	新闻发布	6	1	news.publish
11	\N	\N	2	已发起	9	1	flow.list.submit
12	\N	\N	2	待处理	9	2	flow.list.pending
10	\N	\N	2	已处理	9	3	flow.list.approve
13	\N	\N	2	拒绝事宜	9	4	flow.list.reject
9	\N	\N	1	我的任务	\N	3	\N
\.


--
-- Data for Name: ad_permission; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY ad_permission (code, created_on, message_key, parent_code, permit, type) FROM stdin;
99	2017-08-21 09:13:48.477	resource.permission.group.default	\N	99	0
10	2017-08-21 09:13:48.477	resource.permission.group.role	\N	10	0
1003	2017-08-21 09:13:48.477	resource.permission.function.delete	10	03	1
\.


--
-- Data for Name: ad_process_flow; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY ad_process_flow (execution_id, apply_by, apply_on, news_id, process_id, state, updated_by, updated_at) FROM stdin;
\.


--
-- Data for Name: ad_role; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY ad_role (id, created_at, created_by, updated_by, updated_at, status, description, name) FROM stdin;
1	2017-08-21 09:21:08.119	0	0	2017-08-25 15:47:26.561	0	poosse	管理员
2	2017-10-09 10:12:47.157	0	\N	\N	0	\N	新闻相关角色
\.


--
-- Data for Name: ad_role_menu; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY ad_role_menu (role_id, menu_id) FROM stdin;
1	6
1	8
1	7
1	9
1	10
1	11
1	12
1	13
1	4
1	3
1	2
1	1
1	5
2	6
2	8
2	7
2	9
2	10
2	11
2	12
2	13
\.


--
-- Data for Name: ad_role_permission; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY ad_role_permission (role_id, permission_code) FROM stdin;
\.


--
-- Data for Name: ad_user; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY ad_user (id, created_at, created_by, updated_by, updated_at, status, account, email, gender, mobile, name, password, telephone, approve_role) FROM stdin;
0	\N	\N	0	2017-08-24 17:12:32.49	0	admin	\N	1	\N	管理员	707f8e47f7fab4f5cb2f7733e2a8afe017d64897e072ad09814d9fcc6fddcb440a2e8346a16a4c5a	\N	\N
1	2017-10-09 10:13:11.067	0	\N	\N	1	user1	\N	\N	\N	张三	32187faca4d0aca163c4f6b85a70cba975a5b3702542f136b52abd814a3bf2985d7331f95a3cd10e	\N	100
2	2017-10-09 10:13:19.839	0	\N	\N	1	user2	\N	\N	\N	李四	a0ff06cc1fa84e96e990092de06a31772aa62a4cae128a5559192b9eef396c9047145e4573cdd839	\N	101
3	2017-10-09 10:13:29.7	0	\N	\N	1	user3	\N	\N	\N	王五	cf3492a7f3e0afa8e0510278e683c1368a4c69b58cdc0e6c5180b00feeae6f9a15723758280b3196	\N	102
4	2017-10-09 10:13:42.466	0	\N	\N	1	user4	\N	\N	\N	赵六	6559eef24aa60c1c724cbdc11929bc66ccd4f28c4bf0a10ac1df2193d701d25ce35c98b4ce9c8fd0	\N	103
\.


--
-- Data for Name: ad_user_permission; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY ad_user_permission (user_id, permission_code) FROM stdin;
\.


--
-- Data for Name: ad_user_role; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY ad_user_role (user_id, role_id) FROM stdin;
0	1
4	2
3	2
2	2
1	2
\.


--
-- Data for Name: cargo_discrepancy_event; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY cargo_discrepancy_event (id, order_number, erp_number, added_at, expired_at, event_push_url, event_max_push_retry, event_push_retry_count, event_last_push_at, event_pushed, event_time, request_body, response, client_id, owner_id, order_discrepancy_id) FROM stdin;
2	BESTSELL22703270	3004606320	2017-09-12 17:16:00	2017-09-16 00:00:00	https://esb.otms.cn/bestseller/discrepancy/push/internal	10	10	2017-09-15 17:02:00	t	2017-09-12 17:16:00	{"orderDiscrepancies":[{"erpNumber":"3004606320","shipToName":"昆明金鹰2期店JJ 6G26","shipToExternalId":"6G26","orderLineDiscrepancies":[{"productCode":"SH17080900023423","productName":"SH17080900023423","unit":"箱","damage":0,"shortage":1}]}]}	{"status":"500"};ERROR: duplicate key value violates unique constraint "ws_inbound_pk"\r\n  Detail: Key (id)=(1759570) already exists. (org.postgresql.util.PSQLException). Message payload is of type: String;{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"}	50	7000	43115
8	BESTSELL22869327	3004663223	2017-09-12 17:20:00	2017-09-16 00:00:00	https://esb.otms.cn/bestseller/discrepancy/push/internal	10	10	2017-09-15 17:02:00	t	2017-09-12 17:20:00	{"orderDiscrepancies":[{"erpNumber":"3004663223","shipToName":"昭通新百货大楼JJ 6G33","shipToExternalId":"6G33","orderLineDiscrepancies":[{"productCode":"SH17081500006430","productName":"SH17081500006430","unit":"箱","damage":0,"shortage":1}]}]}	{"status":"500"};ERROR: duplicate key value violates unique constraint "ws_inbound_pk"\r\n  Detail: Key (id)=(1759607) already exists. (org.postgresql.util.PSQLException). Message payload is of type: String;{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"}	50	7000	43140
4	BESTSELL22702829	3004645263	2017-09-12 17:18:00	2017-09-16 00:00:00	https://esb.otms.cn/bestseller/discrepancy/push/internal	10	10	2017-09-15 17:02:00	t	2017-09-12 17:18:00	{"orderDiscrepancies":[{"erpNumber":"3004645263","shipToName":"昆明金鹰2期店JJ 6G26","shipToExternalId":"6G26","orderLineDiscrepancies":[{"productCode":"SH17081100018118","productName":"SH17081100018118","unit":"箱","damage":0,"shortage":1}]}]}	{"status":"500"};ERROR: duplicate key value violates unique constraint "ws_inbound_pk"\r\n  Detail: Key (id)=(1759577) already exists. (org.postgresql.util.PSQLException). Message payload is of type: String;{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"}	50	7000	43117
5	BESTSELL22702982	3004626308	2017-09-12 17:19:00	2017-09-16 00:00:00	https://esb.otms.cn/bestseller/discrepancy/push/internal	10	10	2017-09-15 17:02:00	t	2017-09-12 17:19:00	{"orderDiscrepancies":[{"erpNumber":"3004626308","shipToName":"昆明金鹰2期店JJ 6G26","shipToExternalId":"6G26","orderLineDiscrepancies":[{"productCode":"SH17081100012078","productName":"SH17081100012078","unit":"箱","damage":0,"shortage":1}]}]}	{"status":"500"};ERROR: duplicate key value violates unique constraint "ws_inbound_pk"\r\n  Detail: Key (id)=(1759583) already exists. (org.postgresql.util.PSQLException). Message payload is of type: String;{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"}	50	7000	43120
3	BESTSELL22703270	3004606320	2017-09-12 17:16:00	2017-09-16 00:00:00	https://esb.otms.cn/bestseller/discrepancy/push/internal	10	10	2017-09-15 17:02:00	t	2017-09-12 17:16:00	{"orderDiscrepancies":[{"erpNumber":"3004606320","shipToName":"昆明金鹰2期店JJ 6G26","shipToExternalId":"6G26","orderLineDiscrepancies":[{"productCode":"SH17080900017602","productName":"SH17080900017602","unit":"箱","damage":0,"shortage":1}]}]}	{"status":"500"};ERROR: duplicate key value violates unique constraint "ws_inbound_pk"\r\n  Detail: Key (id)=(1759571) already exists. (org.postgresql.util.PSQLException). Message payload is of type: String;{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"}	50	7000	43114
7	BESTSELL22702982	3004626308	2017-09-12 17:19:00	2017-09-16 00:00:00	https://esb.otms.cn/bestseller/discrepancy/push/internal	10	10	2017-09-15 17:02:00	t	2017-09-12 17:19:00	{"orderDiscrepancies":[{"erpNumber":"3004626308","shipToName":"昆明金鹰2期店JJ 6G26","shipToExternalId":"6G26","orderLineDiscrepancies":[{"productCode":"SH17081100011639","productName":"SH17081100011639","unit":"箱","damage":0,"shortage":1}]}]}	{"status":"500"};ERROR: duplicate key value violates unique constraint "ws_inbound_pk"\r\n  Detail: Key (id)=(1759585) already exists. (org.postgresql.util.PSQLException). Message payload is of type: String;{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"}	50	7000	43118
1	BESTSELL22703270	3004606320	2017-09-12 17:16:00	2017-09-16 00:00:00	https://esb.otms.cn/bestseller/discrepancy/push/internal	10	10	2017-09-15 17:02:00	t	2017-09-12 17:16:00	{"orderDiscrepancies":[{"erpNumber":"3004606320","shipToName":"昆明金鹰2期店JJ 6G26","shipToExternalId":"6G26","orderLineDiscrepancies":[{"productCode":"SH17080900021054","productName":"SH17080900021054","unit":"箱","damage":0,"shortage":1}]}]}	{"status":"500"};ERROR: duplicate key value violates unique constraint "ws_inbound_pk"\r\n  Detail: Key (id)=(1759569) already exists. (org.postgresql.util.PSQLException). Message payload is of type: String;{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"}	50	7000	43116
11	BESTSELL22956461	3004722853	2017-09-12 17:21:00	2017-09-16 00:00:00	https://esb.otms.cn/bestseller/discrepancy/push/internal	10	10	2017-09-15 17:02:00	t	2017-09-12 17:21:00	{"orderDiscrepancies":[{"erpNumber":"3004722853","shipToName":"个旧丽水金湾ONLY 1G23","shipToExternalId":"1G23","orderLineDiscrepancies":[{"productCode":"SH17081800005145","productName":"SH17081800005145","unit":"箱","damage":0,"shortage":1}]}]}	{"status":"500"};ERROR: duplicate key value violates unique constraint "ws_inbound_pk"\r\n  Detail: Key (id)=(1759627) already exists. (org.postgresql.util.PSQLException). Message payload is of type: String;{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"}	50	7000	43627
9	BESTSELL22956474	3004722893	2017-09-12 17:21:00	2017-09-16 00:00:00	https://esb.otms.cn/bestseller/discrepancy/push/internal	10	10	2017-09-15 17:02:00	t	2017-09-12 17:21:00	{"orderDiscrepancies":[{"erpNumber":"3004722893","shipToName":"普洱大世界ONLY 1G81","shipToExternalId":"1G81","orderLineDiscrepancies":[{"productCode":"SH17081900003608","productName":"SH17081900003608","unit":"箱","damage":0,"shortage":1}]}]}	{"status":"500"};ERROR: duplicate key value violates unique constraint "ws_inbound_pk"\r\n  Detail: Key (id)=(1759620) already exists. (org.postgresql.util.PSQLException). Message payload is of type: String;{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"}	50	7000	43806
13	BESTSELL23119306	3004821253	2017-09-12 17:22:00	2017-09-16 00:00:00	https://esb.otms.cn/bestseller/discrepancy/push/internal	10	10	2017-09-15 17:02:00	t	2017-09-12 17:22:00	{"orderDiscrepancies":[{"erpNumber":"3004821253","shipToName":"个旧丽水金湾ONLY 1G23","shipToExternalId":"1G23","orderLineDiscrepancies":[{"productCode":"SH17082300003118","productName":"SH17082300003118","unit":"箱","damage":0,"shortage":1}]}]}	{"status":"500"};ERROR: duplicate key value violates unique constraint "ws_inbound_pk"\r\n  Detail: Key (id)=(1759634) already exists. (org.postgresql.util.PSQLException). Message payload is of type: String;{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"}	50	7000	44018
6	BESTSELL22702982	3004626308	2017-09-12 17:19:00	2017-09-16 00:00:00	https://esb.otms.cn/bestseller/discrepancy/push/internal	10	10	2017-09-15 17:02:00	t	2017-09-12 17:19:00	{"orderDiscrepancies":[{"erpNumber":"3004626308","shipToName":"昆明金鹰2期店JJ 6G26","shipToExternalId":"6G26","orderLineDiscrepancies":[{"productCode":"SH17081100012269","productName":"SH17081100012269","unit":"箱","damage":0,"shortage":1}]}]}	{"status":"500"};ERROR: duplicate key value violates unique constraint "ws_inbound_pk"\r\n  Detail: Key (id)=(1759584) already exists. (org.postgresql.util.PSQLException). Message payload is of type: String;{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"}	50	7000	43119
10	BESTSELL22956461	3004722853	2017-09-12 17:21:00	2017-09-16 00:00:00	https://esb.otms.cn/bestseller/discrepancy/push/internal	10	10	2017-09-15 17:02:00	t	2017-09-12 17:21:00	{"orderDiscrepancies":[{"erpNumber":"3004722853","shipToName":"个旧丽水金湾ONLY 1G23","shipToExternalId":"1G23","orderLineDiscrepancies":[{"productCode":"SH17081800003841","productName":"SH17081800003841","unit":"箱","damage":0,"shortage":1}]}]}	{"status":"500"};ERROR: duplicate key value violates unique constraint "ws_inbound_pk"\r\n  Detail: Key (id)=(1759625) already exists. (org.postgresql.util.PSQLException). Message payload is of type: String;{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"}	50	7000	43628
12	BESTSELL23040268	3004746567	2017-09-12 17:22:00	2017-09-16 00:00:00	https://esb.otms.cn/bestseller/discrepancy/push/internal	10	10	2017-09-15 17:02:00	t	2017-09-12 17:22:00	{"orderDiscrepancies":[{"erpNumber":"3004746567","shipToName":"个旧丽水金湾ONLY 1G23","shipToExternalId":"1G23","orderLineDiscrepancies":[{"productCode":"SH17081900014174","productName":"SH17081900014174","unit":"箱","damage":0,"shortage":1}]}]}	{"status":"500"};ERROR: duplicate key value violates unique constraint "ws_inbound_pk"\r\n  Detail: Key (id)=(1759629) already exists. (org.postgresql.util.PSQLException). Message payload is of type: String;{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"};{"status":"500"}	50	7000	43697
\.


--
-- Data for Name: confirm_discrepancy_event; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY confirm_discrepancy_event (id, added_at, clientid, erp_number, event_last_push_at, event_max_push_retry, event_push_retry_count, event_push_url, event_pushed, event_time, expired_at, order_discrepancy_id, order_number, ownerid, request_body, response) FROM stdin;
\.


--
-- Data for Name: contact; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY contact (customer, phone) FROM stdin;
黄伟,兰林（门市）	13008373893,18723739919
李万红	18983531840
边朝东	18904174404
成都方老板	13688110931微信
黄华全	53231383
成都李德蓉	13348830058,028-83133091
成都李祥军	18280254768
成都王军	13881904320
成都程树林	13018293419
成都余长荣	15528798880
成都曾大琼\n成都张艳	028-83128733,13688349894
绵阳李红	0816-6098600,18781115918
德阳杨老板	0838-2823766,15008366554
德阳张兴州	0838-2821462
德阳贺斯明	0838-2828380,13518267320
达州周丽（不对帐）	18282225358
达州冉晓（会计）	18008193677
达州盛世阳光	13666101899
达州覃光茂(正味)\n李女士（对帐）	13982848693,15984782444
达州吴忠海	0818-2389798,13518251013
达州王晓莉	13198751251
达州张姐	13458171363
攀枝花黄亮	0812-2512690,13508238470
攀枝花王平	0812-2512367,13980350981,13550953391
攀枝花张大	0812-2512484,13547602479,13340713966
雅安李琼	13551559990
宜宾郑姐	0831-8301109,13778969582
自贡胡泽金	13700959605
南充肖远多,黄玉兰	0817-2251943,15881724560
南充方勇	0817-2248348,13990898986
代艳琼	13092825039
广安谭子崟	18926009392,13982683273
刘勇	0831-8356492,13708291351
闻老板	13388382572,18181695486
高燕	13550748643,13890911172
辛厂长	13594462007,58760479
申华林	85808710,45245227237
周虹	18290584405
颜大菊	52675333,15223586458
谭功富	52228173,52267222，52910789
牛牛	52384888,13983553130
周先俊	52221044,13594826883
朱占华，陈贤柱	13608433693,52223709
梁英	52259906,13996639968
谭逢洋，熊安秀	54234825,13983527808
王英明	13635368600,18680909860
王世勇	15826458112
严英	13896204413
万灵金	13038368102
周海涛	54243848,15320728003
蒋丽英，杨平	13752804257
牟来西	13628227238
荣虎源	13985242135
王鹏	\N
唐江毅	15523762181
廖会长	13635388358
陈大海	15084476969
冯妈老火锅	13594775456
汪永碧	13908307245
殷俊杰	13015528638
罗莹	15084388833
薛经理	18183161670
张磊	13637906561
王燕	13594032080
王师傅	13983231124
王师傅	13983231124
韩庄羊蹄	15826370299
万州老蒋	64896539,18315060983
晏总	13638291815
万州蒋帮武	18996630211
周小华	13628355753
刘忠伟	89113796,13708361607
谭奎，徐勇	13908326755
石见	13757928758
小赵	13521360635
黎松	15228888091
周老板	15023878281
侯老板	13996608535
陈小姐	13594815697
杨祖成	58807077,18983701188
谭佐才	13452612147
吴兵	18825258896
向德钢	13908264775
黄超	13509432733,13635328099
赵万红	85807848,13896826490,13896939570
王尔安	13452635613
阿东	15859556822
罗利银	13985159603
刘增宪	13038376057
赵华连	13166811905
唐江义	15523762181
王海君	13252978922
潘光芬	13669363987
张国川	18906820128
王成	13641235255
王贵仁	17790089058,13019229608
刘坤	15055506867
李叔泉	13371121780
卜媛	13806383743
孙占峰	13180032825
吴云	13327028786
刘海光	13593019709
迟东梅	18842374708
任毅	13637812218
魏威	15150044499
鲍卫东	15051319566
吴兴伙	53231241,13896243133
吴兴国	85708107,13512328232
赵红	53337169,15696526796
石万刚	53224124
蒋明坤	13638261100
李小链	53237155
向老板	85701851
胡文君	53251790,13594476422
吴经理	18723539627
哈儿鱼	53336266
廖永梅	53685188,52227493,13594493007
张巧珍	53666717,18323768166
秦	53228377,15923458366
唐运树	53666797
周兴工	53571999,13896222531
方霞	53224910,13206253799
月中桂	53251178
曾凡平	53336358,15320618883
梨博园	53681177
康老师	64831386,53224247
王顺高	13452602618
黄伍妹，熊德明	53239445,85806793,13228580728
瞿国元	238118,2240224,13982828083
李小姐, 李天？	13574046308,13574045858
梁平-胡二	18512335678,18996674358
王世平,何国香	13709434064,15870536173,15123535068
龙溪鱼	53232127
彭国建	57000031,13008373791
周小华	13628355753
梭边鱼	53236777
高老板	13996646425
刘宗强	53232733 53233080,13996594935
林生禄	18323593119,15310527171接待服务
胡老师	13994460812
陶斯菊	53391333
李姐	18183156337
杨经理（收款）	15223769366
唐江义	15523762181
杨	18996674358
张中兵	15084328526
锦兴超市	13452622239,53511112
杨宇	15826188893
李总	13908263219
李老板	13525707978
欧高全	13959809281
黄志彬	15922522277
廖光丽	15923477977
璐璐	15923846466
余涛	13658263733
廖伟	18523788627
常盘	13996597575
常正锋	15923817128
陈良初	13594794998
石校长	13668452789
罗团长	13075493173
廖主任	13996560068
方老师	15923852570
房老板	18123186619
王波	15084468073
王哥	13896910508
富立广告	53231002,15320768588
王平	15328991267
彭	13983177455,15320769797
陈中亮	18996501817
吴惠芬	13971997223
卓	17726607824
张蓉	15310473773
刘爱斌	18523359464
吴乐	18825258896
许正航	18580776273
刘	15736370688
谢知明	13720276870
王贵香	18225018063
言永单	15823376680
周伦琼	13436190245
欣富迪\n常总	67776669,13436277333
卢少群	15808067720,15223564576
余师	17502323481
彭总	18837271111
信阳张经理	15037675942张挺
宁波郑姐	15658202589
唐江毅	15523762181
李敏敏	15023535391
侯德权	13435144748
香香	18983533572,17782205595
杨平	18983533249
侯老板	13882860557
谢总	13709453521
贺孝惠	13708335453
岳卫	15881006960
王小红	15892983509
来宝小学	13638282078
显华烟酒	023-85700852
徐世君	13068397666
名豪夜食	13668412022
工商所袁老师	13896200009
张乐平	13518471364
吴先均	13527369752,023-67006037
何宝堂	15549538898
石含斌	13330732550
翁丽媛	13364575885
孙红	15023857966
韩小姐	15324911948
田经理	18523537649
曾有光	15998906557
刘显儿	13996616444
刘平	18676920079
金带邮政	15923898118
夏红亮	15211003993
杨永红	15070283771
欧先生	13392871275
融康王经理	13637890001
谭兴勇	13430671808
李伟杰	18621573373,021-80211698
马小姐	023-81171600
王经理	13637890001
王姐	53222652
钟小姐	17782383337
游川	13680706961
张志彬	13543451136
送水谭师傅	18983530297
田晓霞	18983912919
郝德秀	18580425856
叶哲桥	15907237011
张进	18223270831
张银平	13949888565
谭老板	15320601219
谭二娃	18983530297
许经理	18983533017
田总	13388901999
胡二-杨总	18996674358
梁平-黄伟	18581358886
廖主任-职教中心	13996560068
刘海光-大同	13593019707
刘汉彬	13996594935
刘汉彬仓库	53233080
刘进	15084452727
口福居-刘老板	18523788627
刘老师	13996667605
快递-刘杨勇	15223564576
璐璐	15923846466
罗老师-双桂中学	13075493173
罗利银-贵州	13985159603
麻辣空间-罗莹	15084388833
绵阳-李红	17780961613
杨经理-名豪	15223769366
南充-方勇	13990898986
宁安文	15025558256
欧高全	13959809281
秦姐-食店	15923458366
卜媛	13806383743
王思元	13641797417
石万刚	18983533260
石校长	13668452789
孙小姐	18983531605
谭老师-文化镇	13452798449
桃林老-李总	13574046308
天厨调料	53224910
天厨方霞	13206253799
田伟	18996566331
向德刚	13908264775
黄超	13509432733
王彩虹	18983533459
王尔安	13452635613
王乾峰	15826314626
王维	15215282186
陈大海-巫山华艺	15084476969
杨永安-西安	18591781212
谢怀太	18689591666
新城-郑老板	18581420219
新城-彭老板	18723657268
新城-孙老板	15870529774
新福迪包装-刘	18723693330
吴经理-联谊超市	18323539627
李姐-梁平豆干	18183156337
安安鱼-冉总	13709451314
边朝东	15566334141
常盘-新华小学	13996597575
常盘-新华小学	18182268698
明达小学-常正峰	15923817128
陈良初	13594794998
陈松	13509412444
成都方老板	13350089519
成都余长荣	15528798880
重庆-林欢	18883274493
唐江毅	15523762181
重庆银行－陈行长	13883588185
周小华	13628355753
卢燕	18048739111
王晓莉	13198751251
盛世阳光KTV	13666101899
覃光茂	13982848693
吴忠海	13518251013
吴忠海	13092857959
达州KTV	18282225358
谭左才	13452612147
分水－侯老板	13996608535
冯妈老火锅	13594775456
国辉－黄总	13638269591
韩庄羊蹄	15826370299
河南－殷老板	13015528638
河南－李老板	13525707978
红阳超市	17784019422
胡鸭子	15826303760
湖北黄石－叶哲桥	15907237011
滑石寨－薛经理	18183161670
黄华全	13272548707
黄礼洪	18423361333
吉林－赵华连	13166811905
蒋邦武	18996630211
蒋丽英	13452078232
金泰－黄总	15922522277
锦和苑	18323768166
经信委－刘主任	18182331122
莱茵虎地板	15320618883
兰州会展－王海	13252978922
兰州－潘光分	13669363987
联谊超市－吴经理	18323539627
梁平豆干－李姐	18183156337
新世纪仓库-王燕	13594032080
许老师-明达小学	15023475480
杨永安	13609286966
宜宾-郑姐	13778969582
邮政汇款-周总	63887420
邮政销售-吴经理	13527369752
月中桂	53251178
张鸭子-方老师	15923852570
掌上明珠	13996646425
赵红食品	15696526796
忠县-刘增宪	13038376057
忠县-赵万江	13896939570
忠县-申华林	15215227237
忠县-万灵金	13038368102
忠县-王世勇	15826458112
忠县-熊德明	13228580728
忠县-周海涛	15320728003
忠县-周虹	18290584405
周科贤	18996692037
胡泽金	13700959605
荣虎源 	13985242135
新世纪搬运-王师傅	13983231124
新世纪采购-张磊	13637906561
新世纪仓库－王燕	13594032080
明达小学－许老师	15023475480
杨永安	13609286966
宜宾－郑姐	13778969582
邮政汇款－周总	63887420
邮政销售－吴经理	13527369752
月中桂	53251178
张鸭子－方老师	15923852570
掌上明珠	13996646425
赵红食品	15696526796
忠县－刘增宪	13038376057
忠县－赵万江	13896939570
忠县－申华林	15215227237
忠县－万灵金	13038368102
忠县－王世勇	15826458112
忠县－熊德明	13228580728
忠县－周海涛	15320728003
忠县－周虹	18290584405
周科贤	18996692037
胡泽金	13700959605
荣虎源	13985242135
新世纪搬运－王师傅	13983231124
新世纪采购－张磊	13637906561
泓源泰商贸－杨总	15348262833
吴忠海门市	0818-2389798
胡二－杨总	18996674358
职教中心－廖主任	13996560068
大同－刘海光	13593019707
刘汉彬	13996594935
刘汉彬仓库	53233080
刘进	15084452727
刘老师	13996667605
璐璐	15923846466
双桂中学－罗老师	13075493173
贵州－罗利银	13985159603
麻辣空间－罗莹	15084388833
绵阳－李红	17780961613
名豪－杨经理	15223769366
南充－方勇	13990898986
宁安文	15025558256
欧高全	13959809281
食店－秦姐	15923458366
卜媛	13806383743
王思元	13641797417
石万刚	18983533260
石校长	13668452789
孙小姐	18983531605
文化镇－谭老师	13452798449
天厨调料	53224910
天厨方霞	13206253799
田伟	18996566331
向德刚	13908264775
黄超	13509432733
王彩虹	18983533459
王尔安	13452635613
王乾峰	15826314626
王维	15215282186
巫山华艺－陈大海	15084476969
一品土菜李总	13908263219
西安－杨永安	18591781212
谢怀太	18689591666
新城－郑老板	18581420219
新城－彭老板	18723657268
新城－孙老板	15870529774
\.


--
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY department (code, full_code, is_leaf, level, name, parent_code) FROM stdin;
5001	500100000000	t	2	重庆市沙坪坝	50
50	500000000000	f	1	重庆市	\N
10	100000000000	f	1	北京市	\N
2012	201200000000	t	2	上海浦东	20
20	200000000000	f	1	上海市	\N
1020	102000000000	f	2	北京天安门	10
201312	201312000000	f	3	啊	1020
2013456	201345600000	f	3	安慰	201312
502564	502564000000	t	3	123	502456
502456	502456000000	f	3	posse	2013456
\.


--
-- Data for Name: log; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY log (id, key, body, remote_ip, request_time, created_on) FROM stdin;
40281	test	test	192.168.3.132	2017-08-14 00:00:00	2017-08-14 00:00:00
40305	test	test	192.168.3.132	2017-08-14 00:00:00	2017-08-14 00:00:00
40330	chain-1502702037658	{"#ChainStep#":{"[1]startLocalChain(name)":16,"[2]@ChainUpdate proceed":110,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":132,"[8]lockHolder.extendLockForValidation()":0,"[9]remoteValidation()":318,"[10]handleException()":0,"[11]ready execute localUpdate":0,"[12]localUpdate()":3,"[13]startParallelExecution()":0,"[14]remoteUpdate Process()":16,"[15]afterCommit() for update":7},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":3,"beanId":null,"count":1,"times":[3]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":93,"beanId":null,"count":1,"times":[93]}},"#Other#":{"[16][TOTAL]":695}}	192.168.3.132	2017-08-14 00:00:00	2017-08-14 00:00:00
40331	chain-1502702039370	{"#ChainStep#":{"[1]startLocalChain(name)":1,"[2]@ChainUpdate proceed":61,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":5,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":1},"#Other#":{"[14][TOTAL]":69}}	192.168.3.132	2017-08-14 00:00:00	2017-08-14 00:00:00
40332	chain-1502702943444	{"#ChainStep#":{"[1]startLocalChain(name)":12,"[2]@ChainUpdate proceed":94,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":135,"[8]lockHolder.extendLockForValidation()":0,"[9]remoteValidation()":379,"[10]handleException()":0,"[11]ready execute localUpdate":0,"[12]localUpdate()":3,"[13]startParallelExecution()":0,"[14]remoteUpdate Process()":28,"[15]afterCommit() for update":4},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":2,"beanId":null,"count":1,"times":[2]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":99,"beanId":null,"count":1,"times":[99]}},"#Other#":{"[16][TOTAL]":740}}	192.168.3.132	2017-08-14 17:29:04.435	2017-08-14 17:29:04.531
40333	chain-1502702945090	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":54,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":2,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":1},"#Other#":{"[14][TOTAL]":58}}	192.168.3.132	2017-08-14 17:29:05.189	2017-08-14 17:29:05.345
40334	chain-1502703057426	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":27,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":63,"[8]lockHolder.extendLockForValidation()":0,"[9]remoteValidation()":122,"[10]handleException()":0,"[11]ready execute localUpdate":0,"[12]localUpdate()":2,"[13]startParallelExecution()":0,"[14]remoteUpdate Process()":4,"[15]afterCommit() for update":5},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":60,"beanId":null,"count":1,"times":[60]}},"#Other#":{"[16][TOTAL]":239}}	192.168.3.132	2017-08-14 17:30:57.7	2017-08-14 17:30:57.851
40355	chain-1502703057963	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":72,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":1,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":74}}	192.168.3.132	2017-08-14 17:30:58.08	2017-08-14 17:30:58.098
40356	chain-1502703069192	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":26,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":10059,"[8]lockHolder.extendLockForValidation()":0,"[9]remoteValidation()":56208,"[10]handleException()":0,"[11]ready execute localUpdate":0,"[12]localUpdate()":2,"[13]startParallelExecution()":0,"[14]remoteUpdate Process()":4,"[15]afterCommit() for update":2},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":5255,"beanId":null,"count":1,"times":[5255]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":2926,"beanId":null,"count":1,"times":[2926]}},"#Other#":{"[16][TOTAL]":66329}}	192.168.3.132	2017-08-14 17:32:15.559	2017-08-14 17:32:15.584
40357	chain-1502703988548	{"#ChainStep#":{"[1]startLocalChain(name)":14,"[2]@ChainUpdate proceed":127,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":2249,"[8]lockHolder.extendLockForValidation()":0,"[9]remoteValidation()":350,"[10]handleException()":0,"[11]ready execute localUpdate":1,"[12]localUpdate()":3,"[13]startParallelExecution()":0,"[14]remoteUpdate Process()":16,"[15]afterCommit() for update":11},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":899,"beanId":null,"count":1,"times":[899]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":1340,"beanId":null,"count":1,"times":[1340]}},"#Other#":{"[16][TOTAL]":2963}}	192.168.3.132	2017-08-14 17:46:31.8	2017-08-14 17:46:31.882
40358	chain-1502703992756	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":41,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":1,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":2},"#Other#":{"[14][TOTAL]":44}}	192.168.3.132	2017-08-14 17:46:32.837	2017-08-14 17:46:32.976
40359	chain-1502704004925	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":26,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":58,"[8]lockHolder.extendLockForValidation()":0,"[9]remoteValidation()":109,"[10]handleException()":0,"[11]ready execute localUpdate":0,"[12]localUpdate()":0,"[13]startParallelExecution()":0,"[14]remoteUpdate Process()":8,"[15]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":58,"beanId":null,"count":1,"times":[58]}},"#Other#":{"[16][TOTAL]":215}}	192.168.3.132	2017-08-14 17:46:45.175	2017-08-14 17:46:45.205
40380	chain-1502704005351	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":67,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":1,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":6},"#Other#":{"[14][TOTAL]":94}}	192.168.3.132	2017-08-14 17:46:45.477	2017-08-14 17:46:45.631
41431	chain-1502706621878	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:21.89	2017-08-14 18:30:21.979
40381	chain-1502704046376	{"#ChainStep#":{"[1]startLocalChain(name)":1,"[2]@ChainUpdate proceed":42,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":8933,"[8]lockHolder.extendLockForValidation()":0,"[9]remoteValidation()":41289,"[10]handleException()":0,"[11]ready execute localUpdate":1,"[12]localUpdate()":0,"[13]startParallelExecution()":0,"[14]remoteUpdate Process()":9,"[15]afterCommit() for update":1},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":7420,"beanId":null,"count":1,"times":[7420]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":1510,"beanId":null,"count":1,"times":[1510]}},"#Other#":{"[16][TOTAL]":54149}}	192.168.3.132	2017-08-14 17:49:01.973	2017-08-14 17:49:02.148
40382	chain-1502706345669	{"#ChainStep#":{"[1]startLocalChain(name)":9,"[2]@ChainUpdate proceed":96,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":105,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":324,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":3,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":28,"[19]afterCommit() for update":4},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":2,"beanId":null,"count":1,"times":[2]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":93,"beanId":null,"count":1,"times":[93]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":26,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[26]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":201,"beanId":null,"count":1,"times":[201]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":662}}	192.168.3.132	2017-08-14 18:25:46.606	2017-08-14 18:25:46.714
40383	chain-1502706347439	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":42,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":1,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":2},"#Other#":{"[14][TOTAL]":47}}	192.168.3.132	2017-08-14 18:25:47.499	2017-08-14 18:25:47.63
40384	chain-1502706606444	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":58,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":199,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":488,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":99,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":1,"beanId":null,"count":1,"times":[1]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":125,"beanId":null,"count":1,"times":[125]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":59,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[59]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":217,"beanId":null,"count":1,"times":[217]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":1,"beanId":null,"count":1,"times":[1]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":886}}	192.168.3.132	2017-08-14 18:30:07.354	2017-08-14 18:30:07.445
40405	chain-1502706606557	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":215,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":110,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":687,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":4,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":16,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":79,"beanId":null,"count":1,"times":[79]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":15,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[15]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":386,"beanId":null,"count":1,"times":[386]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1091}}	192.168.3.132	2017-08-14 18:30:07.66	2017-08-14 18:30:08.061
40406	chain-1502706606435	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":39,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":333,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":813,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":328,"beanId":null,"count":1,"times":[328]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":21,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[21]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":477,"beanId":null,"count":1,"times":[477]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1255}}	192.168.3.132	2017-08-14 18:30:07.727	2017-08-14 18:30:08.095
40407	chain-1502706606816	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":258,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":62,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":617,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":1},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":60,"beanId":null,"count":1,"times":[60]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":13,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[13]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":253,"beanId":null,"count":1,"times":[253]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1009}}	192.168.3.132	2017-08-14 18:30:07.863	2017-08-14 18:30:08.095
40408	chain-1502706606673	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":197,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":121,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":684,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":1,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":4,"[19]afterCommit() for update":15},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":120,"beanId":null,"count":1,"times":[120]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":56,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[56]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":261,"beanId":null,"count":1,"times":[261]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1168}}	192.168.3.132	2017-08-14 18:30:07.92	2017-08-14 18:30:08.095
40409	chain-1502706606613	{"#ChainStep#":{"[1]startLocalChain(name)":1,"[2]@ChainUpdate proceed":270,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":126,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":761,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":126,"beanId":null,"count":1,"times":[126]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":62,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[62]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":359,"beanId":null,"count":1,"times":[359]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1308}}	192.168.3.132	2017-08-14 18:30:07.927	2017-08-14 18:30:08.156
40430	chain-1502706606677	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":196,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":128,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":705,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":1,"beanId":null,"count":1,"times":[1]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":103,"beanId":null,"count":1,"times":[103]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":56,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[56]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":373,"beanId":null,"count":1,"times":[373]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1160}}	192.168.3.132	2017-08-14 18:30:07.923	2017-08-14 18:30:08.156
40431	chain-1502706606608	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":293,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":126,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":642,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":77,"beanId":null,"count":1,"times":[77]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":30,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[30]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":372,"beanId":null,"count":1,"times":[372]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1308}}	192.168.3.132	2017-08-14 18:30:07.946	2017-08-14 18:30:08.186
40432	chain-1502706606676	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":204,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":248,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":719,"[14]handleException()":0,"[15]ready execute localUpdate":1,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":1},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":201,"beanId":null,"count":1,"times":[201]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":67,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[67]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":256,"beanId":null,"count":1,"times":[256]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1276}}	192.168.3.132	2017-08-14 18:30:07.951	2017-08-14 18:30:08.186
40433	chain-1502706606563	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":206,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":142,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":1005,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":1},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":103,"beanId":null,"count":1,"times":[103]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":27,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[27]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":364,"beanId":null,"count":1,"times":[364]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1399}}	192.168.3.132	2017-08-14 18:30:07.964	2017-08-14 18:30:08.436
41432	chain-1502706622073	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:22.085	2017-08-14 18:30:22.196
40434	chain-1502706606737	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":135,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":81,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":724,"[14]handleException()":0,"[15]ready execute localUpdate":6,"[16]localUpdate()":2,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":76,"beanId":null,"count":1,"times":[76]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":24,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[24]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":369,"beanId":null,"count":1,"times":[369]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1162}}	192.168.3.132	2017-08-14 18:30:07.964	2017-08-14 18:30:08.436
40455	chain-1502706606615	{"#ChainStep#":{"[1]startLocalChain(name)":1,"[2]@ChainUpdate proceed":272,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":154,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":861,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":147,"beanId":null,"count":1,"times":[147]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":54,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[54]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":278,"beanId":null,"count":1,"times":[278]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1443}}	192.168.3.132	2017-08-14 18:30:08.06	2017-08-14 18:30:08.665
40456	chain-1502706606665	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":192,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":146,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":864,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":140,"beanId":null,"count":1,"times":[140]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":53,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[53]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":284,"beanId":null,"count":1,"times":[284]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1394}}	192.168.3.132	2017-08-14 18:30:08.064	2017-08-14 18:30:08.666
40457	chain-1502706606680	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":208,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":185,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":836,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":183,"beanId":null,"count":1,"times":[183]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":100,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[100]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":402,"beanId":null,"count":1,"times":[402]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":1,"beanId":null,"count":1,"times":[1]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1421}}	192.168.3.132	2017-08-14 18:30:08.1	2017-08-14 18:30:08.666
40458	chain-1502706606709	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":178,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":149,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":836,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":4,"[19]afterCommit() for update":1},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":108,"beanId":null,"count":1,"times":[108]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":57,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[57]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":275,"beanId":null,"count":1,"times":[275]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1389}}	192.168.3.132	2017-08-14 18:30:08.096	2017-08-14 18:30:08.667
40459	chain-1502706606729	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":145,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":128,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":794,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":78,"beanId":null,"count":1,"times":[78]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":38,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[38]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":428,"beanId":null,"count":1,"times":[428]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1392}}	192.168.3.132	2017-08-14 18:30:08.128	2017-08-14 18:30:08.667
41433	chain-1502706622285	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":15,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":15}}	192.168.3.132	2017-08-14 18:30:22.298	2017-08-14 18:30:22.412
40480	chain-1502706606611	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":261,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":163,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":921,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":1},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":156,"beanId":null,"count":1,"times":[156]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":98,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[98]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":425,"beanId":null,"count":1,"times":[425]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1533}}	192.168.3.132	2017-08-14 18:30:08.143	2017-08-14 18:30:08.667
40481	chain-1502706608031	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":168,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":1,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":1},"#Other#":{"[14][TOTAL]":173}}	192.168.3.132	2017-08-14 18:30:08.204	2017-08-14 18:30:08.667
40482	chain-1502706606729	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":145,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":128,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":794,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":78,"beanId":null,"count":1,"times":[78]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":38,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[38]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":428,"beanId":null,"count":1,"times":[428]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1392}}	192.168.3.132	2017-08-14 18:30:08.127	2017-08-14 18:30:08.667
40483	chain-1502706606729	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":145,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":128,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":794,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":78,"beanId":null,"count":1,"times":[78]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":38,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[38]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":428,"beanId":null,"count":1,"times":[428]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1392}}	192.168.3.132	2017-08-14 18:30:08.127	2017-08-14 18:30:08.667
40484	chain-1502706606722	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":249,"[3]navigateTillExhausted()":1,"[4]checkChainValid()":0,"[7]localValidation()":153,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":973,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":2,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":151,"beanId":null,"count":1,"times":[151]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":108,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[108]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":523,"beanId":null,"count":1,"times":[523]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1461}}	192.168.3.132	2017-08-14 18:30:08.181	2017-08-14 18:30:08.668
40505	chain-1502706607497	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":187,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":69,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":608,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":3,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":68,"beanId":null,"count":1,"times":[68]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":22,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[22]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":277,"beanId":null,"count":1,"times":[277]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1258}}	192.168.3.132	2017-08-14 18:30:08.754	2017-08-14 18:30:08.886
40506	chain-1502706608083	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":99,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":140,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":516,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":1,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":138,"beanId":null,"count":1,"times":[138]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":33,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[33]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":310,"beanId":null,"count":1,"times":[310]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":830}}	192.168.3.132	2017-08-14 18:30:08.912	2017-08-14 18:30:09.103
40507	chain-1502706607846	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":284,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":101,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":713,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":1,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":85,"beanId":null,"count":1,"times":[85]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":151,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[151]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":165,"beanId":null,"count":1,"times":[165]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1146}}	192.168.3.132	2017-08-14 18:30:08.991	2017-08-14 18:30:09.103
40508	chain-1502706607966	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":124,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":93,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":752,"[14]handleException()":0,"[15]ready execute localUpdate":1,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":93,"beanId":null,"count":1,"times":[93]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":136,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[136]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":316,"beanId":null,"count":1,"times":[316]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1051}}	192.168.3.132	2017-08-14 18:30:09.029	2017-08-14 18:30:09.103
40509	chain-1502706608115	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":177,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":55,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":505,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":14,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":53,"beanId":null,"count":1,"times":[53]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":17,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[17]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":246,"beanId":null,"count":1,"times":[246]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":926}}	192.168.3.132	2017-08-14 18:30:09.06	2017-08-14 18:30:09.137
40530	chain-1502706607807	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":359,"[3]navigateTillExhausted()":1,"[4]checkChainValid()":0,"[7]localValidation()":236,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":545,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":17,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":200,"beanId":null,"count":1,"times":[200]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":41,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[41]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":223,"beanId":null,"count":1,"times":[223]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":2,"beanId":null,"count":1,"times":[2]}},"#Other#":{"[20][TOTAL]":1244}}	192.168.3.132	2017-08-14 18:30:09.05	2017-08-14 18:30:09.137
40531	chain-1502706608143	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":150,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":46,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":731,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":1},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":45,"beanId":null,"count":1,"times":[45]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":19,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[19]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":338,"beanId":null,"count":1,"times":[338]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1117}}	192.168.3.132	2017-08-14 18:30:09.259	2017-08-14 18:30:09.37
40532	chain-1502706608262	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":170,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":118,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":590,"[14]handleException()":0,"[15]ready execute localUpdate":2,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":95,"beanId":null,"count":1,"times":[95]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":37,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[37]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":194,"beanId":null,"count":1,"times":[194]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1002}}	192.168.3.132	2017-08-14 18:30:09.271	2017-08-14 18:30:09.37
41434	chain-1502706622480	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:22.491	2017-08-14 18:30:22.667
40533	chain-1502706608389	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":134,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":87,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":571,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":7,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":87,"beanId":null,"count":1,"times":[87]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":64,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[64]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":167,"beanId":null,"count":1,"times":[167]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":873}}	192.168.3.132	2017-08-14 18:30:09.283	2017-08-14 18:30:09.37
40534	chain-1502706608374	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":90,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":66,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":745,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":65,"beanId":null,"count":1,"times":[65]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":12,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[12]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":360,"beanId":null,"count":1,"times":[360]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":968}}	192.168.3.132	2017-08-14 18:30:09.341	2017-08-14 18:30:09.643
40555	chain-1502706608148	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":119,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":203,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":688,"[14]handleException()":0,"[15]ready execute localUpdate":1,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":20,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":198,"beanId":null,"count":1,"times":[198]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":16,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[16]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":262,"beanId":null,"count":1,"times":[262]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1165}}	192.168.3.132	2017-08-14 18:30:09.314	2017-08-14 18:30:09.643
40556	chain-1502706608468	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":159,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":78,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":653,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":16,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":63,"beanId":null,"count":1,"times":[63]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":42,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[42]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":87,"beanId":null,"count":1,"times":[87]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":980}}	192.168.3.132	2017-08-14 18:30:09.474	2017-08-14 18:30:09.644
40557	chain-1502706608487	{"#ChainStep#":{"[1]startLocalChain(name)":1,"[2]@ChainUpdate proceed":94,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":93,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":656,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":93,"beanId":null,"count":1,"times":[93]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":74,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[74]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":207,"beanId":null,"count":1,"times":[207]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1024}}	192.168.3.132	2017-08-14 18:30:09.513	2017-08-14 18:30:09.644
40558	chain-1502706608445	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":102,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":166,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":624,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":2},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":155,"beanId":null,"count":1,"times":[155]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":33,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[33]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":205,"beanId":null,"count":1,"times":[205]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1005}}	192.168.3.132	2017-08-14 18:30:09.499	2017-08-14 18:30:09.644
41455	chain-1502706622792	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":18,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":18}}	192.168.3.132	2017-08-14 18:30:22.808	2017-08-14 18:30:22.937
40559	chain-1502706608286	{"#ChainStep#":{"[1]startLocalChain(name)":1,"[2]@ChainUpdate proceed":144,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":111,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":793,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":3,"beanId":null,"count":1,"times":[3]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":106,"beanId":null,"count":1,"times":[106]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":73,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[73]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":341,"beanId":null,"count":1,"times":[341]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1216}}	192.168.3.132	2017-08-14 18:30:09.518	2017-08-14 18:30:09.644
40580	chain-1502706608400	{"#ChainStep#":{"[1]startLocalChain(name)":1,"[2]@ChainUpdate proceed":178,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":57,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":821,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":56,"beanId":null,"count":1,"times":[56]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":123,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[123]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":225,"beanId":null,"count":1,"times":[225]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1138}}	192.168.3.132	2017-08-14 18:30:09.546	2017-08-14 18:30:09.645
40581	chain-1502706608478	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":241,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":40,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":583,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":38,"beanId":null,"count":1,"times":[38]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":28,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[28]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":389,"beanId":null,"count":1,"times":[389]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1103}}	192.168.3.132	2017-08-14 18:30:09.58	2017-08-14 18:30:09.887
40582	chain-1502706608259	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":165,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":106,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":744,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":93,"beanId":null,"count":1,"times":[93]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":38,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[38]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":264,"beanId":null,"count":1,"times":[264]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":1,"beanId":null,"count":1,"times":[1]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1551}}	192.168.3.132	2017-08-14 18:30:09.821	2017-08-14 18:30:09.887
40583	chain-1502706609054	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":178,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":99,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":378,"[14]handleException()":0,"[15]ready execute localUpdate":1,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":98,"beanId":null,"count":1,"times":[98]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":34,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[34]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":136,"beanId":null,"count":1,"times":[136]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":861}}	192.168.3.132	2017-08-14 18:30:09.914	2017-08-14 18:30:10.103
40584	chain-1502706608818	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":141,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":407,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":535,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":402,"beanId":null,"count":1,"times":[402]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":59,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[59]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":183,"beanId":null,"count":1,"times":[183]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1115}}	192.168.3.132	2017-08-14 18:30:09.937	2017-08-14 18:30:10.103
41456	chain-1502706623024	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":23,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":23}}	192.168.3.132	2017-08-14 18:30:23.047	2017-08-14 18:30:23.154
40605	chain-1502706609227	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":106,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":107,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":445,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":1,"beanId":null,"count":1,"times":[1]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":105,"beanId":null,"count":1,"times":[105]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":47,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[47]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":104,"beanId":null,"count":1,"times":[104]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":759}}	192.168.3.132	2017-08-14 18:30:09.984	2017-08-14 18:30:10.2
40606	chain-1502706609226	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":159,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":83,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":389,"[14]handleException()":0,"[15]ready execute localUpdate":1,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":81,"beanId":null,"count":1,"times":[81]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":20,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[20]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":187,"beanId":null,"count":1,"times":[187]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":769}}	192.168.3.132	2017-08-14 18:30:09.994	2017-08-14 18:30:10.201
40607	chain-1502706609588	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":50,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":90,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":418,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":90,"beanId":null,"count":1,"times":[90]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":19,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[19]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":151,"beanId":null,"count":1,"times":[151]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":622}}	192.168.3.132	2017-08-14 18:30:10.21	2017-08-14 18:30:10.479
40608	chain-1502706609543	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":96,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":71,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":499,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":71,"beanId":null,"count":1,"times":[71]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":34,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[34]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":152,"beanId":null,"count":1,"times":[152]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":774}}	192.168.3.132	2017-08-14 18:30:10.319	2017-08-14 18:30:10.479
40609	chain-1502706609259	{"#ChainStep#":{"[1]startLocalChain(name)":1,"[2]@ChainUpdate proceed":188,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":55,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":640,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":1,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":1},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":55,"beanId":null,"count":1,"times":[55]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":54,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[54]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":251,"beanId":null,"count":1,"times":[251]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1034}}	192.168.3.132	2017-08-14 18:30:10.296	2017-08-14 18:30:10.479
40630	chain-1502706610331	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":26,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":26}}	192.168.3.132	2017-08-14 18:30:10.355	2017-08-14 18:30:10.52
40631	chain-1502706609055	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":460,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":157,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":592,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":154,"beanId":null,"count":1,"times":[154]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":96,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[96]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":124,"beanId":null,"count":1,"times":[124]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1322}}	192.168.3.132	2017-08-14 18:30:10.375	2017-08-14 18:30:10.521
40632	chain-1502706609508	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":141,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":78,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":575,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":78,"beanId":null,"count":1,"times":[78]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":51,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[51]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":301,"beanId":null,"count":1,"times":[301]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":1,"beanId":null,"count":1,"times":[1]}},"#Other#":{"[20][TOTAL]":908}}	192.168.3.132	2017-08-14 18:30:10.426	2017-08-14 18:30:10.775
40633	chain-1502706609541	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":88,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":143,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":671,"[14]handleException()":0,"[15]ready execute localUpdate":1,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":95,"beanId":null,"count":1,"times":[95]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":27,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[27]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":333,"beanId":null,"count":1,"times":[333]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":969}}	192.168.3.132	2017-08-14 18:30:10.509	2017-08-14 18:30:10.775
40634	chain-1502706609543	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":89,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":110,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":682,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":96,"beanId":null,"count":1,"times":[96]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":53,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[53]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":276,"beanId":null,"count":1,"times":[276]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":973}}	192.168.3.132	2017-08-14 18:30:10.525	2017-08-14 18:30:10.775
40655	chain-1502706609590	{"#ChainStep#":{"[1]startLocalChain(name)":1,"[2]@ChainUpdate proceed":90,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":71,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":687,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":71,"beanId":null,"count":1,"times":[71]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":14,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[14]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":316,"beanId":null,"count":1,"times":[316]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":958}}	192.168.3.132	2017-08-14 18:30:10.551	2017-08-14 18:30:10.775
40656	chain-1502706609702	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":109,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":87,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":538,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":86,"beanId":null,"count":1,"times":[86]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":140,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[140]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":138,"beanId":null,"count":1,"times":[138]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":871}}	192.168.3.132	2017-08-14 18:30:10.572	2017-08-14 18:30:10.776
40657	chain-1502706609703	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":56,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":36,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":627,"[14]handleException()":0,"[15]ready execute localUpdate":2,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":35,"beanId":null,"count":1,"times":[35]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":34,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[34]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":275,"beanId":null,"count":1,"times":[275]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":865}}	192.168.3.132	2017-08-14 18:30:10.567	2017-08-14 18:30:10.776
41457	chain-1502706623345	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":22,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":22}}	192.168.3.132	2017-08-14 18:30:23.365	2017-08-14 18:30:23.571
40658	chain-1502706609754	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":186,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":62,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":418,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":61,"beanId":null,"count":1,"times":[61]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":11,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[11]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":134,"beanId":null,"count":1,"times":[134]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":904}}	192.168.3.132	2017-08-14 18:30:10.659	2017-08-14 18:30:11.012
40659	chain-1502706609648	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":120,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":108,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":568,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":107,"beanId":null,"count":1,"times":[107]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":120,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[120]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":129,"beanId":null,"count":1,"times":[129]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":1,"beanId":null,"count":1,"times":[1]}},"#Other#":{"[20][TOTAL]":948}}	192.168.3.132	2017-08-14 18:30:10.6	2017-08-14 18:30:11.012
40680	chain-1502706609680	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":208,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":205,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":585,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":5,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":204,"beanId":null,"count":1,"times":[204]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":63,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[63]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":232,"beanId":null,"count":1,"times":[232]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1070}}	192.168.3.132	2017-08-14 18:30:10.771	2017-08-14 18:30:11.012
40681	chain-1502706609956	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":239,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":57,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":391,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":55,"beanId":null,"count":1,"times":[55]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":9,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[9]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":205,"beanId":null,"count":1,"times":[205]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":759}}	192.168.3.132	2017-08-14 18:30:10.731	2017-08-14 18:30:11.013
40682	chain-1502706610157	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":67,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":164,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":501,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":1,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":1},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":163,"beanId":null,"count":1,"times":[163]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":19,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[19]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":221,"beanId":null,"count":1,"times":[221]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":2,"beanId":null,"count":1,"times":[2]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":896}}	192.168.3.132	2017-08-14 18:30:11.051	2017-08-14 18:30:11.095
40683	chain-1502706610158	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":76,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":162,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":594,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":161,"beanId":null,"count":1,"times":[161]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":26,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[26]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":198,"beanId":null,"count":1,"times":[198]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":918}}	192.168.3.132	2017-08-14 18:30:11.08	2017-08-14 18:30:11.328
41458	chain-1502706623591	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":15,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":15}}	192.168.3.132	2017-08-14 18:30:23.604	2017-08-14 18:30:23.612
40684	chain-1502706610147	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":184,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":92,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":562,"[14]handleException()":0,"[15]ready execute localUpdate":8,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":92,"beanId":null,"count":1,"times":[92]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":26,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[26]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":303,"beanId":null,"count":1,"times":[303]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1116}}	192.168.3.132	2017-08-14 18:30:11.262	2017-08-14 18:30:11.328
40705	chain-1502706610653	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":56,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":157,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":374,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":1,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":8,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":155,"beanId":null,"count":1,"times":[155]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":18,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[18]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":208,"beanId":null,"count":1,"times":[208]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":666}}	192.168.3.132	2017-08-14 18:30:11.319	2017-08-14 18:30:11.377
40706	chain-1502706610503	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":121,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":99,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":478,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":98,"beanId":null,"count":1,"times":[98]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":8,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[8]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":139,"beanId":null,"count":1,"times":[139]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":778}}	192.168.3.132	2017-08-14 18:30:11.281	2017-08-14 18:30:11.378
40707	chain-1502706610440	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":120,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":47,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":611,"[14]handleException()":0,"[15]ready execute localUpdate":1,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":1},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":46,"beanId":null,"count":1,"times":[46]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":49,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[49]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":231,"beanId":null,"count":1,"times":[231]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":891}}	192.168.3.132	2017-08-14 18:30:11.332	2017-08-14 18:30:11.603
40708	chain-1502706610448	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":207,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":96,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":562,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":95,"beanId":null,"count":1,"times":[95]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":131,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[131]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":167,"beanId":null,"count":1,"times":[167]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":934}}	192.168.3.132	2017-08-14 18:30:11.382	2017-08-14 18:30:11.604
40709	chain-1502706610267	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":285,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":82,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":558,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":23,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":82,"beanId":null,"count":1,"times":[82]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":127,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[127]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":167,"beanId":null,"count":1,"times":[167]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1118}}	192.168.3.132	2017-08-14 18:30:11.383	2017-08-14 18:30:11.604
41459	chain-1502706623800	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:23.811	2017-08-14 18:30:23.846
40730	chain-1502706610144	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":185,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":192,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":720,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":1,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":192,"beanId":null,"count":1,"times":[192]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":13,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[13]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":302,"beanId":null,"count":1,"times":[302]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1313}}	192.168.3.132	2017-08-14 18:30:11.456	2017-08-14 18:30:11.604
40731	chain-1502706610508	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":145,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":91,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":560,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":89,"beanId":null,"count":1,"times":[89]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":113,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[113]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":183,"beanId":null,"count":1,"times":[183]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":972}}	192.168.3.132	2017-08-14 18:30:11.479	2017-08-14 18:30:11.605
40732	chain-1502706610603	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":146,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":103,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":451,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":1},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":101,"beanId":null,"count":1,"times":[101]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":19,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[19]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":99,"beanId":null,"count":1,"times":[99]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":871}}	192.168.3.132	2017-08-14 18:30:11.473	2017-08-14 18:30:11.605
40733	chain-1502706610779	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":160,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":94,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":493,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":93,"beanId":null,"count":1,"times":[93]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":19,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[19]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":53,"beanId":null,"count":1,"times":[53]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":879}}	192.168.3.132	2017-08-14 18:30:11.662	2017-08-14 18:30:11.82
40734	chain-1502706610918	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":74,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":96,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":603,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":1},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":95,"beanId":null,"count":1,"times":[95]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":7,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[7]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":180,"beanId":null,"count":1,"times":[180]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":834}}	192.168.3.132	2017-08-14 18:30:11.76	2017-08-14 18:30:11.82
40755	chain-1502706610900	{"#ChainStep#":{"[1]startLocalChain(name)":1,"[2]@ChainUpdate proceed":112,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":53,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":649,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":51,"beanId":null,"count":1,"times":[51]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":15,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[15]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":183,"beanId":null,"count":1,"times":[183]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":877}}	192.168.3.132	2017-08-14 18:30:11.788	2017-08-14 18:30:12.045
41480	chain-1502706623984	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":1},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:23.999	2017-08-14 18:30:24.089
40756	chain-1502706610921	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":143,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":36,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":533,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":36,"beanId":null,"count":1,"times":[36]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":47,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[47]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":152,"beanId":null,"count":1,"times":[152]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":851}}	192.168.3.132	2017-08-14 18:30:11.77	2017-08-14 18:30:12.045
40757	chain-1502706610405	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":237,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":218,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":304,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":1,"beanId":null,"count":1,"times":[1]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":209,"beanId":null,"count":1,"times":[209]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":8,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[8]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":96,"beanId":null,"count":1,"times":[96]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1459}}	192.168.3.132	2017-08-14 18:30:11.864	2017-08-14 18:30:12.046
40758	chain-1502706610776	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":221,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":91,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":653,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":3,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":1,"beanId":null,"count":1,"times":[1]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":90,"beanId":null,"count":1,"times":[90]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":32,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[32]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":240,"beanId":null,"count":1,"times":[240]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1049}}	192.168.3.132	2017-08-14 18:30:11.824	2017-08-14 18:30:12.046
40759	chain-1502706610919	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":134,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":93,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":657,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":92,"beanId":null,"count":1,"times":[92]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":35,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[35]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":237,"beanId":null,"count":1,"times":[237]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":979}}	192.168.3.132	2017-08-14 18:30:11.905	2017-08-14 18:30:12.046
40780	chain-1502706610917	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":78,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":83,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":624,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":81,"beanId":null,"count":1,"times":[81]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":13,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[13]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":466,"beanId":null,"count":1,"times":[466]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":958}}	192.168.3.132	2017-08-14 18:30:11.88	2017-08-14 18:30:12.046
40781	chain-1502706610919	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":134,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":93,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":657,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":92,"beanId":null,"count":1,"times":[92]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":35,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[35]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":237,"beanId":null,"count":1,"times":[237]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":979}}	192.168.3.132	2017-08-14 18:30:11.905	2017-08-14 18:30:12.047
41481	chain-1502706624214	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":16,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":16}}	192.168.3.132	2017-08-14 18:30:24.228	2017-08-14 18:30:24.321
40782	chain-1502706611190	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":131,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":115,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":539,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":8,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":114,"beanId":null,"count":1,"times":[114]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":162,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[162]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":151,"beanId":null,"count":1,"times":[151]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":1,"beanId":null,"count":1,"times":[1]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":879}}	192.168.3.132	2017-08-14 18:30:12.069	2017-08-14 18:30:12.261
40783	chain-1502706611138	{"#ChainStep#":{"[1]startLocalChain(name)":1,"[2]@ChainUpdate proceed":280,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":222,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":394,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":6,"[19]afterCommit() for update":14},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":221,"beanId":null,"count":1,"times":[221]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":19,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[19]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":195,"beanId":null,"count":1,"times":[195]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":977}}	192.168.3.132	2017-08-14 18:30:12.157	2017-08-14 18:30:12.262
40784	chain-1502706611677	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":132,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":101,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":231,"[14]handleException()":18,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":100,"beanId":null,"count":1,"times":[100]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":33,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[33]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":53,"beanId":null,"count":1,"times":[53]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":553}}	192.168.3.132	2017-08-14 18:30:12.23	2017-08-14 18:30:12.262
40805	chain-1502706611433	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":257,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":165,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":435,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":1,"beanId":null,"count":1,"times":[1]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":163,"beanId":null,"count":1,"times":[163]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":41,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[41]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":114,"beanId":null,"count":1,"times":[114]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":968}}	192.168.3.132	2017-08-14 18:30:12.399	2017-08-14 18:30:12.487
40806	chain-1502706611634	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":177,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":89,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":461,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":89,"beanId":null,"count":1,"times":[89]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":24,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[24]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":127,"beanId":null,"count":1,"times":[127]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":811}}	192.168.3.132	2017-08-14 18:30:12.445	2017-08-14 18:30:12.725
40807	chain-1502706611635	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":152,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":78,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":421,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":3},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":77,"beanId":null,"count":1,"times":[77]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":8,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[8]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":124,"beanId":null,"count":1,"times":[124]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":783}}	192.168.3.132	2017-08-14 18:30:12.417	2017-08-14 18:30:12.725
41482	chain-1502706624424	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:24.435	2017-08-14 18:30:24.554
40808	chain-1502706611636	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":188,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":69,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":477,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":65,"beanId":null,"count":1,"times":[65]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":11,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[11]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":120,"beanId":null,"count":1,"times":[120]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":900}}	192.168.3.132	2017-08-14 18:30:12.556	2017-08-14 18:30:12.725
40809	chain-1502706611876	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":115,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":63,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":390,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":4,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":62,"beanId":null,"count":1,"times":[62]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":18,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[18]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":231,"beanId":null,"count":1,"times":[231]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":703}}	192.168.3.132	2017-08-14 18:30:12.677	2017-08-14 18:30:12.726
40830	chain-1502706611635	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":149,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":53,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":489,"[14]handleException()":0,"[15]ready execute localUpdate":59,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":52,"beanId":null,"count":1,"times":[52]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":27,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[27]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":176,"beanId":null,"count":1,"times":[176]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":945}}	192.168.3.132	2017-08-14 18:30:12.677	2017-08-14 18:30:12.726
40831	chain-1502706611659	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":86,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":134,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":577,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":130,"beanId":null,"count":1,"times":[130]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":15,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[15]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":134,"beanId":null,"count":1,"times":[134]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":933}}	192.168.3.132	2017-08-14 18:30:12.68	2017-08-14 18:30:12.745
40832	chain-1502706611731	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":164,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":74,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":576,"[14]handleException()":0,"[15]ready execute localUpdate":1,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":73,"beanId":null,"count":1,"times":[73]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":57,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[57]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":243,"beanId":null,"count":1,"times":[243]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":981}}	192.168.3.132	2017-08-14 18:30:12.712	2017-08-14 18:30:12.745
40833	chain-1502706611934	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":74,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":58,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":609,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":57,"beanId":null,"count":1,"times":[57]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":20,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[20]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":345,"beanId":null,"count":1,"times":[345]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":821}}	192.168.3.132	2017-08-14 18:30:12.756	2017-08-14 18:30:13.019
41483	chain-1502706624628	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":17,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":17}}	192.168.3.132	2017-08-14 18:30:24.643	2017-08-14 18:30:24.77
40834	chain-1502706611878	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":120,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":51,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":605,"[14]handleException()":0,"[15]ready execute localUpdate":2,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":50,"beanId":null,"count":1,"times":[50]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":9,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[9]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":211,"beanId":null,"count":1,"times":[211]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":905}}	192.168.3.132	2017-08-14 18:30:12.782	2017-08-14 18:30:13.019
40855	chain-1502706611926	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":81,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":44,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":603,"[14]handleException()":0,"[15]ready execute localUpdate":1,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":44,"beanId":null,"count":1,"times":[44]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":10,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[10]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":217,"beanId":null,"count":1,"times":[217]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":862}}	192.168.3.132	2017-08-14 18:30:12.787	2017-08-14 18:30:13.019
40856	chain-1502706612007	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":129,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":162,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":418,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":4,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":160,"beanId":null,"count":1,"times":[160]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":13,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[13]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":130,"beanId":null,"count":1,"times":[130]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":790}}	192.168.3.132	2017-08-14 18:30:12.801	2017-08-14 18:30:13.02
40857	chain-1502706611957	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":71,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":71,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":663,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":70,"beanId":null,"count":1,"times":[70]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":12,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[12]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":350,"beanId":null,"count":1,"times":[350]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":918}}	192.168.3.132	2017-08-14 18:30:12.875	2017-08-14 18:30:13.02
40858	chain-1502706612118	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":39,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":138,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":521,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":137,"beanId":null,"count":1,"times":[137]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":26,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[26]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":290,"beanId":null,"count":1,"times":[290]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":751}}	192.168.3.132	2017-08-14 18:30:12.867	2017-08-14 18:30:13.02
40859	chain-1502706612051	{"#ChainStep#":{"[1]startLocalChain(name)":11,"[2]@ChainUpdate proceed":88,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":172,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":525,"[14]handleException()":0,"[15]ready execute localUpdate":13,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":165,"beanId":null,"count":1,"times":[165]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":11,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[11]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":240,"beanId":null,"count":1,"times":[240]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":987}}	192.168.3.132	2017-08-14 18:30:13.036	2017-08-14 18:30:13.237
41484	chain-1502706624814	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":15}}	192.168.3.132	2017-08-14 18:30:24.826	2017-08-14 18:30:24.987
40880	chain-1502706612166	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":203,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":79,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":571,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":1,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":79,"beanId":null,"count":1,"times":[79]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":58,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[58]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":215,"beanId":null,"count":1,"times":[215]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":934}}	192.168.3.132	2017-08-14 18:30:13.1	2017-08-14 18:30:13.237
40881	chain-1502706612446	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":122,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":113,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":425,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":111,"beanId":null,"count":1,"times":[111]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":11,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[11]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":161,"beanId":null,"count":1,"times":[161]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":716}}	192.168.3.132	2017-08-14 18:30:13.16	2017-08-14 18:30:13.238
40882	chain-1502706612208	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":171,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":110,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":647,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":99,"beanId":null,"count":1,"times":[99]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":8,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[8]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":315,"beanId":null,"count":1,"times":[315]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":948}}	192.168.3.132	2017-08-14 18:30:13.156	2017-08-14 18:30:13.238
40883	chain-1502706612330	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":168,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":147,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":541,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":2,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":129,"beanId":null,"count":1,"times":[129]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":44,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[44]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":113,"beanId":null,"count":1,"times":[113]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":886}}	192.168.3.132	2017-08-14 18:30:13.215	2017-08-14 18:30:13.487
40884	chain-1502706612587	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":147,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":96,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":447,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":92,"beanId":null,"count":1,"times":[92]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":31,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[31]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":230,"beanId":null,"count":1,"times":[230]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":759}}	192.168.3.132	2017-08-14 18:30:13.345	2017-08-14 18:30:13.487
40905	chain-1502706612521	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":209,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":75,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":454,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":74,"beanId":null,"count":1,"times":[74]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":11,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[11]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":198,"beanId":null,"count":1,"times":[198]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":888}}	192.168.3.132	2017-08-14 18:30:13.407	2017-08-14 18:30:13.487
41505	chain-1502706625039	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":12,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:25.051	2017-08-14 18:30:25.204
40906	chain-1502706612706	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":89,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":139,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":268,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":10,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":139,"beanId":null,"count":1,"times":[139]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":5,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[5]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":109,"beanId":null,"count":1,"times":[109]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":649}}	192.168.3.132	2017-08-14 18:30:13.357	2017-08-14 18:30:13.488
40907	chain-1502706612776	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":120,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":109,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":378,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":107,"beanId":null,"count":1,"times":[107]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":11,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[11]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":194,"beanId":null,"count":1,"times":[194]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":637}}	192.168.3.132	2017-08-14 18:30:13.419	2017-08-14 18:30:13.488
40908	chain-1502706612630	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":152,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":161,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":436,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":15,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":157,"beanId":null,"count":1,"times":[157]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":13,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[13]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":169,"beanId":null,"count":1,"times":[169]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":859}}	192.168.3.132	2017-08-14 18:30:13.488	2017-08-14 18:30:13.74
40909	chain-1502706612627	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":179,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":186,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":406,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":186,"beanId":null,"count":1,"times":[186]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":19,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[19]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":160,"beanId":null,"count":1,"times":[160]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":873}}	192.168.3.132	2017-08-14 18:30:13.499	2017-08-14 18:30:13.74
40930	chain-1502706612627	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":200,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":186,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":426,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":184,"beanId":null,"count":1,"times":[184]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":38,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[38]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":180,"beanId":null,"count":1,"times":[180]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":934}}	192.168.3.132	2017-08-14 18:30:13.559	2017-08-14 18:30:13.741
40931	chain-1502706612567	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":214,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":58,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":573,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":23,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":55,"beanId":null,"count":1,"times":[55]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":7,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[7]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":193,"beanId":null,"count":1,"times":[193]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":954}}	192.168.3.132	2017-08-14 18:30:13.519	2017-08-14 18:30:13.741
41506	chain-1502706625217	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:25.228	2017-08-14 18:30:25.245
40932	chain-1502706612732	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":133,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":93,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":370,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":6,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":93,"beanId":null,"count":1,"times":[93]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":16,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[16]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":80,"beanId":null,"count":1,"times":[80]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":844}}	192.168.3.132	2017-08-14 18:30:13.575	2017-08-14 18:30:13.741
40933	chain-1502706612826	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":236,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":95,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":461,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":93,"beanId":null,"count":1,"times":[93]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":8,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[8]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":187,"beanId":null,"count":1,"times":[187]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":886}}	192.168.3.132	2017-08-14 18:30:13.71	2017-08-14 18:30:13.742
40934	chain-1502706612838	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":206,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":74,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":545,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":1},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":73,"beanId":null,"count":1,"times":[73]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":43,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[43]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":188,"beanId":null,"count":1,"times":[188]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":898}}	192.168.3.132	2017-08-14 18:30:13.736	2017-08-14 18:30:13.995
40955	chain-1502706612851	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":286,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":71,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":504,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":71,"beanId":null,"count":1,"times":[71]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":11,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[11]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":225,"beanId":null,"count":1,"times":[225]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":948}}	192.168.3.132	2017-08-14 18:30:13.798	2017-08-14 18:30:13.996
40956	chain-1502706613069	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":145,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":95,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":510,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":1,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":80,"beanId":null,"count":1,"times":[80]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":11,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[11]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":206,"beanId":null,"count":1,"times":[206]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":789}}	192.168.3.132	2017-08-14 18:30:13.878	2017-08-14 18:30:13.996
40957	chain-1502706612914	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":197,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":37,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":577,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":37,"beanId":null,"count":1,"times":[37]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":18,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[18]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":249,"beanId":null,"count":1,"times":[249]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":963}}	192.168.3.132	2017-08-14 18:30:13.875	2017-08-14 18:30:13.997
41507	chain-1502706625398	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":37,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":37}}	192.168.3.132	2017-08-14 18:30:25.434	2017-08-14 18:30:25.504
40958	chain-1502706612913	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":190,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":106,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":572,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":104,"beanId":null,"count":1,"times":[104]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":17,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[17]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":198,"beanId":null,"count":1,"times":[198]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1022}}	192.168.3.132	2017-08-14 18:30:13.94	2017-08-14 18:30:14.045
40959	chain-1502706613151	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":114,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":123,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":383,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":17,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":121,"beanId":null,"count":1,"times":[121]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":23,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[23]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":252,"beanId":null,"count":1,"times":[252]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":782}}	192.168.3.132	2017-08-14 18:30:13.932	2017-08-14 18:30:14.045
40980	chain-1502706612868	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":211,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":97,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":677,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":97,"beanId":null,"count":1,"times":[97]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":35,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[35]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":405,"beanId":null,"count":1,"times":[405]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1093}}	192.168.3.132	2017-08-14 18:30:13.96	2017-08-14 18:30:14.287
40981	chain-1502706613239	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":159,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":79,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":476,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":79,"beanId":null,"count":1,"times":[79]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":19,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[19]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":218,"beanId":null,"count":1,"times":[218]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":861}}	192.168.3.132	2017-08-14 18:30:14.099	2017-08-14 18:30:14.288
40982	chain-1502706613407	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":100,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":133,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":387,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":13,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":132,"beanId":null,"count":1,"times":[132]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":17,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[17]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":200,"beanId":null,"count":1,"times":[200]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":694}}	192.168.3.132	2017-08-14 18:30:14.099	2017-08-14 18:30:14.288
40983	chain-1502706613398	{"#ChainStep#":{"[1]startLocalChain(name)":1,"[2]@ChainUpdate proceed":135,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":77,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":367,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":77,"beanId":null,"count":1,"times":[77]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":22,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[22]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":146,"beanId":null,"count":1,"times":[146]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":768}}	192.168.3.132	2017-08-14 18:30:14.166	2017-08-14 18:30:14.288
41508	chain-1502706625609	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:25.62	2017-08-14 18:30:25.737
40984	chain-1502706613187	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":190,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":150,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":412,"[14]handleException()":0,"[15]ready execute localUpdate":1,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":150,"beanId":null,"count":1,"times":[150]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":14,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[14]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":149,"beanId":null,"count":1,"times":[149]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":988}}	192.168.3.132	2017-08-14 18:30:14.173	2017-08-14 18:30:14.288
41005	chain-1502706613256	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":227,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":83,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":526,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":3,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":82,"beanId":null,"count":1,"times":[82]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":17,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[17]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":172,"beanId":null,"count":1,"times":[172]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1106}}	192.168.3.132	2017-08-14 18:30:14.36	2017-08-14 18:30:14.503
41006	chain-1502706613543	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":192,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":53,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":517,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":6,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":53,"beanId":null,"count":1,"times":[53]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":19,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[19]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":137,"beanId":null,"count":1,"times":[137]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":840}}	192.168.3.132	2017-08-14 18:30:14.384	2017-08-14 18:30:14.504
41007	chain-1502706613532	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":272,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":95,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":412,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":92,"beanId":null,"count":1,"times":[92]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":10,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[10]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":203,"beanId":null,"count":1,"times":[203]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":854}}	192.168.3.132	2017-08-14 18:30:14.384	2017-08-14 18:30:14.504
41008	chain-1502706613575	{"#ChainStep#":{"[1]startLocalChain(name)":4,"[2]@ChainUpdate proceed":159,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":100,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":484,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":13,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":1,"beanId":null,"count":1,"times":[1]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":99,"beanId":null,"count":1,"times":[99]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":10,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[10]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":197,"beanId":null,"count":1,"times":[197]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":892}}	192.168.3.132	2017-08-14 18:30:14.465	2017-08-14 18:30:14.504
41009	chain-1502706613696	{"#ChainStep#":{"[1]startLocalChain(name)":1,"[2]@ChainUpdate proceed":59,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":60,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":499,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":60,"beanId":null,"count":1,"times":[60]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":6,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[6]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":351,"beanId":null,"count":1,"times":[351]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":819}}	192.168.3.132	2017-08-14 18:30:14.515	2017-08-14 18:30:14.737
41509	chain-1502706625788	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:25.8	2017-08-14 18:30:25.954
41030	chain-1502706613468	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":319,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":69,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":509,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":69,"beanId":null,"count":1,"times":[69]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":12,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[12]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":182,"beanId":null,"count":1,"times":[182]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1037}}	192.168.3.132	2017-08-14 18:30:14.504	2017-08-14 18:30:14.737
41031	chain-1502706613768	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":133,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":110,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":443,"[14]handleException()":0,"[15]ready execute localUpdate":1,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":3,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":109,"beanId":null,"count":1,"times":[109]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":51,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[51]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":256,"beanId":null,"count":1,"times":[256]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":787}}	192.168.3.132	2017-08-14 18:30:14.556	2017-08-14 18:30:14.738
41032	chain-1502706613471	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":78,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":126,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":641,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":3,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":3,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":27,"beanId":null,"count":1,"times":[27]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":99,"beanId":null,"count":1,"times":[99]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":7,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[7]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":351,"beanId":null,"count":1,"times":[351]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1098}}	192.168.3.132	2017-08-14 18:30:14.569	2017-08-14 18:30:14.738
41033	chain-1502706613692	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":151,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":126,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":532,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":126,"beanId":null,"count":1,"times":[126]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":6,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[6]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":363,"beanId":null,"count":1,"times":[363]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":935}}	192.168.3.132	2017-08-14 18:30:14.625	2017-08-14 18:30:14.738
41034	chain-1502706613835	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":122,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":89,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":394,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":89,"beanId":null,"count":1,"times":[89]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":14,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[14]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":210,"beanId":null,"count":1,"times":[210]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":735}}	192.168.3.132	2017-08-14 18:30:14.569	2017-08-14 18:30:14.738
41055	chain-1502706613783	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":118,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":90,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":488,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":89,"beanId":null,"count":1,"times":[89]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":15,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[15]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":273,"beanId":null,"count":1,"times":[273]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":852}}	192.168.3.132	2017-08-14 18:30:14.633	2017-08-14 18:30:14.995
41530	chain-1502706625973	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:25.985	2017-08-14 18:30:26.029
41056	chain-1502706613977	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":95,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":51,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":448,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":51,"beanId":null,"count":1,"times":[51]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":48,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[48]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":159,"beanId":null,"count":1,"times":[159]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":758}}	192.168.3.132	2017-08-14 18:30:14.733	2017-08-14 18:30:14.996
41057	chain-1502706613927	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":108,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":1,"[7]localValidation()":147,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":447,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":140,"beanId":null,"count":1,"times":[140]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":24,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[24]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":227,"beanId":null,"count":1,"times":[227]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":880}}	192.168.3.132	2017-08-14 18:30:14.806	2017-08-14 18:30:14.997
41058	chain-1502706614234	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":190,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":79,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":254,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":79,"beanId":null,"count":1,"times":[79]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":10,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[10]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":111,"beanId":null,"count":1,"times":[111]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":589}}	192.168.3.132	2017-08-14 18:30:14.828	2017-08-14 18:30:14.997
41059	chain-1502706613978	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":182,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":97,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":491,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":93,"beanId":null,"count":1,"times":[93]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":38,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[38]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":156,"beanId":null,"count":1,"times":[156]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":854}}	192.168.3.132	2017-08-14 18:30:14.831	2017-08-14 18:30:14.997
41080	chain-1502706613935	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":95,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":95,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":604,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":93,"beanId":null,"count":1,"times":[93]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":4,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[4]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":279,"beanId":null,"count":1,"times":[279]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":931}}	192.168.3.132	2017-08-14 18:30:14.864	2017-08-14 18:30:14.997
41081	chain-1502706614009	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":126,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":144,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":533,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":142,"beanId":null,"count":1,"times":[142]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":24,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[24]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":150,"beanId":null,"count":1,"times":[150]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":892}}	192.168.3.132	2017-08-14 18:30:14.899	2017-08-14 18:30:15.037
41531	chain-1502706626298	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":12,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":12}}	192.168.3.132	2017-08-14 18:30:26.308	2017-08-14 18:30:26.493
41082	chain-1502706614209	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":142,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":75,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":547,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":1,"beanId":null,"count":1,"times":[1]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":73,"beanId":null,"count":1,"times":[73]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":17,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[17]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":191,"beanId":null,"count":1,"times":[191]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":870}}	192.168.3.132	2017-08-14 18:30:15.082	2017-08-14 18:30:15.262
41083	chain-1502706614149	{"#ChainStep#":{"[1]startLocalChain(name)":1,"[2]@ChainUpdate proceed":94,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":150,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":482,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":1,"beanId":null,"count":1,"times":[1]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":149,"beanId":null,"count":1,"times":[149]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":22,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[22]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":149,"beanId":null,"count":1,"times":[149]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":988}}	192.168.3.132	2017-08-14 18:30:15.15	2017-08-14 18:30:15.262
41084	chain-1502706614161	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":204,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":67,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":691,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":1,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":4,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":67,"beanId":null,"count":1,"times":[67]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":17,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[17]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":324,"beanId":null,"count":1,"times":[324]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1103}}	192.168.3.132	2017-08-14 18:30:15.29	2017-08-14 18:30:15.312
41105	chain-1502706614426	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":151,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":126,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":517,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":125,"beanId":null,"count":1,"times":[125]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":56,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[56]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":172,"beanId":null,"count":1,"times":[172]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":924}}	192.168.3.132	2017-08-14 18:30:15.349	2017-08-14 18:30:15.554
41106	chain-1502706614663	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":69,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":86,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":496,"[14]handleException()":0,"[15]ready execute localUpdate":1,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":1,"beanId":null,"count":1,"times":[1]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":85,"beanId":null,"count":1,"times":[85]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":5,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[5]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":189,"beanId":null,"count":1,"times":[189]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":706}}	192.168.3.132	2017-08-14 18:30:15.368	2017-08-14 18:30:15.554
41107	chain-1502706614494	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":227,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":49,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":464,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":49,"beanId":null,"count":1,"times":[49]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":7,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[7]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":177,"beanId":null,"count":1,"times":[177]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":884}}	192.168.3.132	2017-08-14 18:30:15.376	2017-08-14 18:30:15.555
41532	chain-1502706626481	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":1,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":15}}	192.168.3.132	2017-08-14 18:30:26.494	2017-08-14 18:30:26.529
41108	chain-1502706614427	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":137,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":88,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":655,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":86,"beanId":null,"count":1,"times":[86]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":15,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[15]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":241,"beanId":null,"count":1,"times":[241]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1022}}	192.168.3.132	2017-08-14 18:30:15.448	2017-08-14 18:30:15.604
41109	chain-1502706614458	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":185,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":94,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":525,"[14]handleException()":0,"[15]ready execute localUpdate":22,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":1},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":93,"beanId":null,"count":1,"times":[93]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":4,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[4]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":333,"beanId":null,"count":1,"times":[333]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1007}}	192.168.3.132	2017-08-14 18:30:15.465	2017-08-14 18:30:15.604
41130	chain-1502706614867	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":95,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":94,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":450,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":1},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":93,"beanId":null,"count":1,"times":[93]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":8,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[8]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":168,"beanId":null,"count":1,"times":[168]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":669}}	192.168.3.132	2017-08-14 18:30:15.535	2017-08-14 18:30:15.862
41131	chain-1502706614604	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":214,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":119,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":425,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":1,"beanId":null,"count":1,"times":[1]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":118,"beanId":null,"count":1,"times":[118]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":4,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[4]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":175,"beanId":null,"count":1,"times":[175]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":934}}	192.168.3.132	2017-08-14 18:30:15.536	2017-08-14 18:30:15.863
41132	chain-1502706614590	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":145,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":92,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":694,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":1,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":91,"beanId":null,"count":1,"times":[91]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":7,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[7]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":236,"beanId":null,"count":1,"times":[236]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1007}}	192.168.3.132	2017-08-14 18:30:15.604	2017-08-14 18:30:15.863
41133	chain-1502706614608	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":163,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":137,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":584,"[14]handleException()":0,"[15]ready execute localUpdate":1,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":19,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":136,"beanId":null,"count":1,"times":[136]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":26,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[26]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":318,"beanId":null,"count":1,"times":[318]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1070}}	192.168.3.132	2017-08-14 18:30:15.68	2017-08-14 18:30:15.863
41533	chain-1502706626663	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":12,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":12}}	192.168.3.132	2017-08-14 18:30:26.674	2017-08-14 18:30:26.779
41134	chain-1502706614663	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":145,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":204,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":503,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":2,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":204,"beanId":null,"count":1,"times":[204]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":10,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[10]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":182,"beanId":null,"count":1,"times":[182]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1067}}	192.168.3.132	2017-08-14 18:30:15.729	2017-08-14 18:30:15.863
41155	chain-1502706614615	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":90,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":235,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":651,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":232,"beanId":null,"count":1,"times":[232]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":11,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[11]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":202,"beanId":null,"count":1,"times":[202]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1077}}	192.168.3.132	2017-08-14 18:30:15.691	2017-08-14 18:30:15.863
41156	chain-1502706614775	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":113,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":136,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":560,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":136,"beanId":null,"count":1,"times":[136]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":9,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[9]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":205,"beanId":null,"count":1,"times":[205]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1011}}	192.168.3.132	2017-08-14 18:30:15.784	2017-08-14 18:30:15.864
41157	chain-1502706614909	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":126,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":87,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":583,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":87,"beanId":null,"count":1,"times":[87]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":10,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[10]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":206,"beanId":null,"count":1,"times":[206]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":836}}	192.168.3.132	2017-08-14 18:30:15.743	2017-08-14 18:30:15.864
41158	chain-1502706614982	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":67,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":113,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":641,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":1,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":112,"beanId":null,"count":1,"times":[112]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":8,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[8]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":406,"beanId":null,"count":1,"times":[406]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":961}}	192.168.3.132	2017-08-14 18:30:15.942	2017-08-14 18:30:16.087
41159	chain-1502706615176	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":143,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":75,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":470,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":73,"beanId":null,"count":1,"times":[73]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":8,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[8]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":288,"beanId":null,"count":1,"times":[288]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":770}}	192.168.3.132	2017-08-14 18:30:15.951	2017-08-14 18:30:16.087
41534	chain-1502706626841	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":12,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:26.852	2017-08-14 18:30:26.995
41180	chain-1502706615122	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":121,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":79,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":466,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":78,"beanId":null,"count":1,"times":[78]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":6,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[6]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":287,"beanId":null,"count":1,"times":[287]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":845}}	192.168.3.132	2017-08-14 18:30:15.965	2017-08-14 18:30:16.087
41181	chain-1502706614866	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":173,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":77,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":695,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":76,"beanId":null,"count":1,"times":[76]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":20,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[20]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":424,"beanId":null,"count":1,"times":[424]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1121}}	192.168.3.132	2017-08-14 18:30:15.986	2017-08-14 18:30:16.088
41182	chain-1502706614973	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":246,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":130,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":543,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":127,"beanId":null,"count":1,"times":[127]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":17,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[17]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":285,"beanId":null,"count":1,"times":[285]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1019}}	192.168.3.132	2017-08-14 18:30:15.991	2017-08-14 18:30:16.088
41183	chain-1502706615517	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":93,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":201,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":245,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":1,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":198,"beanId":null,"count":1,"times":[198]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":23,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[23]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":76,"beanId":null,"count":1,"times":[76]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":706}}	192.168.3.132	2017-08-14 18:30:16.224	2017-08-14 18:30:16.304
41184	chain-1502706615349	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":96,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":111,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":428,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":1,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":103,"beanId":null,"count":1,"times":[103]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":20,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[20]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":160,"beanId":null,"count":1,"times":[160]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":894}}	192.168.3.132	2017-08-14 18:30:16.242	2017-08-14 18:30:16.537
41205	chain-1502706615519	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":164,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":116,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":405,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":106,"beanId":null,"count":1,"times":[106]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":38,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[38]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":171,"beanId":null,"count":1,"times":[171]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":775}}	192.168.3.132	2017-08-14 18:30:16.293	2017-08-14 18:30:16.537
41555	chain-1502706627041	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":18,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":1,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":19}}	192.168.3.132	2017-08-14 18:30:27.059	2017-08-14 18:30:27.254
41206	chain-1502706615689	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":103,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":121,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":405,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":12,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":120,"beanId":null,"count":1,"times":[120]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":13,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[13]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":177,"beanId":null,"count":1,"times":[177]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":763}}	192.168.3.132	2017-08-14 18:30:16.451	2017-08-14 18:30:16.538
41207	chain-1502706615588	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":261,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":44,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":484,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":44,"beanId":null,"count":1,"times":[44]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":15,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[15]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":206,"beanId":null,"count":1,"times":[206]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":872}}	192.168.3.132	2017-08-14 18:30:16.462	2017-08-14 18:30:16.579
41208	chain-1502706615503	{"#ChainStep#":{"[1]startLocalChain(name)":1,"[2]@ChainUpdate proceed":261,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":57,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":471,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":1,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":53,"beanId":null,"count":1,"times":[53]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":22,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[22]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":182,"beanId":null,"count":1,"times":[182]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":951}}	192.168.3.132	2017-08-14 18:30:16.452	2017-08-14 18:30:16.579
41209	chain-1502706615528	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":197,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":73,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":631,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":61,"beanId":null,"count":1,"times":[61]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":11,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[11]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":276,"beanId":null,"count":1,"times":[276]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":991}}	192.168.3.132	2017-08-14 18:30:16.518	2017-08-14 18:30:16.837
41230	chain-1502706615718	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":142,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":115,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":335,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":2,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":115,"beanId":null,"count":1,"times":[115]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":14,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[14]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":106,"beanId":null,"count":1,"times":[106]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":815}}	192.168.3.132	2017-08-14 18:30:16.532	2017-08-14 18:30:16.837
41231	chain-1502706615589	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":259,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":106,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":572,"[14]handleException()":0,"[15]ready execute localUpdate":1,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":105,"beanId":null,"count":1,"times":[105]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":8,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[8]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":205,"beanId":null,"count":1,"times":[205]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":1,"beanId":null,"count":1,"times":[1]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1033}}	192.168.3.132	2017-08-14 18:30:16.622	2017-08-14 18:30:16.838
41556	chain-1502706627286	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":1,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":15}}	192.168.3.132	2017-08-14 18:30:27.3	2017-08-14 18:30:27.303
41232	chain-1502706615826	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":172,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":91,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":436,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":90,"beanId":null,"count":1,"times":[90]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":8,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[8]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":226,"beanId":null,"count":1,"times":[226]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":777}}	192.168.3.132	2017-08-14 18:30:16.603	2017-08-14 18:30:16.838
41233	chain-1502706615510	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":345,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":116,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":454,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":1,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":114,"beanId":null,"count":1,"times":[114]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":7,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[7]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":181,"beanId":null,"count":1,"times":[181]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1141}}	192.168.3.132	2017-08-14 18:30:16.655	2017-08-14 18:30:16.838
41234	chain-1502706615757	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":143,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":115,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":492,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":113,"beanId":null,"count":1,"times":[113]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":6,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[6]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":122,"beanId":null,"count":1,"times":[122]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":919}}	192.168.3.132	2017-08-14 18:30:16.676	2017-08-14 18:30:16.838
41255	chain-1502706615527	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":319,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":35,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":606,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":35,"beanId":null,"count":1,"times":[35]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":5,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[5]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":213,"beanId":null,"count":1,"times":[213]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1177}}	192.168.3.132	2017-08-14 18:30:16.704	2017-08-14 18:30:16.87
41256	chain-1502706616029	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":115,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":111,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":413,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":109,"beanId":null,"count":1,"times":[109]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":21,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[21]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":153,"beanId":null,"count":1,"times":[153]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":720}}	192.168.3.132	2017-08-14 18:30:16.752	2017-08-14 18:30:16.871
41257	chain-1502706616011	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":46,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":92,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":529,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":18,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":92,"beanId":null,"count":1,"times":[92]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":31,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[31]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":284,"beanId":null,"count":1,"times":[284]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":768}}	192.168.3.132	2017-08-14 18:30:16.779	2017-08-14 18:30:17.12
41557	chain-1502706627504	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:27.517	2017-08-14 18:30:27.587
41258	chain-1502706615776	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":232,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":92,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":534,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":91,"beanId":null,"count":1,"times":[91]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":7,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[7]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":202,"beanId":null,"count":1,"times":[202]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1013}}	192.168.3.132	2017-08-14 18:30:16.79	2017-08-14 18:30:17.121
41259	chain-1502706615981	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":152,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":100,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":547,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":16,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":98,"beanId":null,"count":1,"times":[98]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":88,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[88]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":155,"beanId":null,"count":1,"times":[155]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":912}}	192.168.3.132	2017-08-14 18:30:16.891	2017-08-14 18:30:17.121
41280	chain-1502706615715	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":333,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":100,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":541,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":100,"beanId":null,"count":1,"times":[100]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":13,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[13]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":144,"beanId":null,"count":1,"times":[144]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":1,"beanId":null,"count":1,"times":[1]}},"#Other#":{"[20][TOTAL]":1156}}	192.168.3.132	2017-08-14 18:30:16.87	2017-08-14 18:30:17.121
41281	chain-1502706616042	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":91,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":75,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":624,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":74,"beanId":null,"count":1,"times":[74]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":10,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[10]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":314,"beanId":null,"count":1,"times":[314]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":861}}	192.168.3.132	2017-08-14 18:30:16.902	2017-08-14 18:30:17.122
41282	chain-1502706616018	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":147,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":315,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":388,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":312,"beanId":null,"count":1,"times":[312]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":5,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[5]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":180,"beanId":null,"count":1,"times":[180]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":1,"beanId":null,"count":1,"times":[1]}},"#Other#":{"[20][TOTAL]":1188}}	192.168.3.132	2017-08-14 18:30:17.22	2017-08-14 18:30:17.354
41283	chain-1502706616258	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":271,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":111,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":389,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":111,"beanId":null,"count":1,"times":[111]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":19,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[19]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":168,"beanId":null,"count":1,"times":[168]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":945}}	192.168.3.132	2017-08-14 18:30:17.22	2017-08-14 18:30:17.354
41558	chain-1502706627699	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:27.712	2017-08-14 18:30:27.82
41284	chain-1502706616288	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":233,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":96,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":406,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":2,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":95,"beanId":null,"count":1,"times":[95]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":7,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[7]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":148,"beanId":null,"count":1,"times":[148]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":944}}	192.168.3.132	2017-08-14 18:30:17.231	2017-08-14 18:30:17.354
41305	chain-1502706616513	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":83,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":87,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":493,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":27,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":86,"beanId":null,"count":1,"times":[86]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":7,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[7]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":170,"beanId":null,"count":1,"times":[170]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":881}}	192.168.3.132	2017-08-14 18:30:17.393	2017-08-14 18:30:17.461
41306	chain-1502706616490	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":137,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":163,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":490,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":162,"beanId":null,"count":1,"times":[162]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":9,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[9]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":219,"beanId":null,"count":1,"times":[219]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":1,"beanId":null,"count":1,"times":[1]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":925}}	192.168.3.132	2017-08-14 18:30:17.416	2017-08-14 18:30:17.462
41307	chain-1502706616528	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":172,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":126,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":382,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":1},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":126,"beanId":null,"count":1,"times":[126]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":5,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[5]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":245,"beanId":null,"count":1,"times":[245]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":911}}	192.168.3.132	2017-08-14 18:30:17.438	2017-08-14 18:30:17.696
41308	chain-1502706616405	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":290,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":84,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":419,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":1,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":79,"beanId":null,"count":1,"times":[79]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":16,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[16]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":253,"beanId":null,"count":1,"times":[253]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1035}}	192.168.3.132	2017-08-14 18:30:17.438	2017-08-14 18:30:17.696
41309	chain-1502706616644	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":142,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":83,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":483,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":7,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":82,"beanId":null,"count":1,"times":[82]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":17,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[17]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":246,"beanId":null,"count":1,"times":[246]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":857}}	192.168.3.132	2017-08-14 18:30:17.5	2017-08-14 18:30:17.696
41559	chain-1502706627909	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:27.92	2017-08-14 18:30:28.037
41330	chain-1502706616593	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":246,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":76,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":505,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":76,"beanId":null,"count":1,"times":[76]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":28,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[28]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":244,"beanId":null,"count":1,"times":[244]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":884}}	192.168.3.132	2017-08-14 18:30:17.481	2017-08-14 18:30:17.696
41331	chain-1502706616645	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":75,"[3]navigateTillExhausted()":1,"[4]checkChainValid()":0,"[7]localValidation()":71,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":583,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":71,"beanId":null,"count":1,"times":[71]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":20,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[20]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":224,"beanId":null,"count":1,"times":[224]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":866}}	192.168.3.132	2017-08-14 18:30:17.516	2017-08-14 18:30:17.697
41332	chain-1502706616703	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":106,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":80,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":493,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":80,"beanId":null,"count":1,"times":[80]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":5,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[5]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":223,"beanId":null,"count":1,"times":[223]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":800}}	192.168.3.132	2017-08-14 18:30:17.504	2017-08-14 18:30:17.697
41333	chain-1502706616630	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":96,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":62,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":550,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":62,"beanId":null,"count":1,"times":[62]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":6,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[6]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":272,"beanId":null,"count":1,"times":[272]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":901}}	192.168.3.132	2017-08-14 18:30:17.539	2017-08-14 18:30:17.938
41334	chain-1502706616818	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":78,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":184,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":315,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":182,"beanId":null,"count":1,"times":[182]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":36,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[36]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":115,"beanId":null,"count":1,"times":[115]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":709}}	192.168.3.132	2017-08-14 18:30:17.525	2017-08-14 18:30:17.939
41355	chain-1502706616914	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":117,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":167,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":356,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":167,"beanId":null,"count":1,"times":[167]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":12,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[12]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":205,"beanId":null,"count":1,"times":[205]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":660}}	192.168.3.132	2017-08-14 18:30:17.573	2017-08-14 18:30:17.939
41356	chain-1502706617570	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":26,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":1,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":27}}	192.168.3.132	2017-08-14 18:30:17.595	2017-08-14 18:30:17.94
41357	chain-1502706617280	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":192,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":53,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":127,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":51,"beanId":null,"count":1,"times":[51]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":4,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[4]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":46,"beanId":null,"count":1,"times":[46]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":391}}	192.168.3.132	2017-08-14 18:30:17.67	2017-08-14 18:30:17.94
41358	chain-1502706617991	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":35,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":36}}	192.168.3.132	2017-08-14 18:30:18.025	2017-08-14 18:30:18.179
41359	chain-1502706618282	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":20,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":20}}	192.168.3.132	2017-08-14 18:30:18.302	2017-08-14 18:30:18.396
41380	chain-1502706618578	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":17,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":17}}	192.168.3.132	2017-08-14 18:30:18.594	2017-08-14 18:30:18.654
41381	chain-1502706618884	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":25,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":26}}	192.168.3.132	2017-08-14 18:30:18.911	2017-08-14 18:30:19.071
41382	chain-1502706619252	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":19,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":19}}	192.168.3.132	2017-08-14 18:30:19.273	2017-08-14 18:30:19.487
41383	chain-1502706619619	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":16,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":1,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":17}}	192.168.3.132	2017-08-14 18:30:19.634	2017-08-14 18:30:19.704
41384	chain-1502706619908	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":18,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":1},"#Other#":{"[14][TOTAL]":19}}	192.168.3.132	2017-08-14 18:30:19.925	2017-08-14 18:30:19.971
41405	chain-1502706620231	{"#ChainStep#":{"[1]startLocalChain(name)":1,"[2]@ChainUpdate proceed":21,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":22}}	192.168.3.132	2017-08-14 18:30:20.251	2017-08-14 18:30:20.387
41406	chain-1502706620554	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":22,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":23}}	192.168.3.132	2017-08-14 18:30:20.574	2017-08-14 18:30:20.621
41407	chain-1502706620988	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":17,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":17}}	192.168.3.132	2017-08-14 18:30:21.004	2017-08-14 18:30:21.062
41408	chain-1502706621241	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":15,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":1,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":16}}	192.168.3.132	2017-08-14 18:30:21.255	2017-08-14 18:30:21.287
41409	chain-1502706621478	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":15,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":15}}	192.168.3.132	2017-08-14 18:30:21.493	2017-08-14 18:30:21.52
41430	chain-1502706621678	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:21.69	2017-08-14 18:30:21.762
41580	chain-1502706628083	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":15,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":15}}	192.168.3.132	2017-08-14 18:30:28.096	2017-08-14 18:30:28.254
41581	chain-1502706628268	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":1,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:28.28	2017-08-14 18:30:28.3
41582	chain-1502706628452	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":1,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:28.464	2017-08-14 18:30:28.545
41583	chain-1502706628661	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:28.673	2017-08-14 18:30:28.762
41584	chain-1502706628861	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:28.872	2017-08-14 18:30:28.979
41605	chain-1502706629053	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:29.064	2017-08-14 18:30:29.196
41606	chain-1502706629233	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:29.244	2017-08-14 18:30:29.26
41607	chain-1502706629423	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:29.436	2017-08-14 18:30:29.512
41608	chain-1502706629603	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":19,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":19}}	192.168.3.132	2017-08-14 18:30:29.621	2017-08-14 18:30:29.74
41609	chain-1502706629793	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:29.805	2017-08-14 18:30:29.954
41630	chain-1502706629969	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":16,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":16}}	192.168.3.132	2017-08-14 18:30:29.983	2017-08-14 18:30:30.012
41631	chain-1502706630158	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:30.169	2017-08-14 18:30:30.262
41632	chain-1502706630355	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":1},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:30.367	2017-08-14 18:30:30.512
41633	chain-1502706630541	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:30.552	2017-08-14 18:30:30.562
41634	chain-1502706630745	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:30.757	2017-08-14 18:30:30.812
41655	chain-1502706630946	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:30.958	2017-08-14 18:30:31.029
41656	chain-1502706631166	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:31.177	2017-08-14 18:30:31.246
41657	chain-1502706631352	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:31.364	2017-08-14 18:30:31.462
41658	chain-1502706631540	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":15,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":16}}	192.168.3.132	2017-08-14 18:30:31.553	2017-08-14 18:30:31.679
41659	chain-1502706631732	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":1,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:31.743	2017-08-14 18:30:31.904
41680	chain-1502706631926	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:31.938	2017-08-14 18:30:31.954
41681	chain-1502706632125	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":15,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":15}}	192.168.3.132	2017-08-14 18:30:32.138	2017-08-14 18:30:32.204
41682	chain-1502706632327	{"#ChainStep#":{"[1]startLocalChain(name)":1,"[2]@ChainUpdate proceed":18,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":1},"#Other#":{"[14][TOTAL]":20}}	192.168.3.132	2017-08-14 18:30:32.345	2017-08-14 18:30:32.435
41683	chain-1502706632520	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:32.532	2017-08-14 18:30:32.646
41684	chain-1502706632706	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":15,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":15}}	192.168.3.132	2017-08-14 18:30:32.72	2017-08-14 18:30:32.862
41705	chain-1502706632911	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":1,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":15}}	192.168.3.132	2017-08-14 18:30:32.926	2017-08-14 18:30:33.119
41706	chain-1502706633103	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:33.115	2017-08-14 18:30:33.119
41707	chain-1502706633280	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:33.293	2017-08-14 18:30:33.355
41708	chain-1502706633462	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":1,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:33.473	2017-08-14 18:30:33.587
41709	chain-1502706633651	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:33.663	2017-08-14 18:30:33.804
41730	chain-1502706633828	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:33.839	2017-08-14 18:30:33.854
41731	chain-1502706634006	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:34.017	2017-08-14 18:30:34.104
41732	chain-1502706634179	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:34.19	2017-08-14 18:30:34.32
41733	chain-1502706634351	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:34.363	2017-08-14 18:30:34.37
41734	chain-1502706634535	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:34.547	2017-08-14 18:30:34.638
41755	chain-1502706634709	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":12,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:34.719	2017-08-14 18:30:34.854
41756	chain-1502706634887	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:34.898	2017-08-14 18:30:34.912
41757	chain-1502706635084	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:35.095	2017-08-14 18:30:35.172
41758	chain-1502706635286	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:35.298	2017-08-14 18:30:35.412
41759	chain-1502706635496	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":16,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":17}}	192.168.3.132	2017-08-14 18:30:35.511	2017-08-14 18:30:35.629
41780	chain-1502706635688	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":1,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:35.699	2017-08-14 18:30:35.845
41781	chain-1502706635911	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":15,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":1,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":16}}	192.168.3.132	2017-08-14 18:30:35.924	2017-08-14 18:30:36.104
41782	chain-1502706636104	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:36.116	2017-08-14 18:30:36.129
41783	chain-1502706636288	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:36.3	2017-08-14 18:30:36.388
41784	chain-1502706636476	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":12,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":1,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:36.486	2017-08-14 18:30:36.604
41805	chain-1502706636655	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":17,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":17}}	192.168.3.132	2017-08-14 18:30:36.67	2017-08-14 18:30:36.82
41806	chain-1502706636849	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:36.86	2017-08-14 18:30:36.879
41807	chain-1502706637059	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":12,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":1,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:37.069	2017-08-14 18:30:37.131
41808	chain-1502706637262	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:37.273	2017-08-14 18:30:37.462
41809	chain-1502706637431	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:37.443	2017-08-14 18:30:37.462
41830	chain-1502706637623	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:37.634	2017-08-14 18:30:37.704
41831	chain-1502706637811	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:37.822	2017-08-14 18:30:37.929
41832	chain-1502706637995	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":15,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":15}}	192.168.3.132	2017-08-14 18:30:38.008	2017-08-14 18:30:38.145
41833	chain-1502706638197	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":1,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:38.208	2017-08-14 18:30:38.37
41834	chain-1502706638379	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":1},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:38.39	2017-08-14 18:30:38.42
41855	chain-1502706638547	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":1,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":15}}	192.168.3.132	2017-08-14 18:30:38.559	2017-08-14 18:30:38.672
41856	chain-1502706638730	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:38.741	2017-08-14 18:30:38.887
41857	chain-1502706638911	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:38.922	2017-08-14 18:30:38.945
41858	chain-1502706639094	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":12,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:39.104	2017-08-14 18:30:39.199
41859	chain-1502706639263	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":18,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":1,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":19}}	192.168.3.132	2017-08-14 18:30:39.28	2017-08-14 18:30:39.412
41880	chain-1502706639436	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:39.446	2017-08-14 18:30:39.47
41881	chain-1502706639603	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:39.633	2017-08-14 18:30:39.723
41882	chain-1502706639803	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":16,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":16}}	192.168.3.132	2017-08-14 18:30:39.818	2017-08-14 18:30:39.954
41883	chain-1502706639982	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:39.994	2017-08-14 18:30:40.004
41884	chain-1502706640161	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:40.172	2017-08-14 18:30:40.25
41905	chain-1502706640340	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":1,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:40.351	2017-08-14 18:30:40.462
41906	chain-1502706640522	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:40.533	2017-08-14 18:30:40.679
41907	chain-1502706640708	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":15,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":15}}	192.168.3.132	2017-08-14 18:30:40.721	2017-08-14 18:30:40.729
41908	chain-1502706640908	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:40.923	2017-08-14 18:30:40.97
41909	chain-1502706641090	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:41.102	2017-08-14 18:30:41.196
41930	chain-1502706641271	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:41.283	2017-08-14 18:30:41.412
41931	chain-1502706641453	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":12,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":1},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:41.463	2017-08-14 18:30:41.629
41932	chain-1502706641631	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:41.642	2017-08-14 18:30:41.654
41933	chain-1502706641809	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:41.819	2017-08-14 18:30:41.912
41934	chain-1502706641988	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:41.999	2017-08-14 18:30:42.129
41955	chain-1502706642154	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":1,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:42.165	2017-08-14 18:30:42.187
41956	chain-1502706642337	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":1,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:42.349	2017-08-14 18:30:42.437
41957	chain-1502706642514	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:42.525	2017-08-14 18:30:42.654
41958	chain-1502706642685	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":12,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:42.695	2017-08-14 18:30:42.712
41959	chain-1502706642872	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":15,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":15}}	192.168.3.132	2017-08-14 18:30:42.885	2017-08-14 18:30:42.962
41980	chain-1502706643061	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":12,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":1,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:43.072	2017-08-14 18:30:43.179
41981	chain-1502706643238	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":15,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":1,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":16}}	192.168.3.132	2017-08-14 18:30:43.251	2017-08-14 18:30:43.395
41982	chain-1502706643444	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":1,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:43.456	2017-08-14 18:30:43.612
41983	chain-1502706643619	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":12,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":12}}	192.168.3.132	2017-08-14 18:30:43.629	2017-08-14 18:30:43.662
41984	chain-1502706643791	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:43.803	2017-08-14 18:30:43.921
42005	chain-1502706644025	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":16,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":16}}	192.168.3.132	2017-08-14 18:30:44.039	2017-08-14 18:30:44.137
42006	chain-1502706644240	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:44.253	2017-08-14 18:30:44.354
42007	chain-1502706644449	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:44.461	2017-08-14 18:30:44.595
42008	chain-1502706644644	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":12,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:44.656	2017-08-14 18:30:44.812
42009	chain-1502706644827	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:44.839	2017-08-14 18:30:44.862
42030	chain-1502706645023	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:45.034	2017-08-14 18:30:45.121
42031	chain-1502706645212	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":15,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":15}}	192.168.3.132	2017-08-14 18:30:45.225	2017-08-14 18:30:45.346
42032	chain-1502706645387	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:45.399	2017-08-14 18:30:45.562
42033	chain-1502706645572	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:45.585	2017-08-14 18:30:45.595
42034	chain-1502706645755	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:45.766	2017-08-14 18:30:45.837
42055	chain-1502706645921	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:45.932	2017-08-14 18:30:46.054
42056	chain-1502706646089	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":12,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:46.099	2017-08-14 18:30:46.112
42057	chain-1502706646269	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:46.281	2017-08-14 18:30:46.363
42058	chain-1502706646455	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:46.466	2017-08-14 18:30:46.579
42059	chain-1502706646642	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":1,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:46.653	2017-08-14 18:30:46.837
42080	chain-1502706646822	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:46.833	2017-08-14 18:30:46.838
42081	chain-1502706647001	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:47.014	2017-08-14 18:30:47.112
42082	chain-1502706647182	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":1},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:47.194	2017-08-14 18:30:47.329
42083	chain-1502706647371	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":15,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":16}}	192.168.3.132	2017-08-14 18:30:47.384	2017-08-14 18:30:47.586
42084	chain-1502706647557	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:47.567	2017-08-14 18:30:47.896
42105	chain-1502706647833	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:47.845	2017-08-14 18:30:47.896
42106	chain-1502706648025	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:48.036	2017-08-14 18:30:48.123
42107	chain-1502706648225	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":8,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":23}}	192.168.3.132	2017-08-14 18:30:48.246	2017-08-14 18:30:48.346
42108	chain-1502706648434	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:48.445	2017-08-14 18:30:48.562
42109	chain-1502706648625	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:48.636	2017-08-14 18:30:48.779
42130	chain-1502706648814	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:48.825	2017-08-14 18:30:48.862
42131	chain-1502706649017	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":12,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:49.027	2017-08-14 18:30:49.095
42132	chain-1502706649223	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:49.234	2017-08-14 18:30:49.312
42133	chain-1502706649401	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:49.411	2017-08-14 18:30:49.537
42134	chain-1502706649587	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":15}}	192.168.3.132	2017-08-14 18:30:49.601	2017-08-14 18:30:49.754
42155	chain-1502706649781	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:49.792	2017-08-14 18:30:49.81
42156	chain-1502706649960	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:49.97	2017-08-14 18:30:50.054
42157	chain-1502706650135	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:50.146	2017-08-14 18:30:50.27
42158	chain-1502706650339	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":12,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":1},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:50.349	2017-08-14 18:30:50.504
42159	chain-1502706650558	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:50.57	2017-08-14 18:30:50.635
42180	chain-1502706650782	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:50.794	2017-08-14 18:30:50.912
42181	chain-1502706650957	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:50.968	2017-08-14 18:30:50.987
42182	chain-1502706651144	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:51.155	2017-08-14 18:30:51.27
42183	chain-1502706651325	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:51.335	2017-08-14 18:30:51.455
42184	chain-1502706651560	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":1,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:51.571	2017-08-14 18:30:51.747
42205	chain-1502706651745	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":12,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":1,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:51.756	2017-08-14 18:30:52.081
42206	chain-1502706652055	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:52.067	2017-08-14 18:30:52.153
42207	chain-1502706652256	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:52.267	2017-08-14 18:30:52.432
42208	chain-1502706652531	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":195,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":195}}	192.168.3.132	2017-08-14 18:30:52.724	2017-08-14 18:30:53.223
42209	chain-1502706653054	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":12,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":1,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:53.065	2017-08-14 18:30:53.224
42230	chain-1502706653235	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":11,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":11}}	192.168.3.132	2017-08-14 18:30:53.247	2017-08-14 18:30:53.47
42231	chain-1502706653421	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:53.432	2017-08-14 18:30:53.471
42232	chain-1502706653605	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":12,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":12}}	192.168.3.132	2017-08-14 18:30:53.615	2017-08-14 18:30:53.695
42233	chain-1502706653790	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:53.801	2017-08-14 18:30:53.92
42234	chain-1502706653973	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:53.984	2017-08-14 18:30:54.146
42255	chain-1502706654226	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:54.237	2017-08-14 18:30:54.401
42256	chain-1502706654411	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":32,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":32}}	192.168.3.132	2017-08-14 18:30:54.441	2017-08-14 18:30:54.473
42257	chain-1502706654648	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":1,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":19}}	192.168.3.132	2017-08-14 18:30:54.664	2017-08-14 18:30:54.778
42258	chain-1502706654918	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":12,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":12}}	192.168.3.132	2017-08-14 18:30:54.928	2017-08-14 18:30:55.012
42259	chain-1502706655139	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:55.151	2017-08-14 18:30:55.245
42280	chain-1502706655327	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":1},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:55.338	2017-08-14 18:30:55.462
42281	chain-1502706655815	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:55.826	2017-08-14 18:30:56.053
42282	chain-1502706656091	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":1,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":15}}	192.168.3.132	2017-08-14 18:30:56.104	2017-08-14 18:30:56.535
42283	chain-1502706656639	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":12,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":1},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:56.65	2017-08-14 18:30:56.795
42284	chain-1502706656422	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":1,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:56.433	2017-08-14 18:30:56.796
42305	chain-1502706656856	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:56.867	2017-08-14 18:30:57.11
42306	chain-1502706657113	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":32,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":32}}	192.168.3.132	2017-08-14 18:30:57.143	2017-08-14 18:30:57.362
42307	chain-1502706657370	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":169,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":170}}	192.168.3.132	2017-08-14 18:30:57.537	2017-08-14 18:30:57.726
42308	chain-1502706658125	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":12,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":1,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:58.135	2017-08-14 18:30:58.379
42309	chain-1502706658386	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":22,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":22}}	192.168.3.132	2017-08-14 18:30:58.406	2017-08-14 18:30:58.712
42330	chain-1502706658621	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14}}	192.168.3.132	2017-08-14 18:30:58.633	2017-08-14 18:30:59.015
42331	chain-1502706658998	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":17,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":17}}	192.168.3.132	2017-08-14 18:30:59.013	2017-08-14 18:30:59.262
42332	chain-1502706659199	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":13,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":13}}	192.168.3.132	2017-08-14 18:30:59.209	2017-08-14 18:30:59.262
42333	chain-1502706659398	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":15,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":1},"#Other#":{"[14][TOTAL]":16}}	192.168.3.132	2017-08-14 18:30:59.411	2017-08-14 18:30:59.75
42334	chain-1502706659583	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":12,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":12}}	192.168.3.132	2017-08-14 18:30:59.593	2017-08-14 18:30:59.751
42355	chain-1502706855255	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":21,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":57,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":108,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":1},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":57,"beanId":null,"count":1,"times":[57]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":5,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[5]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":72,"beanId":null,"count":1,"times":[72]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":199}}	192.168.3.132	2017-08-14 18:34:15.449	2017-08-14 18:34:15.581
42356	chain-1502706855550	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":19,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":19}}	192.168.3.132	2017-08-14 18:34:15.566	2017-08-14 18:34:15.582
42357	chain-1502707084142	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":32,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":15,"[8]lockHolder.extendLockForValidation()":0,"[17]remoteValidation()":350,"[18]handleException()":0,"[19]ready execute localUpdate":0,"[20]localUpdate()":1,"[21]startParallelExecution()":0,"[22]remoteUpdate Process()":1,"[23]afterCommit() for update":1},"#ChainMethodIndicator#":{"validatePairPickNotExistErpNum":{"name":"validatePairPickNotExistErpNum","costTime":10,"beanId":null,"count":1,"times":[10]},"validatePairOrders":{"name":"validatePairOrders","costTime":1,"beanId":null,"count":1,"times":[1]},"doPairOrdersValidateUpdate":{"name":"doPairOrdersValidateUpdate","costTime":28,"beanId":"coreOpenApiPairPickupChainUpdate","count":1,"times":[28]},"updatePairPickupOrder":{"name":"updatePairPickupOrder","costTime":0,"beanId":null,"count":1,"times":[0]},"preloadOrders":{"name":"preloadOrders","costTime":10,"beanId":null,"count":1,"times":[10]},"dispatchAssignDriverValidate":{"name":"dispatchAssignDriverValidate","costTime":204,"beanId":null,"count":1,"times":[204]},"createShipmentForNonOtmsVendor":{"name":"createShipmentForNonOtmsVendor","costTime":0,"beanId":null,"count":1,"times":[0]},"validateCreateShipmentForNonOtmsVendorChainUpdate":{"name":"validateCreateShipmentForNonOtmsVendorChainUpdate","costTime":0,"beanId":null,"count":1,"times":[0]},"updatePickupOrderMilestone":{"name":"updatePickupOrderMilestone","costTime":59,"beanId":null,"count":1,"times":[59]},"validateRegisterLeftHub":{"name":"validateRegisterLeftHub","costTime":1,"beanId":null,"count":1,"times":[1]}},"#Other#":{"[24][TOTAL]":426}}	192.168.3.132	2017-08-14 18:38:04.561	2017-08-14 18:38:04.6
42358	chain-1502707084948	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":22,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":23}}	192.168.3.132	2017-08-14 18:38:04.965	2017-08-14 18:38:05.057
42407	chain-1502710790280	{"#ChainStep#":{"[1]startLocalChain(name)":1,"[2]@ChainUpdate proceed":33,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":34,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":106,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":33,"beanId":null,"count":1,"times":[33]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":12,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[12]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":65,"beanId":null,"count":1,"times":[65]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":804}}	192.168.3.132	2017-08-14 19:39:51.07	2017-08-14 19:39:51.141
42359	chain-1502707267136	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":57,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":2073,"[8]lockHolder.extendLockForValidation()":0,"[17]remoteValidation()":3132,"[18]handleException()":0,"[19]ready execute localUpdate":0,"[20]localUpdate()":0,"[21]startParallelExecution()":0,"[22]remoteUpdate Process()":1,"[23]afterCommit() for update":0},"#ChainMethodIndicator#":{"validatePairPickNotExistErpNum":{"name":"validatePairPickNotExistErpNum","costTime":856,"beanId":null,"count":1,"times":[856]},"validatePairOrders":{"name":"validatePairOrders","costTime":1216,"beanId":null,"count":1,"times":[1216]},"doPairOrdersValidateUpdate":{"name":"doPairOrdersValidateUpdate","costTime":18,"beanId":"coreOpenApiPairPickupChainUpdate","count":1,"times":[18]},"updatePairPickupOrder":{"name":"updatePairPickupOrder","costTime":0,"beanId":null,"count":1,"times":[0]},"preloadOrders":{"name":"preloadOrders","costTime":11,"beanId":null,"count":1,"times":[11]},"dispatchAssignDriverValidate":{"name":"dispatchAssignDriverValidate","costTime":137,"beanId":null,"count":1,"times":[137]},"createShipmentForNonOtmsVendor":{"name":"createShipmentForNonOtmsVendor","costTime":0,"beanId":null,"count":1,"times":[0]},"validateCreateShipmentForNonOtmsVendorChainUpdate":{"name":"validateCreateShipmentForNonOtmsVendorChainUpdate","costTime":0,"beanId":null,"count":1,"times":[0]},"updatePickupOrderMilestone":{"name":"updatePickupOrderMilestone","costTime":25,"beanId":null,"count":1,"times":[25]},"validateRegisterLeftHub":{"name":"validateRegisterLeftHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[24][TOTAL]":7056}}	192.168.3.132	2017-08-14 18:41:14.187	2017-08-14 18:41:14.218
42380	chain-1502707299415	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":43,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":43}}	192.168.3.132	2017-08-14 18:41:39.452	2017-08-14 18:41:39.651
42381	chain-1502707811024	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":38,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":12,"[8]lockHolder.extendLockForValidation()":0,"[17]remoteValidation()":241,"[18]handleException()":0,"[19]ready execute localUpdate":0,"[20]localUpdate()":0,"[21]startParallelExecution()":0,"[22]remoteUpdate Process()":1,"[23]afterCommit() for update":0},"#ChainMethodIndicator#":{"validatePairPickNotExistErpNum":{"name":"validatePairPickNotExistErpNum","costTime":11,"beanId":null,"count":1,"times":[11]},"validatePairOrders":{"name":"validatePairOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"doPairOrdersValidateUpdate":{"name":"doPairOrdersValidateUpdate","costTime":27,"beanId":"coreOpenApiPairPickupChainUpdate","count":1,"times":[27]},"updatePairPickupOrder":{"name":"updatePairPickupOrder","costTime":0,"beanId":null,"count":1,"times":[0]},"preloadOrders":{"name":"preloadOrders","costTime":9,"beanId":null,"count":1,"times":[9]},"dispatchAssignDriverValidate":{"name":"dispatchAssignDriverValidate","costTime":151,"beanId":null,"count":1,"times":[151]},"createShipmentForNonOtmsVendor":{"name":"createShipmentForNonOtmsVendor","costTime":0,"beanId":null,"count":1,"times":[0]},"validateCreateShipmentForNonOtmsVendorChainUpdate":{"name":"validateCreateShipmentForNonOtmsVendorChainUpdate","costTime":0,"beanId":null,"count":1,"times":[0]},"updatePickupOrderMilestone":{"name":"updatePickupOrderMilestone","costTime":22,"beanId":null,"count":1,"times":[22]},"validateRegisterLeftHub":{"name":"validateRegisterLeftHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[24][TOTAL]":303}}	192.168.3.132	2017-08-14 18:50:11.314	2017-08-14 18:50:11.461
42382	chain-1502707829476	{"#ChainStep#":{"[1]startLocalChain(name)":1,"[2]@ChainUpdate proceed":58,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":60}}	192.168.3.132	2017-08-14 18:50:29.523	2017-08-14 18:50:29.692
42383	chain-1502708564053	{"#ChainStep#":{"[1]startLocalChain(name)":1,"[2]@ChainUpdate proceed":24,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":49,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":106,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":49,"beanId":null,"count":1,"times":[49]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":11,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[11]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":63,"beanId":null,"count":1,"times":[63]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":193}}	192.168.3.132	2017-08-14 19:02:44.226	2017-08-14 19:02:44.322
42384	chain-1502708564401	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":43,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":1},"#Other#":{"[14][TOTAL]":44}}	192.168.3.132	2017-08-14 19:02:44.423	2017-08-14 19:02:44.575
42405	chain-1502710735889	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":36,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":47,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":121,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":4},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":1,"beanId":null,"count":1,"times":[1]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":46,"beanId":null,"count":1,"times":[46]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":11,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[11]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":78,"beanId":null,"count":1,"times":[78]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":220}}	192.168.3.132	2017-08-14 19:38:56.106	2017-08-14 19:38:56.272
42406	chain-1502710742174	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":34,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":35}}	192.168.3.132	2017-08-14 19:39:02.164	2017-08-14 19:39:02.29
42408	chain-1502710798147	{"#ChainStep#":{"[1]startLocalChain(name)":1032,"[2]@ChainUpdate proceed":11882,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":14358}}	192.168.3.132	2017-08-14 19:40:12.462	2017-08-14 19:40:12.577
42409	chain-1502710853052	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":26,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":61,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":76,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":60,"beanId":null,"count":1,"times":[60]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":6,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[6]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":42,"beanId":null,"count":1,"times":[42]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":176}}	192.168.3.132	2017-08-14 19:40:53.201	2017-08-14 19:40:53.22
42430	chain-1502710875994	{"#ChainStep#":{"[1]startLocalChain(name)":1,"[2]@ChainUpdate proceed":2290,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":2291}}	192.168.3.132	2017-08-14 19:41:18.246	2017-08-14 19:41:18.26
42431	chain-1502710912522	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":22,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":39,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":75,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":39,"beanId":null,"count":1,"times":[39]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":7,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[7]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":42,"beanId":null,"count":1,"times":[42]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":151}}	192.168.3.132	2017-08-14 19:41:52.646	2017-08-14 19:41:52.714
42432	chain-1502710950856	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":227,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":228}}	192.168.3.132	2017-08-14 19:42:31.036	2017-08-14 19:42:31.159
42433	chain-1502710987035	{"#ChainStep#":{"[1]startLocalChain(name)":1037,"[2]@ChainUpdate proceed":1207,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":36,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":87,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":35,"beanId":null,"count":1,"times":[35]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":10,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[10]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":48,"beanId":null,"count":1,"times":[48]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":3122}}	192.168.3.132	2017-08-14 19:43:10.131	2017-08-14 19:43:10.196
42434	chain-1502711016404	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":21,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":21}}	192.168.3.132	2017-08-14 19:43:36.377	2017-08-14 19:43:36.43
42455	chain-1502711198036	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":39,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":42,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":190,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":42,"beanId":null,"count":1,"times":[42]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":29,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[29]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":78,"beanId":null,"count":1,"times":[78]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":286}}	192.168.3.132	2017-08-14 19:46:38.311	2017-08-14 19:46:38.385
42456	chain-1502711242124	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":95,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":1,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":96}}	192.168.3.132	2017-08-14 19:47:22.171	2017-08-14 19:47:22.237
42457	chain-1502711986510	{"#ChainStep#":{"[1]startLocalChain(name)":8,"[2]@ChainUpdate proceed":124,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":132,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":531,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":3,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":17,"[19]afterCommit() for update":3},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":2,"beanId":null,"count":1,"times":[2]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":122,"beanId":null,"count":1,"times":[122]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":57,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[57]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":308,"beanId":null,"count":1,"times":[308]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1049}}	192.168.3.132	2017-08-14 19:59:49.808	2017-08-14 19:59:49.883
42458	chain-1502711993528	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":3894,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":5,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":6},"#Other#":{"[14][TOTAL]":5645}}	192.168.3.132	2017-08-14 19:59:59.15	2017-08-14 19:59:59.187
42459	chain-1502712034389	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":20,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":36,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":96,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":1,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":7,"[19]afterCommit() for update":3},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":28,"beanId":null,"count":1,"times":[28]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":8,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[8]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":51,"beanId":null,"count":1,"times":[51]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":1,"beanId":null,"count":1,"times":[1]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":177}}	192.168.3.132	2017-08-14 20:00:34.635	2017-08-14 20:00:34.831
42480	chain-1502712049629	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":418,"[3]navigateTillExhausted()":1,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":1,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":422}}	192.168.3.132	2017-08-14 20:00:49.994	2017-08-14 20:00:50.054
42481	chain-1502712128541	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":38,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":54,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":146,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":2,"[19]afterCommit() for update":2},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":53,"beanId":null,"count":1,"times":[53]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":10,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[10]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":86,"beanId":null,"count":1,"times":[86]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":262}}	192.168.3.132	2017-08-14 20:02:09.03	2017-08-14 20:02:09.132
42482	chain-1502712133382	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":872,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":873}}	192.168.3.132	2017-08-14 20:02:14.2	2017-08-14 20:02:14.245
42483	chain-1502712180654	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":20,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":31,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":120,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":9,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":1},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":30,"beanId":null,"count":1,"times":[30]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":7,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[7]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":64,"beanId":null,"count":1,"times":[64]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":194}}	192.168.3.132	2017-08-14 20:03:00.903	2017-08-14 20:03:01.093
42484	chain-1502712210773	{"#ChainStep#":{"[1]startLocalChain(name)":1,"[2]@ChainUpdate proceed":629,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":1,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":631}}	192.168.3.132	2017-08-14 20:03:31.343	2017-08-14 20:03:31.526
42731	chain-1502780599627	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":21,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]acquireInitialLock()":0,"[6]localValidation()":0,"[7]lockHolder.extendLockForValidation()":0,"[8]remoteValidation()":0,"[9]handleException()":0,"[10]ready execute localUpdate":0,"[11]localUpdate()":0,"[12]startParallelExecution()":0,"[13]remoteUpdate Process()":0,"[14]afterCommit() for update":1,"[15]all Update":1,"[16]LoggerSupplier.log()":0},"#Other#":{"[17][TOTAL]":22}}	192.168.3.132	2017-08-15 15:03:18.784	2017-08-15 15:03:18.992
42505	chain-1502712217741	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":17,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":34,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":101,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":33,"beanId":null,"count":1,"times":[33]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":5,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[5]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":58,"beanId":null,"count":1,"times":[58]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":166}}	192.168.3.132	2017-08-14 20:03:37.871	2017-08-14 20:03:37.941
42506	chain-1502712247726	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":430,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":1,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":431}}	192.168.3.132	2017-08-14 20:04:08.094	2017-08-14 20:04:08.214
42507	chain-1502712301013	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":23,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":53,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":128,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":1},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":49,"beanId":null,"count":1,"times":[49]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":7,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[7]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":82,"beanId":null,"count":1,"times":[82]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":1,"beanId":null,"count":1,"times":[1]}},"#Other#":{"[20][TOTAL]":228}}	192.168.3.132	2017-08-14 20:05:01.179	2017-08-14 20:05:01.272
42508	chain-1502712326029	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":490,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":490}}	192.168.3.132	2017-08-14 20:05:26.458	2017-08-14 20:05:26.528
42509	chain-1502712573694	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":33,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":39,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":166,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":1,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":37,"beanId":null,"count":1,"times":[37]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":18,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[18]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":71,"beanId":null,"count":1,"times":[71]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":283}}	192.168.3.132	2017-08-14 20:09:33.912	2017-08-14 20:09:33.915
42530	chain-1502712589646	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":20,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":20}}	192.168.3.132	2017-08-14 20:09:49.601	2017-08-14 20:09:49.788
42531	chain-1502712877527	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":30,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":50,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":3225,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":49,"beanId":null,"count":1,"times":[49]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":12,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[12]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":3175,"beanId":null,"count":1,"times":[3175]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":3321}}	192.168.3.132	2017-08-14 20:14:40.786	2017-08-14 20:14:40.827
42532	chain-1502712905182	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":79,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":80}}	192.168.3.132	2017-08-14 20:15:05.193	2017-08-14 20:15:05.284
42732	chain-1502780599893	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":35,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]acquireInitialLock()":0,"[6]localValidation()":0,"[7]lockHolder.extendLockForValidation()":0,"[8]remoteValidation()":0,"[9]handleException()":0,"[10]ready execute localUpdate":0,"[11]localUpdate()":0,"[12]startParallelExecution()":0,"[13]remoteUpdate Process()":0,"[14]afterCommit() for update":1,"[15]all Update":1,"[16]LoggerSupplier.log()":0},"#Other#":{"[17][TOTAL]":36}}	192.168.3.132	2017-08-15 15:03:19.068	2017-08-15 15:03:19.209
42533	chain-1502712977742	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":29,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":59,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":140,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":1,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":58,"beanId":null,"count":1,"times":[58]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":7,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[7]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":84,"beanId":null,"count":1,"times":[84]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":1,"beanId":null,"count":1,"times":[1]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":250}}	192.168.3.132	2017-08-14 20:16:17.921	2017-08-14 20:16:17.951
42534	chain-1502712983825	{"#ChainStep#":{"[1]startLocalChain(name)":702,"[2]@ChainUpdate proceed":42,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":1249}}	192.168.3.132	2017-08-14 20:16:28.609	2017-08-14 20:16:28.8
42555	chain-1502713008103	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":25,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":40,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":92,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":1,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":39,"beanId":null,"count":1,"times":[39]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":8,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[8]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":52,"beanId":null,"count":1,"times":[52]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":174}}	192.168.3.132	2017-08-14 20:16:48.205	2017-08-14 20:16:48.231
42556	chain-1502713013990	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":17339,"[3]navigateTillExhausted()":21,"[4]checkChainValid()":12,"[5]localValidation()":37,"[6]lockHolder.extendLockForValidation()":10,"[7]remoteValidation()":10,"[8]handleException()":19,"[9]ready execute localUpdate":33,"[10]localUpdate()":1,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":1},"#Other#":{"[14][TOTAL]":17590}}	192.168.3.132	2017-08-14 20:17:12.671	2017-08-14 20:17:12.681
42557	chain-1502713055526	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":26,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":39,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":83,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":38,"beanId":null,"count":1,"times":[38]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":7,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[7]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":46,"beanId":null,"count":1,"times":[46]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":161}}	192.168.3.132	2017-08-14 20:17:35.615	2017-08-14 20:17:35.732
42558	chain-1502713062582	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":22786,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":22787}}	192.168.3.132	2017-08-14 20:18:07.999	2017-08-14 20:18:08.002
42559	chain-1502713508574	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":22,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":39,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":111,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":37,"beanId":null,"count":1,"times":[37]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":12,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[12]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":70,"beanId":null,"count":1,"times":[70]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":186}}	192.168.3.132	2017-08-14 20:25:08.682	2017-08-14 20:25:08.751
42580	chain-1502713527343	{"#ChainStep#":{"[1]startLocalChain(name)":1670,"[2]@ChainUpdate proceed":7507,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":9849}}	192.168.3.132	2017-08-14 20:25:37.12	2017-08-14 20:25:37.192
42733	chain-1502780600114	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":15,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]acquireInitialLock()":0,"[6]localValidation()":0,"[7]lockHolder.extendLockForValidation()":0,"[8]remoteValidation()":0,"[9]handleException()":0,"[10]ready execute localUpdate":0,"[11]localUpdate()":0,"[12]startParallelExecution()":0,"[13]remoteUpdate Process()":0,"[14]afterCommit() for update":0,"[15]all Update":0,"[16]LoggerSupplier.log()":0},"#Other#":{"[17][TOTAL]":15}}	192.168.3.132	2017-08-15 15:03:19.262	2017-08-15 15:03:19.425
42581	chain-1502713620907	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":26,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":37,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":1246,"[14]handleException()":0,"[15]ready execute localUpdate":1,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":0,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":36,"beanId":null,"count":1,"times":[36]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":12,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[12]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":1202,"beanId":null,"count":1,"times":[1202]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1322}}	192.168.3.132	2017-08-14 20:27:02.149	2017-08-14 20:27:02.273
42582	chain-1502713630445	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":38,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":39}}	192.168.3.132	2017-08-14 20:27:10.403	2017-08-14 20:27:10.528
42583	chain-1502713640211	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":15,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":39,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":2396,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":38,"beanId":null,"count":1,"times":[38]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":7,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[7]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":2359,"beanId":null,"count":1,"times":[2359]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":2463}}	192.168.3.132	2017-08-14 20:27:22.597	2017-08-14 20:27:22.748
42584	chain-1502713653560	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":45,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":45}}	192.168.3.132	2017-08-14 20:27:33.525	2017-08-14 20:27:33.587
42605	chain-1502713660874	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":30,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":1549,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":1,"[19]afterCommit() for update":1},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":30,"beanId":null,"count":1,"times":[30]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":6,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[6]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":1512,"beanId":null,"count":1,"times":[1512]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1605}}	192.168.3.132	2017-08-14 20:27:42.399	2017-08-14 20:27:42.404
42606	chain-1502713674099	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":64,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":1,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":65}}	192.168.3.132	2017-08-14 20:27:54.087	2017-08-14 20:27:54.265
42607	chain-1502761825531	{"#ChainStep#":{"[1]startLocalChain(name)":22,"[2]@ChainUpdate proceed":86,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":91,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":2408,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":11,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":61,"[19]afterCommit() for update":3},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":3,"beanId":null,"count":1,"times":[3]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":74,"beanId":null,"count":1,"times":[74]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":29,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[29]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":2174,"beanId":null,"count":1,"times":[2174]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":1,"beanId":null,"count":1,"times":[1]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":2787}}	192.168.3.132	2017-08-15 09:50:28.269	2017-08-15 09:50:28.276
42608	chain-1502761834159	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":133,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":4,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":23},"#Other#":{"[14][TOTAL]":160}}	192.168.3.132	2017-08-15 09:50:33.765	2017-08-15 09:50:33.922
42734	chain-1502780600389	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":23,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]acquireInitialLock()":0,"[6]localValidation()":0,"[7]lockHolder.extendLockForValidation()":0,"[8]remoteValidation()":0,"[9]handleException()":0,"[10]ready execute localUpdate":0,"[11]localUpdate()":0,"[12]startParallelExecution()":0,"[13]remoteUpdate Process()":0,"[14]afterCommit() for update":0,"[15]all Update":0,"[16]LoggerSupplier.log()":0},"#Other#":{"[17][TOTAL]":23}}	192.168.3.132	2017-08-15 15:03:19.545	2017-08-15 15:03:19.658
42609	chain-1502761862624	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":21,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":34,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":1664,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":13,"[19]afterCommit() for update":1},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":33,"beanId":null,"count":1,"times":[33]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":9,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[9]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":1609,"beanId":null,"count":1,"times":[1609]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":1745}}	192.168.3.132	2017-08-15 09:51:03.754	2017-08-15 09:51:03.758
42630	chain-1502761865686	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":58,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":1,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":59}}	192.168.3.132	2017-08-15 09:51:05.128	2017-08-15 09:51:05.21
42631	chain-1502761915349	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":18,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":32,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":105,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":1,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":5,"[19]afterCommit() for update":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":31,"beanId":null,"count":1,"times":[31]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":7,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[7]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":67,"beanId":null,"count":1,"times":[67]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":172}}	192.168.3.132	2017-08-15 09:51:54.912	2017-08-15 09:51:55.064
42632	chain-1502761915719	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":66,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":1,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":67}}	192.168.3.132	2017-08-15 09:51:55.166	2017-08-15 09:51:55.302
42633	chain-1502762481186	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":42,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":58,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":138,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":2,"[19]afterCommit() for update":1},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":58,"beanId":null,"count":1,"times":[58]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":11,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[11]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":80,"beanId":null,"count":1,"times":[80]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":1,"beanId":null,"count":1,"times":[1]}},"#Other#":{"[20][TOTAL]":261}}	192.168.3.132	2017-08-15 10:01:20.823	2017-08-15 10:01:20.933
42634	chain-1502762481704	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":88,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":91}}	192.168.3.132	2017-08-15 10:01:21.18	2017-08-15 10:01:21.348
42655	chain-1502777931943	{"#ChainStep#":{"[1]startLocalChain(name)":24,"[2]@ChainUpdate proceed":113,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":60,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":358,"[14]handleException()":0,"[15]ready execute localUpdate":0,"[16]localUpdate()":6,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":27,"[19]afterCommit() for update":4},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":2,"beanId":null,"count":1,"times":[2]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":50,"beanId":null,"count":1,"times":[50]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":18,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[18]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":204,"beanId":null,"count":1,"times":[204]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":702}}	192.168.3.132	2017-08-15 14:18:52.204	2017-08-15 14:18:52.236
42656	chain-1502777934162	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":47,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":1,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":1},"#Other#":{"[14][TOTAL]":51}}	192.168.3.132	2017-08-15 14:18:53.409	2017-08-15 14:18:53.447
42755	chain-1502780600652	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":23,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]acquireInitialLock()":0,"[6]localValidation()":0,"[7]lockHolder.extendLockForValidation()":0,"[8]remoteValidation()":0,"[9]handleException()":0,"[10]ready execute localUpdate":0,"[11]localUpdate()":0,"[12]startParallelExecution()":0,"[13]remoteUpdate Process()":0,"[14]afterCommit() for update":0,"[15]all Update":0,"[16]LoggerSupplier.log()":0},"#Other#":{"[17][TOTAL]":23}}	192.168.3.132	2017-08-15 15:03:19.807	2017-08-15 15:03:19.9
42657	chain-1502778073449	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":36,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":62,"[8]lockHolder.extendLockForValidation()":0,"[13]remoteValidation()":143,"[14]handleException()":1,"[15]ready execute localUpdate":0,"[16]localUpdate()":0,"[17]startParallelExecution()":0,"[18]remoteUpdate Process()":10,"[19]afterCommit() for update":4},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":49,"beanId":null,"count":1,"times":[49]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":12,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[12]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":80,"beanId":null,"count":1,"times":[80]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":0,"beanId":null,"count":1,"times":[0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[20][TOTAL]":274}}	192.168.3.132	2017-08-15 14:21:12.905	2017-08-15 14:21:12.976
42658	chain-1502778074267	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":92,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":93}}	192.168.3.132	2017-08-15 14:21:13.542	2017-08-15 14:21:13.665
42659	chain-1502778197851	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":52,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":20,"[8]lockHolder.extendLockForValidation()":0,"[17]remoteValidation()":3289,"[18]handleException()":0,"[19]ready execute localUpdate":0,"[20]localUpdate()":1,"[21]startParallelExecution()":0,"[22]remoteUpdate Process()":1,"[23]afterCommit() for update":2},"#ChainMethodIndicator#":{"validatePairPickNotExistErpNum":{"name":"validatePairPickNotExistErpNum","costTime":14,"beanId":null,"count":1,"times":[14]},"validatePairOrders":{"name":"validatePairOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"doPairOrdersValidateUpdate":{"name":"doPairOrdersValidateUpdate","costTime":39,"beanId":"coreOpenApiPairPickupChainUpdate","count":1,"times":[39]},"updatePairPickupOrder":{"name":"updatePairPickupOrder","costTime":2919,"beanId":null,"count":1,"times":[2919]},"preloadOrders":{"name":"preloadOrders","costTime":12,"beanId":null,"count":1,"times":[12]},"dispatchAssignDriverValidate":{"name":"dispatchAssignDriverValidate","costTime":207,"beanId":null,"count":1,"times":[207]},"createShipmentForNonOtmsVendor":{"name":"createShipmentForNonOtmsVendor","costTime":0,"beanId":null,"count":1,"times":[0]},"validateCreateShipmentForNonOtmsVendorChainUpdate":{"name":"validateCreateShipmentForNonOtmsVendorChainUpdate","costTime":0,"beanId":null,"count":1,"times":[0]},"updatePickupOrderMilestone":{"name":"updatePickupOrderMilestone","costTime":67,"beanId":null,"count":1,"times":[67]},"validateRegisterLeftHub":{"name":"validateRegisterLeftHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[24][TOTAL]":3387}}	192.168.3.132	2017-08-15 14:23:20.41	2017-08-15 14:23:20.562
42680	chain-1502778201486	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":59,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":66}}	192.168.3.132	2017-08-15 14:23:20.721	2017-08-15 14:23:20.776
42681	chain-1502778219479	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":34,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[7]localValidation()":21,"[8]lockHolder.extendLockForValidation()":0,"[17]remoteValidation()":293,"[18]handleException()":0,"[19]ready execute localUpdate":0,"[20]localUpdate()":1,"[21]startParallelExecution()":0,"[22]remoteUpdate Process()":1,"[23]afterCommit() for update":0},"#ChainMethodIndicator#":{"validatePairPickNotExistErpNum":{"name":"validatePairPickNotExistErpNum","costTime":12,"beanId":null,"count":1,"times":[12]},"validatePairOrders":{"name":"validatePairOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"doPairOrdersValidateUpdate":{"name":"doPairOrdersValidateUpdate","costTime":19,"beanId":"coreOpenApiPairPickupChainUpdate","count":1,"times":[19]},"updatePairPickupOrder":{"name":"updatePairPickupOrder","costTime":0,"beanId":null,"count":1,"times":[0]},"preloadOrders":{"name":"preloadOrders","costTime":12,"beanId":null,"count":1,"times":[12]},"dispatchAssignDriverValidate":{"name":"dispatchAssignDriverValidate","costTime":157,"beanId":null,"count":1,"times":[157]},"createShipmentForNonOtmsVendor":{"name":"createShipmentForNonOtmsVendor","costTime":0,"beanId":null,"count":1,"times":[0]},"validateCreateShipmentForNonOtmsVendorChainUpdate":{"name":"validateCreateShipmentForNonOtmsVendorChainUpdate","costTime":0,"beanId":null,"count":1,"times":[0]},"updatePickupOrderMilestone":{"name":"updatePickupOrderMilestone","costTime":21,"beanId":null,"count":1,"times":[21]},"validateRegisterLeftHub":{"name":"validateRegisterLeftHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[24][TOTAL]":378}}	192.168.3.132	2017-08-15 14:23:39.079	2017-08-15 14:23:39.214
42682	chain-1502778220026	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":33,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]localValidation()":0,"[6]lockHolder.extendLockForValidation()":0,"[7]remoteValidation()":0,"[8]handleException()":0,"[9]ready execute localUpdate":0,"[10]localUpdate()":0,"[11]startParallelExecution()":0,"[12]remoteUpdate Process()":0,"[13]afterCommit() for update":0},"#Other#":{"[14][TOTAL]":33}}	192.168.3.132	2017-08-15 14:23:39.229	2017-08-15 14:23:39.425
42683	chain-1502779562726	{"#ChainStep#":{"[1]startLocalChain(name)":20,"[2]@ChainUpdate proceed":88,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]acquireInitialLock()":65},"#ChainMethodIndicator#":{"validatePairPickNotExistErpNum":{"name":"validatePairPickNotExistErpNum","costTime":17,"beanId":null,"count":1,"times":[17]},"ChainExecutionStatus.getNextLocalValidation":{"name":"ChainExecutionStatus.getNextLocalValidation","costTime":0,"beanId":null,"count":1,"times":[0]},"validatePairOrders":{"name":"validatePairOrders","costTime":2,"beanId":null,"count":1,"times":[2]}},"#Other#":{"[9][TOTAL]":201}}	192.168.3.132	2017-08-15 14:46:02.303	2017-08-15 14:46:02.444
42756	chain-1502780600888	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":20,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":1,"[5]acquireInitialLock()":0,"[6]localValidation()":0,"[7]lockHolder.extendLockForValidation()":0,"[8]remoteValidation()":0,"[9]handleException()":0,"[10]ready execute localUpdate":0,"[11]localUpdate()":0,"[12]startParallelExecution()":0,"[13]remoteUpdate Process()":0,"[14]afterCommit() for update":0,"[15]all Update":0,"[16]LoggerSupplier.log()":0},"#Other#":{"[17][TOTAL]":21}}	192.168.3.132	2017-08-15 15:03:20.041	2017-08-15 15:03:20.117
42684	chain-1502780102464	{"#ChainStep#":{"[1]startLocalChain(name)":13,"[2]@ChainUpdate proceed":108,"[3]navigateTillExhausted()":1,"[4]checkChainValid()":0,"[5]acquireInitialLock()":78,"[10]localValidation()":32,"[11]lockHolder.extendLockForValidation()":0,"[28]remoteValidation()":545,"[29]handleException()":0,"[30]ready execute localUpdate":0,"[31]localUpdate()":4,"[32]startParallelExecution()":0,"[33]remoteUpdate Process()":20,"[34]afterCommit() for update":3,"[35]all Update":50,"[36]LoggerSupplier.log()":1},"#ChainMethodIndicator#":{"validatePairPickNotExistErpNum":{"name":"validatePairPickNotExistErpNum","costTime":19,"beanId":null,"count":1,"times":[19]},"ChainExecutionStatus.getNextLocalValidation":{"name":"ChainExecutionStatus.getNextLocalValidation","costTime":0,"beanId":null,"count":10,"times":[0,0,0,0,0,0,0,0,0,0]},"validatePairOrders":{"name":"validatePairOrders","costTime":2,"beanId":null,"count":1,"times":[2]},"doPairOrdersValidateUpdate":{"name":"doPairOrdersValidateUpdate","costTime":40,"beanId":"coreOpenApiPairPickupChainUpdate","count":1,"times":[40]},"updatePairPickupOrder":{"name":"updatePairPickupOrder","costTime":0,"beanId":null,"count":1,"times":[0]},"preloadOrders":{"name":"preloadOrders","costTime":14,"beanId":null,"count":1,"times":[14]},"dispatchAssignDriverValidate":{"name":"dispatchAssignDriverValidate","costTime":238,"beanId":null,"count":1,"times":[238]},"createShipmentForNonOtmsVendor":{"name":"createShipmentForNonOtmsVendor","costTime":0,"beanId":null,"count":1,"times":[0]},"validateCreateShipmentForNonOtmsVendorChainUpdate":{"name":"validateCreateShipmentForNonOtmsVendorChainUpdate","costTime":0,"beanId":null,"count":1,"times":[0]},"updatePickupOrderMilestone":{"name":"updatePickupOrderMilestone","costTime":154,"beanId":null,"count":1,"times":[154]},"validateRegisterLeftHub":{"name":"validateRegisterLeftHub","costTime":1,"beanId":null,"count":1,"times":[1]}},"#Other#":{"[37][TOTAL]":828}}	192.168.3.132	2017-08-15 14:55:02.715	2017-08-15 14:55:02.746
42705	chain-1502780104105	{"#ChainStep#":{"[1]startLocalChain(name)":1,"[2]@ChainUpdate proceed":77,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]acquireInitialLock()":0,"[6]localValidation()":0,"[7]lockHolder.extendLockForValidation()":0,"[8]remoteValidation()":0,"[9]handleException()":0,"[10]ready execute localUpdate":0,"[11]localUpdate()":2,"[12]startParallelExecution()":0,"[13]remoteUpdate Process()":0,"[14]afterCommit() for update":1,"[15]all Update":3,"[16]LoggerSupplier.log()":0},"#Other#":{"[17][TOTAL]":81}}	192.168.3.132	2017-08-15 14:55:03.327	2017-08-15 14:55:03.411
42706	chain-1502780119653	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":27,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]acquireInitialLock()":6,"[10]localValidation()":15,"[11]lockHolder.extendLockForValidation()":0,"[28]remoteValidation()":177,"[29]handleException()":0,"[30]ready execute localUpdate":1,"[31]localUpdate()":5,"[32]startParallelExecution()":0,"[33]remoteUpdate Process()":1,"[34]afterCommit() for update":1,"[35]all Update":19,"[36]LoggerSupplier.log()":0},"#ChainMethodIndicator#":{"validatePairPickNotExistErpNum":{"name":"validatePairPickNotExistErpNum","costTime":7,"beanId":null,"count":1,"times":[7]},"ChainExecutionStatus.getNextLocalValidation":{"name":"ChainExecutionStatus.getNextLocalValidation","costTime":0,"beanId":null,"count":10,"times":[0,0,0,0,0,0,0,0,0,0]},"validatePairOrders":{"name":"validatePairOrders","costTime":0,"beanId":null,"count":1,"times":[0]},"doPairOrdersValidateUpdate":{"name":"doPairOrdersValidateUpdate","costTime":13,"beanId":"coreOpenApiPairPickupChainUpdate","count":1,"times":[13]},"updatePairPickupOrder":{"name":"updatePairPickupOrder","costTime":0,"beanId":null,"count":1,"times":[0]},"preloadOrders":{"name":"preloadOrders","costTime":5,"beanId":null,"count":1,"times":[5]},"dispatchAssignDriverValidate":{"name":"dispatchAssignDriverValidate","costTime":94,"beanId":null,"count":1,"times":[94]},"createShipmentForNonOtmsVendor":{"name":"createShipmentForNonOtmsVendor","costTime":0,"beanId":null,"count":1,"times":[0]},"validateCreateShipmentForNonOtmsVendorChainUpdate":{"name":"validateCreateShipmentForNonOtmsVendorChainUpdate","costTime":0,"beanId":null,"count":1,"times":[0]},"updatePickupOrderMilestone":{"name":"updatePickupOrderMilestone","costTime":22,"beanId":null,"count":1,"times":[22]},"validateRegisterLeftHub":{"name":"validateRegisterLeftHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[37][TOTAL]":245}}	192.168.3.132	2017-08-15 14:55:19.043	2017-08-15 14:55:19.238
42707	chain-1502780120141	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":24,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]acquireInitialLock()":0,"[6]localValidation()":0,"[7]lockHolder.extendLockForValidation()":0,"[8]remoteValidation()":0,"[9]handleException()":0,"[10]ready execute localUpdate":0,"[11]localUpdate()":0,"[12]startParallelExecution()":0,"[13]remoteUpdate Process()":0,"[14]afterCommit() for update":0,"[15]all Update":1,"[16]LoggerSupplier.log()":0},"#Other#":{"[17][TOTAL]":25}}	192.168.3.132	2017-08-15 14:55:19.306	2017-08-15 14:55:19.451
42708	chain-1502780596919	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":101,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]acquireInitialLock()":22,"[10]localValidation()":105,"[11]lockHolder.extendLockForValidation()":0,"[56]remoteValidation()":327,"[57]handleException()":0,"[58]ready execute localUpdate":0,"[59]localUpdate()":2,"[60]startParallelExecution()":0,"[61]remoteUpdate Process()":18,"[62]afterCommit() for update":10,"[63]all Update":41,"[64]LoggerSupplier.log()":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":1,"beanId":null,"count":1,"times":[1]},"ChainExecutionStatus.getNextLocalValidation":{"name":"ChainExecutionStatus.getNextLocalValidation","costTime":0,"beanId":null,"count":24,"times":[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":99,"beanId":null,"count":1,"times":[99]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":21,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[21]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":160,"beanId":null,"count":1,"times":[160]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":1,"beanId":null,"count":10,"times":[0,0,1,0,0,0,0,0,0,0]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":10,"times":[0,0,0,0,0,0,0,0,0,0]}},"#Other#":{"[65][TOTAL]":596}}	192.168.3.132	2017-08-15 15:03:16.725	2017-08-15 15:03:16.793
42709	chain-1502780598734	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":53,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]acquireInitialLock()":0,"[6]localValidation()":0,"[7]lockHolder.extendLockForValidation()":0,"[8]remoteValidation()":0,"[9]handleException()":0,"[10]ready execute localUpdate":0,"[11]localUpdate()":0,"[12]startParallelExecution()":0,"[13]remoteUpdate Process()":0,"[14]afterCommit() for update":0,"[15]all Update":1,"[16]LoggerSupplier.log()":0},"#Other#":{"[17][TOTAL]":54}}	192.168.3.132	2017-08-15 15:03:17.923	2017-08-15 15:03:18.075
42730	chain-1502780599260	{"#ChainStep#":{"[1]startLocalChain(name)":2,"[2]@ChainUpdate proceed":44,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]acquireInitialLock()":0,"[6]localValidation()":0,"[7]lockHolder.extendLockForValidation()":0,"[8]remoteValidation()":0,"[9]handleException()":0,"[10]ready execute localUpdate":0,"[11]localUpdate()":0,"[12]startParallelExecution()":0,"[13]remoteUpdate Process()":0,"[14]afterCommit() for update":0,"[15]all Update":1,"[16]LoggerSupplier.log()":0},"#Other#":{"[17][TOTAL]":47}}	192.168.3.132	2017-08-15 15:03:18.459	2017-08-15 15:03:18.492
42757	chain-1502780601092	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":24,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]acquireInitialLock()":0,"[6]localValidation()":0,"[7]lockHolder.extendLockForValidation()":0,"[8]remoteValidation()":0,"[9]handleException()":0,"[10]ready execute localUpdate":0,"[11]localUpdate()":0,"[12]startParallelExecution()":0,"[13]remoteUpdate Process()":0,"[14]afterCommit() for update":0,"[15]all Update":1,"[16]LoggerSupplier.log()":0},"#Other#":{"[17][TOTAL]":25}}	192.168.3.132	2017-08-15 15:03:20.251	2017-08-15 15:03:20.333
42758	chain-1502780601318	{"#ChainStep#":{"[1]startLocalChain(name)":1,"[2]@ChainUpdate proceed":14,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]acquireInitialLock()":0,"[6]localValidation()":0,"[7]lockHolder.extendLockForValidation()":0,"[8]remoteValidation()":0,"[9]handleException()":0,"[10]ready execute localUpdate":0,"[11]localUpdate()":0,"[12]startParallelExecution()":0,"[13]remoteUpdate Process()":0,"[14]afterCommit() for update":1,"[15]all Update":1,"[16]LoggerSupplier.log()":0},"#Other#":{"[17][TOTAL]":16}}	192.168.3.132	2017-08-15 15:03:20.465	2017-08-15 15:03:20.567
42759	chain-1502781854460	{"#ChainStep#":{"[1]startLocalChain(name)":14,"[2]@ChainUpdate proceed":85,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]acquireInitialLock()":67,"[8]localValidation()":65,"[9]lockHolder.extendLockForValidation()":0,"[18]remoteValidation()":321,"[19]handleException()":0,"[20]ready execute localUpdate":1,"[21]localUpdate()":12,"[22]startParallelExecution()":0,"[23]remoteUpdate Process()":17,"[24]afterCommit() for update":6,"[25]all Update":56,"[26]LoggerSupplier.log()":0},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":2,"beanId":null,"count":1,"times":[2]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":55,"beanId":null,"count":1,"times":[55]},"getNextCompanyForValidation":{"name":"getNextCompanyForValidation","costTime":0,"beanId":null,"count":2,"times":[0,0]},"handleReceivedRemoteValidation.resume":{"name":"handleReceivedRemoteValidation.resume","costTime":0,"beanId":null,"count":1,"times":[0]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":22,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[22]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":205,"beanId":null,"count":1,"times":[205]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":1,"beanId":null,"count":1,"times":[1]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]},"remove":{"name":"remove","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[27][TOTAL]":609}}	192.168.3.132	2017-08-15 15:24:14.616	2017-08-15 15:24:14.678
42780	chain-1502781856275	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":59,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]acquireInitialLock()":0,"[6]localValidation()":0,"[7]lockHolder.extendLockForValidation()":0,"[9]remoteValidation()":0,"[10]handleException()":0,"[11]ready execute localUpdate":0,"[12]localUpdate()":2,"[13]startParallelExecution()":0,"[14]remoteUpdate Process()":0,"[15]afterCommit() for update":2,"[16]all Update":4,"[17]LoggerSupplier.log()":0},"#ChainMethodIndicator#":{"getNextCompanyForValidation":{"name":"getNextCompanyForValidation","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[18][TOTAL]":63}}	192.168.3.132	2017-08-15 15:24:15.51	2017-08-15 15:24:15.7
42781	chain-1502783661939	{"#ChainStep#":{"[1]startLocalChain(name)":68,"[2]@ChainUpdate proceed":105,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]acquireInitialLock()":80,"[8]localValidation()":69,"[9]lockHolder.extendLockForValidation()":0,"[14]remoteValidation()":344,"[15]handleException()":0,"[16]ready execute localUpdate":0,"[17]localUpdate()":3,"[18]startParallelExecution()":0,"[19]remoteUpdate Process()":25,"[20]afterCommit() for update":7,"[21]all Update":74,"[22]LoggerSupplier.log()":32},"#ChainMethodIndicator#":{"validateLeafOrders":{"name":"validateLeafOrders","costTime":2,"beanId":null,"count":1,"times":[2]},"validatePairDeliveryConfirmation":{"name":"validatePairDeliveryConfirmation","costTime":59,"beanId":null,"count":1,"times":[59]},"doSpOrdersValidateUpdate":{"name":"doSpOrdersValidateUpdate","costTime":16,"beanId":"coreOpenApiPairDeliveryChainUpdate","count":1,"times":[16]},"updateDeliveryOrder":{"name":"updateDeliveryOrder","costTime":216,"beanId":null,"count":1,"times":[216]},"validateForDeliveredByPos":{"name":"validateForDeliveredByPos","costTime":1,"beanId":null,"count":1,"times":[1]},"doRegisterArrivedHub":{"name":"doRegisterArrivedHub","costTime":0,"beanId":null,"count":1,"times":[0]}},"#Other#":{"[23][TOTAL]":772}}	192.168.3.132	2017-08-15 15:54:22.299	2017-08-15 15:54:22.402
42782	chain-1502783664084	{"#ChainStep#":{"[1]startLocalChain(name)":0,"[2]@ChainUpdate proceed":77,"[3]navigateTillExhausted()":0,"[4]checkChainValid()":0,"[5]acquireInitialLock()":0,"[6]localValidation()":0,"[7]lockHolder.extendLockForValidation()":0,"[8]remoteValidation()":0,"[9]handleException()":0,"[10]ready execute localUpdate":0,"[11]localUpdate()":1,"[12]startParallelExecution()":0,"[13]remoteUpdate Process()":0,"[14]afterCommit() for update":1,"[15]all Update":3,"[16]LoggerSupplier.log()":0},"#Other#":{"[17][TOTAL]":80}}	192.168.3.132	2017-08-15 15:54:23.34	2017-08-15 15:54:23.483
\.


--
-- Data for Name: news; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY news (id, created_at, created_by, updated_by, updated_at, status, content, hits, number, execution_id, source, title, type, image_id) FROM stdin;
1	2017-10-09 10:18:11.582	1	1	2017-10-09 11:27:46.881	2	<p>1111<br/></p>	0	TWG7OCRS4IEKC3ZHBMAPR6IP	\N	\N	隔壁老王	11	\N
2	2017-10-09 14:00:21.007	1	1	2017-10-09 14:01:48.162	5	<p>setaet2</p>	0	TOLCIUIENJA77NOUW2KKLB3S	\N	\N	test	11	\N
3	2017-10-09 18:56:13.041	1	1	2017-10-09 18:57:19.656	2	<p>www</p>	0	VG3DRKGIYCDFDUX2RGZEZ2UX	\N	aa	aa	10	IMAGE_1507546637098
4	2017-10-10 12:59:10.376	1	\N	\N	2	<p>test<br/></p>	0	XNBJ3BO6JZ5VJOM6SKQUBWJN	\N	\N	test	11	\N
\.


--
-- Data for Name: news_attach; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY news_attach (id, news_id) FROM stdin;
\.


--
-- Data for Name: news_picture; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY news_picture (id, name, news_id, origin_name, sequence, size, suffix, image_id) FROM stdin;
\.


--
-- Data for Name: news_temp_image; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY news_temp_image (id, access_path, created_at, name, origin_name, size, suffix, upload_path, news_id) FROM stdin;
\.


--
-- Data for Name: process_flow; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY process_flow (execution_id, apply_by, apply_on, news_id, process_id, state, updated_by, updated_at) FROM stdin;
\.


--
-- Data for Name: resource_bundle; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY resource_bundle (id, country, key, locale, tooltip, value, variant) FROM stdin;
1	\N	permission.group.default	zh	\N	默认组	\N
2	\N	login.user.or.password.error	zh	\N	用户或密码错误.	\N
3	\N	global.api.access.error	zh	\N	接口访问错误.	\N
4	\N	global.api.unauthorized	zh	\N	接口认证错误.	\N
5	\N	common.message.save.success	zh	\N	保存成功.	\N
6	\N	common.message.save.failed	zh	\N	保存失败.	\N
7	\N	common.message.system.error	zh	\N	系统异常.	\N
8	\N	resource.constant.gender.male	zh	\N	男	\N
9	\N	resource.constant.gender.female	zh	\N	女	\N
10	\N	resource.constant.data.status.init	zh	\N	初始化	\N
11	\N	resource.constant.data.status.enabled	zh	\N	正常	\N
12	\N	resource.constant.data.status.disabled	zh	\N	无效	\N
13	\N	resource.constant.data.status.deleted	zh	\N	已删除	\N
14	\N	resource.constant.data.status.expired	zh	\N	已过期	\N
15	\N	resource.permission.function.create	zh	\N	创建	\N
16	\N	resource.permission.function.update	zh	\N	修改	\N
17	\N	resource.permission.function.delete	zh	\N	删除	\N
18	\N	resource.permission.group.default	zh	\N	默认	\N
19	\N	resource.permission.group.role	zh	\N	角色管理	\N
20	\N	resource.constant.news.type.tpxw	zh	\N	图片新闻	\N
21	\N	resource.constant.news.type.jqkx	zh	\N	警情快讯	\N
22	\N	resource.constant.news.type.dwjs	zh	\N	队伍建设	\N
23	\N	resource.constant.news.type.bmdt	zh	\N	部门动态	\N
24	\N	resource.constant.news.type.xxyd	zh	\N	学习园地	\N
25	\N	resource.constant.news.type.whsb	zh	\N	网海拾贝	\N
26	\N	resource.constant.news.type.kjlw	zh	\N	科技瞭望	\N
27	\N	resource.constant.news.type.jzfc	zh	\N	技侦风采	\N
\.


--
-- Data for Name: resource_file; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY resource_file (id, access_url, created_at, extension, file_id, file_name, file_size, local_path, origin_name, source, type) FROM stdin;
5	/tempFiles/1503650875152.png	2017-08-25 16:47:55.166	.png	bf550ba70d6c4047730ac1006468b08cf601	1503650875152.png	207762	/news/20170825/1503650875152.png	2017-07-06 11:30:45屏幕截图.png	10	1
6	/images/1503653467071.png	2017-08-25 17:31:07.092	.png	9c88dfc80fd34047040bfc40cae6396c9f21	1503653467071.png	82090	/news/20170825/1503653467071.png	2017-01-13 10:27:00屏幕截图.png	10	1
7	/images/1503653485906.png	2017-08-25 17:31:25.906	.png	8a94b5260511804e700b4d50d2a0bbeeab93	1503653485906.png	207762	/news/20170825/1503653485906.png	2017-07-06 11:30:45屏幕截图.png	10	1
8	/images/1503653567424.png	2017-08-25 17:32:53.735	.png	5d9421490334204cc9083d20c6f7ce112493	1503653567424.png	26623	/news/20170825/1503653567424.png	2017-06-16 16:00:23屏幕截图.png	10	1
9	http://localhost:9091/sp/images/1504184906050.png	2017-08-31 21:08:26.468	.png	eabf23840a956041810bb770c6a5fe172617	1504184906050.png	38070	/news/20170831/1504184906050.png	2017-06-19 18:14:55屏幕截图.png	10	1
10	http://localhost:9091/sp/images/1504185351793.png	2017-08-31 21:15:52.063	.png	206d2d1007a1a044ff089680a7dc0b2559da	1504185351793.png	38070	/news/20170831/1504185351793.png	2017-06-19 18:14:55屏幕截图.png	10	1
\.


--
-- Data for Name: resource_image; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY resource_image (id, created_at, dir, image_id, name, origin_name, path, size, suffix, source) FROM stdin;
2	2017-09-27 14:23:10.211	/home/bert/Documents/work/cqjz/images/	IMAGE_1506493389851	IMAGE_1506493389851.png	2017-06-15 15:52:30屏幕截图.png	20170927/IMAGE_1506493389851.png	97737	.png	11
3	2017-09-29 10:28:03.075	/home/bert/Documents/work/cqjz/images/	IMAGE_1506652083074	IMAGE_1506652083074.png	2017-09-04 14:54:39屏幕截图.png	20170929/IMAGE_1506652083074.png	103783	.png	11
4	2017-09-29 10:30:49.488	/home/bert/Documents/work/cqjz/images/	IMAGE_1506652249488	IMAGE_1506652249488.png	2017-06-20 18:27:57屏幕截图.png	20170929/IMAGE_1506652249488.png	99569	.png	11
5	2017-09-29 10:34:04.986	/home/bert/Documents/work/cqjz/images/	IMAGE_1506652444986	IMAGE_1506652444986.png	flow.png	20170929/IMAGE_1506652444986.png	4252	.png	11
6	2017-09-29 10:38:41.861	/home/bert/Documents/work/cqjz/images/	IMAGE_1506652721860	IMAGE_1506652721860.png	2017-07-06 11:30:45屏幕截图.png	20170929/IMAGE_1506652721860.png	207762	.png	11
7	2017-09-29 10:39:15.606	/home/bert/Documents/work/cqjz/images/	IMAGE_1506652755605	IMAGE_1506652755605.png	flow.png	20170929/IMAGE_1506652755605.png	4252	.png	11
8	2017-09-29 10:58:29.187	/home/bert/Documents/work/cqjz/images/	IMAGE_1506653909185	IMAGE_1506653909185.png	2017-09-04 14:54:26屏幕截图.png	20170929/IMAGE_1506653909185.png	81797	.png	11
9	2017-09-29 10:59:24.835	/home/bert/Documents/work/cqjz/images/	IMAGE_1506653964835	IMAGE_1506653964835.png	2017-08-09 14:06:19屏幕截图.png	20170929/IMAGE_1506653964835.png	34726	.png	11
10	2017-09-29 11:04:04.939	/home/bert/Documents/work/cqjz/images/	IMAGE_1506654244939	IMAGE_1506654244939.png	2017-08-09 14:06:19屏幕截图.png	20170929/IMAGE_1506654244939.png	34726	.png	11
11	2017-09-29 11:04:47.173	/home/bert/Documents/work/cqjz/images/	IMAGE_1506654287173	IMAGE_1506654287173.png	2017-07-06 11:30:45屏幕截图.png	20170929/IMAGE_1506654287173.png	207762	.png	11
12	2017-09-29 11:07:29.675	/home/bert/Documents/work/cqjz/images/	IMAGE_1506654449675	IMAGE_1506654449675.png	flow.png	20170929/IMAGE_1506654449675.png	4252	.png	11
13	2017-09-29 16:03:13.766	/home/bert/Documents/work/cqjz/images/	IMAGE_1506672193766	IMAGE_1506672193766.png	2017-06-19 18:14:55屏幕截图.png	20170929/IMAGE_1506672193766.png	38070	.png	11
14	2017-09-29 16:05:30.985	/home/bert/Documents/work/cqjz/images/	IMAGE_1506672330962	IMAGE_1506672330962.png	2017-07-06 11:30:45屏幕截图.png	20170929/IMAGE_1506672330962.png	207762	.png	11
15	2017-09-29 16:06:38.488	/home/bert/Documents/work/cqjz/images/	IMAGE_1506672398488	IMAGE_1506672398488.png	flow.png	20170929/IMAGE_1506672398488.png	4252	.png	11
16	2017-10-09 18:56:27.797	/home/bert/Documents/work/cqjz/images/	IMAGE_1507546587720	IMAGE_1507546587720.png	2017-06-15 15:56:12屏幕截图.png	20171009/IMAGE_1507546587720.png	518462	.png	10
17	2017-10-09 18:56:59.196	/home/bert/Documents/work/cqjz/images/	IMAGE_1507546619196	IMAGE_1507546619196.png	2017-09-08 17:31:33屏幕截图.png	20171009/IMAGE_1507546619196.png	48168	.png	10
18	2017-10-09 18:57:14.113	/home/bert/Documents/work/cqjz/images/	IMAGE_1507546634084	IMAGE_1507546634084.png	2017-06-16 16:00:23屏幕截图.png	20171009/IMAGE_1507546634084.png	26623	.png	10
19	2017-10-09 18:57:17.098	/home/bert/Documents/work/cqjz/images/	IMAGE_1507546637098	IMAGE_1507546637098.png	flow.png	20171009/IMAGE_1507546637098.png	4252	.png	10
\.


--
-- Data for Name: result; Type: TABLE DATA; Schema: public; Owner: jetty
--

COPY result (customer, phone, start_time, end_time, amount, revenue, uy) FROM stdin;
掌上明珠	13996646425	2014-10-20	2016-09-23	7160.00	4960.00	2200.00
王彩虹	18983533459	2015-09-15	2016-07-23	2292.00	2012.00	280.00
刘老师	13996667605	2016-11-09	2016-11-15	400.00	400.00	0.00
璐璐	15923846466	2016-08-20	2016-08-20	0.00	0.00	0.00
王思元	13641797417	2016-09-10	2016-09-10	0.00	0.00	0.00
张平	\N	2016-11-26	2016-11-26	300.00	300.00	0.00
成都余长荣	15528798880	2014-11-10	2017-08-13	449508.00	375988.00	73520.00
刘汉彬	13996594935	2014-09-05	2017-04-09	210695.00	196895.00	13800.00
王尔安	13452635613	2014-10-21	2017-09-15	40134.00	33567.00	6567.00
周小华	13628355753	2014-09-02	2016-09-03	93890.00	87390.00	6500.00
石万刚	53224124,18983533260	2014-09-02	2016-11-19	106225.00	100825.00	5400.00
三亚湾新世纪	\N	2015-07-08	2016-08-06	1943797.80	547290.66	1396507.14
新世纪	\N	2015-07-30	2017-08-15	2110137.68	907609.10	1202528.58
万州晏总	\N	2014-08-10	2017-08-24	287274.00	199524.00	87750.00
新世纪百货	\N	2017-08-30	2017-09-15	78662.80	0.00	78662.80
宜宾郑姐	0831-8301109,13778969582	2014-11-19	2016-09-07	123580.00	66745.00	56835.00
五斗米张蓉	\N	2017-03-10	2017-09-13	55318.40	11682.00	43636.40
成都方老板	13688110931微信,13350089519	2016-06-08	2017-08-25	106780.30	68810.00	37970.30
吉林赵华连	\N	2015-03-27	2017-07-10	94311.00	58970.00	35341.00
成都李利	\N	2015-08-26	2016-01-07	38000.00	16000.00	22000.00
广羽众商贸公司	\N	2017-08-30	2017-09-13	21600.00	0.00	21600.00
保安公司	\N	2015-10-14	2017-07-18	30088.00	9028.00	21060.00
乌鲁木齐龚政	\N	2015-08-28	2015-08-28	21000.00	0.00	21000.00
万州老蒋	64896539,18315060983	2014-08-13	2017-09-03	67913.00	49113.00	18800.00
重庆人人乐	\N	2015-12-03	2016-04-12	74960.00	56742.80	18217.20
达州吴忠海	0818-2389798,13518251013	2014-09-01	2017-08-11	86400.00	68250.00	18150.00
深圳人人乐	\N	2015-06-15	2015-08-11	32000.00	14730.60	17269.40
渝东北特产	\N	2015-02-07	2017-07-31	35712.94	19839.00	15873.94
万州蒋帮武	18996630211	2014-12-27	2017-08-03	100245.50	84850.00	15395.50
周维峰	\N	2014-11-11	2015-05-05	13346.00	0.00	13346.00
鸿野商贸	\N	2016-02-23	2016-04-09	13757.00	557.00	13200.00
添亿商贸公司	\N	2015-11-26	2015-12-21	11660.00	0.00	11660.00
好人家	\N	2015-01-13	2017-06-23	90407.00	79492.00	10915.00
广安谭子崟	18926009392,13982683273	2017-02-14	2017-08-13	24873.90	15313.60	9560.30
锦和苑	18323768166	2014-09-29	2017-08-28	57055.00	47655.00	9400.00
黄石叶哲桥	\N	2016-04-01	2017-07-18	40500.00	32400.00	8100.00
绵阳李红	0816-6098600,18781115918	2014-11-10	2017-04-27	67367.00	59504.50	7862.50
忠县周海涛	\N	2014-11-28	2017-02-22	33925.00	26075.00	7850.00
人人乐超市退货	\N	2017-03-28	2017-03-28	7304.60	0.00	7304.60
分水明海卤业	\N	2014-10-24	2017-06-27	45752.00	38552.00	7200.00
黎庆奎	\N	2014-09-01	2017-09-13	34427.42	27637.00	6790.42
冯妈老火锅	13594775456,13594775456	2014-09-10	2017-09-16	28542.00	22042.00	6500.00
散户	\N	2014-09-01	2216-10-13	100560.28	94078.90	6481.38
源丰农业	\N	2016-03-14	2016-07-05	6000.00	0.00	6000.00
刘洪超市	\N	2015-02-08	2017-01-15	16160.00	10400.00	5760.00
显华烟酒	023-85700852	2015-07-24	2017-08-24	38834.67	33273.00	5561.67
余长荣（成都）	\N	2017-08-01	2017-08-01	5500.00	0.00	5500.00
忠县周虹	\N	2014-12-18	2017-09-13	22529.00	17239.00	5290.00
南充方勇	0817-2248348,13990898986	2014-09-03	2017-02-16	40625.00	35350.00	5275.00
达州覃光茂	\N	2015-01-03	2017-03-09	31500.00	26420.00	5080.00
人人乐言永童	\N	2017-01-15	2017-03-11	5032.00	0.00	5032.00
永鑫超市	\N	2014-10-19	2017-09-15	22007.50	17187.50	4820.00
红洋超市	\N	2015-06-17	2017-09-06	14387.00	9704.00	4683.00
高笋明海卤业	\N	2014-11-05	2015-08-31	16940.00	12440.00	4500.00
锦兴超市	13452622239,53511112	2017-01-16	2017-08-21	10905.78	6414.00	4491.78
重庆周维风	\N	2014-10-29	2014-11-29	4478.00	0.00	4478.00
江北田飞	\N	2015-06-10	2015-06-11	4200.00	0.00	4200.00
万州向德刚	\N	2015-03-19	2016-08-15	10800.00	6800.00	4000.00
重庆冯华侨	\N	2015-03-11	2015-10-10	7625.00	3800.00	3825.00
重庆田飞	\N	2015-06-28	2015-07-02	3780.00	0.00	3780.00
忠县申华林	\N	2014-12-01	2016-10-12	13525.00	9850.00	3675.00
天厨调味	\N	2014-09-01	2016-03-05	56300.00	52700.00	3600.00
经信委	\N	2015-01-15	2017-04-26	9969.40	6370.00	3599.40
人人乐周伦琼	\N	2017-01-15	2017-03-11	3565.20	0.00	3565.20
忠县熊德明	\N	2014-11-06	2017-07-09	33515.50	30275.00	3240.50
邓烧腊	\N	2014-09-11	2017-07-15	22412.00	19176.00	3236.00
人人乐王桂香	\N	2017-01-15	2017-01-15	3212.00	0.00	3212.00
麻辣空间	\N	2016-07-21	2017-09-11	5310.00	2100.00	3210.00
巫山华艺百货	\N	2016-01-25	2016-01-25	3000.00	0.00	3000.00
邹文富	\N	2014-09-15	2016-02-02	35879.00	32952.00	2927.00
名豪酒店	\N	2014-12-26	2017-08-03	9575.00	6722.00	2853.00
锅儿食特道老火锅	\N	2016-12-28	2017-09-11	2736.00	0.00	2736.00
滑石寨	\N	2014-09-12	2017-05-06	32683.00	29983.00	2700.00
万州黄超	\N	2015-01-18	2017-07-17	53075.00	50575.00	2500.00
五斗米（张蓉）	\N	2017-08-30	2017-08-30	2360.00	0.00	2360.00
和林卤菜	\N	2015-06-08	2017-04-28	16322.50	13977.00	2345.50
安安精品火锅	\N	2015-06-04	2015-09-26	3240.00	960.00	2280.00
吴兴伙	53231241,13896243133	2014-09-25	2015-01-05	4925.00	2700.00	2225.00
梁平胡二	\N	2015-05-05	2017-06-24	25109.00	22899.00	2210.00
张进	18223270831	2016-11-16	2017-02-22	4812.50	2646.00	2166.50
人社局	\N	2014-12-05	2015-02-07	2500.00	700.00	1800.00
内蒙古吴云	\N	2015-04-14	2015-06-11	1800.00	0.00	1800.00
国辉超市	\N	2015-08-27	2016-09-14	13221.00	11441.00	1780.00
重庆银行	\N	2015-06-14	2017-07-20	2793.90	1040.00	1753.90
万州蒋邦武	\N	2017-09-05	2017-09-05	1650.00	0.00	1650.00
常总	\N	2015-10-09	2017-03-28	2045.00	420.00	1625.00
梁平供销社	\N	2016-10-09	2016-12-14	4345.00	2760.00	1585.00
李辉国	\N	2014-05-22	2017-09-10	34500.50	32921.50	1579.00
忠县王越	\N	2015-06-02	2015-09-04	2625.00	1050.00	1575.00
重庆周科贤	\N	2016-09-03	2016-09-21	1536.00	0.00	1536.00
赵红食品经营部	\N	2014-09-12	2017-05-05	26230.00	24730.00	1500.00
联谊超市	\N	2014-11-01	2015-12-12	10937.00	9437.00	1500.00
李河明海卤业	\N	2015-06-22	2015-12-19	5000.00	3500.00	1500.00
星星套装门	\N	2015-06-27	2015-11-02	2650.00	1150.00	1500.00
周总	\N	2015-04-26	2015-04-26	1470.00	0.00	1470.00
唐光	\N	2015-02-09	2015-02-09	1400.00	0.00	1400.00
任市房老板	\N	2016-09-12	2016-09-12	1682.00	282.00	1400.00
国辉超市-梁中	\N	2016-10-06	2017-08-16	5421.00	4041.00	1380.00
双桂堂刘姐	\N	2014-08-06	2016-11-17	4370.00	3070.00	1300.00
巫山展销会	\N	2014-12-19	2014-12-19	6291.00	5011.00	1280.00
刘汉彬 	\N	2015-08-07	2016-12-23	11500.00	10250.00	1250.00
忠县张秀琼	\N	2016-12-12	2017-08-21	7925.00	6725.00	1200.00
显华副食	\N	2014-11-27	2017-01-16	7585.00	6430.00	1155.00
万州（老蒋）	\N	2017-09-01	2017-09-01	1150.00	0.00	1150.00
安安鱼	\N	2015-04-27	2016-08-18	1620.00	480.00	1140.00
曾凡平	53336358,15320618883	2014-09-07	2016-11-22	7187.00	6097.00	1090.00
梁平申通快递	\N	2016-10-29	2017-05-05	2580.00	1495.00	1085.00
秦姐食店	\N	2014-09-03	2016-07-26	10124.00	9044.00	1080.00
周海涛	54243848,15320728003	2014-09-06	2015-04-13	5100.00	4050.00	1050.00
蒋立俊	\N	2014-09-06	2017-08-18	13092.00	12092.00	1000.00
联谊超市东门	\N	2015-09-29	2015-09-29	1000.00	0.00	1000.00
渝桂文具	\N	2015-11-11	2015-12-12	2315.00	1330.00	985.00
梁平豆干	\N	2016-01-30	2017-09-13	44058.00	43094.00	964.00
来宝小学	13638282078	2017-03-22	2017-09-14	7360.00	6400.00	960.00
陈时令	\N	2015-08-25	2017-07-08	1475.00	575.00	900.00
易吉慧	\N	2014-09-21	2016-12-09	870.00	774.00	96.00
梁平南站展销	\N	2017-07-27	2017-07-31	1869.50	975.50	894.00
姚国明	\N	2016-05-19	2017-08-28	4706.40	3817.00	889.40
云阳罗晓峰18623608566	\N	2016-12-19	2016-12-24	880.00	0.00	880.00
冉隆婵	\N	2014-11-06	2017-09-08	2724.95	1855.00	869.95
范家荣	\N	2014-09-11	2016-04-13	4851.00	4001.00	850.00
金带政府党政办	\N	2016-03-01	2017-01-23	832.00	0.00	832.00
袁驿顾六儿豆干	\N	2017-07-02	2017-07-02	818.00	0.00	818.00
陈局	\N	2017-01-24	2017-01-24	800.00	0.00	800.00
忠县万灵金	\N	2014-12-25	2016-08-31	3150.00	2352.00	798.00
云龙麻麻鱼	\N	2015-09-10	2016-05-04	2520.00	1800.00	720.00
藕然间-大兴村店	\N	2017-04-30	2017-06-27	708.00	0.00	708.00
何国平	\N	2014-10-27	2017-01-13	1651.00	966.00	685.00
实验幼儿园	\N	2014-12-03	2017-09-06	2706.00	2066.00	640.00
商务局	\N	2016-07-21	2017-06-29	640.00	0.00	640.00
双桂堂永玲超市	\N	2014-10-26	2014-10-31	740.00	105.00	635.00
梁平戴斯大酒店	\N	2017-05-15	2017-06-02	772.00	140.00	632.00
明达小学	\N	2016-03-23	2017-09-14	8335.00	7735.00	600.00
国辉超市-大河坝	\N	2016-08-18	2017-08-10	6024.70	5444.70	580.00
忠县刘增宪	\N	2016-03-04	2017-06-27	10575.00	10000.00	575.00
梁平特产-南站	\N	2017-05-19	2017-05-19	552.00	0.00	552.00
重庆陈怡	\N	2014-11-06	2016-03-23	1510.00	960.00	550.00
周春	\N	2015-05-17	2017-08-12	2346.00	1806.00	540.00
工商所袁老师	13896200009	2017-01-16	2017-03-31	630.00	90.00	540.00
百年超市	\N	2015-10-15	2015-12-19	1050.00	525.00	525.00
忠县王志勇	\N	2015-10-11	2015-10-11	525.00	0.00	525.00
忠县叶占云	\N	2015-10-17	2015-10-17	525.00	0.00	525.00
易同富	\N	2015-07-28	2015-07-28	525.00	0.00	525.00
李季	\N	2014-10-21	2017-09-15	2435.00	1925.00	510.00
岗上渣渣火锅店	\N	2017-03-15	2017-04-20	500.00	0.00	500.00
北门黄伟	\N	2015-01-03	2015-08-17	31750.00	31250.00	500.00
仁贤中学	\N	2015-09-29	2016-09-18	1200.00	700.00	500.00
水电公司	\N	2015-04-30	2015-09-14	500.00	0.00	500.00
张小姐（深圳）	\N	2017-08-30	2017-08-30	500.00	0.00	500.00
工商银行	\N	2014-11-20	2017-07-27	1600.00	1115.00	485.00
唐燕	\N	2017-09-11	2017-09-11	480.00	0.00	480.00
重庆华西资产评估房地产估价有限公司\n	\N	2017-09-17	2017-09-17	480.00	0.00	480.00
渝东北超市	\N	2015-12-04	2017-09-13	33250.00	32770.00	480.00
刘行召	\N	2014-09-02	2017-01-18	6139.00	5659.00	480.00
百世快递	\N	2017-09-16	2017-09-16	480.00	0.00	480.00
李佳红	\N	2014-12-10	2017-02-06	1145.00	665.00	480.00
唐兴华	\N	2014-09-16	2016-02-10	2008.00	1540.00	468.00
姚平川	\N	2015-08-29	2015-08-29	460.00	0.00	460.00
唐泽兰（宜兴豆棒）	\N	2017-04-16	2017-04-16	690.00	230.00	460.00
王德书	\N	2015-08-13	2016-08-15	875.00	425.00	450.00
移民局	\N	2015-10-10	2015-10-10	420.00	0.00	420.00
李局	\N	2015-10-20	2017-06-12	5951.00	5545.00	406.00
戴斯酒店	\N	2017-09-07	2017-09-07	400.00	0.00	400.00
万州邮政廖玉兰	\N	2016-12-20	2016-12-20	400.00	0.00	400.00
邓家食店	\N	2015-09-21	2017-05-09	1985.00	1600.00	385.00
藕然间	\N	2016-10-30	2017-02-22	2760.00	2376.00	384.00
合川黄志彬	\N	2016-08-26	2016-08-26	363.60	0.00	363.60
锅炉检验	\N	2015-03-11	2015-07-15	0.00	0.00	0.00
唐江毅	15523762181	2016-01-05	2017-03-09	2700.00	1830.00	870.00
宁安文	15025558256	2014-09-22	2016-12-29	2486.00	1882.00	604.00
月中桂	53251178	2014-09-12	2017-06-05	4415.00	3935.00	480.00
周科贤	18996692037	2017-01-04	2017-01-16	461.00	0.00	461.00
云龙冯妈老火锅	\N	2015-09-29	2016-05-10	1920.00	1560.00	360.00
郑唯勇	\N	2017-09-16	2017-09-16	330.00	0.00	330.00
油泼面	\N	2015-03-30	2017-06-19	3169.00	2844.00	325.00
工商局江科长	\N	2015-08-28	2015-08-28	320.00	0.00	320.00
森宝木胶	\N	2016-11-24	2017-05-02	2406.00	2094.00	312.00
曾有光15998906557	\N	2016-10-26	2016-11-22	3610.00	3300.00	310.00
胡鸭子	15826303760	2016-07-09	2017-08-16	2198.00	1898.00	300.00
袁明田	\N	2014-09-10	2017-09-07	5057.00	4757.00	300.00
蒋志通	\N	2015-09-15	2015-09-15	300.00	0.00	300.00
双桂中学	\N	2015-09-22	2015-09-22	300.00	0.00	300.00
地税刘局	\N	2015-10-05	2015-10-05	270.00	0.00	270.00
何世洪	\N	2014-12-27	2015-11-09	2146.00	1890.00	256.00
谭德秋	\N	2014-09-07	2017-08-27	7033.00	6781.00	252.00
杨丽华	\N	2014-09-25	2017-08-24	4430.00	4178.00	252.00
滑石寨莫总	\N	2015-10-09	2015-10-09	250.00	0.00	250.00
三峡生态鱼	\N	2014-10-29	2016-04-29	1360.00	1120.00	240.00
邓姐	\N	2014-10-13	2015-12-21	320.00	80.00	240.00
冯妈老火锅祥和店	\N	2015-10-15	2016-02-02	960.00	720.00	240.00
双桂堂小卖部	\N	2014-10-21	2014-12-07	1125.00	900.00	225.00
曾小乐	\N	2015-10-02	2015-10-02	210.00	0.00	210.00
唐洪	\N	2014-11-30	2017-01-10	1496.00	1286.00	210.00
吉林小刘	\N	2015-10-17	2015-10-17	210.00	0.00	210.00
万州宋总	\N	2015-07-07	2015-07-08	210.00	0.00	210.00
高万琼	\N	2014-11-09	2017-05-20	3580.00	3400.00	180.00
地税食堂	\N	2015-07-06	2017-01-19	2455.00	2275.00	180.00
晏家鱼庄	\N	2016-09-23	2017-04-13	1474.00	1294.00	180.00
刘宇炳	\N	2014-12-03	2017-03-18	1784.00	1614.00	170.00
何煤炭	\N	2014-09-04	2017-08-06	2876.00	2706.00	170.00
邓主任	\N	2015-02-08	2015-02-08	165.00	0.00	165.00
食监局	\N	2015-02-07	2016-10-27	160.00	0.00	160.00
汪银川	\N	2015-06-23	2015-09-22	320.00	160.00	160.00
金带蒋书记	\N	2016-04-05	2016-11-10	160.00	0.00	160.00
重庆周维锋	\N	2015-06-02	2015-06-02	160.00	0.00	160.00
李艳	\N	2017-09-13	2017-09-13	160.00	0.00	160.00
安检	\N	2014-09-03	2016-12-07	4450.00	4290.00	160.00
赵云	\N	2014-09-30	2017-09-12	1890.00	1740.00	150.00
高笋郎中平	\N	2015-01-25	2015-02-08	4475.00	4330.00	145.00
魏奎富	\N	2014-09-03	2017-04-14	1971.00	1831.00	140.00
包总	\N	2015-07-24	2015-07-27	374.00	234.00	140.00
张顺祥	\N	2015-09-13	2017-01-07	1137.00	1013.00	124.00
吴兴宏	\N	2015-10-22	2015-10-22	120.00	0.00	120.00
王海波	\N	2016-01-14	2017-04-11	758.00	638.00	120.00
马世凤	\N	2014-12-06	2016-03-29	500.00	380.00	120.00
刘小兰	\N	2015-02-07	2016-01-25	965.00	845.00	120.00
地税局李局	\N	2017-02-23	2017-05-16	190.00	70.00	120.00
金洋酒家	\N	2014-11-01	2015-10-15	730.00	610.00	120.00
白塔瓷砖田总	\N	2015-09-18	2015-09-18	120.00	0.00	120.00
姚朝奎	\N	2015-06-05	2016-08-20	530.00	410.00	120.00
金带政府	\N	2015-02-04	2017-05-22	1364.00	1244.00	120.00
蒋善斌	\N	2014-10-19	2016-02-04	768.00	648.00	120.00
王朝富	\N	2014-11-02	2017-09-17	918.00	798.00	120.00
吕老师	\N	2015-10-19	2015-10-19	120.00	0.00	120.00
吉利宾馆	\N	2017-06-27	2017-06-27	114.00	0.00	114.00
大拇指刘总	\N	2014-11-20	2015-08-20	6610.00	6500.00	110.00
渝东北特产前台	\N	2015-08-08	2015-08-08	108.00	0.00	108.00
黄庆菊	\N	2014-12-22	2017-09-10	1174.00	1074.00	100.00
维清润滑油	\N	2015-08-24	2017-06-29	220.00	120.00	100.00
廖兴菊	\N	2015-09-25	2017-09-13	1372.00	1272.00	100.00
王义真	\N	2016-04-24	2016-04-24	192.00	96.00	96.00
黄主席	\N	2015-08-15	2015-08-15	95.00	0.00	95.00
蒋丽英	13452078232	2014-10-18	2016-09-29	6986.00	6904.00	82.00
派出所胡	\N	2015-10-10	2015-10-10	80.00	0.00	80.00
吴忠闰	\N	2015-08-16	2015-08-16	80.00	0.00	80.00
重庆林欢	\N	2016-09-03	2016-09-03	80.00	0.00	80.00
达州卢燕	\N	2016-07-13	2017-01-04	1500.00	1425.00	75.00
何世川	\N	2015-09-07	2016-02-02	132.00	60.00	72.00
渝东北前台	\N	2015-08-09	2015-08-09	72.00	0.00	72.00
明建平	\N	2015-08-08	2015-08-08	70.00	0.00	70.00
何小红	\N	2015-08-02	2015-08-02	70.00	0.00	70.00
游克明	\N	2014-12-09	2016-03-11	534.00	470.00	64.00
吴顺元	\N	2014-11-14	2015-10-04	306.00	246.00	60.00
双桂罗老师	\N	2015-10-04	2015-10-04	60.00	0.00	60.00
杨彩霞	\N	2015-09-24	2016-02-02	216.00	156.00	60.00
熊兵芬	\N	2015-01-06	2016-12-06	2020.00	1960.00	60.00
吴忠润	\N	2014-12-18	2015-11-18	318.00	258.00	60.00
攀枝花王平	0812-2512367,13980350981,13550953391	2014-11-19	2016-09-29	6050.00	6000.00	50.00
谭成龙	\N	2017-07-26	2017-07-26	48.00	0.00	48.00
谢作峰 【方付通】	\N	2017-09-15	2017-09-15	41.00	0.00	41.00
杨春玲	\N	2016-01-17	2017-04-12	1358.00	1318.00	40.00
一中高老师	\N	2015-10-18	2015-10-18	30.80	0.00	30.80
梁平县法院	\N	2014-12-01	2014-12-01	560.00	534.00	26.00
张兴州（德阳）	\N	2014-11-12	2014-11-12	1060.00	1040.00	20.00
自贡胡泽金	13700959605	2014-10-22	2014-10-22	2500.00	2488.00	12.00
分水谭老板	\N	2014-11-15	2014-11-15	1000.00	988.00	12.00
人人乐-江津	\N	2016-11-01	2016-11-01	12250.00	12240.00	10.00
兴茂门岗	\N	2014-10-09	2015-01-31	340.00	330.00	10.00
贵阳罗利银	\N	2015-03-30	2016-03-03	18975.00	18965.00	10.00
江北张翠花	\N	2015-01-30	2015-01-30	200.00	192.00	8.00
新城彭姐	\N	2017-04-08	2017-06-25	2748.00	2744.00	4.00
妈妈乐火锅	\N	2016-07-26	2016-09-04	1725.00	1722.00	3.00
李德久	\N	2017-01-05	2017-01-05	9124.90	9124.00	0.90
香香超市	\N	2017-03-14	2017-05-05	245.00	244.50	0.50
达州职业学院	\N	2017-03-13	2017-06-12	5617.50	5617.00	0.50
公司样品	\N	2015-06-30	2015-06-30	0.00	0.00	0.00
高宝翠-员工	\N	2016-11-13	2017-01-06	200.00	200.00	0.00
谢元成	\N	2014-10-06	2014-10-06	32.00	32.00	0.00
皇世推拿	\N	2015-05-27	2015-05-27	120.00	120.00	0.00
范家云	\N	2014-11-12	2017-02-11	575.00	575.00	0.00
湖北聂老板	\N	2015-04-05	2015-04-05	540.00	540.00	0.00
周学兵	\N	2016-11-08	2017-01-16	640.00	640.00	0.00
重庆银行杨小姐	\N	2016-08-17	2016-08-17	160.00	160.00	0.00
谭熊香料行	\N	2014-09-12	2014-10-13	3000.00	3000.00	0.00
温中元	\N	2015-02-12	2015-02-12	700.00	700.00	0.00
梁老板	\N	2015-03-21	2015-03-21	0.00	0.00	0.00
田伟	18996566331,18996566331	2016-01-05	2016-01-05	959.00	959.00	0.00
南充张昭平	\N	2015-01-03	2015-01-03	0.00	0.00	0.00
都梁实业	\N	2015-01-11	2015-01-13	1600.00	1600.00	0.00
分水谭佐才	\N	2014-12-29	2016-08-19	2450.00	2450.00	0.00
小学	\N	2016-05-20	2016-05-20	3584.00	3584.00	0.00
梁勇	\N	2014-09-05	2015-05-18	45725.00	45725.00	0.00
周医生	\N	2014-12-01	2017-08-02	300.00	300.00	0.00
游叔叔	\N	2016-01-29	2016-01-30	92.00	92.00	0.00
金带镇府	\N	2016-11-09	2016-11-09	83.00	83.00	0.00
唐江义	15523762181	2016-10-07	2017-07-20	1030.00	850.00	180.00
韩庄羊蹄	15826370299	2015-09-22	2017-06-07	1524.00	1404.00	120.00
刘先生	\N	2014-09-18	2014-09-18	14.00	14.00	0.00
党政办	\N	2015-12-21	2015-12-21	490.00	490.00	0.00
湖北何宝堂	\N	2017-04-08	2017-04-08	0.00	0.00	0.00
游小进	\N	2016-01-25	2016-01-25	240.00	240.00	0.00
谭老板	15320601219	2014-10-25	2014-10-25	56.00	56.00	0.00
王稳静	\N	2015-08-17	2015-08-17	0.00	0.00	0.00
刘健康	\N	2016-04-27	2016-04-27	40.00	40.00	0.00
游洪	\N	2016-01-26	2017-01-21	522.00	522.00	0.00
徐飞	\N	2017-07-18	2017-07-18	0.00	0.00	0.00
张鸭子	\N	2016-02-25	2016-11-13	900.00	900.00	0.00
新城彭杰	\N	2017-08-20	2017-08-20	710.00	710.00	0.00
云龙国税	\N	2014-12-10	2014-12-10	0.00	0.00	0.00
柏家医院	\N	2016-03-20	2016-03-20	1070.00	1070.00	0.00
经信委唐主任	\N	2017-02-23	2017-02-23	588.00	588.00	0.00
上海王思元	\N	2016-02-25	2016-02-25	0.00	0.00	0.00
河南张银平	\N	2017-06-29	2017-07-14	4905.90	4905.90	0.00
万州明海食品	\N	2015-03-26	2015-03-26	0.00	0.00	0.00
龙顺元	\N	2016-03-24	2016-03-24	40.00	40.00	0.00
公司会议室	\N	2016-06-20	2016-06-20	0.00	0.00	0.00
万州担保公司	\N	2016-01-13	2016-01-13	0.00	0.00	0.00
蒋俊东	\N	2015-01-26	2015-01-26	550.00	550.00	0.00
曾婷林	\N	2016-05-06	2016-05-06	20.00	20.00	0.00
达州王晓莉	13198751251	2014-09-17	2015-01-09	1280.00	1280.00	0.00
食堂	\N	2016-10-13	2016-10-13	50.00	50.00	0.00
王成慧	\N	2015-02-06	2015-02-07	311.00	311.00	0.00
钟才军	\N	2016-02-02	2017-01-22	455.00	455.00	0.00
吕家芳	\N	2016-09-12	2017-02-06	261.00	261.00	0.00
曹廷玲	\N	2016-04-14	2016-09-01	140.00	140.00	0.00
申通	\N	2016-02-02	2016-02-02	169.00	169.00	0.00
王维胜	\N	2017-01-10	2017-01-10	700.00	700.00	0.00
华鑫蛋糕	\N	2016-09-22	2016-09-22	40.00	40.00	0.00
成都李总	\N	2015-10-07	2015-10-07	0.00	0.00	0.00
郭先生	\N	2017-02-28	2017-02-28	65.00	65.00	0.00
蔡俊	\N	2016-10-31	2016-10-31	0.00	0.00	0.00
谢鸭子	\N	2017-01-10	2017-05-16	1440.00	1440.00	0.00
梁平食药监局	\N	2017-07-04	2017-07-04	0.00	0.00	0.00
远程物流	\N	2016-10-13	2016-10-13	168.00	168.00	0.00
游天贵	\N	2016-05-04	2016-08-09	110.00	110.00	0.00
汪德毛	\N	2017-01-26	2017-01-26	216.00	216.00	0.00
周继培	\N	2016-12-18	2016-12-18	120.00	120.00	0.00
刘韩春	\N	2016-11-15	2016-11-15	35.00	35.00	0.00
刘尹碧员工	\N	2017-06-11	2017-06-11	40.00	40.00	0.00
周涛	\N	2015-04-15	2015-04-24	256.00	256.00	0.00
云阳黄淑明	\N	2016-06-13	2016-06-13	84.00	84.00	0.00
陆涛	\N	2016-10-05	2016-10-05	0.00	0.00	0.00
蒋快餐	\N	2016-12-20	2017-04-12	4140.00	4140.00	0.00
李忠现	\N	2014-11-11	2014-11-11	140.00	140.00	0.00
杨书记	\N	2016-02-16	2016-02-16	216.00	216.00	0.00
攀枝花黄亮	0812-2512690,13508238470	2014-11-19	2014-11-19	2500.00	2500.00	0.00
八块桥食品	\N	2015-09-02	2015-09-02	0.00	0.00	0.00
兴农担保	\N	2015-05-18	2016-05-16	0.00	0.00	0.00
唐科	\N	2016-07-21	2016-07-21	390.00	390.00	0.00
都江堰刘晟	\N	2015-08-12	2015-08-12	96.00	96.00	0.00
何南新乡谷飞	\N	2015-05-21	2015-05-21	0.00	0.00	0.00
幼儿园	\N	2014-09-03	2014-09-03	240.00	240.00	0.00
温亚芳	\N	2014-10-04	2017-05-22	200.00	200.00	0.00
朱明虹	\N	2016-12-29	2016-12-29	40.00	40.00	0.00
高万群-员工	\N	2016-09-18	2016-10-26	160.00	160.00	0.00
黄中慧	\N	2014-09-30	2014-09-30	24.00	24.00	0.00
牙婆	\N	2016-09-30	2016-09-30	100.00	100.00	0.00
成都曾大琼	\N	2014-11-05	2014-11-16	7500.00	7500.00	0.00
万州送检	\N	2017-03-27	2017-03-27	0.00	0.00	0.00
电力局唐经理	\N	2015-02-07	2015-02-07	0.00	0.00	0.00
福州德庆隆	\N	2016-03-30	2016-03-30	0.00	0.00	0.00
食品药监局	\N	2017-08-23	2017-08-23	0.00	0.00	0.00
包装设计公司	\N	2017-03-07	2017-03-07	0.00	0.00	0.00
长春朱颖	\N	2016-05-10	2016-05-10	0.00	0.00	0.00
周厚忠	\N	2016-11-10	2016-12-06	160.00	160.00	0.00
黄发权	\N	2014-12-21	2014-12-21	3600.00	3600.00	0.00
永川汪永碧	\N	2016-04-09	2016-04-09	390.00	390.00	0.00
湖南省桃林佬食品有限公司	\N	2015-06-05	2016-06-28	29360.00	29360.00	0.00
培训老师	\N	2016-08-20	2016-08-20	0.00	0.00	0.00
重庆市工商局	\N	2015-12-23	2015-12-23	0.00	0.00	0.00
何小兰	\N	2016-09-25	2016-09-25	40.00	40.00	0.00
姜维老师	\N	2015-12-05	2015-12-05	98.00	98.00	0.00
杨总	\N	2015-12-09	2017-01-24	2776.00	2776.00	0.00
江良凉	\N	2016-08-03	2016-08-03	210.00	210.00	0.00
谢利琼-员工	\N	2017-04-26	2017-04-26	60.00	60.00	0.00
谢启凤	\N	2014-10-29	2017-08-01	3813.00	3813.00	0.00
刘行勇	\N	2014-09-30	2016-02-03	290.00	290.00	0.00
王海君	13252978922	2016-05-11	2016-06-17	8400.00	8400.00	0.00
李总	13908263219	2014-09-15	2017-04-20	2130.00	2130.00	0.00
渝州监狱	\N	2015-09-14	2015-09-14	0.00	0.00	0.00
油波面	\N	2016-09-16	2016-09-16	60.00	60.00	0.00
源丰食品加工	\N	2016-08-30	2016-08-30	0.00	0.00	0.00
谭兴勇	13430671808	2017-06-07	2017-06-13	325.00	325.00	0.00
山西运城陈崇旭	\N	2015-09-25	2015-09-27	0.00	0.00	0.00
山东-刘青峰	\N	2016-10-15	2016-10-15	0.00	0.00	0.00
温娅芳	\N	2014-12-02	2016-12-29	1470.00	1470.00	0.00
肖主任（大渡口）	\N	2014-11-13	2014-11-13	1200.00	1200.00	0.00
陈宗逵	\N	2016-12-31	2017-01-14	160.00	160.00	0.00
山峡生态鱼	\N	2014-11-18	2016-01-25	460.00	460.00	0.00
杨学福	\N	2016-01-28	2016-01-28	140.00	140.00	0.00
宁安文【厂长】	\N	2017-08-22	2017-08-22	0.00	0.00	0.00
攀枝花张大	0812-2512484,13547602479,13340713966	2014-11-19	2014-11-19	2500.00	2500.00	0.00
西苑小学	\N	2016-05-30	2016-06-15	1050.00	1050.00	0.00
刘晓兰	\N	2014-12-08	2015-04-24	165.00	165.00	0.00
滑石寨B区	\N	2014-09-06	2014-09-06	300.00	300.00	0.00
田晓霞	18983912919	2017-06-25	2017-06-25	320.00	320.00	0.00
宜宾刘勇	\N	2014-11-19	2014-12-06	10000.00	10000.00	0.00
周汉菊	\N	2015-05-13	2015-12-04	300.00	300.00	0.00
新城孙老板	\N	2016-09-12	2016-09-23	340.00	340.00	0.00
燕子姐	\N	2016-06-30	2016-06-30	160.00	160.00	0.00
渝东北特产-蒋店长	\N	2017-03-30	2017-03-30	525.00	525.00	0.00
福建欧高全	\N	2016-08-14	2016-08-14	0.00	0.00	0.00
于玉容	\N	2017-01-22	2017-01-22	24.00	24.00	0.00
姚明川	\N	2015-02-10	2015-02-10	460.00	460.00	0.00
食品检测	\N	2017-06-12	2017-06-12	0.00	0.00	0.00
朱成兰	\N	2015-12-25	2016-01-18	168.00	168.00	0.00
魏成根	\N	2017-01-26	2017-01-26	160.00	160.00	0.00
谭群武员工	\N	2017-06-07	2017-06-07	120.00	120.00	0.00
谭群武-员工	\N	2016-09-14	2016-12-19	160.00	160.00	0.00
邓晓玲	\N	2016-02-21	2016-02-21	30.00	30.00	0.00
张轻轻	\N	2015-12-03	2016-05-04	484.00	484.00	0.00
袁驿刘洪超市	\N	2016-09-07	2017-01-17	1900.00	1900.00	0.00
安检办	\N	2015-11-07	2016-02-02	970.00	970.00	0.00
周医生 	\N	2015-06-17	2017-01-22	305.00	305.00	0.00
亿联展会	\N	2016-01-08	2016-06-30	890.00	890.00	0.00
重庆渝洽会	\N	2016-05-23	2016-05-23	6642.50	6642.50	0.00
陆委员	\N	2016-01-06	2016-01-06	320.00	320.00	0.00
文萍	\N	2016-12-18	2016-12-18	560.00	560.00	0.00
王哥	13896910508	2016-09-23	2016-09-23	280.00	280.00	0.00
超级美味	\N	2016-03-16	2016-05-13	405.00	405.00	0.00
永玲超市	\N	2014-12-19	2015-03-02	1281.00	1281.00	0.00
广场杂货	\N	2015-05-09	2015-05-09	500.00	500.00	0.00
重庆余涛	\N	2016-09-02	2016-09-02	0.00	0.00	0.00
王秋菊-员工	\N	2017-05-05	2017-05-05	40.00	40.00	0.00
大冶铜都干菜	\N	2016-03-31	2016-03-31	0.00	0.00	0.00
重庆曹处长	\N	2016-11-19	2016-11-19	0.00	0.00	0.00
双桂农商行	\N	2014-12-30	2014-12-30	240.00	240.00	0.00
人人乐赖文浩	\N	2014-11-26	2014-12-03	101200.00	101200.00	0.00
李门卫	\N	2017-09-08	2017-09-08	80.00	80.00	0.00
邓宜兰	\N	2015-12-03	2017-01-22	395.00	395.00	0.00
吉林鑫吉羊火锅	\N	2016-03-07	2016-03-07	0.00	0.00	0.00
陈老师	\N	2014-10-26	2017-05-27	290.00	290.00	0.00
牦牛香锅	\N	2016-10-08	2016-10-09	187.00	187.00	0.00
公司福利	\N	2016-07-05	2016-07-26	0.00	0.00	0.00
吴徐珍	\N	2016-08-09	2016-08-09	42.00	42.00	0.00
徐久琴	\N	2016-11-10	2017-01-03	490.00	490.00	0.00
刘世春	\N	2016-12-12	2016-12-12	120.00	120.00	0.00
游洪出差	\N	2016-04-09	2016-04-09	0.00	0.00	0.00
辽宁阜新史海涛	\N	2015-04-17	2015-04-17	1800.00	1800.00	0.00
重庆江北徐世军	\N	2015-06-03	2015-06-03	0.00	0.00	0.00
食监局金带	\N	2016-05-09	2016-05-11	128.00	128.00	0.00
殷俊杰	13015528638	2016-09-13	2016-09-13	0.00	0.00	0.00
和林王老板	\N	2015-07-22	2015-07-22	500.00	500.00	0.00
西门卤菜店	\N	2014-09-21	2014-09-21	250.00	250.00	0.00
五金店	\N	2016-09-19	2016-09-19	30.00	30.00	0.00
仁和街坊	\N	2015-01-19	2015-01-19	350.00	350.00	0.00
高保翠	\N	2017-08-01	2017-09-13	395.00	395.00	0.00
县政府	\N	2017-05-17	2017-05-17	0.00	0.00	0.00
青岛张秋生	\N	2015-05-05	2015-05-05	0.00	0.00	0.00
产品图	\N	2016-09-30	2016-09-30	0.00	0.00	0.00
黄宗见	\N	2014-10-17	2015-02-07	794.00	794.00	0.00
拉渣	\N	2016-04-18	2016-06-02	360.00	360.00	0.00
李红	\N	2016-08-07	2016-08-30	120.00	120.00	0.00
石安洞辛厂长	\N	2014-10-24	2014-10-24	0.00	0.00	0.00
何德俊	\N	2016-05-09	2016-10-26	560.00	560.00	0.00
新疆乌兰浩特吴云	\N	2015-04-02	2015-04-02	0.00	0.00	0.00
周经理	\N	2016-12-06	2016-12-06	0.00	0.00	0.00
唐小兵	\N	2016-12-25	2016-12-25	110.00	110.00	0.00
地税刘祖万	\N	2017-03-17	2017-03-17	65.00	65.00	0.00
职教中心	\N	2016-05-09	2016-05-12	4400.00	4400.00	0.00
金带政府陈元	\N	2016-08-04	2016-08-04	200.00	200.00	0.00
地税李局	\N	2015-09-20	2017-02-03	120.00	120.00	0.00
平野李光旭	\N	2015-01-30	2015-01-30	0.00	0.00	0.00
西门邓烧腊	\N	2014-11-04	2016-08-15	1295.00	1295.00	0.00
江苏魏威	\N	2015-07-13	2015-07-13	0.00	0.00	0.00
黄庆菊-员工	\N	2017-05-05	2017-05-05	120.00	120.00	0.00
江苏宿迁鲍卫东	\N	2015-07-15	2015-07-15	0.00	0.00	0.00
金带安检办	\N	2016-04-05	2016-04-05	0.00	0.00	0.00
杨贤平	\N	2016-11-23	2017-03-21	616.00	616.00	0.00
国土局食堂	\N	2017-06-06	2017-07-31	850.00	850.00	0.00
安检金带镇	\N	2015-04-11	2015-04-11	310.00	310.00	0.00
刘玲	\N	2017-01-13	2017-01-13	0.00	0.00	0.00
高娟	\N	2017-04-20	2017-04-20	616.00	616.00	0.00
湖南展销会	\N	2016-11-28	2016-11-28	0.00	0.00	0.00
新农人	\N	2014-09-21	2014-09-24	88.00	88.00	0.00
陆建华	\N	2016-01-14	2017-02-24	355.00	355.00	0.00
政府	\N	2016-11-26	2016-11-26	0.00	0.00	0.00
文丹	\N	2016-03-09	2016-03-09	1050.00	1050.00	0.00
上海麦德龙	\N	2016-11-04	2016-11-04	0.00	0.00	0.00
周继培员工	\N	2017-06-23	2017-06-23	20.00	20.00	0.00
环监办	\N	2016-05-16	2016-05-16	0.00	0.00	0.00
水发豆筋送样	\N	2015-04-22	2015-04-22	0.00	0.00	0.00
郑开明	\N	2015-01-28	2015-01-28	230.00	230.00	0.00
唐庄	\N	2016-10-16	2017-07-26	2644.00	2644.00	0.00
源丰	\N	2016-01-25	2016-09-25	0.00	0.00	0.00
重庆工商局	\N	2016-03-21	2016-03-21	800.00	800.00	0.00
农委姜老师	\N	2016-12-13	2016-12-16	1260.00	1260.00	0.00
七桥游勇	\N	2015-09-05	2015-09-05	0.00	0.00	0.00
徐玖琴	\N	2015-01-03	2016-09-03	568.00	568.00	0.00
成都蒋书记	\N	2017-01-04	2017-01-04	0.00	0.00	0.00
秦德荣	\N	2016-05-28	2016-05-28	40.00	40.00	0.00
熊德明	\N	2014-10-11	2015-12-09	4100.00	4100.00	0.00
林老师	\N	2016-01-13	2016-01-13	0.00	0.00	0.00
马仕凤	\N	2015-02-01	2015-02-01	392.00	392.00	0.00
廖局	\N	2016-04-30	2016-05-04	80.00	80.00	0.00
李国凤	\N	2015-11-26	2015-12-29	420.00	420.00	0.00
河南济源段小霞	\N	2015-03-27	2015-03-27	0.00	0.00	0.00
县法院	\N	2015-05-06	2015-05-06	480.00	480.00	0.00
旅游局-拍照	\N	2016-08-06	2016-08-06	0.00	0.00	0.00
黄老板	\N	2016-12-04	2016-12-04	288.00	288.00	0.00
县委食堂	\N	2017-04-20	2017-04-20	0.00	0.00	0.00
陆少群	\N	2017-01-09	2017-01-09	20.00	20.00	0.00
杨金花	\N	2014-11-06	2015-02-05	1013.00	1013.00	0.00
张承莲	\N	2014-09-12	2017-08-10	2656.00	2656.00	0.00
王朝富员工	\N	2017-06-23	2017-07-14	84.00	84.00	0.00
杨顺富	\N	2016-01-18	2016-01-18	360.00	360.00	0.00
重庆谢鑫	\N	2014-09-27	2014-09-27	0.00	0.00	0.00
唐先菊	\N	2014-09-02	2017-01-18	2000.00	2000.00	0.00
山东济宁张春英	\N	2015-04-15	2015-05-04	1500.00	1500.00	0.00
蒋力俊	\N	2016-12-16	2016-12-16	600.00	600.00	0.00
陈佩灵	\N	2015-01-21	2015-01-21	180.00	180.00	0.00
大连众普商贸	\N	2016-03-26	2016-03-26	0.00	0.00	0.00
明达许老师	\N	2017-03-22	2017-03-22	1200.00	1200.00	0.00
余玉蓉	\N	2015-12-29	2017-01-09	180.00	180.00	0.00
山东腾州李牧泉	\N	2015-03-31	2015-03-31	0.00	0.00	0.00
温雪冬	\N	2014-11-27	2014-11-27	90.00	90.00	0.00
梁志彬	\N	2016-01-15	2016-01-15	120.00	120.00	0.00
上海袁永祥	\N	2015-01-05	2015-01-20	620.00	620.00	0.00
苏春银	\N	2015-01-17	2017-01-03	170.00	170.00	0.00
小雪13880728710	\N	2016-11-29	2016-11-29	0.00	0.00	0.00
凯美塑料	\N	2017-01-05	2017-01-19	2297.00	2297.00	0.00
刘德富	\N	2016-08-08	2016-08-08	35.00	35.00	0.00
许光明	\N	2014-10-27	2015-02-08	2400.00	2400.00	0.00
邮政	\N	2016-05-26	2017-08-25	42311.00	42311.00	0.00
何老板-何煤炭	\N	2016-09-18	2016-11-16	384.00	384.00	0.00
朱明淑	\N	2014-12-23	2014-12-23	168.00	168.00	0.00
广东刘平	\N	2017-05-23	2017-05-23	0.00	0.00	0.00
向丽君13983776969	\N	2016-12-15	2016-12-15	48.00	48.00	0.00
重庆真本味食品有限公司（张鸭子）	\N	2016-09-12	2016-09-12	4172.00	4172.00	0.00
申光义	\N	2017-01-06	2017-01-06	900.00	900.00	0.00
何煤炭朋友	\N	2017-06-03	2017-06-03	600.00	600.00	0.00
会议室展品	\N	2016-08-30	2016-12-16	0.00	0.00	0.00
黄义红	\N	2016-08-28	2016-08-28	0.00	0.00	0.00
汪晓荣	\N	2016-01-07	2016-01-07	0.00	0.00	0.00
唐先慧	\N	2014-09-06	2017-01-21	1976.00	1976.00	0.00
杨老板（德阳）	\N	2014-11-12	2014-11-12	530.00	530.00	0.00
五块石程树林	\N	2016-05-28	2016-06-18	10010.00	10010.00	0.00
杨兰	\N	2016-11-27	2016-11-27	0.00	0.00	0.00
邮政罗建	\N	2016-02-15	2016-05-12	1877.00	1877.00	0.00
朱高玉	\N	2014-12-24	2014-12-24	705.00	705.00	0.00
黄林	\N	2014-10-06	2015-07-11	19690.00	19690.00	0.00
辽宁迟冬梅	\N	2015-03-22	2015-03-22	775.00	775.00	0.00
莫总	\N	2016-12-06	2016-12-06	0.00	0.00	0.00
攀枝花袁胜	\N	2016-11-04	2016-11-04	24.00	24.00	0.00
国税	\N	2015-06-29	2016-12-31	0.00	0.00	0.00
陕西黄总	\N	2016-05-06	2016-05-06	0.00	0.00	0.00
口福居	\N	2014-09-11	2016-12-14	600.00	600.00	0.00
滑石寨农家乐	\N	2015-05-14	2015-05-14	100.00	100.00	0.00
刘小琴	\N	2014-11-13	2014-11-13	172.00	172.00	0.00
吴兴红	\N	2016-01-27	2016-02-02	180.00	180.00	0.00
候总	\N	2015-11-24	2016-06-29	695.00	695.00	0.00
宁厂	\N	2016-10-25	2017-03-24	480.00	480.00	0.00
魏奎富 	\N	2015-04-18	2016-08-26	0.00	0.00	0.00
古胜见	\N	2017-05-18	2017-05-28	112.00	112.00	0.00
孟庆佳	\N	2016-09-21	2016-09-21	480.00	480.00	0.00
肖厚珍	\N	2015-01-10	2015-01-10	280.00	280.00	0.00
张玲餐厅	\N	2016-10-26	2016-10-26	76.00	76.00	0.00
周学宾	\N	2016-04-14	2017-01-14	640.00	640.00	0.00
常丹	\N	2016-04-28	2016-04-28	54.00	54.00	0.00
水发豆筋	\N	2017-02-20	2017-08-25	0.00	0.00	0.00
唐总1332031869	\N	2016-11-30	2016-11-30	160.00	160.00	0.00
永安监理公司	\N	2016-11-10	2016-11-10	650.00	650.00	0.00
明海食品杨成	\N	2015-01-09	2015-01-09	0.00	0.00	0.00
人人乐超市-江津	\N	2016-09-17	2016-09-17	10000.00	10000.00	0.00
端午节客情	\N	2017-05-26	2017-05-26	0.00	0.00	0.00
周世春员工	\N	2017-05-31	2017-05-31	40.00	40.00	0.00
山东淄博刘欣	\N	2015-06-02	2015-06-02	720.00	720.00	0.00
食堂领用	\N	2014-12-17	2016-11-24	55.00	55.00	0.00
湖北吴慧芬	\N	2016-09-24	2017-07-06	9256.00	9256.00	0.00
祥和火锅	\N	2014-09-25	2014-09-25	390.00	390.00	0.00
金带派出所	\N	2016-02-25	2017-06-14	1177.00	1177.00	0.00
孙红	15023857966	2014-10-06	2017-04-13	4486.00	4486.00	0.00
农商行电商	\N	2017-05-16	2017-05-16	0.00	0.00	0.00
尹述清	\N	2015-01-12	2015-07-09	464.00	464.00	0.00
宁波郑姐	15658202589	2017-03-08	2017-03-08	0.00	0.00	0.00
向丽君	\N	2016-12-15	2016-12-15	40.00	40.00	0.00
胡15923817852	\N	2017-06-26	2017-06-26	120.00	120.00	0.00
科委吕总	\N	2016-09-17	2016-09-17	0.00	0.00	0.00
周世春	\N	2014-12-26	2017-01-21	1835.00	1835.00	0.00
梁山城西小学	\N	2016-09-01	2016-09-01	500.00	500.00	0.00
李广	\N	2016-08-09	2017-07-05	470.00	470.00	0.00
杨小东	\N	2016-08-04	2016-08-04	200.00	200.00	0.00
广州张立彬	\N	2014-10-27	2014-10-27	0.00	0.00	0.00
掌上明珠杨总	\N	2015-11-26	2015-11-26	120.00	120.00	0.00
彭快餐	\N	2016-10-09	2017-02-22	1630.00	1630.00	0.00
兴隆担保	\N	2017-02-17	2017-05-04	0.00	0.00	0.00
徐老师	\N	2016-11-20	2016-11-20	1200.00	1200.00	0.00
刘永碧-员工	\N	2016-10-05	2016-11-25	168.00	168.00	0.00
谭群武	\N	2016-02-27	2017-03-06	751.00	751.00	0.00
罗合田	\N	2015-01-27	2015-01-27	70.00	70.00	0.00
罗万明	\N	2014-12-19	2014-12-19	525.00	525.00	0.00
陆国秀	\N	2016-08-08	2016-08-08	35.00	35.00	0.00
林记调味	\N	2014-09-14	2015-02-02	31580.00	31580.00	0.00
张师傅	\N	2016-04-12	2016-04-12	40.00	40.00	0.00
垫江参展	\N	2016-03-25	2016-03-28	0.00	0.00	0.00
彭涛	\N	2016-10-28	2016-10-28	240.00	240.00	0.00
谭海蓉	\N	2014-09-13	2014-10-20	132.00	132.00	0.00
重庆农委	\N	2017-04-20	2017-04-20	0.00	0.00	0.00
包老师	\N	2015-06-26	2015-06-26	340.00	340.00	0.00
贺章禄	\N	2014-09-02	2014-09-02	79.00	79.00	0.00
高万琼-员工	\N	2017-05-26	2017-05-26	40.00	40.00	0.00
顾文全	\N	2017-04-28	2017-04-28	490.00	490.00	0.00
翟其勇	\N	2014-10-24	2014-10-24	1500.00	1500.00	0.00
山东烟台卜媛	\N	2015-04-02	2015-04-02	0.00	0.00	0.00
蒋帮武	\N	2014-09-15	2016-12-05	6615.00	6615.00	0.00
沈大队	\N	2015-02-10	2016-12-30	700.00	700.00	0.00
山东副食	\N	2015-12-01	2016-12-29	404.00	404.00	0.00
徐勇	\N	2016-03-07	2016-03-07	4000.00	4000.00	0.00
工商银行饭堂	\N	2017-04-17	2017-07-11	315.00	315.00	0.00
山西大同刘海光	\N	2015-04-25	2015-04-25	2700.00	2700.00	0.00
科委	\N	2016-01-06	2016-03-15	0.00	0.00	0.00
仁贤小学-钟老师	\N	2017-04-24	2017-04-24	70.00	70.00	0.00
电力公司	\N	2016-08-07	2017-05-02	490.00	490.00	0.00
腾龙超市	\N	2017-01-19	2017-01-19	375.00	375.00	0.00
刘兴宇	\N	2016-01-16	2016-01-16	120.00	120.00	0.00
黄伟	\N	2014-12-04	2014-12-04	1350.00	1350.00	0.00
金带镇政府	\N	2014-10-16	2015-07-23	956.00	956.00	0.00
南充唐德军	\N	2016-05-29	2016-05-29	0.00	0.00	0.00
贯标赠送	\N	2017-03-15	2017-03-15	0.00	0.00	0.00
王成会	\N	2015-01-26	2015-12-01	109.00	109.00	0.00
蔡明红	\N	2016-05-30	2016-06-27	128.00	128.00	0.00
向德刚	13908264775,13908264775	2015-06-19	2015-11-10	2000.00	2000.00	0.00
13983958655	\N	2016-11-23	2016-11-23	0.00	0.00	0.00
黄姐	\N	2016-05-10	2016-05-10	320.00	320.00	0.00
公司饭堂	\N	2015-03-31	2016-08-13	240.00	240.00	0.00
梁老师	\N	2015-04-04	2015-04-04	70.00	70.00	0.00
滑石寨A区	\N	2014-09-06	2014-09-06	100.00	100.00	0.00
成都客户	\N	2015-04-13	2016-10-24	0.00	0.00	0.00
何军	\N	2015-09-09	2015-09-09	0.00	0.00	0.00
工商苏所	\N	2017-07-24	2017-07-24	812.00	812.00	0.00
重师大唐拥军	\N	2015-11-09	2015-11-09	160.00	160.00	0.00
陈师傅	\N	2017-01-13	2017-08-05	468.00	468.00	0.00
食药局江科长	\N	2017-05-22	2017-05-22	240.00	240.00	0.00
名豪夜食	13668412022	2017-03-27	2017-06-20	230.00	230.00	0.00
许老师	\N	2016-12-11	2017-02-14	3300.00	3300.00	0.00
锅炉外检	\N	2017-03-15	2017-03-15	0.00	0.00	0.00
文总	\N	2014-12-18	2014-12-18	600.00	600.00	0.00
易吉公	\N	2016-08-07	2016-08-07	40.00	40.00	0.00
边朝东 廖光丽	\N	2016-09-02	2016-09-02	0.00	0.00	0.00
刘厚兵	\N	2016-02-26	2016-02-26	35.00	35.00	0.00
刘芳	\N	2016-04-28	2016-04-28	60.00	60.00	0.00
销售部石磊	\N	2017-01-10	2017-05-04	1600.00	1600.00	0.00
深圳吴兵	\N	2014-10-11	2015-07-16	0.00	0.00	0.00
山东李叔泉	\N	2017-04-08	2017-04-08	0.00	0.00	0.00
屈继英	\N	2016-12-17	2016-12-17	780.00	780.00	0.00
周师傅	\N	2016-09-17	2017-08-14	221.00	221.00	0.00
曾明凤	\N	2014-09-18	2014-09-18	36.00	36.00	0.00
杨书记刘区长	\N	2017-05-28	2017-05-28	0.00	0.00	0.00
明海卤业青龙石分店	\N	2014-12-16	2014-12-16	0.00	0.00	0.00
王骑山	\N	2015-11-24	2016-02-28	616.00	616.00	0.00
云南马关-田茂芬	\N	2016-12-18	2016-12-18	0.00	0.00	0.00
姜柯	\N	2016-01-14	2016-01-14	540.00	540.00	0.00
茂森农家乐	\N	2016-11-06	2016-11-06	600.00	600.00	0.00
休闲车间	\N	2017-09-02	2017-09-18	0.00	0.00	0.00
石局	\N	2014-11-17	2014-12-27	616.00	616.00	0.00
罗青云	\N	2016-03-31	2016-03-31	160.00	160.00	0.00
派出所 	\N	2016-09-12	2016-09-12	200.00	200.00	0.00
向小兰	\N	2016-03-29	2016-03-29	210.00	210.00	0.00
梁平质检	\N	2015-11-18	2015-11-18	0.00	0.00	0.00
赖厚建	\N	2014-09-26	2015-06-28	1361.00	1361.00	0.00
北京赵老师	\N	2014-09-27	2014-09-27	0.00	0.00	0.00
丁美凤	\N	2016-09-07	2016-09-07	0.00	0.00	0.00
叶海成	\N	2016-08-24	2016-08-24	120.00	120.00	0.00
和田枣	\N	2016-02-24	2016-02-24	280.00	280.00	0.00
滑石寨 	\N	2015-05-31	2015-06-09	400.00	400.00	0.00
余舞群	\N	2017-09-07	2017-09-07	50.00	50.00	0.00
重庆孙红	\N	2015-03-23	2015-03-23	2700.00	2700.00	0.00
杭州何建凤	\N	2016-03-02	2016-03-02	70.00	70.00	0.00
陈其龙	\N	2016-03-07	2016-03-07	0.00	0.00	0.00
易绍国	\N	2016-10-03	2016-10-03	121.00	121.00	0.00
粥品天下	\N	2015-03-15	2016-06-01	1870.00	1870.00	0.00
重庆火锅协会	\N	2017-09-03	2017-09-03	0.00	0.00	0.00
黄老师（环监）	\N	2015-07-15	2015-07-15	150.00	150.00	0.00
言师傅	\N	2017-04-13	2017-04-13	30.00	30.00	0.00
工程试验	\N	2016-08-20	2016-08-20	0.00	0.00	0.00
刘大云	\N	2016-08-09	2017-01-19	780.00	780.00	0.00
李佳红国税	\N	2015-01-03	2015-01-03	0.00	0.00	0.00
汪黑鸭卤菜	\N	2016-10-26	2016-10-26	320.00	320.00	0.00
七香阁	\N	2015-04-29	2015-04-29	320.00	320.00	0.00
郑晓鸿	\N	2015-12-10	2015-12-10	80.00	80.00	0.00
重庆李工	\N	2017-04-11	2017-04-11	0.00	0.00	0.00
金源酒店	\N	2015-03-31	2015-03-31	200.00	200.00	0.00
个人	\N	2015-02-04	2015-02-07	690.00	690.00	0.00
曹小林	\N	2016-05-05	2016-05-05	20.00	20.00	0.00
首老师	\N	2015-02-06	2015-02-06	210.00	210.00	0.00
王里芬	\N	2016-03-15	2016-03-15	35.00	35.00	0.00
欧先生	13392871275	2017-05-31	2017-05-31	240.00	240.00	0.00
苏英	\N	2016-12-20	2016-12-20	100.00	100.00	0.00
旅游协会	\N	2014-12-31	2014-12-31	0.00	0.00	0.00
双桂堂展销	\N	2016-07-22	2016-10-05	156.00	156.00	0.00
重庆展销	\N	2015-06-03	2016-01-09	2374.00	2374.00	0.00
唐先蓉	\N	2016-12-03	2016-12-03	600.00	600.00	0.00
李伯琼	\N	2016-05-24	2016-09-03	240.00	240.00	0.00
湖北何总	\N	2017-04-26	2017-04-28	0.00	0.00	0.00
黄超（万州）	\N	2017-08-29	2017-08-29	1725.00	1725.00	0.00
陈中奎	\N	2016-07-17	2017-01-09	240.00	240.00	0.00
黄炳元	\N	2016-11-28	2016-11-28	60.00	60.00	0.00
新疆刘成	\N	2017-04-26	2017-04-26	2950.00	2950.00	0.00
李家沱展销	\N	2016-04-18	2016-04-18	1630.00	1630.00	0.00
锅炉检查	\N	2016-03-25	2016-03-25	0.00	0.00	0.00
唐良美	\N	2016-09-16	2016-09-16	672.00	672.00	0.00
远成小黄	\N	2017-08-04	2017-08-04	72.00	72.00	0.00
重庆曾冬梅	\N	2016-09-01	2017-05-12	1840.00	1840.00	0.00
陈松	13509412444	2015-09-16	2016-08-14	4580.00	4580.00	0.00
王毅	\N	2017-01-10	2017-01-10	404.00	404.00	0.00
王总	\N	2016-02-02	2016-02-02	140.00	140.00	0.00
梁平急控中心	\N	2016-01-05	2016-01-05	80.00	80.00	0.00
重庆科委	\N	2016-04-21	2016-04-21	0.00	0.00	0.00
蔡明凤	\N	2016-07-03	2017-01-14	240.00	240.00	0.00
唐老师	\N	2014-12-24	2015-11-29	440.00	440.00	0.00
杨万忠	\N	2016-11-26	2016-12-21	465.00	465.00	0.00
豆筋客户	\N	2016-10-24	2016-10-24	18.00	18.00	0.00
仁贤小学	\N	2017-03-03	2017-09-12	6458.00	6458.00	0.00
姚江波	\N	2014-12-20	2016-04-22	2381.00	2381.00	0.00
认证陈老师	\N	2016-01-06	2016-01-06	0.00	0.00	0.00
邓家园	\N	2014-11-05	2014-11-05	20.00	20.00	0.00
雅安李琼	13551559990	2016-11-09	2016-11-09	200.00	200.00	0.00
张光成	\N	2015-12-27	2015-12-27	240.00	240.00	0.00
公司员工	\N	2015-12-09	2016-04-28	2015.00	2015.00	0.00
文化镇中	\N	2016-05-20	2016-09-18	1050.00	1050.00	0.00
成都李德蓉	13348830058,028-83133091	2014-11-10	2015-01-07	12500.00	12500.00	0.00
何小姐	\N	2016-07-02	2016-07-02	100.00	100.00	0.00
安徽毛华军	\N	2017-02-23	2017-02-23	544.00	544.00	0.00
李辉	\N	2016-10-15	2016-10-15	525.00	525.00	0.00
重庆陈志勇	\N	2015-03-02	2015-03-02	1280.00	1280.00	0.00
刘萍	\N	2014-09-06	2015-02-07	1329.00	1329.00	0.00
谭总	\N	2016-09-06	2016-09-06	1170.00	1170.00	0.00
熊宗林-员工	\N	2016-09-24	2016-12-31	160.00	160.00	0.00
王朝明	\N	2017-02-27	2017-02-27	70.00	70.00	0.00
刘总	\N	2016-08-26	2016-08-26	660.00	660.00	0.00
忠县严英	\N	2014-10-24	2015-07-07	2415.00	2415.00	0.00
江津吴飞宏	\N	2014-11-08	2014-11-08	0.00	0.00	0.00
邓会英	\N	2016-12-07	2016-12-07	166.00	166.00	0.00
安监局	\N	2016-10-21	2016-10-21	0.00	0.00	0.00
向国平	\N	2017-01-10	2017-01-10	180.00	180.00	0.00
张富兰	\N	2014-09-16	2014-09-16	56.00	56.00	0.00
邓老师	\N	2017-01-14	2017-01-16	1200.00	1200.00	0.00
思暮网络	\N	2016-01-07	2016-02-02	1672.00	1672.00	0.00
重庆西部农交会	\N	2016-01-14	2016-01-14	0.00	0.00	0.00
南充肖远多	\N	2014-12-23	2015-01-06	2000.00	2000.00	0.00
河北邯郸孙占峰	\N	2015-03-26	2015-04-02	0.00	0.00	0.00
石含斌	13330732550	2017-04-12	2017-04-20	0.00	0.00	0.00
盈鑫汽贸	\N	2014-09-24	2014-09-24	0.00	0.00	0.00
陈志国	\N	2017-01-02	2017-01-02	120.00	120.00	0.00
张永莲	\N	2015-02-04	2015-02-04	35.00	35.00	0.00
广羽众	\N	2016-12-02	2016-12-02	0.00	0.00	0.00
胡丽君	\N	2014-09-29	2014-09-30	77.00	77.00	0.00
梁静	\N	2014-10-31	2015-01-03	681.00	681.00	0.00
科委检查	\N	2017-01-19	2017-01-19	0.00	0.00	0.00
蒋俊文	\N	2014-11-06	2014-11-06	45.00	45.00	0.00
吴远军-派出所	\N	2016-09-20	2016-09-20	96.00	96.00	0.00
昆明宏运干菜	\N	2016-03-31	2016-03-31	0.00	0.00	0.00
李望红	\N	2015-06-10	2017-01-20	1598.00	1598.00	0.00
包装	\N	2016-12-05	2016-12-05	0.00	0.00	0.00
黄如玉	\N	2016-08-09	2016-08-09	40.00	40.00	0.00
刘总-进出口	\N	2016-09-21	2016-09-21	84.00	84.00	0.00
杨文忠	\N	2016-12-18	2016-12-18	160.00	160.00	0.00
长沙夏红亮	\N	2017-05-25	2017-05-25	0.00	0.00	0.00
余玉荣	\N	2017-03-06	2017-05-04	100.00	100.00	0.00
侯老板	13996608535,13882860557	2017-01-19	2017-05-22	200.00	200.00	0.00
重庆全佳福药业有限公司	\N	2016-01-24	2016-01-28	3402.00	3402.00	0.00
曹久珍	\N	2016-04-27	2016-04-27	40.00	40.00	0.00
库房（干豆筋做鲜豆筋）	\N	2016-09-24	2016-10-25	0.00	0.00	0.00
银行礼品	\N	2015-08-05	2015-08-05	0.00	0.00	0.00
市农委	\N	2016-10-27	2016-10-27	200.00	200.00	0.00
汪团长	\N	2015-12-03	2015-12-03	0.00	0.00	0.00
邮政贷款	\N	2016-07-21	2016-07-21	0.00	0.00	0.00
万中建	\N	2017-07-02	2017-07-02	60.00	60.00	0.00
罗洪芬	\N	2014-09-11	2015-01-26	230.00	230.00	0.00
肖志谦	\N	2014-09-13	2014-09-13	100.00	100.00	0.00
卢少群	15808067720,15223564576	2016-04-07	2016-04-16	255.00	255.00	0.00
永辉超市	\N	2015-12-29	2015-12-29	0.00	0.00	0.00
巴中张乐平	\N	2017-04-02	2017-04-02	1800.00	1800.00	0.00
浙江石见	\N	2014-09-17	2014-10-31	1975.00	1975.00	0.00
陈丁娟	\N	2016-01-10	2016-01-10	120.00	120.00	0.00
作废	\N	2016-11-16	2016-11-16	0.00	0.00	0.00
易国儿	\N	2016-07-26	2016-07-26	100.00	100.00	0.00
金带政府司机	\N	2016-04-21	2016-04-21	100.00	100.00	0.00
重庆唐英	\N	2017-03-21	2017-03-21	34.00	34.00	0.00
李正碧	\N	2014-10-12	2014-11-21	150.00	150.00	0.00
塑佳曾总	\N	2015-02-04	2015-02-04	2160.00	2160.00	0.00
高丽翠	\N	2016-12-04	2016-12-15	380.00	380.00	0.00
梁平豆干-高铁站	\N	2017-06-09	2017-06-09	240.00	240.00	0.00
农商行	\N	2015-05-05	2016-05-06	0.00	0.00	0.00
魏总	\N	2016-08-07	2017-09-04	720.00	720.00	0.00
新城（彭姐）	\N	2017-08-31	2017-08-31	150.00	150.00	0.00
农委	\N	2015-06-12	2017-03-13	1768.00	1768.00	0.00
李总15023398878	\N	2016-12-15	2016-12-15	0.00	0.00	0.00
谭武琼	\N	2016-05-09	2016-08-29	125.00	125.00	0.00
吕卫国	\N	2016-02-18	2017-08-01	2366.00	2366.00	0.00
小雪	\N	2016-11-29	2016-11-29	0.00	0.00	0.00
曾顺玲	\N	2016-04-11	2016-12-12	320.00	320.00	0.00
金带唐主任	\N	2016-01-19	2016-01-19	180.00	180.00	0.00
哈哈鸡	\N	2017-09-04	2017-09-04	60.00	60.00	0.00
食药局曲姐	\N	2017-01-05	2017-01-07	720.00	720.00	0.00
重庆周主任	\N	2014-12-23	2014-12-23	0.00	0.00	0.00
黄小姜	\N	2014-12-24	2015-01-30	2324.00	2324.00	0.00
森宝谭总	\N	2016-09-18	2016-09-18	156.00	156.00	0.00
内蒙古刘宏宇	\N	2015-06-05	2015-06-05	0.00	0.00	0.00
武汉徐进	\N	2014-11-06	2014-11-06	0.00	0.00	0.00
谷静	\N	2017-05-29	2017-05-29	35.00	35.00	0.00
吕卫国-员工	\N	2016-09-28	2017-02-04	1316.00	1316.00	0.00
赖医生	\N	2016-10-19	2016-11-03	420.00	420.00	0.00
成都李祥军	18280254768	2015-11-26	2016-03-31	465.00	465.00	0.00
工商所李强	\N	2017-01-17	2017-01-17	180.00	180.00	0.00
肖远多	\N	2014-09-14	2014-11-10	2000.00	2000.00	0.00
张家燕员工	\N	2017-04-07	2017-05-08	520.00	520.00	0.00
奇爽老总样品	\N	2017-03-08	2017-04-28	0.00	0.00	0.00
贺斯明（德阳）	\N	2014-11-12	2014-11-12	530.00	530.00	0.00
郑州宋奉思	\N	2016-03-30	2016-03-30	0.00	0.00	0.00
灏业包装	\N	2016-11-20	2016-11-20	0.00	0.00	0.00
忠县赵万江	\N	2015-04-18	2016-06-10	3150.00	3150.00	0.00
黄中木	\N	2014-09-23	2017-01-15	2993.00	2993.00	0.00
上海金文食品	\N	2016-03-11	2016-07-07	20800.00	20800.00	0.00
何德万	\N	2016-01-03	2016-01-03	550.00	550.00	0.00
老干局	\N	2016-05-26	2016-06-17	1666.00	1666.00	0.00
谭琴	\N	2016-01-18	2016-01-18	60.00	60.00	0.00
赵春兰	\N	2014-09-20	2015-01-31	991.00	991.00	0.00
何老板	\N	2017-02-15	2017-02-15	1000.00	1000.00	0.00
盛叔荣	\N	2016-08-14	2016-11-14	240.00	240.00	0.00
建委刘彦	\N	2016-09-30	2016-09-30	320.00	320.00	0.00
刘宇英	\N	2014-12-28	2014-12-28	50.00	50.00	0.00
质检局	\N	2016-03-10	2016-03-10	478.00	478.00	0.00
万州侯亮	\N	2016-12-25	2016-12-25	0.00	0.00	0.00
李老师	\N	2014-10-10	2016-06-30	1250.00	1250.00	0.00
南江羊肉米粉	\N	2017-03-05	2017-04-29	710.00	710.00	0.00
李白琼-员工	\N	2016-09-14	2016-09-14	40.00	40.00	0.00
重庆徐勇	\N	2015-07-30	2017-07-19	1900.00	1900.00	0.00
刘天福	\N	2016-11-01	2016-11-01	525.00	525.00	0.00
奇味食品	\N	2015-10-07	2015-10-07	0.00	0.00	0.00
样品	\N	2016-08-14	2016-11-18	0.00	0.00	0.00
河北秦皇岛张明	\N	2015-05-07	2015-05-07	0.00	0.00	0.00
驻马店于江丽	\N	2015-11-06	2015-11-06	1600.00	1600.00	0.00
地税稽查局	\N	2016-11-07	2016-11-07	0.00	0.00	0.00
蒋波	\N	2016-11-23	2016-11-23	635.00	635.00	0.00
顾老师	\N	2014-09-29	2014-09-29	35.00	35.00	0.00
中国雷锋网	\N	2015-08-27	2015-08-27	0.00	0.00	0.00
五斗米曾有光	\N	2016-12-05	2017-02-25	25960.00	25960.00	0.00
方承环	\N	2016-12-02	2016-12-02	160.00	160.00	0.00
西安客户	\N	2015-11-03	2015-11-03	0.00	0.00	0.00
七香阁鸡庄	\N	2015-05-22	2016-01-02	560.00	560.00	0.00
达州张姐	13458171363	2014-09-17	2014-09-17	0.00	0.00	0.00
明海卤业	\N	2014-09-02	2017-04-18	6355.00	6355.00	0.00
中秋礼品	\N	2015-09-25	2015-09-29	0.00	0.00	0.00
岳卫15881006960	\N	2017-02-14	2017-03-17	3046.00	3046.00	0.00
成都瑶瑶	\N	2016-12-10	2016-12-10	0.00	0.00	0.00
武汉谢知明	\N	2016-01-19	2017-01-05	4900.00	4900.00	0.00
古生见	\N	2017-08-12	2017-08-12	120.00	120.00	0.00
温学东	\N	2014-09-29	2014-09-29	55.00	55.00	0.00
深圳胡小姐	\N	2016-03-30	2016-03-30	100.00	100.00	0.00
孙快餐	\N	2016-11-07	2017-04-02	1890.00	1890.00	0.00
惠州游川	\N	2017-06-16	2017-06-16	0.00	0.00	0.00
谢云	\N	2015-06-25	2015-06-25	70.00	70.00	0.00
杨长国	\N	2016-12-25	2016-12-25	56.00	56.00	0.00
谭成	\N	2016-07-17	2016-07-17	1000.00	1000.00	0.00
刘芳-员工	\N	2016-10-06	2016-10-06	50.00	50.00	0.00
渝北郑成聪	\N	2014-11-19	2014-11-19	1350.00	1350.00	0.00
范书记	\N	2015-10-07	2016-06-05	831.50	831.50	0.00
黄宗元	\N	2014-12-14	2016-12-29	2103.00	2103.00	0.00
休闲食品	\N	2015-10-13	2016-01-05	0.00	0.00	0.00
姥家大锅台	\N	2014-09-11	2014-11-02	430.00	430.00	0.00
龙舟玲	\N	2016-11-13	2017-01-15	155.00	155.00	0.00
陆元奎	\N	2016-01-22	2016-01-22	264.00	264.00	0.00
韩德秋	\N	2017-09-04	2017-09-04	120.00	120.00	0.00
姜山	\N	2016-01-30	2016-01-30	0.00	0.00	0.00
贺孝惠	13708335453	2017-03-17	2017-03-17	200.00	200.00	0.00
平野大酒店	\N	2016-09-29	2016-09-29	330.00	330.00	0.00
万州锅炉检测中心	\N	2017-08-17	2017-08-17	0.00	0.00	0.00
佛山丁爱云	\N	2016-11-07	2016-11-07	32.00	32.00	0.00
王师傅	13983231124,13983231124	2016-12-28	2016-12-28	80.00	80.00	0.00
保定郭立功	\N	2015-12-01	2016-03-30	2600.00	2600.00	0.00
河南殷俊杰	\N	2016-04-21	2016-07-02	3630.00	3630.00	0.00
彭姐	\N	2017-05-26	2017-05-26	30.00	30.00	0.00
招待客户-秘鲁进出口	\N	2016-09-22	2016-09-22	0.00	0.00	0.00
邓莉娜	\N	2014-09-17	2014-09-17	280.00	280.00	0.00
今天饲料	\N	2015-02-11	2015-02-11	48.00	48.00	0.00
达州王小红	\N	2017-03-22	2017-03-22	350.00	350.00	0.00
大都钢材	\N	2016-03-17	2016-03-17	240.00	240.00	0.00
侯国	\N	2017-07-24	2017-07-24	630.00	630.00	0.00
哈尔滨李平	\N	2016-03-31	2016-03-31	0.00	0.00	0.00
李总客情	\N	2017-02-03	2017-02-03	0.00	0.00	0.00
东莞汪勇	\N	2016-04-05	2016-04-05	900.00	900.00	0.00
曹晖	\N	2016-02-03	2016-02-03	312.00	312.00	0.00
王顺木	\N	2015-01-20	2015-01-20	88.00	88.00	0.00
国税局雷宁	\N	2017-04-07	2017-04-07	0.00	0.00	0.00
蜀达饲料	\N	2015-02-12	2017-01-16	16344.00	16344.00	0.00
龙顺久	\N	2016-04-27	2017-01-16	945.00	945.00	0.00
金荣树	\N	2014-12-04	2014-12-04	180.00	180.00	0.00
成都展销	\N	2014-10-23	2014-10-31	2075.00	2075.00	0.00
派出所	\N	2014-09-05	2015-07-15	0.00	0.00	0.00
长沙陈艳枝	\N	2015-04-27	2015-05-08	1050.00	1050.00	0.00
遵义荣虎源	\N	2015-12-01	2017-06-27	9000.00	9000.00	0.00
金带镇	\N	2015-04-03	2015-04-03	0.00	0.00	0.00
唐总	\N	2016-08-27	2016-10-10	160.00	160.00	0.00
叶光翠	\N	2016-12-13	2016-12-13	80.00	80.00	0.00
黎维芬	\N	2014-11-07	2014-11-07	60.00	60.00	0.00
黄光荣	\N	2015-06-27	2016-06-28	347.00	347.00	0.00
公司团年饭堂	\N	2016-01-30	2016-01-30	0.00	0.00	0.00
刘永碧员工	\N	2017-05-31	2017-05-31	40.00	40.00	0.00
东门好人家	\N	2016-08-04	2016-08-11	2000.00	2000.00	0.00
新华小学	\N	2016-09-18	2016-09-18	700.00	700.00	0.00
余武琼	\N	2015-01-13	2017-01-21	1376.00	1376.00	0.00
张修清	\N	2015-01-26	2016-12-30	182.00	182.00	0.00
河南胡明群	\N	2014-12-22	2014-12-22	0.00	0.00	0.00
礼让小学	\N	2016-06-03	2016-12-27	2800.00	2800.00	0.00
刘小姐	\N	2016-02-27	2016-02-27	264.00	264.00	0.00
王维	15215282186,15215282186	2016-05-09	2017-08-01	275.00	275.00	0.00
罗成雪	\N	2015-11-05	2016-02-02	170.00	170.00	0.00
罗建邮政	\N	2016-01-28	2016-01-28	32296.00	32296.00	0.00
苏贞昌	\N	2015-02-03	2015-02-03	440.00	440.00	0.00
烟草公司	\N	2015-03-11	2015-11-12	4361.00	4361.00	0.00
申通快递	\N	2017-06-21	2017-06-21	120.00	120.00	0.00
邓丽容	\N	2014-10-25	2014-10-25	42.00	42.00	0.00
福建莆田魏奎军	\N	2015-05-15	2015-05-15	280.00	280.00	0.00
忠县王世勇	\N	2015-05-02	2016-09-06	1575.00	1575.00	0.00
北京王成	\N	2015-03-26	2015-03-26	0.00	0.00	0.00
重庆蔡俊	\N	2016-11-03	2016-11-03	0.00	0.00	0.00
山东济宁	\N	2015-05-23	2015-05-23	0.00	0.00	0.00
严莉	\N	2017-05-19	2017-06-24	300.00	300.00	0.00
江北徐世军	\N	2015-06-06	2015-06-06	0.00	0.00	0.00
杨平	18983533249	2016-10-11	2016-10-31	96.00	96.00	0.00
正味餐料行	\N	2014-09-16	2014-09-16	1000.00	1000.00	0.00
保健院赖医生	\N	2016-04-15	2016-04-15	40.00	40.00	0.00
李广出差重庆	\N	2017-03-07	2017-03-07	0.00	0.00	0.00
成都糖酒会	\N	2016-03-18	2016-03-28	0.00	0.00	0.00
黎总	\N	2016-02-26	2016-08-24	1434.00	1434.00	0.00
高宝翠	\N	2016-01-03	2016-11-08	555.00	555.00	0.00
孙小姐	18983531605,18983531605	2016-09-05	2017-07-31	282.00	282.00	0.00
金带李主任	\N	2014-09-26	2014-09-26	110.00	110.00	0.00
锅炉魏经理	\N	2015-03-14	2015-09-03	0.00	0.00	0.00
孙燕	\N	2017-09-05	2017-09-05	80.00	80.00	0.00
永川秦小华	\N	2017-01-02	2017-01-02	700.00	700.00	0.00
黎昌奎	\N	2015-01-16	2015-01-16	14.00	14.00	0.00
奇香阁	\N	2015-01-06	2015-01-06	240.00	240.00	0.00
建委	\N	2016-09-29	2016-09-29	468.00	468.00	0.00
吕老板	\N	2014-12-24	2014-12-26	3300.00	3300.00	0.00
廖会长	13635388358	2016-01-25	2016-04-08	1327.00	1327.00	0.00
梁平豆腐干	\N	2017-08-13	2017-08-13	960.00	960.00	0.00
曾教授	\N	2015-09-29	2015-09-29	0.00	0.00	0.00
水发实验	\N	2016-05-23	2016-06-17	0.00	0.00	0.00
黄军帮	\N	2015-12-05	2015-12-05	60.00	60.00	0.00
黄立	\N	2016-04-30	2016-04-30	50.00	50.00	0.00
农委王孝仕	\N	2016-03-16	2017-08-21	248.00	248.00	0.00
农委周科	\N	2016-02-05	2016-02-05	144.00	144.00	0.00
信阳张经理	15037675942张挺	2017-03-05	2017-03-05	0.00	0.00	0.00
土城门饭店	\N	2017-05-02	2017-05-02	120.00	120.00	0.00
杨忠元	\N	2014-09-26	2014-09-26	100.00	100.00	0.00
达州盛世阳光	13666101899	2016-08-18	2017-02-04	750.00	750.00	0.00
廖兴菊员工	\N	2017-05-26	2017-05-31	92.00	92.00	0.00
罗成学	\N	2016-12-08	2017-01-21	355.00	355.00	0.00
沈阳刘臣	\N	2015-09-05	2015-09-05	0.00	0.00	0.00
实验品	\N	2016-05-08	2016-08-25	0.00	0.00	0.00
老姚	\N	2015-12-02	2016-05-04	205.00	205.00	0.00
赵红食品	15696526796,15696526796	2016-03-20	2017-01-14	2640.00	2640.00	0.00
曹九珍	\N	2016-04-08	2016-04-08	40.00	40.00	0.00
湖南客户	\N	2015-05-21	2015-05-21	0.00	0.00	0.00
北京顺义柳雪朝	\N	2015-06-03	2015-06-03	0.00	0.00	0.00
李万红	18983531840	2017-02-23	2017-07-31	346.00	346.00	0.00
好视力眼睛店	\N	2016-04-29	2016-04-29	240.00	240.00	0.00
梁平老火锅	\N	2014-09-14	2014-10-23	495.00	495.00	0.00
青华超市黄松	\N	2015-03-27	2015-03-27	115.00	115.00	0.00
赵华莲	\N	2016-10-19	2017-09-16	5250.00	5250.00	0.00
林宏元	\N	2014-09-30	2014-09-30	50.00	50.00	0.00
高宝翠员工	\N	2017-06-13	2017-06-13	120.00	120.00	0.00
实验幼儿园华老师	\N	2016-09-22	2016-09-22	32.00	32.00	0.00
高礼平	\N	2014-09-07	2014-09-07	110.00	110.00	0.00
莫骄	\N	2015-04-29	2015-04-29	200.00	200.00	0.00
员工	\N	2016-09-17	2017-05-28	826.00	826.00	0.00
全牛汤锅	\N	2015-03-20	2015-03-20	110.00	110.00	0.00
锦和范	\N	2017-09-09	2017-09-09	1150.00	1150.00	0.00
重庆华渝宾馆	\N	2016-10-15	2016-10-15	600.00	600.00	0.00
蒋礼丽	\N	2014-12-19	2014-12-19	80.00	80.00	0.00
杨柏香13914603539	\N	2016-12-09	2016-12-09	0.00	0.00	0.00
冉和平	\N	2015-12-25	2015-12-25	60.00	60.00	0.00
农村淘宝	\N	2015-11-16	2015-11-16	0.00	0.00	0.00
张安东	\N	2014-10-16	2014-12-24	198.00	198.00	0.00
何天成	\N	2016-05-05	2017-01-21	215.00	215.00	0.00
泓源泰商贸	\N	2016-06-20	2016-09-23	11340.00	11340.00	0.00
重庆银行陈行长	\N	2016-08-18	2016-08-18	150.00	150.00	0.00
蔡清江	\N	2015-01-21	2015-01-21	120.00	120.00	0.00
张忠兵	\N	2017-05-05	2017-05-05	176.00	176.00	0.00
徐世君	13068397666	2017-03-29	2017-03-29	0.00	0.00	0.00
会议室样品	\N	2017-05-06	2017-05-06	0.00	0.00	0.00
江苏翟总	\N	2014-09-17	2016-07-06	0.00	0.00	0.00
清华超市	\N	2014-10-21	2017-07-09	8610.00	8610.00	0.00
蔡民凤	\N	2017-01-11	2017-01-11	64.00	64.00	0.00
秦姐饭店	\N	2014-10-04	2014-10-04	200.00	200.00	0.00
优优御品商贸	\N	2016-07-21	2016-07-21	0.00	0.00	0.00
成都周总	\N	2016-03-02	2016-03-02	0.00	0.00	0.00
黄玉兰	\N	2016-01-11	2016-01-11	84.00	84.00	0.00
福建蒋志通	\N	2015-04-28	2015-04-28	180.00	180.00	0.00
翁丽媛	13364575885	2017-01-11	2017-01-11	575.00	575.00	0.00
公安局	\N	2015-12-25	2015-12-25	400.00	400.00	0.00
陈老板	\N	2015-01-19	2015-01-19	140.00	140.00	0.00
黄秋菊	\N	2016-06-24	2016-06-24	35.00	35.00	0.00
廖伟	18523788627	2016-09-02	2016-09-02	60.00	60.00	0.00
达州张春福	\N	2015-02-09	2015-02-09	0.00	0.00	0.00
张秀清	\N	2014-12-31	2015-03-15	312.00	312.00	0.00
谭功祥	\N	2017-01-10	2017-01-10	250.00	250.00	0.00
李总朋友	\N	2017-04-25	2017-04-25	32.00	32.00	0.00
五一完小	\N	2016-06-12	2016-06-12	700.00	700.00	0.00
张桂英	\N	2017-01-16	2017-01-16	180.00	180.00	0.00
建筑公司	\N	2016-03-19	2016-04-13	2470.00	2470.00	0.00
环保局	\N	2014-10-28	2014-11-27	0.00	0.00	0.00
江中会	\N	2016-12-10	2016-12-10	120.00	120.00	0.00
西安杨永安	\N	2015-11-14	2015-11-14	2400.00	2400.00	0.00
社保杨局	\N	2015-11-18	2015-11-18	850.00	850.00	0.00
文化铭记超市	\N	2017-01-03	2017-01-03	640.00	640.00	0.00
梁平特产	\N	2016-11-15	2017-08-23	7951.00	7951.00	0.00
魏奎军	\N	2014-09-30	2017-06-07	949.00	949.00	0.00
袁总	\N	2016-10-06	2017-03-07	840.00	840.00	0.00
宁安文-赠送-梁平区环保局	\N	2017-09-15	2017-09-15	0.00	0.00	0.00
莫老板	\N	2015-04-02	2015-04-02	0.00	0.00	0.00
唐蔚	\N	2017-02-28	2017-02-28	44.00	44.00	0.00
方方	\N	2014-12-25	2014-12-25	120.00	120.00	0.00
万州向德钢	\N	2016-01-29	2016-03-03	2100.00	2100.00	0.00
西南大学实验	\N	2015-11-08	2016-04-18	0.00	0.00	0.00
石氏调味	\N	2015-04-07	2015-04-07	1500.00	1500.00	0.00
重庆展会	\N	2015-01-27	2015-01-27	2350.00	2350.00	0.00
宜宾闻老板	\N	2014-11-19	2014-12-06	2080.00	2080.00	0.00
谢老板	\N	2016-09-08	2016-09-08	1560.00	1560.00	0.00
万老板	\N	2017-07-01	2017-07-01	51.00	51.00	0.00
公司食堂	\N	2016-03-10	2016-08-09	180.00	180.00	0.00
高速公路三分部	\N	2016-01-08	2016-01-08	140.00	140.00	0.00
陈霞飞	\N	2017-01-05	2017-05-15	1040.00	1040.00	0.00
定州刘静	\N	2015-12-13	2015-12-13	0.00	0.00	0.00
黎总（唐庄）	\N	2016-08-15	2016-08-20	1100.00	1100.00	0.00
万州检测	\N	2017-02-20	2017-06-13	0.00	0.00	0.00
吴拜子	\N	2015-11-26	2016-01-20	160.00	160.00	0.00
武汉龚文斌	\N	2016-03-30	2016-03-30	0.00	0.00	0.00
李佳慧	\N	2016-12-30	2017-01-11	216.00	216.00	0.00
重庆第八届火锅节	\N	2016-10-24	2016-10-24	0.00	0.00	0.00
刘永碧	\N	2015-12-13	2017-03-12	1105.00	1105.00	0.00
曹廷玲员工	\N	2017-05-29	2017-05-29	60.00	60.00	0.00
新源宾馆	\N	2017-08-15	2017-08-15	187.00	187.00	0.00
门卫	\N	2016-11-01	2016-11-01	80.00	80.00	0.00
熊润兰	\N	2015-01-11	2015-01-11	240.00	240.00	0.00
杨世英	\N	2016-01-28	2017-01-10	410.00	410.00	0.00
高妹儿-员工	\N	2016-09-23	2016-09-23	10.00	10.00	0.00
重庆客户	\N	2015-06-23	2015-06-23	0.00	0.00	0.00
满堂红	\N	2016-05-26	2016-05-26	2010.00	2010.00	0.00
养猪户	\N	2015-12-28	2016-03-05	262.00	262.00	0.00
百世汇通	\N	2017-08-28	2017-08-28	480.00	480.00	0.00
郑维勇	\N	2017-03-02	2017-08-12	2890.00	2890.00	0.00
黄中元-员工	\N	2016-09-14	2017-01-07	180.00	180.00	0.00
彭国建	57000031,13008373791	2015-02-03	2015-02-03	1000.00	1000.00	0.00
新加坡朱红慧	\N	2016-11-19	2016-11-19	0.00	0.00	0.00
冯妈老火锅云龙	\N	2015-12-29	2015-12-29	360.00	360.00	0.00
拱桥兴旺超市周维成	\N	2017-01-03	2017-01-03	325.00	325.00	0.00
江北张教授	\N	2015-04-16	2015-04-16	0.00	0.00	0.00
熊中林	\N	2016-05-05	2017-05-24	305.00	305.00	0.00
陈慧莲138909157078	\N	2016-12-14	2016-12-14	0.00	0.00	0.00
曹丽红	\N	2016-09-24	2016-09-24	0.00	0.00	0.00
名豪展销会	\N	2015-03-14	2015-07-06	2006.00	2006.00	0.00
杨志银	\N	2014-09-27	2015-01-26	353.00	353.00	0.00
李燕	\N	2017-09-07	2017-09-07	40.00	40.00	0.00
华鑫办公	\N	2016-04-18	2016-04-18	35.00	35.00	0.00
公安局李辉斌	\N	2015-11-07	2015-11-07	0.00	0.00	0.00
鼻祖火锅	\N	2016-10-29	2016-10-29	120.00	120.00	0.00
周盛强	\N	2015-02-01	2015-02-01	600.00	600.00	0.00
龙周燕	\N	2016-03-12	2016-06-24	100.00	100.00	0.00
石磊出差退货	\N	2017-03-07	2017-03-24	0.00	0.00	0.00
曾冬梅	\N	2016-09-30	2016-09-30	303.00	303.00	0.00
李芬	\N	2016-12-25	2016-12-25	300.00	300.00	0.00
胡友琴	\N	2016-10-02	2016-10-02	78.00	78.00	0.00
何煤碳	\N	2016-09-29	2017-08-26	810.00	810.00	0.00
平野酒店	\N	2015-06-17	2015-06-17	2800.00	2800.00	0.00
郑州李俊红	\N	2015-11-04	2015-11-04	0.00	0.00	0.00
展示柜	\N	2017-02-20	2017-02-20	0.00	0.00	0.00
送样	\N	2016-11-30	2016-11-30	0.00	0.00	0.00
老刘	\N	2016-05-15	2016-05-15	116.00	116.00	0.00
吕门卫	\N	2016-08-13	2016-08-13	40.00	40.00	0.00
火辣辣	\N	2015-01-18	2015-01-18	200.00	200.00	0.00
罗红芬	\N	2014-12-27	2014-12-27	120.00	120.00	0.00
春节礼品	\N	2017-01-26	2017-01-26	0.00	0.00	0.00
山东卜媛	\N	2015-04-14	2015-04-14	1800.00	1800.00	0.00
交警队	\N	2016-03-17	2016-03-17	0.00	0.00	0.00
国华烟酒	\N	2015-10-15	2015-12-18	236.00	236.00	0.00
区法院	\N	2017-07-11	2017-07-11	0.00	0.00	0.00
森华园林绿化	\N	2016-06-10	2016-06-10	1100.00	1100.00	0.00
陈玲	\N	2014-12-25	2014-12-27	180.00	180.00	0.00
亿联展示	\N	2016-07-11	2016-07-11	0.00	0.00	0.00
曹桂玉	\N	2016-02-02	2016-12-24	180.00	180.00	0.00
乌鲁木齐王有锋	\N	2016-03-31	2016-03-31	0.00	0.00	0.00
邓胖儿调料	\N	2015-02-07	2015-02-07	1500.00	1500.00	0.00
兰州潘光芬	\N	2016-04-23	2016-04-29	1120.00	1120.00	0.00
公司团年赠品	\N	2015-02-10	2015-02-10	0.00	0.00	0.00
老游	\N	2016-01-31	2016-01-31	60.00	60.00	0.00
武汉吴开熊	\N	2016-03-30	2016-03-30	0.00	0.00	0.00
莱茵虎地板曾	\N	2015-06-10	2016-06-28	660.00	660.00	0.00
罗老师	\N	2015-04-18	2015-04-18	432.00	432.00	0.00
陈英豪	\N	2015-11-03	2016-11-26	186.00	186.00	0.00
陶万凤	\N	2014-09-07	2014-09-18	338.00	338.00	0.00
唐万	\N	2017-01-03	2017-01-03	105.00	105.00	0.00
杨文豪	\N	2015-02-25	2015-02-25	160.00	160.00	0.00
谭君武	\N	2016-10-04	2016-11-01	189.00	189.00	0.00
国税雷宇	\N	2016-04-09	2016-04-09	0.00	0.00	0.00
大世界王燕	\N	2015-02-09	2015-02-09	0.00	0.00	0.00
夏雪兰	\N	2017-01-08	2017-01-08	60.00	60.00	0.00
福建连江郑政风	\N	2015-04-23	2015-04-23	360.00	360.00	0.00
盘溪-曾冬梅	\N	2016-10-15	2017-03-06	2155.00	2155.00	0.00
余伍琼 谢启凤	\N	2016-09-02	2016-09-02	90.00	90.00	0.00
张宏	\N	2014-10-11	2014-10-11	28.00	28.00	0.00
周老师	\N	2015-04-08	2015-04-08	105.00	105.00	0.00
张玉清	\N	2016-01-14	2016-01-14	60.00	60.00	0.00
李常委	\N	2015-10-20	2015-10-20	0.00	0.00	0.00
游师傅	\N	2017-08-01	2017-08-01	35.00	35.00	0.00
湖南省桃林佬食品	\N	2016-08-13	2016-08-13	12800.00	12800.00	0.00
余伍琼	\N	2015-04-28	2017-04-11	1547.00	1547.00	0.00
田传菊	\N	2014-12-19	2015-01-17	760.00	760.00	0.00
梁平展销会	\N	2016-11-09	2016-11-09	9390.00	9390.00	0.00
和林快递	\N	2016-07-14	2016-07-14	50.00	50.00	0.00
耗儿鱼	\N	2014-10-15	2014-10-15	200.00	200.00	0.00
唐先悲	\N	2014-11-24	2014-11-24	115.00	115.00	0.00
刘鸭婆	\N	2017-05-10	2017-06-27	1290.00	1290.00	0.00
曹辉	\N	2014-09-05	2014-09-05	110.00	110.00	0.00
刘继德	\N	2017-02-28	2017-02-28	115.00	115.00	0.00
传奇火锅	\N	2015-05-05	2015-06-12	385.00	385.00	0.00
树上鲜李伦祥	\N	2016-04-01	2016-04-01	0.00	0.00	0.00
何德贵	\N	2016-08-10	2016-08-10	40.00	40.00	0.00
张佳凤	\N	2017-01-05	2017-01-05	200.00	200.00	0.00
伙食团	\N	2016-06-04	2016-06-04	60.00	60.00	0.00
孙老板	\N	2016-10-16	2016-10-23	360.00	360.00	0.00
达州正味	\N	2014-10-18	2014-10-18	1000.00	1000.00	0.00
中国银行	\N	2015-11-11	2015-11-11	0.00	0.00	0.00
李总（机器）	\N	2014-10-15	2014-10-15	142.00	142.00	0.00
吴老师	\N	2016-07-01	2016-07-01	160.00	160.00	0.00
金老板	\N	2015-04-05	2015-04-05	180.00	180.00	0.00
华西资产评估	\N	2015-12-13	2015-12-13	1960.00	1960.00	0.00
泉州阿东	\N	2016-02-25	2016-03-02	970.00	970.00	0.00
重庆今天饲料	\N	2015-02-11	2015-02-11	2176.00	2176.00	0.00
候老板	\N	2016-08-20	2017-01-14	396.00	396.00	0.00
华渝宾馆	\N	2014-09-10	2017-03-07	25800.00	25800.00	0.00
杨永红江西	\N	2017-05-27	2017-05-27	52.00	52.00	0.00
好又佳	\N	2015-01-13	2016-03-30	171.00	171.00	0.00
石桥界牌	\N	2017-01-03	2017-01-20	265.00	265.00	0.00
陈宗高	\N	2017-04-04	2017-07-09	140.00	140.00	0.00
立城	\N	2015-02-05	2015-02-05	199.00	199.00	0.00
张成莲	\N	2017-04-13	2017-04-13	120.00	120.00	0.00
金带张镇	\N	2016-05-11	2016-07-03	280.00	280.00	0.00
杨先生18613030939	\N	2016-12-27	2016-12-27	100.00	100.00	0.00
一品土菜李总	13908263219	2016-08-19	2016-08-19	780.00	780.00	0.00
龙周玲	\N	2015-01-05	2017-08-31	1172.00	1172.00	0.00
杨	18996674358	2016-11-06	2016-11-06	120.00	120.00	0.00
万州小贷公司	\N	2017-01-09	2017-01-09	0.00	0.00	0.00
兴隆评估	\N	2016-05-24	2016-05-24	0.00	0.00	0.00
江良琼	\N	2016-11-27	2016-11-27	96.00	96.00	0.00
刘兴勇	\N	2016-11-16	2016-11-16	600.00	600.00	0.00
山西客户	\N	2015-04-20	2015-04-20	0.00	0.00	0.00
何家	\N	2017-03-01	2017-03-01	32.00	32.00	0.00
智勇科技	\N	2016-08-03	2016-08-03	0.00	0.00	0.00
雅安水电公司	\N	2015-04-17	2015-04-17	0.00	0.00	0.00
河南李谊成	\N	2016-08-14	2016-08-14	204.00	204.00	0.00
宜宾胡总	\N	2016-05-06	2016-05-06	0.00	0.00	0.00
成都王军	13881904320	2014-11-05	2014-11-16	5000.00	5000.00	0.00
乾街唐总	\N	2015-02-04	2015-02-04	5840.00	5840.00	0.00
戴斯谭老板	\N	2017-07-01	2017-07-01	180.00	180.00	0.00
杨圣梅	\N	2016-12-31	2016-12-31	770.00	770.00	0.00
李金龙	\N	2016-01-06	2016-04-26	586.00	586.00	0.00
万州技术监督局	\N	2016-12-13	2016-12-13	0.00	0.00	0.00
工商所	\N	2015-06-03	2016-11-10	300.00	300.00	0.00
林洪元	\N	2014-09-22	2014-09-23	130.00	130.00	0.00
景和苑	\N	2016-11-02	2016-12-01	1150.00	1150.00	0.00
廖先菊	\N	2017-05-09	2017-05-09	40.00	40.00	0.00
陈武菊	\N	2014-09-06	2014-09-13	90.00	90.00	0.00
河南焦作胡亚斌	\N	2015-03-31	2015-03-31	850.00	850.00	0.00
利川郭德全	\N	2016-03-31	2016-03-31	0.00	0.00	0.00
招商局	\N	2016-08-11	2016-08-11	0.00	0.00	0.00
食药局	\N	2014-09-16	2017-06-29	792.00	792.00	0.00
张志彬	13543451136	2017-06-19	2017-06-19	0.00	0.00	0.00
娜娜	\N	2015-12-23	2015-12-23	108.00	108.00	0.00
展示柜（退货）	\N	2017-05-18	2017-05-18	0.00	0.00	0.00
百事快递	\N	2017-09-04	2017-09-04	480.00	480.00	0.00
黑龙江大庆陈纯生	\N	2015-06-02	2015-06-02	0.00	0.00	0.00
水发休闲食品	\N	2015-05-07	2015-05-07	0.00	0.00	0.00
浪浪鱼	\N	2017-02-07	2017-02-07	600.00	600.00	0.00
公司拍照	\N	2016-06-22	2016-06-22	0.00	0.00	0.00
袁老师	\N	2017-06-30	2017-06-30	300.00	300.00	0.00
万州 蒋帮武	\N	2017-09-12	2017-09-12	1955.00	1955.00	0.00
周后中	\N	2015-01-07	2015-01-07	70.00	70.00	0.00
忠县刘忠宪	\N	2016-04-14	2016-08-03	2625.00	2625.00	0.00
工商银行丁老师	\N	2016-08-17	2016-08-17	320.00	320.00	0.00
郑州林原调味	\N	2016-03-30	2016-03-30	0.00	0.00	0.00
公司研发实验	\N	2015-04-26	2015-11-18	0.00	0.00	0.00
刘天贵	\N	2017-08-17	2017-08-17	240.00	240.00	0.00
汪元德	\N	2015-03-30	2015-05-14	1664.00	1664.00	0.00
江苏无锡	\N	2015-03-27	2015-03-27	0.00	0.00	0.00
游中凡	\N	2015-04-04	2015-04-04	1000.00	1000.00	0.00
魏奎琼	\N	2015-01-02	2016-06-12	622.00	622.00	0.00
富安娜	\N	2015-02-07	2015-02-07	320.00	320.00	0.00
夏学兰	\N	2016-07-23	2016-12-08	50.00	50.00	0.00
国税局	\N	2015-02-05	2016-12-23	0.00	0.00	0.00
廖京波	\N	2016-01-22	2016-01-22	320.00	320.00	0.00
远程小黄	\N	2016-03-12	2016-04-16	275.00	275.00	0.00
安检-黄	\N	2016-10-28	2016-10-28	80.00	80.00	0.00
金老师	\N	2015-02-06	2016-02-02	660.00	660.00	0.00
彭总	18837271111	2017-03-20	2017-03-20	60.00	60.00	0.00
永芬熊德明	\N	2014-09-16	2014-09-16	1000.00	1000.00	0.00
安徽阜阳刘坤	\N	2015-03-29	2015-03-29	0.00	0.00	0.00
魏良成	\N	2015-01-09	2015-01-09	290.00	290.00	0.00
李代蓉	\N	2014-09-30	2014-11-05	192.00	192.00	0.00
唐店长渝东北超市	\N	2017-03-09	2017-03-09	1575.00	1575.00	0.00
游天贵-员工	\N	2016-09-30	2017-01-09	105.00	105.00	0.00
长春王贵仁	\N	2015-03-28	2015-03-28	0.00	0.00	0.00
县医院周医生	\N	2016-01-09	2016-01-09	120.00	120.00	0.00
陈森元	\N	2015-12-04	2015-12-04	240.00	240.00	0.00
天翔科技	\N	2017-03-19	2017-03-19	116.00	116.00	0.00
黄小江	\N	2016-10-17	2016-10-17	600.00	600.00	0.00
王秋菊	\N	2016-04-13	2017-03-15	430.00	430.00	0.00
田华儿	\N	2016-04-12	2016-04-12	400.00	400.00	0.00
黄达雪	\N	2014-12-01	2017-03-12	1550.00	1550.00	0.00
电视台	\N	2015-11-14	2015-11-14	0.00	0.00	0.00
刘梅	\N	2016-12-14	2017-01-16	200.00	200.00	0.00
人人乐超市	\N	2014-11-21	2014-11-21	0.00	0.00	0.00
工业园区王姐	\N	2016-04-18	2016-04-18	0.00	0.00	0.00
重庆质检	\N	2017-03-07	2017-03-07	0.00	0.00	0.00
盘锦杨明	\N	2015-12-13	2015-12-13	0.00	0.00	0.00
曹少平	\N	2014-10-14	2014-10-21	202.00	202.00	0.00
实验幼儿园张老师	\N	2016-02-06	2016-02-06	360.00	360.00	0.00
地税局	\N	2016-04-01	2016-09-09	0.00	0.00	0.00
王玉兰	\N	2014-10-14	2015-12-27	1030.00	1030.00	0.00
金带政府陶	\N	2016-07-07	2016-07-07	524.00	524.00	0.00
黄华全	53231383,13272548707	2014-09-06	2015-03-18	33050.00	33050.00	0.00
曹处长	\N	2015-11-11	2015-11-11	0.00	0.00	0.00
黄建华	\N	2017-02-28	2017-02-28	39.00	39.00	0.00
宁家容	\N	2014-11-29	2014-12-16	170.00	170.00	0.00
宜宾高燕	\N	2014-11-19	2014-12-06	5200.00	5200.00	0.00
黄军邦	\N	2017-03-03	2017-03-03	80.00	80.00	0.00
孙艳	\N	2017-08-18	2017-08-28	160.00	160.00	0.00
高礼翠	\N	2017-02-23	2017-02-23	60.00	60.00	0.00
恒大担保	\N	2016-03-24	2016-04-18	0.00	0.00	0.00
新疆特产	\N	2016-10-14	2016-10-14	130.00	130.00	0.00
美宜佳	\N	2015-07-19	2015-07-19	240.00	240.00	0.00
万大哥	\N	2016-10-06	2016-10-06	80.00	80.00	0.00
贵阳王正	\N	2016-03-30	2016-03-30	0.00	0.00	0.00
新城郑姐	\N	2016-09-23	2016-09-23	190.00	190.00	0.00
重庆旅游展销	\N	2015-06-29	2015-06-29	1532.00	1532.00	0.00
曾有光	15998906557	2017-05-03	2017-05-03	236.00	251.00	-15.00
谢云辉	\N	2017-07-14	2017-07-14	70.00	86.00	-16.00
韶关侯德权	\N	2017-03-13	2017-03-13	140.00	168.00	-28.00
郝德秀	18580425856	2017-06-26	2017-06-26	400.00	445.00	-45.00
遵义田总	\N	2017-08-01	2017-08-10	1500.00	1560.00	-60.00
辽宁边朝东	\N	2014-12-04	2016-04-08	12743.00	12883.00	-140.00
名柚园展销	\N	2016-04-16	2016-04-16	0.00	479.00	-479.00
涪陵展销会	\N	2017-01-03	2017-01-03	0.00	2053.00	-2053.00
办公室样品	\N	2016-03-20	2016-07-13	0.00	2703.00	-2703.00
南坪会展	\N	2017-01-10	2017-01-10	0.00	5400.00	-5400.00
\.


--
-- Name: seq_act_approve_task; Type: SEQUENCE SET; Schema: public; Owner: jetty
--

SELECT pg_catalog.setval('seq_act_approve_task', 6, true);


--
-- Name: seq_admin_login; Type: SEQUENCE SET; Schema: public; Owner: jetty
--

SELECT pg_catalog.setval('seq_admin_login', 1, false);


--
-- Name: seq_admin_login_log; Type: SEQUENCE SET; Schema: public; Owner: jetty
--

SELECT pg_catalog.setval('seq_admin_login_log', 1351, true);


--
-- Name: seq_admin_menu; Type: SEQUENCE SET; Schema: public; Owner: jetty
--

SELECT pg_catalog.setval('seq_admin_menu', 6, true);


--
-- Name: seq_admin_permission; Type: SEQUENCE SET; Schema: public; Owner: jetty
--

SELECT pg_catalog.setval('seq_admin_permission', 2, true);


--
-- Name: seq_admin_role; Type: SEQUENCE SET; Schema: public; Owner: jetty
--

SELECT pg_catalog.setval('seq_admin_role', 1, true);


--
-- Name: seq_admin_user; Type: SEQUENCE SET; Schema: public; Owner: jetty
--

SELECT pg_catalog.setval('seq_admin_user', 1, false);


--
-- Name: seq_cargo_discrepancy_event_id; Type: SEQUENCE SET; Schema: public; Owner: jetty
--

SELECT pg_catalog.setval('seq_cargo_discrepancy_event_id', 1, false);


--
-- Name: seq_department; Type: SEQUENCE SET; Schema: public; Owner: jetty
--

SELECT pg_catalog.setval('seq_department', 1, false);


--
-- Name: seq_k_user_id; Type: SEQUENCE SET; Schema: public; Owner: jetty
--

SELECT pg_catalog.setval('seq_k_user_id', 1, false);


--
-- Name: seq_log_id; Type: SEQUENCE SET; Schema: public; Owner: jetty
--

SELECT pg_catalog.setval('seq_log_id', 8556, true);


--
-- Name: seq_login_history; Type: SEQUENCE SET; Schema: public; Owner: jetty
--

SELECT pg_catalog.setval('seq_login_history', 51, true);


--
-- Name: seq_login_info; Type: SEQUENCE SET; Schema: public; Owner: jetty
--

SELECT pg_catalog.setval('seq_login_info', 51, true);


--
-- Name: seq_login_log; Type: SEQUENCE SET; Schema: public; Owner: jetty
--

SELECT pg_catalog.setval('seq_login_log', 4701, true);


--
-- Name: seq_menu; Type: SEQUENCE SET; Schema: public; Owner: jetty
--

SELECT pg_catalog.setval('seq_menu', 13, true);


--
-- Name: seq_news; Type: SEQUENCE SET; Schema: public; Owner: jetty
--

SELECT pg_catalog.setval('seq_news', 4, true);


--
-- Name: seq_news_attach; Type: SEQUENCE SET; Schema: public; Owner: jetty
--

SELECT pg_catalog.setval('seq_news_attach', 1, false);


--
-- Name: seq_news_picture; Type: SEQUENCE SET; Schema: public; Owner: jetty
--

SELECT pg_catalog.setval('seq_news_picture', 1, false);


--
-- Name: seq_news_temp_file; Type: SEQUENCE SET; Schema: public; Owner: jetty
--

SELECT pg_catalog.setval('seq_news_temp_file', 1, false);


--
-- Name: seq_news_temp_image; Type: SEQUENCE SET; Schema: public; Owner: jetty
--

SELECT pg_catalog.setval('seq_news_temp_image', 1, false);


--
-- Name: seq_permission; Type: SEQUENCE SET; Schema: public; Owner: jetty
--

SELECT pg_catalog.setval('seq_permission', 1, true);


--
-- Name: seq_resource_bundle; Type: SEQUENCE SET; Schema: public; Owner: jetty
--

SELECT pg_catalog.setval('seq_resource_bundle', 27, true);


--
-- Name: seq_resource_file; Type: SEQUENCE SET; Schema: public; Owner: jetty
--

SELECT pg_catalog.setval('seq_resource_file', 10, true);


--
-- Name: seq_resource_image; Type: SEQUENCE SET; Schema: public; Owner: jetty
--

SELECT pg_catalog.setval('seq_resource_image', 19, true);


--
-- Name: seq_role; Type: SEQUENCE SET; Schema: public; Owner: jetty
--

SELECT pg_catalog.setval('seq_role', 2, true);


--
-- Name: seq_user; Type: SEQUENCE SET; Schema: public; Owner: jetty
--

SELECT pg_catalog.setval('seq_user', 51, true);


--
-- Name: act_approve_task_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_approve_task
    ADD CONSTRAINT act_approve_task_pkey PRIMARY KEY (id_);


--
-- Name: act_evt_log_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_evt_log
    ADD CONSTRAINT act_evt_log_pkey PRIMARY KEY (log_nr_);


--
-- Name: act_ge_bytearray_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_ge_bytearray
    ADD CONSTRAINT act_ge_bytearray_pkey PRIMARY KEY (id_);


--
-- Name: act_ge_property_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_ge_property
    ADD CONSTRAINT act_ge_property_pkey PRIMARY KEY (name_);


--
-- Name: act_hi_actinst_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_hi_actinst
    ADD CONSTRAINT act_hi_actinst_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_attachment_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_hi_attachment
    ADD CONSTRAINT act_hi_attachment_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_hi_comment
    ADD CONSTRAINT act_hi_comment_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_hi_detail
    ADD CONSTRAINT act_hi_detail_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_identitylink_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_hi_identitylink
    ADD CONSTRAINT act_hi_identitylink_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_procinst_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_hi_procinst
    ADD CONSTRAINT act_hi_procinst_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_procinst_proc_inst_id__key; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_hi_procinst
    ADD CONSTRAINT act_hi_procinst_proc_inst_id__key UNIQUE (proc_inst_id_);


--
-- Name: act_hi_taskinst_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_hi_taskinst
    ADD CONSTRAINT act_hi_taskinst_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_varinst_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_hi_varinst
    ADD CONSTRAINT act_hi_varinst_pkey PRIMARY KEY (id_);


--
-- Name: act_id_group_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_id_group
    ADD CONSTRAINT act_id_group_pkey PRIMARY KEY (id_);


--
-- Name: act_id_info_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_id_info
    ADD CONSTRAINT act_id_info_pkey PRIMARY KEY (id_);


--
-- Name: act_id_membership_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_id_membership
    ADD CONSTRAINT act_id_membership_pkey PRIMARY KEY (user_id_, group_id_);


--
-- Name: act_id_user_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_id_user
    ADD CONSTRAINT act_id_user_pkey PRIMARY KEY (id_);


--
-- Name: act_procdef_info_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_procdef_info
    ADD CONSTRAINT act_procdef_info_pkey PRIMARY KEY (id_);


--
-- Name: act_re_deployment_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_re_deployment
    ADD CONSTRAINT act_re_deployment_pkey PRIMARY KEY (id_);


--
-- Name: act_re_model_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_re_model
    ADD CONSTRAINT act_re_model_pkey PRIMARY KEY (id_);


--
-- Name: act_re_procdef_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_re_procdef
    ADD CONSTRAINT act_re_procdef_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_event_subscr_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_ru_event_subscr
    ADD CONSTRAINT act_ru_event_subscr_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_execution_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_ru_execution
    ADD CONSTRAINT act_ru_execution_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_identitylink_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_ru_identitylink
    ADD CONSTRAINT act_ru_identitylink_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_job_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_ru_job
    ADD CONSTRAINT act_ru_job_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_task_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_ru_task
    ADD CONSTRAINT act_ru_task_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_variable_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_ru_variable
    ADD CONSTRAINT act_ru_variable_pkey PRIMARY KEY (id_);


--
-- Name: act_uniq_info_procdef; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_procdef_info
    ADD CONSTRAINT act_uniq_info_procdef UNIQUE (proc_def_id_);


--
-- Name: act_uniq_procdef; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_re_procdef
    ADD CONSTRAINT act_uniq_procdef UNIQUE (key_, version_, tenant_id_);


--
-- Name: ad_login_log_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY ad_login_log
    ADD CONSTRAINT ad_login_log_pkey PRIMARY KEY (id);


--
-- Name: ad_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY ad_menu
    ADD CONSTRAINT ad_menu_pkey PRIMARY KEY (id);


--
-- Name: ad_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY ad_permission
    ADD CONSTRAINT ad_permission_pkey PRIMARY KEY (code);


--
-- Name: ad_process_flow_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY ad_process_flow
    ADD CONSTRAINT ad_process_flow_pkey PRIMARY KEY (execution_id);


--
-- Name: ad_role_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY ad_role
    ADD CONSTRAINT ad_role_pkey PRIMARY KEY (id);


--
-- Name: ad_user_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY ad_user
    ADD CONSTRAINT ad_user_pkey PRIMARY KEY (id);


--
-- Name: cargo_discrepancy_event_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY cargo_discrepancy_event
    ADD CONSTRAINT cargo_discrepancy_event_pkey PRIMARY KEY (id);


--
-- Name: confirm_discrepancy_event_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY confirm_discrepancy_event
    ADD CONSTRAINT confirm_discrepancy_event_pkey PRIMARY KEY (id);


--
-- Name: department_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY department
    ADD CONSTRAINT department_pkey PRIMARY KEY (code);


--
-- Name: log_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY log
    ADD CONSTRAINT log_pkey PRIMARY KEY (id);


--
-- Name: news_attach_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY news_attach
    ADD CONSTRAINT news_attach_pkey PRIMARY KEY (id);


--
-- Name: news_picture_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY news_picture
    ADD CONSTRAINT news_picture_pkey PRIMARY KEY (id);


--
-- Name: news_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY news
    ADD CONSTRAINT news_pkey PRIMARY KEY (id);


--
-- Name: news_temp_image_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY news_temp_image
    ADD CONSTRAINT news_temp_image_pkey PRIMARY KEY (id);


--
-- Name: process_flow_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY process_flow
    ADD CONSTRAINT process_flow_pkey PRIMARY KEY (execution_id);


--
-- Name: resource_bundle_key_local_ukey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY resource_bundle
    ADD CONSTRAINT resource_bundle_key_local_ukey UNIQUE (key, locale);


--
-- Name: resource_bundle_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY resource_bundle
    ADD CONSTRAINT resource_bundle_pkey PRIMARY KEY (id);


--
-- Name: resource_file_key_file_id; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY resource_file
    ADD CONSTRAINT resource_file_key_file_id UNIQUE (file_id);


--
-- Name: resource_file_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY resource_file
    ADD CONSTRAINT resource_file_pkey PRIMARY KEY (id);


--
-- Name: resource_image_pkey; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY resource_image
    ADD CONSTRAINT resource_image_pkey PRIMARY KEY (id);


--
-- Name: uk_resource_image_with_image_id; Type: CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY resource_image
    ADD CONSTRAINT uk_resource_image_with_image_id UNIQUE (image_id);


--
-- Name: act_idx_athrz_procedef; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_athrz_procedef ON act_ru_identitylink USING btree (proc_def_id_);


--
-- Name: act_idx_bytear_depl; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_bytear_depl ON act_ge_bytearray USING btree (deployment_id_);


--
-- Name: act_idx_event_subscr; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_event_subscr ON act_ru_event_subscr USING btree (execution_id_);


--
-- Name: act_idx_event_subscr_config_; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_event_subscr_config_ ON act_ru_event_subscr USING btree (configuration_);


--
-- Name: act_idx_exe_parent; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_exe_parent ON act_ru_execution USING btree (parent_id_);


--
-- Name: act_idx_exe_procdef; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_exe_procdef ON act_ru_execution USING btree (proc_def_id_);


--
-- Name: act_idx_exe_procinst; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_exe_procinst ON act_ru_execution USING btree (proc_inst_id_);


--
-- Name: act_idx_exe_super; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_exe_super ON act_ru_execution USING btree (super_exec_);


--
-- Name: act_idx_exec_buskey; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_exec_buskey ON act_ru_execution USING btree (business_key_);


--
-- Name: act_idx_hi_act_inst_end; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_hi_act_inst_end ON act_hi_actinst USING btree (end_time_);


--
-- Name: act_idx_hi_act_inst_exec; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_hi_act_inst_exec ON act_hi_actinst USING btree (execution_id_, act_id_);


--
-- Name: act_idx_hi_act_inst_procinst; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_hi_act_inst_procinst ON act_hi_actinst USING btree (proc_inst_id_, act_id_);


--
-- Name: act_idx_hi_act_inst_start; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_hi_act_inst_start ON act_hi_actinst USING btree (start_time_);


--
-- Name: act_idx_hi_detail_act_inst; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_hi_detail_act_inst ON act_hi_detail USING btree (act_inst_id_);


--
-- Name: act_idx_hi_detail_name; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_hi_detail_name ON act_hi_detail USING btree (name_);


--
-- Name: act_idx_hi_detail_proc_inst; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_hi_detail_proc_inst ON act_hi_detail USING btree (proc_inst_id_);


--
-- Name: act_idx_hi_detail_task_id; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_hi_detail_task_id ON act_hi_detail USING btree (task_id_);


--
-- Name: act_idx_hi_detail_time; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_hi_detail_time ON act_hi_detail USING btree (time_);


--
-- Name: act_idx_hi_ident_lnk_procinst; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_hi_ident_lnk_procinst ON act_hi_identitylink USING btree (proc_inst_id_);


--
-- Name: act_idx_hi_ident_lnk_task; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_hi_ident_lnk_task ON act_hi_identitylink USING btree (task_id_);


--
-- Name: act_idx_hi_ident_lnk_user; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_hi_ident_lnk_user ON act_hi_identitylink USING btree (user_id_);


--
-- Name: act_idx_hi_pro_i_buskey; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_hi_pro_i_buskey ON act_hi_procinst USING btree (business_key_);


--
-- Name: act_idx_hi_pro_inst_end; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_hi_pro_inst_end ON act_hi_procinst USING btree (end_time_);


--
-- Name: act_idx_hi_procvar_name_type; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_hi_procvar_name_type ON act_hi_varinst USING btree (name_, var_type_);


--
-- Name: act_idx_hi_procvar_proc_inst; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_hi_procvar_proc_inst ON act_hi_varinst USING btree (proc_inst_id_);


--
-- Name: act_idx_hi_procvar_task_id; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_hi_procvar_task_id ON act_hi_varinst USING btree (task_id_);


--
-- Name: act_idx_hi_task_inst_procinst; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_hi_task_inst_procinst ON act_hi_taskinst USING btree (proc_inst_id_);


--
-- Name: act_idx_ident_lnk_group; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_ident_lnk_group ON act_ru_identitylink USING btree (group_id_);


--
-- Name: act_idx_ident_lnk_user; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_ident_lnk_user ON act_ru_identitylink USING btree (user_id_);


--
-- Name: act_idx_idl_procinst; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_idl_procinst ON act_ru_identitylink USING btree (proc_inst_id_);


--
-- Name: act_idx_job_exception; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_job_exception ON act_ru_job USING btree (exception_stack_id_);


--
-- Name: act_idx_memb_group; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_memb_group ON act_id_membership USING btree (group_id_);


--
-- Name: act_idx_memb_user; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_memb_user ON act_id_membership USING btree (user_id_);


--
-- Name: act_idx_model_deployment; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_model_deployment ON act_re_model USING btree (deployment_id_);


--
-- Name: act_idx_model_source; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_model_source ON act_re_model USING btree (editor_source_value_id_);


--
-- Name: act_idx_model_source_extra; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_model_source_extra ON act_re_model USING btree (editor_source_extra_value_id_);


--
-- Name: act_idx_procdef_info_json; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_procdef_info_json ON act_procdef_info USING btree (info_json_id_);


--
-- Name: act_idx_procdef_info_proc; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_procdef_info_proc ON act_procdef_info USING btree (proc_def_id_);


--
-- Name: act_idx_task_create; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_task_create ON act_ru_task USING btree (create_time_);


--
-- Name: act_idx_task_exec; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_task_exec ON act_ru_task USING btree (execution_id_);


--
-- Name: act_idx_task_procdef; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_task_procdef ON act_ru_task USING btree (proc_def_id_);


--
-- Name: act_idx_task_procinst; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_task_procinst ON act_ru_task USING btree (proc_inst_id_);


--
-- Name: act_idx_tskass_task; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_tskass_task ON act_ru_identitylink USING btree (task_id_);


--
-- Name: act_idx_var_bytearray; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_var_bytearray ON act_ru_variable USING btree (bytearray_id_);


--
-- Name: act_idx_var_exe; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_var_exe ON act_ru_variable USING btree (execution_id_);


--
-- Name: act_idx_var_procinst; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_var_procinst ON act_ru_variable USING btree (proc_inst_id_);


--
-- Name: act_idx_variable_task_id; Type: INDEX; Schema: public; Owner: jetty
--

CREATE INDEX act_idx_variable_task_id ON act_ru_variable USING btree (task_id_);


--
-- Name: act_fk_athrz_procedef; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_ru_identitylink
    ADD CONSTRAINT act_fk_athrz_procedef FOREIGN KEY (proc_def_id_) REFERENCES act_re_procdef(id_);


--
-- Name: act_fk_bytearr_depl; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_ge_bytearray
    ADD CONSTRAINT act_fk_bytearr_depl FOREIGN KEY (deployment_id_) REFERENCES act_re_deployment(id_);


--
-- Name: act_fk_event_exec; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_ru_event_subscr
    ADD CONSTRAINT act_fk_event_exec FOREIGN KEY (execution_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_fk_exe_parent; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_ru_execution
    ADD CONSTRAINT act_fk_exe_parent FOREIGN KEY (parent_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_fk_exe_procdef; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_ru_execution
    ADD CONSTRAINT act_fk_exe_procdef FOREIGN KEY (proc_def_id_) REFERENCES act_re_procdef(id_);


--
-- Name: act_fk_exe_procinst; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_ru_execution
    ADD CONSTRAINT act_fk_exe_procinst FOREIGN KEY (proc_inst_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_fk_exe_super; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_ru_execution
    ADD CONSTRAINT act_fk_exe_super FOREIGN KEY (super_exec_) REFERENCES act_ru_execution(id_);


--
-- Name: act_fk_idl_procinst; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_ru_identitylink
    ADD CONSTRAINT act_fk_idl_procinst FOREIGN KEY (proc_inst_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_fk_info_json_ba; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_procdef_info
    ADD CONSTRAINT act_fk_info_json_ba FOREIGN KEY (info_json_id_) REFERENCES act_ge_bytearray(id_);


--
-- Name: act_fk_info_procdef; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_procdef_info
    ADD CONSTRAINT act_fk_info_procdef FOREIGN KEY (proc_def_id_) REFERENCES act_re_procdef(id_);


--
-- Name: act_fk_job_exception; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_ru_job
    ADD CONSTRAINT act_fk_job_exception FOREIGN KEY (exception_stack_id_) REFERENCES act_ge_bytearray(id_);


--
-- Name: act_fk_memb_group; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_id_membership
    ADD CONSTRAINT act_fk_memb_group FOREIGN KEY (group_id_) REFERENCES act_id_group(id_);


--
-- Name: act_fk_memb_user; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_id_membership
    ADD CONSTRAINT act_fk_memb_user FOREIGN KEY (user_id_) REFERENCES act_id_user(id_);


--
-- Name: act_fk_model_deployment; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_re_model
    ADD CONSTRAINT act_fk_model_deployment FOREIGN KEY (deployment_id_) REFERENCES act_re_deployment(id_);


--
-- Name: act_fk_model_source; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_re_model
    ADD CONSTRAINT act_fk_model_source FOREIGN KEY (editor_source_value_id_) REFERENCES act_ge_bytearray(id_);


--
-- Name: act_fk_model_source_extra; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_re_model
    ADD CONSTRAINT act_fk_model_source_extra FOREIGN KEY (editor_source_extra_value_id_) REFERENCES act_ge_bytearray(id_);


--
-- Name: act_fk_task_exe; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_ru_task
    ADD CONSTRAINT act_fk_task_exe FOREIGN KEY (execution_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_fk_task_procdef; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_ru_task
    ADD CONSTRAINT act_fk_task_procdef FOREIGN KEY (proc_def_id_) REFERENCES act_re_procdef(id_);


--
-- Name: act_fk_task_procinst; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_ru_task
    ADD CONSTRAINT act_fk_task_procinst FOREIGN KEY (proc_inst_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_fk_tskass_task; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_ru_identitylink
    ADD CONSTRAINT act_fk_tskass_task FOREIGN KEY (task_id_) REFERENCES act_ru_task(id_);


--
-- Name: act_fk_var_bytearray; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_ru_variable
    ADD CONSTRAINT act_fk_var_bytearray FOREIGN KEY (bytearray_id_) REFERENCES act_ge_bytearray(id_);


--
-- Name: act_fk_var_exe; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_ru_variable
    ADD CONSTRAINT act_fk_var_exe FOREIGN KEY (execution_id_) REFERENCES act_ru_execution(id_);


--
-- Name: act_fk_var_procinst; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY act_ru_variable
    ADD CONSTRAINT act_fk_var_procinst FOREIGN KEY (proc_inst_id_) REFERENCES act_ru_execution(id_);


--
-- Name: fk4bj5bi1de1f3xd1yw28rnlrvc; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY news
    ADD CONSTRAINT fk4bj5bi1de1f3xd1yw28rnlrvc FOREIGN KEY (created_by) REFERENCES ad_user(id);


--
-- Name: fk7d42nhfvscnei9mv1n03uwn94; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY department
    ADD CONSTRAINT fk7d42nhfvscnei9mv1n03uwn94 FOREIGN KEY (parent_code) REFERENCES department(code);


--
-- Name: fk8chn97h6i9nr0qpclr72j5fuo; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY news_picture
    ADD CONSTRAINT fk8chn97h6i9nr0qpclr72j5fuo FOREIGN KEY (news_id) REFERENCES news(id);


--
-- Name: fk8dkd3egsbday50k7q5pm93fce; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY news_temp_image
    ADD CONSTRAINT fk8dkd3egsbday50k7q5pm93fce FOREIGN KEY (news_id) REFERENCES news(id);


--
-- Name: fk8k161mwysktjc0e7paqs4wlfv; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY ad_user_permission
    ADD CONSTRAINT fk8k161mwysktjc0e7paqs4wlfv FOREIGN KEY (permission_code) REFERENCES ad_permission(code);


--
-- Name: fk9gs7id1ufus4i20uy8bbsw781; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY ad_role_permission
    ADD CONSTRAINT fk9gs7id1ufus4i20uy8bbsw781 FOREIGN KEY (permission_code) REFERENCES ad_permission(code);


--
-- Name: fkdj260y3g5c3j3uj2jrkdnkreo; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY ad_role_menu
    ADD CONSTRAINT fkdj260y3g5c3j3uj2jrkdnkreo FOREIGN KEY (menu_id) REFERENCES ad_menu(id);


--
-- Name: fker6yegvactho7w5aotods1ik; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY ad_role
    ADD CONSTRAINT fker6yegvactho7w5aotods1ik FOREIGN KEY (updated_by) REFERENCES ad_user(id);


--
-- Name: fkfop7n0pyljtl41e2ssatjv8d8; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY news
    ADD CONSTRAINT fkfop7n0pyljtl41e2ssatjv8d8 FOREIGN KEY (execution_id) REFERENCES ad_process_flow(execution_id);


--
-- Name: fkgp38rq1hb622jbt4yqocd7ocv; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY news_attach
    ADD CONSTRAINT fkgp38rq1hb622jbt4yqocd7ocv FOREIGN KEY (news_id) REFERENCES news(id);


--
-- Name: fkh4ukwkq9wbqfmp6nkktcntb1b; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY ad_role
    ADD CONSTRAINT fkh4ukwkq9wbqfmp6nkktcntb1b FOREIGN KEY (created_by) REFERENCES ad_user(id);


--
-- Name: fkhch0xmm46o9cf2qd608shgvht; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY ad_user_permission
    ADD CONSTRAINT fkhch0xmm46o9cf2qd608shgvht FOREIGN KEY (user_id) REFERENCES ad_user(id);


--
-- Name: fki44ftja4cwusasl4dfxd5qw4j; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY ad_role_menu
    ADD CONSTRAINT fki44ftja4cwusasl4dfxd5qw4j FOREIGN KEY (role_id) REFERENCES ad_role(id);


--
-- Name: fkixvn96mmlkwpkhkdu2ac6sr5e; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY ad_user_role
    ADD CONSTRAINT fkixvn96mmlkwpkhkdu2ac6sr5e FOREIGN KEY (user_id) REFERENCES ad_user(id);


--
-- Name: fkjxsvs14r1otg3wkp55u7vqqr8; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY news
    ADD CONSTRAINT fkjxsvs14r1otg3wkp55u7vqqr8 FOREIGN KEY (updated_by) REFERENCES ad_user(id);


--
-- Name: fkk6ntihsdv4vlv05kp823m0b60; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY ad_menu
    ADD CONSTRAINT fkk6ntihsdv4vlv05kp823m0b60 FOREIGN KEY (parent_id) REFERENCES ad_menu(id);


--
-- Name: fknieljl2bt9fiamdcsdc66vlw9; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY ad_user
    ADD CONSTRAINT fknieljl2bt9fiamdcsdc66vlw9 FOREIGN KEY (updated_by) REFERENCES ad_user(id);


--
-- Name: fkobo2klp0b9wy196d3l67rrkyu; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY ad_process_flow
    ADD CONSTRAINT fkobo2klp0b9wy196d3l67rrkyu FOREIGN KEY (news_id) REFERENCES news(id);


--
-- Name: fkpg7rbu8stdktw7qmv1wyyw8ih; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY ad_role_permission
    ADD CONSTRAINT fkpg7rbu8stdktw7qmv1wyyw8ih FOREIGN KEY (role_id) REFERENCES ad_role(id);


--
-- Name: fkpnnutj3b3dyeiuo66ok7jgg66; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY ad_user
    ADD CONSTRAINT fkpnnutj3b3dyeiuo66ok7jgg66 FOREIGN KEY (created_by) REFERENCES ad_user(id);


--
-- Name: fkv3krfocy4oy9luvc6kr7eld1; Type: FK CONSTRAINT; Schema: public; Owner: jetty
--

ALTER TABLE ONLY ad_user_role
    ADD CONSTRAINT fkv3krfocy4oy9luvc6kr7eld1 FOREIGN KEY (role_id) REFERENCES ad_role(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

