USE employees;

SELECT * FROM (SELECT emp_no, max(salary) AS max_salary
               FROM salaries GROUP BY emp_no) AS tmp_salaries
         WHERE max_salary > 90000
         ORDER BY max_salary DESC LIMIT 30;


SELECT employees.first_name, employees.laSt_name, max_salary
FROM (SELECT emp_no, max(salary) AS max_salary
      FROM salaries GROUP BY emp_no) AS tmp_salaries
    JOIN employees ON employees.emp_no = tmp_salaries.emp_no
WHERE max_salary > 90000 ORDER BY max_salary DESC limit 30;
