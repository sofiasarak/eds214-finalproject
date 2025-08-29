##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                                                                            --
##--------- THIS SCRIPT CREATES ALL SEPARATE PLOTS, AND COMBINES THEM-----------
##                                                                            --
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#..........................quick set up..........................

# assigning "hurricane" its own value in order to plot it as a vertical line

hurricane <- 1989

# sourcing my ggplot theme

source(here("R", "ggplot_theme.R"))

#..............actually plotting for all nutrients...............

# creating a line plot with just the potassium values and saving

k_plot <- ggplot(data = calc_k, 
                 aes(sample_date, y = k_avg, linetype = sample_id)) + 
  geom_line() +
  geom_vline(xintercept = hurricane, linetype = "dashed") +  
  labs(x = " ", y = "K mg l^-1", subtitle = "Year") + 
  theme_fig3() + 
  theme(plot.subtitle = element_text(hjust = 0.5))

ggsave(here("outputs", "k_plot.png"))

# nitrate

no3_n_plot <- ggplot(data = calc_no3_n, 
                     aes(sample_date, y = no3_n_avg, linetype = sample_id)) +
  geom_line() +
  labs(x = " ", y = "NO3N µg l^-1") + 
  theme_fig3()

ggsave(here("outputs", "no3_n_plot.png"))

# magnesium

mg_plot <- ggplot(data = calc_mg, 
                  aes(x = sample_date, y = mg_avg, linetype = sample_id)) + 
  geom_line() +
  labs(x = " ", y = "Mg mg l^-1") + 
  theme_fig3()

ggsave(here("outputs", "mg_plot.png")) 

# calcium

ca_plot <- ggplot(data = calc_ca, 
                  aes(x = sample_date, y = ca_avg, linetype = sample_id)) + geom_line() +
  labs(x = " ", y = "Ca mg l^-1") +
  theme_fig3()

ggsave(here("outputs", "ca_plot.png"))

#ammonium

nh4_n_plot <- ggplot(data = calc_nh4_n, 
                     aes(x = sample_date, y = nh4_n_avg, linetype = sample_id)) + 
  geom_line() +
  labs(x = "Year", y = "NH4-N µg l^-1") +
  theme_fig3_last()

ggsave(here("outputs", "no3_n_plot.png"))

#..............Combining to create patchwork figure..............

library(patchwork)

final <- (k_plot/no3_n_plot/mg_plot/ca_plot/nh4_n_plot) + plot_layout(guides = "collect", axes = "keep") 

ggsave(here("outputs", "final.png"))

