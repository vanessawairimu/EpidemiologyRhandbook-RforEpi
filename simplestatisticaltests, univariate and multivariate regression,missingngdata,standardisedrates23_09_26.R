#simple statistical tests
install.packages("rstatix")
library(rstatix)
library(dplyr)
#basic hypothesis tests 
#t-test is used to compare numeric variables between two groups
t.test(age_years ~ outcome, data = linelist %>% filter(outcome %in% c("Death", "Recover")))
t.test(age_years ~ sex, data = linelist)
names(linelist)
# Welch two sample t-test is a variant of the t-test that doesnt assume both groups have equal variance 
# t= test statistic 
# df= degrees of freedon - feeds into p-value
# p-value check the pvalue <0.05 suggests a statistically meaningful difference.
# 95 percent confidence intervals is the range of plausible values for the true difference in mean age btwn the 2 groups 

#Wlicoxon test - nonparametric - used when your numeric data isn't normally distributed, skewed data, small samples.
wilcox.test(age_years ~ outcome, data = linelist %>% filter(outcome %in% c("Death", "Recover")))
wilcox.test(days_to_hosp ~ sex, data = linelist)
#p-value is 0.3241 which is way above the 0.05 theshold meaning there is no statistical evidence that hospitalization delay differs between male and female.

#Chi-squared test - compare 2 categoical varibles
chisq.test(linelist$sex, linelist$outcome)
chisq.test(linelist$age_group_simple, linelist$outcome)
length(linelist$age_group_simple)
length(linelist$outcome)
outcome <- c("Recovered", "Died", "Recovered")
exists("outcome")
length(outcome)
rm(outcome)

#fisher's exact test - categorical variables with small sample sizes
fisher.test(linelist$sex, linelist$outcome)
#correlation - rela btwn 2 numeric variables 
cor.test(linelist$age_years, linelist$days_to_hosp)
class(linelist$days_to_hosp)
linelist <- linelist %>%
  mutate(date_hospitalisation = as.Date(date_hospitalisation)) %>%
  mutate(days_to_hosp = as.numeric(date_hospitalisation - date_onset))
linelist <- linelist %>%
  mutate(days_to_hosp = as.numeric(days_to_hosp))
cor.test(linelist$age_years, linelist$days_to_hosp)

#rstatix -tidyverse option pipeable and cleaner output
linelist %>%
  filter(outcome %in% c("Death", "Recover")) %>%
  t_test(age_years ~ outcome)


# UNIVARIATE AND MULTIVARIATE REGRESSION
library(broom)
library(gtsummary)

# Regression - models relationships , stats test tests the comparison in the variables while regression looks at how much one variable affects another accounting for other variables at the same time#
#glm =generalised linear model - linear regression , logistic regression  , poisson regression, negative binomial regression, Gamma regression.
# simple linear regression - models rela btwn one predictor(independent variable ) and one outcome(dependent variable)
model1 <- lm(age_years ~ sex, data = linelist)
summary(model1)

#logistic regression - predicts a binary outcome (yes/no,1/2,dead/recovered), it models probablity that y=1 

# first, make outcome binary/numeric if needed (1 = death, 0 = other)
linelist <- linelist %>%
  mutate(died = if_else(outcome == "Death", 1, 0))

model2 <- glm(died ~ age_years, data = linelist, family = "binomial")
summary(model2)
#interprating logistic regression coefficients- odds ratio
tidy(model2, exponentiate = TRUE, conf.int = TRUE)
# multivariable regression 
model3 <- glm(died ~ age_years + sex, data = linelist, family = "binomial")
tidy(model3, exponentiate = TRUE, conf.int = TRUE)
tbl_regression(model3, exponentiate = TRUE)


# MISSING DATA 
library(naniar)
#UNDERSTANDING and handling missing data properly
#visual overview of missingness across the whole dataset
vis_miss(linelist)
vis_miss(linelist)
miss_var_summary(linelist)
# three types of missingness 
#MCAR- Missing completely at random, MAR- Missingness at Random,MNAR- Missingness Not At Random.
#testing if missingness in one column relates to another variable (MAR vs MCAR)
linelist %>%
  group_by(is.na(outcome)) %>%
  summarise(mean_age = mean(age_years, na.rm = TRUE))
#visualise whether two varibales missingness are related#
gg_miss_upset(linelist)
gg_miss_fct(linelist, age_cat5)
ggplot(
  data = linelist,
  mapping = aes(x = age_years, y = temp)) +     
  geom_miss_point()
#shadow matrix 
linelist_shadow <- bind_shadow(linelist)
linelist %>%
  slice(1:800) %>%
  miss_var_summary()


# STANDARDISED RATES
linelist %>%
  group_by(hospital) %>%
  summarise(
    n_cases = n(),
    n_deaths = sum(died, na.rm = TRUE),
    crude_rate = n_deaths / n_cases * 100
  )
standard_pop <- linelist %>%
  count(age_unit) %>%
  mutate(standard_weight = n / sum(n))
names(linelist_shadow)
standard_pop
age_specific_rates <- linelist %>%
  group_by(hospital, age_unit) %>%
  summarise(
    n_cases = n(),
    n_deaths = sum(died, na.rm = TRUE),
    rate = n_deaths / n_cases,
    .groups = "drop"
  )

age_specific_rates
standardized_rates <- age_specific_rates %>%
  left_join(standard_pop, by = "age_unit") %>%
  group_by(hospital) %>%
  summarise(
    standardized_rate = sum(rate * standard_weight, na.rm = TRUE) * 100
  )

standardized_rates
standardized_rates <- age_specific_rates %>%
  left_join(standard_pop, by = "age_unit") %>%
  group_by(hospital) %>%
  summarise(
    standardized_rate = sum(rate * standard_weight, na.rm = TRUE) * 100
  )

standardized_rates
