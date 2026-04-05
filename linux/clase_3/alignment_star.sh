#!/bin/bash

# Script to do RNAseq alignment using STAR

# Record start time
start_time=$(date +%s.%N)
# ----------------------

# STAR files permission issue fix
ulimit -n 10000

# Alignment process

# Output directory 
OUTDIR="star_out"

# Loop for all fastq files
for R1 in *_1.fastq
do
    # basename (remove _1.fastq)
    BASE=$(basename $R1 _1.fastq)
    R2=${BASE}_2.fastq
    mkdir -p ${OUTDIR}/${BASE}

    echo "Process sample: $BASE"

    STAR \
        --genomeDir /home/jrmarval/rnaseq_fadu/Genome_chr22 \
        --limitBAMsortRAM 6000000000 \
        --sjdbOverhang 100 \
        --readFilesIn $R1 $R2 \
        --runThreadN 6 \
        --outFileNamePrefix ${OUTDIR}/${BASE}_ \
        --outSAMtype None \
        --quantMode GeneCounts
        

done

# ----------------------

# Time end
end_time=$(date +%s.%N)
execution_time=$(echo "$end_time - $start_time" | bc)

# Convert time to minutes and seconds
minutes=$(echo "scale=0; $execution_time / 60" | bc)
seconds=$(echo "scale=0; $execution_time % 60" | bc)
total_minutes=$(echo "$minutes + ($seconds > 0)" | bc)

echo "Alignment done"
echo "Execution time: $minutes minutos $seconds segundos."

# End of script
echo "Done"
