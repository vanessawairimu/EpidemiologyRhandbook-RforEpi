# install the latest version of the Epi R Handbook package
pacman::p_install_gh("appliedepi/epirhandbook")
install.packages("pacman")
pacman::p_install_gh("appliedepi/epirhandbook")
pacman::p_install_gh("appliedepi/epirhandbook")
install.packages("remotes")
remotes::install_github("appliedepi/epirhandbook")
# install the latest version of the Epi R Handbook package
pacman::p_install_gh("appliedepi/epirhandbook")
remotes::install_github("appliedepi/epirhandbook@master")
usethis::create_github_token()  # opens browser to generate a token
# paste it when prompted, or run:
Sys.setenv(GITHUB_PAT = "your_token_here")
remotes::install_github("appliedepi/epirhandbook")
install.packages("remotes")
remotes::install_github("appliedepi/epirhandbook", force = TRUE)
usethis::gh_token_help()
usethis::create_github_token()
gitcreds::gitcreds_set()
remotes::install_github("appliedepi/epirhandbook", auth_token = NA)
# install the latest version of the Epi R Handbook package
pacman::p_install_gh("appliedepi/epirhandbook")
?pacman
# Create an age pyramid
age_pyramid(
  data = linelist,        # use case linelist
  age_group = "age_cat5", # provide age group column
  split_by = "gender"     # use gender column for two sides of pyramid
)
# Create an age pyramid
age_pyramid(data = linelist, age_group = "age_cat5", split_by = "gender")
linelist <- rio::import("linelist_cleaned.rds")
install.packages("apyramid")
library(apyramid)
# Install (if necessary) and load packages for use
pacman::p_load(rio, tidyverse, here)
# load packages for use, with base R
library(tidyverse)
library(rio)
library(here)
# install/load the epicontacts package from its Github repository
p_load_gh("reconhub/epicontacts")
packageurl <- "https://cran.r-project.org/src/contrib/Archive/dsr/dsr_0.2.2.tar.gz"
install.packages(packageurl, repos=NULL, type="source")
packageurl <- "https://cran.r-project.org/src/contrib/Archive/dsr/dsr_0.2.2.tar.gz"
install.packages(packageurl, repos=NULL, type="source")
install.packages("frailtypack")
packageurl <- "https://cran.r-project.org/src/contrib/Archive/dsr/dsr_0.2.2.tar.gz"
# This command uses the package "rio" and its function "import()" to import a dataset
linelist <- rio::import("linelist.xlsx", which = "Sheet1")
getwd()
current_week <- "2018-W10"
# A fake example of how to bake a cake using piping syntax

cake <- flour %>%       # to define cake, start with flour, and then...
  add(eggs) %>%   # add eggs
  add(oil) %>%    # add oil
  add(water) %>%  # add water
  mix_together(         # mix together
    utensil = spoon,
    minutes = 2) %>%    
  bake(degrees = 350,   # bake
       system = "fahrenheit",
       minutes = 35) %>%  
  let_cool()            # let it cool down
library(tidyverse)
##########################################
# List of useful epidemiology R packages #
##########################################

# This script uses the p_load() function from pacman R package, 
# which installs if package is absent, and loads for use if already installed


# Ensures the package "pacman" is installed
if (!require("pacman")) install.packages("pacman")


# Packages available from CRAN
##############################
pacman::p_load(
  
  # learning R
  ############
  learnr,   # interactive tutorials in RStudio Tutorial pane
  swirl,    # interactive tutorials in R console
  
  # project and file management
  #############################
  here,     # file paths relative to R project root folder
  rio,      # import/export of many types of data
  openxlsx, # import/export of multi-sheet Excel workbooks 
  
  # package install and management
  ################################
  pacman,   # package install/load
  renv,     # managing versions of packages when working in collaborative groups
  remotes,  # install from github
  
  # General data management
  #########################
  tidyverse,    # includes many packages for tidy data wrangling and presentation
  #dplyr,      # data management
  #tidyr,      # data management
  #ggplot2,    # data visualization
  #stringr,    # work with strings and characters
  #forcats,    # work with factors 
  #lubridate,  # work with dates
  #purrr       # iteration and working with lists
  linelist,     # cleaning linelists
  naniar,       # assessing missing data
  
  # statistics  
  ############
  janitor,      # tables and data cleaning
  gtsummary,    # making descriptive and statistical tables
  rstatix,      # quickly run statistical tests and summaries
  broom,        # tidy up results from regressions
  lmtest,       # likelihood-ratio tests
  easystats,
  # parameters, # alternative to tidy up results from regressions
  # see,        # alternative to visualise forest plots 
  
  # epidemic modeling
  ###################
  epicontacts,  # Analysing transmission networks
  EpiNow2,      # Rt estimation
  EpiEstim,     # Rt estimation
  projections,  # Incidence projections
  incidence2,   # Make epicurves and handle incidence data
  i2extras,     # Extra functions for the incidence2 package
  epitrix,      # Useful epi functions
  distcrete,    # Discrete delay distributions
  
  
  # plots - general
  #################
  #ggplot2,         # included in tidyverse
  cowplot,          # combining plots  
  # patchwork,      # combining plots (alternative)     
  RColorBrewer,     # color scales
  ggnewscale,       # to add additional layers of color schemes
  
  
  # plots - specific types
  ########################
  DiagrammeR,       # diagrams using DOT language
  incidence2,       # epidemic curves
  gghighlight,      # highlight a subset
  ggrepel,          # smart labels
  plotly,           # interactive graphics
  gganimate,        # animated graphics 
  
  
  # gis
  ######
  sf,               # to manage spatial data using a Simple Feature format
  tmap,             # to produce simple maps, works for both interactive and static maps
  OpenStreetMap,    # to add OSM basemap in ggplot map
  spdep,            # spatial statistics 
  
  # routine reports
  #################
  rmarkdown,        # produce PDFs, Word Documents, Powerpoints, and HTML files
  reportfactory,    # auto-organization of R Markdown outputs
  officer,          # powerpoints
  
  # dashboards
  ############
  flexdashboard,    # convert an R Markdown script into a dashboard
  shiny,            # interactive web apps
  
  # tables for presentation
  #########################
  knitr,            # R Markdown report generation and html tables
  flextable,        # HTML tables
  #DT,              # HTML tables (alternative)
  #gt,              # HTML tables (alternative)
  #huxtable,        # HTML tables (alternative) 
  
  # phylogenetics
  ###############
  ggtree,           # visualization and annotation of trees
  ape,              # analysis of phylogenetics and evolution
  treeio            # to visualize phylogenetic files
  
)