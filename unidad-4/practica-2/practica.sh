#!/bin/bash


echo "Seleccione una opción:"
echo "1. Comprimir con el comando zip"
echo "2. Comprimir con el comando rar"
read opcion


echo "Ingrese el nombre de la carpeta a comprimir:"
read carpeta
echo "Ingrese el nombre del archivo comprimido:"
read archivo


mkdir $carpeta
touch $carpeta/index.html


if [ $opcion -eq 1 ]
then
    zip $archivo $carpeta
else
    rar a $archivo $carpeta
fi


echo "¿Desea descomprimir el archivo? (SI/NO)"
read respuesta


if [ $respuesta = "SI" ]
then
    mkdir practica-2/descomprimidos
    if [ $opcion -eq 1 ]
    then
        unzip $archivo -d practica-2/descomprimidos
    else
        unrar x $archivo practica-2/descomprimidos
    fi
fi



