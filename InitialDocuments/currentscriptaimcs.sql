-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema aimcs
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema aimcs
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `aimcs` DEFAULT CHARACTER SET latin1 ;
USE `aimcs` ;

-- -----------------------------------------------------
-- Table `aimcs`.`aircraft_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aimcs`.`aircraft_type` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `IATA_CODE` VARCHAR(10) NOT NULL,
  `ICAO_CODE` VARCHAR(10) NOT NULL,
  `DESCRIPTION` VARCHAR(100) NOT NULL,
  `STATUS` VARCHAR(10) NOT NULL,
  `ADDED_DATE` DATE NOT NULL,
  `ADDED_BY` INT(11) NOT NULL,
  `LAST_MODIFIED` DATE NULL DEFAULT NULL,
  `MODIFIED_BY` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `aimcs`.`aircraft`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aimcs`.`aircraft` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `AIRCRAFT_REGISTRATION` VARCHAR(10) NOT NULL,
  `ICAO_BASE` VARCHAR(10) NOT NULL,
  `FIRST_FLOWN` DATE NOT NULL,
  `SERIAL_NO` VARCHAR(50) NOT NULL,
  `AIRCRAFT_HOURS` INT(11) NOT NULL,
  `MTOW` FLOAT NOT NULL,
  `MLW` FLOAT NOT NULL,
  `MZFW` FLOAT NOT NULL,
  `CAPACITY` INT(11) NOT NULL,
  `OEW` FLOAT NOT NULL,
  `WING_TYPE` VARCHAR(20) NOT NULL,
  `FUEL_TYPE` VARCHAR(20) NOT NULL,
  `STATUS` VARCHAR(10) NOT NULL,
  `ADDED_DATE` DATE NOT NULL,
  `ADDED_BY` INT(11) NOT NULL,
  `LAST_MODIFIED` DATE NULL DEFAULT NULL,
  `MODIFIED_BY` INT(11) NULL DEFAULT NULL,
  `AIRCRAFT_TYPE_ID` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_AIRCRAFT_AIRCRAFT_TYPE_idx` (`AIRCRAFT_TYPE_ID` ASC),
  CONSTRAINT `fk_AIRCRAFT_AIRCRAFT_TYPE`
    FOREIGN KEY (`AIRCRAFT_TYPE_ID`)
    REFERENCES `aimcs`.`aircraft_type` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `aimcs`.`aircraft_configuration`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aimcs`.`aircraft_configuration` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `PILOTS` INT(11) NOT NULL,
  `CREW` INT(11) NOT NULL,
  `SEATS` INT(11) NOT NULL,
  `CARGO_LBS` FLOAT NOT NULL,
  `ENDURANCE_HRS` FLOAT NOT NULL,
  `COST_PER_HR_FLYING` FLOAT NOT NULL,
  `COST_PER_HR_GRND` FLOAT NOT NULL,
  `STATUS` VARCHAR(10) NOT NULL,
  `ADDED_DATE` DATETIME NOT NULL,
  `ADDED_BY` INT(11) NOT NULL,
  `LAST_MODIFIED` DATETIME NULL DEFAULT NULL,
  `MODIFIED_BY` INT(11) NULL DEFAULT NULL,
  `AIRCRAFT_ID` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_AIRCRAFT_CONFIGURATION_AIRCRAFT1_idx` (`AIRCRAFT_ID` ASC),
  CONSTRAINT `fk_AIRCRAFT_CONFIGURATION_AIRCRAFT1`
    FOREIGN KEY (`AIRCRAFT_ID`)
    REFERENCES `aimcs`.`aircraft` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `aimcs`.`document_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aimcs`.`document_type` (
  `ID` INT(11) NOT NULL,
  `DESCRIPTION` VARCHAR(200) NOT NULL,
  `STATUS` VARCHAR(10) NOT NULL,
  `ADDED_DATE` DATE NOT NULL,
  `ADDED_BY` INT(11) NOT NULL,
  `LAST_MODIFIED` DATE NULL DEFAULT NULL,
  `MODIFIED_BY` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `aimcs`.`aircraft_document`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aimcs`.`aircraft_document` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `DOCUMENT_PATH` VARCHAR(45) NOT NULL,
  `SUBJECT` VARCHAR(45) NOT NULL,
  `DOC_NO` VARCHAR(45) NULL DEFAULT NULL,
  `REFERED_TO` INT(11) NULL DEFAULT NULL,
  `DOCUMENT_DATE` VARCHAR(45) NULL DEFAULT NULL,
  `INITIATOR` INT(11) NULL DEFAULT NULL,
  `AMM_REF` VARCHAR(45) NULL DEFAULT NULL,
  `NTM_REF` VARCHAR(45) NULL DEFAULT NULL,
  `IPC_REF` VARCHAR(45) NULL DEFAULT NULL,
  `CMM_REF` VARCHAR(45) NULL DEFAULT NULL,
  `SM_REF` VARCHAR(45) NULL DEFAULT NULL,
  `DESCRIPTION` VARCHAR(200) NULL DEFAULT NULL,
  `document_type_ID` INT(11) NOT NULL,
  `aircraft_ID` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_aircraft_document_document_type1_idx` (`document_type_ID` ASC),
  INDEX `fk_aircraft_document_aircraft1_idx` (`aircraft_ID` ASC),
  CONSTRAINT `fk_aircraft_document_document_type1`
    FOREIGN KEY (`document_type_ID`)
    REFERENCES `aimcs`.`document_type` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_aircraft_document_aircraft1`
    FOREIGN KEY (`aircraft_ID`)
    REFERENCES `aimcs`.`aircraft` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `aimcs`.`aircraft_utilization`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aimcs`.`aircraft_utilization` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `MTHS_FIRST_FLOWN` INT(11) NOT NULL,
  `TOTAL_AIRFRAME_HRS` FLOAT NOT NULL,
  `TOTAL_AIRFRAME_LNDGS` INT(11) NOT NULL,
  `AVG_MONTHLY_HRS` FLOAT NOT NULL,
  `AVG_MONTLY_LNDGS` FLOAT NOT NULL,
  `FIRST_ENTRY_CURRENT_OP` DATE NOT NULL,
  `CURRENT_OP_MONTHS` INT(11) NOT NULL,
  `HRS_CURRENT_OP` FLOAT NOT NULL,
  `CURRENT_AVG_MTH_HRS` FLOAT NOT NULL,
  `CURRENT_AVG_MTH_LNDGS` FLOAT NOT NULL,
  `EST_MTH_HRS` FLOAT NOT NULL,
  `EST_MTH_LNDGS` INT(11) NOT NULL,
  `STATUS` VARCHAR(10) NOT NULL,
  `ADDED_DATE` DATE NOT NULL,
  `ADDED_BY` INT(11) NOT NULL,
  `LAST_MODIFIED` DATE NULL DEFAULT NULL,
  `MODIFIED_BY` INT(11) NULL DEFAULT NULL,
  `AIRCRAFT_ID` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_AIRCRAFT_UTILIZATION_AIRCRAFT1_idx` (`AIRCRAFT_ID` ASC),
  CONSTRAINT `fk_AIRCRAFT_UTILIZATION_AIRCRAFT1`
    FOREIGN KEY (`AIRCRAFT_ID`)
    REFERENCES `aimcs`.`aircraft` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `aimcs`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aimcs`.`country` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(45) NOT NULL,
  `2LetterCountryCode` VARCHAR(45) NOT NULL,
  `3LetterCountryCode` VARCHAR(45) NOT NULL,
  `REGION` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aimcs`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aimcs`.`city` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(45) NOT NULL,
  `CODE` VARCHAR(45) NOT NULL,
  `Country_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_CITY_Country1_idx` (`Country_ID` ASC),
  CONSTRAINT `fk_CITY_Country1`
    FOREIGN KEY (`Country_ID`)
    REFERENCES `aimcs`.`country` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aimcs`.`timezone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aimcs`.`timezone` (
  `ID` INT NOT NULL,
  `UTC` INT NOT NULL,
  `DESCRIPTION` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aimcs`.`contact_information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aimcs`.`contact_information` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `CONTACT_PERSON1` VARCHAR(100) NOT NULL,
  `CONTACT_PERSON2` VARCHAR(100) NULL DEFAULT NULL,
  `CONTACT_PERSON3` VARCHAR(100) NULL DEFAULT NULL,
  `ADDRESS1` VARCHAR(200) NOT NULL,
  `ADDRESS2` VARCHAR(200) NULL DEFAULT NULL,
  `ADDRESS3` VARCHAR(200) NULL DEFAULT NULL,
  `PHONE1` VARCHAR(25) NOT NULL,
  `PHONE2` VARCHAR(25) NULL DEFAULT NULL,
  `PHONE3` VARCHAR(25) NULL DEFAULT NULL,
  `FAX1` VARCHAR(25) NULL DEFAULT NULL,
  `FAX2` VARCHAR(25) NULL DEFAULT NULL,
  `FAX3` VARCHAR(25) NULL DEFAULT NULL,
  `EMAIL_ADDRESS1` VARCHAR(50) NULL DEFAULT NULL,
  `EMAIL_ADDRESS2` VARCHAR(50) NULL DEFAULT NULL,
  `EMAIL_ADDRESS3` VARCHAR(50) NULL DEFAULT NULL,
  `STATE` VARCHAR(30) NULL DEFAULT NULL,
  `COUNTRY_CODE` CHAR(3) NOT NULL,
  `CITY_CODE` CHAR(3) NOT NULL,
  `POST_ZIP_CODE` VARCHAR(20) NULL DEFAULT NULL,
  `HOME_PAGE` VARCHAR(100) NULL DEFAULT NULL,
  `TELEX1` VARCHAR(50) NULL DEFAULT NULL,
  `TELEX2` VARCHAR(50) NULL DEFAULT NULL,
  `TELEX3` VARCHAR(50) NULL DEFAULT NULL,
  `INTERNATIONAL` CHAR(1) NOT NULL DEFAULT 'N' COMMENT 'Y for yes and N for no',
  `STATUS` CHAR(1) NULL DEFAULT NULL,
  `ADDED_DATE` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ADDED_BY` INT(11) NOT NULL,
  `LAST_MODIFIED` TIMESTAMP NULL DEFAULT NULL,
  `MODIFIED_BY` INT(11) NULL DEFAULT NULL,
  `Country_ID` INT NOT NULL,
  `CITY_ID` INT NOT NULL,
  `TIMEZONE_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `PK_CONTACT_INFORMATION` (`ID` ASC),
  INDEX `fk_contact_information_Country1_idx` (`Country_ID` ASC),
  INDEX `fk_contact_information_CITY1_idx` (`CITY_ID` ASC),
  INDEX `fk_contact_information_TIMEZONE1_idx` (`TIMEZONE_ID` ASC),
  CONSTRAINT `fk_contact_information_Country1`
    FOREIGN KEY (`Country_ID`)
    REFERENCES `aimcs`.`country` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contact_information_CITY1`
    FOREIGN KEY (`CITY_ID`)
    REFERENCES `aimcs`.`city` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contact_information_TIMEZONE1`
    FOREIGN KEY (`TIMEZONE_ID`)
    REFERENCES `aimcs`.`timezone` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `aimcs`.`file`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aimcs`.`file` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `FILE_NO` VARCHAR(45) NOT NULL,
  `SUBJECT` VARCHAR(45) NOT NULL,
  `INITIATOR` VARCHAR(45) NOT NULL,
  `REFERER` VARCHAR(45) NOT NULL,
  `STATUS` VARCHAR(10) NOT NULL,
  `ADDED_DATE` DATE NOT NULL,
  `ADDED_BY` INT(11) NOT NULL,
  `LAST_MODIFIED` DATE NULL DEFAULT NULL,
  `MODIFIED_BY` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `aimcs`.`file_has_aircraft_document`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aimcs`.`file_has_aircraft_document` (
  `file_ID` INT(11) NOT NULL,
  `aircraft_document_ID` INT(11) NOT NULL,
  PRIMARY KEY (`file_ID`, `aircraft_document_ID`),
  INDEX `fk_file_has_aircraft_document_aircraft_document1_idx` (`aircraft_document_ID` ASC),
  INDEX `fk_file_has_aircraft_document_file1_idx` (`file_ID` ASC),
  CONSTRAINT `fk_file_has_aircraft_document_aircraft_document1`
    FOREIGN KEY (`aircraft_document_ID`)
    REFERENCES `aimcs`.`aircraft_document` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_file_has_aircraft_document_file1`
    FOREIGN KEY (`file_ID`)
    REFERENCES `aimcs`.`file` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `aimcs`.`file_movment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aimcs`.`file_movment` (
  `id` INT(11) NOT NULL,
  `sender` INT(11) NOT NULL,
  `reciever` INT(11) NOT NULL,
  `remarks` VARCHAR(100) NULL DEFAULT NULL,
  `status` VARCHAR(10) NOT NULL,
  `added_date` DATE NOT NULL,
  `added_by` INT(11) NOT NULL,
  `last_modified` DATE NULL DEFAULT NULL,
  `modified_by` INT(11) NULL DEFAULT NULL,
  `file_ID` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_file_movment_file1_idx` (`file_ID` ASC),
  CONSTRAINT `fk_file_movment_file1`
    FOREIGN KEY (`file_ID`)
    REFERENCES `aimcs`.`file` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `aimcs`.`seat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aimcs`.`seat` (
  `SEAT_ID` INT NOT NULL AUTO_INCREMENT,
  `SEAT_NO` VARCHAR(45) NOT NULL,
  `ROW` INT NOT NULL,
  `COL` CHAR(1) NOT NULL,
  `aircraft_ID` INT(11) NOT NULL,
  PRIMARY KEY (`SEAT_ID`),
  INDEX `fk_Seat_aircraft1_idx` (`aircraft_ID` ASC),
  CONSTRAINT `fk_Seat_aircraft1`
    FOREIGN KEY (`aircraft_ID`)
    REFERENCES `aimcs`.`aircraft` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aimcs`.`seatchart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aimcs`.`seatchart` (
  `SeatChartID` INT NOT NULL AUTO_INCREMENT,
  `ROWS` INT NOT NULL,
  `COLUMNS` VARCHAR(45) NOT NULL,
  `AISLE` VARCHAR(45) NOT NULL,
  `EMERGENCY_EXITS` VARCHAR(45) NOT NULL,
  `ZONES` VARCHAR(45) NOT NULL,
  `aircraft_ID` INT(11) NOT NULL,
  PRIMARY KEY (`SeatChartID`),
  INDEX `fk_SeatChart_aircraft1_idx` (`aircraft_ID` ASC),
  CONSTRAINT `fk_SeatChart_aircraft1`
    FOREIGN KEY (`aircraft_ID`)
    REFERENCES `aimcs`.`aircraft` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aimcs`.`seatchart_has_seat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aimcs`.`seatchart_has_seat` (
  `SeatChart_SeatChartID` INT NOT NULL,
  `Seat_SEAT_ID` INT NOT NULL,
  PRIMARY KEY (`SeatChart_SeatChartID`, `Seat_SEAT_ID`),
  INDEX `fk_SeatChart_has_Seat_Seat1_idx` (`Seat_SEAT_ID` ASC),
  INDEX `fk_SeatChart_has_Seat_SeatChart1_idx` (`SeatChart_SeatChartID` ASC),
  CONSTRAINT `fk_SeatChart_has_Seat_SeatChart1`
    FOREIGN KEY (`SeatChart_SeatChartID`)
    REFERENCES `aimcs`.`seatchart` (`SeatChartID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SeatChart_has_Seat_Seat1`
    FOREIGN KEY (`Seat_SEAT_ID`)
    REFERENCES `aimcs`.`seat` (`SEAT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aimcs`.`airport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aimcs`.`airport` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ICAO_CODE` VARCHAR(45) NOT NULL,
  `IATA_CODE` VARCHAR(45) NOT NULL,
  `CITY_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_AIRPORT_CITY1_idx` (`CITY_ID` ASC),
  CONSTRAINT `fk_AIRPORT_CITY1`
    FOREIGN KEY (`CITY_ID`)
    REFERENCES `aimcs`.`city` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aimcs`.`currency`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aimcs`.`currency` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(45) NOT NULL,
  `CODE` VARCHAR(45) NOT NULL,
  `Country_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_CURRENCY_Country1_idx` (`Country_ID` ASC),
  CONSTRAINT `fk_CURRENCY_Country1`
    FOREIGN KEY (`Country_ID`)
    REFERENCES `aimcs`.`country` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aimcs`.`exchange_rate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aimcs`.`exchange_rate` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `DATE_TO` VARCHAR(45) NOT NULL,
  `DATE_FROM` VARCHAR(45) NOT NULL,
  `RATE` VARCHAR(45) NOT NULL,
  `BASE_CURRENCY` INT NOT NULL,
  `CURRENCY` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_EXCHANGE_RATE_CURRENCY1_idx` (`BASE_CURRENCY` ASC),
  INDEX `fk_EXCHANGE_RATE_CURRENCY2_idx` (`CURRENCY` ASC),
  CONSTRAINT `fk_EXCHANGE_RATE_CURRENCY1`
    FOREIGN KEY (`BASE_CURRENCY`)
    REFERENCES `aimcs`.`currency` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EXCHANGE_RATE_CURRENCY2`
    FOREIGN KEY (`CURRENCY`)
    REFERENCES `aimcs`.`currency` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
