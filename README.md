# Employee Workforce Analytics: Job Market, Recruitment & Retention

## 📌 Project Overview

An end-to-end data analytics project analyzing the employment lifecycle from **job market demand and recruitment performance to employee retention and churn**.

The project combines **Python, PostgreSQL, and Power BI** to transform raw data into business insights and interactive dashboards.

The analysis is divided into three major areas:

1. **Job Market Analysis** — understanding job demand and employment trends
2. **Recruitment Analysis** — evaluating hiring activity and recruitment performance
3. **Employee Retention & Churn Analysis** — identifying patterns associated with employee turnover

---

## 🎯 Business Objective

The objective of this project is to understand how job market characteristics, recruitment performance, and employee-related factors vary across different roles, industries, companies, and employee groups.

The project addresses business questions such as:

* Which industries and job roles have the highest demand?
* Which skills and technology stacks are most frequently requested?
* Which industries attract the most applicants?
* How effective is the recruitment process?
* Does recruiter response time relate to offer acceptance?
* Which employee groups show higher churn?
* Does churn vary by salary, experience, tenure, industry, or job role?

---

# 🛠️ Tools & Technologies

### Programming & Data Analysis

* Python
* Pandas
* NumPy
* Matplotlib
* Seaborn

### Database & SQL

* PostgreSQL
* SQL
* pgAdmin

### Business Intelligence

* Microsoft Power BI
* Power Query
* DAX

### Version Control

* Git
* GitHub

---

# 🔄 Project Workflow

```text
Raw Data
   ↓
Data Cleaning & Validation
   ↓
Python Exploratory Data Analysis
   ↓
Data Preparation
   ↓
PostgreSQL Database
   ↓
Advanced SQL Business Analysis
   ↓
Power BI Data Modeling
   ↓
Interactive Dashboards
   ↓
Business Insights & Recommendations
```

---

# 📂 Dataset

The project uses three main datasets/tables.

## 1. Job Listings

Contains information about job demand and job characteristics.

### Features

* job_id
* title
* industry
* company_size
* company_tier
* country
* city
* remote_policy
* experience_level
* education_required
* skills
* tech_stack
* employment_type
* posted_date
* application_deadline

---

## 2. Recruitment KPIs

Contains recruitment and hiring performance metrics.

### Features

* job_id
* num_applicants
* avg_response_hours
* offer_extended
* offer_accepted

---

## 3. Retention KPIs

Contains employee retention information.

### Features

* job_id
* starting_salary
* tenure_months
* churned_within_1yr

---

# 🐍 Python Data Analysis

Python was used for data preparation, cleaning, validation, and exploratory analysis.

### Key activities

* Data loading
* Data type validation
* Missing-value analysis
* Duplicate checks
* Data cleaning
* Data transformation
* Feature creation
* Exploratory Data Analysis
* Grouped analysis
* Churn analysis
* Salary analysis
* Experience analysis
* Tenure analysis
* Industry analysis
* Job-role analysis

### Python Libraries

```text
Pandas
NumPy
Matplotlib
Seaborn
```

---

# 🗄️ PostgreSQL & Advanced SQL Analysis

The cleaned datasets were loaded into PostgreSQL for structured business analysis.

A total of **39 advanced business questions** were analyzed across three areas:

### Job Listings Analysis

Questions focused on:

* Job market demand
* Industry demand
* Job-role demand
* Country and city concentration
* Remote work availability
* Employment type
* Experience-level demand
* Skills
* Technology stacks
* Job posting trends
* Applicant competition

### Recruitment KPI Analysis

Questions focused on:

* Applicant volume
* Offer conversion
* Offer acceptance
* Recruitment efficiency
* Response time
* Hiring performance
* Recruitment competition

### Retention KPI Analysis

Questions focused on:

* Overall churn
* Industry churn
* Job-role churn
* Salary and retention
* Experience-level churn
* Company characteristics
* Tenure
* Employee stability
* Multiple-factor churn risk

### Advanced SQL Techniques

* INNER JOIN
* LEFT JOIN
* GROUP BY
* HAVING
* CASE WHEN
* Aggregate Functions
* Common Table Expressions (CTEs)
* Subqueries
* Window Functions
* RANK()
* DENSE_RANK()
* Percentage Calculations
* Date Functions

---

# 📊 Power BI Dashboards

The Power BI report contains **three analytical dashboards** covering the employment lifecycle.

---

## 1. Job Market Analysis

This dashboard focuses on job demand and market characteristics.

### Key Analysis

* Job posting volume
* Industry demand
* Job-role demand
* Country and city distribution
* Remote job availability
* Company size
* Employment type
* Experience-level demand
* Skills
* Technology stacks

### Dashboard Preview

