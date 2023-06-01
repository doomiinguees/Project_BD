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
    idVisitante INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    telemovel VARCHAR(20),
    FOREIGN KEY (idVisitante) REFERENCES Visitante(idPessoa)
);

CREATE TABLE Categoria (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    funcao ENUM('Diretor', 'Animador', 'Técnica de Ação Social', 'Ajudante de Ação Direta')
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
    FOREIGN KEY (idUtente) REFERENCES Utente(idPessoa),
    FOREIGN KEY (idSala) REFERENCES Sala(id),
    FOREIGN KEY (idTipoVisita) REFERENCES TipoVisita(id)
);

CREATE TABLE TipoVisita (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    tipo enum('Na Instituição', 'Saída de Curta Duração', 'Saída de Longa Duração'),
    descricao VARCHAR(100)
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

CREATE TRIGGER Insert_Pessoa
	BEFORE INSERT ON Pessoa
	FOR EACH ROW 
		BEGIN
			IF NEW.dtaNascimento > CURDATE()	THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Data inválida";
			END IF;
		END;
