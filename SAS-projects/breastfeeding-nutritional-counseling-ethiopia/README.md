
# Antenatal Nutritional Counseling and Timely Initiation of Breastfeeding in Ethiopia

*A population-based survey analysis*

## Population Health Context

Early initiation of breastfeeding within one hour of birth is a critical maternal and child health indicator, associated with reduced neonatal mortality and improved early-life outcomes. Antenatal care provides an important opportunity to promote optimal infant feeding practices; however, the effectiveness of antenatal nutritional counseling depends on broader **health system and delivery-level factors**.

This analysis uses nationally representative survey data to assess whether antenatal nutritional counseling translates into timely breastfeeding initiation, while accounting for socio-demographic and delivery-related determinants.

---

## Project Objective

To evaluate the association between receipt of antenatal nutritional counseling and timely initiation of breastfeeding among women in Ethiopia, using survey-weighted methods appropriate for complex population-based data.

---

## Data Source & Study Population

* **Dataset:** Ethiopia Demographic and Health Survey (EDHS), 2016
* **Design:** Nationally representative, cross-sectional household survey
* **Sample:** 4,074 women with children aged 0–23 months
* **Survey Design:** Stratified, clustered sampling with probability weights

Restricted DHS microdata are not included in this repository.

---

## Study Design & Methodology

### Analytical Approach

* Survey-weighted descriptive statistics to characterise the study population
* Bivariate associations assessed using **Rao–Scott chi-square tests**
* Unadjusted and multivariable **survey-weighted logistic regression**

All analyses appropriately account for DHS sampling weights, strata, and clusters to ensure valid population-level inference.

### Key Measures

**Outcome**

* Timely initiation of breastfeeding (within one hour of birth)

**Primary Exposure**

* Receipt of nutritional counseling during antenatal care

**Covariates**

* Maternal age, parity, education, and marital status
* Household wealth index
* Urban vs rural residence
* Number of antenatal visits
* Place of delivery and skilled birth attendance
* Cesarean section delivery
* Sex of the child

---

## Key Findings

* Receipt of antenatal nutritional counseling was **not significantly associated** with timely initiation of breastfeeding after adjustment
* Higher parity (2–4 children and ≥5 children) was associated with **higher odds** of early initiation
* Cesarean section delivery showed a **strong negative association** with timely breastfeeding initiation
* Mothers aged 35–49 years had a **lower likelihood** of initiating breastfeeding within one hour

---

## Programmatic & Policy Implications

* Antenatal counseling alone may be **insufficient** to improve early breastfeeding initiation without supportive delivery and postnatal practices
* Delivery-related factors, particularly cesarean section, represent critical barriers requiring targeted interventions
* Findings support the need for:

  * Strengthened **post-delivery breastfeeding support**
  * Improved integration between antenatal counseling and maternity ward practices
  * Emphasis on skilled birth attendance and immediate postnatal care protocols

---

## Strengths & Limitations

### Strengths

* Use of nationally representative survey data
* Appropriate handling of complex survey design
* Policy-relevant maternal and child health outcomes

### Limitations

* Cross-sectional design limits causal inference
* Self-reported measures may be subject to recall bias
* Quality and content of antenatal counseling could not be assessed

---

## Tools & Methods

* **SAS 9.4**

  * PROC SURVEYFREQ
  * PROC SURVEYLOGISTIC
* Survey-weighted regression modelling
* DHS data management and variable construction

---

## Repository Contents

```
antenatal-nutrition-breastfeeding/
├── analysis.sas        # Data cleaning, variable recoding, survey analyses
├── manuscript.pdf     # Full research manuscript
├── tables.pdf         # Formatted descriptive and regression tables
```

---

## How This Work Can Be Used in Practice

* Inform maternal and child health program design
* Identify delivery-level barriers to optimal infant feeding practices
* Support monitoring and evaluation of antenatal and postnatal care interventions
* Provide evidence for strengthening facility-based breastfeeding support policies

---








