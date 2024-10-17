const express = require('express');
const router = express.Router();
const { getAnimals, getAnimalDetails, addAnimalInfo } = require('../controllers/animalController');

// Get all animals
router.get('/', getAnimals);

// Get specific animal details by ID
router.get('/:id', getAnimalDetails);

// Add information to an animal
router.post('/:id/info', addAnimalInfo);

module.exports = router;
