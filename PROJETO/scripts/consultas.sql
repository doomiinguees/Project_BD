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
ORDER BY 6 ASC;

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


-- Selecionar as views criadas
SELECT * FROM v_SelectVisitante;