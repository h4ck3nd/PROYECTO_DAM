import flet as ft
from flet import Page
import psycopg2
import uuid
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime
import re

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

# Función para validar el nombre de usuario
def is_valid_username(usuario):
    # Solo permite letras, números y guiones bajos
    pattern = "^[a-zA-Z0-9_]+$"
    return bool(re.match(pattern, usuario))

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
        # Verificar que todos los campos estén completos
        if password_input.value != confirm_password_input.value:
            page.add(ft.Text("Las contraseñas no coinciden", color="red"))
            page.update()
            return

        if not nombre_input.value or not apellidos_input.value or not email_input.value or not usuario_input.value or not password_input.value:
            page.add(ft.Text("Por favor, completa todos los campos", color="red"))
            page.update()
            return

        # Verificar que el nombre de usuario sea válido
        if not is_valid_username(usuario_input.value):
            page.add(ft.Text("El nombre de usuario solo puede contener letras, números y guiones bajos.", color="red"))
            page.update()
            return

        # Agregar depuración para verificar los valores antes de registrarse
        print(f"Intentando registrar: {nombre_input.value}, {apellidos_input.value}, {email_input.value}, {usuario_input.value}")

        conn = connect_db()
        try:
            # Registramos el usuario pero no iniciamos sesión automáticamente
            user_cookie = register_user(conn, nombre_input.value, apellidos_input.value, email_input.value, usuario_input.value, password_input.value)
            print(f"Usuario registrado con cookie: {user_cookie}")  # Mostrar cookie generada

            # Redirigir al login para que el usuario pueda iniciar sesión
            show_login(page)

        except Exception as error:
            print(f"Error al registrar usuario: {error}")  # Imprimir error en la consola
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

# Función para verificar login
def login_user(db_conn, username_or_email, password):
    cursor = db_conn.cursor()
    cursor.execute("""
        SELECT id, nombre, apellidos, email, usuario, password_hash, cookie FROM usuarios 
        WHERE usuario = %s OR email = %s
    """, (username_or_email, username_or_email))
    user = cursor.fetchone()
    cursor.close()

    if user and check_password_hash(user[5], password):
        return {
            "id": user[0],
            "nombre": user[1],
            "apellidos": user[2],
            "email": user[3],
            "usuario": user[4],
            "cookie": user[6],
            "password_hash": user[5]  # Añadido para verificación de la contraseña
        }
    return None

def get_user_by_cookie(db_conn, user_cookie):
    cursor = db_conn.cursor()
    print(f"Buscando usuario con cookie: {user_cookie}")
    cursor.execute("""
        SELECT id, nombre, apellidos, email, usuario, password_hash, fecha_nacimiento, estado, fecha_registro, rol, cookie 
        FROM usuarios WHERE cookie = %s
    """, (user_cookie,))
    user = cursor.fetchone()
    cursor.close()

    # Agregar depuración para ver qué datos estás obteniendo
    print(f"Datos del usuario recuperados: {user}")

    if user:
        return {
            "id": user[0],
            "nombre": user[1],
            "apellidos": user[2],
            "email": user[3],
            "usuario": user[4],
            "password_hash": user[5],
            "cookie": user[10],  # Asegúrate de que la cookie está correctamente extraída
        }
    return None

# Función para actualizar el perfil del usuario
def update_user_profile(db_conn, user_id, nombre, apellidos, email, usuario):
    cursor = db_conn.cursor()
    cursor.execute("""
        UPDATE usuarios SET nombre = %s, apellidos = %s, email = %s, usuario = %s WHERE id = %s
    """, (nombre, apellidos, email, usuario, user_id))
    db_conn.commit()
    cursor.close()

# Función para actualizar la contraseña
def update_user_password(db_conn, user_id, new_password):
    password_hash = generate_password_hash(new_password)
    cursor = db_conn.cursor()
    cursor.execute("""
        UPDATE usuarios SET password_hash = %s WHERE id = %s
    """, (password_hash, user_id))
    db_conn.commit()
    cursor.close()

