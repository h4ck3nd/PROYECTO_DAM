##################################################################
# Importación de librerías necesarias para el backend y frontend #
##################################################################

import flet as ft
from flask_cors import CORS
from flet import Page
import psycopg2
import psycopg2.extras
import uuid
from werkzeug.security import generate_password_hash, check_password_hash
import re
import jwt
from datetime import datetime, timedelta
import time
import requests

from flask import Flask, request, jsonify, session, redirect, make_response, abort
import threading

##########################
# Clave secreta para JWT #
##########################

SECRET_KEY = "clave_super_secreta" # Clave secreta utilizada para firmar y verificar los tokens JWT

#######################
# Configuración Flask #
#######################
app = Flask(__name__) # Inicialización de la aplicación Flask

##########################################
# Conexión a la base de datos PostgreSQL #
##########################################

def connect_db(): # Función para conectarse a la base de datos PostgreSQL
    return psycopg2.connect(
        dbname="appusers",
        user="postgres",
        password="1234",
        host="localhost",
        port="5432"
    )

#############################################################
# Generación de token JWT a partir de los datos del usuario #
#############################################################

def generate_token(user_data):
    payload = {
        "user_id": user_data["id"],
        "usuario": user_data["usuario"],
        "email": user_data["email"],
        "nombre": user_data["nombre"],
        "apellidos": user_data["apellidos"],
        "cookie": user_data["cookie"],  # Aquí guardas la cookie del usuario
        "rol": user_data["rol"],  # Aquí incluyes el rol
        "ultimo_login": user_data["ultimo_login"],  # Aquí guardas el último inicio de sesión
        "exp": datetime.utcnow() + timedelta(hours=1)  # Expiración del token en 1 hora
    }
    return jwt.encode(payload, SECRET_KEY, algorithm="HS256")

#########################################################################
# Verificación del token JWT recibido, controlando expiración y validez #
#########################################################################

def verify_token(token):
    try:
        return jwt.decode(token, SECRET_KEY, algorithms=["HS256"])
    except jwt.ExpiredSignatureError:
        return None
    except jwt.InvalidTokenError:
        return None

###################################################################
# Validación del nombre de usuario mediante una expresión regular #
###################################################################

def is_valid_username(usuario):
    return bool(re.match("^[a-zA-Z0-9_]+$", usuario))

#######################################################################################################
# Registro de un nuevo usuario en la base de datos, incluyendo generación de cookie y password (hash) #
#######################################################################################################

def register_user(db_conn, nombre, apellidos, email, usuario, password):
    password_hash = generate_password_hash(password)
    user_cookie = str(uuid.uuid4())
    cursor = db_conn.cursor()
    cursor.execute("""
        INSERT INTO usuarios (nombre, apellidos, email, usuario, password_hash, fecha_nacimiento, estado, fecha_registro, rol, cookie)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """, (nombre, apellidos, email, usuario, password_hash, datetime.now(), True, datetime.now(), "user", user_cookie))
    db_conn.commit()
    cursor.close()
    return user_cookie

############################################################################################################
# Lógica de autenticación de usuario: validación de credenciales, manejo de cookies y generación del token #
############################################################################################################

