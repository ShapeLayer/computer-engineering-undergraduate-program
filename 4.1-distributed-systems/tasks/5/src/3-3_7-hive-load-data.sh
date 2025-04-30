cp ./test.dat ~/hive_test/data/

beeline -n hduser -u jdbc:hive2://localhost:10000
load data local inpath '/home/hduser/hive_test/data/test.dat' overwrite into table test;

dfs -ls /user/hive/warehouse/test;
select * from test;

alter table test set serdeproperties ('field.delim'=',');
select * from test;


select * from test;
select name from test;
select salary as col1, name from test;
select * from test where salary > 1300 or salary < 1000;