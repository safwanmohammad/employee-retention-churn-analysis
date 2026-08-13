# Methodology

## 1. Project Approach

This project follows an end-to-end data analytics workflow designed to analyze the employment lifecycle across three areas:

1. Job Market Analysis
2. Recruitment Analysis
3. Employee Retention & Churn Analysis

The overall workflow is:

```text
Raw Data
   ↓
Data Inspection
   ↓
Data Cleaning & Validation
   ↓
Exploratory Data Analysis
   ↓
PostgreSQL Database
   ↓
Advanced SQL Analysis
   ↓
Power BI Data Transformation & Modeling
   ↓
DAX Measures & KPIs
   ↓
Interactive Dashboards
   ↓
Business Insights
   ↓
Recommendations
```

---

# 2. Data Preparation

The project uses three main datasets:

* Job Listings
* Recruitment KPIs
* Retention KPIs

The datasets were inspected before performing analysis to understand their structure, data types, relationships, and data quality.

---

# 3. Data Cleaning Using Python

Python was used for data cleaning, validation, transformation, and exploratory analysis.

### Main libraries

```text
Pandas
NumPy
Matplotlib
Seaborn
```

### Data cleaning activities

The following checks and transformations were performed:

* Loaded datasets using Pandas
* Inspected rows and columns
* Checked data types
* Checked missing values
* Checked duplicate records
* Validated numerical columns
* Validated categorical columns
* Reviewed Boolean fields
* Converted and validated date fields
* Standardized categorical values where required
* Created analytical categories where required
* Prepared datasets for PostgreSQL analysis

The cleaned datasets were then used for further analysis.

---

# 4. Exploratory Data Analysis

Exploratory Data Analysis (EDA) was performed using Python to understand the underlying patterns in the datasets.

The analysis examined:

### Job Market

* Job posting distribution
* Industry demand
* Job-role demand
* Geographic distribution
* Remote work availability
* Employment types
* Experience levels
* Skills
* Technology stacks

### Recruitment

* Applicant volume
* Offer activity
* Offer acceptance
* Response time
* Recruitment performance

### Employee Retention

* Employee churn
* Employee retention
* Salary groups
* Experience levels
* Tenure groups
* Industries
* Job roles

EDA helped identify important patterns and potential business questions for further SQL analysis.

---

# 5. PostgreSQL Database

After data preparation, the datasets were loaded into PostgreSQL for structured querying and business analysis.

The main tables used were:

```text
job_listings
recruiting_kpis
retention_kpis
```

The tables were connected using the common:

```text
job_id
```

This allowed job characteristics to be analyzed together with recruitment and retention information.

---

# 6. Advanced SQL Analysis

Advanced SQL was used to convert business questions into measurable analytical queries.

A total of **39 business questions** were analyzed across the three major areas.

### Job Listings Analysis

Analysis included:

* Job demand
* Industry demand
* Job-role demand
* Country and city distribution
* Remote work
* Employment type
* Experience-level demand
* Skills
* Technology stacks
* Applicant competition

### Recruitment Analysis

Analysis included:

* Applicant volume
* Offer activity
* Offer acceptance
* Response time
* Recruitment efficiency
* Hiring performance
* Recruitment conversion

### Retention Analysis

Analysis included:

* Overall churn
* Retention
* Churn by industry
* Churn by job role
* Churn by salary group
* Churn by experience level
* Churn by tenure
* Multiple-factor churn analysis

### SQL techniques used

```text
SELECT
WHERE
GROUP BY
HAVING
ORDER BY
CASE WHEN
Aggregate Functions
INNER JOIN
LEFT JOIN
Subqueries
Common Table Expressions (CTEs)
Window Functions
RANK()
DENSE_RANK()
Percentage Calculations
Date Functions
```

The SQL analysis was focused on answering business questions rather than only performing basic data retrieval.

---

# 7. Power BI Data Preparation

Power BI was used to create the final interactive business intelligence layer.

Power Query was used where required for:

* Data transformation
* Data type validation
* Column preparation
* Creating analytical groups
* Preparing fields for visualization

The data was structured so that job market, recruitment, and retention metrics could be analyzed effectively.

---

# 8. Power BI Data Modeling

The Power BI model was designed to connect the relevant datasets using the common job identifier.

The main analytical tables were:

```text
Job Listings
     │
     ├── Recruitment KPIs
     │
     └── Retention KPIs
```

This structure allowed job characteristics to be analyzed alongside recruitment and employee retention metrics.

---

# 9. DAX Measures & KPI Development

DAX was used to create key business metrics required for the dashboards.

