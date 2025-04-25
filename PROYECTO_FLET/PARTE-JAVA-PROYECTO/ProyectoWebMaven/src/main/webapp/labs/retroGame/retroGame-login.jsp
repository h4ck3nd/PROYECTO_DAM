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
  <meta charset="UTF-8">
  <title>Login Retro 60s</title>
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
    
    .attacker-button {
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
  left: 20px;
  z-index: 1000;
  border-radius: 25px;
}

    .attacker-button:hover {
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
      line-height: 1.6;
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
    header {
	  display: flex;
	  justify-content: space-between;
	  align-items: center;
	  padding: 8px 16px;
	  border-bottom: 1px solid #1e1e1e;
	  position: fixed;
	  top: 0;
	  width: 100%;
	  z-index: 1000;
	}
	.window-controls {
	  display: flex;
	  margin-right: 30px;
	  gap: 8px;
	}
	.win-btn {
	  background: #21262d;
	  border: none;
	  color: #e6edf3;
	  width: 30px;
	  height: 30px;
	  font-size: 1rem;
	  cursor: pointer;
	  border-radius: 4px;
	  font-family: 'Press Start 2P', monospace;
	  transition: background 0.2s ease;
	}
	.win-btn:hover {
	  background-color: #30363d;
	}
	.win-btn {
	  background: #21262d;
	  border: none;
	  color: #e6edf3;
	  width: 30px;
	  height: 30px;
	  font-size: 1rem;
	  cursor: pointer;
	  border-radius: 4px;
	  font-family: 'Press Start 2P', monospace;
	  transition: background 0.2s ease;
	  
	  display: flex;
	  align-items: center;
	  justify-content: center;
	  padding: 0; /* Opcional: asegura que no haya desplazamientos internos */
	}
  </style>
</head>
<body>
  <header>
	  <div class="left">
	    <!-- Aquí podrías colocar un logo o nombre si quisieras -->
	  </div>
	  <div class="window-controls">
	    <button class="win-btn minimize">—</button>
	    <button class="win-btn maximize">□</button>
	    <button onclick="window.location.href='<%= request.getContextPath() %>/labs/retroGame/retroGame-lab.jsp'" class="win-btn close">✕</button>
	  </div>
	</header>
  <div class="bios-container">
    <img src="<%= request.getContextPath() %>/img/login-retro.png" alt="Logo Retro" class="retro-image">
    <div class="bios-header">SISTEMA DE ACCESO</div>
    <form action="<%= request.getContextPath() %>/LoginGameRetroControlador" method="post" class="login-form">
	    <label for="username">USUARIO</label>
	    <input type="text" id="username" name="username" required>
	
	    <label for="password">CONTRASEÑA</label>
	    <input type="password" id="password" name="password" required>
	
	    <button type="submit">ENTRAR</button>
	</form>
    <div class="bios-footer">© 2025 Login Retro</div>
  </div>
  <button class="lightbulb-button" onclick="togglePopup()">
    💡
  </button>
  
  <button class="attacker-button" onclick="attackerPopup()">
    💀
  </button>
  
  <!-- POPUP DE DESCRIPCIÓN -->
<div class="popup-overlay" id="attackerPopup">
    <div class="popup">
        <span class="close-btn" onclick="cerrarPopup('attackerPopup')">✖</span>
        <h2>Descripción de la Página</h2>
        <p>
            Esta es tu <strong>máquina atacante</strong> en el entorno de CTF (Capture The Flag). 
            A través de este panel, puedes simular un ataque de <strong>fuerza bruta</strong> 
            para intentar descubrir contraseñas de un sistema vulnerable en un entorno controlado. 
            Ingresa los diccionarios de usuarios y contraseñas, junto con la ruta de login, 
            el JSESSIONID y el token para realizar el ataque.
        </p>
        <button class="popup-button" onclick="irABruteForce()">Ir al Brute Force Tool</button>
    </div>
</div>
  
  <div class="popup-overlay" id="popupOverlay">
    <div class="popup">
      <span class="close-btn" onclick="togglePopup()">X</span>
      <h2>¿Qué es un ataque de Fuerza Bruta?</h2>
      <p>
        Un ataque de fuerza bruta es un método utilizado para descifrar contraseñas o encontrar combinaciones válidas de usuario y contraseña mediante la prueba exhaustiva de todas las combinaciones posibles. Este ataque puede ser muy efectivo si no existen mecanismos de protección como límites de intentos de login o autenticación multifactor.
      </p>
      <p>
        Durante un ataque de fuerza bruta, el atacante utiliza una lista de usuarios y contraseñas, probando cada combinación hasta encontrar una correcta. Este ataque es especialmente peligroso cuando el sistema no tiene medidas adecuadas para evitar múltiples intentos fallidos.
      </p>
      <p>
        Para realizar este tipo de ataque, los atacantes generalmente emplean herramientas automatizadas que envían solicitudes de login repetidamente con diferentes combinaciones de usuarios y contraseñas hasta conseguir acceso.
      </p>
      <button onclick="window.location.href='scriptPage.jsp';">Ver el Script en Python</button>
    </div>
</div>

  <script>
    function togglePopup() {
      const popup = document.getElementById('popupOverlay');
      popup.style.display = popup.style.display === 'flex' ? 'none' : 'flex';
    }
    
 	// Mostrar el popup
    function attackerPopup() {
        document.getElementById("attackerPopup").style.display = "flex";
    }

    // Cerrar el popup
    function cerrarPopup(popupId) {
        document.getElementById(popupId).style.display = "none";
    }

    // Redirigir a la página bruteForce.jsp
    function irABruteForce() {
        window.location.href = "<%= request.getContextPath() %>/labs/retroGame/bruteForce.jsp";  // Redirige a bruteForce.jsp
    }
  </script>
</body>
</html>