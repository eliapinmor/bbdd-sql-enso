CREATE TABLE "centers" (
  "id" bigint PRIMARY KEY,
  "name" varchar(30) NOT NULL,
  "address" varchar(100) NOT NULL,
  "cif" varchar(9) NOT NULL,
  "center_code" varchar(8) NOT NULL,
  "created_at" timestamp(0),
  "updated_at" timestamp(0),
  "deleted_at" timestamp(0)
);

CREATE TABLE "countries" (
  "id" bigint PRIMARY KEY,
  "name" varchar(100) UNIQUE NOT NULL,
  "iso_code" varchar(10) UNIQUE NOT NULL,
  "created_at" timestamp(0),
  "updated_at" timestamp(0)
);

CREATE TABLE "provinces" (
  "id" bigint PRIMARY KEY,
  "name" varchar(100) NOT NULL,
  "country_id" bigint NOT NULL,
  "created_at" timestamp(0),
  "updated_at" timestamp(0)
);

CREATE TABLE "cities" (
  "id" bigint PRIMARY KEY,
  "name" varchar(255) NOT NULL,
  "province_id" bigint NOT NULL,
  "created_at" timestamp(0),
  "updated_at" timestamp(0)
);

CREATE TABLE "training_areas" (
  "id" bigint PRIMARY KEY,
  "name" varchar(50) NOT NULL,
  "description" varchar(200),
  "created_at" timestamp(0),
  "updated_at" timestamp(0),
  "deleted_at" timestamp(0)
);

CREATE TABLE "courses" (
  "id" bigint PRIMARY KEY,
  "name" varchar(150) NOT NULL,
  "description" varchar(200),
  "training_area_id" bigint NOT NULL,
  "center_id" bigint NOT NULL,
  "created_at" timestamp(0),
  "updated_at" timestamp(0),
  "deleted_at" timestamp(0),
  "code" varchar(10),
  "study_type" varchar(10) NOT NULL
);

CREATE TABLE "document_types" (
  "id" bigint PRIMARY KEY,
  "name" varchar(100) NOT NULL,
  "abbreviation" varchar(20) NOT NULL,
  "created_at" timestamp(0),
  "updated_at" timestamp(0),
  "deleted_at" timestamp(0)
);

CREATE TABLE "roles" (
  "id" bigint PRIMARY KEY,
  "name" varchar(50) NOT NULL,
  "description" varchar(255),
  "created_at" timestamp(0),
  "updated_at" timestamp(0)
);

CREATE TABLE "users" (
  "id" bigint PRIMARY KEY,
  "password" varchar(255) NOT NULL,
  "status" varchar(50) NOT NULL,
  "created_at" timestamp(0),
  "updated_at" timestamp(0),
  "deleted_at" timestamp(0)
);

CREATE TABLE "emails" (
  "id" bigint PRIMARY KEY,
  "user_id" bigint NOT NULL,
  "email" text NOT NULL,
  "created_at" timestamp(0),
  "updated_at" timestamp(0),
  "email_hash" varchar(64) UNIQUE
);

CREATE TABLE "users_data" (
  "id" bigint PRIMARY KEY,
  "name" varchar(50) NOT NULL,
  "last_name_1" varchar(50) NOT NULL,
  "last_name_2" varchar(50),
  "birthdate" date NOT NULL,
  "dni" text UNIQUE,
  "address" text NOT NULL,
  "postal_code" text,
  "social_security" text,
  "health_card" text,
  "phone_number" text,
  "user_id" bigint NOT NULL,
  "city_id" bigint NOT NULL,
  "document_type_id" bigint NOT NULL,
  "created_at" timestamp(0),
  "updated_at" timestamp(0),
  "deleted_at" timestamp(0),
  "identification" varchar(64),
  "lat" text,
  "lon" text,
  "social_security_path" varchar(255),
  "passport" text,
  "nie" text
);

CREATE TABLE "users_courses" (
  "id" bigint PRIMARY KEY,
  "academic_course" varchar(10) NOT NULL,
  "user_id" bigint NOT NULL,
  "course_id" bigint NOT NULL,
  "role_id" bigint NOT NULL,
  "created_at" timestamp(0),
  "updated_at" timestamp(0),
  "deleted_at" timestamp(0),
  "year_level" integer,
  "is_withdrawn" boolean
);

