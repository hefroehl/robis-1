obis_url <- function(service) {
  if (service =="WFS") {
    return("http://www.iobis.org/geoserver/OBIS/ows")
  } else if (service == "WMS") {
    return("http://www.iobis.org/geoserver/wms")
  }
}

aphia_url <- function() {
  return("http://www.marinespecies.org/aphia.php?p=soap")
}