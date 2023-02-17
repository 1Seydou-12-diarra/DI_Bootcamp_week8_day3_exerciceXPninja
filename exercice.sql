-- 1- Récupérez tous les films classés G ou PG, qui ne sont pas actuellement loués (ils ont été rendus/n'ont jamais été empruntés).
SELECT *
FROM movies
LEFT JOIN rentals ON movies.movie_id = rentals.movie_id
WHERE (rating = 'G' OR rating = 'PG') AND (rentals.rental_id IS NULL OR rentals.return_date IS NOT NULL)


-- 2- Créez une nouvelle table qui représentera une liste d'attente pour les films pour enfants. Cela permettra à un enfant d'ajouter
-- son nom à la liste jusqu'à ce que le DVD soit disponible (a été retourné). Une fois que l'enfant prend le DVD, son nom doit être retiré 
-- de la liste d'attente (idéalement en utilisant des déclencheurs, mais nous ne les connaissons pas encore. Supposons que notre programme Python gère cela).
--Quelles références de table doivent être incluses ?
CREATE TABLE waiting_list (
    waiting_id SERIAL PRIMARY KEY,
    movie_id INTEGER REFERENCES movies(movie_id),
    child_name VARCHAR(255),
    date_added DATE
);


-- 3- Récupérez le nombre de personnes qui attendent le DVD de chaque enfant. Testez cela en ajoutant des lignes au tableau que vous avez créé à la question 2 ci-dessus.
SELECT movies.title, COUNT(waiting_list.waiting_id) AS num_waiting
FROM movies
LEFT JOIN waiting_list ON movies.movie_id = waiting_list.movie_id
GROUP BY movies.title
