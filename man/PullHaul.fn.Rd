% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/PullHaul.fn.R
\name{PullHaul.fn}
\alias{PullHaul.fn}
\title{Pull haul data from the NWFSC data warehouse
The website is: https://www.nwfsc.noaa.gov/data
This function can be used to pull haul data and associated covariates}
\usage{
PullHaul.fn(YearRange = c(1000, 5000), SurveyName = NULL,
  SaveFile = FALSE, Dir = NULL, verbose = TRUE)
}
\arguments{
\item{YearRange}{range of years to pull data. Defaults to all years, 1977 - present.}

\item{SurveyName}{survey to pull the data for the options are: Triennial, AFSC.Slope, NWFSC.Combo, NWFSC.Slope, NWFSC.Shelf, NWFSC.Hypoxia, NWFSC.Santa.Barb.Basin, NWFSC.Shelf.Rockfish, NWFSC.Video. If NULL, all are used.}

\item{SaveFile}{option to save the file to the directory}

\item{Dir}{directory where the file should be saved}

\item{verbose}{opt to print out message statements}
}
\value{
Returns a data frame of haul characteristics for satisfactory hauls
}
\description{
Pull haul data from the NWFSC data warehouse
The website is: https://www.nwfsc.noaa.gov/data
This function can be used to pull haul data and associated covariates
}
\examples{
\dontrun{
haul_dat = PullHaul.fn(SurveyName = "NWFSC.Combo", YearRange=c(2003,2007))
haul_dat = PullHaul.fn()
}
}
\author{
Eric Ward
}
