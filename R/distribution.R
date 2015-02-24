#' Distribution
#' 
#' Retrieves distribution data
#' 
#' @param identifier taxon name
#' @param table table, one of \code{dist_sp_5deg}, \code{dist_sp_1deg}, \code{dist_sp_05deg}, \code{dist_sp_01deg}
#' @param maxFeatures maximum number of features
#' @param ... additional arguments for \code{\link{wfs_request}}
#' 
#' @return distribution data
get_distribution <- function(identifier, table="dist_sp_5deg", maxFeatures=NULL, ...) {
  
  tables <- c("dist_sp_5deg", "dist_sp_1deg", "dist_sp_05deg", "dist_sp_01deg")
  
  if (! table %in% tables) {
    stop(paste0("Table must be one of ", paste(tables, collapse=", ")))
  }
  
  viewparams <- NULL
  viewparams[["where"]] <- paste0("scientific='", identifier, "'")
  viewparams[["table"]] <- table
  viewparams[["count_column"]] <- "nincl"

  return(wfs_request("OBIS:dist_sp", viewparams=viewparams, maxFeatures=maxFeatures, ...))
  
}