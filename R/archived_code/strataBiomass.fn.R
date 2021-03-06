#' This function outputs a dataframe in the abundance index format needed for SS3
#' it calculates the standard error of log(B) by first finding the cv of B
#' It can output the median biomass or the mean biomass. Median biomass is bias corrected so that log(Bmedian)=mean(log(B))
#'
#' @param bio object
#' @param theStrata year 
#' @param fleet Fleet number 
#' @param season Season number
#' @param outputMedian TRUE/FALSE
#'
#' @author Allan Hicks 
#' @export 

strataBiomass.fn <-function(bio, theStrata="Year", fleet="EnterFleet", season=1, outputMedian=T) {

    xxx <- split(bio[,c(theStrata,"Biomass","BiomassVar")],bio[,theStrata])
    strat <- names(xxx)
    bio <- unlist(lapply(xxx,function(x){sum(x$Biomass,na.rm=T)}))
    variance <- unlist(lapply(xxx,function(x){sum(x$BiomassVar,na.rm=T)}))
    cv <- sqrt(variance)/bio
    seLogB <- sqrt(log(cv^2+1))
    if(outputMedian==T) {
        med <- bio*exp(-0.5*seLogB^2)
        out <- data.frame(Stratum=strat,Season=season,Fleet=fleet,Value=med,seLogB=seLogB)
    }
    else {
        out <- data.frame(Stratum=strat,Season=season,Fleet=fleet,Value=bio,seLogB=seLogB)
    }
    row.names(out) <- NULL
    return(out)
}
