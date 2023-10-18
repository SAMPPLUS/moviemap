CREATE TABLE "users" (
  "id" SERIAL PRIMARY KEY,
  "username" varchar,
  "role" varchar,
  "created_at" timestamp
);

CREATE TABLE "movies" (
  "id" SERIAL PRIMARY KEY,
  "tmdb_id" integer,
  "title" text,
  "director" text,
  "year" integer
);

CREATE TABLE "locations" (
  "id" SERIAL PRIMARY KEY,
  "movie_id" integer,
  "coord" float,
  "address" text,
  "description" text,
  "time" timestamp,
  "submitted_user" integer
);

CREATE TABLE "test" (
  "id" SERIAL PRIMARY KEY,
  "text" text
);

ALTER TABLE "locations" ADD FOREIGN KEY ("movie_id") REFERENCES "movies" ("id");

ALTER TABLE "locations" ADD FOREIGN KEY ("submitted_user") REFERENCES "users" ("id");
