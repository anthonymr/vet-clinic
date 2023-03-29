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

SELECT animals.name FROM animals
  LEFT JOIN owners ON animals.owners_id = owners.id
  WHERE owners.full_name = 'Melody Pond';

SELECT * FROM animals
  LEFT JOIN species ON animals.species_id = species.id
  WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name FROM owners
  LEFT JOIN animals ON owners.id = animals.owners_id;

SELECT species.name, count(*) AS animals_by_specie FROM animals
  JOIN species ON animals.species_id = species.id
  GROUP BY species.name;

SELECT animals.* FROM animals
  JOIN owners ON animals.owners_id = owners.id
  JOIN species ON animals.species_id = species.id
  WHERE 
    species.name = 'Digimon'
    AND owners.full_name = 'Jennifer Orwell';

SELECT animals.* FROM animals
  JOIN owners ON animals.owners_id = owners.id
  WHERE 
    owners.full_name = 'Dean Winchester'
    AND animals.escape_attempts = 0;

SELECT owners.full_name FROM animals
  JOIN owners ON animals.owners_id = owners.id
  GROUP BY owners.id
  ORDER BY count(*) DESC
  LIMIT 1;

SELECT animals.name, visits.date_of_visit FROM vets
  LEFT JOIN visits ON vets.id = visits.vets_id
  LEFT JOIN animals ON visits.animals_id = animals.id
  WHERE vets.name = 'William Tatcher'
  ORDER BY date_of_visit DESC
  LIMIT 1;

SELECT count(distinct(visits.animals_id)) AS different_animals FROM visits
  LEFT JOIN vets ON visits.vets_id = vets.id
  WHERE vets.name = 'Stephanie Mendez';

SELECT vets.name, species.name  FROM vets
  LEFT JOIN specializations ON vets.id = specializations.vets_id
  LEFT JOIN species ON specializations.species_id = species.id;

SELECT animals.name, visits.date_of_visit FROM visits
  LEFT JOIN animals on visits.animals_id = animals.id
  LEFT JOIN vets on visits.vets_id = vets.id
  WHERE vets.name = 'Stephanie Mendez'
  AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

SELECT animals.name, count(*) AS number_of_visits FROM visits
  LEFT JOIN animals ON visits.animals_id = animals.id
  GROUP BY animals.name
  ORDER BY count(*) DESC
  LIMIT 1;

SELECT animals.name, date_of_visit FROM visits
  LEFT JOIN animals ON visits.animals_id = animals.id
  LEFT JOIN vets ON visits.vets_id = vets.id
  WHERE vets.name = 'Maisy Smith'
  ORDER BY date_of_visit DESC
  LIMIT 1;

SELECT animals.name AS animal_name, 
       animals.date_of_birth AS animal_date_of_birth,
       animals.escape_attempts AS animal_escape_attempts, 
       animals.neutered AS animal_neutered,
       animals.weight_kg AS animal_weight_kg,
       vets.name AS vet_name,
       vets.age AS vet_age,
       vets.date_of_graduation AS vet_date_of_graduation,
       visits.date_of_visit
  FROM visits
    LEFT JOIN animals ON visits.animals_id = animals.id
    LEFT JOIN vets ON visits.vets_id = vets.id
    ORDER BY visits.date_of_visit DESC;

SELECT count(*) AS visits_withow_specialization FROM visits
  LEFT JOIN vets ON visits.vets_id = vets.id
  LEFT JOIN animals ON visits.animals_id = animals.id
  LEFT JOIN specializations ON (
    vets.id = specializations.vets_id
    AND animals.species_id = specializations.species_id
  )
  WHERE specializations.id IS NULL;

SELECT species.name AS new_maysys_speciality FROM visits
  LEFT JOIN vets ON visits.vets_id = vets.id
  LEFT JOIN animals ON visits.animals_id = animals.id
  LEFT JOIN species ON animals.species_id = species.id
  WHERE vets.name = 'Maisy Smith'
  GROUP BY species.name
  ORDER BY count(species.name) DESC
  LIMIT 1;