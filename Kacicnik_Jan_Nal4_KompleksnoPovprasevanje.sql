DROP TABLE IF EXISTS ReceptImaSestavino;
DROP TABLE IF EXISTS ProizvajalecImaSestavino;
DROP TABLE IF EXISTS JedilnikImaOsebo;
DROP TABLE IF EXISTS JedilnikImaJed;
DROP TABLE IF EXISTS TrgovinaImaSestavino;
DROP TABLE IF EXISTS JedilnikImaJed;
DROP TABLE IF EXISTS Recept;
DROP TABLE IF EXISTS Sestavina;
DROP TABLE IF EXISTS Proizvajalec;
DROP TABLE IF EXISTS Trgovina;
DROP TABLE IF EXISTS Jed;
DROP TABLE IF EXISTS Jedilnik;
DROP TABLE IF EXISTS Vir;
DROP TABLE IF EXISTS Oseba;
DROP TABLE IF EXISTS Naslov;
DROP TABLE IF EXISTS Cena;
DROP TABLE IF EXISTS CasKuhanja;
DROP TABLE IF EXISTS CasPriprave;
DROP TABLE IF EXISTS CasovnaEnota;

CREATE TABLE CasovnaEnota(
    id INT NOT NULL,
    enota VARCHAR(10) NOT NULL
);

CREATE TABLE CasPriprave(
    id INT NOT NULL,
    cas INT NOT NULL,
    idCasovnaEnota INT NOT NULL
);

CREATE TABLE CasKuhanja(
    id INT NOT NULL,
    cas INT NOT NULL,
    idCasovnaEnota INT NOT NULL
);

CREATE TABLE Cena(
    id INT NOT NULL NOT NULL,
    cena DECIMAL(10,2) NOT NULL,
    valuta VARCHAR(20) NOT NULL
);

CREATE TABLE Naslov(
    id INT NOT NULL,
    ulica VARCHAR(80) NOT NULL,
    hisnaStevilka INT NOT NULL,
    kraj VARCHAR(80) NOT NULL,
    drzava VARCHAR(80)
);

CREATE TABLE Oseba(
    id INT NOT NULL,
    ime VARCHAR(25) NOT NULL,
    priimek VARCHAR(25) NOT NULL,
    elektronskiNaslov VARCHAR(50),
    uporabniskoIme VARCHAR(50)
);

CREATE TABLE Vir(
    id INT NOT NULL,
    naziv VARCHAR(80) NOT NULL,
    stran INT,
    elektronskaPovezava VARCHAR(250),
    idAvtor INT NOT NULL
);

CREATE TABLE Jedilnik(
    id INT NOT NULL,
    namen VARCHAR(80),
    cas DATETIME NOT NULL
);

CREATE TABLE JedilnikImaOsebo(
	id INT NOT NULL,
    idOseba INT NOT NULL,
    idJedilnik INT NOT NULL
);

CREATE TABLE JedilnikImaJed(
    id INT NOT NULL,
    idJed INT NOT NULL,
    idJedilnik INT
);

CREATE TABLE Jed(
    id INT NOT NULL,
    naziv VARCHAR(80) NOT NULL,
    vrsta VARCHAR(60) NOT NULL
);

CREATE TABLE Trgovina(
    id INT NOT NULL,
    naziv VARCHAR(80) NOT NULL,
    idNaslov INT NOT NULL
);

CREATE TABLE Sestavina(
    id INT NOT NULL,
    naziv VARCHAR(50),
    idCena INT 
);

CREATE TABLE Proizvajalec(
    id INT NOT NULL,
    naziv VARCHAR(80) NOT NULL,
    idNaslov INT NOT NULL
);

CREATE TABLE TrgovinaImaSestavino(
    id INT NOT NULL,
    idSestavina INT NOT NULL,
    idTrgovina INT
);

CREATE TABLE ProizvajalecImaSestavino(
    id INT NOT NULL,
    idSestavina INT NOT NULL,
    idProizvajalec INT
);

CREATE TABLE ReceptImaSestavino(
    id INT NOT NULL,
    idRecept INT NOT NULL,
    idSestavina INT,
    kolicina DECIMAL(10,2) NOT NULL,
    enota VARCHAR(45)
);

CREATE TABLE Recept(
    id INT NOT NULL,
    idJed INT NOT NULL,
    idCasKuhanja INT NOT NULL,
    idCasPriprave INT NOT NULL,
    postopek VARCHAR(1000) NOT NULL,
    komentar VARCHAR(1000),
    idVir INT
);

