#' Epands the lengths up to the total stratum area then sums over strata
#' Written by Allan Hicks 16 March 2009
#' modified to incorporate unsexed fish using sex ratios in May 2011
#' weighted by sample size and area
#' datA should have a column called "year" indicating year
#' femaleMale is a vector of codes for female then male (in that order)
#' lgthBin is the increment of each length bin or a vector of the actual bins
#' NOTE: The length bin called F0 or M0 is retained to show proportion of lengths smaller than smallest bin
#' You will want to likely add this to your first length bin and delete this before putting in SS, or
#' start the lgthBins argument at the 2nd length bin and F0 will be all fish smaller (hence the first length bin)
#' SSout: if True the output is in a format pastable into SS dat file
#' 
#' @param dir directory this is where the output files will be saved
#' @param datA the read in age data by the ReadInAges.EWC.fn function
#' @param datTows the read in catch data by the DesignBasedEstBiomass.EWC.fn function
#' @param strat.vars the variables used define the stratas. Defaul is bottom depth and latitudes.
#' @param strat.df the created strata matrix with the calculated areas by the createStrataDF.fn function
#' @param femaleMale numbering for female and male fish in the data file. This is opposite to what is used in SS.
#' @param lageBins length bins
#' @param SSout if True the output is in a format pastable into SS dat file
#' @param meanRatioMethod TRUE/FALSE
#' @param gender gender value for Stock Synthesis
#' @param NAs2zero change NAs to zeros
#' @param sexRatioUnsexed sex ratio to apply to any length bins of a certain size or smaller as defined by the maxSizeUnsexed
#' @param maxSizeUnsexed all sizes below this threshold will assign unsexed fish by sexRatio set equal to 0.50, fish larger than this size will have unsexed fish assigned by the calculated sex ratio in the data.
#' @param partition partition for Stock Synthesis
#' @param fleet fleet number
#' @param agelow value for SS -1
#' @param agehigh value for SS -1
#' @param ageErr age error vector to apply
#' @param nSamps effective sample size for Stock Synthesis
#' @param month month when the samples were collected
#' @param printfolder folder where the length comps will be saved
#'
#' @author Allan Hicks and Chantel Wetzel
#' @export 
#' @seealso \code{\link{SurveyLFs.EWC.fn}}

SurveyAFs.EWC.fn <- function(dir, datA, datTows, strat.vars=c("BOTTOM_DEPTH","START_LATITUDE"), strat.df=NULL, femaleMale=c(2,1), ageBins=1, SSout=FALSE, meanRatioMethod=TRUE,
                             gender=3, NAs2zero=T, sexRatioUnsexed=NA, maxSizeUnsexed=NA, partition=0, fleet="Enter Fleet", agelow = "Enter", agehigh = "Enter", ageErr = "Enter",
                             nSamps="Enter Samps", month="Enter Month", printfolder = "forSS")  {

    # Overwrite inputs to use the same code for lengths as ages
    datL = datA
    lgthBins = ageBins  
    datL$LENGTH = datA$AGE
    datL$Length_cm = datA$AGE

    out = SurveyLFs.EWC.fn(dir = dir, datL = datL, datTows = datTows, strat.vars = strat.vars, strat.df = strat.df, 
                           femaleMale = femaleMale, lgthBins = lgthBins, SSout = SSout, meanRatioMethod = meanRatioMethod,
                           gender = gender, NAs2zero= NAs2zero,  sexRatioUnsexed = sexRatioUnsexed, maxSizeUnsexed = maxSizeUnsexed, 
                           partition = partition,  fleet = fleet, nSamps = nSamps, 
                           month = month, printfolder = printfolder, remove999 = TRUE)


    Ages.out = cbind(out[,1:5],
                 agelow,
                 agehigh,
                 ageErr,
                 out[,6:dim(out)[2]])

    # save output as a csv
    comp.type ="Age"
    plotdir <- file.path(dir, printfolder)
    plotdir.isdir <- file.info(plotdir)$isdir
    if(is.na(plotdir.isdir) | !plotdir.isdir){
      dir.create(plotdir)
    }

    fn = paste0(plotdir, "/Survey_Gender", gender, "_Bins_-999_", max(lgthBins),"_", comp.type, "Comps.csv")
    if (file.exists(fn)) {file.remove(fn)}

    write.csv(Ages.out, file = paste0(plotdir, "/Survey_Gender", gender, "_Bins_",min(lgthBins),"_", max(lgthBins),"_", comp.type, "Comps.csv"), row.names = FALSE)

    return(Ages.out)
}
