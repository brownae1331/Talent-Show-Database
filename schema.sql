

-- -----------------------------------------------------
-- Table `Coach`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Coach` (
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `DoB` DATE NOT NULL,
  `phone` VARCHAR(11) NOT NULL,
  `dailySalary` FLOAT NOT NULL,
  `gender` CHAR(1) NOT NULL,
  `idCoach` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idCoach`));


-- -----------------------------------------------------
-- Table `Contender`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Contender` (
  `idContender` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `stageName` VARCHAR(45) NOT NULL,
  `type` VARCHAR(10) NOT NULL,
  `idCoach` INT,
  FOREIGN KEY (`idCoach`) REFERENCES `Coach` (`idCoach`) ON DELETE SET NULL ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `Participant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Participant` (
  `name` VARCHAR(45) NOT NULL,
  `idParticipant` INT NOT NULL AUTO_INCREMENT,
  `surname` VARCHAR(45) NOT NULL,
  `DoB` DATE NOT NULL,
  `phone` VARCHAR(11) NOT NULL,
  `dailySalary` FLOAT NOT NULL,
  `gender` CHAR(1) NOT NULL,
  `idContender` INT NOT NULL,
  PRIMARY KEY (`idParticipant`),
  CONSTRAINT 
    FOREIGN KEY (`idContender`)
    REFERENCES `Contender` (`idContender`)
    ON DELETE CASCADE);


-- -----------------------------------------------------
-- Table `Show`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Show` (
  `idShow` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `startTime` TIME NOT NULL,
  `endTime` TIME NOT NULL,
  `location` VARCHAR(45) NULL,
  PRIMARY KEY (`idShow`));


-- -----------------------------------------------------
-- Table `CoachInShow`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CoachInShow` (
  `idCoach` INT NOT NULL,
  `idShow` INT NOT NULL,
  PRIMARY KEY (`idCoach`, `idShow`),
  CONSTRAINT 
    FOREIGN KEY (`idCoach`)
    REFERENCES `Coach` (`idCoach`)
    ON DELETE CASCADE,
  CONSTRAINT 
    FOREIGN KEY (`idShow`)
    REFERENCES `Show` (`idShow`));


-- -----------------------------------------------------
-- Table `ContenderInShow`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ContenderInShow` (
  `idShow` INT NOT NULL,
  `idContender` INT NOT NULL,
  PRIMARY KEY (`idShow`, `idContender`),
  CONSTRAINT 
    FOREIGN KEY (`idShow`)
    REFERENCES `Show` (`idShow`),
  CONSTRAINT 
    FOREIGN KEY (`idContender`)
    REFERENCES `Contender` (`idContender`)
    ON DELETE CASCADE);

-- Semantic Constraints
-- 1. Group contenders must be made of more than one participant
-- 2. Contenders should be made of at least one participant