# Desempeño del estimador de Sample Coverage de Chao en datos de normas de propiedades conceptuales

Código de simulación y de análisis de datos del estudio que evalúa, mediante simulación, el desempeño del estimador de sample coverage (Chao2) en normas de propiedades conceptuales (CPN).

El diseño, los resultados y las conclusiones están en el póster: [`poster/poster.pdf`](poster/poster.pdf). Este trabajo fue presentado en las XLVIII Jornadas Nacionales de Estadística 2026 de la Sociedad Chilena de Estadística (SOCHE).

Autores: Rodrigo Lagos, Felipe A. Medina Marín y Sergio E. Chaigneau.
Center for Social and Cognitive Neuroscience (CSCN), Universidad Adolfo Ibáñez; Programa de Bioestadística, Facultad de Medicina, Universidad de Chile.
Contacto: rodrigolagoschavez@gmail.com

## Estructura

> Propuesta inicial. Ajustar a los nombres reales de los archivos.

```
.
├── README.md
├── LICENSE
├── poster/
│   └── poster.pdf
├── data/                   # Matrices de referencia y salidas de la simulación
├── R/
│   ├── 01_simulation.R     # Simulación
│   ├── 02_analysis.R       # Análisis de datos
│   └── 03_figures.R        # Figuras
└── figures/
```

## Requisitos

R (indicar versión) y los paquetes `ggplot2` y `generalCorr`; completar con los demás que use el código.

## Reproducción

```r
source("R/01_simulation.R")
source("R/02_analysis.R")
source("R/03_figures.R")
```

Semilla aleatoria: indicar el valor usado.

## Datos

Las matrices de referencia provienen de la base de datos CPN120. EsPal (Spanish Lexical Database) se usó solo para seleccionar los conceptos (vinegar, cheek, mounting y scope), no como fuente de las matrices. Indicar las condiciones de uso de CPN120 antes de publicar las matrices.

## Financiamiento

James S. McDonnell Foundation (https://doi.org/10.37717/2022-3930) y ANID Fondecyt 1240075.

## Licencia

Pendiente de definir.
