/*1 artigos vendidos num dado período (i.e. entre duas datas), por dia da semana, por concelho e no total*/
SELECT SUM(unidades) AS totalvendas
FROM vendas
WHERE totalvendas.ano >= givenano1 AND totalvendas.ano <= givenano2
GROUP BY (concelho, dia_semana, ());
/*2 artigos vendidos num dado distrito (i.e. “Lisboa”), por concelho, categoria, dia da semana e no total*/

SELECT SUM(unidades) AS totalvendas
FROM vendas
WHERE vendas.distrito = givendistrito
GROUP BY (concelho, cat, dia_semana, ());