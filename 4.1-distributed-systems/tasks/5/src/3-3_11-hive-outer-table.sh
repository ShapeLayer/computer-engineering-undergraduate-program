cp ./test1.dat ~/hive_test/data/

# beeline -n hduser -u jdbc:hive2://localhost:10000

create table if not exists test_external (name string, salary int)
comment 'external table' row format delimited fields
terminated by ',' stored as textfile location '/output';

load data local inpath '/home/hduser/hive_test/data/test1.dat'
overwrite into table test_external;


select * from test_external;
dfs -ls /user/hive/warehouse;
dfs -ls /output;
