---ATENÇÃO - NECESSÁRIO ESTAR LOGADO COM 'loja'
--- insere movimentações de entradas(compras) extras

	-- 1° insert movimento
	 
	----------------------------------------------------
    --- OP3 compra 20 bananas do fornecedor Hortifruti sucesso
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
   20,
   (SELECT TOP 1 precoVenda FROM Produto WHERE nome LIKE 'bana%'),
   'E';


   ----------------------------------------------------
    --- OP3 compra 38 laranjas do fornecedor Hortifruti sucesso
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
   (SELECT TOP 1 idProduto FROM Produto WHERE nome LIKE 'lar%'),
   38,
   (SELECT TOP 1 precoVenda FROM Produto WHERE nome LIKE 'lar%'),
   'E';
