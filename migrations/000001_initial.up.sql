create table users (
    created_at timestamp with time zone not null,
    updated_at timestamp with time zone not null,
    deleted_at timestamp with time zone,
    id serial not null constraint users_pk primary key,
    prefix varchar(20),
    first_name varchar(256),
    last_name varchar(256),
    citizen_id varchar(13),
    birthday timestamp with time zone,
    phone_number varchar(10),
    email varchar(256),
    password_hash varchar(256)
);

create index users_deleted_at_index on users (deleted_at);
create unique index users_citizen_id_uindex on users (citizen_id);

create table tokens (
    id serial not null constraint tokens_pk primary key,
    created_at timestamp with time zone not null,
    updated_at timestamp with time zone not null,
    deleted_at timestamp with time zone,
    user_id integer not null constraint tokens_users_id_fk references users,
    refresh_token varchar(512) not null,
    device_token varchar(1024)
);

create index tokens_deleted_at_index on tokens (deleted_at);
create unique index tokens_refresh_token_uindex on tokens (refresh_token);

create table user_roles (
    id serial not null constraint user_roles_pk primary key,
    created_at timestamp with time zone not null,
    updated_at timestamp with time zone not null,
    deleted_at timestamp with time zone,
    user_id integer not null constraint user_roles_user_id_fk references users,
    role integer not null
);

create table registers (
    id serial not null constraint registers_pk primary key,
    created_at timestamp with time zone not null,
    updated_at timestamp with time zone not null,
    deleted_at timestamp with time zone,
    first_name varchar(256),
    last_name varchar(256),
    cid int,
    phone_number varchar(10) not null,
    type int default 0 not null
);

create table otps (
    id serial not null constraint otps_pk primary key,
    created_at timestamp with time zone not null,
    updated_at timestamp with time zone not null,
    deleted_at timestamp with time zone,
    phone_number varchar(10) not null,
    secret varchar(128) not null,
    ref varchar(6) not null,
    ref_id bigint,
    type integer
);

create index otps_deleted_at_index on otps (deleted_at);
create index otps_ref_phone_number_index on otps (ref, phone_number);