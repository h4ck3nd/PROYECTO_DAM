import flet as ft
from flask_cors import CORS
from flet import Page
import psycopg2
import uuid
from werkzeug.security import generate_password_hash, check_password_hash
import re
import jwt
from datetime import datetime, timedelta
import time
import requests

from flask import Flask, request, jsonify, session, redirect, make_response
import threading

# Clave secreta para JWT
SECRET_KEY = "clave_super_secreta"

# Configuración Flask
app = Flask(__name__)

# Conexión a la base de datos PostgreSQL
def connect_db():
    return psycopg2.connect(
        dbname="appusers",
        user="postgres",
        password="1234",
        host="localhost",
        port="5432"
    )

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

def verify_token(token):
    try:
        return jwt.decode(token, SECRET_KEY, algorithms=["HS256"])
    except jwt.ExpiredSignatureError:
        return None
    except jwt.InvalidTokenError:
        return None

def is_valid_username(usuario):
    return bool(re.match("^[a-zA-Z0-9_]+$", usuario))

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
            "id": user[0],
            "nombre": user[1],
            "apellidos": user[2],
            "email": user[3],
            "usuario": user[4],
            "cookie": user[6],  # Aquí viene la cookie de la base de datos
            "rol": user[7],
            "ultimo_login": user[8],
            "password_hash": user[5],
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
            "rol": user[7],  # Asegúrate de que 'rol' esté aquí
            "ultimo_login": user[8]
        }
    return None

def update_user_profile(db_conn, user_id, nombre, apellidos, email, usuario):
    cursor = db_conn.cursor()
    cursor.execute("""
        UPDATE usuarios SET nombre = %s, apellidos = %s, email = %s, usuario = %s WHERE id = %s
    """, (nombre, apellidos, email, usuario, user_id))
    db_conn.commit()
    cursor.close()

def update_user_password(db_conn, user_id, new_password):
    password_hash = generate_password_hash(new_password)
    cursor = db_conn.cursor()
    cursor.execute("""
        UPDATE usuarios SET password_hash = %s WHERE id = %s
    """, (password_hash, user_id))
    db_conn.commit()
    cursor.close()


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

# Función para eliminar la cookie de la base de datos
def remove_cookie_from_db(cookie_value):
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("UPDATE usuarios SET cookie = NULL WHERE cookie = %s", (cookie_value,))
    conn.commit()
    cursor.close()
    conn.close()

# ------------ FLASK ENDPOINT ------------
# Habilitar CORS
CORS(app, supports_credentials=True)  # Esto permite que se envíen cookies
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
        response = make_response(redirect("http://localhost:8080/ProyectoWebMaven/animation.jsp"))
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

@app.route("/eliminar-cuenta", methods=["GET"])
def eliminar_cuenta():
    try:
        # Obtener el userId del parámetro de la URL
        user_id = request.args.get("userId")
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
            # Eliminar cookie
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

def run_flask():
    app.run(port=5000, debug=False, use_reloader=False)

threading.Thread(target=run_flask, daemon=True).start()

# ------------ FLET INTERFAZ ------------

def show_register(page: Page):
    page.clean()
    page.bgcolor = "#1e1e2f"  # Fondo oscuro elegante

    nombre_input = ft.TextField(label="Nombre", width=300)
    apellidos_input = ft.TextField(label="Apellidos", width=300)
    email_input = ft.TextField(label="Correo Electrónico", width=300)
    usuario_input = ft.TextField(label="Nombre de Usuario", width=300)
    password_input = ft.TextField(label="Contraseña", password=True, width=300)
    confirm_password_input = ft.TextField(label="Repetir Contraseña", password=True, width=300)

    def handle_register(e):
        if password_input.value != confirm_password_input.value:
            page.add(ft.Text("Las contraseñas no coinciden", color="red"))
            return
        if not all([nombre_input.value, apellidos_input.value, email_input.value, usuario_input.value, password_input.value]):
            page.add(ft.Text("Por favor, completa todos los campos", color="red"))
            return
        if not is_valid_username(usuario_input.value):
            page.add(ft.Text("Nombre de usuario inválido", color="red"))
            return

        conn = connect_db()
        try:
            register_user(conn, nombre_input.value, apellidos_input.value, email_input.value, usuario_input.value, password_input.value)
            show_login(page)
        except Exception as error:
            page.add(ft.Text(f"Error al registrar: {error}", color="red"))
        finally:
            conn.close()

    form = ft.Column([
        ft.Image(src="https://cdn-icons-png.flaticon.com/512/295/295128.png", width=100),
        nombre_input, apellidos_input, email_input, usuario_input,
        password_input, confirm_password_input,
        ft.ElevatedButton("Registrarse", on_click=handle_register),
        ft.TextButton("¿Ya tienes cuenta? Inicia sesión", on_click=lambda _: show_login(page))
    ],
    alignment=ft.MainAxisAlignment.CENTER,
    horizontal_alignment=ft.CrossAxisAlignment.CENTER,
    spacing=20
    )

    container = ft.Container(
        content=form,
        bgcolor="#2b2b3c",
        padding=30,
        border_radius=20,
        width=400,
        shadow=ft.BoxShadow(blur_radius=10, color="#00000040", spread_radius=1)
    )

    page.add(ft.Row([container], alignment=ft.MainAxisAlignment.CENTER))


def show_login(page: Page):
    page.clean()
    page.bgcolor = "#1e1e2f"

    username_input = ft.TextField(label="Usuario o Correo", width=300)
    password_input = ft.TextField(label="Contraseña", password=True, width=300)

    def handle_login(e):
        if not username_input.value or not password_input.value:
            page.add(ft.Text("Por favor, ingresa usuario y contraseña", color="red"))
            return

        username_or_email = username_input.value
        password = password_input.value

        try:
            conn = connect_db()
            cursor = conn.cursor()

            cursor.execute("SELECT password_hash FROM usuarios WHERE usuario = %s OR email = %s", (username_or_email, username_or_email))
            user_data = cursor.fetchone()

            if user_data:
                stored_password = user_data[0]
                if check_password_hash(stored_password, password):
                    page.add(ft.Text("Login exitoso!", color="green"))
                    url = f"http://localhost:5000/login?username_or_email={username_or_email}&password={password}"
                    page.launch_url(url)
                else:
                    page.add(ft.Text("Usuario o Contraseña incorrectos", color="red"))
            else:
                page.add(ft.Text("Usuario o Contraseña incorrectos", color="red"))

            cursor.close()
            conn.close()

        except Exception as e:
            page.add(ft.Text(f"Error al conectar con la base de datos: {str(e)}", color="red"))

    form = ft.Column([
        ft.Image(src="https://cdn-icons-png.flaticon.com/512/295/295128.png", width=100),
        username_input,
        password_input,
        ft.ElevatedButton("Iniciar sesión", on_click=handle_login),
        ft.TextButton("¿No tienes cuenta? Regístrate", on_click=lambda _: show_register(page))
    ],
    alignment=ft.MainAxisAlignment.CENTER,
    horizontal_alignment=ft.CrossAxisAlignment.CENTER,
    spacing=20
    )

    container = ft.Container(
        content=form,
        bgcolor="#2b2b3c",
        padding=30,
        border_radius=20,
        width=400,
        shadow=ft.BoxShadow(blur_radius=10, color="#00000040", spread_radius=1)
    )

    page.add(ft.Row([container], alignment=ft.MainAxisAlignment.CENTER))


def flet_app(page: Page):
    page.title = "Sistema de Login"
    show_login(page)

ft.app(target=flet_app, view=ft.WEB_BROWSER, port=30050, host="localhost")
