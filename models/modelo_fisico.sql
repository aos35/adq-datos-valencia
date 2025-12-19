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
-- Table `mydb`.`Dim_Tiempo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Dim_Tiempo` (
  `id_Tiempo` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `nombre_dia_semana` VARCHAR(45) NOT NULL,
  `es_fin_de_semana` TINYINT NOT NULL,
  `anio` SMALLINT(4) NOT NULL,
  `mes` SMALLINT(2) NOT NULL,
  `dia` SMALLINT(2) NOT NULL,
  PRIMARY KEY (`id_Tiempo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Dim_Distrito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Dim_Distrito` (
  `id_Distrito` INT NOT NULL AUTO_INCREMENT,
  `nombre_distrito` VARCHAR(100) NOT NULL,
  `codigo_distrito` SMALLINT(10) NULL,
  `poblacion_total` INT NULL,
  `area_km2` DECIMAL(10,2) NULL,
  `densidad_hab_km2` DECIMAL(10,2) NULL,
  `latitud_centroide` DOUBLE NULL,
  `longitud_centroide` DOUBLE NULL,
  `geo_shape` LONGTEXT NULL,
  UNIQUE INDEX `nombre_distrito_UNIQUE` (`nombre_distrito` ASC) VISIBLE,
  PRIMARY KEY (`id_Distrito`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Dim_Estacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Dim_Estacion` (
  `id_Estacion` INT NOT NULL AUTO_INCREMENT,
  `nombre_estacion` VARCHAR(100) NOT NULL,
  `direccion` VARCHAR(255) NULL,
  `latitud` DOUBLE NULL,
  `longitud` DOUBLE NULL,
  `tipo_zona` VARCHAR(50) NULL,
  `tipo_emision` VARCHAR(50) NULL,
  `fuente_datos` VARCHAR(50) NULL,
  `id_Distrito` INT NULL,
  PRIMARY KEY (`id_Estacion`),
  INDEX `id_Distrito_idx` (`id_Distrito` ASC) VISIBLE,
  UNIQUE INDEX `nombre_estacion_UNIQUE` (`nombre_estacion` ASC) VISIBLE,
  CONSTRAINT `id_Distrito_Estacion`
    FOREIGN KEY (`id_Distrito`)
    REFERENCES `mydb`.`Dim_Distrito` (`id_Distrito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Dim_Zona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Dim_Zona` (
  `id_Zona` INT NOT NULL AUTO_INCREMENT,
  `gridcode` VARCHAR(45) NOT NULL,
  `latitud_centroide` DECIMAL(10,8) NULL,
  `longitud_centroide` DECIMAL(10,8) NULL,
  `area_m2` DECIMAL(12,2) NULL,
  `geo_shape` LONGTEXT NULL,
  `id_Distrito` INT NULL,
  PRIMARY KEY (`id_Zona`),
  INDEX `id_Distrito_idx` (`id_Distrito` ASC) VISIBLE,
  CONSTRAINT `id_Distrito_Zona`
    FOREIGN KEY (`id_Distrito`)
    REFERENCES `mydb`.`Dim_Distrito` (`id_Distrito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Dim_Contaminante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Dim_Contaminante` (
  `id_Contaminante` INT NOT NULL AUTO_INCREMENT,
  `nombre_contaminante` VARCHAR(50) NOT NULL,
  `unidad_medida` VARCHAR(20) NULL,
  `tipo_compuesto` VARCHAR(30) NULL,
  `limite_recomendad` DECIMAL(10,3) NULL,
  `efecto_salud` TEXT(255) NULL,
  PRIMARY KEY (`id_Contaminante`),
  UNIQUE INDEX `nombre_contaminante_UNIQUE` (`nombre_contaminante` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Hecho_Medicion_Ambiental`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Hecho_Medicion_Ambiental` (
  `id_Tiempo` INT NOT NULL,
  `id_Estacion` INT NOT NULL,
  `id_Contaminante` INT NOT NULL,
  `valor_medido` INT NULL,
  `temperatura_c` DECIMAL(5,2) NULL,
  `hum_rel_pct` DECIMAL(5,2) NULL,
  `velocidad_viento_ms` DECIMAL(5,2) NULL,
  `presion_hpa` DECIMAL(6,2) NULL,
  `calidad_ambiental` VARCHAR(50) NULL,
  `ruido_mapa_db` DECIMAL(5,2) NULL,
  `id_Zona` INT NULL,
  PRIMARY KEY (`id_Estacion`, `id_Tiempo`, `id_Contaminante`),
  INDEX `id_Contaminante_idx` (`id_Contaminante` ASC) VISIBLE,
  INDEX `id_Tiempo_idx` (`id_Tiempo` ASC) VISIBLE,
  INDEX `id_Zona_idx` (`id_Zona` ASC) VISIBLE,
  CONSTRAINT `id_Contaminante`
    FOREIGN KEY (`id_Contaminante`)
    REFERENCES `mydb`.`Dim_Contaminante` (`id_Contaminante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_Tiempo`
    FOREIGN KEY (`id_Tiempo`)
    REFERENCES `mydb`.`Dim_Tiempo` (`id_Tiempo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_Estacion`
    FOREIGN KEY (`id_Estacion`)
    REFERENCES `mydb`.`Dim_Estacion` (`id_Estacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_Zona`
    FOREIGN KEY (`id_Zona`)
    REFERENCES `mydb`.`Dim_Zona` (`id_Zona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
