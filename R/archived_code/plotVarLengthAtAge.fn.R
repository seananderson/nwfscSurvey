#' Plot variability of length at age
#'
#' @details Plots the SD and CV of age at observed and predicted length
#'
#'
#' @param dir directory to save the file
#' @param dat      The data loaded from the NWFSC database or the SexedLgthWtAge sheet
#' @param survey specify the survey data set for calculations. Options are "NWFSCBT", "Tri.Shelf", "AFSC.Slope"
#' @param ageBin   Currently fixed at 1, so a moot parameter
#' @param bySex    Logical to indicate if plot by sex
#' @param parStart Vector of starting parameters for Linf, k, and t0 in VonB estimation
#' @param estVB    Logical. Estimate vonB growth to plot against predicted length. If F,
#'                 it uses the paramters in \code{parStart}.
#' @param bins     The bins to put ages into. If NULL then simply uses the ages as recorded.
#' @param dopng TRUE/FALSE whether to save a png file   
#' @param ...      Additional arguments for the plots
#'
#' @examples
#'   slwa <- read.csv(paste(directory,"SexedLgthWtAge.csv",sep="\\"),skip=8)
#'   ageBin currently is fixed at 1 no matter what number you enter
#'   res <- varLengthAtAge.fn(slwa,ageBin=1,bySex=T,parStart=c(52,0.09,1),estVB=T)
#' @author Allan Hicks and Chantel Wetzel
#'
#' @export

varLengthAtAge.fn <- function(dir, dat, survey, ageBin=1, bySex=T, parStart=c(52,0.09,1), estVB=T, bins=NULL, legX="bottomleft", legY=NULL, dopng = FALSE,...) 
{
    #calculate and plot the sd and cv for length at age
    #if you enter estVB=F, then it uses the parStart as the VB parameters

    plotdir <- paste0(dir, "/plots")
    plotdir.isdir <- file.info(plotdir)$isdir
    if(is.na(plotdir.isdir) | !plotdir.isdir){
      dir.create(plotdir)
    }

    VB.fn <- function(age,Linf,k,t0) {
        out <- Linf*(1-exp(-k*(age-t0)))
        return(out)
    }
    VBopt.fn <- function(x,age,lengths) {sum((lengths-VB.fn(age,Linf=x[1],k=x[2],t0=x[3]))^2)}

    if(survey%in%c("Tri.Shelf", "AFSC.Slope")){
        dat$LENGTH_CM <- dat$Length_cm
        dat$AGE_YRS   <- dat$AGE
        dat <- dat[!is.na(dat$AGE_YRS),]
        ind = which(dat$SEX == 3)
        dat = dat[-ind,]
    }

    datL <- dat[!is.na(dat$AGE_YRS),]
    if(is.null(bins)) {datL$AGE_YRS_2 <- datL$AGE_YRS}
    if(!is.null(bins)) {datL$AGE_YRS_2 <- findInterval(datL$AGE_YRS,bins)}

    if(!bySex) {
        datL <- list(allSex=datL)
        nn <- 1
    }
    if(bySex) {
        if(survey%in%c("Tri.Shelf", "AFSC.Slope")){
            datL$sex <- rep(NA,nrow(datL))
            datL[datL$SEX==2,"sex"] <- "f"
            datL[datL$SEX==1,"sex"] <- "m"

            datLf <- datL[datL$sex=="f",]
            datLm <- datL[datL$sex=="m",]
            datL <- list(female=datLf,male=datLm)
        }

        if(survey == "NWFSCBT"){
            datLf <- datL[datL$SEX=="f",]
            datLm <- datL[datL$SEX=="m",]
            datL <- list(female=datLf,male=datLm)            
        }
        nn <- 2
    }
    
    if (dopng) { png(paste0(dir, "/plots/", survey, "_VarLengthAtAge.png"), height=7, width=7, units="in",res=300) }
    par(mfcol=c(2,nn), mar =c(3,5,3,5))

    out <- vector(mode="list",length=nn)
    names(out) <- names(datL)
    for(i in 1:length(datL)) {
        if(estVB) {
            xpar <- optim(parStart,VBopt.fn,age=datL[[i]]$AGE_YRS,lengths=datL[[i]]$LENGTH_CM)$par
            cat("Estimated VB parameters for",names(datL)[i],xpar,"\n")
        }
        if(!estVB) {
            xpar <- parStart
        }
        predL <- VB.fn(1:max(datL[[i]]$AGE_YRS),xpar[1],xpar[2],xpar[3])
        names(predL) <- as.character(1:max(datL[[i]]$AGE_YRS))

        x <- split(datL[[i]]$LENGTH_CM,datL[[i]]$AGE_YRS_2)
        xsd <- unlist(lapply(x,sd))
        xcv <- xsd/predL[names(xsd)]
        if(is.null(bins)) {ages <- as.numeric(names(xsd))}
        if(!is.null(bins)) {ages <- bins[as.numeric(names(xsd))]}
        out[[i]] <- data.frame(ages=ages,sd=xsd,cv=xcv)

        plot(ages,xsd,xlab="Age",ylab="SD of L@A",type="b",pch=16,lty=1,main=names(datL)[i],...)
        par(new=T)
        plot(ages,xcv,xlab="",ylab="",yaxt="n",type="b",pch=3,lty=2,...)
        axis(4)
        mtext("CV",side=4,line=2.6)
        legend(x=legX,y=legY,c("SD","CV"),pch=c(16,3),lty=c(1,2))

        plot(VB.fn(ages,xpar[1],xpar[2],xpar[3]),xsd,xlab="Predicted Length at Age",ylab="SD of L@A",type="b",pch=16,lty=1,main=names(datL)[i],...)
        par(new=T)
        plot(VB.fn(ages,xpar[1],xpar[2],xpar[3]),xcv,xlab="",ylab="",yaxt="n",type="b",pch=3,lty=2,...)
        axis(4)
        mtext("CV",side=4,line=2.6)
        legend(x=legX,y=legY,c("SD","CV"),pch=c(16,3),lty=c(1,2))
    }
    if (dopng) { dev.off()}
    return(out)
}


