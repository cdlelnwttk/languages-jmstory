window.onload = async () => {
    const response = await fetch('http://backend:3000/api/movies');
    const movies = await response.json();
    
    const postersDiv = document.getElementById('posters');
    
    movies.forEach(movie => {
      const img = document.createElement('img');
      img.src = movie.poster_url;
      postersDiv.appendChild(img);
    });
  };
  
  document.getElementById('submit').addEventListener('click', () => {
    const guess = document.getElementById('guess').value;
    fetch('http://backend:3000/api/movies')
      .then(response => response.json())
      .then(movies => {
        const correctMovie = movies.find(movie => movie.name.toLowerCase() === guess.toLowerCase());
        const resultDiv = document.getElementById('result');
        if (correctMovie) {
          resultDiv.textContent = `Correct! It was ${correctMovie.name}`;
        } else {
          resultDiv.textContent = 'Incorrect! Try again.';
        }
      });
  });
  