-- =====================================================
-- Job Market Analytics SQL Analysis
-- =====================================================

-- =====================================================
-- Job Market Demand Analysis
-- =====================================================
SELECT * FROM jobs limit 10 ;


-- 1.Which industries have the highest number of job postings and 
-- what percentage of total market demand do they represent?
SELECT industry,
COUNT (job_id) AS job_posting,
ROUND(( COUNT(job_id) * 100.0 ) / SUM( COUNT(job_id)) OVER(),3) AS percentage_of_market_demand
FROM jobs
GROUP BY industry 
ORDER BY job_posting DESC;

-- 2. Which job titles rank in the top 10 most demanded roles by number of postings?
SELECT title,
COUNT( job_id ) AS number_of_posting
FROM jobs
GROUP BY title
ORDER BY number_of_posting DESC LIMIT 10 ;

-- 3. Which countries have the highest hiring activity compared to the global average?
SELECT country,
COUNT(job_id) AS total_posting
FROM jobs
GROUP BY country
HAVING COUNT( job_id ) > (( SELECT COUNT(*) FROM jobs ) / ( SELECT COUNT( country) FROM jobs ) )
ORDER BY total_posting DESC ;

-- 4.  Which cities have the highest job concentration within each country?
WITH RankedCities AS (
    SELECT 
        country,
        city,
        COUNT(job_id) AS job_count,
        DENSE_RANK() OVER(PARTITION BY country ORDER BY COUNT(job_id) DESC) AS ranking
    FROM jobs
    GROUP BY country, city
)
SELECT 
    country,
    city,
    job_count
FROM RankedCities
WHERE ranking = 1;

-- 5. Which company sizes generate the most job opportunities?
SELECT 
	company_size,
	COUNT(*) AS total_jobs
FROM jobs
GROUP BY company_size
ORDER BY total_jobs DESC ;

-- 6. Which industries have the highest remote job availability?
SELECT 
	industry,
	COUNT(*) AS Remote_jobs
FROM jobs
where remote_policy = 'Remote'
GROUP BY industry
ORDER BY Remote_jobs DESC ;

-- 7. How does employment type distribution vary across different industries?
SELECT
	industry,
	COUNT(*) AS total_industry_count,
	COUNT(CASE WHEN employment_type = 'Internship' THEN 1 END)AS intership_count,
	COUNT(CASE WHEN employment_type = 'Part-time' THEN 1 END )AS part_time_count,
	COUNT(CASE WHEN employment_type = 'Contract' THEN 1 END) AS contract_count,
	COUNT(CASE WHEN employment_type = 'Full-time' THEN 1 END) AS full_time_count
FROM jobs
GROUP BY industry
ORDER BY total_industry_count DESC;

-- 8. Which experience levels have the highest demand within each industry?
WITH IndustryExperienceCounts AS (
    SELECT 
        industry,
        experience_level,
        COUNT(*) AS demand_count
    FROM jobs
    WHERE experience_level IS NOT NULL AND industry IS NOT NULL
    GROUP BY industry, experience_level
),
RankedDemand AS (
    SELECT 
        industry,
        experience_level,
        demand_count,
        ROW_NUMBER() OVER(PARTITION BY industry ORDER BY demand_count DESC) as ranking
    FROM IndustryExperienceCounts
)
SELECT 
    industry,
    experience_level AS highest_demanded_level,
    demand_count
FROM RankedDemand
WHERE ranking = 1
ORDER BY demand_count DESC;

-- 9. Which skills appear most frequently in job postings?
SELECT 
    trim(individual_skill) AS skill, 
    COUNT(*)::numeric AS job_count 
FROM jobs, UNNEST(string_to_array(skills, ',')) AS individual_skill
GROUP BY skill 
ORDER BY job_count DESC;

-- 10. Which technology stacks are most commonly required for each job role?
with job_role_count as (
select 
	title,
	trim(individual_teck_stack) as tech_stacks,
	count(*)::numeric as job_count
from jobs,unnest(string_to_array(tech_stack,',')) as individual_teck_stack
	group by title,tech_stacks
	order by job_count desc 
	
), rank_job_role as (
select
	title,
	tech_stacks,
	job_count,
	dense_rank() over( partition by title order by job_count desc ) as ranking
from job_role_count
)
select 
	title,
	tech_stacks,
	job_count
from rank_job_role
where ranking = 1 ;

-- 11. Which job roles require the highest number of skills on average?
with skills_on_average as (
select 
	title,
	job_id,
	count(individual_skill) as total_count
from jobs,
	unnest(string_to_array(skills,',')) as individual_skill
	group by job_id,title
)
select 
	title,
	round(avg(total_count)) as avrage_skills
