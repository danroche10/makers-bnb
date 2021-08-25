CREATE TABLE requests (id SERIAL PRIMARY KEY, start_date DATE, end_date DATE, user_id integer REFERENCES users(id), space_id integer REFERENCES spaces(id), approval_status BOOLEAN DEFAULT null)
