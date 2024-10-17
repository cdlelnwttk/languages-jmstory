const express = require('express');
const app = express();
const port = 3000;

// Sample data that will be sent to the front-end
const tableData = [
  { id: 1, name: 'John Doe', email: 'john@example.com' },
  { id: 2, name: 'Jane Smith', email: 'jane@example.com' },
  { id: 3, name: 'Sam Johnson', email: 'sam@example.com' }
];

// Middleware to serve static files (HTML, JS)
app.use(express.static('public'));

// Route to send table data
app.get('/getTableData', (req, res) => {
  res.json(tableData);  // Return the data as JSON
});

// Start the server
app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});