Examples include:

* Total Jobs
* Total Applicants
* Average Applicants
* Remote Job Percentage
* Total Offers Extended
* Total Offers Accepted
* Offer Acceptance Rate
* Total Churned Employees
* Total Retained Employees
* Overall Churn Rate

These measures were used to support KPI cards and analytical visuals.

---

# 10. Dashboard Development

Three Power BI dashboards were developed.

---

## Dashboard 1 — Job Market Analysis

The first dashboard focuses on understanding job market demand.

### Key areas

* Job posting volume
* Industry demand
* Job-role demand
* Company characteristics
* Remote work
* Employment type
* Experience level
* Skills
* Technology stacks
* Geographic distribution

The dashboard provides an overview of where job opportunities are concentrated and what employers are looking for.

---

## Dashboard 2 — Recruitment Analysis

The second dashboard focuses on recruitment and hiring performance.

### Key areas

* Total applicants
* Average applicants
* Offers extended
* Offers accepted
* Offer acceptance rate
* Applicant distribution
* Recruitment efficiency
* Response time
* Hiring performance

The dashboard helps identify differences in recruitment activity and hiring outcomes across different segments.

---

## Dashboard 3 — Employee Retention & Churn Analysis

The third dashboard focuses on employee retention and turnover.

### Key KPIs

* Total Employees
* Total Churned Employees
* Total Retained Employees
* Overall Churn Rate
* Average Starting Salary
* Average Tenure

### Key visual analysis

* Churn Rate by Job Role
* Employee Retention vs Churn
* Churn Rate by Tenure Group
* Churn Rate by Company Tier
* Churn Rate by Industry
* Churn Rate by Experience
* Churn Rate by Salary Group

The dashboard is designed to identify employee segments with comparatively higher observed churn.

---

# 11. Business Analysis

After completing the SQL analysis and Power BI dashboards, the results were reviewed from a business perspective.

The analysis focused on:

* Identifying important patterns
* Comparing different employee groups
* Identifying high-churn segments
* Comparing recruitment performance
* Understanding job market demand
* Translating analytical results into potential business actions

The goal was to move from:

```text
Data
   ↓
Information
   ↓
Insight
   ↓
Business Recommendation
```

---

# 12. Business Recommendations

Recommendations were developed based on observed patterns in the data.

Examples include:

### Compensation

Investigate compensation competitiveness for employee groups showing comparatively higher churn.

### Early-Tenure Retention

Review onboarding, training, workload, and employee support for employees in the early stages of their tenure.

### Career Development

Investigate career progression and learning opportunities for employee groups with comparatively higher churn.

### High-Churn Roles

Perform deeper analysis of job roles with higher observed churn.

### High-Churn Industries

Investigate organizational and workforce factors within industries showing comparatively higher churn.

### Recruitment Efficiency

Use applicant volume, response time, offers, and acceptance rates to identify potential recruitment process improvements.

---

# 13. Data Visualization Principles

The Power BI dashboards were designed to communicate business information clearly.

The visualization approach focused on:

* KPI cards for important metrics
* Bar and column charts for comparisons
* Donut charts for simple composition analysis
* Consistent grouping and categorization
* Clear titles
* Business-focused visual selection
* Avoiding unnecessary visual duplication
* Highlighting important differences between segments

---

# 14. Validation

The results were reviewed across Python, SQL, and Power BI to reduce inconsistencies.

Validation included:

* Checking cleaned data
* Reviewing calculated metrics
* Comparing SQL results with Power BI measures
* Checking dashboard filters
* Validating KPI calculations
* Reviewing category groupings
* Checking visual outputs

---

# 15. Analytical Limitations

The analysis is based on the available dataset and its variables.

The findings identify **patterns and associations**, but they do not prove causation.

For example, if one salary group has a higher churn rate, this does not prove that salary directly caused employees to leave.

Additional variables and statistical analysis would be required to investigate causal relationships.

Potential additional factors could include:

* Workload
* Manager quality
* Job satisfaction
* Performance
* Promotion history
* Benefits
* Work-life balance
* Location
* Overtime
* Employee engagement

---

# 16. Final Outcome

The project demonstrates a complete data analytics workflow:

```text
Python
  ↓
Data Cleaning & EDA
  ↓
PostgreSQL
  ↓
Advanced SQL
  ↓
Power BI
  ↓
DAX & KPIs
  ↓
Interactive Dashboards
  ↓
Business Insights
  ↓
Recommendations
```

The final solution combines technical analysis with business-oriented reporting to demonstrate an end-to-end approach to data analytics.
