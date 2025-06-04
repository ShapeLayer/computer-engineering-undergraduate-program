-- Page 7
show databases;
create database testdb1;
use testdb1;

-- Page 8
create table flight (
  DEST_COUNTRY_NAME STRING,
  ORIGIN_COUNTRY_NAME STRING,
  count LONG
);

show tables;
describe table flight;
describe table extended flight;
drop table flight;

-- Page 9
create table flight (
  DEST_COUNTRY_NAME STRING,
  ORIGIN_COUNTRY_NAME STRING,
  count LONG
) row format delimited fields terminated by ',';

load data local inpath '/home/hduser/data/test.csv' into table flight;

select * from flight;
describe table flight;
describe table extended flight;

-- Page 10
create table flight1 (
  DEST_COUNTRY_NAME STRING,
  ORIGIN_COUNTRY_NAME STRING,
  count LONG
) using json options (
  path '/home/hduser/data/2015-summary.json'
);

-- Page 11
create external table flight2 row format delimited fields terminated by ','
location '/home/hduser/data/spark/sql/flight2/' as
select * from flight where count > 2;

describe table extended flight2;

create view usa_flight as select * from flight where dest_country_name='United States';
describe table extended usa_flight;
