DROP TABLE IF EXISTS dog;
DROP TABLE IF EXISTS pig;
DROP TABLE IF EXISTS cow;
DROP TABLE IF EXISTS armadillo;
-- Create the users table
CREATE TABLE IF NOT EXISTS dog (
    id serial,
    name text,
    state text,
    comment text,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS pig (
    id serial,
    name text,
    state text,
    comment text,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS cow (
    id serial,
    name text,
    state text,
    comment text,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS armadillo (
    id serial,
    name text,
    state text,
    comment text,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- Insert some default data into the table
INSERT INTO dog (name, state, comment) VALUES
('Random Name', 'Random State', 'This is a lemon beagle, leave a comment on its wall!');

INSERT INTO pig (name, state, comment) VALUES
('Random Name', 'Random State', 'This is a pig, leave a comment on its wall!');
INSERT INTO cow (name, state, comment) VALUES
('Random Name', 'Random State', 'This is a cow, leave a comment on its wall!');
INSERT INTO armadillo (name, state, comment) VALUES
('Random Name', 'Random State', 'This is a armadillo, leave a comment on its wall!');
