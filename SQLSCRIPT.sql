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