def login_user(db_conn, username_or_email, password):
    cursor = db_conn.cursor()
    cursor.execute(""" 
        SELECT id, nombre, apellidos, email, usuario, password_hash, cookie, rol, ultimo_login FROM usuarios 
        WHERE usuario = %s OR email = %s
    """, (username_or_email, username_or_email))
    user = cursor.fetchone()
    cursor.close()

    if user and check_password_hash(user[5], password):
        user_data = {
            "id": user[0], # Aquí viene el id del usuario de la base de datos
            "nombre": user[1], # Aquí viene el nombre del usuario de la base de datos
            "apellidos": user[2], # Aquí viene el apellido del usuario de la base de datos
            "email": user[3], # Aquí viene el email del usuario de la base de datos
            "usuario": user[4], # Aquí viene el nombre de usuario de la base de datos
            "cookie": user[6],  # Aquí viene la cookie de la base de datos
            "rol": user[7], # Aquí viene el rol del usuario de la base de datos
            "ultimo_login": user[8], # Aquí viene el ultimo login del usuario de la base de datos
            "password_hash": user[5], # Aquí viene la password (hash) del usuario de la base de datos
        }

        # Si no tiene cookie, se genera una nueva
        if not user_data["cookie"]:
            new_cookie = str(uuid.uuid4())  # Genera un valor único para la cookie
            user_data["cookie"] = new_cookie

            # Actualiza la base de datos con la nueva cookie
            cursor = db_conn.cursor()
            cursor.execute(""" 
                UPDATE usuarios SET cookie = %s WHERE id = %s
            """, (user_data["cookie"], user_data["id"]))
            db_conn.commit()
            cursor.close()

        # Generar un token (como ya lo haces) y añadirlo a los datos de usuario
        token = generate_token(user_data)
        user_data["token"] = token

        return user_data

    return None

#######################################################
# Obtener los datos completos de un usuario por su ID #
#######################################################

def get_user_by_id(db_conn, user_id):
    cursor = db_conn.cursor()
    cursor.execute("""
        SELECT id, nombre, apellidos, email, usuario, password_hash, cookie, rol, ultimo_login 
        FROM usuarios WHERE id = %s
    """, (user_id,))
    user = cursor.fetchone()
    cursor.close()
    if user:
        return {
            "id": user[0],
            "nombre": user[1],
            "apellidos": user[2],
            "email": user[3],
            "usuario": user[4],
            "password_hash": user[5],
            "cookie": user[6],
            "rol": user[7],  # obtener el 'rol' del usuario
            "ultimo_login": user[8]
        }
    return None

####################################################################################
# Actualizar los datos del perfil del usuario en la base de datos (sin contraseña) #
####################################################################################

def update_user_profile(db_conn, user_id, nombre, apellidos, email, usuario):
    cursor = db_conn.cursor()
    cursor.execute("""
        UPDATE usuarios SET nombre = %s, apellidos = %s, email = %s, usuario = %s WHERE id = %s
    """, (nombre, apellidos, email, usuario, user_id))
    db_conn.commit()
    cursor.close()

###################################################
# Actualizar únicamente la contraseña del usuario #
###################################################

def update_user_password(db_conn, user_id, new_password):
    password_hash = generate_password_hash(new_password)
    cursor = db_conn.cursor()
    cursor.execute("""
        UPDATE usuarios SET password_hash = %s WHERE id = %s
    """, (password_hash, user_id))
    db_conn.commit()
    cursor.close()

#########################################################################
# Actualizar tanto datos del perfil como contraseña (si se proporciona) #
#########################################################################

def update_user_profile_and_password(db_conn, user_id, nombre, apellidos, email, usuario, new_password=None):
    cursor = db_conn.cursor()

    # Si se ha proporcionado una nueva contraseña, actualizarla
    if new_password:
        new_password_hash = generate_password_hash(new_password)
        cursor.execute("""
            UPDATE usuarios SET password_hash = %s WHERE id = %s
        """, (new_password_hash, user_id))

    # Actualizar los otros campos (nombre, apellidos, email, usuario)
    cursor.execute("""
        UPDATE usuarios SET nombre = %s, apellidos = %s, email = %s, usuario = %s WHERE id = %s
    """, (nombre, apellidos, email, usuario, user_id))

    db_conn.commit()
    cursor.close()

#########################################################################
# Elimina la cookie del usuario desde la base de datos (logout backend) #
#########################################################################

# Función para eliminar la cookie de la base de datos
def remove_cookie_from_db(cookie_value):
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("UPDATE usuarios SET cookie = NULL WHERE cookie = %s", (cookie_value,))
    conn.commit()
    cursor.close()
    conn.close()

