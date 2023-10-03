---ATENÇÃO - NECESSÁRIO ESTAR LOGADO COM 'loja'
--- criação das tabelas

USE loja;
GO
-------------------------------------------------------
--- DROP VIEWS
-------------------------------------------------------
---Movimento precisa ser removida antes devido a integridade com as demais
-------------------------------------------------------
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'movimento')
BEGIN
    DROP TABLE movimento;
END
-------------------------------------------------------
-- Produto
-------------------------------------------------------
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Produto')
BEGIN
    DROP TABLE Produto;
END
---usuario
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Usuario')
BEGIN
    DROP TABLE Usuario;
END
-------------------------------------------------------
--- sequence pessoa
-------------------------------------------------------
IF EXISTS (SELECT * FROM sys.sequences WHERE name = 'PessoaIdSeq')
BEGIN
    DROP SEQUENCE PessoaIdSeq;
END
-------------------------------------------------------
--PesoaFisica e Juridica devem ser removidas antes
--PessoaFisica
-------------------------------------------------------
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PessoaFisica')
BEGIN
    DROP TABLE PessoaFisica;
END
-------------------------------------------------------
--PessoaJuridica
-------------------------------------------------------
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PessoaJuridica')
BEGIN
    DROP TABLE PessoaJuridica;
END
-------------------------------------------------------
---Pessoa
-------------------------------------------------------
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Pessoa')
BEGIN
    DROP TABLE Pessoa;
END

-------------------------------------------------------
---CREATE TABLES
-------------------------------------------------------
---Produto
-------------------------------------------------------
CREATE TABLE Produto (
  idProduto INT IDENTITY(1,1),
  nome VARCHAR(45),
  quantidade INT,
  precoVenda DECIMAL(10, 2),
  PRIMARY KEY (idProduto)
);
-------------------------------------------------------
--Usuario
-------------------------------------------------------
CREATE TABLE Usuario (
  idUsuario  INT IDENTITY(1,1),
  login CHAR(100) NOT NULL UNIQUE,
  senha CHAR(150) NOT NULL,
  PRIMARY KEY (idUsuario)
);
-------------------------------------------------------
-- sequence PessoaFIsica e Juridica
-------------------------------------------------------
CREATE SEQUENCE PessoaIdSeq
AS INT
START WITH 1
INCREMENT BY 1;
-------------------------------------------------------
--Pessoa
-------------------------------------------------------
CREATE TABLE Pessoa (
    id INT PRIMARY KEY NOT NULL,
    nome NVARCHAR(60) NOT NULL,
    logradouro VARCHAR(255),
    cidade VARCHAR(100),
    estado VARCHAR(2),
    telefone VARCHAR(11),
    email VARCHAR(255),
    tipo CHAR(1) CHECK (tipo IN ('F', 'J')) NOT NULL -- F para física, J para jurídica
);
-------------------------------------------------------
-- Pessoafisica
-------------------------------------------------------
CREATE TABLE PessoaFisica (
    idpessoa INT PRIMARY KEY,
	cpf CHAR(11),
    FOREIGN KEY (idpessoa) REFERENCES Pessoa(id)
	ON DELETE CASCADE
);
 
-- PessoaJuridica
 CREATE TABLE PessoaJuridica (
  idpessoa INT PRIMARY KEY,
  cnpj CHAR(14),
  FOREIGN KEY (idpessoa) REFERENCES Pessoa(id)
  ON DELETE CASCADE
);

