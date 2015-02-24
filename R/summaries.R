#' Summaries (c-squares)
#' 
#' Retrieves diversity summaries for c-squares
#' 
#' @param table table, one of one of \code{map5deg_with_geom}, \code{map1deg_with_geom}, \code{map05deg_with_geom}, \code{map01deg_with_geom}
#' @param maxFeatures maximum number of features
#' @param ... additional arguments for \code{\link{wfs_request}}
#' 
#' @return diversity summaries
get_summaries <- function(table="map5deg_with_geom", maxFeatures=NULL, ...) {
  
  tables <- c("map5deg_with_geom", "map1deg_with_geom", "map05deg_with_geom", "map01deg_with_geom")
  
  if (! table %in% tables) {
    stop(paste0("Table must be one of ", paste(tables, collapse=", ")))
  }
  
  viewparams <- NULL
  viewparams[["table"]] <- table
  
  return(wfs_request("OBIS:summaries", viewparams=viewparams, maxFeatures=maxFeatures, ...))
  
}

#' Summaries (hexagonal grid)
#' 
#' Retrieves diversity summaries for a hexagonal grid
#' 
#' @param typeName feature type name, one of \code{hexgrid1}, \code{hexgrid2}, \code{hexgrid3}, \code{hexgrid4}, \code{hexgrid5}, \code{hexgrid6}
#' @param maxFeatures maximum number of features
#' @param ... additional arguments for \code{\link{wfs_request}}
#' 
#' @return diversity summaries
get_hexsummaries <- function(typeName="hexgrid4", maxFeatures=NULL, ...) {

  names <- c("hexgrid1", "hexgrid2", "hexgrid3", "hexgrid4", "hexgrid5", "hexgrid6")
  
  if (! typeName %in% names) {
    stop(paste0("typeName must be one of ", paste(names, collapse=", ")))
  }
  
  return(wfs_request(typeName, maxFeatures=maxFeatures, ...))

}