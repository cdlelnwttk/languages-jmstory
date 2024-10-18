DROP TABLE IF EXISTS users;

-- Create the users table
CREATE TABLE dog (
    id serial,
    name text,
    state text,
    comment text,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert some default data into the table
INSERT INTO dog (name, state, comment) VALUES
('jane', 'PA', 'This is a lemon beagle, leave a comment on his wall!');
