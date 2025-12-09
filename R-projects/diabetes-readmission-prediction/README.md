
# Predicting 30-Day Hospital Readmission Among Diabetic Patients

**Tools:** R (tidyverse, janitor, caret, pROC, randomForest)
**Domain:** Clinical Epidemiology, Health Services Research
**Data Source:** UCI Diabetes 130-US Hospitals Dataset

---

## Project Overview

This project analyzes factors associated with **30-day hospital readmission among diabetic patients** and develops baseline predictive models to estimate readmission risk using routinely collected inpatient data. The goal is to evaluate how well administrative and clinical variables alone can predict short-term readmission.

---

## Data

* Publicly available dataset from the **UCI Machine Learning Repository**
* ~100,000 inpatient encounters from **130 U.S. hospitals** (1999–2008)
* Adult patients with diabetes-related diagnoses
* **Outcome:** Readmission within 30 days of discharge
* Raw and processed data files are **not included** due to file size and best practices

---

## Study Design & Methods

* Data cleaning and feature engineering using **tidyverse** and **janitor**
* Exploratory data analysis to assess patient and hospitalization characteristics
* Binary classification modeling:

  * Logistic regression
  * Random forest
* Model evaluation included:

  * ROC–AUC
  * Confusion matrices
* Feature relevance assessed using **random forest variable importance**

All scripts are fully reproducible using relative file paths.

---

## Key Findings

* Approximately **10–12%** of inpatient encounters resulted in 30-day readmission
* Higher readmission risk was associated with:

  * Longer hospital stays
  * Greater medication burden
  * Higher number of laboratory procedures
  * Increased diagnostic complexity
  * Older age groups
* Logistic regression and random forest models showed **modest predictive performance**
  (**AUC ≈ 0.55–0.58**), highlighting the limitations of administrative data for readmission prediction

---

## Limitations

* Strong class imbalance constrained predictive performance
* Administrative diagnosis and procedure codes lack clinical granularity
* No incorporation of outpatient care, social determinants of health, or longitudinal patient history

---

## Repository Structure

```
diabetes-readmission-prediction/
├── README.md
├── scripts/
│   ├── 01_load_clean.R      # Data cleaning & feature engineering
│   ├── 02_eda.R             # Exploratory data analysis
│   └── 03_model.R           # Logistic regression & random forest models
├── outputs/
│   ├── figures/             # Key visualizations
│   └── tables/              # Model outputs & variable importance
```

---

## Skills Demonstrated

* End-to-end analytical workflow in R
* Reproducible project structuring
* Data wrangling and preprocessing
* Exploratory data analysis and visualization
* Logistic regression and tree-based modeling
* Model evaluation and interpretation in a healthcare context

---



