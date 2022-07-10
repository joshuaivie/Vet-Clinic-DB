/* Populate database with sample data. */
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES 
	(1, 'Agumon', '2020-02-03', 0, true, 10.23 ), 
	(2, 'Gabumon', '2018-11-15', 2, true, 8.00 ),
	(3, 'Pikachu', '2021-01-07', 1, false, 15.04 ),
	(4, 'Devimon', '2017-05-12', 5, true, 11.00 );

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
  (5, 'Charmander', '2020-02-08', 0, false, -11),
  (6, 'Plantmon', '2021-11-15',  2, true, -5.7),
  (7, 'Squirtle', '1993-04-02',  3, false, -12.13),
  (8, 'Angemon', '2005-06-12', 1, true, -45),
  (9, 'Boarmon', '2005-06-07', 7, true, 20.4),    
  (10, 'Blossom', '1998-10-13', 3, true, 17),
  (11, 'Ditto', '2022-05-14', 4, true, 22);

begin;
	update animals set species = 'unspecified';
	rollback;
end;
select * from animals;

begin;
	update animals set species = 'digimon' where name like '%mon';
	update animals set species = 'pokemon' where species is null;
	commit;
end;
select * from animals;


begin;
	delete from animals;
	rollback;
end;
select * from animals;

begin;
	delete from animals where date_of_birth > '2022-01-01';
	savepoint seperate_young_animals;
	update animals set weight_kg = weight_kg * -1;
	rollback to seperate_young_animals;
	update animals set weight_kg = weight_kg * -1 where weight_kg < 0;
	commit;
end;
select * from animals;

insert into owners (full_name, age) values 
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);
  
insert into species (name) values ('Pokemon'), ('Digimon');
 
update animals set species_id = (select id from species where name = 'Digimon' ) where name like '%mon%';
update animals set species_id = (select id from species where "name" = 'Pokemon') where species_id is null;

update animals set owner_id = (select id from owners where full_name = 'Sam Smith') where name = 'Agumon';
update animals set owner_id = (select id from owners where full_name = 'Jennifer Orwell') where name in ('Gabumon', 'Pikachu');
update animals set owner_id = (select id from owners where full_name = 'Bob') where name in ('Devimon', 'Plantmon');
update animals set owner_id = (select id from owners where full_name = 'Melody Pond') where name in ('Charmander', 'Squirtle', 'Blossom');
update animals set owner_id = (select id from owners where full_name = 'Dean Winchester') where name in ('Angemon', 'Boarmon');