from skills_on_average 
	group by title 
	ORDER BY avrage_skills DESC;
	
-- 12. Which industries show growth in job postings over time based on posting dates
WITH industry_monthly_counts AS (
    SELECT 
        industry,
        DATE_TRUNC('month', posted_date::DATE)::DATE AS posting_month,
        COUNT(*) AS current_month_postings
    FROM jobs
    WHERE posted_date IS NOT NULL AND industry IS NOT NULL
    GROUP BY industry, DATE_TRUNC('month', posted_date::DATE)::DATE
),
industry_growth_trends AS (
    SELECT 
        industry,
        posting_month,
        current_month_postings,
        LAG(current_month_postings) OVER (
            PARTITION BY industry 
            ORDER BY posting_month
        ) AS previous_month_postings
    FROM industry_monthly_counts
)
SELECT 
    industry,
    posting_month,
    current_month_postings,
    previous_month_postings,
    (current_month_postings - previous_month_postings) AS absolute_growth,
    ROUND(
        ((current_month_postings - previous_month_postings)::numeric / 
        NULLIF(previous_month_postings, 0)) * 100, 2
    ) AS growth_percentage
FROM industry_growth_trends
ORDER BY industry, posting_month;

-- 13. Which companies/job categories have the highest competition based on applicant volume?
SELECT 
    j.company_tier,
    COUNT(j.job_id) AS total_jobs_posted,
    SUM(r.num_applicants) AS total_applicants,
    ROUND(AVG(r.num_applicants)::numeric, 1) AS avg_applicants_per_job
FROM jobs as j inner join recruitment as r
on j.job_id = r.job_id
WHERE j.company_tier IS NOT NULL AND r.num_applicants IS NOT NULL
GROUP BY j.company_tier
HAVING COUNT(j.job_id) >= 3 
ORDER BY avg_applicants_per_job DESC ;


-- =====================================================
-- 2. Hiring Performance Analysis
-- =====================================================
SELECT * FROM recruitment limit 10;
-- 14. Which job roles receive the highest average number of applicants?
select 
	j.title,
	round(avg(num_applicants)::numeric) as average_applicant  
from recruitment as r inner join jobs as j
on r.job_id = j.job_id 
	group by j.title 
	order by average_applicant desc;
-- 15. Which industries have the highest applicant-to-offer conversion rate?
select 
	industry,
	round((count(case when r.offer_accepted = true then 1 end ) * 100.0)/sum(num_applicants),3) as total_accepted
from recruitment as r inner join jobs as j
on r.job_id = j.job_id 
group by industry 
order by total_accepted desc;

-- 16. What is the overall offer acceptance percentage?
select 
	round((count(case when offer_accepted = true then 1 end)) * 100.0
		  / sum(num_applicants) ,3) as offer_acceptance_percentage
from recruitment  ;

-- 17. Which job titles have the highest offer acceptance rate?
select
	j.title,
	round((count(case when offer_accepted = true then 1 end) * 100.0) /
		  sum(num_applicants),3) as offer_acceptance_percentage
from recruitment as r inner join jobs as j
on j.job_id = r.job_id
group by j.title 
order by offer_acceptance_percentage desc;

-- 18. Which industries have above-average hiring success rates?
select 
	j.industry,
	round((count(case when r.offer_accepted = true then 1 end) * 100.0) /
		  sum(r.num_applicants),4) as success_rates
from recruitment as r inner join jobs as j
on j.job_id = r.job_id
group by j.industry 
having (count(case when r.offer_accepted = true then 1 end) * 100.0) /sum(r.num_applicants) >
		( select (count(case when offer_accepted = true then 1 end) * 100.0) /sum(num_applicants) from  recruitment )
order by success_rates desc ;
		
-- 19. Does faster recruiter response time improve offer acceptance?
select
	avg_response_hours,
	sum( case when offer_accepted = true then 1 else 0 end ) as total_acceplted_offer
from recruitment
group by avg_response_hours
order by total_acceplted_offer desc ;

-- 20. Which employment types have the highest recruitment conversion?
select
	j.employment_type,
	round((sum(case when offer_accepted = true then 1 else 0 end) * 100.0 )/
		 sum(num_applicants),3) as  highest_recruitment
from 
	jobs as j inner join recruitment as r
	on j.job_id = r.job_id
	group by j.employment_type
	order by highest_recruitment desc ;

-- 21. Which experience levels receive the most successful offers?
select
	j.experience_level,
	round((sum(case when r.offer_accepted = true then 1 else 0 end) * 100.0 )/
		 sum(r.num_applicants),4) as  successful_offer
from 
	jobs as j inner join recruitment as r
	on j.job_id = r.job_id
	group by j.experience_level
	order by successful_offer desc;

