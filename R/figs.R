##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                                                                            --
##--------- THIS SCRIPT CREATES ALL SEPARATE PLOTS, AND COMBINES THEM-----------
##                                                                            --
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ca_plot <- ggplot(data = bisley_streams, aes(x = sample_date, y = ca_9wk_avg)) + 
  geom_line() 
geom_line(aes(x = as.integer(1989)))
ca_plot