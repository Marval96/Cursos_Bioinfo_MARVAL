# Reporte de Análisis de Calidad NGS  

**Autor:** Fulan@ de tal

**Fecha:** *muy muy lejano* a tal de tal

**Herramientas usadas:** *FastQC y MultiQC*

**Objetivo:** determinar la calidad de secuención de neustras muestras, obtenidas por *NGS* en formato *fastq*.

---

## Introducción  
Este reporte documenta el análisis de calidad de las secuencias FASTQ utilizando **FastQC** versión 'xy'  y **MultiQC** versión 'xy'.
Se evaluaron los parámetros clave como la calidad por base, contenido de GC y presencia de adaptadores.

## Comandos utilizados  
Los siguientes comandos se usaron para procesar los archivos de secuenciación:

    #!/bin/bash

    # Crear un directorio para almacenar los resultados
    mkdir -p fastqc_results

    # Analisis de calidad. La salida se guarda en el directorio creado
    fastqc *.fastq -o fastqc_results/

    # Resumen de los analisis de calidad guardando la salida en el directorio creado
    multiqc fastqc_results/ -o fastqc_results/

El reporte de calidad MultiQC se pude consultar ejecutando:

    firefox fastqc_results/multiqc_report.html

**Nota:** aquí pueden añadir una descripción del proceso, reportar algunos aspectos claves o técnicos sobre en análisis a fin de hacer su trabajo más reproducible y consistente.