ALTER TABLE CasPriprave ADD CONSTRAINT PK_cas_priprave PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE CasKuhanja ADD CONSTRAINT PK_cas_kuhanja PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE CasovnaEnota ADD CONSTRAINT PK_casovna_enota PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Cena ADD CONSTRAINT PK_cena PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Naslov ADD CONSTRAINT PK_naslov PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Oseba ADD CONSTRAINT PK_oseba PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Vir ADD CONSTRAINT PK_vir PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Jedilnik ADD CONSTRAINT PK_jedilnik PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE JedilnikImaJed ADD CONSTRAINT PK_jedilnik_ima_jed PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE JedilnikImaOsebo ADD CONSTRAINT PK_jedilnik_ima_osebo PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Jed ADD CONSTRAINT PK_jed PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Trgovina ADD CONSTRAINT PK_trgovina PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Proizvajalec ADD CONSTRAINT PK_proizvajalec PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE TrgovinaImaSestavino ADD CONSTRAINT PK_trgovina_ima_sestavino PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE ProizvajalecImaSestavino ADD CONSTRAINT PK_proizvajalec_ima_sestavino PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Sestavina ADD CONSTRAINT PK_sestavina PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE ReceptImaSestavino ADD CONSTRAINT PK_recept_ima_sestavino PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Recept ADD CONSTRAINT PK_recept PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;




