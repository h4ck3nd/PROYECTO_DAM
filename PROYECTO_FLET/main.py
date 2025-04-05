import flet as ft
from flask_cors import CORS
from flet import Page
import psycopg2
import uuid
from werkzeug.security import generate_password_hash, check_password_hash
import re
import jwt
from datetime import datetime, timedelta
import requests

from flask import Flask, request, jsonify, session, redirect
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
            # Generar una cookie única (podrías usar UUID o algún hash)
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
@app.route("/login", methods=["POST"])
def login():
    try:
        # Obtener los datos enviados por el cliente
        data = request.get_json()
        username_or_email = data.get("username_or_email")
        password = data.get("password")

        if not username_or_email or not password:
            return jsonify({"error": "Credenciales incompletas"}), 400

        # Conexión a la base de datos
        conn = connect_db()
        user_data = login_user(conn, username_or_email, password)
        conn.close()

        if user_data:
            # Crear una respuesta y agregar el JWT en la cookie
            response = jsonify({"message": "Login successful"})

            # Establecer la cookie con el token JWT
            response.set_cookie(
                "token",  # Nombre de la cookie
                user_data["token"],  # Valor del JWT
                httponly=True,  # Solo accesible por HTTP, no puede ser accedida por JavaScript
                secure=False,  # Solo se enviará sobre HTTPS
                max_age=timedelta(hours=1)  # Duración del token
            )

            return response
        else:
            return jsonify({"error": "Usuario o contraseña incorrectos"}), 401
    except Exception as e:
        return jsonify({"error": "Hubo un error en el servidor", "mensaje": str(e)}), 500

@app.route("/actualizar-datos", methods=["POST"])
def actualizar_datos():
    try:
        data = request.get_json()
        token = data.get("token")

        if not token:
            return jsonify({"error": "Token no proporcionado"}), 400

        # Verificar y decodificar el token
        payload = verify_token(token)
        if not payload:
            return jsonify({"error": "Token inválido o expirado"}), 403

        # Extraer los datos del payload del token
        user_id = payload["user_id"]
        rol = payload["rol"]  # Aquí extraes el rol
        ultimo_login = payload["ultimo_login"]  # Aquí extraes el último inicio de sesión
        cookie = payload.get("cookie")  # También extraemos la cookie

        # Ahora que tienes los datos, puedes proceder con la lógica para actualizar el perfil
        nombre = data.get("nombre")
        apellidos = data.get("apellidos")
        email = data.get("email")
        usuario = data.get("usuario")
        current_password = data.get("currentPassword")
        new_password = data.get("newPassword")

        if not nombre or not apellidos or not email or not usuario:
            return jsonify({"error": "Faltan datos"}), 400

        conn = connect_db()
        user = get_user_by_id(conn, user_id)
        if not user:
            conn.close()
            return jsonify({"error": "Usuario no encontrado"}), 404

        # Verificar la contraseña actual
        if current_password and not check_password_hash(user["password_hash"], current_password):
            conn.close()
            return jsonify({"error": "Contraseña actual incorrecta"}), 400

        # Si se proporciona una nueva contraseña, actualizarla
        if new_password:
            update_user_password(conn, user_id, new_password)

        update_user_profile(conn, user_id, nombre, apellidos, email, usuario)
        conn.close()

        # Generar un nuevo token con los datos actualizados
        new_payload = {
            "user_id": user_id,
            "nombre": nombre,
            "apellidos": apellidos,
            "email": email,
            "usuario": usuario,
            "cookie": cookie,  # Reintegramos la cookie en el nuevo token
            "rol": rol,  # Mantener el rol
            "ultimo_login": str(datetime.utcnow()),  # Actualizamos el último inicio de sesión
            "exp": datetime.utcnow() + timedelta(hours=1)  # Expiración en 1 hora
        }

        # Generar el nuevo token
        nuevo_token = jwt.encode(new_payload, SECRET_KEY, algorithm="HS256")

        # Devolver el nuevo token en la respuesta
        return jsonify({"token": nuevo_token})

    except Exception as e:
        # Capturamos el error completo y lo mostramos
        print(f"Error al procesar la solicitud: {str(e)}")
        return jsonify({"error": "Hubo un problema en el servidor", "mensaje": str(e)}), 500

# Habilitar CORS para permitir solicitudes desde cualquier origen
CORS(app, origins="http://localhost:8080")  # Permite solicitudes solo desde http://localhost:8080


@app.route("/logout", methods=["GET"])
def logout():
    token = request.args.get("token")
    print(f"Token recibido: {token}")  # Para depurar el valor del token

    if not token:
        return jsonify({"error": "Token no proporcionado"}), 400

    try:
        # Verificar el token
        payload = verify_token(token)
        if not payload:
            return jsonify({"error": "Token inválido o expirado"}), 403

        user_cookie = payload.get("cookie")
        if user_cookie:
            # Eliminar la cookie de la base de datos
            remove_cookie_from_db(user_cookie)
            # Redirigir al login
            response = redirect("http://localhost:30050")
            response.set_cookie("user_cookie", "", max_age=0)
            return response
        else:
            return jsonify({"error": "Cookie no encontrada en el token"}), 400
    except Exception as e:
        return jsonify({"error": "Error durante el cierre de sesión", "message": str(e)}), 500

