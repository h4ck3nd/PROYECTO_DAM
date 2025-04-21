<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Herramientas Hacking Ético</title>
  <style>
    * {
      box-sizing: border-box;
    }

    body {
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
      background-color: #0f1117;
      color: #ffffff;
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }

    header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 10px 20px;
      background-color: #0f1117;
      border-bottom: 1px solid #1e1e1e;
    }

    header .left {
      display: flex;
      align-items: center;
    }

    header img {
      height: 30px;
      margin-right: 10px;
    }

    header h1 {
      font-size: 16px;
      color: #00ffcc;
      letter-spacing: 2px;
    }

    .window-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	background: #161b22;
	border-bottom: 1px solid #30363d;
	padding: 10px 20px;
}

.window-controls {
	display: flex;
	gap: 10px;
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
}

.win-btn:hover {
	background-color: #30363d;
}

    main {
      flex: 1;
      padding: 40px 20px;
      text-align: center;
    }

    h2 {
      font-size: 24px;
      margin-bottom: 10px;
      color: #fff;
    }

    p.description {
      color: #ccc;
      margin-bottom: 40px;
    }

    .tool-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
      gap: 30px;
      max-width: 1200px;
      margin: 0 auto;
    }

    .tool-card {
      background: radial-gradient(circle at top left, #1b1f27, #0f1117);
      padding: 20px;
      border-radius: 16px;
      box-shadow: 0 0 15px #1f1f1f;
      border: 1px solid #1c1c1c;
      text-align: center;
      transition: all 0.3s ease;
    }

    .tool-card:hover {
      box-shadow: 0 0 20px #00ffcc77;
    }

    .tool-card img {
      width: 60px;
      height: 60px;
      object-fit: contain;
      margin-bottom: 10px;
    }

    .tool-card h3 {
      color: #aa88ff;
      font-size: 18px;
      margin-bottom: 10px;
    }

    .tool-card .buttons {
  display: flex;
  justify-content: space-around;
  margin-top: 15px;
}

.tool-card .buttons button {
  background-color: #1a1a1a;
  border: 1px solid #2f2f2f;
  color: #00ffcc;
  text-decoration: none;
  padding: 5px 10px;
  border-radius: 8px;
  font-size: 13px;
  transition: background 0.2s ease;
  cursor: pointer; /* Asegura que el cursor sea de mano sobre el botón */
}

.tool-card .buttons button:hover {
  background-color: #00ffcc33;
}

botones .tool-card .buttons {
      display: flex;
      justify-content: space-around;
      margin-top: 15px;
    }

    .tool-card .buttons a {
      background-color: #1a1a1a;
      border: 1px solid #2f2f2f;
      color: #00ffcc;
      text-decoration: none;
      padding: 5px 10px;
      border-radius: 8px;
      font-size: 13px;
      transition: background 0.2s ease;
    }

    .tool-card .buttons a:hover {
      background-color: #00ffcc33;
    }

   .modal {
  display: none;
  position: fixed;
  z-index: 999;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0, 0, 0, 0.7);
}


  .modal-content {
    background-color: #1b1f27;
    margin: 10% auto;
    padding: 20px;
    border: 1px solid #333;
    width: 80%;
    max-width: 500px;
    border-radius: 12px;
    color: #eee;
    box-shadow: 0 0 10px #00ffcc55;
  }

  .modal-content h2 {
    color: #00ffcc;
  }

  .modal-img {
  width: 100%;
  max-width: 200px;
  margin: 10px auto;
  display: block;
  border-radius: 10px;
  box-shadow: 0 0 10px #00ffcc55;
}

  .close {
    color: #aaa;
    float: right;
    font-size: 24px;
    font-weight: bold;
    cursor: pointer;
  }

  .close:hover {
    color: #fff;
  }

    footer {
      background-color: #0f1117;
      border-top: 1px solid #1e1e1e;
      text-align: center;
      padding: 20px;
      font-size: 12px;
      color: #888;
    }
  </style>
