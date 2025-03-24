USE employees;

SELECT count(*) FROM salaries WHERE salary > ALL (
SELECT salary FROM salaries JOIN dept_manager
    ON salaries.emp_no = dept_manager.emp_no
              WHERE dept_manager.dept_no='d001');

SELECT count(*) FROM salaries WHERE salary > ANY (
SELECT emp_no FROM dept_manager WHERE dept_no='d001');
