const apiUrl = 'http://localhost:5000/animals';

document.addEventListener('DOMContentLoaded', () => {
  fetchAnimals();
});

async function fetchAnimals() {
  const res = await fetch(apiUrl);
  const animals = await res.json();
  
  const animalList = document.getElementById('animal-list');
  animals.forEach(animal => {
    const animalDiv = document.createElement('div');
    animalDiv.innerHTML = `<img src="${animal.image_url}" onclick="showAnimal(${animal.id})" alt="${animal.name}">`;
    animalList.appendChild(animalDiv);
  });
}

async function showAnimal(id) {
  const res = await fetch(`${apiUrl}/${id}`);
  const data = await res.json();
  
  document.getElementById('main-image').src = data.animal.image_url;
  document.getElementById('animal-name').innerText = data.animal.name;
  document.getElementById('animal-description').innerText = data.animal.description;
  
  const infoDiv = document.getElementById('animal-info');
  infoDiv.innerHTML = '';
  data.info.forEach(info => {
    const infoDiv = document.createElement('div');
    infoDiv.innerHTML = `<strong>${info.category}:</strong> ${info.information}`;
    infoDiv.classList.add('animal-info-item');
    infoDiv.classList.add(info.category);
    infoDiv.classList.add('info-div');
    infoDiv.classList.add('category-class');
    infoDiv.classList.add('new-category');
    infoDiv.classList.add('newtype');
    infoDiv.classList.add('category');
    infoDiv.classList.add('sections')
  })}