##################################################
# ------------ FLASK ENDPOINT (APIs) ------------#
##################################################

######################################################################
# Habilita CORS en la API Flask para permitir cookies 'cross-origin' #
######################################################################

CORS(app, supports_credentials=True)  # Esto permite que se envíen cookies

#####################################################################################################
# Endpoint de login: maneja POST y GET para iniciar sesión, generar token y enviarlo en una cookie  #
#####################################################################################################

@app.route("/login", methods=["GET", "POST"])
def handle_login():
    if request.method == "POST":
        # Obtener datos del formulario
        data = request.get_json()
        username_or_email = data.get("username_or_email")
        password = data.get("password")
    else:
        # Si es una solicitud GET, obtener los parámetros de la URL
        username_or_email = request.args.get("username_or_email")
        password = request.args.get("password")

    print(f"Intentando iniciar sesión con usuario: {username_or_email} y contraseña: {password}")

    conn = connect_db()
    user_data = login_user(conn, username_or_email, password)
    conn.close()

    if user_data:
        token = generate_token(user_data)

        # Establecer la cookie con el token
        response = make_response(redirect("http://localhost:8080/Hackend/vistas/animation.jsp"))
        response.set_cookie(
            "token",
            token,
            httponly=True,  # Asegura que la cookie no sea accesible por JavaScript
            secure=False,   # Cambia a True si usas HTTPS
            max_age=timedelta(hours=1),  # La cookie expirará en 1 hora
            samesite='Strict'  # Asegura que la cookie no se envíe en solicitudes de otros sitios
        )

        print(f"TOKEN: {token}")  # Verificar que el token se está generando correctamente
        return response
    else:
        print(f"Error: Usuario o contraseña incorrectos para {username_or_email}")
        return jsonify({"message": "Invalid username or password"}), 401

######################################################################################
# Endpoint para actualizar los datos del perfil y contraseña del usuario autenticado #
######################################################################################

