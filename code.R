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

# Sentinel-2A a 10m de 2021-07-23
files <- "./data/sentinel_2/R10m/"
files <- paste0(files, list.files(files))

S2A10 <- stack(files)
names(S2A10) <- c('B02','B03','B04','B08') # Cambiamos los nombres
S2A10

# Sentinel-2A a 20m de 2021-07-23
files <- "./data/sentinel_2/R20m/"
files <- paste0(files, list.files(files))
S2A20 <- stack(files)
names(S2A20) <- c('B02','B03','B04','B05','B06',
                  'B07','B08A','B11','B12') # Cambiamos los nombres

# Area de estudio --------------------------------------------------------------
area <-st_read('./data/area.shp')
