import flet as ft
from flet import Page
import psycopg2
import uuid
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime

# Conexión a la base de datos PostgreSQL
def connect_db():
    return psycopg2.connect(
        dbname="appusers",
        user="postgres",
        password="1234",
        host="localhost",
        port="5432"
    )

# Función para registrar un usuario
def register_user(db_conn, nombre, apellidos, email, usuario, password):
    password_hash = generate_password_hash(password)
    user_cookie = str(uuid.uuid4())  # Generar una cookie única

    cursor = db_conn.cursor()
    cursor.execute("""
        INSERT INTO usuarios (nombre, apellidos, email, usuario, password_hash, fecha_nacimiento, estado, fecha_registro, rol, cookie)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """, (nombre, apellidos, email, usuario, password_hash, datetime.now(), True, datetime.now(), "user", user_cookie))
    db_conn.commit()
    cursor.close()
    return user_cookie

# Función para verificar login
def login_user(db_conn, username_or_email, password):
    cursor = db_conn.cursor()
    cursor.execute("""
        SELECT id, password_hash, cookie FROM usuarios WHERE usuario = %s OR email = %s
    """, (username_or_email, username_or_email))
    user = cursor.fetchone()
    cursor.close()

    if user and check_password_hash(user[1], password):
        return user[2]  # Retornar la cookie del usuario si el login es exitoso
    return None

# Página de Login
def show_login(page):
    page.clean()

    username_input = ft.TextField(label="Nombre de Usuario o Correo Electrónico")
    password_input = ft.TextField(label="Contraseña", password=True)
    
    def handle_login(e):
        conn = connect_db()
        user_cookie = login_user(conn, username_input.value, password_input.value)
        conn.close()

        if user_cookie:
            show_home(page, user_cookie)
        else:
            page.add(ft.Text("Usuario o contraseña incorrectos", color="red"))
            page.update()

    login_button = ft.ElevatedButton("Iniciar sesión", on_click=handle_login)
    go_register_button = ft.TextButton("¿No tienes cuenta? Regístrate", on_click=lambda _: show_register(page))

    page.add(ft.Column([username_input, password_input, login_button, go_register_button], alignment="center"))
    page.update()

# Página de Registro
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
            page.update()
            return

        conn = connect_db()
        try:
            user_cookie = register_user(conn, nombre_input.value, apellidos_input.value, email_input.value, usuario_input.value, password_input.value)
            show_home(page, user_cookie)  # Redirigir al home
        except Exception as error:
            page.add(ft.Text(f"Error al registrar usuario: {error}", color="red"))
            page.update()
        finally:
            conn.close()

    register_button = ft.ElevatedButton("Registrarse", on_click=handle_register)
    go_login_button = ft.TextButton("¿Ya tienes cuenta? Inicia sesión", on_click=lambda _: show_login(page))

    page.add(ft.Column([
        nombre_input, apellidos_input, email_input, usuario_input, password_input, confirm_password_input,
        register_button, go_login_button
    ], alignment="center"))

    page.update()

# Página Principal (Home)
def show_home(page, user_cookie):
    page.clean()

    welcome_text = ft.Text(f"Bienvenido a la página principal. Cookie de sesión: {user_cookie}")
    
    def logout(e):
        show_login(page)

    logout_button = ft.ElevatedButton("Cerrar sesión", on_click=logout)

    page.add(ft.Column([welcome_text, logout_button], alignment="center"))
    page.update()

# Iniciar la app con la pantalla de login
def flet_app(page: Page):
    page.title = "Sistema de Login"
    show_login(page)

ft.app(target=flet_app, view=ft.WEB_BROWSER, port=4308)
