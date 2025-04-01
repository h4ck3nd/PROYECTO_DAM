#!/bin/bash

echo "Instalando servicio de DDBB 'PostgreSQL'..."

apt install postgresql 2>/dev/null

echo "Iniciando servicio..."

systemctl start postgresql 2>/dev/null

echo "Cambiando credenciales al usuario 'postgres'..."

# Variables
USUARIO="postgres"               # Usuario para el que cambiarás la contraseña
NUEVA_CONTRASENA="1234"  # Nueva contraseña
DB_ADMIN="postgres"              # Usuario administrador para conectarse a la base de datos

# Cambiar la contraseña
sudo -u postgres PGPASSWORD="" psql -U $DB_ADMIN -d postgres -c "ALTER USER $USUARIO WITH PASSWORD '$NUEVA_CONTRASENA';"

echo "Contraseña de $USUARIO ha sido cambiada exitosamente."

echo "Creando DDBB para la APP"

sudo -u postgres psql -U postgres -f databaseCreate.sql

echo "Instalando requisitos..."

pip install -r requirements.txt

echo "Instalacion realizada con exito!"
