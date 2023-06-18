/*
TeSP_PSI_22_23_CDBD
Sistema de Gestão de Visitas de Crianças e Jovens Institicionalizados
David Domingues, estudante n.º 2220897
Hugo Gomes, estudante n.º 2220893
Ruben Soares, estudante n.º 2220900
…
*/

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

-- consulta de visitas realizadas por ordem temporal

-- Selecionar as views criadas
SELECT * FROM v_selectfuncionario;
SELECT * FROM v_selectutente;
SELECT * FROM v_SelectVisitante;