USE employees;

SELECT count(*) FROM employees;
SELECT count(*) AS num_of_records FROM employees;
SELECT last_name, MIN(birth_date), MAX(birth_date) FROM employees
                                                   GROUP BY last_name;
SELECT gender, count(*) AS num_of_emp FROM employees
                                      GROUP BY gender;
