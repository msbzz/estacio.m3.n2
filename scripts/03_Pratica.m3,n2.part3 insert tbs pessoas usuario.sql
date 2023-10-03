---ATENÇÃO - NECESSÁRIO ESTAR LOGADO COM 'loja'
--- insere pessoa fisica, juridica e operadores (usuarios)
USE loja;
GO
   	----------------------------------------------------------------------------------- 
   delete from Movimento  
    
   delete from pessoa
 
    ----------------------------------------------------------------------------
    -- Insere em Pessoa fisica

	-- p1
    INSERT INTO Pessoa (id,nome, logradouro,cidade,estado ,telefone, email, tipo)
    VALUES ( NEXT VALUE FOR PessoaIdSeq,'Fulano Silva', 'Rua X', 'Cidade X', 'MG', '(21)3333333', 'fulano@example.com', 'F');

    -- Insere em PessoaFisica
    INSERT INTO PessoaFisica (idpessoa, cpf)
    VALUES ((SELECT MAX(id) FROM Pessoa where tipo='F'), '69418874083');

	-- p2
    INSERT INTO Pessoa (id,nome, logradouro,cidade,estado ,telefone, email, tipo)
    VALUES ( NEXT VALUE FOR PessoaIdSeq,'Ciclana Souza', 'Rua Y', 'Cidade Y', 'SP', '(21)4444444', 'ciclana@example.com', 'F');

 
    INSERT INTO PessoaFisica (idpessoa, cpf)
    VALUES ((SELECT MAX(id) FROM Pessoa where tipo='F'), '66203143049');    
  
	-- p3
    INSERT INTO Pessoa (id,nome, logradouro,cidade,estado ,telefone, email, tipo)
    VALUES ( NEXT VALUE FOR PessoaIdSeq,'Mari Silva', 'Rua X', 'Cidade T', 'SP', '(21)4445675', 'mari@example.com', 'F');

 
    INSERT INTO PessoaFisica (idpessoa, cpf)
    VALUES ((SELECT MAX(id) FROM Pessoa where tipo='F'), '65241594043');    


   
    -- Insere em Pessoa juridica
    INSERT INTO Pessoa (id,nome, logradouro,cidade,estado ,telefone, email, tipo)
    VALUES ( NEXT VALUE FOR PessoaIdSeq,'Hortifruti sucesso', 'Rua A', 'Cidade A', 'SP', '(11)1111111', 'empresaA@example.com', 'J');

     INSERT INTO PessoaJuridica (idpessoa, cnpj)
    VALUES ((SELECT MAX(id) FROM Pessoa where tipo='J'), '30333306000120');



	    INSERT INTO Pessoa (id,nome, logradouro,cidade,estado ,telefone, email, tipo)
    VALUES ( NEXT VALUE FOR PessoaIdSeq,'Mercado principal', 'Rua B', 'Cidade B', 'RJ', '(11)2222222', 'empresaB@example.com', 'J');

     INSERT INTO PessoaJuridica (idpessoa, cnpj)
    VALUES ((SELECT MAX(id) FROM Pessoa where tipo='J'), '33102645000194');


	-----------------------------------------------------------------------------------
	-- insere usuario
	-----------------------------------------------------------------------------------
	delete from Usuario

	insert into Usuario (login,senha)
	values('op1','op1'),
       ('op2','op2'),
       ('op3','op3');

 