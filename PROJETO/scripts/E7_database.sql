/*
TeSP_PSI_22_23_CDBD
Sistema de Gestão de Visitas de Crianças e Jovens Institicionalizados
David Domingues, estudante n.º 2220897
Hugo Gomes, estudante n.º 2220893
Ruben Soares, estudante n.º 2220900
…
*/

DROP DATABASE IF EXISTS E7_Database;
CREATE DATABASE E7_Database;

USE E7_Database;

CREATE TABLE Pessoa (
    id INT PRIMARY KEY  NOT NULL AUTO_INCREMENT,
    pnome VARCHAR(15) NOT NULL,
    apelido VARCHAR(15) NOT NULL,
    genero ENUM('Masculino', 'Feminino', 'Outro') NOT NULL,
    dtaNascimento DATETIME NOT NULL
);

CREATE TABLE Funcionario (
    idPessoa INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    salario DECIMAL(10,2) NOT NULL,
    dtaContrato DATETIME NOT NULL,
    idCategoria INT NOT NULL,
    FOREIGN KEY (idPessoa) REFERENCES Pessoa(id),
    FOREIGN KEY (idCategoria) REFERENCES Categoria(id)
);

CREATE TABLE Utente (
    idPessoa INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    dtaEntrada DATE NOT NULL,
    idAcolhimento INT NOT NULL,
    FOREIGN KEY (idPessoa) REFERENCES Pessoa(id),
    FOREIGN KEY (idAcolhimento) REFERENCES Acolhimento(id)
);

CREATE TABLE Visitante (
    idPessoa INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    parentesco VARCHAR(12) NOT NULL,
    FOREIGN KEY (idPessoa) REFERENCES Pessoa(id)
);

CREATE TABLE Contacto (
    idVisitante INT NOT NULL,
    telemovel VARCHAR(20),
    PRIMARY KEY (idVisitante, telemovel),
    FOREIGN KEY (idVisitante) REFERENCES Visitante(idPessoa)
);

CREATE TABLE Categoria (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    funcao ENUM('Diretor', 'Animador', 'Técnico de Ação Social', 'Auxiliar de Ação Direta', 'Auxiliar de Serviços Gerais') NOT NULL
);

CREATE TABLE Acolhimento (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    delegacao ENUM('CPCJ', 'Segurança Social'),
    descricao VARCHAR(100)
);

CREATE TABLE Visita (
    id INT PRIMARY KEY,
    dtaVisita DATE NOT NULL,
    idUtente INT NOT NULL,
    idSala INT NOT NULL,
    idTipoVisita INT NOT NULL,
    idFuncionario INT NOT NULL,
    FOREIGN KEY (idUtente) REFERENCES Utente(idPessoa),
    FOREIGN KEY (idSala) REFERENCES Sala(id),
    FOREIGN KEY (idTipoVisita) REFERENCES TipoVisita(id),
    FOREIGN KEY (idFuncionario) REFERENCES funcionario(idPessoa)
);

CREATE TABLE TipoVisita (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    tipo enum('Na Instituição', 'Saída de Curta Duração', 'Saída de Longa Duração') NOT NULL,
    descricao VARCHAR(256)
);

CREATE TABLE Sala (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    edificio VARCHAR(3) NOT NULL,
    andar INT NOT NULL,
    porta VARCHAR(50)  NOT NULL
);

CREATE TABLE VisitanteVisita (
    idVisitante INT NOT NULL,
    idVisita INT NOT NULL,
    FOREIGN KEY (idVisitante) REFERENCES Visitante(idPessoa),
    FOREIGN KEY (idVisita) REFERENCES Visita(id)
);

DELIMITER $$
CREATE TRIGGER Insert_Pessoa
BEFORE INSERT ON Pessoa
FOR EACH ROW 
	BEGIN
		IF NEW.dtaNascimento > CURDATE()	THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Data inválida";
		END IF;
	END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER Update_Pessoa
BEFORE UPDATE ON Pessoa
FOR EACH ROW 
	BEGIN
		IF NEW.dtaNascimento > CURDATE()	THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Data inválida";
		END IF;
	END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER Insert_Utente
BEFORE INSERT ON Utente
FOR EACH ROW
	BEGIN
		IF NEW.dtaEntrada < (SELECT dtaNascimento FROM pessoa WHERE id = NEW.idPessoa) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Data de entrada não pode ser menor que a de Nascimento";
		END IF;
    END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER Update_Utente
BEFORE UPDATE ON Utente
FOR EACH ROW
	BEGIN
		IF NEW.dtaEntrada < (SELECT dtaNascimento FROM pessoa WHERE id = OLD.idPessoa) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Data de entrada não pode ser menor que a de Nascimento";
		END IF;
    END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER Insert_Funcionario
BEFORE INSERT ON Funcionario
FOR EACH ROW
	BEGIN
		IF NEW.dtaContrato < (SELECT dtaNascimento FROM pessoa WHERE id = NEW.idPessoa) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Data de contrato não pode ser menor que a de Nascimento";
		END IF;
    END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER Update_Funcionario
BEFORE UPDATE ON Funcionario
FOR EACH ROW
	BEGIN
		IF NEW.dtaContrato < (SELECT dtaNascimento FROM pessoa WHERE id = OLD.idPessoa) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Data de contrato não pode ser menor que a de Nascimento";
		END IF;
    END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER Inser_Visita
BEFORE INSERT ON visita
FOR EACH ROW
	BEGIN
		IF NEW.dtaVisita < CURDATE() THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Data de visita não pode ser menor que a atual";
		END IF;
	END$$
DELIMITER ;