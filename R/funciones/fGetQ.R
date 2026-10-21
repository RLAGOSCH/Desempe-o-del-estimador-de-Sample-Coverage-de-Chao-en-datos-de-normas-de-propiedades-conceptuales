
## funcion fGetQ

#' Autor: Rodrigo Lagos
# Fecha: 27-06-27

#Desde el vector de frecuencias de detecion otiene el vector de Q

#Inputs:
#  mtI: matrix de incidencia 

#Outputs:
#  vQ : vector de Q, ordenao y con nombres





fGetQ <- function(mtI)
{
  
  nT <- dim(mtI)[2]
  
  vFq<- rowSums(mtI)
  
  vQ <- (1:nT) * 0
  vQ[as.numeric(names(table(vFq)))] <- table(vFq)
  
  names(vQ) <- paste0("Q_",1:nT)
  return(vQ)
}