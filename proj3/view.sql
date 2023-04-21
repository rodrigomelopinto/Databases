create view vendas(ean,cat,ano,trimestre,mes,dia_mes,dia_semana,distrito,concelho,unidades) as
select ean,cat,EXTRACT(YEAR from evento_reposicao.instante) as ano, EXTRACT(QUARTER from evento_reposicao.instante) as trimestre, 
EXTRACT(MONTH from evento_reposicao.instante) as mes, EXTRACT(DAY from evento_reposicao.instante) as dia_mes, 
EXTRACT(DOW from evento_reposicao.instante) as dia_semana, distrito,concelho,unidades from produto natural join categoria
natural join evento_reposicao natural join ponto_de_retalho;