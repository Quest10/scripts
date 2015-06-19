#! /bin/bash
# Genera un archivo con una muestra de todas las fuentes disponibles en el sistema

directorio=`mktemp -d`
puntos=20
output="Font_list.jpg"

for fuente in `convert -list font | grep "Font" | awk '{print $2}'`; 
  do 
  convert -size 1000x25 xc:white -gravity Center \
    -font $fuente -pointsize $puntos -fill black  \
    -annotate +0+0 "$fuente  -- Tamaño: $puntos pt"\
    $directorio/$fuente.jpg
  done

montage -mode concatenate -tile 1x $directorio/* $output

echo "Cleaning temporary files"
rm -R $directorio