CREATE TABLE "users_roles" (
  "user_id" bigint NOT NULL,
  "role_id" bigint NOT NULL,
  "created_at" timestamp(0),
  "updated_at" timestamp(0),
  PRIMARY KEY ("user_id", "role_id")
);

CREATE TABLE "enso_tutors" (
  "id" bigint PRIMARY KEY,
  "role_id" bigint,
  "name" varchar(50) NOT NULL,
  "last_name_1" varchar(50) NOT NULL,
  "last_name_2" varchar(50),
  "birthdate" date NOT NULL,
  "dni" text UNIQUE,
  "address" text NOT NULL,
  "postal_code" text,
  "phone_number" text,
  "email" varchar(320) UNIQUE NOT NULL,
  "created_at" timestamp(0),
  "updated_at" timestamp(0)
);

CREATE TABLE "enso_tutors_students" (
  "tutor_id" bigint,
  "student_id" bigint,
  PRIMARY KEY ("tutor_id", "student_id")
);

CREATE TABLE "enso_games" (
  "id" bigint PRIMARY KEY,
  "game_name" varchar(50) UNIQUE NOT NULL,
  "game_description" text,
  "game_path" text,
  "created_at" timestamp(0),
  "updated_at" timestamp(0)
);

CREATE TABLE "enso_collections" (
  "id" bigint PRIMARY KEY,
  "collection_name" varchar(50) NOT NULL,
  "collection_description" text,
  "created_at" timestamp(0),
  "updated_at" timestamp(0)
);

CREATE TABLE "enso_collections_games" (
  "id" bigint PRIMARY KEY,
  "collection_id" bigint NOT NULL,
  "game_id" bigint NOT NULL,
  "created_at" timestamp(0),
  "updated_at" timestamp(0)
);

CREATE TABLE "enso_unidades_parameters" (
  "id" bigint PRIMARY KEY,
  "unidad_name" varchar(200) NOT NULL
);

CREATE TABLE "enso_collections_games_parameters" (
  "id" bigint PRIMARY KEY,
  "unidad_id" bigint,
  "collection_game_id" bigint NOT NULL,
  "minimum" integer,
  "maximum" integer,
  "created_at" timestamp(0),
  "updated_at" timestamp(0)
);

CREATE TABLE "enso_files" (
  "id" bigint PRIMARY KEY,
  "student_id" bigint,
  "file_name" varchar(260),
  "file_path" text,
  "created_at" timestamp(0),
  "updated_at" timestamp(0)
);

CREATE TABLE "enso_sop_tracking" (
  "id" bigint PRIMARY KEY,
  "student_id" bigint,
  "tracking_date" timestamp(0),
  "notes" text,
  "created_at" timestamp(0),
  "updated_at" timestamp(0),
  "file_id" bigint
);

CREATE TABLE "enso_messages" (
  "id" bigint PRIMARY KEY,
  "sender_id" bigint,
  "subject_message" text,
  "body" text,
  "date_sent" timestamp(0),
  "file_id" bigint
);

CREATE TABLE "enso_recipient_type" (
  "id" bigint PRIMARY KEY,
  "recipient_name" text
);

CREATE TABLE "enso_messages_recipients" (
  "recipient_id" bigint,
  "message_id" bigint,
  "recipient_type_id" bigint,
  PRIMARY KEY ("recipient_id", "message_id", "recipient_type_id")
);

CREATE UNIQUE INDEX "provinces_name_country_id_unique" ON "provinces" ("name", "country_id");

CREATE UNIQUE INDEX "cities_name_province_id_unique" ON "cities" ("name", "province_id");

CREATE UNIQUE INDEX "UK, collection_id_game_id" ON "enso_collections_games" ("collection_id", "game_id");

ALTER TABLE "enso_collections_games_parameters" ADD FOREIGN KEY ("collection_game_id") REFERENCES "enso_collections_games" ("id");

ALTER TABLE "enso_sop_tracking" ADD FOREIGN KEY ("file_id") REFERENCES "enso_files" ("id");

ALTER TABLE "enso_messages" ADD FOREIGN KEY ("file_id") REFERENCES "enso_files" ("id");

ALTER TABLE "provinces" ADD CONSTRAINT "fk_provinces_countries" FOREIGN KEY ("country_id") REFERENCES "countries" ("id") ON DELETE CASCADE;

