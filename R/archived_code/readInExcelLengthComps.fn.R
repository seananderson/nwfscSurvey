#' Reads in the stratum numbers from the Excel file provided by Beth (LengthComps Sheet)
#' headerRow is the row number of the column where the data start
#' it doesn't read in the column names correctly, so I put in simplified names. 
#' Make sure that these match what is in your Excel spreadsheet.
#' 
#' @param file excel file name
#' @param sheet sheet name in excel file
#' @param headerRow line of header row in excel file
#'
#' @author Allan Hicks 
#' @export 
#' @seealso  \code{\link{readDataFromExcel.fn}}

readInExcelLengthComps.fn <-function(file, sheet="LengthComps", headerRow=7) {

    nombres <- c("SpeciesCode","ScientificName","Species","Year","Project","AreaSetIdentifier","AreaName","DepthStrataSet",
    		     "MinStratumDepth","MaxStratumDepth","Length","NumF","NumM","NumUnsexed")

    xx <- readDataFromExcel.fn(file,sheet,headerRow)
    names(xx) <- nombres
    cat("\nNOTE: column names have been modified from the Excel Sheet. You may want to verify that they match.\n")
    return(xx)
}