ALTER TABLE CasPriprave ADD CONSTRAINT FK_cas_priprave_enota FOREIGN KEY(idCasovnaEnota) REFERENCES CasovnaEnota(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE CasKuhanja ADD CONSTRAINT FK_cas_kuhanja_enota FOREIGN KEY(idCasovnaEnota) REFERENCES CasovnaEnota(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Vir ADD CONSTRAINT FK_vir_avtor FOREIGN KEY(idAvtor) REFERENCES Oseba(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE JedilnikImaOsebo ADD CONSTRAINT FK_jedilnik_ima_osebo_oseba FOREIGN KEY(idOseba) REFERENCES Oseba(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE JedilnikImaOsebo ADD CONSTRAINT FK_jedilnik_ima_osebo_jedilnik FOREIGN KEY(idJedilnik) REFERENCES Oseba(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE JedilnikImaJed ADD CONSTRAINT FK_jedilnik_ima_jed_jed FOREIGN KEY(idJed) REFERENCES Jed(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE JedilnikImaJed ADD CONSTRAINT FK_jedilnik_ima_jed_jedilnik FOREIGN KEY(idJedilnik) REFERENCES Jedilnik(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Trgovina ADD CONSTRAINT FK_naslov_trgovine FOREIGN KEY(idNaslov) REFERENCES Naslov(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Proizvajalec ADD CONSTRAINT FK_naslov_proizvajalca FOREIGN KEY(idNaslov) REFERENCES Naslov(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE TrgovinaImaSestavino ADD CONSTRAINT FK_trgovina_ima_sestavino_sestavina FOREIGN KEY(idSestavina) REFERENCES Sestavina(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE TrgovinaImaSestavino ADD CONSTRAINT FK_trgovina_ima_sestavino_trgovina FOREIGN KEY(idTrgovina) REFERENCES Trgovina(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE ProizvajalecImaSestavino ADD CONSTRAINT FK_proizvajalec_ima_sestavino_sestavina FOREIGN KEY(idSestavina) REFERENCES Sestavina(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE ProizvajalecImaSestavino ADD CONSTRAINT FK_proizvajalec_ima_sestavino_proizvajalec FOREIGN KEY(idProizvajalec) REFERENCES Proizvajalec(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Sestavina ADD CONSTRAINT FK_cena FOREIGN KEY(idCena) REFERENCES Cena(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE ReceptImaSestavino ADD CONSTRAINT FK_recept_ima_sestavino_recept FOREIGN KEY(idRecept) REFERENCES Recept(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE ReceptImaSestavino ADD CONSTRAINT FK_recept_ima_sestavino_sestavina FOREIGN KEY(idSestavina) REFERENCES Sestavina(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Recept ADD CONSTRAINT FK_recept_jed FOREIGN KEY(idJed) REFERENCES Jed(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Recept ADD CONSTRAINT FK_recept_cas_priprave FOREIGN KEY(idCasPriprave) REFERENCES CasPriprave(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Recept ADD CONSTRAINT FK_recept_cas_kuhanja FOREIGN KEY(idCasKuhanja) REFERENCES CasKuhanja(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Recept ADD CONSTRAINT FK_recept_vir FOREIGN KEY(idVir) REFERENCES Vir(id) ON DELETE CASCADE ON UPDATE CASCADE;


DELIMITER !!

DROP PROCEDURE IF EXISTS `PopulateCena`!!
CREATE PROCEDURE `PopulateCena`(IN stevilo INT)
  BEGIN
    DECLARE i INT;
    DECLARE _cena DECIMAL(10,2);
    DECLARE _valuta VARCHAR(20);
    

    SET i = 0;
    
    START TRANSACTION;

    WHILE i < stevilo DO
      
      SET _cena = FLOOR(RAND() * 50);
      SET _valuta = CONCAT('Valuta', FLOOR(RAND() * (999) + 1));
      
      INSERT INTO Cena (cena, valuta) values (_cena, _valuta);

      SET i = i + 1;
    END WHILE;
    
    COMMIT;

  END!!
  
DROP PROCEDURE IF EXISTS `PopulateNaslov`!!
CREATE PROCEDURE `PopulateNaslov`(IN stevilo INT)
  BEGIN
    DECLARE i INT;
    DECLARE _ulica VARCHAR(80);
    DECLARE _hisnaStevilka INT;
    DECLARE _kraj VARCHAR(80);
    DECLARE _drzava VARCHAR(80);

    SET i = 0;
    
    START TRANSACTION;

    WHILE i < stevilo DO
      
      SET _ulica = CONCAT('Ulica', FLOOR(RAND() * (999) + 1));
      SET _hisnaStevilka = FLOOR(RAND() * (50) + 1);
      SET _kraj = CONCAT('Kraj', FLOOR(RAND() * (999) + 1));
      SET _drzava = CONCAT('Drzava', FLOOR(RAND() * (999) + 1));
      
      INSERT INTO Naslov (ulica, hisnaStevilka, kraj, drzava) values (_ulica, _hisnaStevilka, _kraj, _drzava);

      SET i = i + 1;
    END WHILE;
    
    COMMIT;

  END!!
  
DROP PROCEDURE IF EXISTS `PopulateJed`!!
CREATE PROCEDURE `PopulateJed`(IN stevilo INT)
  BEGIN
    DECLARE i INT;
    DECLARE _naziv VARCHAR(80);
    DECLARE _vrsta VARCHAR(60);

    SET i = 0;
    
    START TRANSACTION;

    WHILE i < stevilo DO
      
      SET _naziv = CONCAT('Naziv', FLOOR(RAND() * (999) + 1));
      SET _vrsta = CONCAT('Vrsta', FLOOR(RAND() * (999) + 1));
      
      INSERT INTO Jed (naziv, vrsta) values (_naziv, _vrsta);

      SET i = i + 1;
    END WHILE;
    
    COMMIT;

  END!!
  
DROP PROCEDURE IF EXISTS `PopulateOseba`!!
CREATE PROCEDURE `PopulateOseba`(IN stevilo INT)
  BEGIN
    DECLARE i INT;
    DECLARE _ime VARCHAR(50);
    DECLARE _priimek VARCHAR(50);
	DECLARE _elektronskiNaslov VARCHAR(50);
	DECLARE _uporabniskoIme VARCHAR(50);

    SET i = 0;
    
    START TRANSACTION;

    WHILE i < stevilo DO
      
      SET _ime = CONCAT('Ime', FLOOR(RAND() * (999) + 1));
      SET _priimek = CONCAT('Priimek', FLOOR(RAND() * (999) + 1));
      SET _elektronskiNaslov = CONCAT('ElektronskiNaslov', FLOOR(RAND() * (999) + 1));
      SET _uporabniskoIme = CONCAT('UporabniskoIme', FLOOR(RAND() * (999) + 1));
      
      INSERT INTO Oseba (ime, priimek, elektronskiNaslov, uporabniskoIme) values (_ime, _priimek, _elektronskiNaslov, _uporabniskoIme);

      SET i = i + 1;
    END WHILE;
    
    COMMIT;

  END!!
  
DROP PROCEDURE IF EXISTS `PopulateJedilnik`!!
CREATE PROCEDURE `PopulateJedilnik`(IN stevilo INT)
  BEGIN
    DECLARE i INT;
    DECLARE _namen VARCHAR(80);
    DECLARE _cas DATETIME;

    SET i = 0;
    
    START TRANSACTION;

    WHILE i < stevilo DO
      
      SET _namen = CONCAT('Namen', FLOOR(RAND() * (999) + 1));
      SET _cas = NOW() + INTERVAL FLOOR(RAND() * 10) DAY;
      
      INSERT INTO Jedilnik (namen, cas) values (_namen, _cas);

      SET i = i + 1;
    END WHILE;
    
    COMMIT;

  END!!
  
DROP PROCEDURE IF EXISTS `PopulateCasovnaEnota`!!
CREATE PROCEDURE `PopulateCasovnaEnota`(IN stevilo INT)
  BEGIN
    DECLARE i INT;
    DECLARE _enota VARCHAR(20);

    SET i = 0;
    
    START TRANSACTION;

    WHILE i < stevilo DO
      
      SET _enota = CONCAT('Enota', FLOOR(RAND() * (999) + 1));
	
      INSERT INTO CasovnaEnota (enota) values (_enota);

      SET i = i + 1;
    END WHILE;
    
    COMMIT;

  END!!
  
DROP PROCEDURE IF EXISTS `PopulateSestavina`!!
CREATE PROCEDURE `PopulateSestavina`(IN stevilo INT)
  BEGIN
    DECLARE i INT;
    DECLARE _naziv VARCHAR(50);
    DECLARE _idCena INT;
    
    DECLARE cur_cena CURSOR FOR SELECT id FROM Cena;
    
    OPEN cur_cena;
    
    SET i = 0;
    
    START TRANSACTION;
    
    WHILE i < stevilo DO
    
	  FETCH cur_cena INTO _idCena;
      
      SET _naziv = CONCAT('Sestavina', FLOOR(RAND() * (999) + 1));
      
      INSERT INTO Sestavina (naziv, idCena) values (_naziv, _idCena);
      

      SET i = i + 1;
    END WHILE;
    
    COMMIT;


  END!!
  
DROP PROCEDURE IF EXISTS `PopulateTrgovina`!!
CREATE PROCEDURE `PopulateTrgovina`(IN stevilo INT)
  BEGIN
    DECLARE i INT;
    DECLARE _naziv VARCHAR(50);
    DECLARE _idNaslov INT;
    
    DECLARE cur_naslov CURSOR FOR SELECT id FROM Naslov;
    
    OPEN cur_naslov;

    SET i = 0;
    
    START TRANSACTION;

    WHILE i < stevilo DO
      
      SET _naziv = CONCAT('Trgovina', FLOOR(RAND() * (999) + 1));
      
      FETCH cur_naslov INTO _idNaslov;
	
      INSERT INTO Trgovina (naziv, idNaslov) values (_naziv, _idNaslov);

      SET i = i + 1;
    END WHILE;
    
    COMMIT;
    
    CLOSE cur_naslov;

  END!!
  
DROP PROCEDURE IF EXISTS `PopulateProizvajalec`!!
CREATE PROCEDURE `PopulateProizvajalec`(IN stevilo INT)
  BEGIN
    DECLARE i INT;
    DECLARE _naziv VARCHAR(50);
    DECLARE _idNaslov INT;
    
    DECLARE cur_naslov CURSOR FOR SELECT id FROM Naslov;
    
    OPEN cur_naslov;

    SET i = 0;
    
    START TRANSACTION;

    WHILE i < stevilo DO
      
      SET _naziv = CONCAT('Proizvajalec', FLOOR(RAND() * (999) + 1));
      
      FETCH cur_naslov INTO _idNaslov;
	
      INSERT INTO Proizvajalec (naziv, idNaslov) values (_naziv, _idNaslov);

      SET i = i + 1;
    END WHILE;
    
    COMMIT;

	CLOSE cur_naslov;

  END!!
  
DROP PROCEDURE IF EXISTS `PopulateVir`!!
CREATE PROCEDURE `PopulateVir`(IN stevilo INT)
  BEGIN
    DECLARE i INT;
    DECLARE _naziv VARCHAR(80);
    DECLARE _stran INT;
    DECLARE _elektronskaPovezava VARCHAR(250);
    DECLARE _idAvtor INT;
    
    DECLARE cur_oseba CURSOR FOR SELECT id FROM Oseba;
    
    OPEN cur_oseba;

    SET i = 0;

	START TRANSACTION;
	
    WHILE i < stevilo DO
      
      SET _naziv = CONCAT('Vir1', FLOOR(RAND() * (999) + 1));
      SET _stran = FLOOR(RAND() * (999) + 1);
      
      FETCH cur_oseba INTO _idAvtor;
	
      INSERT INTO Vir (naziv, stran, idAvtor) values (_naziv, _stran, _idAvtor);

      SET i = i + 1;
    END WHILE;
    
    COMMIT;

	CLOSE cur_oseba;

  END!!

DROP PROCEDURE IF EXISTS `PopulateCasKuhanja`!!
CREATE PROCEDURE `PopulateCasKuhanja`(IN stevilo INT)
  BEGIN
    DECLARE i INT;
    DECLARE _cas INT;
    DECLARE _idCasovnaEnota INT;
    
    DECLARE cur_casovna_enota CURSOR FOR SELECT id FROM CasovnaEnota;
    
    OPEN cur_casovna_enota;
    
    SET i = 0;
    
    START TRANSACTION;

    WHILE i < stevilo DO
      
      SET _cas = FLOOR(RAND() * (500) + 1);
      
      FETCH cur_casovna_enota INTO _idCasovnaEnota;
	
      INSERT INTO CasKuhanja (cas, idCasovnaEnota) values (_cas, _idCasovnaEnota);

      SET i = i + 1;
    END WHILE;
    
    COMMIT;

	CLOSE cur_casovna_enota;
    
  END!!
  
DROP PROCEDURE IF EXISTS `PopulateCasPriprave`!!
CREATE PROCEDURE `PopulateCasPriprave`(IN stevilo INT)
  BEGIN
    DECLARE i INT;
    DECLARE _cas INT;
    DECLARE _idCasovnaEnota INT;
    
    DECLARE cur_casovna_enota CURSOR FOR SELECT id FROM CasovnaEnota;
    
    OPEN cur_casovna_enota;

    SET i = 0;
    
    START TRANSACTION;

    WHILE i < stevilo DO
      
      SET _cas = FLOOR(RAND() * (500) + 1);
      
      FETCH cur_casovna_enota INTO _idCasovnaEnota;
	
      INSERT INTO CasPriprave (cas, idCasovnaEnota) values (_cas, _idCasovnaEnota);

      SET i = i + 1;
    END WHILE;
    
    COMMIT;
    
    CLOSE cur_casovna_enota;

  END!!
  
DROP PROCEDURE IF EXISTS `PopulateJedilnikImaJed`!!
CREATE PROCEDURE `PopulateJedilnikImaJed`(IN stevilo INT)
  BEGIN
    DECLARE i INT;
    DECLARE j INT;
    DECLARE _idJed INT;
    DECLARE _idJedilnik INT;
    
    DECLARE cur_jedilnik CURSOR FOR SELECT id FROM Jedilnik;
    DECLARE cur_jed CURSOR FOR SELECT id FROM Jed;
    
    OPEN cur_jedilnik;
    OPEN cur_jed;

    SET i = 0;
	SET j = 0;
    
    START TRANSACTION;
    
    WHILE i < stevilo DO
      
      FETCH cur_jedilnik INTO _idJedilnik;
      FETCH cur_jed INTO _idJed;
      
      SET j = 0;
      
      WHILE j < stevilo DO

		INSERT INTO JedilnikImaJed (idJed, idJedilnik) values (_idJed, _idJedilnik);
        
		SET j = j + 1;
      END WHILE;

      SET i = i + 1;
    END WHILE;
    
    COMMIT;
    
    CLOSE cur_jedilnik;
    CLOSE cur_jed;

  END!!
  
  DROP PROCEDURE IF EXISTS `PopulateJedilnikImaOsebo`!!
CREATE PROCEDURE `PopulateJedilnikImaOsebo`(IN stevilo INT)
  BEGIN
    DECLARE i INT;
    DECLARE j INT;
    DECLARE _idOseba INT;
    DECLARE _idJedilnik INT;

    DECLARE cur_jedilnik CURSOR FOR SELECT id FROM Jedilnik;
    DECLARE cur_oseba CURSOR FOR SELECT id FROM Oseba;

    OPEN cur_jedilnik;
    OPEN cur_oseba;

    SET i = 0;
	SET j = 0;
    
    START TRANSACTION;

    WHILE i < stevilo DO
      
      FETCH cur_jedilnik INTO _idJedilnik;
      FETCH cur_oseba INTO _idOseba;
      
	  SET j = 0;
      
      WHILE j < stevilo DO
      
		INSERT INTO JedilnikImaOsebo (idOseba, idJedilnik) values (_idOseba, _idJedilnik);
      
        SET j = j + 1;
      END WHILE;

      SET i = i + 1;
      
    END WHILE;
    
    COMMIT;
    
	CLOSE cur_jedilnik;
    CLOSE cur_oseba;

  END!!
  
    DROP PROCEDURE IF EXISTS `PopulateTrgovinaImaSestavino`!!
CREATE PROCEDURE `PopulateTrgovinaImaSestavino`(IN stevilo INT)
  BEGIN
    DECLARE i INT;
    DECLARE j INT;
    DECLARE _idSestavina INT;
    DECLARE _idTrgovina INT;
    
    DECLARE cur_trgovina CURSOR FOR SELECT id FROM Trgovina;
    DECLARE cur_sestavina CURSOR FOR SELECT id FROM Sestavina;
    
    OPEN cur_trgovina;
    OPEN cur_sestavina;

	SET i = 0;
	SET j = 0;
    
    START TRANSACTION;

    WHILE i < stevilo DO
      
      FETCH cur_trgovina INTO _idTrgovina;
      FETCH cur_sestavina INTO _idSestavina;
      
      SET j = 0;
      
      WHILE j < stevilo DO
        
		INSERT INTO TrgovinaImaSestavino (idSestavina, idTrgovina) values (_idSestavina, _idTrgovina);
        
        SET j = j + 1;
      END WHILE;

      SET i = i + 1;
    END WHILE;
    
    COMMIT;
    
	CLOSE cur_trgovina;
    CLOSE cur_sestavina;

  END!!
  
DROP PROCEDURE IF EXISTS `PopulateProizvajalecImaSestavino`!!
CREATE PROCEDURE `PopulateProizvajalecImaSestavino`(IN stevilo INT)
  BEGIN
    DECLARE i INT;
    DECLARE j INT;
    DECLARE _idSestavina INT;
    DECLARE _idProizvajalec INT;
    
    DECLARE cur_proizvajalec CURSOR FOR SELECT id FROM Proizvajalec;
    DECLARE cur_sestavina CURSOR FOR SELECT id FROM Sestavina;
    
    OPEN cur_proizvajalec;
    OPEN cur_sestavina;

    SET i = 0;
	SET j = 0;
    
    START TRANSACTION;

    WHILE i < stevilo DO
      
      FETCH cur_proizvajalec INTO _idProizvajalec;
      FETCH cur_sestavina INTO _idSestavina;
      
      SET j = 0;
      
      WHILE j < stevilo DO 

		INSERT INTO ProizvajalecImaSestavino (idSestavina, idProizvajalec) values (_idSestavina, _idProizvajalec);
		
        SET j = j + 1;
        
      END WHILE;
	
      SET i = i + 1;      
    END WHILE;
    
    COMMIT;

	CLOSE cur_proizvajalec;
    CLOSE cur_sestavina;
    
  END!!
  
  DROP PROCEDURE IF EXISTS `PopulateRecept`!!
CREATE PROCEDURE `PopulateRecept`(IN stevilo INT)
  BEGIN
    DECLARE i INT;
    DECLARE _idJed INT;
    DECLARE _idCasKuhanja INT;
    DECLARE _idCasPriprave INT;
    DECLARE _postopek VARCHAR(2500);
    DECLARE _komentar VARCHAR(2500);
    DECLARE _idVir INT;
    
    
    DECLARE cur_jed CURSOR FOR SELECT id FROM Jed;
    DECLARE cur_cas_kuhanja CURSOR FOR SELECT id FROM CasKuhanja;
	DECLARE cur_cas_priprave CURSOR FOR SELECT id FROM CasPriprave;
    DECLARE cur_vir CURSOR FOR SELECT id FROM Vir;
    
    OPEN cur_jed;
    OPEN cur_cas_kuhanja;
	OPEN cur_cas_priprave;
    OPEN cur_vir;

    SET i = 0;
    
    START TRANSACTION;

    WHILE i < stevilo DO
      
      FETCH cur_jed INTO _idJed;
      FETCH cur_cas_kuhanja INTO _idCasKuhanja;
	  FETCH cur_cas_priprave INTO _idCasPriprave;
      FETCH cur_vir INTO _idVir;
      
      SET _postopek = CONCAT('Postopek', FLOOR(RAND() * (999) + 1));
      SET _komentar = CONCAT('Komentar', FLOOR(RAND() * (999) + 1));

      INSERT INTO Recept (idJed, idCasKuhanja, idCasPriprave, postopek, komentar, idVir) values (_idJed, _idCasKuhanja, _idCasPriprave, _postopek, _komentar, _idVir);

      SET i = i + 1;
    END WHILE;
    
    COMMIT;

    CLOSE cur_jed;
    CLOSE cur_cas_kuhanja;
	CLOSE cur_cas_priprave;
    CLOSE cur_vir; 
    
  END!!

DROP PROCEDURE IF EXISTS `PopulateReceptImaSestavino`!!
CREATE PROCEDURE `PopulateReceptImaSestavino`(IN stevilo INT)
  BEGIN
    DECLARE i INT;
    DECLARE j INT;
    DECLARE _idSestavina INT;
    DECLARE _idRecept INT;
    DECLARE _kolicina DECIMAL(10,2);
    DECLARE _enota VARCHAR(45);
    
    DECLARE cur_recept CURSOR FOR SELECT id FROM Recept;
    DECLARE cur_sestavina CURSOR FOR SELECT id FROM Sestavina;
    
    OPEN cur_recept;
    OPEN cur_sestavina;

    SET i = 0;
	SET j = 0;
    
    START TRANSACTION;
    
    WHILE i < stevilo DO
      
      FETCH cur_recept INTO _idRecept;
      FETCH cur_sestavina INTO _idSestavina;
      
      SET j = 0;
      
      WHILE j < stevilo DO 
      
		SET _kolicina = FLOOR(RAND() * (999) + 1);
		SET _enota = CONCAT('Enota', FLOOR(RAND() * (999) + 1));
	
		INSERT INTO ReceptImaSestavino (idSestavina, idRecept, kolicina, enota) values (_idSestavina, _idRecept, _kolicina, _enota);

		SET j = j + 1;
      END WHILE;
      
      SET i = i + 1;
      
    END WHILE;
    
    COMMIT;

    CLOSE cur_recept;

  END!!

DELIMITER ;

CALL PopulateCena(1000);
CALL PopulateNaslov(1000);
CALL PopulateJed(1000);
CALL PopulateOseba(1000);
CALL PopulateJedilnik(1000);
CALL PopulateCasovnaEnota(1000);
CALL PopulateSestavina(1000);
CALL PopulateTrgovina(1000);
CALL PopulateProizvajalec(1000);
CALL PopulateVir(1000);
CALL PopulateCasKuhanja(1000);
CALL PopulateCasPriprave(1000);
CALL PopulateJedilnikImaJed(1000);
CALL PopulateJedilnikImaOsebo(1000);
CALL PopulateTrgovinaImaSestavino(1000);
CALL PopulateRecept(1000);
CALL PopulateProizvajalecImaSestavino(1000);
CALL PopulateReceptImaSestavino(1000);


SELECT j.naziv, COUNT(ris.idSestavina) AS Stevilo_sestavin_v_receptu FROM ReceptImaSestavino ris
JOIN Recept r ON r.id = ris.idRecept
JOIN Jed j ON r.idJed = j.id
WHERE j.vrsta LIKE '%sta%' AND j.vrsta LIKE '%7'
GROUP BY ris.idSestavina
HAVING Stevilo_sestavin_v_receptu = (SELECT MAX(Stevilo_sestavin_v_receptu) 
FROM (SELECT COUNT(idSestavina) AS Stevilo_sestavin_v_receptu 
FROM ReceptImaSestavino 
GROUP BY idSestavina) AS steviloSestavin);

SELECT j.naziv, r.id, SUM(c.cena) AS Cena_jedi, c.valuta AS Valuta FROM Cena c
JOIN Sestavina s ON s.idCena=c.id
JOIN ReceptImaSestavino ris ON ris.idSestavina=s.id
JOIN Recept r ON ris.idRecept = r.id
JOIN Jed j ON r.idJed=j.id
WHERE j.vrsta LIKE '%st%' AND j.vrsta LIKE '%7'
GROUP BY ris.idRecept
HAVING Cena_jedi < (SELECT AVG(Cena_jedi)
FROM (SELECT SUM(cena) AS Cena_jedi FROM Cena c 
JOIN Sestavina s ON s.idCena=c.id
JOIN ReceptImaSestavino ris ON ris.idSestavina=s.id
JOIN Recept r ON ris.idRecept = r.id
JOIN Jed j ON r.idJed=j.id
GROUP BY ris.idRecept) AS cena);

SELECT o.id, o.ime, o.priimek, COUNT(r.idVir) AS Stevilo_receptov FROM Recept r right
JOIN Vir v ON r.idVir=v.id
JOIN Oseba o ON v.idAvtor=o.id
WHERE EXISTS (SELECT * FROM Jed j WHERE r.idJed = j.id AND j.vrsta LIKE '%st%' AND j.vrsta LIKE '%7')
GROUP BY o.priimek;

SELECT t.naziv, n.ulica, n.hisnaStevilka, n.kraj, COUNT(tis.idSestavina) AS Stevilo_sestavin FROM TrgovinaImaSestavino tis
JOIN Trgovina t ON tis.idTrgovina=t.id
JOIN Naslov n ON t.idNaslov=n.id
WHERE n.hisnaStevilka < 40 AND n.kraj LIKE 'Kraj%'
GROUP BY tis.idSestavina
HAVING Stevilo_sestavin = (SELECT MAX(Stevilo_sestavin) 
FROM (SELECT COUNT(idSestavina) AS Stevilo_sestavin FROM TrgovinaImaSestavino GROUP BY idSestavina) AS SteviloSestavin);

SELECT DISTINCT n.* FROM Naslov n
INNER JOIN Trgovina t ON t.idNaslov=n.id
INNER JOIN Proizvajalec p ON p.idNaslov=n.id
JOIN TrgovinaImaSestavino tis ON tis.idTrgovina=t.id
JOIN ProizvajalecImaSestavino pis ON pis.idProizvajalec=p.id
JOIN Sestavina s ON tis.idSestavina=s.id AND pis.idSestavina=s.id
JOIN ReceptImaSestavino ris ON ris.idSestavina=s.id
WHERE ris.kolicina < 200 AND s.naziv LIKE '%4';

SELECT DISTINCT t.naziv FROM Trgovina t
JOIN TrgovinaImaSestavino tis ON tis.idTrgovina=t.id
JOIN Sestavina s ON tis.idSestavina=s.id
JOIN ReceptImaSestavino ris ON ris.idSestavina=s.id
JOIN Recept r ON ris.idRecept=r.id
JOIN Jed j ON r.idJed=j.id
WHERE j.naziv LIKE 'Naziv615';

SELECT j.naziv, r.id, SUM(c.cena) AS Cena_jedi, c.valuta AS Valuta FROM Cena c
JOIN Sestavina s ON s.idCena=c.id
JOIN ReceptImaSestavino ris ON ris.idSestavina=s.id
JOIN Recept r ON ris.idRecept = r.id
JOIN Jed j ON r.idJed=j.id
WHERE j.naziv LIKE 'Naziv831'
GROUP BY ris.idRecept;

SELECT r.* FROM Recept r
JOIN Vir v ON r.idVir=v.id
WHERE v.naziv LIKE '%96';

SELECT s.naziv AS Ime_sestavine FROM Sestavina s 
JOIN ReceptImaSestavino ris ON ris.idSestavina=s.id
JOIN Recept r ON ris.idRecept=r.id
JOIN Jed j ON r.idJed=j.id
JOIN JedilnikImaJed jij ON jij.idJed=j.id
JOIN Jedilnik je ON jij.idJedilnik=je.id
WHERE je.cas = '2018-11-20 11:56:37';


CREATE INDEX vrstaJedi ON Jed(vrsta);
CREATE INDEX kolicinaSestavine ON ReceptImaSestavino(kolicina);
CREATE INDEX nazivJedi ON Jed(naziv);
CREATE INDEX hisnaStevilkaStavbe ON Naslov(hisnaStevilka);
CREATE INDEX krajNaslova ON Naslov(kraj);

SELECT j.naziv, COUNT(ris.idSestavina) AS Stevilo_sestavin_v_receptu FROM ReceptImaSestavino ris
JOIN Recept r ON r.id = ris.idRecept
JOIN Jed j ON r.idJed = j.id
WHERE j.vrsta LIKE '%sta%' AND j.vrsta LIKE '%7'
GROUP BY ris.idSestavina
HAVING Stevilo_sestavin_v_receptu = (SELECT MAX(Stevilo_sestavin_v_receptu) 
FROM (SELECT COUNT(idSestavina) AS Stevilo_sestavin_v_receptu 
FROM ReceptImaSestavino 
GROUP BY idSestavina) AS steviloSestavin);

SELECT j.naziv, r.id, SUM(c.cena) AS Cena_jedi, c.valuta AS Valuta FROM Cena c
JOIN Sestavina s ON s.idCena=c.id
JOIN ReceptImaSestavino ris ON ris.idSestavina=s.id
JOIN Recept r ON ris.idRecept = r.id
JOIN Jed j ON r.idJed=j.id
WHERE j.vrsta LIKE '%st%' AND j.vrsta LIKE '%7'
GROUP BY ris.idRecept
HAVING Cena_jedi < (SELECT AVG(Cena_jedi)
FROM (SELECT SUM(cena) AS Cena_jedi FROM Cena c 
JOIN Sestavina s ON s.idCena=c.id
JOIN ReceptImaSestavino ris ON ris.idSestavina=s.id
JOIN Recept r ON ris.idRecept = r.id
JOIN Jed j ON r.idJed=j.id
GROUP BY ris.idRecept) AS cena);

SELECT o.id, o.ime, o.priimek, COUNT(r.idVir) AS Stevilo_receptov FROM Recept r right
JOIN Vir v ON r.idVir=v.id
JOIN Oseba o ON v.idAvtor=o.id
WHERE EXISTS (SELECT * FROM Jed j WHERE r.idJed = j.id AND j.vrsta LIKE '%st%' AND j.vrsta LIKE '%7')
GROUP BY o.priimek;

SELECT t.naziv, n.ulica, n.hisnaStevilka, n.kraj, COUNT(tis.idSestavina) AS Stevilo_sestavin FROM TrgovinaImaSestavino tis
JOIN Trgovina t ON tis.idTrgovina=t.id
JOIN Naslov n ON t.idNaslov=n.id
WHERE n.hisnaStevilka < 40 AND n.kraj LIKE 'Kraj%'
GROUP BY tis.idSestavina
HAVING Stevilo_sestavin = (SELECT MAX(Stevilo_sestavin) 
FROM (SELECT COUNT(idSestavina) AS Stevilo_sestavin FROM TrgovinaImaSestavino GROUP BY idSestavina) AS SteviloSestavin);

SELECT DISTINCT n.* FROM Naslov n
INNER JOIN Trgovina t ON t.idNaslov=n.id
INNER JOIN Proizvajalec p ON p.idNaslov=n.id
JOIN TrgovinaImaSestavino tis ON tis.idTrgovina=t.id
JOIN ProizvajalecImaSestavino pis ON pis.idProizvajalec=p.id
JOIN Sestavina s ON tis.idSestavina=s.id AND pis.idSestavina=s.id
JOIN ReceptImaSestavino ris ON ris.idSestavina=s.id
WHERE ris.kolicina < 200 AND s.naziv LIKE '%4';

SELECT DISTINCT t.naziv FROM Trgovina t
JOIN TrgovinaImaSestavino tis ON tis.idTrgovina=t.id
JOIN Sestavina s ON tis.idSestavina=s.id
JOIN ReceptImaSestavino ris ON ris.idSestavina=s.id
JOIN Recept r ON ris.idRecept=r.id
JOIN Jed j ON r.idJed=j.id
WHERE j.naziv LIKE 'Naziv615';

SELECT j.naziv, r.id, SUM(c.cena) AS Cena_jedi, c.valuta AS Valuta FROM Cena c
JOIN Sestavina s ON s.idCena=c.id
JOIN ReceptImaSestavino ris ON ris.idSestavina=s.id
JOIN Recept r ON ris.idRecept = r.id
JOIN Jed j ON r.idJed=j.id
WHERE j.naziv LIKE 'Naziv831'
GROUP BY ris.idRecept;

SELECT r.* FROM Recept r
JOIN Vir v ON r.idVir=v.id
WHERE v.naziv LIKE '%96';

SELECT s.naziv AS Ime_sestavine FROM Sestavina s 
JOIN ReceptImaSestavino ris ON ris.idSestavina=s.id
JOIN Recept r ON ris.idRecept=r.id
JOIN Jed j ON r.idJed=j.id
JOIN JedilnikImaJed jij ON jij.idJed=j.id
JOIN Jedilnik je ON jij.idJedilnik=je.id
WHERE je.cas = '2018-11-20 11:56:37';



