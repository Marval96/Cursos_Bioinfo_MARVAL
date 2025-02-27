# **Bash Script**

### **Introducción**

Como habrás notado puedes hacer tareas directamente en la terminal pero cuando tengas una tarea mayor y repetitiva frente a ti no es tan buena idea introducir el comando *n* cantidad de veces, esperando a que termine un proceso para ingresar el siguiente comando. Podemos hacer que la computadora trabaje para nosotros al unificar la secuencia de comandos y ejecutarlos al mismo tiempo. Así podríamos irnos a casa mientras la computadora trabaja.   

Automatizar un proceso es posible gracias a los **scripts**, un archivo ejecutable por un lenguaje de programación como R, Python o Bash. En el caso de Linux el empleado por el SO es Bash, si quieres saber que interprete de Shell (comandos por terminal) tiene tu equipo simplemente ejecuta:

    echo $SHELL
---
    > /bin/bash

Para crear un script de Bash usamos el editor de textos *nano* y lo guardamos con la extensión sh.

    nano mi_primer_script.sh

Una vez dentro del editor escribimos:

    #!/bin/bash
    echo "Hola, $USER"

Para ejecutar el el script:

    ./mi_primer_script.sh

**¿Cuál es el resultado? ¿El script funcionó? ¿Tiene idea de que pasó? ¿Comó defines $USER?**

Recordemos que Linux es un sistema multiusuario, es decir, varias personas pueden estar trabajando en él al mismo tiempo por lo que la gestión de recursos y de permisos es un aspecto clave. Para resolver esto, hay todo un sistema de permisos que te permiten realizar ciertas tareas. Veamos esto de forma práctica ejecutando:

    ls -lh
---
    > total 36K
    drwxr-xr-x 2 jrmarval jrmarval 4.0K Feb 26 23:20 .
    drwxr-xr-x 4 jrmarval jrmarval 4.0K Feb 26 23:16 ..
    -rwxr-xr-x 1 jrmarval jrmarval  580 Feb 22 11:35 ejercicio_for.sh
    -rwxr-xr-x 1 jrmarval jrmarval  179 Feb 22 11:35 ejercicio_if
    -rwxr-xr-x 1 jrmarval jrmarval  171 Feb 22 11:35 ejercicio_while.sh
    -rw-r--r-- 1 jrmarval jrmarval 6.7K Feb 22 11:35 mexico.jpg
    -rw-r--r-- 1 jrmarval jrmarval 7.9K Feb 26 23:40 readme.md
---

Este comando enlista los elementos del directorio actual de trabajo, pero también nos indica si se trata de un directorio o de un archivo. Además, nos indica los permisos que tiene cada uno de los elementos. Esto esta codificado en tercias de caracteres que corresponden a la actividad a realizar; **x:ejecutar | r:leer | w:escribir**. Esto es aplicable para tres tipos de usarios: propietario, grupos y otros.

Para dar los permisos de ejecución a un archivo se usa un código numérico.

    Leer        | 4
    Escribir    | 2
    Ejecutar    | 1


Por ejemplo, si queremos que un script tenga todos los permisos para todos los usuarios ejecutamos:

    ls -lh
---
    > -rw-r--r-- 1 jrmarval jrmarval 32 Feb 26 23:37 mi_primer_script.sh
---

    chmod 777 mi_primer_script.sh
---
    ls -lh
---
    > -rwxrwxrwx 1 jrmarval jrmarval 32 Feb 26 23:37 mi_primer_script.sh

Ahora, modifica los permisos necesarios para que solo tú (propietario) puedas ejecutar el archivo mi_primer_script.sh y verifica que los permisos hayan cambiado. Una vez hecho esto, ejecuta el script.

    ./mi_primer_script.sh

¿Qué será $USER? Se trata de una variable de entorno GLOBAL que contiene el usuario del sistema. El punto importante aquí es que podemos declarar variables (un contenedor de información) en Linux para mejorar nuestros programas. Editando un poco nuestro script:

    #!/bin/bash
    echo "Hola, $1"

