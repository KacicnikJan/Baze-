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

