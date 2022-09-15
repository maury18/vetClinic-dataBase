SELECT * FROM animals WHERE name LIKE '%mon';

SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT * FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

SELECT name, date_of_birth FROM animals WHERE name = 'agumon' OR name = 'Pikachu';

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.50;

SELECT * FROM animals WHERE neutered = TRUE;

SELECT * FROM animals WHERE name != 'Gabumon';

SELECT * FROM animals WHERE weight_kg >= 10.40 AND weight_kg <= 17.30;

// Queries

/* species to unspecified */
BEGIN TRANSACTION;
UPDATE animals
	SET species = 'unspecified';
SELECT * FROM animals;

/* rolleback to species */


/* set digimon and pokemon species */
BEGIN TRANSACTION;

UPDATE animals
    SET species = 'digimon' WHERE name LIKE '%mon';

UPDATE animals
   SET species = 'pokemon' WHERE species IS NULL;

SELECT * FROM animals; 

// deleting all
BEGIN TRANSACTION;

DELETE FROM animals;

SELECT * FROM animals; 

// rolleback
ROLLBACK;

SELECT * FROM animals; 


/* deleting all animals born after jan 1st 2022 */
BEGIN TRANSACTION;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT delete2022;
SELECT * FROM animals;

/* update animals weigth */
BEGIN TRANSACTION;

UPDATE animals
   SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

SELECT * FROM animals;

COMMIT;

// Questions

// how many animals are there
SELECT COUNT(DISTINCT name) FROM animals;

/* how many animals have never tried to escape */
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

/* Average weight of animal */
SELECT AVG(weight_kg) FROM animals;

/* Who escapes the most, neutered or not neutered animals */
SELECT AVG(escape_attempts), neutered FROM animals GROUP BY neutered;

/* min and max weight */
SELECT MIN(weight_kg), MAX(weight_kg), species FROM animals GROUP BY species;

/* average scpae per animal type between 1990 - 2000 */
SELECT AVG(escape_attempts) AS AVERAGE_ESCAPES, species FROM animals
    WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

/* New Questions */
/* What animals belong to Melody Pond? */
SELECT name, full_name FROM animals JOIN owners
    ON animals.owner_id = owners.id
    WHERE owners.full_name = 'Melody Pond';

/* List of all animals that are pokemon (their type is Pokemon) */
SELECT animals.name FROM animals JOIN species
    ON animals.species_id = species.id
	WHERE species.name = 'Pokemon';

/* List all owners and their animals, remember to include those that don't own any animal */
SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals
    ON animals.owner_id = owners.id;

/* How many animals are there per species? */
SELECT COUNT(animals.name), species.name FROM animals
   JOIN species
   ON animals.species_id = species.id
   GROUP BY species.name;

/* List all Digimon owned by Jennifer Orwell */
SELECT animals.name, owners.full_name FROM animals
    JOIN owners ON animals.owner_id = owners.id
    JOIN species ON species.id = animals.species_id
	WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

/* List all animals owned by Dean Winchester that haven't tried to escape */
SELECT animals.name, owners.full_name FROM animals
    JOIN owners ON animals.owner_id = owners.id
	WHERE animals.escape_attempts = 0 AND owners.full_name = 'Dean Winchester';

/* Who owns the most animals? */
SELECT owners.full_name, COUNT(animals.id) FROM owners
    JOIN animals ON animals.owner_id = owners.id
	GROUP BY owners.full_name
	ORDER BY COUNT(animals.id) DESC
	LIMIT 1;

/* Queries... Questions */
/* last animal seen by William Tatcher */
SELECT animals.name, vets.name, visits.date_of_visit FROM animals JOIN visits 
ON animals.id = visits.animals_id JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit DESC
LIMIT 1;

/* How many different animals did Stephanie Mendez see */
SELECT COUNT(DISTINCT(animals.id)) FROM animals
JOIN visits on animals.id = visits.animals_id JOIN vets on visits.vets_id = vets.id
WHERE vets.name = 'Stephanie Mendez';


/* List all vets and their specialties, including vets with no specialties */
SELECT vets.name, species.name FROM vets LEFT JOIN specializations
ON vets.id = specializations.vets_id LEFT JOIN species
ON specializations.species_id = species.id;

/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020 */
SELECT animals.name, vets.name, visits.date_of_visit FROM animals JOIN visits 
ON animals.id = visits.animals_id JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'Stephanie Mendez' AND visits.date_of_visit > '2020-04-01'
AND visits.date_of_visit <= '2020-08-30'
ORDER BY visits.date_of_visit DESC;

/* What animal has the most visits to vets */
SELECT animals.name, COUNT(visits.animals_id) FROM visits JOIN animals 
ON animals.id = visits.animals_id
GROUP BY animals.name
ORDER BY COUNT(visits.animals_id) DESC
LIMIT 1;

/* Who was Maisy Smith's first visit */
SELECT animals.name, vets.name, visits.date_of_visit FROM animals JOIN visits 
ON animals.id = visits.animals_id JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.date_of_visit ASC
LIMIT 1;

/* Details for most recent visit: animal information, vet information, and date of visit */
SELECT animals.name, animals.date_of_birth, animals.escape_attempts, animals.neutered, animals.weight_kg,
species.name AS specie, owners.full_name AS owner, vets.name AS vet, vets.age AS vet_age,
vets.date_of_graduation AS vet_grad, visits.date_of_visit AS visit_date FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN species ON species.id = animals.species_id
JOIN owners ON owners.id = animals.owner_id
JOIN vets ON visits.vets_id = vets.id
ORDER BY visits.date_of_visit DESC
LIMIT 1;

/* How many visits were with a vet that did not specialize in that animal's species */
SELECT COUNT(visits.animals_id) FROM visits JOIN animals 
ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
WHERE animals.species_id NOT IN (
    SELECT species_id FROM specializations 
    WHERE vets_id = vets.id
    );

/* What specialty should Maisy Smith consider getting? Look for the species she gets the most */
SELECT species.name, COUNT(animals.species_id) FROM visits
JOIN animals ON animals.id = visits.animals_id
JOIN species ON species.id = animals.species_id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(animals.species_id) DESC
LIMIT 1;