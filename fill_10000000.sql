
DELIMITER !!

DROP PROCEDURE IF EXISTS `PopulateNaslov`!!
CREATE PROCEDURE `PopulateNaslov`(IN stevilo INT)
  BEGIN
    
  
    DECLARE i INT;
    DECLARE _ulica VARCHAR(80);
    DECLARE _hisnaStevilka INT;
    DECLARE _kraj VARCHAR(80);
    DECLARE _drzava VARCHAR(80);

    SET i = 0;
    

    WHILE i < stevilo DO
      
      SET _ulica = CONCAT('Ulica', FLOOR(RAND() * (999) + 1));
      SET _hisnaStevilka = FLOOR(RAND() * (50) + 1);
      SET _kraj = CONCAT('Kraj', FLOOR(RAND() * (999) + 1));
      SET _drzava = CONCAT('Drzava', FLOOR(RAND() * (999) + 1));
      
      INSERT INTO Naslov (ulica, hisnaStevilka, kraj, drzava) values (_ulica, _hisnaStevilka, _kraj, _drzava);

      SET i = i + 1;
    END WHILE;

  END!!

DROP PROCEDURE IF EXISTS `PopulateTrgovina`!!
CREATE PROCEDURE `PopulateTrgovina`(IN stevilo INT)
  BEGIN
    DECLARE i INT;
    DECLARE j INT;
    DECLARE _naziv VARCHAR(50);
    DECLARE _idNaslov INT;
    
    DECLARE cur_naslov CURSOR FOR SELECT id FROM Naslov;
    
    OPEN cur_naslov;

    SET i = 0;

	START TRANSACTION;
    
    WHILE i < stevilo DO
      
      FETCH cur_naslov INTO _idNaslov;
      
	  SET j = 0;
      
      WHILE j < stevilo DO
	
		SET _naziv = CONCAT('Trgovina', FLOOR(RAND() * (999) + 1));
        
		INSERT INTO Trgovina (naziv, idNaslov) values (_naziv, _idNaslov);
         
		SET j = j + 1; 
      END WHILE;


      SET i = i + 1;
    END WHILE;
    
    COMMIT;
    
    CLOSE cur_naslov;

  END!!
  
  DELIMITER ;
  
/* --- Start with index --- */   

CREATE  INDEX nazivTrgovine ON Trgovina(naziv);

CALL PopulateNaslov(10000000);
CALL PopulateTrgovina(10000000);
SELECT * FROM Trgovina t WHERE t.nazivTrgovine LIKE 'Trgo%' AND t.nazivTrgovine LIKE '89%';
UPDATE Trgovina t SET t.naziv = CONCAT('NovaTrgovina', FLOOR(RAND() * (999) + 1)) WHERE t.idNaslov < 20; 
DELETE FROM Trgovina;
DELETE FROM Naslov;

DROP INDEX nazivTrgovine ON Trgovina;

/* --- End with index --- */ 
  
/* --- Start with constraint --- */

CALL PopulateNaslov(10000000);
CALL PopulateTrgovina(10000000);
SELECT * FROM Trgovina t WHERE t.idNaslov % 2 = 0;
UPDATE Trgovina t SET t.naziv = CONCAT('NovaTrgovina', FLOOR(RAND() * (999) + 1)) WHERE t.idNaslov < 20; 
DELETE FROM Trgovina;
DELETE FROM Naslov;

/* --- End with constraint --- */

/* --- Start without constraint --- */

ALTER TABLE Trgovina DROP FOREIGN KEY FK_naslov_trgovine;

CALL PopulateNaslov(10000000);
CALL PopulateTrgovina(10000000);
SELECT * FROM Trgovina t WHERE t.idNaslov % 2 = 0;
UPDATE Trgovina t SET t.naziv = CONCAT('NovaTrgovina', FLOOR(RAND() * (999) + 1)) WHERE t.idNaslov < 20; 
DELETE FROM Trgovina;
DELETE FROM Naslov;

/* --- End without constraint --- */
