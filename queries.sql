/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals 
  WHERE name like '%mon';

SELECT name FROM animals 
  WHERE DATE_PART('Year', date_of_birth) BETWEEN 2016 AND 2019;

SELECT name FROM animals
  WHERE neutered = true AND
    escape_attempts < 3;

SELECT date_of_birth FROM animals
  WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals
  WHERE weight_kg > 10.5;

SELECT * FROM animals
  WHERE neutered = true;

SELECT * FROM animals
  WHERE name != 'Gabumon';

SELECT * FROM animals
  WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
  UPDATE animals
    SET species = 'unspecified';
  SELECT name, species FROM animals;
ROLLBACK;
SELECT name, species FROM animals;

BEGIN;
  UPDATE animals
    SET species = 'digimon'
    WHERE name like '%mon';
  UPDATE animals
    SET species = 'pokemon'
    WHERE species IS NULL;
COMMIT;
SELECT name, species FROM animals;

BEGIN;
  DELETE FROM animals;
  SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
  DELETE FROM animals
    WHERE date_of_birth > '2022-01-01';
  SAVEPOINT deleted_newly_born;
  UPDATE animals
    SET weight_kg = weight_kg * -1;
  ROLLBACK TO SAVEPOINT deleted_newly_born;
  UPDATE animals
    SET weight_kg = weight_kg * -1
    WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

SELECT count(*) AS animal_count FROM animals;

SELECT count(*) AS animal_rebels FROM animals
  WHERE escape_attempts > 0;

SELECT avg(weight_kg) AS weight_avg FROM animals;

SELECT name, escape_attempts FROM animals
  ORDER BY escape_attempts DESC
  LIMIT 1;

SELECT species, min(weight_kg) AS min_weight, max(weight_kg) AS max_weight FROM animals
  GROUP BY (species);

SELECT species, avg(escape_attempts) AS rebels_avg FROM animals
  WHERE DATE_PART('Year', date_of_birth) BETWEEN 1990 AND 2000
  GROUP BY species;