const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const db = require('./models/db');
const animalRoutes = require('./routes/animals');

const app = express();
app.use(cors());
app.use(bodyParser.json());

// Routes
app.use('/animals', animalRoutes);

// Connect to the database and start server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
