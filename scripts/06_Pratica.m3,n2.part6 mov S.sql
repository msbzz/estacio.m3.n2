 ---ATENÇÃO - NECESSÁRIO ESTAR LOGADO COM 'loja'
--- insere movimentações de saida (vendas)

	-- 1° insert movimento

	delete from Movimento where tipo='S'
	----------------------------------------------------
    --- OP1 vende 10 bananas 
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
   (SELECT TOP 1 id FROM Pessoa WHERE tipo='F' and nome LIKE 'fu%'),
   (SELECT TOP 1 idProduto FROM Produto WHERE nome LIKE 'bana%'),
   10,
   (SELECT TOP 1 precoVenda FROM Produto WHERE nome LIKE 'bana%'),
   'S';

--- ver 1° compra

select 'op1 vende 10 bananas para fulano' as acao1

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

---------------------------------------------------------------------------------------------------------------
-- 2° insert movimento

	---------------------------------------------------
    --- OP1 vende 5 mangas
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
   (SELECT TOP 1 id FROM Pessoa WHERE tipo='F' and nome LIKE 'cic%'),
   (SELECT TOP 1 idProduto FROM Produto WHERE nome LIKE 'man%'),
   5,
   (SELECT TOP 1 precoVenda FROM Produto WHERE nome LIKE 'man%'),
   'S';

--- ver 2° venda

select 'op1 vende 5 mangas para ciclana' as acao2

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

---------------------------------------------------------------------------------------------------------------
-- 3° insert movimento

	---------------------------------------------------
    --- OP1 vende 15 laranjas
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
   (SELECT TOP 1 id FROM Pessoa WHERE tipo='F' and nome LIKE 'ma%'),
   (SELECT TOP 1 idProduto FROM Produto WHERE nome LIKE 'la%'),
   15,
   (SELECT TOP 1 precoVenda FROM Produto WHERE nome LIKE 'la%'),
   'S';

--- ver 3° venda

select 'op1 vende 15 laranjas para mari' as acao3

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
