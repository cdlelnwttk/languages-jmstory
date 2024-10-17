const db = require('../models/db');

// Get all animals
exports.getAnimals = async (req, res) => {
  try {
    const animals = await db.query('SELECT * FROM animals');
    res.json(animals.rows);
  } catch (err) {
    console.error(err);
    res.status(500).send('Server Error');
  }
};

// Get animal details by ID
exports.getAnimalDetails = async (req, res) => {
  const { id } = req.params;
  try {
    const animal = await db.query('SELECT * FROM animals WHERE id = $1', [id]);
    const info = await db.query('SELECT * FROM animal_info WHERE animal_id = $1', [id]);
    res.json({ animal: animal.rows[0], info: info.rows });
  } catch (err) {
    console.error(err);
    res.status(500).send('Server Error');
  }
};

// Add information to an animal
exports.addAnimalInfo = async (req, res) => {
  const { id } = req.params;
  const { category, information } = req.body;
  try {
    await db.query('INSERT INTO animal_info (animal_id, category, information) VALUES ($1, $2, $3)', [id, category, information]);
    res.status(201).send('Information Added');
  } catch (err) {
    console.error(err);
    res.status(500).send('Server Error');
  }
};
