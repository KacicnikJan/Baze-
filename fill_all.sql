DROP TABLE IF EXISTS Trgovina;
DROP TABLE IF EXISTS Naslov;

CREATE TABLE Naslov(
    id INT NOT NULL,
    ulica VARCHAR(80) NOT NULL,
    hisnaStevilka INT NOT NULL,
    kraj VARCHAR(80) NOT NULL,
    drzava VARCHAR(80) NOT NULL
);

CREATE TABLE Trgovina(
    id INT NOT NULL,
    naziv VARCHAR(80) NOT NULL,
    idNaslov INT NOT NULL
);

ALTER TABLE Naslov ADD CONSTRAINT PK_naslov PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;
ALTER TABLE Trgovina ADD CONSTRAINT PK_trgovina PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;
ALTER TABLE Trgovina ADD CONSTRAINT FK_naslov_trgovine FOREIGN KEY(idNaslov) REFERENCES Naslov(id) ON DELETE CASCADE ON UPDATE CASCADE;

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
      
      FETCH cur_naslov INTO _idNaslov;
      
	  SET _naziv = CONCAT('Trgovina', FLOOR(RAND() * (999) + 1));
        
	  INSERT INTO Trgovina (naziv, idNaslov) values (_naziv, _idNaslov);

      SET i = i + 1;
    END WHILE;
    
    COMMIT;
    
    CLOSE cur_naslov;

  END!!
  
  DELIMITER ;
  
/* --- Start with index --- */   

CREATE INDEX nazivTrgovine ON Trgovina(naziv);

CALL PopulateNaslov(100);
CALL PopulateTrgovina(100);
EXPLAIN SELECT * FROM Trgovina t WHERE t.naziv LIKE 'Trgo%' AND t.naziv LIKE '%89';
EXPLAIN UPDATE Trgovina t SET t.naziv = CONCAT('NovaTrgovina', FLOOR(RAND() * (999) + 1)) WHERE t.naziv LIKE '%89'; 
EXPLAIN DELETE FROM Trgovina;
EXPLAIN DELETE FROM Naslov;

DROP INDEX nazivTrgovine ON Trgovina;

/* --- End with index --- */ 
  
/* --- Start with constraint --- */

CALL PopulateNaslov(100);
CALL PopulateTrgovina(100);
EXPLAIN SELECT * FROM Trgovina t WHERE t.naziv LIKE 'Trgo%' AND t.naziv LIKE '%89';
EXPLAIN UPDATE Trgovina t SET t.naziv = CONCAT('NovaTrgovina', FLOOR(RAND() * (999) + 1)) WHERE t.naziv LIKE '%89'; 
EXPLAIN DELETE FROM Trgovina;
EXPLAIN DELETE FROM Naslov;

/* --- End with constraint --- */

/* --- Start without constraint --- */

ALTER TABLE Trgovina DROP FOREIGN KEY FK_naslov_trgovine;

CALL PopulateNaslov(100);
CALL PopulateTrgovina(100);
EXPLAIN SELECT * FROM Trgovina t WHERE t.naziv LIKE 'Trgo%' AND t.naziv LIKE '%89';
EXPLAIN UPDATE Trgovina t SET t.naziv = CONCAT('NovaTrgovina', FLOOR(RAND() * (999) + 1)) WHERE t.naziv LIKE '%89'; 
EXPLAIN DELETE FROM Trgovina;
EXPLAIN DELETE FROM Naslov;

/* --- End without constraint --- */

/*ALTER TABLE Trgovina ADD CONSTRAINT FK_naslov_trgovine FOREIGN KEY(idNaslov) REFERENCES Naslov(id) ON DELETE CASCADE ON UPDATE CASCADE;*/
  
/* --- Start with index --- */   

/*CREATE  INDEX nazivTrgovine ON Trgovina(naziv);

CALL PopulateNaslov(1000000);
CALL PopulateTrgovina(1000000);
EXPLAIN SELECT * FROM Trgovina t WHERE t.naziv LIKE 'Trgo%' AND t.naziv LIKE '%89';
EXPLAIN UPDATE Trgovina t SET t.naziv = CONCAT('NovaTrgovina', FLOOR(RAND() * (999) + 1)) WHERE t.naziv LIKE '%89'; 
EXPLAIN DELETE FROM Trgovina;
EXPLAIN DELETE FROM Naslov;

DROP INDEX nazivTrgovine ON Trgovina;*/

/* --- End with index --- */ 
  
/* --- Start with constraint --- */

/*CALL PopulateNaslov(1000000);
CALL PopulateTrgovina(1000000);
SELECT * FROM Trgovina t WHERE t.naziv LIKE 'Trgo%' AND t.naziv LIKE '%89';
UPDATE Trgovina t SET t.naziv = CONCAT('NovaTrgovina', FLOOR(RAND() * (999) + 1)) WHERE t.naziv LIKE '%89'; 
DELETE FROM Trgovina;
DELETE FROM Naslov;*/

/* --- End with constraint --- */

/* --- Start without constraint --- */

