select * from information_schema.columns
where table_schema = 'cycling' and table_name = 'metrics'
order by table_name, ordinal_position;


select 
concat( '{''columnName'': ', concat('''', concat(column_name, ''','))) as ColumnName, 
concat( '''position'': ', concat('', concat(ordinal_position, ','))) as Position,
concat( '''data_type'': ', concat('''', concat(data_type, '''},'))) as Data_type 
from information_schema.columns
where table_schema = 'cycling' and table_name = 'metrics'
order by table_name, ordinal_position;
