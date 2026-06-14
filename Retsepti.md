## Kogu kood tavauseris
```sql
CREATE DATABASE RetseptiRaamat;
USE RetseptiRaamat;
--TABELIT
CREATE TABLE kasutaja (
    kasutaja_id INT PRIMARY KEY IDENTITY(1,1),
    eesnimi VARCHAR(50),
    perenimi VARCHAR(50),
    email VARCHAR(150)
);
SELECT * FROM kasutaja;
CREATE TABLE kategooria (
    kategooria_id INT PRIMARY KEY IDENTITY(1,1),
    kategooria_nimi VARCHAR(50)
);
SELECT * FROM kategooria;
CREATE TABLE toiduaine (
    toiduaine_id INT PRIMARY KEY IDENTITY(1,1),
    toiduaine_nimi VARCHAR(100)
);
SELECT * FROM toiduaine;
CREATE TABLE yhik (
    yhik_id INT PRIMARY KEY IDENTITY(1,1),
    yhik_nimi VARCHAR(100)
);
SELECT * FROM yhik;
CREATE TABLE retsept (
    retsept_id INT PRIMARY KEY IDENTITY(1,1),
    retsepti_nimi VARCHAR(100),
    kirjeldus VARCHAR(200),
    juhend VARCHAR(500),
    sisestatud_kp DATE,
    kasutaja_id INT FOREIGN KEY REFERENCES kasutaja(kasutaja_id),
    kategooria_id INT FOREIGN KEY REFERENCES kategooria(kategooria_id)
);

SELECT * FROM retsept;
CREATE TABLE koostis (
    koostis_id INT PRIMARY KEY IDENTITY(1,1),
    kogus INT,
    retsept_retsept_id INT FOREIGN KEY REFERENCES retsept(retsept_id),
    toiduaine_id INT FOREIGN KEY REFERENCES toiduaine(toiduaine_id),
    yhik_id INT FOREIGN KEY REFERENCES yhik(yhik_id)
);

SELECT * FROM koostis;
CREATE TABLE tehtud (
    tehtud_id INT PRIMARY KEY IDENTITY(1,1),
    tehtud_kp DATE,
    retsept_id INT FOREIGN KEY REFERENCES retsept(retsept_id)
);

SELECT * FROM tehtud;
-- 5 protseduuri
--Uue ühiku lisamine 
CREATE PROCEDURE lisaUusYhik
@yhik_nimi VARCHAR(100)
AS
BEGIN
	INSERT INTO yhik (yhik_nimi) VALUES (@yhik_nimi);
	SELECT * FROM yhik;
END;

--Uue kategooria lisamine
CREATE PROCEDURE lisaUusKategooria
@kat_nimi VARCHAR(50)
AS
BEGIN
	INSERT INTO kategooria (kategooria_nimi) VALUES (@kat_nimi);
	SELECT * FROM kategooria;
END;

--Tehtud toidu märke lisamine
CREATE PROCEDURE lisaUusTehtudToit
@kuupaev DATE,
@retsept_id INT
AS
BEGIN
	INSERT INTO tehtud (tehtud_kp, retsept_id) VALUES (@kuupaev, @retsept_id);
	SELECT * FROM tehtud;
END;

--Tehtud ajaloo kustutamine ID järgi
CREATE PROCEDURE kustutaTehtudAjalugu
@tehtud_id INT
AS
BEGIN
	DELETE FROM tehtud WHERE tehtud_id = @tehtud_id;
	SELECT * FROM tehtud;
END;

--Toiduaine kustutamine ID järgi
CREATE PROCEDURE kustutaToiduainePohitabelist
@toiduaine_id INT
AS
BEGIN
	DELETE FROM toiduaine WHERE toiduaine_id = @toiduaine_id;
	SELECT * FROM toiduaine;
END;



-- ANDME SISESTAMINE


INSERT INTO kasutaja VALUES ('Ivan', 'Ivanov', 'ivan@gmail.com'), ('Mari', 'Maasikas', 'mari@gmail.com'), ('John', 'Doe', 'john@gmail.com'), ('Anna', 'Tamm', 'anna@gmail.com'), ('Juri', 'Kukk', 'juri@gmail.com');
INSERT INTO toiduaine VALUES ('Kartul'), ('Piim'), ('Suhkur'), ('Kanaliha'), ('Porgand');

-- Testime uusi protseduure
EXEC lisaUusYhik 'gr';
EXEC lisaUusYhik 'kg';
EXEC lisaUusYhik 'ml';
EXEC lisaUusYhik 'l';
EXEC lisaUusYhik 'tk';

EXEC lisaUusKategooria 'Supid';
EXEC lisaUusKategooria 'Magustoidud';
EXEC lisaUusKategooria 'Praed';
EXEC lisaUusKategooria 'Salatid';
EXEC lisaUusKategooria 'Joogid';

--Täidame retseptid ja koostise
INSERT INTO retsept VALUES 
('Kanasupp', 'Maitsev supp', 'Keeda pikalt', '2026-01-10', 1, 1),
('Pannkoogid', 'Magus hommikusöök', 'Prae pannil', '2026-02-15', 2, 2),
('Kartulisalat', 'Klassikaline salat', 'Haki ja sega', '2026-03-20', 3, 4),
('Ahjukana', 'Pühapäeva praed', 'Küpseta ahjus', '2026-04-05', 4, 3),
('Mahl', 'Värskendav jook', 'Vala klaasi', '2026-05-12', 5, 5);

INSERT INTO koostis VALUES (500, 1, 4, 1), (300, 1, 1, 2), (200, 2, 3, 1), (500, 2, 2, 4), (400, 3, 1, 2);

--Testime protseduuri 3
EXEC lisaUusTehtudToit '2026-06-01', 1;
EXEC lisaUusTehtudToit '2026-06-02', 2;
EXEC lisaUusTehtudToit '2026-06-03', 3;
EXEC lisaUusTehtudToit '2026-06-04', 4;
EXEC lisaUusTehtudToit '2026-06-05', 5;

CREATE PROCEDURE muudaTabel
@tegevus VARCHAR(10),
@tabelinimi VARCHAR(50),
@veerunimi VARCHAR(50),
@tyyp VARCHAR(50)=NULL
AS
BEGIN
    DECLARE @sqltegevus VARCHAR(MAX)

    SET @sqltegevus = CASE
        WHEN @tegevus='add' THEN
            CONCAT ('ALTER TABLE ', @tabelinimi, ' ADD ', @veerunimi, ' ', @tyyp)

        WHEN @tegevus='drop' THEN
            CONCAT('ALTER TABLE ', @tabelinimi, ' DROP COLUMN ', @veerunimi)

        WHEN @tegevus='alter' THEN
            CONCAT('ALTER TABLE ', @tabelinimi, ' ALTER COLUMN ', @veerunimi, ' ', @tyyp)

        END;

    PRINT @sqltegevus;
    EXEC(@sqltegevus);

END;

EXEC muudaTabel 'add','kasutaja','telefon','varchar(20)';
EXEC muudaTabel 'alter','kasutaja','telefon','varchar(50)';
EXEC muudaTabel 'drop','kasutaja','telefon';

SELECT * FROM kasutaja;

--SELECT-päringud
-- Päring Kuvab kasutaja eesnime, perekonnanime ja tema retseptide nimetused.
SELECT kasutaja.eesnimi, kasutaja.perenimi, retsept.retsepti_nimi 
FROM kasutaja, retsept
WHERE kasutaja.kasutaja_id = retsept.kasutaja_id;

-- Päring Kuvab retsepti nimetuse ja sellele vastava kategooria.
SELECT retsept.retsepti_nimi, kategooria.kategooria_nimi 
FROM retsept, kategooria
WHERE retsept.kategooria_id = kategooria.kategooria_id;

-- Päring Kuvab koostises kasutatud toiduained ja nende kogused.
SELECT toiduaine.toiduaine_nimi, koostis.kogus 
FROM toiduaine, koostis
WHERE toiduaine.toiduaine_id = koostis.toiduaine_id;



--LISATÖÖ

--Uus tabel
CREATE TABLE retsepti_pariolu (
    pariolu_id INT IDENTITY(1,1) PRIMARY KEY,
    riik VARCHAR(100), 
    retsept_id INT FOREIGN KEY REFERENCES retsept(retsept_id)
);

--Protseduur päritolu lisamiseks
CREATE PROCEDURE lisaPariolu
@riigi_nimi VARCHAR(100),
@retsept INT
AS
BEGIN
	INSERT INTO retsepti_pariolu (riik, retsept_id) VALUES (@riigi_nimi, @retsept);
	SELECT * FROM retsepti_pariolu;
END;

--Protseduur päritolu kustutamiseks
CREATE PROCEDURE kustutaPariolu
@id INT
AS
BEGIN
	DELETE FROM retsepti_pariolu WHERE pariolu_id = @id;
	SELECT * FROM retsepti_pariolu;
END;

-- Lisame testandmed uue protseduuriga
EXEC lisaPariolu 'Venemaa', 1;
EXEC lisaPariolu 'Prantsusmaa', 2;
EXEC lisaPariolu 'Eesti', 3;
EXEC lisaPariolu 'Ameerika', 4;
EXEC lisaPariolu 'Itaalia', 5;


-- User "staff" parooliga = '12345';
-- User manager parooliga = '12345';

-- KASUTAJA STAFF ÕIGUSED
GRANT SELECT ON kasutaja TO staff;
GRANT SELECT ON toiduaine TO staff;
GRANT SELECT ON kategooria TO staff;
GRANT INSERT ON toiduaine TO staff;
GRANT INSERT ON kategooria TO staff;
DENY UPDATE, DELETE ON toiduaine TO staff;
DENY UPDATE, DELETE ON kategooria TO staff;
DENY INSERT, UPDATE, DELETE ON kasutaja TO staff;

-- KASUTAJA MANAGER ÕIGUSED
GRANT SELECT ON kasutaja TO manager;
GRANT SELECT ON toiduaine TO manager;
GRANT SELECT ON kategooria TO manager;
GRANT SELECT ON yhik TO manager;
GRANT SELECT ON tehtud TO manager;
GRANT SELECT ON retsepti_pariolu TO manager;

DENY INSERT ON kasutaja TO manager;
DENY INSERT ON toiduaine TO manager;

GRANT SELECT, INSERT, UPDATE, DELETE ON retsept TO manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON koostis TO manager;

```
## Kood staff useris
```sql
--Tohib teha

SELECT *FROM kasutaja;
INSERT INTO toiduaine (toiduaine_nimi) VALUES ('Apelsin');
SELECT *FROM toiduaine;

--Ei hohi teha

UPDATE toiduaine
SET toiduaine_nimi = 'Test'
WHERE toiduaine_id =1;

INSERT INTO kasutaja (eesnimi,perenimi,email) 
VALUES ('Testnimi','testperenimi','test@gmail.com');
```
## Kogu kood manager useris
```sql
SELECT *FROM  retsept;

UPDATE retsept
SET kirjeldus = 'Uuendatud kirjeldus manageri poolt'
WHERE retsepti_nimi = 'Test-manager';

SELECT *FROM  retsept;

--Ei tohi teha

INSERT INTO kasutaja (eesnimi, perenimi, email)
VALUES ('Manager', 'User', 'manager_test@mail.ee');

INSERT INTO toiduaine (toiduaine_nimi)
VALUES ('Mango');
```
