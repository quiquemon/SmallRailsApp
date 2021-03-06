-- MySQL Script generated by MySQL Workbench
-- 01/13/17 15:31:36
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema smallrailsapp
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `smallrailsapp` ;

-- -----------------------------------------------------
-- Schema smallrailsapp
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `smallrailsapp` DEFAULT CHARACTER SET utf8 ;
USE `smallrailsapp` ;

-- -----------------------------------------------------
-- Table `smallrailsapp`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smallrailsapp`.`User` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `lastname` VARCHAR(100) NOT NULL,
  `birthday` DATE NOT NULL,
  `email` VARCHAR(70) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `newsletter` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smallrailsapp`.`Team`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smallrailsapp`.`Team` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(100) NULL,
  `memberNumber` INT NOT NULL,
  `creationDate` DATE NOT NULL,
  `code` VARCHAR(80) NULL,
  `idUserOwner` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Team_User1_idx` (`idUserOwner` ASC),
  CONSTRAINT `fk_Team_User1`
    FOREIGN KEY (`idUserOwner`)
    REFERENCES `smallrailsapp`.`User` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smallrailsapp`.`RunnerNumber`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smallrailsapp`.`RunnerNumber` (
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smallrailsapp`.`UserTeam`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smallrailsapp`.`UserTeam` (
  `idUser` INT NOT NULL,
  `idTeam` INT NOT NULL,
  `serial` VARCHAR(45) NULL,
  `idRunnerNumber` INT NULL,
  PRIMARY KEY (`idUser`, `idTeam`),
  INDEX `fk_User_has_Team_Team1_idx` (`idTeam` ASC),
  INDEX `fk_User_has_Team_User_idx` (`idUser` ASC),
  INDEX `fk_UserTeam_RunnerNumber1_idx` (`idRunnerNumber` ASC),
  CONSTRAINT `fk_User_has_Team_User`
    FOREIGN KEY (`idUser`)
    REFERENCES `smallrailsapp`.`User` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_User_has_Team_Team1`
    FOREIGN KEY (`idTeam`)
    REFERENCES `smallrailsapp`.`Team` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_UserTeam_RunnerNumber1`
    FOREIGN KEY (`idRunnerNumber`)
    REFERENCES `smallrailsapp`.`RunnerNumber` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smallrailsapp`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smallrailsapp`.`Payment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status` TINYINT(1) NOT NULL,
  `transaction` VARCHAR(45) NOT NULL,
  `amount` DECIMAL(15,2) NOT NULL,
  `completed` DATE NOT NULL,
  `idTeam` INT NOT NULL,
  PRIMARY KEY (`id`, `idTeam`),
  INDEX `fk_Payment_Team1_idx` (`idTeam` ASC),
  CONSTRAINT `fk_Payment_Team1`
    FOREIGN KEY (`idTeam`)
    REFERENCES `smallrailsapp`.`Team` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
