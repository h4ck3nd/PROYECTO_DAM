<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.nio.file.*, java.io.*" %>
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

    String rutaUsuarios = application.getRealPath("/labs/retroGame/users.txt");
    String rutaContrasenas = application.getRealPath("/labs/retroGame/pass.txt");

    File archivoUsuarios = new File(rutaUsuarios);
    File archivoContrasenas = new File(rutaContrasenas);

    if (!archivoUsuarios.exists()) {
        archivoUsuarios.createNewFile();
    }
    if (!archivoContrasenas.exists()) {
        archivoContrasenas.createNewFile();
    }

    String usuarios = new String(Files.readAllBytes(archivoUsuarios.toPath()));
    String contrasenas = new String(Files.readAllBytes(archivoContrasenas.toPath()));
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Brute Force Tool</title>
    <style>
		@import url('https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap');
		
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
		  padding: 30px 30px 40px 30px;
		  max-width: 440px;
		  margin: 40px auto;
		  box-sizing: border-box;
		  display: flex;
		  flex-direction: column;
		  align-items: center;
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
		
		.login-form {
		  width: 100%;
		  display: flex;
		  flex-direction: column;
		  gap: 12px;
		  margin-bottom: 20px;
		}
		
		.login-form label {
		  font-size: 10px;
		  color: #c7c7c7;
		}
		
		.login-form input,
		.login-form textarea {
		  background-color: #111;
		  color: #d6f3c1;
		  border: 1px solid #555;
		  padding: 8px;
		  font-family: 'Press Start 2P', monospace;
		  font-size: 10px;
		  outline: none;
		}
		
		.login-form input:focus,
		.login-form textarea:focus {
		  border-color: #aaa;
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
		
		.bios-footer {
		  margin-top: 30px;
		  font-size: 8px;
		  text-align: center;
		  color: #999;
		}
		.console-terminal {
		  background-color: #111;
		  color: #fffde7;
		  border: 2px solid #777;
		  padding: 20px; /* Aumentamos el padding para más espacio */
		  height: 240px;
		  width: 340px;
		  overflow-y: auto;
		  font-size: 8px; /* Aumentamos el tamaño de fuente para mayor legibilidad */
		  font-family: 'Press Start 2P', monospace;
		  white-space: pre-wrap;
		  box-shadow: inset 0 0 10px #0f0;
		  border-radius: 8px;
		  scrollbar-width: thin;
		  scrollbar-color: #4caf50 #222;
		  line-height: 1.6; /* Aumentamos el espaciado entre líneas */
		}
		
		.console-terminal::-webkit-scrollbar {
		  width: 8px;
		}
		
		.console-terminal::-webkit-scrollbar-track {
		  background: #222;
		}
		
		.console-terminal::-webkit-scrollbar-thumb {
		  background-color: #4caf50;
		  border-radius: 10px;
		}
		.lightbulb-button {
		  background-color: #444;
		  color: #fffde7;
		  border: 2px solid #777;
		  padding: 12px;
		  font-size: 12px;
		  cursor: pointer;
		  display: flex;
		  align-items: center;
		  gap: 8px;
		  position: fixed;
		  bottom: 20px;
		  right: 20px;
		  z-index: 1000;
		  border-radius: 25px;
		}
		.lightbulb-button:hover {
		  background-color: #666;
		}
		
		.popup-overlay {
		  position: fixed;
		  top: 0;
		  left: 0;
		  width: 100%;
		  height: 100%;
		  background-color: rgba(20, 20, 20, 0.8);
		  display: none;
		  justify-content: center;
		  align-items: center;
		}
		.popup {
		  background-color: #2c2c2c;
		  border: 2px solid #777;
		  padding: 20px;
		  width: 400px;
		  color: #e5e5c9;
		  position: relative;
		  font-size: 10px;
		}
		.popup p {
		  line-height: 1.6;
		}
		.popup h2 {
		  font-size: 12px;
		  margin-top: 0;
		  margin-bottom: 10px;
		  text-align: center;
		}
		.popup .close-btn {
		  position: absolute;
		  top: 5px;
		  right: 10px;
		  cursor: pointer;
		  color: #aaa;
		  font-size: 12px;
		}
		.popup .close-btn:hover {
		  color: #fff;
		}
		.retro-header {
		  width: 97.35%;
		  background-color: #2c2c2c;
		  color: #a8c686;
		  font-family: 'Press Start 2P', monospace;
		  font-size: 10px;
		  padding: 22px 25px;
		  display: flex;
		  justify-content: space-between;
		  align-items: center;
		  border-bottom: 2px solid #777;
		  box-shadow: 0 2px 6px #111;
		  position: sticky;
		  top: 0;
		  z-index: 100;
		}
		
		.header-title {
		  font-size: 10px;
		  color: #e5e5c9;
		}
		
		.status-online {
		  color: #d6f3c1;
		}
		
		.retro-footer {
		  background-color: #2c2c2c;
		  color: #a8c686;
		  font-family: 'Press Start 2P', monospace;
		  font-size: 8px;
		  padding: 16px;
		  text-align: center;
		  align-items: center;
		  align-content: center;
		  margin-top: 40px;
		  border-top: 2px solid #777;
		  box-shadow: 0 -2px 6px #111;
		  display: flex;
		  justify-content: center;
		  flex-wrap: wrap;
		  gap: 20px;
		}
		
		.retro-footer div {
		  white-space: nowrap;
		}
    </style>
</head>
<body>
	<!-- HEADER RETRO -->
	<header class="retro-header">
	  <div>💀 RETRO ATTACK BOX v1.0</div>
	  <div><a href="<%= request.getContextPath() %>/labs/retroGame/retroGame-login.jsp" style="margin-left: -80px; text-decoration: none; color: #a8c686;">VOLVER AL LOGIN</a></div>
	  <div>Estado: <span class="status-indicator">ACTIVO</span></div>
	</header>
	
	<!-- CONTENEDOR PRINCIPAL -->
	<div class="bios-container">
	    <img src="https://cdn-icons-png.flaticon.com/512/684/684908.png" class="retro-image" alt="Retro Icon">
	    <div class="bios-header">BruteForce Login Panel</div>
	
	    <!-- FORM GUARDAR DICCIONARIOS -->
	    <form class="login-form" method="post" action="<%= request.getContextPath() %>/GuardarDiccionariosControlador">
	        <label for="usuarios">Diccionario de Usuarios:</label>
	        <textarea name="usuarios" rows="4"><%=usuarios %></textarea>
	
	        <label for="contrasenas">Diccionario de Contraseñas:</label>
	        <textarea name="contrasenas" rows="4"><%=contrasenas %></textarea>
	
	        <button type="submit">💾 Guardar Diccionarios</button>
	    </form>
	
	    <!-- FORM ATAQUE -->
	    <form class="login-form" onsubmit="ejecutarAtaque(event)">
	        <label for="path">Ruta del Login:</label>
	        <input type="text" id="path" name="path" placeholder="localhost:8080/ProyectoWebMaven">
	
	        <label for="jsession">JSESSIONID:</label>
	        <input type="text" id="jsession" name="jsession" placeholder="abc123xyz...">
	
	        <label for="token">Token (si aplica):</label>
	        <input type="text" id="token" name="token" placeholder="Token o vacío">
	
	        <button type="submit">🚀 Ejecutar Ataque</button>
	    </form>
		
	    <!-- TERMINAL -->
	    <pre id="consoleOutput" class="console-terminal"></pre>
	    
	    <div class="bios-footer">Retro Security Labs 2025</div>
	</div>
	
	<!-- FOOTER INFO -->
	<footer class="retro-footer">
	  <br><br><br><br><br>
	  <div>🧠 IP Atacante: 127.0.0.1</div>
	  <div>💾 Sistema: RetroCTF-Windows</div>
	  <div>🔓 Usuario: <%= usuarioJWT.getUsuario() %>@lab</div>
	  <div>📅 Año: 2025</div>
	  <div>👾 by Retro Security Labs</div>
	  <br><br><br><br><br>
	</footer>
	
	<!-- INFO BUTTON -->
	<button class="lightbulb-button" onclick="mostrarInfo()">💡 Info</button>
	
	<!-- POPUP -->
	<div class="popup-overlay" id="popup">
	    <div class="popup">
	        <span class="close-btn" onclick="cerrarPopup()">✖</span>
	        <h2>Información de uso</h2>
	        <p>Introduce las rutas necesarias, JSesion y token si es necesario. Guarda tus diccionarios antes de lanzar el ataque.</p>
	    </div>
	</div>

<script>
    function mostrarInfo() {
        document.getElementById("popup").style.display = "flex";
    }
    function cerrarPopup() {
        document.getElementById("popup").style.display = "none";
    }
    
    // CONSOLA
    
    function ejecutarAtaque(event) {
    event.preventDefault();
    const consoleEl = document.getElementById("consoleOutput");
    consoleEl.textContent = "⌛ Ejecutando ataque...\n";

    const path = document.getElementById("path").value;
    const jsession = document.getElementById("jsession").value;
    const token = document.getElementById("token").value;

    console.log("Path:", path);
    console.log("JSESSION:", jsession);
    console.log("Token:", token);

    const contextPath = '<%= request.getContextPath() %>';
    const url = contextPath + '/EjecutarBruteForceControlador' +
                '?path=' + encodeURIComponent(path) +
                '&jsession=' + encodeURIComponent(jsession) +
                '&token=' + encodeURIComponent(token);

    fetch(url, {
        method: 'GET'
    })
    .then(res => res.body.getReader())
    .then(reader => {
        const decoder = new TextDecoder();
        function read() {
            reader.read().then(({ done, value }) => {
                if (done) {
                    consoleEl.textContent += "\n✅ Finalizado.";
                    return;
                }
                consoleEl.textContent += decoder.decode(value);
                consoleEl.scrollTop = consoleEl.scrollHeight;
                read();
            });
        }
        read();
    })
    .catch(err => {
        consoleEl.textContent += "\n❌ Error: " + err;
    });
}
</script>
</body>
</html>
