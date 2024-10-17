const express = require('express');
const path = require('path');
const { Pool } = require('pg');

const app = express();
const port = 3000;

// PostgreSQL connection pool
const pool = new Pool({
  user: 'postgres',
  host: 'db',
  database: 'moviesdb',
  password: 'password',
  port: 5432,
});

app.use(express.static(path.join(__dirname, 'public')));

// API route to fetch movie posters and names
app.get('/api/movies', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM movies ORDER BY RANDOM() LIMIT 5');
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).send('Error retrieving movies');
  }
});

// Start server
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
