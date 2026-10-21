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

Copyright (c) 2026 Rodrigo Lagos, Felipe A. Medina Marín y Sergio E. Chaigneau

Este trabajo está licenciado bajo la Licencia Creative Commons
Atribución-NoComercial 4.0 Internacional (CC BY-NC 4.0).

Usted es libre de:

  - Compartir: copiar y redistribuir el material en cualquier medio o formato.
  - Adaptar: remezclar, transformar y construir a partir del material.

Bajo los siguientes términos:

  - Atribución: debe dar crédito de manera adecuada, brindar un enlace a la
    licencia e indicar si se han realizado cambios.
  - NoComercial: no puede utilizar el material con propósitos comerciales.
    Se permite su uso con fines académicos, de investigación y de educación.
  - Sin restricciones adicionales: no puede aplicar términos legales ni
    medidas tecnológicas que restrinjan legalmente a otros a hacer cualquier
    uso permitido por la licencia.

El material se ofrece "tal cual", sin garantías de ningún tipo.

Texto legal completo:
https://creativecommons.org/licenses/by-nc/4.0/legalcode.es

Resumen de la licencia:
https://creativecommons.org/licenses/by-nc/4.0/deed.es
