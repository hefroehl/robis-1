% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/summaries.R
\name{get_summaries}
\alias{get_summaries}
\title{Summaries (c-squares)}
\usage{
get_summaries(table = "map5deg_with_geom", maxFeatures = NULL, ...)
}
\arguments{
\item{table}{table, one of one of \code{map5deg_with_geom}, \code{map1deg_with_geom}, \code{map05deg_with_geom}, \code{map01deg_with_geom}}

\item{maxFeatures}{maximum number of features}

\item{...}{additional arguments for \code{\link{wfs_request}}}
}
\value{
diversity summaries
}
\description{
Retrieves diversity summaries for c-squares
}

