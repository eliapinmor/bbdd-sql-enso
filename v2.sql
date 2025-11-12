Table centers {
  id bigint [pk]
  name varchar(30) [not null]
  address varchar(100) [not null]
  cif varchar(9) [not null]
  center_code varchar(8) [not null]
  created_at timestamp(0)
  updated_at timestamp(0)
  deleted_at timestamp(0)
}
 
Table countries {
  id bigint [pk]
  name varchar(100) [unique, not null]
  iso_code varchar(10) [unique, not null]
  created_at timestamp(0)
  updated_at timestamp(0)
}
 
Table provinces {
  id bigint [pk]
  name varchar(100) [not null]
  country_id bigint [not null]
  created_at timestamp(0)
  updated_at timestamp(0)
 
  Indexes {
    (name, country_id) [unique, name: "provinces_name_country_id_unique"]
  }
}
 
Table cities {
  id bigint [pk]
  name varchar(255) [not null]
  province_id bigint [not null]
  created_at timestamp(0)
  updated_at timestamp(0)
 
  Indexes {
    (name, province_id) [unique, name: "cities_name_province_id_unique"]
  }
}
 
Table training_areas {
  id bigint [pk]
  name varchar(50) [not null]
  description varchar(200)
  created_at timestamp(0)
  updated_at timestamp(0)
  deleted_at timestamp(0)
}
 
Table courses {
  id bigint [pk]
  name varchar(150) [not null]
  description varchar(200)
  training_area_id bigint [not null]
  center_id bigint [not null]
  created_at timestamp(0)
  updated_at timestamp(0)
  deleted_at timestamp(0)
  code varchar(10)
  study_type varchar(10) [not null]
}
 
Table document_types {
  id bigint [pk]
  name varchar(100) [not null]
  abbreviation varchar(20) [not null]
  created_at timestamp(0)
  updated_at timestamp(0)
  deleted_at timestamp(0)
}
 
Table roles {
  id bigint [pk]
  name varchar(50) [not null]
  description varchar(255)
  created_at timestamp(0)
  updated_at timestamp(0)
}
 
Table users {
  id bigint [pk]
  password varchar(255) [not null]
  status varchar(50) [not null]
  created_at timestamp(0)
  updated_at timestamp(0)
  deleted_at timestamp(0)
}
 
Table emails {
  id bigint [pk]
  user_id bigint [not null]
  email text [not null]
  created_at timestamp(0)
  updated_at timestamp(0)
  email_hash varchar(64) [unique]
}
 
Table users_data {
  id bigint [pk]
  name varchar(50) [not null]
  last_name_1 varchar(50) [not null]
  last_name_2 varchar(50)
  birthdate date [not null]
  dni text [unique]
  address text [not null]
  postal_code text
  social_security text
  health_card text
  phone_number text
  user_id bigint [not null]
  city_id bigint [not null]
  document_type_id bigint [not null]
  created_at timestamp(0)
  updated_at timestamp(0)
  deleted_at timestamp(0)
  identification varchar(64)
  lat text
  lon text
  social_security_path varchar(255)
  passport text
  nie text
}
 
Table users_courses {
  id bigint [pk]
  academic_course varchar(10) [not null]
  user_id bigint [not null]
  course_id bigint [not null]
  role_id bigint [not null]
  created_at timestamp(0)
  updated_at timestamp(0)
  deleted_at timestamp(0)
  year_level integer
  is_withdrawn boolean
}
 
Table users_roles {
  user_id bigint [not null]
  role_id bigint [not null]
  created_at timestamp(0)
  updated_at timestamp(0)
 
  Indexes {
    (user_id, role_id) [pk]
  }
}
 
Table enso_tutors {
  id integer [pk]
  role_id integer
  name varchar(50) [not null]
  last_name_1 varchar(50) [not null]
  last_name_2 varchar(50)
  birthdate date [not null]
  dni text [unique]
  address text [not null]
  postal_code text
  phone_number text
  email varchar(320) [unique, not null]
  created_at timestamp(0)
  updated_at timestamp(0)
}
 
