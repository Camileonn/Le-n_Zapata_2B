#!/bin/bash

echo "Seleccione una de las siguientes opciones:"
echo "1. Descargar contenido de URL y guardar en archivo con palabra personalizada"
echo "2. Consultar URL y guardar resultado en archivo"
echo "3. Enviar datos por POST a URL y guardar resultado en archivo"
read opcion

if [ $opcion -eq 1 ]
then
    read -p "Introduce una URL: " url
    read -p "Introduce una palabra (escribe NO para salir): " palabra

    while [ "$palabra" != "NO" ]
    do
        curl -o "$palabra.html" "$url"
        read -p "Introduce otra palabra (escribe NO para salir): " palabra
    done

elif [ $opcion -eq 2 ]
then
    curl -o "posts.json" "https://jsonplaceholder.typicode.com/posts"

elif [ $opcion -eq 3 ]
then
    read -p "Introduce userId: " userId
    read -p "Introduce id: " id
    read -p "Introduce title: " title
    read -p "Introduce body: " body
    filename="${title}.json"

    curl -X POST -H "Content-Type: application/json" -d "{\"userId\": $userId, \"id\": $id, \"title\": \"$title\", \"body\": \"$body\"}" "https://jsonplaceholder.typicode.com/posts" -o "$filename"

else
    echo "Opción no válida"
fi

