% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SurveyLFs.fn.R
\name{SurveyLFs.fn}
\alias{SurveyLFs.fn}
\title{Expands the lengths up to the total stratum area then sums over strata
Original Version Written by Allan Hicks 16 March 2009
Modified by Chantel Wetzel to work with the data warehouse data formatting,
add additional options of when to apply the sex ratio, and correct some treatment of unsexed fish
weighted by sample size and area}
\usage{
SurveyLFs.fn(dir = NULL, datL, datTows, strat.vars = c("Depth_m",
  "Latitude_dd"), strat.df = NULL, lgthBins = 1, SSout = TRUE,
  meanRatioMethod = TRUE, gender = 3, NAs2zero = T,
  sexRatioUnsexed = NA, maxSizeUnsexed = NA, sexRatioStage = 1,
  partition = 0, fleet = "Enter Fleet", agelow = "Enter",
  agehigh = "Enter", ageErr = "Enter", nSamps = "Enter Samps",
  month = "Enter Month", printfolder = "forSS", remove999 = TRUE,
  outputStage1 = FALSE, verbose = TRUE)
}
\arguments{
\item{dir}{directory this is where the output files will be saved}

\item{datL}{the read in length comps by the PullBio.fn function}

\item{datTows}{the read in catch data by the PullCatch.fn function}

\item{strat.vars}{the variables used define the stratas. Defaul is bottom depth and latitudes.}

\item{strat.df}{the created strata matrix with the calculated areas by the createStrataDF.fn function}

\item{lgthBins}{length bins}

\item{SSout}{TRUE/FALSE if True the output is in a format pastable into SS dat file}

\item{meanRatioMethod}{TRUE/FALSE}

\item{gender}{(0, 1, 2, 3) gender value for Stock Synthesis}

\item{NAs2zero}{TRUE/FALSE change NAs to zeros}

\item{sexRatioUnsexed}{sex ratio to apply to any length bins of a certain size or smaller as defined by the maxSizeUnsexed}

\item{maxSizeUnsexed}{all sizes below this threshold will assign unsexed fish by sexRatio set equal to 0.50, fish larger than this size will have unsexed fish assigned by the calculated sex ratio in the data.}

\item{sexRatioStage}{(1, 2) the stage of the expansion to apply the sex ratio. Input either 1 or 2.}

\item{partition}{partition for Stock Synthesis}

\item{fleet}{fleet number}

\item{agelow}{value for SS -1}

\item{agehigh}{value for SS -1}

\item{ageErr}{age error vector to apply}

\item{nSamps}{effective sample size for Stock Synthesis}

\item{month}{month the samples were collected}

\item{printfolder}{folder where the length comps will be saved}

\item{remove999}{the output object by the function will have the 999 column combined with the first length bin}

\item{outputStage1}{return the first stage expanded data without compiling it for SS}

\item{verbose}{opt to print out message statements}
}
\description{
Expands the lengths up to the total stratum area then sums over strata
Original Version Written by Allan Hicks 16 March 2009
Modified by Chantel Wetzel to work with the data warehouse data formatting,
add additional options of when to apply the sex ratio, and correct some treatment of unsexed fish
weighted by sample size and area
}
\seealso{
\code{\link{StrataFactors.fn}}

\code{\link{SexRatio.fn}}
}
\author{
Allan Hicks and Chantel Wetzel
}
