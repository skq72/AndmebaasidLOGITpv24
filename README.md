# Andmebaasid
andmebaaside haldusega seotud sql kood ja konspektid
## Sisukord
- [Põhimõisted](#põhimõisted)
- [Andmetüübid](#andmetüübid)
- [SÕL](#sõl)
- [Piirangud](#piirangud)
- [Tabelivahelised_seosed](#tabelivahelised_seosed)
- [Alter_table](#alter_table)
## Põhimõisted
- Andmebaasi haldussüsteemid - tarkvara, millega abil saab luua andmebaas (mariaDB - XAMPP, SQL Server - SQL Server Management Studio)
- Andmebaas - struktureeritud andmete kogum
- Tabel = olem - сущности
- Veerg = väli - поле
- Rida = kirje - запись
- Primaarne võti - Primary key -PK- veerg, unikaalse identifikaatoriga (tavaliselt nimetakse ID)- первичный ключ
- Välisvõti (võõrvõti) - Foreign key -FK- veerg, mis loob seose teise tabeli primaarne võtmega - вторичный ключ

## SÕL 
- structured query language - struktureeritud päringu keel - структуированый язык запросов

<img width="402" height="350" alt="{93A579AC-2E7D-451D-82E5-DA3A40B673F4}" src="https://github.com/user-attachments/assets/d9760256-3e96-4d9c-b603-7ddd8515ea67" />

- päring - запрос
1. DDL - Data Definition Language
2. DML - Data Manipulation Language

## Piirangud
- ограничения
1. PRIMARY KEY
2. NOT NULL
3. CHECK -vali
4. UNIQUE
5. FOREIGN KEY
   
## Andmetüübid 
```
1. int, smallint, decimal(5,2) - numbrilised
2. varchar(30), char(5), TEXT -tekst/sümbolised
3. date, time, datetime, - kuupäeva
4. boolean, bit, bool -loogilised
```
## Tabelivahelised_seosed
- üks-ühele -(nt naine-mees)
- üks-mitmele (nt naine -lapsed)
 <img width="499" height="207" alt="{2F7F4959-E85F-452A-9416-2BC01B6CA80A}" src="https://github.com/user-attachments/assets/a7fa5b1c-8663-4039-a1e5-92646f7e05ce" />


- mitme-mitmele (nt õpilased-tunnid)

  ## Alter_table
1. uue veeru lisamine
  
```sql

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
```
