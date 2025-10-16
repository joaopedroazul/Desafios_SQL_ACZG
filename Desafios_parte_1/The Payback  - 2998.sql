select c.name,c.investment,tab.ultimo_mes as month_of_payback,(tab.lucro-c.investment) as "return"
from Clients as c
left join 
((Select tab.id, (tab.lucro - 
(select profit
from operations
where month = tab.ultimo_mes and client_id = tab.id)) as lucro,
( ultimo_mes - 1) as ultimo_mes
from
	(select c.id as id, sum(o.profit ) as lucro,max(o.month) as ultimo_mes 
	from Clients as c
	left join operations as o
	on c.id = o.client_id 
	group by c.id) as tab
left join clients as c
on c.id = tab.id
where (tab.lucro - c.investment) > 0 
union
Select tab.id, tab.lucro as lucro,tab.ultimo_mes as ultimo_mes from
(select c.id as id, sum(o.profit ) as lucro,max(o.month) as ultimo_mes 
from Clients as c
left join operations as o
on c.id = o.client_id 
group by c.id) as tab
left join clients as c
on c.id = tab.id
where (tab.lucro - c.investment) <= 0
)order by id) as tab
on tab.id = c.id
where (tab.lucro-c.investment) >=0
order by c.name

