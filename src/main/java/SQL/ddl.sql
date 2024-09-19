-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema TwoGather
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema TwoGather
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `TwoGather` DEFAULT CHARACTER SET utf8 ;
USE `TwoGather` ;

-- -----------------------------------------------------
-- Table `TwoGather`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TwoGather`.`User` (
  `id` VARCHAR(30) NOT NULL,
  `partner_id` VARCHAR(30) ,
  `img_src` text NULL,
  `password` VARCHAR(30) NOT NULL,
  `nickname` VARCHAR(10) NOT NULL,
  `mobile` VARCHAR(13) NOT NULL,
  `birthdate` DATE NOT NULL,
  `email` VARCHAR(30) NOT NULL,
  `gender` CHAR(1) NOT NULL,
  `address` VARCHAR(200) NULL,
  `matching` VARCHAR(5) NOT NULL DEFAULT '매칭전',
  `start_date` DATE NULL,
  `break_date` DATETIME NULL,
  UNIQUE INDEX `mobile_UNIQUE` (`mobile` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  INDEX `fk_User_User_idx` (`partner_id` ASC) VISIBLE,
  CONSTRAINT `fk_User_User`
    FOREIGN KEY (`partner_id`)
    REFERENCES `TwoGather`.`User` (`id`)
    ON DELETE cascade
    ON UPDATE cascade)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TwoGather`.`Schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TwoGather`.`Schedule` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `User_id` VARCHAR(30) NOT NULL,
  `is_personal` VARCHAR(5) NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `title` VARCHAR(20) NOT NULL,
  `description` VARCHAR(200) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Schedule_User1_idx` (`User_id` ASC) VISIBLE,
  CONSTRAINT `fk_Schedule_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `TwoGather`.`User` (`id`)
    ON DELETE cascade
    ON UPDATE cascade)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TwoGather`.`story`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TwoGather`.`story` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `User_id` VARCHAR(30) NOT NULL,
  `upload_date` DATE NOT NULL DEFAULT (CURRENT_DATE),
  `img_src` text NOT NULL,
  `title` VARCHAR(50) NOT NULL,
  `content` VARCHAR(200) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_story_User1_idx` (`User_id` ASC) VISIBLE,
  CONSTRAINT `fk_story_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `TwoGather`.`User` (`id`)
    ON DELETE cascade
    ON UPDATE cascade)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TwoGather`.`Gagyebu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TwoGather`.`Gagyebu` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `User_id` VARCHAR(30) NOT NULL,
  `transaction_date` DATE NOT NULL,
  `is_deposit` VARCHAR(5) NOT NULL,
  `category` VARCHAR(10) NULL,
  `price` INT NOT NULL,
  `title` VARCHAR(20) NULL,
  `payment_type` VARCHAR(4) NULL,
  `etc` VARCHAR(100) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Gagyebu_User1_idx` (`User_id` ASC) VISIBLE,
  CONSTRAINT `fk_Gagyebu_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `TwoGather`.`User` (`id`)
    ON DELETE cascade
    ON UPDATE cascade)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TwoGather`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TwoGather`.`Category` (
  `Category_name` VARCHAR(200) NOT NULL,
  `User_id` VARCHAR(30) NOT NULL,
  INDEX `fk_Category_User1_idx` (`User_id` ASC) VISIBLE,
  CONSTRAINT `fk_Category_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `TwoGather`.`User` (`id`)
    ON DELETE cascade
    ON UPDATE cascade)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
