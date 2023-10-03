---ATENÇÃO - NECESSÁRIO ESTAR LOGADO COM 'loja'
--- insere produtos

    delete from produto

  	-- insert produto
	INSERT INTO Produto ( nome, quantidade, precoVenda)
    VALUES ('banana', 100, 10.5),
           ('laranja', 50, 20.0),
           ('manga', 200, 5.75);


select 'produtos inseridos' as acao

select * from produto