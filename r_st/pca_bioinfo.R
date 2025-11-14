#---- Datos Generales ----
# Programador: Cecilia Suárez & Raul Valderrama
# Version de R: 4.3.1
# Fecha: Septiembre 4, 2023
# Tema: PCA & Heatmap, Bionformática ENCB-IPN
# Script para realiazar un par de graficos exploratorios de 

#----Instalacion y activacion de librerrías----

#install.packages("corrr")
library(corrr)
#install.packages("ggplot2")
library(ggplot2)
#install.packages("ggcorrplot")
library(ggcorrplot)
#install.packages("FactoMineR")
library(FactoMineR)
#install.packages("factoextra")
library(factoextra)

#----Importacion de datos----

# Establcer directorio de trabajo
setwd("D:/marval_windows/JR_MARVAL/ceci")
list.files()

# Cargar datos
data <- read.table(file = "expresion_normalizada_mediana_GMCSF_vs_MACcoCC.csv", sep = ",", 
                   head=T, row.names = 1)
head(data)

#----Analisis----

# Estructura de datos y busqueda de valores faltantes
str(data)
colSums(is.na(data))
# Eliminar filas cuya suma sea 0 (uso de las medianas)
data <- data[!(rowSums(data[, -1]) == 0), ]
head(data)
colnames(data)


# Matriz de correlacion
corr_matrix <- cor(data)
ggcorrplot(corr_matrix)

# PCA
pca <- princomp(corr_matrix)
res <- summary(pca)
res

# Matriz de carga
pca$loadings[,1:2]

# Scree plot: gráfico de sedimentacion
sed <- fviz_eig(pca, addlabels = T)
sed

# Graph of the variables
fviz_pca_var(pca, col.var = "black")

# Representacion de cada variable en los componentes: las barras mas altas indican que esas
# variables contribuyen más en los componenetes indicados
cos <- fviz_cos2(pca, choice = "var", axes = 1:2)
cos

# Combinacion del peso de los componentes y la influencia de las varibles en ellos
pcaf <- fviz_pca_var(pca, col.var = "cos2",
                     gradient.cols = c("blue", "black", "red"),
                     repel = T) + ggtitle("Macrófagos entrenados")


pcaf

#---- Guardar el grafico----
path = "D:/marval_windows/JR_MARVAL/ceci/"

png(filename =paste (path, "pcaf_mediana_MACcoCC.png", sep = ""),
    res = 1800, height = 7, width = 7, units = "in")
pcaf
dev.off()

#----Referencia----
# https://www.datacamp.com/tutorial/pca-analysis-r