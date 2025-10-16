select tab.* from 
(
Select Dep.nome as departamento, pag.nome ,pag."Salario Bruto",pag."Total Desconto",pag."Salario Liquidoaws"
from departamento as dep
left join divisao as div
on div.cod_dep = dep.cod_dep
left join(
	Select emp.matr,emp.nome, emp.lotacao,emp.lotacao_div,COALESCE(sum(valores.salario),0) as "Salario Bruto", 
	COALESCE(sum(descontos.desconto),0) as  "Total Desconto",(COALESCE(sum(valores.salario),0) - COALESCE(sum(descontos.desconto),0)) as "Salario Liquidoaws"
	from empregado as emp
	left join(
		select e.matr,sum(v.valor) as salario
		from emp_venc as e
		left join vencimento as v
		on v.cod_venc = e.cod_venc
		group by e.matr
	)as valores
	on valores.matr = emp.matr
		left join(
		select e.matr,sum(d.valor) as desconto
		from emp_desc as e
		left join desconto as d
		on d.cod_desc = e.cod_desc
		group by e.matr
	) as descontos
	on descontos.matr = emp.matr
	group by emp.matr,emp.nome, emp.lotacao,emp.lotacao_div
) as pag
on dep.cod_dep = pag.lotacao and div.cod_divisao = pag.lotacao_div
) as tab
order by tab."Salario Liquidoaws"  desc,tab.nome desc
