#...............................................................................

# ---- Data ----
# Introruducción a R
# Script para conocer R
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
