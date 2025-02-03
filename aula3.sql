CREATE TABLE Empregado (
    cpf VARCHAR(11) NOT NULL PRIMARY KEY,  
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(255),
    datanasc DATE,
    sexo VARCHAR(15),
    carttrab VARCHAR(15),
    salario DECIMAL(10,2),
    numero_dep INT NOT NULL,
    cpf_super VARCHAR(11) NULL, 
    CONSTRAINT fk_supervisor FOREIGN KEY (cpf_super) REFERENCES Empregado(cpf) ON DELETE SET NULL
);




CREATE TABLE Departamento (
    numero_dep SERIAL NOT NULL PRIMARY KEY,  
    nome_dep VARCHAR(100) NOT NULL,
    cpf_GER VARCHAR(11),
    datainicio DATE,
	FOREIGN KEY (cpf_GER) REFERENCES Empregado (cpf)
);

ALTER TABLE Empregado 
ADD CONSTRAINT fk_departamento 
FOREIGN KEY (numero_dep) REFERENCES Departamento(numero_dep);

CREATE TABLE Projeto (
    numero_proj SERIAL NOT NULL PRIMARY KEY,  
    nome_proj VARCHAR(100) NOT NULL,
    localizacao VARCHAR(100),
    numero_dep int,
	FOREIGN KEY (numero_dep) REFERENCES Departamento (numero_dep)
);
CREATE TABLE Dependente (
    numero_dep SERIAL NOT NULL PRIMARY KEY,  
    cpf_E VARCHAR(11) NOT NULL,
    sexo VARCHAR(15),
    parentesco VARCHAR(50),
	FOREIGN KEY (cpf_E) REFERENCES Empregado (cpf)
	
);

CREATE TABLE Trabalha_Em (
    cpf_E VARCHAR(11),  
    numero_proj INT,
	horas TIME,
    PRIMARY KEY (cpf_E, numero_proj),
    FOREIGN KEY (cpf_E) REFERENCES Empregado (cpf),
    FOREIGN KEY (numero_proj) REFERENCES Projeto (numero_proj)
);
INSERT INTO Departamento (nome_dep, datainicio) VALUES
('TI', '2020-01-10'),
('Recursos Humanos', '2019-05-20'),
('Financeiro', '2018-08-15'),
('Marketing', '2021-02-01'),
('Vendas', '2017-09-05'),
('Logística', '2016-06-30');

INSERT INTO Empregado (cpf, nome, endereco, datanasc, sexo, carttrab, salario, numero_dep, cpf_super) VALUES
('12345678901', 'Leandro Silva', 'Rua A, 123', '2000-05-15', 'Masculino', '123456', 5000.00, 1, NULL),
('23456789012', 'Mariana Souza', 'Rua B, 456', '1992-10-22', 'Feminino', '234567', 6000.00, 2, '12345678901'),
('34567890123', 'Carlos Mendes', 'Rua C, 789', '1985-03-18', 'Masculino', '345678', 7000.00, 3, '12345678901'),
('45678901234', 'Fernanda Lima', 'Rua D, 101', '1995-07-05', 'Feminino', '456789', 5500.00, 4, '23456789012'),
('56789012345', 'Ricardo Alves', 'Rua E, 202', '1998-09-30', 'Masculino', '567890', 4800.00, 5, '34567890123'),
('67890123456', 'Juliana Martins', 'Rua F, 303', '1990-12-12', 'Feminino', '678901', 6200.00, 6, '45678901234');
INSERT INTO Empregado (cpf, nome, endereco, datanasc, sexo, carttrab, salario, numero_dep, cpf_super) VALUES
('12345678941', 'lucas Silva', 'Rua S, 123', '2000-05-15', 'Masculino', '124456', 125000.00, 1, null);

UPDATE Departamento SET cpf_GER = '12345678901' WHERE numero_dep = 1;  
UPDATE Departamento SET cpf_GER = '23456789012' WHERE numero_dep = 2;  
UPDATE Departamento SET cpf_GER = '34567890123' WHERE numero_dep = 3; 
UPDATE Departamento SET cpf_GER = '45678901234' WHERE numero_dep = 4;  
UPDATE Departamento SET cpf_GER = '56789012345' WHERE numero_dep = 5;  
UPDATE Departamento SET cpf_GER = '67890123456' WHERE numero_dep = 6; 
UPDATE Departamento SET cpf_GER = '67890123456' WHERE numero_dep = 7; 


