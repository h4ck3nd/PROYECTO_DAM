<%@ page contentType="text/html; charset=UTF-8" language="java"%>
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
    <img src="<%= request.getContextPath() %>/img/login-retro.png" alt="Logo Retro" class="retro-image">
    <div class="bios-header">SISTEMA DE ACCESO</div>
    <form class="login-form">
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

  <div class="popup-overlay" id="popupOverlay">
    <div class="popup">
      <span class="close-btn" onclick="togglePopup()">X</span>
      <h2>¿Qué es Burp Suite?</h2>
      <p>
        Burp Suite es una herramienta esencial para el hacking web ético. Permite interceptar, modificar y analizar el tráfico entre el navegador y el servidor. Es clave para descubrir vulnerabilidades como XSS, SQLi, CSRF y muchas otras en aplicaciones web.
      </p>
      <p>
        Se usa en pruebas de penetración profesionales y también en laboratorios de aprendizaje como Hack The Box o TryHackMe.
      </p>
    </div>
  </div>

  <script>
    function togglePopup() {
      const popup = document.getElementById('popupOverlay');
      popup.style.display = popup.style.display === 'flex' ? 'none' : 'flex';
    }
  </script>
</body>
</html>