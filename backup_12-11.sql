
Table "centers" {
  "id" bigint [pk]
  "name" "character varying(30)" [not null]
  "address" "character varying(100)" [not null]
  "cif" "character varying(9)" [not null]
  "center_code" "character varying(8)" [not null]
  "created_at" timestamp(0)
  "updated_at" timestamp(0)
  "deleted_at" timestamp(0)
}

Table "countries" {
  "id" bigint [pk]
  "name" "character varying(100)" [unique, not null]
  "iso_code" "character varying(10)" [unique, not null]
  "created_at" timestamp(0)
  "updated_at" timestamp(0)
}

Table "provinces" {
  "id" bigint [pk]
  "name" "character varying(100)" [not null]
  "country_id" bigint [not null]
  "created_at" timestamp(0)
  "updated_at" timestamp(0)

  Indexes {
    (name, country_id) [unique, name: "provinces_name_country_id_unique"]
  }
}

Table "cities" {
  "id" bigint [pk]
  "name" "character varying(255)" [not null]
  "province_id" bigint [not null]
  "created_at" timestamp(0)
  "updated_at" timestamp(0)

  Indexes {
    (name, province_id) [unique, name: "cities_name_province_id_unique"]
  }
}

Table "training_areas" {
  "id" bigint [pk]
  "name" "character varying(50)" [not null]
  "description" "character varying(200)"
  "created_at" timestamp(0)
  "updated_at" timestamp(0)
  "deleted_at" timestamp(0)
}

Table "courses" {
  "id" bigint [pk]
  "name" "character varying(150)" [not null]
  "description" "character varying(200)"
  "training_area_id" bigint [not null]
  "center_id" bigint [not null]
  "created_at" timestamp(0)
  "updated_at" timestamp(0)
  "deleted_at" timestamp(0)
  "code" "character varying(10)"
  "study_type" "character varying(10)" [not null]
}

Table "document_types" {
  "id" bigint [pk]
  "name" "character varying(100)" [not null]
  "abbreviation" "character varying(20)" [not null]
  "created_at" timestamp(0)
  "updated_at" timestamp(0)
  "deleted_at" timestamp(0)
}

Table "roles" {
  "id" bigint [pk]
  "name" "character varying(50)" [not null]
  "description" "character varying(255)"
  "created_at" timestamp(0)
  "updated_at" timestamp(0)
}

Table "users" {
  "id" bigint [pk]
  "password" "character varying(255)" [not null]
  "status" "character (50)" [not null]
  "created_at" timestamp(0)
  "updated_at" timestamp(0)
  "deleted_at" timestamp(0)
}

Table "emails" {
  "id" bigint [pk]
  "user_id" bigint [not null]
  "email" text [not null]
  "created_at" timestamp(0)
  "updated_at" timestamp(0)
  "email_hash" "character varying(64)" [unique]
}

Table "users_data" {
  "id" bigint [pk]
  "name" "character varying(50)" [not null]
  "last_name_1" "character varying(50)" [not null]
  "last_name_2" "character varying(50)"
  "birthdate" date [not null]
  "dni" text [unique]
  "address" text [not null]
  "postal_code" text
  "social_security" text
  "health_card" text
  "phone_number" text
  "user_id" bigint [not null]
  "city_id" bigint [not null]
  "document_type_id" bigint [not null]
  "created_at" timestamp(0)
  "updated_at" timestamp(0)
  "deleted_at" timestamp(0)
  "identification" "character varying(64)"
  "lat" text
  "lon" text
  "social_security_path" "character varying(255)"
  "passport" text
  "nie" text
}

Table "users_courses" {
  "id" bigint [pk]
  "academic_course" "character varying(10)" [not null]
  "user_id" bigint [not null]
  "course_id" bigint [not null]
  "role_id" bigint [not null]
  "created_at" timestamp(0)
  "updated_at" timestamp(0)
  "deleted_at" timestamp(0)
  "year_level" integer
  "is_withdrawn" boolean
}

Table "users_roles" {
  "user_id" bigint [not null]
  "role_id" bigint [not null]
  "created_at" timestamp(0)
  "updated_at" timestamp(0)

  Indexes {
    (user_id, role_id) [pk]
  }
}

Table "enso_tutors" {
  "id_tutor" integer [pk]
  "id_role" integer
  "name" "character varying(50)" [not null]
  "last_name_1" "character varying(50)" [not null]
  "last_name_2" "character varying(50)"
  "birthdate" date [not null]
  "dni" text [unique]
  "address" text [not null]
  "postal_code" text
  "phone_number" text
  "email" varchar(320) [unique, not null]
  "created_at" timestamp(0)
  "updated_at" timestamp(0)
}

