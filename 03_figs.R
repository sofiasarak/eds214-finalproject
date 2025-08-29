##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                                                                            --
##--------- THIS SCRIPT CREATES ALL SEPARATE PLOTS, AND COMBINES THEM-----------
##                                                                            --
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#..........................quick set up..........................

# assigning "hurricane" its own value in order to plot it as a vertical line

hurricane <- as.numeric(1989)
library(scales)

# sourcing my ggplot theme

source(here("R", "ggplot_theme.R"))

#..............actually plotting for all nutrients...............

# creating a line plot with just the potassium values and saving

k_plot <- ggplot() + 
  geom_line(data = calc_k, 
            aes(x = sample_date, y = k_avg, linetype = sample_id)) +  
  labs(x = " ", y = "K mg l^-1", subtitle = "Year") + 
  theme_fig3() + 
  theme(plot.subtitle = element_text(hjust = 0.5)) +
  geom_vline(xintercept = 1989)

ggsave(here("outputs", "k_plot.png"))

# nitrate

no3_n_plot <- ggplot(data = calc_no3_n, 
                     aes(sample_date, y = no3_n_avg, linetype = sample_id)) +
  geom_line() +
  labs(x = " ", y = "NO3N µg l^-1") + 
  theme_fig3() +
  geom_vline(aes(xintercept = hurricane), linetype = "dashed", color = "black")

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

# load patchwork, a package that allows for combining figures together
library(patchwork)

#stack figures on top of each other in same order as Figure 3
final <- (k_plot/no3_n_plot/mg_plot/ca_plot/nh4_n_plot) + 
  plot_layout(guides = "collect", axes = "keep") +
  plot_annotation(title = "Stream nutrients concentrations in Bisley, Puerto Rico",
                  subtitle = "Before and after Hurrican Hugo (1989)")

ggsave(here("outputs", "final.png"))