INSERT INTO Projeto (nome_proj, localizacao, numero_dep) VALUES
('Sistema de Gestão', 'São Paulo', 1),
('Treinamento de Funcionários', 'Rio de Janeiro', 2),
('Revisão Orçamentária', 'Brasília', 3),
('Campanha Publicitária', 'Curitiba', 4),
('Expansão de Mercado', 'Belo Horizonte', 5),
('Otimização Logística', 'Porto Alegre', 6);


INSERT INTO Dependente (cpf_E, sexo, parentesco) VALUES
('12345678901', 'Feminino', 'Esposa'),
('23456789012', 'Masculino', 'Filho'),
('34567890123', 'Feminino', 'Filha'),
('45678901234', 'Masculino', 'Filho'),
('56789012345', 'Feminino', 'Mãe'),
('67890123456', 'Masculino', 'Pai');


INSERT INTO Trabalha_Em (cpf_E, numero_proj, horas) VALUES
('12345678901', 1, '08:00:00'),
('23456789012', 2, '06:30:00'),
('34567890123', 3, '07:00:00'),
('45678901234', 4, '08:30:00'),
('56789012345', 5, '05:45:00'),
('67890123456', 6, '07:15:00');



INSERT INTO Departamento (nome_dep, datainicio) VALUES
('TI', '2020-01-10'),
('Recursos Humanos', '2019-05-20'),
('Financeiro', '2018-08-15'),
('Marketing', '2021-02-01'),
('Vendas', '2017-09-05'),
('Logística', '2016-06-30');

--consultando tudo
SELECT * FROM Empregado, Departamento, Dependente, Projeto, Trabalha_Em;

--substring, com posições especificas de caracteres
SELECT nome_proj FROM Projeto WHERE nome_proj LIKE  'R%';

-- DIFERENÇA DE ASPAS SIMPLES E DUPLAS
-- AS SIMPLES PEGAM STRINGS
-- AS DUPLAS SÃO PARA IDENTIFICAR O NOME DA TABELA, COLUNA, ETC...
SELECT e.nome FROM Empregado e WHERE e.nome LIKE 'L%';
SELECT "nome" FROM Empregado e WHERE "nome" LIKE 'C%';


--Operadores na propria coluna
SELECT e.nome, e.salario * 1.1 FROM Empregado e;

--colocar nome referencia na operacao usando o AS
SELECT e.nome, e.Salario * 1.1 AS SalarioATT FROM Empregado e;
SELECT * FROM departamento;


--Distinct é para evitar duplicações
SELECT DISTINCT d.nome_dep, e.cpf from Departamento d, Empregado e WHERE d.cpf_GER = e.cpf;

--Utilizar o UNION que é uniao de 2 consultas
--2. listar os numeros de projetos nos quais esteja envolvido o empregado "leandro"
-- como empregado ou como gerente responsavel  pelo departamento que controla o projeto
(SELECT DISTINCT P.numero_proj FROM Projeto p, Departamento d, Empregado e WHERE p.numero_dep = d.numero_dep and d.cpf_GER = e.cpf and e.nome = 'Leandro') -- ele ta como gerente
UNION
(SELECT P.numero_proj FROM Projeto p, Empregado e, Trabalha_Em t WHERE p.numero_proj = t.numero_proj and t.cpf_E = e.cpf and e.nome = 'Leandro');

--Uso do Intersect
--LISTANDO EMPREGADOS QUE TAMBEM SÃO GERENTES
SELECT e.nome FROM Empregado e 
INTERSECT
SELECT e.nome FROM Empregado e, Departamento d WHERE d.cpf_GER = e.cpf;


--utilizar o isnull, para imprimir registros que tem nulo em alguma coluna
select e.nome from Empregado e WHERE e.cpf_super is null;
select e.nome from Empregado e WHERE e.cpf_super is not null;

--media dos salarios dos empregados

select avg(salario) from Empregado;
select max(salario) from Empregado;
select min(salario) from Empregado;
select sum(salario) from Empregado;

-- selecionar o cpf de todos os empregados que 
-- trabalham no mesmmo projeto e com a mesma quantidade de horas que o empregado cujo cpf e "12345678901"
SELECT DISTINCT cpf_E 
FROM Trabalha_Em WHERE (numero_proj, horas) IN (SELECT numero_proj, horas FROM Trabalha_Em WHERE cpf_E = '12345678901');

--SELECIONAR O NOME DE TODOS OS EMPREGADO QUE TEM SALARIO MAIOR QUE TODOS OS SALARIOS DOS EMPREGADOS DO DEPARTAMENTO 2
SELECT DISTINCT nome, salario from Empregado where salario > ALL(select salario from empregado where numero_dep = 2);
