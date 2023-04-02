/* Exploring basic statistics for both student types */

SELECT inter_dom, avg(todep) as average_phq, avg(tosc) as average_scs, avg(toas) as average_as
FROM students 
GROUP BY inter_dom;

SELECT inter_dom, max(todep) as maximum_phq, max(tosc) as maximum_scs, max(toas) as maximum_as
FROM students 
GROUP BY inter_dom;

SELECT inter_dom, min(todep) as minimum_phq, min(tosc) as minimum_scs, min(toas) as minimum_as
FROM students 
GROUP BY inter_dom;

/* Exploring basic statistics for international students only */

SELECT inter_dom, avg(todep) as average_phq, avg(tosc) as average_scs, avg(toas) as average_as
FROM students 
WHERE inter_dom = 'Inter'
GROUP BY inter_dom;

SELECT inter_dom, max(todep) as maximum_phq, max(tosc) as maximum_scs, max(toas) as maximum_as
FROM students 
WHERE inter_dom = 'Inter'
GROUP BY inter_dom;

SELECT inter_dom, min(todep) as minimum_phq, min(tosc) as minimum_scs, min(toas) as minimum_as
FROM students 
WHERE inter_dom = 'Inter'
GROUP BY inter_dom;

/* Finding how different tests change depending on the length of stay*/

SELECT stay, 
ROUND(avg(todep), 2) as average_phq, 
ROUND(avg(tosc), 2) as average_scs, 
ROUND(avg(toas), 2) as average_as
FROM students
WHERE inter_dom = 'Inter'
GROUP BY stay
ORDER BY stay desc;
