CREATE TABLE Maquina (
Id_Maquina INT PRIMARY KEY NOT NULL,
Tipo VARCHAR(255),
Velocidade INT,
HardDisk INT,
Placa_Rede INT,
Memoria_Ram INT,
Fk_Usuario INT,
FOREIGN KEY(Fk_Usuario) REFERENCES Usuarios(ID_Usuario)
);
CREATE TABLE Usuarios (
ID_Usuario INT PRIMARY KEY NOT NULL,
Password VARCHAR(255),
Nome_Usuario VARCHAR(255),
Ramal INT,
Especialidade VARCHAR(255)
);
CREATE TABLE Software (
Id_Software INT PRIMARY KEY NOT NULL,
Produto VARCHAR(255),
HardDisk INT,
Memoria_Ram INT,
Fk_Maquina INT,
FOREIGN KEY(Fk_Maquina) REFERENCES Maquina(Id_Maquina)
);
insert into Maquina values (1, 'Desktop', 2, 500, 1, 4, 1);
insert into Maquina values (2, 'Notebook', 1, 250, 1, 2, 2);
insert into Maquina values (3, 'Desktop', 3, 1000, 1, 8, 3);
insert into Maquina values (4, 'Notebook', 2, 500, 1, 4, 4);
insert into Maquina values (5, 'Notebook', 2, 10, 1, 4, 3);
insert into Usuarios values (1, '123', 'Joao', 123, 'TI');
insert into Usuarios values (2, '456', 'Maria', 456, 'RH');
insert into Usuarios values (3, '789', 'Jose', 789, 'Financeiro');
insert into Usuarios values (4, '101', 'Ana', 101, 'TI');
insert into Software values (1, 'Windows', 100, 2, 1);
insert into Software values (2, 'Linux', 50, 1, 2);
insert into Software values (3, 'Windows', 200, 4, 3);
insert into Software values (4, 'Linux', 100, 2, 4);

--1 
create or replace function Espaco_disponivel(id_maq integer) returns boolean as $$
declare 
	capacidade_hd int;
	hd_usado int;
begin
	select HardDisk into capacidade_hd from maquina where Id_Maquina = id_maq;
	if capacidade_hd is null then
		return false;
	end if;
	select sum(HardDisk) into hd_usado from software where Fk_Maquina = id_maq;
	return (hd_usado <= capacidade_hd); 
end;
$$ language plpgsql;

select Espaco_disponivel(1);

--2
create or replace procedure Instalar_software(id_maq integer, id_soft integer) as $$
declare 
 capacidade_hd int;
 hd_usado int;
begin
	select m.HardDisk into capacidade_hd from maquina m
	join Software on m.Id_Maquina = id_maq;

	if capacidade_hd is null then
		raise exception 'Maquina Não encontrada!';
	end if;
	select sum(HardDisk) into hd_usado from software where Fk_Maquina = id_maq;
	if hd_usado <= capacidade_hd then 
		raise exception 'Software Instalado na Maquina!';
	else
		raise exception 'Software não instalado!';
	end if;
end;
$$ language plpgsql;
call Instalar_software(5, 1);

--3
create or replace function Maquinas_user(id_user integer) returns varchar as $$
declare
	nome_maq varchar(255);
begin
	select tipo into nome_maq from Maquina
	join Usuarios on Fk_Usuario = id_Usuario;
	return nome_maq;
end;
$$ language plpgsql;
select Maquinas_user(1);

4--
create or replace procedure Atualizar_recursos(id_maq integer, qtd_m integer, qtd_h integer) as $$
begin
	update Maquina set Memoria_Ram = qtd_m, HardDisk = qtd_h where Id_Maquina = id_maq;
end;
$$ language plpgsql;
call Atualizar_recursos(4, 8, 1000);
select * from Maquina;

5--
create or replace procedure Transferir_software(id_maq INTEGER, id_soft INTEGER) as $$
declare 
    capacidade_hd INT;
    hd_usado INT;
begin
    select m.HardDisk into capacidade_hd 
    from Maquina m
    where m.Id_Maquina = id_maq;
	
    if capacidade_hd is null then
        raise exception 'Máquina não encontrada!';
    end if;

    select sum(s.HardDisk) into hd_usado
    from Software s
    where s.Fk_Maquina = id_maq;
	
    if (hd_usado + (select HardDisk from Software where Id_Software = id_soft)) <= capacidade_hd then
        update Software set Fk_Maquina = id_maq where Id_Software = id_soft;
        
        raise notice 'Software transferido!';
    else
        raise exception 'Não ha espaço para transferir o software!';
    end if;
end;
$$ language plpgsql;
call Transferir_software(1, 4);
select * from software;

--6
create or replace function media() returns table(media_memoria numeric, media_hd numeric) as $$
begin
	return query
	select avg(memoria_ram), avg(HardDisk)
	from Maquina;
end;
$$ language plpgsql;
select * from media();

7--