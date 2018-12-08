CREATE TABLE comments(id SERIAL PRIMARY KEY, text VARCHAR(240), bookmark_id INT REFERENCES bookmarks(id);
