/*
TeSP_PSI_22_23_CDBD
Sistema de Gestão de Visitas de Crianças e Jovens Institicionalizados
David Domingues, estudante n.º 2220897
Hugo Gomes, estudante n.º 2220893
Ruben Soares, estudante n.º 2220900
…
*/
-- Cração das Views

CREATE OR REPLACE VIEW v_SelectUtente AS
	SELECT CONCAT(p.pnome, ' ', p.apelido) AS NomeCompleto,
			DATE_FORMAT(p.dtaNascimento, '%Y-%m-%d') AS dtaNascimento,
            p.genero,
			TIMESTAMPDIFF(YEAR, p.dtaNascimento, CURDATE()) AS Idade,
			u.dtaEntrada,
			CONCAT(a.delegacao, ' - ', a.descricao) AS Acolhimento
	FROM Utente u
	INNER JOIN Pessoa p ON u.idPessoa = p.id
	INNER JOIN Acolhimento a ON u.idAcolhimento = a.id;

CREATE OR REPLACE VIEW v_SelectFuncionario AS
	SELECT 	CONCAT(p.pnome, ' ', p.apelido) AS NomeCompleto,
			DATE_FORMAT(p.dtaNascimento, '%Y-%m-%d') AS dtaNascimento,
			TIMESTAMPDIFF(YEAR, p.dtaNascimento, CURDATE()) AS Idade,
			DATE_FORMAT(f.dtaContrato, '%Y-%m-%d') AS dtaContrato,
			TIMESTAMPDIFF(YEAR, f.dtaContrato, CURDATE()) AS AnosDeContrato,
			c.funcao
	FROM Funcionario f
	INNER JOIN Pessoa p ON f.idPessoa = p.id
	INNER JOIN Categoria c ON f.idCategoria = c.id;

CREATE OR REPLACE VIEW v_SelectVisitante AS
	SELECT	v.idPessoa,
			p.pnome,
			p.apelido,
            p.genero,
            DATE_FORMAT(p.dtaNascimento, '%Y-%m-%d') AS dtaNascimentoo,
            GROUP_CONCAT(IFNULL(c.telemovel, 'Sem contacto associado')SEPARATOR ', ') AS Contacto
	FROM Visitante v
	INNER JOIN Pessoa p ON v.idPessoa = p.id
	LEFT JOIN Contacto c ON v.idPessoa = c.idVisitante
    GROUP BY v.idPessoa;

-- Criação de Users e atribuição de previlégios
DROP USER 'diretor'@'localhost';
DROP USER 'tasocial'@'localhost';
CREATE USER 'diretor'@'localhost' IDENTIFIED BY 'diretor';
CREATE USER 'tasocial'@'localhost' IDENTIFIED BY 'taSocial';


-- Permissões para o user 'diretor'
GRANT ALL PRIVILEGES ON e7_database.* TO 'diretor'@'localhost' WITH GRANT OPTION;

-- Permissões para o user 'tasocial'
GRANT SELECT ON v_SelectUtente TO 'tasocial'@'localhost';
GRANT SELECT ON v_SelectVisitante TO 'tasocial'@'localhost';
GRANT INSERT ON visita TO 'tasocial'@'localhost';
