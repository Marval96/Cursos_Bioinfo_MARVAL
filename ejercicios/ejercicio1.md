# **Ejercicio: Comandos básicos en Linux**

### **Objetivo:**

Familiarizarse con el uso de la terminal de Linux mediante la simulación de la organización y manipulación de archivos que se utilizan en un análisis de RNA-seq.

Durante esta tarea practicarás:

- navegación en directorios
- creación y eliminación de archivos
- uso de *wildcards*
- redirección de salida
- permisos de archivos
- comandos de visualización

---

### 1. Preparando el entorno de trabajo

1. Verifica en qué directorio te encuentras usando:
2. Crea un directorio  para esta práctica cuyo nombre sea: *rnaseq_practica*
3. Entra al directorio y genra la siguiente estructura de directorios:

```
rnaseq_practica/
├── datos
├── scripts
├── resultados
```
5. Verifica que los directorios fueron creados usando:

### Preguntas

1. ¿Qué diferencia observas entre si ejecutas `ls` y `ls -lha`?
2. ¿Qué significa el punto (`.`) que aparece al inicio de algunos archivos o directorios?

---

### 2. Simulando archivos de RNA-seq

En un análisis de RNA-seq normalmente se tienen múltiples archivos FASTQ correspondientes a distintas muestras.

1. Entra al directorio `datos` y crea los siguientes archivos simulando datos de secuenciación:

```
tumor_rep1.fastq
tumor_rep2.fastq
tumor_rep3.fastq
control_rep1.fastq
control_rep2.fastq
control_rep3.fastq
```

---

### 3. Exploración y visualización de archivos

1. Crea un archivo llamado notas.txt y escribe dentro:

```
Inicio del análisis RNAseq
Datos simulados para práctica de Linux
```

2. ¿Cómo puedes visualizar el contenido del archivo usando?
3. Intenta mostrar solo las primeras líneas usando:

### Pregunta

¿En qué situaciones sería útil usar `head` o `tail` en lugar de `cat`?

---

### 4. Uso de wildcards

Usando comodines (`*`, `?`, etc.), realiza lo siguiente:

1. Lista únicamente los archivos `.fastq`.
2. Lista únicamente los archivos que pertenecen a **tumor**.
3. Lista únicamente los archivos que terminan en **rep1.fastq**.
4. Crea una carpeta llamada *backup* y copia todos los archivos `.fastq` a esa carpeta.

---

### 5. Eliminación selectiva de archivos

Un compañero decidió eliminar archivos usando el comando:

```bash
rm *.fastq
```

y borró todos los datos accidentalmente.

### Preguntas

1. ¿Qué hace el wildcard `*` en este contexto?
2. ¿Cómo podrías listar los archivos antes de borrarlos para evitar errores?
3. ¿Qué opción del comando `rm` podría ayudarte a confirmar antes de eliminar archivos?

Ahora elimina **únicamente los archivos control**.

---

### 6. Redirección de salida

Regresa al directorio principal de la práctica.

Crea un archivo llamado bitacora.txt y ejecuta:

```bash
echo "Inicio del análisis" > bitacora.txt
```

Después ejecuta:

```bash
echo "Archivos cargados correctamente" > bitacora.txt
```

Observa el contenido del archivo.

Ahora ejecuta:

```bash
echo "Paso de control de calidad completado" >> bitacora.txt
```

### Preguntas

1. ¿Qué diferencia observaste entre `>` y `>>`?
2. ¿Por qué es importante conocer esta diferencia?

---

### 7. Permisos en Linux

Entra al directorio `scripts` y crea el archivo:

```
qc.sh
```

Después cambia sus permisos para que sea ejecutable y Verifícalo.

### Preguntas

1. ¿Qué significan los permisos `r`, `w` y `x`?
2. ¿Qué hace el comando:

```bash
chmod 777 qc.sh
```

3. ¿Por qué podría ser una mala práctica usar `777`?

---

## **Nota**

+ Esta es una **tarea moral**. No es obligatoria, así que si decides no hacerla no pasa nada… aunque luego algunas cosas en clase puedan parecer misteriosamente complicadas, cada quien gestiona su propio destino académico.

+ Si algo se te complica, recuerda que Google, foros de apoyo, la IA e incluso hasta la documentación de los programas :S son herramientas válidas para resolver problemas. Saber usarlas también es parte del oficio bioinformático.
