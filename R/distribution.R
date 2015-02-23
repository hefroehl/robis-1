get_distribution <- function(identifier, table="dist_sp_5deg", ...) {
  
  viewparams <- NULL
  viewparams[["where"]] <- paste0("scientific='", identifier, "'")
  viewparams[["table"]] <- table

  return(wfs_request("OBIS:dist_sp", viewparams=viewparams, ...))
  
}