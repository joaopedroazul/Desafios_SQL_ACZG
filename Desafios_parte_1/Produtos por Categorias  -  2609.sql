select c.name, sum(p.amount)
from products as p 
left join categories as c
on p.id_categories = c.id
group by c.name