@app.route("/actualizar-datos", methods=["POST"])
def actualizar_datos():
    try:
        # Obtener el token directamente desde la cookie
        token = request.cookies.get("token")
        if not token:
            return jsonify({"error": "Token no proporcionado en la cookie"}), 400

        # Verificar y decodificar el token
        payload = verify_token(token)
        if not payload:
            return jsonify({"error": "Token inválido o expirado"}), 403

        # Obtener los datos enviados en el cuerpo de la solicitud
        data = request.get_json()
        nombre = data.get("nombre")
        apellidos = data.get("apellidos")
        email = data.get("email")
        usuario = data.get("usuario")
        current_password = data.get("currentPassword")
        new_password = data.get("newPassword")

        # Conectar a la base de datos
        conn = connect_db()
        cursor = conn.cursor()

        # Obtener la cookie desde la base de datos (tabla usuarios)
        cursor.execute("SELECT cookie FROM usuarios WHERE id = %s", (payload["user_id"],))
        user_cookie = cursor.fetchone()

        if user_cookie:
            user_cookie_value = user_cookie[0]
        else:
            user_cookie_value = None  # En caso de que no haya cookie registrada en la base de datos

        # Actualizar solo los campos que han cambiado
        if nombre:
            cursor.execute("UPDATE usuarios SET nombre = %s WHERE id = %s", (nombre, payload["user_id"]))
            payload["nombre"] = nombre
        if apellidos:
            cursor.execute("UPDATE usuarios SET apellidos = %s WHERE id = %s", (apellidos, payload["user_id"]))
            payload["apellidos"] = apellidos
        if email:
            cursor.execute("UPDATE usuarios SET email = %s WHERE id = %s", (email, payload["user_id"]))
            payload["email"] = email
        if usuario:
            cursor.execute("UPDATE usuarios SET usuario = %s WHERE id = %s", (usuario, payload["user_id"]))
            payload["usuario"] = usuario

        # Si se ha proporcionado una nueva contraseña, verificar y actualizar
        if new_password:
            # Verificar si la contraseña actual es correcta antes de actualizarla
            if current_password:
                cursor.execute("SELECT password_hash FROM usuarios WHERE id = %s", (payload["user_id"],))
                result = cursor.fetchone()

                if result and check_password_hash(result[0], current_password):
                    # Si la contraseña actual es correcta, actualizarla
                    hashed_new_password = generate_password_hash(new_password)
                    cursor.execute("UPDATE usuarios SET password_hash = %s WHERE id = %s", (hashed_new_password, payload["user_id"]))
                    payload["password"] = new_password  # Actualizamos la password en el payload
                else:
                    cursor.close()
                    conn.close()
                    return jsonify({"error": "Contraseña actual incorrecta"}), 400

        # Commit para guardar los cambios en la base de datos
        conn.commit()

        # Generar el nuevo token con el Payload actualizado (solo con los datos modificados)
        new_payload = {
            "user_id": payload["user_id"],
            "usuario": payload["usuario"],
            "email": payload["email"],
            "nombre": payload["nombre"],
            "apellidos": payload["apellidos"],
            "rol": payload["rol"],
            "cookie": user_cookie_value,  # Aquí usamos la cookie obtenida de la base de datos
            "ultimo_login": str(datetime.utcnow()),
            "exp": datetime.utcnow() + timedelta(hours=1)  # Establecer la nueva expiración
        }

        # Regenerar el token
        nuevo_token = jwt.encode(new_payload, SECRET_KEY, algorithm="HS256")

        # Cerrar la conexión a la base de datos
        cursor.close()
        conn.close()

        # Regresar el nuevo token como respuesta
        return jsonify({"message": "Datos actualizados exitosamente", "token": nuevo_token})

    except Exception as e:
        # Log de errores detallados
        print(f"Error en actualizar-datos: {str(e)}")
        return jsonify({"error": "Hubo un error", "mensaje": str(e)}), 500

#################################################################################
# Endpoint para cerrar sesión: borra cookie del navegador y de la base de datos #
#################################################################################

@app.route("/logout", methods=["POST"])
def logout():
    try:
        # Obtener el token directamente desde la cookie
        token = request.cookies.get("token")
        if token:
            payload = verify_token(token)
            if payload:
                # Eliminar la cookie de la base de datos (en la DDBB)
                remove_cookie_from_db(payload["cookie"])

            # Eliminar la cookie en el navegador del cliente
            response = jsonify({"message": "Logout exitoso"})
            response.set_cookie("token", "", max_age=0)  # Eliminar la cookie "token"
            return response
        else:
            return jsonify({"error": "No se encontró token en la cookie"}), 400
    except Exception as e:
        return jsonify({"error": "Error al intentar cerrar sesión", "mensaje": str(e)}), 500

###########################################################################
# Endpoint para eliminar la cuenta del usuario autenticado mediante su ID #
###########################################################################

@app.route("/eliminar-cuenta", methods=["GET"])
def eliminar_cuenta():
    try:
        # Si viene una bandera especial desde Java, saltamos la verificación de token
        if request.args.get("internal") == "true":
            user_id = request.args.get("userId", type=int)
            if not user_id:
                return jsonify({"error": "userId no válido o ausente"}), 400
        else:
            # Obtener el userId del parámetro de la URL
            user_id = request.args.get("userId", type=int)
            if not user_id:
                return jsonify({"error": "userId no proporcionado en la URL"}), 400

            # Obtener el token directamente desde la cookie
            token = request.cookies.get("token")
            if not token:
                return jsonify({"error": "Token no proporcionado en la cookie"}), 400

            # Verificar y decodificar el token
            payload = verify_token(token)
            if not payload:
                return jsonify({"error": "Token inválido o expirado"}), 403

        # Conectar a la base de datos PostgreSQL
        conn = connect_db()
        cursor = conn.cursor()

        # Eliminar el usuario de la base de datos usando el userId
        cursor.execute("DELETE FROM usuarios WHERE id = %s", (user_id,))
        conn.commit()

        # Comprobar si la eliminación fue exitosa
        if cursor.rowcount > 0:
            # Eliminar cookie si viene desde navegador (opcional)
            response = make_response(redirect("http://localhost:30050/"))
            response.set_cookie("token", "", max_age=0)
            cursor.close()
            conn.close()
            return response
        else:
            cursor.close()
            conn.close()
            return jsonify({"error": "No se encontró el usuario con ese ID"}), 404

    except Exception as e:
        return jsonify({"error": "Error al eliminar la cuenta", "mensaje": str(e)}), 500

