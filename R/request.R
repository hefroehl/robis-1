wfs_request <- function(typeName, version="1.0.0", request="GetFeature", outputFormat="csv", maxFeatures=100, bbox=c(-180, -90, 180, 90), propertyName=NULL, viewparams=NULL) {

  url <- wfs_url()
  
  params <- c(
    service="WFS",
    version=version,
    request=request,
    typeName=typeName,
    outputFormat=outputFormat,
    maxFeatures=maxFeatures
  )
  
  if (!is.null(propertyName)) {
    params[["propertyName"]] <- paste0(propertyName, collapse=",")
  }
  
  if (!is.null(viewparams)) {
    params[["viewparams"]] <- paste0(names(viewparams), ":", viewparams, collapse=";")
  }
  
  params[["bbox"]] <- paste(bbox, collapse=",")
 
  response <- GET(url, query=compact(as.list(params)))
  
  if (outputFormat == "csv") {
    csv <- content(response, as = "text")
    return(read.csv(text=csv))
  } else {
    return(NULL)
  }
  
}