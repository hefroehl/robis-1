get_summaries <- function(table="map5deg_with_geom", maxFeatures=NULL, ...) {
  
  viewparams <- NULL
  viewparams[["table"]] <- table
  
  return(wfs_request("OBIS:summaries", viewparams=viewparams, maxFeatures=maxFeatures, ...))
  
}

get_hexsummaries <- function(typeName="hexgrid4", maxFeatures=NULL, ...) {

  return(wfs_request(typeName, maxFeatures=maxFeatures, ...))

}