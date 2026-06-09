# Andmebaasi võtmed (Keys)

[Põhimõisted](README.md) | [Trigerid](triger.md) | [Trigerid XAMPP-is](trigerXAMPP.md) | [Keys](keys.md) | [Kasutajad ja ül1](kasutaja.md) | 

## Primary Key
See on tabeli rea peamine unikaalne number (nagu inimese passi number). Selle abil leiab andmebaas vajaliku kirje.
```sql
CREATE TABLE ostjad (
    ostja_id INT PRIMARY KEY,
    ostja_nimi VARCHAR(100) NOT NULL
);
```

<img width="210" height="70" alt="image" src="https://github.com/user-attachments/assets/f9ec7645-5dc8-46e4-8412-48edf86f7c57" />

## Foreign Key
See on veerg, mis seob ühe tabeli teisega. See viitab teise tabeli primaarvõtmele (peamisele ID-le), luues nende vahel selge seose.
Peamine eesmärk: tagada, et seosed oleksid õiged (seda nimetatakse viite terviklikkuseks). Tellimust ei saa seostada olematuga kliendiga.

```sql
CREATE TABLE kullerid (
    kulleri_id INT IDENTITY(1,1) PRIMARY KEY,
    kulleri_nimi VARCHAR(100)
);

CREATE TABLE restoranid (
    restorani_id INT IDENTITY(1,1) PRIMARY KEY,
    tootaja_nimi VARCHAR(100),
    kulleri_id INT,
    FOREIGN KEY (kulleri_id)
    REFERENCES kullerid(kulleri_id)
);
```

<img width="210" height="67" alt="image" src="https://github.com/user-attachments/assets/a0dc5581-cfb2-4a71-b46d-a36fff7e67ce" />
<img width="242" height="85" alt="image" src="https://github.com/user-attachments/assets/e638b265-bda9-4c1f-9092-b8e49da26ced" />

## Unique Key
See on reegel, mis keelab andmete kordamise veerus. Kõik selle veeru väärtused peavad olema unikaalsed, kuid erinevalt põhivõtmest võib selle veeru jätta tühjaks (NULL).
```sql
CREATE TABLE tootajad (
    id INT IDENTITY(1,1) PRIMARY KEY,
    Email VARCHAR(100) UNIQUE
);
```
<img width="240" height="122" alt="image" src="https://github.com/user-attachments/assets/1948d4af-0619-496f-acf5-b8d8e0d5a0db" />

## Simple Key
See on võti mis tahes tüüpi: esmane, unikaalne või välisvõti, mis koosneb vaid ühestainsast veerust.

Te ei pea mitut välja kokku liitma, et leida soovitud rida või tabeleid omavahel seostada – sellest ühest väljast piisab enam kui küll.
```sql
CREATE TABLE omanikud (
    omaniku_id INT PRIMARY KEY,
    omaniku_nimi VARCHAR(100) NOT NULL
);
```
<img width="244" height="103" alt="image" src="https://github.com/user-attachments/assets/38a4820e-9af4-4540-b447-222cd59e77ba" />

## Composite Key
See on üks peavõti, mis koosneb mitmest veerust. Eraldi võivad andmed nendes veergudes korduda nii palju kui soovite, kuid nende kombinatsioon peab olema rangelt unikaalne.
```sql
CREATE TABLE soprade_suunnipaevad (
    sober_id INT,
    sunnipaev_date DATE,
    sopra_nimi VARCHAR(100),
    PRIMARY KEY (sunnipaev_date, sober_id) 
);
```
<img width="249" height="120" alt="image" src="https://github.com/user-attachments/assets/d89158d5-ccc8-45d1-b349-40217bca253d" />

## Compound Key
See on liitvõtme liik, mis koosneb kahest või enamast veerust. Eraldi võivad andmed nendes veergudes korduda, kuid koos moodustavad nad unikaalse kombinatsiooni.

Peamine omadus: iga veerg, mis kuulub (Compound Key) koosseisu, on tingimata välisvõti (Foreign Key) ja viitab mõnele teisele tabelile.
```sql
CREATE TABLE paevik (
    opilane_id INT, 
    aineID INT,
    PRIMARY KEY (opilane_id, aineID)
);
```
<img width="248" height="109" alt="image" src="https://github.com/user-attachments/assets/e0f1f46d-21df-4206-8d05-dcb321f04c8b" />


## Superkey
See on täiesti mis tahes veerukombinatsioon, mille abil on võimalik tabelis kindlasti leida konkreetne rida. Supervõtme peamine omadus on see, et see võib olla liigne – st sisaldada palju üleliigset, mittevajalikku teavet.
```SQL
CREATE TABLE nutitelefonidD (
    telefon_id INT IDENTITY(1,1) PRIMARY KEY,
    imei_kood VARCHAR(15) NOT NULL,
    varv VARCHAR(20),
);
```
<img width="247" height="125" alt="image" src="https://github.com/user-attachments/assets/6506fd9d-c3c0-40a6-af42-5f63790551ab" />

## Candidate Key
See on nimekiri kõigist „ideaalseist kandidaatidest”, mis sobivad tabeli peavõtmeks. Iga selline väli määrab rida üheselt kindlaks ega sisalda endas mingit üleliigset infojäätmeid.
```sql
CREATE TABLE Klient (
    klient_id INT IDENTITY (1,1) PRIMARY KEY,
    Telefon VARCHAR(20) UNIQUE,
    Email VARCHAR(120) UNIQUE
);
```
<img width="242" height="154" alt="image" src="https://github.com/user-attachments/assets/164b2775-9029-4bba-9033-c9d76c16d257" />

## Alternate Key
See on veerg (või veergude rühm), mis võinuks saada põhivõtmeks, sest ka see on unikaalne, kuid jäi lõpuks „varuks”.
```sql
CREATE TABLE pass (
    pass_id INT IDENTITY (1,1) PRIMARY KEY,
    isikukood VARCHAR(50) UNIQUE
);
```
<img width="260" height="123" alt="image" src="https://github.com/user-attachments/assets/2f5f0c74-bac3-4904-8c7e-9774ca18e680" />

## Kasutatud allikad:

https://www.guru99.com/dbms-keys.html 

https://www.geeksforgeeks.org/dbms/types-of-keys-in-relational-model-candidate-super-primary-alternate-and-foreign/ 

https://www.sqlpractice.in/blog/keys-in-sql 
