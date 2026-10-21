
## funcion fCoverage

#' Autor: Rodrigo Lagos
# Fecha: 29-06-27

#Determina el estimador del coverage 

#Inputs:
#  vQ : vector con valores de Q


#Outputs:

# CV : estimador del coverage de la muestra



fCoverage <- function(vQ)
  
{
  # cndidad de trampas partiticpantes
  nT <- length(vQ)
  
  # total de feataures
  U <- sum( vQ * 1:nT)
  
  CV <- 1 - vQ[1]/U * ((vQ[1]*(nT-1)) / (vQ[1]*(nT-1) + 2 *vQ[2]) )
  
  CV <-unname(CV)
  
  if(vQ[1] == 0 & vQ[2] == 0)
  {
    CV <-1 
    
  }
  
  
  return(CV)
  
}