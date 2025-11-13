#...............................................................................

# ---- Data ----
# EIntrorudcción a R
# Script para conocer R y hacer un análisis de expresión diferencial 
#usando DESeq2 a partir de cuentas generadas con STAR.
# R version: 4.5.0

#...............................................................................

# Introducción a R
# Como pedir ayuda en R
help.start()

# Escrbir el signo "?" antes de una función o paquete 
#del que se desea obtener ayuda
?data.frame
?plot
?log

#Para ver un ejemplo de la función:

example (log)
example (plot)

# Usando el signo # para hacer comentarios en R
# Calcular 3 + 4
3 + 4

# Aritmetica básica, ejecuta lo siguiente:
# Calcula 10 + 15
10 + 15
#Calcula 50 * 60
50 * 60
50 * 60 /564 

# Variables en R: variable <- valor_de_la variable
a <- 5
b <- 10
c <- a + b
c

# Tipos de datos en R

# Númericos
numerics <- 54.5
numerics
# Enteros
integers <- 54
integers
# Caracteres
characters <- "ATCGATUGAAATTAAGCAT"
characters
# Lógicos
logical <- TRUE
logical

#Corrobora el tipo de dato asignado a tus variables
class(numerics)
class(integers)
class(characters)
class(logical)

# Estamos haciendo un experimento que va a salvar nuestra tesis, vamos a guardar el número de ratones que tenemos para cada condición:

#Asigna un valor a cada condición
wild_type <- 6
knockout_csf <- 6

#¿Cuál es el resultado de sumar todas las variables?
wild_type + knockout_csf

#Crea una variable que tenga todas tus variables:
best_experiment <- wild_type + knockout_csf
best_experiment

# Ejemplos de vectores en R 
# Crea un vector con los pesos de los ratones en cada condición
wild_weight <- c(0, 10, 20, 60, 78, 80, 75, 90, 95)
wild_weight
knockout_weight <- c(0, 10, 20, 40, -10, -15, -30, -20, -15)
knockout_weight

#Nombra los días de muestreo en cada vector
days_vector <- c("0d", "3d", "6d", "9d", "12d", "15d", "18d", "21d", "24d")
days_vector
# Asigna los nombres a cada vector
names(wild_weight) <- days_vector
names(knockout_weight) <- days_vector
#No olvides decirle a R que te muestre el resultado:
wild_weight
knockout_weight

# Calcular cuánto peso gano cada uno de los ratoncitos

total_wild <- sum(wild_weight)
total_knockout <- sum(knockout_weight)

#¿El ratón knockout tiene mayor o menor peso que el control?:
total_wild>total_knockout
total_wild<total_knockout

#Vamos a aprender a como crear una nueva variable basada en una selección:

#Solo quiero ver los datos del día 6 al 24
wild_selection <- wild_weight [3:9]
wild_selection

#Hacer una nueva variable basada en una comparación
#Queremos saber en qué días el ratón knockdown perdió peso
comparison_vector <- knockout_weight < 0

#Hay que colocar en un vector esos datos:
weight_loss <- knockout_weight [comparison_vector]
weight_loss

# Matrices en R
#Construye tu primera matriz
matrix (1:9, byrow = TRUE, nrow = 3)

#Regresemos a los ratones, vamos a poner en una matriz los siguientes datos
initial_weight <- c(20.2, 21.3)
final_weight <- c(24.3, 21.1)
tumor_volume <- c(50, 450)

#Queremos poner todos esos datos en la matriz, primero lo pondremos dentro de una variable
parameters <- c(initial_weight, final_weight, tumor_volume)
matrix_parameters <- matrix(parameters, byrow = TRUE, nrow = 3)
matrix_parameters

# Invertir filas y columnas
t(matrix_parameters)

#Coloca en un vector los nombres de las distintas condiciones que se encontraran en las filas y columnas
name_parameters <- c("Initial weight (g)", "Final weight (g)", "Tumor volume (mm3)")
condition <- c("Wild_type", "Knockout_CSF1")

#Nombra las columnas con la condición
colnames(matrix_parameters) <- condition
#Nombra las filas con los parámetros que medimos
rownames(matrix_parameters) <- name_parameters
#Muestra como quedo la matriz:
matrix_parameters

# Días después de sacar el experimento ustedes terminan de cuantificar los valores de la proteína CSF1 por citometría de flujo y WB en los ratónes
# ¿Se puede agregar una nueva fila que contenga estos datos en nuestra matriz?, la respuesta es SI, con la función `rbind()`
# si quieren agregar columnas es con la función `cbind()`:
# Lo primero es hacer la matriz con esos nuevos datos:

expression_flow <- c(50.5, 10.1)
expression_wb <- c(120, 23)
expression_csf <- c(expression_flow, expression_wb)
matrix_expression <- matrix(expression_csf, nrow =2, byrow =TRUE, 
                            dimnames = list (c("IMF_CSF1", "WB_CSF1" ), 
                                             c("Wild_type", "Knockdout_CSF1")))