#############################################################
# Endpoint que obtiene el nombre de usuario a partir del ID #
#############################################################

@app.route('/get_username/<int:user_id>')
def get_username(user_id):
    # Conectando a la base de datos PostgreSQL
    conn = connect_db()
    cursor = conn.cursor()

    # Ejecutando la consulta para obtener el nombre de usuario
    cursor.execute("SELECT usuario FROM usuarios WHERE id = %s", (user_id,))
    result = cursor.fetchone()

    # Cerrando la conexión
    cursor.close()
    conn.close()

    if result:
        # Si se encuentra el usuario, devolvemos el nombre de usuario
        return jsonify({"username": result[0]})
    else:
        # Si no se encuentra el usuario, devolvemos un mensaje de error
        return jsonify({"username": "Desconocido"}), 404

###########################################################################
#         Endpoint para extraer toda la informacion de los usuarios       #
###########################################################################

@app.route("/usuariosPDF", methods=["GET"])
def obtener_usuarios():
    conn = None
    cursor = None
    try:
        conn = connect_db()
        cursor = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
        cursor.execute("""
            SELECT id, nombre, apellidos, usuario, fecha_registro, rol 
            FROM usuarios
        """)
        usuarios = cursor.fetchall()
        return jsonify(usuarios), 200


    except Exception as e:
        print("ERROR en /usuariosPDF:", e)
        return jsonify({"error": str(e)}), 500

    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

#############################################################################################
# Función que lanza el servidor Flask en segundo plano para que no bloquee la interfaz Flet #
#############################################################################################

def run_flask():
    CORS(app)
    app.run(port=5000, debug=False, use_reloader=False)

threading.Thread(target=run_flask, daemon=True).start()

######################################################
# ------------ FLET INTERFAZ (Frontend) ------------ #
######################################################

############################################################################################################################
# Interfaz de registro de usuario con validación de campos, verificación de contraseñas y llamada a la función de registro #
############################################################################################################################

