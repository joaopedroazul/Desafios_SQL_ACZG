select tab.*,((tab.victories*3)+(tab.defeats*0)+tab.draws) as score
from
(select t.name,match.partidas as matches, COALESCE(win.vitorias,0) as victories,
COALESCE(lose.derrotas,0) as defeats,COALESCE(draw.empates,0) as draws
from teams as t
left join(
	select t.id,sum(t.pts) as vitorias 
	from
	(select t.id, Count (t.id) as pts from teams as t
	left join matches as m
	on t.id = m.team_1 
	where team_1_goals > team_2_goals
	group by t.id
	union all
	select t.id, Count (t.id) as pts from teams as t
	left join matches as m
	on t.id = m.team_2 
	where team_1_goals < team_2_goals
	group by t.id) as t
	group by t.id
) as win
on t.id = win.id

left join
(
	select t.id,sum(t.pts) as derrotas 
	from
	(select t.id, Count (t.id) as pts from teams as t
	left join matches as m
	on t.id = m.team_1 
	where team_1_goals < team_2_goals
	group by t.id
	union all
	select t.id, Count (t.id) as pts from teams as t
	left join matches as m
	on t.id = m.team_2 
	where team_1_goals > team_2_goals
	group by t.id) as t
	group by t.id
) as lose
on lose.id = t.id

left join(
	select t.id,sum(t.pts) as empates 
	from
	(select t.id, Count (t.id) as pts from teams as t
	left join matches as m
	on t.id = m.team_1 
	where team_1_goals = team_2_goals
	group by t.id
	union all
	select t.id, Count (t.id) as pts from teams as t
	left join matches as m
	on t.id = m.team_2 
	where team_1_goals = team_2_goals
	group by t.id) as t
	group by t.id
) as draw
on draw.id = t.id

left join (
	select t.id,sum(t.pts) as partidas 
	from
	(select t.id, Count (t.id) as pts from teams as t
	left join matches as m
	on t.id = m.team_1 
	group by t.id
	union all
	select t.id, Count (t.id) as pts from teams as t
	left join matches as m
	on t.id = m.team_2 
	group by t.id) as t
	group by t.id
) as match
on match.id = t.id
) as tab
order by score desc