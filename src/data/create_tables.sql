BEGIN;
DROP TABLE IF EXISTS "animal",
    "user",
    "request",
    "family",
    "association",
    "department";
CREATE TABLE "animal"
(
    "id"             INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    "name"           TEXT      NOT NULL,
    "gender"         TEXT      NOT NULL,
    "race"           TEXT,
    "species"        TEXT      NOT NULL,
    "age"            INTEGER   NOT NULL,
    "size"           TEXT      NOT NULL,
    "description"    TEXT      NOT NULL,
    "url_image"      TEXT UNIQUE,
    "availability"   BOOLEAN   NOT NULL,
    "family_id"      INTEGER,
    "association_id" INTEGER   NOT NULL,
    "created_at"     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at"     TIMESTAMP          DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE "user"
(
    "id"             INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    "email"          TEXT UNIQUE NOT NULL,
    "password"       TEXT        NOT NULL,
    "role"           TEXT        NOT NULL,
    "family_id"      INTEGER,
    "association_id" INTEGER,
    "created_at"     TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at"     TIMESTAMP            DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE "family"
(
    "id"            INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    "name"          TEXT,
    "address"       TEXT      NOT NULL,
    "zip_code"      TEXT      NOT NULL,
    "city"          TEXT      NOT NULL,
    "department_id" INTEGER      NOT NULL,
    "phone_number"  TEXT      NOT NULL,
    "description"   TEXT,
    "url_image"     TEXT DEFAULT '/images/families/default_family_img.svg',
    "created_at"    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at"    TIMESTAMP          DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE "association"
(
    "id"            INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    "name"          TEXT,
    "address"       TEXT    NOT NULL,
    "zip_code"      TEXT    NOT NULL,
    "city"          TEXT    NOT NULL,
    "department_id" INTEGER    NOT NULL,
    "phone_number"  TEXT    NOT NULL,
    "description"   TEXT,
    "url_image"     TEXT    UNIQUE,
    "created_at"    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at"    TIMESTAMP          DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE "request"
(
    "id"              INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    "status"          TEXT      NOT NULL,
    "family_id"       INTEGER,
    "animal_id"       INTEGER,
    "association_id"  INTEGER,
    "created_at"      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at"      TIMESTAMP          DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE "department"
(
    "id"              INTEGER PRIMARY KEY,
    "code"            TEXT NOT NULL UNIQUE,
    "name"            TEXT    NOT NULL UNIQUE
);

ALTER TABLE "animal"
    ADD FOREIGN KEY ("family_id") REFERENCES "family" ("id") ON DELETE SET NULL;

ALTER TABLE "animal"
    ADD FOREIGN KEY ("association_id") REFERENCES "association" ("id") ON DELETE CASCADE;

ALTER TABLE "request"
    ADD FOREIGN KEY ("family_id") REFERENCES "family" ("id") ON DELETE SET NULL;

ALTER TABLE "request"
    ADD FOREIGN KEY ("animal_id") REFERENCES "animal" ("id") ON DELETE SET NULL;

ALTER TABLE "request"
    ADD FOREIGN KEY ("association_id") REFERENCES "association" ("id") ON DELETE SET NULL;

ALTER TABLE "user"
    ADD FOREIGN KEY ("family_id") REFERENCES "family" ("id") ON DELETE CASCADE;

ALTER TABLE "user"
    ADD FOREIGN KEY ("association_id") REFERENCES "association" ("id") ON DELETE CASCADE;

ALTER TABLE "family"
    ADD FOREIGN KEY ("department_id") REFERENCES "department" ("id") ON DELETE SET NULL;

ALTER TABLE "association"
    ADD FOREIGN KEY ("department_id") REFERENCES "department" ("id") ON DELETE SET NULL;

COMMIT;