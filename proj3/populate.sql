DROP TABLE IF EXISTS categoria;
DROP TABLE IF EXISTS categoria_simples;
DROP TABLE IF EXISTS super_categoria;
DROP TABLE IF EXISTS tem_outra;
DROP TABLE IF EXISTS produto;
DROP TABLE IF EXISTS tem_categoria;
DROP TABLE IF EXISTS IVM;
DROP TABLE IF EXISTS ponto_de_retalho;
DROP TABLE IF EXISTS instalada_em;
DROP TABLE IF EXISTS prateleira;
DROP TABLE IF EXISTS planograma;
DROP TABLE IF EXISTS retalhista;
DROP TABLE IF EXISTS responsavel_por;
DROP TABLE IF EXISTS evento_reposicao;

CREATE TABLE categoria 
    (nome VARCHAR(50) NOT NULL,
    PRIMARY KEY (nome));

CREATE TABLE categoria_simples 
    (nome VARCHAR(50),
    PRIMARY KEY (nome),
    FOREIGN KEY (nome) references categoria(nome) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE super_categoria 
    (nome VARCHAR(50) NOT NULL,
    PRIMARY KEY (nome),
    FOREIGN KEY (nome) references categoria(nome) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE tem_outra
    (super_categoria VARCHAR(50) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    PRIMARY KEY (categoria),
    FOREIGN KEY (super_categoria) references super_categoria(nome) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (categoria) references categoria(nome) ON DELETE CASCADE ON UPDATE CASCADE,
    CHECK (super_categoria != categoria));

CREATE TABLE produto
    (ean CHAR(13) NOT NULL,
    cat VARCHAR(50),
    descr VARCHAR(500),
    PRIMARY KEY (ean),
    FOREIGN KEY (cat) references categoria(nome) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE tem_categoria
    (ean CHAR(13),
    nome VARCHAR(50),
    FOREIGN KEY (ean) references produto(ean) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (nome) references categoria(nome) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE IVM
    (num_serie INTEGER,
    fabricante VARCHAR(50),
    PRIMARY KEY (num_serie, fabricante));

CREATE TABLE ponto_de_retalho
    (nome VARCHAR(50),
    distrito VARCHAR(50),
    concelho VARCHAR(50),
    PRIMARY KEY(nome));

CREATE TABLE instalada_em
    (num_serie INTEGER,
    fabricante VARCHAR(50),
    loc VARCHAR(50),
    PRIMARY KEY(num_serie, fabricante),
    FOREIGN KEY(num_serie, fabricante) references IVM(num_serie,fabricante) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(loc) references ponto_de_retalho(nome) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE prateleira
    (nro INTEGER,
    num_serie INTEGER,
    fabricante VARCHAR(50),
    altura INTEGER,
    nome VARCHAR(50),
    PRIMARY KEY(nro, num_serie, fabricante),
    FOREIGN KEY(num_serie, fabricante) references IVM(num_serie,fabricante) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(nome) references categoria(nome) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE planograma
    (ean CHAR(13),
    nro INTEGER,
    num_serie INTEGER,
    fabricante VARCHAR(50),
    faces INTEGER,
    unidades INTEGER,
    loc VARCHAR(50),
    PRIMARY KEY(ean, nro, num_serie, fabricante),
    FOREIGN KEY(num_serie, fabricante, nro) references prateleira(num_serie,fabricante,nro) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(ean) references produto(ean) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE retalhista
    (tin VARCHAR(50),
    nome VARCHAR(50) UNIQUE,
    PRIMARY KEY(tin));

CREATE TABLE responsavel_por
    (tin VARCHAR(50),
    nome_cat VARCHAR(50),
    num_serie INTEGER,
    fabricante VARCHAR(50),
    PRIMARY KEY(num_serie,fabricante),
    FOREIGN KEY(num_serie,fabricante) references IVM(num_serie,fabricante) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(tin) references retalhista(tin) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(nome_cat) references categoria(nome) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE evento_reposicao
    (ean CHAR(13),
    nro INTEGER,
    num_serie INTEGER,
    fabricante VARCHAR(50),
    instante TIMESTAMP,
    unidades INTEGER,
    tin VARCHAR(50),
    PRIMARY KEY(ean,nro,num_serie,fabricante,instante),
    FOREIGN KEY(ean,nro,num_serie,fabricante) references planograma(ean,nro,num_serie,fabricante) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(tin) references retalhista(tin) ON DELETE CASCADE ON UPDATE CASCADE);

/* ---------------------------------Populate-------------------------------------------------------------------*/

insert into categoria values ('Fruta');
insert into categoria values ('Vegetal');
insert into categoria values ('Bolachas');
insert into categoria values ('Carne');
insert into categoria values ('Peixe');
insert into categoria values ('Flor');
insert into categoria values ('Banana');
insert into categoria values ('Chocolate');
insert into categoria values ('Kit kat');
insert into categoria values ('Twix');
insert into categoria values ('Oreo');
insert into categoria values ('Melancia');
insert into categoria values ('Melão');
insert into categoria values ('Cereja');
insert into categoria values ('Alface');

insert into categoria_simples values ('Cereja');
insert into categoria_simples values ('Alface');
insert into categoria_simples values ('Oreo');
insert into categoria_simples values ('Melão');
insert into categoria_simples values ('Melancia');
insert into categoria_simples values ('Twix');
insert into categoria_simples values ('Kit kat');
insert into categoria_simples values ('Banana');

insert into super_categoria values ('Fruta');
insert into super_categoria values ('Vegetal');
insert into super_categoria values ('Bolachas');
insert into super_categoria values ('Carne');
insert into super_categoria values ('Peixe');
insert into super_categoria values ('Flor');
insert into super_categoria values ('Chocolate');

insert into tem_outra values ('Fruta',	 'Banana');
insert into tem_outra values ('Fruta', 'Cereja');
insert into tem_outra values ('Fruta',	 'Melão');
insert into tem_outra values ('Fruta', 'Melancia');
insert into tem_outra values ('Bolachas',	 'Oreo');
insert into tem_outra values ('Vegetal', 'Alface');
insert into tem_outra values ('Chocolate',   'Twix');
insert into tem_outra values ('Chocolate',	 'Kit kat');

insert into produto values ('1234567890123', 'Banana','Banana da madeira');
insert into produto values ('2345678901234', 'Oreo','Gelado oreo');
insert into produto values ('3456789012345', 'Kit kat','Kit kat max');
insert into produto values ('4567890123456', 'Melancia','Melancia de verão');
insert into produto values ('5678901234567', 'Alface','Alface fresca');
insert into produto values ('6789012345678', 'Cereja','Cereja fresca');
insert into produto values ('7890123456789', 'Banana','Banana de barco');
insert into produto values ('8901234567890', 'Oreo','Bolacha Oreo');
insert into produto values ('9012345678901', 'Banana','Banana de avião');

insert into tem_categoria values ('1234567890123','Banana');
insert into tem_categoria values ('2345678901234',	'Bolachas');
insert into tem_categoria values ('3456789012345',	'Oreo');
insert into tem_categoria values ('4567890123456',	'Melancia');
insert into tem_categoria values ('5678901234567',  'Alface');
insert into tem_categoria values ('6789012345678',	'Cereja');
insert into tem_categoria values ('7890123456789',	'Banana');
insert into tem_categoria values ('8901234567890',	'Bolachas');
insert into tem_categoria values ('9012345678901',	'Banana');

insert into IVM values (1,'F1');
insert into IVM values (2,	'F2');
insert into IVM values (3,	'F3');
insert into IVM values (4,	'F4');
insert into IVM values (5,	'F5');
insert into IVM values (6,'F6');
insert into IVM values (7,	'F7');
insert into IVM values (8,	'F8');
insert into IVM values (9,	'F9');
insert into IVM values (10,	'F10');
insert into IVM values (11,'F11');
insert into IVM values (12,	'F12');

insert into ponto_de_retalho values ('Colombo','Lisboa','Lisboa');
insert into ponto_de_retalho values ('Estadio do Dragão',	'Porto', 'Vila Nova de Gaia');
insert into ponto_de_retalho values ('Loja do ze',	'Lisboa', 'Torres Vedras');
insert into ponto_de_retalho values ('Grab and Go',	'Braga', 'Braga');
insert into ponto_de_retalho values ('Shopping',	'Viseu', 'Viseu');

insert into instalada_em values (1,'F1','Colombo');
insert into instalada_em values (2,	'F2', 'Estadio do Dragão');
insert into instalada_em values (3,	'F3', 'Loja do ze');
insert into instalada_em values (4,	'F4', 'Grab and Go');
insert into instalada_em values (5,	'F5', 'Shopping');

insert into prateleira values (1,1, 'F1',2,'Banana');
insert into prateleira values (2,1, 'F1',1,'Melancia');
insert into prateleira values (3,1, 'F1',3,'Oreo');
insert into prateleira values (4,2,	'F2',1,'Melancia');
insert into prateleira values (5,3,	'F3',2,'Alface');
insert into prateleira values (6,3,	'F3',3,'Fruta');
insert into prateleira values (7,4,	'F4',1,'Banana');
insert into prateleira values (8,4,	'F4',2,'Bolachas');
insert into prateleira values (9,5,	'F5',1,'Fruta');

insert into planograma values ('1234567890123',1,1,   'F1',2,5,'Colombo');
insert into planograma values ('4567890123456',4,2,   'F2',3,6,'Estadio do Dragão');
insert into planograma values ('5678901234567',5,3,   'F3',1,4,'Loja do ze');
insert into planograma values ('3456789012345',7,4,	'F4',3,7, 'Grab and Go');

insert into retalhista values ('id1','José');
insert into retalhista values ('id2','João');
insert into retalhista values ('id3','Jorge');
insert into retalhista values ('id4','Acácio');

insert into responsavel_por values ('id1','Banana',1,'F1');
insert into responsavel_por values ('id2','Banana',4,'F4');
insert into responsavel_por values ('id3','Melancia',2,'F2');
insert into responsavel_por values ('id4','Fruta',5,'F5');
insert into responsavel_por values ('id2','Cereja',6,'F6');
insert into responsavel_por values ('id2','Alface',7,'F7');
insert into responsavel_por values ('id2','Oreo',8,'F8');
insert into responsavel_por values ('id2','Melão',9,'F9');
insert into responsavel_por values ('id2','Melancia',10,'F10');
insert into responsavel_por values ('id2','Twix',11,'F11');
insert into responsavel_por values ('id2','Kit kat',12,'F12');

insert into evento_reposicao values ('1234567890123',1,1,'F1','2018-7-1 19:42:50',3,'id1');
insert into evento_reposicao values ('4567890123456',4,2,'F2','2016-8-1 15:42:50',2,'id1');
insert into evento_reposicao values ('1234567890123',1,1,'F1','2017-8-1 15:42:50',3,'id2');
insert into evento_reposicao values ('5678901234567',5,3,'F3','2017-8-6 15:42:50',3,'id1');