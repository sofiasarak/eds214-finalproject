##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                                                                            --
##--------- THIS SCRIPT CREATES ALL SEPARATE PLOTS, AND COMBINES THEM-----------
##                                                                            --
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ca_plot <- ggplot(data = bisley_calc_avg, aes(x = sample_date, y = ca_9wk_avg)) + 
  geom_line()
ggsave(here("outputs", "ca_plot.png"))

k_plot <- ggplot(data = bisley_calc_avg, aes(x = sample_date, y = k_9wk_avg)) + 
  geom_line()
ggsave(here("outputs", "k_plot.png"))

no3_n_plot <- ggplot(data = bisley_calc_avg, aes(x = sample_date, y = no3_n_9wk_avg)) + 
  geom_line()
ggsave(here("outputs", "no3_n_plot.png"))

mg_plot <- ggplot(data = bisley_calc_avg, aes(x = sample_date, y = mg_9wk_avg)) + 
  geom_line()
ggsave(here("outputs", "mg_plot.png"))

ca_plot <- ggplot(data = bisley_calc_avg, aes(x = sample_date, y = ca_9wk_avg)) + 
  geom_line()

#..............Combining to create patchwork figure..............

library(patchwork)

final <- (ca_plot/k_plot/no3_n_plot/mg_plot)

