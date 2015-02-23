get_distribution <- function(identifier, maxFeatures=NULL, table="dist_sp_5deg", propertyName=NULL) {
  url <- wfs_url()
  parms <- c(
    service="WFS",
    version="1.0.0",
    request="GetFeature",
    typeName="OBIS:dist_sp",
    outputFormat="csv",
    maxFeatures=maxFeatures
  )
  viewparams <- c(
    where=paste0("scientific='", identifier, "'"),
    table=table
  )
  return(obis_request(url, parms, viewparams, propertyName))
}