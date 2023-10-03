
-------------------------------------------------------
-- Fisica
-------------------------------------------------------

CREATE VIEW vw_pessoa_fisica AS
select p.id,pf.idPessoa,p.nome,p.logradouro,p.cidade,p.estado,p.telefone,p.email,pf.cpf 
from (pessoa p inner join pessoafisica pf on p.id=pf.idpessoa)
 

-------------------------------------------------------
-- Juridica
-------------------------------------------------------

CREATE VIEW vw_pessoa_juridica AS
select p.id,pj.idPessoa,p.nome,p.logradouro,p.cidade,p.estado,p.telefone,p.email,pj.cnpj 
from (pessoa p inner join pessoaJuridica pj on p.id=pj.idpessoa)
 
-------------------------------------------------------
-- Movimentações de compras
-------------------------------------------------------

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
 
-------------------------------------------------------
-- Movimentações de vendas
-------------------------------------------------------
 
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
 
 
-------------------------------------------------------
--- Operadores compras
-------------------------------------------------------
 
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
--- Operadores vendas
-------------------------------------------------------
 
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


-------------------------------------------------------
--- Operadores media ponderada
-------------------------------------------------------


CREATE VIEW vw_media_ponderada AS
 SELECT 
    SUM(valorUnitario * quantidade) AS TotalVendas,
    SUM(quantidade) AS TotalQuantidade,
	CAST(FLOOR(SUM(valorUnitario * quantidade) * 100 / SUM(quantidade)) / 100 AS DECIMAL(10, 2)) AS MediaPonderada
FROM 
    Movimento;