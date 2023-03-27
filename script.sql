-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema portfolio_valentina
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema portfolio_valentina
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `portfolio_valentina` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `portfolio_valentina` ;

-- -----------------------------------------------------
-- Table `portfolio_valentina`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio_valentina`.`users` (
  `id_users` INT NOT NULL AUTO_INCREMENT,
  `uidExtern` INT NOT NULL,
  `username` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `password` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  PRIMARY KEY (`id_users`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  UNIQUE INDEX `uidExtern_UNIQUE` (`uidExtern` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio_valentina`.`person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio_valentina`.`person` (
  `id_person` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) CHARACTER SET 'utf8' NOT NULL,
  `secondName` VARCHAR(45) CHARACTER SET 'utf8' NULL,
  `lastname` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `birthday` DATE NOT NULL,
  `aboutMe` VARCHAR(1000) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL,
  `photo` VARCHAR(500) NULL,
  `users_id_users` INT NOT NULL,
  PRIMARY KEY (`id_person`),
  INDEX `fk_person_users1_idx` (`users_id_users` ASC),
  CONSTRAINT `fk_person_users1`
    FOREIGN KEY (`users_id_users`)
    REFERENCES `portfolio_valentina`.`users` (`id_users`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio_valentina`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio_valentina`.`categories` (
  `id_categories` INT NOT NULL AUTO_INCREMENT,
  `nameCategories` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_categories`),
  UNIQUE INDEX `nameCategories_UNIQUE` (`nameCategories` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio_valentina`.`technologies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio_valentina`.`technologies` (
  `id_technologies` INT NOT NULL AUTO_INCREMENT,
  `nameTech` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `categories_id_categories` INT NOT NULL,
  PRIMARY KEY (`id_technologies`, `categories_id_categories`),
  UNIQUE INDEX `nameTech_UNIQUE` (`nameTech` ASC),
  INDEX `fk_technologies_categories1_idx` (`categories_id_categories` ASC),
  CONSTRAINT `fk_technologies_categories1`
    FOREIGN KEY (`categories_id_categories`)
    REFERENCES `portfolio_valentina`.`categories` (`id_categories`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio_valentina`.`projects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio_valentina`.`projects` (
  `id_projects` INT NOT NULL AUTO_INCREMENT,
  `desc` VARCHAR(500) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL,
  `nameProject` VARCHAR(45) NOT NULL,
  `link` VARCHAR(500) NULL,
  `person_id_person` INT NOT NULL,
  PRIMARY KEY (`id_projects`, `person_id_person`),
  INDEX `fk_projects_person1_idx` (`person_id_person` ASC),
  CONSTRAINT `fk_projects_person1`
    FOREIGN KEY (`person_id_person`)
    REFERENCES `portfolio_valentina`.`person` (`id_person`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio_valentina`.`socialmedia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio_valentina`.`socialmedia` (
  `id_socialmedia` INT NOT NULL AUTO_INCREMENT,
  `nameSocialmedia` VARCHAR(45) NOT NULL,
  `linkProfile` VARCHAR(500) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `person_id_person` INT NOT NULL,
  PRIMARY KEY (`id_socialmedia`),
  INDEX `fk_socialmedia_person1_idx` (`person_id_person` ASC),
  CONSTRAINT `fk_socialmedia_person1`
    FOREIGN KEY (`person_id_person`)
    REFERENCES `portfolio_valentina`.`person` (`id_person`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio_valentina`.`person_has_technologies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio_valentina`.`person_has_technologies` (
  `person_id_person` INT NOT NULL,
  `technologies_id_technologies` INT NOT NULL,
  PRIMARY KEY (`person_id_person`, `technologies_id_technologies`),
  INDEX `fk_person_has_technologies_technologies1_idx` (`technologies_id_technologies` ASC),
  INDEX `fk_person_has_technologies_person1_idx` (`person_id_person` ASC),
  CONSTRAINT `fk_person_has_technologies_person1`
    FOREIGN KEY (`person_id_person`)
    REFERENCES `portfolio_valentina`.`person` (`id_person`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_has_technologies_technologies1`
    FOREIGN KEY (`technologies_id_technologies`)
    REFERENCES `portfolio_valentina`.`technologies` (`id_technologies`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio_valentina`.`projects_has_technologies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio_valentina`.`projects_has_technologies` (
  `projects_id_projects` INT NOT NULL,
  `projects_person_id_person` INT NOT NULL,
  `technologies_id_technologies` INT NOT NULL,
  `technologies_categories_id_categories` INT NOT NULL,
  PRIMARY KEY (`projects_id_projects`, `projects_person_id_person`, `technologies_id_technologies`, `technologies_categories_id_categories`),
  INDEX `fk_projects_has_technologies_technologies1_idx` (`technologies_id_technologies` ASC, `technologies_categories_id_categories` ASC),
  INDEX `fk_projects_has_technologies_projects1_idx` (`projects_id_projects` ASC, `projects_person_id_person` ASC),
  CONSTRAINT `fk_projects_has_technologies_projects1`
    FOREIGN KEY (`projects_id_projects` , `projects_person_id_person`)
    REFERENCES `portfolio_valentina`.`projects` (`id_projects` , `person_id_person`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_projects_has_technologies_technologies1`
    FOREIGN KEY (`technologies_id_technologies` , `technologies_categories_id_categories`)
    REFERENCES `portfolio_valentina`.`technologies` (`id_technologies` , `categories_id_categories`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
