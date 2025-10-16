# Desafios SQL

## Autor

 Joao Pedro Silva de Andrade
 
## Descrição
	
Projeto desenvolvido como solução dos desafios extras de PostgreSQL .

## Comandos utilizados

COALESCE -> subtituir um valor num por qualquer outro valor de sua escolha

ex: COALESCE(C.valor, 0.00)

UNION -> retorna duas query agrupadas em uma

ex: SELECT cidade FROM Comprador
    UNION
    SELECT cidade FROM Fabricante
    ORDER BY cidade;
