USE employees;

SELECT count(*) FROM dept_manager LEFT JOIN salaries
    ON dept_manager.emp_no = salaries.emp_no;

SELECT count(*) FROM salaries LEFT JOIN dept_manager
    ON dept_manager.emp_no = salaries.emp_no;
