-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Persona` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `edad` INT NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Actividades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Actividades` (
  `Id_actividad` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `tipo` ENUM('fija', 'esporadica') NOT NULL,
  `descripcion` TEXT NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id_actividad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Asignaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Asignaciones` (
  `id_asignaciones` INT NOT NULL AUTO_INCREMENT,
  `Persona_id` INT NOT NULL,
  `Actividad_Id_actividad` INT NOT NULL,
  PRIMARY KEY (`id_asignaciones`),
  INDEX `fk_Asignaciones_Persona_idx` (`Persona_id` ASC) VISIBLE,
  INDEX `fk_Asignaciones_Actividades1_idx` (`Actividad_Id_actividad` ASC) VISIBLE,
  CONSTRAINT `fk_Asignaciones_Persona`
    FOREIGN KEY (`Persona_id`)
    REFERENCES `mydb`.`Persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Asignaciones_Actividades1`
    FOREIGN KEY (`Actividad_Id_actividad`)
    REFERENCES `mydb`.`Actividades` (`Id_actividad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Calendario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Calendario` (
  `id_evento` INT NOT NULL AUTO_INCREMENT,
  `fecha_inicio` DATETIME NOT NULL,
  `fecha_fin` DATETIME NOT NULL,
  `repeticion` ENUM('única', 'diaria', 'semanal', 'mensual') NOT NULL,
  `observacion` TEXT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Actividad_Id_actividad` INT NOT NULL,
  PRIMARY KEY (`id_evento`),
  INDEX `fk_Calendario_Actividades1_idx` (`Actividad_Id_actividad` ASC) VISIBLE,
  CONSTRAINT `fk_Calendario_Actividades1`
    FOREIGN KEY (`Actividad_Id_actividad`)
    REFERENCES `mydb`.`Actividades` (`Id_actividad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
