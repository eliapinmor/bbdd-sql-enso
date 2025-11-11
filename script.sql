CREATE TABLE enso_tutors(
    id_tutor integer constraint pk_id_tutor PRIMARY KEY,
    id_role integer,
    name character varying(50) NOT NULL,
    last_name_1 character varying(50) NOT NULL,
    last_name_2 character varying(50),
    birthdate date NOT NULL,
    dni text UNIQUE,
    address text NOT NULL,
    postal_code text,
    phone_number text,
    email varchar2(320) constraint uk_tutors_email UNIQUE constraint nn_tutors_email NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    constraint fk_tutors_id_role foreign key (id_role) references public.roles(id)
)

CREATE TABLE enso_tutors_students(
    id_tutor integer,
    id_student integer,
    constraint pk_tutors_students PRIMARY KEY(id_tutor, id_student),
    constraint fk_tutors_students_id_tutor foreign key (id_tutor) references enso_tutors(id_tutor),
    constraint fk_tutors_students_id_student foreign key (id_student) references users(id)
)

CREATE TABLE enso_games(
    id_game integer constraint pk_id_game PRIMARY KEY,
    game_name varchar2 (50 BYTE) constraint uk_game_name UNIQUE constraint nn_name_game NOT NULL,
    game_description text,
    game_path text, --poner estructura
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone

)

CREATE TABLE enso_collections(
    id_collection integer constraint pk_id_collection PRIMARY KEY,
    collection_name varchar2 (50 BYTE) constraint nn_name_game NOT NULL,
    collection_description text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone    
)

CREATE TABLE enso_collections_games(
    id integer constraint pk_id_collections_game PRIMARY KEY,
    id_collection integer,
    id_game integer,
    id_parameter integer,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,

)

CREATE TABLE enso_unidades_parameters(
    id_unidad integer constraint pk_id_unidad PRIMARY KEY,
    unidad_name text
    --segundos, minutos, nº de errores,      insertar los datos 
)

CREATE TABLE enso_collections_games_parameters(
    id_parameter integer constraint pk_id_parameter PRIMARY KEY,
    id_unidad integer,
    minimum integer,
    maximum integer,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    constraint fk_parameters_id_unidad foreign key (id_unidad) references enso_unidades_parameters(id_unidad)
)

CREATE TABLE enso_files(
    id_file integer constraint pk_id_file PRIMARY KEY,
    id_student integer,
    file_name text,
    file_path text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    constraint fk_enso_files_id_student foreign key (id_role) references roles(id_role)
)

CREATE TABLE enso_sop_tracking(
    id_tracking integer constraint pk_id_tracking PRIMARY KEY,
    id_student integer,
    tracking_date,
    notes,
    report_id,
    contacts_id,
    confidentiality_document_id,
    tutoring_tracking_id,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
)

CREATE TABLE enso_messages(
    id_message integer constraint pk_id_messages PRIMARY KEY,
    id_sender,
    subject_message,
    body,
    date_sent
)

CREATE TABLE enso_recipient_type(
    id_recipient integer constraint pk_id_recipient PRIMARY KEY,
    recipient_name text
    -- insertar los datos to , cc , cco
)

CREATE TABLE enso_messages_recipients(
    id_recipient integer,
    id_message integer,
    id_recipient_type integer,
    constraint pk_users_interests PRIMARY KEY(id_recipient, id_message, id_recipient_type),
    constraint fk_enso_messages_recipients_id_recipient foreign key (id_recipient) references users(id_user)
    constraint fk_enso_messages_recipients_id_message foreign key (id_message) references enso_messages(id_message),
    constraint fk_enso_messages_recipients_id_recipient_type foreign key (id_recipient) references enso_recipient_type(id_recipient)
)