Table "enso_tutors_students" {
  "id_tutor" integer
  "id_student" integer

  Indexes {
    (id_tutor, id_student) [pk, name: "pk_tutors_students"]
  }
}

Table "enso_games" {
  "id_game" integer [pk]
  "game_name" varchar(50) [unique, not null]
  "game_description" text
  "game_path" text
  "created_at" timestamp(0)
  "updated_at" timestamp(0)
}

Table "enso_collections" {
  "id_collection" integer [pk]
  "collection_name" varchar(50) [not null]
  "collection_description" text
  "created_at" timestamp(0)
  "updated_at" timestamp(0)
}

Table "enso_collections_games" {
  "id" integer [pk]
  "id_collection" integer
  "id_game" integer
  "id_parameter" integer
  "created_at" timestamp(0)
  "updated_at" timestamp(0)
}

Table "enso_unidades_parameters" {
  "id_unidad" integer [pk]
  "unidad_name" text
}

Table "enso_collections_games_parameters" {
  "id_parameter" integer [pk]
  "id_unidad" integer
  "minimum" integer
  "maximum" integer
  "created_at" timestamp(0)
  "updated_at" timestamp(0)
}

Table "enso_files" {
  "id_file" integer [pk]
  "id_student" integer
  "file_name" text
  "file_path" text
  "created_at" timestamp(0)
  "updated_at" timestamp(0)
}

Table "enso_sop_tracking" {
  "id_tracking" integer [pk]
  "id_student" integer
  "tracking_date" timestamp(0)
  "notes" text
  "created_at" timestamp(0)
  "updated_at" timestamp(0)
}

Table "enso_messages" {
  "id_message" integer [pk]
  "id_sender" integer
  "subject_message" text 
  "body" text
  "date_sent" timestamp(0)
}

Table "enso_recipient_type" {
  "id_recipient" integer [pk]
  "recipient_name" text
}

Table "enso_messages_recipients" {
  "id_recipient" integer
  "id_message" integer
  "id_recipient_type" integer

  Indexes {
    (id_recipient, id_message, id_recipient_type) [pk, name: "pk_users_interests"]
  }
}

Ref "provinces_country_id_foreign":"countries"."id" < "provinces"."country_id" [delete: cascade]

Ref "cities_province_id_foreign":"provinces"."id" < "cities"."province_id" [delete: cascade]

Ref "courses_training_area_id_foreign":"training_areas"."id" < "courses"."training_area_id" [delete: cascade]

Ref "courses_center_id_foreign":"centers"."id" < "courses"."center_id" [delete: cascade]

Ref "emails_user_id_foreign":"users"."id" < "emails"."user_id" [delete: cascade]

Ref "users_data_user_id_foreign":"users"."id" < "users_data"."user_id" [delete: cascade]

Ref "users_data_city_id_foreign":"cities"."id" < "users_data"."city_id" [delete: restrict]

Ref "users_data_document_type_id_foreign":"document_types"."id" < "users_data"."document_type_id" [delete: restrict]

Ref "users_courses_user_id_foreign":"users"."id" < "users_courses"."user_id" [delete: cascade]

Ref "users_courses_course_id_foreign":"courses"."id" < "users_courses"."course_id" [delete: cascade]

Ref "users_courses_role_id_foreign":"roles"."id" < "users_courses"."role_id" [delete: cascade]

Ref "users_roles_user_id_foreign":"users"."id" < "users_roles"."user_id" [delete: cascade]

Ref "users_roles_role_id_foreign":"roles"."id" < "users_roles"."role_id" [delete: cascade]

Ref "fk_tutors_id_role":"roles"."id" < "enso_tutors"."id_role"

Ref "fk_tutors_students_id_tutor":"enso_tutors"."id_tutor" < "enso_tutors_students"."id_tutor"

Ref "fk_tutors_students_id_student":"users"."id" < "enso_tutors_students"."id_student"

Ref "fk_parameters_id_unidad":"enso_unidades_parameters"."id" < "enso_collections_games_parameters"."id"

Ref "fk_enso_messages_id_sender":"enso_messages"."id_sender" < "users"."id"

Ref "fk_enso_messages_recipients_id_recipient":"users"."id" < "enso_messages_recipients"."id_recipient"

Ref "fk_enso_messages_recipients_id_message":"enso_messages"."id" < "enso_messages_recipients"."id"

Ref "fk_enso_messages_recipients_id_recipient":"users"."id" < "enso_messages_recipients"."id_recipient"

Ref "fk_enso_messages_recipients_id_message":"enso_messages"."id_message" < "enso_messages_recipients"."id_message"

Ref "fk_collections_games_id_collection":"enso_collections_games"."id_collection" < "enso_collections"."id_collection"

Ref "fk_collections_games_id_game":"enso_collections_games"."id_game" < "enso_games"."id_game"

