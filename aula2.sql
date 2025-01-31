CREATE TABLE usuario (
    Id_Cliente INT NOT NULL,
    nome VARCHAR(100),
    email VARCHAR(100),
    PRIMARY KEY (Id_Cliente)
);
CREATE TABLE cargo (
    id INT NOT NULL,
    nome VARCHAR(50),
    fk_usuario INT,
    salario DECIMAL(10,2),
    PRIMARY KEY (id),
    CONSTRAINT fk_cargo_usuario FOREIGN KEY (fk_usuario)
    REFERENCES usuario (Id_Cliente)
);

--ALterando a tabela

ALTER TABLE cargo ADD COLUMN salario decimal(10,2);
ALTER TABLE cargo ALTER COLUMN nome TYPE varchar(100);
ALTER TABLE cargo DROP COLUMN salario;
SELECT * FROM cargo;

--Excluir a Tabela
DROP TABLE cargo;
DROP TABLE usuario;

-- Inserindo dados na tabela
INSERT INTO usuario values(1, 'leandro', 'leandrocandido638@gmail.com');
INSERT INTO usuario values(2, 'arthur', 'arthursantoro@gmail.com');
INSERT INTO usuario values(3, 'marcos', 'marcosgabriel@gmail.com');
UPDATE cargo set salario = 2000.00 WHERE id = 2;


INSERT INTO cargo values(1, 'Analista T.I', 1, 5000.00);
INSERT INTO cargo values(2, 'Suporte', 2, 5000.00);
INSERT INTO cargo values(3, 'Desenvolvedor', 3, 10000.00); 

--consultas
SELECT * FROM cargo;
SELECT * FROM usuario;

-- LEFT JOIN
SELECT * FROM usuario LEFT JOIN cargo on usuario.Id_Cliente = cargo.fk_usuario;

-- RIGHT JOIN
SELECT * FROM usuario RIGHT JOIN cargo on usuario.Id_Cliente = cargo.fk_usuario;

--INNER JOIN    
SELECT * FROM usuario INNER JOIN cargo on usuario.Id_Cliente = cargo.fk_usuario;

--Abreviação
SELECT c.nome FROM cargo c;
SELECT c.nome, u.nome FROM cargo c, usuario u;

--aplicação de condições
SELECT c.nome FROM cargo c WHERE id = 1;
SELECT u.Id_Cliente FROM usuario u WHERE u.nome = 'leandro';

SELECT u.nome FROM usuario u WHERE u.Id_Cliente = 1 OR u.Id_Cliente = 2;

SELECT u.nome FROM usuario u WHERE u.Id_Cliente = 1 AND u.Id_Cliente = 2;

--Selecionar uma lista id
SELECT u.nome FROM usuario u WHERE Id_Cliente in (1,2,3);

SELECT u.nome FROM usuario u WHERE Id_Cliente not in (1,2,3);

--Utilizar o operando Between para ser usados o que esta entre os intervalos
SELECT u.nome FROM usuario u WHERE Id_Cliente BETWEEN 1 AND 3;

SELECT u.id_cliente FROM usuario u WHERE u.nome BETWEEN 'leandro' AND 'marcos';

--Utilizar o operador Like para pesquisar partes de uma string(texto)

SELECT u.id_cliente, u.nome FROM usuario u WHERE u.nome LIKE 'mar%';

SELECT u.nome FROM usuario u WHERE u.nome LIKE '%dro';

--Operadores de Comparação
SELECT u.id_cliente, u.nome FROM usuario u WHERE id_cliente > 1;

SELECT u.id_cliente, u.nome FROM usuario u WHERE id_cliente >= 1;

SELECT u.id_cliente, u.nome FROM usuario u WHERE id_cliente > 1 AND id_cliente < 3;


-- Operadores 
SELECT u.id_cliente, u.nome from usuario u ORDER BY id_cliente ASC;

SELECT u.id_cliente, u.nome from usuario u ORDER BY id_cliente DESC;

SELECT u.id_cliente, u.nome FROM usuario u ORDER BY nome DESC;

-- Limitar os resultados 
SELECT * FROM usuario LIMIT 1;

--Agrupamento 
SELECT c.nome, u.id_cliente FROM usuario u, cargo c WHERE u.id_cliente = c.fk_usuario GROUP BY c.nome, u.id_cliente;

SELECT c.nome, u.id_cliente, count(c.id) FROM usuario u, cargo c WHERE u.id_cliente = c.fk_usuario GROUP BY c.nome, u.id_cliente;






