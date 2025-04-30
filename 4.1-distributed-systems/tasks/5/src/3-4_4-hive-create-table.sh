# beeline -n hduser -u jdbc:hive2://localhost:10000

create table cte_test as with
r1 as (select name from test where name = 'peter'),
r2 as (select name from test where salary < 1300)
select * from r1 union all select * from r2;

select * from cte_test;
