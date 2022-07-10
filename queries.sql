/*queries that provide answers to the questions from all projects.*/

select * from animals where name like '%mon%';
select * from animals where date_of_birth between '2016-01-01' and '2019-12-31';
select * from animals where neutered = true and escape_attempts < 3;
select date_of_birth from animals where name = 'agumon' or name = 'pikachu';
select name, escape_attempts from animals where weight_kg > 10.5;
select * from animals where neutered = true;
select * from animals where name != 'gabumon';
select * from animals where weight_kg >= 10.4 and weight_kg <= 17.3;

select count(*) from animals;
select count(*) from animals where escape_attempts = 0;
select avg(weight_kg) as average_animal_weight from animals;
select neutered, avg(escape_attempts) average_escape_attempts from animals group by neutered;
select species, min(weight_kg) as minimum_weight, max(weight_kg) as maximum_weight from animals group by species;
select species, avg(escape_attempts) as average_escape_attempts from animals where date_of_birth between '1990-01-01' and '2000-12-31' group by species;

select name from animals join owners on animals.owner_id = owners.id where owners.full_name = 'melody pond';
select animals.name from animals join species on animals.species_id = species.id where species.name = 'pokemon';
select owners.full_name, animals.name from animals right join owners on animals.owner_id = owners.id;
select species.name, count(*) from animals join species on animals.species_id = species.id group by species.id;
select animals.name, species.name, owners.full_name from animals join species on animals.species_id = species.id join owners on animals.owner_id = owners.id where owners.full_name = 'jennifer orwell' and species.name = 'digimon';
select animals.name, owners.full_name, animals.escape_attempts from animals join owners on animals.owner_id = owners.id where owners.full_name = 'dean winchester' and animals.escape_attempts = 0;
select owners.full_name, count(animals.name) from animals right join owners on animals.owner_id = owners.id group by owners.full_name;

select animals.name, vets.name, visits.visit_date from animals join visits on (animals.id = visits.animals_id) join vets on (vets.id = visits.vets_id) where vets.name = 'william tatcher' and visits .visit_date = (select max(visits.visit_date) from visits join vets on (vets.id = visits.vets_id) group by vets.name having vets.name = 'william tatcher'); 
select count(animals.name) from animals join visits on (animals.id = visits.animals_id) join vets on (vets.id = visits.vets_id) where vets.name = 'stephanie mendez';
select vets.name, species.name from vets left join specializations on vets.id = specializations.vets_id left join species on species.id = specializations.species_id;  
select animals.name, vets.name, visits.visit_date from animals join visits on visits.animals_id = animals.id join vets on vets.id = visits.vets_id where vets.name = 'stephanie mendez' and visits.visit_date between '2020-04-01' and '2020-08-30';
select animals.name, count(animals.name) from animals join visits on animals.id = visits.animals_id group by animals.name having count (animals_id) = (select max(mycount) from (select count(animals_id) mycount from visits group by animals_id) as animals_count);
select animals.name, vets.name, visits.visit_date from animals join visits on (animals.id = visits.animals_id) join vets on (vets.id = visits.vets_id) where vets.name = 'maisy smith' and visits.visit_date = (select min(visits.visit_date) from visits join vets on (vets.id = visits.vets_id) group by vets.name having vets.name = 'maisy smith');
select animals.name, vets.name, visits.visit_date from animals join visits on (animals.id = visits.animals_id) join vets on (vets.id = visits.vets_id) where visits.visit_date = (select max(visits.visit_date) from visits);
select count(visits.visit_date) from vets join visits on visits.vets_id = vets.id join animals on animals.id = visits.animals_id join specializations on vets.id = specializations.vets_id join species on specializations.species_id = species.id where animals.species_id <> specializations.species_id;
select species.name, count(species.name) as visits
from animals join visits on visits.animals_id = animals.id join vets on visits.vets_id = vets.id join species on species.id = animals.species_id where vets.name = 'maisy smith' group by species.name order by visits desc limit 1;
