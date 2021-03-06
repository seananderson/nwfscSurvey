% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/GetN.fn.R
\name{GetN.fn}
\alias{GetN.fn}
\title{Calculate effN input sample sizes
based on Stewart, I.J. and O.W Hamel 2014.
Bootstrapping of sample size for legth- or age-composition data used in stock assessment
Canadian Journal of Fishery and Aquatic Science, 71: 581-588.}
\usage{
GetN.fn(dir = NULL, dat, type, species = NULL, printfolder = "forSS",
  verbose = TRUE)
}
\arguments{
\item{dir}{directory}

\item{dat}{excel file name for the NWFSC or data object for the Triennial or AKSFC survey data}

\item{type}{specify whether doing "length" or "age". Used to read associatied excel sheets}

\item{species}{species specific value to determine the number of unique samples per tow (flatfish, shelfrock, sloperock, thorny, others, all)}

\item{printfolder}{name of the folder to create and save files. Location will be paste0(dir, printfolder)}

\item{verbose}{opt to print out message statements}
}
\description{
Calculate effN input sample sizes
based on Stewart, I.J. and O.W Hamel 2014.
Bootstrapping of sample size for legth- or age-composition data used in stock assessment
Canadian Journal of Fishery and Aquatic Science, 71: 581-588.
}
\author{
Chantel Wetzel
}
