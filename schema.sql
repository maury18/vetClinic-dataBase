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