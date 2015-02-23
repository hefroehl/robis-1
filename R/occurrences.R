get_occurrences <- function(identifiers, filter=NULL, where=NULL, ...) {
  
  result <- NULL

  quote <- function(x) {
    if (is.character(x)) {
      paste0("'", x, "'")  
    } else {
      as.character(x)
    }
  }
  
  for (identifier in identifiers) {
    
    sfilter <- filter
    sfilter <- sapply(sfilter, quote)
    
    if(!is.na(as.numeric(identifier))) {
      sfilter[["valid_aphia_id"]] <- identifier  
    } else {
      sfilter[["tname"]] <- quote(identifier)
    }
    
    cond <- NULL
    for (name in names(sfilter)) {
      cond <- c(cond, paste0(name, "=", sfilter[[name]]))
    }

    viewparams <- NULL
    if (is.null(where)) {
      viewparams[["where"]] <- paste(cond, collapse=" and ")
    } else {
      viewparams[["where"]] <- paste0(paste(cond, collapse=" and "), " and (", where, ")")
    }

    sresult <- wfs_request("OBIS:points_ex", viewparams=viewparams, ...)
    result <- rbind(result, sresult)
    
  }
  
  return(result)
  
}