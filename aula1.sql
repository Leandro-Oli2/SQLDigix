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