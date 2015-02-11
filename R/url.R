obis_url <- function(service) {
  if (service =="WFS") {
    return("http://www.iobis.org/geoserver/OBIS/ows?service=WFS&version=1.0.0")
  } else if (service == "WMS") {
    return("")
  } else {
    return(NULL)
  }
}