-- 22. Which job roles have the longest recruitment cycle?
select 
	title,
	round(avg(application_deadline::date - posted_date::date)::numeric, 1) as average_day_to_hire
from jobs 
group by title
order by average_day_to_hire desc;

-- 23. Rank industries based on recruitment efficiency.
with recruitment_efficiency as (
select 
	industry,
	round((sum(case when offer_accepted = true then 1 else 0 end )*100.0) /
	sum(num_applicants),4) as Efficiency_Rate
from jobs as j inner join recruitment as r on j.job_id = r.job_id
	group by industry
	
)
select
	industry,
	Efficiency_Rate,
	rank() over(order by Efficiency_Rate desc) as rank_by_industry
from recruitment_efficiency ;

-- 24. Which roles have high applicant volume but low offer acceptance?
select
	title,
	sum(num_applicants) as total_applicant,
	sum(case when offer_accepted = true then 1 else 0 end) as total_offer_acceptance
from 
	jobs as j inner join recruitment as r
	on j.job_id = r.job_id
	group by title 
	order by total_applicant desc , total_offer_acceptance asc ;
	
-- 25. Which industries attract many applicants but have poor hiring conversion?
select 
	j.industry,
	sum(r.num_applicants) as total_applicants,
	round((sum(case when r.offer_accepted = true then 1 else 0 end) * 100.0) /
		  sum(r.num_applicants), 4) as conversion_rate
from recruitment as r inner join jobs as j
on j.job_id = r.job_id
group by j.industry 
order by total_applicants desc, conversion_rate asc;


-- =====================================================
-- Employee Retention & Turnover Analysis
-- =====================================================
SELECT * FROM retention limit 10 ; 

-- 26. What is the overall employee churn rate?
select 
	round((sum(case when churned_within_1yr = true then 1 else 0 end) * 100.0) /
		  count(job_id),2) as overall_churn_rate
from retention ;

-- 27. Which industries have the highest employee turnover rate?
select
	j.industry,
	round((sum(case when r.churned_within_1yr = true then 1 else 0 end) * 100.0) /
		  count(r.job_id),2) as overall_churn_rate
from retention as r inner join jobs as j
on j.job_id = r.job_id
group by j.industry
order by overall_churn_rate  desc;

-- 28. Which job roles have the highest churn risk?
select
	j.title,
	round((sum(case when r.churned_within_1yr = true then 1 else 0 end) * 100.0) /
		  count(r.job_id),2) as overall_churn_rate
from retention as r inner join jobs as j
on j.job_id = r.job_id
group by j.title
order by overall_churn_rate  desc;

-- 29. Does salary level impact employee retention?
select
	case when starting_salary < 50000 then 'below_50k' 
		 when starting_salary < 100000 then '100k_to_50k'
		else '100k_above'
	end  as salary_range,
	round((sum(case when r.churned_within_1yr = true then 1 else 0 end ) * 100) /
		  count(*),2) as employee_retention
from retention as r inner join jobs as j 
on j.job_id = r.job_id 
group by
	case when starting_salary < 50000 then 'below_50k' 
		 when starting_salary < 100000 then '100k_to_50k'
		else '100k_above'
	end 
order by employee_retention desc;

-- 30. Compare average salary between retained and churned employees.
select 
	case
		when churned_within_1yr = true then 'Churned'
		else 'Retained'
	end as Employee_status,
	round(avg(starting_salary)::numeric,2) as avg_salary
from retention 
group by 	
	case
		when churned_within_1yr = true then 'Churned'
		else 'Retained'
	end
order by avg_salary desc ;

-- 31. Which experience levels have the highest turnover?
select 
	experience_level,
	round((sum(case when churned_within_1yr = true then 1 else 0 end )* 100.0) /
		  count(*),2) as highest_turnover
from retention as r inner join jobs as j on r.job_id = j.job_id 
group by experience_level
order by highest_turnover desc ;

-- 32. Does company size influence employee retention?
select 
	company_size,
	round((sum(case when churned_within_1yr = true then 1 else 0 end )* 100.0) /
		  count(*),2) as employee_retention
from retention as r inner join jobs as j on r.job_id = j.job_id 
group by company_size
order by employee_retention desc ;

-- 33. Which industries have better employee stability?
select 
	industry,
	round((sum(case when churned_within_1yr = true then 1 else 0 end )* 100.0) /
		  count(*),2) as employee_retention
from retention as r inner join jobs as j on r.job_id = j.job_id 
group by industry
order by employee_retention asc ;

-- 34. Does employee tenure differ between retained and churned employees?
select
	case
		when churned_within_1yr = true then 'Churned'
		else 'Retained'
	end as employee_status,
	round(sum(tenure_months)/ count(*),2) as avg_tendure_month 
