# **Introducción a la programación en R**

R es un lenguaje de programación para estadística y representación gráfica de software libre. 

**Ventajas de R:**

+ R tiene muchas presencia en el área de ciencias biológicas en análisis ómicos mediante una amplia gama de herrameintas.
+ Todas las paqueterías son de libre acceso. 

**R no es perfecto:**

+ No fue escrito para no programadores.
+ Es un nuevo lenguaje que aprender, así que tiene su curva de aprendizaje, como cuando aprendes hablar cualquier idioma.
+ Solo habla inglés.

Para trabajar con R debemos instalar R mismo como lenguaje de programación y sobre todo instalar dos Rstudio, un entorno de desarrollo integrado que facilita la interacción con el software. Trabajar en R implica seguir una estructura básica de comunicación. Por ende, para saber como establecer este canal de comunicacíon es importante saber pedir ayuda 

Obtención de ayuda básica en R

Manual básico de R: `help.start()`

Ayuda de comandos específicos: `?nombredelcomando`

    ?plot
---
    ?log

Para ver un ejemplo de la función:

    example (log)
---
    example (plot)

Al igual que en Linux y en otroas lengujaes de programación, R hace uso del signo `#` para añadir comentarios en tu código, con el objetivo de aumentar su claridad y reproducibilidad.

Por ejemplo:

    # Calcular 3 + 4
    3 + 4

También puedes ejecutar comandos de R directamente en la consola. 

---
### **Arimética en R:**
La forma más básica de usar R es como una calculadora.
Vamos hacer aritmética con R, para ello es importante que siempre recuerdes que usa los siguientes operadores aritméticos:

Suma: `+`

Resta: `-`

Multiplicación: `*`

División: `/`

Exponente: `^`

Ejecuta lo siguiente:

    # Calcula 10 + 15
    10 + 15
---
    #Calcula 50 * 60
    50 * 60 /564


---
### **Variables en R:**

R trabaja con variables, un concepto básico matamático pero ahora en programación. Es un elemento del lenguaje al que le podemos asignar un valor. Para definir una variable en R se realiza una operación de asignación empleando el signo:

    variable <- valor_de_la variable
---

    # Asigna el 96a x
    x <- 96
    # Muestra el valor de X
    x
---
    a <- 5
    b <- 10
    c <- a + b
    c
---

En protgramación no solo puedes almacenar números en las variabes, existen distintos tipos de datos con los que puedes trabajar. Estos son las estructuras de datos básicas con las que podemos trabajar:

*Numerics*: valores con números decimales

*Integers*: números enteros (Aún que también forman parte de los numéricos)

*Logical*: emplea valores Booleanos (TRUE or FALSE)

*Characters*: texto (or String)

Veamos algunos ejemplos, asigna cada uno de estos valores a una variabe particular: '54', 'ATCGATUGAAATTAAGCAT', 'TRUE:

---
    numerics <- 54
    numerics
---
    characters <- "ATCGATUGAAATTAAGCAT"
    characters
---
    logical <- TRUE
    logical

Vamos a usar el comando `class()` para saber que tipo de dato es:

    #Corrobora el tipo de dato asignado a tus variables
    class(numerics)

Saber con que tipo de datos estamos trabajando es muy importante a la hora de organizar tablas muy grandes, o incluso en seleccionar que tipo de operación vamos a usar para cada tipo de datos.

**¿Subimos la complejidad?**

Estamos haciendo un experimento que va a salvar nuestra tesis, vamos a guardar el número de ratones que tenemos para cada condición:

    #Asigna un valor a cada condición
    wild_type <- 6
    knockout_csf <- 6
---
    #¿Cuál es el resultado de sumar todas las variables?
    wild_type + knockout_csf
---
    #Crea una variable que tenga todas tus variables:
    best_experiment <- wild_type + knockout_csf
---

### **Vectores en R:**

El siguiente paso es conocer otros elementos que se pueden asignar a una variable, vamos a ver qué es un vector. Un vector en R es un arreglo unidimensional que puede contener datos numéricos, caracteres o datos lógicos. En términos prácticos diríamos que un vector es otra herramienta para guardar varios datos en un solo espacio. Para crear un vector en R se coloca la función `c()`, dentro de los paréntesis van a ir los elementos que tu desees, estos siempre deben ir separados por una coma.

Regresemos a los ratones, los cuales fueron inoculados con células que forma tumores mamarios, el peso de cada ratón fue registrado cada 3 días durante 24 días, aquí mostramos el ejemplo de uno de ellos:

    wild_weight <- c(0, 10, 20, 60, 78, 80, 75, 90, 95)
    knockout_weight <- c(0, 10, 20, 40, -10, -15, -30, -20, -15)

