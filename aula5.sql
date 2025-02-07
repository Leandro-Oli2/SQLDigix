create database aula5;
use aula5;
create table atividade(
	id_atividade int primary key auto_increment,
    nome varchar(100) not null
);
create table instrutor(
	id_instrutor int primary key auto_increment,
    rg int not null,
    nome varchar(100) not null,
    nascimento date,
    titulacao int
);
create table telefone_instrutor(
	id_telefone int,
    fk_id_instrutor int,
    numero varchar(20) not null,
    tipo varchar(45),
    primary key(id_telefone, fk_id_instrutor),
    foreign key (fk_id_instrutor) references instrutor(id_instrutor)
);
create table turma(
	id_turma int,
    fk_id_atividade int,
    fk_id_instrutor int,
    nome varchar(100),
    horario time not null,
    duracao int not null,
    dataInicio date not null,
    dataFim date not null,
    primary key(id_turma, fk_id_atividade, fk_id_instrutor),
    foreign key (fk_id_atividade) references atividade(id_atividade),
    foreign key (fk_id_instrutor) references instrutor(id_instrutor)
);
create table aluno(
	id_matricula int,
    fk_id_turma int,
    dataMatricula date not null,
    nome varchar(45),
    endereco text,
    telefone varchar(20),
    datanascimento date,
    altura float,
    peso int,
    primary key(id_matricula, fk_id_turma),
    foreign key(fk_id_turma) references turma(id_turma)
);


create table chamada(
	id_chamada int,
    fk_id_turma int,
    fk_id_matricula int,
    dataChamada date not null,
    presente bool not null,
    primary key(id_chamada, fk_id_turma, fk_id_matricula),
    foreign key(fk_id_matricula) references aluno(id_matricula),
    foreign key(fk_id_turma) references turma(id_turma)
);

-- Inserindo dados na tabela atividade
INSERT INTO atividade (nome) VALUES 
('Musculação'), 
('Yoga'), 
('Pilates'), 
('Natação'), 
('Crossfit'), 
('Dança'), 
('Funcional'), 
('Spinning'), 
('Boxe'), 
('Alongamento');

-- Inserindo dados na tabela instrutor
INSERT INTO instrutor (rg, nome, nascimento, titulacao) VALUES 
(98765432, 'Carlos Silva', '1980-05-12', 1),
(87651234, 'Maria Souza', '1985-09-25', 2),
(56473829, 'João Pereira', '1990-03-15', 1),
(43782910, 'Ana Lima', '1988-07-30', 3),
(32109876, 'Paulo Oliveira', '1975-12-05', 2),
(19283746, 'Fernanda Santos', '1982-03-14', 3),
(73829104, 'Roberto Almeida', '1995-06-22', 1),
(65432198, 'Vanessa Ribeiro', '1987-09-10', 2),
(28473619, 'Ricardo Nogueira', '1993-02-28', 1),
(93847562, 'Juliana Souza', '1991-12-03', 3);

-- Inserindo dados na tabela telefone_instrutor
INSERT INTO telefone_instrutor (id_telefone, fk_id_instrutor, numero, tipo) VALUES 
(1, 1, 67999887766, 'Celular'),
(2, 2, 6732234455, 'Residencial'),
(3, 3, 67988776655, 'Celular'),
(4, 4, 67977665544, 'Celular'),
(5, 5, 6732110099, 'Comercial'),
(6, 6, 67966554433, 'Celular'),
(7, 7, 67977889900, 'Residencial'),
(8, 8, 67966998877, 'Celular'),
(9, 9, 67966778899, 'Celular'),
(10, 10, 6732555444, 'Comercial');

-- Inserindo dados na tabela turma (variação nas FKs e horários misturados)
INSERT INTO turma (id_turma, fk_id_atividade, fk_id_instrutor, nome, horario, duracao, dataInicio, dataFim) VALUES 
(101, 1, 3, 'Turma Musculação - Manhã', '08:00:00', 60, '2024-02-01', '2024-07-01'),
(202, 2, 6, 'Turma Yoga - Tarde', '15:30:00', 90, '2024-03-01', '2024-09-01'),
(303, 3, 8, 'Turma Pilates - Noite', '19:15:00', 45, '2024-02-15', '2024-08-15'),
(404, 4, 2, 'Turma Natação - Manhã', '07:00:00', 60, '2024-01-10', '2024-06-10'),
(505, 5, 5, 'Turma Crossfit - Tarde', '17:30:00', 90, '2024-04-01', '2024-10-01'),
(606, 6, 9, 'Turma Dança - Noite', '20:00:00', 60, '2024-02-20', '2024-07-20'),
(707, 7, 4, 'Turma Funcional - Manhã', '06:30:00', 75, '2024-03-05', '2024-09-05'),
(808, 8, 1, 'Turma Spinning - Tarde', '14:45:00', 60, '2024-05-01', '2024-11-01'),
(909, 9, 7, 'Turma Boxe - Noite', '18:00:00', 90, '2024-06-10', '2024-12-10'),
(1001, 10, 10, 'Turma Alongamento - Manhã', '09:00:00', 45, '2024-07-01', '2025-01-01');

