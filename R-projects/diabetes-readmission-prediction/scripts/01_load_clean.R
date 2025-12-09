# scripts/01_load_clean.R
# STEP 1 — LOAD, CLEAN, AND SAVE THE PROCESSED DATASET

# Install packages (run once manually, not in the script):
# install.packages(c("tidyverse", "janitor"))

library(tidyverse)
library(janitor)

#------------------------------------------------------------
# 1. Load raw dataset (from data/raw/)
#   Assumes working directory is the project root:
#   .../diabetes_readmission_prediction
#   and the file is at: data/raw/diabetic_data.csv
#------------------------------------------------------------

raw_path <- "data/raw/diabetic_data.csv"

data_raw <- read.csv(raw_path, stringsAsFactors = FALSE)

# Quick sanity checks
cat("Raw data dimensions:\n")
print(dim(data_raw))
cat("\nFirst rows:\n")
print(head(data_raw))
cat("\nStructure:\n")
str(data_raw)

#------------------------------------------------------------
# 2. Clean column names
#------------------------------------------------------------

df <- data_raw %>% 
  clean_names()

#------------------------------------------------------------
# 3. Create binary target variable: readmitted_30
#    YES = readmitted within 30 days ("<30")
#    NO  = all other values
#------------------------------------------------------------

df <- df %>%
  mutate(
    readmitted_30 = case_when(
      readmitted == "<30" ~ "YES",
      TRUE ~ "NO"
    ),
    readmitted_30 = factor(readmitted_30, levels = c("NO", "YES"))
  )

#------------------------------------------------------------
# 4. Convert selected columns to factors
#------------------------------------------------------------

df <- df %>%
  mutate(
    race                      = factor(race),
    gender                    = factor(gender),
    age                       = factor(age),
    admission_type_id         = factor(admission_type_id),
    discharge_disposition_id  = factor(discharge_disposition_id),
    admission_source_id       = factor(admission_source_id)
  )

#------------------------------------------------------------
# 5. Replace "?" with NA across all columns
#------------------------------------------------------------

df <- df %>%
  mutate(across(where(is.character), ~ na_if(.x, "?")))

#------------------------------------------------------------
# 6. Save cleaned dataset to data/processed/ as processed file
#------------------------------------------------------------

processed_dir <- "data/processed"
dir.create(processed_dir, recursive = TRUE, showWarnings = FALSE)

processed_path <- file.path(processed_dir, "diabetes_processed.csv")
write.csv(df, processed_path, row.names = FALSE)

cat("\n✔️ Saved cleaned data to:", processed_path, "\n")








