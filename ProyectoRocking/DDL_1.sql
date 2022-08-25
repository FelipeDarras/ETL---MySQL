
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


--  Proyecto Rocking
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `proyectorocking` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `proyectorocking` ;



CREATE TABLE IF NOT EXISTS `proyectorocking`.`actor_groups` (
  `actorGroupId` INT NOT NULL AUTO_INCREMENT,
  `actorGroups` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`actorGroupId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;



CREATE TABLE IF NOT EXISTS `proyectorocking`.`actor_table` (
  `actorId` INT NOT NULL AUTO_INCREMENT,
  `actorGroupId` INT NULL DEFAULT NULL,
  `actor` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`actorId`),
  INDEX `actorGroupId` (`actorGroupId` ASC),
  CONSTRAINT `actor_table_ibfk_1`
    FOREIGN KEY (`actorGroupId`)
    REFERENCES `proyectorocking`.`actor_groups` (`actorGroupId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;



CREATE TABLE IF NOT EXISTS `proyectorocking`.`category_table` (
  `categoryId` INT NOT NULL AUTO_INCREMENT,
  `category` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`categoryId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;



CREATE TABLE IF NOT EXISTS `proyectorocking`.`country_groups` (
  `countryGroupId` INT NOT NULL AUTO_INCREMENT,
  `countryGroups` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`countryGroupId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;



CREATE TABLE IF NOT EXISTS `proyectorocking`.`country_table` (
  `countryId` INT NOT NULL AUTO_INCREMENT,
  `countryGroupId` INT NULL DEFAULT NULL,
  `country` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`countryId`),
  INDEX `countryGroupId` (`countryGroupId` ASC),
  CONSTRAINT `country_table_ibfk_1`
    FOREIGN KEY (`countryGroupId`)
    REFERENCES `proyectorocking`.`country_groups` (`countryGroupId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;



CREATE TABLE IF NOT EXISTS `proyectorocking`.`director_groups` (
  `directorGroupId` INT NOT NULL AUTO_INCREMENT,
  `directorGroups` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`directorGroupId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;



CREATE TABLE IF NOT EXISTS `proyectorocking`.`director_table` (
  `directorId` INT NOT NULL AUTO_INCREMENT,
  `directorGroupId` INT NULL DEFAULT NULL,
  `director` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`directorId`),
  INDEX `directorGroupId` (`directorGroupId` ASC),
  CONSTRAINT `director_table_ibfk_1`
    FOREIGN KEY (`directorGroupId`)
    REFERENCES `proyectorocking`.`director_groups` (`directorGroupId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;



CREATE TABLE IF NOT EXISTS `proyectorocking`.`main_table` (
  `show_id` INT NOT NULL AUTO_INCREMENT,
  `type` TEXT NULL DEFAULT NULL,
  `title` TEXT NULL DEFAULT NULL,
  `directorGroupId` INT NULL DEFAULT NULL,
  `actorGroupId` INT NULL DEFAULT NULL,
  `countryGroupId` INT NULL DEFAULT NULL,
  `date_added` DATETIME NULL DEFAULT NULL,
  `release_year` TEXT NULL DEFAULT NULL,
  `rating` TEXT NULL DEFAULT NULL,
  `duration` TEXT NULL DEFAULT NULL,
  `categoryId` INT NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `platform` TEXT NOT NULL,
  PRIMARY KEY (`show_id`),
  INDEX `directorGroupId` (`directorGroupId` ASC) ,
  INDEX `countryGroupId` (`countryGroupId` ASC) ,
  INDEX `categoryId` (`categoryId` ASC) ,
  CONSTRAINT `main_table_ibfk_1`
    FOREIGN KEY (`directorGroupId`)
    REFERENCES `proyectorocking`.`director_groups` (`directorGroupId`),
  CONSTRAINT `main_table_ibfk_2`
    FOREIGN KEY (`directorGroupId`)
    REFERENCES `proyectorocking`.`actor_groups` (`actorGroupId`),
  CONSTRAINT `main_table_ibfk_3`
    FOREIGN KEY (`countryGroupId`)
    REFERENCES `proyectorocking`.`country_groups` (`countryGroupId`),
  CONSTRAINT `main_table_ibfk_4`
    FOREIGN KEY (`categoryId`)
    REFERENCES `proyectorocking`.`category_table` (`categoryId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;