matrix_protein <- rbind (matrix_parameters, matrix_expression)
matrix_protein
t(matrix_protein)

#Selecciona los datos del knockout y colócalo en una variable:
parameters_knockdown <- matrix_protein [,2]
parameters
#Selecciona solo los datos datos de peso inicial y final
parameters_weight <- matrix_protein [1:2, 1:2]
parameters_weight
#¿Cuál es la media de los pesos obtenidos?
mean(parameters_weight)
summary(matrix_protein)

# Data frames en R
#Pon toda la información en vectores
condition_df <- c("Wild_type", "Wild_type_tumor", "Knockout_CSF1", "Knockout_CSF1_tumor")
ini_weight <- c(20.2, 20.5, 21.3, 22.5)
fin_weight <- c(24.3, 23.5, 22.3, 21.1)
tumor_injection<- c(FALSE, TRUE, FALSE, TRUE)

#Crea un data frame a partir de tus vectores
expe_mouse <- data.frame(condition_df, ini_weight, fin_weight, tumor_injection)
expe_mouse

#Revisa la estructura del data frame
str(expe_mouse)
summary(expe_mouse)

# Trabjando con datos de RNA-seq 
#Leer data frame de datos de expresión de RNASeq
expression_data <- read.csv("expression_RNASeq.csv")

# Explora los datos
head(expression_data)
tail(expression_data)
str(expression_data)
summary(expression_data)

# Selecciona el valor ubicado en la fila 1, columna 3)
expression_data[1,3]
# Selecciona la fila 4
expression_data[4,]
# Selecciona los primeros 5 genes de la columna "hgnc_symbol"
expression_data[1:5,"hgnc_symbol"]
# Almacena en una variable los datos de p ajustada
padj_values <- expression_data$padj
padj_values

#Selecciona los valores con Log2FC mayor a 1
subset(expression_data, subset = log2FoldChange >1)

#Sorting
a <- c(100, 10, 1000)
order(a)
a[order(a)]

#Usa la función order en la matriz de datos, para que los genes queden posicionados de acuerdo a su valor de expresión
positions <- order(expression_data$log2FoldChange)

#Usa el orden establecido en la variables positions para organizar todo el data frame
expression_data[positions, ]


#...............................................................................
# ---- Establercer el directorio de trabajo ----
# version
setwd("./")
getwd()
list.files()

#...............................................................................

# ---- Instalar librerías ----

#if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

# 
# BiocManager::install("DESeq2")
# BiocManager::install("tximport")
# BiocManager::install("org.Hs.eg.db")
# BiocManager::install("AnnotationDbi")
# BiocManager::install("biomaRt")
# BiocManager::install("apeglm")
# install.packages("readr")
#BiocManager::install('EnhancedVolcano')

library(DESeq2)
library(tximport)
library(org.Hs.eg.db)
library(AnnotationDbi)
library(biomaRt)
library(dplyr)
library(readr)
library(apeglm)
library(EnhancedVolcano)

#...............................................................................

# ---- Importar datos de STAR ----

# Import txt matrix from STAR
count_matrix <- read.table("matrix_counts_DESeq2.txt", header = TRUE, sep = "\t", 
                   row.names = 1)

# Verifica el formato
head(count_matrix)
colnames(count_matrix)
colnames(count_matrix) <- c("WT_1", "WT_2", "WT_3", 
                    "IrrKO_1", "IrrKO_2", "IrrKO_3")

head(count_matrix)

# Define el vector de condiciones
condition <- factor(c(rep("WT", 3), rep("IrrKO", 3)))

# Crea el data frame de diseño
colData <- data.frame(row.names = colnames(count_matrix), condition)
head(colData)

#...............................................................................

# ---- Crear el objeto DESeq ----
dds <- DESeqDataSetFromMatrix(
  countData = count_matrix,
  colData = colData,
  design = ~ condition)

#...............................................................................

# ---- Filtrado de genes ----

# Filtrado de genes con múltiples condiciones

# Definir criterios de expresión mínima
min_counts <- 10
min_samples <- 3

# Calcular genes expresados en al menos `min_samples` muestras por cada condición
expressed_in_group <- lapply(levels(dds$condition), function(cond) {
  rowSums(counts(dds)[, dds$condition == cond] >= min_counts) >= min_samples
})

# Conservar genes que cumplen el criterio en al menos un grupo
keep <- Reduce("|", expressed_in_group)

# Aplicar el filtro
dds <- dds[keep, ]

#...............................................................................

# ---- Correr DESeq2 ----

dds <- DESeq(dds)

#...............................................................................

# ---- Datos Normalizados ----

