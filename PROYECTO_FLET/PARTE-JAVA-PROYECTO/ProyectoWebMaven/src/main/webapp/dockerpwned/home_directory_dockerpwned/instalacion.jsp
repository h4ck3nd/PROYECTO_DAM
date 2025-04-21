<%@ page contentType="text/html; charset=UTF-8" language="java"%>
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
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>DockerPwned - Instrucciones de Instalación</title>
  <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/img/img_dockerpwned/logo-dockerpwned.ico">
  <link href="https://fonts.googleapis.com/css2?family=VT323&display=swap" rel="stylesheet">
  <style>
  * {
			font-family: 'VT323', monospace;
			
		}
    body {
      background-color: #121212;
      color: #e0e0e0;
      font-family: 'Share Tech Mono', monospace;
      font-size: 20px;
      margin: 0;
      padding: 0;
    }

    header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      background-color: #1c1c1c;
      padding: 20px 40px;
      border-bottom: 1px solid #333;
    }

    .header-left h1 {
      color: #00ffcc;
      font-size: 2rem;
      letter-spacing: 1px;
    }

    .window-btn {
      background: #333;
      border: none;
      color: #fff;
      padding: 6px 10px;
      margin-left: 6px;
      border-radius: 5px;
      cursor: pointer;
    }

    .window-btn:hover {
      background-color: #555;
    }

    main {
      padding: 40px 20px;
      max-width: 900px;
      margin: auto;
    }

    h2 {
      color: #00ffff;
      font-size: 1.8rem;
      margin-bottom: 20px;
      text-align: center;
    }

    .paso {
      margin-bottom: 30px;
    }

    .paso h3 {
      color: #ffcc00;
      font-size: 1.3rem;
      margin-bottom: 10px;
    }

    .paso p {
      line-height: 1.6;
    }

    code {
      display: block;
      background-color: #1e1e1e;
      padding: 10px;
      border-radius: 8px;
      border: 1px solid #333;
      margin-top: 10px;
      color: #00ffcc;
    }

    footer {
      background-color: #1c1c1c;
      color: #888;
      text-align: center;
      padding: 20px;
      font-size: 0.9rem;
      border-top: 1px solid #333;
      margin-top: 40px;
    }
    .typewriter-cursor::after {
      content: '_';
      animation: blink 1s step-start infinite;
      display: inline-block;
    }

    @keyframes blink {
      50% { opacity: 0; }
    }
  </style>
</head>
<body>

<header>
  <div class="header-left">
    <h1 class="typewriter" data-text="¿Como instalo los CTFs?"></h1>
  </div>
  <div class="header-right">
    <button class="window-btn">🗕</button>
    <button class="window-btn">🗖</button>
    <button class="window-btn" onclick="window.location.href='<%= request.getContextPath() %>/dockerpwned/home_directory_dockerpwned/home_dockerpwned.jsp?page=0'">✖</button>
  </div>
</header>

<main>
  <h2>🛠️ Instrucciones de Instalación de CTF - DockerPwned</h2>

  <div class="paso">
    <h3>1. Entorno virtual preparado</h3>
    <p>Primero, asegúrate de estar dentro de tu entorno virtual o máquina virtual. Este entorno se usará para lanzar la máquina víctima de forma temporal. Necesitarás algo de espacio en disco.</p>
  </div>

  <div class="paso">
    <h3>2. Descargar la máquina comprimida</h3>
    <p>Descarga el archivo .zip correspondiente al CTF que quieras montar.</p>
  </div>

  <div class="paso">
    <h3>3. Descomprimir el archivo</h3>
    <p>Desde una terminal Linux, descomprime el contenido del archivo ZIP:</p>
    <code class="typewriter" data-text="$ unzip &lt;FILE&gt;.zip"></code>
    <p>Obtendrás dos archivos un: <code class="typewriter" data-text=".tar"></code> con la máquina y un script llamado <code class="typewriter" data-text="auto_mount.sh"></code>.</p>
  </div>

  <div class="paso">
    <h3>4. Montar la máquina en Docker</h3>
    <p>Ejecuta el script <code class="typewriter" data-text="auto_mount.sh"></code> seguido del nombre del archivo <code class="typewriter" data-text=".tar"></code> para lanzar la máquina:</p>
    <code class="typewriter" data-text="$ bash auto_mount.sh &lt;FILE&gt;.tar"></code>
  </div>

  <div class="paso">
    <h3>5. Obtener la IP y empezar a jugar</h3>
    <p>Una vez montada, se iniciará un contenedor Docker de forma temporal y se te mostrará la IP de la máquina.</p>
  </div>

  <div class="paso">
    <h3>6. Cierre automático sin dejar rastros</h3>
    <p>Cuando hayas terminado de hackear la máquina, simplemente presiona <strong>Ctrl+C</strong> en la terminal. Esto eliminará automáticamente el contenedor sin dejar archivos basura.</p>
  </div>

  <div class="paso">
    <h3>📄 Recomendación final</h3>
    <p>Para más detalles, revisa la documentación específica incluida con cada CTF.</p>
  </div>
</main>

<footer>
  <p>© 2025 DockerPwned. Todos los derechos reservados.</p>
</footer>
<script>
document.addEventListener("DOMContentLoaded", () => {
    const elements = document.querySelectorAll(".typewriter");

    elements.forEach((el) => {
      const text = el.getAttribute("data-text");
      let index = 0;

      const cursorSpan = document.createElement("span");
      cursorSpan.className = "typewriter-cursor";
      el.appendChild(cursorSpan);

      const type = () => {
        if (index < text.length) {
          el.insertBefore(document.createTextNode(text.charAt(index)), cursorSpan);
          index++;
          setTimeout(type, 70); // velocidad de escritura
        }
      };

      type();
    });
  });
</script>
</body>
</html>