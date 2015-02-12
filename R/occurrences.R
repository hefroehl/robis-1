get_occurrences <- function(species, maxFeatures=NULL) {
  result <- NULL
  url <- paste0(obis_url(service="WFS"), "&request=GetFeature&typeName=OBIS:points_ex&outputFormat=csv")
  if (!is.null(maxFeatures)) {
    url <- paste0(url, "&maxFeatures=", maxFeatures)
  }
  for (name in species) {
    u <- paste0(url, "&VIEWPARAMS=where:tname='", name, "'")                  
    csv <- getURL(URLencode(u))
    result <- rbind(result, read.csv(text=csv))
  }
  return(result)
}