# Página de Login
def show_login(page):
    page.clean()

    username_input = ft.TextField(label="Nombre de Usuario o Correo Electrónico")
    password_input = ft.TextField(label="Contraseña", password=True)
    
    def handle_login(e):
        conn = connect_db()
        user_data = login_user(conn, username_input.value, password_input.value)
        conn.close()

        if user_data:
            show_home(page, user_data)
        else:
            page.add(ft.Text("Usuario o contraseña incorrectos", color="red"))
            page.update()

    login_button = ft.ElevatedButton("Iniciar sesión", on_click=handle_login)
    go_register_button = ft.TextButton("¿No tienes cuenta? Regístrate", on_click=lambda _: show_register(page))

    page.add(ft.Column([username_input, password_input, login_button, go_register_button], alignment="center"))
    page.update()

# Página Principal (Home)
def show_home(page, user_data):
    page.clean()

    # Verificar que 'cookie' existe en user_data
    if 'cookie' in user_data:
        profile_info = f"""
        Bienvenido, {user_data['usuario']}
        Nombre: {user_data['nombre']}
        Apellidos: {user_data['apellidos']}
        Correo Electrónico: {user_data['email']}
        Cookie: {user_data['cookie']}  # Mostrar cookie
        """
    else:
        profile_info = "No se pudo recuperar la cookie del usuario"

    welcome_text = ft.Text(profile_info)

    def go_to_edit_profile(e):
        show_edit_profile(page, user_data["cookie"])

    edit_profile_button = ft.ElevatedButton("Editar Perfil", on_click=go_to_edit_profile)
    logout_button = ft.ElevatedButton("Cerrar sesión", on_click=lambda _: show_login(page))

    page.add(ft.Column([welcome_text, edit_profile_button, logout_button], alignment="center"))
    page.update()

# Página de Edición de Perfil
def show_edit_profile(page, user_cookie):
    page.clean()
    
    conn = connect_db()
    user_data = get_user_by_cookie(conn, user_cookie)
    conn.close()

    if not user_data:
        page.add(ft.Text("Error al cargar datos del usuario", color="red"))
        page.update()
        return

    nombre_input = ft.TextField(label="Nombre", value=user_data["nombre"])
    apellidos_input = ft.TextField(label="Apellidos", value=user_data["apellidos"])
    email_input = ft.TextField(label="Correo Electrónico", value=user_data["email"])
    usuario_input = ft.TextField(label="Nombre de Usuario", value=user_data["usuario"])

    # Campos para cambiar la contraseña
    current_password_input = ft.TextField(label="Contraseña Actual", password=True)
    new_password_input = ft.TextField(label="Nueva Contraseña", password=True)
    confirm_new_password_input = ft.TextField(label="Repetir Nueva Contraseña", password=True)

    def handle_update(e):
        conn = connect_db()

        # Verificar si se cambió la contraseña
        if new_password_input.value and new_password_input.value == confirm_new_password_input.value:
            if not check_password_hash(user_data["password_hash"], current_password_input.value):
                page.add(ft.Text("Contraseña actual incorrecta", color="red"))
                page.update()
                conn.close()
                return
            update_user_password(conn, user_data["id"], new_password_input.value)

        # Actualizar datos del perfil
        update_user_profile(conn, user_data["id"], nombre_input.value, apellidos_input.value, email_input.value, usuario_input.value)
        conn.close()

        # Mostrar mensaje de éxito
        page.add(ft.Text("Perfil actualizado exitosamente"))
        show_home(page, user_data)  # Volver al home con datos actualizados
        page.update()

    save_changes_button = ft.ElevatedButton("Guardar Cambios", on_click=handle_update)
    back_button = ft.ElevatedButton("Volver", on_click=lambda _: show_home(page, user_data))

    page.add(ft.Column([
        nombre_input, apellidos_input, email_input, usuario_input, 
        current_password_input, new_password_input, confirm_new_password_input,
        save_changes_button, back_button
    ], alignment="center"))

    page.update()

# Iniciar la app con la pantalla de login
def flet_app(page: Page):
    page.title = "Sistema de Login"
    show_login(page)

ft.app(target=flet_app, view=ft.WEB_BROWSER, port=4308)
