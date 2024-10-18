document.getElementById('fetchUsers').addEventListener('click', async () => {
    const response = await fetch('/api/users');
    const users = await response.json();
  
    const userTable = document.getElementById('userTable');
  
    if (users.length > 0) {
      let tableHtml = `
        <table>
          <thead>
            <tr>
              <th>ID</th>
              <th>Name</th>
              <th>Email</th>
            </tr>
          </thead>
          <tbody>
      `;
  
      users.forEach(user => {
        tableHtml += `
          <tr>
            <td>${user.id}</td>
            <td>${user.name}</td>
            <td>${user.email}</td>
          </tr>
        `;
      });
  
      tableHtml += '</tbody></table>';
      userTable.innerHTML = tableHtml;
    } else {
      userTable.innerHTML = '<p>No users found</p>';
    }
  });
  