// Event listener for the "Load Data" button
document.getElementById('loadData').addEventListener('click', function() {
  fetch('http://localhost:3000/getTableData')
    .then(response => response.json())
    .then(data => {
      const tableBody = document.querySelector('#dataTable tbody');
      tableBody.innerHTML = ''; // Clear the existing data

      // Loop through the data and create table rows
      data.forEach(row => {
        const tr = document.createElement('tr');
        tr.innerHTML = `
          <td>${row.id}</td>
          <td>${row.name}</td>
          <td>${row.email}</td>
        `;
        tableBody.appendChild(tr);
      });
    })
    .catch(error => console.error('Error loading data:', error));
});




