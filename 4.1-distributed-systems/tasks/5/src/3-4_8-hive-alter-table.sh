alter table ctas_test rename to ctas_test_internal;
alter table ctas_test_internal set tblproperties ('comment'='ctas generated');
alter table ctas_test_internal add columns (addr string, id int);
alter table ctas_test_internal change name emp_name string;
alter table ctas_test_internal change id id string;


alter table ctas_test_internal change id id int;  # Error Expected
alter table ctas_test_internal change id emp_id string after salary;
alter table ctas_test_internal replace columns (name string, salary int);

describe extended ctas_test_internal;
