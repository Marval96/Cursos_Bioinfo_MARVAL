#!/bin/bash

# Crear un directorio para almacenar los resultados
mkdir -p fastqc_results

# Analisis de calidad. La salida se guarda en el directorio creado
fastqc *.fastq -o fastqc_results/

# Resumen de los analisis de calidad guardando la salida en el directorio creado
multiqc fastqc_results/ -o fastqc_results/
