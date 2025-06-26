SELECT 
    p.id AS director_id,
    CONCAT(p.first_name, ' ', p.last_name) AS director_name,
    ROUND(AVG(m.budget), 2) AS average_budget
FROM Person p
INNER JOIN Movie m ON p.id = m.director_id
GROUP BY p.id, p.first_name, p.last_name
ORDER BY average_budget DESC; 