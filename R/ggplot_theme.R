theme_fig3 <- function(){
  theme_minimal() +
    theme(axis.text.x = element_blank(), 
          panel.grid.major = element_blank(),
          legend.title = element_blank(),
          axis.title.y = element_text(size = 9),
          axis.text.y = element_text(size = 5),
    )
}

theme_fig3_last <- function(){
  theme_minimal() +
    theme(panel.grid.major = element_blank(),
          legend.title = element_blank(),
          axis.title.y = element_text(size = 9),
          axis.text.y = element_text(size = 5),
    )
}