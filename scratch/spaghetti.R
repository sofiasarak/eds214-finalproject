##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                                                                                   --
##-------------------------------------------------------------------------------------
##                                                                                   --
##      #      #............Analysis and Plotting of Figure 3............ ~~~ ~~
##                                                                                   ~~
##   This script is meant to recreate the stream water content figure through
##                       wrangling of data and plotting. 
##            Contact Sofia Sarak at sarak@ucsb.edu with questions. ~~
##                                                                                   ~~
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# loading packages

library(tidyverse)
library(here)
library(janitor)

#........................Wrangling of Data.......................

# reading in data

prm <- read_csv(here("data", "RioMameyesPuenteRoto.csv")) %>% 
  clean_names()
bq1 <- read_csv(here("data", "QuebradaCuenca1-Bisley.csv")) %>% 
  clean_names()
bq2 <- read_csv(here("data", "QuebradaCuenca2-Bisley.csv")) %>% 
  clean_names()
bq3 <- read_csv(here("data", "QuebradaCuenca3-Bisley.csv")) %>% 
  clean_names()

# trying to combine everything
figure3 <- full_join(prm, bq1)
figure3 <- full_join(figure3, bq2)
figure3 <- full_join(figure3, bq3)
unique(figure3$sample_id) #checking to see that all four dfs were combined, should return: MPR, Q1, Q2, and Q3

# making a year column, in order to have something to index by if running a for loop
year_value <- data.frame(sample_id = figure3$sample_id, 
                         sample_date = figure3$sample_date, 
                         code = figure3$code, 
                         year = lubridate::year(figure3$sample_date))
figure3 <- left_join(figure3, year_value, by = c("sample_id", "sample_date", "code"))

# making a smaller dataset to work with without miscellaneous columns; week column
figure3 <- figure3 %>% 
  mutate(week = lubridate::week(sample_date)) %>% 
  relocate(week, .after= sample_date) %>% 
  relocate(year, .after= week) %>% 
  select(sample_id:nh4_n)

# making a matrix in case I need it for moving averages

moving_avg <- matrix(nrow = 34*52, ncol=1)

# pivoting data to long format to make plotting with various nutrients easier

long_fig3 <- figure3 %>% 
  select(!c("na", "so4_s")) %>% 
  pivot_longer(no3_n:nh4_n, names_to = "nutrient", values_to = "value") %>% 
  arrange(sample_date)


#....................First Attempt at Plotting...................

# grouping my mean to make a basic graph with no moving averages

fig3_by_year <- longfig3 %>% 
  group_by(year, nutrient) %>% 
  summarize(mean = mean(value, na.rm=TRUE))

# faceted plot with respective scales!!
ggplot(data = longfig3, aes(x = year, y = value)) + geom_line() + facet_wrap(~nutrient, dir = "v", scales = "free_y")

# plotted with mean values, by year (building on previous plot)
ggplot(data = fig3_byyear, aes(x = year, y = mean)) + geom_line() + 
  facet_wrap(~nutrient, dir = "v", scales = "free_y") + 
  geom_line(aes(x = 1989), linetype = "dashed")

#....................Making the function.....................

moving_average <- function(focal_date, dates, conc, win_size_wks) {
  # Which dates are in the window?
  is_in_window <- (dates > focal_date - (win_size_wks / 2) * 7) &
    (dates < focal_date + (win_size_wks / 2) * 7)
  # Find the associated concentrations
  window_conc <- conc[is_in_window]
  # Calculate the mean
  result <- mean(window_conc)
  
  return(result)
}

moving_average(focal_date = lubridate::as_date("1989-05-16"),
               dates = figure3$sample_date, 
               conc = figure3$k, 
               win_size_wks = 9)

#using sapply()

figure3$calc_rolling <- sapply(
  figure3$sample_date,
  moving_average,
  dates = figure3$sample_date,
  conc = figure3$ca,
  win_size_wks = 9
)

#..............................Mess..............................

# the rest is still unclear playing around

for(i in 1:length(week)) {
  temp <- figure3$week[i]:figure3$week[i+8]}
  avg <- figure3 %>% 
    group_by(year) %>%
    filter(week[i]:week[i+8]) %>% 
    summarize(mean = mean(no3_n))
  moving_avg[i, 1] <- avg
}


<<<<<<< HEAD
first_draft <- ggplot(data = figure3, aes(x = year, no3_n)) + geom_line()
=======
myplot <- ggplot(data = figure3, aes(x = year, no3_n)) + geom_line()
>>>>>>> e8b9841b84addd5f1dc7b906af42cba59171e1c2


# what I can do: group by year, then reorder so weeks go up ordinally. then run my for loop
by_year <- figure3 %>% 
  group_by(year) %>% 


# faceted plot with respective scales!!
ggplot(data = longfig3, aes(x = year, y = value)) + 
  geom_line() + 
  facet_wrap(~nutrient, dir = "v", scales = "free_y")

# plotted with mean values, by year
ggplot(data = fig3_byyear, aes(x = year, y = mean)) + 
  geom_line() + 
  facet_wrap(~nutrient, dir = "v", scales = "free_y")
 
bin_col <- vector(mode = "numeric", length = length(figure3$week)-8)
 

for(i in 1:length(figure3$week)) {
  +   bin_num <- figure3$week[i]:figure3$week[i+8]
  +   bin_col[i] <- bin_num
  + }



#...................trying slider and failing!...................      

install.packages("slider")
library(slider)

mean1 <- function(x) {
  mean(x, na.rm = TRUE)
}

no3_n_df <- longfig3 %>% 
  filter(nutrient == "no3_n") %>% 
  arrange(sample_date) %>% 
  filter(year>1988, year<1996)
                      
slideattempt <- slide_index_dbl(.x = no3_n_df$value, .i = no3_n_df$sample_date, .f = mean1, .before = days(4), .after = days(4))


no3n_df_avg <- data.frame(no3_n_df, slideattempt) 

ggplot(data = no3n_df_avg, aes(x = year, y = slideattempt)) + geom_line()

library(lubridate)
longfig3 %>%
  mutate(date = ymd(sample_date)) %>%
  group_by(nutrient) %>%
  arrange(nutrient, date) %>% # slider unfortunately requires dates be sorted
  slide_index_dbl(longfig3$value, longfig3$date, mean(na.rm = TRUE), .before = days(-31), .after = days(31))


year1 <- longfig3 %>% 
  filter(year == 1989, sample_id == "MPR")

year1$week <- as.Date(year1$wee
