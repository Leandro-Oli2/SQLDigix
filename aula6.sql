CREATE TABLE time (
id INTEGER PRIMARY KEY,
nome VARCHAR(50)
);
CREATE TABLE partida (
id INTEGER PRIMARY KEY,
time_1 INTEGER,
time_2 INTEGER,
time_1_gols INTEGER,
time_2_gols INTEGER,
FOREIGN KEY(time_1) REFERENCES time(id),
FOREIGN KEY(time_2) REFERENCES time(id)
);
INSERT INTO time(id, nome) VALUES
(1,'CORINTHIANS'),
(2,'SÃO PAULO'),
(3,'CRUZEIRO'),
(4,'ATLETICO MINEIRO'),
(5,'PALMEIRAS');
INSERT INTO partida(id, time_1, time_2, time_1_gols, time_2_gols)
VALUES
(1,4,1,0,4),
(2,3,2,0,1),
(3,1,3,3,0),
(4,3,4,0,1),
(5,1,2,0,0),
(6,2,4,2,2),
(7,1,5,1,2),
(8,5,2,1,2);

create view vpartida as
select p.id as jogo, p.time_1 as id_time_1, t1.nome as nome1,time_1_gols as gols_time1,
time_2_gols as gols_time2, t2.nome as nome2, time_2 as id_time_2
from partida p
join time t1 on t1.id = p.time_1
join time t2 on t2.id = p.time_2;



select * from vpartida
where nome1 ilike 'a%' or nome1 like 'c%' 
or nome2 like 'a%' or nome2 like 'c%';



create view resultado_partida as
select jogo, nome1, gols_time1, gols_time2, nome2, 
case 
	when gols_time1 > gols_time2 then nome1
	when gols_time2 > gols_time1 then nome2
	else 'EMPATE'
end as classificacao_vencedor
from vpartida
order by classificacao_vencedor desc;

select * from resultado_partida;




-- 4. Crie uma view vtime que retorne a tabela de time adicionando as colunas partidas, vitorias,
--  derrotas, empates e pontos.
-- Colunas esperadas:  id, nome, partidas, vitorias, derrotas, empates, pontos 
-- Ordenação:  pontos descendente
create or replace view vtime as
select t.id, t.nome
-- Partidas
(select count(time_1) from partida where time_1 = t.id) + (select count(time_2) from partida where time_2 = t.id) as partidas
-- Vitorias
(select sum(case when time_2_gols > time_1_gols then 1 else 0 end) from partida where time_2 = t.id) +
(select sum(case when time_1_gols > time_2_gols then 1 else 0 end) from partida where time_1 = t.id)
-- Empates
(select sum(case when time_2_gols = time_1_gols then 1 else 0 end) from partida where time_2 = t.id) +
(select sum(case when time_1_gols = time_2_gols then 1 else 0 end) from partida where time_1 = t.id)
-- Derrota
(select sum(case when time_2_gols < time_1_gols then 1 else 0 end) from partida where time_2 = t.id) +
(select sum(case when time_1_gols < time_2_gols then 1 else 0 end) from partida where time_1 = t.id)
-- Pontos
(select sum(case when time_2_gols > time_1_gols then 3 when time_2_gols = time_1_gols then 1 else 0 end)
from partida where time_2 = t.id) + 
(select sum(case when time_2_gols < time_1_gols then 3 when time_2_gols = time_1_gols then 1 else 0 end)
from partida where time_1 = t.id) as pontos
from time t
order by pontos desc;

-- Tabela temporaria: elas são para dados temporarios, 
-- e que sao de unica sessap de banco de dados
create Temp table temp_time as select * from time;


select * from temp_time;

--Ele apaga os dados mais não a tabela;
truncate table temp_time;

--Operações nas funções no Postgres
--1-Criar variaveis dentro da função e imprimir
create or replace function operacao_funcao() returns void as $$
declare --declare é para declarar e criar as variaveis internas
	v_id integer;
	v_nome varchar(50);
