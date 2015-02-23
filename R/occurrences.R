get_occurrences <- function(identifiers, type="species", filter=NULL, where=NULL, ...) {
  
  result <- NULL

  if (type == "species") {
    quote <- function(x) paste0("'", x, "'")
    identifiers <- sapply(identifiers, quote)
    elname <- "tname"
  } else if (type == "aphiaid") {
    elname <- "valid_aphia_id"
  }
  
  for (identifier in identifiers) {
    
    quote <- function(x) {
      if (is.character(x)) {
        paste0("'", x, "'")  
      } else {
        as.character(x)
      }
    }
    
    sfilter <- filter
    sfilter <- sapply(sfilter, quote)
    sfilter[[elname]] <- identifier
    
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