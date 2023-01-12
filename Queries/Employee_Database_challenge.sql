SELECT emp_no, first_name, last_name
INTO employee_search
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31');

SELECT emp_no, title, to_date
INTO title_search
FROM titles;

SELECT employee_search.emp_no, employee_search.first_name, employee_search.last_name,
title_search.title, title_search.to_date
INTO retirement_titles
FROM employee_search
INNER JOIN title_search
ON employee_search.emp_no = title_search.emp_no;

drop table employee_search, title_search;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name, last_name, title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no ASC;

SELECT COUNT(emp_no), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date,
de.from_date, de.to_date, ti.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (de.emp_no = ti.emp_no)
WHERE(de.to_date = '9999-01-01') 
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31');

-- Extra Query
SELECT ut.emp_no,
ut.first_name,
ut.last_name,
s.salary
INTO extra_query
from unique_titles as ut
INNER JOIN salaries as s
ON (ut.emp_no = s.emp_no);

SELECT AVG(salary) from extra_query;

-- Extra Query 2
SELECT AVG(s.salary), de.dept_no
FROM dept_emp as de
INNER JOIN salaries as s
ON (s.emp_no = de.emp_no)
GROUP BY de.dept_no
