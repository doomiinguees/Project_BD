/*
TeSP_PSI_22_23_CDBD
Sistema de Gestão de Visitas de Crianças e Jovens Institicionalizados
David Domingues, estudante n.º 2220897
Hugo Gomes, estudante n.º 2220893
Ruben Soares, estudante n.º 2220900
…
*/

-- Qual o tipo de acolhimento de cada utente?
SELECT * FROM v_selectutente;

-- Consultar os dados de da tabela Pessoa com o respetivo perfil
SELECT
    p.*,
    CASE
        WHEN f.idPessoa IS NOT NULL THEN 'Funcionario'
        WHEN u.idPessoa IS NOT NULL THEN 'Utente'
        WHEN v.idPessoa IS NOT NULL THEN 'Visitante'
    END AS Perfil
FROM Pessoa p
	LEFT JOIN Funcionario f ON p.id = f.idPessoa
	LEFT JOIN Utente u ON p.id = u.idPessoa
	LEFT JOIN Visitante v ON p.id = v.idPessoa
ORDER BY id ASC;

-- consulta visitas de cada visitante com o respetivo utente, ordenado por data mais aintiga
SELECT	v.id AS idVisita,
		CONCAT(pv.pnome, ' ', pv.apelido) AS NomeVisitante, 
        CONCAT(pu.pnome, ' ', pu.apelido) AS NomeUtente
FROM Visita v
	JOIN Utente u ON v.idUtente = u.idPessoa
	JOIN VisitanteVisita vv ON v.id = vv.idVisita
	JOIN Visitante vi ON vv.idVisitante = vi.idPessoa
	JOIN Pessoa pv ON vi.idPessoa = pv.id
	JOIN Pessoa pu ON u.idPessoa = pu.id
ORDER BY v.dtaVisita ASC;

-- Quais funcionários são também visitantes
SELECT	p.id,
		CONCAT(p.pnome, ' ', p.apelido) AS Nome,
        c.funcao AS Função,
        v.parentesco AS Parentesco
FROM Pessoa p
JOIN Funcionario f ON p.id = f.idPessoa
JOIN Visitante v ON p.id = v.idPessoa
JOIN categoria c ON f.idCategoria = c.id;

-- Quantas salas existem para realização de visitas na instituição?
SELECT	COUNT(*) AS NumeroDeSalas
FROM sala
WHERE edificio != '0';

-- Qual a função de cada um dos funcionários? E há quantos anos estão contratados?
SELECT * FROM v_selectfuncionario;


-- Qual a idade e o parentesco de cada visitante
SELECT * FROM v_SelectVisitante;

-- Total de visitas por tipo de visita
SELECT tv.descricao AS TipoVisita, 
    (
        SELECT COUNT(*)
        FROM Visita v
        WHERE v.idTipoVisita = tv.id
    ) AS TotalVisitas
FROM TipoVisita tv;

-- Consulta que apresenta dos dados da visita, com todos os valores substituidos pela informaçã adjacente ao id registado
SELECT v.id, v.dtaVisita,
       CONCAT(ut.pnome, ' ', ut.apelido) AS NomeUtente,
       CONCAT(f.pnome, ' ', f.apelido) AS NomeFuncionario,
       CONCAT(vi.pnome, ' ', vi.apelido) AS NomeVisitante,
       CONCAT(s.edificio, '.', s.andar, '.', s.porta) AS Sala,
       (SELECT descricao FROM TipoVisita WHERE id = v.idTipoVisita) AS TipoVisita
FROM Visita v
INNER JOIN Utente u ON v.idUtente = u.idPessoa
INNER JOIN Pessoa ut ON u.idPessoa = ut.id
INNER JOIN Funcionario fu ON v.idFuncionario = fu.idPessoa
INNER JOIN Pessoa f ON fu.idPessoa = f.id
INNER JOIN VisitanteVisita vv ON v.id = vv.idVisita
INNER JOIN Pessoa vi ON vv.idVisitante = vi.id
LEFT JOIN Sala s ON v.idSala = s.id
ORDER BY year(dtaVisita) DESC;

-- Número de visitas por ano
SELECT EXTRACT(YEAR FROM dtaVisita) AS Ano, COUNT(*) AS NumVisitas
FROM Visita
GROUP BY Ano;

-- Quantidade de visitas por faixa etária dos utentes
SELECT CASE
    WHEN TIMESTAMPDIFF(YEAR, p.dtaNascimento, CURDATE()) BETWEEN 0 AND 5 THEN ' 0 - 5 anos'
    WHEN TIMESTAMPDIFF(YEAR, p.dtaNascimento, CURDATE()) BETWEEN 6 AND 12 THEN ' 6 - 12 anos'
    WHEN TIMESTAMPDIFF(YEAR, p.dtaNascimento, CURDATE()) BETWEEN 13 AND 18 THEN '13 - 18 anos'
    ELSE 'Maior de 18 anos'
    END AS FaixaEtaria,
    COUNT(*) AS NumVisitas
FROM Visita v
INNER JOIN Utente u ON v.idUtente = u.idPessoa
INNER JOIN Pessoa p ON u.idPessoa = p.id
GROUP BY FaixaEtaria
ORDER BY FaixaEtaria ASC;