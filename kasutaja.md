# SQL Server – Kasutajate autentimine ja õiguste haldamine
## Mis on autentimine SQL Serveris?
 - Autentimine tähendab kasutaja tuvastamist ehk kontrollimist, kas kasutajal on õigus SQL Serverisse sisse logida.
## SQL Serveris kasutatakse kahte peamist autentimise tüüpi:
  1. Windows Authentication

Selle puhul kasutatakse samu kasutajaandmeid, millega logitakse sisse Windows operatsioonisüsteemi.
>Kasutajanimi ja parool on seotud Windowsiga. 
>Turvalisem lahendus. 
>Paroole haldab Windows. 
>Kasutaja ei pea eraldi SQL Serveri parooli teadma.
<img width="479" height="438" alt="изображение" src="https://github.com/user-attachments/assets/0fb48165-8d7c-425d-b068-fb842d4570ac" />

  2.  SQL Server Authentication

>Selle puhul luuakse kasutaja otse SQL Serverisse.
>Kasutaja ei ole seotud Windowsiga. 
>Määratakse eraldi kasutajanimi ja parool. 
>Sobib veebirakenduste jaoks.

<img width="324" height="264" alt="изображение" src="https://github.com/user-attachments/assets/c8cc9a3d-23f4-42a1-a359-9bf847d4c8e8" />

# Näide kasutajast: DirectorKirill. Parool: director
## Kasutaja loomine SQL Serveris
  1. Serveritaseme kasutaja loomine (Login) Sammud Ava:
Security → Logins Tee paremklikk ja vali:
New Login:

<img width="549" height="655" alt="изображение" src="https://github.com/user-attachments/assets/f7c0baed-d255-4875-9b21-f66a7c8b6083" />

Harjutamiseks võib eemaldada linnukese: User must change password at next login.

**Server Roles**
Menüüst Server Roles saab määrata serveri üldised õigused.

Tavaliselt piisab rollist: public

<img width="547" height="648" alt="изображение" src="https://github.com/user-attachments/assets/28cc147f-fceb-4671-933f-538f62f2005c" />

  2. Andmebaasi kasutaja loomine (User)
Ava:

Database → Security → Users
Tee paremklikk:  New User...

Seosta kasutaja loginiga

<img width="298" height="236" alt="изображение" src="https://github.com/user-attachments/assets/613c13b2-5b7d-4042-bce1-10e32642c5d0" />

**Membership ja õigused**
Menüüst Membership saab määrata kasutaja rollid.

>db_datareader → võib lugeda SELECT

>db_datawriter → võib kirjutada INSERT, UPDATE, DELETE

<img width="721" height="451" alt="изображение" src="https://github.com/user-attachments/assets/d5880d58-403e-4e74-b928-f1462600ef1e" />

## Kasutaja õiguste kontroll

  1. Tuleb sisselogida kasutajana directorIrina. Connect--> Database Engine
<img width="483" height="609" alt="изображение" src="https://github.com/user-attachments/assets/20959f8e-c894-4d82-96ac-f48d4ba4a60f" />

  2. Saab tabeli sisu näha ja sisestada uus kiri.
<img width="804" height="415" alt="изображение" src="https://github.com/user-attachments/assets/74b3f8b4-e1f2-477a-b157-4f3a0b5fbd97" />

  3. Kontrollime tegevus, mis ei ole lubatud kasutajale, näiteks tabeli loomine.
<img width="724" height="338" alt="изображение" src="https://github.com/user-attachments/assets/f8f59327-4333-46d5-9479-f7d9841dd803" />

``` sql
#### SQL Server Authentication Mode muutmine
Kui ilmub viga: Error 18456, siis on tavaliselt lubatud ainult Windows Authentication.
Lahendus: Server → Properties -->
Security
 Vali: SQL Server and Windows Authentication mode
```
``` sql
--GRANT - õiguste määramine
--DENY - õiguste keelamine

--db_datareader -SELECT 
--db_datawriter - INSERT, DELETE, UPDATE

--anname kasutajale directorIrina õigus 
--ainult kustutada ja uuendada tabelit 
--(DELETE, UPDATE, SELECT)

GRANT DELETE ON puhkus TO directorKirill;
GRANT UPDATE ON puhkus TO directorKirill;
GRANT SELECT ON puhkus TO directorKirill;

--keelame INSERT
DENY INSERT ON puhkus TO directorKirill;
```

<img width="689" height="630" alt="изображение" src="https://github.com/user-attachments/assets/9f731be3-b747-4efa-96af-850048a41964" />

SELECT Lugemine INSERT Lisamine UPDATE Muutmine DELETE Kustutamine

<img width="838" height="415" alt="изображение" src="https://github.com/user-attachments/assets/708b8a2f-ba1c-4bf0-829b-414575caca9b" />


## ÜL1
Loon SQL Serveris uus andmebaas nimega MovieBase ja lisan sinna kaks tabelit nimega 'movies' ja 'guest'.

<img width="429" height="388" alt="изображение" src="https://github.com/user-attachments/assets/afca88f3-4884-40c1-8045-ef18fb3c226f" />

Lisan kahe tabelisse 7 kirjet.

<img width="787" height="559" alt="изображение" src="https://github.com/user-attachments/assets/dd6a1c8b-201a-4d65-b2b5-fd3780dcfce8" />

