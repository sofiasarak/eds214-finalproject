
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                                                                            --
##-------- THIS SCRIPT ANALYZES THE MOVING AVERAGES FOR EACH NUTRIENT-----------
##                                                                            --
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Figure 3 calls for the use of moving averages. We source the function moving_average() from an .R file in our R folder, all of which we made beforehand.

# loading the function into our global environment
source(here("R", "moving_average.R"))

# creating a new df that will house only the moving averages

bisley_streams <- read_csv(here("outputs", "bisley_streams_clean.csv"))

bisley_calc_avg <- bisley_streams %>% 
  select(sample_date, year)

# our function is applied to the entire dataset using tidyverse::sapply()
# calculating moving average over 9 week interval for potassium (k)
bisley_calc_avg$k_9wk_avg <- sapply(
  bisley_streams$sample_date,
  moving_average,
  dates = bisley_streams$sample_date,
  value = bisley_streams$k,
  interval_wks = 9
)

# for no3_n
bisley_calc_avg$no3_n_9wk_avg <- sapply(
  bisley_streams$sample_date,
  moving_average,
  dates = bisley_streams$sample_date,
  value = bisley_streams$no3_n,
  interval_wks = 9
)

# for magnesium (mg)

bisley_calc_avg$mg_9wk_avg <- sapply(
  bisley_streams$sample_date,
  moving_average,
  dates = bisley_streams$sample_date,
  value = bisley_streams$mg,
  interval_wks = 9
)

# for calcium (ca)

bisley_calc_avg$ca_9wk_avg <- sapply(
  bisley_streams$sample_date,
  moving_average,
  dates = bisley_streams$sample_date,
  value = bisley_streams$ca,
  interval_wks = 9
)

# for nh4_n

bisley_calc_avg$nh4_n_9wk_avg <- sapply(
  bisley_streams$sample_date,
  moving_average,
  dates = bisley_streams$sample_date,
  value = bisley_streams$nh4_n,
  interval_wks = 9
)

conc_vec <- c("k", "no3_n", "mg", "ca", "nh4_n")

