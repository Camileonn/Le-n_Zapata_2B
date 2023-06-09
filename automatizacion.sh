#!/bin/bash

linklogin="https://tierra-nativa-api.eium.com.mx/api/ordinario-so/logIn"
read -p "Ingrese su matrícula: " matricula
read -s -p "Ingrese su contraseña: " password
echo

response=$(curl -s -X POST -H "Content-Type: application/json" -d "{\"matricula\":\"$matricula\", \"password\":\"$password\"}" $linklogin)

token=$(echo "$response" | jq -r '.token')

if [[ -z $token ]]; then
  echo "Error al obtener el token de autenticación. Verifique las credenciales."
  exit 1
fi

linkproductos="https://tierra-nativa-api.eium.com.mx/api/ordinario-so/get-products/$matricula"
fecha_hora=$(date +"%Y-%m-%d_%H-%M-%S")
archivop="CRONS/mis-archivos-$fecha_hora.txt"

curl -s -H "Authorization: Bearer $token" $linkproductos > $archivop

echo "Lista de productos es  :"
cat $archivop
echo "siguiente......................................................................."

# rwx= u, personal,g grupos, o todos lectura y escritura
chmod u=rwx,g=rwx,o=rwx $archivop

exit 0