from retention 
group by
	case
		when churned_within_1yr = true then 'Churned'
		else 'Retained'
	end ;

-- 35. Which salary ranges have the highest churn percentage?
select
	case when starting_salary < 50000 then 'below_50k' 
		 when starting_salary < 100000 then '100k_to_50k'
		else '100k_above'
	end  as salary_range,
	round((sum(case when r.churned_within_1yr = true then 1 else 0 end ) * 100) /
		  count(*),2) as employee_retention
from retention as r inner join jobs as j 
on j.job_id = r.job_id 
group by
	case when starting_salary < 50000 then 'below_50k' 
		 when starting_salary < 100000 then '100k_to_50k'
		else '100k_above'
	end 
order by employee_retention desc;

-- 36. Rank job roles based on employee retention performance.
with retention_performance as (
select
	j.title,
	round((sum( case when r.churned_within_1yr = false then 1 else 0 end) * 100.0 ) /
		count(*)::numeric,2) as retention_rate
from retention as r inner join jobs as j 
on j.job_id = r.job_id 
	group by j.title
)
select 
	title,
	retention_rate,
	rank() over( order by retention_rate desc ) as rank_performance
from retention_performance ;

-- 37. Which factors contribute most to employee turnover?
WITH salary_rates AS (
    SELECT 
        'Salary Range' AS factor_name,
        ROUND((SUM(CASE WHEN r.churned_within_1yr = true THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS rate
    FROM retention AS r INNER JOIN jobs AS j ON r.job_id = j.job_id
    GROUP BY CASE WHEN r.starting_salary < 50000 THEN 1 WHEN r.starting_salary < 100000 THEN 2 ELSE 3 END
),
experience_rates AS (
    SELECT 
        'Experience Level' AS factor_name,
        ROUND((SUM(CASE WHEN r.churned_within_1yr = true THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS rate
    FROM retention AS r INNER JOIN jobs AS j ON r.job_id = j.job_id
    GROUP BY j.experience_level
),
size_rates AS (
    SELECT 
        'Company Size' AS factor_name,
        ROUND((SUM(CASE WHEN r.churned_within_1yr = true THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS rate
    FROM retention AS r INNER JOIN jobs AS j ON r.job_id = j.job_id
    GROUP BY j.company_size
),
all_gaps AS (
    SELECT factor_name, MAX(rate) - MIN(rate) AS churn_difference_gap FROM salary_rates GROUP BY factor_name
    UNION ALL
    SELECT factor_name, MAX(rate) - MIN(rate) AS churn_difference_gap FROM experience_rates GROUP BY factor_name
    UNION ALL
    SELECT factor_name, MAX(rate) - MIN(rate) AS churn_difference_gap FROM size_rates GROUP BY factor_name
)
SELECT * 
FROM all_gaps
ORDER BY churn_difference_gap DESC;

-- 38. Which combination of industry, role, and company size shows the highest churn risk?
select 
	j.industry,
	j.title as job_role,
	j.company_size,
	count(*) as total_employees,
	round((sum(case when r.churned_within_1yr = true then 1 else 0 end) * 100.0) / 
		  count(*), 2) as churn_rate
from retention as r 
inner join jobs as j on r.job_id = j.job_id 
group by j.industry, j.title, j.company_size
having count(*) >= 5 
order by churn_rate desc, total_employees desc;


-- 39. Identify employees/groups with high turnover probability based on multiple factors.
WITH employee_risk_scoring AS (
    SELECT 
        r.job_id AS employee_id,
        j.industry,
        j.title AS job_role,
        j.company_size,
        r.starting_salary,
        r.tenure_months,
      
        (
            CASE WHEN r.starting_salary < 50000 THEN 2 ELSE 0 END +        
            CASE WHEN r.tenure_months < 12 THEN 2 ELSE 0 END +              
            CASE WHEN j.company_size = 'Small' THEN 1 ELSE 0 END          
        ) AS risk_score
    FROM retention AS r 
    INNER JOIN jobs AS j ON r.job_id = j.job_id 
    WHERE r.churned_within_1yr = false 
)
SELECT 
    risk_score,
    industry,
    job_role,
    company_size,
    COUNT(*) AS vulnerable_employee_count,
    ROUND(AVG(starting_salary)::numeric, 2) AS avg_salary_of_group,
    ROUND(AVG(tenure_months)::numeric, 1) AS avg_tenure_of_group
FROM employee_risk_scoring
GROUP BY risk_score, industry, job_role, company_size
ORDER BY risk_score DESC, vulnerable_employee_count DESC;











