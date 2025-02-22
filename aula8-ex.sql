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
insert into Usuarios values (1, '123', 'Joao', 123, 'TI');
insert into Usuarios values (2, '456', 'Maria', 456, 'RH');
insert into Usuarios values (3, '789', 'Jose', 789, 'Financeiro');
insert into Usuarios values (4, '101', 'Ana', 101, 'TI');
insert into Software values (1, 'Windows', 100, 2, 1);
insert into Software values (2, 'Linux', 50, 1, 2);
insert into Software values (3, 'Windows', 200, 4, 3);
insert into Software values (4, 'Linux', 100, 2, 4);



1--
create table log_maquina (
	id serial primary key,
	maquina_id integer,
	acao varchar(20),
	data timestamp default current_timestamp
);


create or replace function log_partida_delete()
returns trigger as $$
begin
	delete from software where Fk_Maquina = old.Id_Maquina;
	insert into log_maquina(maquina_id, acao) values (old.Id_Maquina, 'DELETE');
	return old;
end;
$$ language plpgsql;

create or replace trigger log_partida_delete
before delete on Maquina
for each row
execute function log_partida_delete();
	
delete from maquina where Id_Maquina = 1;

select * from log_maquina;



2--
create or replace function senha_fraca()
returns trigger as $$
begin
	if char_length(new.Password) < 6 then
		raise exception 'Erro: A senha deve ter pelo menos 6 digitos';
	end if;
	return new;
end;
$$ language plpgsql;

create or replace trigger senha_fraca
before insert on Usuarios
for each row
execute function senha_fraca();

insert into Usuarios values (5, '4577', 'Leandro', 222, 'Gerente');

3--
create table Maquina_software_Count(
	id serial primary key,
	maquina_id integer,
	qtd int,
	data timestamp default current_timestamp
);

create or replace function cont_software()
returns trigger as $$
declare
 	cont int;
begin
	select count(Id_Software) into cont from Software 
	where Fk_Maquina = new.Fk_Maquina;
	insert into Maquina_software_Count(maquina_id, qtd) values (new.Fk_Maquina, cont)
	on conflict (maquina_id) 
	do update set qtd = cont, data = current_timestamp;
	return new;
end;
$$ language plpgsql;

create or replace trigger cont_software
after insert on Software
for each row
execute function cont_software();

insert into Software values (5, 'Linux', 100, 2, 2);
insert into Software values (7, 'ubuntu', 100, 2, 4);
insert into Software values (8, 'ubuntu', 100, 2, 4);
insert into Software values (10, 'ubuntu', 100, 2, 2);
insert into Software values (11, 'ubuntu', 100, 2, 2);


select * from Maquina_software_Count;

4--

create or replace function evitar_remov()
returns trigger as $$
begin
	if old.Especialidade = 'TI' then
		raise exception 'Erro: Não eh permitido excluir pessoas do TI';
	end if;
	return old;
end;
$$ language plpgsql;

create or replace trigger evitar_remov
before delete on Usuarios
for each row
execute function evitar_remov();

delete from Usuarios where ID_Usuario = 4;
select * from Usuarios;

5--



6--
create table newEspecialidade (
	id serial primary key,
	ID_Usuario integer,
	Espec VARCHAR(255),
	data timestamp default current_timestamp
);


create or replace function update_user()
returns trigger as $$
begin
	insert into newEspecialidade(ID_Usua
	
	
	rio, Espec) values (new.ID_Usuario, new.Especialidade);
	return new;
end;
$$ language plpgsql;

create or replace trigger update_user
after update on Usuarios
for each row
execute function update_user();
	
update Usuarios set Especialidade = 'TI' where ID_Usuario = 2;
select * from newEspecialidade;
select * from Usuarios;

7--
create or replace function evitar_remov_soft()
returns trigger as $$
begin
	if old.Produto = 'Windows' then
		raise exception 'Erro: Não eh permitido excluir softwares importantes';
	end if;
	return old;
end;
$$ language plpgsql;

create or replace trigger evitar_remov_soft
before delete on Software
for each row
execute function evitar_remov_soft();

delete from Software where ID_software = 2;
select * from Software;

