select tab.temperature, tab.number_of_records from(select temperature, mark,count(mark) as number_of_records
from records
group by temperature, mark
order by mark ) as tab