-- Inserindo dados na tabela aluno (repetindo fk_id_turma para ter vários alunos por turma)
INSERT INTO aluno (id_matricula, fk_id_turma, dataMatricula, nome, endereco, telefone, datanascimento, altura, peso) VALUES 
(2001, 101, '2024-02-02', 'Lucas Mendes', 'Rua A, 123', 67999887766, '2005-05-15', 1.75, 70),
(2002, 101, '2024-02-05', 'Amanda Costa', 'Rua B, 456', 67988776655, '2003-08-20', 1.60, 55),
(2003, 202, '2024-03-01', 'Pedro Rocha', 'Rua C, 789', 67977665544, '2004-12-10', 1.80, 78),
(2004, 303, '2024-03-15', 'Bruno Almeida', 'Rua D, 321', 6732110099, '2001-07-30', 1.72, 75),
(2005, 404, '2024-04-01', 'Carla Silva', 'Rua E, 654', 67966554433, '2002-11-25', 1.65, 60),
(2006, 505, '2024-04-10', 'Fernanda Lima', 'Rua F, 987', 6732998877, '2006-09-12', 1.70, 68),
(2007, 606, '2024-05-01', 'Ricardo Nogueira', 'Rua G, 741', 67977889900, '2003-02-18', 1.78, 80),
(2008, 707, '2024-06-01', 'Juliana Souza', 'Rua H, 852', 6732445566, '2005-03-21', 1.62, 58),
(2009, 808, '2024-06-15', 'Gabriel Santos', 'Rua I, 963', 67966998877, '2004-01-05', 1.75, 72),
(2010, 909, '2024-07-01', 'Vanessa Oliveira', 'Rua J, 159', 67966778899, '2002-06-17', 1.68, 64);

-- Inserindo dados na tabela chamada (com datas alternadas e presença variada)
INSERT INTO chamada (id_chamada, fk_id_turma, fk_id_matricula, dataChamada, presente) VALUES 
(1, 101, 2001, '2024-02-03', TRUE),
(2, 101, 2002, '2024-02-03', FALSE),
(3, 202, 2003, '2024-03-02', TRUE),
(4, 303, 2004, '2024-03-16', TRUE),
(5, 404, 2005, '2024-04-02', FALSE),
(6, 505, 2006, '2024-04-11', TRUE),
(7, 606, 2007, '2024-05-02', TRUE),
(8, 707, 2008, '2024-06-02', FALSE),
(9, 808, 2009, '2024-06-16', TRUE),
(10, 909, 2010, '2024-07-02', FALSE);


-- 1)-
SELECT al.nome as alunos, t.nome as nome_turma from aluno al
join chamada c on al.id_matricula = c.fk_id_matricula join
turma t on c.fk_id_turma = t.id_turma;
select * from aluno;
-- 2)-
select t.nome as nome_turma, count(c.fk_id_matricula) 
as qtd_aluno from turma t
join chamada c on t.id_turma = c.fk_id_turma 
group by t.id_turma, t.nome;

-- 3)- 
select nome, round(avg(timestampdiff(year, datanascimento, current_date)), 2) 
as idade from aluno group by nome;

-- 4)-
select t.nome from turma t
join chamada c on t.id_turma = c.fk_id_turma
group by t.nome
having count(c.fk_id_turma) > 1;
-- 5)-
select i.nome as nome_instruct, t.nome as nome_turma from instrutor i
join turma t on i.id_instrutor = t.fk_id_instrutor; 

-- 6)-
select a.nome as aluno, t.id_turma as turma from aluno a
join chamada c on a.id_matricula = c.fk_id_matricula
join turma t on c.fk_id_turma = t.id_turma
group by a.id_matricula, t.id_turma
having count(case when c.presente = true then 1 end) = 
(select count(*) from chamada c2 where c2.fk_id_turma = t.id_turma);

-- 7)-
select i.nome as nome_instruct, a.nome as nome_atividade from instrutor i
join turma t on i.id_instrutor = t.fk_id_instrutor
join atividade a on t.fk_id_atividade = a.id_atividade
where a.nome = 'Yoga' or a.nome = 'Crossfit';

-- 8)-

-- 9)-
select t.id_turma, t.nome, count(c.fk_id_turma) 
as qtd_aluno from turma t
join chamada c on t.id_turma = c.fk_id_turma 
group by t.id_turma, t.nome 
order by qtd_aluno desc
limit 1;

-- 10)


