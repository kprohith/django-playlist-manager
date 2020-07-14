BEGIN;
--
-- Create model Artist
--
CREATE TABLE "backend_artist" ("artist_id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(50) NOT NULL);
--
-- Create model Song
--
CREATE TABLE "backend_song" ("title" varchar(100) NOT NULL, "song_id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "year" date NOT NULL, "duration" bigint NOT NULL);
CREATE TABLE "backend_song_artists" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "song_id" integer NOT NULL REFERENCES "backend_song" ("song_id") DEFERRABLE INITIALLY DEFERRED, "artist_id" integer NOT NULL REFERENCES "backend_artist" ("artist_id") DEFERRABLE INITIALLY DEFERRED);
--
-- Create model PlayList
--
CREATE TABLE "backend_playlist" ("playlist_name" varchar(50) NOT NULL, "playlist_id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "duration" bigint NOT NULL, "date_created" datetime NOT NULL, "last_modified" datetime NOT NULL, "creator_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE "backend_playlist_playlist_songs" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "playlist_id" integer NOT NULL REFERENCES "backend_playlist" ("playlist_id") DEFERRABLE INITIALLY DEFERRED, "song_id" integer NOT NULL REFERENCES "backend_song" ("song_id") DEFERRABLE INITIALLY DEFERRED);
CREATE UNIQUE INDEX "backend_song_artists_song_id_artist_id_df727f5d_uniq" ON "backend_song_artists" ("song_id", "artist_id");
CREATE INDEX "backend_song_artists_song_id_5590072a" ON "backend_song_artists" ("song_id");
CREATE INDEX "backend_song_artists_artist_id_abf3a412" ON "backend_song_artists" ("artist_id");
CREATE INDEX "backend_playlist_creator_id_8fc263b5" ON "backend_playlist" ("creator_id");
CREATE UNIQUE INDEX "backend_playlist_playlist_songs_playlist_id_song_id_df475cb2_uniq" ON "backend_playlist_playlist_songs" ("playlist_id", "song_id");
CREATE INDEX "backend_playlist_playlist_songs_playlist_id_80afbfe7" ON "backend_playlist_playlist_songs" ("playlist_id");
CREATE INDEX "backend_playlist_playlist_songs_song_id_b930420f" ON "backend_playlist_playlist_songs" ("song_id");
COMMIT;
BEGIN;
--
-- Create model Album
--
CREATE TABLE "backend_album" ("title" varchar(50) NOT NULL, "album_id" integer NOT NULL PRIMARY KEY AUTOINCREMENT);
--
-- Rename field playlist_songs on playlist to songs
--
CREATE TABLE "backend_playlist_songs" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "playlist_id" integer NOT NULL REFERENCES "backend_playlist" ("playlist_id") DEFERRABLE INITIALLY DEFERRED, "song_id" integer NOT NULL REFERENCES "backend_song" ("song_id") DEFERRABLE INITIALLY DEFERRED);
INSERT INTO "backend_playlist_songs" (id, playlist_id, song_id) SELECT id, playlist_id, song_id FROM "backend_playlist_playlist_songs";
DROP TABLE "backend_playlist_playlist_songs";
--
-- Add field count to playlist
--
CREATE TABLE "new__backend_playlist" ("playlist_name" varchar(50) NOT NULL, "playlist_id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "duration" bigint NOT NULL, "date_created" datetime NOT NULL, "last_modified" datetime NOT NULL, "creator_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "count" integer NOT NULL);
INSERT INTO "new__backend_playlist" ("playlist_name", "playlist_id", "duration", "date_created", "last_modified", "creator_id", "count") SELECT "playlist_name", "playlist_id", "duration", "date_created", "last_modified", "creator_id", 0 FROM "backend_playlist";
DROP TABLE "backend_playlist";
ALTER TABLE "new__backend_playlist" RENAME TO "backend_playlist";
CREATE UNIQUE INDEX "backend_playlist_songs_playlist_id_song_id_529d6dae_uniq" ON "backend_playlist_songs" ("playlist_id", "song_id");
CREATE INDEX "backend_playlist_songs_playlist_id_95de618b" ON "backend_playlist_songs" ("playlist_id");
CREATE INDEX "backend_playlist_songs_song_id_67f0d6cf" ON "backend_playlist_songs" ("song_id");
CREATE INDEX "backend_playlist_creator_id_8fc263b5" ON "backend_playlist" ("creator_id");
--
-- Alter field title on song
--
CREATE TABLE "new__backend_song" ("song_id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "year" date NOT NULL, "duration" bigint NOT NULL, "title" varchar(50) NOT NULL);
INSERT INTO "new__backend_song" ("song_id", "year", "duration", "title") SELECT "song_id", "year", "duration", "title" FROM "backend_song";
DROP TABLE "backend_song";
ALTER TABLE "new__backend_song" RENAME TO "backend_song";
--
-- Add field album to song
--
CREATE TABLE "new__backend_song" ("title" varchar(50) NOT NULL, "song_id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "year" date NOT NULL, "duration" bigint NOT NULL, "album_id" integer NOT NULL REFERENCES "backend_album" ("album_id") DEFERRABLE INITIALLY DEFERRED);
INSERT INTO "new__backend_song" ("title", "song_id", "year", "duration", "album_id") SELECT "title", "song_id", "year", "duration", 21 FROM "backend_song";
DROP TABLE "backend_song";
ALTER TABLE "new__backend_song" RENAME TO "backend_song";
CREATE INDEX "backend_song_album_id_8faf312d" ON "backend_song" ("album_id");
COMMIT;
BEGIN;
--
-- Alter field year on song
--
CREATE TABLE "new__backend_song" ("year" datetime NOT NULL, "title" varchar(50) NOT NULL, "song_id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "duration" bigint NOT NULL, "album_id" integer NOT NULL REFERENCES "backend_album" ("album_id") DEFERRABLE INITIALLY DEFERRED);
INSERT INTO "new__backend_song" ("title", "song_id", "duration", "album_id", "year") SELECT "title", "song_id", "duration", "album_id", "year" FROM "backend_song";
DROP TABLE "backend_song";
ALTER TABLE "new__backend_song" RENAME TO "backend_song";
CREATE INDEX "backend_song_album_id_8faf312d" ON "backend_song" ("album_id");
COMMIT;
BEGIN;
--
-- Alter field duration on song
--
CREATE TABLE "new__backend_song" ("duration" bigint NOT NULL, "title" varchar(50) NOT NULL, "song_id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "year" datetime NOT NULL, "album_id" integer NOT NULL REFERENCES "backend_album" ("album_id") DEFERRABLE INITIALLY DEFERRED);
INSERT INTO "new__backend_song" ("title", "song_id", "year", "album_id", "duration") SELECT "title", "song_id", "year", "album_id", "duration" FROM "backend_song";
DROP TABLE "backend_song";
ALTER TABLE "new__backend_song" RENAME TO "backend_song";
CREATE INDEX "backend_song_album_id_8faf312d" ON "backend_song" ("album_id");
COMMIT;
BEGIN;
--
-- Remove field count from playlist
--
CREATE TABLE "new__backend_playlist" ("playlist_name" varchar(50) NOT NULL, "playlist_id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "duration" bigint NOT NULL, "date_created" datetime NOT NULL, "last_modified" datetime NOT NULL, "creator_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED);
INSERT INTO "new__backend_playlist" ("playlist_name", "playlist_id", "duration", "date_created", "last_modified", "creator_id") SELECT "playlist_name", "playlist_id", "duration", "date_created", "last_modified", "creator_id" FROM "backend_playlist";
DROP TABLE "backend_playlist";
ALTER TABLE "new__backend_playlist" RENAME TO "backend_playlist";
CREATE INDEX "backend_playlist_creator_id_8fc263b5" ON "backend_playlist" ("creator_id");
--
-- Remove field duration from playlist
--
CREATE TABLE "new__backend_playlist" ("playlist_name" varchar(50) NOT NULL, "playlist_id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "date_created" datetime NOT NULL, "last_modified" datetime NOT NULL, "creator_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED);
INSERT INTO "new__backend_playlist" ("playlist_name", "playlist_id", "date_created", "last_modified", "creator_id") SELECT "playlist_name", "playlist_id", "date_created", "last_modified", "creator_id" FROM "backend_playlist";
DROP TABLE "backend_playlist";
ALTER TABLE "new__backend_playlist" RENAME TO "backend_playlist";
CREATE INDEX "backend_playlist_creator_id_8fc263b5" ON "backend_playlist" ("creator_id");
--
-- Remove field duration from song
--
CREATE TABLE "new__backend_song" ("title" varchar(50) NOT NULL, "song_id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "year" datetime NOT NULL, "album_id" integer NOT NULL REFERENCES "backend_album" ("album_id") DEFERRABLE INITIALLY DEFERRED);
INSERT INTO "new__backend_song" ("title", "song_id", "year", "album_id") SELECT "title", "song_id", "year", "album_id" FROM "backend_song";
DROP TABLE "backend_song";
ALTER TABLE "new__backend_song" RENAME TO "backend_song";
CREATE INDEX "backend_song_album_id_8faf312d" ON "backend_song" ("album_id");
--
-- Remove field year from song
--
CREATE TABLE "new__backend_song" ("title" varchar(50) NOT NULL, "song_id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "album_id" integer NOT NULL REFERENCES "backend_album" ("album_id") DEFERRABLE INITIALLY DEFERRED);
INSERT INTO "new__backend_song" ("title", "song_id", "album_id") SELECT "title", "song_id", "album_id" FROM "backend_song";
DROP TABLE "backend_song";
ALTER TABLE "new__backend_song" RENAME TO "backend_song";
CREATE INDEX "backend_song_album_id_8faf312d" ON "backend_song" ("album_id");
COMMIT;
BEGIN;
--
-- Rename field album_id on album to id
--
ALTER TABLE "backend_album" RENAME COLUMN "album_id" TO "id";
--
-- Rename field artist_id on artist to id
--
ALTER TABLE "backend_artist" RENAME COLUMN "artist_id" TO "id";
--
-- Rename field playlist_id on playlist to id
--
ALTER TABLE "backend_playlist" RENAME COLUMN "playlist_id" TO "id";
--
-- Rename field song_id on song to id
--
ALTER TABLE "backend_song" RENAME COLUMN "song_id" TO "id";
COMMIT;
BEGIN;
--
-- Rename field playlist_name on playlist to name
--
ALTER TABLE "backend_playlist" RENAME COLUMN "playlist_name" TO "name";
COMMIT;
BEGIN;
--
-- Add field artist to album
--
CREATE TABLE "new__backend_album" ("artist_id" integer NOT NULL REFERENCES "backend_artist" ("id") DEFERRABLE INITIALLY DEFERRED, "title" varchar(50) NOT NULL, "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT);
INSERT INTO "new__backend_album" ("title", "id", "artist_id") SELECT "title", "id", 1 FROM "backend_album";
DROP TABLE "backend_album";
ALTER TABLE "new__backend_album" RENAME TO "backend_album";
CREATE INDEX "backend_album_artist_id_76ed25cf" ON "backend_album" ("artist_id");
COMMIT;
