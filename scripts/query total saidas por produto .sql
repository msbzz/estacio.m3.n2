1 - Quais as diferenças no uso de sequence e identity?

    A sequence se trata de um objeto separado ao qual pode ser usado em qualquer coluna, desde que numérica enquanto que identity é um atributo que por ser restrita e única por coluna, é usada como chave primaria. 

    A sequence porem, não é impeditida de ser usada como chave primaria desde que com o controle adequado.


2 - Qual a importância das chaves estrangerias para a
    consistência do banco?
     
    A integridade referencial ou consistencia dos dados relacionados entre duas tabelas

    Evitar dados orfãos. Como dito acima, consistencia dos dados
    
    Perfomance pois otimizam as consultas
    
    Garantem transações seguras    

 
3 - Quais operadores do SQL pertencem à álgebra relacional
    e quais são definidos no cálculo relacional?

    Seleção (select * from)
    Projeção (select col1,col2 from)
    Produto cartesiano(from Tab1,Tab2)
    União (union)
    Diferença (EXCEPT SELECT, where col not in(),where not(col=))
    Junção (Join)
    Divisão - (feito através de uma combinação de operações)

4 - Como é feito o agrupamento em consultas, e qual
    requisito é obrigatório?

    Feito através da clausula group by onde somente colunas declaradas poderão ser declaradas na query ou outras colunas que seja aplicadas funções agregadas com SUM,AVG,COUNT.etc..