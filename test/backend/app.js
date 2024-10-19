const express = require('express');
const path = require('path');
const { initDb, getUsers, pool } = require('./database');

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

// Start the server
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});

// Parse JSON body
app.use(express.json());

app.get('/image/:imageName', async (req, res) => {
    let imageName = req.params.imageName;  // The image name passed (e.g., 'dog.jpg')
    
    console.log(`Fetching data for image: ${imageName}`); 

    try {
        // Fetch data from the database related to the image (using the table name that matches the image name)
        const queryResult = await pool.query(`SELECT * FROM "${imageName}"`); // Assuming the table name matches the image name
        const imageData = queryResult.rows;  // Get all rows from the table

        if (imageData.length > 0) {
            // Send the fetched data to the frontend
            res.json({
                success: true,
                data: imageData
            });
        } else {
            res.json({
                success: false,
                message: 'No data found for the image'
            });
        }
    } catch (error) {
        console.error('Error fetching image data:', error);
        res.status(500).json({ error: 'Failed to fetch image data' });
    }
});

app.post('/add-image/:imageName', async (req, res) => {
    console.log("here after the form");

    const imageName = req.params.imageName;  // The image name passed (e.g., 'dog.jpg')
    const { name, description, comment } = req.body;  // Extract name, description, and comment from request body

    try {
        // Dynamically create the query using imageName
        const query = `INSERT INTO "${imageName}" (name, state, comment) VALUES ($1, $2, $3) RETURNING *`;
        const values = [name, description, comment];

        const result = await pool.query(query, values);  // Execute the query

        // Respond with success and the inserted data
        res.status(200).json({ success: true, data: result.rows[0] });
    } catch (error) {
        console.error('Error inserting data:', error);
        res.status(500).json({ success: false, message: 'Error adding image data' });
    }
});
