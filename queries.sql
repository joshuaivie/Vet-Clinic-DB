/*Queries that provide answers to the questions from all projects.*/

select * from animals where name like '%mon%';
select * from animals where date_of_birth between '2016-01-01' and '2019-12-31';
select * from animals where neutered = true and escape_attempts < 3;
select date_of_birth from animals where name = 'Agumon' or name = 'Pikachu';
select name, escape_attempts from animals where weight_kg > 10.5;
select * from animals where neutered = true;
select * from animals where name != 'Gabumon';
select * from animals where weight_kg >= 10.4 and weight_kg <= 17.3;

select count(*) from animals;
select count(*) from animals where escape_attempts = 0;
select avg(weight_kg) as average_animal_weight from animals;
select neutered, avg(escape_attempts) average_escape_attempts from animals group by neutered;
select species, min(weight_kg) as minimum_weight, max(weight_kg) as maximum_weight from animals group by species;
select species, avg(escape_attempts) as average_escape_attempts from animals where date_of_birth between '1990-01-01' and '2000-12-31' group by species; 