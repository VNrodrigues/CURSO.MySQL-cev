-- Projeto baseado no curso de mySQL do canal "Curso em Vídeo"

-- Criar database
-- Definir padrão português
create database cadastro
default character set utf8mb4
default collate utf8mb4_general_ci;

-- Selecionar database
use cadastro;

-- Criar tabela
create table pessoas(
id int not null auto_increment,
nome varchar(30) not null,
nascimento date,
sexo enum('M', 'F'),
peso decimal(5,2),
altura decimal(3,2),
nacionalidade varchar(20) default 'Brasil',
primary key (id)
) default charset = utf8mb4;

-- Inserir dados em uma tabela
insert into pessoas values
(default, 'Marcelo', '1972-08-08', 'M', '80', '1.70', default);

select * from pessoas;

desc pessoas;

-- Adicionar coluna (adiciona em último lugar)
alter table pessoas
add column profissao varchar(10);

-- Adiocionar coluna após outra
alter table pessoas
add column profissao varchar(10) after nome;

-- Adicionar coluna em primeiro
alter table pessoas
add column profissao varchar(10) first;

-- Remover uma coluna
alter table pessoas
drop column profissao;

-- Modificar uma coluna, seus tipos primitivos e constraints
alter table pessoas
modify column profissao varchar(20) not null default '' after nome;

-- Modificar nome da coluna e suas constraints (nome velho - nome novo)
alter table pessoas
change column prof profissao varchar(20) not null default '';

-- Modificar nome da tabela
alter table pessoas
rename to alunos;

desc alunos;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------

create table if not exists cursos (
nome varchar(30) not null unique,
descricao text,
carga int unsigned,
total_aulas int,
ano year default '2016'
) default charset = utf8mb4;

desc cursos;

alter table cursos
add column idcurso int first;

-- Adicionar uma coluna como chave primária
alter table cursos
add primary key (idcurso);

-- Apagar tabela
drop table if exists cursos;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------

insert into cursos values
('1', 'HTML4', 'Curso de HTML5', '40', '37', '2014'),
('2', 'Algoritmos', 'Lógica de Progamação', '20', '15', '2014'),
('3', 'Photoshop', 'Dicas de Photoshop CC', '10', '8', '2014'),
('4', 'PGP', 'Curso de PHP para iniciantes', '40', '20', '2010'),
('5', 'Jarva', 'Introdução à Linguagem Java', '10', '29', '2000'),
('6', 'MySQL', 'Banco de Dados MySQL', '30', '15', '2016'),
('7', 'Word', 'Curso completo de Word', '40', '30', '2016'),
('8', 'Sapateado', 'Danças Rítmicas', '40', '37', '2018'),
('9', 'Cozinha Árabe', 'Aprender a fazer Kibe', '40', '30', '2018'),
('10', 'YouTuber', 'Gerar polêmica e ganhar inscritos', '5', '2', '2018');

-- Modificar uma informação de uma linha
update cursos
set nome = 'HTML5'
where idcurso = '1';

-- Modificar várias informações de uma linha
update cursos
set nome = 'PHP', ano = '2015'
where idcurso = '4';

-- "limit" limita quantas linhas serão afetadas pelo comando
update cursos
set nome = 'Java', carga = '40', ano = '2015'
where idcurso = '5'
limit 1;

-- Remover linhas
delete from cursos
where ano = 2018
limit 3;

-- Remover todas as linhas de uma tabela
truncate cursos;

insert into cursos values
('10', 'Sapateado', 'Danças Rítmicas', '40', '37', '2018'),
('9', 'Cozinha Árabe', 'Aprender a fazer Kibe', '40', '30', '2018'),
('8', 'YouTuber', 'Gerar polêmica e ganhar inscritos', '5', '2', '2018');

-- ---------------------------------------------------------------------------------------------------------------------------------------------------

drop table alunos;

alter table gafanhotos
rename to alunos;

-- Seleciona todos os registros de uma tabela
select * from cursos;

-- Seleciona todos os registros e ordena a tabela por uma coluna
select * from cursos
order by nome;

-- Seleciona todos os registros e ordena a tabela por uma coluna descendente
select * from cursos
order by nome desc;

-- Seleciona apenas os registros das colunas desejadas de uma tabela
select ano, nome, carga from cursos
order by ano;

-- Seleciona apenasos registros das linhas desejadas de uma tabela
select * from cursos
where ano = '2016'
order by nome;

