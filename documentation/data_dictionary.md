# Data Dictionary

The project uses three main analytical tables:

1. Job Listings
2. Recruitment KPIs
3. Retention KPIs

---

# 1. Job Listings Table

Contains information about job postings and job market characteristics.

| Column | Description |
|---|---|
| `job_id` | Unique identifier for the job listing |
| `title` | Job title or role |
| `industry` | Industry associated with the job |
| `company_size` | Size category of the hiring company |
| `company_tier` | Company classification or tier |
| `country` | Country where the job is located |
| `city` | City where the job is located |
| `remote_policy` | Remote work policy associated with the job |
| `experience_level` | Required experience level |
| `education_required` | Required educational qualification |
| `skills` | Skills required for the job |
| `tech_stack` | Technologies or technical tools required |
| `employment_type` | Type of employment |
| `posted_date` | Date the job was posted |
| `application_deadline` | Application closing date |

---

# 2. Recruitment KPIs Table

Contains recruitment and hiring performance metrics.

| Column | Description |
|---|---|
| `job_id` | Job identifier used to connect recruitment data with job listings |
| `num_applicants` | Number of applicants for the job |
| `avg_response_hours` | Average recruiter response time in hours |
| `offer_extended` | Indicates whether an offer was extended |
| `offer_accepted` | Indicates whether the offer was accepted |

---

# 3. Retention KPIs Table

Contains employee retention and turnover information.

| Column | Description |
|---|---|
| `job_id` | Job identifier used to connect retention data with job listings |
| `starting_salary` | Employee starting salary |
| `tenure_months` | Employee tenure measured in months |
| `churned_within_1yr` | Indicates whether the employee left within one year |

---

# Relationships

The three analytical tables are connected using:

`job_id`

Conceptually:

```text
Job Listings
     |
     | job_id
     |
     +--------------------+
     |                    |
     ▼                    ▼
Recruitment KPIs     Retention KPIs