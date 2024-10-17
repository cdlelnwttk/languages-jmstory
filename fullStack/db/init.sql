-- File: db/init.sql

CREATE TABLE IF NOT EXISTS images (
  id INT AUTO_INCREMENT PRIMARY KEY,
  image_name VARCHAR(255) NOT NULL,
  description TEXT
);

-- Insert some sample data
INSERT INTO images (title, description) VALUES 
('cat.jpg', 'This is a cat. Cats are great pets.'),
('dog.jpg', 'This is a dog. Dogs are loyal companions.');
