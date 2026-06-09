# SQL Protseduurid
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
