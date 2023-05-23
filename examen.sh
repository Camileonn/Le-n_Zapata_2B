#!/bin/bash


get_metodo="https://tierra-nativa-api.eium.com.mx/api/examen-U3/get-products-2B/13160606"
post_metodo="https://tierra-nativa-api.eium.com.mx/api/examen-U3/create-product-2B"

#  POST
send_post_request() {
  local matricula="$1"
  local name="$2"
  local description="$3"
  local fecha="$4"
  curl -X POST -H "Content-Type: application/json" -d '{
    "name": "'"$name"'",
    "description": "'"$description"'",
    "fecha": "'"$"fecha'",
    "user": "'"$matricula"'"
  }' "$post_metodo"
}

# Función de get
send_get_request() {
  local matricula="$1"
  response=$(curl -s "$get_metodo$matricula")
  #JASONXD
  echo "$response" > products.json
  tar -cf products.tar products.json
  cat products.json | jq -r '.[:3] | "\(.id_product)---\(.name)\n\(.description)"'
}

while true; do
  echo "Seleccione una opción:"
  echo "1. Realizar POST"
  echo "2. Realizar solicitud GET"
  echo "3. Salir del programa"
  read option
  case $option in
    1)
      echo "Ingrese la matrícula del alumno:"
      read matricula
      echo "Ingrese el nombre del producto (máximo 100 caracteres):"
      read name
      echo "Ingrese la descripción del producto (máximo 150 caracteres):"
      read description
      fecha=$(date "+%Y-%m-%d")
      send_post_request "$matricula" "$name" "$description" "$fecha"
      echo "Solicitud POST realizada con éxito."
      ;;
    2)
      echo "Ingrese su matrícula para recuperar los productos:"
      read matricula
      send_get_request "$matricula"
      ;;
    3)
      echo "gracias xd"
      exit 0
      ;;
    *)
      echo "ingrese una opción valida"
      ;;
  esac
done