# Obtener los conteos normalizados
normalized_counts <- counts(dds, normalized = TRUE)
# Convertir los conteos a un data frame para manipularlos
normalized_counts_df <- as.data.frame(normalized_counts)
# Guardar los conteos normalizados en un archivo CSV
write.csv(normalized_counts_df, file = "normalized_RNASEQ_FaDu.csv",
          row.names = TRUE)

# Aplicar transformación VST: mayor control de la varianza
#vsd <- varianceStabilizingTransformation(dds)
# Obtener los conteos transformados
#vsd_counts <- assay(vsd)
# Convertir a un data frame
#vsd_counts_df <- as.data.frame(vsd_counts)
# Guardar los conteos transformados en un archivo CSV
#write.csv(vsd_counts_df, file = "vsd_counts_all_samples_L1.csv", row.names = TRUE)

#...............................................................................

# ---- Análisis de Expresion diferencial ----
# confg ideal: results <- results(dds, contrast = c("condition", "treated", "control"))
# dds$condition <- factor(dds$condition, levels = c("untreated","treated"))
res <- results(dds, contrast = c("condition", "IrrKO", "WT"), alpha = 0.05,
               lfcThreshold = 0.58)#, altHypothesis = "greaterAbs")
res
summary(res)

# Convertir los resultados a un data.frame
res_df <- as.data.frame(res)

# Añadir nombre de los genes
res_df$symbol <- mapIds(org.Hs.eg.db, keys = rownames(res_df), 
                        keytype = "ENSEMBL", column = "SYMBOL")

# Remover valores NA
res_df <- na.omit(res_df)

# Identificar genes duplicados en los nombres de fila
duplicados <- duplicated(rownames(res_df))
# Mostrar si hay genes duplicados
any(duplicados)  # Devuelve TRUE si hay genes duplicados

# Guardar todos los genes (con y sin significancia)
write.csv(res_df, file = "all_genes_WT_vs_IrrKO.csv", row.names = TRUE)

# Filtrar los genes que tienen un valor de p.adj menor a 0.05
res_df<- res_df[res_df$padj < 0.05, ]

# Guardar los resultados como un archivo CSV
write.csv(res_df, file = "differential_expression_results_WT_vs_uIrrKO.csv",
          row.names = TRUE)
# Resumen
summary(res_df)

#...............................................................................

# ---- Volcano Plot ----

# Activacion de librerias

library(ggplot2)
#install.packages("tidyverse")
library(tidyverse)
library(gtable)


#Importar nuestra base de datos
list.files()
datos <- read.csv("all_genes_WT_vs_IrrKO.csv")
colnames(datos)

# Filtrar datos con padj no NA ni 0
datos <- datos %>%
  filter(!is.na(padj) & padj > 0)

#Construccion del grafico
# Agregar una columna a los datos para determinar el estado de la expresion
datos$Estado <- "Sin cambio"
# Si el log2Foldchange > 1 y qvalue < -log10(0.05) entonces "Sobreexpresado" 
datos$Estado[datos$log2FoldChange >= 1 & datos$padj < (0.05)] <- "Sobreexpresado"
# Si log2Foldchange < -1 y qvalue < -log10(0.05),} entonces "Subexpresado"
datos$Estado[datos$log2FoldChange <= -1 & datos$padj < (0.05)] <- "Subexpresado"

# Agregar el nombre de los genes
# Crear una columna "delabel" en la base de datos 
# que contenga el nombre de los genes expresados diferencialmente
datos$delabel <- NA
datos$delabel[datos$Estado != "NO"] <- datos$symbol[datos$Estado != "NO"]


# Insertar logarimos en las variables
# X/Y mejora la visualizacion
ggplot(data=datos, aes(x=datos$log2FoldChange, y=datos$padj)) + geom_point() #base

p = ggplot(data=datos, aes(x=log2FoldChange, y=-log10(padj), 
                           col=Estado)) + geom_point()+
  theme_classic(base_family = "Arial") + guides(color="none")
  #theme_classic()+ guides(color="none")
#labs(title = "Expresi?n diferencial entre GM-CSF vs 3CM178")+
#theme (plot.title = element_text (hjust = 0.5 ))+
#theme(legend.position="bottom")
p

# Agregar marco de referencia 
#de la expresion diferencial log2FoldChange y -log10qval 
#El log base 2 de 2 es 1...usar ese valor en lugar de o.6?
#El -log10(0.05)= 1.30
p2 = p + geom_vline(xintercept=c(-1, 1), col="grey") +
  geom_hline(yintercept=-log10(0.05), col="grey")
p2

# Cambiar el color de los puntos
mycolors <- c("#1A85FF", "black", "#D41159")
names(mycolors) <- c("Subexpresado", "Sin cambio", "Sobreexpresado")
p3 <- p2 + scale_colour_manual(values = mycolors)
p3