-- Seleciona apenas os registros das linhas e colunas desejadas de uma tabela
select nome, descricao, ano from cursos
where ano <= '2015'
order by nome;

-- Seleciona apenas os registros dos intervalos desejados de uma tabela
select nome, ano from cursos
where ano between '2014' and '2016'
order by ano desc, nome asc;

-- Seleciona apenas os registros dos valores desejados de uma tabela
select nome, descricao, ano from cursos
where ano in (2014, 2018)
order by ano;

-- Combinando testes
select nome, carga, totaulas from cursos
where carga > 35 and totaulas < 30
order by nome;

-- Operador LIKE
select * from cursos
where nome like 'p%';

select * from cursos
where nome like '%p';
 
select * from cursos
where nome like '%a%';
 
select * from cursos
where nome not like '%a%';

select * from cursos
where nome like 'ph%p';

select * from cursos
where nome like 'ph%p%';

select * from cursos
where nome like 'ph%p_';

-- Distinguir coisas
select distinct carga from cursos;

select distinct nacionalidade from alunos
order by nacionalidade;

-- Funções de agregação
select count(*) from cursos;

select max(carga) from cursos;

select min(carga) from cursos;

select avg(carga) from cursos;

select sum(totaulas) from cursos
where ano = '2016';

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
--            --
-- Exercícios --
--            --

-- 1) Uma lista com o nome de todos as alunas.
select nome from alunos
where sexo = 'F';

-- 2) Uma lista com os dados de todos aqueles que nasceram entre 1/01/2000 e 31/12/2015.
select * from alunos
where nascimento between '2000-01-01'
and '2015-12-31';

-- 3) Uma lista com o nome de todos os homens que trabalham como programadores.
select * from alunos
where profissao = 'programador' 
and sexo = 'M';

-- 4) Uma lista com os dados de todas as mulheres que nasceram no Brasil e que têm seu nome iniciando com a letra J.
select * from alunos
where sexo = 'F' 
and nacionalidade = 'Brasil' 
and nome like 'J%';

-- 5) Uma lista com o nome e nacionalidade de todos os homens que têm Silva no nome, não nasceram no Brasil e pesam menos de 100 Kg.
select nome, nacionalidade from alunos
where sexo = 'M'
and nome like '%SILVA%'
and nacionalidade <> 'Brasil'
and peso < '100';

-- 6) Qual é a maior altura entre alunos Homens que moram no Brasil?
select max(altura) from alunos
where sexo = 'M'
and nacionalidade = 'Brasil';

-- 7) Qual é a média de peso dos alunos cadastrados?
select avg(peso) from alunos;

-- 8) Qual é o menor peso entre as alunas Mulheres que nasceram fora do Brasil e entre 01/01/1990 e 31/12/2000?
select min(peso) from alunos
where sexo = 'F'
and nacionalidade not like 'Brasil'
and nascimento between '1990-01-01' and '2000-12-01';

-- 9) Quantas alunas Mulheres tem mais de 1.90cm de altura?
select count(*) from alunos
where altura > '1.90';

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- Agrupando registros
select carga from cursos
group by carga;

select carga, count(nome) from cursos
group by carga;

-- Agrupando e agregando
select carga, count(nome) from cursos
group by carga
having count(nome) > 3;

select ano, count(*) from cursos
where totaulas > 30
group by ano
having ano > 2013
order by count(*) desc;

select carga, count(*) from cursos
where ano > 2015
group by carga
having carga > (select avg(carga) from cursos);

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
--            --
-- Exercícios --
--            --

-- 1) Uma lista com as profissoes dos alunos e seus respectivos quantitativos.
select profissao, count(profissao) from alunos
group by profissao
order by profissao;

-- 2) Quantos alunos homens e mulheres nasceram após 01/jan/2005?
select count(*) from alunos
where nascimento > '2005-01-01';

-- 3) Lista com alunos que nasceram fora do BRASIL, mostrando o país de origem
-- e o total de pessoas nascidas lá. Só nos interessam os países que tiveram mais de 3
-- alunos com essa nacionalidade
select nacionalidade, count(*) from alunos 
where nacionalidade not like 'brasil'
group by nacionalidade
having count(nacionalidade ) > '3';

-- 4) Lista agrupada pela altura dos alunos, mostrando quantas pessoas 
-- pesam mais de 100kg e que estao acima da media da altura de todos os alunos
select altura,count(*) from alunos
where peso > '100'
group by altura
having altura > (select avg(altura)from alunos);

-- ---------------------------------------------------------------------------------------------------------------------------------------------------

