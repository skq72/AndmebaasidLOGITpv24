# Trigger päästik

[Põhimõisted](README.md) | [Trigerid](triger.md) | [Trigerid XAMPP-is](trigerXAMPP.md) | [Keys](keys.md) | [Protseduurid](protseduurid.md) | [Kasutajad ja ül1](kasutaja.md) | 

### SQL triggerid on spetsiaalsed andmebaasi objektid, mis käivituvad automaatselt, kui toimub teatud sündmus (nt INSERT, UPDATE või DELETE).
--Trigger lisatud kirjeid jälgimiseks tabelis “linnad” – INSERT
--Jälgib andmete sisestamine tabelis linnad ja teeb vastava kirje tabelis logi
```SQL
CREATE TRIGGER linnaLisamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR INSERT
AS
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
GETDATE(),  --aeg
SYSTEM_USER, --kasutaja mis on sisse logitud serverisse
'on tehtud INSERT käsk',  --toiming
concat ('linn: ', inserted.linnanimi, ', rahvaarv: ', inserted.rahvaarv)  --andmed tabelist linnad
FROM inserted;
```

Kontrollimine

<img width="608" height="419" alt="{C18954B6-4DED-4A98-9882-DD1BA8E38EAC}" src="https://github.com/user-attachments/assets/0616dc11-ad27-4ab3-863c-afff2aa80b9b" />

<img width="441" height="509" alt="{AAEE3257-D697-45DC-859E-8A5411C26104}" src="https://github.com/user-attachments/assets/d125b5b7-7ad5-466e-826f-da202c0173bf" />
