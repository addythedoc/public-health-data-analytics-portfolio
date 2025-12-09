# scripts/02_eda.R
# STEP 2 — EXPLORATORY DATA ANALYSIS (EDA)

library(tidyverse)

#------------------------------------------------------------
# Helper function: save plots to outputs/figures
#------------------------------------------------------------

save_plot <- function(plot_obj, name) {
  dir.create("outputs/figures", recursive = TRUE, showWarnings = FALSE)
  
  ggsave(
    filename = paste0(name, ".png"),
    plot = plot_obj,
    path = "outputs/figures",
    width = 8,
    height = 6,
    dpi = 300
  )
}

#------------------------------------------------------------
# 1. Load the cleaned dataset (relative path)
#------------------------------------------------------------

df <- read.csv("data/processed/diabetes_processed.csv",
               stringsAsFactors = FALSE)

#------------------------------------------------------------
# 2. Structure & basic checks
#------------------------------------------------------------

str(df)

df %>%
  count(readmitted_30) %>%
  mutate(pct = round(100 * n / sum(n), 1))

#------------------------------------------------------------
# 3. Summary of key numeric variables
#------------------------------------------------------------

df %>%
  select(time_in_hospital, num_lab_procedures, num_medications, number_diagnoses) %>%
  summary()

#------------------------------------------------------------
# 4. Boxplot: time in hospital vs readmission
#------------------------------------------------------------

p_box <- ggplot(df, aes(x = readmitted_30, y = time_in_hospital)) +
  geom_boxplot(outlier.alpha = 0.2) +
  labs(
    title = "Time in Hospital by 30-Day Readmission Status",
    x = "Readmitted Within 30 Days",
    y = "Time in Hospital (days)"
  ) +
  theme_minimal()

p_box
save_plot(p_box, "time_in_hospital_by_readmission")

#------------------------------------------------------------
# 5. Bar plot: readmission proportion by age group
#------------------------------------------------------------

p_age <- df %>%
  group_by(age, readmitted_30) %>%
  summarise(n = n(), .groups = "drop") %>%
  group_by(age) %>%
  mutate(prop = n / sum(n)) %>%
  ggplot(aes(x = age, y = prop, fill = readmitted_30)) +
  geom_col(position = "fill") +
  scale_y_continuous(labels = scales::percent) +
  labs(
    title = "Proportion of 30-Day Readmission by Age Group",
    x = "Age Group",
    y = "Proportion",
    fill = "Readmitted <30 Days"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

p_age
save_plot(p_age, "readmission_proportion_by_age")
