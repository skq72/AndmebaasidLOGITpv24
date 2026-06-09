# SQL Server – Kasutajate autentimine ja õiguste haldamine

[Põhimõisted](README.md) | [Trigerid](triger.md) | [Trigerid XAMPP-is](trigerXAMPP.md) | [Keys](keys.md) | [Protseduurid](protseduurid.md) | [Kasutajad ja ül1](kasutaja.md) | 

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