-------------------------------------------------------
--Movimento
-------------------------------------------------------
CREATE TABLE Movimento (
  idMovimento INT IDENTITY(1,1), 
  idUsuario INT,
  idPessoa INT,
  idProduto INT,
  quantidade INT,
  valorUnitario decimal(10,2),
  tipo CHAR(1),
  PRIMARY KEY (idMovimento),
  FOREIGN KEY (idProduto)
    REFERENCES Produto(idProduto)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (idUsuario)
    REFERENCES Usuario(idUsuario)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
	FOREIGN KEY (idPessoa)
    REFERENCES Pessoa(id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
);

  
-------------------------------------------------------
-- CREATE VIEWS PESSOAS
-------------------------------------------------------
-- fisica
-------------------------------------------------------
GO

IF EXISTS (SELECT * FROM sys.views WHERE name = 'vw_pessoa_fisica')
DROP VIEW vw_pessoa_fisica;
 

-- vou usar top para manter order (regras da view)
GO

CREATE VIEW vw_pessoa_fisica AS
select p.id,pf.idPessoa,p.nome,p.logradouro,p.cidade,p.estado,p.telefone,p.email,pf.cpf 
from (pessoa p inner join pessoafisica pf on p.id=pf.idpessoa)
 

-------------------------------------------------------
-- Juridica
-------------------------------------------------------
GO

IF EXISTS (SELECT * FROM sys.views WHERE name = 'vw_pessoa_juridica')
DROP VIEW vw_pessoa_juridica;


-- vou usar top para manter order (regras da view)
GO

CREATE VIEW vw_pessoa_juridica AS
select p.id,pj.idPessoa,p.nome,p.logradouro,p.cidade,p.estado,p.telefone,p.email,pj.cnpj 
from (pessoa p inner join pessoaJuridica pj on p.id=pj.idpessoa)
 
-------------------------------------------------------
-- Movimentações de entrada, com produto, fornecedor
-------------------------------------------------------
GO

IF EXISTS (SELECT * FROM sys.views WHERE name = 'vw_mov_compras')
DROP VIEW vw_mov_compras;
GO

-- vou usar top para manter order (regras da view)
GO

CREATE VIEW vw_mov_compras AS
select 
u.login as operador,
mv.tipo as operacao,
p.nome as produto,
mv.quantidade,
mv.valorUnitario,
(mv.valorUnitario*mv.quantidade) as total,
pe.nome as comprador,
pj.cnpj
from ((((movimento mv inner join produto p on p.idProduto=mv.idProduto)
inner join usuario u on u.idUsuario=mv.idUsuario)
left join PessoaJuridica pj on mv.idPessoa=pj.idPessoa) inner join Pessoa pe on pe.id=pj.idpessoa) 
where mv.tipo='E'
GO
-------------------------------------------------------
--Movimentações de saída, com produto, comprador, quantidade, preço unitário e valor total.
-------------------------------------------------------
IF EXISTS (SELECT * FROM sys.views WHERE name = 'vw_mov_vendas')
DROP VIEW vw_mov_vendas;
GO

-- vou usar top para manter order (regras da view)
GO

CREATE VIEW vw_mov_vendas AS
select 
u.login as operador,
mv.tipo as operacao,
p.nome as produto,
mv.quantidade,
mv.valorUnitario,
(mv.valorUnitario*mv.quantidade) as total,
pe.nome as fornecedor,
pf.cpf
from ((((movimento mv inner join produto p on p.idProduto=mv.idProduto)
inner join usuario u on u.idUsuario=mv.idUsuario)
left join PessoaFisica pf on mv.idPessoa=pf.idPessoa) inner join Pessoa pe on pe.id=pf.idpessoa) 
where mv.tipo='S'  

GO
 
-------------------------------------------------------
-- CREATE VIEWS OPERADORES
-------------------------------------------------------
--- Compras
-------------------------------------------------------
GO

IF EXISTS (SELECT * FROM sys.views WHERE name = 'vw_operador_compras')
DROP VIEW vw_operador_compras;
GO

-- vou usar top para manter order (regras da view)
GO
CREATE VIEW vw_operador_compras AS
select 
u.login as operador,
mv.tipo as operacao,
p.nome as produto,
mv.quantidade,
mv.valorUnitario,
(mv.valorUnitario*mv.quantidade) as total,
pe.nome as comprador,
pj.cnpj
from ((((movimento mv inner join produto p on p.idProduto=mv.idProduto)
inner join usuario u on u.idUsuario=mv.idUsuario)
left join PessoaJuridica pj on mv.idPessoa=pj.idPessoa) inner join Pessoa pe on pe.id=pj.idpessoa) 
where mv.tipo='E';
GO

-------------------------------------------------------
-- vendas
-------------------------------------------------------
GO

IF EXISTS (SELECT * FROM sys.views WHERE name = 'vw_operador_vendas')
DROP VIEW vw_operador_vendas;
GO

-- vou usar top para manter order (regras da view)

CREATE VIEW vw_operador_vendas AS
select 
u.login as operador,
mv.tipo as operacao,
p.nome as produto,
mv.quantidade,
mv.valorUnitario,
(mv.valorUnitario*mv.quantidade) as total,
pe.nome as fornecedor,
pf.cpf
from ((((movimento mv inner join produto p on p.idProduto=mv.idProduto)
inner join usuario u on u.idUsuario=mv.idUsuario)
left join PessoaFisica pf on mv.idPessoa=pf.idPessoa) inner join Pessoa pe on pe.id=pf.idpessoa) 
where mv.tipo='S' 
GO

IF EXISTS (SELECT * FROM sys.views WHERE name = 'vw_media_ponderada')
DROP VIEW vw_media_ponderada;
GO 

CREATE VIEW vw_media_ponderada AS
 SELECT 
    SUM(valorUnitario * quantidade) AS TotalVendas,
    SUM(quantidade) AS TotalQuantidade,
	CAST(FLOOR(SUM(valorUnitario * quantidade) * 100 / SUM(quantidade)) / 100 AS DECIMAL(10, 2)) AS MediaPonderada
FROM 
    Movimento;