Ahora vamos a nombrar un vector. Recuerden que es importante siempre tener una visión clara de los datos que están usando, y entender a que se refiere cada elemento es esencial para lograrlo.

    days_vector <- c("0d", "3d", "6d", "9d", "12d", "15d", "18d", "21d", "24d" )
    names(wild_weight) <- days_vector
    names(knockout_weight) <- days_vector
    #No olvides decirle a R que te muestre el resultado:
    wild_weight
    knockout_weight

Vamos a realizar operaciones que nos ayuden a conocer a nuestros datos:

---
    #Calcular cuánto peso gano cada uno de los ratoncitos
    total_wild <- sum(wild_weight)
    total_knockout <- sum(knockout_weight)
---
    #¿El ratón knockout tiene mayor o menor peso que el control?:
    total_wild>total_knockout
    total_wild<total_knockout

Ustedes pueden realizar casi cualquier comparación que se les venga a mente, aquí les dejamos los operadores lógicos más usados en R:

`<`; Menor que

`>`; Mayor que

`<=`; Menor o igual a

`>=`; Mayor o igual a

`==`; Iguales entre sí

`¡=`; Diferentes entre si

Vamos a aprender a como crear una nueva variable basada en una selección:

    #Solo quiero ver los datos del día 6 al 24
    wild_selection <- wild_weight [3:9]
    wild_selection
---
    #Hacer una nueva variable basada en una comparación
    #Queremos saber en qué días el ratón knockdown perdió peso
    comparison_vector<- knockout_weight<0
---
    #Hay que colocar en un vector esos datos:
    weight_loss<- knockout_weight [comparison_vector]
    weight_loss

### **Matrices en R:**

Hasta este momento ya hemos conocido como trabajar con elementos unidimensionales en R, pero no es todo lo que podemos hacer, comenzaremos a trabajar con matrices. Una matriz en R se refiere a una colección de elementos con el mismo tipo de datos, arreglados en un determinado número de filas y columnas.
Tu puedes construir una matriz en R con la función `matrix()`. 

    #Construye tu primera matriz
    matrix (1:9, byrow = TRUE, nrow = 3)
---
    #Regresemos a los ratones, vamos a poner en una matriz los siguientes datos
    initial_weight <- c(20.2, 21.3)
    final_weight <- c(24.3, 21.1)
    tumor_volume <- c(50, 450)
---
    #Queremos poner todos esos datos en la matriz, primero lo pondremos dentro de una variable
    parameters <- c(initial_weight, final_weight, tumor_volume)
    matrix_parameters <- matrix(parameters, byrow = TRUE, nrow = 3)
    matrix_parameters
---
    # Invertir filas y columnas
    t(matrix_parameters)
---

Así como es importante nombrar las variables, hay que nombrar las matrices:

    #Coloca en un vector los nombres de las distintas condiciones que se encontraran en las filas y columnas
    name_parameters <- c("Initial weight (g)", "Final weight (g)", "Tumor volume (mm3)")
    condition <- c("Wild_type", "Knockout_CSF1")
---
    #Nombra las columnas con la condición
    colnames(matrix_parameters) <- condition
    #Nombra las filas con los parámetros que medimos
    rownames(matrix_parameters) <- name_parameters
---
    #Muestra como quedo la matriz:
    matrix_parameters

Días después de sacar el experimento ustedes terminan de cuantificar los valores de la proteína CSF1 por citometría de flujo y WB en los ratónes, ¿Se puede agregar una nueva fila que contenga estos datos en nuestra matriz?, la respuesta es SI, con la función `rbind()`, si quieren agregar columnas es con la función `cbind()`:

    #Lo primero es hacer la matriz con esos nuevos datos:
    expression_flow <- c(50.5, 10.1)
    expression_wb <- c(120, 23)
    expression_csf <- c(expression_flow, expression_wb)
    matrix_expression <- matrix(expression_csf, nrow =2, byrow =TRUE, 
                                dimnames = list (c("IMF_CSF1", "WB_CSF1" ), 
                                                c("Wild_type", "Knockdout_CSF1")))
    matrix_protein <- rbind (matrix_parameters, matrix_expression)
    matrix_protein
    t(matrix_protein)

Ahora, cómo podemos seleccionar elementos en nuestra matriz, no siempre queremos hacer operaciones con todos los datos. Para marcarle una selección a R siempre usamos `[]`, las matrices son bidimensionales, entonces necesitamos saber como decirle que nos seleccione una fila o una columna:

