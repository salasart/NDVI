## Cargar la librería ----------------------------------------------------------
library(pacman)
pacman::p_load(rgdal, raster,  RColorBrewer, rasterVis, 
               sf, randomForest, tidyverse)

rm(list = ls()) #Borrar el espacio de trabajo

# Directorio de trabajo
setwd("D:/CSA_R/projects/ndvi/")

# Coordenadas en wgs84-zona19
z19 <- "+proj=utm +zone=19 +south +datum=WGS84 +units=m +no_defs"
color <- brewer.pal(10, 'RdYlGn')

## Cargar los datos ------------------------------------------------------------

# Sentinel-2A a 10m de 2021-07-23
files <- "./data/R10m/"
files <- paste0(files, list.files(files))

S2A10 <- stack(files)
names(S2A10) <- c('B02','B03','B04','B08') # Cambiamos los nombres
S2A10

# Sentinel-2A a 20m de 2021-07-23
files <- "./data/R20m/"
files <- paste0(files, list.files(files))
S2A20 <- stack(files)
names(S2A20) <- c('B02','B03','B04','B05','B06',
                  'B07','B08A','B11','B12') # Cambiamos los nombres
S2A20

# Área de estudio
area <-st_read('./data/area.shp')

# recortar al área de estudio con sentinel-2A 10m
stl10 <- crop(S2A10, area) %>% mask(area)

## Combinación de bandas -------------------------------------------------------
# Color natural 4,3,2
plotRGB(stl10, r=3, g=2, b=1, axes = T, colNA = 'white', stretch = 'lin' )

# Color infrarojo
plotRGB(stl, r=4, g=3, b=2, axes = T, colNA = 'white', stretch = 'lin' )


## NDVI ------------------------------------------------------------------------
# Índice de Vegetación de Diferencia Normalizada (NDVI)
# ndvi = (b08-b04)/(b08+b04)
ndvi <- (stl10[[4]]-stl10[[3]])/(stl10[[4]]+stl10[[3]])

ndvi_r <- reclassify(ndvi, c(-Inf, 0.1, 0,
                             0.1, 0.2, 1,
                             0.2, 0.3, 2,
                             0.3, 0.4, 3,
                             0.4, 0.5, 4,
                             0.5, 0.6, 5,
                             0.6, 0.7, 6,
                             0.7, 0.8, 7,
                             0.8, 0.9, 8,
                             0.9, 1, 9
))



png(filename = './result/ndvi.png',
    units = 'in', width = 15, height = 10, res = 300)
plot(ndvi_r, col = col.ndvi, legend.args = list(text = 'NDVI', side = 4,
                                                font = 2, line = 2.5, cex = 0.8))
dev.off()