ALTER TABLE "cities" ADD CONSTRAINT "fk_cities_provinces" FOREIGN KEY ("province_id") REFERENCES "provinces" ("id") ON DELETE CASCADE;

ALTER TABLE "courses" ADD CONSTRAINT "fk_courses_training_areas" FOREIGN KEY ("training_area_id") REFERENCES "training_areas" ("id") ON DELETE CASCADE;

ALTER TABLE "courses" ADD CONSTRAINT "fk_courses_centers" FOREIGN KEY ("center_id") REFERENCES "centers" ("id") ON DELETE CASCADE;

ALTER TABLE "emails" ADD CONSTRAINT "fk_emails_users" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE;

ALTER TABLE "users_data" ADD CONSTRAINT "fk_users_data_users" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE;

ALTER TABLE "users_data" ADD CONSTRAINT "fk_users_data_cities" FOREIGN KEY ("city_id") REFERENCES "cities" ("id") ON DELETE RESTRICT;

ALTER TABLE "users_data" ADD CONSTRAINT "fk_users_data_document_types" FOREIGN KEY ("document_type_id") REFERENCES "document_types" ("id") ON DELETE RESTRICT;

ALTER TABLE "users_courses" ADD CONSTRAINT "fk_users_courses_users" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE;

ALTER TABLE "users_courses" ADD CONSTRAINT "fk_users_courses_courses" FOREIGN KEY ("course_id") REFERENCES "courses" ("id") ON DELETE CASCADE;

ALTER TABLE "users_courses" ADD CONSTRAINT "fk_users_courses_roles" FOREIGN KEY ("role_id") REFERENCES "roles" ("id") ON DELETE CASCADE;

ALTER TABLE "users_roles" ADD CONSTRAINT "fk_users_roles_users" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE;

ALTER TABLE "users_roles" ADD CONSTRAINT "fk_users_roles_roles" FOREIGN KEY ("role_id") REFERENCES "roles" ("id") ON DELETE CASCADE;

ALTER TABLE "enso_tutors" ADD CONSTRAINT "fk_enso_tutors_roles" FOREIGN KEY ("role_id") REFERENCES "roles" ("id");

ALTER TABLE "enso_tutors_students" ADD CONSTRAINT "fk_enso_tutors_students_tutor" FOREIGN KEY ("tutor_id") REFERENCES "enso_tutors" ("id");

ALTER TABLE "enso_tutors_students" ADD CONSTRAINT "fk_enso_tutors_students_student" FOREIGN KEY ("student_id") REFERENCES "users" ("id");

ALTER TABLE "enso_collections_games" ADD CONSTRAINT "fk_enso_collections_games_collection" FOREIGN KEY ("collection_id") REFERENCES "enso_collections" ("id");

ALTER TABLE "enso_collections_games" ADD CONSTRAINT "fk_enso_collections_games_game" FOREIGN KEY ("game_id") REFERENCES "enso_games" ("id");

ALTER TABLE "enso_collections_games_parameters" ADD CONSTRAINT "fk_enso_collections_games_parameters_unidad" FOREIGN KEY ("unidad_id") REFERENCES "enso_unidades_parameters" ("id");

ALTER TABLE "enso_files" ADD CONSTRAINT "fk_enso_files_student" FOREIGN KEY ("student_id") REFERENCES "users" ("id");

ALTER TABLE "enso_sop_tracking" ADD CONSTRAINT "fk_enso_sop_tracking_student" FOREIGN KEY ("student_id") REFERENCES "users" ("id");

ALTER TABLE "enso_messages" ADD CONSTRAINT "fk_enso_messages_sender" FOREIGN KEY ("sender_id") REFERENCES "users" ("id");

ALTER TABLE "enso_messages_recipients" ADD CONSTRAINT "fk_enso_messages_recipients_recipient" FOREIGN KEY ("recipient_id") REFERENCES "users" ("id");

ALTER TABLE "enso_messages_recipients" ADD CONSTRAINT "fk_enso_messages_recipients_message" FOREIGN KEY ("message_id") REFERENCES "enso_messages" ("id");

ALTER TABLE "enso_messages_recipients" ADD CONSTRAINT "fk_enso_messages_recipients_recipient_type" FOREIGN KEY ("recipient_type_id") REFERENCES "enso_recipient_type" ("id");
