#loading packages

library(tidyverse)
library(here)
library(janitor)

#reading in data

prm <- read_csv(here("data", "RioMameyesPuenteRoto.csv")) %>% 
  clean_names()
bq1 <- read_csv(here("data", "QuebradaCuenca1-Bisley.csv")) %>% 
  clean_names()
bq2 <- read_csv(here("data", "QuebradaCuenca2-Bisley.csv")) %>% 
  clean_names()
bq3 <- read_csv(here("data", "QuebradaCuenca3-Bisley.csv")) %>% 
  clean_names()

#trying to combine everything
figure3 <- full_join(prm, bq1)
figure3 <- full_join(figure3, bq2)
figure3 <- full_join(figure3, bq3)
unique(figure3$sample_id) #checking to see that all four dfs were combined, should return: MPR, Q1, Q2, and Q3

#making a year column
year_value <- data.frame(sample_id = figure3$sample_id, 
                         sample_date = figure3$sample_date, 
                         code = figure3$code, 
                         year = lubridate::year(figure3$sample_date))
figure3test <- left_join(figure3, year_value, by = c("sample_id", ))