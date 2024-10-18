document.addEventListener('DOMContentLoaded', function() {
    const imageElements = document.querySelectorAll('.animalPictures');  // Select all images with class "animalPictures"
  
    // Add event listeners to all images
    imageElements.forEach(function(imageElement) {
      imageElement.addEventListener('click', function() {
        fetchImageData(imageElement);  // Call fetchImageData when an image is clicked
      });
    });
    const backButton = document.querySelector('.back-to-gallery-button');
    if (backButton) {
        backButton.addEventListener('click', backToGallery);
      }

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
      responseMessage.style.display = 'none';
      if (imageDataTable) {
        console.log("why is not hidden");
        imageDataTable.style.display = 'none'; // Ensure the table is hidden when going back to the gallery
        document.getElementById('AddComment').style.display = 'none';
      }
    }
    
    function fetchImageData(imageElement) {
        console.log("show this on console");
        showImage(imageElement.src);
      
        const imageName = imageElement.src.split('/').pop().split('.')[0];  // Extract the image name without the extension
        
        console.log("Fetching data for image: " + imageName);
      
        fetch(`/image/${imageName}`)
          .then(response => response.json())
          .then(data => {
            if (data.success) {
                console.log("inside the data success loop");
              displayImageData(data.data);
              const form = document.getElementById('AddComment');
              form.addEventListener('submit', (event) => handleFormSubmit(event, imageName));
            } else {
              console.error("No data found for image: " + imageName);
            }
          })
          .catch(error => console.error("Error fetching image data:", error));
      }
      
    function displayImageData(imageData) {
        
        console.log("imageData:", imageData); 
      const tableBody = document.getElementById('imageDataTable') ? document.getElementById('imageDataTable').getElementsByTagName('tbody')[0] : null;
  
      if (!tableBody) {
        console.error("No table with id 'imageDataTable' found.");
        return;
      }
  
      // Clear existing rows in the table
      tableBody.innerHTML = '';
  
      // Create rows for the table from the fetched data
      imageData.forEach(item => {
        const row = tableBody.insertRow();  // Add a new row
  
        // Insert cells and populate them with the fetched data
        const cell1 = row.insertCell(0);  // Assuming "id" field
        const cell2 = row.insertCell(1);  // Assuming "image_url" field
        const cell3 = row.insertCell(2);  // Assuming "description" field
        const cell4 = row.insertCell(3);  // Assuming "description" field
        cell1.textContent = item.name;       // ID from database
        cell2.textContent = item.state;  // Image URL from database
        cell3.textContent = item.comment; // Description from database
        cell4.textContent = item.created_at;

        document.getElementById('imageDataTable').style.display = 'table';
        document.getElementById('AddComment').style.display = 'block';

      });
    }

    function handleFormSubmit(event, imageElement) {
        event.preventDefault();

        const name = document.getElementById('name').value;
        const description = document.getElementById('description').value;
        const comment = document.getElementById('comment').value;

        const data = {
            name: name,
            description: description,
            comment: comment
        };
        fetch(`/add-image/${imageElement}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
        .then(response => response.json())
        .then(data => {
            const messageElement = document.getElementById('responseMessage');
            if (data.success) {
                refreshTable(imageElement);
                responseMessage.style.display = 'inline';
                messageElement.textContent = 'comment added to wall successfully!';
                messageElement.style.color = 'green';
                document.getElementById('name').value = '';
                document.getElementById('description').value = '';
                document.getElementById('comment').value = '';
            } else {
                messageElement.textContent = 'Error adding image data: ' + data.message;
                messageElement.style.color = 'red';
            }
        })
        .catch(error => console.error('Error:', error));
    }

    function refreshTable(imageName) {
        // Fetch the updated data from the server (use your appropriate API to fetch all data)
        fetch(`/image/${imageName}`)
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    console.log("refreshing table here");
                    // Assuming 'imageDataTable' is the table where image data is displayed
                    displayImageData(data.data);  // Re-render the table with the new data
                } else {
                    console.error("Error fetching updated data:", data.message);
                }
            })
            .catch(error => console.error("Error refreshing the table:", error));
    }
  });
  
