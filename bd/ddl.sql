-- MySQL Script generated by MySQL Workbench
-- 02/27/18 19:58:26
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema ecommerce
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ecommerce
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ecommerce` DEFAULT CHARACTER SET utf8 ;
USE `ecommerce` ;

-- -----------------------------------------------------
-- Table `ecommerce`.`direccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`direccion` (
  `id_direccion` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre_direccion` VARCHAR(95) NULL DEFAULT NULL,
  `direccion_2` VARCHAR(95) NULL DEFAULT NULL,
  `ciudad` VARCHAR(45) NULL DEFAULT NULL,
  `departamento` VARCHAR(45) NULL DEFAULT NULL,
  `telefono1` VARCHAR(45) NULL DEFAULT NULL,
  `telefono2` VARCHAR(45) NULL DEFAULT NULL,
  `observaciones` VARCHAR(100) NULL DEFAULT NULL,
  `coordenada` VARCHAR(150) NULL,
  PRIMARY KEY (`id_direccion`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecommerce`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`usuario` (
  `id_usuario` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `apellido` VARCHAR(45) NULL DEFAULT NULL,
  `correo` VARCHAR(55) NULL DEFAULT NULL,
  `password` VARCHAR(45) NULL DEFAULT NULL,
  `fecha_nac` DATE NULL DEFAULT NULL,
  `id_direccion` INT(11) NOT NULL,
  PRIMARY KEY (`id_usuario`, `id_direccion`),
  INDEX `fk_usuario_direccion1_idx` (`id_direccion` ASC),
  CONSTRAINT `fk_usuario_direccion1`
    FOREIGN KEY (`id_direccion`)
    REFERENCES `ecommerce`.`direccion` (`id_direccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecommerce`.`carrito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`carrito` (
  `id_carrito` INT(11) NOT NULL AUTO_INCREMENT,
  `estado` TINYINT(1) NULL DEFAULT NULL,
  `id_usuario` INT(11) NOT NULL,
  PRIMARY KEY (`id_carrito`, `id_usuario`),
  INDEX `fk_carrito_usuario1_idx` (`id_usuario` ASC),
  CONSTRAINT `fk_carrito_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `ecommerce`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecommerce`.`carrito_productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`carrito_productos` (
  `id_carrito` INT(11) NOT NULL,
  `id_producto` INT(11) NOT NULL,
  `cantidad` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_carrito`, `id_producto`),
  INDEX `fk_carrito_has_productos_productos1_idx` (`id_producto` ASC),
  INDEX `fk_carrito_has_productos_carrito1_idx` (`id_carrito` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecommerce`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`categoria` (
  `id_categoria` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre_categoria` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecommerce`.`Metodos_Pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`Metodos_Pago` (
  `idMetodos_Pago` INT NOT NULL,
  `descripcion_pago` VARCHAR(45) NULL,
  `cuenta` VARCHAR(45) NULL,
  `contaseña` VARCHAR(45) NULL,
  `monto_acumulado` VARCHAR(45) NULL,
  PRIMARY KEY (`idMetodos_Pago`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`compras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`compras` (
  `id_compras` INT(11) NOT NULL AUTO_INCREMENT,
  `fecha` DATE NULL DEFAULT NULL,
  `monto` DOUBLE NULL DEFAULT NULL,
  `estado_envio` VARCHAR(45) NULL DEFAULT NULL,
  `fecha_entrega` DATE NULL DEFAULT NULL,
  `id_carrito` INT(11) NOT NULL,
  `qr` VARCHAR(150) NULL,
  `idMetodos_Pago` INT NOT NULL,
  PRIMARY KEY (`id_compras`, `id_carrito`, `idMetodos_Pago`),
  INDEX `fk_compras_carrito1_idx` (`id_carrito` ASC),
  INDEX `fk_compras_Metodos_Pago1_idx` (`idMetodos_Pago` ASC),
  CONSTRAINT `fk_compras_carrito1`
    FOREIGN KEY (`id_carrito`)
    REFERENCES `ecommerce`.`carrito` (`id_carrito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compras_Metodos_Pago1`
    FOREIGN KEY (`idMetodos_Pago`)
    REFERENCES `ecommerce`.`Metodos_Pago` (`idMetodos_Pago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecommerce`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`productos` (
  `id_producto` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `precio` DOUBLE NULL DEFAULT NULL,
  `cantidad` INT(11) NULL DEFAULT NULL,
  `descripcion` VARCHAR(400) NULL DEFAULT NULL,
  `peso` DOUBLE NULL DEFAULT NULL,
  `modelo` VARCHAR(45) NULL DEFAULT NULL,
  `id_categoria` INT(11) NOT NULL,
  PRIMARY KEY (`id_producto`, `id_categoria`),
  INDEX `fk_productos_categoria1_idx` (`id_categoria` ASC),
  CONSTRAINT `fk_productos_categoria1`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `ecommerce`.`categoria` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecommerce`.`foto_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`foto_producto` (
  `id_foto` INT(11) NOT NULL AUTO_INCREMENT,
  `url` VARCHAR(259) NULL DEFAULT NULL,
  `principal` INT(11) NOT NULL,
  `id_producto` INT(11) NOT NULL,
  PRIMARY KEY (`id_foto`, `id_producto`),
  INDEX `fk_foto_producto_productos1_idx` (`id_producto` ASC),
  CONSTRAINT `fk_foto_producto_productos1`
    FOREIGN KEY (`id_producto`)
    REFERENCES `ecommerce`.`productos` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 27
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecommerce`.`historico_compras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`historico_compras` (
  `id_historico` INT NULL,
  `id_compras` INT(11) NOT NULL,
  `id_carrito` INT(11) NOT NULL,
  `historico_compras` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_historico`),
  INDEX `fk_historico_compras_compras1_idx` (`id_compras` ASC, `id_carrito` ASC),
  CONSTRAINT `fk_historico_compras_compras1`
    FOREIGN KEY (`id_compras`)
    REFERENCES `ecommerce`.`compras` (`id_compras`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`compras_has_historico_compras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`compras_has_historico_compras` (
  `compras_id_compras` INT(11) NOT NULL,
  `compras_id_carrito` INT(11) NOT NULL,
  `historico_compras_id_historico` INT NOT NULL,
  PRIMARY KEY (`compras_id_compras`, `compras_id_carrito`, `historico_compras_id_historico`),
  INDEX `fk_compras_has_historico_compras_historico_compras1_idx` (`historico_compras_id_historico` ASC),
  INDEX `fk_compras_has_historico_compras_compras_idx` (`compras_id_compras` ASC, `compras_id_carrito` ASC),
  CONSTRAINT `fk_compras_has_historico_compras_compras`
    FOREIGN KEY (`compras_id_compras`)
    REFERENCES `ecommerce`.`compras` (`id_compras`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compras_has_historico_compras_historico_compras1`
    FOREIGN KEY (`historico_compras_id_historico`)
    REFERENCES `ecommerce`.`historico_compras` (`id_historico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecommerce`.`envios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`envios` (
  `id_envio` INT NULL,
  `direccion_googlem` VARCHAR(100) NOT NULL,
  `fecha_envio` DATE NOT NULL,
  `id_usuario` INT(11) NOT NULL AUTO_INCREMENT,
  `id_direccion` INT(11) NOT NULL,
  PRIMARY KEY (`id_envio`),
  INDEX `fk_envios_usuario1_idx` (`id_usuario` ASC, `id_direccion` ASC),
  CONSTRAINT `fk_envios_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `ecommerce`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`codigos_barra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`codigos_barra` (
  `id_codigob` INT NOT NULL,
  `codigos_barra` VARCHAR(45) NOT NULL,
  `id_producto` INT(11) NOT NULL,
  `id_categoria` INT(11) NOT NULL,
  INDEX `fk_codigos_barra_productos1_idx` (`id_producto` ASC, `id_categoria` ASC),
  CONSTRAINT `fk_codigos_barra_productos1`
    FOREIGN KEY (`id_producto`)
    REFERENCES `ecommerce`.`productos` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`ordenes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`ordenes` (
  `id_orden` INT NOT NULL,
  `id_usuario` INT(11) NOT NULL,
  `id_direccion` INT(11) NOT NULL,
  `id_producto` INT(11) NOT NULL,
  `id_categoria` INT(11) NOT NULL,
  `monto_orden`  NOT NULL,
  INDEX `fk_ordenes_usuario1_idx` (`id_usuario` ASC, `id_direccion` ASC),
  INDEX `fk_ordenes_productos1_idx` (`id_producto` ASC, `id_categoria` ASC),
  PRIMARY KEY (`id_orden`),
  CONSTRAINT `fk_ordenes_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `ecommerce`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ordenes_productos1`
    FOREIGN KEY (`id_producto`)
    REFERENCES `ecommerce`.`productos` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce`.`carrito_has_productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`carrito_has_productos` (
  `id_carrito` INT(11) NOT NULL,
  `id_producto` INT(11) NOT NULL,
  `cantidad` INT(11) NULL,
  PRIMARY KEY (`id_carrito`, `id_producto`),
  INDEX `fk_carrito_has_productos_productos1_idx` (`id_producto` ASC),
  INDEX `fk_carrito_has_productos_carrito1_idx` (`id_carrito` ASC),
  CONSTRAINT `fk_carrito_has_productos_carrito1`
    FOREIGN KEY (`id_carrito`)
    REFERENCES `ecommerce`.`carrito` (`id_carrito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_carrito_has_productos_productos1`
    FOREIGN KEY (`id_producto`)
    REFERENCES `ecommerce`.`productos` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ecommerce`.`TIckets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`TIckets` (
  `idTickets` INT NOT NULL,
  `asunto` VARCHAR(45) NULL,
  `estado` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  `fecha_apertura` DATE NULL,
  `fecha_resolucion` DATE NULL,
  `id_usuario` INT(11) NOT NULL,
  PRIMARY KEY (`idTickets`, `id_usuario`),
  INDEX `fk_TIckets_usuario1_idx` (`id_usuario` ASC),
  CONSTRAINT `fk_TIckets_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `ecommerce`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
