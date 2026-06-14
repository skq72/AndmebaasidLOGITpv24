```sql
-- ========================================================
-- 1. LOO ANDMEBAAS JA TABELID (Создание БД и таблиц)
-- ========================================================
CREATE DATABASE RetseptiRaamat;
GO

USE RetseptiRaamat;
GO

CREATE TABLE kasutaja (
    kasutaja_id INT PRIMARY KEY IDENTITY(1,1),
    eesnimi VARCHAR(50),
    perenimi VARCHAR(50),
    email VARCHAR(150)
);

CREATE TABLE kategooria (
    kategooria_id INT PRIMARY KEY IDENTITY(1,1),
    kategooria_nimi VARCHAR(50)
);

CREATE TABLE toiduaine (
    toiduaine_id INT PRIMARY KEY IDENTITY(1,1),
    toiduaine_nimi VARCHAR(100)
);

CREATE TABLE yhik (
    yhik_id INT PRIMARY KEY IDENTITY(1,1),
    yhik_nimi VARCHAR(100)
);

CREATE TABLE retsept (
    retsept_id INT PRIMARY KEY IDENTITY(1,1),
    retsepti_nimi VARCHAR(100),
    kirjeldus VARCHAR(200),
    juhend VARCHAR(500),
    sisestatud_kp DATE,
    kasutaja_id INT FOREIGN KEY REFERENCES kasutaja(kasutaja_id),
    kategooria_id INT FOREIGN KEY REFERENCES kategooria(kategooria_id)
);

CREATE TABLE koostis (
    koostis_id INT PRIMARY KEY IDENTITY(1,1),
    kogus INT,
    retsept_retsept_id INT FOREIGN KEY REFERENCES retsept(retsept_id),
    toiduaine_id INT FOREIGN KEY REFERENCES toiduaine(toiduaine_id),
    yhik_id INT FOREIGN KEY REFERENCES yhik(yhik_id)
);

CREATE TABLE tehtud (
    tehtud_id INT PRIMARY KEY IDENTITY(1,1),
    tehtud_kp DATE,
    retsept_id INT FOREIGN KEY REFERENCES retsept(retsept_id)
);
GO

-- ========================================================
-- 2. 5 UUT LIHTSAT PROTSEDUURI (5 новых простых процедур)
-- ========================================================

-- Protseduur 1: Uue ühiku lisamine (Добавление единицы измерения)
CREATE PROCEDURE lisaUusYhik
@yhik_nimi VARCHAR(100)
AS
BEGIN
	INSERT INTO yhik (yhik_nimi) VALUES (@yhik_nimi);
	SELECT * FROM yhik;
END;
GO

-- Protseduur 2: Uue kategooria lisamine (Добавление категории)
CREATE PROCEDURE lisaUusKategooria
@kat_nimi VARCHAR(50)
AS
BEGIN
	INSERT INTO kategooria (kategooria_nimi) VALUES (@kat_nimi);
	SELECT * FROM kategooria;
END;
GO

-- Protseduur 3: Tehtud toidu märke lisamine (Добавление отметки о приготовлении)
CREATE PROCEDURE lisaUusTehtudToit
@kuupaev DATE,
@retsept_id INT
AS
BEGIN
	INSERT INTO tehtud (tehtud_kp, retsept_id) VALUES (@kuupaev, @retsept_id);
	SELECT * FROM tehtud;
END;
GO

-- Protseduur 4: Tehtud ajaloo kustutamine ID järgi (Удаление из истории приготовлений)
CREATE PROCEDURE kustutaTehtudAjalugu
@tehtud_id INT
AS
BEGIN
	DELETE FROM tehtud WHERE tehtud_id = @tehtud_id;
	SELECT * FROM tehtud;
END;
GO

-- Protseduur 5: Toiduaine kustutamine ID järgi (Удаление ингредиента из справочника)
CREATE PROCEDURE kustutaToiduainePohitabelist
@toiduaine_id INT
AS
BEGIN
	DELETE FROM toiduaine WHERE toiduaine_id = @toiduaine_id;
	SELECT * FROM toiduaine;
END;
GO

-- ========================================================
-- 3. ANDMETE SISESTAMINE (Заполнение данными - минимум 5 строк)
-- ========================================================

-- Täidame algandmed käsitsi, et protseduurid jääksid puhtaks
INSERT INTO kasutaja VALUES ('Ivan', 'Ivanov', 'ivan@mail.ee'), ('Mari', 'Maasikas', 'mari@mail.ee'), ('John', 'Doe', 'john@mail.ee'), ('Anna', 'Tamm', 'anna@mail.ee'), ('Juri', 'Kukk', 'juri@mail.ee');
INSERT INTO toiduaine VALUES ('Kartul'), ('Piim'), ('Suhkur'), ('Kanaliha'), ('Porgand');

-- Testime uusi protseduure 1 ja 2 andmete sisestamiseks
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

-- Täidame retseptid ja koostise
INSERT INTO retsept VALUES 
('Kanasupp', 'Maitsev supp', 'Keeda pikalt', '2026-01-10', 1, 1),
('Pannkoogid', 'Magus hommikusöök', 'Prae pannil', '2026-02-15', 2, 2),
('Kartulisalat', 'Klassikaline salat', 'Haki ja sega', '2026-03-20', 3, 4),
('Ahjukana', 'Pühapäeva praed', 'Küpseta ahjus', '2026-04-05', 4, 3),
('Mahl', 'Värskendav jook', 'Vala klaasi', '2026-05-12', 5, 5);

INSERT INTO koostis VALUES (500, 1, 4, 1), (300, 1, 1, 2), (200, 2, 3, 1), (500, 2, 2, 4), (400, 3, 1, 2);

-- Testime protseduuri 3 (ajaloo lisamine)
EXEC lisaUusTehtudToit '2026-06-01', 1;
EXEC lisaUusTehtudToit '2026-06-02', 2;
EXEC lisaUusTehtudToit '2026-06-03', 3;
EXEC lisaUusTehtudToit '2026-06-04', 4;
EXEC lisaUusTehtudToit '2026-06-05', 5;
GO

-- ========================================================
-- 4. PROTSEDUUR TABELI MUUTMISEKS (Динамический SQL)
-- ========================================================
CREATE PROCEDURE muudaTabel
	@tegevus VARCHAR(10),
	@tabelinimi VARCHAR(50),
	@veerunimi VARCHAR(50),
	@tyyp VARCHAR(50)=NULL
AS
BEGIN
	DECLARE @sqltegevus VARCHAR(MAX)

	SET @sqltegevus = CASE
		WHEN @tegevus='add' THEN CONCAT ('ALTER TABLE ', @tabelinimi, ' ADD ', @veerunimi, ' ', @tyyp)
		WHEN @tegevus='drop' THEN CONCAT('ALTER TABLE ', @tabelinimi, ' DROP COLUMN ', @veerunimi)
		WHEN @tegevus='alter' THEN CONCAT('ALTER TABLE ', @tabelinimi, ' ALTER COLUMN ', @veerunimi, ' ', @tyyp)
		END;

	PRINT @sqltegevus;
	EXEC(@sqltegevus);
END;
GO

-- ========================================================
-- 5. SELECT-PÄRINGUD (Выборки)
-- ========================================================

-- Päring 1: Kuvab kasutaja eesnime, perekonnanime ja tema retseptide nimetused.
SELECT kasutaja.eesnimi, kasutaja.perenimi, retsept.retsepti_nimi 
FROM kasutaja, retsept
WHERE kasutaja.kasutaja_id = retsept.kasutaja_id;

-- Päring 2: Kuvab retsepti nimetuse ja sellele vastava kategooria.
SELECT retsept.retsepti_nimi, kategooria.kategooria_nimi 
FROM retsept, kategooria
WHERE retsept.kategooria_id = kategooria.kategooria_id;

-- Päring 3: Kuvab koostises kasutatud toiduained ja nende kogused.
SELECT toiduaine.toiduaine_nimi, koostis.kogus 
FROM toiduaine, koostis
WHERE toiduaine.toiduaine_id = koostis.toiduaine_id;

-- ========================================================
-- 6. UUS LISATÖÖ: Retseptide päritolu (Новое уникальное задание)
-- ========================================================

-- 1. Uus tabel päritolu jaoks (Новая таблица стран происхождения)
CREATE TABLE retsepti_pariolu (
    pariolu_id INT IDENTITY(1,1) PRIMARY KEY,
    riik VARCHAR(100), 
    retsept_id INT FOREIGN KEY REFERENCES retsept(retsept_id)
);
GO

-- 2. Protseduur päritolu lisamiseks
CREATE PROCEDURE lisaPariolu
@riigi_nimi VARCHAR(100),
@retsept INT
AS
BEGIN
	INSERT INTO retsepti_pariolu (riik, retsept_id) VALUES (@riigi_nimi, @retsept);
	SELECT * FROM retsepti_pariolu;
END;
GO

-- 3. Protseduur päritolu kustutamiseks
CREATE PROCEDURE kustutaPariolu
@id INT
AS
BEGIN
	DELETE FROM retsepti_pariolu WHERE pariolu_id = @id;
	SELECT * FROM retsepti_pariolu;
END;
GO

-- Lisame testandmed uue protseduuriga
EXEC lisaPariolu 'Ukraina', 1;
EXEC lisaPariolu 'Prantsusmaa', 2;
EXEC lisaPariolu 'Eesti', 3;
EXEC lisaPariolu 'Ameerika', 4;
EXEC lisaPariolu 'Itaalia', 5;
GO

-- ========================================================
-- 7. KASUTAJATE ÕIGUSED (DCL - Права доступа)
-- ========================================================

-- NB! Logins ja Users luuakse tavaliselt serveri tasemel, veendu, et need on olemas või loo uued:
-- CREATE LOGIN staff WITH PASSWORD = '12345';
-- CREATE LOGIN manager WITH PASSWORD = '12345';
-- CREATE USER staff FOR LOGIN staff;
-- CREATE USER manager FOR LOGIN manager;

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
GRANT SELECT ON retsepti_pariolu TO manager; -- Õigused uuele lisatöö tabelile

DENY INSERT ON kasutaja TO manager;
DENY INSERT ON toiduaine TO manager;

GRANT SELECT, INSERT, UPDATE, DELETE ON retsept TO manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON koostis TO manager;
GO
```
