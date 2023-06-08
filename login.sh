#!/bin/bash

read -p "Ingresa tu usuario: " user
read -p "Ingresa tu contraseña: " password

curl -X POST -H "Content-Type: application/json" -d '{"user":"'$user'", "password":"'$password'"}' https://tierra-nativa-api.eium.com.mx/api/ordinario-so/signUp

read -p "Ingresa tu usuario: " user
read -p "Ingresa tu contraseña: " password

response=$(curl -X POST -H "Content-Type: application/json" -d '{"user":"'$user'", "password":"'$password'"}' https://tierra-nativa-api.eium.com.mx/api/ordinario-so/logIn)

token=$(echo $response | jq -r '.token')

if [[ -z "$token" ]]; then
echo "Inicio de sesión fallido. Credenciales incorrectas."
exit 1
fi

filename="venta_productos_$(date +"%Y-%m-%d-%H-%M-%S").txt"

while true; do
read -p "Ingresa el nombre del producto (Escribe 'SALIR' para terminar): " name

if [[ "$name" == "SALIR" ]]; then
break
fi

read -p "Ingresa la descripción del producto: " description
created_date=$(date +"%Y-%m-%d")
read -p "Ingresa tu matrícula: " user
read -p "Ingresa el precio del producto: " price

curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $token" -d '{"name":"'$name'", "description":"'$description'", "created_date":"'$created_date'", "user":"'$user'", "price>

echo "Nombre: $name, Descripción: $description, Fecha: $created_date, Usuario: $user, Precio: $price" >> $filename
done

mv $filename COMPRAS/$filename


