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
      if (imageDataTable) {
        console.log("why is not hidden");
        imageDataTable.style.display = 'none'; // Ensure the table is hidden when going back to the gallery
        document.getElementById('addData').style.display = 'none';
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
        document.getElementById('addData').style.display = 'block';

      });
    }


  });
  
  