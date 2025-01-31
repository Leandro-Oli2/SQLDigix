CREATE TABLE usuario(
    ID_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(50),
    senha VARCHAR(50),
    ramal VARCHAR(15),
    escpecialidade VARCHAR(30)
);
CREATE TABLE maquinas(
    ID_maquina SERIAL PRIMARY KEY,
    tipo VARCHAR(20),
    velocidade VARCHAR(50),
    hardDisk VARCHAR(50),
    placaRede VARCHAR(50),
    memoriaRam int
);
CREATE TABLE software(
    ID_software SERIAL PRIMARY KEY,
    produto VARCHAR(50),
    hardDisk VARCHAR(50),
    memoriaRam int
);
CREATE TABLE possuem(
    fk_usuario INT,
    fk_maquina INT,
    PRIMARY KEY (fk_usuario, fk_maquina),
    FOREIGN KEY (fk_usuario) REFERENCES usuario (ID_usuario),
    FOREIGN KEY (fk_maquina) REFERENCES maquinas (ID_maquina)
);
CREATE TABLE contem(
    fk_maquina INT,
    fk_software INT,
    PRIMARY KEY (fk_maquina, fk_software),
    FOREIGN KEY (fk_maquina) REFERENCES maquinas (ID_maquina),
    FOREIGN KEY (fk_software) REFERENCES software (ID_software)
);

--povoando a tabela usuario
INSERT INTO usuario (nome, senha, ramal, escpecialidade) VALUES ('leandro', 'le123', '101', 'Desenvolvedor'),
('jose', 'jo123', '102', 'Gerente'),
('ana', 'an123', '103', 'Analista'),
('juarez', 'ju123', '104', 'Tecnico'),
('rafael', 'raf123', '105', 'Tecnico'),
('Vinicius', 'vini123', '106', 'Tecnico'),
('Vitoria', 'vi123', '107', 'Marketing'),
('carlos', 'car123', '108', 'Tecnico'),
('arthur', 'art123', '109', 'Tecnico'),
('marcos', 'mar123', '110', 'Marketing');

SELECT * from usuario;

--povoando a tabela maquinas
INSERT INTO Maquinas (tipo, velocidade, hardDisk, placaRede, memoriaRam) VALUES
('Desktop', '3.2 GHz', '1TB', 'Intel Gigabit', 16),
('Notebook', '2.8 GHz', '512GB SSD', 'Realtek 802.11ac', 8),
('Servidor', '3.6 GHz', '4TB', 'Broadcom 10GbE', 32),
('Core III', '3.0 GHz', '2TB', 'Intel Gigabit', 16),
('Notebook', '2.5 GHz', '256GB SSD', 'Qualcomm Atheros', 8),
('Pentium', '3.8 GHz', '8TB', 'Intel 40GbE', 64),
('Desktop', '3.1 GHz', '500GB', 'Realtek PCIe', 4);

-- DROP table usuario;
-- drop table Maquinas;
-- DROP table software;
-- drop table possuem;
-- drop table contem;

--povoando a tabela software
INSERT INTO Software (produto, hardDisk, memoriaRam) VALUES
('Windows 10', '20GB', 2),
('Linux Ubuntu', '15GB', 2),
('Adobe Photoshop', '2GB', 4),
('Microsoft Office', '3GB', 2),
('MySQL Server', '5GB', 8),
('Visual Studio Code', '500MB', 1),
('AutoCAD', '4GB', 8);

--associando usuarios a maquinas
INSERT INTO possuem (fk_usuario, fk_maquina) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 1),
(9, 6),
(10, 4);


--associando software a maquinas
INSERT INTO contem (fk_maquina, fk_software) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7);


--01)
SELECT * FROM usuario WHERE escpecialidade = 'Tecnico';

--02)
SELECT tipo, velocidade FROM maquinas;

--03)
SELECT tipo, velocidade FROM maquinas WHERE tipo = 'Core III' OR tipo = 'Pentium';

--04)
SELECT ID_maquina, tipo, placaRede FROM maquinas WHERE memoriaRam < 16;

--05)
SELECT u.nome FROM usuario u JOIN possuem p ON u.id_usuario = p.fk_usuario
JOIN maquinas m ON m.id_maquina = p.fk_maquina WHERE m.tipo = 'Notebook' OR m.tipo = 'Desktop';


--06)
SELECT m.id_maquina FROM maquinas m JOIN contem c ON m.id_maquina = c.fk_maquina
JOIN software s ON s.id_software = c.fk_software WHERE s.produto = 'AutoCAD';

--07)
SELECT m.id_maquina, m.memoriaram, s.produto FROM maquinas m JOIN contem c ON m.id_maquina = c.fk_maquina
JOIN software s ON s.id_software = c.fk_software WHERE s.produto = 'AutoCAD';

--08)
SELECT u.nome, m.velocidade FROM usuario u JOIN possuem p ON u.id_usuario = p.fk_usuario
JOIN maquinas m ON m.id_maquina = p.fk_maquina;

--09)
SELECT u.nome, u.id_usuario FROM usuario u WHERE id_usuario < (SELECT u.id_usuario FROM usuario u WHERE u.nome = 'jose');

--10)
SELECT count(*) as total_maquinas from maquinas WHERE memoriaRam < 32;

--11)
SELECT count(*) as users from usuario;

--12)
SELECT count(*) as users_agrupados from maquinas WHERE tipo in('Desktop', 'Notebook', 'Servidor', 'Core III', 'Pentium') GROUP BY tipo;

--13)
SELECT count(*) as users from maquinas WHERE tipo in ('Core III');

--14)


--15)


--16)
SELECT avg(CAST(regexp_replace(hardDisk, '[^0-9]', '', 'g') AS INT)) FROM software;

--17)
SELECT tipo, count(*) from maquinas GROUP BY tipo;

--18)


--19)


--20)


--21)



