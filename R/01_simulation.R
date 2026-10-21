# Limpieza de entorno
rm(list = ls())

# Fijar semilla para reproducibilidad
set.seed(71965)

# Cargar librerías necesarias
library(doParallel)
library(foreach)
library(ggplot2)
library(tidyr)
library(dplyr)

# Configurar el backend de procesamiento paralelo
numCores <- detectCores() - 1  # Detectar el número de núcleos disponibles y dejar uno libre
cl <- makeCluster(numCores)
registerDoParallel(cl)

# Cargar funciones externas
source("funciones/fMetricas.R")
source("funciones/fGetQ.R")

# Cargar lista de matrices de incicencia
listMtI <- readRDS(file = "Data/listMiCPN120.RDS")

# Definir el vector de conceptos y categorías
conceptos <- c("vinegar",  "cheek" , "scope" ,"mounting")
categorias <- c("Concretos", "Abstractos")
dfCategorias <- data.frame(
  Concepto = conceptos,
  Categoria = c("Concretos", "Concretos", "Abstractos", "Abstractos")
)

# Función para seleccionar el concepto y la categoría
seleccionar_concepto <- function(concepto, categoria) {
  if (!concepto %in% conceptos) {
    stop("El concepto no está en la lista de conceptos.")
  }
  if (!categoria %in% categorias) {
    stop("La categoría no está en la lista de categorías.")
  }
  if (dfCategorias$Categoria[dfCategorias$Concepto == concepto] != categoria) {
    stop("El concepto no coincide con la categoría especificada.")
  }
  return(listMtI[[concepto]])
}

# Función para realizar el resample y estimar
fResample <- function(n, mtI) {
  mtSample <- mtI[, sample(x = 1:nTpobla, size = n, replace = TRUE)]
  mtSample <- mtSample[rowSums(mtSample) > 0, ]  # Filtrar filas con al menos un elemento > 0
  return(list2DF(fMetricas(mtI = mtI, mtSample = mtSample)))
}


# Definir el número de resamples
B <- 1000 # Magic number

# Vector de tamaños de muestra
vN <- seq(5, 100, 1)

# Crear dataframe vacío para almacenar resultados
df_final <- data.frame()

# Iterar sobre todos los conceptos y categorías disponibles
for (i in 1:nrow(dfCategorias)) {
  concepto_seleccionado <- dfCategorias$Concepto[i]
  categoria_seleccionada <- dfCategorias$Categoria[i]
  
  # Seleccionar el dataframe correspondiente
  mtI <- seleccionar_concepto(concepto = concepto_seleccionado, categoria = categoria_seleccionada)
  
  
  nTpobla <- dim(mtI)[2]
  
  # Obtener el vector Q de la población
  vQpobla <- fGetQ(mtI)
  Upobla <- sum(mtI)
  
  # Realizar la simulación para cada tamaño de muestra en vN
  df_concepto <- foreach(n = vN, .combine = rbind, .packages = c("doParallel", "dplyr")) %dopar% {
    foreach(x = 1:B, .combine = rbind) %dopar% {
      res <- fResample(n, mtI)  # Llamar a la función fResample con el tamaño de muestra y el dataframe
      res$Concepto <- concepto_seleccionado  # Agregar el concepto seleccionado al resultado
      res$Categoria <- categoria_seleccionada  # Agregar la categoría seleccionada al resultado
      res
    }
  }
  
  # Combinar los resultados del concepto actual al dataframe final
  df_final <- rbind(df_final, df_concepto)
}

# Detener el clúster de procesamiento paralelo
stopCluster(cl)


saveRDS(object = df_final, file = "data/Simulacion.RDS")
