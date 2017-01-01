setwd("~/Workspace/SambaTV/")

user_table = read.csv("Translation_Test__281_29/user_table.csv")
test_table = read.csv("Translation_Test__281_29/test_table.csv")

# test: 0 if saw old translation, 1 if saw new translation

length(unique(user_table$user_id))
length(unique(test_table$user_id))
# user_id is unique identifier in both datasets

merged_table = merge(user_table, test_table, by = "user_id", all = TRUE)

# Spaniard-translated conversion-rate of non-Spanish Spanish-speaking users:
spanish_language = subset(merged_table, browser_language == "ES" & country != "Spain" & test == 0)
mean(spanish_language$conversion) # 0.0486

# Spaniard-translated conversion-rate of Spanish Spanish-speaking users:
# Note that there is no new vs. old methodology for Spain, since it's already localized.
spain = subset(merged_table, browser_language == "ES" & country == "Spain")
mean(spain$conversion)

# Clearly significantly different, considering the number of observations.
# Obvious enough that there's no need to formally test this hypothesis.

## 1. Investigate if the test is actually negative:

# Localized conversion-rate of Spanish-speaking users:
spanish_language_test = subset(merged_table, browser_language == "ES" & country != "Spain" & test == 1)
mean(spanish_language_test$conversion) # 0.0435

# Conclusion: Test is actually negative, since 0.0435 < 0.0486

## 2. Explain why that might be happening. Are the localized translations really worse?

# Localized translations are not necessarily worse, since there could be other explanations.