/*
	Challenge 1
*/

SELECT
	a.au_id AS 'AUTHOR ID',
	a.au_lname AS 'LAST NAME',
	a.au_fname AS 'FIRST NAME',
	t.title AS 'TITLE',
	p.pub_name AS 'PUBLISHER'
FROM authors a
JOIN titleauthor ta 
	ON a.au_id = ta.au_id
JOIN titles t
	ON ta.title_id = t.title_id
LEFT JOIN publishers p
	ON t.pub_id = p.pub_id;

/*
	Challenge 2
*/

SELECT
	a.au_id AS 'AUTHOR ID',
	a.au_lname AS 'LAST NAME',
	a.au_fname AS 'FIRST NAME',
	p.pub_name AS 'PUBLISHER',
	COUNT(t.title_id) AS 'TITLE COUNT'
FROM authors a
JOIN titleauthor ta 
	ON a.au_id = ta.au_id
JOIN titles t
	ON ta.title_id = t.title_id
LEFT JOIN publishers p
	ON t.pub_id = p.pub_id
GROUP BY a.au_id, a.au_lname, a.au_fname, p.pub_name
ORDER BY COUNT(t.title_id) DESC

/*
Challenge 3 - Best Selling Authors
*/

SELECT
	a.au_id AS 'AUTHOR ID',
	a.au_lname AS 'LAST NAME',
	a.au_fname AS 'FIRST NAME',
	SUM(s.qty) AS 'TOTAL'
FROM authors a
JOIN titleauthor ta 
	ON a.au_id = ta.au_id
JOIN titles t
	ON ta.title_id = t.title_id
LEFT JOIN sales s
	ON t.title_id = s.title_id
GROUP BY a.au_id, a.au_lname, a.au_fname
ORDER BY SUM(s.qty) DESC
LIMIT 3

/*
Challenge 4 - Best Selling Authors Ranking
*/

SELECT
	a.au_id AS 'AUTHOR ID',
	a.au_lname AS 'LAST NAME',
	a.au_fname AS 'FIRST NAME',
	COALESCE(SUM(s.qty), 0) AS 'TOTAL'
FROM authors a
LEFT JOIN titleauthor ta 
	ON a.au_id = ta.au_id
LEFT JOIN titles t
	ON ta.title_id = t.title_id
LEFT JOIN sales s
	ON t.title_id = s.title_id
GROUP BY a.au_id, a.au_lname, a.au_fname
ORDER BY SUM(s.qty) DESC
