/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id                  INT GENERATED ALWAYS AS IDENTITY,
    name                VARCHAR(250),
    date_of_birth       DATE,
    escape_attempts     SMALLINT,
    neutered            BOOLEAN,
    weight_kg           DECIMAL,
    PRIMARY KEY(id)
);

ALTER TABLE animals
    ADD COLUMN species VARCHAR(250);

CREATE TABLE owners (
    id                  INT GENERATED ALWAYS AS IDENTITY,
    full_name           VARCHAR(250),
    age     SMALLINT,
    PRIMARY KEY(id)
);

CREATE TABLE species (
    id                  INT GENERATED ALWAYS AS IDENTITY,
    name                VARCHAR(250),
    PRIMARY KEY(id)
);

ALTER TABLE animals
    DROP COLUMN species,
    ADD COLUMN species_id INTEGER,
    ADD COLUMN owners_id INTEGER,
    ADD CONSTRAINT fk_species FOREIGN KEY (species_id)
        REFERENCES species(id),
    ADD CONSTRAINT fk_owners FOREIGN KEY (owners_id)
        REFERENCES owners(id);