const express = require('express');
const path = require('path');
const { initDb, getUsers } = require('./database');

const app = express();
const PORT = 3000;

// Serve static files (HTML, CSS, JS)
app.use(express.static(path.join(__dirname, '../public')));

// Initialize the database
initDb();

// API route to get the users
app.get('/api/users', async (req, res) => {
  try {
    const users = await getUsers();
    res.json(users);
  } catch (error) {
    console.error(error);
    res.status(500).send('Error retrieving users');
  }
});

// Parse JSON body
app.use(express.json());

app.get('/image/:tableName', async (req, res) => {
    const { tableName } = req.params;
  
    // To prevent SQL injection, make sure the table name is sanitized, possibly whitelist the table names
    const allowedTables = ['dog', 'cow', 'pig', 'armadillo'];
    
    if (!allowedTables.includes(tableName)) {
      return res.status(400).json({ message: 'Invalid table name' });
    }
  
    try {
      const queryText = `SELECT * FROM ${tableName}`; // Fetch one record for simplicity
      const result = await pool.query(queryText);
  
      if (result.rows.length > 0) {
        res.json(result.rows[0]);
      } else {
        res.status(404).json({ message: 'Image not found' });
      }
    } catch (err) {
      console.error('Error fetching image data:', err);
      res.status(500).json({ message: 'Server error' });
    }
  });

// Start the server
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
