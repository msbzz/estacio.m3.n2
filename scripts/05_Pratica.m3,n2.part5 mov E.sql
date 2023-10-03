---ATENÇÃO - NECESSÁRIO ESTAR LOGADO COM 'loja'
--- insere movimentações de entradas(compras)

	-- 1° insert movimento

	delete from Movimento where tipo='E'
	----------------------------------------------------
    --- OP3 compra 30 bananas do fornecedor Hortifruti sucesso
    ----------------------------------------------------

	INSERT INTO Movimento 
		(
		 idUsuario,
    	 idPessoa,
		 idProduto,
		 quantidade,
		 valorUnitario,
		 tipo
		)

   SELECT 
   (SELECT TOP 1 idUsuario FROM Usuario WHERE login = 'op3'),
   (SELECT TOP 1 id FROM Pessoa WHERE tipo='J' and nome LIKE 'Hort%'),
   (SELECT TOP 1 idProduto FROM Produto WHERE nome LIKE 'bana%'),
   30,
   (SELECT TOP 1 precoVenda FROM Produto WHERE nome LIKE 'bana%'),
   'E';

--- ver 1° compra

select 'op3 compra 30 bananas' as acao1

   select 
u.login as operador,
mv.tipo as operacao,
p.nome as produto,
mv.quantidade,
mv.valorUnitario,
(mv.valorUnitario*mv.quantidade) as total,
pe.nome as fornecedor,
pj.cnpj
from ((((movimento mv inner join produto p on p.idProduto=mv.idProduto)
inner join usuario u on u.idUsuario=mv.idUsuario)
left join PessoaJuridica pj on mv.idPessoa=pj.idPessoa) inner join Pessoa pe on pe.id=pj.idpessoa) 
where mv.tipo='E'

---------------------------------------------------------------------------------------------------------------
-- 2° insert movimento

	---------------------------------------------------
    --- OP3 compra 10 laranjas do fornecedor Hortifruti sucesso
    ----------------------------------------------------

	INSERT INTO Movimento 
		(
		 idUsuario,
    	 idPessoa,
		 idProduto,
		 quantidade,
		 valorUnitario,
		 tipo
		)

   SELECT 
   (SELECT TOP 1 idUsuario FROM Usuario WHERE login = 'op3'),
   (SELECT TOP 1 id FROM Pessoa WHERE tipo='J' and nome LIKE 'Hort%'),
   (SELECT TOP 1 idProduto FROM Produto WHERE nome LIKE 'lara%'),
   10,
   (SELECT TOP 1 precoVenda FROM Produto WHERE nome LIKE 'lara%'),
   'E';

--- ver 2° compra

select 'op3 compra 10 laranjas' as acao2

   select 
u.login as operador,
mv.tipo as operacao,
p.nome as produto,
mv.quantidade,
mv.valorUnitario,
(mv.valorUnitario*mv.quantidade) as total,
pe.nome as fornecedor,
pj.cnpj
from ((((movimento mv inner join produto p on p.idProduto=mv.idProduto)
inner join usuario u on u.idUsuario=mv.idUsuario)
left join PessoaJuridica pj on mv.idPessoa=pj.idPessoa) inner join Pessoa pe on pe.id=pj.idpessoa) 
where mv.tipo='E'

---------------------------------------------------------------------------------------------------------------
-- 3° insert movimento

	---------------------------------------------------
    --- OP1 compra 50 mangas do fornecedor Mercado principal
    ----------------------------------------------------

	INSERT INTO Movimento 
		(
		 idUsuario,
    	 idPessoa,
		 idProduto,
		 quantidade,
		 valorUnitario,
		 tipo
		)

   SELECT 
   (SELECT TOP 1 idUsuario FROM Usuario WHERE login = 'op1'),
   (SELECT TOP 1 id FROM Pessoa WHERE tipo='J' and nome LIKE 'Merc%'),
   (SELECT TOP 1 idProduto FROM Produto WHERE nome LIKE 'man%'),
   50,
   (SELECT TOP 1 precoVenda FROM Produto WHERE nome LIKE 'man%'),
   'E';

--- ver 3° compra

select 'op1 compra 50 mangas' as acao2

   select 
u.login as operador,
mv.tipo as operacao,
p.nome as produto,
mv.quantidade,
mv.valorUnitario,
(mv.valorUnitario*mv.quantidade) as total,
pe.nome as fornecedor,
pj.cnpj
from ((((movimento mv inner join produto p on p.idProduto=mv.idProduto)
inner join usuario u on u.idUsuario=mv.idUsuario)
left join PessoaJuridica pj on mv.idPessoa=pj.idPessoa) inner join Pessoa pe on pe.id=pj.idpessoa) 
where mv.tipo='E'
