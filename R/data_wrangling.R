##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                                                                            --
##- THIS R SCRIPT IMPORTS AND CLEANS DATA, AND THEN SAVES A SINGLE CSV FILE-----
##                                                                            --
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#................Combining dfs from 4 sites into 1...............

# using dplyr::read_csv() and here::here() to read in files from our data folder
# janitor::clean_names() is used to put all vairables name into lower snake case
prm <- read_csv(here("data", "RioMameyesPuenteRoto.csv")) %>% 
  clean_names()
bq1 <- read_csv(here("data", "QuebradaCuenca1-Bisley.csv")) %>% 
  clean_names()
bq2 <- read_csv(here("data", "QuebradaCuenca2-Bisley.csv")) %>% 
  clean_names()
bq3 <- read_csv(here("data", "QuebradaCuenca3-Bisley.csv")) %>% 
  clean_names()

# combining all four data sets, one at a time, using full_join() because we want to keep all observations from all sites!
bisley_streams <- full_join(prm, bq1)
bisley_streams <- full_join(bisley_streams, bq2)
bisley_streams <- full_join(bisley_streams, bq3)

# removing the four individual data sets from our global environment as we won't need them anymore
rm(bq1, bq2, bq3, prm)

#.....Removing unnecessary columns and adding a year column......

# using dplyr::select() to keep only the variables necessary for our analysis
bisley_streams <- bisley_streams %>% 
  select(sample_id, code, sample_date, k, no3_n, mg, ca, nh4_n)

# using lubirate::year() to create a year column, and then only keeping necessary years
bisley_streams <- bisley_streams %>% 
  mutate(year = year(as_date(sample_date))) %>% 
  relocate(year, .after= sample_date) %>% 
  filter(year>1988, year<1996)

# saving as a csv fils
write.csv(bisley_streams, "outputs/bisley_streams_clean.csv")

#..................Making subset to preview data.................

bisley_streams_head <- bisley_streams %>% 
  slice_head(n = 6) %>% 
  select(!"code")
