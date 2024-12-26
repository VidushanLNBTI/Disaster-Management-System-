BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_time"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"last_name"	varchar(150) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"first_name"	varchar(150) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
CREATE TABLE IF NOT EXISTS "app_disaster" (
	"id"	integer NOT NULL,
	"description"	varchar(45) NOT NULL,
	"date"	date NOT NULL,
	"time"	time NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "app_identification" (
	"id"	integer NOT NULL,
	"safety_area"	varchar(1000) NOT NULL,
	"risky_area"	varchar(1000) NOT NULL,
	"affected_area"	varchar(1000) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "app_guidelines" (
	"id"	integer NOT NULL,
	"before_disaster"	text NOT NULL,
	"after_disaster"	text NOT NULL,
	"during_disaster"	text NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "app_divisionalsecretariat" (
	"id"	integer NOT NULL,
	"name"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "app_gramaniladharidivision" (
	"id"	integer NOT NULL,
	"name"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "app_village" (
	"id"	integer NOT NULL,
	"name"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "app_locationdisaster" (
	"id"	integer NOT NULL,
	"location_id"	bigint NOT NULL,
	"disaster_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("location_id") REFERENCES "app_location"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("disaster_id") REFERENCES "app_disaster"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "app_village_disasters" (
	"id"	integer NOT NULL,
	"village_id"	bigint NOT NULL,
	"disaster_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("village_id") REFERENCES "app_village"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("disaster_id") REFERENCES "app_disaster"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "app_villagedisaster" (
	"id"	integer NOT NULL,
	"disaster_id"	bigint NOT NULL,
	"village_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("disaster_id") REFERENCES "app_disaster"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("village_id") REFERENCES "app_location"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "app_refugee" (
	"id"	integer NOT NULL,
	"name"	varchar(45) NOT NULL,
	"address"	varchar(45) NOT NULL,
	"age"	integer NOT NULL,
	"dob"	date NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "app_location" (
	"id"	integer NOT NULL,
	"name"	varchar(255),
	"latitude"	real NOT NULL,
	"longitude"	real NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "app_camp" (
	"id"	integer NOT NULL,
	"name"	varchar(45) NOT NULL,
	"no_of_refugee"	integer NOT NULL,
	"casualities"	integer NOT NULL,
	"availability_status_of_food"	varchar(10) NOT NULL,
	"availability_status_of_resources"	varchar(10) NOT NULL,
	"medical_needs"	varchar(1000),
	"special_needs"	varchar(1000),
	"latitude"	real NOT NULL,
	"longitude"	real NOT NULL,
	"location"	varchar(255),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "app_waterlevel" (
	"id"	integer NOT NULL,
	"timestamp"	datetime NOT NULL,
	"water_level"	real NOT NULL,
	"location_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("location_id") REFERENCES "app_location"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "app_userprofile" (
	"id"	integer NOT NULL,
	"contact_number1"	varchar(20),
	"contact_number2"	varchar(20),
	"address"	text,
	"profile_image"	varchar(100),
	"user_id"	integer NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
INSERT INTO "django_migrations" VALUES (1,'contenttypes','0001_initial','2023-05-20 11:55:12.838269');
INSERT INTO "django_migrations" VALUES (2,'auth','0001_initial','2023-05-20 11:55:13.649286');
INSERT INTO "django_migrations" VALUES (3,'admin','0001_initial','2023-05-20 11:55:14.630474');
INSERT INTO "django_migrations" VALUES (4,'admin','0002_logentry_remove_auto_add','2023-05-20 11:55:15.115268');
INSERT INTO "django_migrations" VALUES (5,'admin','0003_logentry_add_action_flag_choices','2023-05-20 11:55:15.574937');
INSERT INTO "django_migrations" VALUES (6,'contenttypes','0002_remove_content_type_name','2023-05-20 11:55:16.024637');
INSERT INTO "django_migrations" VALUES (7,'auth','0002_alter_permission_name_max_length','2023-05-20 11:55:16.450203');
INSERT INTO "django_migrations" VALUES (8,'auth','0003_alter_user_email_max_length','2023-05-20 11:55:16.866620');
INSERT INTO "django_migrations" VALUES (9,'auth','0004_alter_user_username_opts','2023-05-20 11:55:17.274082');
INSERT INTO "django_migrations" VALUES (10,'auth','0005_alter_user_last_login_null','2023-05-20 11:55:17.700564');
INSERT INTO "django_migrations" VALUES (11,'auth','0006_require_contenttypes_0002','2023-05-20 11:55:18.052394');
INSERT INTO "django_migrations" VALUES (12,'auth','0007_alter_validators_add_error_messages','2023-05-20 11:55:18.467683');
INSERT INTO "django_migrations" VALUES (13,'auth','0008_alter_user_username_max_length','2023-05-20 11:55:18.878288');
INSERT INTO "django_migrations" VALUES (14,'auth','0009_alter_user_last_name_max_length','2023-05-20 11:55:19.305151');
INSERT INTO "django_migrations" VALUES (15,'auth','0010_alter_group_name_max_length','2023-05-20 11:55:19.834858');
INSERT INTO "django_migrations" VALUES (16,'auth','0011_update_proxy_permissions','2023-05-20 11:55:20.271947');
INSERT INTO "django_migrations" VALUES (17,'auth','0012_alter_user_first_name_max_length','2023-05-20 11:55:20.697869');
INSERT INTO "django_migrations" VALUES (18,'sessions','0001_initial','2023-05-20 11:55:21.422056');
INSERT INTO "django_migrations" VALUES (19,'app','0001_initial','2023-05-20 18:30:35.187437');
INSERT INTO "django_migrations" VALUES (20,'app','0002_alter_refugee_dob','2023-05-21 05:35:10.747861');
INSERT INTO "django_migrations" VALUES (21,'app','0003_disaster_guidelines_and_more','2023-05-30 18:37:18.095871');
INSERT INTO "django_migrations" VALUES (22,'app','0004_remove_guidelines_during_disatser_and_more','2023-06-04 16:06:10.384984');
INSERT INTO "django_migrations" VALUES (23,'app','0005_identification_location_and_more','2023-06-05 04:10:38.636905');
INSERT INTO "django_migrations" VALUES (24,'app','0006_province','2023-06-10 19:27:43.280087');
INSERT INTO "django_migrations" VALUES (25,'app','0007_alter_province_name','2023-06-10 19:27:43.714073');
INSERT INTO "django_migrations" VALUES (26,'app','0008_delete_province','2023-06-15 19:26:36.938019');
INSERT INTO "django_migrations" VALUES (27,'app','0009_divisionalsecretariat','2023-06-15 19:27:43.253576');
INSERT INTO "django_migrations" VALUES (28,'app','0010_gramaniladharidivision','2023-06-15 19:59:02.402388');
INSERT INTO "django_migrations" VALUES (29,'app','0011_village','2023-06-15 20:40:00.265130');
INSERT INTO "django_migrations" VALUES (30,'app','0012_location_disasters_locationdisaster','2023-08-25 17:39:39.561871');
INSERT INTO "django_migrations" VALUES (31,'app','0013_rename_disaster_locationdisaster_disaster_and_more','2023-08-25 17:42:53.983391');
INSERT INTO "django_migrations" VALUES (32,'app','0014_alter_camp_options_alter_locationdisaster_options_and_more','2023-08-27 06:33:35.304479');
INSERT INTO "django_migrations" VALUES (33,'app','0015_alter_location_name','2023-08-28 19:18:10.334319');
INSERT INTO "django_migrations" VALUES (34,'app','0016_alter_refugee_age_alter_refugee_dob','2023-09-07 18:47:48.095338');
INSERT INTO "django_migrations" VALUES (35,'app','0017_alter_refugee_age_alter_refugee_dob','2023-09-07 18:59:35.717179');
INSERT INTO "django_migrations" VALUES (36,'app','0018_remove_location_disasters','2023-09-08 16:47:14.763324');
INSERT INTO "django_migrations" VALUES (37,'app','0019_alter_location_latitude_alter_location_longitude','2024-01-21 09:32:01.206252');
INSERT INTO "django_migrations" VALUES (38,'app','0020_camp_latitude_camp_longitude_alter_camp_location','2024-01-21 12:21:37.095388');
INSERT INTO "django_migrations" VALUES (39,'app','0021_waterlevel','2024-01-22 17:00:01.914003');
INSERT INTO "django_migrations" VALUES (40,'app','0022_userprofile','2024-01-25 10:15:37.699716');
INSERT INTO "django_migrations" VALUES (41,'app','0023_alter_refugee_options','2024-01-25 11:59:42.175730');
INSERT INTO "django_migrations" VALUES (42,'app','0024_alter_camp_options_alter_refugee_options','2024-01-25 12:00:04.925839');
INSERT INTO "auth_group_permissions" VALUES (1,1,32);
INSERT INTO "auth_group_permissions" VALUES (2,1,64);
INSERT INTO "auth_group_permissions" VALUES (3,1,36);
INSERT INTO "auth_group_permissions" VALUES (4,1,68);
INSERT INTO "auth_group_permissions" VALUES (5,1,40);
INSERT INTO "auth_group_permissions" VALUES (6,1,72);
INSERT INTO "auth_group_permissions" VALUES (7,1,44);
INSERT INTO "auth_group_permissions" VALUES (8,1,60);
INSERT INTO "auth_group_permissions" VALUES (9,1,48);
INSERT INTO "auth_group_permissions" VALUES (10,1,52);
INSERT INTO "auth_group_permissions" VALUES (11,1,56);
INSERT INTO "auth_group_permissions" VALUES (12,1,28);
INSERT INTO "auth_group_permissions" VALUES (13,2,68);
INSERT INTO "auth_group_permissions" VALUES (14,2,40);
INSERT INTO "auth_group_permissions" VALUES (15,2,73);
INSERT INTO "auth_group_permissions" VALUES (16,2,74);
INSERT INTO "auth_group_permissions" VALUES (17,2,75);
INSERT INTO "auth_group_permissions" VALUES (18,2,76);
INSERT INTO "auth_group_permissions" VALUES (19,2,72);
INSERT INTO "auth_group_permissions" VALUES (20,2,28);
INSERT INTO "auth_group_permissions" VALUES (21,2,48);
INSERT INTO "auth_group_permissions" VALUES (22,2,32);
INSERT INTO "auth_group_permissions" VALUES (23,2,36);
INSERT INTO "auth_group_permissions" VALUES (24,2,86);
INSERT INTO "auth_user_groups" VALUES (1,4,2);
INSERT INTO "auth_user_groups" VALUES (2,2,1);
INSERT INTO "auth_user_groups" VALUES (3,30,2);
INSERT INTO "auth_user_groups" VALUES (4,28,2);
INSERT INTO "auth_user_groups" VALUES (5,33,2);
INSERT INTO "auth_user_user_permissions" VALUES (2,33,86);
INSERT INTO "django_admin_log" VALUES (1,'2','Sarah',1,'[{"added": {}}]',4,1,'2023-05-20 11:57:55.810799');
INSERT INTO "django_admin_log" VALUES (2,'3','Kumudu',1,'[{"added": {}}]',4,1,'2023-05-20 11:58:24.062804');
INSERT INTO "django_admin_log" VALUES (3,'1','Camp object (1)',2,'[{"changed": {"fields": ["Location", "No of refugee"]}}]',7,1,'2023-05-21 06:59:45.596827');
INSERT INTO "django_admin_log" VALUES (4,'1','Community',1,'[{"added": {}}]',3,1,'2023-08-27 05:48:08.304593');
INSERT INTO "django_admin_log" VALUES (5,'2','Manager',1,'[{"added": {}}]',3,1,'2023-08-27 06:36:07.137287');
INSERT INTO "django_admin_log" VALUES (6,'4','Kasun',2,'[{"changed": {"fields": ["Groups"]}}]',4,1,'2023-08-27 06:37:09.021262');
INSERT INTO "django_admin_log" VALUES (7,'3','Kumudu',2,'[]',4,1,'2023-08-27 06:37:18.610954');
INSERT INTO "django_admin_log" VALUES (8,'2','Sarah',2,'[{"changed": {"fields": ["Groups"]}}]',4,1,'2023-08-27 06:37:34.535001');
INSERT INTO "django_admin_log" VALUES (9,'2','Manager',2,'[{"changed": {"fields": ["Permissions"]}}]',3,1,'2023-08-27 16:27:07.725857');
INSERT INTO "django_admin_log" VALUES (10,'9','Jane',3,'',4,1,'2023-09-07 07:38:53.013136');
INSERT INTO "django_admin_log" VALUES (11,'11','ivar',3,'',4,1,'2023-09-07 07:43:57.877826');
INSERT INTO "django_admin_log" VALUES (12,'12','jahseh',3,'',4,1,'2023-09-07 07:51:52.648735');
INSERT INTO "django_admin_log" VALUES (13,'13','Thadi',3,'',4,1,'2023-09-07 07:58:57.902633');
INSERT INTO "django_admin_log" VALUES (14,'14','Hashan',3,'',4,1,'2023-09-07 08:03:56.860502');
INSERT INTO "django_admin_log" VALUES (15,'15','Jama',3,'',4,1,'2023-09-07 08:33:01.583318');
INSERT INTO "django_admin_log" VALUES (16,'16','Saman',3,'',4,1,'2023-09-07 08:40:27.942652');
INSERT INTO "django_admin_log" VALUES (17,'24','Ranja',3,'',4,1,'2023-10-10 13:28:09.055946');
INSERT INTO "django_admin_log" VALUES (18,'29','Ranja',2,'[{"changed": {"fields": ["First name", "Last name"]}}]',4,1,'2023-10-16 17:22:56.066555');
INSERT INTO "django_admin_log" VALUES (19,'29','Ranja',3,'',4,1,'2023-10-31 15:56:08.453661');
INSERT INTO "django_admin_log" VALUES (20,'30','Ranja',2,'[{"changed": {"fields": ["Groups"]}}]',4,1,'2023-12-03 05:42:24.366371');
INSERT INTO "django_admin_log" VALUES (21,'2','Manager',2,'[{"changed": {"fields": ["Permissions"]}}]',3,1,'2023-12-03 05:49:03.291136');
INSERT INTO "django_admin_log" VALUES (22,'28','Dew',2,'[{"changed": {"fields": ["Groups"]}}]',4,1,'2023-12-06 05:12:14.178699');
INSERT INTO "django_admin_log" VALUES (23,'14','Bandarawela',1,'[{"added": {}}]',12,1,'2024-01-21 09:59:08.842740');
INSERT INTO "django_admin_log" VALUES (24,'15','Rathnapura',1,'[{"added": {}}]',12,1,'2024-01-21 10:18:19.645514');
INSERT INTO "django_admin_log" VALUES (25,'13','Unnamed Location',3,'',12,1,'2024-01-21 11:44:06.156855');
INSERT INTO "django_admin_log" VALUES (26,'12','Unnamed Location',3,'',12,1,'2024-01-21 11:44:08.517607');
INSERT INTO "django_admin_log" VALUES (27,'11','Unnamed Location',3,'',12,1,'2024-01-21 11:44:08.604770');
INSERT INTO "django_admin_log" VALUES (28,'10','Unnamed Location',3,'',12,1,'2024-01-21 11:44:08.688399');
INSERT INTO "django_admin_log" VALUES (29,'9','Unnamed Location',3,'',12,1,'2024-01-21 11:44:08.776890');
INSERT INTO "django_admin_log" VALUES (30,'15','Rathnapura',3,'',12,1,'2024-01-21 11:44:34.060764');
INSERT INTO "django_admin_log" VALUES (31,'8','Rathnapura',3,'',12,1,'2024-01-21 11:47:39.473879');
INSERT INTO "django_admin_log" VALUES (32,'20','Rathnapura',1,'[{"added": {}}]',12,1,'2024-01-21 11:48:04.487054');
INSERT INTO "django_admin_log" VALUES (33,'55','Camp object (55)',3,'',7,1,'2024-01-21 18:04:16.284044');
INSERT INTO "django_admin_log" VALUES (34,'54','Camp object (54)',3,'',7,1,'2024-01-21 18:04:18.775218');
INSERT INTO "django_admin_log" VALUES (35,'53','Camp object (53)',3,'',7,1,'2024-01-21 18:04:18.866835');
INSERT INTO "django_admin_log" VALUES (36,'52','Camp object (52)',3,'',7,1,'2024-01-21 18:04:18.951245');
INSERT INTO "django_admin_log" VALUES (37,'51','Camp object (51)',3,'',7,1,'2024-01-21 18:04:19.036503');
INSERT INTO "django_admin_log" VALUES (38,'50','Camp object (50)',3,'',7,1,'2024-01-21 18:04:19.146419');
INSERT INTO "django_admin_log" VALUES (39,'49','Camp object (49)',3,'',7,1,'2024-01-21 18:04:19.219130');
INSERT INTO "django_admin_log" VALUES (40,'48','Camp object (48)',3,'',7,1,'2024-01-21 18:04:19.317675');
INSERT INTO "django_admin_log" VALUES (41,'47','Camp object (47)',3,'',7,1,'2024-01-21 18:04:19.400190');
INSERT INTO "django_admin_log" VALUES (42,'46','Camp object (46)',3,'',7,1,'2024-01-21 18:04:19.486559');
INSERT INTO "django_admin_log" VALUES (43,'45','Camp object (45)',3,'',7,1,'2024-01-21 18:04:19.567553');
INSERT INTO "django_admin_log" VALUES (44,'44','Camp object (44)',3,'',7,1,'2024-01-21 18:04:19.655097');
INSERT INTO "django_admin_log" VALUES (45,'43','Camp object (43)',3,'',7,1,'2024-01-21 18:04:19.733332');
INSERT INTO "django_admin_log" VALUES (46,'42','Camp object (42)',3,'',7,1,'2024-01-21 18:04:19.826302');
INSERT INTO "django_admin_log" VALUES (47,'41','Camp object (41)',3,'',7,1,'2024-01-21 18:04:19.907117');
INSERT INTO "django_admin_log" VALUES (48,'40','Camp object (40)',3,'',7,1,'2024-01-21 18:04:19.995954');
INSERT INTO "django_admin_log" VALUES (49,'39','Camp object (39)',3,'',7,1,'2024-01-21 18:04:20.068401');
INSERT INTO "django_admin_log" VALUES (50,'38','Camp object (38)',3,'',7,1,'2024-01-21 18:04:20.166655');
INSERT INTO "django_admin_log" VALUES (51,'37','Camp object (37)',3,'',7,1,'2024-01-21 18:04:20.250524');
INSERT INTO "django_admin_log" VALUES (52,'36','Camp object (36)',3,'',7,1,'2024-01-21 18:04:20.335687');
INSERT INTO "django_admin_log" VALUES (53,'35','Camp object (35)',3,'',7,1,'2024-01-21 18:04:20.419568');
INSERT INTO "django_admin_log" VALUES (54,'34','Camp object (34)',3,'',7,1,'2024-01-21 18:04:20.506103');
INSERT INTO "django_admin_log" VALUES (55,'33','Camp object (33)',3,'',7,1,'2024-01-21 18:04:20.591470');
INSERT INTO "django_admin_log" VALUES (56,'32','Camp object (32)',3,'',7,1,'2024-01-21 18:04:20.687515');
INSERT INTO "django_admin_log" VALUES (57,'31','Camp object (31)',3,'',7,1,'2024-01-21 18:04:20.767057');
INSERT INTO "django_admin_log" VALUES (58,'30','Camp object (30)',3,'',7,1,'2024-01-21 18:04:20.850993');
INSERT INTO "django_admin_log" VALUES (59,'29','Camp object (29)',3,'',7,1,'2024-01-21 18:04:20.937064');
INSERT INTO "django_admin_log" VALUES (60,'28','Camp object (28)',3,'',7,1,'2024-01-21 18:04:21.026883');
INSERT INTO "django_admin_log" VALUES (61,'27','Camp object (27)',3,'',7,1,'2024-01-21 18:04:21.101372');
INSERT INTO "django_admin_log" VALUES (62,'26','Camp object (26)',3,'',7,1,'2024-01-21 18:04:21.195715');
INSERT INTO "django_admin_log" VALUES (63,'25','Camp object (25)',3,'',7,1,'2024-01-21 18:04:21.282105');
INSERT INTO "django_admin_log" VALUES (64,'24','Camp object (24)',3,'',7,1,'2024-01-21 18:04:21.366769');
INSERT INTO "django_admin_log" VALUES (65,'23','Camp object (23)',3,'',7,1,'2024-01-21 18:04:21.450959');
INSERT INTO "django_admin_log" VALUES (66,'22','Camp object (22)',3,'',7,1,'2024-01-21 18:04:21.536908');
INSERT INTO "django_admin_log" VALUES (67,'21','Camp object (21)',3,'',7,1,'2024-01-21 18:04:21.620103');
INSERT INTO "django_admin_log" VALUES (68,'20','Camp object (20)',3,'',7,1,'2024-01-21 18:04:21.702288');
INSERT INTO "django_admin_log" VALUES (69,'12','Camp object (12)',3,'',7,1,'2024-01-21 18:05:09.738160');
INSERT INTO "django_admin_log" VALUES (70,'19','Camp object (19)',3,'',7,1,'2024-01-21 18:05:43.486026');
INSERT INTO "django_admin_log" VALUES (71,'17','Camp object (17)',3,'',7,1,'2024-01-21 18:06:01.588286');
INSERT INTO "django_admin_log" VALUES (72,'16','Camp object (16)',3,'',7,1,'2024-01-21 18:06:22.039755');
INSERT INTO "django_admin_log" VALUES (73,'14','Camp object (14)',3,'',7,1,'2024-01-21 18:06:22.482670');
INSERT INTO "django_admin_log" VALUES (74,'13','Camp object (13)',3,'',7,1,'2024-01-21 18:06:22.582882');
INSERT INTO "django_admin_log" VALUES (75,'11','Camp object (11)',3,'',7,1,'2024-01-21 18:06:22.667365');
INSERT INTO "django_admin_log" VALUES (76,'10','Camp object (10)',3,'',7,1,'2024-01-21 18:06:22.750350');
INSERT INTO "django_admin_log" VALUES (77,'7','Ellagawa',3,'',12,1,'2024-01-21 18:06:58.368690');
INSERT INTO "django_admin_log" VALUES (78,'3','Putupaula',3,'',12,1,'2024-01-21 18:06:58.881748');
INSERT INTO "django_admin_log" VALUES (79,'2','Millakanda',3,'',12,1,'2024-01-21 18:06:58.971402');
INSERT INTO "django_admin_log" VALUES (80,'1','Magura',3,'',12,1,'2024-01-21 18:06:59.057859');
INSERT INTO "django_admin_log" VALUES (81,'6','Anuradhapura',3,'',12,1,'2024-01-21 18:07:20.376455');
INSERT INTO "django_admin_log" VALUES (82,'33','Piyumi',2,'[{"changed": {"fields": ["Groups"]}}]',4,1,'2024-01-25 08:23:23.958198');
INSERT INTO "django_admin_log" VALUES (83,'33','Piyumi',2,'[{"changed": {"fields": ["User permissions"]}}]',4,1,'2024-01-25 08:24:39.504511');
INSERT INTO "django_admin_log" VALUES (84,'33','Piyumi',2,'[]',4,1,'2024-01-25 08:24:39.694634');
INSERT INTO "django_admin_log" VALUES (85,'33','Piyumi',2,'[{"changed": {"fields": ["User permissions"]}}]',4,1,'2024-01-25 12:04:51.587385');
INSERT INTO "django_admin_log" VALUES (86,'2','Manager',2,'[{"changed": {"fields": ["Permissions"]}}]',3,1,'2024-01-25 12:05:24.759783');
INSERT INTO "django_admin_log" VALUES (87,'34','Isuri',3,'',4,1,'2024-01-25 13:17:40.256802');
INSERT INTO "django_admin_log" VALUES (88,'36','Isuri',3,'',4,1,'2024-01-25 13:29:17.922892');
INSERT INTO "django_admin_log" VALUES (89,'24','millakanda',3,'',12,1,'2024-01-25 13:45:38.770093');
INSERT INTO "django_admin_log" VALUES (90,'23','Magura',3,'',12,1,'2024-01-25 14:53:03.191798');
INSERT INTO "django_admin_log" VALUES (91,'22','Rath',3,'',12,1,'2024-01-25 14:53:03.604076');
INSERT INTO "django_admin_log" VALUES (92,'79','Camp object (79)',2,'[{"changed": {"fields": ["Casualities"]}}]',7,1,'2024-01-25 16:02:18.278607');
INSERT INTO "django_admin_log" VALUES (93,'67','Camp object (67)',2,'[{"changed": {"fields": ["Medical needs", "Special needs"]}}]',7,1,'2024-01-25 16:03:58.290754');
INSERT INTO "django_content_type" VALUES (1,'admin','logentry');
INSERT INTO "django_content_type" VALUES (2,'auth','permission');
INSERT INTO "django_content_type" VALUES (3,'auth','group');
INSERT INTO "django_content_type" VALUES (4,'auth','user');
INSERT INTO "django_content_type" VALUES (5,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (6,'sessions','session');
INSERT INTO "django_content_type" VALUES (7,'app','camp');
INSERT INTO "django_content_type" VALUES (8,'app','refugee');
INSERT INTO "django_content_type" VALUES (9,'app','disaster');
INSERT INTO "django_content_type" VALUES (10,'app','guidelines');
INSERT INTO "django_content_type" VALUES (11,'app','identification');
INSERT INTO "django_content_type" VALUES (12,'app','location');
INSERT INTO "django_content_type" VALUES (13,'app','province');
INSERT INTO "django_content_type" VALUES (14,'app','divisionalsecretariat');
INSERT INTO "django_content_type" VALUES (15,'app','gramaniladharidivision');
INSERT INTO "django_content_type" VALUES (16,'app','village');
INSERT INTO "django_content_type" VALUES (17,'app','locationdisaster');
INSERT INTO "django_content_type" VALUES (18,'app','villagedisaster');
INSERT INTO "django_content_type" VALUES (19,'app','waterlevel');
INSERT INTO "django_content_type" VALUES (20,'app','userprofile');
INSERT INTO "auth_permission" VALUES (1,1,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES (2,1,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES (3,1,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES (4,1,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES (5,2,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES (6,2,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES (7,2,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES (8,2,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES (9,3,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES (10,3,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES (11,3,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES (12,3,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES (13,4,'add_user','Can add user');
INSERT INTO "auth_permission" VALUES (14,4,'change_user','Can change user');
INSERT INTO "auth_permission" VALUES (15,4,'delete_user','Can delete user');
INSERT INTO "auth_permission" VALUES (16,4,'view_user','Can view user');
INSERT INTO "auth_permission" VALUES (17,5,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES (18,5,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES (19,5,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES (20,5,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES (21,6,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES (22,6,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES (23,6,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES (24,6,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES (25,7,'add_camp','Can add camp');
INSERT INTO "auth_permission" VALUES (26,7,'change_camp','Can change camp');
INSERT INTO "auth_permission" VALUES (27,7,'delete_camp','Can delete camp');
INSERT INTO "auth_permission" VALUES (28,7,'view_camp','Can view camp');
INSERT INTO "auth_permission" VALUES (29,8,'add_refugee','Can add refugee');
INSERT INTO "auth_permission" VALUES (30,8,'change_refugee','Can change refugee');
INSERT INTO "auth_permission" VALUES (31,8,'delete_refugee','Can delete refugee');
INSERT INTO "auth_permission" VALUES (32,8,'view_refugee','Can view refugee');
INSERT INTO "auth_permission" VALUES (33,9,'add_disaster','Can add disaster');
INSERT INTO "auth_permission" VALUES (34,9,'change_disaster','Can change disaster');
INSERT INTO "auth_permission" VALUES (35,9,'delete_disaster','Can delete disaster');
INSERT INTO "auth_permission" VALUES (36,9,'view_disaster','Can view disaster');
INSERT INTO "auth_permission" VALUES (37,10,'add_guidelines','Can add guidelines');
INSERT INTO "auth_permission" VALUES (38,10,'change_guidelines','Can change guidelines');
INSERT INTO "auth_permission" VALUES (39,10,'delete_guidelines','Can delete guidelines');
INSERT INTO "auth_permission" VALUES (40,10,'view_guidelines','Can view guidelines');
INSERT INTO "auth_permission" VALUES (41,11,'add_identification','Can add identification');
INSERT INTO "auth_permission" VALUES (42,11,'change_identification','Can change identification');
INSERT INTO "auth_permission" VALUES (43,11,'delete_identification','Can delete identification');
INSERT INTO "auth_permission" VALUES (44,11,'view_identification','Can view identification');
INSERT INTO "auth_permission" VALUES (45,12,'add_location','Can add location');
INSERT INTO "auth_permission" VALUES (46,12,'change_location','Can change location');
INSERT INTO "auth_permission" VALUES (47,12,'delete_location','Can delete location');
INSERT INTO "auth_permission" VALUES (48,12,'view_location','Can view location');
INSERT INTO "auth_permission" VALUES (49,13,'add_province','Can add province');
INSERT INTO "auth_permission" VALUES (50,13,'change_province','Can change province');
INSERT INTO "auth_permission" VALUES (51,13,'delete_province','Can delete province');
INSERT INTO "auth_permission" VALUES (52,13,'view_province','Can view province');
INSERT INTO "auth_permission" VALUES (53,14,'add_divisionalsecretariat','Can add divisional secretariat');
INSERT INTO "auth_permission" VALUES (54,14,'change_divisionalsecretariat','Can change divisional secretariat');
INSERT INTO "auth_permission" VALUES (55,14,'delete_divisionalsecretariat','Can delete divisional secretariat');
INSERT INTO "auth_permission" VALUES (56,14,'view_divisionalsecretariat','Can view divisional secretariat');
INSERT INTO "auth_permission" VALUES (57,15,'add_gramaniladharidivision','Can add grama niladhari division');
INSERT INTO "auth_permission" VALUES (58,15,'change_gramaniladharidivision','Can change grama niladhari division');
INSERT INTO "auth_permission" VALUES (59,15,'delete_gramaniladharidivision','Can delete grama niladhari division');
INSERT INTO "auth_permission" VALUES (60,15,'view_gramaniladharidivision','Can view grama niladhari division');
INSERT INTO "auth_permission" VALUES (61,16,'add_village','Can add village');
INSERT INTO "auth_permission" VALUES (62,16,'change_village','Can change village');
INSERT INTO "auth_permission" VALUES (63,16,'delete_village','Can delete village');
INSERT INTO "auth_permission" VALUES (64,16,'view_village','Can view village');
INSERT INTO "auth_permission" VALUES (65,17,'add_locationdisaster','Can add location disaster');
INSERT INTO "auth_permission" VALUES (66,17,'change_locationdisaster','Can change location disaster');
INSERT INTO "auth_permission" VALUES (67,17,'delete_locationdisaster','Can delete location disaster');
INSERT INTO "auth_permission" VALUES (68,17,'view_locationdisaster','Can view location disaster');
INSERT INTO "auth_permission" VALUES (69,18,'add_villagedisaster','Can add village disaster');
INSERT INTO "auth_permission" VALUES (70,18,'change_villagedisaster','Can change village disaster');
INSERT INTO "auth_permission" VALUES (71,18,'delete_villagedisaster','Can delete village disaster');
INSERT INTO "auth_permission" VALUES (72,18,'view_villagedisaster','Can view village disaster');
INSERT INTO "auth_permission" VALUES (73,7,'print_camp','Can print camp');
INSERT INTO "auth_permission" VALUES (74,8,'print_refugee','Can print refugee');
INSERT INTO "auth_permission" VALUES (75,17,'print_locationdisaster','Can print locationdisaster');
INSERT INTO "auth_permission" VALUES (76,18,'print_villagedisaster','Can print villagedisaster');
INSERT INTO "auth_permission" VALUES (77,19,'add_waterlevel','Can add water level');
INSERT INTO "auth_permission" VALUES (78,19,'change_waterlevel','Can change water level');
INSERT INTO "auth_permission" VALUES (79,19,'delete_waterlevel','Can delete water level');
INSERT INTO "auth_permission" VALUES (80,19,'view_waterlevel','Can view water level');
INSERT INTO "auth_permission" VALUES (81,20,'add_userprofile','Can add user profile');
INSERT INTO "auth_permission" VALUES (82,20,'change_userprofile','Can change user profile');
INSERT INTO "auth_permission" VALUES (83,20,'delete_userprofile','Can delete user profile');
INSERT INTO "auth_permission" VALUES (84,20,'view_userprofile','Can view user profile');
INSERT INTO "auth_permission" VALUES (85,8,'generate_camp_pdf','Can print refugee');
INSERT INTO "auth_permission" VALUES (86,7,'generate_camp_pdf','Can print camp');
INSERT INTO "auth_group" VALUES (1,'Community');
INSERT INTO "auth_group" VALUES (2,'Manager');
INSERT INTO "auth_user" VALUES (1,'pbkdf2_sha256$600000$9SD1KYb0OmC9BK3uQNl6Qj$UJEQIQUeE3zXjfXZOoAR1LA47y+tBs1zVBkT7qIA6iU=','2024-01-25 16:28:13.368352',1,'admin','','admin@dm.com',1,1,'2023-05-20 11:56:23.496591','');
INSERT INTO "auth_user" VALUES (2,'pbkdf2_sha256$600000$jOeoJzEt4a2oHc84SLIdV4$p4mz+iqG/UURqyykLHSI2qYj6RhdpJuK81dfVUZBzBE=','2023-11-04 04:45:16.491440',0,'Sarah','','',0,1,'2023-05-20 11:57:55','');
INSERT INTO "auth_user" VALUES (3,'pbkdf2_sha256$390000$3PbHGzqlxHqbW0gfxDww5L$n4KYzzoMgf/HIPyPTQDPg33COmLERs0dTvwe+ZIP7+Q=',NULL,0,'Kumudu','','',0,1,'2023-05-20 11:58:23','');
INSERT INTO "auth_user" VALUES (4,'pbkdf2_sha256$600000$aODcQLwsLiRqQAM2hTmUxF$jVb9ZGx9EB8cmrDYIIe/qH0knD9XYjMPcA7dN9RMRzM=','2023-12-06 05:08:33.535823',0,'Kasun','','',0,1,'2023-08-26 17:16:39','');
INSERT INTO "auth_user" VALUES (5,'pbkdf2_sha256$600000$UTboSCpvJgKeeWg6qeAper$NzEiEeNp2vXSlgf5ME3MI48jrhAAwzBGSqrNL2/2bnc=',NULL,0,'Sanduni','','',0,1,'2023-09-06 14:59:20.350403','');
INSERT INTO "auth_user" VALUES (6,'pbkdf2_sha256$390000$7pMTyc1TVmFztdrvkDtuwb$ys4aDgz5Rxr9WsJF4CX6cou3t0iUYZU2WvR/TEVHE0E=',NULL,0,'sasa','','sasa@gmail.com',0,0,'2023-09-07 06:23:00.900603','');
INSERT INTO "auth_user" VALUES (7,'pbkdf2_sha256$390000$Bo9P60Dn7SD5l2kKNbJy9M$YU9U4uTblhUatHNhxjRJQEz0GD7OjATScCH4KarL3f4=',NULL,0,'Kassa','','kassa@gmail.com',0,0,'2023-09-07 06:35:12.388896','');
INSERT INTO "auth_user" VALUES (8,'pbkdf2_sha256$390000$rKvBcALas1hGpzopRwJBHN$xNdUQAejZTItAyAmy3NNY1hkh35IFs85hUHg2MjJj9I=',NULL,0,'Hasi','','hasi@gmail.com',0,0,'2023-09-07 07:18:13.592597','');
INSERT INTO "auth_user" VALUES (21,'pbkdf2_sha256$390000$qtaYmiOkrjcx4IgyKBEyvh$WDOzmbfcsSlDNYbPxkGp+wIAxJ/o9t0v3IysLlU8d5w=',NULL,0,'janana','','',0,0,'2023-09-07 09:08:05.656500','');
INSERT INTO "auth_user" VALUES (25,'pbkdf2_sha256$600000$S4Thmyh9MU97LQMidYRfXi$655ySuWrZ+T7cXAiaddqTY87NGa5gjB7KIRL/BY+mPg=','2023-12-06 05:04:29.585407',0,'KH','','hasithikeshi17@gmail.com',0,1,'2023-09-07 15:57:22.503368','');
INSERT INTO "auth_user" VALUES (26,'pbkdf2_sha256$600000$EGJ2rxwF9M9p7IFaAoCAg4$zCDPBPPEmpoqcvKEfJl2yNYH9++5AFluRBIuatR6G5Y=','2023-12-05 22:47:47.005930',0,'Nimali','','nimali@gmai.com',0,1,'2023-09-07 18:03:46.683730','');
INSERT INTO "auth_user" VALUES (27,'pbkdf2_sha256$390000$54gA9uWuRKVbJb4fbup4jG$c+60QfKTImRy0qkzebTjIx97l+FZ7J78zOf4oZfGQpQ=','2023-09-12 05:31:17.577759',0,'Goldfish','','kavi1008dk@gmail.com',0,1,'2023-09-12 05:29:47.678651','');
INSERT INTO "auth_user" VALUES (28,'pbkdf2_sha256$390000$opSWYtLf282H0krumQy3J3$nHJsbLsYD+Yg4Xo0CdX60OPtg9ZBhmopamXgEMqhKJE=',NULL,0,'Dew','','kavi1008dk@gmail.com',0,1,'2023-09-12 05:30:20','');
INSERT INTO "auth_user" VALUES (30,'pbkdf2_sha256$600000$HYvCOnm6pWrePDYzEjb40o$ADaRBGyo6DJjtuEcmy43Cl3g52lCwVXIIp76/q11OgU=','2023-12-03 05:51:09.324157',0,'Ranja','','prabashvidushan@gmail.com',0,1,'2023-10-31 15:57:07','');
INSERT INTO "auth_user" VALUES (31,'pbkdf2_sha256$600000$1DRG1OB1NdFA5NhHWzyyjg$P6lJoTqGjqve+o0/EP4WkJS/myjn9j+qXbkyLtTSNZM=','2024-01-25 12:06:18.268538',0,'Kasudd','','hasithikeshi17@gmail.com',0,1,'2024-01-20 12:30:34.214655','');
INSERT INTO "auth_user" VALUES (32,'pbkdf2_sha256$600000$Y0FMgt8rFhZCLtpBaWa5No$LEpEEZQmT1iLX0qNJil3krOstS5OaL/4WvpmyuiP8QE=','2024-01-25 04:57:22.136132',0,'aaaa','','hasithikeshi17@gmail.com',0,1,'2024-01-25 04:23:28.512670','');
INSERT INTO "auth_user" VALUES (33,'pbkdf2_sha256$600000$dRcqZnUKWXnvkrL6FrtVAV$LN1H+UCpd0WfajaIeyvbggkiYVL+xKKDz/UR0ROEZpg=','2024-01-25 16:16:19.396690',0,'Piyumi','Waruni','hasithikeshi17@gmail.com',0,1,'2024-01-25 08:21:43','Piyumi');
INSERT INTO "auth_user" VALUES (35,'pbkdf2_sha256$600000$fJMWsX1P5QOyc1anyRN765$HGQ7ueXJoJniKpqPCTyGqC4aC6699NjlaYUQ5ZrCu+g=',NULL,0,'dfdf','','hasithikeshi17@gmail.com',0,1,'2024-01-25 13:19:27.388576','');
INSERT INTO "auth_user" VALUES (37,'pbkdf2_sha256$600000$bkbSqciTPVJjk0ziNBY2xy$kvSnevAlACOywcAKAVN43UOiWqd24YC6b6I1/CkL3qs=','2024-01-25 14:07:12.555144',0,'Isuri','N','hasithikeshi17@gmail.com',0,1,'2024-01-25 13:37:04.724985','Isuri');
INSERT INTO "auth_user" VALUES (38,'pbkdf2_sha256$600000$qPvT6zljI4oTiWtSImIDH2$YrDmKgFncxNxzxm2ZZ9EGDQ5oTn1ecIu7of/SaDcDLI=',NULL,0,'Saman','','hasithikeshi17@gmail.com',0,1,'2024-01-26 09:34:49.617472','');
INSERT INTO "auth_user" VALUES (39,'pbkdf2_sha256$600000$goreO99BWF4GQ8SGfSpEez$j/r7HMJO1v9ALk93Mo9lRO7LGhN/6/y+0/zC2J6tZ0g=','2024-01-26 09:46:56.097944',0,'prabash','','vidushanprabash6@gmail.com',0,1,'2024-01-26 09:45:30.821918','');
INSERT INTO "django_session" VALUES ('isgktgt87eal1yfm0tjwv2u0f07e0llt','.eJxVjDsOwyAQBe9CHSFgWcAp0_sMiM8SnERYMnYV5e6xJRdJOzPvvZkP21r91mnxU2ZXJtnll8WQntQOkR-h3Wee5rYuU-RHwk_b-Thnet3O9u-ghl73tQZHBaSwJLVzA6WiLKpkgQxA2ZEyTmS0ApEEDeSKNllD0FIixgLs8wW6vjbM:1q0LDD:d5M2grPSCsXAOyP2tS2PHtltifd6DVeIIL891K5_vyQ','2023-06-03 11:57:27.479160');
INSERT INTO "django_session" VALUES ('jkt5m0tnylq6hxuanyh40wn2om2esciq','.eJxVjEEOwiAQRe_C2hDAAYpL9z0DGWZAqoYmpV0Z765NutDtf-_9l4i4rTVuPS9xYnERRpx-t4T0yG0HfMd2myXNbV2mJHdFHrTLceb8vB7u30HFXr81gA7KEVFQJpeiiwtnk1E59FxSAECXNJH1aSDwxibGwTrlTChglWbx_gDn8zfR:1qCZmJ:a2u6EMgE6e2yI0f1IKxFiu8zHhx-WCs81rIRqq0Rlvs','2023-07-07 05:56:15.217278');
INSERT INTO "django_session" VALUES ('8fmki3odyxq0nlugyjvs7ssxmzcdj2rb','.eJxVjEEOwiAQRe_C2hDoUKEu3XsGMjMMUjUlKe3KeHfbpAvdvvf-f6uI61Li2mSOY1IXZdXplxHyU6ZdpAdO96q5Tss8kt4TfdimbzXJ63q0fwcFW9nWnFywGYGxG7IJGQYnghv0Qh56MBCEmRz1NoVsSYBsIJ-tgTMMHavPFwJIOF8:1qZYWu:42RUpBusdfKmex65LMjyMFoSK5zJqqEfs9-VmU77uew','2023-09-08 15:15:20.366208');
INSERT INTO "django_session" VALUES ('a0lecdbja3ntxppispirs615i3jx934s','.eJxVjEEOwiAQRe_C2hDoUKEu3XsGMjMMUjUlKe3KeHfbpAvdvvf-f6uI61Li2mSOY1IXZdXplxHyU6ZdpAdO96q5Tss8kt4TfdimbzXJ63q0fwcFW9nWnFywGYGxG7IJGQYnghv0Qh56MBCEmRz1NoVsSYBsIJ-tgTMMHavPFwJIOF8:1qZxvb:WTyIHp92Zw7AhVH98GcF5CqXF2s6pYoLjdRpxGagfUo','2023-09-09 18:22:31.676936');
INSERT INTO "django_session" VALUES ('p4mryjf3src27wzedsdbt8xil68sxsgv','.eJxVjEEOwiAQRe_C2hDoUKEu3XsGMjMMUjUlKe3KeHfbpAvdvvf-f6uI61Li2mSOY1IXZdXplxHyU6ZdpAdO96q5Tss8kt4TfdimbzXJ63q0fwcFW9nWnFywGYGxG7IJGQYnghv0Qh56MBCEmRz1NoVsSYBsIJ-tgTMMHavPFwJIOF8:1qa8aW:AMpw7Juvc8uOciiwhNLYC6hhqNHf0LVTyVKe0jPg3hk','2023-09-10 05:45:28.174309');
INSERT INTO "django_session" VALUES ('lgg6fowf5qpbdt67zgcba9j0rzpsrrju','.eJxVjEEOwiAQRe_C2pBCBygu3XuGZoYZpGpoUtqV8e7apAvd_vfef6kRt7WMW5NlnFidFajT70aYHlJ3wHest1mnua7LRHpX9EGbvs4sz8vh_h0UbOVbRx4cOUAAZ0l8Zua-Qw4g0fQd5EAekuk8oYizxgyUvA8JY7YeLUT1_gDuMTgB:1qaEET:Q-mTdX4mzyYEj2Y6J5KxLp5N2qurBCSiuSSEqeVD4lM','2023-09-10 11:47:05.492278');
INSERT INTO "django_session" VALUES ('5yus4kfgxzql6o4afurxaghynn05nzd0','.eJxVjL0OwjAQg98lM4qONH9lZOcZotxdQgoolZp2Qrw7qdQBvFjyZ_stQtzWEraWljCxuAilxek3xEjPVHfCj1jvs6S5rsuEcq_IgzZ5mzm9rkf376DEVvraocMuCy5F7UYHiTKSAgKwnngw3SmyUx70OWnMmTWbgUfjMyhjxecLIaI4WQ:1qeBQ7:X0NI1bhS-LgR8AquuJvOj92QV4RSb3UU_Kfz8p5yjkA','2023-09-21 09:35:27.929575');
INSERT INTO "django_session" VALUES ('21eku0q0gqh8w2pqycstn2h6761t4dfe','.eJxVjMsOwiAQRf-FtSEwLY-6dO83kBkYpGogKe3K-O_apAvd3nPOfYmA21rC1nkJcxJnAUacfkfC-OC6k3THemsytrouM8ldkQft8toSPy-H-3dQsJdv7RNQ1kaTjeA8O-NYW2Qi9mqyJiG4AfWUgbxRQ0Z2MbHSHlDBOOoo3h8TKTgq:1qeHVH:yUoRmb4JtKqsZ8tueGdo1JV8XUKMl4l-IupU2s0BfRU','2023-09-21 16:05:11.184342');
INSERT INTO "django_session" VALUES ('8sw1p7s398v4lf5yvi5g7wbcev2hzezi','.eJxVjEEOwiAQRe_C2pBCCxSX7nsGMswMUjWQlHZlvLsh6UK3_7333yLAsedwNN7CSuIqlLj8bhHwyaUDekC5V4m17NsaZVfkSZtcKvHrdrp_Bxla7vUIQzJ6cpSSHVVUyrAdEEYE8qy9wcTzzC46q5GsTxojkiJHxOzjJD5fA9s5Wg:1qeJud:mGRYRaJ8gb_sv1rJLHmhokxbE2BhNfYfQGwbWOUsd_k','2023-09-21 18:39:31.659758');
INSERT INTO "django_session" VALUES ('fezqrma1nkzcv19txwy6grvpuvzd2032','.eJxVjDsOwjAQBe_iGlm7trNOKOlzhmj9wwFkS3FSIe6OLKWA9s3Me4uFjz0vR4vbsgZxFYrE5Xd07J-xdBIeXO5V-lr2bXWyK_KkTc41xNftdP8OMrfc6wmsIueUhxFAD9objaAgRXY8IoLXZP3E5CyqBIMOhtBQQBshMRjx-QLklTcX:1qepIM:t7wKiIHp3zGPvKbH8lP-JZ0uiinMt2VEpspEnAC8J7A','2023-09-23 04:10:06.323205');
INSERT INTO "django_session" VALUES ('egondwxwdbgx8tzzh92zpwxabs7wp2bc','.eJxVjL0OwjAQg98lM4qONH9lZOcZotxdQgoolZp2Qrw7qdQBvFjyZ_stQtzWEraWljCxuAilxek3xEjPVHfCj1jvs6S5rsuEcq_IgzZ5mzm9rkf376DEVvraocMuCy5F7UYHiTKSAgKwnngw3SmyUx70OWnMmTWbgUfjMyhjxecLIaI4WQ:1qkA33:NL8qiNVzewSpLdX7qeuajiyL-3DQsr7bIrgEW-37GRs','2023-10-07 21:20:21.316741');
INSERT INTO "django_session" VALUES ('aj5xn9neazl5vnid8onk2qr5xdu9cfqs','.eJxVjMsOwiAQRf-FtSGU14BL934DgRmQqoGktCvjv2uTLnR7zzn3xULc1hq2kZcwEzsz6dnpd0wRH7nthO6x3TrH3tZlTnxX-EEHv3bKz8vh_h3UOOq3FlYriWKy4JMySilR1BSxUBJOIAptHNoiPQBaCxJcIV0iJE9ovJOZvT_iaTeG:1qqCpW:iMvnodgTNGaBxgr3xNTNatLAUE6n3gJ0cFQBlf9BWVQ','2023-10-24 13:31:22.805725');
INSERT INTO "django_session" VALUES ('ormq2zg5itfse8td6f04cg1munu6zyum','.eJxVjDEOwyAQBP9CHSEDOh-kTJ83oOOA4CQCydiVlb_HllwkxTY7s7sJT-tS_NrT7KcorkKJy28XiF-pHiA-qT6a5FaXeQryUORJu7y3mN630_07KNTLvuZRq-QGcLCHLRpth4zIoMEg6dFFpBQZRlYqO2e1CphzMGCAomYQny-2LDcn:1qrJSB:NoEWveqUMSkrw6ZNDByfsDNmmm6AALG-wLsl9TuBGj0','2023-10-27 14:47:51.049329');
INSERT INTO "django_session" VALUES ('3ow6efkrn9dzcmnq5as8zzoosnb29p7t','.eJxVjMsOwiAQRf-FtSGU14BL934DgRmQqoGktCvjv2uTLnR7zzn3xULc1hq2kZcwEzsz6dnpd0wRH7nthO6x3TrH3tZlTnxX-EEHv3bKz8vh_h3UOOq3FlYriWKy4JMySilR1BSxUBJOIAptHNoiPQBaCxJcIV0iJE9ovJOZvT_iaTeG:1qsRM0:5hU8T00eptB3sWSMUlU4aD8HlXoNojlJuhOwosagIjg','2023-10-30 17:26:08.751201');
INSERT INTO "django_session" VALUES ('0hyxjbe1wy3xq3g5sdl3nnwrmzi8ewiu','.eJxVjDEOwyAUQ-_CXCEC_BA6ds8Z0IcPJW0FUkimqncvkTK0ky0_22_mcN-y21tc3ULsypRgl9_QY3jGchB6YLlXHmrZ1sXzo8JP2vhcKb5uZ_fvIGPLfR0SSR20DNjdaCx2hSiGmAymCDQoISwmjSoBeIkwwjTpBFpoowxZ9vkCRFw4xQ:1qxr7f:lsMy0fXeTtzDLtPDKX8xse-lG7wPYl41Fcr4xaKdiOY','2023-11-14 15:57:43.070780');
INSERT INTO "django_session" VALUES ('qzs0ha1jy4p31tuqdasrl32bkc4pdbcz','.eJxVjDsOwjAQBe_iGln-fyjpOYO167VxADlSnFSIu0OkFNC-mXkvlmBbW9pGWdJE7MwkO_1uCPlR-g7oDv028zz3dZmQ7wo_6ODXmcrzcrh_Bw1G-9ZWOa3IKe-E0j5UE4QVoiAaqSGESGBFlURVawyViMAU8kFijD4L59n7A7mVN3g:1qz9pZ:XN8jnWd8pYP-86bbSyeMZdY3AFd1MiyfkY6aY4eQsw4','2023-11-18 06:08:25.853752');
INSERT INTO "django_session" VALUES ('xlt70mq93ln0fy1hoxt4xf3rkn25w0ne','.eJxVjEEOwiAQRe_C2pBCBygu3XuGZoYZpGpoUtqV8e7apAvd_vfef6kRt7WMW5NlnFidFajT70aYHlJ3wHest1mnua7LRHpX9EGbvs4sz8vh_h0UbOVbRx4cOUAAZ0l8Zua-Qw4g0fQd5EAekuk8oYizxgyUvA8JY7YeLUT1_gDuMTgB:1r9f8x:Q91mlu5BDUEcRm-5MUwvfczBfYNrwaQTXrW0S0pNqHM','2023-12-17 05:35:51.490020');
INSERT INTO "django_session" VALUES ('x1c42iu8ot6u41cpzdzz2hv7u3locnua','.eJxVjEEOwiAQRe_C2pBCBygu3XuGZoYZpGpoUtqV8e7apAvd_vfef6kRt7WMW5NlnFidFajT70aYHlJ3wHest1mnua7LRHpX9EGbvs4sz8vh_h0UbOVbRx4cOUAAZ0l8Zua-Qw4g0fQd5EAekuk8oYizxgyUvA8JY7YeLUT1_gDuMTgB:1r9f8x:Q91mlu5BDUEcRm-5MUwvfczBfYNrwaQTXrW0S0pNqHM','2023-12-17 05:35:51.754358');
INSERT INTO "django_session" VALUES ('d546ezgkedj39gcsxd33rsq3gbwll29b','.eJxVjMsOwiAQRf-FtSEwLY-6dO83kBkYpGogKe3K-O_apAvd3nPOfYmA21rC1nkJcxJnAUacfkfC-OC6k3THemsytrouM8ldkQft8toSPy-H-3dQsJdv7RNQ1kaTjeA8O-NYW2Qi9mqyJiG4AfWUgbxRQ0Z2MbHSHlDBOOoo3h8TKTgq:1rAYKr:4MzayBZzTexY3UgPyTbQ4fwL18RZ-rr2d2jFlPC2s9A','2023-12-19 16:31:49.036556');
INSERT INTO "django_session" VALUES ('k67k06pvw7rrf75k8hvhu4p8hmqrrw5h','.eJxVjDsOwjAQBe_iGln-fyjpOYO167VxADlSnFSIu0OkFNC-mXkvlmBbW9pGWdJE7MwkO_1uCPlR-g7oDv028zz3dZmQ7wo_6ODXmcrzcrh_Bw1G-9ZWOa3IKe-E0j5UE4QVoiAaqSGESGBFlURVawyViMAU8kFijD4L59n7A7mVN3g:1rAkDr:NPBG_5_hehotIqEH53ErI-9eEByMacCMxx4CuFn6Eic','2023-12-20 05:13:23.221029');
INSERT INTO "django_session" VALUES ('yb9h9w0nr8mhdcitxzz779m4nyfo0t97','.eJxVjDsOwjAQRO_iGlm2E_8o6TmDtd5dcADZUpxUiLuTSClAmmrem3mLBOtS0tp5ThOJsxicOP2WGfDJdSf0gHpvEltd5inLXZEH7fLaiF-Xw_07KNDLtmbSqMGT0uPoXWRvFPphi9ekDYZ8U4FCROQYwSplzRDRabaWoiLjxecL_Sc3fg:1rSzi6:8GWUz4RSEM28-IYeJ_CBaoPS9EW9MQ3r3wdUawwhnqc','2024-02-08 13:24:02.161323');
INSERT INTO "django_session" VALUES ('gh07g86tesqjyomcchsoxhp34ob2ltll','.eJxVjEEOwiAQRe_C2hAoUBmX7j0DmQFGqgaS0q6Md7dNutDte-__twi4LiWsPc9hSuIiDIjTLySMz1x3kx5Y703GVpd5Irkn8rBd3lrKr-vR_h0U7GVbgx80M5BJ7J0ekjaKEEZldY6szoTOAybvyUZDOFpWTrHHjSngjCg-XxF8OMk:1rTInY:LrjL47f8DAv5th2-T0RmLXOflomlStO0W3OfqCN5Sb8','2024-02-09 09:46:56.182291');
INSERT INTO "app_disaster" VALUES (3,'low Risky','2000-02-02','14:30:59');
INSERT INTO "app_disaster" VALUES (4,'risky','2000-02-02','14:30:59');
INSERT INTO "app_identification" VALUES (2,'Kaduwela','Colombo','Nugegoda');
INSERT INTO "app_identification" VALUES (3,'Kaduwela','Colombo','Kaluthara');
INSERT INTO "app_guidelines" VALUES (2,'gdd','dgdg','wgsv');
INSERT INTO "app_divisionalsecretariat" VALUES (2,'Colombo1');
INSERT INTO "app_divisionalsecretariat" VALUES (3,'Colombo');
INSERT INTO "app_gramaniladharidivision" VALUES (2,'Colombo');
INSERT INTO "app_village" VALUES (1,'St. John Lane');
INSERT INTO "app_refugee" VALUES (1,'Nimal','Bandarawela',22,'1999-12-01');
INSERT INTO "app_refugee" VALUES (2,'Kamal','No.12, Rathnapura',22,'2001-02-03');
INSERT INTO "app_refugee" VALUES (5,'Mala','Colombo',22,'2001-12-02');
INSERT INTO "app_refugee" VALUES (7,'k','123,Colombo',24,'1999-12-01');
INSERT INTO "app_location" VALUES (16,'Badulla',6.9900353,81.0570315);
INSERT INTO "app_location" VALUES (17,'Badulla',6.9900353,81.0570315);
INSERT INTO "app_location" VALUES (18,'Diyathalawa',6.8028552,80.9458377);
INSERT INTO "app_location" VALUES (19,'Matara',5.947822,80.5482919);
INSERT INTO "app_location" VALUES (20,'Rathnapura',6.68610125,80.4079243309443);
INSERT INTO "app_location" VALUES (21,'Galle',6.0328139,80.214955);
INSERT INTO "app_location" VALUES (25,'Hambanthota',6.12607505,81.1168468016198);
INSERT INTO "app_location" VALUES (26,'Millakanda',6.6426337,80.1754761);
INSERT INTO "app_camp" VALUES (56,'Camp at disaster',34,1,'Low','Low',NULL,NULL,7.9395357,81.0003387,'Polonnaruwa');
INSERT INTO "app_camp" VALUES (61,'Camp Yaa',43,3,'Moderate','Moderate','aa','scscs',7.9395357,81.0003387,'Polonnaruwa');
INSERT INTO "app_camp" VALUES (65,'Camp Yaa',12,12,'Moderate','Low',NULL,NULL,7.012402,80.757161154847,'Nuwara Eliya');
INSERT INTO "app_camp" VALUES (66,'Camp Yaa',2222,12,'Low','Low',NULL,NULL,7.012402,80.757161154847,'Nuwara Eliya');
INSERT INTO "app_camp" VALUES (67,'Camp Yaa',2222,12,'Low','Low','First Aid Supplies: Adhesive bandages ,Gauze and bandage rolls','Clothing',7.012402,80.757161154847,'Nuwara Eliya');
INSERT INTO "app_camp" VALUES (75,'Camp at Kalu area',68,34,'Low','Low',NULL,NULL,6.9524093,80.2210641,'Awissawella');
INSERT INTO "app_camp" VALUES (79,'Camp kalu area 1',68,34,'Low','Low','Pain Relief','Water',6.9371712,79.8970186,'Awissawella');
INSERT INTO "app_camp" VALUES (80,'Camp kalu area 2',103,4,'Low','Low','Pain Relief','Water',6.7123347,80.3909444,'Hidellana Tamil School Palm Garden Estate Road, Ratnapura');
INSERT INTO "app_camp" VALUES (81,'Camp kalu area 3',400,30,'High','Low','Pain Relief','Blankets Sleeping bags Warm clothing (especially in cold climates) Tents and tarps',6.6825167,80.3992026,'Ferguson High School,Ratnapura');
INSERT INTO "app_userprofile" VALUES (1,'+94771193426','0771193426','123,Colombo','',33);
INSERT INTO "app_userprofile" VALUES (2,'+94772236489','0778864324','No, 1234, Colombo','',37);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_group_id_97559544" ON "auth_user_groups" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
CREATE INDEX IF NOT EXISTS "app_locationdisaster_location_id_b219efc1" ON "app_locationdisaster" (
	"location_id"
);
CREATE INDEX IF NOT EXISTS "app_locationdisaster_disaster_id_b29c8726" ON "app_locationdisaster" (
	"disaster_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "app_village_disasters_village_id_disaster_id_0bf0b8b2_uniq" ON "app_village_disasters" (
	"village_id",
	"disaster_id"
);
CREATE INDEX IF NOT EXISTS "app_village_disasters_village_id_9925c08c" ON "app_village_disasters" (
	"village_id"
);
CREATE INDEX IF NOT EXISTS "app_village_disasters_disaster_id_8889d7ed" ON "app_village_disasters" (
	"disaster_id"
);
CREATE INDEX IF NOT EXISTS "app_villagedisaster_disaster_id_a895360f" ON "app_villagedisaster" (
	"disaster_id"
);
CREATE INDEX IF NOT EXISTS "app_villagedisaster_village_id_e3f8168f" ON "app_villagedisaster" (
	"village_id"
);
CREATE INDEX IF NOT EXISTS "app_waterlevel_location_id_d69b01c6" ON "app_waterlevel" (
	"location_id"
);
COMMIT;
