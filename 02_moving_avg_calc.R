
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                                                                            --
##-------- THIS SCRIPT ANALYZES THE MOVING AVERAGES FOR EACH NUTRIENT-----------
##                                                                            --
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Figure 3 calls for the use of moving averages. We source the function moving_average() from an .R file in our R folder, all of which we made beforehand.

# loading the function into our global environment
source(here("R", "moving_average_function.R"))

# calling in bisley_streams

bisley_streams <- read_csv(here("outputs", "bisley_streams_clean.csv")) 


#...................Calculating moving average...................


# our function is applied to the entire dataset using sapply, and we apply it to each nutrient, one by one
# each separate dataframe is saved as its own csv file in outputs

# calculating moving average over 9 week interval for potassium (k)
calc_k <- bisley_streams %>% 
  group_by(sample_id) %>% 
  mutate(k_avg = sapply(sample_date, 
                        moving_average, 
                        dates = sample_date, 
                        value = k, 
                        interval_wks = 9))

write.csv(calc_k, "outputs/calc_k.csv")

# for nitrate (no3_n)
calc_no3_n <- bisley_streams %>% 
  group_by(sample_id) %>% 
  mutate(no3_n_avg = sapply(sample_date, 
                        moving_average, 
                        dates = sample_date, 
                        value = no3_n, 
                        interval_wks = 9))

write.csv(calc_no3_n, "outputs/calc_no3_n.csv")

# for magnesium (mg)

calc_mg <- bisley_streams %>% 
  group_by(sample_id) %>% 
  mutate(mg_avg = sapply(sample_date, 
                            moving_average, 
                            dates = sample_date, 
                            value = mg, 
                            interval_wks = 9))

write.csv(calc_mg, "outputs/calc_mg.csv")

# for calcium (ca)

calc_ca <- bisley_streams %>% 
  group_by(sample_id) %>% 
  mutate(ca_avg = sapply(sample_date, 
                            moving_average, 
                            dates = sample_date, 
                            value = ca, 
                            interval_wks = 9))

write.csv(calc_ca, "outputs/calc_ca.csv")

# for ammonium (nh4_n)

calc_nh4_n <- bisley_streams %>% 
  group_by(sample_id) %>% 
  mutate(nh4_n_avg = sapply(sample_date, 
                            moving_average, 
                            dates = sample_date, 
                            value = nh4_n, 
                            interval_wks = 9))

write.csv(calc_nh4_n, "outputs/calc_nh4_n.csv")

