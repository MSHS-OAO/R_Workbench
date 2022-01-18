
# Check renv library
# create reproducible environments for R projects

#set working directory
setwd("C:/Users/aghaer01/Downloads/Renv Library")


# 1. Install packages

#install.packages("renv")


# Import libraries
library(readxl)
library(tidyverse)
library(renv)

.libPaths()

# 2. Initialize renv: this set up the project with a private library recorded into a lockfile, called renv.lock.
# The renv.lock lockfile records the state of the project's private library, and can be used to restore the state of that library as required.
renv::init(renv::init(force = TRUE)) 

# select "Activate the project and use the existing library" to restart R session 

.libPaths()

# check packages in lockfile
renv::dependencies()

covid_data_mssn <- read_excel("C:/Users/aghaer01/Downloads/Patient Details - 2021-12-30.xlsx")

# Status column
colnames(covid_data_mssn )[colnames(covid_data_mssn ) == "COVID +  Cond"] <- "status"
covid_data_mssn  <- covid_data_mssn  %>% mutate(status=ifelse(status=="Covid+", "COVID19", status))

# Create Unit Type High
covid_data_mssn  <- covid_data_mssn  %>% 
  mutate(`Unit Type High` = ifelse(`Pat Class` %in% "I", "IP", ifelse(`Pat Class` %in% "E", "ED", "Other")))


# Change date format
covid_data_mssn  <- covid_data_mssn %>% mutate(AdmitDate = as.Date(`Admit date`, "%m/%d/%Y"),
                                               DischargeDate = as.Date(`Discharge Date`, "%m/%d/%Y"))


#Create Census Date
covid_data_mssn  <- covid_data_mssn %>% mutate(end_date = ifelse(is.na(DischargeDate), Sys.Date(), DischargeDate))
covid_data_mssn  <- covid_data_mssn %>%  mutate(end_date = as.Date(end_date, "1970-01-01"),
                                                los = as.integer(end_date - AdmitDate))  %>% filter(los > 0)


covid_data_mssn  <- covid_data_mssn <- covid_data_mssn[rep(seq(nrow(covid_data_mssn)), times = covid_data_mssn$los),]
covid_data_mssn  <- covid_data_mssn %>% group_by(Visitid, Medrec, status, `Unit Type High`, AdmitDate, DischargeDate, end_date) %>%
  mutate(number = 1:n(), CensusDate = AdmitDate + (number - 1)) %>%
  select(Visitid, Medrec, status, `Unit Type High`, AdmitDate, DischargeDate, end_date, los, CensusDate )

covid_data_mssn <- unique(covid_data_mssn)



# save the state of libraries to the lockfile
renv::snapshot() # running the code, it asks if we would like to activate the project. Say Y, then it updates libraries. 




# port the project in another computer
# It reinstall all packages as declared in the lockfile.
renv::restore()

renv::deactivate()