/*ALTER TABLE Trgovina DROP FOREIGN KEY FK_naslov_trgovine;

CALL PopulateNaslov(1000000);
CALL PopulateTrgovina(1000000);
SELECT * FROM Trgovina t WHERE t.naziv LIKE 'Trgo%' AND t.naziv LIKE '%89';
UPDATE Trgovina t SET t.naziv = CONCAT('NovaTrgovina', FLOOR(RAND() * (999) + 1)) WHERE t.naziv LIKE '%89'; 
DELETE FROM Trgovina;
DELETE FROM Naslov;*/

/* --- End without constraint --- */

/*ALTER TABLE Trgovina ADD CONSTRAINT FK_naslov_trgovine FOREIGN KEY(idNaslov) REFERENCES Naslov(id) ON DELETE CASCADE ON UPDATE CASCADE;*/ 
  
/* --- Start with index --- */   

/*CREATE  INDEX nazivTrgovine ON Trgovina(naziv);

CALL PopulateNaslov(1000000);
CALL PopulateNaslov(1000000);
CALL PopulateNaslov(1000000);
CALL PopulateNaslov(1000000);
CALL PopulateNaslov(1000000);
CALL PopulateNaslov(1000000);
CALL PopulateNaslov(1000000);
CALL PopulateNaslov(1000000);
CALL PopulateNaslov(1000000);
CALL PopulateNaslov(1000000);

CALL PopulateTrgovina(1000000);
CALL PopulateTrgovina(1000000);
CALL PopulateTrgovina(1000000);
CALL PopulateTrgovina(1000000);
CALL PopulateTrgovina(1000000);
CALL PopulateTrgovina(1000000);
CALL PopulateTrgovina(1000000);
CALL PopulateTrgovina(1000000);
CALL PopulateTrgovina(1000000);
CALL PopulateTrgovina(1000000);

SELECT * FROM Trgovina t WHERE t.naziv LIKE 'Trgo%' AND t.naziv LIKE '%89';
UPDATE Trgovina t SET t.naziv = CONCAT('NovaTrgovina', FLOOR(RAND() * (999) + 1)) WHERE t.naziv LIKE '%89'; 
DELETE FROM Trgovina;
DELETE FROM Naslov;

DROP INDEX nazivTrgovine ON Trgovina;*/

/* --- End with index --- */ 
  
/* --- Start with constraint --- */

/*CALL PopulateNaslov(1000000);
CALL PopulateNaslov(1000000);
CALL PopulateNaslov(1000000);
CALL PopulateNaslov(1000000);
CALL PopulateNaslov(1000000);
CALL PopulateNaslov(1000000);
CALL PopulateNaslov(1000000);
CALL PopulateNaslov(1000000);
CALL PopulateNaslov(1000000);
CALL PopulateNaslov(1000000);

CALL PopulateTrgovina(1000000);
CALL PopulateTrgovina(1000000);
CALL PopulateTrgovina(1000000);
CALL PopulateTrgovina(1000000);
CALL PopulateTrgovina(1000000);
CALL PopulateTrgovina(1000000);
CALL PopulateTrgovina(1000000);
CALL PopulateTrgovina(1000000);
CALL PopulateTrgovina(1000000);
CALL PopulateTrgovina(1000000);

SELECT * FROM Trgovina t WHERE t.naziv LIKE 'Trgo%' AND t.naziv LIKE '%89';
UPDATE Trgovina t SET t.naziv = CONCAT('NovaTrgovina', FLOOR(RAND() * (999) + 1)) WHERE t.naziv LIKE '%89'; 
DELETE FROM Trgovina;
DELETE FROM Naslov;*/

/* --- End with constraint --- */

/* --- Start without constraint --- */

/*ALTER TABLE Trgovina DROP FOREIGN KEY FK_naslov_trgovine;

CALL PopulateNaslov(1000000);
CALL PopulateNaslov(1000000);
CALL PopulateNaslov(1000000);
CALL PopulateNaslov(1000000);
CALL PopulateNaslov(1000000);
CALL PopulateNaslov(1000000);
CALL PopulateNaslov(1000000);
CALL PopulateNaslov(1000000);
CALL PopulateNaslov(1000000);
CALL PopulateNaslov(1000000);

CALL PopulateTrgovina(1000000);
CALL PopulateTrgovina(1000000);
CALL PopulateTrgovina(1000000);
CALL PopulateTrgovina(1000000);
CALL PopulateTrgovina(1000000);
CALL PopulateTrgovina(1000000);
CALL PopulateTrgovina(1000000);
CALL PopulateTrgovina(1000000);
CALL PopulateTrgovina(1000000);
CALL PopulateTrgovina(1000000);

SELECT * FROM Trgovina t WHERE t.naziv LIKE 'Trgo%' AND t.naziv LIKE '%89';
UPDATE Trgovina t SET t.naziv = CONCAT('NovaTrgovina', FLOOR(RAND() * (999) + 1)) WHERE t.naziv LIKE '%89'; 
DELETE FROM Trgovina;
DELETE FROM Naslov;*/

/* --- End without constraint --- */

