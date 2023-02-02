CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "breweries" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "year" integer, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "active" boolean);
CREATE TABLE sqlite_sequence(name,seq);
CREATE TABLE IF NOT EXISTS "beers" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "style" varchar, "brewery_id" integer, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "style_id" integer);
CREATE TABLE IF NOT EXISTS "ratings" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "score" integer, "beer_id" integer, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "user_id" integer);
CREATE TABLE IF NOT EXISTS "users" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "username" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "password_digest" varchar, "admin" boolean, "enabled" boolean, "avatar" attachment);
CREATE TABLE IF NOT EXISTS "beer_clubs" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "founded" integer, "city" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "memberships" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "beer_club_id" integer, "user_id" integer, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "styles" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "description" text, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE INDEX "index_users_on_username" ON "users" ("username");
CREATE TABLE IF NOT EXISTS "active_storage_blobs" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "key" varchar NOT NULL, "filename" varchar NOT NULL, "content_type" varchar, "metadata" text, "service_name" varchar NOT NULL, "byte_size" bigint NOT NULL, "checksum" varchar, "created_at" datetime(6) NOT NULL);
CREATE UNIQUE INDEX "index_active_storage_blobs_on_key" ON "active_storage_blobs" ("key");
CREATE TABLE IF NOT EXISTS "active_storage_attachments" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar NOT NULL, "record_type" varchar NOT NULL, "record_id" bigint NOT NULL, "blob_id" bigint NOT NULL, "created_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_c3b3935057"
FOREIGN KEY ("blob_id")
  REFERENCES "active_storage_blobs" ("id")
);
CREATE INDEX "index_active_storage_attachments_on_blob_id" ON "active_storage_attachments" ("blob_id");
CREATE UNIQUE INDEX "index_active_storage_attachments_uniqueness" ON "active_storage_attachments" ("record_type", "record_id", "name", "blob_id");
CREATE TABLE IF NOT EXISTS "active_storage_variant_records" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "blob_id" bigint NOT NULL, "variation_digest" varchar NOT NULL, CONSTRAINT "fk_rails_993965df05"
FOREIGN KEY ("blob_id")
  REFERENCES "active_storage_blobs" ("id")
);
CREATE UNIQUE INDEX "index_active_storage_variant_records_uniqueness" ON "active_storage_variant_records" ("blob_id", "variation_digest");
INSERT INTO "schema_migrations" (version) VALUES
('20221021170639'),
('20221023205641'),
('20221110182719'),
('20221116130649'),
('20221119061809'),
('20221122190421'),
('20221122190520'),
('20221123180138'),
('20221210162502'),
('20221210175409'),
('20221212183446'),
('20221213101723'),
('20221213102735'),
('20221215051846'),
('20230201111636'),
('20230201114314');


