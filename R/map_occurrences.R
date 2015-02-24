#' Occurrence map
#' 
#' Creates a map from occurrence data
#' 
#' @param data data frame from \code{\link{get_occurrences}}
#' @param color attribute to be used for color coding
map_occurrences <- function(data, color="tname") {
  
  world <- map_data(map="world")
  
  p <- ggplot(world, aes(long, lat)) +
    geom_polygon(aes(group=group), fill="gray90", color="gray90", size=0.2) +
    geom_point(data=data, aes_string("longitude", "latitude", color=color), alpha=0.4, size=3) +
    labs(x="", y="") +
    theme_bw(base_size=14) +
    theme(
      legend.position="bottom", 
      legend.key=element_blank(), 
      legend.title=element_blank(),
      axis.line=element_blank(),
      axis.text.x=element_blank(),
      axis.text.y=element_blank(),
      axis.ticks=element_blank(),
      axis.title.x=element_blank(),
      axis.title.y=element_blank(),
      panel.background=element_blank(),
      panel.border=element_blank(),
      panel.grid.major=element_blank(),
      panel.grid.minor=element_blank(),
      plot.background=element_blank()
    ) +
    guides(col = guide_legend(nrow=2)) +
    coord_fixed(ratio=1)
  
  print(p)

}