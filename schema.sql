CREATE TABLE public.animals
(
    id integer,
    name text,
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg numeric,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.animals
    OWNER to postgres;

// New Column
ALTER TABLE IF EXISTS public.animals
    ADD COLUMN species text;

/* new table owners*/
CREATE TABLE public.owners
(
    id bigserial,
    full_name text,
    age integer,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.owners
    OWNER to postgres;

/* new table species */
CREATE TABLE public.species
(
    id bigserial,
    name text,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.species
    OWNER to postgres;

/* modify animals table */
ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INT
	REFERENCES species(id);

ALTER TABLE animals ADD COLUMN owner_id INT
	REFERENCES owners(id);

/* vets table */
CREATE TABLE public.vets
(
    id bigserial,
    name text,
    age integer,
    date_of_graduation date,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.vets
    OWNER to postgres;

/* specializations table */
CREATE TABLE specializations (
    vets_id integer,
    species_id integer
);

ALTER TABLE specializations ADD FOREIGN KEY (species_id) REFERENCES species (id);
ALTER TABLE specializations ADD FOREIGN KEY (vet_id) REFERENCES vets (id);

/* visits table */
CREATE TABLE visits(
    id SERIAL NOT NULL,
    vets_id INT,
	animals_id INT,
    date_of_visit DATE,
	PRIMARY KEY(id)
);

ALTER TABLE visits
ADD FOREIGN KEY(vets_id) REFERENCES vets(id);

ALTER TABLE visits
ADD FOREIGN KEY(animals_id) REFERENCES animals(id);