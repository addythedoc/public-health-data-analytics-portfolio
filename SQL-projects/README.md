**Influenza Vaccination Coverage Analysis (SQL & Tableau)**

Tools: MySQL · SQL · Tableau
Domain: Public Health Surveillance · Preventive Medicine
Data Source: CDC FluVaxView (Influenza Vaccination Coverage – All Ages, 6+ Months)

**Project Overview**

This project analyzes influenza vaccination coverage across U.S. states and evaluates progress toward the Healthy People 70% vaccination target.
Using SQL-based aggregation and transformation, the project identifies geographic disparities and temporal trends, which are visualized through an interactive Tableau dashboard.

**Data**

CDC FluVaxView public-use dataset

Influenza vaccination coverage for all ages (6+ months)

State-level data across multiple influenza seasons

Public, aggregate-level data (no individual identifiers)

**Study Design & Methods**

Data ingestion and cleaning using SQL (MySQL)

Creation of analytical tables with:

State-level vaccination coverage

Year-over-year trends

Comparison to Healthy People 70% benchmark

Export of cleaned datasets for visualization

Development of an interactive Tableau dashboard

**Key SQL Operations**

Filtering and aggregation using GROUP BY

Calculation of vaccination coverage percentages

Derivation of indicator variables for states below/above target

Ordering and ranking states by coverage

Preparation of visualization-ready datasets

**Key Insights**

Influenza vaccination coverage varies substantially across states

Multiple states consistently fall below the 70% Healthy People target

Some states demonstrate gradual improvement over time, while others remain stagnant

Geographic disparities highlight the need for targeted public health interventions

**Dashboard**

An interactive Tableau dashboard visualizes:

State-level vaccination coverage

Comparison to the 70% target

Temporal vaccination trends

📌 Note: GitHub cannot preview .twbx files.
To view the dashboard:

Download the file from dashboard/

Open using Tableau Desktop or Tableau Public

**Repository Structure**

influenza-vaccine-coverage/
├── data/
│   └── Influenza_Vaccination_Coverage.csv
├── scripts/
│   └── vaccine_coverage_pipeline.sql
├── dashboard/
│   └── Influenza_vaccine_coverage.twbx
└── README.md

**Public Health Relevance**

Influenza vaccination remains a critical preventive strategy.
This analysis supports surveillance, policy evaluation, and program planning by identifying vaccination gaps and tracking progress toward national targets.

**Skills Demonstrated**

SQL querying and data transformation

Public health surveillance analysis

KPI benchmarking (Healthy People objectives)

Dashboard-driven data storytelling

Translating surveillance data into actionable insights
