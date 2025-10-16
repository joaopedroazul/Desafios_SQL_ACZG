select c.name, 
round((((s.math*2)+(s.specific*3)+(s.project_plan*5.0))/10.0),2) avg
from candidate as c
left join score as s on c.id = s.candidate_id
order by avg desc