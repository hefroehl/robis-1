obis_request <- function(url, parms, viewparams=NULL, propertyName=NULL) {
  if (!is.null(viewparams)) {
    parms <- c(parms, viewparams=paste0(names(viewparams), ":", viewparams, collapse=";"))
  }
  if (!is.null(propertyName)) {
    parms <- c(parms, propertyName=paste0(propertyName, collapse=","))
  }
  response <- GET(url, query=compact(as.list(parms)))
  csv <- content(response, as = "text")
  return(read.csv(text=csv))
}