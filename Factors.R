#install.packages("forcats")
library(forcats)
library(dplyr)
library(rio)
library(here)
library(dplyr)
library(janitor)
library(lubridate)

# confirm project location
getwd()
setwd("C:/Users/User/Desktop/EpidemiologistsHandbookR/EpidemiologistsHandbookR")
getwd()
here()

# re-import
linelist <- import(here("data", "linelists", "linelist_cleaned.xlsx"), which = "Sheet 1")

# reapply cleaning steps done earlier in this session
linelist <- linelist %>% clean_names()
linelist <- linelist %>% rename(sex = gender)

linelist <- linelist %>%
  mutate(sex = case_when(
    sex %in% c("m", "M", "male", "Male") ~ "Male",
    sex %in% c("f", "F", "female", "Female") ~ "Female",
    TRUE ~ sex
  ))

linelist <- linelist %>%
  mutate(age_group_simple = case_when(
    age_years < 18 ~ "Child",
    age_years >= 18 & age_years < 65 ~ "Adult",
    age_years >= 65 ~ "Elderly",
    TRUE ~ NA_character_
  ))

linelist <- linelist %>%
  mutate(date_hospitalisation = as.Date(date_hospitalisation))

linelist <- linelist %>%
  mutate(days_to_hosp = as.numeric(date_hospitalisation - date_onset))

linelist <- linelist %>%
  mutate(epiweek_onset = epiweek(date_onset))

names(linelist)   # confirm it worked
# factors 
class(linelist$age_group_simple)
linelist <- linelist %>%
  mutate(age_group_simple = factor(
    age_group_simple,
    levels = c("Child", "Adult", "Elderly")   # the order you WANT
  ))

levels(linelist$age_group_simple)
# Relevel - move one specific category to the front.
linelist <- linelist %>%
  mutate(outcome = fct_relevel(outcome, "Death"))
# forces "Death" to be first level
# collapsing categories together
linelist <- linelist %>%
  mutate(hospital_grouped = fct_lump_n(hospital, n = 3))   # keep top 3, lump rest into "Other"

table(linelist$hospital_grouped)

# Descriptive/summary tables for reports.
install.packages("gtsummary")
library(gtsummary)
library(dplyr)
linelist %>%
  select(age_years, sex, outcome) %>%
  tbl_summary()

#split by grouping a variable
linelist %>%
  select(age_years, sex, outcome) %>%
  tbl_summary(by = outcome)
# add an overall column alognside the group split 
linelist %>%
  select(age_years, sex, outcome) %>%
  tbl_summary(by = outcome) %>%
  add_overall()
#rename labels to be more readable 
linelist %>%
  select(age_years, sex, outcome) %>%
  tbl_summary(
    by = outcome,
    label = list(
      age_years ~ "Age (years)",
      sex ~ "Sex"
    )
  )
#add a statistical test comparing groups using add_p
linelist %>%
  select(age_years, sex, outcome) %>%
  tbl_summary(by = outcome) %>%
  add_p()
  