## Cargar la librería ----------------------------------------------------------
library(pacman)
pacman::p_load(rgdal, raster,  RColorBrewer, rasterVis, 
               sf, randomForest, tidyverse)

rm(list = ls()) #Borrar el espacio de trabajo

# Directorio de trabajo
setwd("D:/CSA_R/projects/ndvi/")

# Coordenadas en wgs84-zona19
z19 <- "+proj=utm +zone=19 +south +datum=WGS84 +units=m +no_defs"

## Cargar los datos ------------------------------------------------------------



