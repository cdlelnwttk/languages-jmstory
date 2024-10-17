CREATE TABLE movies (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  poster_url VARCHAR(255)
);

INSERT INTO movies (name, poster_url) VALUES
('Inception', 'https://image.tmdb.org/t/p/w500/qmDpIHrmpJINaRKAfWQfftjCdyi.jpg'),
('Titanic', 'https://image.tmdb.org/t/p/w500/wSptpaWSWyUpIuLgoYx1qzTklQT.jpg'),
('Avatar', 'https://image.tmdb.org/t/p/w500/5PSNL1qE6FWSQj4h7oxkMqaWvP.jpg'),
('The Matrix', 'https://image.tmdb.org/t/p/w500/x0d5xWfvQOiy3deIdXsaM6Tx0Ob.jpg'),
('The Dark Knight', 'https://image.tmdb.org/t/p/w500/1hRpDVi7qZQ7Nq6h8T3P0TVfp08.jpg');
