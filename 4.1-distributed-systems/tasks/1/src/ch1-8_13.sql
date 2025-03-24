USE employees;

SELECT emp_no FROM dept_manager WHERE dept_no='d001';
SELECT count(*) FROM salaries
                WHERE salary > (SELECT emp_no FROM dept_manager
                                              WHERE dept_no='d001');