def show_register(page: Page):
    # ────────────────────────────────────────────────
    # FUNCIÓN PRINCIPAL PARA MOSTRAR LA PANTALLA DE REGISTRO
    # ────────────────────────────────────────────────

    # Limpiamos el contenido previo de la página
    page.clean()

    # Establecemos un color de fondo oscuro para la interfaz
    page.bgcolor = "#1e1e2f"

    # Centramos vertical y horizontalmente el contenido en la pantalla
    page.vertical_alignment = ft.MainAxisAlignment.CENTER
    page.horizontal_alignment = ft.CrossAxisAlignment.CENTER

    # ───────────────
    # CAMPOS DE ENTRADA DEL FORMULARIO DE REGISTRO
    # ───────────────
    nombre_input = ft.TextField(label="Nombre", width=300)
    apellidos_input = ft.TextField(label="Apellidos", width=300)
    email_input = ft.TextField(label="Correo Electrónico", width=300)
    usuario_input = ft.TextField(label="Nombre de Usuario", width=300)
    password_input = ft.TextField(label="Contraseña", password=True, width=300)
    confirm_password_input = ft.TextField(label="Repetir Contraseña", password=True, width=300)

    # ────────────────────────────────────────────────
    # FUNCIÓN QUE MANEJA EL EVENTO CUANDO SE PRESIONA "Registrarse"
    # ────────────────────────────────────────────────
    def handle_register(e):
        # Verificar si las contraseñas coinciden
        if password_input.value != confirm_password_input.value:
            page.add(ft.Text("Las contraseñas no coinciden", color="red"))
            return

        # Verificar que todos los campos estén completos
        if not all([nombre_input.value, apellidos_input.value, email_input.value, usuario_input.value, password_input.value]):
            page.add(ft.Text("Por favor, completa todos los campos", color="red"))
            return

        # Validar el nombre de usuario (solo letras, números y guion bajo)
        if not is_valid_username(usuario_input.value):
            page.add(ft.Text("Nombre de usuario inválido", color="red"))
            return

        # Si todo está bien, conectarse a la base de datos e intentar registrar el usuario
        conn = connect_db()
        try:
            register_user(conn, nombre_input.value, apellidos_input.value, email_input.value, usuario_input.value, password_input.value)
            show_login(page)  # Redirigir al login tras el registro exitoso
        except Exception as error:
            page.add(ft.Text(f"Error al registrar: {error}", color="red"))
        finally:
            conn.close()

    # ────────────────────────────────────────────────
    # CONSTRUCCIÓN DEL FORMULARIO Y BOTONES
    # ────────────────────────────────────────────────
    form = ft.Column(
        [
            ft.Image(src="https://cdn-icons-png.flaticon.com/512/295/295128.png", width=100),  # Icono decorativo
            nombre_input,
            apellidos_input,
            email_input,
            usuario_input,
            password_input,
            confirm_password_input,
            ft.ElevatedButton("Registrarse", on_click=handle_register),  # Botón de registro
            ft.TextButton("¿Ya tienes cuenta? Inicia sesión", on_click=lambda _: show_login(page))  # Botón para cambiar a login
        ],
        alignment=ft.MainAxisAlignment.CENTER,
        horizontal_alignment=ft.CrossAxisAlignment.CENTER,
        spacing=20  # Espaciado entre los elementos del formulario
    )

    # ────────────────────────────────────────────────
    # CONTENEDOR DEL FORMULARIO CON ESTILO
    # ────────────────────────────────────────────────
    container = ft.Container(
        content=form,
        bgcolor="#2b2b3c",             # Fondo del formulario
        padding=40,                    # Espaciado interior
        border_radius=20,             # Bordes redondeados
        width=400,                    # Ancho del contenedor
        shadow=ft.BoxShadow(          # Sombra suave para profundidad visual
            blur_radius=10,
            color="#00000040",
            spread_radius=1
        )
    )

    # ────────────────────────────────────────────────
    # AÑADIR EL CONTENEDOR A LA PÁGINA DENTRO DE UNA FILA CENTRADA
    # ────────────────────────────────────────────────
    page.add(ft.Row([container], alignment=ft.MainAxisAlignment.CENTER))

#####################################################################################
# Interfaz de login que valida credenciales y redirige al backend para autenticarse #
#####################################################################################

