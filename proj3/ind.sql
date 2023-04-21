create index prod_index on responsavel_por using hash(nome_cat);

/*explain analyse SELECT DISTINCT R.nome FROM retalhista R, responsavel_por P WHERE R.tin = P.tin and P. nome_cat = 'Frutos';*/

create index nome_index on tem_categoria(nome);
create index cat_index on produto using hash(cat);

/*explain analyse SELECT T.nome, count(T.ean) FROM produto P, tem_categoria T WHERE p.cat = T.nome and P.descr like 'A%' GROUP BY T.nome;*/