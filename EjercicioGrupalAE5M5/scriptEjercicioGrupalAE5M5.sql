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
-- Table `mydb`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Clientes` (
  `idClientes` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(150) NOT NULL,
  `Telefono` VARCHAR(12) NOT NULL,
  `correo_electronico` VARCHAR(40) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idClientes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`VehiculosDisponibles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`VehiculosDisponibles` (
  `idVehiculosDisponibles` INT NOT NULL AUTO_INCREMENT,
  `Patente` VARCHAR(10) NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Capacidad` DECIMAL NOT NULL,
  `Disponibilidad` TINYINT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idVehiculosDisponibles`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SolicitudesRetiro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`SolicitudesRetiro` (
  `idSolicitudesRetiro` INT NOT NULL AUTO_INCREMENT,
  `Fecha` DATETIME NOT NULL,
  `Hora` DATETIME NOT NULL,
  `Estado` ENUM('pendiente', 'completado', 'cancelado') NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Cliente_idClientes` INT NOT NULL,
  `VehiculoDisponible_idVehiculosDisponibles` INT NOT NULL,
  PRIMARY KEY (`idSolicitudesRetiro`),
  INDEX `fk_SolicitudesRetiro_Clientes_idx` (`Cliente_idClientes` ASC) VISIBLE,
  INDEX `fk_SolicitudesRetiro_VehiculosDisponibles1_idx` (`VehiculoDisponible_idVehiculosDisponibles` ASC) VISIBLE,
  CONSTRAINT `fk_SolicitudesRetiro_Clientes`
    FOREIGN KEY (`Cliente_idClientes`)
    REFERENCES `mydb`.`Clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SolicitudesRetiro_VehiculosDisponibles1`
    FOREIGN KEY (`VehiculoDisponible_idVehiculosDisponibles`)
    REFERENCES `mydb`.`VehiculosDisponibles` (`idVehiculosDisponibles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Articulos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Articulos` (
  `idArticulos` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Descripción` VARCHAR(255) NOT NULL,
  `Peso` DECIMAL NOT NULL,
  `Estado` ENUM('bueno', 'danado') NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `SolicitudRetiro_idSolicitudesRetiro` INT NOT NULL,
  PRIMARY KEY (`idArticulos`),
  INDEX `fk_Articulos_SolicitudesRetiro1_idx` (`SolicitudRetiro_idSolicitudesRetiro` ASC) VISIBLE,
  CONSTRAINT `fk_Articulos_SolicitudesRetiro1`
    FOREIGN KEY (`SolicitudRetiro_idSolicitudesRetiro`)
    REFERENCES `mydb`.`SolicitudesRetiro` (`idSolicitudesRetiro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