Loon uus kasutaja nimega Produtsent parooliga director

<img width="721" height="652" alt="изображение" src="https://github.com/user-attachments/assets/0e02d7f9-93cb-4415-ac38-873dfb29e37c" />

Seotan kasutaja Produtsent andmebaasiga MovieBase

<img width="725" height="654" alt="изображение" src="https://github.com/user-attachments/assets/6a64fe6e-bb8f-4e0e-86b4-91eafc884e72" />

Määran kasutajale rollid db-datareader ja db-datawriter, et kasutaja saaks andmeid lugeda ja muuta

<img width="717" height="655" alt="изображение" src="https://github.com/user-attachments/assets/5ffa229b-5155-471b-a3eb-ece7b9565489" />

Andsin kasutajatele  Produtsent järgmised õigused:

<img width="626" height="388" alt="изображение" src="https://github.com/user-attachments/assets/b5e9fbd2-f92b-4572-945b-586168690d1e" />

<img width="491" height="206" alt="изображение" src="https://github.com/user-attachments/assets/7ceaafb5-a435-4b85-800b-4b8f442ee421" />
<img width="512" height="214" alt="изображение" src="https://github.com/user-attachments/assets/7cddde46-9329-4d69-ac33-3135f9a5e289" />

## Kontrollimine
Logisin sisse kasutajaga Produtsent

<img width="480" height="466" alt="изображение" src="https://github.com/user-attachments/assets/4053c701-6c47-4ff3-99f2-44ce404f004d" />

Kontrollin et kasutaja saab vaadata tabeli movies väljud movieDir ja MovieCost

<img width="434" height="491" alt="изображение" src="https://github.com/user-attachments/assets/c953231b-b899-4cf1-b6c2-520ea66cc70d" />

Kontrollin et kasutaja saab muuta anmded

<img width="508" height="421" alt="изображение" src="https://github.com/user-attachments/assets/00363142-65ef-4e05-a01c-f9cc09525906" />

Kontrollin et kasutaja saab lisada uue filmi tabelisse movies

<img width="786" height="341" alt="изображение" src="https://github.com/user-attachments/assets/84a1b464-b754-4b0f-a064-a72de0b06c01" />

Kasutaja Produtsent saab vaadata ja lisada kirjeid tabelisse guest

<img width="473" height="352" alt="изображение" src="https://github.com/user-attachments/assets/a83b224f-7875-4893-be47-6a3cbca37483" />

Kasutajal puudub õigus kustutada andeid tabelist  mocies ja guest

<img width="812" height="304" alt="изображение" src="https://github.com/user-attachments/assets/4964229c-66f8-4e0d-bb70-7e5c0c42631a" />
<img width="832" height="298" alt="изображение" src="https://github.com/user-attachments/assets/b0261a61-7883-47c2-8773-a991d44a73c1" />


Kogu kood kasutajal Produtsent:
```sql
USE MovieBase;

SELECT movieDir, movieCost FROM movies;

UPDATE movies SET movieCost=140000000 WHERE ID=1;

SELECT * FROM movies


INSERT INTO movies(movieNimi,movieYear,MovieDir) VALUES ('Nowhere',2023,'Albert Pinto')
SELECT * FROM movies;
SELECT * FROM guest;

INSERT INTO guest VALUES ('Test');

SELECT * FROM guest

DELETE FROM guest WHERE id=1;

DELETE FROM movies WHERE ID=3;
```
Kogu kood tavakasutajal:
```sql
CREATE DATABASE MovieBase;
USE MovieBase;

CREATE TABLE movies(
	ID int identity(1,1) PRIMARY KEY,
	movieNimi varchar(70),
	movieYear int,
	movieDir varchar(70),
	movieCost int
);


CREATE TABLE guest (
	id int identity(1,1) PRIMARY KEY,
	name varchar(70)
);


INSERT INTO movies VALUES ('Menüü', 2022, 'Mark Mailod' , 30000000),
('Platvorm', 2019, 'Galder Gastelu-Urrutia', 1800000),
('Iron MAN', 2008, 'Džon Favro', 140000000),
('2012',2009,'Rolland Emmerikh', 200000000),
('Maailmade sõda', 2005, 'Stiven Spillberg', 132000000),
('1+1', 2011,'Oliver Nakache', 1150000),
('Tõmme', 2017,'Fedor Bondarchuk', 6500000);

INSERT INTO guest VALUES ('Artjom'),('Inna'),('Nikita'),('Robert'),('Ivan'),('Kristina'),('Aleksandr');

SELECT *FROM movies;
SELECT *FROM guest;

--Õigus vaadata ja uuendada tabeli movies välju MovieDir ja MovieCost
GRANT UPDATE (movieDir,movieCost) ON movies TO Produtsent;
GRANT SELECT (movieDir,movieCost) ON movies TO Produtsent;
--Enda valitud privileeg -õigus lisada uusi filme tabelisse movies
GRANT INSERT ON movies TO Produtsent;
--Õigus vaadata ja lisada kirjeid tabelisse guest
GRANT SELECT,INSERT ON guest TO Produtsent;
--Keela andmete kustutamine tabelis movies
DENY DELETE ON movies TO Produtsent;
--Keela andmete kustutamine tabelis guest
DENY DELETE ON guest TO Produtsent;
```

