---ATENÇÃO - NECESSÁRIO ESTAR LOGADO COM 'loja'
--- insere movimentações de saidas(vendas) extras

	---------------------------------------------------
    --- OP1 vende 20 mangas a fulano
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
   (SELECT TOP 1 id FROM Pessoa WHERE tipo='F' and nome LIKE 'ful%'),
   (SELECT TOP 1 idProduto FROM Produto WHERE nome LIKE 'man%'),
   20,
   (SELECT TOP 1 precoVenda FROM Produto WHERE nome LIKE 'man%'),
   'S';

   	---------------------------------------------------
    --- OP1 vende 20 laranjas a ciclana
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
   (SELECT TOP 1 idProduto FROM Produto WHERE nome LIKE 'la%'),
   20,
   (SELECT TOP 1 precoVenda FROM Produto WHERE nome LIKE 'la%'),
   'S';

    ---------------------------------------------------
    --- OP2 vende 30 bananas a Mari
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
   (SELECT TOP 1 idUsuario FROM Usuario WHERE login = 'op2'),
   (SELECT TOP 1 id FROM Pessoa WHERE tipo='F' and nome LIKE 'mar%'),
   (SELECT TOP 1 idProduto FROM Produto WHERE nome LIKE 'ba%'),
   30,
   (SELECT TOP 1 precoVenda FROM Produto WHERE nome LIKE 'ba%'),
   'S';
