#' Distribution
#' 
#' Retrieves distribution data
#' 
#' @param identifier species name
#' @param table table
#' @param maxFeatures maximum number of features
#' @param ... additional arguments for \code{\link{wfs_request}}
#' 
#' @return distribution data
get_distribution <- function(identifier, table="dist_sp_5deg", maxFeatures=NULL, ...) {
  
  viewparams <- NULL
  viewparams[["where"]] <- paste0("scientific='", identifier, "'")
  viewparams[["table"]] <- table

  return(wfs_request("OBIS:dist_sp", viewparams=viewparams, maxFeatures=maxFeatures, ...))
  
}