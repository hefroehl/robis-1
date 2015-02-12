get_occurrences <- function(identifiers, maxFeatures=NULL, type="species") {
  result <- NULL
  url <- obis_url(service="WFS")
  parms <- c(
    service="WFS",
    version="1.0.0",
    request="GetFeature",
    typeName="OBIS:points_ex",
    outputFormat="csv",
    maxFeatures=maxFeatures
  )

  if (type == "species") {
    quote <- function(x) paste0("'", x, "'")
    identifiers <- sapply(identifiers, quote)
    cond <- "where:tname="
  } else if (type == "aphiaid") {
    cond <- "where:valid_aphia_id="
  }
  
  for (identifier in identifiers) {
    sparms <- c(parms, viewparams=paste0(cond, identifier))
    response <- GET(url, query=compact(as.list(sparms)))
    csv <- content(response, as = "text")
    result <- rbind(result, read.csv(text=csv))
  }
  return(result)
}