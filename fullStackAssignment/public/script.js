document.addEventListener('DOMContentLoaded', function() {
    const imageElements = document.querySelectorAll('.animalPictures');  // Select all images with class "animalPictures"

    let currentImageName = ''; // Variable to store the currently selected image name

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
        const responseMessage = document.getElementById('responseMessage');  // Assuming you have a responseMessage element
        const imageDataTable = document.getElementById('imageDataTable'); // Assuming you have the imageDataTable element

        // Show the gallery view and hide the enlarged view
        galleryView.style.display = 'flex';
        enlargedView.style.display = 'none';
        if (responseMessage) {
            responseMessage.style.display = 'none';
        }
        if (imageDataTable) {
            imageDataTable.style.display = 'none'; // Ensure the table is hidden when going back to the gallery
            document.getElementById('AddComment').style.display = 'none';
        }
    }

    // Function to fetch image data
    function fetchImageData(imageElement) {
        showImage(imageElement.src);

        currentImageName = imageElement.src.split('/').pop().split('.')[0];  // Extract the image name without the extension


        fetch(`/image/${currentImageName}`)
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    displayImageData(data.data);
                } else {
                    console.error("No data found for image: " + currentImageName);
                }
            })
            .catch(error => console.error("Error fetching image data:", error));
    }

    // Function to display image data
    function displayImageData(imageData) {
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
            const cell1 = row.insertCell(0);  // Assuming "name" field (ID)
            const cell2 = row.insertCell(1);  // Assuming "state" field (Image URL)
            const cell3 = row.insertCell(2);  // Assuming "comment" field (Description)
            const cell4 = row.insertCell(3);  // Assuming "created_at" field (Date)

            // Populate cells with data
            cell1.textContent = item.name;       
            cell2.textContent = item.state;  
            cell3.textContent = item.comment; 
            cell4.textContent = item.created_at;

            // Show the table and the "AddComment" section
            document.getElementById('imageDataTable').style.display = 'table';
            document.getElementById('AddComment').style.display = 'block';
        });
    }

    // Form submit handler
    const form = document.getElementById('AddComment');
    if (form) {
        form.addEventListener('submit', (event) => {
            event.preventDefault();  // Prevent the default form submission

            const name = document.getElementById('name').value;
            const description = document.getElementById('description').value;
            const comment = document.getElementById('comment').value;

            if (!name || !description || !comment) {
                const responseMessage = document.getElementById('responseMessage');
                if (responseMessage) {
                    responseMessage.textContent = 'All fields are required!';
                    responseMessage.style.color = 'red';
                }
                return;
            }

            const data = {
                name: name,
                description: description,
                comment: comment
            };

            fetch(`/add-image/${currentImageName}`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            })
            .then(response => response.json())
            .then(data => {
                const responseMessage = document.getElementById('responseMessage');
                if (responseMessage) {
                    if (data.success) {
                        responseMessage.style.display = 'inline';
                        responseMessage.textContent = 'Comment added successfully!';
                        responseMessage.style.color = 'green';

                        // Clear form fields after successful submission
                        document.getElementById('name').value = '';
                        document.getElementById('description').value = '';
                        document.getElementById('comment').value = '';

                        // Refresh the image data to show updated data
                        refreshTable(currentImageName);
                    } else {
                        responseMessage.textContent = 'Error adding comment';
                        responseMessage.style.color = 'red';
                    }
                }
            })
            .catch(error => console.error('Error:', error));
        });
    }

    // Function to refresh the image data table
    function refreshTable(imageName) {
        // Fetch the updated data from the server (use your appropriate API to fetch all data)
        fetch(`/image/${imageName}`)
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Assuming 'imageDataTable' is the table where image data is displayed
                    displayImageData(data.data);  // Re-render the table with the new data
                } else {
                    console.error("Error fetching updated data:", data.message);
                }
            })
            .catch(error => console.error("Error refreshing the table:", error));
    }
});
