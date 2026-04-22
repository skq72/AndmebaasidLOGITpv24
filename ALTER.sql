
--tabeli struktuuri muutmine
--1. uue veeru lisamine
ALTER TABLE tootaja ADD testVeerg int;
SELECT * FROM tootaja;
--2. veeru kustutamine
ALTER TABLE tootaja DROP COLUMN testVeerg;
SELECT * FROM tootaja;
--3. andmetüübi muutmine veerus
ALTER TABLE tootaja ALTER COLUMN testVeerg varchar(5);
--struktuuri kontrollimiseks kasutame protseduur sp_help
sp_help tootaja;

--piirangute lisamine
CREATE TABLE ryhm(
ryhmID int not null,
ryhmNimi char(10));
DROP TABLE ryhm;
--muudame tabeli ja lisame piirang -primary key 
ALTER TABLE ryhm ADD CONSTRAINT  pk_ryhm PRIMARY KEY (ryhmID);


INSERT INTO ryhm 
VALUES (3, 'LOGITpe24');
SELECT * FROM ryhm;

--lisame piirang UNIQUE
ALTER TABLE ryhm ADD CONSTRAINT  un_ryhm UNIQUE (ryhmNimi);

--lisame uus veerg
ALTER TABLE ryhm ADD ryhmajuhataja int;
--lisame piirang Foreign Key
ALTER TABLE ryhm ADD CONSTRAINT  fk_ryhm
FOREIGN KEY (ryhmajuhataja) REFERENCES tootaja(tootajaID);
--kontrollimiseks
SELECT * FROM tootaja;
SELECT * FROM ryhm;
UPDATE ryhm SET ryhmajuhataja=2 WHERE ryhmNimi='LOGITpe24'
