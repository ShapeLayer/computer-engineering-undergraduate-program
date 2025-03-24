USE employees;

SELECT last_name, count(*) AS num_of_emp FROM employees
                                         GROUP BY last_name
                                         HAVING num_of_emp > 220;