begin
	--atribuindo vlaores nas variaveis
	v_id := 1;
	v_nome := 'FLAMENGO';
	raise notice 'ID: %, NOME: %', v_id, v_nome;

	-- Operações matematicas
	-- v_id := v_id + 1;
	raise notice 'Soma: %', 1 + 1;
	raise notice 'Subtração: %', 1 - 1;
	raise notice 'Multiplicação: %', 1 * 1;
	raise notice 'Divisao: %', 1 / 1;

	-- Operação de comparação
	raise notice 'Maior: %', 1 > 1;
	raise notice 'Maior ou Igual: %', 1 >= 1;
	raise notice 'Menor: %', 1 < 1;
	raise notice 'Menor ou Igual: %', 1 <= 1;
	raise notice 'Igual: %', 1 = 1;
	raise notice 'Diferente: %', 1 <> 1;

	-- Operção de concatenação
	raise notice 'Concatenação: %', 'Aula' || 'Digix';
	-- Operação de Logica
	raise notice 'E: %', true and true;
	raise notice 'Ou: %', true or false;
	raise notice 'Não: %', not true;

	--Manuulação de String
	-- raise notice 'Tamanho da String: %', lenght('Aula Digix');
	raise notice 'Substituir: %', replace('Aula Digix', 'Digix', 'Postgres');
	raise notice 'Posição: %', position('Digix' in 'Aula Digix');
	raise notice 'Sub String: %', substring('Aula Digix', 6, 5);
	raise notice 'Maiuscula: %', upper('Aula Digix');
	raise notice 'Minuscula: %', lower('Aula Digix');

	--Manipulação de Data
	raise notice 'Data Atual: %', now();
	raise notice 'Data Atual: %', current_date;
	raise notice 'Hora Atual: %', current_time;

	--Manipulação de array
	raise notice 'Array: %', ARRAY[1,2,3,4,5];
	raise notice 'Array: %', ARRAY['Aula', 'Digix'];
	-- raise notice 'Array: %', ARRAY['Aula', 1, true];
	raise notice 'Matriz: %', ARRAY[[1,2,4],[4,5,6]];
	raise notice 'Matriz Tridimencional: %', ARRAY[[[1,2,3],[4,5,6]]];

	--Manupulação JSON
	raise notice 'JSON: %', '{"nome": "Aula Digix"}';
end;
$$ language plpgsql;


select operacao_funcao();

-- 2. Criar uma função que recebe parametros e retorna um valor
CREATE OR REPLACE function obter_nome_time(p_id integer) returns 
varchar as $$
declare
	v_nome varchar(50);
begin
 select nome into v_nome from time where id= p_id;
 return v_nome;
end;
$$ language plpgsql;

select obter_nome_time(1);

-- 3. criar função com loops
create or replace function obter_times() returns setof time as $$
declare 
	i int := 1;
begin
	loop -- loop é igual o while
		exit when i > 5;
		raise notice 'Valor de i:%', i;
		i := i+1;
	end loop;


	for i in 1..5 loop 
		raise notice 'Valor de i:%', i;
		i := i+1;
	end loop;

	while i <= 5 loop
		raise notice 'Valor de i:%', i;
		i :=i+1;
	end loop;
end;
$$ language plpgsql;

select obter_times();


create or replace function obter_times_dados() returns setof time as $$
declare 
	v_time time%rowtype;
begin
	for v_time in select * from time loop
		return next v_time;
	end loop;
	return;
end;
$$ language plpgsql;

select * from obter_times_dados();

-- 5 Função que trabalha
create or replace function gols() returns setof time as $$
declare
	v_gols integer;
	begin
		select time_1_gols into v_gols from partida where time_1 = 1;
		if v_gols > 2 then
			raise notice 'Time marcou mais de 2 gols';
		else
			raise notice 'Time marcou menos de 2 gols';
		end if;
	end;
$$ language plpgsql;

select * from gols();

-- ou com case
create or replace function gols() returns setof time as $$
declare
	v_gols integer;
	begin
		select time_1_gols into v_gols from partida where time_1 = 1;
		case 
		when v_gols > 2 then
			raise notice 'Time marcou mais de 2 gols';
		else
			raise notice 'Time marcou menos de 2 gols';
		end case;
	end;
$$ language plpgsql;

select * from gols();


create or replace function obter_nome_time_excecao(id_time_nome integer) returns varchar as $$
declare
	v_nome varchar(50);
begin
	select nome into v_nome from time where id = id_time_nome;
	if v_nome is null then
		raise notice 'Nenhum registro encontrado';
		return null;
	end if;
	return v_nome;
end;
$$ language plpgsql;

select * from obter_nome_time_excecao(6);
