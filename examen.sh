#!/bin/bash

get_endpoint="https://tierra-nativa-api.eium.com.mx/api/examen-U3/get-products-2B/13160606"
post_endpoint="https://tierra-nativa-api.eium.com.mx/api/examen-U3/create-product-2B"

while true; do
  echo "Seleccione una opción:"
  echo "1. Realizar solicitud GET"
  echo "2. Realizar solicitud POST"
  echo "3. Salir"

  read opcion

  if [ "$opcion" = "1" ]; then
    echo "Ingrese su matrícula:"
    read matricula

    get_request_url="${get_endpoint/\{matricula\}/$matricula}"

    curl -X GET "$get_request_url"

  elif [ "$opcion" = "2" ]; then
    echo "Ingrese el nombre del producto (máximo 100 caracteres):"
    read name

    echo "Ingrese la descripción del producto (máximo 150 caracteres):"
    read descripcion

    created_date=$(date +%Y-%m-%d)

    echo "Ingrese su matrícula:"
    read matricula

    send_post_request() {
      local name="$1"
      local descripcion="$2"
      local created_date="$3"
      local matricula="$4"

      curl -X POST -H "Content-Type: application/json" -d '{
        "name": "'"$name"'",
        "description": "'"$descripcion"'",
        "created_date": "'"$created_date"'",
        "user": "'"$matricula"'"
      }' "$post_endpoint"
    }

    send_post_request  "$name" "$descripcion" "$created_date" "$matricula"

  elif [ "$opcion" = "3" ]; then
    break
  else
    echo "Opción inválida. Por favor, seleccione una opción válida."
  fi
done

