#' Occurrences
#' 
#' Retrieves occurrence data
#' 
#' @param identifiers vector of identifiers, these can be species names, AphiaIDs, OBIS Taxon IDs, or storedpaths
#' @param idColumn which column to use when the identifier is an id, one of \code{valid_aphia_id}, \code{valid_id}
#' @param filter list of filters
#' @param where explicit where clause
#' @param ... additional arguments for \code{\link{wfs_request}}
#' 
#' @return occurrence data 
get_occurrences <- function(identifiers, idColumn="valid_aphia_id", filter=NULL, where=NULL, ...) {
  
  column <- "tname"
  pathColumn <- "storedpath"
  pathIdColumn <- "valid_id"
  
  result <- NULL

  quote <- function(x) {
    if (is.character(x)) {
      paste0("'", x, "'")  
    } else {
      as.character(x)
    }
  }
  
  for (identifier in identifiers) {

    cond <- NULL
    
    sfilter <- filter
    sfilter <- sapply(sfilter, quote)

    if (grepl("(x[0-9]+)+$", identifier)) {
      
      path <- TRUE 
      m <- regexpr("[0-9]+$", identifier)
      id <- regmatches(identifier, m)
      cond <- c(cond, paste0(pathIdColumn, "=", id, " or ", pathColumn, " like '", identifier, "%'"))
            
    } else {
      
      path <- FALSE      
      if(!is.na(as.numeric(identifier))) {
        sfilter[[idColumn]] <- identifier  
      } else {
        sfilter[[column]] <- quote(identifier)
      }
      
    }
    
    for (name in names(sfilter)) {
      cond <- c(cond, paste0(name, "=", sfilter[[name]]))
    }

    viewparams <- NULL
    if (is.null(where)) {
      viewparams[["where"]] <- paste("(", cond, ")", sep="", collapse=" and ")
    } else {
      viewparams[["where"]] <- paste0(paste(cond, sep="", collapse=" and "), " and (", where, ")")
    }

    sresult <- wfs_request("OBIS:points_ex", viewparams=viewparams, ...)
    result <- rbind(result, sresult)
    
  }
  
  return(result)
  
}