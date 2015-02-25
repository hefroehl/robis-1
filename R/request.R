#' WFS request
#' 
#' Makes a WFS request to OBIS
#'
#' @param typeName feature type name
#' @param version service version
#' @param request operation name
#' @param outputFormat output format, only csv is supported
#' @param maxFeatures maximum number of features
#' @param bbox bounding box as \code{c(min_longitude, min_latitude, max_longitude, max_latitude)}
#' @param propertyName vector of attributes to be returned
#' @param viewparams viewparams
#' @param verbose verbose get request
#'
#' @return data frame
wfs_request <- function(typeName, version="1.0.0", request="GetFeature", outputFormat="csv", maxFeatures=100, bbox=c(-180, -90, 180, 90), propertyName=NULL, viewparams=NULL, verbose=FALSE) {

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
 
  if (verbose) {
    config <- verbose()
  } else {
    config <- list()
  }
  
  response <- GET(url, config, query=compact(as.list(params)))
  
  if (outputFormat == "csv") {
    csv <- content(response, as = "text")
    return(read.csv(text=csv))
  } else {
    return(NULL)
  }
  
}