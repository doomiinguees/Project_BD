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
			p.dtanascimento,
            p.genero,
			TIMESTAMPDIFF(YEAR, p.dtaNascimento, CURDATE()) AS Idade,
			u.dtaEntrada,
			a.descricao AS Tipo_Acolhimento
	FROM Utente u
	INNER JOIN Pessoa p ON u.idPessoa = p.id
	INNER JOIN Acolhimento a ON u.idAcolhimento = a.id;

CREATE OR REPLACE VIEW v_SelectFuncionario AS
	SELECT CONCAT(p.pnome, ' ', p.apelido) AS NomeCompleto,
			p.dtaNascimento,
		   TIMESTAMPDIFF(YEAR, p.dtaNascimento, CURDATE()) AS Idade,
		   f.dtaContrato,
           c.funcao
	FROM Funcionario f
	INNER JOIN Pessoa p ON f.idPessoa = p.id
	INNER JOIN Categoria c ON f.idCategoria = c.id;

CREATE OR REPLACE VIEW v_SelectVisitante AS
SELECT CONCAT(p.pnome, ' ', p.apelido) AS NomeCompleto,
       p.dtaNascimento,
       TIMESTAMPDIFF(YEAR, p.dtaNascimento, CURDATE()) AS Idade,
       v.parentesco,
       IFNULL(c.telemovel, 'Sem Telefone') AS Contacto
FROM visitante v
INNER JOIN Contacto c ON v.idPessoa = c.idPessoa
INNER JOIN Pessoa p ON v.idPessoa = p.id;

-- Criação de Users e atribuição de previlégios
