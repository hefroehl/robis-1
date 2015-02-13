get_distribution <- function(identifier, maxFeatures=NULL, table="dist_sp_5deg") {
  url <- obis_url(service="WFS")
  parms <- c(
    service="WFS",
    version="1.0.0",
    request="GetFeature",
    typeName="OBIS:dist_sp",
    outputFormat="csv",
    maxFeatures=maxFeatures
  )
  
  vp <- paste0("where:scientific='", identifier, "';table:", table, ";")
  sparms <- c(parms, viewparams=vp)
  response <- GET(url, query=compact(as.list(sparms)))
  csv <- content(response, as = "text")
  
  return(read.csv(text=csv))
}