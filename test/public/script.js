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
  
  // Function to show the clicked image in enlarged view
function showImage(imageSrc) {
    const galleryView = document.querySelector('.gallery-view');
    const enlargedView = document.querySelector('.enlarged-view');
    const enlargedImage = document.getElementById('enlarged-image');
  
    // Hide the gallery view and show the enlarged view
    galleryView.style.display = 'none';
    enlargedView.style.display = 'flex';
  
    // Set the clicked image as the source for the enlarged image
    enlargedImage.src = imageSrc;
  }
  
  // Function to go back to the gallery view
  function backToGallery() {
    const galleryView = document.querySelector('.gallery-view');
    const enlargedView = document.querySelector('.enlarged-view');
  
    // Show the gallery view and hide the enlarged view
    galleryView.style.display = 'flex';
    enlargedView.style.display = 'none';
  }
  
  function fetchImageData(tableName) {
    // Fetch the data from the backend based on the table name
    fetch(`/image/${tableName}`)
      .then(response => response.json())
      .then(data => {
        // Display the enlarged image and details
        document.getElementById('enlarged-image').src = data.image_url;
        document.getElementById('description').textContent = data.description;
        
        // Show the details section
        document.getElementById('image-details').style.display = 'block';
      })
      .catch(error => {
        console.error('Error fetching image data:', error);
      });
  }

  function fetchImageData(imageElement) {
    // Get the image file name without the extension
    const imageName = imageElement.src.split('/').pop().split('.')[0]; // Strip the .jpg extension
    console.log("Image name (table):", imageName); // Check the table name being used

    // Fetch the data from the backend based on the image name
    fetch(`/image/${imageName}`)
      .then(response => response.json())
      .then(data => {
        // Display the enlarged image and details
        document.getElementById('enlarged-image').src = data.image_url;
        document.getElementById('description').textContent = data.description;

        // Show the details section
        document.getElementById('image-details').style.display = 'block';
      })
      .catch(error => {
        console.error('Error fetching image data:', error);
      });
  }