![Job Market Dashboard](powerbi/Job%20Market%20Overview.png)

---

## 2. Recruitment Analysis

This dashboard focuses on recruitment and hiring performance.

### Key Analysis

* Total applicants
* Average applicants
* Offers extended
* Offers accepted
* Offer acceptance rate
* Applicant volume by job role
* Applicant volume by industry
* Recruitment efficiency
* Recruiter response time
* Hiring conversion

### Dashboard Preview

![Recruitment Dashboard](powerbi/Recruitment%20Performance.png)

---

## 3. Employee Retention & Churn Analysis

This dashboard focuses on employee turnover and retention patterns.

### Key Metrics

* Total Employees
* Churned Employees
* Retained Employees
* Overall Churn Rate
* Average Starting Salary
* Average Tenure

### Key Analysis

* Churn Rate by Job Role
* Retained vs Churned Employees
* Churn Rate by Tenure Group
* Churn Rate by Industry
* Churn Rate by Salary Group
* Churn Rate by Experience Level

### Dashboard Preview

![Employee Retention Dashboard](powerbi/Employee%20Retention%20&%20Churn%20Analysis.png)

---

# 🔎 Key Findings

## Job Market

* Job demand varies considerably across industries and job roles.
* Certain technology stacks and skills appear more frequently across job postings.
* Remote availability differs across industries and employment types.
* Experience-level requirements vary across different job categories.

## Recruitment

* Applicant volume varies significantly by job role and industry.
* Offer acceptance rates differ across recruitment segments.
* Recruitment efficiency varies between industries and employment types.
* Response time can be analyzed alongside offer acceptance to identify potential recruitment patterns.

## Employee Retention

* Overall employee churn rate was approximately **48.2%**.
* Low-salary employees showed the highest observed churn rate at approximately **51.2%**.
* Mid-level employees showed the highest observed churn among experience groups at approximately **48.6%**.
* Manufacturing showed the highest observed churn among the displayed industries at approximately **48.4%**.
* The highest displayed job-role churn rate was approximately **48.6%**.
* The 0–6 month tenure group showed the highest observed churn among the displayed tenure groups.

> **Important:** These findings represent associations observed in the dataset. They do not prove that salary, experience, tenure, industry, or job role directly causes employee churn.

---

# 💡 Business Recommendations

## 1. Investigate Low-Salary Employee Churn

Review compensation competitiveness, benefits, workload, and career progression opportunities for lower-salary employees.

## 2. Strengthen Early Employee Support

Investigate onboarding, training, workload, management support, and employee experience during the first six months.

## 3. Review Mid-Level Employee Retention

Analyze career progression, learning opportunities, management practices, compensation, and promotion pathways for mid-level employees.

## 4. Investigate High-Churn Job Roles

Perform deeper analysis of workload, compensation, working conditions, and career opportunities for roles with comparatively high churn.

## 5. Investigate High-Churn Industries

Examine organizational and workforce factors in industries showing comparatively high employee churn.

## 6. Improve Recruitment Efficiency

Use applicant volume, response time, offer acceptance, and recruitment conversion metrics to identify opportunities to improve the hiring process.

---

# 📁 Project Structure

```text
employee-retention-churn-analysis/
│
├── data/
│   ├── job_listings.csv
│   ├── recruitment_kpis.csv
│   └── retention_kpis.csv
│
├── python/
│   └── retention_analysis.ipynb
│
├── sql/
│   └── advanced_sql_analysis.sql
│
├── powerbi/
│   ├── Employee_Workforce_Analytics.pbix
│   ├── page_01_job_market.png
│   ├── page_02_recruitment.png
│   └── page_03_employee_retention.png
│
├── requirements.txt
├── .gitignore
└── README.md
```

---

# 📈 Skills Demonstrated

This project demonstrates practical experience in:

* Data Cleaning
* Data Validation
* Exploratory Data Analysis
* Python
* Pandas
* NumPy
* SQL
* PostgreSQL
* Advanced SQL
* Data Transformation
* Power Query
* DAX
* Power BI
* Business Analysis
* Data Visualization
* KPI Analysis
* Insight Generation
* Git
* GitHub

---

# 🚀 End-to-End Analytics Approach

The project demonstrates the ability to take a dataset from:

```text
Raw Data
    ↓
Python Cleaning
    ↓
EDA
    ↓
PostgreSQL
    ↓
Advanced SQL
    ↓
Power BI
    ↓
Business Insights
    ↓
Recommendations
```

This provides an end-to-end demonstration of practical data analytics skills rather than focusing on a single tool.

---

# ⚠️ Analytical Disclaimer

The analysis identifies patterns and associations within the available dataset. The observed relationships should not be interpreted as causal relationships without additional statistical testing or experimental analysis.
