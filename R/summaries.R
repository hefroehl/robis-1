get_summaries <- function(maxFeatures=NULL, table="map5deg_with_geom", propertyName=NULL) {
  url <- wfs_url()
  parms <- c(
    service="WFS",
    version="1.0.0",
    request="GetFeature",
    typeName="OBIS:summaries",
    outputFormat="csv",
    maxFeatures=maxFeatures
  )
  viewparams <- c(
    table=table
  )
  return(obis_request(url, parms, viewparams, propertyName))
}

get_hexsummaries <- function(maxFeatures=NULL, typeName="hexgrid4", propertyName=NULL) {
  url <- wfs_url()
  parms <- c(
    service="WFS",
    version="1.0.0",
    request="GetFeature",
    typeName=typeName,
    outputFormat="csv",
    maxFeatures=maxFeatures
  )
  return(obis_request(url, parms, propertyName=propertyName))
}