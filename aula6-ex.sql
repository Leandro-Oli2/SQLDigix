create table Empregado (
	Nome varchar(50),
	Endereco varchar(500),
	CPF int primary key not null,
	DataNasc date,
	Sexo char(10),
	CartTrab int,
	Salario float,
	NumDep int,
	CPFSup int
);

create table Departamento (
	NomeDep varchar(50),
	NumDep int primary key not null,
	CPFGer int,
	DataInicioGer date,
	foreign key (CPFGer) references Empregado(CPF)
);
create table Projeto (
	NomeProj varchar(50),
	NumProj int primary key not null,
	Localizacao varchar(50),
	NumDep int,
	foreign key (NumDep) references Departamento(NumDep)
);
create table Dependente (
	idDependente int primary key not null,
	CPFE int,
	NomeDep varchar(50),
	Sexo char(10),
	Parentesco varchar(50),
	foreign key (CPFE) references Empregado(CPF)
);
create table Trabalha_Em (
	CPF int,
	NumProj int,
	HorasSemana int,
	foreign key (CPF) references Empregado(CPF),
	foreign key (NumProj) references Projeto(NumProj)
);
ALTER TABLE Empregado ADD CONSTRAINT FK_Empregado_Supervisor FOREIGN KEY (CPFSup) REFERENCES Empregado(CPF); 
-- Inserir os dados
insert into Departamento values ('Dep1', 1, null, '1990-01-01');
insert into Departamento values ('Dep2', 2, null, '1990-01-01');
insert into Departamento values ('Dep3', 3, null, '1990-01-01');
insert into Empregado values ('Joao', 'Rua 1', 123, '1990-01-01', 'M', 123, 1000, 1, null);
insert into Empregado values ('Maria', 'Rua 2', 456, '1990-01-01', 'F', 456, 2000, 2, null);
insert into Empregado values ('Jose', 'Rua 3', 789, '1990-01-01', 'M', 789, 3000, 3, null);

update Departamento set CPFGer = 123 where NumDep = 1;
update Departamento set CPFGer = 456 where NumDep = 2;
update Departamento set CPFGer = 789 where NumDep = 3;
insert into Projeto values ('Proj1', 1, 'Local1', 1);
insert into Projeto values ('Proj2', 2, 'Local2', 2);
insert into Projeto values ('Proj3', 3, 'Local3', 3);
insert into Dependente values (1, 123, 'Dep1', 'M', 'Filho');
insert into Dependente values (2, 456, 'Dep2', 'F', 'Filha');
insert into Dependente values (3, 789, 'Dep3', 'M', 'Filho');
insert into Trabalha_Em values (123, 1, 40);
insert into Trabalha_Em values (456, 2, 40);
insert into Trabalha_Em values (789, 3, 40);

--1
create or replace function obter_salario(cpf_empregado integer) returns float as $$
declare
	sal float;
begin
	select Salario into sal from empregado where CPF = cpf_empregado;
		if sal > 0 then
			raise notice 'Salario: %', sal;
		else
			raise notice 'Salario não encontrado!';
		end if;
	return sal;
	end;
$$ language plpgsql;

select obter_salario(456);

--2
create or replace function obter_dep(cpf_empregado integer) returns varchar as $$
declare
	nome_departs varchar(50);
begin
	select NomeDep into nome_departs from departamento where CPFGer = cpf_empregado;
	return nome_departs;
	end;
$$ language plpgsql;


select obter_dep(123);

--3
create or replace function obter_nome_ger(num_departs integer) returns varchar as $$
declare
	nome_ger varchar(50);
begin
	select e.nome into nome_ger from empregado e 
	join Departamento d on num_departs = d.NumDep;
	return nome_ger;
	end;
$$ language plpgsql;


select obter_nome_ger(1);

--4
create or replace function obter_nome_proj(cpf integer) returns varchar as $$
declare
	nome_proj varchar(50);
begin
	select p.NomeProj into nome_proj from Projeto p
	join Departamento d on d.NumDep = p.NumDep
	join empregado e on d.CPFGer = e.CPF
	where d.CPFGer = e.CPF;
	return nome_proj;
	end;
$$ language plpgsql;

select obter_nome_proj(123);

--5
create or replace function obter_nome_denp(cpf integer) returns varchar as $$
declare
	parent varchar(50);
begin
	select d.Parentesco into parent from Dependente d
	join Empregado e on d.CPFE = e.CPF;
	return parent;
	end;
$$ language plpgsql;

select obter_nome_denp(123);

--6
