# **Linux en Análisis Bioinformáticos**

**Anaconda/Conda**

Conda es un sotfware enfocado en la gestión de paquetes para evitar incompatibilidades, crea una especie de burbuja para instalar una serie de programas sin causar problemas entre ellos (eso es lo ideal). Esto muy útil porque los programas se valen de *dependencias* para trabajar, es decir, necesitan de otros programas para poder funcionar y en ocasiones hay algunos que no se llevan bien entre ellos, o que las versiones  ya no son comptibles... todo este tipo de problemas lo soluciona [Conda](https://docs.conda.io/en/latest/) en la mayoría de los casos.

Resulta una herramienta de gran valor en la bionformática, nos permite trabajar con versiones específicas de manera aislada en el equipo global. Imaginemos que todos nosotros nos conectamos al mismo cluster para trabajar, gestionar todas los programas necesarios para nuestro trabajo resultaría en un caos, en cambio si cada uno puede tener su propio espacio de trabajo sin influir en el sistema de los demás representa una enorme ventaja.

En esta sección veremos como instalar Conda en nuestros equipos y haremos un pequeño ejercico para ver como se trabaja con estas herramientas por línea de comandos. Pero primero debos actualizar la lista de paquetes de de nuestro sistema operativo:

        sudo apt update
---
        sudo apt upgrade

Ahora si podemos realizar la instalación de Conda:

1. Descarga el instalador adecuado para tu SO de [Miniconda](https://docs.conda.io/projects/miniconda/en/latest/), para ello da click derecho sobre el instlador y copia el enlace.
2. Abre tu terminal Linux, escribe wget, pega el enlace que copiaste y ejecuta:
    
        wget enlace_conda

3. Cuando términe verás que se descargo un archico con extensión *.sh*. Deberás ejecutarlo:

        sh fileconda.sh
    
    Confirma lo que te sea requerido. Al finaliza cierra tu terminal y abrela de nuevo (esto es para reiniciar el Shell).

[Vídeo de apoyo](https://youtu.be/P6eGTN9QN2Q?si=UtVllFqq7E03tt9B)

Para este punto ya tenemos instalado Conda ¿Notas algo distinto? Ahora vamos a usar Conda. 

+ Para crear un ambiente conda:
            
        conda create --name nombredelambiente biopython --y

+ Para activar el ambiente:

        conda activate nombredelambiente

+ Para desactivarlo: 
  
        conda deactivate

+ Para eliminarlo:

        conda env remove --name mi_ambiente

+ Para **instalar un herramienta debemos situarnos dentro de nuestro ambiente activo**. Después buscamos el link de instalación de nuestra herramienta en la página de conda, lo pegamos en la terminal, ejecutamos y listo. Por ejemplo: voy a instalar un programa llmado [FastQC](https://anaconda.org/bioconda/fastqc).

        conda install -c bioconda fastqc

### **Ejercicio:**
+ Instala FastQC y MultiQC en un ambiente conda.
+ Descargar las dos primeras muestras de esta liga: https://github.com/hartwigmedical/testdata/tree/master/100k_reads_hiseq/TESTX

+ ¿Para qué son estás herramientas y cómo las utilizamos?

FastQC nos permite ejecutar un análisis de calidad en datos obtenidos por secuenciación masiva (.fastq) para evaluar el estado de nuestras lecturas y saber si son o no confibles dentro de nuestro flujo de trabajo. En tanto MultiQC en este caso nos ofrece la ventaja de agrupar todos los resumenes de nuestras lecturas en un solo archivo.

Para ejecutar FastQC debemos llamar a la herrmaineta y decirle sobre que archivos debe trabajar. En este caso voy a escribir:

        fastqc *.fastq

Esto genera los reportes de calidad de todos los archivos que contengan la extensión **.fastq** dentro de mi directorio de trabajo. Ahora para sintetizar todos esos reportes en uno solo usaremos MultiQC:

        multiqc .

Lo ideal sería realizar un script. Una manera d automatizar la tarea es: 

    #!/bin/bash

    # Crear un directorio para almacenar los resultados
    mkdir -p fastqc_results

    # Analisis de calidad. La salida se guarda en el directorio creado
    fastqc *.fastq -o fastqc_results/

    # Resumen de los analisis de calidad guardando la salida en el directorio creado
    multiqc fastqc_results/ -o fastqc_results/

¿Qué archivos aparecen en el directorio? ¿Cómo podrías visualizar los resultados? Ejecuta:

        firefox fastqc_results/multiqc_report.html

Ahora vamos a generar un reporte usando el lenguaje Markdown. Para conocer la  sintaxis del [lenguaje Markdown](https://www.markdownguide.org/basic-syntax/) puedes consultar guías o documentaciones en internet. El archivo [reporte.md](reporte.md) es un ejemplo de como puedes comenzar a documentar tus análisis, tal y como lo harías con una bitácora de laboratorio.

---

**Ahora estás listo para iniciar tu próximo análisis bioinformático de una manera más organizada.**

![*May the force be with you!*](bioinformatics.jpg)








