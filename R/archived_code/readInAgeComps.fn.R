#' Reads in the stratum numbers from the Excel file provided by Beth (AgeComps Sheet)
#' headerRow is the row number of the column where the data start
#' it doesn't read in the column names correctly, so I put in simplified names. 
#' Make sure that these match what is in your Excel spreadsheet
#' 
#' @param file csv file
#' @param headerRow line of header row in excel file
#' @param sep seperator
#' @param colNames column names the overwrite the one in the csv file
#'
#' @author Allan Hicks 
#' @export 

readInAgeComps.fn <-function(file,headerRow=7,sep=",",colNames = c("SpeciesCode","Species","Year","Project","AreaName",
                            "MinStratumDepth","MaxStratumDepth","Length","Age","NumF","NumM","NumUnsexed","LengthedAgeTally",
                            "AgeTallyF","AgeTallyM","AgeTallyU")) {

    xx <- read.table(file,skip=headerRow-1,sep=sep,header=T)
    if(length(colNames) == ncol(xx)) {
        names(xx) <- colNames
        cat("NOTE: column names have been modified from the csv file. You may want to verify that they match.\n")
    }
    return(xx)
}
