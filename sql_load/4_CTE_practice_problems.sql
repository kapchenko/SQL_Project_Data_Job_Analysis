SELECT * FROM skills_dim;

WITH top_skill AS (SELECT 
skill_id ,
COUNT(*) AS skill_count
FROM skills_job_dim
GROUP BY skill_id
ORDER BY skill_count DESC
LIMIT 5
) 


SELECT skills,
        skill_count AS num_skill
FROM skills_dim 
LEFT JOIN top_skill ON  skills_dim.skill_id = top_skill.skill_id
;


-- Practice problem #2 
WITH vacancies AS (SELECT 
        company_id,
        COUNT(*) AS vacancies_count
    FROM 
        job_postings_fact 
    GROUP BY 
        company_id ) 

SELECT 
    company_id,
    c.name,
   vacancies_count,
    CASE WHEN vacancies_count < 10 THEN 'Small'
    WHEN vacancies_count BETWEEN 10 AND 50 THEN 'Medium'
    ELSE 'Large' END AS size_category
FROM vacancies
LEFT JOIN company_dim AS c USING(company_id) 
ORDER BY vacancies_count DESC;


/* Find the count of number of remote job postins per skill
    - Display the top 5 skills by their demand in remote jobs
    - Include skill ID, name, and count of postings requiring the skill */


WITH remote_job_skills AS (
        SELECT 
            skill_id, 
            COUNT (*) AS skill_count
        FROM 
            skills_job_dim AS skills_to_job
        INNER JOIN 
            job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
        WHERE 
            job_postings.job_work_from_home = True
            AND 
            job_postings.job_title_short = 'Data Analyst'
        GROUP BY skill_id) 

SELECT 
    skills.skill_id, 
    skills as skill_name, 
    skill_count
FROM 
    remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id 
ORDER BY skill_count DESC
LIMIT 5  ;