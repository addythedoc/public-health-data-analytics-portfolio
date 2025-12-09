# scripts/03_model.R
# STEP 3 — MODELING: LOGISTIC REGRESSION & RANDOM FOREST

# Load libraries
library(tidyverse)
library(caret)
library(pROC)
library(randomForest)

set.seed(123)

#------------------------------------------------------------
# 1. Load cleaned dataset (relative path)
#------------------------------------------------------------

df <- read.csv("data/processed/diabetes_processed.csv")
df$readmitted_30 <- factor(df$readmitted_30, levels = c("NO", "YES"))

#------------------------------------------------------------
# 2. Drop ID columns & duplicate outcome, then drop NAs
#------------------------------------------------------------

id_cols <- c("encounter_id", "patient_nbr", "readmitted")
id_cols <- id_cols[id_cols %in% colnames(df)]

df_model <- df %>%
  select(-all_of(id_cols)) %>%
  drop_na()

#------------------------------------------------------------
# 3. Train/test split
#------------------------------------------------------------

train_index <- createDataPartition(df_model$readmitted_30, p = 0.7, list = FALSE)

train <- df_model[train_index, ]
test  <- df_model[-train_index, ]

#------------------------------------------------------------
# 4. Convert character → factor
#------------------------------------------------------------

train <- train %>% mutate(across(where(is.character), as.factor))
test  <- test  %>% mutate(across(where(is.character), as.factor))

# Ensure factor levels in test match those in train
for (v in names(train)) {
  if (is.factor(train[[v]]) && v %in% names(test)) {
    test[[v]] <- factor(test[[v]], levels = levels(train[[v]]))
  }
}

#------------------------------------------------------------
# 5. Drop predictors with <2 unique values
#------------------------------------------------------------

predictor_names <- setdiff(names(train), "readmitted_30")

n_levels <- sapply(train[predictor_names], function(x) {
  if (is.factor(x)) {
    nlevels(x)
  } else {
    length(unique(x))
  }
})

cols_to_drop <- names(n_levels[n_levels < 2])
cols_to_drop   # shows what gets dropped in console

train <- train %>% select(-all_of(cols_to_drop))
test  <- test  %>% select(-all_of(cols_to_drop))

#------------------------------------------------------------
# 6. Logistic Regression (using full training data)
#------------------------------------------------------------

model_logit <- glm(
  readmitted_30 ~ time_in_hospital + num_lab_procedures + num_medications + number_diagnoses +
    age + race + gender + admission_type_id + discharge_disposition_id + admission_source_id,
  data = train,
  family = binomial
)

summary(model_logit)

# Predictions on test set
pred_logit_prob <- predict(model_logit, newdata = test, type = "response")

pred_logit_class <- ifelse(pred_logit_prob >= 0.5, "YES", "NO") |>
  factor(levels = c("NO", "YES"))

# Confusion matrix
cm_logit <- confusionMatrix(pred_logit_class, test$readmitted_30, positive = "YES")
cm_logit

# ROC + AUC
roc_logit <- roc(test$readmitted_30, pred_logit_prob)
auc_logit <- auc(roc_logit)
cat("\nLogistic Regression AUC:", auc_logit, "\n")

#------------------------------------------------------------
# 7. Random Forest (same predictors as logistic model)
#------------------------------------------------------------

cat("\n=== Random Forest ===\n")

train_rf <- train
test_rf  <- test

# Make sure factor structure is consistent
train_rf <- train_rf %>% mutate(across(where(is.character), as.factor))
test_rf  <- test_rf  %>% mutate(across(where(is.character), as.factor))

rf_formula <- readmitted_30 ~ time_in_hospital + num_lab_procedures + num_medications + number_diagnoses +
  age + race + gender + admission_type_id + discharge_disposition_id + admission_source_id

model_rf <- randomForest(
  rf_formula,
  data = train_rf,
  ntree = 200,
  mtry = 4,
  importance = TRUE
)

print(model_rf)

# Predict on test set
pred_rf_prob  <- predict(model_rf, newdata = test_rf, type = "prob")[, "YES"]
pred_rf_class <- predict(model_rf, newdata = test_rf, type = "response")

# Confusion matrix
cm_rf <- confusionMatrix(pred_rf_class, test_rf$readmitted_30, positive = "YES")
cm_rf

# ROC and AUC
roc_rf <- roc(test_rf$readmitted_30, pred_rf_prob)
auc_rf <- auc(roc_rf)
cat("\nRandom Forest AUC:", auc_rf, "\n")

#------------------------------------------------------------
# 8. Variable importance (Random Forest)
#------------------------------------------------------------

cat("\n=== Random Forest Variable Importance ===\n")

vip <- importance(model_rf)
vip_df <- as.data.frame(vip) %>%
  rownames_to_column(var = "variable") %>%
  arrange(desc(MeanDecreaseGini))

print(head(vip_df, 20))

# Create outputs dirs (relative)
dir.create("outputs/tables",  recursive = TRUE, showWarnings = FALSE)
dir.create("outputs/figures", recursive = TRUE, showWarnings = FALSE)

# Save importance table
write.csv(
  vip_df,
  "outputs/tables/rf_variable_importance.csv",
  row.names = FALSE
)

# Plot top 20 variables
p_vip <- ggplot(vip_df[1:20, ], aes(x = reorder(variable, MeanDecreaseGini), y = MeanDecreaseGini)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Top 20 Important Predictors (Random Forest)",
    x = "Variable",
    y = "Mean Decrease in Gini"
  ) +
  theme_minimal()

print(p_vip)

ggsave(
  filename = "rf_variable_importance_top20.png",
  path = "outputs/figures",
  width = 8,
  height = 6,
  dpi = 300
)

cat("\n✔️ Saved RF variable importance CSV and plot to outputs/.\n")



