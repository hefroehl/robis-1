\name{robis}
\alias{robis}
\docType{package}
\title{R package for retrieving data from the OBIS Web Services}
\description{}
\details{
\code{\link{get_aphiaid}} \cr
\code{\link{get_occurrences}} \cr
\code{\link{get_distribution}} \cr
\code{\link{get_summaries}} \cr
\code{\link{get_hexsummaries}} \cr
\code{\link{map_occurrences}} \cr
\code{\link{map_distribution}} \cr
\code{\link{map_summaries}} \cr
\code{\link{request}} \cr
\code{\link{aphia_url}} \cr
\code{\link{wfs_url}}
}
\author{Pieter Provoost <pieterprovoost@gmail.com>}
\keyword{ OBIS }
\examples{
library(robis)

data <- get_occurrences("Abra alba", maxFeatures=1000)
map_occurrences(data)

data <- get_hexsummaries()
map_summaries(data, "shannon")
}