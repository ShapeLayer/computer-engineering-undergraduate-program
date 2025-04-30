# beeline -n hduser -u jdbc:hive2://localhost:10000

create table if not exists test_internal (name string, salary int)
comment 'internal table' row format delimited fields
terminated by ',' stored as textfile;

load data local inpath '/home/hduser/hive_test/data/test.dat'
overwrite into table test_internal;

select * from test_internal;
