Create Database LOGITpv24;


--ab kasutamine

USE LOGITpv24;
CREATE TABLE tootaja(
tootajaId int PRIMARY KEY identity(1,1), --identity -automaatselt kasvav arv +1
eesnimi varchar(15) not null,
perenimi varchar(30) not null,
synniaeg date,
aadress TEXT,
koormus int CHECK (koormus>0), -- piirang, et koormus >0
aktiivne bit)

--tabeli kuvamine
SELECT * FROM tootaja;

--andmete lisamine tabelisse
INSERT INTO tootaja(perenimi, eesnimi, synniaeg)
VALUES ('Ilus','Liis','2002-12-4')

INSERT INTO tootaja
VALUES ('Oliver','Silk','2007-2-1','Tallinn',100, 1),('Kersti','Mää','2000-10-14','Tallinn',110, 1),('Artjom','Kashin','2001-2-4','Tallinn',10, 1)

--andmete uuendamine tabelis
UPDATE tootaja SET aadress='Tallinn', koormus= 11, aktiivne=0
WHERE tootajaId=1;
