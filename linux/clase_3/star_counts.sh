#!/bin/bash

# Script to do a count matrix from STAR to DESeq2

# Record start time
start_time=$(date +%s.%N)
# ----------------------

# Output file

OUTFILE="matrix_counts_DESeq2.txt"
STRAND_COL=2   # 2 = unstranded, 3 = forward, 4 = reverse

FILES=$(ls *_ReadsPerGene.out.tab | sort)

FIRST=1

for file in $FILES; do
    BASE=$(basename "$file" _ReadsPerGene.out.tab)

    if [[ $FIRST -eq 1 ]]; then
        # Primera muestra: gene + counts
        awk -v col=$STRAND_COL '$1 !~ /^N_/ {print $1 "\t" $col}' $file > $OUTFILE
        FIRST=0
    else
        # Solo counts de las demás muestras
        awk -v col=$STRAND_COL '$1 !~ /^N_/ {print $col}' $file > temp_counts.txt
        paste $OUTFILE temp_counts.txt > temp_matrix.txt
        mv temp_matrix.txt $OUTFILE
        rm temp_counts.txt
    fi
done

# Añadir encabezados
HEADER="Gene"
for file in $FILES; do
    BASE=$(basename "$file" _ReadsPerGene.out.tab)
    HEADER="$HEADER\t$BASE"
done
sed -i "1i$HEADER" $OUTFILE

echo "✅ Matrix for DESeq2 generated: $OUTFILE"


# ----------------------

# Time end
end_time=$(date +%s.%N)
execution_time=$(echo "$end_time - $start_time" | bc)

# Convert time to minutes and seconds
minutes=$(echo "scale=0; $execution_time / 60" | bc)
seconds=$(echo "scale=0; $execution_time % 60" | bc)
total_minutes=$(echo "$minutes + ($seconds > 0)" | bc)

echo "Counts matrix done"
echo "Execution time: $minutes minutos $seconds segundos."

# Mail notification
# Body mail
#BODY="The count matrix process has finished in: ${total_minutes} minutes."

# Send mail
#echo "$BODY" | mail -s "Notification: Count-Matrix-DESeq2" jhonatanraulm@gmail.com

# End of script
#echo "Done"
