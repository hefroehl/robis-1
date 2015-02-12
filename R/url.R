obis_url <- function(service) {
  if (service =="WFS") {
    return("http://www.iobis.org/geoserver/OBIS/ows")
  } else if (service == "WMS") {
    return("")
  } else {
    return(NULL)
  }
}