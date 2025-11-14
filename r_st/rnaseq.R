#...............................................................................

#  ---- Datos generales ----
# Análisis transcriptómico
# Script para realizar un analisis transcrpt+omico: PCA, DEA. PEA
# R version: 4.5.0

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


# PCA
pca_norm <- prcomp(t(normalized_counts_df), scale. = TRUE)
# Prepara un data frame para ggplot
pca_norm_df <- as.data.frame(pca_norm$x)
pca_norm_df$condition <- colData$condition

ggplot(pca_norm_df, aes(x = PC1, y = PC2, color = condition)) +
  geom_point(size = 4) +
  theme_classic() +
  labs(title = "PCA on normalized counts")

#...............................................................................

# ----- Heatmap Control vs Experimental ----
# Heatmap:

# Llamado de librerias
#install.packages("pheatmap")
library(pheatmap)
#install.packages("ggplot2")
library(ggplot2)
#install.packages("colorspace")
library(colorspace)
#install.packages("grid")
library(grid)
#install.packages("RColorBrewer")
library(RColorBrewer)
#install.packages("viridis") 
library(viridis)

# Establecer directorio de trabajo
setwd("./")
getwd()
list.files()

# Cargar datos
data <- read.table(file = "normalized_RNASEQ_FaDu.csv", 
                   sep = ",", head=T)
colnames(data)


# No tiene caso representar un gen cuyo valor de expresión es 0 en todas las condciones
# Eliminar filas con 0 en todas las columnas de condición experimental

data <- data[!(rowSums(data[, -1]) == 0), ]

# Reestructurando datos
# Transformar dataframe a una matriz
rownames(data) <- data[,1]
samp2 <- data[,-1]
mat_data <- data.matrix(samp2[,1:ncol(samp2)])

colnames(mat_data)

# Clasificar las condiciones basadas en los nombres de las columnas
Tipo_celular <- ifelse(grepl("^WT_", colnames(mat_data)), "Control", 
                       ifelse(grepl("^IrrKO_", colnames(mat_data)), "Experimental", NA))

# Crear el DataFrame de anotaciones de columnas
my_sample_col <- data.frame(
  Condition = factor(Tipo_celular, levels = c("Control", "Experimental")))

row.names(my_sample_col) <- colnames(mat_data)


# Definir los colores para las anotaciones
my_colour <- list(
  Condition = c("Control" = "#1A85FF", "Experimental" = "#D41159"))

# Crear el heatmap
map <- pheatmap(mat_data,
                #color= colorRampPalette(c("blue", "black", "red"))(100),
                #color = hcl.colors(100, "magma"),
                color = viridis(100, option = "viridis"),# viridis magma infierno plasma cividis mako rocket turbo
                fontsize_col = 8,
                fontsize_row = 8,
                show_rownames = F,
                show_colnames = F,
                cluster_rows = T,
                treeheight_row = 0,
                #cluster_cols = F,
                border_color = "grey",
                scale = "row", 
                cellwidth = 20,
                legend = T,
                annotation_legend = T,
                treeheight_col = 40,
                annotation_col = my_sample_col,
                annotation_colors = my_colour,
                annotation_names_col = T
)
map

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

#install.packages("ggplot2")
#install.packages("tidyverse")
#install.packages("gtable")

library(ggplot2)
library(tidyverse)
library(gtable)


# Importar nuestra base de datos
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

# Volcano con libreria
volcano <- EnhancedVolcano(datos, x= "log2FoldChange", y= "padj", lab = datos$X)
volcano

#---- Análisis de enriquecimiento ----------------------------------------------

# Un análisis de sobrerepresentación determinia un valor estadistico 
# de la presencia de un set definido de genes (GO, KEEG, etc) 
# en un set de genes de interes.

# Instalar paqueterias:

#if (!require("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")

#BiocManager::install("clusterProfiler")
#BiocManager::install("pathview")
#BiocManager::install("biomaRt")
#install.packages("wordcloud")
#install.packages("extrafont")

