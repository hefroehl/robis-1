get_occurrences <- function(identifiers, maxFeatures=100, type="species", filter=NULL, where=NULL, propertyName=NULL, bbox=c(-180, -90, 180, 90)) {
  result <- NULL
  url <- wfs_url()
  parms <- c(
    service="WFS",
    version="1.0.0",
    request="GetFeature",
    typeName="OBIS:points_ex",
    outputFormat="csv",
    bbox=paste(bbox, collapse=","),
    maxFeatures=maxFeatures
  )

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

    if (is.null(where)) {
      viewparams <- c(
        where=paste(cond, collapse=" and ")
      )
    } else {
      viewparams <- c(
        where=paste0(paste(cond, collapse=" and "), " and (", where, ")")
      )
    }

    sresult <- obis_request(url, parms, viewparams, propertyName)
    result <- rbind(result, sresult)
  }
  return(result)
}