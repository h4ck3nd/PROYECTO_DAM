import flet as ft
from flet import Page
import psycopg2
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime

# Conexión a la base de datos PostgreSQL
def connect_db():
    conn = psycopg2.connect(
        dbname="appusers",
        user="postgres",
        password="1234",
        host="localhost",
        port="5432"
    )
    return conn

# Función de registro
def register_user(db_conn, nombre, apellidos, email, usuario, password):
    # Hash de la contraseña antes de insertarla
    password_hash = generate_password_hash(password)
    cursor = db_conn.cursor()
    cursor.execute("""
        INSERT INTO usuarios (nombre, apellidos, email, usuario, password_hash, fecha_nacimiento, estado, fecha_registro, rol)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
    """, (nombre, apellidos, email, usuario, password_hash, datetime.now(), True, datetime.now(), "user"))
    db_conn.commit()
    cursor.close()

# Función de login
def login_user(db_conn, username_or_email, password):
    cursor = db_conn.cursor()
    cursor.execute("""
        SELECT id, password_hash FROM usuarios WHERE usuario = %s OR email = %s
    """, (username_or_email, username_or_email))
    user = cursor.fetchone()
    cursor.close()

    if user and check_password_hash(user[1], password):
        return user[0]  # Retorna el ID del usuario si el login es exitoso
    return None

# Función que define la página de Flet
def flet_app(page: Page):
    page.add(ft.Column())

    # Formulario de login
    username_input = ft.TextField(label="Nombre de Usuario o Correo Electrónico")
    password_input = ft.TextField(label="Contraseña", password=True)
    login_button = ft.ElevatedButton("Iniciar sesión", on_click=lambda _: login(page, username_input.value, password_input.value))

    # Formulario de registro
    nombre_input = ft.TextField(label="Nombre")
    apellidos_input = ft.TextField(label="Apellidos")
    email_input = ft.TextField(label="Correo Electrónico")
    usuario_input = ft.TextField(label="Nombre de Usuario")
    password_register_input = ft.TextField(label="Contraseña", password=True)
    register_button = ft.ElevatedButton("Registrar", on_click=lambda _: register(page, nombre_input.value, apellidos_input.value, email_input.value, usuario_input.value, password_register_input.value))

    # Añadir los formularios a la página
    page.add(ft.Column([username_input, password_input, login_button, nombre_input, apellidos_input, email_input, usuario_input, password_register_input, register_button]))

    page.update()

# Función que maneja el registro de un nuevo usuario
def register(page, nombre, apellidos, email, usuario, password):
    conn = connect_db()
    try:
        register_user(conn, nombre, apellidos, email, usuario, password)
        page.add(ft.Text("Usuario registrado exitosamente"))
    except Exception as e:
        page.add(ft.Text(f"Error al registrar usuario: {str(e)}"))
    finally:
        conn.close()

# Función que maneja el login
def login(page, username_or_email, password):
    conn = connect_db()
    user_id = login_user(conn, username_or_email, password)
    if user_id:
        page.add(ft.Text(f"Bienvenido, Usuario {user_id}"))
    else:
        page.add(ft.Text("Usuario o contraseña incorrectos"))
    conn.close()

# Crear y ejecutar la aplicación de Flet, ahora con la opción de abrirla en un navegador web
ft.app(target=flet_app, view=ft.WEB_BROWSER, port=4308)
