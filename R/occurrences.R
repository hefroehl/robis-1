get_occurrences <- function(species, maxFeatures=NULL) {
  result <- NULL
  url <- obis_url(service="WFS")
  parms <- c(
    service="WFS",
    version="1.0.0",
    request="GetFeature",
    typeName="OBIS:points_ex",
    outputFormat="csv"
  )
  if (!is.null(maxFeatures)) {
    parms <- c(parms, maxFeatures=as.character(maxFeatures))
  }
  
  for (name in species) {
    sparms <- c(parms, VIEWPARAMS=paste0("where:tname='", name, "'"))
    response <- GET(url, query=as.list(sparms))
    csv <- content(response, as = "text")
    result <- rbind(result, read.csv(text=csv))
  }
  return(result)
}