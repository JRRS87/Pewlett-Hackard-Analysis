Employee_Database_challenge

--CHALLENGE 7	
SELECT emp_no, first_name, last_name
FROM employees
	

SELECT titles, from_date, to_date
FROM titles

SELECT employees.emp_no,
       employees.first_name,
       employees.last_name,
       titles.titles,
       titles.from_date,
       titles.to_date
INTO retirement_titles
FROM employees 
INNER JOIN titles
ON (employees.emp_no = titles.emp_no)
WHERE (employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
order by employees.emp_no;


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
titles

INTO unique_tables
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

SELECT COUNT(unique_tables.emp_no),
unique_tables.titles
INTO retiring_titles
FROM unique_tables  
GROUP BY titles
ORDER BY COUNT(titles) DESC;

SELECT DISTINCT ON (e.emp_no) e.emp_no,
		e.first_name,
		e.last_name,
		e.birth_date,
		dept_manager.from_date,
		dept_manager.to_date,
		titles.titles
INTO mentorship_eligibility
FROM employees as e
FULL JOIN  dept_manager
ON (e.emp_no = dept_manager.emp_no)
FULL JOIN titles
ON (e.emp_no = titles.emp_no)
WHERE (dept_manager.to_date >= '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')

ORDER BY e.emp_no

;

--retrieve the number of employees by their most recent job title who are about to retire.
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count(emp_no) DESC;

SELECT * FROM retiring_titles;

-- Deliverable 2: The Employees Eligible for the Mentorship Program
-- create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program
SELECT emp_no, first_name, last_name, birth_date 
FROM employees;

SELECT emp_no, from_date, to_date
FROM dept_emp

SELECT emp_no, title FROM titles;

SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date,
	d.from_date, d.to_date, t.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS d
ON e.emp_no = d.emp_no
INNER JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE d.to_date = '9999-01-01' AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY e.emp_no;
