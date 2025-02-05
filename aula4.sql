create database aula4;
use aula4;
create table funcao(
	id_funcao int primary key auto_increment,
    nome varchar(45)
);
create table diretor(
	id_diretor int primary key auto_increment,
    nome varchar(45)
);
create table genero(
	id_genero int primary key auto_increment,
    nome varchar(45)
);
create table premiacao(
	id_premiacao int primary key auto_increment,
    nome varchar(45),
    ano int
);
create table filme(
	id_filme int primary key auto_increment,
    nomeBR varchar(45),
    nomeEN varchar(45),
    anoLancamento int,
    fk_id_diretor int,
    fk_id_genero int,
    sinopse text,
    foreign key(fk_id_diretor) references diretor(id_diretor),
    foreign key(fk_id_genero) references genero(id_genero)
);
create table filme_has_premiacao(
	id_premiacao int,
    fk_id_filme int,
    ganhou boolean,
    primary key(id_premiacao, fk_id_filme),
    foreign key(fk_id_filme) references filme(id_filme),
    foreign key(id_premiacao) references premiacao(id_premiacao)
);
create table sala(
	id_sala int primary key auto_increment,
    nome varchar(45),
    capacidade int
);
create table horario(
	id_horario int primary key auto_increment,
    horario time
);
create table filme_exibido_sala(
	fk_id_filme int,
    fk_id_sala int,
    fk_id_horario int,
    primary key(fk_id_filme, fk_id_sala, fk_id_horario),
    foreign key(fk_id_filme) references filme(id_filme),
    foreign key(fk_id_sala) references sala(id_sala),
    foreign key(fk_id_horario) references horario(id_horario)
);
create table funcionario(
	id_funcionario int primary key auto_increment,
    nome varchar(45),
    carteiraTrabalho int,
    datacontratacao date,
    salario float
);
create table horario_trabalho_funcionario(
	fk_id_horario int,
    fk_id_funcionario int,
    fk_id_funcao int,
	primary key(fk_id_horario, fk_id_funcionario, fk_id_funcao),
    foreign key(fk_id_horario) references horario(id_horario),
    foreign key(fk_id_funcionario) references funcionario(id_funcionario),
    foreign key(fk_id_funcao) references funcao(id_funcao)
);
-- Inserir na tabela 'funcao'
INSERT INTO funcao (nome) VALUES
('Gerente'),
('Atendente'),
('Coordenador'),
('Assistente'),
('Supervisor'),
('Diretor'),
('Analista'),
('Operador'),
('Vendedor'),
('Consultor');

-- Inserir na tabela 'diretor'
INSERT INTO diretor (nome) VALUES
('Steven Spielberg'),
('Christopher Nolan'),
('Quentin Tarantino'),
('Martin Scorsese'),
('James Cameron'),
('Ridley Scott'),
('Alfred Hitchcock'),
('George Lucas'),
('Peter Jackson'),
('David Fincher');

-- Inserir na tabela 'genero'
INSERT INTO genero (nome) VALUES
('Ação'),
('Comédia'),
('Drama'),
('Terror'),
('Ficção Científica'),
('Romance'),
('Mistério'),
('Documentário'),
('Aventura'),
('Animação');

-- Inserir na tabela 'premiacao'
INSERT INTO premiacao (nome, ano) VALUES
('Oscar', 2020),
('Globo de Ouro', 2019),
('Cannes Film Festival', 2021),
('BAFTA', 2020),
('Emmy', 2021),
('SAG Awards', 2019),
('Golden Globe', 2021),
('Critics\' Choice', 2022),
('Palme d\'Or', 2021),
('Venice Film Festival', 2020);

