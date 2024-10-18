const { Pool } = require('pg');
const fs = require('fs');
const path = require('path');

// Create a pool of connections to the database
const pool = new Pool({
  user: 'fullstack',
  host: 'localhost',
  database: 'fullstack',
  password: 'password',
  port: 5432,
});

// Function to initialize the table and seed data from an SQL file
const initDb = async () => {
  const client = await pool.connect();

  try {
    // Read SQL file
    const sql = fs.readFileSync(path.join(__dirname, '../init.sql')).toString();

    // Execute SQL file
    await client.query(sql);
    console.log("Database initialized with schema and data");
  } catch (error) {
    console.error('Error executing SQL file', error);
  } finally {
    client.release();
  }
};

// Function to get all users from the database
const getUsers = async () => {
  const client = await pool.connect();
  try {
    const res = await client.query('SELECT * FROM users');
    return res.rows;
  } finally {
    client.release();
  }
};

module.exports = { initDb, getUsers, pool };
