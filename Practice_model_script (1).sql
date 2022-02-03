-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`regions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`regions` (
  `region_id` VARCHAR(2) NOT NULL,
  `region_name` VARCHAR(45) NULL,
  `last_updated_date` DATE NULL,
  `last_updated_by` VARCHAR(20) NULL,
  PRIMARY KEY (`region_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`countries` (
  `country_cd` VARCHAR(2) NOT NULL,
  `country_name` VARCHAR(45) NULL,
  `regions_region_id` VARCHAR(2) NOT NULL,
  `last_updated_date` DATE NULL,
  `last_updated_by` VARCHAR(20) NULL,
  PRIMARY KEY (`country_cd`, `regions_region_id`),
  INDEX `fk_countries_regions1_idx` (`regions_region_id` ASC) VISIBLE,
  CONSTRAINT `fk_countries_regions1`
    FOREIGN KEY (`regions_region_id`)
    REFERENCES `mydb`.`regions` (`region_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`departments` (
  `dept_id` INT NOT NULL,
  `dept_name` VARCHAR(45) NULL,
  `last_updated_date` DATE NULL,
  `last_updated_by` VARCHAR(20) NULL,
  PRIMARY KEY (`dept_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`job_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`job_types` (
  `job_type_cd` INT NOT NULL,
  `job_type_name` VARCHAR(45) NULL,
  `last_updated_by` VARCHAR(20) NULL,
  `last_updated_date` DATE NULL,
  PRIMARY KEY (`job_type_cd`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`job_status_codes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`job_status_codes` (
  `job_status_cd` INT NOT NULL,
  `status_desc` VARCHAR(45) NULL,
  `last_updated_date` DATE NULL,
  `last_updated_by` VARCHAR(20) NULL,
  PRIMARY KEY (`job_status_cd`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`appl_status_codes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`appl_status_codes` (
  `appl_status_cd` INT NOT NULL,
  `status_desc` VARCHAR(45) NULL,
  `last_updated_date` DATE NULL,
  `last_updated_by` VARCHAR(20) NULL,
  PRIMARY KEY (`appl_status_cd`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`education_levels`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`education_levels` (
  `edu_level_cd` INT NOT NULL,
  `edu_level_name` VARCHAR(45) NULL,
  `last_updated_date` DATE NULL,
  `last_updated_by` VARCHAR(20) NULL,
  PRIMARY KEY (`edu_level_cd`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`education_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`education_type` (
  `edu_type_cd` INT NOT NULL,
  `edu_type_name` VARCHAR(45) NULL,
  `last_updated_date` DATE NULL,
  `last_updated_by` VARCHAR(20) NULL,
  PRIMARY KEY (`edu_type_cd`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`jobs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`jobs` (
  `job_id` INT NOT NULL,
  `job_title` VARCHAR(45) NULL,
  `job_desc` VARCHAR(4000) NULL,
  `job_types_job_type_cd` INT NOT NULL,
  `departments_dept_id` INT NOT NULL,
  `job_status_codes_job_status_cd` INT NOT NULL,
  `countries_country_cd` VARCHAR(2) NOT NULL,
  `countries_regions_region_id` VARCHAR(2) NOT NULL,
  `last_update_date` DATE NULL,
  `last_updated_by` VARCHAR(45) NULL,
  PRIMARY KEY (`job_id`, `job_types_job_type_cd`, `departments_dept_id`, `job_status_codes_job_status_cd`, `countries_country_cd`, `countries_regions_region_id`),
  INDEX `fk_jobs_job_types1_idx` (`job_types_job_type_cd` ASC) VISIBLE,
  INDEX `fk_jobs_departments1_idx` (`departments_dept_id` ASC) VISIBLE,
  INDEX `fk_jobs_job_status_codes1_idx` (`job_status_codes_job_status_cd` ASC) VISIBLE,
  INDEX `fk_jobs_countries1_idx` (`countries_country_cd` ASC, `countries_regions_region_id` ASC) VISIBLE,
  CONSTRAINT `fk_jobs_job_types1`
    FOREIGN KEY (`job_types_job_type_cd`)
    REFERENCES `mydb`.`job_types` (`job_type_cd`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jobs_departments1`
    FOREIGN KEY (`departments_dept_id`)
    REFERENCES `mydb`.`departments` (`dept_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jobs_job_status_codes1`
    FOREIGN KEY (`job_status_codes_job_status_cd`)
    REFERENCES `mydb`.`job_status_codes` (`job_status_cd`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jobs_countries1`
    FOREIGN KEY (`countries_country_cd` , `countries_regions_region_id`)
    REFERENCES `mydb`.`countries` (`country_cd` , `regions_region_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`applicants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`applicants` (
  `appl_id` INT NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `phone_num` VARCHAR(10) NULL,
  `address` VARCHAR(45) NULL,
  `city` VARCHAR(20) NULL,
  `state` VARCHAR(20) NULL,
  `zip` VARCHAR(7) NULL,
  `countries_country_cd` VARCHAR(2) NOT NULL,
  `countries_regions_region_id` VARCHAR(2) NOT NULL,
  `appl_status_codes_appl_status_cd` INT NOT NULL,
  `education_levels_edu_level_cd` INT NOT NULL,
  `education_type_edu_type_cd` INT NOT NULL,
  `resume_file_name` VARCHAR(20) NULL,
  `cover_letter_text` VARCHAR(45) NULL,
  `date_applied` DATE NULL,
  `employed_flag` TINYINT NULL,
  `current_employer_name` VARCHAR(45) NULL,
  `years_of_experience` TINYINT NULL,
  `last_updated_date` DATE NULL,
  `last_updated_by` VARCHAR(45) NULL,
  PRIMARY KEY (`appl_id`, `countries_country_cd`, `countries_regions_region_id`, `appl_status_codes_appl_status_cd`, `education_levels_edu_level_cd`, `education_type_edu_type_cd`),
  INDEX `fk_applicants_countries1_idx` (`countries_country_cd` ASC, `countries_regions_region_id` ASC) VISIBLE,
  INDEX `fk_applicants_appl_status_codes1_idx` (`appl_status_codes_appl_status_cd` ASC) VISIBLE,
  INDEX `fk_applicants_education_levels1_idx` (`education_levels_edu_level_cd` ASC) VISIBLE,
  INDEX `fk_applicants_education_type1_idx` (`education_type_edu_type_cd` ASC) VISIBLE,
  CONSTRAINT `fk_applicants_countries1`
    FOREIGN KEY (`countries_country_cd` , `countries_regions_region_id`)
    REFERENCES `mydb`.`countries` (`country_cd` , `regions_region_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_applicants_appl_status_codes1`
    FOREIGN KEY (`appl_status_codes_appl_status_cd`)
    REFERENCES `mydb`.`appl_status_codes` (`appl_status_cd`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_applicants_education_levels1`
    FOREIGN KEY (`education_levels_edu_level_cd`)
    REFERENCES `mydb`.`education_levels` (`edu_level_cd`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_applicants_education_type1`
    FOREIGN KEY (`education_type_edu_type_cd`)
    REFERENCES `mydb`.`education_type` (`edu_type_cd`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`applicant_jobs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`applicant_jobs` (
  `applicants_appl_id` INT NOT NULL,
  `applicants_countries_country_cd` VARCHAR(2) NOT NULL,
  `applicants_countries_regions_region_id` VARCHAR(2) NOT NULL,
  `applicants_appl_status_codes_appl_status_cd` INT NOT NULL,
  `applicants_education_levels_edu_level_cd` INT NOT NULL,
  `applicants_education_type_edu_type_cd` INT NOT NULL,
  `jobs_job_id` INT NOT NULL,
  `jobs_job_types_job_type_cd` INT NOT NULL,
  `jobs_departments_dept_id` INT NOT NULL,
  `jobs_job_status_codes_job_status_cd` INT NOT NULL,
  `jobs_countries_country_cd` VARCHAR(2) NOT NULL,
  `jobs_countries_regions_region_id` VARCHAR(2) NOT NULL,
  `appl_status_codes_appl_status_cd` INT NOT NULL,
  `date_applied` DATE NULL,
  `written_test_date` DATE NULL,
  `interview1_date` DATE NULL,
  `interview2_date` DATE NULL,
  `last_updated_date` DATE NULL,
  `last_updated_by` VARCHAR(20) NULL,
  PRIMARY KEY (`applicants_appl_id`, `applicants_countries_country_cd`, `applicants_countries_regions_region_id`, `applicants_appl_status_codes_appl_status_cd`, `applicants_education_levels_edu_level_cd`, `applicants_education_type_edu_type_cd`, `jobs_job_id`, `jobs_job_types_job_type_cd`, `jobs_departments_dept_id`, `jobs_job_status_codes_job_status_cd`, `jobs_countries_country_cd`, `jobs_countries_regions_region_id`, `appl_status_codes_appl_status_cd`),
  INDEX `fk_applicant_jobs_jobs1_idx` (`jobs_job_id` ASC, `jobs_job_types_job_type_cd` ASC, `jobs_departments_dept_id` ASC, `jobs_job_status_codes_job_status_cd` ASC, `jobs_countries_country_cd` ASC, `jobs_countries_regions_region_id` ASC) VISIBLE,
  INDEX `fk_applicant_jobs_appl_status_codes1_idx` (`appl_status_codes_appl_status_cd` ASC) VISIBLE,
  CONSTRAINT `fk_applicant_jobs_applicants1`
    FOREIGN KEY (`applicants_appl_id` , `applicants_countries_country_cd` , `applicants_countries_regions_region_id` , `applicants_appl_status_codes_appl_status_cd` , `applicants_education_levels_edu_level_cd` , `applicants_education_type_edu_type_cd`)
    REFERENCES `mydb`.`applicants` (`appl_id` , `countries_country_cd` , `countries_regions_region_id` , `appl_status_codes_appl_status_cd` , `education_levels_edu_level_cd` , `education_type_edu_type_cd`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_applicant_jobs_jobs1`
    FOREIGN KEY (`jobs_job_id` , `jobs_job_types_job_type_cd` , `jobs_departments_dept_id` , `jobs_job_status_codes_job_status_cd` , `jobs_countries_country_cd` , `jobs_countries_regions_region_id`)
    REFERENCES `mydb`.`jobs` (`job_id` , `job_types_job_type_cd` , `departments_dept_id` , `job_status_codes_job_status_cd` , `countries_country_cd` , `countries_regions_region_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_applicant_jobs_appl_status_codes1`
    FOREIGN KEY (`appl_status_codes_appl_status_cd`)
    REFERENCES `mydb`.`appl_status_codes` (`appl_status_cd`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