¿Cuál será la salida? Pues en efecto será un saludo con el contenido de la variable $1, la cual se define en la línea de comandos:

    ./mi_primer_script.sh tu_nombre
---
    > Hola, tu_nombre

Ahora si quieres saber cuánto tiempo tardó en ejecutarse tu script puedes correr:

    time ./mi_primer_script.sh
---
    > Hola, Raul

    real    0m0.004s
    user    0m0.000s
    sys     0m0.004s

Con este ejemplo no verás muchas diferencias porque el proceso es muy rápido, pero en tareas que toman mucho tiempo, saber cuánto tarda en ejecutarse un proceso es muy útil para optimizar nuestro trabajo. Por ejemplo, el ensamble de secuencias de RNASeq o de Genoma podría demorar mucho tiempo. Esto también depende de los recursos computacionales con los que cuentes. Veamos el siguiente script:

    #!/bin/bash 
    # Obtener la fecha actual
    DATE=$(date)
    echo "El script inicia $DATE"
    echo  Hola, $1
    sleep 10
    # Obtener la fecha nuevamente
    DATE=$(date)
    echo Oye $1, el proceso ha terminado $DATE

¿Qué hace y cómo se comporta este script?

Cuando lanzamos un proceso que toma tiempo la terminal queda "secuestrada", lo cual es un impedimento para seguir trabajando. Para ello podemos lanzar el script en segundo plano:

    nohup ./mi_primer_scrip.sh Raul &

 Cada proceso genera un PID (Identificador de Procesos) y este puede ser rastreado para saber si mi proceso sigue en ejecución.
    
    ps -p <PID>
---
    ps aux | grep <PID>

Para ver todos los procesos de la computadora usamos el comando *top*.

Así como tenemos la capacidad de ejecutar procesos, también podemos deternerlos. Para ello requerimos conocer su PID y ejecutar el siguiente comando:

    kill -9 <PID>

Finalmente, veremos los *loops/ciclos/bucles* una manera de optimizar nuestros procesos, son una declaración de iteración, lo cual esto es realmente útil para tareas repetitivas. 

El primero ciclo que veremos será el *for*,  este realiza una tarea para una variable en un conjunto de elementos. 

    #!/bin/bash
    for i in 1 2 3 4 5; do
    echo "Hello $i"
    done

---

    #!/bin/bash
    # Ciclo for que imprime los números del 1 al $1
    for ((i = 1; i <= $1; i++)); do
        echo "Número: $i"
    done
    echo Ciclo finalizado. 

---

    #!/bin/bash
    for i in * ; do
        echo He trabajado con el archivo = $i
    done

También existen ciclos condicionales, es decir, que se realizan solo si se cumple con una condición y en caso de no hacerlo se realiza otra tarea. Por ejemplo: 

    #!/bin/bash

    # Ejemplo para emitir un mensaje con base en una condición

    edad=$1
    if [ $edad -ge 18 ]; then
        echo "Eres mayor de edad."
    else
        echo "Eres menor de edad."
    fi


[Material sobre Operadores](https://medium.com/enredando-con-linux/linux-shell-operadores-8f385713e8ad) 

Otro tipo de ciclo importante es el *while*, el cual ejecuta una función mientras una condición sea verdadera:

    #!/bin/bash
    # Inicializar un contador
    contador=1
    # Ciclo while que cuenta hasta $1
    while [ $contador -le $1 ]; do
        echo "Contador: $contador"
        ((contador++))
    done

---

### **Ejercicio:** 

1. Crea una carpeta llamada loop_for; coloca una imagen en ella y ponle el nombre que tú quieras. Ahora deberás generar esa imagen 5 veces usando el nombre que le diste como prefijo, seguida de un número (1-5) para distinguir cada imagen. Después deberás ponerlas en un fichero llamado new_name, pero ahora las imágenes llevaran el prefijo "figura" seguido del número que le corresponde. Realiza un script para esto y entre más automatizado se encuentre muchísimo mejor. 

2. Escribe un script que realice la tarea que tú quieras pero deberás emplear un ciclo *if* y/o *while*.

**Nota:** la computadora no piensa, solo hace cosas y a veces esas cosas no siempre son las que queremos. 