Table enso_tutors_students {
  tutor_id integer
  student_id integer
 
  Indexes {
    (tutor_id, student_id) [pk, name: "pk_tutors_students"]
  }
}
 
Table enso_games {
  id integer [pk]
  game_name varchar(50) [unique, not null]
  game_description text
  game_path text
  created_at timestamp(0)
  updated_at timestamp(0)
}
 
Table enso_collections {
  id integer [pk]
  collection_name varchar(50) [not null]
  collection_description text
  created_at timestamp(0)
  updated_at timestamp(0)
}
 
Table enso_collections_games {
  id integer [pk]
  collection_id integer
  game_id integer
  parameter_id integer
  created_at timestamp(0)
  updated_at timestamp(0)
}
 
Table enso_unidades_parameters {
  id integer [pk]
  unidad_name text
}
 
Table enso_collections_games_parameters {
  id integer [pk]
  unidad_id integer
  minimum integer
  maximum integer
  created_at timestamp(0)
  updated_at timestamp(0)
}
 
Table enso_files {
  id integer [pk]
  student_id integer
  file_name text
  file_path text
  created_at timestamp(0)
  updated_at timestamp(0)
}
 
Table enso_sop_tracking {
  id integer [pk]
  student_id integer
  tracking_date timestamp(0)
  notes text
  created_at timestamp(0)
  updated_at timestamp(0)
}
 
Table enso_messages {
  id integer [pk]
  sender_id integer
  subject_message text
  body text
  date_sent timestamp(0)
}
 
Table enso_recipient_type {
  id integer [pk]
  recipient_name text
}
 
Table enso_messages_recipients {
  recipient_id integer
  message_id integer
  recipient_type_id integer
 
  Indexes {
    (recipient_id, message_id, recipient_type_id) [pk, name: "pk_users_interests"]
  }
}
 
Ref fk_provinces_countries: countries.id < provinces.country_id [delete: cascade]
Ref fk_cities_provinces: provinces.id < cities.province_id [delete: cascade]
Ref fk_courses_training_areas: training_areas.id < courses.training_area_id [delete: cascade]
Ref fk_courses_centers: centers.id < courses.center_id [delete: cascade]
Ref fk_emails_users: users.id < emails.user_id [delete: cascade]
Ref fk_users_data_users: users.id < users_data.user_id [delete: cascade]
Ref fk_users_data_cities: cities.id < users_data.city_id [delete: restrict]
Ref fk_users_data_document_types: document_types.id < users_data.document_type_id [delete: restrict]
Ref fk_users_courses_users: users.id < users_courses.user_id [delete: cascade]
Ref fk_users_courses_courses: courses.id < users_courses.course_id [delete: cascade]
Ref fk_users_courses_roles: roles.id < users_courses.role_id [delete: cascade]
Ref fk_users_roles_users: users.id < users_roles.user_id [delete: cascade]
Ref fk_users_roles_roles: roles.id < users_roles.role_id [delete: cascade]
Ref fk_enso_tutors_roles: roles.id < enso_tutors.role_id
Ref fk_enso_tutors_students_tutor: enso_tutors.id < enso_tutors_students.tutor_id
Ref fk_enso_tutors_students_student: users.id < enso_tutors_students.student_id
Ref fk_enso_collections_games_collection: enso_collections.id < enso_collections_games.collection_id
Ref fk_enso_collections_games_game: enso_games.id < enso_collections_games.game_id
Ref fk_enso_collections_games_parameters_unidad: enso_unidades_parameters.id < enso_collections_games_parameters.unidad_id
Ref fk_enso_files_student: users.id < enso_files.student_id
Ref fk_enso_sop_tracking_student: users.id < enso_sop_tracking.student_id
Ref fk_enso_messages_sender: users.id < enso_messages.sender_id
Ref fk_enso_messages_recipients_recipient: users.id < enso_messages_recipients.recipient_id
Ref fk_enso_messages_recipients_message: enso_messages.id < enso_messages_recipients.message_id
Ref fk_enso_messages_recipients_recipient_type: enso_recipient_type.id < enso_messages_recipients.recipient_type_id
