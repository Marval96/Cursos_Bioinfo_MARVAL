#!/bin/bash

# Inicializar un contador
contador=1

# Ciclo while que cuenta hasta $1
while [ $contador -le $1 ]; do
    echo "Contador: $contador"
    ((contador++))
done
