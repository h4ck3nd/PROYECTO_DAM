<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Panel de Administración Retro</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap');

    html, body {
      height: 100%;
      margin: 0;
      padding: 0;
      font-family: 'Press Start 2P', monospace;
      background-color: #1a1a1a;
      color: #a8c686;
      display: flex;
      flex-direction: column;
    }

    .admin-header {
      background-color: #2c2c2c;
      border-bottom: 2px solid #777;
      padding: 16px;
      text-align: center;
      color: #e5e5c9;
      font-size: 12px;
    }

    .admin-container {
      flex: 1;
      padding: 20px;
      max-width: 900px;
      width: 100%;
      margin: 0 auto;
      box-sizing: border-box;
    }

    .admin-section {
      background-color: #2c2c2c;
      border: 2px solid #777;
      padding: 20px;
      margin-bottom: 20px;
    }

    .admin-section h2 {
      margin-top: 0;
      font-size: 12px;
      color: #e5e5c9;
      text-align: center;
    }

    .admin-section p {
      font-size: 10px;
      color: #c7c7c7;
      margin-bottom: 12px;
    }

    .admin-section button {
      background-color: #444;
      color: #fffde7;
      border: none;
      padding: 10px;
      font-family: 'Press Start 2P', monospace;
      font-size: 10px;
      cursor: pointer;
      width: 100%;
    }

    .admin-section button:hover {
      background-color: #666;
    }

    .admin-footer {
      background-color: #2c2c2c;
      border-top: 2px solid #777;
      padding: 12px;
      text-align: center;
      font-size: 8px;
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
      z-index: 999;
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

    .flag-lab {
  background-color: #2c2c2c;
  border: 2px solid #777;
  padding: 20px;
  width: 58%; /* Igual que las admin-sections */
  margin: 20px auto; /* Centrado horizontalmente */
  color: #e5e5c9;
  font-family: 'Press Start 2P', monospace;
  font-size: 10px;
  text-align: center;
  box-sizing: border-box;
}

.flag-lab button:hover {
  background-color: #666;
}

  </style>
</head>
<body>

  <div class="admin-header">
    PANEL DE ADMINISTRACIÓN - RETROTECH SYSTEMS
  </div>

  <div class="admin-container">
    <div class="admin-section">
      <h2>Gestión de Usuarios</h2>
      <p>Aquí puedes ver, editar o eliminar los usuarios registrados en el sistema.</p>
      <button>ADMINISTRAR AHORA</button>
    </div>

    <div class="admin-section">
      <h2>Registros del Sistema</h2>
      <p>Consulta los logs de acceso y eventos del sistema.</p>
      <button>ADMINISTRAR AHORA</button>
    </div>

    <div class="admin-section">
      <h2>Configuración</h2>
      <p>Modifica las opciones del sistema retro de forma segura.</p>
      <button>ADMINISTRAR AHORA</button>
    </div>
    <div class="admin-section">
      <h2>Módulos de Seguridad</h2>
      <p>Activa o desactiva sistemas de protección y monitoreo de amenazas.</p>
      <button>ADMINISTRAR AHORA</button>
    </div>    
  </div>
  <div class="flag-lab">
    <h2>Flag-Lab</h2>
    <p>Este es un espacio donde se puede encontrar la bandera para desafíos de hacking ético.</p>
    <p><strong>FLAG:</strong> Flag{retro-game_flag}</p>
    <button onclick="window.location.href='<%= request.getContextPath() %>/labs/hacking_community/hacking_community-lab.jsp'">
      ENVIAR WRITEUP
    </button>
  </div>  
  <div class="admin-footer">
    © 2025 RetroTech Systems - Admin Console v1.0
  </div>

  <!-- Botón Bombilla -->
  <button class="lightbulb-button" onclick="togglePopup()">💡</button>

  <!-- Popup -->
  <div class="popup-overlay" id="popupOverlay">
    <div class="popup">
      <span class="close-btn" onclick="togglePopup()">X</span>
      <h2>¿Cómo usar este panel?</h2>
      <p>Este panel de administración retro te permite gestionar el sistema con estilo. Accede a las secciones para manejar usuarios, revisar registros o cambiar configuraciones.</p>
      <p>¡Mantente en modo retro mientras administras como un profesional!</p>
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
