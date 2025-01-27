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


INSERT INTO usuario values(1, 'leandro', 'leandrocandido638@gmail.com');
INSERT INTO usuario values(2, 'arthur', 'arthursantoro@gmail.com');
INSERT INTO usuario values(3, 'marcos', 'marcosgabriel@gmail.com');

INSERT INTO cargo values(1, 'Analista T.I', 1, 5000.00);
INSERT INTO cargo values(2, 'Suporte', 1, 5000.00);
INSERT INTO cargo values(3, 'Desenvolvedor', 1, 10000.00); 

--consultas
SELECT * FROM cargo;
SELECT * FROM usuario;

-- LEFT JOIN
SELECT * FROM usuario LEFT JOIN cargo on usuario.id_cliente = cargo.fk_usuario;

-- RIGHT JOIN
SELECT * FROM usuario RIGHT JOIN cargo on usuario.id_cliente = cargo.fk_usuario;

--INNER JOIN    

SELECT * FROM usuario INNER JOIN cargo on usuario.id_cliente = cargo.fk_usuario;


--exercicio
CREATE TABLE exercicio.aluno(
    id_aluno int PRIMARY KEY,
    nome TEXT NOT NULL,
    num_grau INTEGER
);

CREATE TABLE exercicio.amigo(
    idt_amigo1 INTEGER,
    idt_amigo2 INTEGER,
    FOREIGN KEY (idt_amigo1) REFERENCES exercicio.aluno(id_aluno),
    FOREIGN KEY (idt_amigo2) REFERENCES exercicio.aluno(id_aluno)
);
CREATE TABLE exercicio.curtida(
    idt_amigo1 INTEGER,
    idt_amigo2 INTEGER,
    FOREIGN KEY (idt_amigo1) REFERENCES exercicio.aluno(id_aluno),
    FOREIGN KEY (idt_amigo2) REFERENCES exercicio.aluno(id_aluno)
);



INSERT INTO exercicio.aluno (nome, num_grau) VALUES ('Leandro', 3);
INSERT INTO exercicio.aluno (nome, num_grau) VALUES ('Carlos', 2);
INSERT INTO exercicio.aluno (nome, num_grau) VALUES ('Maria', 5);

-- Inserindo relacionamentos de amizade
INSERT INTO exercicio.amigo (idt_amigo1, idt_amigo2) VALUES (1, 2);
INSERT INTO exercicio.amigo (idt_amigo1, idt_amigo2) VALUES (2, 3);

-- Inserindo curtidas
INSERT INTO exercicio.curtida (id_aluno) VALUES (3);

-- INNER JOIN
SELECT * FROM exercicio.aluno 
INNER JOIN exercicio.amigo ON exercicio.aluno.id_aluno = exercicio.amigo.idt_amigo1 
OR exercicio.aluno.id_aluno = exercicio.amigo.idt_amigo2
INNER JOIN exercicio.curtida ON exercicio.aluno.id_aluno = exercicio.curtida.id_aluno;

-- LEFT JOIN
SELECT * FROM exercicio.aluno LEFT JOIN exercicio.curtida 
ON exercicio.aluno.id_aluno = exercicio.curtida.id_aluno;

-- RIGHT JOIN
SELECT * FROM exercicio.aluno RIGHT JOIN exercicio.amigo 
ON exercicio.aluno.id_aluno = exercicio.amigo.idt_amigo1 
OR exercicio.aluno.id_aluno = exercicio.amigo.idt_amigo2;.