-- Inserir na tabela 'filme'
INSERT INTO filme (nomeBR, nomeEN, anoLancamento, fk_id_diretor, fk_id_genero, sinopse) VALUES
('Jurassic Park', 'Jurassic Park', 1993, 1, 1, 'Dinossauros são recriados em um parque temático, mas algo dá errado.'),
('Inception', 'Inception', 2010, 2, 5, 'Um ladrão especializado em roubo de segredos entra nos sonhos das pessoas.'),
('Pulp Fiction', 'Pulp Fiction', 1994, 3, 2, 'Três histórias interligadas sobre crime em Los Angeles.'),
('The Irishman', 'The Irishman', 2019, 4, 3, 'A história de um assassino de aluguel e sua relação com a máfia.'),
('Avatar', 'Avatar', 2009, 5, 6, 'Humanos tentam explorar os recursos de um planeta habitado por nativos.'),
('Alien', 'Alien', 1979, 6, 4, 'Uma tripulação de nave espacial encontra um ser alienígena mortal.'),
('Psycho', 'Psycho', 1960, 7, 7, 'Um suspense psicológico com o famoso assassinato na ducha.'),
('Star Wars', 'Star Wars', 1977, 8, 1, 'A luta entre o Império Galáctico e os Rebeldes.'),
('The Lord of the Rings', 'The Lord of the Rings', 2001, 9, 9, 'Uma jornada épica para destruir o Anel do Poder.'),
('Fight Club', 'Fight Club', 1999, 10, 3, 'Um homem insatisfeito com a vida funda um clube de combate secreto.');

select * from filme;
-- Inserir na tabela 'filme_has_premiacao'
INSERT INTO filme_has_premiacao (id_premiacao, fk_id_filme, ganhou) VALUES
(1, 21, TRUE),
(2, 22, TRUE),
(3, 23, FALSE),
(4, 24, TRUE),
(5, 25, TRUE),
(6, 26, FALSE),
(7, 27, TRUE),
(8, 28, TRUE),
(9, 29, TRUE),
(10, 30, FALSE);

-- Inserir na tabela 'sala'
INSERT INTO sala (nome, capacidade) VALUES
('Sala 1', 100),
('Sala 2', 80),
('Sala 3', 120),
('Sala 4', 90),
('Sala 5', 150),
('Sala 6', 200),
('Sala 7', 75),
('Sala 8', 130),
('Sala 9', 110),
('Sala 10', 160);

-- Inserir na tabela 'horario'
INSERT INTO horario (horario) VALUES
('10:00:00'),
('12:30:00'),
('15:00:00'),
('17:30:00'),
('20:00:00'),
('22:30:00'),
('14:00:00'),
('16:30:00'),
('18:30:00'),
('21:00:00');
INSERT INTO funcionario (nome, carteiraTrabalho, datacontratacao, salario) 
VALUES 
('Carlos Silva', 123456, '2015-03-20', 2500.00),
('Ana Costa', 234567, '2017-07-15', 3200.50),
('José Oliveira', 345678, '2019-01-10', 2900.00),
('Maria Santos', 456789, '2018-11-05', 3500.75),
('Pedro Alves', 567890, '2020-02-25', 2700.40),
('Julia Pereira', 678901, '2016-06-12', 3200.00),
('Rafael Gomes', 789012, '2019-08-18', 4000.30),
('Fernanda Lima', 890123, '2021-09-01', 2500.00),
('Ricardo Souza', 901234, '2022-01-22', 2800.50),
('Letícia Martins', 112233, '2020-05-30', 3500.00);

INSERT INTO horario_trabalho_funcionario (fk_id_horario, fk_id_funcionario, fk_id_funcao)
VALUES
(1, 4, 1),  
(2, 2, 2),  
(3, 3, 7), 
(4, 5, 4),  
(5, 7, 5),  
(6, 9, 8),  
(10, 4, 7),  
(2, 1, 2),  
(3, 6, 1),  
(4, 2, 2);

select * from horario_trabalho_funcionario;
select * from filme_exibido_sala;
-- Inserir na tabela 'filme_exibido_sala' com filmes sendo exibidos em mais de uma sala
INSERT INTO filme_exibido_sala (fk_id_filme, fk_id_sala, fk_id_horario) VALUES
(21, 1, 1),  -- Jurassic Park na Sala 1 às 10:00
(21, 2, 2),  -- Jurassic Park na Sala 2 às 12:30
(31, 3, 3),  -- Inception na Sala 3 às 15:00
(32, 4, 4),  -- Inception na Sala 4 às 17:30
(23, 5, 5),  -- Pulp Fiction na Sala 5 às 20:00
(23, 6, 6),  -- Pulp Fiction na Sala 6 às 22:30
(36, 7, 7),  -- The Irishman na Sala 7 às 14:00
(27, 8, 8),  -- The Irishman na Sala 8 às 16:30
(28, 9, 9),  -- Avatar na Sala 9 às 18:30
(37, 10, 10), -- Avatar na Sala 10 às 21:00
(24, 1, 1),  -- Alien na Sala 1 às 10:00
(24, 2, 2),  -- Alien na Sala 2 às 12:30
(29, 3, 3),  -- Psycho na Sala 3 às 15:00
(28, 4, 4),  -- Psycho na Sala 4 às 17:30
(38, 5, 5),  -- Star Wars na Sala 5 às 20:00
(38, 6, 6),  -- Star Wars na Sala 6 às 22:30
(39, 7, 7),  -- The Lord of the Rings na Sala 7 às 14:00
(39, 8, 8),  -- The Lord of the Rings na Sala 8 às 16:30
(25, 9, 9), -- Fight Club na Sala 9 às 18:30
(33, 10, 10); -- Fight Club na Sala 10 às 21:00