`my_first_matrix[1,]` selecciona todos los elementos de la primera fila

`my_first_matrix[,1]` selecciona todos los elementos de la primera columna

También podemos seleccionar más variables:

`my_first_matrix[1,2]` selecciona los elementos del primer renglón de la segunda columna

`my_first_matrix[5:8, 90:115]` selecciona  los datos de los renglones 5 al 8 y las columnas de la 90 a la 115

A practicar:

    #Selecciona los datos del knockout y colócalo en una variable:
    parameters_knockdown <- matrix_protein [,2]

    #Selecciona solo los datos datos de peso inicial y final
    parameters_weight <- matrix_protein [1:2, 1:2]

    #¿Cuál es la media de los pesos obtenidos?
    mean(parameters_weight)

`mean()` no es el único parámetro que puedes analizar, también se pueden sumas columnas o filas con las funciones `colSums()` y `rowSums()`, respectivamente.

### **Data frame en R:**

Como vieron, todos los elementos que tenia nuestra matriz eran del mismo tipo (númerico), pero que pasa si nosotros queremos poner elementos lógicos o caracteres en nuestro set de datos. Por ejemplo:

+ Subtipo de cancer, “luminal o basal” (caracteres)
+ Tratamiento , “SI” o “NO” (lógicos)

Lo primero que harémos es crear nuestro primer data frame usando la función `data.frame()`

    #Pon toda la información en vectores
    condition_df <- c("Wild_type", "Wild_type_tumor", "Knockout_CSF1", "Knockout_CSF1_tumor")
    ini_weight <- c(20.2, 20.5, 21.3, 22.5)
    fin_weight <- c(24.3, 23.5, 22.3, 21.1)
    tumor_injection<- c(FALSE, TRUE, FALSE, TRUE)
---
    #Crea un data frame a partir de tus vectores
    expe_mouse <- data.frame(condition_df, ini_weight, fin_weight, tumor_injection)
    expe_mouse
---
    #Revisa la estructura del data frame
    str(expe_mouse)
    summary(expe_mouse)

Vamos a trabajar con un data frame un tanto más grande, pero al que nos vamos a enfrentar comúnmente en los análisis OMICOS, lo primero es descaargar el archivo "expression_RNASeq.csv" (lo ajunto en la carpeta "R" de Github) y colocarlo en la carpeta de trabajo.

El siguente paso es leerlo en nuestro espacio de trabajo:

    #Leer data frame de datos de expresión de RNASeq
    expression_data <- read.csv("expression_RNASeq.csv")

Para comenzar a explorar los datos que tiene nuestro data frame podemos emplear las siguientes funciones; 

+ `head()`, nos muestra los primeros 6-10 renglones del data frame
+ `tail()`, nos muestra los últimos 6-10 renglones del data frame
+ `str()`, nos dice que tipo de archivo, cuan grande es y el tipo de datos que tiene cada columna.
+ `summary()`, también nos dice que tipo de archivo es, su tamaño, el tipo de datos, así como un análisis básico de aquellos datos que sean de tipo númericos
---
    head(expression_data)
    tail(expression_data)
    str(expression_data)
    summary(expression_data)

Las reglas para seleccionas elementos del data frame son las mismas que para las matrices, solo le vamos a sumar una más. En los data frame puedes usar el signo `$nombredelacolumna` para seleccionar una columna completa.

    #Selecciona el valor ubicado en la fila 1, columna 3
    expression_data[1,3]

    #Selecciona la fila 4
    expression_data[4,]

    #Selecciona los primeros 5 genes de la columna "hgnc_symbol"
    expression_data[1:5,"hgnc_symbol"]

    #Almacena en una variable los datos de p ajustada
    padj_values <- expression_data$padj
    padj_values


Un extra para seleccionar en data frame, apliquen la siguiente funcion `subset()` y describan que observan.

    #Selecciona los valores con Log2FC mayor a 2
    subset(expression_data, subset = log2FoldChange >2)

Finalmente, aprenderemos a como ordenar datos:

    #Sorting
    a <- c(100, 10, 1000)
    order(a)
    a[order(a)]
---
    #Usa la función order en la matriz de datos, para que los genes queden posicionados de acuerdo a su valor de expresión
    positions <- order(expression_data$log2FoldChange)

    #Usa el orden establecido en la variables positions para organizar todo el data frame
    expression_data[positions, ]

---
### **Ejercicio de R**

Realiza una selección para que únicamente te queden las columnas de los genes, los valores de log2FC, padj. Determina los valores estadisticos básicos y posicionalos de acuerdo al valor de padj.