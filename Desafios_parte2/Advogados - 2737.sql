select t2.* from(select  tab.name, max(tab.totalClientes) as clientes from (select name, sum(customers_number) totalClientes from lawyers
group by name) as tab
group by tab.name
order by clientes desc limit 1)as t2
union all
select t.* from(select  tab.name, min(tab.totalClientes) as clientes from (select name, sum(customers_number) totalClientes from lawyers
group by name) as tab
group by tab.name
order by clientes asc limit 1) as t
union all
select  'Average' as name,round( sum(tab.totalClientes)/count(tab.name),0) as clientes from (select name, sum(customers_number) totalClientes from lawyers
group by name) as tab