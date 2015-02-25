#' Occurrences
#' 
#' Retrieves occurrence data
#' 
#' @param identifiers vector of identifiers, these can be species names, AphiaIDs, OBIS Taxon IDs, or storedpaths
#' @param id which id to use when the identifier is an id, one of \code{aphia}, \code{obis}
#' @param filter list of filters
#' @param where explicit where clause
#' @param ... additional arguments for \code{\link{wfs_request}}
#' 
#' @return occurrence data 
get_occurrences <- function(identifiers, id="aphia", filter=NULL, where=NULL, ...) {
  
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

    if (grepl("(x[0-9]+)+x$", identifier)) {
      
      m <- regexpr("[0-9]+x$", identifier)
      id <- regmatches(identifier, m)
      id <- substr(id, 1, nchar(id) - 1)
      cond <- c(cond, paste0("valid_id=", id, " or storedpath like '", identifier, "%'"))
            
    } else {
      
      if(!is.na(as.numeric(identifier))) {
        if (id == "aphia") {
          sfilter[["valid_aphia_id"]] <- identifier    
        } else if (id =="obis") {
          sfilter[["valid_id"]] <- identifier    
        }
      } else {
        sfilter[["tname"]] <- quote(identifier)
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