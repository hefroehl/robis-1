get_summaries <- function(maxFeatures=NULL, table="map5deg_with_geom") {
  url <- obis_url(service="WFS")
  parms <- c(
    service="WFS",
    version="1.0.0",
    request="GetFeature",
    typeName="OBIS:summaries",
    outputFormat="csv",
    maxFeatures=maxFeatures
  )
  
  vp <- paste0("table:", table, ";")
  sparms <- c(parms, viewparams=vp)
  response <- GET(url, query=compact(as.list(sparms)))
  csv <- content(response, as = "text")
  
  return(read.csv(text=csv))
}

get_hexsummaries <- function(typeName="hexgrid4", maxFeatures=NULL) {
  url <- obis_url(service="WFS")
  parms <- c(
    service="WFS",
    version="1.0.0",
    request="GetFeature",
    typeName=typeName,
    outputFormat="csv",
    maxFeatures=maxFeatures
  )
  
  response <- GET(url, query=compact(as.list(parms)))
  csv <- content(response, as = "text")
  
  return(read.csv(text=csv))
}