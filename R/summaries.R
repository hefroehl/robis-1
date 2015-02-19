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
  vp <- c(
    table=table
  )
  return(obis_request(url, parms, vp))
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
  return(obis_request(url, parms))
}