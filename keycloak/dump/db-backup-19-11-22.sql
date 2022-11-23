--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Debian 15.1-1.pgdg110+1)
-- Dumped by pg_dump version 15.1 (Debian 15.1-1.pgdg110+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


--
-- Name: client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- Name: client_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


--
-- Name: component; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


--
-- Name: component_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


--
-- Name: credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: realm; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


--
-- Name: user_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
67ae94d1-9d81-42d3-a2c3-72b784ecbbc2	fc37b30e-a645-4ef7-9080-29f81549adfa
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
33ef4f4e-0cb5-40aa-85e9-660fcb785f4d	\N	auth-cookie	4462ad8a-9bc0-49aa-887b-192539be165a	c9ea40b2-4c5e-4309-bcb0-dbc5cde99e32	2	10	f	\N	\N
9ae8a183-acab-433d-b448-501467dfa30d	\N	auth-spnego	4462ad8a-9bc0-49aa-887b-192539be165a	c9ea40b2-4c5e-4309-bcb0-dbc5cde99e32	3	20	f	\N	\N
2faf566d-5296-48d4-a04d-27bb128efb61	\N	identity-provider-redirector	4462ad8a-9bc0-49aa-887b-192539be165a	c9ea40b2-4c5e-4309-bcb0-dbc5cde99e32	2	25	f	\N	\N
b5637132-7e5c-4fd7-8db7-0f05122f61b5	\N	\N	4462ad8a-9bc0-49aa-887b-192539be165a	c9ea40b2-4c5e-4309-bcb0-dbc5cde99e32	2	30	t	594f4af5-258c-4916-86ab-74e4a3f3e743	\N
3b013b48-f005-4b38-bbe8-8c9b10fafc2e	\N	auth-username-password-form	4462ad8a-9bc0-49aa-887b-192539be165a	594f4af5-258c-4916-86ab-74e4a3f3e743	0	10	f	\N	\N
f2d2983b-0c6e-4216-8094-18c911586bd7	\N	\N	4462ad8a-9bc0-49aa-887b-192539be165a	594f4af5-258c-4916-86ab-74e4a3f3e743	1	20	t	8b8c00b4-9b7f-4fec-8d24-17419409856c	\N
e751965a-55aa-454e-9698-7f5b296632ed	\N	conditional-user-configured	4462ad8a-9bc0-49aa-887b-192539be165a	8b8c00b4-9b7f-4fec-8d24-17419409856c	0	10	f	\N	\N
5a5be003-0468-42ca-82db-68b8fe5b08e8	\N	auth-otp-form	4462ad8a-9bc0-49aa-887b-192539be165a	8b8c00b4-9b7f-4fec-8d24-17419409856c	0	20	f	\N	\N
7af8c430-920e-488b-96c0-09825cdc1c9b	\N	direct-grant-validate-username	4462ad8a-9bc0-49aa-887b-192539be165a	947efab2-f265-4d37-9b07-0b60eefcbfbd	0	10	f	\N	\N
185047ad-2e05-4726-b0de-3c149462f7b5	\N	direct-grant-validate-password	4462ad8a-9bc0-49aa-887b-192539be165a	947efab2-f265-4d37-9b07-0b60eefcbfbd	0	20	f	\N	\N
3a650f86-8d7e-47ee-a690-417f00062b09	\N	\N	4462ad8a-9bc0-49aa-887b-192539be165a	947efab2-f265-4d37-9b07-0b60eefcbfbd	1	30	t	422b1c91-6281-4e53-a5cc-12b230f61f9c	\N
7aa28aae-933a-4aa2-84d0-55d30ac9cd23	\N	conditional-user-configured	4462ad8a-9bc0-49aa-887b-192539be165a	422b1c91-6281-4e53-a5cc-12b230f61f9c	0	10	f	\N	\N
2756c833-fa54-4315-9aa4-c75184ce8c3a	\N	direct-grant-validate-otp	4462ad8a-9bc0-49aa-887b-192539be165a	422b1c91-6281-4e53-a5cc-12b230f61f9c	0	20	f	\N	\N
60d32d82-b1dd-4be1-9adc-a5cbf83e7866	\N	registration-page-form	4462ad8a-9bc0-49aa-887b-192539be165a	311a0db9-63f6-48ad-9abe-d21e5c29614b	0	10	t	1b467def-c710-4627-9b53-fefb26d1d0e0	\N
7c058638-c558-4f58-9b14-9e3027cf208e	\N	registration-user-creation	4462ad8a-9bc0-49aa-887b-192539be165a	1b467def-c710-4627-9b53-fefb26d1d0e0	0	20	f	\N	\N
fd0ba54a-1fc9-4560-8625-2cd508306844	\N	registration-profile-action	4462ad8a-9bc0-49aa-887b-192539be165a	1b467def-c710-4627-9b53-fefb26d1d0e0	0	40	f	\N	\N
49b6e21c-d283-4738-88ff-15ca84a7ab8a	\N	registration-password-action	4462ad8a-9bc0-49aa-887b-192539be165a	1b467def-c710-4627-9b53-fefb26d1d0e0	0	50	f	\N	\N
057e408f-0070-484c-a6c0-0f450d3eeab4	\N	registration-recaptcha-action	4462ad8a-9bc0-49aa-887b-192539be165a	1b467def-c710-4627-9b53-fefb26d1d0e0	3	60	f	\N	\N
06bbde7f-171e-4fb3-a9b0-2fdee62533fd	\N	reset-credentials-choose-user	4462ad8a-9bc0-49aa-887b-192539be165a	205538a2-270a-4889-8bf0-c602f0c33492	0	10	f	\N	\N
f3d261f3-6060-4d99-8034-1cb1ab87f0a2	\N	reset-credential-email	4462ad8a-9bc0-49aa-887b-192539be165a	205538a2-270a-4889-8bf0-c602f0c33492	0	20	f	\N	\N
bbb08479-1740-45f2-9c8f-d87eacc7f9c2	\N	reset-password	4462ad8a-9bc0-49aa-887b-192539be165a	205538a2-270a-4889-8bf0-c602f0c33492	0	30	f	\N	\N
70ee4bf9-5de7-4548-b554-329a044a0c20	\N	\N	4462ad8a-9bc0-49aa-887b-192539be165a	205538a2-270a-4889-8bf0-c602f0c33492	1	40	t	cf304740-9887-41fb-b582-9b99e92b615b	\N
7f4a23f1-9f95-4c4b-a89a-495fcd5d5e2f	\N	conditional-user-configured	4462ad8a-9bc0-49aa-887b-192539be165a	cf304740-9887-41fb-b582-9b99e92b615b	0	10	f	\N	\N
c8e289af-8404-496e-b032-11422da4ba74	\N	reset-otp	4462ad8a-9bc0-49aa-887b-192539be165a	cf304740-9887-41fb-b582-9b99e92b615b	0	20	f	\N	\N
cb0d2c4e-fa38-4274-bd51-72b182a28bb8	\N	client-secret	4462ad8a-9bc0-49aa-887b-192539be165a	07be6d32-dcc2-4595-b97e-a243e96594b0	2	10	f	\N	\N
9de89518-e1c2-4378-b6b1-dc1c994104a4	\N	client-jwt	4462ad8a-9bc0-49aa-887b-192539be165a	07be6d32-dcc2-4595-b97e-a243e96594b0	2	20	f	\N	\N
8bab320d-722e-4a22-8df0-d1f06353680b	\N	client-secret-jwt	4462ad8a-9bc0-49aa-887b-192539be165a	07be6d32-dcc2-4595-b97e-a243e96594b0	2	30	f	\N	\N
136faca2-5543-4c86-9ccc-430602d9af6f	\N	client-x509	4462ad8a-9bc0-49aa-887b-192539be165a	07be6d32-dcc2-4595-b97e-a243e96594b0	2	40	f	\N	\N
fa52dd7c-b713-4ef2-b620-7670024925ac	\N	idp-review-profile	4462ad8a-9bc0-49aa-887b-192539be165a	e2f31903-ac63-4174-be1c-ed8d07a7f58f	0	10	f	\N	7727c5ff-a4b1-4d9b-9eb3-d0f6c418d46a
d15884e2-7d65-4c0d-865e-6dad85b75319	\N	\N	4462ad8a-9bc0-49aa-887b-192539be165a	e2f31903-ac63-4174-be1c-ed8d07a7f58f	0	20	t	10b1c456-33fd-4bda-b80e-538bd022cb9a	\N
7f78b3db-5338-43ea-a6a1-5d6f1dd17e91	\N	idp-create-user-if-unique	4462ad8a-9bc0-49aa-887b-192539be165a	10b1c456-33fd-4bda-b80e-538bd022cb9a	2	10	f	\N	e7c0911a-d6b5-4c3e-954b-f517c830ccdf
e7b06259-3a3a-4fa6-a692-752dace96cb4	\N	\N	4462ad8a-9bc0-49aa-887b-192539be165a	10b1c456-33fd-4bda-b80e-538bd022cb9a	2	20	t	cd92dec7-9b71-4802-b6cc-39d5f067009d	\N
048b7923-6576-4ea2-a15b-e7de08c08ef2	\N	idp-confirm-link	4462ad8a-9bc0-49aa-887b-192539be165a	cd92dec7-9b71-4802-b6cc-39d5f067009d	0	10	f	\N	\N
4191c786-e498-484d-a839-078409b70649	\N	\N	4462ad8a-9bc0-49aa-887b-192539be165a	cd92dec7-9b71-4802-b6cc-39d5f067009d	0	20	t	a7cb7bc2-de26-4dae-a1ad-197b59aadde4	\N
db91a5f3-d21e-458f-99ab-c1d4c790753a	\N	idp-email-verification	4462ad8a-9bc0-49aa-887b-192539be165a	a7cb7bc2-de26-4dae-a1ad-197b59aadde4	2	10	f	\N	\N
20a2d66e-a99b-400a-a296-728e500b1c12	\N	\N	4462ad8a-9bc0-49aa-887b-192539be165a	a7cb7bc2-de26-4dae-a1ad-197b59aadde4	2	20	t	cb4b6857-7a4b-4b28-8af7-c3e7681a17ec	\N
0ef27037-1bea-4a34-803c-e0b4b512e87e	\N	idp-username-password-form	4462ad8a-9bc0-49aa-887b-192539be165a	cb4b6857-7a4b-4b28-8af7-c3e7681a17ec	0	10	f	\N	\N
df3f9f7a-ef21-4c99-abf4-b6c4a1b029c9	\N	\N	4462ad8a-9bc0-49aa-887b-192539be165a	cb4b6857-7a4b-4b28-8af7-c3e7681a17ec	1	20	t	2b0341e0-ba01-4306-8252-0cdf5dbb5a05	\N
3a4d5f17-d2c1-4f38-9e22-400467cc2173	\N	conditional-user-configured	4462ad8a-9bc0-49aa-887b-192539be165a	2b0341e0-ba01-4306-8252-0cdf5dbb5a05	0	10	f	\N	\N
d8ead9ec-4941-43a6-9e4f-d9d0f6827c01	\N	auth-otp-form	4462ad8a-9bc0-49aa-887b-192539be165a	2b0341e0-ba01-4306-8252-0cdf5dbb5a05	0	20	f	\N	\N
25de30d0-d9ae-4294-9bcb-590f8144d387	\N	http-basic-authenticator	4462ad8a-9bc0-49aa-887b-192539be165a	4a82fcca-9105-472e-a845-7787d4116987	0	10	f	\N	\N
b0adccec-69d9-4da6-9b92-ad74e0673c7e	\N	docker-http-basic-authenticator	4462ad8a-9bc0-49aa-887b-192539be165a	8b6bb737-7425-4c5a-9572-2ebc1e6d4268	0	10	f	\N	\N
d8717bcd-292d-4b30-b061-da4ab51748ce	\N	no-cookie-redirect	4462ad8a-9bc0-49aa-887b-192539be165a	ba32aa55-6048-4da8-b70f-fafd66aff071	0	10	f	\N	\N
3b61967a-9a7d-4d47-9797-2a05b1a9fa13	\N	\N	4462ad8a-9bc0-49aa-887b-192539be165a	ba32aa55-6048-4da8-b70f-fafd66aff071	0	20	t	f44caac5-35ec-4f51-8506-376622c3524b	\N
30867b04-772d-4cd3-8c03-f43c1c5ca8d7	\N	basic-auth	4462ad8a-9bc0-49aa-887b-192539be165a	f44caac5-35ec-4f51-8506-376622c3524b	0	10	f	\N	\N
97ae9faa-3c18-4afc-ba20-f08b2440a966	\N	basic-auth-otp	4462ad8a-9bc0-49aa-887b-192539be165a	f44caac5-35ec-4f51-8506-376622c3524b	3	20	f	\N	\N
4a397af9-a218-472f-be8b-0c56a1d530c1	\N	auth-spnego	4462ad8a-9bc0-49aa-887b-192539be165a	f44caac5-35ec-4f51-8506-376622c3524b	3	30	f	\N	\N
23ee7748-5cbd-421c-b126-f4e849ed6a63	\N	auth-cookie	f7426fe0-9b39-4eb4-8348-4780b68b86b4	f288a5dc-8e05-4477-90d5-39ac82f2d6a5	2	10	f	\N	\N
e71d7625-c91d-4951-a9e9-f6d8f8d1ee65	\N	auth-spnego	f7426fe0-9b39-4eb4-8348-4780b68b86b4	f288a5dc-8e05-4477-90d5-39ac82f2d6a5	3	20	f	\N	\N
e579ef34-c882-45c1-bcf3-7744c5640169	\N	identity-provider-redirector	f7426fe0-9b39-4eb4-8348-4780b68b86b4	f288a5dc-8e05-4477-90d5-39ac82f2d6a5	2	25	f	\N	\N
a1ec9caa-efba-49df-8142-ef9adec58b30	\N	\N	f7426fe0-9b39-4eb4-8348-4780b68b86b4	f288a5dc-8e05-4477-90d5-39ac82f2d6a5	2	30	t	94339c8a-7d8e-4887-860d-92be7a3896ac	\N
9a7773a5-ffbd-462f-8550-cdd8626c327a	\N	auth-username-password-form	f7426fe0-9b39-4eb4-8348-4780b68b86b4	94339c8a-7d8e-4887-860d-92be7a3896ac	0	10	f	\N	\N
d2e0d21e-e8d0-4d07-83e9-caa2bb332c73	\N	\N	f7426fe0-9b39-4eb4-8348-4780b68b86b4	94339c8a-7d8e-4887-860d-92be7a3896ac	1	20	t	e95d0ec3-c503-4d56-baca-99a43b65f4f4	\N
04bdf161-229a-4c39-a327-508afc098875	\N	conditional-user-configured	f7426fe0-9b39-4eb4-8348-4780b68b86b4	e95d0ec3-c503-4d56-baca-99a43b65f4f4	0	10	f	\N	\N
7885a591-ac7f-4353-89a9-876fcbb57901	\N	auth-otp-form	f7426fe0-9b39-4eb4-8348-4780b68b86b4	e95d0ec3-c503-4d56-baca-99a43b65f4f4	0	20	f	\N	\N
c1f94261-42cf-4621-8a86-56e334f5ab43	\N	direct-grant-validate-username	f7426fe0-9b39-4eb4-8348-4780b68b86b4	7480f46c-4da2-4464-bad0-c90104d62545	0	10	f	\N	\N
c970c9e2-bf93-4a13-aeb5-28d7eacf2994	\N	direct-grant-validate-password	f7426fe0-9b39-4eb4-8348-4780b68b86b4	7480f46c-4da2-4464-bad0-c90104d62545	0	20	f	\N	\N
9b653d28-be6f-441b-9bea-cefadd320f71	\N	\N	f7426fe0-9b39-4eb4-8348-4780b68b86b4	7480f46c-4da2-4464-bad0-c90104d62545	1	30	t	f4993bdb-644a-4450-82b2-b64e01f25d14	\N
c570aa01-1090-49f3-b3e6-08e7dc68ffcd	\N	conditional-user-configured	f7426fe0-9b39-4eb4-8348-4780b68b86b4	f4993bdb-644a-4450-82b2-b64e01f25d14	0	10	f	\N	\N
55565d85-9490-42d6-887a-239b87d432d7	\N	direct-grant-validate-otp	f7426fe0-9b39-4eb4-8348-4780b68b86b4	f4993bdb-644a-4450-82b2-b64e01f25d14	0	20	f	\N	\N
d8c2082b-1b70-4240-8fef-78011d5d91f4	\N	registration-page-form	f7426fe0-9b39-4eb4-8348-4780b68b86b4	258e3ae9-066a-4e55-9f79-b4e1e354c7db	0	10	t	b292e222-bc67-45d5-aea3-c300aca78077	\N
c2681b7d-d107-49ac-bc1c-639620412540	\N	registration-user-creation	f7426fe0-9b39-4eb4-8348-4780b68b86b4	b292e222-bc67-45d5-aea3-c300aca78077	0	20	f	\N	\N
f33b8cb5-c9e9-49c1-a27d-45709a21f2a9	\N	registration-profile-action	f7426fe0-9b39-4eb4-8348-4780b68b86b4	b292e222-bc67-45d5-aea3-c300aca78077	0	40	f	\N	\N
b3fdd8fe-6723-4057-9414-f9747e3d5d04	\N	registration-password-action	f7426fe0-9b39-4eb4-8348-4780b68b86b4	b292e222-bc67-45d5-aea3-c300aca78077	0	50	f	\N	\N
cc86c0d8-ee31-45e5-b91b-f79636474143	\N	registration-recaptcha-action	f7426fe0-9b39-4eb4-8348-4780b68b86b4	b292e222-bc67-45d5-aea3-c300aca78077	3	60	f	\N	\N
2a2d279b-0ffc-432a-93ac-3ccb46b55e6d	\N	reset-credentials-choose-user	f7426fe0-9b39-4eb4-8348-4780b68b86b4	ace4184a-9b1d-4667-978c-47b7fba8138e	0	10	f	\N	\N
ae179e5c-135a-484c-9e32-3fc7235e8d16	\N	reset-credential-email	f7426fe0-9b39-4eb4-8348-4780b68b86b4	ace4184a-9b1d-4667-978c-47b7fba8138e	0	20	f	\N	\N
d8cf787e-7867-4f3d-81b7-a7d29f520b3b	\N	reset-password	f7426fe0-9b39-4eb4-8348-4780b68b86b4	ace4184a-9b1d-4667-978c-47b7fba8138e	0	30	f	\N	\N
af48e31a-902d-44d1-b3ef-e9fa3ca384be	\N	\N	f7426fe0-9b39-4eb4-8348-4780b68b86b4	ace4184a-9b1d-4667-978c-47b7fba8138e	1	40	t	e4e9095e-f687-4d03-9fe5-10481f767984	\N
ea179892-55e7-4717-984c-81f95568cdf6	\N	conditional-user-configured	f7426fe0-9b39-4eb4-8348-4780b68b86b4	e4e9095e-f687-4d03-9fe5-10481f767984	0	10	f	\N	\N
9a098cfb-35ad-46c6-8bd7-7790bd03a4b4	\N	reset-otp	f7426fe0-9b39-4eb4-8348-4780b68b86b4	e4e9095e-f687-4d03-9fe5-10481f767984	0	20	f	\N	\N
c03d8c3e-bfc3-40ec-b3d8-a958bcc5faae	\N	client-secret	f7426fe0-9b39-4eb4-8348-4780b68b86b4	25018c07-b545-4b8d-a0bc-c52abc8f462c	2	10	f	\N	\N
16e7300b-8122-46fb-a830-15588090bfa3	\N	client-jwt	f7426fe0-9b39-4eb4-8348-4780b68b86b4	25018c07-b545-4b8d-a0bc-c52abc8f462c	2	20	f	\N	\N
df262438-bc04-4a75-9934-1b10dc816600	\N	client-secret-jwt	f7426fe0-9b39-4eb4-8348-4780b68b86b4	25018c07-b545-4b8d-a0bc-c52abc8f462c	2	30	f	\N	\N
259d1041-96f6-4fdc-8521-27f1e5525f61	\N	client-x509	f7426fe0-9b39-4eb4-8348-4780b68b86b4	25018c07-b545-4b8d-a0bc-c52abc8f462c	2	40	f	\N	\N
dd4f4870-9b8e-4e4f-99b7-60e2e2f86d62	\N	idp-review-profile	f7426fe0-9b39-4eb4-8348-4780b68b86b4	a8efc479-492d-459e-8df2-6e02d75149d2	0	10	f	\N	31e8f4c9-c6c5-4669-bf29-6b1fe6400ebd
eb012806-3797-4d7c-80ca-2cccefdc1a8a	\N	\N	f7426fe0-9b39-4eb4-8348-4780b68b86b4	a8efc479-492d-459e-8df2-6e02d75149d2	0	20	t	4a21a4aa-bf83-401e-9dd6-1f62e9bfee47	\N
6c4c94d5-ef12-4b79-87c1-df375d2ffaa9	\N	idp-create-user-if-unique	f7426fe0-9b39-4eb4-8348-4780b68b86b4	4a21a4aa-bf83-401e-9dd6-1f62e9bfee47	2	10	f	\N	15717b54-8c6a-4f0b-afe8-a939c87bbc8a
c3829457-5e25-45d8-830c-8727017962a9	\N	\N	f7426fe0-9b39-4eb4-8348-4780b68b86b4	4a21a4aa-bf83-401e-9dd6-1f62e9bfee47	2	20	t	7efac612-3cbb-4179-a889-c2217fd45907	\N
317a4454-92a5-45c2-b92a-9461161d9483	\N	idp-confirm-link	f7426fe0-9b39-4eb4-8348-4780b68b86b4	7efac612-3cbb-4179-a889-c2217fd45907	0	10	f	\N	\N
b022eaf1-6c18-4cb7-85d7-8ba694f80871	\N	\N	f7426fe0-9b39-4eb4-8348-4780b68b86b4	7efac612-3cbb-4179-a889-c2217fd45907	0	20	t	c95b56f4-7098-4865-89d4-8c245f34681e	\N
53fab5c2-5ca8-40e8-904c-682296f4e008	\N	idp-email-verification	f7426fe0-9b39-4eb4-8348-4780b68b86b4	c95b56f4-7098-4865-89d4-8c245f34681e	2	10	f	\N	\N
2a86072f-14dc-4f69-a495-b0a8de0bbac4	\N	\N	f7426fe0-9b39-4eb4-8348-4780b68b86b4	c95b56f4-7098-4865-89d4-8c245f34681e	2	20	t	60f25fce-43d5-4923-b0b3-c6e79f78da65	\N
70002a97-8a55-4ce5-a2a1-c3ec41b954af	\N	idp-username-password-form	f7426fe0-9b39-4eb4-8348-4780b68b86b4	60f25fce-43d5-4923-b0b3-c6e79f78da65	0	10	f	\N	\N
33375fb1-0800-4371-ab06-3cc15edaf179	\N	\N	f7426fe0-9b39-4eb4-8348-4780b68b86b4	60f25fce-43d5-4923-b0b3-c6e79f78da65	1	20	t	5a543493-af7d-4ce6-b861-522b075f6d70	\N
bf000521-298d-48c8-a572-bf52eb361e18	\N	conditional-user-configured	f7426fe0-9b39-4eb4-8348-4780b68b86b4	5a543493-af7d-4ce6-b861-522b075f6d70	0	10	f	\N	\N
ddaa52de-15c8-4008-8458-10653326fc44	\N	auth-otp-form	f7426fe0-9b39-4eb4-8348-4780b68b86b4	5a543493-af7d-4ce6-b861-522b075f6d70	0	20	f	\N	\N
ebd789dd-b37b-469e-836b-3a3a1a208954	\N	http-basic-authenticator	f7426fe0-9b39-4eb4-8348-4780b68b86b4	8c6f7ece-3c14-4e3d-a0d0-a1150cfd160a	0	10	f	\N	\N
f56c1699-4489-4f0a-bea4-de4c19f66379	\N	docker-http-basic-authenticator	f7426fe0-9b39-4eb4-8348-4780b68b86b4	17ad1a3f-f9e0-4ea4-9396-a0c1c0a1784d	0	10	f	\N	\N
794f8706-4bf2-468d-b034-c1d1940f6813	\N	no-cookie-redirect	f7426fe0-9b39-4eb4-8348-4780b68b86b4	7efc0369-e345-4f5e-b4b6-5cfcf0a37bd3	0	10	f	\N	\N
e09a0e31-c27c-4e1b-b8e3-cce708f14c08	\N	\N	f7426fe0-9b39-4eb4-8348-4780b68b86b4	7efc0369-e345-4f5e-b4b6-5cfcf0a37bd3	0	20	t	ee93a8a3-da26-48f9-be81-d9a0dbbbc9e3	\N
30ee3a97-b535-4bb4-ae00-66f42132ff29	\N	basic-auth	f7426fe0-9b39-4eb4-8348-4780b68b86b4	ee93a8a3-da26-48f9-be81-d9a0dbbbc9e3	0	10	f	\N	\N
aa50f809-b112-41d6-ab58-fae435270364	\N	basic-auth-otp	f7426fe0-9b39-4eb4-8348-4780b68b86b4	ee93a8a3-da26-48f9-be81-d9a0dbbbc9e3	3	20	f	\N	\N
64f2993b-9a13-4483-a33a-1661a973085e	\N	auth-spnego	f7426fe0-9b39-4eb4-8348-4780b68b86b4	ee93a8a3-da26-48f9-be81-d9a0dbbbc9e3	3	30	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
c9ea40b2-4c5e-4309-bcb0-dbc5cde99e32	browser	browser based authentication	4462ad8a-9bc0-49aa-887b-192539be165a	basic-flow	t	t
594f4af5-258c-4916-86ab-74e4a3f3e743	forms	Username, password, otp and other auth forms.	4462ad8a-9bc0-49aa-887b-192539be165a	basic-flow	f	t
8b8c00b4-9b7f-4fec-8d24-17419409856c	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	4462ad8a-9bc0-49aa-887b-192539be165a	basic-flow	f	t
947efab2-f265-4d37-9b07-0b60eefcbfbd	direct grant	OpenID Connect Resource Owner Grant	4462ad8a-9bc0-49aa-887b-192539be165a	basic-flow	t	t
422b1c91-6281-4e53-a5cc-12b230f61f9c	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	4462ad8a-9bc0-49aa-887b-192539be165a	basic-flow	f	t
311a0db9-63f6-48ad-9abe-d21e5c29614b	registration	registration flow	4462ad8a-9bc0-49aa-887b-192539be165a	basic-flow	t	t
1b467def-c710-4627-9b53-fefb26d1d0e0	registration form	registration form	4462ad8a-9bc0-49aa-887b-192539be165a	form-flow	f	t
205538a2-270a-4889-8bf0-c602f0c33492	reset credentials	Reset credentials for a user if they forgot their password or something	4462ad8a-9bc0-49aa-887b-192539be165a	basic-flow	t	t
cf304740-9887-41fb-b582-9b99e92b615b	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	4462ad8a-9bc0-49aa-887b-192539be165a	basic-flow	f	t
07be6d32-dcc2-4595-b97e-a243e96594b0	clients	Base authentication for clients	4462ad8a-9bc0-49aa-887b-192539be165a	client-flow	t	t
e2f31903-ac63-4174-be1c-ed8d07a7f58f	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	4462ad8a-9bc0-49aa-887b-192539be165a	basic-flow	t	t
10b1c456-33fd-4bda-b80e-538bd022cb9a	User creation or linking	Flow for the existing/non-existing user alternatives	4462ad8a-9bc0-49aa-887b-192539be165a	basic-flow	f	t
cd92dec7-9b71-4802-b6cc-39d5f067009d	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	4462ad8a-9bc0-49aa-887b-192539be165a	basic-flow	f	t
a7cb7bc2-de26-4dae-a1ad-197b59aadde4	Account verification options	Method with which to verity the existing account	4462ad8a-9bc0-49aa-887b-192539be165a	basic-flow	f	t
cb4b6857-7a4b-4b28-8af7-c3e7681a17ec	Verify Existing Account by Re-authentication	Reauthentication of existing account	4462ad8a-9bc0-49aa-887b-192539be165a	basic-flow	f	t
2b0341e0-ba01-4306-8252-0cdf5dbb5a05	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	4462ad8a-9bc0-49aa-887b-192539be165a	basic-flow	f	t
4a82fcca-9105-472e-a845-7787d4116987	saml ecp	SAML ECP Profile Authentication Flow	4462ad8a-9bc0-49aa-887b-192539be165a	basic-flow	t	t
8b6bb737-7425-4c5a-9572-2ebc1e6d4268	docker auth	Used by Docker clients to authenticate against the IDP	4462ad8a-9bc0-49aa-887b-192539be165a	basic-flow	t	t
ba32aa55-6048-4da8-b70f-fafd66aff071	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	4462ad8a-9bc0-49aa-887b-192539be165a	basic-flow	t	t
f44caac5-35ec-4f51-8506-376622c3524b	Authentication Options	Authentication options.	4462ad8a-9bc0-49aa-887b-192539be165a	basic-flow	f	t
f288a5dc-8e05-4477-90d5-39ac82f2d6a5	browser	browser based authentication	f7426fe0-9b39-4eb4-8348-4780b68b86b4	basic-flow	t	t
94339c8a-7d8e-4887-860d-92be7a3896ac	forms	Username, password, otp and other auth forms.	f7426fe0-9b39-4eb4-8348-4780b68b86b4	basic-flow	f	t
e95d0ec3-c503-4d56-baca-99a43b65f4f4	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	f7426fe0-9b39-4eb4-8348-4780b68b86b4	basic-flow	f	t
7480f46c-4da2-4464-bad0-c90104d62545	direct grant	OpenID Connect Resource Owner Grant	f7426fe0-9b39-4eb4-8348-4780b68b86b4	basic-flow	t	t
f4993bdb-644a-4450-82b2-b64e01f25d14	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	f7426fe0-9b39-4eb4-8348-4780b68b86b4	basic-flow	f	t
258e3ae9-066a-4e55-9f79-b4e1e354c7db	registration	registration flow	f7426fe0-9b39-4eb4-8348-4780b68b86b4	basic-flow	t	t
b292e222-bc67-45d5-aea3-c300aca78077	registration form	registration form	f7426fe0-9b39-4eb4-8348-4780b68b86b4	form-flow	f	t
ace4184a-9b1d-4667-978c-47b7fba8138e	reset credentials	Reset credentials for a user if they forgot their password or something	f7426fe0-9b39-4eb4-8348-4780b68b86b4	basic-flow	t	t
e4e9095e-f687-4d03-9fe5-10481f767984	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	f7426fe0-9b39-4eb4-8348-4780b68b86b4	basic-flow	f	t
25018c07-b545-4b8d-a0bc-c52abc8f462c	clients	Base authentication for clients	f7426fe0-9b39-4eb4-8348-4780b68b86b4	client-flow	t	t
a8efc479-492d-459e-8df2-6e02d75149d2	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	f7426fe0-9b39-4eb4-8348-4780b68b86b4	basic-flow	t	t
4a21a4aa-bf83-401e-9dd6-1f62e9bfee47	User creation or linking	Flow for the existing/non-existing user alternatives	f7426fe0-9b39-4eb4-8348-4780b68b86b4	basic-flow	f	t
7efac612-3cbb-4179-a889-c2217fd45907	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	f7426fe0-9b39-4eb4-8348-4780b68b86b4	basic-flow	f	t
c95b56f4-7098-4865-89d4-8c245f34681e	Account verification options	Method with which to verity the existing account	f7426fe0-9b39-4eb4-8348-4780b68b86b4	basic-flow	f	t
60f25fce-43d5-4923-b0b3-c6e79f78da65	Verify Existing Account by Re-authentication	Reauthentication of existing account	f7426fe0-9b39-4eb4-8348-4780b68b86b4	basic-flow	f	t
5a543493-af7d-4ce6-b861-522b075f6d70	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	f7426fe0-9b39-4eb4-8348-4780b68b86b4	basic-flow	f	t
8c6f7ece-3c14-4e3d-a0d0-a1150cfd160a	saml ecp	SAML ECP Profile Authentication Flow	f7426fe0-9b39-4eb4-8348-4780b68b86b4	basic-flow	t	t
17ad1a3f-f9e0-4ea4-9396-a0c1c0a1784d	docker auth	Used by Docker clients to authenticate against the IDP	f7426fe0-9b39-4eb4-8348-4780b68b86b4	basic-flow	t	t
7efc0369-e345-4f5e-b4b6-5cfcf0a37bd3	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	f7426fe0-9b39-4eb4-8348-4780b68b86b4	basic-flow	t	t
ee93a8a3-da26-48f9-be81-d9a0dbbbc9e3	Authentication Options	Authentication options.	f7426fe0-9b39-4eb4-8348-4780b68b86b4	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
7727c5ff-a4b1-4d9b-9eb3-d0f6c418d46a	review profile config	4462ad8a-9bc0-49aa-887b-192539be165a
e7c0911a-d6b5-4c3e-954b-f517c830ccdf	create unique user config	4462ad8a-9bc0-49aa-887b-192539be165a
31e8f4c9-c6c5-4669-bf29-6b1fe6400ebd	review profile config	f7426fe0-9b39-4eb4-8348-4780b68b86b4
15717b54-8c6a-4f0b-afe8-a939c87bbc8a	create unique user config	f7426fe0-9b39-4eb4-8348-4780b68b86b4
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
7727c5ff-a4b1-4d9b-9eb3-d0f6c418d46a	missing	update.profile.on.first.login
e7c0911a-d6b5-4c3e-954b-f517c830ccdf	false	require.password.update.after.registration
15717b54-8c6a-4f0b-afe8-a939c87bbc8a	false	require.password.update.after.registration
31e8f4c9-c6c5-4669-bf29-6b1fe6400ebd	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
6daac312-3376-4df6-a77c-1be530767894	t	f	master-realm	0	f	\N	\N	t	\N	f	4462ad8a-9bc0-49aa-887b-192539be165a	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
365e9f94-e018-41e9-9a46-73544a6dc85e	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	4462ad8a-9bc0-49aa-887b-192539be165a	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
5c046893-b83c-43bf-8110-173c406767c4	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	4462ad8a-9bc0-49aa-887b-192539be165a	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
8f1cc027-4fdf-4593-ba1e-e677fa81962e	t	f	broker	0	f	\N	\N	t	\N	f	4462ad8a-9bc0-49aa-887b-192539be165a	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
203c77ab-5b84-4cac-8982-a883bc321474	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	4462ad8a-9bc0-49aa-887b-192539be165a	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
3929d524-202d-4ad9-a0a3-ff502ad937c3	t	f	admin-cli	0	t	\N	\N	f	\N	f	4462ad8a-9bc0-49aa-887b-192539be165a	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
d4e3c9f4-3afd-4491-b7c1-cdf733a62648	t	f	development-realm	0	f	\N	\N	t	\N	f	4462ad8a-9bc0-49aa-887b-192539be165a	\N	0	f	f	development Realm	f	client-secret	\N	\N	\N	t	f	f	f
52437f02-f7d1-44af-982b-11824e320acd	t	f	realm-management	0	f	\N	\N	t	\N	f	f7426fe0-9b39-4eb4-8348-4780b68b86b4	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
1bdcd8b0-67c0-4b8f-9e68-120030586995	t	f	account	0	t	\N	/realms/development/account/	f	\N	f	f7426fe0-9b39-4eb4-8348-4780b68b86b4	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
c345fa1c-a51c-42cc-bae3-a27f78070f4d	t	f	account-console	0	t	\N	/realms/development/account/	f	\N	f	f7426fe0-9b39-4eb4-8348-4780b68b86b4	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
5d2b0d93-b6ba-4005-b767-88368baffd2b	t	f	broker	0	f	\N	\N	t	\N	f	f7426fe0-9b39-4eb4-8348-4780b68b86b4	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
d8c943ac-ce3b-4594-b705-17159fbb50be	t	f	security-admin-console	0	t	\N	/admin/development/console/	f	\N	f	f7426fe0-9b39-4eb4-8348-4780b68b86b4	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
7d1ce979-8caf-4bf5-928c-d95ea77ae7d5	t	f	admin-cli	0	t	\N	\N	f	\N	f	f7426fe0-9b39-4eb4-8348-4780b68b86b4	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
053c4f80-9471-47f4-baaf-f432f1b2cf89	t	t	rest-client	0	t	\N	\N	f	\N	f	f7426fe0-9b39-4eb4-8348-4780b68b86b4	openid-connect	-1	t	f	rest-client	f	client-secret	\N		\N	t	f	t	t
69f64c80-4877-479f-a3be-498c4f49e75c	t	t	internal-services	0	f	ASLelSDoDqTuPEODKUpantzkivy7xiRc	\N	f	\N	f	f7426fe0-9b39-4eb4-8348-4780b68b86b4	openid-connect	-1	t	f		t	client-secret	\N		\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
365e9f94-e018-41e9-9a46-73544a6dc85e	post.logout.redirect.uris	+
5c046893-b83c-43bf-8110-173c406767c4	post.logout.redirect.uris	+
5c046893-b83c-43bf-8110-173c406767c4	pkce.code.challenge.method	S256
203c77ab-5b84-4cac-8982-a883bc321474	post.logout.redirect.uris	+
203c77ab-5b84-4cac-8982-a883bc321474	pkce.code.challenge.method	S256
1bdcd8b0-67c0-4b8f-9e68-120030586995	post.logout.redirect.uris	+
c345fa1c-a51c-42cc-bae3-a27f78070f4d	post.logout.redirect.uris	+
c345fa1c-a51c-42cc-bae3-a27f78070f4d	pkce.code.challenge.method	S256
d8c943ac-ce3b-4594-b705-17159fbb50be	post.logout.redirect.uris	+
d8c943ac-ce3b-4594-b705-17159fbb50be	pkce.code.challenge.method	S256
053c4f80-9471-47f4-baaf-f432f1b2cf89	oauth2.device.authorization.grant.enabled	false
053c4f80-9471-47f4-baaf-f432f1b2cf89	oidc.ciba.grant.enabled	false
053c4f80-9471-47f4-baaf-f432f1b2cf89	backchannel.logout.session.required	true
053c4f80-9471-47f4-baaf-f432f1b2cf89	backchannel.logout.revoke.offline.tokens	false
69f64c80-4877-479f-a3be-498c4f49e75c	client.secret.creation.time	1668813532
69f64c80-4877-479f-a3be-498c4f49e75c	oauth2.device.authorization.grant.enabled	false
69f64c80-4877-479f-a3be-498c4f49e75c	oidc.ciba.grant.enabled	false
69f64c80-4877-479f-a3be-498c4f49e75c	backchannel.logout.session.required	true
69f64c80-4877-479f-a3be-498c4f49e75c	backchannel.logout.revoke.offline.tokens	false
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
9ab0ca76-b46b-4c41-9893-28932475414d	offline_access	4462ad8a-9bc0-49aa-887b-192539be165a	OpenID Connect built-in scope: offline_access	openid-connect
4110c314-fe82-4c21-a123-d4c6ef210ce2	role_list	4462ad8a-9bc0-49aa-887b-192539be165a	SAML role list	saml
591ce7f3-b89b-4ecd-97dd-1efb04efdb4a	profile	4462ad8a-9bc0-49aa-887b-192539be165a	OpenID Connect built-in scope: profile	openid-connect
ed05201b-4177-4382-8889-618388b9195f	email	4462ad8a-9bc0-49aa-887b-192539be165a	OpenID Connect built-in scope: email	openid-connect
7ee53d12-f869-4eed-82ee-0db60375e9e6	address	4462ad8a-9bc0-49aa-887b-192539be165a	OpenID Connect built-in scope: address	openid-connect
383293f8-eac1-4577-96fe-7784940368a8	phone	4462ad8a-9bc0-49aa-887b-192539be165a	OpenID Connect built-in scope: phone	openid-connect
8cc9fff2-98e9-4ac4-a745-a3df6736b036	roles	4462ad8a-9bc0-49aa-887b-192539be165a	OpenID Connect scope for add user roles to the access token	openid-connect
7d58c395-3289-48fd-a104-7f8b6594f64f	web-origins	4462ad8a-9bc0-49aa-887b-192539be165a	OpenID Connect scope for add allowed web origins to the access token	openid-connect
b4706d7f-9173-4653-800f-2b54c6b2a81c	microprofile-jwt	4462ad8a-9bc0-49aa-887b-192539be165a	Microprofile - JWT built-in scope	openid-connect
48890c47-f1ed-4e99-8cd1-a564779a95f1	acr	4462ad8a-9bc0-49aa-887b-192539be165a	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
9cf54c8a-ab1c-4649-be3c-632182ff8d83	offline_access	f7426fe0-9b39-4eb4-8348-4780b68b86b4	OpenID Connect built-in scope: offline_access	openid-connect
c6eb7a7d-4332-4ddd-ad57-b778e9b271c2	role_list	f7426fe0-9b39-4eb4-8348-4780b68b86b4	SAML role list	saml
40b52045-c184-4158-9ed0-130d19f5f04b	profile	f7426fe0-9b39-4eb4-8348-4780b68b86b4	OpenID Connect built-in scope: profile	openid-connect
2417ad88-e18f-4952-a889-d1707a2fb20d	email	f7426fe0-9b39-4eb4-8348-4780b68b86b4	OpenID Connect built-in scope: email	openid-connect
d897f308-bb7d-4b3a-a98e-49ea33c6f6d5	address	f7426fe0-9b39-4eb4-8348-4780b68b86b4	OpenID Connect built-in scope: address	openid-connect
d791a902-ec8c-4464-824e-d3d9e03788f0	phone	f7426fe0-9b39-4eb4-8348-4780b68b86b4	OpenID Connect built-in scope: phone	openid-connect
fd323536-a66b-4cba-8b98-94cf53bb67ca	roles	f7426fe0-9b39-4eb4-8348-4780b68b86b4	OpenID Connect scope for add user roles to the access token	openid-connect
4725e6b7-9327-4e4e-a895-573d5a475540	web-origins	f7426fe0-9b39-4eb4-8348-4780b68b86b4	OpenID Connect scope for add allowed web origins to the access token	openid-connect
b18f4355-9385-477d-b4fa-cea6b9a763f1	microprofile-jwt	f7426fe0-9b39-4eb4-8348-4780b68b86b4	Microprofile - JWT built-in scope	openid-connect
6e16b37f-968c-4527-806a-3031b0dd63ba	acr	f7426fe0-9b39-4eb4-8348-4780b68b86b4	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
f55cfb1f-4521-4c61-b6fc-0859d18aea44	rest-client-roles	f7426fe0-9b39-4eb4-8348-4780b68b86b4		openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
9ab0ca76-b46b-4c41-9893-28932475414d	true	display.on.consent.screen
9ab0ca76-b46b-4c41-9893-28932475414d	${offlineAccessScopeConsentText}	consent.screen.text
4110c314-fe82-4c21-a123-d4c6ef210ce2	true	display.on.consent.screen
4110c314-fe82-4c21-a123-d4c6ef210ce2	${samlRoleListScopeConsentText}	consent.screen.text
591ce7f3-b89b-4ecd-97dd-1efb04efdb4a	true	display.on.consent.screen
591ce7f3-b89b-4ecd-97dd-1efb04efdb4a	${profileScopeConsentText}	consent.screen.text
591ce7f3-b89b-4ecd-97dd-1efb04efdb4a	true	include.in.token.scope
ed05201b-4177-4382-8889-618388b9195f	true	display.on.consent.screen
ed05201b-4177-4382-8889-618388b9195f	${emailScopeConsentText}	consent.screen.text
ed05201b-4177-4382-8889-618388b9195f	true	include.in.token.scope
7ee53d12-f869-4eed-82ee-0db60375e9e6	true	display.on.consent.screen
7ee53d12-f869-4eed-82ee-0db60375e9e6	${addressScopeConsentText}	consent.screen.text
7ee53d12-f869-4eed-82ee-0db60375e9e6	true	include.in.token.scope
383293f8-eac1-4577-96fe-7784940368a8	true	display.on.consent.screen
383293f8-eac1-4577-96fe-7784940368a8	${phoneScopeConsentText}	consent.screen.text
383293f8-eac1-4577-96fe-7784940368a8	true	include.in.token.scope
8cc9fff2-98e9-4ac4-a745-a3df6736b036	true	display.on.consent.screen
8cc9fff2-98e9-4ac4-a745-a3df6736b036	${rolesScopeConsentText}	consent.screen.text
8cc9fff2-98e9-4ac4-a745-a3df6736b036	false	include.in.token.scope
7d58c395-3289-48fd-a104-7f8b6594f64f	false	display.on.consent.screen
7d58c395-3289-48fd-a104-7f8b6594f64f		consent.screen.text
7d58c395-3289-48fd-a104-7f8b6594f64f	false	include.in.token.scope
b4706d7f-9173-4653-800f-2b54c6b2a81c	false	display.on.consent.screen
b4706d7f-9173-4653-800f-2b54c6b2a81c	true	include.in.token.scope
48890c47-f1ed-4e99-8cd1-a564779a95f1	false	display.on.consent.screen
48890c47-f1ed-4e99-8cd1-a564779a95f1	false	include.in.token.scope
9cf54c8a-ab1c-4649-be3c-632182ff8d83	true	display.on.consent.screen
9cf54c8a-ab1c-4649-be3c-632182ff8d83	${offlineAccessScopeConsentText}	consent.screen.text
c6eb7a7d-4332-4ddd-ad57-b778e9b271c2	true	display.on.consent.screen
c6eb7a7d-4332-4ddd-ad57-b778e9b271c2	${samlRoleListScopeConsentText}	consent.screen.text
40b52045-c184-4158-9ed0-130d19f5f04b	true	display.on.consent.screen
40b52045-c184-4158-9ed0-130d19f5f04b	${profileScopeConsentText}	consent.screen.text
40b52045-c184-4158-9ed0-130d19f5f04b	true	include.in.token.scope
2417ad88-e18f-4952-a889-d1707a2fb20d	true	display.on.consent.screen
2417ad88-e18f-4952-a889-d1707a2fb20d	${emailScopeConsentText}	consent.screen.text
2417ad88-e18f-4952-a889-d1707a2fb20d	true	include.in.token.scope
d897f308-bb7d-4b3a-a98e-49ea33c6f6d5	true	display.on.consent.screen
d897f308-bb7d-4b3a-a98e-49ea33c6f6d5	${addressScopeConsentText}	consent.screen.text
d897f308-bb7d-4b3a-a98e-49ea33c6f6d5	true	include.in.token.scope
d791a902-ec8c-4464-824e-d3d9e03788f0	true	display.on.consent.screen
d791a902-ec8c-4464-824e-d3d9e03788f0	${phoneScopeConsentText}	consent.screen.text
d791a902-ec8c-4464-824e-d3d9e03788f0	true	include.in.token.scope
fd323536-a66b-4cba-8b98-94cf53bb67ca	true	display.on.consent.screen
fd323536-a66b-4cba-8b98-94cf53bb67ca	${rolesScopeConsentText}	consent.screen.text
fd323536-a66b-4cba-8b98-94cf53bb67ca	false	include.in.token.scope
4725e6b7-9327-4e4e-a895-573d5a475540	false	display.on.consent.screen
4725e6b7-9327-4e4e-a895-573d5a475540		consent.screen.text
4725e6b7-9327-4e4e-a895-573d5a475540	false	include.in.token.scope
b18f4355-9385-477d-b4fa-cea6b9a763f1	false	display.on.consent.screen
b18f4355-9385-477d-b4fa-cea6b9a763f1	true	include.in.token.scope
6e16b37f-968c-4527-806a-3031b0dd63ba	false	display.on.consent.screen
6e16b37f-968c-4527-806a-3031b0dd63ba	false	include.in.token.scope
f55cfb1f-4521-4c61-b6fc-0859d18aea44		consent.screen.text
f55cfb1f-4521-4c61-b6fc-0859d18aea44	true	display.on.consent.screen
f55cfb1f-4521-4c61-b6fc-0859d18aea44	true	include.in.token.scope
f55cfb1f-4521-4c61-b6fc-0859d18aea44		gui.order
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
365e9f94-e018-41e9-9a46-73544a6dc85e	591ce7f3-b89b-4ecd-97dd-1efb04efdb4a	t
365e9f94-e018-41e9-9a46-73544a6dc85e	ed05201b-4177-4382-8889-618388b9195f	t
365e9f94-e018-41e9-9a46-73544a6dc85e	48890c47-f1ed-4e99-8cd1-a564779a95f1	t
365e9f94-e018-41e9-9a46-73544a6dc85e	7d58c395-3289-48fd-a104-7f8b6594f64f	t
365e9f94-e018-41e9-9a46-73544a6dc85e	8cc9fff2-98e9-4ac4-a745-a3df6736b036	t
365e9f94-e018-41e9-9a46-73544a6dc85e	7ee53d12-f869-4eed-82ee-0db60375e9e6	f
365e9f94-e018-41e9-9a46-73544a6dc85e	9ab0ca76-b46b-4c41-9893-28932475414d	f
365e9f94-e018-41e9-9a46-73544a6dc85e	383293f8-eac1-4577-96fe-7784940368a8	f
365e9f94-e018-41e9-9a46-73544a6dc85e	b4706d7f-9173-4653-800f-2b54c6b2a81c	f
5c046893-b83c-43bf-8110-173c406767c4	591ce7f3-b89b-4ecd-97dd-1efb04efdb4a	t
5c046893-b83c-43bf-8110-173c406767c4	ed05201b-4177-4382-8889-618388b9195f	t
5c046893-b83c-43bf-8110-173c406767c4	48890c47-f1ed-4e99-8cd1-a564779a95f1	t
5c046893-b83c-43bf-8110-173c406767c4	7d58c395-3289-48fd-a104-7f8b6594f64f	t
5c046893-b83c-43bf-8110-173c406767c4	8cc9fff2-98e9-4ac4-a745-a3df6736b036	t
5c046893-b83c-43bf-8110-173c406767c4	7ee53d12-f869-4eed-82ee-0db60375e9e6	f
5c046893-b83c-43bf-8110-173c406767c4	9ab0ca76-b46b-4c41-9893-28932475414d	f
5c046893-b83c-43bf-8110-173c406767c4	383293f8-eac1-4577-96fe-7784940368a8	f
5c046893-b83c-43bf-8110-173c406767c4	b4706d7f-9173-4653-800f-2b54c6b2a81c	f
3929d524-202d-4ad9-a0a3-ff502ad937c3	591ce7f3-b89b-4ecd-97dd-1efb04efdb4a	t
3929d524-202d-4ad9-a0a3-ff502ad937c3	ed05201b-4177-4382-8889-618388b9195f	t
3929d524-202d-4ad9-a0a3-ff502ad937c3	48890c47-f1ed-4e99-8cd1-a564779a95f1	t
3929d524-202d-4ad9-a0a3-ff502ad937c3	7d58c395-3289-48fd-a104-7f8b6594f64f	t
3929d524-202d-4ad9-a0a3-ff502ad937c3	8cc9fff2-98e9-4ac4-a745-a3df6736b036	t
3929d524-202d-4ad9-a0a3-ff502ad937c3	7ee53d12-f869-4eed-82ee-0db60375e9e6	f
3929d524-202d-4ad9-a0a3-ff502ad937c3	9ab0ca76-b46b-4c41-9893-28932475414d	f
3929d524-202d-4ad9-a0a3-ff502ad937c3	383293f8-eac1-4577-96fe-7784940368a8	f
3929d524-202d-4ad9-a0a3-ff502ad937c3	b4706d7f-9173-4653-800f-2b54c6b2a81c	f
8f1cc027-4fdf-4593-ba1e-e677fa81962e	591ce7f3-b89b-4ecd-97dd-1efb04efdb4a	t
8f1cc027-4fdf-4593-ba1e-e677fa81962e	ed05201b-4177-4382-8889-618388b9195f	t
8f1cc027-4fdf-4593-ba1e-e677fa81962e	48890c47-f1ed-4e99-8cd1-a564779a95f1	t
8f1cc027-4fdf-4593-ba1e-e677fa81962e	7d58c395-3289-48fd-a104-7f8b6594f64f	t
8f1cc027-4fdf-4593-ba1e-e677fa81962e	8cc9fff2-98e9-4ac4-a745-a3df6736b036	t
8f1cc027-4fdf-4593-ba1e-e677fa81962e	7ee53d12-f869-4eed-82ee-0db60375e9e6	f
8f1cc027-4fdf-4593-ba1e-e677fa81962e	9ab0ca76-b46b-4c41-9893-28932475414d	f
8f1cc027-4fdf-4593-ba1e-e677fa81962e	383293f8-eac1-4577-96fe-7784940368a8	f
8f1cc027-4fdf-4593-ba1e-e677fa81962e	b4706d7f-9173-4653-800f-2b54c6b2a81c	f
6daac312-3376-4df6-a77c-1be530767894	591ce7f3-b89b-4ecd-97dd-1efb04efdb4a	t
6daac312-3376-4df6-a77c-1be530767894	ed05201b-4177-4382-8889-618388b9195f	t
6daac312-3376-4df6-a77c-1be530767894	48890c47-f1ed-4e99-8cd1-a564779a95f1	t
6daac312-3376-4df6-a77c-1be530767894	7d58c395-3289-48fd-a104-7f8b6594f64f	t
6daac312-3376-4df6-a77c-1be530767894	8cc9fff2-98e9-4ac4-a745-a3df6736b036	t
6daac312-3376-4df6-a77c-1be530767894	7ee53d12-f869-4eed-82ee-0db60375e9e6	f
6daac312-3376-4df6-a77c-1be530767894	9ab0ca76-b46b-4c41-9893-28932475414d	f
6daac312-3376-4df6-a77c-1be530767894	383293f8-eac1-4577-96fe-7784940368a8	f
6daac312-3376-4df6-a77c-1be530767894	b4706d7f-9173-4653-800f-2b54c6b2a81c	f
203c77ab-5b84-4cac-8982-a883bc321474	591ce7f3-b89b-4ecd-97dd-1efb04efdb4a	t
203c77ab-5b84-4cac-8982-a883bc321474	ed05201b-4177-4382-8889-618388b9195f	t
203c77ab-5b84-4cac-8982-a883bc321474	48890c47-f1ed-4e99-8cd1-a564779a95f1	t
203c77ab-5b84-4cac-8982-a883bc321474	7d58c395-3289-48fd-a104-7f8b6594f64f	t
203c77ab-5b84-4cac-8982-a883bc321474	8cc9fff2-98e9-4ac4-a745-a3df6736b036	t
203c77ab-5b84-4cac-8982-a883bc321474	7ee53d12-f869-4eed-82ee-0db60375e9e6	f
203c77ab-5b84-4cac-8982-a883bc321474	9ab0ca76-b46b-4c41-9893-28932475414d	f
203c77ab-5b84-4cac-8982-a883bc321474	383293f8-eac1-4577-96fe-7784940368a8	f
203c77ab-5b84-4cac-8982-a883bc321474	b4706d7f-9173-4653-800f-2b54c6b2a81c	f
1bdcd8b0-67c0-4b8f-9e68-120030586995	fd323536-a66b-4cba-8b98-94cf53bb67ca	t
1bdcd8b0-67c0-4b8f-9e68-120030586995	6e16b37f-968c-4527-806a-3031b0dd63ba	t
1bdcd8b0-67c0-4b8f-9e68-120030586995	2417ad88-e18f-4952-a889-d1707a2fb20d	t
1bdcd8b0-67c0-4b8f-9e68-120030586995	4725e6b7-9327-4e4e-a895-573d5a475540	t
1bdcd8b0-67c0-4b8f-9e68-120030586995	40b52045-c184-4158-9ed0-130d19f5f04b	t
1bdcd8b0-67c0-4b8f-9e68-120030586995	b18f4355-9385-477d-b4fa-cea6b9a763f1	f
1bdcd8b0-67c0-4b8f-9e68-120030586995	d791a902-ec8c-4464-824e-d3d9e03788f0	f
1bdcd8b0-67c0-4b8f-9e68-120030586995	d897f308-bb7d-4b3a-a98e-49ea33c6f6d5	f
1bdcd8b0-67c0-4b8f-9e68-120030586995	9cf54c8a-ab1c-4649-be3c-632182ff8d83	f
c345fa1c-a51c-42cc-bae3-a27f78070f4d	fd323536-a66b-4cba-8b98-94cf53bb67ca	t
c345fa1c-a51c-42cc-bae3-a27f78070f4d	6e16b37f-968c-4527-806a-3031b0dd63ba	t
c345fa1c-a51c-42cc-bae3-a27f78070f4d	2417ad88-e18f-4952-a889-d1707a2fb20d	t
c345fa1c-a51c-42cc-bae3-a27f78070f4d	4725e6b7-9327-4e4e-a895-573d5a475540	t
c345fa1c-a51c-42cc-bae3-a27f78070f4d	40b52045-c184-4158-9ed0-130d19f5f04b	t
c345fa1c-a51c-42cc-bae3-a27f78070f4d	b18f4355-9385-477d-b4fa-cea6b9a763f1	f
c345fa1c-a51c-42cc-bae3-a27f78070f4d	d791a902-ec8c-4464-824e-d3d9e03788f0	f
c345fa1c-a51c-42cc-bae3-a27f78070f4d	d897f308-bb7d-4b3a-a98e-49ea33c6f6d5	f
c345fa1c-a51c-42cc-bae3-a27f78070f4d	9cf54c8a-ab1c-4649-be3c-632182ff8d83	f
7d1ce979-8caf-4bf5-928c-d95ea77ae7d5	fd323536-a66b-4cba-8b98-94cf53bb67ca	t
7d1ce979-8caf-4bf5-928c-d95ea77ae7d5	6e16b37f-968c-4527-806a-3031b0dd63ba	t
7d1ce979-8caf-4bf5-928c-d95ea77ae7d5	2417ad88-e18f-4952-a889-d1707a2fb20d	t
7d1ce979-8caf-4bf5-928c-d95ea77ae7d5	4725e6b7-9327-4e4e-a895-573d5a475540	t
7d1ce979-8caf-4bf5-928c-d95ea77ae7d5	40b52045-c184-4158-9ed0-130d19f5f04b	t
7d1ce979-8caf-4bf5-928c-d95ea77ae7d5	b18f4355-9385-477d-b4fa-cea6b9a763f1	f
7d1ce979-8caf-4bf5-928c-d95ea77ae7d5	d791a902-ec8c-4464-824e-d3d9e03788f0	f
7d1ce979-8caf-4bf5-928c-d95ea77ae7d5	d897f308-bb7d-4b3a-a98e-49ea33c6f6d5	f
7d1ce979-8caf-4bf5-928c-d95ea77ae7d5	9cf54c8a-ab1c-4649-be3c-632182ff8d83	f
5d2b0d93-b6ba-4005-b767-88368baffd2b	fd323536-a66b-4cba-8b98-94cf53bb67ca	t
5d2b0d93-b6ba-4005-b767-88368baffd2b	6e16b37f-968c-4527-806a-3031b0dd63ba	t
5d2b0d93-b6ba-4005-b767-88368baffd2b	2417ad88-e18f-4952-a889-d1707a2fb20d	t
5d2b0d93-b6ba-4005-b767-88368baffd2b	4725e6b7-9327-4e4e-a895-573d5a475540	t
5d2b0d93-b6ba-4005-b767-88368baffd2b	40b52045-c184-4158-9ed0-130d19f5f04b	t
5d2b0d93-b6ba-4005-b767-88368baffd2b	b18f4355-9385-477d-b4fa-cea6b9a763f1	f
5d2b0d93-b6ba-4005-b767-88368baffd2b	d791a902-ec8c-4464-824e-d3d9e03788f0	f
5d2b0d93-b6ba-4005-b767-88368baffd2b	d897f308-bb7d-4b3a-a98e-49ea33c6f6d5	f
5d2b0d93-b6ba-4005-b767-88368baffd2b	9cf54c8a-ab1c-4649-be3c-632182ff8d83	f
52437f02-f7d1-44af-982b-11824e320acd	fd323536-a66b-4cba-8b98-94cf53bb67ca	t
52437f02-f7d1-44af-982b-11824e320acd	6e16b37f-968c-4527-806a-3031b0dd63ba	t
52437f02-f7d1-44af-982b-11824e320acd	2417ad88-e18f-4952-a889-d1707a2fb20d	t
52437f02-f7d1-44af-982b-11824e320acd	4725e6b7-9327-4e4e-a895-573d5a475540	t
52437f02-f7d1-44af-982b-11824e320acd	40b52045-c184-4158-9ed0-130d19f5f04b	t
52437f02-f7d1-44af-982b-11824e320acd	b18f4355-9385-477d-b4fa-cea6b9a763f1	f
52437f02-f7d1-44af-982b-11824e320acd	d791a902-ec8c-4464-824e-d3d9e03788f0	f
52437f02-f7d1-44af-982b-11824e320acd	d897f308-bb7d-4b3a-a98e-49ea33c6f6d5	f
52437f02-f7d1-44af-982b-11824e320acd	9cf54c8a-ab1c-4649-be3c-632182ff8d83	f
d8c943ac-ce3b-4594-b705-17159fbb50be	fd323536-a66b-4cba-8b98-94cf53bb67ca	t
d8c943ac-ce3b-4594-b705-17159fbb50be	6e16b37f-968c-4527-806a-3031b0dd63ba	t
d8c943ac-ce3b-4594-b705-17159fbb50be	2417ad88-e18f-4952-a889-d1707a2fb20d	t
d8c943ac-ce3b-4594-b705-17159fbb50be	4725e6b7-9327-4e4e-a895-573d5a475540	t
d8c943ac-ce3b-4594-b705-17159fbb50be	40b52045-c184-4158-9ed0-130d19f5f04b	t
d8c943ac-ce3b-4594-b705-17159fbb50be	b18f4355-9385-477d-b4fa-cea6b9a763f1	f
d8c943ac-ce3b-4594-b705-17159fbb50be	d791a902-ec8c-4464-824e-d3d9e03788f0	f
d8c943ac-ce3b-4594-b705-17159fbb50be	d897f308-bb7d-4b3a-a98e-49ea33c6f6d5	f
d8c943ac-ce3b-4594-b705-17159fbb50be	9cf54c8a-ab1c-4649-be3c-632182ff8d83	f
053c4f80-9471-47f4-baaf-f432f1b2cf89	6e16b37f-968c-4527-806a-3031b0dd63ba	t
053c4f80-9471-47f4-baaf-f432f1b2cf89	2417ad88-e18f-4952-a889-d1707a2fb20d	t
053c4f80-9471-47f4-baaf-f432f1b2cf89	4725e6b7-9327-4e4e-a895-573d5a475540	t
053c4f80-9471-47f4-baaf-f432f1b2cf89	b18f4355-9385-477d-b4fa-cea6b9a763f1	f
053c4f80-9471-47f4-baaf-f432f1b2cf89	d791a902-ec8c-4464-824e-d3d9e03788f0	f
053c4f80-9471-47f4-baaf-f432f1b2cf89	d897f308-bb7d-4b3a-a98e-49ea33c6f6d5	f
053c4f80-9471-47f4-baaf-f432f1b2cf89	9cf54c8a-ab1c-4649-be3c-632182ff8d83	f
053c4f80-9471-47f4-baaf-f432f1b2cf89	40b52045-c184-4158-9ed0-130d19f5f04b	f
69f64c80-4877-479f-a3be-498c4f49e75c	6e16b37f-968c-4527-806a-3031b0dd63ba	t
69f64c80-4877-479f-a3be-498c4f49e75c	2417ad88-e18f-4952-a889-d1707a2fb20d	t
69f64c80-4877-479f-a3be-498c4f49e75c	4725e6b7-9327-4e4e-a895-573d5a475540	t
69f64c80-4877-479f-a3be-498c4f49e75c	40b52045-c184-4158-9ed0-130d19f5f04b	t
69f64c80-4877-479f-a3be-498c4f49e75c	fd323536-a66b-4cba-8b98-94cf53bb67ca	f
69f64c80-4877-479f-a3be-498c4f49e75c	b18f4355-9385-477d-b4fa-cea6b9a763f1	f
69f64c80-4877-479f-a3be-498c4f49e75c	d791a902-ec8c-4464-824e-d3d9e03788f0	f
69f64c80-4877-479f-a3be-498c4f49e75c	f55cfb1f-4521-4c61-b6fc-0859d18aea44	f
69f64c80-4877-479f-a3be-498c4f49e75c	d897f308-bb7d-4b3a-a98e-49ea33c6f6d5	f
69f64c80-4877-479f-a3be-498c4f49e75c	9cf54c8a-ab1c-4649-be3c-632182ff8d83	f
053c4f80-9471-47f4-baaf-f432f1b2cf89	f55cfb1f-4521-4c61-b6fc-0859d18aea44	t
053c4f80-9471-47f4-baaf-f432f1b2cf89	fd323536-a66b-4cba-8b98-94cf53bb67ca	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
9ab0ca76-b46b-4c41-9893-28932475414d	7270da39-25b5-45d2-816d-6eeb424a3d58
9cf54c8a-ab1c-4649-be3c-632182ff8d83	28c76a2f-8561-4468-9e4a-88f621dc5707
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
eac9a260-40fe-4539-8254-126382bbf72c	Trusted Hosts	4462ad8a-9bc0-49aa-887b-192539be165a	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4462ad8a-9bc0-49aa-887b-192539be165a	anonymous
a191642c-2515-4d9c-bb2c-d5b6055f6222	Consent Required	4462ad8a-9bc0-49aa-887b-192539be165a	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4462ad8a-9bc0-49aa-887b-192539be165a	anonymous
c1c4691e-c884-4006-80e9-13573136f96f	Full Scope Disabled	4462ad8a-9bc0-49aa-887b-192539be165a	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4462ad8a-9bc0-49aa-887b-192539be165a	anonymous
dc9cfed3-8359-4dbc-8cb5-240fd3111ea5	Max Clients Limit	4462ad8a-9bc0-49aa-887b-192539be165a	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4462ad8a-9bc0-49aa-887b-192539be165a	anonymous
3e5ad539-0386-4bbf-ac45-e065e15bc080	Allowed Protocol Mapper Types	4462ad8a-9bc0-49aa-887b-192539be165a	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4462ad8a-9bc0-49aa-887b-192539be165a	anonymous
69e648ec-6700-4725-8b0b-b4b9bd80746a	Allowed Client Scopes	4462ad8a-9bc0-49aa-887b-192539be165a	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4462ad8a-9bc0-49aa-887b-192539be165a	anonymous
d8b30710-7c36-4f7f-ac59-0c79e73e307e	Allowed Protocol Mapper Types	4462ad8a-9bc0-49aa-887b-192539be165a	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4462ad8a-9bc0-49aa-887b-192539be165a	authenticated
6660fee2-2cef-4ff3-a926-b609b5b011c3	Allowed Client Scopes	4462ad8a-9bc0-49aa-887b-192539be165a	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4462ad8a-9bc0-49aa-887b-192539be165a	authenticated
88b2b5cb-ae73-4f31-b6b5-92e19f10b0ec	rsa-generated	4462ad8a-9bc0-49aa-887b-192539be165a	rsa-generated	org.keycloak.keys.KeyProvider	4462ad8a-9bc0-49aa-887b-192539be165a	\N
ce6980a1-f4e5-45c6-a159-be04ffe26c27	rsa-enc-generated	4462ad8a-9bc0-49aa-887b-192539be165a	rsa-enc-generated	org.keycloak.keys.KeyProvider	4462ad8a-9bc0-49aa-887b-192539be165a	\N
1d1e5e1c-cf8c-4e1b-842d-9274bfeb6429	hmac-generated	4462ad8a-9bc0-49aa-887b-192539be165a	hmac-generated	org.keycloak.keys.KeyProvider	4462ad8a-9bc0-49aa-887b-192539be165a	\N
f6dee73d-1cb3-4ff8-9013-6f97208086b4	aes-generated	4462ad8a-9bc0-49aa-887b-192539be165a	aes-generated	org.keycloak.keys.KeyProvider	4462ad8a-9bc0-49aa-887b-192539be165a	\N
b10ca023-f68b-4d1c-88ce-037e1248cd1f	rsa-generated	f7426fe0-9b39-4eb4-8348-4780b68b86b4	rsa-generated	org.keycloak.keys.KeyProvider	f7426fe0-9b39-4eb4-8348-4780b68b86b4	\N
e9e5e878-cc48-4ed8-ac72-7b0dec964cef	rsa-enc-generated	f7426fe0-9b39-4eb4-8348-4780b68b86b4	rsa-enc-generated	org.keycloak.keys.KeyProvider	f7426fe0-9b39-4eb4-8348-4780b68b86b4	\N
1c825067-b31f-4b2a-8fb6-3c84ac1db08f	hmac-generated	f7426fe0-9b39-4eb4-8348-4780b68b86b4	hmac-generated	org.keycloak.keys.KeyProvider	f7426fe0-9b39-4eb4-8348-4780b68b86b4	\N
60ac3edc-d7d0-4c72-9cfd-0d478fadc6b4	aes-generated	f7426fe0-9b39-4eb4-8348-4780b68b86b4	aes-generated	org.keycloak.keys.KeyProvider	f7426fe0-9b39-4eb4-8348-4780b68b86b4	\N
369adbb1-ff3a-49fa-a025-5ad8315a4f3f	Trusted Hosts	f7426fe0-9b39-4eb4-8348-4780b68b86b4	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f7426fe0-9b39-4eb4-8348-4780b68b86b4	anonymous
898f462c-449c-4e89-98eb-e82b0e1928c2	Consent Required	f7426fe0-9b39-4eb4-8348-4780b68b86b4	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f7426fe0-9b39-4eb4-8348-4780b68b86b4	anonymous
c91b91f3-728b-4753-8587-a7051b87775c	Full Scope Disabled	f7426fe0-9b39-4eb4-8348-4780b68b86b4	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f7426fe0-9b39-4eb4-8348-4780b68b86b4	anonymous
84317b54-ca3d-4cd7-9e5c-37f2e70ed6ee	Max Clients Limit	f7426fe0-9b39-4eb4-8348-4780b68b86b4	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f7426fe0-9b39-4eb4-8348-4780b68b86b4	anonymous
5390b03f-5593-480a-af56-3808fbdae55d	Allowed Protocol Mapper Types	f7426fe0-9b39-4eb4-8348-4780b68b86b4	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f7426fe0-9b39-4eb4-8348-4780b68b86b4	anonymous
358a0731-8ff8-4e9b-9cd3-68037faeecf2	Allowed Client Scopes	f7426fe0-9b39-4eb4-8348-4780b68b86b4	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f7426fe0-9b39-4eb4-8348-4780b68b86b4	anonymous
a710e971-b03a-4ea1-9944-72f0ecbe8a3b	Allowed Protocol Mapper Types	f7426fe0-9b39-4eb4-8348-4780b68b86b4	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f7426fe0-9b39-4eb4-8348-4780b68b86b4	authenticated
cd5b709b-6f64-4d8c-89ec-ee3ed161ce5b	Allowed Client Scopes	f7426fe0-9b39-4eb4-8348-4780b68b86b4	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f7426fe0-9b39-4eb4-8348-4780b68b86b4	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
a2292f1d-4d82-42b7-9701-0b813552c2d1	69e648ec-6700-4725-8b0b-b4b9bd80746a	allow-default-scopes	true
c772c66f-90b0-4d3e-97f3-b73dc1270dc2	d8b30710-7c36-4f7f-ac59-0c79e73e307e	allowed-protocol-mapper-types	saml-user-attribute-mapper
d80157ea-2b53-47f8-8587-e2c429b5a92d	d8b30710-7c36-4f7f-ac59-0c79e73e307e	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
6e07515a-c67e-4f70-8976-09d9b590f24e	d8b30710-7c36-4f7f-ac59-0c79e73e307e	allowed-protocol-mapper-types	oidc-full-name-mapper
f49c300d-5406-4efe-a65b-59b827aa638b	d8b30710-7c36-4f7f-ac59-0c79e73e307e	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
f5347a5a-132b-439d-984a-9246b2681aee	d8b30710-7c36-4f7f-ac59-0c79e73e307e	allowed-protocol-mapper-types	saml-user-property-mapper
01855680-72f4-4083-b26e-71e3ae7e023f	d8b30710-7c36-4f7f-ac59-0c79e73e307e	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
85c7ce23-e7b0-4161-8782-de0d5a7b6fcc	d8b30710-7c36-4f7f-ac59-0c79e73e307e	allowed-protocol-mapper-types	oidc-address-mapper
02cf5b30-d84c-4355-b9fd-af4734e9308e	d8b30710-7c36-4f7f-ac59-0c79e73e307e	allowed-protocol-mapper-types	saml-role-list-mapper
9a1562f2-c311-4ce8-9ad1-77e68ca84de8	dc9cfed3-8359-4dbc-8cb5-240fd3111ea5	max-clients	200
14fc0dde-733f-42bd-9b88-3d3a1bfd92b6	3e5ad539-0386-4bbf-ac45-e065e15bc080	allowed-protocol-mapper-types	saml-user-attribute-mapper
dfc4627a-a3e8-4955-a3f7-2404d1e41316	3e5ad539-0386-4bbf-ac45-e065e15bc080	allowed-protocol-mapper-types	oidc-full-name-mapper
7fc4022f-9e94-4835-9487-f96cfc77be6b	3e5ad539-0386-4bbf-ac45-e065e15bc080	allowed-protocol-mapper-types	saml-user-property-mapper
9bbaa935-bf8a-4477-a551-f2fd24fc699c	3e5ad539-0386-4bbf-ac45-e065e15bc080	allowed-protocol-mapper-types	saml-role-list-mapper
b203259c-238e-41dd-9bc2-ea28d7f61efb	3e5ad539-0386-4bbf-ac45-e065e15bc080	allowed-protocol-mapper-types	oidc-address-mapper
9608e282-4b7b-460d-b0cb-73e58815428c	3e5ad539-0386-4bbf-ac45-e065e15bc080	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
80f16552-1bb9-480a-82ee-ccdc383977d8	3e5ad539-0386-4bbf-ac45-e065e15bc080	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
04667ddc-c5f5-4572-b14e-218a6b0371a0	3e5ad539-0386-4bbf-ac45-e065e15bc080	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
c7a27441-5154-4429-a063-e2adc7ee13df	eac9a260-40fe-4539-8254-126382bbf72c	client-uris-must-match	true
81abadfc-7ad4-4cfe-8d36-09e5316cc1a9	eac9a260-40fe-4539-8254-126382bbf72c	host-sending-registration-request-must-match	true
acef7264-c258-4298-9e58-e40ed5a0d604	6660fee2-2cef-4ff3-a926-b609b5b011c3	allow-default-scopes	true
6b63e724-9ac2-4cbf-83ff-7eaa4e343925	ce6980a1-f4e5-45c6-a159-be04ffe26c27	privateKey	MIIEogIBAAKCAQEA15cNX2StkwdbrZcfTPov6/dAKcOBHton7If/QIEkI3ZBU8v4bLXqzAhPjK7p91G/R88cs985JBscp0G71k8YMueH6+VHb/sBOcj9aUZ82LKt3wOA3+5qNS7W3L7+blu0dOOgCwWhbKtWo2po3QFaGZNbLHu43i+nVek7gmEMD+KCAQNk0lLWN/lZpi7xYMn4491hMz5bEGAxl3ZgH0YUyPqo9ooC3WXEgeXmYJFhuu7gkfrGClqoGr9KWlPgVgIUNvAWttB4+9yDgXVQX3BVkCNJBGR5uqJjTVVnOOGiFwOyEi6pWMOfS040bHhCfJWzapJahEEJmdgwQR7U3vf+DwIDAQABAoIBAARBIlq5RJjSSQ0rBMtpMOxOqkqVfzHp9//s2FNgP3BsHOW3vW5jxQwdHXjD9Bdup3Ni0zwURSJNxXbiTxmJFD8ShTYMbCiTdjA7Cg+VFdFu7guotYpCjOabLVLlrMt/uso6h1Kzjz5zDFglBiG9k5bnatUWmFmmH7Hyn6G27/Z/2Z2qsAHxpq6s3+wF4bxg+DaQjfYizvCxEoh0sYaskgCZg7dKUzUW1667Z5R9R1x5+JCb5Tif0b5ETUc0oIDGrxD4YlF4EbKJ5jd68e/CUWVYtwKXdaAPkfXvqTszL0t+bEa0js1qf0x9xF8C5mfPX+8Qj+Q5WS85tHQKLp6aFI0CgYEA+qDoxRm9rb9S7Lec1GYYFS5+cU1ixp0e+NItHmlR4XuakFn5a6BYS5muzBCuOeBChkuMVtgpUP1+jpQ6BcBd+1w9rUNuSwJxqgHmLzi3k4sx7/KqIdTSCGsVTD6Qe7q2iLRmB/01lUEpqih6maLJujEv9/HrTkvAaHusZmpXT30CgYEA3DXm3eiXkVsvUtfs4NoXsXvGmEUxc88yaSRzuBZVS9VW2V4lKtya1ENPr1g/qhHz0l8LKOwc4R+AIDVxbBeNwrz+1w+phmTck6r+01bFg6yZO2+ULTKEjuv8I1vH9NbiVmmiP2GDU9rcYJ9jEARMkY2wbEYKJ75ZPpFmlS0rkXsCgYAoRtuhcTWOSoTlDcziRVXxcXtYcftBt9ZWXlBp5rsF5Xs9X3g515bY72Wr3bJiEqweMN3oxuw828AO4btBWVzBHF29Dm0XGNlzXMLFK/Q0fdYUnYbB0RW/zJWrnxJRD/xtk7Ah8Is/5Szw73hkYEjS5zyyN+p8tqfBIr7d5pEJcQKBgA6Hb+gMRJPOlFy+6l4bhZysMfox9oVRkl3ljc0DjDUoqkZFM+aUD5MZrdQ/2lN6Q8AJjU7x5SXlUirN2+Hp2+yRU68U1XaMiRElIxMGkpmRdbq6LeidgKl9YHFkyNiapOxWo+HSqTuLIScu3PZdkj+4PX+nT1w37uN17HLDPDCpAoGAawiS5SfLZqhhpdHgNbRqIH/6QZ3Tebz4gH4Tgm5WBUhVdNGjHMiI6FEK/gPgqPG++3vtqiQu84uLJNMvChFJm2YVy1+CREvulrr9Ew6OSsVdMIZF4su3YPbdBq5O0a5xy6+OGFRCVkZvti1WOLCWjqSOf0U7EaUlRTEqkhne4SI=
065d297c-faae-43a9-87fa-af776d7f2d62	ce6980a1-f4e5-45c6-a159-be04ffe26c27	keyUse	ENC
6297a2fc-4c48-43b4-b448-a8ad63002caa	ce6980a1-f4e5-45c6-a159-be04ffe26c27	certificate	MIICmzCCAYMCBgGEhX/+rjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIxMTE3MTIwOTI4WhcNMzIxMTE3MTIxMTA4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDXlw1fZK2TB1utlx9M+i/r90Apw4Ee2ifsh/9AgSQjdkFTy/hsterMCE+Mrun3Ub9Hzxyz3zkkGxynQbvWTxgy54fr5Udv+wE5yP1pRnzYsq3fA4Df7mo1Ltbcvv5uW7R046ALBaFsq1ajamjdAVoZk1sse7jeL6dV6TuCYQwP4oIBA2TSUtY3+VmmLvFgyfjj3WEzPlsQYDGXdmAfRhTI+qj2igLdZcSB5eZgkWG67uCR+sYKWqgav0paU+BWAhQ28Ba20Hj73IOBdVBfcFWQI0kEZHm6omNNVWc44aIXA7ISLqlYw59LTjRseEJ8lbNqklqEQQmZ2DBBHtTe9/4PAgMBAAEwDQYJKoZIhvcNAQELBQADggEBADaz8SbGAMd/M/vceYPV9/6/gM7R+shJEnsqvLnEY1nVWoIjuq/OWlukgwzw1PMEQXCTzOWMA7hEIBh8jHzRhTZJ9kF5R7KyrO9Oo7Ia/nGnw5ckuEkAuJl6IWTFdfBK0T4B8Dzw8OCWarur99SLMCLz+ro7T3WCqizcwXXCQ7vfGudv3smc+Q/jyZbHH7JOKSyma08bdaiGArBNayQvfe27TRLMQLmJk5K25paBECfgKiZo/I9ly0C05OKyYDE37wYOCk1zBxF67K/mlgqomdaukYesuEahXiVMGqB+U6S9NoWeF5LGXjsEuVGClBkLslUrqh/tryde5/kHlxN7P28=
bc1a8dd2-0ae3-4df7-a905-990983e737ae	ce6980a1-f4e5-45c6-a159-be04ffe26c27	algorithm	RSA-OAEP
1c1a6a85-55d1-44f1-8fd2-df44dc63db9b	ce6980a1-f4e5-45c6-a159-be04ffe26c27	priority	100
b22a45f2-a013-49e2-af71-26c00d174d6c	88b2b5cb-ae73-4f31-b6b5-92e19f10b0ec	privateKey	MIIEowIBAAKCAQEA50+34paVsgFGLOM0TKv5/VmpYSvjtz0h0FjvHlCUR4gRX+dWtC3YWEoLUATQag698/C0R8Kt+xQmkpYSGJehQRf8x1afZkyDF8wpWHaQsDD9bCbCEtUSPIFh1geGg2eeu14V0NMp4C+ewhytmbOGWH6kGq08VXZeyGbkgKnXzaG5wqDfor1npCBTB9AFiccnquZ8PJutNEBgezRzvBhv/n6WAjAxxxflzT1cpG6DmUSHDTbOUznIP2duRxV8cUYlH8oZbEsGZMNklv+egmKWwGmpZfNJjohhNki/LsGMzXOtYY5uTZNz02Gr8ZPS1m+5tRKPswWOpR5uuOx7Dz7XHwIDAQABAoIBAGsSbzPPcca+qT3BBGYTW3pnhSzKVLPu89aOPE3DjgfYl/ZVT0DDUfh4eekV+WWGom4nd0QafU+SgdJr7j98/PN1R5j8Y3fGpg4ffuoIpCwy2TQ1crOl9rWUTHX28NCl6AeiYyXRgXpZgLso7EEQJXmUUaFZnGqRCwnn+xEFzbPMrjVCVIIw04G6YYATCwBZiTbN6jH57Hu81LfK0ND7vCbxXNrlZHKt9bUkXzgbUvUDyLntL4fz5J4Q+/WQ/HUZzOcCCcpo5odGe2pc61CEJ5u+OLWE9Sxjt+HN9+KkzUDm6NZaEhNlHUWmtdwh6XFMPqlJRcKM/slkwHyltnFoPIUCgYEA9YkfhvIYVb5sUM2jIGcsUPtPAMyOZ5s/XVTHDavYVwO2wiF8+66bSAsyHQYqtoSaRvfWz1G0i41zwLOY47NCv75Tbv2DZ6ntUvD8AzcYMOSqlNAF+qA4KIC2x20WgpgRvEl73mcrQPE8WVffCO9sTGaKlNHuMjQ0dgmO8YZ/H3MCgYEA8StnZkNyCh/yp9DMB/IVBY9VcxNtimjWaPY0R9M+FXR4bgiJdla1zUm5fdUjEjY07fcFlIraJ6l8rPFa1VKiE7ETFST9ht9IY+1K9EN+WGhyKYlvs4AKtbcnWQLn7hbQ+dSAJKhIua0nvpVE9n/BkVGNgtt/nBUSPed1tpqppqUCgYBi7jsbvlP7yFwQOqrtlWSPxJJSehkuuajQTCZf5cunU8HBeojHR9UdNBWfCCsRm2AmFBojMoKScA4hqLuDk2jjpSYs5Eyb6iXLc3m3Oe2vVZM9nouqLgAyoZoDxHp7aBZNTTZxqBQPeKOeQ/+DtCRorDBOQj+9TreMj9Fek5iI7QKBgAYZ7QG/TxFGgaMROzgwPavoVmcU5L6NrG73W5c9luKAEdPmz2N5ChxpcxHl5H8/c9NZXoDFioNaXFcbvAqNjqAk6LCuQOO6nmA4zp6jXnzqF4lJetP1t0+llI9B7ZAub5cCc0N6JmzcHpdJu3bpAIKmp4fZ+b5/IfkC9A1smEIpAoGBAIAx/4wt0n1oyYqr5RayULom8Gnkv/+Mu2gT+G6MTK/wVeJF39ITpdiDIn27W5euQFg5pFqLACSs1qFiOofXMYJDuJWS25ZPCMsLUu+NC/foWSiPxbp70DXO1WVxG7qNKfBK5FUyHbKVSOPdQZQa4l6KMTlD4hBVW72QYTy62dXh
6e39771c-f37f-48e4-8973-df94072822c9	88b2b5cb-ae73-4f31-b6b5-92e19f10b0ec	certificate	MIICmzCCAYMCBgGEhX/7ITANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIxMTE3MTIwOTI3WhcNMzIxMTE3MTIxMTA3WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDnT7filpWyAUYs4zRMq/n9WalhK+O3PSHQWO8eUJRHiBFf51a0LdhYSgtQBNBqDr3z8LRHwq37FCaSlhIYl6FBF/zHVp9mTIMXzClYdpCwMP1sJsIS1RI8gWHWB4aDZ567XhXQ0yngL57CHK2Zs4ZYfqQarTxVdl7IZuSAqdfNobnCoN+ivWekIFMH0AWJxyeq5nw8m600QGB7NHO8GG/+fpYCMDHHF+XNPVykboOZRIcNNs5TOcg/Z25HFXxxRiUfyhlsSwZkw2SW/56CYpbAaall80mOiGE2SL8uwYzNc61hjm5Nk3PTYavxk9LWb7m1Eo+zBY6lHm647HsPPtcfAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAAqG5Wv1MP6lMyoUWPisJJIlasHZ/RSUgtH6UDBZgBm82pZtzWP24UPEt9vMUAY9tEhE0LAMUeeh1qsV/qzGhT0Rop0zchOp/pIHptIgqemiyx/SbDhPKKrEO+dfFzOO30mlmlfb3g0tTusz+EMF56EniircvL3lGrHL3FU5Meg4fw7qrTz26uPsThAibCcXyxM5CS6D0qcgkXOK95Ot8ysON+dC5HoL039QQVcUFh8LtIurYwFHEKtdWa4H6hNq00xdZ1oPm0T1IzbSL/yJrGkuHmneaEXEGFckMPFHWZqHG7bFChfrAgOlDSeRGy3EZWWPZU60WAQiqX2jt7vtCHM=
6898e5d3-d1f7-40c0-aaeb-c2bdbaafa1a0	88b2b5cb-ae73-4f31-b6b5-92e19f10b0ec	keyUse	SIG
d8721730-77bd-4c3a-aa94-421fdcb08b72	88b2b5cb-ae73-4f31-b6b5-92e19f10b0ec	priority	100
b11dc3f6-232d-4413-a6aa-c84bcffa1b60	f6dee73d-1cb3-4ff8-9013-6f97208086b4	priority	100
b6bf4840-099f-408d-8299-1e548eec370c	f6dee73d-1cb3-4ff8-9013-6f97208086b4	kid	48b60f69-7144-49f4-8ee6-c5912e4e0eb6
e4602be5-8c20-4de3-8ae6-698e7a03adbd	f6dee73d-1cb3-4ff8-9013-6f97208086b4	secret	iLkfMEe7U-uB9uFaO4Hkyg
48c17b9d-627a-4cef-93f1-5fb32712f5f3	1d1e5e1c-cf8c-4e1b-842d-9274bfeb6429	secret	d7TSBcIxqlPfQCrMswPgK4VuPv0AH2kRKDjwpjV3VPqrgz8YWkGuFjgIiPrGPXESYUU0TEtYrMzDg2kPk5vJcw
b4aa0e85-6828-4558-93ad-585a2f9ce370	1d1e5e1c-cf8c-4e1b-842d-9274bfeb6429	algorithm	HS256
0bf9cdd3-501b-4194-862a-590b2b670e91	1d1e5e1c-cf8c-4e1b-842d-9274bfeb6429	kid	1ce592e3-3ac4-433a-98e5-412d89905bfa
bbcc3844-93ff-489b-ab21-e5fe5389b6ec	1d1e5e1c-cf8c-4e1b-842d-9274bfeb6429	priority	100
2fe8f87c-9182-487f-9e11-3a143a9564b3	e9e5e878-cc48-4ed8-ac72-7b0dec964cef	privateKey	MIIEpAIBAAKCAQEAo5c/H613sseJzjRmBcrRZJ0XNa19v54BbsTT/wkElEVIR+jWOk/ThTiCoY8LP5YhYjWj0CVAJYPf5EieBG3cbxv7MdngZS41XryGIsjz39KmrRzxDu4BWhjHqlkfhTV0Y2UFQd3AHMw56wd5gJrvn8zYNB2A6Tewu6Wx8QJaJKIKBcMFwLNdh3BuvsJBLo8GlS2Xucyj60mvDvckHVmHlPQbmPUDSgIx2cq9HafLrznMvcPyi5VmAixcSIaAzcdHl9W8n3R5KOp2N8NSisPYsf5o5MfwOvJZFIxGRw9PinFNokw3IjyCb6IlCUZEDwehRiGTUqhjRVj35P3aU4qwcQIDAQABAoIBABaI4l9m+h7kuUEwOyCPon4JXLXedvzDE3/yeaB/WcPh8lXDh2Ujc2f905LVPU+uSt14NZ9ZzkcMrjYIYcoK5ytgD597m5tcfOoWrqSSiXOa1S5yFuu/UezbDoATBFJJfYWmmA2NciYVZOIRFsXmMd2RrnOpX8VgkEYdClDAifHTLwpT9qsPi1slQ5jAxCYWsFb0M/zSlxELer3Cj5qoTzPlUGzl1KyEyCINNRljeewD2mDEBtKByQqI13PNAB7RBktqM8T7S+JW87CqSpkTpyBG8nhzbEmFhN3pdn7xvIO/PI/NQXFEK4PclQeolW7hRHGBGLOLTrUB4ibfMEq63YUCgYEA0BgpEijodGONK69xuJ+VouGETX63PHKR+DkfAGjOx1LTxZ1jlRJvG22o9PZ+BQ6nK5yJoiNYrwhjznsKBalwdNU1Bb2QJDjPe68Xgy1ccWv11SgJNKDkJGSrHrbSR1+yuSyrQycXd2zg6BPz/IdbxcQEdzZSTTA+c0Xj7LHQ/10CgYEAyUBPwzq4CM1wICiw3z//VuFg8E9bTq8G74HSLJbG1E0Hc1jykpFliru/sM/8CMjNttrgcr8euABt6w7JZQHlPHLUzQ1nZQUCV7gBsFiVTPIxpSwyvd81pYARPIk8FxcfEfAr8CGF0Ug2a2EEoqReuWwqDIgXuNmO8opKsMl4aCUCgYEAhOvJ4EWtJhso44yvsWSOanpuzilw1fXA87NY8CQCYSOxDfuYznH18qk7US3aFVTkx2C4MY8uaK+NQSkqn685nAdMVRxe5CQ9tB2FgU8KS5DQeJWYO7vBvtVm0Lmq29hvCwVTaBOiU7CCgPutz9KOdmbdC2DxdUipu2wbSOfUPikCgYEAsyT+W4kPfTZykw3ltDUhtFLXmdLqMnZ3NAhZ8LserqkK8tDAzVuECiTqlBfwAFnPVPAtT7d1PtGTBuSYvcMcLd0CNK2z1ibJWRBA4JtZ+660JpXbbU0eUf5YWYzH4r4AOFWUpyMQHaWsW5V3LNgoQeJY4+LZSwDO0HPt3MTa28kCgYANyTAWGQB71HZQsOzFDQ4vhrHtTe03JqmHFgpSuiPqdAMgGrhHJinBhPBvjbjjzMdtXY0xzYWSUBkzL7I6B7sP3/uZHKiuqkBlOfc7i8TBHb/+QaTo3jT2ESKHfJBjWqODhNqTKQl30TwBMAKBJYytvWX+CYsSgofkYVHXhr8eAQ==
aa906f25-9bc3-4b47-be6f-8cc49bf2a78b	e9e5e878-cc48-4ed8-ac72-7b0dec964cef	keyUse	ENC
c3b57d00-0bad-48d1-ba5e-b10c1ca0505d	e9e5e878-cc48-4ed8-ac72-7b0dec964cef	certificate	MIICpTCCAY0CBgGEhfQJEDANBgkqhkiG9w0BAQsFADAWMRQwEgYDVQQDDAtkZXZlbG9wbWVudDAeFw0yMjExMTcxNDE2MTNaFw0zMjExMTcxNDE3NTNaMBYxFDASBgNVBAMMC2RldmVsb3BtZW50MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAo5c/H613sseJzjRmBcrRZJ0XNa19v54BbsTT/wkElEVIR+jWOk/ThTiCoY8LP5YhYjWj0CVAJYPf5EieBG3cbxv7MdngZS41XryGIsjz39KmrRzxDu4BWhjHqlkfhTV0Y2UFQd3AHMw56wd5gJrvn8zYNB2A6Tewu6Wx8QJaJKIKBcMFwLNdh3BuvsJBLo8GlS2Xucyj60mvDvckHVmHlPQbmPUDSgIx2cq9HafLrznMvcPyi5VmAixcSIaAzcdHl9W8n3R5KOp2N8NSisPYsf5o5MfwOvJZFIxGRw9PinFNokw3IjyCb6IlCUZEDwehRiGTUqhjRVj35P3aU4qwcQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQAHYU9L4mJIvYvw+ZwNKnbMfplcMa1oQQ490qquZ5FDVYy/QSuGuB2JOpzFCuujvTg/c26Wi0Bqa6fDa2x/OujZnv8AGzBNX46GDm7ZFA70I/eqFCRyUxRV9qJNGY6pHq3ex9uxrgEjnWcmCmAHmU8+UGyKvUKWcgTC0hY67NO8JX+RY3VVm93QIp7CPxlrYsJcha/xsPb9NOLaVH1kKu5CkgNpU9CTfOtXQIx8bm18H2zTQIkYb6RYydxl2skityCFndoLghy9fEmBdWiZu3tnqtPAeyL/TixzI3buIZboIgPtPqnlbwTf2w/Erhffyl1uJwmEettzTwq91E5ZVQD9
271d905c-86c8-48cf-b6ea-ee85b07d1451	e9e5e878-cc48-4ed8-ac72-7b0dec964cef	priority	100
b0152fb7-7322-4779-914a-585221b55328	e9e5e878-cc48-4ed8-ac72-7b0dec964cef	algorithm	RSA-OAEP
d4d5af00-3bb3-4ea8-85fb-efef0c18dc18	1c825067-b31f-4b2a-8fb6-3c84ac1db08f	priority	100
5da99e60-ac69-43f5-9a41-5fa39e35c71b	1c825067-b31f-4b2a-8fb6-3c84ac1db08f	kid	eef111ce-6761-448b-b21c-1092741c3d75
f99a76d3-b61d-4420-b9ed-996fab64649f	1c825067-b31f-4b2a-8fb6-3c84ac1db08f	algorithm	HS256
f9540c3f-5ba0-447b-a1f8-b3c1b8c939ea	1c825067-b31f-4b2a-8fb6-3c84ac1db08f	secret	bHYLkyzZ0R7oZnHcfWiB2Di9BEFWYbe4xrNMZVCJmvEBtn-IoKt2fNRCeV6BKd00Q6UxfWG6szuXRzQEpV9sSg
94bfa8bc-e88c-47a1-a103-982b6723a9a0	b10ca023-f68b-4d1c-88ce-037e1248cd1f	privateKey	MIIEowIBAAKCAQEAv4vlWoiQa5rydf65xAJ9mt4zQAfUPh8cDrCzrF2nwSdXi5cBJI5jK4XQA8ty1lfsiLXG61Rjvrd36iNh/LGdi4nXTP/qebJ9hhDiABtiD7pwx0w71AMyd/Wmy6nm89z48eUy6snXbupkqXe7Wfyd5Enu5ziEMOlHLdUlyEiJowUHhP2i+SA9lTEKwy0qsG3NtAYQThg6yfkkGICpWWQ27LRcEHWjDroaRD1DePLYnFQhjrOPoqYZe22AAmkVbFpI9ymII1lSOMUAo3ME2Hzk+bC66ohebgVpPnxRlQeuLjqvDTpLmF/E3o7zWst/e6CQrM7EokB754hj9UKZf4+uCwIDAQABAoIBAEuXgn5tiY0lu4zsZ1Re5UHicdhRnqWbcl+rxWR/G26DP63jfHx4QtPQvaxZtGq5jSvQjP2fMrP3xLeemhN25uVEEzccgeTgF2B6ti3zoInzeoF0aOH9FwQ3aklStkXEDWytFqCI4l+v2eT1Tvcu1gLbWJBgge6piUEhroTxd3vhF0KYLJwdSpT+noV22EfjJikfMZnccgsNiHiMbuNZxEXDaJgBa+hRSzfPf0olaOqWWTxrQNHo/18RLgiqs2SgNDUhAYerijeWh1KNl4POFGGMGYnXOS7QAnniNpVUMhQRz41dPtndfAcc8yPNNT4p/RC0ouzvOfFkFAgQ3CcZqfECgYEA8hDY96ym6eOf9G9HoGGZLIcQ7rcBHBRmEdxYhx5gWJrFbNu5LJAVyFom/cCeB7Rm3SHlB2khF6dgKoWgiXj8JHdcQ9vFfw/o2TzOwht0Sp/OmFV0ExMaW9avV43x8ER8vzvBZdOUgP8tqwpjXPXy3a7aJRANa1q3kPenHYZcdJsCgYEAypKUond8uFR1Rfn39pOCZobN4MWWFYYaNH8bzSDumeJYWIhhTVN4H+DdYcUXzGhEpk4MaGkXe06rYtdtk9JFvYusKS/L6KCa4G+Bmgz9W1krvdmKvrKUNpuBr9xTxjcHDZC4g/vu3+pbdHZQKUJVmUUTlVXyt9tXnNJfmnrWa1ECgYEA7zT844vnCfxZphiNhIzN7DWw4uVPoGr8Dqxbg3LeLNENRazACax9Chckrt+4is6YU+/ZvwABprlNC9gvM4quSG73a0tzmEOli39Opnyw58mSQ/E2Gl9nTdgSQAhSTGexitzHGhQCjZMdkwdZ95RIow7WHYgGas8j1YsVxtRu6v8CgYBbUDPcAIyh8sBiaMmTxu6TFNUdKzP6Q9bwLxPzJZMontVAI0npN2UAybZBajzOEXpQlQIW1riVBuNOzNlCNxjk1l8mubrrA+qMnPcI4C4czVdgXv2h9JHHA9Yz1deVlByDyubB6ADHwrazCtobnyFC09Z+DJ46ro8Ry+r4kcKx4QKBgFmHdNbuuPAlI5uGqlA+3VwzxanLjLbWBswCfA5xryySt62TMR/UCUgNWxrNPBYtzKjLIOcxGEpg1z95mF029VQ1Zs/5XhVP28faMRHdYDa8hUeuE0kSF2R2SsC0tv/ximWyFFjQvQUvy1lH/GQpJW8m5kUfoWaqlGZ7AqsC1Wom
50dcb5f3-431f-4adc-b0a1-959b21d28772	b10ca023-f68b-4d1c-88ce-037e1248cd1f	certificate	MIICpTCCAY0CBgGEhfQHrzANBgkqhkiG9w0BAQsFADAWMRQwEgYDVQQDDAtkZXZlbG9wbWVudDAeFw0yMjExMTcxNDE2MTNaFw0zMjExMTcxNDE3NTNaMBYxFDASBgNVBAMMC2RldmVsb3BtZW50MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAv4vlWoiQa5rydf65xAJ9mt4zQAfUPh8cDrCzrF2nwSdXi5cBJI5jK4XQA8ty1lfsiLXG61Rjvrd36iNh/LGdi4nXTP/qebJ9hhDiABtiD7pwx0w71AMyd/Wmy6nm89z48eUy6snXbupkqXe7Wfyd5Enu5ziEMOlHLdUlyEiJowUHhP2i+SA9lTEKwy0qsG3NtAYQThg6yfkkGICpWWQ27LRcEHWjDroaRD1DePLYnFQhjrOPoqYZe22AAmkVbFpI9ymII1lSOMUAo3ME2Hzk+bC66ohebgVpPnxRlQeuLjqvDTpLmF/E3o7zWst/e6CQrM7EokB754hj9UKZf4+uCwIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQCObGhPy8wZVUNPNuZyaTUNznY6FMjT0KIEYE8c0B3xWHIGvX8B6BsnsyADUI2kzWqpB1l7zGlO/EqH+nWcyJQKyu91bEwfdEa01QU0YynfoFj7mGb0bF1W4dOMpSXmm2RGJbhpGQTFqJKcHGwMy2IA1YvNIbBCj6/I7cce6ZvGKAtp8HNId4Wub3xRB0+6jGsVZu6CF2XIJVyHIYyfvdruzbOX+0ryFZqRzDGEv2FkNZOWlAtPd1Q1bAwpTc9MB8SvVdjNSp57X2mptaFrBtwVLFexQNSYt1FwqppVZYLTj0ZU7W7uXwBtg8NyI0jESpy+ie1C3j0VTeXxxe2hyTOi
c7f189da-3f85-4c73-ac6d-5be57b2c661c	b10ca023-f68b-4d1c-88ce-037e1248cd1f	priority	100
3da0a2d6-b15c-45db-8cd9-7fe2aa143f9c	b10ca023-f68b-4d1c-88ce-037e1248cd1f	keyUse	SIG
cfbb2b32-1802-4efe-87b8-3a29071dfb90	60ac3edc-d7d0-4c72-9cfd-0d478fadc6b4	priority	100
ad4df568-1b10-4ec2-878c-64e5c3e1043f	60ac3edc-d7d0-4c72-9cfd-0d478fadc6b4	secret	8BCrb9oHRcR_pQp0p4FhZg
3c267761-864a-44a2-bb13-60e19d6637f0	60ac3edc-d7d0-4c72-9cfd-0d478fadc6b4	kid	4d570d2f-5116-46c3-a2dd-06a853ba97e0
db9935f3-7f8a-4446-8a52-4f24cff22f4d	358a0731-8ff8-4e9b-9cd3-68037faeecf2	allow-default-scopes	true
9fcc16f7-2b93-422c-a1c4-0f0fc5b59939	5390b03f-5593-480a-af56-3808fbdae55d	allowed-protocol-mapper-types	saml-user-property-mapper
d555f332-7918-4d36-9102-408ef233fa73	5390b03f-5593-480a-af56-3808fbdae55d	allowed-protocol-mapper-types	oidc-address-mapper
12bcdfc4-0b74-4639-bf33-497cfe470c01	5390b03f-5593-480a-af56-3808fbdae55d	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
9a54afc3-faa4-454e-890a-1521a0fe6416	5390b03f-5593-480a-af56-3808fbdae55d	allowed-protocol-mapper-types	oidc-full-name-mapper
e1cab271-9a2a-40be-a452-2b64ae253bf6	5390b03f-5593-480a-af56-3808fbdae55d	allowed-protocol-mapper-types	saml-user-attribute-mapper
77fc868c-073b-4fbd-bb81-4b2b6cbe2277	5390b03f-5593-480a-af56-3808fbdae55d	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
a1c8a30c-c58b-4739-b578-c24785993310	5390b03f-5593-480a-af56-3808fbdae55d	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
38669d20-a774-49e9-ad39-cbfa70e86f54	5390b03f-5593-480a-af56-3808fbdae55d	allowed-protocol-mapper-types	saml-role-list-mapper
9dba34c5-f7f8-4907-8c9d-2fab6722f0a3	cd5b709b-6f64-4d8c-89ec-ee3ed161ce5b	allow-default-scopes	true
21dbc120-d7cc-4052-9368-2a6bd84697e5	84317b54-ca3d-4cd7-9e5c-37f2e70ed6ee	max-clients	200
2ee9a3c9-03e9-466f-ae01-832093c02d0d	a710e971-b03a-4ea1-9944-72f0ecbe8a3b	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
0833d93b-e32d-49f3-83f1-44010b530c3b	a710e971-b03a-4ea1-9944-72f0ecbe8a3b	allowed-protocol-mapper-types	oidc-full-name-mapper
d330715c-25b1-440f-9799-6e2ab365061f	a710e971-b03a-4ea1-9944-72f0ecbe8a3b	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
ad863499-5410-4a4c-ac58-d04a243602a1	a710e971-b03a-4ea1-9944-72f0ecbe8a3b	allowed-protocol-mapper-types	saml-user-property-mapper
9ae8b8d9-27ae-4c64-a5b7-38d3313cd284	a710e971-b03a-4ea1-9944-72f0ecbe8a3b	allowed-protocol-mapper-types	oidc-address-mapper
7192dee5-5f69-46ef-9f27-c2f9481cfa26	a710e971-b03a-4ea1-9944-72f0ecbe8a3b	allowed-protocol-mapper-types	saml-role-list-mapper
80a54686-48b9-4942-b168-5ba0e88889fc	a710e971-b03a-4ea1-9944-72f0ecbe8a3b	allowed-protocol-mapper-types	saml-user-attribute-mapper
6d17ab0e-8daf-4d21-b3b2-02a5a94f0405	a710e971-b03a-4ea1-9944-72f0ecbe8a3b	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
6e5a5515-d473-4891-abe5-bac0bff7ee0d	369adbb1-ff3a-49fa-a025-5ad8315a4f3f	client-uris-must-match	true
4bb793b6-b82d-4b7f-9468-debe834cd44e	369adbb1-ff3a-49fa-a025-5ad8315a4f3f	host-sending-registration-request-must-match	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.composite_role (composite, child_role) FROM stdin;
fcc64481-b604-439f-aff7-0dfd9f016931	a7b41c29-80bd-4e61-b672-1b872c90b008
fcc64481-b604-439f-aff7-0dfd9f016931	f2374f0b-6cae-4171-a9ac-19f7e43d9de4
fcc64481-b604-439f-aff7-0dfd9f016931	cc2297fc-fd5a-4c01-ae56-908e40eaae85
fcc64481-b604-439f-aff7-0dfd9f016931	bf2088c0-8062-410c-abfc-dec4e73842cb
fcc64481-b604-439f-aff7-0dfd9f016931	091d826a-7a99-4bf1-a581-f52e88a795fe
fcc64481-b604-439f-aff7-0dfd9f016931	c6ef4384-2a82-45da-84ab-a0da8faf95f6
fcc64481-b604-439f-aff7-0dfd9f016931	acf3058b-cd9d-47a8-a96e-46ec67184f44
fcc64481-b604-439f-aff7-0dfd9f016931	645d618b-78cc-4ccc-8487-36ceb38a8f87
fcc64481-b604-439f-aff7-0dfd9f016931	2cf4f6b6-2c13-4c92-9abc-8c804906eca3
fcc64481-b604-439f-aff7-0dfd9f016931	4e5e1a2d-4ab5-4128-b00e-9a713fd12109
fcc64481-b604-439f-aff7-0dfd9f016931	26ccd273-59fb-4e48-9bd1-ec40f7eace28
fcc64481-b604-439f-aff7-0dfd9f016931	2d7804db-064f-466e-ba5c-23a94cc1defe
fcc64481-b604-439f-aff7-0dfd9f016931	6de1a5c9-5f1f-4f5d-bb11-f8b1ec926d21
fcc64481-b604-439f-aff7-0dfd9f016931	e2e4a499-1530-4a88-a801-748b830fe05e
fcc64481-b604-439f-aff7-0dfd9f016931	06c21627-d50b-47d5-b2b4-577ca505394c
fcc64481-b604-439f-aff7-0dfd9f016931	ab3da247-d1d6-4300-9790-80e1c6bb4c47
fcc64481-b604-439f-aff7-0dfd9f016931	ab5103c0-ccfc-4c1f-8915-0075f5866d2f
fcc64481-b604-439f-aff7-0dfd9f016931	cc9ff24f-0504-4bcc-ae46-0c7ef4ef3186
091d826a-7a99-4bf1-a581-f52e88a795fe	ab3da247-d1d6-4300-9790-80e1c6bb4c47
3111849e-163a-4a14-8fc1-7ad9ffeea268	987d3517-8350-4d9b-ae5e-f4bae4c4f6ac
bf2088c0-8062-410c-abfc-dec4e73842cb	06c21627-d50b-47d5-b2b4-577ca505394c
bf2088c0-8062-410c-abfc-dec4e73842cb	cc9ff24f-0504-4bcc-ae46-0c7ef4ef3186
3111849e-163a-4a14-8fc1-7ad9ffeea268	2c5555d0-1b4a-443f-b117-f20f54b289ef
2c5555d0-1b4a-443f-b117-f20f54b289ef	a16e71b1-88a7-4868-8150-e51f8bad731a
0bcbabb4-3fc1-4582-bce9-1a5418ff1851	7e7c0454-2682-4ba7-bea2-6c3bd1b14ef2
fcc64481-b604-439f-aff7-0dfd9f016931	3ef7f36f-3f78-42d6-ad5f-4839931c7f63
3111849e-163a-4a14-8fc1-7ad9ffeea268	7270da39-25b5-45d2-816d-6eeb424a3d58
3111849e-163a-4a14-8fc1-7ad9ffeea268	9f94bbb8-f7a6-4016-9b8e-01114ebfbc62
fcc64481-b604-439f-aff7-0dfd9f016931	9c8134c8-155a-46b0-8074-3852a2534a7b
fcc64481-b604-439f-aff7-0dfd9f016931	afc521c1-c46e-4707-b19e-937bfba0b9ef
fcc64481-b604-439f-aff7-0dfd9f016931	4e8c7660-8e83-408e-9019-f0b36d6afbfc
fcc64481-b604-439f-aff7-0dfd9f016931	4b17bc6d-a201-4549-b25a-34aaca09c8c0
fcc64481-b604-439f-aff7-0dfd9f016931	4b6c49e1-ced7-4652-8a0c-56d6b9a8ed65
fcc64481-b604-439f-aff7-0dfd9f016931	069bdc19-63e9-458e-a31f-94ae47ce615b
fcc64481-b604-439f-aff7-0dfd9f016931	3b08b8a8-1af7-44a5-80cc-288019f369e5
fcc64481-b604-439f-aff7-0dfd9f016931	3fc96ef9-9bf5-4159-98db-768e2ca7f28f
fcc64481-b604-439f-aff7-0dfd9f016931	d4e58da6-9874-4a0e-a7d1-1653379c8260
fcc64481-b604-439f-aff7-0dfd9f016931	85444d65-ee76-4fa3-b11f-65f8a9ca6eca
fcc64481-b604-439f-aff7-0dfd9f016931	ba813970-65f4-48c7-91a1-c6a1d96a34aa
fcc64481-b604-439f-aff7-0dfd9f016931	72e45a12-99bc-4f2b-a3f6-67e3a4a497b0
fcc64481-b604-439f-aff7-0dfd9f016931	5b55674b-7b2c-46fb-b0c8-602f60df40d2
fcc64481-b604-439f-aff7-0dfd9f016931	e151d0dc-27d5-4743-981d-67fb7c85a5c8
fcc64481-b604-439f-aff7-0dfd9f016931	2e6a032d-e6ef-469b-ad81-bf9dd056044c
fcc64481-b604-439f-aff7-0dfd9f016931	e887762d-227f-4544-a98a-fb2f3be129a6
fcc64481-b604-439f-aff7-0dfd9f016931	1759e0a1-e4f9-4f84-a1c0-52d04b99a139
4b17bc6d-a201-4549-b25a-34aaca09c8c0	2e6a032d-e6ef-469b-ad81-bf9dd056044c
4e8c7660-8e83-408e-9019-f0b36d6afbfc	1759e0a1-e4f9-4f84-a1c0-52d04b99a139
4e8c7660-8e83-408e-9019-f0b36d6afbfc	e151d0dc-27d5-4743-981d-67fb7c85a5c8
86ea2c5e-25fd-43c8-8603-bdf1e53337e8	91bad962-abce-4123-bb9c-4db4c93fb2b5
86ea2c5e-25fd-43c8-8603-bdf1e53337e8	75bad138-a0ac-46ca-90ca-46d97ef8cc71
86ea2c5e-25fd-43c8-8603-bdf1e53337e8	a7dbc9db-d835-4c00-bb4c-2181a3512f34
86ea2c5e-25fd-43c8-8603-bdf1e53337e8	03bb8506-ac51-4d91-898a-d61d0532bbdc
86ea2c5e-25fd-43c8-8603-bdf1e53337e8	12ba6c61-7c9a-4854-852d-09e4daa5ec74
86ea2c5e-25fd-43c8-8603-bdf1e53337e8	dc690927-39a2-4a70-ab48-b93958b2947c
86ea2c5e-25fd-43c8-8603-bdf1e53337e8	7daa6c0c-76b0-45fe-8b39-96d4d5b736a7
86ea2c5e-25fd-43c8-8603-bdf1e53337e8	f4fded31-fe8d-43c0-8289-edc8fd181378
86ea2c5e-25fd-43c8-8603-bdf1e53337e8	1b3d5c94-0ebf-47fe-90a0-b6f09e7499de
86ea2c5e-25fd-43c8-8603-bdf1e53337e8	1796cf9a-a279-4117-b8aa-e0c792a7ff44
86ea2c5e-25fd-43c8-8603-bdf1e53337e8	4adf7651-a773-4e2e-89be-5a46dfc75475
86ea2c5e-25fd-43c8-8603-bdf1e53337e8	029580e4-41e2-4bd8-8a0d-8be742f1d83d
86ea2c5e-25fd-43c8-8603-bdf1e53337e8	68b5cd97-70df-4142-a2c5-b9230f73bac5
86ea2c5e-25fd-43c8-8603-bdf1e53337e8	7be43ac4-a4b5-470c-96f4-9d56c1118bd1
86ea2c5e-25fd-43c8-8603-bdf1e53337e8	38250e8e-e305-4dae-b2a4-3797bc955a71
86ea2c5e-25fd-43c8-8603-bdf1e53337e8	38b4b795-c971-472d-97fb-8f1d5c5cbd1e
86ea2c5e-25fd-43c8-8603-bdf1e53337e8	64d12247-206c-400b-b0da-d10893c0b1c6
03bb8506-ac51-4d91-898a-d61d0532bbdc	38250e8e-e305-4dae-b2a4-3797bc955a71
4715f9b4-7df9-4b27-a87e-0427f84823b5	8915adbd-344b-4682-8b47-195b318e9ce0
a7dbc9db-d835-4c00-bb4c-2181a3512f34	64d12247-206c-400b-b0da-d10893c0b1c6
a7dbc9db-d835-4c00-bb4c-2181a3512f34	7be43ac4-a4b5-470c-96f4-9d56c1118bd1
4715f9b4-7df9-4b27-a87e-0427f84823b5	8582ebab-88c2-4b8b-889b-f8c6878a276d
8582ebab-88c2-4b8b-889b-f8c6878a276d	2fa93b36-3727-49e9-8f2a-ea3acdde9fcd
8540586e-5b88-46a7-be99-e00fd9eb1def	6850313e-33ba-4b0d-95fb-64d4bc65c139
fcc64481-b604-439f-aff7-0dfd9f016931	4e16f673-4e6a-43c7-82f7-b2b327a05551
86ea2c5e-25fd-43c8-8603-bdf1e53337e8	dc4e49c1-caa6-450c-8a0a-7613d795aeaa
4715f9b4-7df9-4b27-a87e-0427f84823b5	28c76a2f-8561-4468-9e4a-88f621dc5707
4715f9b4-7df9-4b27-a87e-0427f84823b5	b525ebbb-66dd-4a24-9dbb-8222557fa5c2
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
53e8c164-35e3-411b-9ee1-3131f798cdbd	\N	password	17b3cd37-9d48-4414-a8ed-a120f949e3f5	1668694569732	\N	{"value":"EZpPMbElOhqyD+g8IHcBVj4ichbpMRRpfMXHQ4OoPRJuw8DqK3qut4d9AWbnlwbU/SVqCKG0z93ap/d51u/KOQ==","salt":"cM/uOrBEGpKpUQsKyctEow==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
63c39d83-928b-43e7-a1ec-7784bd2a4968	\N	password	9b538bc9-284e-4acc-b034-7acf4ce0fdf8	1668695031654	My password	{"value":"Wus3R/PdAefzp/op7mXEB5Ncz2xvUONaM+o8VjrDtUaBVztjNrgw+NCDpDpzUFC3C5oQ0K2+C3KFdl06JtYgHg==","salt":"oBGGLCOVFw1wZGa2OWWlFg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2022-11-17 12:10:57.52755	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	8687056001
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2022-11-17 12:10:57.554889	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	8687056001
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2022-11-17 12:10:57.692952	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.8.0	\N	\N	8687056001
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2022-11-17 12:10:57.710266	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	8687056001
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2022-11-17 12:10:58.007229	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	8687056001
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2022-11-17 12:10:58.017182	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	8687056001
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2022-11-17 12:10:58.270034	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	8687056001
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2022-11-17 12:10:58.278664	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	8687056001
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2022-11-17 12:10:58.296716	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.8.0	\N	\N	8687056001
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2022-11-17 12:10:58.569228	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.8.0	\N	\N	8687056001
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2022-11-17 12:10:58.756189	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	8687056001
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2022-11-17 12:10:58.76327	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	8687056001
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2022-11-17 12:10:58.833817	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	8687056001
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-11-17 12:10:58.883816	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.8.0	\N	\N	8687056001
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-11-17 12:10:58.889977	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	8687056001
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-11-17 12:10:58.89602	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.8.0	\N	\N	8687056001
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-11-17 12:10:58.902193	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.8.0	\N	\N	8687056001
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2022-11-17 12:10:59.020345	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.8.0	\N	\N	8687056001
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2022-11-17 12:10:59.125181	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	8687056001
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2022-11-17 12:10:59.14016	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	8687056001
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-11-17 12:11:00.174596	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	8687056001
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2022-11-17 12:10:59.146082	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	8687056001
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2022-11-17 12:10:59.152707	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	8687056001
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2022-11-17 12:10:59.21694	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.8.0	\N	\N	8687056001
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2022-11-17 12:10:59.23291	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	8687056001
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2022-11-17 12:10:59.239674	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	8687056001
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2022-11-17 12:10:59.309423	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.8.0	\N	\N	8687056001
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2022-11-17 12:10:59.472447	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.8.0	\N	\N	8687056001
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2022-11-17 12:10:59.48179	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	8687056001
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2022-11-17 12:10:59.617186	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.8.0	\N	\N	8687056001
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2022-11-17 12:10:59.64733	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.8.0	\N	\N	8687056001
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2022-11-17 12:10:59.694561	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.8.0	\N	\N	8687056001
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2022-11-17 12:10:59.706998	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	4.8.0	\N	\N	8687056001
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-11-17 12:10:59.724018	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	8687056001
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-11-17 12:10:59.729963	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	8687056001
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-11-17 12:10:59.809913	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	8687056001
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2022-11-17 12:10:59.82643	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	4.8.0	\N	\N	8687056001
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-11-17 12:10:59.842662	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	8687056001
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2022-11-17 12:10:59.852173	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	4.8.0	\N	\N	8687056001
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2022-11-17 12:10:59.860836	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	4.8.0	\N	\N	8687056001
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-11-17 12:10:59.86571	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	8687056001
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-11-17 12:10:59.870796	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	8687056001
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2022-11-17 12:10:59.883499	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	4.8.0	\N	\N	8687056001
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-11-17 12:11:00.150468	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.8.0	\N	\N	8687056001
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2022-11-17 12:11:00.16014	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	4.8.0	\N	\N	8687056001
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-11-17 12:11:00.186156	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	4.8.0	\N	\N	8687056001
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-11-17 12:11:00.190859	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	8687056001
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-11-17 12:11:00.290448	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.8.0	\N	\N	8687056001
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-11-17 12:11:00.301287	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	4.8.0	\N	\N	8687056001
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2022-11-17 12:11:00.40397	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.8.0	\N	\N	8687056001
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2022-11-17 12:11:00.469416	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.8.0	\N	\N	8687056001
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2022-11-17 12:11:00.479786	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	8687056001
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2022-11-17 12:11:00.492299	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	4.8.0	\N	\N	8687056001
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2022-11-17 12:11:00.503744	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	4.8.0	\N	\N	8687056001
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-11-17 12:11:00.522873	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.8.0	\N	\N	8687056001
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-11-17 12:11:00.534889	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.8.0	\N	\N	8687056001
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-11-17 12:11:00.599497	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.8.0	\N	\N	8687056001
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-11-17 12:11:00.917992	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.8.0	\N	\N	8687056001
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2022-11-17 12:11:00.990221	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.8.0	\N	\N	8687056001
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2022-11-17 12:11:01.004833	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	8687056001
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-11-17 12:11:01.030399	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.8.0	\N	\N	8687056001
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-11-17 12:11:01.043922	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.8.0	\N	\N	8687056001
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2022-11-17 12:11:01.053014	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	8687056001
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2022-11-17 12:11:01.06112	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	8687056001
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2022-11-17 12:11:01.071927	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.8.0	\N	\N	8687056001
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2022-11-17 12:11:01.099289	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.8.0	\N	\N	8687056001
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2022-11-17 12:11:01.110809	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.8.0	\N	\N	8687056001
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2022-11-17 12:11:01.12332	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	4.8.0	\N	\N	8687056001
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2022-11-17 12:11:01.153909	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.8.0	\N	\N	8687056001
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2022-11-17 12:11:01.170864	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.8.0	\N	\N	8687056001
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2022-11-17 12:11:01.180488	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	4.8.0	\N	\N	8687056001
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-11-17 12:11:01.202515	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	8687056001
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-11-17 12:11:01.227028	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	8687056001
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-11-17 12:11:01.232496	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	8687056001
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-11-17 12:11:01.297275	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.8.0	\N	\N	8687056001
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-11-17 12:11:01.317887	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.8.0	\N	\N	8687056001
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-11-17 12:11:01.326613	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	4.8.0	\N	\N	8687056001
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-11-17 12:11:01.331207	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.8.0	\N	\N	8687056001
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-11-17 12:11:01.370085	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.8.0	\N	\N	8687056001
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-11-17 12:11:01.375699	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.8.0	\N	\N	8687056001
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-11-17 12:11:01.386383	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.8.0	\N	\N	8687056001
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-11-17 12:11:01.391361	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	8687056001
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-11-17 12:11:01.402189	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	8687056001
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-11-17 12:11:01.406566	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	8687056001
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-11-17 12:11:01.427142	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	8687056001
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2022-11-17 12:11:01.439492	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.8.0	\N	\N	8687056001
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-11-17 12:11:01.45729	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.8.0	\N	\N	8687056001
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-11-17 12:11:01.473686	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.8.0	\N	\N	8687056001
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-17 12:11:01.489987	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	4.8.0	\N	\N	8687056001
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-17 12:11:01.504589	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.8.0	\N	\N	8687056001
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-17 12:11:01.515555	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	8687056001
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-17 12:11:01.536262	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.8.0	\N	\N	8687056001
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-17 12:11:01.540083	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	8687056001
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-17 12:11:01.55513	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	8687056001
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-17 12:11:01.559628	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.8.0	\N	\N	8687056001
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-11-17 12:11:01.573288	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.8.0	\N	\N	8687056001
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-17 12:11:01.597136	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	8687056001
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-17 12:11:01.6031	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	8687056001
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-17 12:11:01.641725	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	8687056001
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-17 12:11:01.652853	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	8687056001
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-17 12:11:01.657946	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	8687056001
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-17 12:11:01.671391	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.8.0	\N	\N	8687056001
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-11-17 12:11:01.687919	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	4.8.0	\N	\N	8687056001
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2022-11-17 12:11:01.711651	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.8.0	\N	\N	8687056001
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2022-11-17 12:11:01.725657	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.8.0	\N	\N	8687056001
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2022-11-17 12:11:01.739182	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.8.0	\N	\N	8687056001
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2022-11-17 12:11:01.753374	107	EXECUTED	8:af510cd1bb2ab6339c45372f3e491696	customChange		\N	4.8.0	\N	\N	8687056001
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2022-11-17 12:11:01.769997	108	EXECUTED	8:05c99fc610845ef66ee812b7921af0ef	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.8.0	\N	\N	8687056001
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2022-11-17 12:11:01.778177	109	MARK_RAN	8:314e803baf2f1ec315b3464e398b8247	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.8.0	\N	\N	8687056001
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2022-11-17 12:11:01.804943	110	EXECUTED	8:56e4677e7e12556f70b604c573840100	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	8687056001
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
4462ad8a-9bc0-49aa-887b-192539be165a	9ab0ca76-b46b-4c41-9893-28932475414d	f
4462ad8a-9bc0-49aa-887b-192539be165a	4110c314-fe82-4c21-a123-d4c6ef210ce2	t
4462ad8a-9bc0-49aa-887b-192539be165a	591ce7f3-b89b-4ecd-97dd-1efb04efdb4a	t
4462ad8a-9bc0-49aa-887b-192539be165a	ed05201b-4177-4382-8889-618388b9195f	t
4462ad8a-9bc0-49aa-887b-192539be165a	7ee53d12-f869-4eed-82ee-0db60375e9e6	f
4462ad8a-9bc0-49aa-887b-192539be165a	383293f8-eac1-4577-96fe-7784940368a8	f
4462ad8a-9bc0-49aa-887b-192539be165a	8cc9fff2-98e9-4ac4-a745-a3df6736b036	t
4462ad8a-9bc0-49aa-887b-192539be165a	7d58c395-3289-48fd-a104-7f8b6594f64f	t
4462ad8a-9bc0-49aa-887b-192539be165a	b4706d7f-9173-4653-800f-2b54c6b2a81c	f
4462ad8a-9bc0-49aa-887b-192539be165a	48890c47-f1ed-4e99-8cd1-a564779a95f1	t
f7426fe0-9b39-4eb4-8348-4780b68b86b4	9cf54c8a-ab1c-4649-be3c-632182ff8d83	f
f7426fe0-9b39-4eb4-8348-4780b68b86b4	40b52045-c184-4158-9ed0-130d19f5f04b	t
f7426fe0-9b39-4eb4-8348-4780b68b86b4	2417ad88-e18f-4952-a889-d1707a2fb20d	t
f7426fe0-9b39-4eb4-8348-4780b68b86b4	d897f308-bb7d-4b3a-a98e-49ea33c6f6d5	f
f7426fe0-9b39-4eb4-8348-4780b68b86b4	d791a902-ec8c-4464-824e-d3d9e03788f0	f
f7426fe0-9b39-4eb4-8348-4780b68b86b4	4725e6b7-9327-4e4e-a895-573d5a475540	t
f7426fe0-9b39-4eb4-8348-4780b68b86b4	b18f4355-9385-477d-b4fa-cea6b9a763f1	f
f7426fe0-9b39-4eb4-8348-4780b68b86b4	6e16b37f-968c-4527-806a-3031b0dd63ba	t
f7426fe0-9b39-4eb4-8348-4780b68b86b4	f55cfb1f-4521-4c61-b6fc-0859d18aea44	f
f7426fe0-9b39-4eb4-8348-4780b68b86b4	fd323536-a66b-4cba-8b98-94cf53bb67ca	f
f7426fe0-9b39-4eb4-8348-4780b68b86b4	c6eb7a7d-4332-4ddd-ad57-b778e9b271c2	t
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
3111849e-163a-4a14-8fc1-7ad9ffeea268	4462ad8a-9bc0-49aa-887b-192539be165a	f	${role_default-roles}	default-roles-master	4462ad8a-9bc0-49aa-887b-192539be165a	\N	\N
a7b41c29-80bd-4e61-b672-1b872c90b008	4462ad8a-9bc0-49aa-887b-192539be165a	f	${role_create-realm}	create-realm	4462ad8a-9bc0-49aa-887b-192539be165a	\N	\N
fcc64481-b604-439f-aff7-0dfd9f016931	4462ad8a-9bc0-49aa-887b-192539be165a	f	${role_admin}	admin	4462ad8a-9bc0-49aa-887b-192539be165a	\N	\N
f2374f0b-6cae-4171-a9ac-19f7e43d9de4	6daac312-3376-4df6-a77c-1be530767894	t	${role_create-client}	create-client	4462ad8a-9bc0-49aa-887b-192539be165a	6daac312-3376-4df6-a77c-1be530767894	\N
cc2297fc-fd5a-4c01-ae56-908e40eaae85	6daac312-3376-4df6-a77c-1be530767894	t	${role_view-realm}	view-realm	4462ad8a-9bc0-49aa-887b-192539be165a	6daac312-3376-4df6-a77c-1be530767894	\N
bf2088c0-8062-410c-abfc-dec4e73842cb	6daac312-3376-4df6-a77c-1be530767894	t	${role_view-users}	view-users	4462ad8a-9bc0-49aa-887b-192539be165a	6daac312-3376-4df6-a77c-1be530767894	\N
091d826a-7a99-4bf1-a581-f52e88a795fe	6daac312-3376-4df6-a77c-1be530767894	t	${role_view-clients}	view-clients	4462ad8a-9bc0-49aa-887b-192539be165a	6daac312-3376-4df6-a77c-1be530767894	\N
c6ef4384-2a82-45da-84ab-a0da8faf95f6	6daac312-3376-4df6-a77c-1be530767894	t	${role_view-events}	view-events	4462ad8a-9bc0-49aa-887b-192539be165a	6daac312-3376-4df6-a77c-1be530767894	\N
acf3058b-cd9d-47a8-a96e-46ec67184f44	6daac312-3376-4df6-a77c-1be530767894	t	${role_view-identity-providers}	view-identity-providers	4462ad8a-9bc0-49aa-887b-192539be165a	6daac312-3376-4df6-a77c-1be530767894	\N
645d618b-78cc-4ccc-8487-36ceb38a8f87	6daac312-3376-4df6-a77c-1be530767894	t	${role_view-authorization}	view-authorization	4462ad8a-9bc0-49aa-887b-192539be165a	6daac312-3376-4df6-a77c-1be530767894	\N
2cf4f6b6-2c13-4c92-9abc-8c804906eca3	6daac312-3376-4df6-a77c-1be530767894	t	${role_manage-realm}	manage-realm	4462ad8a-9bc0-49aa-887b-192539be165a	6daac312-3376-4df6-a77c-1be530767894	\N
4e5e1a2d-4ab5-4128-b00e-9a713fd12109	6daac312-3376-4df6-a77c-1be530767894	t	${role_manage-users}	manage-users	4462ad8a-9bc0-49aa-887b-192539be165a	6daac312-3376-4df6-a77c-1be530767894	\N
26ccd273-59fb-4e48-9bd1-ec40f7eace28	6daac312-3376-4df6-a77c-1be530767894	t	${role_manage-clients}	manage-clients	4462ad8a-9bc0-49aa-887b-192539be165a	6daac312-3376-4df6-a77c-1be530767894	\N
2d7804db-064f-466e-ba5c-23a94cc1defe	6daac312-3376-4df6-a77c-1be530767894	t	${role_manage-events}	manage-events	4462ad8a-9bc0-49aa-887b-192539be165a	6daac312-3376-4df6-a77c-1be530767894	\N
6de1a5c9-5f1f-4f5d-bb11-f8b1ec926d21	6daac312-3376-4df6-a77c-1be530767894	t	${role_manage-identity-providers}	manage-identity-providers	4462ad8a-9bc0-49aa-887b-192539be165a	6daac312-3376-4df6-a77c-1be530767894	\N
e2e4a499-1530-4a88-a801-748b830fe05e	6daac312-3376-4df6-a77c-1be530767894	t	${role_manage-authorization}	manage-authorization	4462ad8a-9bc0-49aa-887b-192539be165a	6daac312-3376-4df6-a77c-1be530767894	\N
06c21627-d50b-47d5-b2b4-577ca505394c	6daac312-3376-4df6-a77c-1be530767894	t	${role_query-users}	query-users	4462ad8a-9bc0-49aa-887b-192539be165a	6daac312-3376-4df6-a77c-1be530767894	\N
ab3da247-d1d6-4300-9790-80e1c6bb4c47	6daac312-3376-4df6-a77c-1be530767894	t	${role_query-clients}	query-clients	4462ad8a-9bc0-49aa-887b-192539be165a	6daac312-3376-4df6-a77c-1be530767894	\N
ab5103c0-ccfc-4c1f-8915-0075f5866d2f	6daac312-3376-4df6-a77c-1be530767894	t	${role_query-realms}	query-realms	4462ad8a-9bc0-49aa-887b-192539be165a	6daac312-3376-4df6-a77c-1be530767894	\N
cc9ff24f-0504-4bcc-ae46-0c7ef4ef3186	6daac312-3376-4df6-a77c-1be530767894	t	${role_query-groups}	query-groups	4462ad8a-9bc0-49aa-887b-192539be165a	6daac312-3376-4df6-a77c-1be530767894	\N
987d3517-8350-4d9b-ae5e-f4bae4c4f6ac	365e9f94-e018-41e9-9a46-73544a6dc85e	t	${role_view-profile}	view-profile	4462ad8a-9bc0-49aa-887b-192539be165a	365e9f94-e018-41e9-9a46-73544a6dc85e	\N
2c5555d0-1b4a-443f-b117-f20f54b289ef	365e9f94-e018-41e9-9a46-73544a6dc85e	t	${role_manage-account}	manage-account	4462ad8a-9bc0-49aa-887b-192539be165a	365e9f94-e018-41e9-9a46-73544a6dc85e	\N
a16e71b1-88a7-4868-8150-e51f8bad731a	365e9f94-e018-41e9-9a46-73544a6dc85e	t	${role_manage-account-links}	manage-account-links	4462ad8a-9bc0-49aa-887b-192539be165a	365e9f94-e018-41e9-9a46-73544a6dc85e	\N
2f87e118-9ba4-42f2-838d-7efd50b77e93	365e9f94-e018-41e9-9a46-73544a6dc85e	t	${role_view-applications}	view-applications	4462ad8a-9bc0-49aa-887b-192539be165a	365e9f94-e018-41e9-9a46-73544a6dc85e	\N
7e7c0454-2682-4ba7-bea2-6c3bd1b14ef2	365e9f94-e018-41e9-9a46-73544a6dc85e	t	${role_view-consent}	view-consent	4462ad8a-9bc0-49aa-887b-192539be165a	365e9f94-e018-41e9-9a46-73544a6dc85e	\N
0bcbabb4-3fc1-4582-bce9-1a5418ff1851	365e9f94-e018-41e9-9a46-73544a6dc85e	t	${role_manage-consent}	manage-consent	4462ad8a-9bc0-49aa-887b-192539be165a	365e9f94-e018-41e9-9a46-73544a6dc85e	\N
2b902f06-9d40-4537-a6b1-7a902fee8c6c	365e9f94-e018-41e9-9a46-73544a6dc85e	t	${role_view-groups}	view-groups	4462ad8a-9bc0-49aa-887b-192539be165a	365e9f94-e018-41e9-9a46-73544a6dc85e	\N
065b20d8-97f2-4dbe-9c95-444baa5edf5c	365e9f94-e018-41e9-9a46-73544a6dc85e	t	${role_delete-account}	delete-account	4462ad8a-9bc0-49aa-887b-192539be165a	365e9f94-e018-41e9-9a46-73544a6dc85e	\N
82d45511-80d8-4153-8ff7-f99a9d25c0d2	8f1cc027-4fdf-4593-ba1e-e677fa81962e	t	${role_read-token}	read-token	4462ad8a-9bc0-49aa-887b-192539be165a	8f1cc027-4fdf-4593-ba1e-e677fa81962e	\N
3ef7f36f-3f78-42d6-ad5f-4839931c7f63	6daac312-3376-4df6-a77c-1be530767894	t	${role_impersonation}	impersonation	4462ad8a-9bc0-49aa-887b-192539be165a	6daac312-3376-4df6-a77c-1be530767894	\N
7270da39-25b5-45d2-816d-6eeb424a3d58	4462ad8a-9bc0-49aa-887b-192539be165a	f	${role_offline-access}	offline_access	4462ad8a-9bc0-49aa-887b-192539be165a	\N	\N
9f94bbb8-f7a6-4016-9b8e-01114ebfbc62	4462ad8a-9bc0-49aa-887b-192539be165a	f	${role_uma_authorization}	uma_authorization	4462ad8a-9bc0-49aa-887b-192539be165a	\N	\N
4715f9b4-7df9-4b27-a87e-0427f84823b5	f7426fe0-9b39-4eb4-8348-4780b68b86b4	f	${role_default-roles}	default-roles-development	f7426fe0-9b39-4eb4-8348-4780b68b86b4	\N	\N
9c8134c8-155a-46b0-8074-3852a2534a7b	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	t	${role_create-client}	create-client	4462ad8a-9bc0-49aa-887b-192539be165a	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	\N
afc521c1-c46e-4707-b19e-937bfba0b9ef	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	t	${role_view-realm}	view-realm	4462ad8a-9bc0-49aa-887b-192539be165a	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	\N
4e8c7660-8e83-408e-9019-f0b36d6afbfc	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	t	${role_view-users}	view-users	4462ad8a-9bc0-49aa-887b-192539be165a	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	\N
4b17bc6d-a201-4549-b25a-34aaca09c8c0	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	t	${role_view-clients}	view-clients	4462ad8a-9bc0-49aa-887b-192539be165a	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	\N
4b6c49e1-ced7-4652-8a0c-56d6b9a8ed65	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	t	${role_view-events}	view-events	4462ad8a-9bc0-49aa-887b-192539be165a	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	\N
069bdc19-63e9-458e-a31f-94ae47ce615b	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	t	${role_view-identity-providers}	view-identity-providers	4462ad8a-9bc0-49aa-887b-192539be165a	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	\N
3b08b8a8-1af7-44a5-80cc-288019f369e5	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	t	${role_view-authorization}	view-authorization	4462ad8a-9bc0-49aa-887b-192539be165a	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	\N
3fc96ef9-9bf5-4159-98db-768e2ca7f28f	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	t	${role_manage-realm}	manage-realm	4462ad8a-9bc0-49aa-887b-192539be165a	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	\N
d4e58da6-9874-4a0e-a7d1-1653379c8260	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	t	${role_manage-users}	manage-users	4462ad8a-9bc0-49aa-887b-192539be165a	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	\N
85444d65-ee76-4fa3-b11f-65f8a9ca6eca	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	t	${role_manage-clients}	manage-clients	4462ad8a-9bc0-49aa-887b-192539be165a	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	\N
ba813970-65f4-48c7-91a1-c6a1d96a34aa	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	t	${role_manage-events}	manage-events	4462ad8a-9bc0-49aa-887b-192539be165a	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	\N
72e45a12-99bc-4f2b-a3f6-67e3a4a497b0	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	t	${role_manage-identity-providers}	manage-identity-providers	4462ad8a-9bc0-49aa-887b-192539be165a	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	\N
5b55674b-7b2c-46fb-b0c8-602f60df40d2	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	t	${role_manage-authorization}	manage-authorization	4462ad8a-9bc0-49aa-887b-192539be165a	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	\N
e151d0dc-27d5-4743-981d-67fb7c85a5c8	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	t	${role_query-users}	query-users	4462ad8a-9bc0-49aa-887b-192539be165a	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	\N
2e6a032d-e6ef-469b-ad81-bf9dd056044c	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	t	${role_query-clients}	query-clients	4462ad8a-9bc0-49aa-887b-192539be165a	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	\N
e887762d-227f-4544-a98a-fb2f3be129a6	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	t	${role_query-realms}	query-realms	4462ad8a-9bc0-49aa-887b-192539be165a	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	\N
1759e0a1-e4f9-4f84-a1c0-52d04b99a139	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	t	${role_query-groups}	query-groups	4462ad8a-9bc0-49aa-887b-192539be165a	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	\N
86ea2c5e-25fd-43c8-8603-bdf1e53337e8	52437f02-f7d1-44af-982b-11824e320acd	t	${role_realm-admin}	realm-admin	f7426fe0-9b39-4eb4-8348-4780b68b86b4	52437f02-f7d1-44af-982b-11824e320acd	\N
91bad962-abce-4123-bb9c-4db4c93fb2b5	52437f02-f7d1-44af-982b-11824e320acd	t	${role_create-client}	create-client	f7426fe0-9b39-4eb4-8348-4780b68b86b4	52437f02-f7d1-44af-982b-11824e320acd	\N
75bad138-a0ac-46ca-90ca-46d97ef8cc71	52437f02-f7d1-44af-982b-11824e320acd	t	${role_view-realm}	view-realm	f7426fe0-9b39-4eb4-8348-4780b68b86b4	52437f02-f7d1-44af-982b-11824e320acd	\N
a7dbc9db-d835-4c00-bb4c-2181a3512f34	52437f02-f7d1-44af-982b-11824e320acd	t	${role_view-users}	view-users	f7426fe0-9b39-4eb4-8348-4780b68b86b4	52437f02-f7d1-44af-982b-11824e320acd	\N
03bb8506-ac51-4d91-898a-d61d0532bbdc	52437f02-f7d1-44af-982b-11824e320acd	t	${role_view-clients}	view-clients	f7426fe0-9b39-4eb4-8348-4780b68b86b4	52437f02-f7d1-44af-982b-11824e320acd	\N
12ba6c61-7c9a-4854-852d-09e4daa5ec74	52437f02-f7d1-44af-982b-11824e320acd	t	${role_view-events}	view-events	f7426fe0-9b39-4eb4-8348-4780b68b86b4	52437f02-f7d1-44af-982b-11824e320acd	\N
dc690927-39a2-4a70-ab48-b93958b2947c	52437f02-f7d1-44af-982b-11824e320acd	t	${role_view-identity-providers}	view-identity-providers	f7426fe0-9b39-4eb4-8348-4780b68b86b4	52437f02-f7d1-44af-982b-11824e320acd	\N
7daa6c0c-76b0-45fe-8b39-96d4d5b736a7	52437f02-f7d1-44af-982b-11824e320acd	t	${role_view-authorization}	view-authorization	f7426fe0-9b39-4eb4-8348-4780b68b86b4	52437f02-f7d1-44af-982b-11824e320acd	\N
f4fded31-fe8d-43c0-8289-edc8fd181378	52437f02-f7d1-44af-982b-11824e320acd	t	${role_manage-realm}	manage-realm	f7426fe0-9b39-4eb4-8348-4780b68b86b4	52437f02-f7d1-44af-982b-11824e320acd	\N
1b3d5c94-0ebf-47fe-90a0-b6f09e7499de	52437f02-f7d1-44af-982b-11824e320acd	t	${role_manage-users}	manage-users	f7426fe0-9b39-4eb4-8348-4780b68b86b4	52437f02-f7d1-44af-982b-11824e320acd	\N
1796cf9a-a279-4117-b8aa-e0c792a7ff44	52437f02-f7d1-44af-982b-11824e320acd	t	${role_manage-clients}	manage-clients	f7426fe0-9b39-4eb4-8348-4780b68b86b4	52437f02-f7d1-44af-982b-11824e320acd	\N
4adf7651-a773-4e2e-89be-5a46dfc75475	52437f02-f7d1-44af-982b-11824e320acd	t	${role_manage-events}	manage-events	f7426fe0-9b39-4eb4-8348-4780b68b86b4	52437f02-f7d1-44af-982b-11824e320acd	\N
029580e4-41e2-4bd8-8a0d-8be742f1d83d	52437f02-f7d1-44af-982b-11824e320acd	t	${role_manage-identity-providers}	manage-identity-providers	f7426fe0-9b39-4eb4-8348-4780b68b86b4	52437f02-f7d1-44af-982b-11824e320acd	\N
68b5cd97-70df-4142-a2c5-b9230f73bac5	52437f02-f7d1-44af-982b-11824e320acd	t	${role_manage-authorization}	manage-authorization	f7426fe0-9b39-4eb4-8348-4780b68b86b4	52437f02-f7d1-44af-982b-11824e320acd	\N
7be43ac4-a4b5-470c-96f4-9d56c1118bd1	52437f02-f7d1-44af-982b-11824e320acd	t	${role_query-users}	query-users	f7426fe0-9b39-4eb4-8348-4780b68b86b4	52437f02-f7d1-44af-982b-11824e320acd	\N
38250e8e-e305-4dae-b2a4-3797bc955a71	52437f02-f7d1-44af-982b-11824e320acd	t	${role_query-clients}	query-clients	f7426fe0-9b39-4eb4-8348-4780b68b86b4	52437f02-f7d1-44af-982b-11824e320acd	\N
38b4b795-c971-472d-97fb-8f1d5c5cbd1e	52437f02-f7d1-44af-982b-11824e320acd	t	${role_query-realms}	query-realms	f7426fe0-9b39-4eb4-8348-4780b68b86b4	52437f02-f7d1-44af-982b-11824e320acd	\N
64d12247-206c-400b-b0da-d10893c0b1c6	52437f02-f7d1-44af-982b-11824e320acd	t	${role_query-groups}	query-groups	f7426fe0-9b39-4eb4-8348-4780b68b86b4	52437f02-f7d1-44af-982b-11824e320acd	\N
8915adbd-344b-4682-8b47-195b318e9ce0	1bdcd8b0-67c0-4b8f-9e68-120030586995	t	${role_view-profile}	view-profile	f7426fe0-9b39-4eb4-8348-4780b68b86b4	1bdcd8b0-67c0-4b8f-9e68-120030586995	\N
8582ebab-88c2-4b8b-889b-f8c6878a276d	1bdcd8b0-67c0-4b8f-9e68-120030586995	t	${role_manage-account}	manage-account	f7426fe0-9b39-4eb4-8348-4780b68b86b4	1bdcd8b0-67c0-4b8f-9e68-120030586995	\N
2fa93b36-3727-49e9-8f2a-ea3acdde9fcd	1bdcd8b0-67c0-4b8f-9e68-120030586995	t	${role_manage-account-links}	manage-account-links	f7426fe0-9b39-4eb4-8348-4780b68b86b4	1bdcd8b0-67c0-4b8f-9e68-120030586995	\N
dbbce971-8efa-40e4-9c35-87a5ffac40fc	1bdcd8b0-67c0-4b8f-9e68-120030586995	t	${role_view-applications}	view-applications	f7426fe0-9b39-4eb4-8348-4780b68b86b4	1bdcd8b0-67c0-4b8f-9e68-120030586995	\N
6850313e-33ba-4b0d-95fb-64d4bc65c139	1bdcd8b0-67c0-4b8f-9e68-120030586995	t	${role_view-consent}	view-consent	f7426fe0-9b39-4eb4-8348-4780b68b86b4	1bdcd8b0-67c0-4b8f-9e68-120030586995	\N
8540586e-5b88-46a7-be99-e00fd9eb1def	1bdcd8b0-67c0-4b8f-9e68-120030586995	t	${role_manage-consent}	manage-consent	f7426fe0-9b39-4eb4-8348-4780b68b86b4	1bdcd8b0-67c0-4b8f-9e68-120030586995	\N
e6131746-c424-48c8-9e59-91adad005725	1bdcd8b0-67c0-4b8f-9e68-120030586995	t	${role_view-groups}	view-groups	f7426fe0-9b39-4eb4-8348-4780b68b86b4	1bdcd8b0-67c0-4b8f-9e68-120030586995	\N
21182a8f-9b26-40b4-8946-d50cdd927b39	1bdcd8b0-67c0-4b8f-9e68-120030586995	t	${role_delete-account}	delete-account	f7426fe0-9b39-4eb4-8348-4780b68b86b4	1bdcd8b0-67c0-4b8f-9e68-120030586995	\N
4e16f673-4e6a-43c7-82f7-b2b327a05551	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	t	${role_impersonation}	impersonation	4462ad8a-9bc0-49aa-887b-192539be165a	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	\N
dc4e49c1-caa6-450c-8a0a-7613d795aeaa	52437f02-f7d1-44af-982b-11824e320acd	t	${role_impersonation}	impersonation	f7426fe0-9b39-4eb4-8348-4780b68b86b4	52437f02-f7d1-44af-982b-11824e320acd	\N
79235d1a-ca95-40f5-91c5-a0ea54f0e50a	5d2b0d93-b6ba-4005-b767-88368baffd2b	t	${role_read-token}	read-token	f7426fe0-9b39-4eb4-8348-4780b68b86b4	5d2b0d93-b6ba-4005-b767-88368baffd2b	\N
28c76a2f-8561-4468-9e4a-88f621dc5707	f7426fe0-9b39-4eb4-8348-4780b68b86b4	f	${role_offline-access}	offline_access	f7426fe0-9b39-4eb4-8348-4780b68b86b4	\N	\N
b525ebbb-66dd-4a24-9dbb-8222557fa5c2	f7426fe0-9b39-4eb4-8348-4780b68b86b4	f	${role_uma_authorization}	uma_authorization	f7426fe0-9b39-4eb4-8348-4780b68b86b4	\N	\N
8a5917e3-d73e-48cd-96e4-91031dd715b0	69f64c80-4877-479f-a3be-498c4f49e75c	t	\N	uma_protection	f7426fe0-9b39-4eb4-8348-4780b68b86b4	69f64c80-4877-479f-a3be-498c4f49e75c	\N
44120ffd-88bd-464e-8475-0bae0c003857	f7426fe0-9b39-4eb4-8348-4780b68b86b4	f		rest-client	f7426fe0-9b39-4eb4-8348-4780b68b86b4	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.migration_model (id, version, update_time) FROM stdin;
9sly0	20.0.1	1668687062
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
fc37b30e-a645-4ef7-9080-29f81549adfa	code	// by default, grants any permission associated with this policy\n$evaluation.grant();\n
67ae94d1-9d81-42d3-a2c3-72b784ecbbc2	defaultResourceType	urn:internal-services:resources:default
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
92ed4161-d2a7-4396-8b65-9d49bdeeba1d	audience resolve	openid-connect	oidc-audience-resolve-mapper	5c046893-b83c-43bf-8110-173c406767c4	\N
c969cd3c-b25a-423e-8de4-ef665e9b1b05	locale	openid-connect	oidc-usermodel-attribute-mapper	203c77ab-5b84-4cac-8982-a883bc321474	\N
17bb47f1-9696-43ef-b754-503a178c916c	role list	saml	saml-role-list-mapper	\N	4110c314-fe82-4c21-a123-d4c6ef210ce2
81881d24-6728-4002-b3d6-9f2b9a9b7fd0	full name	openid-connect	oidc-full-name-mapper	\N	591ce7f3-b89b-4ecd-97dd-1efb04efdb4a
ab483e59-c10e-4848-97dd-52af7c7327da	family name	openid-connect	oidc-usermodel-property-mapper	\N	591ce7f3-b89b-4ecd-97dd-1efb04efdb4a
e0b36400-4e1b-47e8-bca1-33e85989cde4	given name	openid-connect	oidc-usermodel-property-mapper	\N	591ce7f3-b89b-4ecd-97dd-1efb04efdb4a
c2c1ef8a-50c3-447b-9770-4a7c6b3a1f83	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	591ce7f3-b89b-4ecd-97dd-1efb04efdb4a
814a6196-95b6-471d-899c-084d16c18b92	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	591ce7f3-b89b-4ecd-97dd-1efb04efdb4a
bc12128f-842d-4b19-b21a-41b65de0a59e	username	openid-connect	oidc-usermodel-property-mapper	\N	591ce7f3-b89b-4ecd-97dd-1efb04efdb4a
0635b0b5-1f77-4b20-888c-97da2d901d6d	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	591ce7f3-b89b-4ecd-97dd-1efb04efdb4a
f5a29b23-d1ff-400f-99e8-b03cbe8d4150	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	591ce7f3-b89b-4ecd-97dd-1efb04efdb4a
c2e70e9a-2696-4b40-b170-af52b9b2e751	website	openid-connect	oidc-usermodel-attribute-mapper	\N	591ce7f3-b89b-4ecd-97dd-1efb04efdb4a
9cf50b5e-d4f9-4b03-af17-85df17f878a6	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	591ce7f3-b89b-4ecd-97dd-1efb04efdb4a
6389a562-b842-4822-9341-d01e08fce515	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	591ce7f3-b89b-4ecd-97dd-1efb04efdb4a
a606aa66-895d-4b3e-85f7-b55d3ea5ea6b	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	591ce7f3-b89b-4ecd-97dd-1efb04efdb4a
c6952196-d7ca-422b-a254-66ea4395cf3f	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	591ce7f3-b89b-4ecd-97dd-1efb04efdb4a
413c373b-a9d5-4809-93a0-f6410b09a41d	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	591ce7f3-b89b-4ecd-97dd-1efb04efdb4a
1ebd1460-a66d-4197-a421-de9ab7a12754	email	openid-connect	oidc-usermodel-property-mapper	\N	ed05201b-4177-4382-8889-618388b9195f
d7b1a567-51d4-4b20-adf7-9332a8f2d6e3	email verified	openid-connect	oidc-usermodel-property-mapper	\N	ed05201b-4177-4382-8889-618388b9195f
497018ab-f866-446d-9235-355e6a1ec4f8	address	openid-connect	oidc-address-mapper	\N	7ee53d12-f869-4eed-82ee-0db60375e9e6
c838e81f-ee57-48bb-bdd8-6c6497d5c4eb	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	383293f8-eac1-4577-96fe-7784940368a8
9b7c4f8d-8fa9-43b7-817a-381060e13f53	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	383293f8-eac1-4577-96fe-7784940368a8
89be244e-2014-48dd-8d4f-c2c8c9f33b9c	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	8cc9fff2-98e9-4ac4-a745-a3df6736b036
7f93eb46-87c0-4b54-b5d6-2f5873eb7481	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	8cc9fff2-98e9-4ac4-a745-a3df6736b036
4941be72-c3e8-4de0-a4cd-bd6973876e02	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	8cc9fff2-98e9-4ac4-a745-a3df6736b036
de32f5a6-d2c1-4dbc-91cd-2b7847d61e20	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	7d58c395-3289-48fd-a104-7f8b6594f64f
145849d4-56f9-4c1c-bbdd-1d18e686e683	upn	openid-connect	oidc-usermodel-property-mapper	\N	b4706d7f-9173-4653-800f-2b54c6b2a81c
5eca59c2-d775-478f-993b-a9d24b826fd4	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	b4706d7f-9173-4653-800f-2b54c6b2a81c
7f6b3832-c365-45e0-8b6a-75d45d669f49	acr loa level	openid-connect	oidc-acr-mapper	\N	48890c47-f1ed-4e99-8cd1-a564779a95f1
b93847c4-f548-4243-9584-5676cb9b0946	audience resolve	openid-connect	oidc-audience-resolve-mapper	c345fa1c-a51c-42cc-bae3-a27f78070f4d	\N
5717ae94-71bd-4a63-b6d2-a8ea0ff6ee92	role list	saml	saml-role-list-mapper	\N	c6eb7a7d-4332-4ddd-ad57-b778e9b271c2
94d5e1fb-2160-4f44-b12e-c9e0f190a69e	full name	openid-connect	oidc-full-name-mapper	\N	40b52045-c184-4158-9ed0-130d19f5f04b
62482555-1388-4fcb-8d07-13d6b186ec9b	family name	openid-connect	oidc-usermodel-property-mapper	\N	40b52045-c184-4158-9ed0-130d19f5f04b
a0d389b5-eff0-4986-a996-5e36be87a4e8	given name	openid-connect	oidc-usermodel-property-mapper	\N	40b52045-c184-4158-9ed0-130d19f5f04b
af4b0b2d-3071-4cb8-858a-ef44a87e0fe6	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	40b52045-c184-4158-9ed0-130d19f5f04b
01a5137f-52b5-42f1-bd6e-91e9132fcacb	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	40b52045-c184-4158-9ed0-130d19f5f04b
b5a43b00-86a9-4889-958e-b5e6964038bb	username	openid-connect	oidc-usermodel-property-mapper	\N	40b52045-c184-4158-9ed0-130d19f5f04b
f8804fca-46b5-44ac-84f4-613bcf4e5912	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	40b52045-c184-4158-9ed0-130d19f5f04b
c6028fb1-7f47-4997-91f2-870a18432c15	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	40b52045-c184-4158-9ed0-130d19f5f04b
423a5f20-5f1d-4ff7-88ca-20d3094b53e8	website	openid-connect	oidc-usermodel-attribute-mapper	\N	40b52045-c184-4158-9ed0-130d19f5f04b
b467db89-5654-47b1-a675-8af09c6fdb5a	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	40b52045-c184-4158-9ed0-130d19f5f04b
a252dc3e-edd3-4302-8f5a-cb3d048bd2b8	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	40b52045-c184-4158-9ed0-130d19f5f04b
2492e2ce-bf0d-4113-b70e-7762db5ddf3d	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	40b52045-c184-4158-9ed0-130d19f5f04b
fa3bb08e-cccc-49b0-85a7-fc49a483bda0	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	40b52045-c184-4158-9ed0-130d19f5f04b
9a2c610b-61c4-4a74-aa4f-1f8a1653acf6	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	40b52045-c184-4158-9ed0-130d19f5f04b
ac8eff71-58df-4fc8-9b3e-111aeec4a97a	email	openid-connect	oidc-usermodel-property-mapper	\N	2417ad88-e18f-4952-a889-d1707a2fb20d
ea1eede2-5961-439f-ae81-58bb3c25544a	email verified	openid-connect	oidc-usermodel-property-mapper	\N	2417ad88-e18f-4952-a889-d1707a2fb20d
59f0e8bd-19e2-44a4-8cd3-c2b2aecf9d29	address	openid-connect	oidc-address-mapper	\N	d897f308-bb7d-4b3a-a98e-49ea33c6f6d5
3eeabe7f-d86f-49fc-8d74-2891e9bb1892	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	d791a902-ec8c-4464-824e-d3d9e03788f0
1428d008-3a23-4359-9a58-56b695dbecf5	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	d791a902-ec8c-4464-824e-d3d9e03788f0
4126c632-781b-4281-bbb2-15715633eaf8	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	fd323536-a66b-4cba-8b98-94cf53bb67ca
d3c545ca-a39b-4807-bba7-82e8a72909f8	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	fd323536-a66b-4cba-8b98-94cf53bb67ca
8e6ac9f8-be4a-4f67-8f23-d67354f3cec3	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	fd323536-a66b-4cba-8b98-94cf53bb67ca
dba82bca-0388-4f92-b0bd-0b6456782449	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	4725e6b7-9327-4e4e-a895-573d5a475540
4e8d9cc6-57da-4a0b-b7dc-a696d1492891	upn	openid-connect	oidc-usermodel-property-mapper	\N	b18f4355-9385-477d-b4fa-cea6b9a763f1
0269483b-c269-4420-9453-f5c0d8b9aab4	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	b18f4355-9385-477d-b4fa-cea6b9a763f1
09d9bb83-0070-4d23-8f02-ed9c810c1c8d	acr loa level	openid-connect	oidc-acr-mapper	\N	6e16b37f-968c-4527-806a-3031b0dd63ba
0587f5b3-5f79-44f4-a7f6-c8710d517465	locale	openid-connect	oidc-usermodel-attribute-mapper	d8c943ac-ce3b-4594-b705-17159fbb50be	\N
adbfa08d-15cb-41de-a47a-0e5742563a03	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	69f64c80-4877-479f-a3be-498c4f49e75c	\N
c24f6da7-9272-4471-9487-0871203a39b3	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	69f64c80-4877-479f-a3be-498c4f49e75c	\N
d7c2cd43-eeab-4821-ab6d-50b5fccba664	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	69f64c80-4877-479f-a3be-498c4f49e75c	\N
bf1889be-b5d7-46dc-be5b-423a8fede322	rest-clinet-realm-role	openid-connect	oidc-usermodel-realm-role-mapper	\N	f55cfb1f-4521-4c61-b6fc-0859d18aea44
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
c969cd3c-b25a-423e-8de4-ef665e9b1b05	true	userinfo.token.claim
c969cd3c-b25a-423e-8de4-ef665e9b1b05	locale	user.attribute
c969cd3c-b25a-423e-8de4-ef665e9b1b05	true	id.token.claim
c969cd3c-b25a-423e-8de4-ef665e9b1b05	true	access.token.claim
c969cd3c-b25a-423e-8de4-ef665e9b1b05	locale	claim.name
c969cd3c-b25a-423e-8de4-ef665e9b1b05	String	jsonType.label
17bb47f1-9696-43ef-b754-503a178c916c	false	single
17bb47f1-9696-43ef-b754-503a178c916c	Basic	attribute.nameformat
17bb47f1-9696-43ef-b754-503a178c916c	Role	attribute.name
0635b0b5-1f77-4b20-888c-97da2d901d6d	true	userinfo.token.claim
0635b0b5-1f77-4b20-888c-97da2d901d6d	profile	user.attribute
0635b0b5-1f77-4b20-888c-97da2d901d6d	true	id.token.claim
0635b0b5-1f77-4b20-888c-97da2d901d6d	true	access.token.claim
0635b0b5-1f77-4b20-888c-97da2d901d6d	profile	claim.name
0635b0b5-1f77-4b20-888c-97da2d901d6d	String	jsonType.label
413c373b-a9d5-4809-93a0-f6410b09a41d	true	userinfo.token.claim
413c373b-a9d5-4809-93a0-f6410b09a41d	updatedAt	user.attribute
413c373b-a9d5-4809-93a0-f6410b09a41d	true	id.token.claim
413c373b-a9d5-4809-93a0-f6410b09a41d	true	access.token.claim
413c373b-a9d5-4809-93a0-f6410b09a41d	updated_at	claim.name
413c373b-a9d5-4809-93a0-f6410b09a41d	long	jsonType.label
6389a562-b842-4822-9341-d01e08fce515	true	userinfo.token.claim
6389a562-b842-4822-9341-d01e08fce515	birthdate	user.attribute
6389a562-b842-4822-9341-d01e08fce515	true	id.token.claim
6389a562-b842-4822-9341-d01e08fce515	true	access.token.claim
6389a562-b842-4822-9341-d01e08fce515	birthdate	claim.name
6389a562-b842-4822-9341-d01e08fce515	String	jsonType.label
814a6196-95b6-471d-899c-084d16c18b92	true	userinfo.token.claim
814a6196-95b6-471d-899c-084d16c18b92	nickname	user.attribute
814a6196-95b6-471d-899c-084d16c18b92	true	id.token.claim
814a6196-95b6-471d-899c-084d16c18b92	true	access.token.claim
814a6196-95b6-471d-899c-084d16c18b92	nickname	claim.name
814a6196-95b6-471d-899c-084d16c18b92	String	jsonType.label
81881d24-6728-4002-b3d6-9f2b9a9b7fd0	true	userinfo.token.claim
81881d24-6728-4002-b3d6-9f2b9a9b7fd0	true	id.token.claim
81881d24-6728-4002-b3d6-9f2b9a9b7fd0	true	access.token.claim
9cf50b5e-d4f9-4b03-af17-85df17f878a6	true	userinfo.token.claim
9cf50b5e-d4f9-4b03-af17-85df17f878a6	gender	user.attribute
9cf50b5e-d4f9-4b03-af17-85df17f878a6	true	id.token.claim
9cf50b5e-d4f9-4b03-af17-85df17f878a6	true	access.token.claim
9cf50b5e-d4f9-4b03-af17-85df17f878a6	gender	claim.name
9cf50b5e-d4f9-4b03-af17-85df17f878a6	String	jsonType.label
a606aa66-895d-4b3e-85f7-b55d3ea5ea6b	true	userinfo.token.claim
a606aa66-895d-4b3e-85f7-b55d3ea5ea6b	zoneinfo	user.attribute
a606aa66-895d-4b3e-85f7-b55d3ea5ea6b	true	id.token.claim
a606aa66-895d-4b3e-85f7-b55d3ea5ea6b	true	access.token.claim
a606aa66-895d-4b3e-85f7-b55d3ea5ea6b	zoneinfo	claim.name
a606aa66-895d-4b3e-85f7-b55d3ea5ea6b	String	jsonType.label
ab483e59-c10e-4848-97dd-52af7c7327da	true	userinfo.token.claim
ab483e59-c10e-4848-97dd-52af7c7327da	lastName	user.attribute
ab483e59-c10e-4848-97dd-52af7c7327da	true	id.token.claim
ab483e59-c10e-4848-97dd-52af7c7327da	true	access.token.claim
ab483e59-c10e-4848-97dd-52af7c7327da	family_name	claim.name
ab483e59-c10e-4848-97dd-52af7c7327da	String	jsonType.label
bc12128f-842d-4b19-b21a-41b65de0a59e	true	userinfo.token.claim
bc12128f-842d-4b19-b21a-41b65de0a59e	username	user.attribute
bc12128f-842d-4b19-b21a-41b65de0a59e	true	id.token.claim
bc12128f-842d-4b19-b21a-41b65de0a59e	true	access.token.claim
bc12128f-842d-4b19-b21a-41b65de0a59e	preferred_username	claim.name
bc12128f-842d-4b19-b21a-41b65de0a59e	String	jsonType.label
c2c1ef8a-50c3-447b-9770-4a7c6b3a1f83	true	userinfo.token.claim
c2c1ef8a-50c3-447b-9770-4a7c6b3a1f83	middleName	user.attribute
c2c1ef8a-50c3-447b-9770-4a7c6b3a1f83	true	id.token.claim
c2c1ef8a-50c3-447b-9770-4a7c6b3a1f83	true	access.token.claim
c2c1ef8a-50c3-447b-9770-4a7c6b3a1f83	middle_name	claim.name
c2c1ef8a-50c3-447b-9770-4a7c6b3a1f83	String	jsonType.label
c2e70e9a-2696-4b40-b170-af52b9b2e751	true	userinfo.token.claim
c2e70e9a-2696-4b40-b170-af52b9b2e751	website	user.attribute
c2e70e9a-2696-4b40-b170-af52b9b2e751	true	id.token.claim
c2e70e9a-2696-4b40-b170-af52b9b2e751	true	access.token.claim
c2e70e9a-2696-4b40-b170-af52b9b2e751	website	claim.name
c2e70e9a-2696-4b40-b170-af52b9b2e751	String	jsonType.label
c6952196-d7ca-422b-a254-66ea4395cf3f	true	userinfo.token.claim
c6952196-d7ca-422b-a254-66ea4395cf3f	locale	user.attribute
c6952196-d7ca-422b-a254-66ea4395cf3f	true	id.token.claim
c6952196-d7ca-422b-a254-66ea4395cf3f	true	access.token.claim
c6952196-d7ca-422b-a254-66ea4395cf3f	locale	claim.name
c6952196-d7ca-422b-a254-66ea4395cf3f	String	jsonType.label
e0b36400-4e1b-47e8-bca1-33e85989cde4	true	userinfo.token.claim
e0b36400-4e1b-47e8-bca1-33e85989cde4	firstName	user.attribute
e0b36400-4e1b-47e8-bca1-33e85989cde4	true	id.token.claim
e0b36400-4e1b-47e8-bca1-33e85989cde4	true	access.token.claim
e0b36400-4e1b-47e8-bca1-33e85989cde4	given_name	claim.name
e0b36400-4e1b-47e8-bca1-33e85989cde4	String	jsonType.label
f5a29b23-d1ff-400f-99e8-b03cbe8d4150	true	userinfo.token.claim
f5a29b23-d1ff-400f-99e8-b03cbe8d4150	picture	user.attribute
f5a29b23-d1ff-400f-99e8-b03cbe8d4150	true	id.token.claim
f5a29b23-d1ff-400f-99e8-b03cbe8d4150	true	access.token.claim
f5a29b23-d1ff-400f-99e8-b03cbe8d4150	picture	claim.name
f5a29b23-d1ff-400f-99e8-b03cbe8d4150	String	jsonType.label
1ebd1460-a66d-4197-a421-de9ab7a12754	true	userinfo.token.claim
1ebd1460-a66d-4197-a421-de9ab7a12754	email	user.attribute
1ebd1460-a66d-4197-a421-de9ab7a12754	true	id.token.claim
1ebd1460-a66d-4197-a421-de9ab7a12754	true	access.token.claim
1ebd1460-a66d-4197-a421-de9ab7a12754	email	claim.name
1ebd1460-a66d-4197-a421-de9ab7a12754	String	jsonType.label
d7b1a567-51d4-4b20-adf7-9332a8f2d6e3	true	userinfo.token.claim
d7b1a567-51d4-4b20-adf7-9332a8f2d6e3	emailVerified	user.attribute
d7b1a567-51d4-4b20-adf7-9332a8f2d6e3	true	id.token.claim
d7b1a567-51d4-4b20-adf7-9332a8f2d6e3	true	access.token.claim
d7b1a567-51d4-4b20-adf7-9332a8f2d6e3	email_verified	claim.name
d7b1a567-51d4-4b20-adf7-9332a8f2d6e3	boolean	jsonType.label
497018ab-f866-446d-9235-355e6a1ec4f8	formatted	user.attribute.formatted
497018ab-f866-446d-9235-355e6a1ec4f8	country	user.attribute.country
497018ab-f866-446d-9235-355e6a1ec4f8	postal_code	user.attribute.postal_code
497018ab-f866-446d-9235-355e6a1ec4f8	true	userinfo.token.claim
497018ab-f866-446d-9235-355e6a1ec4f8	street	user.attribute.street
497018ab-f866-446d-9235-355e6a1ec4f8	true	id.token.claim
497018ab-f866-446d-9235-355e6a1ec4f8	region	user.attribute.region
497018ab-f866-446d-9235-355e6a1ec4f8	true	access.token.claim
497018ab-f866-446d-9235-355e6a1ec4f8	locality	user.attribute.locality
9b7c4f8d-8fa9-43b7-817a-381060e13f53	true	userinfo.token.claim
9b7c4f8d-8fa9-43b7-817a-381060e13f53	phoneNumberVerified	user.attribute
9b7c4f8d-8fa9-43b7-817a-381060e13f53	true	id.token.claim
9b7c4f8d-8fa9-43b7-817a-381060e13f53	true	access.token.claim
9b7c4f8d-8fa9-43b7-817a-381060e13f53	phone_number_verified	claim.name
9b7c4f8d-8fa9-43b7-817a-381060e13f53	boolean	jsonType.label
c838e81f-ee57-48bb-bdd8-6c6497d5c4eb	true	userinfo.token.claim
c838e81f-ee57-48bb-bdd8-6c6497d5c4eb	phoneNumber	user.attribute
c838e81f-ee57-48bb-bdd8-6c6497d5c4eb	true	id.token.claim
c838e81f-ee57-48bb-bdd8-6c6497d5c4eb	true	access.token.claim
c838e81f-ee57-48bb-bdd8-6c6497d5c4eb	phone_number	claim.name
c838e81f-ee57-48bb-bdd8-6c6497d5c4eb	String	jsonType.label
7f93eb46-87c0-4b54-b5d6-2f5873eb7481	true	multivalued
7f93eb46-87c0-4b54-b5d6-2f5873eb7481	foo	user.attribute
7f93eb46-87c0-4b54-b5d6-2f5873eb7481	true	access.token.claim
7f93eb46-87c0-4b54-b5d6-2f5873eb7481	resource_access.${client_id}.roles	claim.name
7f93eb46-87c0-4b54-b5d6-2f5873eb7481	String	jsonType.label
89be244e-2014-48dd-8d4f-c2c8c9f33b9c	true	multivalued
89be244e-2014-48dd-8d4f-c2c8c9f33b9c	foo	user.attribute
89be244e-2014-48dd-8d4f-c2c8c9f33b9c	true	access.token.claim
89be244e-2014-48dd-8d4f-c2c8c9f33b9c	realm_access.roles	claim.name
89be244e-2014-48dd-8d4f-c2c8c9f33b9c	String	jsonType.label
145849d4-56f9-4c1c-bbdd-1d18e686e683	true	userinfo.token.claim
145849d4-56f9-4c1c-bbdd-1d18e686e683	username	user.attribute
145849d4-56f9-4c1c-bbdd-1d18e686e683	true	id.token.claim
145849d4-56f9-4c1c-bbdd-1d18e686e683	true	access.token.claim
145849d4-56f9-4c1c-bbdd-1d18e686e683	upn	claim.name
145849d4-56f9-4c1c-bbdd-1d18e686e683	String	jsonType.label
5eca59c2-d775-478f-993b-a9d24b826fd4	true	multivalued
5eca59c2-d775-478f-993b-a9d24b826fd4	foo	user.attribute
5eca59c2-d775-478f-993b-a9d24b826fd4	true	id.token.claim
5eca59c2-d775-478f-993b-a9d24b826fd4	true	access.token.claim
5eca59c2-d775-478f-993b-a9d24b826fd4	groups	claim.name
5eca59c2-d775-478f-993b-a9d24b826fd4	String	jsonType.label
7f6b3832-c365-45e0-8b6a-75d45d669f49	true	id.token.claim
7f6b3832-c365-45e0-8b6a-75d45d669f49	true	access.token.claim
5717ae94-71bd-4a63-b6d2-a8ea0ff6ee92	false	single
5717ae94-71bd-4a63-b6d2-a8ea0ff6ee92	Basic	attribute.nameformat
5717ae94-71bd-4a63-b6d2-a8ea0ff6ee92	Role	attribute.name
01a5137f-52b5-42f1-bd6e-91e9132fcacb	true	userinfo.token.claim
01a5137f-52b5-42f1-bd6e-91e9132fcacb	nickname	user.attribute
01a5137f-52b5-42f1-bd6e-91e9132fcacb	true	id.token.claim
01a5137f-52b5-42f1-bd6e-91e9132fcacb	true	access.token.claim
01a5137f-52b5-42f1-bd6e-91e9132fcacb	nickname	claim.name
01a5137f-52b5-42f1-bd6e-91e9132fcacb	String	jsonType.label
2492e2ce-bf0d-4113-b70e-7762db5ddf3d	true	userinfo.token.claim
2492e2ce-bf0d-4113-b70e-7762db5ddf3d	zoneinfo	user.attribute
2492e2ce-bf0d-4113-b70e-7762db5ddf3d	true	id.token.claim
2492e2ce-bf0d-4113-b70e-7762db5ddf3d	true	access.token.claim
2492e2ce-bf0d-4113-b70e-7762db5ddf3d	zoneinfo	claim.name
2492e2ce-bf0d-4113-b70e-7762db5ddf3d	String	jsonType.label
423a5f20-5f1d-4ff7-88ca-20d3094b53e8	true	userinfo.token.claim
423a5f20-5f1d-4ff7-88ca-20d3094b53e8	website	user.attribute
423a5f20-5f1d-4ff7-88ca-20d3094b53e8	true	id.token.claim
423a5f20-5f1d-4ff7-88ca-20d3094b53e8	true	access.token.claim
423a5f20-5f1d-4ff7-88ca-20d3094b53e8	website	claim.name
423a5f20-5f1d-4ff7-88ca-20d3094b53e8	String	jsonType.label
62482555-1388-4fcb-8d07-13d6b186ec9b	true	userinfo.token.claim
62482555-1388-4fcb-8d07-13d6b186ec9b	lastName	user.attribute
62482555-1388-4fcb-8d07-13d6b186ec9b	true	id.token.claim
62482555-1388-4fcb-8d07-13d6b186ec9b	true	access.token.claim
62482555-1388-4fcb-8d07-13d6b186ec9b	family_name	claim.name
62482555-1388-4fcb-8d07-13d6b186ec9b	String	jsonType.label
94d5e1fb-2160-4f44-b12e-c9e0f190a69e	true	userinfo.token.claim
94d5e1fb-2160-4f44-b12e-c9e0f190a69e	true	id.token.claim
94d5e1fb-2160-4f44-b12e-c9e0f190a69e	true	access.token.claim
9a2c610b-61c4-4a74-aa4f-1f8a1653acf6	true	userinfo.token.claim
9a2c610b-61c4-4a74-aa4f-1f8a1653acf6	updatedAt	user.attribute
9a2c610b-61c4-4a74-aa4f-1f8a1653acf6	true	id.token.claim
9a2c610b-61c4-4a74-aa4f-1f8a1653acf6	true	access.token.claim
9a2c610b-61c4-4a74-aa4f-1f8a1653acf6	updated_at	claim.name
9a2c610b-61c4-4a74-aa4f-1f8a1653acf6	long	jsonType.label
a0d389b5-eff0-4986-a996-5e36be87a4e8	true	userinfo.token.claim
a0d389b5-eff0-4986-a996-5e36be87a4e8	firstName	user.attribute
a0d389b5-eff0-4986-a996-5e36be87a4e8	true	id.token.claim
a0d389b5-eff0-4986-a996-5e36be87a4e8	true	access.token.claim
a0d389b5-eff0-4986-a996-5e36be87a4e8	given_name	claim.name
a0d389b5-eff0-4986-a996-5e36be87a4e8	String	jsonType.label
a252dc3e-edd3-4302-8f5a-cb3d048bd2b8	true	userinfo.token.claim
a252dc3e-edd3-4302-8f5a-cb3d048bd2b8	birthdate	user.attribute
a252dc3e-edd3-4302-8f5a-cb3d048bd2b8	true	id.token.claim
a252dc3e-edd3-4302-8f5a-cb3d048bd2b8	true	access.token.claim
a252dc3e-edd3-4302-8f5a-cb3d048bd2b8	birthdate	claim.name
a252dc3e-edd3-4302-8f5a-cb3d048bd2b8	String	jsonType.label
af4b0b2d-3071-4cb8-858a-ef44a87e0fe6	true	userinfo.token.claim
af4b0b2d-3071-4cb8-858a-ef44a87e0fe6	middleName	user.attribute
af4b0b2d-3071-4cb8-858a-ef44a87e0fe6	true	id.token.claim
af4b0b2d-3071-4cb8-858a-ef44a87e0fe6	true	access.token.claim
af4b0b2d-3071-4cb8-858a-ef44a87e0fe6	middle_name	claim.name
af4b0b2d-3071-4cb8-858a-ef44a87e0fe6	String	jsonType.label
b467db89-5654-47b1-a675-8af09c6fdb5a	true	userinfo.token.claim
b467db89-5654-47b1-a675-8af09c6fdb5a	gender	user.attribute
b467db89-5654-47b1-a675-8af09c6fdb5a	true	id.token.claim
b467db89-5654-47b1-a675-8af09c6fdb5a	true	access.token.claim
b467db89-5654-47b1-a675-8af09c6fdb5a	gender	claim.name
b467db89-5654-47b1-a675-8af09c6fdb5a	String	jsonType.label
b5a43b00-86a9-4889-958e-b5e6964038bb	true	userinfo.token.claim
b5a43b00-86a9-4889-958e-b5e6964038bb	username	user.attribute
b5a43b00-86a9-4889-958e-b5e6964038bb	true	id.token.claim
b5a43b00-86a9-4889-958e-b5e6964038bb	true	access.token.claim
b5a43b00-86a9-4889-958e-b5e6964038bb	preferred_username	claim.name
b5a43b00-86a9-4889-958e-b5e6964038bb	String	jsonType.label
c6028fb1-7f47-4997-91f2-870a18432c15	true	userinfo.token.claim
c6028fb1-7f47-4997-91f2-870a18432c15	picture	user.attribute
c6028fb1-7f47-4997-91f2-870a18432c15	true	id.token.claim
c6028fb1-7f47-4997-91f2-870a18432c15	true	access.token.claim
c6028fb1-7f47-4997-91f2-870a18432c15	picture	claim.name
c6028fb1-7f47-4997-91f2-870a18432c15	String	jsonType.label
f8804fca-46b5-44ac-84f4-613bcf4e5912	true	userinfo.token.claim
f8804fca-46b5-44ac-84f4-613bcf4e5912	profile	user.attribute
f8804fca-46b5-44ac-84f4-613bcf4e5912	true	id.token.claim
f8804fca-46b5-44ac-84f4-613bcf4e5912	true	access.token.claim
f8804fca-46b5-44ac-84f4-613bcf4e5912	profile	claim.name
f8804fca-46b5-44ac-84f4-613bcf4e5912	String	jsonType.label
fa3bb08e-cccc-49b0-85a7-fc49a483bda0	true	userinfo.token.claim
fa3bb08e-cccc-49b0-85a7-fc49a483bda0	locale	user.attribute
fa3bb08e-cccc-49b0-85a7-fc49a483bda0	true	id.token.claim
fa3bb08e-cccc-49b0-85a7-fc49a483bda0	true	access.token.claim
fa3bb08e-cccc-49b0-85a7-fc49a483bda0	locale	claim.name
fa3bb08e-cccc-49b0-85a7-fc49a483bda0	String	jsonType.label
ac8eff71-58df-4fc8-9b3e-111aeec4a97a	true	userinfo.token.claim
ac8eff71-58df-4fc8-9b3e-111aeec4a97a	email	user.attribute
ac8eff71-58df-4fc8-9b3e-111aeec4a97a	true	id.token.claim
ac8eff71-58df-4fc8-9b3e-111aeec4a97a	true	access.token.claim
ac8eff71-58df-4fc8-9b3e-111aeec4a97a	email	claim.name
ac8eff71-58df-4fc8-9b3e-111aeec4a97a	String	jsonType.label
ea1eede2-5961-439f-ae81-58bb3c25544a	true	userinfo.token.claim
ea1eede2-5961-439f-ae81-58bb3c25544a	emailVerified	user.attribute
ea1eede2-5961-439f-ae81-58bb3c25544a	true	id.token.claim
ea1eede2-5961-439f-ae81-58bb3c25544a	true	access.token.claim
ea1eede2-5961-439f-ae81-58bb3c25544a	email_verified	claim.name
ea1eede2-5961-439f-ae81-58bb3c25544a	boolean	jsonType.label
59f0e8bd-19e2-44a4-8cd3-c2b2aecf9d29	formatted	user.attribute.formatted
59f0e8bd-19e2-44a4-8cd3-c2b2aecf9d29	country	user.attribute.country
59f0e8bd-19e2-44a4-8cd3-c2b2aecf9d29	postal_code	user.attribute.postal_code
59f0e8bd-19e2-44a4-8cd3-c2b2aecf9d29	true	userinfo.token.claim
59f0e8bd-19e2-44a4-8cd3-c2b2aecf9d29	street	user.attribute.street
59f0e8bd-19e2-44a4-8cd3-c2b2aecf9d29	true	id.token.claim
59f0e8bd-19e2-44a4-8cd3-c2b2aecf9d29	region	user.attribute.region
59f0e8bd-19e2-44a4-8cd3-c2b2aecf9d29	true	access.token.claim
59f0e8bd-19e2-44a4-8cd3-c2b2aecf9d29	locality	user.attribute.locality
1428d008-3a23-4359-9a58-56b695dbecf5	true	userinfo.token.claim
1428d008-3a23-4359-9a58-56b695dbecf5	phoneNumberVerified	user.attribute
1428d008-3a23-4359-9a58-56b695dbecf5	true	id.token.claim
1428d008-3a23-4359-9a58-56b695dbecf5	true	access.token.claim
1428d008-3a23-4359-9a58-56b695dbecf5	phone_number_verified	claim.name
1428d008-3a23-4359-9a58-56b695dbecf5	boolean	jsonType.label
3eeabe7f-d86f-49fc-8d74-2891e9bb1892	true	userinfo.token.claim
3eeabe7f-d86f-49fc-8d74-2891e9bb1892	phoneNumber	user.attribute
3eeabe7f-d86f-49fc-8d74-2891e9bb1892	true	id.token.claim
3eeabe7f-d86f-49fc-8d74-2891e9bb1892	true	access.token.claim
3eeabe7f-d86f-49fc-8d74-2891e9bb1892	phone_number	claim.name
3eeabe7f-d86f-49fc-8d74-2891e9bb1892	String	jsonType.label
4126c632-781b-4281-bbb2-15715633eaf8	true	multivalued
4126c632-781b-4281-bbb2-15715633eaf8	foo	user.attribute
4126c632-781b-4281-bbb2-15715633eaf8	true	access.token.claim
4126c632-781b-4281-bbb2-15715633eaf8	realm_access.roles	claim.name
4126c632-781b-4281-bbb2-15715633eaf8	String	jsonType.label
d3c545ca-a39b-4807-bba7-82e8a72909f8	true	multivalued
d3c545ca-a39b-4807-bba7-82e8a72909f8	foo	user.attribute
d3c545ca-a39b-4807-bba7-82e8a72909f8	true	access.token.claim
d3c545ca-a39b-4807-bba7-82e8a72909f8	resource_access.${client_id}.roles	claim.name
d3c545ca-a39b-4807-bba7-82e8a72909f8	String	jsonType.label
0269483b-c269-4420-9453-f5c0d8b9aab4	true	multivalued
0269483b-c269-4420-9453-f5c0d8b9aab4	foo	user.attribute
0269483b-c269-4420-9453-f5c0d8b9aab4	true	id.token.claim
0269483b-c269-4420-9453-f5c0d8b9aab4	true	access.token.claim
0269483b-c269-4420-9453-f5c0d8b9aab4	groups	claim.name
0269483b-c269-4420-9453-f5c0d8b9aab4	String	jsonType.label
4e8d9cc6-57da-4a0b-b7dc-a696d1492891	true	userinfo.token.claim
4e8d9cc6-57da-4a0b-b7dc-a696d1492891	username	user.attribute
4e8d9cc6-57da-4a0b-b7dc-a696d1492891	true	id.token.claim
4e8d9cc6-57da-4a0b-b7dc-a696d1492891	true	access.token.claim
4e8d9cc6-57da-4a0b-b7dc-a696d1492891	upn	claim.name
4e8d9cc6-57da-4a0b-b7dc-a696d1492891	String	jsonType.label
09d9bb83-0070-4d23-8f02-ed9c810c1c8d	true	id.token.claim
09d9bb83-0070-4d23-8f02-ed9c810c1c8d	true	access.token.claim
0587f5b3-5f79-44f4-a7f6-c8710d517465	true	userinfo.token.claim
0587f5b3-5f79-44f4-a7f6-c8710d517465	locale	user.attribute
0587f5b3-5f79-44f4-a7f6-c8710d517465	true	id.token.claim
0587f5b3-5f79-44f4-a7f6-c8710d517465	true	access.token.claim
0587f5b3-5f79-44f4-a7f6-c8710d517465	locale	claim.name
0587f5b3-5f79-44f4-a7f6-c8710d517465	String	jsonType.label
adbfa08d-15cb-41de-a47a-0e5742563a03	clientId	user.session.note
adbfa08d-15cb-41de-a47a-0e5742563a03	true	id.token.claim
adbfa08d-15cb-41de-a47a-0e5742563a03	true	access.token.claim
adbfa08d-15cb-41de-a47a-0e5742563a03	clientId	claim.name
adbfa08d-15cb-41de-a47a-0e5742563a03	String	jsonType.label
c24f6da7-9272-4471-9487-0871203a39b3	clientHost	user.session.note
c24f6da7-9272-4471-9487-0871203a39b3	true	id.token.claim
c24f6da7-9272-4471-9487-0871203a39b3	true	access.token.claim
c24f6da7-9272-4471-9487-0871203a39b3	clientHost	claim.name
c24f6da7-9272-4471-9487-0871203a39b3	String	jsonType.label
d7c2cd43-eeab-4821-ab6d-50b5fccba664	clientAddress	user.session.note
d7c2cd43-eeab-4821-ab6d-50b5fccba664	true	id.token.claim
d7c2cd43-eeab-4821-ab6d-50b5fccba664	true	access.token.claim
d7c2cd43-eeab-4821-ab6d-50b5fccba664	clientAddress	claim.name
d7c2cd43-eeab-4821-ab6d-50b5fccba664	String	jsonType.label
bf1889be-b5d7-46dc-be5b-423a8fede322	true	multivalued
bf1889be-b5d7-46dc-be5b-423a8fede322	true	userinfo.token.claim
bf1889be-b5d7-46dc-be5b-423a8fede322	true	id.token.claim
bf1889be-b5d7-46dc-be5b-423a8fede322	true	access.token.claim
bf1889be-b5d7-46dc-be5b-423a8fede322	roles	claim.name
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
4462ad8a-9bc0-49aa-887b-192539be165a	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	6daac312-3376-4df6-a77c-1be530767894	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	c9ea40b2-4c5e-4309-bcb0-dbc5cde99e32	311a0db9-63f6-48ad-9abe-d21e5c29614b	947efab2-f265-4d37-9b07-0b60eefcbfbd	205538a2-270a-4889-8bf0-c602f0c33492	07be6d32-dcc2-4595-b97e-a243e96594b0	2592000	f	900	t	f	8b6bb737-7425-4c5a-9572-2ebc1e6d4268	0	f	0	0	3111849e-163a-4a14-8fc1-7ad9ffeea268
f7426fe0-9b39-4eb4-8348-4780b68b86b4	60	300	300	\N	\N	\N	t	f	0	\N	development	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	d4e3c9f4-3afd-4491-b7c1-cdf733a62648	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	f288a5dc-8e05-4477-90d5-39ac82f2d6a5	258e3ae9-066a-4e55-9f79-b4e1e354c7db	7480f46c-4da2-4464-bad0-c90104d62545	ace4184a-9b1d-4667-978c-47b7fba8138e	25018c07-b545-4b8d-a0bc-c52abc8f462c	2592000	f	900	t	f	17ad1a3f-f9e0-4ea4-9396-a0c1c0a1784d	0	f	0	0	4715f9b4-7df9-4b27-a87e-0427f84823b5
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	4462ad8a-9bc0-49aa-887b-192539be165a	
_browser_header.xContentTypeOptions	4462ad8a-9bc0-49aa-887b-192539be165a	nosniff
_browser_header.xRobotsTag	4462ad8a-9bc0-49aa-887b-192539be165a	none
_browser_header.xFrameOptions	4462ad8a-9bc0-49aa-887b-192539be165a	SAMEORIGIN
_browser_header.contentSecurityPolicy	4462ad8a-9bc0-49aa-887b-192539be165a	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	4462ad8a-9bc0-49aa-887b-192539be165a	1; mode=block
_browser_header.strictTransportSecurity	4462ad8a-9bc0-49aa-887b-192539be165a	max-age=31536000; includeSubDomains
bruteForceProtected	4462ad8a-9bc0-49aa-887b-192539be165a	false
permanentLockout	4462ad8a-9bc0-49aa-887b-192539be165a	false
maxFailureWaitSeconds	4462ad8a-9bc0-49aa-887b-192539be165a	900
minimumQuickLoginWaitSeconds	4462ad8a-9bc0-49aa-887b-192539be165a	60
waitIncrementSeconds	4462ad8a-9bc0-49aa-887b-192539be165a	60
quickLoginCheckMilliSeconds	4462ad8a-9bc0-49aa-887b-192539be165a	1000
maxDeltaTimeSeconds	4462ad8a-9bc0-49aa-887b-192539be165a	43200
failureFactor	4462ad8a-9bc0-49aa-887b-192539be165a	30
realmReusableOtpCode	4462ad8a-9bc0-49aa-887b-192539be165a	false
displayName	4462ad8a-9bc0-49aa-887b-192539be165a	Keycloak
displayNameHtml	4462ad8a-9bc0-49aa-887b-192539be165a	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	4462ad8a-9bc0-49aa-887b-192539be165a	RS256
offlineSessionMaxLifespanEnabled	4462ad8a-9bc0-49aa-887b-192539be165a	false
offlineSessionMaxLifespan	4462ad8a-9bc0-49aa-887b-192539be165a	5184000
_browser_header.contentSecurityPolicyReportOnly	f7426fe0-9b39-4eb4-8348-4780b68b86b4	
_browser_header.xContentTypeOptions	f7426fe0-9b39-4eb4-8348-4780b68b86b4	nosniff
_browser_header.xRobotsTag	f7426fe0-9b39-4eb4-8348-4780b68b86b4	none
_browser_header.xFrameOptions	f7426fe0-9b39-4eb4-8348-4780b68b86b4	SAMEORIGIN
_browser_header.contentSecurityPolicy	f7426fe0-9b39-4eb4-8348-4780b68b86b4	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	f7426fe0-9b39-4eb4-8348-4780b68b86b4	1; mode=block
_browser_header.strictTransportSecurity	f7426fe0-9b39-4eb4-8348-4780b68b86b4	max-age=31536000; includeSubDomains
bruteForceProtected	f7426fe0-9b39-4eb4-8348-4780b68b86b4	false
permanentLockout	f7426fe0-9b39-4eb4-8348-4780b68b86b4	false
maxFailureWaitSeconds	f7426fe0-9b39-4eb4-8348-4780b68b86b4	900
minimumQuickLoginWaitSeconds	f7426fe0-9b39-4eb4-8348-4780b68b86b4	60
waitIncrementSeconds	f7426fe0-9b39-4eb4-8348-4780b68b86b4	60
quickLoginCheckMilliSeconds	f7426fe0-9b39-4eb4-8348-4780b68b86b4	1000
maxDeltaTimeSeconds	f7426fe0-9b39-4eb4-8348-4780b68b86b4	43200
failureFactor	f7426fe0-9b39-4eb4-8348-4780b68b86b4	30
realmReusableOtpCode	f7426fe0-9b39-4eb4-8348-4780b68b86b4	false
defaultSignatureAlgorithm	f7426fe0-9b39-4eb4-8348-4780b68b86b4	RS256
offlineSessionMaxLifespanEnabled	f7426fe0-9b39-4eb4-8348-4780b68b86b4	false
offlineSessionMaxLifespan	f7426fe0-9b39-4eb4-8348-4780b68b86b4	5184000
actionTokenGeneratedByAdminLifespan	f7426fe0-9b39-4eb4-8348-4780b68b86b4	43200
actionTokenGeneratedByUserLifespan	f7426fe0-9b39-4eb4-8348-4780b68b86b4	300
oauth2DeviceCodeLifespan	f7426fe0-9b39-4eb4-8348-4780b68b86b4	600
oauth2DevicePollingInterval	f7426fe0-9b39-4eb4-8348-4780b68b86b4	5
webAuthnPolicyRpEntityName	f7426fe0-9b39-4eb4-8348-4780b68b86b4	keycloak
webAuthnPolicySignatureAlgorithms	f7426fe0-9b39-4eb4-8348-4780b68b86b4	ES256
webAuthnPolicyRpId	f7426fe0-9b39-4eb4-8348-4780b68b86b4	
webAuthnPolicyAttestationConveyancePreference	f7426fe0-9b39-4eb4-8348-4780b68b86b4	not specified
webAuthnPolicyAuthenticatorAttachment	f7426fe0-9b39-4eb4-8348-4780b68b86b4	not specified
webAuthnPolicyRequireResidentKey	f7426fe0-9b39-4eb4-8348-4780b68b86b4	not specified
webAuthnPolicyUserVerificationRequirement	f7426fe0-9b39-4eb4-8348-4780b68b86b4	not specified
webAuthnPolicyCreateTimeout	f7426fe0-9b39-4eb4-8348-4780b68b86b4	0
webAuthnPolicyAvoidSameAuthenticatorRegister	f7426fe0-9b39-4eb4-8348-4780b68b86b4	false
webAuthnPolicyRpEntityNamePasswordless	f7426fe0-9b39-4eb4-8348-4780b68b86b4	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	f7426fe0-9b39-4eb4-8348-4780b68b86b4	ES256
webAuthnPolicyRpIdPasswordless	f7426fe0-9b39-4eb4-8348-4780b68b86b4	
webAuthnPolicyAttestationConveyancePreferencePasswordless	f7426fe0-9b39-4eb4-8348-4780b68b86b4	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	f7426fe0-9b39-4eb4-8348-4780b68b86b4	not specified
webAuthnPolicyRequireResidentKeyPasswordless	f7426fe0-9b39-4eb4-8348-4780b68b86b4	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	f7426fe0-9b39-4eb4-8348-4780b68b86b4	not specified
webAuthnPolicyCreateTimeoutPasswordless	f7426fe0-9b39-4eb4-8348-4780b68b86b4	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	f7426fe0-9b39-4eb4-8348-4780b68b86b4	false
cibaBackchannelTokenDeliveryMode	f7426fe0-9b39-4eb4-8348-4780b68b86b4	poll
cibaExpiresIn	f7426fe0-9b39-4eb4-8348-4780b68b86b4	120
cibaInterval	f7426fe0-9b39-4eb4-8348-4780b68b86b4	5
cibaAuthRequestedUserHint	f7426fe0-9b39-4eb4-8348-4780b68b86b4	login_hint
parRequestUriLifespan	f7426fe0-9b39-4eb4-8348-4780b68b86b4	60
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
4462ad8a-9bc0-49aa-887b-192539be165a	jboss-logging
f7426fe0-9b39-4eb4-8348-4780b68b86b4	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	4462ad8a-9bc0-49aa-887b-192539be165a
password	password	t	t	f7426fe0-9b39-4eb4-8348-4780b68b86b4
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.redirect_uris (client_id, value) FROM stdin;
365e9f94-e018-41e9-9a46-73544a6dc85e	/realms/master/account/*
5c046893-b83c-43bf-8110-173c406767c4	/realms/master/account/*
203c77ab-5b84-4cac-8982-a883bc321474	/admin/master/console/*
1bdcd8b0-67c0-4b8f-9e68-120030586995	/realms/development/account/*
c345fa1c-a51c-42cc-bae3-a27f78070f4d	/realms/development/account/*
d8c943ac-ce3b-4594-b705-17159fbb50be	/admin/development/console/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
bef4890e-76ff-4bfa-ae51-265e0b0ec7b2	VERIFY_EMAIL	Verify Email	4462ad8a-9bc0-49aa-887b-192539be165a	t	f	VERIFY_EMAIL	50
5e2f1233-a19b-4399-bd05-8f12fc920d04	UPDATE_PROFILE	Update Profile	4462ad8a-9bc0-49aa-887b-192539be165a	t	f	UPDATE_PROFILE	40
02ec241d-5402-4d64-94c0-6f554bae4a6b	CONFIGURE_TOTP	Configure OTP	4462ad8a-9bc0-49aa-887b-192539be165a	t	f	CONFIGURE_TOTP	10
edd5a594-3e20-4a04-a648-9ba7aea7348a	UPDATE_PASSWORD	Update Password	4462ad8a-9bc0-49aa-887b-192539be165a	t	f	UPDATE_PASSWORD	30
26b8a389-0e27-4df6-b3fb-11cb6f498c03	terms_and_conditions	Terms and Conditions	4462ad8a-9bc0-49aa-887b-192539be165a	f	f	terms_and_conditions	20
63e2cc76-1b37-42fb-9a27-844e54590257	delete_account	Delete Account	4462ad8a-9bc0-49aa-887b-192539be165a	f	f	delete_account	60
57e11f52-cec9-4625-8904-cafdc2d290a4	update_user_locale	Update User Locale	4462ad8a-9bc0-49aa-887b-192539be165a	t	f	update_user_locale	1000
a2d1ab9a-065f-491e-b9be-a0f51a4fc21f	webauthn-register	Webauthn Register	4462ad8a-9bc0-49aa-887b-192539be165a	t	f	webauthn-register	70
b6886afc-2ac5-432d-8f81-4fd9c0a4c492	webauthn-register-passwordless	Webauthn Register Passwordless	4462ad8a-9bc0-49aa-887b-192539be165a	t	f	webauthn-register-passwordless	80
8b1abb72-0c12-4403-ad23-853d1177bfd6	VERIFY_EMAIL	Verify Email	f7426fe0-9b39-4eb4-8348-4780b68b86b4	t	f	VERIFY_EMAIL	50
b87e6af8-e4c2-464a-90b0-43f74af8e3f2	UPDATE_PROFILE	Update Profile	f7426fe0-9b39-4eb4-8348-4780b68b86b4	t	f	UPDATE_PROFILE	40
177af2b8-6856-4541-8475-73a566065935	CONFIGURE_TOTP	Configure OTP	f7426fe0-9b39-4eb4-8348-4780b68b86b4	t	f	CONFIGURE_TOTP	10
07e7ad79-024a-4b2d-8533-f4aacd264ee3	UPDATE_PASSWORD	Update Password	f7426fe0-9b39-4eb4-8348-4780b68b86b4	t	f	UPDATE_PASSWORD	30
6e87ec18-60f7-4bb8-b31a-63c7821c2260	terms_and_conditions	Terms and Conditions	f7426fe0-9b39-4eb4-8348-4780b68b86b4	f	f	terms_and_conditions	20
c1454122-0539-4946-b9c1-f837c85d57a3	delete_account	Delete Account	f7426fe0-9b39-4eb4-8348-4780b68b86b4	f	f	delete_account	60
c2b7eace-50b1-4ef8-9971-4394def0e836	update_user_locale	Update User Locale	f7426fe0-9b39-4eb4-8348-4780b68b86b4	t	f	update_user_locale	1000
c07a9708-37a0-4333-b178-fce9e32491c8	webauthn-register	Webauthn Register	f7426fe0-9b39-4eb4-8348-4780b68b86b4	t	f	webauthn-register	70
8c04a1cc-bb18-43be-a736-8b162ae8bebb	webauthn-register-passwordless	Webauthn Register Passwordless	f7426fe0-9b39-4eb4-8348-4780b68b86b4	t	f	webauthn-register-passwordless	80
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
69f64c80-4877-479f-a3be-498c4f49e75c	t	0	1
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
fc37b30e-a645-4ef7-9080-29f81549adfa	Default Policy	A policy that grants access only for users within this realm	js	0	0	69f64c80-4877-479f-a3be-498c4f49e75c	\N
67ae94d1-9d81-42d3-a2c3-72b784ecbbc2	Default Permission	A permission that applies to the default resource type	resource	1	0	69f64c80-4877-479f-a3be-498c4f49e75c	\N
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
d3738e09-f7a0-441d-94de-ea7fd804fab3	Default Resource	urn:internal-services:resources:default	\N	69f64c80-4877-479f-a3be-498c4f49e75c	69f64c80-4877-479f-a3be-498c4f49e75c	f	\N
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_uris (resource_id, value) FROM stdin;
d3738e09-f7a0-441d-94de-ea7fd804fab3	/*
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
5c046893-b83c-43bf-8110-173c406767c4	2b902f06-9d40-4537-a6b1-7a902fee8c6c
5c046893-b83c-43bf-8110-173c406767c4	2c5555d0-1b4a-443f-b117-f20f54b289ef
c345fa1c-a51c-42cc-bae3-a27f78070f4d	8582ebab-88c2-4b8b-889b-f8c6878a276d
c345fa1c-a51c-42cc-bae3-a27f78070f4d	e6131746-c424-48c8-9e59-91adad005725
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
17b3cd37-9d48-4414-a8ed-a120f949e3f5	\N	0eb06d9d-7126-447c-83ef-de0c08923773	f	t	\N	\N	\N	4462ad8a-9bc0-49aa-887b-192539be165a	admin	1668694568691	\N	0
9b538bc9-284e-4acc-b034-7acf4ce0fdf8	test@test.com	test@test.com	t	t	\N	kim	lim	f7426fe0-9b39-4eb4-8348-4780b68b86b4	test@test.com	1668695014840	\N	0
90f7dda9-d852-4a62-b5d0-c9639b5dc8f9	\N	220c1cf1-3f0e-45c2-8754-a566fc09988b	f	t	\N	\N	\N	f7426fe0-9b39-4eb4-8348-4780b68b86b4	service-account-internal-services	1668813532174	69f64c80-4877-479f-a3be-498c4f49e75c	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
3111849e-163a-4a14-8fc1-7ad9ffeea268	17b3cd37-9d48-4414-a8ed-a120f949e3f5
fcc64481-b604-439f-aff7-0dfd9f016931	17b3cd37-9d48-4414-a8ed-a120f949e3f5
9c8134c8-155a-46b0-8074-3852a2534a7b	17b3cd37-9d48-4414-a8ed-a120f949e3f5
afc521c1-c46e-4707-b19e-937bfba0b9ef	17b3cd37-9d48-4414-a8ed-a120f949e3f5
4e8c7660-8e83-408e-9019-f0b36d6afbfc	17b3cd37-9d48-4414-a8ed-a120f949e3f5
4b17bc6d-a201-4549-b25a-34aaca09c8c0	17b3cd37-9d48-4414-a8ed-a120f949e3f5
4b6c49e1-ced7-4652-8a0c-56d6b9a8ed65	17b3cd37-9d48-4414-a8ed-a120f949e3f5
069bdc19-63e9-458e-a31f-94ae47ce615b	17b3cd37-9d48-4414-a8ed-a120f949e3f5
3b08b8a8-1af7-44a5-80cc-288019f369e5	17b3cd37-9d48-4414-a8ed-a120f949e3f5
3fc96ef9-9bf5-4159-98db-768e2ca7f28f	17b3cd37-9d48-4414-a8ed-a120f949e3f5
d4e58da6-9874-4a0e-a7d1-1653379c8260	17b3cd37-9d48-4414-a8ed-a120f949e3f5
85444d65-ee76-4fa3-b11f-65f8a9ca6eca	17b3cd37-9d48-4414-a8ed-a120f949e3f5
ba813970-65f4-48c7-91a1-c6a1d96a34aa	17b3cd37-9d48-4414-a8ed-a120f949e3f5
72e45a12-99bc-4f2b-a3f6-67e3a4a497b0	17b3cd37-9d48-4414-a8ed-a120f949e3f5
5b55674b-7b2c-46fb-b0c8-602f60df40d2	17b3cd37-9d48-4414-a8ed-a120f949e3f5
e151d0dc-27d5-4743-981d-67fb7c85a5c8	17b3cd37-9d48-4414-a8ed-a120f949e3f5
2e6a032d-e6ef-469b-ad81-bf9dd056044c	17b3cd37-9d48-4414-a8ed-a120f949e3f5
e887762d-227f-4544-a98a-fb2f3be129a6	17b3cd37-9d48-4414-a8ed-a120f949e3f5
1759e0a1-e4f9-4f84-a1c0-52d04b99a139	17b3cd37-9d48-4414-a8ed-a120f949e3f5
4715f9b4-7df9-4b27-a87e-0427f84823b5	9b538bc9-284e-4acc-b034-7acf4ce0fdf8
4715f9b4-7df9-4b27-a87e-0427f84823b5	90f7dda9-d852-4a62-b5d0-c9639b5dc8f9
8a5917e3-d73e-48cd-96e4-91031dd715b0	90f7dda9-d852-4a62-b5d0-c9639b5dc8f9
8582ebab-88c2-4b8b-889b-f8c6878a276d	90f7dda9-d852-4a62-b5d0-c9639b5dc8f9
44120ffd-88bd-464e-8475-0bae0c003857	9b538bc9-284e-4acc-b034-7acf4ce0fdf8
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.web_origins (client_id, value) FROM stdin;
203c77ab-5b84-4cac-8982-a883bc321474	+
d8c943ac-ce3b-4594-b705-17159fbb50be	+
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

