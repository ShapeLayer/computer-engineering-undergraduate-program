beeline -n hduser -u jdbc:hive2://localhost:10000

create table ctas_test as select * from test;
select * from ctas_test;
dfs -ls /user/hive/warehouse;
dfs -ls /user/hive/warehouse/ctas_test;
