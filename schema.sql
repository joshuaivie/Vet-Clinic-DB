/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id SERIAL,
    name text,
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal,
    PRIMARY KEY(id)
);

alter table animals add species text;

create table owners (
    id integer generated always as identity,
    full_name text,
    age integer,
    primary key(id)
);

create table species (
    id integer generated always as identity,
    name text,
    primary key(id)
);

alter table animals drop column species;
alter table animals add column species_id integer;
alter table animals add constraint FK_SPECIES foreign key (species_id) references species (id) on delete set null;

alter table animals add column owner_id integer;
alter table animals add constraint FK_OWNER foreign key (owner_id) references owners (id) on delete set null;
