/*
TeSP_PSI_22_23_CDBD
Sistema de Gestão de Visitas de Crianças e Jovens Institicionalizados
David Domingues, estudante n.º 2220897
Hugo Gomes, estudante n.º 2220893
Ruben Soares, estudante n.º 2220900
…
*/

INSERT INTO pessoa (`pnome`, `apelido`, `genero`, `dtanascimento`)
	VALUES
		('Deolinda', 'Gomes', 'Feminino', '1986-02-15'), -- f
        ('David', 'Silva', 'Masculino', '1990-02-19'), -- f
        ('Jose', 'Gomes', 'Masculino', '1976-12-11'), -- v
        ('Maria', 'Pacheco', 'Feminino', '1990-08-08'), -- f
        ('Marco', 'Ramos', 'Masculino', '2007-01-28'), -- u
        ('Fabio','Serrano', 'Masculino', '2000-08-12'), -- v
		('Fabiana', 'Varela', 'Feminino', '1990-03-08'), -- v
        ('Luís', 'Madeira', 'Masculino', '2020-05-10'); -- u

INSERT INTO categoria (`funcao`) 
	VALUES 
		('Animador'),
        ('Diretor'),
        ('Técnico de Ação Social'),
        ('Auxiliar de Serviços Gerais'),
        ('Auxiliar de Ação Direta');

INSERT INTO acolhimento (id, delegacao, descricao)
	VALUES
		(1, 'CPCJ', 'Comissão de Proteção de Crianças e Jovens - Leiria'),
        (2, 'Segurança Social', 'Serviços de Ação Social - Caldas da Rainha');

INSERT INTO funcionario (idPessoa, salario, dtacontrato, idCategoria)
	VALUES
        (1, '1200', '2004-05-25', 2),
        (2, '1000', '2005-04-28', 3),
        (4, '900', '2015-01-21', 1);

INSERT INTO visitante (idpessoa, parentesco)
	VALUES
		(3, 'Pai'),
        (6, 'Primo'),
        (7, 'Mãe');

INSERT INTO utente (idPessoa, dtaEntrada, idAcolhimento)
	VALUES
		(5, '2010-04-14', 1),
        (8, '2020-05-11', 2);

INSERT INTO sala (`edificio`,`andar`,`porta`)
	VALUES
		('A', '1', '12'),
        ('A', '2', '6'),
        ('B', '1', '5'),
        ('B', '2', '4'),
        ('C', '1', '8');
      
INSERT INTO Contacto (idVisitante, telemovel)
	VALUES
        (3, '916369789'),
        (3, '963852741');

