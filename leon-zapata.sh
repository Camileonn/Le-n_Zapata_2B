#!/bin/bash

echo "seleccione una de las siguientes opciones"
echo "1. descargar url y guardarlo en un archivo con el nombre de una palabra" 
echo "2. consultar url y guardarlo en un jason"
echo "3. se le solicitara información para  que se envie a un url para guardarla en un  jason"

read option
if [$option -eq 1]
then
    read-p "introduce una URL" url
    read-p "ingrese una palabra para que sea el nombre de su archibo, si quieres salir escribe (no)" palabra
while["$palabra"!= no]
do
curl -o "$palabra.html" "$url"
read -p "introduce otra palabra (escribe no para salir )" palabra
done

elif[$option -eq 2 ]
then
curl -o "posts.json" "https://jsonplaceholder.typicode.com/posts"

elif[$option -eq 3]
then
read-p "introduce tu userid" userid
read-p "introduce un id" id
read-p "introduce un tittle" title
read-p "introduce un cuerpo" body

filename="${title}.json"

curl -X POST -H ""Content-Type: application/json" -d "{\"userId\": $userId, \"id\": $id, \"title\": \"$title\", \"body\": \"$body\"}" "https://jsonplaceholder.typicode.com/posts" -o "$filename"

else
echo "opción no valida"
fi