</head>
<body>

  <header>
    <div class="left">
      <img src="logo.png" alt="Logo">
      <h1>HACKER TOOL</h1>
    </div>
    <div class="window-controls">
			<button class="win-btn minimize">—</button>
			<button class="win-btn maximize">□</button>
			<button onclick="window.location.href='<%= request.getContextPath() %>/labs/foro-xss-lab.jsp'" class="win-btn close">✕</button>
		</div>
  </header>

  <main>
    <h2>Herramientas recomendadas para hacking ético</h2>
    <p class="description">Estas herramientas son utilizadas diariamente por profesionales del hacking ético para realizar pruebas de penetración, análisis de vulnerabilidades y auditorías de seguridad.</p>
    
    <div class="tool-grid">
      <div class="tool-card">
        <img src="nmap.png" alt="Nmap">
        <h3>Nmap</h3>
        <div class="buttons">
          <a href="#">Descargar</a>
          <button onclick="openModal('nmap')">Más info</button>
        </div>
      </div>
    
      <div class="tool-card">
        <img src="wireshark.png" alt="Wireshark">
        <h3>Wireshark</h3>
        <div class="buttons">
          <a href="#">Descargar</a>
          <button onclick="openModal('wireshark')">Más info</button>
        </div>
      </div>
    
      <div class="tool-card">
        <img src="burpsuite.png" alt="Burp Suite">
        <h3>Burp Suite</h3>
        <div class="buttons">
          <a href="#">Descargar</a>
          <button onclick="openModal('burpsuite')">Más info</button>
        </div>
      </div>
    
      <div class="tool-card">
        <img src="metasploit.png" alt="Metasploit">
        <h3>Metasploit</h3>
        <div class="buttons">
          <a href="#">Descargar</a>
          <button onclick="openModal('metasploit')">Más info</button>
        </div>
      </div>
    
      <div class="tool-card">
        <img src="john.png" alt="John the Ripper">
        <h3>John the Ripper</h3>
        <div class="buttons">
          <a href="#">Descargar</a>
          <button onclick="openModal('john')">Más info</button>
        </div>
      </div>
    
      <div class="tool-card">
        <img src="hydra.png" alt="Hydra">
        <h3>Hydra</h3>
        <div class="buttons">
          <a href="#">Descargar</a>
          <button onclick="openModal('hydra')">Más info</button>
        </div>
      </div>
      <!-- Nikto -->
<div class="tool-card">
  <img src="nikto.png" alt="Nikto">
  <h3>Nikto</h3>
  <div class="buttons">
    <a href="https://cirt.net/Nikto2" target="_blank">Descargar</a>
    <button onclick="openModal('nikto')">Más Info</button>
  </div>
</div>

<!-- SQLmap -->
<div class="tool-card">
  <img src="sqlmap.png" alt="SQL MAP">
  <h3>SQLmap</h3>
  <div class="buttons">
    <a href="https://sqlmap.org/" target="_blank">Descargar</a>
    <button onclick="openModal('sqlmap')">Más Info</button>
  </div>
</div>

<!-- Aircrack-ng -->
<div class="tool-card">
  <img src="aircrack.png" alt="Aircrack">
  <h3>Aircrack-ng</h3>
  <div class="buttons">
    <a href="https://www.aircrack-ng.org/" target="_blank">Descargar</a>
    <button onclick="openModal('aircrack')">Más Info</button>
  </div>
</div>

<!-- TheHarvester -->
<div class="tool-card">
  <img src="theharvester.png" alt="TheHarvester">
  <h3>TheHarvester</h3>
  <div class="buttons">
    <a href="https://github.com/laramies/theHarvester" target="_blank">Descargar</a>
    <button onclick="openModal('theharvester')">Más Info</button>
  </div>
</div>
<!-- SET -->
<div class="tool-card">
<img src="set.png" alt="Set">
  <h3>SET</h3>
  <div class="buttons">
    <a href="https://github.com/trustedsec/social-engineer-toolkit" target="_blank">Descargar</a>
    <button onclick="openModal('set')">Más Info</button>
  </div>
</div>

<!-- Maltego -->
<div class="tool-card">
<img src="maltego.png" alt="Maltego">
  <h3>Maltego</h3>
  <div class="buttons">
    <a href="https://www.maltego.com/" target="_blank">Descargar</a>
    <button onclick="openModal('maltego')">Más Info</button>
  </div>
</div>

<!-- Netcat -->
<div class="tool-card">
<img src="netcat.png" alt="Netcat">
  <h3>Netcat</h3>
  <div class="buttons">
    <a href="https://nmap.org/ncat/" target="_blank">Descargar</a>
    <button onclick="openModal('netcat')">Más Info</button>
  </div>
</div>

<!-- Recon-ng -->
<div class="tool-card">
<img src="recon-ng.png" alt="Recon-ng">
  <h3>Recon-ng</h3>
  <div class="buttons">
    <a href="https://github.com/lanmaster53/recon-ng" target="_blank">Descargar</a>
    <button onclick="openModal('reconng')">Más Info</button>
  </div>
</div>

