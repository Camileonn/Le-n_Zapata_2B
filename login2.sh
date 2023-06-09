#!/bin/bash




# REGISTRAR USUARIO
registrarusuario() {
    read -p "Ingrese su correo electrónico: " email
    read -p "Ingrese su contraseña: " password

    respuestaa=$(curl -s -X POST -H "Content-Type: application/json" -d '{"user":"'"$email"'", "password":"'"$password"'"}' "https://tierra-nativa-api.eium.com.mx/api/ordinario-so/signUp")
        echo  "USUARIO REGISTRADO YA PUEDE INGRESAR Y OBTENER PRODUCTOS"
        menu
}

# INICIARSESIONYOBTENERTOKEN
iniciar_sesion() {
    read -p "Ingrese su correo electrónico: " email
    read -p "Ingrese su contraseña: " password    # Realizar la solicitud POST para iniciar sesión
    respuestaa=$(curl -s -X POST -H "Content-Type: application/json" -d '{"user":"'"$email"'", "password":"'"$password"'"}' "https://tierra-nativa-api.eium.com.mx/api/ordinario-so/logIn")


    if [[ $respuestaa == *"token"* ]]; then
        token=$(echo "$respuestaa" | jq -r '.token')
        echo "Inicio de sesión exitoso. aqui tiene su token: $token"
        menu
    else
        echo "Credenciales incorrectas. No se puede acceder al programa."
        exit 1
    fi
}


archivoproductos() {
    local fecha_hora=$(date +"%Y-%m-%d_%H-%M-%S")
    local txtproductos="venta_productos_$fecha_hora.txt"
    touch "$txtproductos"
    echo "$txtproductos"

}


# CREARPRODUCTOS
crear(){

    while true; do
        read -p "Ingrese su token o SALIR para regresar al menu " token
        read -p "Ingrese su token o SALIR para regresar al menu " token
        if [ "$token" = "SALIR" ]; then
            break
        fi
        read -p "ingrese el nombre de su producto; " nombrep
        read -p "Ingrese la descripción del producto: " descripcionp
        read -p "Ingrese la matrícula del usuario: " matriculauser
        read -p "Ingrese el precio del producto: " preciop

        # Construir el JSON de datos del producto
        local json='{
            "name": "'"$nombrep"'",
            "description": "'"$descripcionp"'",
            "created_date": "'$(date +"%Y-%m-%d")'",
            "user": "'"$matriculauser"'",
            "price": "'"$preciop"'"
          }'

        # Enviar la solicitud POST con el token en el encabezado y guardar el resultado en el archivo
        curl -X POST -H "Authorization: Bearer $token" -H "Content-Type: application/json" -d "$json" https://tierra-nativa-api.eium.com.mx/api/ordinario-so/create-product >> "$txtproductos"
    done
}


txtproductos=$(archivoproductos)




hacer_archivocopia() {
    read -p "¿Desea hacer una copia del archivo de compra? Si desea hacerlo, escriba SI; para salir, escriba NO: " resp
    if [[ $resp == "SI" ]]; then
        cp "$txtproductos" COMPRAS/
        echo "Copia del archivo de compra realizada con éxito."
    fi
}



# Función para mostrar el menú de opciones
menu() {
    while true; do
        echo ".............MENU PRINCIPAL...................."
        echo "seleccione la opcion que desea realizar"
        echo "1. Registrar un usuario"
        echo "2. Iniciar sesión"
        echo "3. Crear un producto"
        echo "4. SALIR"

        read -p "Seleccione una opción: " option

        case $option in
            1)
                registrarusuario
                ;;
            2)
                iniciar_sesion
                ;;
            3)
                crear
                ;;
            4)
                hacer_archivocopia
                break
                ;;
            *)
                echo "Opción inválida. Inténtelo nuevamente."
                ;;
        esac
    done
}

menu



