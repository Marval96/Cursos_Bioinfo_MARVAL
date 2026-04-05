# **Linux en Análisis Bioinformáticos**

**Anaconda/Conda**

Conda es un sotfware enfocado en la gestión de paquetes para evitar incompatibilidades, crea una especie de burbuja para instalar una serie de programas sin causar problemas entre ellos (eso es lo ideal). Esto muy útil porque los programas se valen de *dependencias* para trabajar, es decir, necesitan de otros programas para poder funcionar y en ocasiones hay algunos que no se llevan bien entre ellos, o que las versiones  ya no son comptibles... todo este tipo de problemas lo soluciona [Conda](https://docs.conda.io/en/latest/) en la mayoría de los casos.

Resulta una herramienta de gran valor en la bionformática, nos permite trabajar con versiones específicas de manera aislada en la computadora. Imaginemos que todos nosotros nos conectamos al mismo cluster para trabajar, gestionar todas los programas necesarios para nuestro trabajo resultaría en un caos, en cambio si cada uno puede tener su propio espacio de trabajo sin influir en el sistema de los demás representa una enorme ventaja.

En esta sección veremos como instalar Conda en nuestros equipos y haremos un pequeño ejercico para ver como se trabaja con estas herramientas por línea de comandos. Pero primero debemos actualizar la lista de paquetes de de nuestro sistema operativo:

        sudo apt update
---
        sudo apt upgrade

Ahora si podemos realizar la instalación de Conda:

1. Descarga el instalador adecuado para tu SO de [Miniconda](https://docs.conda.io/projects/miniconda/en/latest/), para ello da click derecho sobre el instlador y copia el enlace.
2. Abre tu terminal Linux, escribe wget, pega el enlace que copiaste y ejecuta:
    
        wget enlace_conda

3. Cuando términe verás que se descargo un archico con extensión *.sh*. Deberás ejecutarlo:

        sh fileconda.sh

Confirma lo que te sea requerido. Al finaliza cierra tu terminal y abrela de nuevo (esto es para reiniciar el Shell). Puedes usar el comando:

        reset

[Vídeo de apoyo](https://youtu.be/P6eGTN9QN2Q?si=UtVllFqq7E03tt9B)

Para este punto ya tenemos instalado Conda ¿Notas algo distinto? Ahora vamos a usar Conda ¿lodudas?

        conda --version

+ Para crear un ambiente conda:
            
        conda create --name nombredelambiente biopython --y

+ Para activar el ambiente:

        conda activate nombredelambiente

+ Para desactivarlo: 
  
        conda deactivate

+ Para eliminarlo:

        conda env remove --name mi_ambiente

+ Para **instalar un herramienta debemos situarnos dentro de nuestro ambiente activo**. Después, buscamos el link de instalación de nuestra herramienta en la página de conda, lo pegamos en la terminal, ejecutamos y listo. Por ejemplo: voy a instalar un programa llmado [FastQC](https://anaconda.org/bioconda/fastqc).

        conda install -c bioconda fastqc

### **Ejercicio:**
+ Instala FastQC y MultiQC en un ambiente conda.
+ Descargar todas las muestras de esta liga: https://github.com/hartwigmedical/testdata/tree/master/100k_reads_hiseq/TESTX

+ ¿Para qué son estás herramientas y cómo las utilizamos?

FastQC nos permite ejecutar un análisis de calidad en datos obtenidos por secuenciación masiva (.fastq) para evaluar el estado de nuestras lecturas y saber si son o no confibles dentro de nuestro flujo de trabajo. En tanto MultiQC en este caso nos ofrece la ventaja de agrupar todos los resumenes de nuestras lecturas en un solo archivo.

Para ejecutar FastQC debemos llamar a la herrmaineta y decirle sobre que archivos debe trabajar. En este caso voy a escribir:

        fastqc *.fastq

Esto genera los reportes de calidad de todos los archivos que contengan la extensión **.fastq** dentro de mi directorio de trabajo. Ahora para sintetizar todos esos reportes en uno solo archivo usaremos MultiQC:

        multiqc .

Lo ideal sería realizar un script. Una manera de automatizar la tarea es: 

    #!/bin/bash

    # Crear un directorio para almacenar los resultados
    mkdir -p fastqc_results

    # Analisis de calidad. La salida se guarda en el directorio creado
    fastqc *.fastq -o fastqc_results/

    # Resumen de los analisis de calidad guardando la salida en el directorio creado
    multiqc fastqc_results/ -o fastqc_results/

¿Qué archivos aparecen en el directorio? ¿Cómo podrías visualizar los resultados? Ejecuta:

        firefox fastqc_results/multiqc_report.html

Ahora vamos a generar un reporte usando el lenguaje Markdown. Para conocer la  sintaxis del [lenguaje Markdown](https://www.markdownguide.org/basic-syntax/) puedes consultar guías o documentaciones en internet. El archivo [reporte.md](reporte.md) es un ejemplo de como puedes comenzar a documentar tus análisis, tal y como lo harías en una bitácora de laboratorio.

## **Ensamblaje transcriptómico**

Para este paso usaremos [STAR](https://pmc-ncbi-nlm-nih-gov.translate.goog/articles/PMC3530905/?_x_tr_sl=en&_x_tr_tl=es&_x_tr_hl=es&_x_tr_pto=tc). Es importante instalar la herramienta en un ambiente [Conda](https://anaconda.org/channels/bioconda/packages/star/overview) usando el comando:

        conda install bioconda::star

La documentación de la herramienta esta disponible [aquí.](https://github.com/alexdobin/STAR)

En este ejercico vamos a trabajar con datos públicos obtenidos del SRA con número de acceso [PRJNA612970](https://www.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA612970&o=acc_s%3Aa). 

| Característica             | Valor                                           |
|-----------------------------|------------------------------------------------|
| BioProject                  | PRJNA612970                                    |
| Consent                     | public                                         |
| Assay Type                  | RNA-Seq                                        |
| AvgSpotLen                  | 202                                            |
| cell_line                   | FaDu                                           |
| Center Name                 | GEO                                            |
| DATASTORE filetype          | fastq, run.zq, sra                             |
| DATASTORE provider          | gs, ncbi, s3                                  |
| DATASTORE region            | gs.us-east1, ncbi.public, s3.us-east-1       |
| Instrument                  | Illumina NovaSeq 6000                          |
| LibraryLayout               | PAIRED                                         |
| LibrarySelection            | cDNA                                           |
| LibrarySource               | TRANSCRIPTOMIC                                 |
| Organism                    | Homo sapiens                                   |
| Platform                    | ILLUMINA                                       |
| ReleaseDate                 | 2021-03-07                                    |
| version                     | 1                                              |
| source_name                 | Head and neck tumor                            |
| SRA Study                   | SRP253044                                      |
| tissue                      | Head and neck tumor cell line                  |

---

| # | Run        | BioSample    | Bases   | Bytes   | Experiment  | Genotype | GEO_Accession | Create_date           | Sample Name   |
|---|------------|--------------|--------|---------|------------|----------|---------------|---------------------|---------------|
| 1 | SRR11319298 | SAMN14389440 | 9.07 G | 2.60 Gb | SRX7923629 | WT       | GSM4416566    | 2020-03-17 18:44:00 | GSM4416566    |
| 2 | SRR11319299 | SAMN14389439 | 8.16 G | 2.35 Gb | SRX7923630 | WT       | GSM4416567    | 2020-03-17 16:23:00 | GSM4416567    |
| 3 | SRR11319300 | SAMN14389438 | 9.89 G | 2.84 Gb | SRX7923631 | WT       | GSM4416568    | 2020-03-17 14:49:00 | GSM4416568    |
| 4 | SRR11319301 | SAMN14389437 | 9.65 G | 2.77 Gb | SRX7923632 | STING-/- | GSM4416569    | 2020-03-18 00:01:00 | GSM4416569    |
| 5 | SRR11319302 | SAMN14389436 | 11.01 G | 3.17 Gb | SRX7923633 | STING-/- | GSM4416570    | 2020-03-17 23:44:00 | GSM4416570    |
| 6 | SRR11319303 | SAMN14389435 | 12.05 G | 3.45 Gb | SRX7923634 | STING-/- | GSM4416571    | 2020-03-18 03:28:00 | GSM4416571    |
| 7 | SRR11319304 | SAMN14389434 | 11.34 G | 3.26 Gb | SRX7923635 | IrrWT       | GSM4416572    | 2020-03-18 02:46:00 | GSM4416572    |
| 8 | SRR11319305 | SAMN14389433 | 10.86 G | 3.14 Gb | SRX7923636 | IrrWT       | GSM4416573    | 2020-03-18 00:01:00 | GSM4416573    |
| 9 | SRR11319306 | SAMN14389432 | 10.47 G | 2.99 Gb | SRX7923637 | IrrWT       | GSM4416574    | 2020-03-17 22:20:00 | GSM4416574    |
| 10 | SRR11319307 | SAMN14389431 | 9.17 G | 2.62 Gb | SRX7923638 | IrrSTING-/- | GSM4416575    | 2020-03-17 14:35:00 | GSM4416575    |
| 11 | SRR11319308 | SAMN14389430 | 8.48 G | 2.44 Gb | SRX7923639 | IrrSTING-/- | GSM4416576    | 2020-03-17 14:43:00 | GSM4416576    |
| 12 | SRR11319309 | SAMN14389429 | 8.30 G | 2.40 Gb | SRX7923640 | IrrSTING-/- | GSM4416577    | 2020-03-17 14:43:00 | GSM4416577    |

Por el momento no es necesario bajar todas las muestras, considera que en promedio cada una pesa 9Gb. Entonces, si te es posible descarga solo las muestas: SRR11319298, SRR11319299, SRR11319300, SRR11319307, SRR11319308 y SRR11319309, las cuales corresponden a una condición control (WT) y otra experimental (IrrSTING-/-) con triplicado biológico cada una. Si quieres conocer más sobre estos datos revisa la publicación original [aquí.](https://pmc.ncbi.nlm.nih.gov/articles/PMC8055995/#Abs1)

Para trabajar con los archivos del SRA necesitarán implementar la herramienta [*SRA Toolkit](https://www.ncbi.nlm.nih.gov/sra/docs/sradownload/). Ejecuta la herramienta descargando el archivo binario de instalación o bien con ayuda de Conda.

La descarga y conveersión de las muestras SRA  FastQC se puede hacer de la siguiente manera:

        #!/bin/bash

        # Activar SRA Toolkit
        export PATH=$PATH:/home/jrmarval/rnaseq_fadu/rnaseq_sab/sratoolkit.3.2.1-ubuntu64/bin

        # Temporizador: inicio
        START=$(date +%s)

        # Automatizacion de la descarga de los datos de SRA

        # Descarga manual
        prefetch SRR11319298 --progress
        prefetch SRR11319299 --progress
        prefetch SRR11319300 --progress
        prefetch SRR11319307 --progress
        prefetch SRR11319308 --progress
        prefetch SRR11319309 --progress

        # Convierte a FASTQ
        fasterq-dump --split-files SRR11319298.sra --progress
        fasterq-dump --split-files SRR11319299.sra --progress
        fasterq-dump --split-files SRR11319300.sra --progress
        fasterq-dump --split-files SRR11319307.sra --progress
        fasterq-dump --split-files SRR11319308.sra --progress
        fasterq-dump --split-files SRR11319309.sra --progress

        # Temporizador: fin
        END=$(date +%s)
        ELAPSED=$((END-START))
        echo "Tiempo total de ejecución: $ELAPSED segundos"

        # Fin del script
        echo "Done"


Con la intención de facilitarles el análsis, he recortado los archivos originales, conservando solo 1000 lecturas por archivo. De esta manera el análsis será más ligero computacionalmente para que puedan ejecutarlo en su computadora. Los archivos se generaron de esta manera:

        #!/bin/bash

        # Recortar los archivos FASTQ a las primeras 4000 líneas
        mkdir -p sub_fastq_files
        for f in *.fastq
        do
        echo "Recortando $f a las primeras 4000 líneas..."
        head -n 4000 "$f" > sub_fastq_files/"$f"
        done


**Con base en estos archivos realiza el análisis de calidad de las lecturas con FastQC y MultiQC. Posteriormente, corre el alineamineto con STAR.** Recuerda que STAR requiere un índice previamente generado, con base en el genoma de referencia y y el archivo de anotación GTF, los cuales puedes obtener del [NCBI RefSeq assembly](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000001405.26/). El código empleado para la genración del índice es:

        #!/bin/bash
        ulimit -n 10000

        # Code to generate the index for STAR
        STAR --runThreadN 15 --runMode genomeGenerate --genomeDir Genome/ --genomeFastaFiles \
        Genome/GCF_000001405.26_GRCh38_genomic.fna --sjdbGTFfile Genome/genomic.gtf \ 
        --sjdbOverhang 100

        # Fin del script
        echo "Done"

Es importante considerar que el uso del Genoma de Referencia completo puede ocasionar un uso elevado de la memoria RAM.Para evitar esto, usaremos solo el cromosoma 22 como referencia, lo cual no permitirá hacer el alineamiento en nuestras computadoras personales a manera de demostración. Así podremos entender mejor como se ejecutra este paso del ensablaje de tranascriptómico y posteiromente poder repetir el proceso en un servidor con datos reales. 

La construcción del indice de referencia con el cromosoma 22 requiere de [Samtools](https://anaconda.org/channels/bioconda/packages/samtools/overview), instálalo mediante Conda. El código empleado para generar el genoma de refencia del cromosoma 22 es:

        samtools faidx GCF_000001405.26_GRCh38_genomic.fna NC_000022.11 > genome_chr22.fa

El código empleado apra generar el archivo de anotación GTF del cromosoma 22 es:

        grep -w "NC_000022.11" genomic.gtf > genes_chr22.gtf

Ahora con estos dos archivos dentro de la carpeta *Genome_chr22*, podemos generar el indice y posteriormete el alineamiento. 
Para generar el indice ejecuta:

        #!/bin/bash

        # Iniciar el temporizador
        start_time=$(date +%s.%N)

        ulimit -n 10000

        # Code to generate the index for STAR
        mkdir Genome_chr22

        STAR \
        --runThreadN 20 \
        --runMode genomeGenerate \
        --genomeDir Genome_chr22 \
        --genomeFastaFiles Genome_chr22/genome_chr22.fa \
        --sjdbGTFfile Genome_chr22/genes_chr22.gtf \
        --sjdbOverhang 100

        # Finalizar el temporizador
        end_time=$(date +%s.%N)
        execution_time=$(echo "$end_time - $start_time" | bc)

        # Convertir el tiempo a minutos y segundos
        minutes=$(echo "scale=0; $execution_time / 60" | bc)
        seconds=$(echo "scale=0; $execution_time % 60" | bc)
        total_minutes=$(echo "$minutes + ($seconds > 0)" | bc)

        echo "Indexing done"
        echo "Execution time: $minutes minutos $seconds segundos."


**Ejercicio:** 
+ Si no lograste descargar los genomas de referecnia del NCBI y generar las referencias del cromosoma 22, puedes descargar la referencia del cromosoma 22 desde [aquí.](https://drive.google.com/drive/folders/1qa9G2WkNgsgVhOd1SR_0i5PiW45liCgb?usp=sharing) y usarla para el alineamiento.
+ Diseña tu script para ejecturar el alineamiento con STAR. En el script *alignment_star.sh * estamos considerando usar 6 CPUs y y 6Gb de RAM. Puedes adecuarlo a los recursos computacionales de tu equipo.
+ Una vez realizado el alineamiento, revisa la calidad del mismo con MultiQC.
+ Con base en los archivos *ReadsPerGene.out.tab* genera la matriz de expresión de estas muestras. Recuerda que esta matriz tiene los genes en las filas y las condicones en las columnas. 

Puedes apotyarte del script *star_counts.sh* para generar la matriz de expresión: *matrix_counts_DESeq2.txt*

---

**Ahora estás listo para iniciar tu próximo análisis bioinformático de una manera más organizada.**

![*May the force be with you!*](bioinformatics.jpg)
---


