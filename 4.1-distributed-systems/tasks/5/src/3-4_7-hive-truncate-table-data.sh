# beeline -n hduser -u jdbc:hive2://localhost:10000

dfs -ls /user/hive/warehouse/test_internal;
truncate table test_internal;
select * from test_internal;
dfs -ls /user/hive/warehouse/test_internal;
