
  CREATE TABLE IF NOT EXISTS tasks (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        description TEXT NOT NULL
    );

-- To insert a task
INSERT INTO tasks (name, description) VALUES ('testTask', 'testDesc'), ('test2', 'desc2');


