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
  vp <- c(
    where=paste0("scientific='", identifier, "'"),
    table=table
  )
  return(obis_request(url, parms, vp))
}