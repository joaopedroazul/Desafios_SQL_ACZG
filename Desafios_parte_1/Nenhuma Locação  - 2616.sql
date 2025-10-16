select c.id, c.name from customers as c
left join locations as l on c.id = l.id_customers
where l.id_customers is null