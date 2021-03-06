#' Calculates the number of observations by strata
#'
#'
#' @param dir directory where the output file will be saved
#' @param dat data-frame of the data that has been by the PullCatch.fn
#' @param stat.vars A vector of the strata variable names (i.e., c("Depth_m","Latitude_dd"))
#' @param strat.df a dataframe with the first column the name of the stratum, the second column the area of the stratum, and the remaining columns are the high and low variables defining the strata created by the CreateStrataDF.fn
#' @param printfolder the folder where files will be saved
#' @param verbose opt to print out message statements
#'
#' @author Chantel Wetzel
#' @export


CheckStrata<- function(dir = NULL, dat, strat.vars = c("Depth_m","Latitude_dd"), strat.df, printfolder = "forSS",  verbose = TRUE) {


    row.names(strat.df) <- strat.df[,1]     #put in rownmaes to make easier to index later
    numStrata <- nrow(strat.df)

    #create strata factors
    stratum <- rep(NA,nrow(dat))        #the stratum factor
    for(strat in 1:numStrata) {
        ind <- rep(T,nrow(dat))
        for(i in 1:length(strat.vars)) {
            ind <- ind & dat[,strat.vars[i]]>=strat.df[strat,paste(strat.vars[i],".1",sep="")] & dat[,strat.vars[i]]<strat.df[strat,paste(strat.vars[i],".2",sep="")]
        }
        stratum[ind] <- as.character(strat.df[strat,1])
    }

    stratum <- factor(stratum,levels=as.character(strat.df[,1]))
    dat <- data.frame(dat, stratum)
    dat.yr <- split(dat,dat$Year)
    dat.stratum <- split(dat, dat$stratum)

    yr.fn <- function(x) {
        x <- split(x,x$stratum)
        namesStrat <- names(x)
        nobs <- unlist(lapply(x,function(x){nrow(x)}))
        if(any(nobs<=1)) {
            if (verbose){
            cat("*****\nWARNING: At least one stratum in year",x[[1]][1,"year"],"has fewer than one observation.\n*****\n")}
        }

        stratStats <- data.frame(name = namesStrat, area = strat.df[namesStrat,2], ntows = nobs)
        stratStats
    }

    yearlyStrataEsts <- lapply(dat.yr, yr.fn)
    names(yearlyStrataEsts) <- paste("Year",names(yearlyStrataEsts),sep="")

    StrataObs = as.data.frame(yearlyStrataEsts[[1]])
    for(a in 2:length(yearlyStrataEsts)){
    	StrataObs = cbind(StrataObs, yearlyStrataEsts[[a]]$ntows)
    }
    colnames(StrataObs) = c("Area_Name", "Area_km2", paste0("Ntows_", names(yearlyStrataEsts)))
    rownames(StrataObs) = c()

    return(StrataObs)
}