<!-- Dirb -->
<div class="tool-card">
<img src="dirb.png" alt="Dirb">
  <h3>Dirb</h3>
  <div class="buttons">
    <a href="https://tools.kali.org/web-applications/dirb" target="_blank">Descargar</a>
    <button onclick="openModal('dirb')">Más Info</button>
  </div>
</div>
    </div>
    
<!-- NMAP -->
<div id="modal-nmap" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeModal('nmap')">&times;</span>
    <h2>Nmap</h2>
    <img src="nmap.png" alt="Nmap Logo" class="modal-img">
    <p>Nmap es una herramienta de escaneo de redes utilizada para descubrir hosts y servicios. Permite realizar mapeo de puertos, detección de sistemas operativos y más. Es fundamental para el reconocimiento en pruebas de penetración.</p>
  </div>
</div>

<!-- WIRESHARK -->
<div id="modal-wireshark" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeModal('wireshark')">&times;</span>
    <h2>Wireshark</h2>
    <img src="wireshark.png" alt="Wireshark Logo" class="modal-img">
    <p>Wireshark es un analizador de protocolos de red. Captura y muestra los datos en tiempo real para su análisis detallado. Es ideal para examinar el tráfico de red, detectar anomalías y depurar protocolos.</p>
  </div>
</div>

<!-- BURP SUITE -->
<div id="modal-burpsuite" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeModal('burpsuite')">&times;</span>
    <h2>Burp Suite</h2>
    <img src="burpsuite.png" alt="Burp Suite Logo" class="modal-img">
    <p>Burp Suite es una herramienta muy usada en pruebas de seguridad web. Permite interceptar tráfico, modificar peticiones, escanear vulnerabilidades y realizar ataques manuales o automatizados a aplicaciones web.</p>
  </div>
</div>

<!-- METASPLOIT -->
<div id="modal-metasploit" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeModal('metasploit')">&times;</span>
    <h2>Metasploit</h2>
    <img src="metasploit.png" alt="Metasploit Logo" class="modal-img">
    <p>Metasploit Framework es una plataforma poderosa para desarrollar y ejecutar exploits. Se utiliza para pruebas de penetración, permitiendo lanzar ataques controlados y evaluar la seguridad de los sistemas.</p>
  </div>
</div>

<!-- JOHN THE RIPPER -->
<div id="modal-john" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeModal('john')">&times;</span>
    <h2>John the Ripper</h2>
    <img src="john.png" alt="John the Ripper Logo" class="modal-img">
    <p>John the Ripper es una herramienta para descifrado de contraseñas. Realiza ataques de diccionario y fuerza bruta sobre hashes para recuperar credenciales comprometidas. Ideal para auditorías de seguridad.</p>
  </div>
</div>

<!-- HYDRA -->
<div id="modal-hydra" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeModal('hydra')">&times;</span>
    <h2>Hydra</h2>
    <img src="hydra.png" alt="Hydra Logo" class="modal-img">
    <p>Hydra es una herramienta de fuerza bruta rápida y flexible. Permite atacar múltiples servicios como SSH, FTP, HTTP, RDP, etc., utilizando diccionarios de usuario y contraseña para encontrar accesos válidos.</p>
  </div>
</div>
  <!-- NIKTO -->
  <div id="modal-nikto" class="modal">
    <div class="modal-content">
      <span class="close" onclick="closeModal('nikto')">&times;</span>
      <h2>Nikto</h2>
      <img src="nikto.png" alt="Nikto Logo" class="modal-img">
      <p>Nikto es un escáner de servidores web que detecta vulnerabilidades como archivos inseguros, configuraciones erróneas y versiones obsoletas de software. Ideal para detectar problemas en páginas web rápidamente.</p>
    </div>
  </div>
  
  <!-- SQLMAP -->
  <div id="modal-sqlmap" class="modal">
    <div class="modal-content">
      <span class="close" onclick="closeModal('sqlmap')">&times;</span>
      <h2>SQLmap</h2>
      <img src="sqlmap.png" alt="SQLmap Logo" class="modal-img">
      <p>SQLmap automatiza el proceso de detección y explotación de inyecciones SQL. Puede extraer datos, obtener accesos de administrador, e incluso tomar control total de bases de datos vulnerables.</p>
    </div>
  </div>
  
  <!-- AIRCRACK-NG -->
  <div id="modal-aircrack" class="modal">
    <div class="modal-content">
      <span class="close" onclick="closeModal('aircrack')">&times;</span>
      <h2>Aircrack-ng</h2>
      <img src="aircrack.png" alt="Aircrack-ng Logo" class="modal-img">
      <p>Aircrack-ng es un conjunto de herramientas para pruebas de seguridad en redes Wi-Fi. Permite capturar paquetes, descifrar claves WEP/WPA, inyectar paquetes y realizar ataques a nivel de red inalámbrica.</p>
    </div>
  </div>
  
  <!-- THEHARVESTER -->
  <div id="modal-theharvester" class="modal">
    <div class="modal-content">
      <span class="close" onclick="closeModal('theharvester')">&times;</span>
      <h2>TheHarvester</h2>
      <img src="theharvester.png" alt="TheHarvester Logo" class="modal-img">
      <p>TheHarvester recopila información de fuentes públicas (OSINT) como Google, Bing o LinkedIn para encontrar correos electrónicos, nombres de empleados, hosts y subdominios. Útil para fases de reconocimiento.</p>
    </div>
  </div>
