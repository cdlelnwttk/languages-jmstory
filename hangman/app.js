const express = require('express');
const bodyParser = require('body-parser');
const { Pool } = require('pg');

const app = express();
app.use(bodyParser.json());

const pool = new Pool({
    user: 'wmacevoy',
    host: 'localhost',
    database: 'tasks_db',  // Name of the database
    password: 'password123',
    port: 5432,
});

// Create the tasks table if it doesn't exist
const createTableQuery = `
    CREATE TABLE IF NOT EXISTS tasks (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        description TEXT NOT NULL
    );
`;

// Insert default tasks into the tasks table
const insertDefaultTasksQuery = `
    INSERT INTO tasks (name, description)
    VALUES 
        ('Example Task 1', 'This is the description for task 1'),
        ('Example Task 2', 'This is the description for task 2'),
        ('Example Task 3', 'This is the description for task 3')
    ON CONFLICT (name) DO NOTHING;
`;

// Run both queries when the server starts
app.listen(3000, async () => {
    try {
        // Create table if it doesn't exist
        await pool.query(createTableQuery);

        // Insert default tasks if they don't exist
        await pool.query(insertDefaultTasksQuery);

        console.log('Server is running on port 3000');
    } catch (error) {
        console.error('Error during server initialization:', error);
    }
});



