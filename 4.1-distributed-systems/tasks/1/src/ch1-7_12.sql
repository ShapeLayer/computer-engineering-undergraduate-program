USE employees;

SELECT * FROM employees WHERE first_name LIKE 'j%' AND gender='M';
SELECT * FROM employees WHERE last_name LIKE 'K%' AND birth_date BETWEEN '1955-01-01' AND '1960-12-31';
SELECT * FROM employees WHERE first_name IN ('Mori','Barna') OR last_name='kitai';