# Activar paqueterias:

# Para genererar el objeto PEA..
library(clusterProfiler)
library(AnnotationDbi)
library(org.Hs.eg.db)

# Para los graficos de PEA.
library(ggplot2)
library(enrichplot)
library(ggupset)
library(wordcloud)

# Topologia
library(pathview) 
library(ggnewscale)

# Para convertir los "gen name" en Id de ENSMBLE.
library(biomaRt)

#---- Importar Base de Datos ---------------------------------------------------

# Establecer directorio de trabajo
setwd("./")
getwd()
list.files()

# La base de datos (db) contiene todos los genes expresados de manera diferencial. 
# El archivo debe contener: nombre del gen, ID ENSEMBLE y el valor del foldchange.
# En caso de no tener el ID, este se puede obtener a traves de BIOMART.
# Leer el archivo CSV con los genes
data <- read.csv("differential_expression_results_WT_vs_uIrrKO.csv")
head(data)
data <- data[order(-data$log2FoldChange), ]
head(data)

# Up genes
upregulated_genes <- data[data$log2FoldChange >= 1 & data$padj < 0.05, ]


# Verificar nombres de columna
head(upregulated_genes)
colnames(upregulated_genes)


#---- ID ENSEMBLE --------------------------------------------------------------

# Convertir los nombres de genes a Entrez IDs
genes_entrez <- bitr(upregulated_genes$X,
                     fromType = "SYMBOL",
                     toType = "ENTREZID",
                     OrgDb = org.Hs.eg.db)

# Extraer los IDs únicos
gene_list <- unique(genes_entrez$ENTREZID)
head(gene_list)

#---- Enriquecimiento: ORA -----------------------------------------------------

pea_ora <- enrichGO(gene = gene_list,
                    OrgDb = org.Hs.eg.db,
                    keyType = "ENTREZID",
                    ont = "BP",               # Biological Process
                    pAdjustMethod = "BH",
                    pvalueCutoff = 0.05,
                    qvalueCutoff = 0.05,
                    readable = TRUE)         # convierte ENTREZ a SYMBOL

nrow(pea_ora@result)

# Salvar resultados 
write.csv(as.data.frame(pea_ora), 
          file = "example_ora_go_bp_results.csv", row.names = FALSE)


#----  Redundancia -------------------------------------------------------------

# Simplificar términos redundantes
nrow(pea_ora@result)
pea_ora <- simplify(pea_ora,
                    cutoff = .5,
                    by = "p.adjust", 
                    select_fun = min, 
                    measure = "Wang")

nrow(pea_ora@result)

# Salvar resultados 
write.csv(as.data.frame(pea_ora),
          file = "example_ora_redu_go_bp_results.csv", row.names = FALSE)

#---- Visualizacón--------------------------------------------------------------


dotplot(pea_ora, showCategory = 20)
p <- barplot(pea_ora, showCategory = 20)
p
pp <- p + scale_fill_viridis_c()
pp <- p + scale_fill_viridis_c(guide = guide_colorbar(reverse = TRUE))
pp

# Traslape de genes en distintos terminos
upsetplot(pea_ora)

# Topologia
map_plot <- pairwise_termsim(pea_ora)
map_plot <- emapplot(map_plot, showCategory = 20)
map_plot

# Visualizar red de términos enriquecidos y genes asociados
# categorySize puede ser "pvalue" o "geneNum"
genes <- upregulated_genes$log2fc
names(genes) <- upregulated_genes$symbol
genes <- na.omit(genes)

net <- cnetplot(pea_ora,
                categorySize = "pvalue", 
                foldChange = genes) + scale_color_gradient(low = "blue", high = "red")

net

#---- Referencias: -------------------------------------------------------------

# https://rpubs.com/pranali018/enrichmentAnalysis
# https://learn.gencore.bio.nyu.edu/rna-seq-analysis/over-representation-analysis/
