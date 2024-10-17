CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE animal_info (
    id SERIAL PRIMARY KEY,
    animal_id INT REFERENCES animals(id) ON DELETE CASCADE,
    category VARCHAR(100),
    information TEXT
);

-- Sample Data
INSERT INTO animals (name, image_url, description) VALUES
('Lion', 'https://example.com/lion.jpg', 'The lion is a species of big cat native to Africa and India.'),
('Elephant', 'https://example.com/elephant.jpg', 'The elephant is the largest land animal on Earth.');

INSERT INTO animal_info (animal_id, category, information) VALUES
(1, 'Habitat', 'Lions live in grasslands and savannas.'),
(2, 'Diet', 'Elephants are herbivores and mainly eat grass, fruits, and bark.');
