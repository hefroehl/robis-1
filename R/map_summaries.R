#' Summary map
#' 
#' Creates a map from summary data
#' 
#' @param data data frame from \code{\link{get_summaries}} or \code{\link{get_hexsummaries}}
#' @param summary summary name to be used, either \code{simpson}, \code{shannon}, \code{es}, \code{s}, \code{chao2_unbiased_biota}, or \code{completeness_biota}
#' @param style list with breaks, labels, and colors vectors
map_summaries <- function(data, summary="shannon", style=NULL) {
  
  names <- c("simpson", "shannon", "es", "s", "chao2_unbiased_biota", "completeness_biota")
  
  if (! summary %in% names) {
    stop(paste0("Summary must be one of ", paste(names, collapse=", ")))
  }
  
  if (is.null(style)) {
    if (summary == "simpson") {
      style <- style_simpson()
    } else if (summary == "shannon") {
      style <- style_shannon()
    } else if (summary == "es") {
      style <- style_es()
    } else if (summary == "s") {
      style <- style_s()
    } else if (summary == "chao2_unbiased_biota") {
      style <- style_chao()
    } else if (summary == "completeness_biota") {
      style <- style_completeness()
    } else {
      style <- style_obis(data[summary])
    }
  }
  
  world <- map_data(map="world")
  
  polyg <- matrix(nrow=0, ncol=4)
  row <- 1
  for (i in 1:nrow(data)) {
    wkt <- readWKT(data$geom[i])
    fort <- fortify(wkt)
    d <- nrow(fort)
    group <- i
    summ <- data[summary][i, 1]
    if (nrow(polyg) < (row + d)) {
      n <- d * 1000
      polyg <- rbind(polyg, matrix(nrow=n, ncol=4))
    }
    last <- row + d - 1
    polyg[row:last,] <- cbind(fort[,1], fort[,2], group, summ)
    row <- last + 1
  }
  polyg <- polyg[!is.na(polyg[,1]),]
  
  polyg <- as.data.frame(polyg)
  names(polyg) <- c("long", "lat", "group", "summary")
  polyg$bin <- .bincode(polyg$summary, breaks=style$breaks)
  
  p <- ggplot() +
    geom_polygon(data=polyg, aes(x=long, y=lat, group=group, fill=as.factor(bin)), alpha=0.9) +
    scale_fill_manual(
      labels=style$labels, 
      values=style$colors) +
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
  
  return(p)
  
}