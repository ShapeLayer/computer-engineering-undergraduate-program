# beeline -n hduser -u jdbc:hive2://localhost:10000

create table empty_ctas_test as select * from test where 1=2;
create table empty_like_test like test;
