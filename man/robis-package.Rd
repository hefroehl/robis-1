\name{robis}
\alias{robis}
\docType{package}
\title{R package for retrieving data from the OBIS Web Services}
\description{}
\details{}
\author{Pieter Provoost <pieterprovoost@gmail.com>}
\keyword{ OBIS }
\examples{
library(robis)

data <- get_occurrences("Abra alba", maxFeatures=1000)
map_occurrences(data)

data <- get_hexsummaries()
map_summaries(data, "shannon")
}
