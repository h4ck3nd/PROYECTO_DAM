<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.nio.file.*, java.io.*" %>
<%
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
    <link rel="stylesheet" href="style.css"> <!-- Si prefieres ponerlo externo -->
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap');

body {
  background-color: #1a1a1a;
  color: #a8c686;
  font-family: 'Press Start 2P', monospace;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  margin: 0;
}

.bios-container {
  background-color: #2c2c2c;
  border: 2px solid #777;
  padding: 30px;
  width: 360px;
  box-sizing: border-box;
}

.retro-image {
  display: block;
  margin: 0 auto 20px auto;
  width: 64px;
  height: auto;
  image-rendering: pixelated;
  filter: grayscale(100%) brightness(1.2);
  object-fit: cover;
  border-radius: 50px;
}

.bios-header {
  font-size: 14px;
  text-align: center;
  margin-bottom: 20px;
  color: #e5e5c9;
}

.login-form {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.login-form label {
  font-size: 10px;
  color: #c7c7c7;
}

.login-form input {
  background-color: #111;
  color: #d6f3c1;
  border: 1px solid #555;
  padding: 8px;
  font-family: 'Press Start 2P', monospace;
  font-size: 10px;
  outline: none;
}

.login-form input:focus {
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
  margin-top: 20px;
  font-size: 8px;
  text-align: center;
  color: #999;
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
    </style>
</head>
<body>
<div class="bios-container">
    <img src="https://cdn-icons-png.flaticon.com/512/684/684908.png" class="retro-image" alt="Retro Icon">
    <div class="bios-header">BruteForce Login Panel</div>

    <form class="login-form" method="post" action="<%= request.getContextPath() %>/GuardarDiccionariosControlador">
        <label for="usuarios">Diccionario de Usuarios:</label>
        <textarea name="usuarios" rows="4" style="font-family: 'Press Start 2P'; font-size: 10px; background-color: #111; color: #d6f3c1; border: 1px solid #555; width: 100%"><%=usuarios %></textarea>

        <label for="contrasenas">Diccionario de Contraseñas:</label>
        <textarea name="contrasenas" rows="4" style="font-family: 'Press Start 2P'; font-size: 10px; background-color: #111; color: #d6f3c1; border: 1px solid #555; width: 100%"><%=contrasenas %></textarea>

        <button type="submit">💾 Guardar Diccionarios</button>
    </form>
	<br>
	<form class="login-form" onsubmit="ejecutarAtaque(event)">
	    <label for="path">Ruta del Login:</label>
	    <input type="text" id="path" name="path" placeholder="http://localhost:8080/login">
	
	    <label for="jsession">JSESSIONID:</label>
	    <input type="text" id="jsession" name="jsession" placeholder="abc123xyz...">
	
	    <label for="token">Token (si aplica):</label>
	    <input type="text" id="token" name="token" placeholder="Token o vacío">
	
	    <button type="submit">🚀 Ejecutar Ataque</button>
	</form>
	
	<!-- Consola retro -->
	<pre id="consoleOutput" style="background:#111;color:#0f0;border:1px solid #333;padding:10px;height:200px;overflow:auto;font-size:10px;margin-top:15px;"></pre>
	

    <div class="bios-footer">Retro Security Labs 2025</div>
</div>

<button class="lightbulb-button" onclick="mostrarInfo()">💡 Info</button>

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

        const formData = new FormData();
        formData.append("path", document.getElementById("path").value);
        formData.append("jsession", document.getElementById("jsession").value);
        formData.append("token", document.getElementById("token").value);
        
        console.log(document.getElementById("path").value);
        console.log(document.getElementById("jsession").value);
        console.log(document.getElementById("token").value);
        
        fetch('<%= request.getContextPath() %>/EjecutarBruteForceControlador', {
            method: 'POST',
            body: formData
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
