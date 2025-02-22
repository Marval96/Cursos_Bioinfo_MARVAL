#!/bin/bash

mkdir new_name

# Nombre de la imagen original
imagen=$1

# Mover la imagen original y renombrarla como mexico_1.jpg
mv "$imagen" "mexico_1.jpg"

# Bucle para copiar la imagen 4 veces con nombres diferentes
for i in {2..5}; do
    cp "mexico_1.jpg" "mexico_$i.jpg"
done

echo "Se han creado 5 imágenes con nombres distintos."

# Mover y renombrar las imágenes al directorio new_name con el prefijo "figura"

for i in {1..5}; do
    cp "mexico_$i.jpg" "new_name/figura$i.jpg"
done

echo "Se han creado 5 imágenes con nombres distintos en el directorio new_name."


