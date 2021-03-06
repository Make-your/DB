-- MySQL Script generated by MySQL Workbench
-- 05/25/16 14:39:55
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idusuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idusuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`administrador` (
  `idadministrador` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  PRIMARY KEY (`idadministrador`, `usuario_idusuario`),
  INDEX `fk_administrador_usuario1_idx` (`usuario_idusuario` ASC),
  CONSTRAINT `fk_administrador_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `mydb`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`fornecedor` (
  `idfornecedor` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `cnpj` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(45) NOT NULL,
  `endereco` VARCHAR(45) NOT NULL,
  `cardapio` VARCHAR(45) NOT NULL,
  `tipo_agendamento` VARCHAR(45) NOT NULL,
  `avaliacoes` VARCHAR(45) NOT NULL,
  `promocoes` VARCHAR(45) NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  PRIMARY KEY (`idfornecedor`, `usuario_idusuario`),
  INDEX `fk_fornecedor_usuario1_idx` (`usuario_idusuario` ASC),
  CONSTRAINT `fk_fornecedor_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `mydb`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`forma_pag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`forma_pag` (
  `idforma_pag` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `Bandeira_cartao` VARCHAR(45) NOT NULL,
  `fornecedor_idfornecedor` INT NOT NULL,
  `fornecedor_administrador_idadministrador` INT NOT NULL,
  PRIMARY KEY (`idforma_pag`, `fornecedor_idfornecedor`, `fornecedor_administrador_idadministrador`),
  INDEX `fk_forma_pag_fornecedor1_idx` (`fornecedor_idfornecedor` ASC, `fornecedor_administrador_idadministrador` ASC),
  CONSTRAINT `fk_forma_pag_fornecedor1`
    FOREIGN KEY (`fornecedor_idfornecedor`)
    REFERENCES `mydb`.`fornecedor` (`idfornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pedido` (
  `idpedido` INT NOT NULL AUTO_INCREMENT,
  `qtde` VARCHAR(45) NOT NULL,
  `preco_total` VARCHAR(45) NOT NULL,
  `forma_pag_idforma_pag` INT NOT NULL,
  `fornecedor_idfornecedor` INT NOT NULL,
  `fornecedor_administrador_idadministrador` INT NOT NULL,
  PRIMARY KEY (`idpedido`, `forma_pag_idforma_pag`, `fornecedor_idfornecedor`, `fornecedor_administrador_idadministrador`),
  INDEX `fk_pedido_forma_pag_idx` (`forma_pag_idforma_pag` ASC),
  INDEX `fk_pedido_fornecedor1_idx` (`fornecedor_idfornecedor` ASC, `fornecedor_administrador_idadministrador` ASC),
  CONSTRAINT `fk_pedido_forma_pag`
    FOREIGN KEY (`forma_pag_idforma_pag`)
    REFERENCES `mydb`.`forma_pag` (`idforma_pag`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_fornecedor1`
    FOREIGN KEY (`fornecedor_idfornecedor`)
    REFERENCES `mydb`.`fornecedor` (`idfornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`produtos` (
  `idprodutos` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `preco` VARCHAR(45) NOT NULL,
  `categoria` VARCHAR(45) NOT NULL,
  `pedido_idpedido` INT NOT NULL,
  `pedido_forma_pag_idforma_pag` INT NOT NULL,
  `fornecedor_idfornecedor` INT NOT NULL,
  `fornecedor_administrador_idadministrador` INT NOT NULL,
  PRIMARY KEY (`idprodutos`, `fornecedor_idfornecedor`, `fornecedor_administrador_idadministrador`),
  INDEX `fk_produtos_pedido1_idx` (`pedido_idpedido` ASC, `pedido_forma_pag_idforma_pag` ASC),
  INDEX `fk_produtos_fornecedor1_idx` (`fornecedor_idfornecedor` ASC, `fornecedor_administrador_idadministrador` ASC),
  CONSTRAINT `fk_produtos_pedido1`
    FOREIGN KEY (`pedido_idpedido` , `pedido_forma_pag_idforma_pag`)
    REFERENCES `mydb`.`pedido` (`idpedido` , `forma_pag_idforma_pag`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produtos_fornecedor1`
    FOREIGN KEY (`fornecedor_idfornecedor`)
    REFERENCES `mydb`.`fornecedor` (`idfornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ingredientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ingredientes` (
  `idingredientes` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `produtos_idprodutos` INT NOT NULL,
  `fornecedor_idfornecedor` INT NOT NULL,
  `fornecedor_administrador_idadministrador` INT NOT NULL,
  PRIMARY KEY (`idingredientes`, `produtos_idprodutos`, `fornecedor_idfornecedor`, `fornecedor_administrador_idadministrador`),
  INDEX `fk_ingredientes_produtos1_idx` (`produtos_idprodutos` ASC),
  INDEX `fk_ingredientes_fornecedor1_idx` (`fornecedor_idfornecedor` ASC, `fornecedor_administrador_idadministrador` ASC),
  CONSTRAINT `fk_ingredientes_produtos1`
    FOREIGN KEY (`produtos_idprodutos`)
    REFERENCES `mydb`.`produtos` (`idprodutos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingredientes_fornecedor1`
    FOREIGN KEY (`fornecedor_idfornecedor`)
    REFERENCES `mydb`.`fornecedor` (`idfornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`agendamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`agendamento` (
  `idagendamento` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL,
  `horario` VARCHAR(45) NOT NULL,
  `data` VARCHAR(45) NOT NULL,
  `pedido_idpedido` INT NOT NULL,
  `pedido_forma_pag_idforma_pag` INT NOT NULL,
  PRIMARY KEY (`idagendamento`, `pedido_idpedido`, `pedido_forma_pag_idforma_pag`),
  INDEX `fk_agendamento_pedido1_idx` (`pedido_idpedido` ASC, `pedido_forma_pag_idforma_pag` ASC),
  CONSTRAINT `fk_agendamento_pedido1`
    FOREIGN KEY (`pedido_idpedido` , `pedido_forma_pag_idforma_pag`)
    REFERENCES `mydb`.`pedido` (`idpedido` , `forma_pag_idforma_pag`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cliente` (
  `idclliente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(45) NOT NULL,
  `cllientecol` VARCHAR(45) NULL,
  `pedido_idpedido` INT NOT NULL,
  `pedido_forma_pag_idforma_pag` INT NOT NULL,
  `pedido_fornecedor_idfornecedor` INT NOT NULL,
  `pedido_fornecedor_administrador_idadministrador` INT NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  PRIMARY KEY (`idclliente`, `pedido_idpedido`, `pedido_forma_pag_idforma_pag`, `pedido_fornecedor_idfornecedor`, `pedido_fornecedor_administrador_idadministrador`, `usuario_idusuario`),
  INDEX `fk_cliente_pedido1_idx` (`pedido_idpedido` ASC, `pedido_forma_pag_idforma_pag` ASC, `pedido_fornecedor_idfornecedor` ASC, `pedido_fornecedor_administrador_idadministrador` ASC),
  INDEX `fk_cliente_usuario1_idx` (`usuario_idusuario` ASC),
  CONSTRAINT `fk_cliente_pedido1`
    FOREIGN KEY (`pedido_idpedido` , `pedido_forma_pag_idforma_pag` , `pedido_fornecedor_idfornecedor` , `pedido_fornecedor_administrador_idadministrador`)
    REFERENCES `mydb`.`pedido` (`idpedido` , `forma_pag_idforma_pag` , `fornecedor_idfornecedor` , `fornecedor_administrador_idadministrador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `mydb`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
