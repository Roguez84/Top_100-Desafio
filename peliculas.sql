--DONE --Crear base de datos llamada películas (1 punto)
CREATE DATABASE peliculas;
\c peliculas;

--DONE --2. Revisar los archivos peliculas.csv y reparto.csv para crear las tablas correspondientes,determinando la relación entre ambas tablas. (2 puntos)
--Es la columna id de peliculas con la primera columna (no tiene nombre) de repartos
CREATE TABLE peliculas(
    ranking INT,
    Pelicula VARCHAR(120),
    Ano_estreno INT,
    Director VARCHAR(60),
    PRIMARY KEY (ranking)
);

CREATE TABLE reparto(
    ranking INT,
    nombre_actor VARCHAR(60),
    FOREIGN KEY (ranking) REFERENCES peliculas(ranking)
);

--DONE --3. Cargar ambos archivos a su tabla correspondiente (1 punto)
\copy peliculas FROM '/home/tony/dev-Folder-Ubuntu/Base_de_datos/Top_100-Desafio/Apoyo Desafío 2 -  Top 100/peliculas.csv' csv header;

\copy reparto FROM '/home/tony/dev-Folder-Ubuntu/Base_de_datos/Top_100-Desafio/Apoyo Desafío 2 -  Top 100/reparto.csv' csv;

--DONE --4. Listar todos los actores que aparecen en la película "Titanic", indicando el título de la película,año de estreno, director y todo el reparto. (0.5 puntos)
SELECT Pelicula, ano_estreno, Director, nombre_actor
FROM peliculas JOIN reparto 
ON peliculas.ranking=reparto.ranking
WHERE Pelicula='Titanic'
;
--DONE --5. Listar los titulos de las películas donde actúe Harrison Ford.(0.5 puntos)
SELECT Pelicula
FROM peliculas JOIN reparto
ON peliculas.ranking=reparto.ranking
WHERE nombre_actor = 'Harrison Ford'
;
--DONE -- 6. Listar los 10 directores mas populares, indicando su nombre y cuántas películas aparecen en eltop 100.(1 puntos)
SELECT Director, COUNT(Director) AS cuenta
FROM peliculas
GROUP BY Director
ORDER BY cuenta DESC
LIMIT 10
;

--DONE --7. Indicar cuantos actores distintos hay (1 puntos)
SELECT COUNT(DISTINCT(nombre_actor))
FROM reparto
--ORDER BY nombre_actor
;

--DONE --8. Indicar las películas estrenadas entre los años 1990 y 1999 (ambos incluidos) ordenadas portítulo de manera ascendente.(1 punto)
SELECT Pelicula, Ano_estreno
FROM peliculas
WHERE Ano_estreno >= 1990 AND Ano_estreno <=1999
ORDER BY Pelicula ASC
;

--DONE --9. Listar el reparto de las películas lanzadas el año 2001 (1 punto)
SELECT nombre_actor, Pelicula, Ano_estreno
FROM peliculas JOIN reparto
ON peliculas.ranking=reparto.ranking
WHERE Ano_estreno =2001
;

--DONE --10. Listar los actores de la película más nueva (1 punto)
--Necesito cachar mejor como usar MAX y MIN
SELECT nombre_actor, Pelicula, Ano_estreno
FROM peliculas JOIN reparto
ON peliculas.ranking=reparto.ranking
WHERE Ano_estreno = (
        SELECT MAX(Ano_estreno)
        FROM peliculas
)
;