def run_flask():
    app.run(port=5000, debug=False, use_reloader=False)

threading.Thread(target=run_flask, daemon=True).start()

# ------------ FLET INTERFAZ ------------
def show_register(page):
    page.clean()
    nombre_input = ft.TextField(label="Nombre")
    apellidos_input = ft.TextField(label="Apellidos")
    email_input = ft.TextField(label="Correo Electrónico")
    usuario_input = ft.TextField(label="Nombre de Usuario")
    password_input = ft.TextField(label="Contraseña", password=True)
    confirm_password_input = ft.TextField(label="Repetir Contraseña", password=True)

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

    page.add(ft.Column([
        nombre_input, apellidos_input, email_input, usuario_input,
        password_input, confirm_password_input,
        ft.ElevatedButton("Registrarse", on_click=handle_register),
        ft.TextButton("¿Ya tienes cuenta? Inicia sesión", on_click=lambda _: show_login(page))
    ], alignment="center"))


def show_login(page):
    page.clean()
    # Aquí estás agregando la fuente a la página
    # page.add(ft.Text("Iniciar Sesion", style="font-family: 'JetBrains Mono', monospace;"))
    username_input = ft.TextField(label="Usuario o Correo")
    password_input = ft.TextField(label="Contraseña", password=True)

    def handle_login(e):
        conn = connect_db()
        user_data = login_user(conn, username_input.value, password_input.value)
        conn.close()

        if username_input.value and password_input.value:
            data = {
                "username_or_email": username_input.value,
                "password": password_input.value
            }
            response = requests.post("http://localhost:5000/login", json=data)

            if response.status_code == 200:
                # Obtener el token desde la cookie de la respuesta
                token = response.cookies.get("token")
                if token:
                    page.launch_url(f"http://localhost:8080/ProyectoWebMaven/animation.jsp?token={token}")
                else:
                    page.add(ft.Text("Error: Token no recibido", color="red"))
            else:
                page.add(ft.Text("Usuario o contraseña incorrectos", color="red"))
        else:
            page.add(ft.Text("Por favor, ingresa usuario y contraseña", color="red"))

    page.add(ft.Column([
        username_input, password_input,
        ft.ElevatedButton("Iniciar sesión", on_click=handle_login),
        ft.TextButton("¿No tienes cuenta? Regístrate", on_click=lambda _: show_register(page))
    ], alignment="center"))

def show_home(page, user_data):
    page.clean()
    profile_info = f"""
    Bienvenido, {user_data['usuario']}
    Nombre: {user_data['nombre']}
    Apellidos: {user_data['apellidos']}
    Correo Electrónico: {user_data['email']}
    Token: {user_data['token']}
    """
    page.add(ft.Column([
        ft.Text(profile_info),
        ft.ElevatedButton("Editar Perfil", on_click=lambda _: show_edit_profile(page, user_data)),
        ft.ElevatedButton("Cerrar sesión", on_click=lambda _: show_login(page))
    ], alignment="center"))

def show_edit_profile(page, user_data):
    page.clean()
    conn = connect_db()
    user = get_user_by_id(conn, user_data["id"])
    conn.close()
    if not user:
        page.add(ft.Text("Error al cargar el perfil", color="red"))
        return

    nombre_input = ft.TextField(label="Nombre", value=user["nombre"])
    apellidos_input = ft.TextField(label="Apellidos", value=user["apellidos"])
    email_input = ft.TextField(label="Correo Electrónico", value=user["email"])
    usuario_input = ft.TextField(label="Nombre de Usuario", value=user["usuario"])
    current_password_input = ft.TextField(label="Contraseña Actual", password=True)
    new_password_input = ft.TextField(label="Nueva Contraseña", password=True)
    confirm_new_password_input = ft.TextField(label="Repetir Nueva Contraseña", password=True)

    def handle_update(e):
        conn = connect_db()
        if new_password_input.value and new_password_input.value == confirm_new_password_input.value:
            if not check_password_hash(user["password_hash"], current_password_input.value):
                page.add(ft.Text("Contraseña actual incorrecta", color="red"))
                conn.close()
                return
            update_user_password(conn, user["id"], new_password_input.value)

        update_user_profile(conn, user["id"], nombre_input.value, apellidos_input.value, email_input.value, usuario_input.value)
        conn.close()
        page.add(ft.Text("Perfil actualizado correctamente"))
        show_home(page, user_data)

    page.add(ft.Column([
        nombre_input, apellidos_input, email_input, usuario_input,
        current_password_input, new_password_input, confirm_new_password_input,
        ft.ElevatedButton("Guardar Cambios", on_click=handle_update),
        ft.ElevatedButton("Volver", on_click=lambda _: show_home(page, user_data))
    ], alignment="center"))

def flet_app(page: Page):
    # Aquí estás agregando la fuente a la página
    #page.add(ft.Text("Sistema de Login", style="font-family: 'JetBrains Mono', monospace;"))

    page.title = "Sistema de Login"
    show_login(page)

ft.app(target=flet_app, view=ft.WEB_BROWSER, port=30050, host="0.0.0.0")
