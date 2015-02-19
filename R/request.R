obis_request <- function(url, parms, vp=NULL) {
  if (!is.null(vp)) {
    parms <- c(parms, viewparams=paste0(names(vp), ":", vp, collapse=";"))
  }
  response <- GET(url, query=compact(as.list(parms)))
  csv <- content(response, as = "text")
  return(read.csv(text=csv))
}