<!-- SET -->
<div id="modal-set" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeModal('set')">&times;</span>
    <h2>Social-Engineer Toolkit (SET)</h2>
    <img src="set.png" alt="SET Logo" class="modal-img">
    <p>SET es una herramienta potente para realizar pruebas de ingeniería social, incluyendo la creación de páginas de phishing, envío de correos maliciosos y ataques personalizados. Ideal para simular ataques dirigidos.</p>
  </div>
</div>

<!-- Maltego -->
<div id="modal-maltego" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeModal('maltego')">&times;</span>
    <h2>Maltego</h2>
    <img src="maltego.png" alt="Maltego Logo" class="modal-img">
    <p>Maltego es una herramienta visual que permite recolectar y mapear relaciones entre personas, dominios, IPs, correos, y más, usando fuentes públicas. Ideal para análisis forense y OSINT avanzado.</p>
  </div>
</div>

<!-- Netcat -->
<div id="modal-netcat" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeModal('netcat')">&times;</span>
    <h2>Netcat</h2>
    <img src="netcat.png" alt="Netcat Logo" class="modal-img">
    <p>Netcat, también llamado el "cuchillo suizo" de las redes, permite crear conexiones TCP/UDP, realizar escaneos de puertos, y establecer shells reversas. Esencial para comunicación entre máquinas.</p>
  </div>
</div>

<!-- Recon-ng -->
<div id="modal-reconng" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeModal('reconng')">&times;</span>
    <h2>Recon-ng</h2>
    <img src="reconng.png" alt="Recon-ng Logo" class="modal-img">
    <p>Recon-ng es un framework basado en módulos para realizar recolección de información sobre objetivos desde múltiples fuentes. Es automatizable y muy útil para tareas de OSINT.</p>
  </div>
</div>

<!-- Dirb -->
<div id="modal-dirb" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeModal('dirb')">&times;</span>
    <h2>Dirb</h2>
    <img src="dirb.png" alt="Dirb Logo" class="modal-img">
    <p>Dirb es un escáner de contenido web que usa diccionarios para encontrar directorios y archivos ocultos en un servidor. Útil para descubrir recursos no protegidos o no indexados.</p>
  </div>
</div>

  </main>
<!-- Script del modal -->
<script>
//Función para abrir el modal
function openModal(toolId) {
  // Intentar encontrar el modal usando el id
  var modal = document.getElementById('modal-' + toolId);
  
  if (modal) {
    // Si el modal existe, cambiar su display a 'block' para mostrarlo
    modal.style.display = 'block';
    console.log('Modal abierto para: ' + toolId);
  } else {
    // Si no se encuentra el modal, mostrar un error en la consola
    console.error('No se encontró el modal con id: modal-' + toolId);
  }
}

// Función para cerrar el modal
function closeModal(toolId) {
  // Intentar encontrar el modal usando el id
  var modal = document.getElementById('modal-' + toolId);
  
  if (modal) {
    // Si el modal existe, cambiar su display a 'none' para ocultarlo
    modal.style.display = 'none';
    console.log('Modal cerrado para: ' + toolId);
  } else {
    // Si no se encuentra el modal, mostrar un error en la consola
    console.error('No se encontró el modal con id: modal-' + toolId);
  }
}

// Cerrar el modal si el usuario hace clic fuera de él
window.onclick = function(event) {
  var modals = document.querySelectorAll('.modal');
  modals.forEach(function(modal) {
    if (event.target == modal) {
      modal.style.display = "none";
    }
  });
}

</script>
  <footer>
    © 2025 HACKER TOOL. Todos los derechos reservados.
  </footer>

</body>
</html>
