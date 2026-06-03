# Andmebaasi võtmed (Keys)

## Primary Key
See on tabeli rea peamine unikaalne number (nagu inimese passi number). Selle abil leiab andmebaas vajaliku kirje.

*Kolm peamist reeglit:*

- Väärtused ei tohi korduda.
- Välja ei tohi jätta tühjaks (ilma NULL-väärtuseta).
- Tabelis võib olla ainult üks selline võti.

## Foreign Key
See on veerg, mis seob ühe tabeli teisega. See viitab teise tabeli primaarvõtmele (peamisele ID-le), luues nende vahel selge seose.
Peamine eesmärk: tagada, et seosed oleksid õiged (seda nimetatakse viite terviklikkuseks). Tellimust ei saa seostada olematuga kliendiga.

## Unique Key
See on reegel, mis keelab andmete kordamise veerus. Kõik selle veeru väärtused peavad olema unikaalsed, kuid erinevalt põhivõtmest võib selle veeru jätta tühjaks (NULL).

*Milleks seda kasutatakse:*

- Oluliste, kuid mitte kohustuslike andmete jaoks: näiteks e-post, telefoninumber või kasutajanimi. Need ei tohi erinevatel inimestel kattuda, kuid mõnel inimesel võib neid üldse mitte olla.
- Ärireeglite jaoks: näiteks selleks, et ühte sooduskoodi ei saaks aktiveerida kaks korda.

*Peamised erinevused esmavõtmest (Primary Key):*

- Esmavõti (Primary Key): Tabelis võib olla ainult üks ja see ei tohi kunagi olla tühi (NULL).
- Unikaalne võti (Unique Key): Selliseid reegleid võib tabelis olla palju ja need lubavad tühja väärtust (NULL).
## Simple Key
See on võti mis tahes tüüpi: esmane, unikaalne või välisvõti, mis koosneb vaid ühestainsast veerust.

Te ei pea mitut välja kokku liitma, et leida soovitud rida või tabeleid omavahel seostada – sellest ühest väljast piisab enam kui küll.

## Composite Key
See on üks peavõti, mis koosneb mitmest veerust. Eraldi võivad andmed nendes veergudes korduda nii palju kui soovite, kuid nende kombinatsioon peab olema rangelt unikaalne.

*Millal seda kasutatakse:*

- Kui tabelis ei ole ühtegi veergu, mis oleks iseenesest unikaalne.
- Siduvates tabelites (suhe „paljud-paljudele”).

## Compound Key
See on liitvõtme liik, mis koosneb kahest või enamast veerust. Eraldi võivad andmed nendes veergudes korduda, kuid koos moodustavad nad unikaalse kombinatsiooni.

Peamine omadus: iga veerg, mis kuulub (Compound Key) koosseisu, on tingimata välisvõti (Foreign Key) ja viitab mõnele teisele tabelile.

## Superkey
See on täiesti mis tahes veerukombinatsioon, mille abil on võimalik tabelis kindlasti leida konkreetne rida. Supervõtme peamine omadus on see, et see võib olla liigne – st sisaldada palju üleliigset, mittevajalikku teavet.

## Candidate Key
See on nimekiri kõigist „ideaalseist kandidaatidest”, mis sobivad tabeli peavõtmeks. Iga selline väli määrab rida üheselt kindlaks ega sisalda endas mingit üleliigset infojäätmeid.

*Peamised reeglid:*

- Kohustuslikkus: igas tabelis peab olema vähemalt üks selline kandidaat.
- Ausad valimised: tabelis võib olla palju potentsiaalseid võtmeid, kuid peamiseks (Primary Key) saab ainult üks neist.
- Ilma üleliigse: kandidaadist ei tohi eemaldada ühtegi veergu nii, et see kaotaks oma unikaalsuse.
## Alternate Key
See on veerg (või veergude rühm), mis võinuks saada põhivõtmeks, sest ka see on unikaalne, kuid jäi lõpuks „varuks”.

Kujutage ette valimisi: 
Teil on mitu suurepärast kandidaati põhivõtme rolli jaoks. Te valite ühe liidri ja kõik ülejäänud kaotajad muutuvad automaatselt alternatiivseteks võtmeteks.

## Kasutatud allikad:

https://www.guru99.com/dbms-keys.html 

https://www.geeksforgeeks.org/dbms/types-of-keys-in-relational-model-candidate-super-primary-alternate-and-foreign/ 

https://www.sqlpractice.in/blog/keys-in-sql 
