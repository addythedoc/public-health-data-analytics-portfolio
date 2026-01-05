
# Influenza Vaccination Coverage Surveillance

*SQL-based population health monitoring and dashboard analytics*

## Population Health Context

Seasonal influenza vaccination coverage is a key indicator of **preventive care performance** and a core component of population health surveillance. Monitoring geographic and temporal variation in vaccination uptake supports **program planning, equity-focused interventions, and evaluation of immunisation strategies**.

This project demonstrates how routinely published surveillance data can be transformed into **decision-ready indicators and dashboards** using SQL-based data pipelines and visual analytics.

---

## Project Objective

To analyse state-level influenza vaccination coverage and assess progress toward the **Healthy People 70% vaccination benchmark**, using structured SQL transformations and an interactive dashboard to highlight geographic gaps and trends over time.

---

## Data Source & Scope

* **Dataset:** CDC FluVaxView – Influenza Vaccination Coverage
* **Coverage:** All ages (≥6 months)
* **Geography:** U.S. states
* **Timeframe:** Multiple influenza seasons
* **Data Type:** Public, aggregate-level surveillance data

No individual-level or identifiable information is used.

---

## Analytical Approach

### Data Processing

* Ingestion and cleaning of surveillance datasets using **MySQL**
* Construction of analytical tables capturing:

  * State-level vaccination coverage
  * Year-over-year trends
  * Benchmark comparison against the 70% target

### SQL Transformations

* Aggregation and summarisation using `GROUP BY`
* Calculation of vaccination coverage percentages
* Creation of indicator variables for states below or meeting targets
* Ranking and ordering states by coverage
* Preparation of clean, visualization-ready datasets

### Visual Analytics

* Export of transformed datasets for dashboard development
* Design of an interactive **Tableau dashboard** to support exploratory analysis and communication of findings

---

## Key Findings

* Influenza vaccination coverage varies substantially across states
* Several states consistently fall below the **70% vaccination benchmark**
* Some states demonstrate gradual improvement over time, while others show persistently low coverage
* Geographic disparities highlight opportunities for targeted immunisation strategies and outreach

---

## Surveillance & Policy Implications

* Routine surveillance data can be effectively operationalised using SQL pipelines to support:

  * Immunisation program monitoring
  * Performance benchmarking
  * Equity-focused intervention planning
* Dashboard-driven analytics enable rapid identification of underperforming regions and support communication with policymakers and program stakeholders

---

## Dashboard

The interactive Tableau dashboard visualises:

* State-level influenza vaccination coverage
* Performance relative to the 70% benchmark
* Temporal trends across influenza seasons

**Viewing instructions:**
GitHub cannot preview `.twbx` files. To view the dashboard:

1. Download the `.twbx` file from the `dashboard/` folder
2. Open using Tableau Desktop or Tableau Public

---

## Tools & Technologies

* **SQL (MySQL):** Data aggregation, transformation pipelines, indicator creation
* **Tableau:** Interactive dashboard design and data storytelling
* **Methods:**

  * Surveillance indicator development
  * KPI benchmarking
  * Geographic and temporal trend analysis

---

## How This Work Can Be Used in Practice

* Support immunisation coverage monitoring at state or regional levels
* Identify geographic gaps in preventive care uptake
* Track progress toward immunisation targets over time
* Inform program planning and resource prioritisation

---



