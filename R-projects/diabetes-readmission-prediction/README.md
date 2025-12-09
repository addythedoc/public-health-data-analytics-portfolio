# Predicting 30-Day Hospital Readmission Among Diabetic Patients

**Tools:** R (tidyverse, janitor, caret, pROC, randomForest)  
**Domain:** Clinical Epidemiology, Health Services Research  
**Data Source:** UCI Diabetes 130-US Hospitals Dataset

---

## Project Overview
This project examines factors associated with 30-day hospital readmission among diabetic
patients and develops baseline predictive models to assess readmission risk using routinely
collected clinical and administrative data.

---

## Data
- Public dataset from the UCI Machine Learning Repository  
- ~100,000 inpatient encounters across 130 U.S. hospitals (1999–2008)  
- Adult patients with diabetes-related diagnoses  
- Outcome: hospital readmission within 30 days of discharge  
- Raw and processed data files are not included due to file size and best practices  

---

## Study Design & Methods
- Data cleaning and feature engineering using `tidyverse` and `janitor`
- Exploratory data analysis to assess patient characteristics and hospitalization patterns
- Binary classification models:
  - Logistic regression
  - Random forest
- Model performance evaluated using:
  - ROC–AUC
  - Confusion matrices
- Variable importance assessed using random forest feature importance

---

## Key Findings
- Approximately 10–12% of inpatient encounters resulted in 30-day readmission
- Higher readmission risk was associated with:
  - Longer hospital stays
  - Greater number of medications and laboratory procedures
  - Higher diagnostic complexity
  - Older age groups
- Logistic regression and random forest models demonstrated similar predictive performance
  (AUC ≈ 0.57), indicating limited discrimination using administrative data alone

---

## Limitations
- Substantial class imbalance constrained model performance
- Administrative diagnosis codes lack clinical granularity
- No incorporation of outpatient care, social determinants of health, or longitudinal follow-up

---

## Files
- `scripts/01_load_clean.R` – Data cleaning and feature engineering  
- `scripts/02_eda.R` – Exploratory data analysis and visualization  
- `scripts/03_model.R` – Logistic regression and random forest modeling  
- `outputs/figures/` – Key visualizations  
- `outputs/tables/` – Model performance summaries  

---

## Skills Demonstrated
- End-to-end analytical workflow in R  
- Data wrangling and preprocessing  
- Exploratory data analysis and visualization  
- Logistic regression and tree-based modeling  
- Model evaluation and interpretation in a healthcare context  

