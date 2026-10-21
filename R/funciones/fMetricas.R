

fMetricas <- function(mtI, mtSample)
{
  
  source(file = "R/funciones/fCoverage_real.R")
  source(file = "R/funciones/fCoverage.R")
  source(file = "R/funciones/fGetQ.R")

  nT <- dim(mtSample)[2]
  
  CV_real <- fCoverage_real(mtI = mtI, mtSample = mtSample)
  
  vQ <- fGetQ(mtI = mtSample)
  
  CV_est <- fCoverage(vQ = vQ)
  
  lstMetricas <- list( 
    # valors de Q1
    Q1 = vQ[1],
    Q2 = vQ[2],
    
    nT = nT,
    
    U  = sum (vQ * 1:nT),
    
    CV_real = CV_real,
    
    CV_est = CV_est 
    
    )
  
  return(lstMetricas)
  

}