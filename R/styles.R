obispalette <- function() {
  return(c("blue", "purple", "#56B4E9", "green", "yellow", "orange", "red"))
}

breaklabels <- function(breaks) {
  return(paste(paste(c("", rep(">", length(breaks)-2)), breaks[1:(length(breaks)-1)], sep=""), breaks[2:length(breaks)], sep="-"))
}

style_simpson <- function() {
  breaks <- c(0, 0.11, 0.23, 0.35, 0.48, 0.61, 0.76, 1.00)
  labels <- breaklabels(breaks)
  colors <- obispalette()
  return(list(breaks=breaks, labels=labels, colors=colors))
}

style_shannon <- function() {
  breaks <- c(0, 1, 2.1, 3.2, 4.3, 5.4, 6.5, 8.3)
  labels <- breaklabels(breaks)
  colors <- obispalette()
  return(list(breaks=breaks, labels=labels, colors=colors))
}

style_es <- function() {
  breaks <- c(0, 27, 38, 42, 44, 46, 48, 50)
  labels <- breaklabels(breaks)
  colors <- obispalette()
  return(list(breaks=breaks, labels=labels, colors=colors))
}

style_obis <- function(x) {
  ra <- range(x, na.rm=TRUE)
  breaks <- seq(ra[1], ra[2], length.out=length(obispalette()) + 1)
  labels <- breaklabels(signif(breaks, digits=3))
  colors <- obispalette()
  return(list(breaks=breaks, labels=labels, colors=colors))
}

style_jet <- function(breaks) {
  jet.colors <- colorRampPalette(c("#00007F", "blue", "#007FFF", "cyan", "#7FFF7F", "yellow", "#FF7F00", "red", "#7F0000"))
  labels <- breaklabels(breaks)
  colors <- jet.colors(length(breaks)-1)
  return(list(breaks=breaks, labels=labels, colors=colors))
}