# SQL Protseduurid

[Põhimõisted](README.md) | [Trigerid](triger.md) | [Trigerid XAMPP-is](trigerXAMPP.md) | [Keys](keys.md) | [Protseduurid](protseduurid.md) | [Kasutajad ja ül1](kasutaja.md) | 

(Protseduur) on SQL käskude kogum, mis salvestatakse andmebaasi ja mida saab korduvalt kasutada.
Eelised:

- koodi korduvkasutus
- parem jõudlus
- turvalisus (piiratud ligipääs)
- lihtsam haldus

## SELECT protseduur
```sql
CREATE PROCEDURE tooted
AS
BEGIN
    SELECT * FROM toode
END;

--Käivitamine
EXEC tooted;

--Kustutamine
DROP PROCEDURE tooted;
```

<img width="308" height="320" alt="{DBEA2A38-5EBC-4FCA-8A74-DF98D7CA7150}" src="https://github.com/user-attachments/assets/5e28a4dd-4e2c-4b2c-a55a-216691ebfb58" />

<img width="451" height="304" alt="{6810DB67-98CB-4352-BE65-35748D94BE46}" src="https://github.com/user-attachments/assets/8610e36c-2e12-4faf-aef6-32024c08f8c9" />


## INSERT protseduur
```sql
--Protseduur andmete lisamiseks
CREATE PROCEDURE lisaToode
    @nimetus varchar(20),
    @tootja varchar(20),
    @kogus int,
    @hind money
AS
BEGIN
    INSERT INTO toode(toodeNimi, tootja, toodeHind, toodeKogus)
    VALUES (@nimetus, @tootja, @hind, @kogus);

    SELECT * FROM toode;
END;
--Käivitamine
EXEC lisaToode 'Fanta', 'FF', 5, 3;
```


<img width="429" height="294" alt="{3BD35B7F-FD8B-4458-8344-916272A315D9}" src="https://github.com/user-attachments/assets/e7e5b3b7-d5ab-4f45-80d1-3f59eaba9044" />

<img width="242" height="20" alt="{18C4AC64-93FF-4971-9DCE-FD49CE88C677}" src="https://github.com/user-attachments/assets/1ff7b9f6-b19b-4628-b91f-c4c96d6f2045" />

## OUTPUT parameetrid (min ja max väärtus)

```sql
--Protseduur, mis leiab väikseima ja suurima hind
CREATE PROCEDURE minmaxHind
    @minHind MONEY OUTPUT,
    @maxHind MONEY OUTPUT
AS
BEGIN
    SELECT 
        @minHind = MIN(toodeHind),
        @maxHind = MAX(toodeHind)
    FROM toode;
END;


--Kasutamine

DECLARE @minHind MONEY, @maxHind MONEY;

EXEC minmaxHind @minHind OUTPUT, @maxHind OUTPUT;

PRINT 'Min hind = ' + CONVERT(varchar, @minHind);
PRINT 'Max hind = ' + CONVERT(varchar, @maxHind);
```


<img width="467" height="368" alt="{81AC9AE2-E854-428F-8ED9-92E9D6E6F375}" src="https://github.com/user-attachments/assets/9ec1926b-9220-4f20-8335-95a925e12bce" />

## Dünaamiline SQL protseduuris (ALTER TABLE)
```sql
--Protseduur veeru lisamiseks või kustutamiseks
CREATE PROCEDURE muudatusss
    @tegevus varchar(10),
    @tabelinimi varchar(25),
    @veerunimi varchar(25),
    @tyyp varchar(25) = NULL
AS
BEGIN
    DECLARE @sqltegevus varchar(max);

    SET @sqltegevus = CASE 
        WHEN @tegevus = 'add' THEN 
            CONCAT('ALTER TABLE ', @tabelinimi, ' ADD ', @veerunimi, ' ', @tyyp)

        WHEN @tegevus = 'drop' THEN 
            CONCAT('ALTER TABLE ', @tabelinimi, ' DROP COLUMN ', @veerunimi)
    END;

    PRINT @sqltegevus;
    EXEC (@sqltegevus);
END;

-- veeru lisamine
EXEC muudatusss 
    @tegevus='add', 
    @tabelinimi='toode', 
    @veerunimi='test', 
    @tyyp='int';

-- veeru kustutamine
EXEC muudatusss 
    @tegevus='drop', 
    @tabelinimi='toode', 
    @veerunimi='test';
```


<img width="421" height="348" alt="{FD3211E3-4D57-4E51
-9604-A120DC0D9C9B}" src="https://github.com/user-attachments/assets/1321b4e1-6681-4989-9d44-a071ce8d80bd" />

<img width="429" height="312" alt="{F7129A7B-8A15-45C4-8CC8-16F05300B684}" src="https://github.com/user-attachments/assets/bb86d1db-6a96-48f4-9635-3d37253dfc30" />

## Protseduur mis lisab automaatselt hinnangu 
```sql
--Protseduur, mis kuvab toodete nime, hinna ja lisab automaatselt hinnangu 
CREATE PROCEDURE kuvaTootedHinnaKategooriaga
AS
BEGIN
    SELECT 
        toodeNimi,
        toodeHind,
        CASE 
            WHEN toodeHind < 2 THEN 'soodne'
            ELSE 'kallis'
        END AS hinnaKategooria
    FROM toode;
END;
EXEC kuvaTootedHinnaKategooriaga
```
## Tähtsad mõisted

- @parameeter – sisendväärtus protseduurile
- OUTPUT – tagastatav väärtus
- EXEC – protseduuri käivitamine
- Dünaamiline SQL – SQL käsk, mis luuakse stringina
- ALTER TABLE – tabeli muutmine

<img width="383" height="257" alt="{260FAE70-66EB-4AC3-B349-E9F66716B30C}" src="https://github.com/user-attachments/assets/3aa314a4-0e41-4cfa-8564-901d622086b8" />


