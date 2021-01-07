/*V katerih trgovinah se dobijo sestavine za Lazanjo*/
SELECT t.ime AS Ime_trgovine, s.ime AS Ime_sestavine FROM trgovine t 
JOIN recepti r ON t.ID=r.JEDI_ID 
JOIN recepti_has_sestavine rhs ON rhs.RECEPTI_ID=r.ID
JOIN sestavine s ON s.ID=rhs.SESTAVINE_ID 
JOIN sestavine_has_trgovine shs ON shs.ID=s.ID
JOIN trgovine tr ON tr.ID=shs.TRGOVINE_ID
JOIN jedi j ON r.JEDI_ID=j.ID WHERE j.ime='Lazanja';

/*Iz katerega vira imamo največ receptov*/
CREATE VIEW ŠteviloVirov AS SELECT COUNT(TIPI_VIROV_ID) AS Število_virov FROM vir GROUP BY TIPI_VIROV_ID;
SELECT tv.tip, COUNT(v.TIPI_VIROV_ID) AS Število_virov FROM tipi_virov tv 
JOIN vir v ON v.TIPI_VIROV_ID = tv.ID 
GROUP BY tv.TIP 
HAVING Število_virov = (SELECT MAX(Število_virov) FROM ŠteviloVirov);

/*Koliko stanejo Čokoladno - mascarponejeve kocke*/
SELECT j.ime AS Ime_Jedi, SUM(c.cena) AS Cena, tv.valuta AS Valuta FROM jedi j 
JOIN recepti r ON j.ID = r.JEDI_ID
JOIN recepti_has_sestavine rhs ON rhs.RECEPTI_ID = r.ID
JOIN sestavine s ON s.ID = rhs.SESTAVINE_ID
JOIN cene c ON c.ID = s.CENE_ID
JOIN tipi_valut tv ON tv.ID = c.TIPI_VALUT_ID
WHERE j.ime = "Čokoladno - mascarponejeve kocke";

/*Ali je v jedilniku za 4.4.2018 tudi svinjina*/
SELECT s.ime AS Ime_sestavine FROM jedi j 
JOIN jedi_has_jedilniki jhd ON j.ID = jhd.JEDI_ID
JOIN jedilniki jd ON jd.ID = jhd.JEDILNIKI_ID
JOIN recepti r ON j.ID = r.JEDI_ID
JOIN recepti_has_sestavine rhs ON rhs.RECEPTI_ID = r.ID
JOIN sestavine s ON s.ID = rhs.SESTAVINE_ID 
WHERE jd.kdaj = '2018-04-04';

/*Spremeni stran vira*/
UPDATE vir SET stran = 45 WHERE nazivVira = "Kniga 1 - Mehiška tortilja";

/*Izbriši sestavino*/
DELETE FROM sestavine WHERE sestavine.ime = "Jajca";




