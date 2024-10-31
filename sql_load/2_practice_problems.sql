/* Practice Problem #1 
Write a query to find the average salary both yearly 
 (salary_year_avg) and hourly (salary_hour_avg)
 for job postings that were posted after Jun 1, 2023. 
 Group the results by job schedule type */ 

SELECT 
    job_schedule_type,
    ROUND(AVG(salary_year_avg), 2) AS avg_year_rate,
    ROUND(AVG(salary_hour_avg), 2) AS avg_hour_rate
FROM job_postings_fact
WHERE job_posted_date  > '2023-06-01' 
GROUP BY job_schedule_type;

/* Practice Problem #2
Write a query to count the number of job postings for each month in 2023,
adjusting the job_posted_date to be in 'America/New_York' time zone before 
extracting the month
Assume the job_posted_date is stored in UTC. Group by and order by month */

SELECT 
    COUNT(*) AS job_posted_count,  
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EDT') AS month
FROM job_postings_fact
GROUP BY month
ORDER BY month;


SELECT * 
FROM job_postings_fact 
LIMIT 5;

SELECT *
FROM company_dim LIMIT 5;
/* Practice Problem #3
Write a query to find companies (include company name) that have posted jobs offering
health insurance, where these postings were made in the second quarter of 2023.
Use date extraction to filter by quarter */ 

SELECT 
    c.name,
    job_health_insurance,
    job_pos
FROM job_postings_fact
JOIN company_dim AS c USING (company_id)
WHERE job_health_insurance IS TRUE 
AND EXTRACT(QUARTER FROM job_posted_date) = 2