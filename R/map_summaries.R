#' Summary map
#' 
#' Creates a map from summary data
#' 
#' @param data data frame from \code{\link{get_summaries}} or \code{\link{get_hexsummaries}}
#' @param summary summary name to be used, either \code{simpson} or \code{shannon}
#' @param breaks breaks vector
#' @param colors colors vector
#' @param labels labels vector
map_summaries <- function(data, summary="shannon", breaks=NULL, colors=NULL, labels=NULL) {

  names <- c("simpson", "shannon", "s", "es")
  
  if (! summary %in% names) {
    stop(paste0("Summary must be one of ", paste(names, collapse=", ")))
  }
  
  if (summary == "simpson") {
    if (is.null(breaks)) breaks <- c(0, 0.11, 0.23, 0.35, 0.48, 0.61, 0.76, 1.00)
    if (is.null(labels)) labels <- c("0.00-0.11", ">0.11-0.23", ">0.23-0.35", ">0.35-0.48", ">0.48-0.61", ">0.61-0.76", ">0.76-1.00")
    if (is.null(colors)) colors <- c("blue", "purple", "#56B4E9", "green", "yellow", "orange", "red")
  } else if (summary == "shannon") {
    if (is.null(breaks)) breaks <- c(0, 1, 2.1, 3.2, 4.3, 5.4, 6.5, 8.3)
    if (is.null(labels)) labels <- c("0.0-1.0", ">1.0-2.1", ">2.1-3.2", ">3.2-4.3", ">4.3-5.4", ">5.4-6.5", ">6.5-8.3")
    if (is.null(colors)) colors <- c("blue", "purple", "#56B4E9", "green", "yellow", "orange", "red")
  } else if (summary == "s") {
    if (is.null(breaks)) breaks <- c(0, 1000, 2000, 4000, 6000, 8000, 10000, 12000)
    if (is.null(labels)) labels <- c("0-1000", ">1000-2000", ">2000-4000", ">4000-6000", ">6000-8000", ">8000-10000", ">10000-12000")
    if (is.null(colors)) colors <- c("blue", "purple", "#56B4E9", "green", "yellow", "orange", "red")
  } else if (summary == "es") {
    if (is.null(breaks)) breaks <- c(0, 27, 38, 42, 44, 46, 48, 50)
    if (is.null(labels)) labels <- c("0-27", ">27-38", ">38-42", ">42-44", ">44-46", ">46-48", ">48-50")
    if (is.null(colors)) colors <- c("blue", "purple", "#56B4E9", "green", "yellow", "orange", "red")
  }
  
  world <- map_data(map="world")
  
  polyg <- NULL
  for (i in 1:nrow(data)) {
    wkt <- readWKT(data$geom[i])
    df <- fortify(wkt)
    df$group <- i
    df[summary] <- data[summary][i,1]
    polyg <- rbind(polyg, df)
  }
  
  polyg$bin <- .bincode(polyg[summary][,1], breaks=breaks)
  
  p <- ggplot() +
    geom_polygon(data=polyg, aes(x=long, y=lat, group=group, fill=as.factor(bin)), alpha=0.9) +
    scale_fill_manual(
      labels=labels, 
      values=colors) +
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
  return(p)
  
}