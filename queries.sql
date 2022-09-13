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