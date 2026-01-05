
# Predicting 30-Day Hospital Readmission Among Patients with Diabetes

## Health System Context

Unplanned 30-day hospital readmissions are a key indicator of **health system performance, continuity of care, and cost efficiency**, particularly for chronic conditions such as diabetes. Health systems often rely on routinely collected inpatient data to identify patients at higher risk of early readmission, despite known limitations in clinical granularity.

This project evaluates the extent to which **administrative and inpatient clinical variables alone** can be used to estimate short-term readmission risk, and highlights both the **potential and the limitations** of such approaches for health service planning.

---

## Project Objective

To analyse factors associated with 30-day hospital readmission among patients with diabetes and to develop baseline predictive models using routinely collected inpatient data, reflecting the type of data commonly available to hospitals and health departments.

---

## Data Source & Scope

* **Dataset:** UCI Diabetes 130-US Hospitals Dataset
* **Source:** UCI Machine Learning Repository
* **Scope:**

  * ~100,000 inpatient encounters
  * 130 U.S. hospitals
  * Study period: 1999–2008
  * Adult patients with diabetes-related diagnoses
* **Outcome:** Readmission within 30 days of discharge

Raw data files are not included in the repository due to file size considerations and reproducibility best practices.

---

## Methodology

### Data Preparation

* Data cleaning, recoding, and feature engineering using **tidyverse** and **janitor**
* Handling of missing values and categorical variables
* Construction of analytically meaningful predictors from administrative fields

### Exploratory Analysis

* Assessment of patient demographics, hospital utilisation, and clinical complexity
* Exploration of readmission patterns across key subgroups

### Modelling Approach

Binary classification models were developed to estimate 30-day readmission risk:

* **Logistic regression** (baseline, interpretable model)
* **Random forest** (non-linear, tree-based model)

### Model Evaluation

* Receiver Operating Characteristic (ROC) curves
* Area Under the Curve (AUC)
* Confusion matrices
* Feature relevance assessed using random forest variable importance

All scripts are fully reproducible using relative file paths.

---

## Key Findings

* Approximately **10–12%** of inpatient encounters resulted in 30-day readmission
* Higher readmission risk was associated with:

  * Longer length of hospital stay
  * Greater medication burden
  * Higher number of laboratory procedures
  * Increased diagnostic complexity
  * Older age groups

Both logistic regression and random forest models demonstrated **modest predictive performance** (AUC ≈ 0.55–0.58), underscoring the limitations of relying solely on inpatient administrative data for readmission prediction.

---

## Health System Implications

* Administrative inpatient data alone provides **limited discriminatory power** for predicting short-term readmission
* Effective readmission risk stratification likely requires:

  * Integration of outpatient and primary care data
  * Longitudinal patient history
  * Social determinants of health
* Findings support the need for **system-level data linkage** rather than standalone hospital-based models when designing readmission reduction strategies

---

## Limitations

* Class imbalance constrained predictive performance
* Diagnosis and procedure codes lack clinical and behavioural detail
* No information on outpatient care, medication adherence, or social risk factors
* Results are not intended for direct clinical deployment

---

## Tools & Technologies

* **R:** tidyverse, janitor, caret, pROC, randomForest
* **Methods:**

  * Data wrangling and preprocessing
  * Exploratory data analysis
  * Logistic regression and tree-based modelling
  * Model evaluation and interpretation

---

## Repository Structure

```
diabetes-readmission-prediction/
├── README.md
├── scripts/
│   ├── 01_load_clean.R   # Data cleaning & feature engineering
│   ├── 02_eda.R          # Exploratory data analysis
│   └── 03_model.R        # Logistic regression & random forest models
├── outputs/
│   ├── figures/          # Key visualisations
│   └── tables/           # Model outputs & variable importance
```

---

## How This Work Could Be Extended

* Incorporation of primary care and outpatient datasets
* Inclusion of social and behavioural risk indicators
* Use of time-to-event models for longitudinal readmission analysis
* Adaptation for population health monitoring and service planning use cases

---



### 🔜 Next step

Paste your **SAS (DHS breastfeeding)** README next.
That one will be your **public-health / epidemiology flagship**, while this becomes your **health systems analytics flagship**.



