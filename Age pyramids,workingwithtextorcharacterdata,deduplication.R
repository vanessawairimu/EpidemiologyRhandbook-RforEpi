#install.packages("apyramid")
library(apyramid)
library(ggplot2)
library(dplyr)
age_pyramid(
  data = linelist,
  age_group = "age_cat5",
  split_by = "sex"
)
linelist <- import(here("data", "linelists", "linelist_cleaned.xlsx"), which = "Sheet 1")
class(linelist$age_cat5) # class tells you what kind of object sth is in R, 
class(5)              # "numeric"
class("hello")         # "character"
class(TRUE)             # "logical"
class(Sys.Date())       # "Date"
class(linelist)         # "data.frame" (or "tbl_df" "tbl" "data.frame" if using tidyverse import)
linelist <- linelist %>%
  mutate(age_cat5 = factor(age_cat5))

class(linelist$age_cat5)   # should now say "factor"
levels(linelist$age_cat5)  # check the order looks sensible
linelist <- linelist %>%
  mutate(age_cat5 = factor(age_cat5, levels = c(sort(unique(age_cat5)))))
age_pyramid(
  data = linelist,
  age_group = "age_cat5",
  split_by = "sex"
)
# check what levels currently exist
unique(linelist$age_cat5)

# reset with the correct numeric order
linelist <- linelist %>%
  mutate(age_cat5 = factor(
    age_cat5,
    levels = c("0-4", "5-9", "10-14", "15-19", "20-24", "25-29", "30-34",
               "35-39", "40-44", "45-49", "50-54", "55-59", "60-64",
               "65-69", "70-74", "75-79", "80-84")
  ))

levels(linelist$age_cat5)   # confirm correct order now

#Working with text/character data

install.packages("stringr")
library(stringr)
library(dplyr)
nchar("hello")           # 5 — counts characters
toupper("hello")         # "HELLO"
tolower("HELLO")         # "hello"
trimws("  hello  ")      # "hello" — removes leading/trailing whitespace
str_detect(linelist$hospital, "General")     # TRUE/FALSE — does it contain this text?
str_length(linelist$hospital)                 # character count per entry
str_to_upper(linelist$hospital)               # uppercase
str_trim(linelist$hospital)                   # trim whitespace
linelist <- import(here("data", "linelists", "linelist_cleaned.xlsx"), which = "Sheet 1")
#detecting and filtering by text pattern 
linelist %>%
  filter(str_detect(hospital, "General"))
#Replacing text 
linelist <- linelist %>%
  mutate(hospital = str_replace_all(hospital, "St. Mary's", "St Marys"))
#splitting text into pieces
str_split("John_Smith_34", "_")

#De-duplication
#count duplicate rows
sum(duplicated(linelist)) # 0 duplicate rows 
linelist %>% filter(duplicated(linelist))

#iteration,loops and lists to repeat operations without copy pasting the code>
library(purrr)
for (i in 1:5) {
  print(i * 2)
}
#to check for missingness across several columns
cols_to_check <- c("age_years", "outcome", "hospital")

for (col in cols_to_check) {
  n_missing <- sum(is.na(linelist[[col]]))
  print(paste(col, "has", n_missing, "missing values"))
}
my_list <- list(
  name = "outbreak_analysis",
  n_cases = nrow(linelist),
  summary_stats = summary(linelist$age_years)
)

my_list$name
my_list$n_cases
# purr::map() is the tidyverse way to iterate preferref over for loops 
map(cols_to_check, ~ sum(is.na(linelist[[.x]])))
#a cleaner variant that returns a simple vector instead of a list.
map_dbl(cols_to_check, ~ sum(is.na(linelist[[.x]])))

library(ggplot2)

map(cols_to_check, ~ {
  ggplot(linelist, aes(x = .data[[.x]])) + geom_bar()
})
names(linelist)
linelist <- linelist %>% rename(sex = gender)

linelist %>%
  filter(hospital == "Missing" | is.na(hospital)) %>%
  count(hospital, outcome)