INSERT INTO public.animals(
	id, name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES (1, 'agumon', '03-02-2020', 0, TRUE, 10.23);

INSERT INTO public.animals(
	id, name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES (2, 'Gabumon', '15-11-2018', 2, TRUE, 8);

INSERT INTO public.animals(
	id, name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES (3, 'Pikachu', '07-01-2021', 1, FALSE, 15.04);

INSERT INTO public.animals(
	id, name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES (4, 'Devimon', '12-05-2017', 5, TRUE, 11);

/* New data */
INSERT INTO public.animals(
	id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
	VALUES (5, 'Charmander', '08-02-2020', 0, FALSE, 11, '');

INSERT INTO public.animals(
	id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
	VALUES (6, 'Plantmon', '15-11-2021', 2, TRUE, 5.7, '');

INSERT INTO public.animals(
	id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
	VALUES (7, 'Squirtle', '02-04-1993', 3, FALSE, 12.13, '');

INSERT INTO public.animals(
	id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
	VALUES (8, 'Angemon', '12-06-2005', 1,TRUE, 45, '');

INSERT INTO public.animals(
	id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
	VALUES (9, 'Boarmon', '07-06-2005', 7,TRUE, 20.4, '');

INSERT INTO public.animals(
	id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
	VALUES (10, 'Blossom', '13-10-1998', 3,TRUE, 17, '');

INSERT INTO public.animals(
	id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
	VALUES (11, 'Ditto', '14-05-2022', 4,TRUE, 22, '');

/* data from owners table */
INSERT INTO public.owners(
	full_name, age)
	VALUES ('Sam Smith', 34);

INSERT INTO public.owners(
	full_name, age)
	VALUES ('Jennifer Orwell', 19);

INSERT INTO public.owners(
	full_name, age)
	VALUES ('Bob', 45);

INSERT INTO public.owners(
	full_name, age)
	VALUES ('Melody Pond', 77);

INSERT INTO public.owners(
	full_name, age)
	VALUES ('Dean Winchester', 14);

INSERT INTO public.owners(
	full_name, age)
	VALUES ('Jodie Whittaker', 38);

/* data from species table*/
INSERT INTO public.species(
	name)
	VALUES ('Pokemon');

INSERT INTO public.species(
	name)
	VALUES ('Digimon');

/* modifying animals so includes species id */
BEGIN TRANSACTION;

UPDATE animals
    SET species_id = (SELECT species.id FROM species WHERE species.name = 'Pokemon')  
	WHERE name NOT LIKE '%mon';

COMMIT;

BEGIN TRANSACTION;

UPDATE animals
    SET species_id = (SELECT species.id FROM species WHERE species.name = 'Digimon')
	WHERE name LIKE '%mon';

COMMIT;

/* modifying animals to include owner informatio */
/* Sam Smith owns Agumon */
BEGIN TRANSACTION;

UPDATE animals
    SET owner_id = (SELECT owners.id FROM owners WHERE owners.full_name = 'Sam Smith')
    WHERE name = 'agumon';

COMMIT;

/* Jennifer Orwell owns Gabumon and Pikachu */
BEGIN TRANSACTION;

UPDATE animals
    SET owner_id = (SELECT owners.id FROM owners WHERE owners.full_name = 'Jennifer Orwell')
    WHERE name = 'Gabumon' OR name = 'Pikachu';

COMMIT;

/* Bob owns Devimon and Plantmon */
BEGIN TRANSACTION;

UPDATE animals
    SET owner_id = (SELECT owners.id FROM owners WHERE owners.full_name = 'Bob')
    WHERE name IN ('Devimon', 'Plantmon');

COMMIT;

/* Melody Pond owns Charmander, Squirtle, and Blossom */
BEGIN TRANSACTION;

UPDATE animals
    SET owner_id = (SELECT owners.id FROM owners WHERE owners.full_name = 'Melody Pond')
    WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

COMMIT;

/* Dean Winchester owns Angemon and Boarmon */
BEGIN TRANSACTION;

UPDATE animals
    SET owner_id = (SELECT owners.id FROM owners WHERE owners.full_name = 'Dean Winchester')
    WHERE name IN ('Angemon', 'Boarmon');

COMMIT;
