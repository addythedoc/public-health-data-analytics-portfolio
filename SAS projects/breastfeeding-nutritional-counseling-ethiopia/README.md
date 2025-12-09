# Association Between Antenatal Nutritional Counseling and Timely Initiation of Breastfeeding in Ethiopia

**Tools:** SAS 9.4 (PROC SURVEYFREQ, PROC SURVEYLOGISTIC)  
**Domain:** Maternal & Child Health, Epidemiology  
**Data Source:** Ethiopia Demographic and Health Survey (EDHS), 2016

---

## Project Overview
This project examines whether receipt of nutritional counseling during antenatal care is associated with timely initiation of breastfeeding (within one hour of birth) among women in Ethiopia using nationally representative DHS data.

---

## Data
- Secondary, de-identified survey data from the 2016 Ethiopia DHS  
- Sample size: **4,074 women with children aged 0–23 months**  
- Complex survey design incorporating stratification, clustering, and sampling weights  
- Raw DHS microdata are restricted and not included in this repository  

---

## Study Design & Methods
- Cross-sectional analysis  
- Survey-weighted descriptive statistics  
- Bivariate analysis using Rao–Scott chi-square tests  
- Unadjusted and multivariable survey-weighted logistic regression  
- All analyses account for DHS sampling design (weights, strata, and clusters)  

---

## Key Variables

### Outcome
- Timely initiation of breastfeeding (within 1 hour of birth)

### Primary Exposure
- Receipt of nutritional counseling during antenatal care

### Covariates
- Maternal age, parity, education, marital status  
- Household wealth index  
- Place of residence (urban/rural)  
- Number of antenatal visits  
- Place of delivery  
- Cesarean section delivery  
- Skilled birth attendance  
- Sex of the child  

---

## Key Findings
- Nutritional counseling during antenatal care was **not significantly associated** with timely initiation of breastfeeding  
- Higher parity (2–4 children and ≥5 children) was associated with **higher odds** of timely breastfeeding initiation  
- Cesarean section delivery was **strongly associated with lower odds** of timely initiation  
- Mothers aged 35–49 years showed a **reduced likelihood** of timely breastfeeding initiation  

---

## Public Health Relevance
Findings highlight structural and delivery-related barriers to early breastfeeding initiation, particularly among women delivering by cesarean section. Results emphasize the importance of strengthening post-delivery support and skilled birth attendance to improve early breastfeeding practices.

---

## Files
- `analysis.sas` – Data cleaning, variable recoding, descriptive, bivariate, and regression analyses  
- `manuscript.pdf` – Full research manuscript
- `tables.pdf` – Formatted results tables exported from SAS (descriptive, bivariate, and regression outputs)  

---

## Skills Demonstrated
- Survey-weighted analysis in SAS  
- DHS data management and variable construction  
- Rao–Scott chi-square testing  
- Survey-adjusted logistic regression (unadjusted and multivariable)  
- Epidemiologic interpretation of results  


