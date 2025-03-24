USE employees;

SELECT * FROM dept_manager
    JOIN salaries
        ON dept_manager.emp_no = salaries.emp_no;

SELECT count(*) FROM departments JOIN salaries;
SELECT count(*) FROM departments CROSS JOIN salaries;
SELECT count(*) FROM dept_manager JOIN salaries;