def show_login(page: Page):
    # ────────────────────────────────────────────────
    # FUNCIÓN PRINCIPAL PARA MOSTRAR LA PANTALLA DE INICIO DE SESIÓN
    # ────────────────────────────────────────────────

    # Limpiamos el contenido anterior de la página
    page.clean()

    # Aplicamos un color de fondo oscuro elegante
    page.bgcolor = "#1e1e2f"

    # Centramos el contenido vertical y horizontalmente
    page.vertical_alignment = ft.MainAxisAlignment.CENTER
    page.horizontal_alignment = ft.CrossAxisAlignment.CENTER

    # ───────────────
    # CAMPOS DE ENTRADA DEL FORMULARIO DE LOGIN
    # ───────────────
    username_input = ft.TextField(label="Usuario o Correo", width=300)
    password_input = ft.TextField(label="Contraseña", password=True, width=300)

    # ────────────────────────────────────────────────
    # FUNCIÓN QUE MANEJA EL EVENTO DE INICIAR SESIÓN
    # ────────────────────────────────────────────────
    def handle_login(e):
        # Verificar que ambos campos estén completos
        if not username_input.value or not password_input.value:
            page.add(ft.Text("Por favor, ingresa usuario y contraseña", color="red"))
            return

        username_or_email = username_input.value
        password = password_input.value

        try:
            # Conectar a la base de datos
            conn = connect_db()
            cursor = conn.cursor()

            # Buscar el usuario por nombre de usuario o correo electrónico
            cursor.execute(
                "SELECT password_hash FROM usuarios WHERE usuario = %s OR email = %s",
                (username_or_email, username_or_email)
            )
            user_data = cursor.fetchone()

            # Si el usuario existe, verificamos la contraseña
            if user_data:
                stored_password = user_data[0]
                if check_password_hash(stored_password, password):
                    page.add(ft.Text("Login exitoso!", color="green"))

                    # Redireccionamos al sistema (por ejemplo, a un backend en Flask)
                    url = f"http://localhost:5000/login?username_or_email={username_or_email}&password={password}"
                    page.launch_url(url)
                else:
                    page.add(ft.Text("Usuario o Contraseña incorrectos", color="red"))
            else:
                page.add(ft.Text("Usuario o Contraseña incorrectos", color="red"))

            # Cerramos la conexión a la base de datos
            cursor.close()
            conn.close()

        except Exception as e:
            # Manejo de errores en caso de fallo al conectar
            page.add(ft.Text(f"Error al conectar con la base de datos: {str(e)}", color="red"))

    # ────────────────────────────────────────────────
    # CONSTRUCCIÓN DEL FORMULARIO DE INICIO DE SESIÓN
    # ────────────────────────────────────────────────
    form = ft.Column(
        [
            ft.Image(src="https://cdn-icons-png.flaticon.com/512/295/295128.png", width=100),  # Icono decorativo
            username_input,
            password_input,
            ft.ElevatedButton("Iniciar sesión", on_click=handle_login),  # Botón principal
            ft.TextButton("¿No tienes cuenta? Regístrate", on_click=lambda _: show_register(page))  # Enlace a registro
        ],
        alignment=ft.MainAxisAlignment.CENTER,
        horizontal_alignment=ft.CrossAxisAlignment.CENTER,
        spacing=20  # Espaciado entre elementos
    )

    # ────────────────────────────────────────────────
    # CONTENEDOR ESTÉTICO QUE ENVUELVE EL FORMULARIO
    # ────────────────────────────────────────────────
    container = ft.Container(
        content=form,
        bgcolor="#2b2b3c",             # Fondo del contenedor
        padding=80,                    # Espaciado interior
        border_radius=20,             # Bordes redondeados
        width=400,                    # Ancho fijo
        shadow=ft.BoxShadow(          # Sombra para efecto visual
            blur_radius=10,
            color="#00000040",
            spread_radius=1
        )
    )

    # ────────────────────────────────────────────────
    # AÑADIMOS EL CONTENEDOR CENTRADO A LA PÁGINA
    # ────────────────────────────────────────────────
    page.add(ft.Row([container], alignment=ft.MainAxisAlignment.CENTER))

#########################################################
# Carga inicial de la app Flet con la pantalla de login #
#########################################################

def flet_app(page: Page):
    page.title = "Sistema de Login"
    show_login(page)

################################################################
# Ejecuta la app Flet en modo navegador, en el puerto definido #
################################################################

ft.app(target=flet_app, view=ft.WEB_BROWSER, port=30050, host="localhost")
