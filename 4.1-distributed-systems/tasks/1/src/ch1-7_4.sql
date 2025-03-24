USE employees;

SELECT * FROM employees
         WHERE first_name IN ('Mori','Barna') OR
               last_name='kitai'
         ORDER BY birth_date;

SELECT * FROM employees
         WHERE first_name in ('Mori','Barna') OR
               last_name='kitai'
         ORDER BY birth_date DESC;

SELECT * FROM employees
         WHERE first_name IN ('Mori','Barna') OR
               last_name='kitai'
         ORDER BY birth_date, hire_date DESC;