select * from filme;

-- 1)- media dos salarios 
select avg(salario) from funcionario; 

-- 2)- listar todos os funcionarios e suas funções.
SELECT f.nome AS nome_funcionario, fu.nome AS nome_funcao
FROM funcionario f
JOIN horario_trabalho_funcionario ht ON f.id_funcionario = ht.fk_id_funcionario
JOIN funcao fu ON ht.fk_id_funcao = fu.id_funcao;

-- 3)- nome de todos os funcionarios com o mesmo horario
select f.nome as nome_funcionario, h.horario from horario_trabalho_funcionario ht
join horario h on ht.fk_id_horario = h.id_horario join funcionario f on ht.fk_id_funcionario = f.id_funcionario
where h.horario in ( select h.horario from horario_trabalho_funcionario ht
join horario h on ht.fk_id_horario = h.id_horario group by h.horario having count(ht.fk_id_funcionario) > 1);

-- 4)- encontrar flmes que foram exibidos em pelo menos duas salaas diferentes.
select f.nomeBR, f.nomeEN, count(distinct fes.fk_id_sala) as numero_de_salas
from filme_exibido_sala fes
join filme f on fes.fk_id_filme = f.id_filme
group by fes.fk_id_filme
having numero_de_salas >= 2; 

-- 5)- listar todos os filmes e seus respectivos generos.
select Distinct f.nomeBR, f.nomeEN, g.nome as nome_genero from filme f join genero g on f.fk_id_genero = g.id_genero;

-- 6)- filmes que recebram premios e tiveram pelo menos 1 exibição
select f.nomeBR, f.nomeEN, fhp.ganhou
from filme f
join filme_has_premiacao fhp on f.id_filme = fhp.fk_id_filme
join filme_exibido_sala fes on f.id_filme = fes.fk_id_filme
where fhp.ganhou = true
group by fhp.fk_id_filme
having count(distinct fes.fk_id_sala);


-- 7)-listar todos os filmes que não receberam nenhum premio
select f.nomeBR, f.nomeEN, fhp.ganhou
from filme f
join filme_has_premiacao fhp on f.id_filme = fhp.fk_id_filme
where fhp.ganhou < 1;

-- 8)- exibir diretores que dirigiram pelo menos 2 filmes
SELECT d.nome
FROM diretor d
JOIN filme f ON d.id_diretor = f.fk_id_diretor
GROUP BY d.id_diretor
HAVING COUNT(f.id_filme) >= 2;

-- 9)-
select f.nome, h.horario from funcionario f 
join horario_trabalho_funcionario htf on f.id_funcionario = htf.fk_id_funcionario
join horario h on htf.fk_id_horario = h.id_horario
order by h.horario;
-- 10)-
SELECT f.nomeBR, s.nome, COUNT(DISTINCT h.horario) AS numero_de_horarios
FROM filme f
JOIN filme_exibido_sala fes ON f.id_filme = fes.fk_id_filme
JOIN sala s ON fes.fk_id_sala = s.id_sala
JOIN horario h ON fes.fk_id_horario = h.id_horario
GROUP BY f.id_filme, s.id_sala
HAVING COUNT(DISTINCT h.horario) > 1;

-- 11)-
SELECT d.nome AS nome, 'Diretor' AS tipo
FROM diretor d
UNION
SELECT func.nome AS nome, 'Funcionario' AS tipo
FROM funcionario func
ORDER BY nome;


-- 12)-
SELECT fu.nome AS nome_funcao, COUNT(htf.fk_id_funcionario) AS quantidade_funcionarios
FROM funcao fu
JOIN horario_trabalho_funcionario htf ON fu.id_funcao = htf.fk_id_funcao
GROUP BY fu.id_funcao
ORDER BY quantidade_funcionarios DESC;

-- 13)-
-- 14)-
-- 15)-


