#' WMS URL
#' 
#' Returns the OBIS WMS URL
wms_url <- function() {
  return("http://www.iobis.org/geoserver/wms")
}

#' WFS URL
#' 
#' Returns the OBIS WFS URL
wfs_url <- function() {
  return("http://www.iobis.org/geoserver/OBIS/ows")
}

#' AphiaID URL
#' 
#' Returns the WoRMS AphiaID service URL
aphia_url <- function() {
  return("http://www.marinespecies.org/aphia.php?p=soap")
}