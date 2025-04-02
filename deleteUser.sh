#!/bin/bash

# Mostrar los IDs y nombres de usuario antes de eliminar
sudo -u postgres psql -U postgres -d appusers -c "SELECT id, nombre FROM usuarios;"

# Solicitar el ID del usuario a eliminar
read -p "Selecciona el ID del usuario a eliminar: " id

# Validar que el ID ingresado es un número
if ! [[ "$id" =~ ^[0-9]+$ ]]; then
    echo "Error: Debes ingresar un número válido."
    exit 1
fi

# Ejecutar el comando en PostgreSQL
sudo -u postgres psql -U postgres -d appusers -c "DELETE FROM usuarios WHERE id = $id;"

# Verificar si el comando se ejecutó correctamente
if [ $? -eq 0 ]; then
    echo "Usuario eliminado con éxito!"
else
    echo "Error al eliminar el usuario."
fi

