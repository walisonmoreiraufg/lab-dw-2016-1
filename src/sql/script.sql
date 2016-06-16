-- URL JDBC para acessar o banco de dados.
--jdbc:derby:db;create=true

create table usuario (
  codigo int,
  nome varchar(255),
  login varchar(255),
  senha  varchar(255)
)

insert into usuario (codigo, nome, login, senha) values (1, 'João', 'joao', '123')

select codigo, nome, login, senha from usuario