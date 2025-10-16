select tab.* from 
(Select Dep.nome as departamento,div.nome as divisao,round((sum(pagamentos.salario)/count(pagamentos.lotacao_div)),2) as media,MAX(pagamentos.salario) as maior
from departamento as dep
left join divisao as div
on div.cod_dep = dep.cod_dep
left join(
Select emp.matr, emp.lotacao,emp.lotacao_div,COALESCE((sum(valores.salario)-COALESCE(sum(descontos.desconto),0.00)),0.00) as salario
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
group by emp.matr, emp.lotacao,emp.lotacao_div
order by salario desc
)
 as pagamentos
on dep.cod_dep = pagamentos.lotacao and div.cod_divisao = pagamentos.lotacao_div
group  by Dep.nome,div.nome) as tab
order by media  desc
