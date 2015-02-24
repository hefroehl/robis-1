#' Summaries (c-squares)
#' 
#' Retrieves diversity summaries for c-squares
#' 
#' @param table table
#' @param maxFeatures maximum number of features
#' @param ... additional arguments for \code{\link{wfs_request}}
#' 
#' @return diversity summaries
get_summaries <- function(table="map5deg_with_geom", maxFeatures=NULL, ...) {
  
  viewparams <- NULL
  viewparams[["table"]] <- table
  
  return(wfs_request("OBIS:summaries", viewparams=viewparams, maxFeatures=maxFeatures, ...))
  
}

#' Summaries (hexagonal grid)
#' 
#' Retrieves diversity summaries for a hexagonal grid
#' 
#' @param typeName feature type name
#' @param maxFeatures maximum number of features
#' @param ... additional arguments for \code{\link{wfs_request}}
#' 
#' @return diversity summaries
get_hexsummaries <- function(typeName="hexgrid4", maxFeatures=NULL, ...) {

  return(wfs_request(typeName, maxFeatures=maxFeatures, ...))

}