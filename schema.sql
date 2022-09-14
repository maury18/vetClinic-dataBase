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