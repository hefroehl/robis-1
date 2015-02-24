#' Distribution map
#' 
#' Creates a map from distribution data
#' 
#' @param data data frame from \code{\link{get_distribution}}
map_distribution <- function(data) {

  world <- map_data(map="world")
  
  polyg <- NULL
  for (i in 1:nrow(data)) {
    wkt <- readWKT(data$geom[i])
    df <- fortify(wkt)
    df$group <- i
    df$num_records <- data$num_records[i]
    polyg <- rbind(polyg, df)
  }
  
  polyg$bin <- .bincode(polyg$num_records, breaks=c(0, 5, 10, 50, 100, 1e12))
  
  p <- ggplot() +
    geom_polygon(data=polyg, aes(x=long, y=lat, group=group, fill=as.factor(bin)), alpha=0.9) +
    scale_fill_manual(
      labels=c("1-5", "6-10", "11-50", "51-100", ">100"), 
      values=c("#56B4E9", "green", "yellow", "orange", "red")) +
    geom_polygon(data = world, aes(long, lat, group=group), fill="gray90", color="gray90", size=0.2) +
    labs(x="", y="") +
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
    coord_fixed(ratio=1)
  
  print(p)
  
}