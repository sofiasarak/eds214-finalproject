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
figure3 <- left_join(figure3, year_value, by = c("sample_id", "sample_date", "code"))

#making a smaller dataset to work with without miscellaneous columns; week column
figure3 <- figure3 %>% 
  mutate(week = lubridate::week(sample_date)) %>% 
  relocate(week, .after= sample_date) %>% 
  relocate(year, .after= week) %>% 
  select(sample_id:nh4_n)

moving_avg <- matrix(nrow = 34*52, ncol=1)

for(i in 1:length(week)) {
  temp <- figure3$week[i]:figure3$week[i+8]}
  avg <- figure3 %>% 
    group_by(year) %>%
    filter(week[i]:week[i+8]) %>% 
    summarize(mean = mean(no3_n))
  moving_avg[i, 1] <- avg
}


firstdraft <- ggplot(data = figure3, aes(x = year, no3_n)) + geom_line()


#what I can do: group by year, then reorder so weeks go up ordinally. then run my for loop
byyear <- figure3 %>% 
  group_by(year) %>% 
  
  




