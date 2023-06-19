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
        ('Renato', 'Botelho', 'Masculino', '1971-02-25'), -- f1
		('Inês', 'Gomes', 'Feminino', '1995-02-15'), -- f2
        ('Tatiana', 'Martins', 'Feminino', '1998-08-08'), -- f3
        ('Paula', 'Amaro', 'Feminino', '1967-02-19'), -- f4
        ('Andreia', 'Gonçalves', 'Feminino', '1990-02-19'), -- f5
        ('Jose', 'Gomes', 'Masculino', '1976-12-11'), -- v6
        ('Fabio','Serrano', 'Masculino', '2000-08-12'), -- v7
		('Fabiana', 'Varela', 'Feminino', '1985-03-08'), -- v8
		('Silvia', 'Domingues', 'Feminino', '1990-03-08'), -- v9
        ('Marco', 'Ramos', 'Masculino', '2007-01-28'), -- u10
        ('Luís', 'Madeira', 'Masculino', '2020-05-10'), -- u11
		('Túlia', 'Pereira', 'Feminino', '2016-10-08'), -- u12
		('Jacinta', 'Afonso', 'Feminino', '2010-08-21'); -- u13

INSERT INTO categoria (`funcao`) 
	VALUES 
        ('Diretor'),
		('Animador'),
        ('Técnico de Ação Social'),
        ('Auxiliar de Serviços Gerais'),
        ('Auxiliar de Ação Direta');

INSERT INTO acolhimento (delegacao, descricao)
	VALUES
		('CPCJ', 'Comissão de Proteção de Crianças e Jovens - Leiria'),
        ('Segurança Social', 'Serviços de Ação Social - Caldas da Rainha'),
        ('Segurança Social', 'Serviços de Ação Social - Leiria'),
        ('Segurança Social', 'Serviços de Ação Social - Peniche');
        
INSERT INTO funcionario (idPessoa, salario, dtacontrato, idCategoria)
	VALUES
        (1, '1200', '2010-05-25', 1),
        (2, '1050', '2018-04-28', 2),
        (3, '1150', '2020-02-17', 3),
        (4, '756.5', '2002-01-21', 4),
        (5, '852', '2016-11-02', 5);

INSERT INTO visitante (idpessoa, parentesco)
	VALUES
		(5, 'Família de Apoio'),
		(6, 'Pai'),
        (7, 'Primo'),
        (8, 'Mãe'),
        (9, 'Mãe');

INSERT INTO utente (idPessoa, dtaEntrada, idAcolhimento)
	VALUES
		(10, '2009-04-14', 1),
		(11, '2020-05-11', 4),
		(12, '2020-12-20', 3),
        (13, '2015-09-30', 2);

INSERT INTO sala (edificio, andar, porta)
	VALUES
		('0', '0', '0'),
		('A', '1', '12'),
        ('A', '2', '6'),
        ('B', '1', '5'),
        ('B', '2', '4'),
        ('C', '1', '8');
      
INSERT INTO Contacto (idVisitante, telemovel)
	VALUES
        (6, '916369789'),
        (7, '926369789'),
        (7, '925969789'),
        (8, '916365009'),
        (9, '922903564');

INSERT INTO TipoVisita (tipo, descricao)
	VALUES
		('Na Instituição', 'Visita controlada por técnico/funcionário nas instalações da instituição'),
		('Saída de Curta Duração', 'Criança/Jovem vai sair das instalações da intituição acompanhada do visitante com tempo de duração inferior a um dia'),
		('Saída de Longa Duração', 'Criança/Jovem vai sair das instalações da intituição acompanhada do visitante com tempo de duração superior a um dia');
        
INSERT INTO visita (dtaVisita, idUtente, idSala, idTipoVisita, idFuncionario)
	VALUES
		('2023-06-19', 10, 3, 1, 2),
        ('2023-05-30', 12, 1, 2, 1),
        ('2022-10-10', 13, 1, 3, 3),
        ('2022-12-23', 11, 1, 3, 2);
        
INSERT INTO visitanteVisita (idVisitante, idVisita)
	VALUES
		(9, 1),
		(6, 2),
		(8, 3),
		(7, 4);