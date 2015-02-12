get_occurrences <- function(identifiers, maxFeatures=NULL, type="species", filter=NULL, where=NULL, bbox=c(-180, -90, 180, 90)) {
  result <- NULL
  url <- obis_url(service="WFS")
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
    
    sfilter <- sapply(filter, quote)
    sfilter[[elname]] <- identifier
    
    cond <- NULL
    for (name in names(sfilter)) {
      cond <- c(cond, paste0(name, "=", sfilter[[name]]))
    }

    if (is.null(where)) {
      vp <- paste0("where:", paste(cond, collapse=" and "))
    } else {
      vp <- paste0("where:", paste(cond, collapse=" and "), " and (", where, ")")
    }
    
    sparms <- c(parms, viewparams=vp)
    response <- GET(url, query=compact(as.list(sparms)))
    csv <- content(response, as = "text")
    result <- rbind(result, read.csv(text=csv))
  }
  return(result)
}