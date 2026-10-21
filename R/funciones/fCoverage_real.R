

fCoverage_real  <- function(mtI, mtSample)
  
{
  vFqPobla <- rowSums(mtI)  # vector frecuanas abslutas poblaciona
  
  vFeature_pobla <- rownames(mtI) # (nombres) features en la poblacion
  
  vFeature_sample <- rownames(mtSample) # featrues presente en la muesta
  
  vInd <- vFeature_pobla %in% vFeature_sample # que featarues estan presentes en la muestra y en la poblacion
  
  CV_real <-  sum(vFqPobla[vInd])/sum(vFqPobla)
  
  return(CV_real)
  
  
}
  