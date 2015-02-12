get_aphiaid <- function(name) {
 
  s <- "<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:aph=\"http://aphia/v1.0/AphiaID\"><soapenv:Header/><soapenv:Body><aph:getAphiaID soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><scientificname xsi:type=\"xsd:string\">?</scientificname><marine_only xsi:type=\"xsd:boolean\">false</marine_only></aph:getAphiaID></soapenv:Body></soapenv:Envelope>"
  
  xml <- xmlParse(s)
  node <- xpathApply(xml, "//scientificname")[[1]]
  xmlValue(node) <- name

  headers <- c(
    "SOAPAction" = "getAphiaID",
    "Accept-Encoding" = "gzip,deflate",
    "Content-Type" = "text/xml;charset=UTF-8"
  )
  
  r <- POST(aphia_url(), body=saveXML(xml), add_headers(headers))
  rxml <- content(r)
  
  id <- xmlValue(xpathApply(rxml, "//return")[[1]])
  
  if (id  == "") {
    return(NULL)
  } else {
    return(id)
  }
  
}