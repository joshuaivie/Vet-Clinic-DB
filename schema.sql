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


create table vets (
    id integer generated always as identity,
    name text,
    age integer,
    data_of_graduation date,
    primary key (id)
);

create table specializations (
    species_id integer not null,
    vets_id integer not null,
    constraint "FK_SPECIES" foreign key (species_id) references species (id) on delete set null,
    constraint "FK_VETS" foreign key (vets_id) references vets (id) on delete set null,
    primary key (species_id, vets_id)
);

create table visits (
    animals_id integer not null,
    vets_id integer not null,
    visit_date date not null,
    constraint "FK_ANIMALS" foreign key (animals_id) references animals (id) on delete set null,
    constraint "FK_VETS" foreign key (vets_id) references vets (id) on delete set null,
    primary key (animals_id, vets_id, visit_date)
);

alter table owners add COLUMN email varchar(120);

create index visits_animals ON visits(animal_id);

create index visits_vet_ids ON visits(vet_id);

create index owners_emails ON owners(email);