<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="dao.LaboratorioDAO" %>
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

    // Obtener el lab_id de "Crackoff" desde la base de datos
    int labId = LaboratorioDAO.obtenerIdLaboratorioCrackoff();
    String mensaje = "";

    // Recuperamos el mensaje desde la URL
    String resultadoFlag = request.getParameter("mensaje");
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/img/img_dockerpwned/logo-dockerpwned.ico">
  <title>Crackoff Lab - Máquina CTF</title>
  <link href="https://fonts.googleapis.com/css2?family=Share+Tech+Mono&display=swap" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    html, body {
      height: 100%;
      background-color: #121212;
      color: #e0e0e0;
      font-family: 'Share Tech Mono', monospace;
    }

    a {
      color: #00ffff;
      text-decoration: none;
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

    main {
      padding: 40px;
      display: flex;
      flex-direction: column;
      gap: 60px;
    }
	
	.window-buttons {
		display: flex;
		gap: 8px;
		position: absolute;
		right: 20px;
	}
	
	.window-buttons button {
		background: transparent;
		border: none;
		color: #ccc;
		font-size: 16px;
		cursor: pointer;
		padding: 4px 8px;
		transition: background 0.2s ease, color 0.2s ease;
		border-radius: 4px;
	}
	
	.window-buttons button:hover {
		background-color: #333;
	}
	
	.window-buttons .close:hover {
		background-color: #c0392b;
		color: #fff;
	}
	
	.window-buttons .minimize:hover, .window-buttons .maximize:hover {
		background-color: #555;
		color: #fff;
	}
	
    .lab-intro {
      display: flex;
      flex-wrap: wrap;
      gap: 30px;
      align-items: center;
      justify-content: center;
    }

    .lab-img img {
      width: 250px;
      height: 250px;
      border-radius: 12px;
      border: 2px solid #555;
      object-fit: cover;
      box-shadow: 0 0 10px rgba(0,255,204,0.2);
      transition: transform 0.3s ease;
    }

    .lab-img img:hover {
      transform: scale(1.05);
    }

    .lab-info {
      display: flex;
      flex-direction: column;
      gap: 12px;
      max-width: 600px;
    }

    .lab-info h2 {
      font-size: 2rem;
      color: #00ffff;
    }

    .nivel-btn {
      width: 100px;
      padding: 10px;
      background-color: #ff3333;
      color: #fff;
      border: none;
      border-radius: 6px;
      text-align: center;
      font-weight: bold;
    }

    .lab-tecnica {
      text-align: center;
    }

    .tecnica-titulo {
      font-size: 1.5rem;
      color: #ffcc00;
      margin-bottom: 20px;
      text-decoration: underline;
    }

    .tecnica-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
      gap: 15px;
      margin-bottom: 30px;
      max-width: 600px;
      margin-left: auto;
      margin-right: auto;
    }

    .tecnica-grid li {
      list-style: none;
      background-color: #1e1e1e;
      padding: 10px 20px;
      border-radius: 8px;
      border: 1px solid #444;
      box-shadow: inset 0 0 5px #000;
      transition: transform 0.2s;
    }

    .tecnica-grid li:hover {
      transform: scale(1.05);
    }

    .botones {
      display: flex;
      justify-content: center;
      gap: 15px;
      flex-wrap: wrap;
    }

    .botones button {
	  position: relative;
	  background-color: #1a1a1a;
	  color: transparent;
	  border: 1px solid #00ffff33;
	  padding: 12px 28px;
	  font-family: 'Share Tech Mono', monospace;
	  font-size: 1rem;
	  border-radius: 6px;
	  cursor: pointer;
	  overflow: hidden;
	  transition: all 0.3s ease;
	}
	
	/* Capa base del texto glitch */
	.botones button::before,
	.botones button::after,
	.botones button::after {
	  content: attr(data-text);
	  position: absolute;
	  top: 0;
	  left: 0;
	  width: 100%;
	  height: 100%;
	  text-align: center;
	  line-height: 2.5em;
	  font-weight: bold;
	  font-size: 1rem;
	  font-family: 'Share Tech Mono', monospace;
	  pointer-events: none;
	}
	
	/* Glitch principal */
	.botones button::before {
	  color: #00ffff;
	  z-index: 1;
	}
	
	/* Glitch en rojo desplazado */
	.botones button::after {
	  color: red;
	  z-index: 2;
	  animation: glitchRed 1s infinite linear alternate-reverse;
	}
	
	/* Glitch en azul desplazado */
	.botones button::after:nth-of-type(2) {
	  color: blue;
	  z-index: 3;
	  animation: glitchBlue 1s infinite linear alternate-reverse;
	}
	
	/* Animaciones glitch */
	@keyframes glitchRed {
	  0% { transform: translate(1px, -1px); opacity: 0.8; }
	  20% { transform: translate(-1px, 1px); }
	  40% { transform: translate(-1px, -1px); }
	  60% { transform: translate(1px, 1px); }
	  80% { transform: translate(0, -2px); }
	  100% { transform: translate(0, 0); opacity: 0.6; }
	}
	
	@keyframes glitchBlue {
	  0% { transform: translate(-1px, 1px); opacity: 0.8; }
	  20% { transform: translate(1px, -1px); }
	  40% { transform: translate(2px, 0); }
	  60% { transform: translate(-1px, -2px); }
	  80% { transform: translate(1px, 2px); }
	  100% { transform: translate(0, 0); opacity: 0.6; }
	}

    .submenu-container {
      position: relative;
    }

    .submenu-rrss {
      display: none;
      position: absolute;
      top: 110%;
      left: 0;
      background-color: #222;
      padding: 10px;
      border-radius: 6px;
      box-shadow: 0px 2px 10px rgba(0, 255, 204, 0.3);
    }

    .submenu-rrss a {
      display: block;
      padding: 6px 12px;
      color: #fff;
    }

    .submenu-rrss a:hover {
      background-color: #444;
    }

    .lab-certificados {
      text-align: center;
    }

    .certificados-titulo {
      color: #00ffff;
      font-size: 1.5rem;
      text-decoration: underline;
      margin-bottom: 20px;
    }

    .certificado-item {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 20px;
      margin-bottom: 20px;
      flex-wrap: wrap;
    }

    .download-section {
      margin-top: 10px;
      margin-bottom: 10px;
      text-align: center;
    }

    .download-btn {
	  background-color: #1e1e1e;
	  color: #00ffcc;
	  padding: 10px 20px;
	  font-size: 1rem;
	  font-family: 'Share Tech Mono', monospace;
	  font-weight: bold;
	  border: 1px solid #00ffcc44;
	  border-radius: 6px;
	  cursor: pointer;
	  transition: all 0.3s ease;
	  box-shadow: 0 0 0 transparent;
	  letter-spacing: 0.5px;
	  text-transform: uppercase;
	}
	
	.download-btn:hover {
	  background-color: #121212;
	  border-color: #00ffcc;
	  box-shadow: 0 0 10px #00ffcc44;
	  color: #00ffff;
	}

    footer {
      background-color: #1c1c1c;
      color: #888;
      text-align: center;
      padding: 20px;
      font-size: 0.9rem;
      border-top: 1px solid #333;
    }
    .typewriter-cursor::after {
      content: '_';
      animation: blink 1s step-start infinite;
      display: inline-block;
    }

    @keyframes blink {
      50% { opacity: 0; }
    }
    .form-container {
        display: flex;
        justify-content: center;
        align-items: center;
        text-align: center;
        align-content: center;
        min-height: 80vh;
    }
    .forum-container {
		padding: 20px;
		max-width: 800px;
		margin: auto;
		flex-grow: 1;
		overflow-y: auto;
	}
	.labPopup-modal {
	    display: none;
	    position: fixed;
	    z-index: 9999;
	    left: 0;
	    top: 0;
	    width: 100vw;
	    height: 100vh;
	    background-color: rgba(0, 0, 0, 0.6);
	    justify-content: center;
	    align-items: center;
	}
	
	.labPopup-content {
	    background-color: #2d2d2d;
	    padding: 30px;
	    border-radius: 10px;
	    width: 90%;
	    max-width: 600px;
	    box-shadow: 0 0 10px #000;
	    position: relative;
	}
	
	.labPopup-close {
	    color: #aaa;
	    position: absolute;
	    top: 15px;
	    right: 20px;
	    font-size: 28px;
	    font-weight: bold;
	    cursor: pointer;
	}
	
	.labPopup-close:hover {
	    color: #fff;
	}
	
	.labPopup-wrapper {
	    display: flex;
	    flex-direction: column;
	    align-items: center;
	}
	
	.labPopup-form {
	    width: 100%;
	    display: flex;
	    flex-direction: column;
	    gap: 10px;
	    margin-bottom: 25px;
	}
	
	.labPopup-form label {
	    color: #f0f0f0;
	    font-weight: bold;
	}
	
	.labPopup-form input {
	    padding: 10px;
	    background: #222;
	    border: 1px solid #555;
	    border-radius: 5px;
	    color: #fff;
	}
	
	.labPopup-btn {
	    background-color: #4f4f4f;
	    color: #f0f0f0;
	    padding: 10px 20px;
	    border: 1px solid #444;
	    border-radius: 5px;
	    cursor: pointer;
	    font-family: 'Courier New', Courier, monospace;
	    transition: background-color 0.3s ease, transform 0.2s ease;
	}
	
	.labPopup-btn:hover {
	    background-color: #777;
	    transform: translateY(-2px);
	}
	
	.labPopup-btn:active {
	    background-color: #333;
	    transform: translateY(0);
	}
	.hidden {
	  display: none;
	}
	/* Estilo del mensaje emergente */
		.message-popup {
		    position: fixed;
		    top: 50%;
		    left: 50%;
		    transform: translate(-50%, -50%);
		    background-color: rgba(0, 0, 0, 0.85); /* Un poco mÃ¡s oscuro para mÃ¡s Ã©nfasis */
		    padding: 25px 40px; /* MÃ¡s espacio alrededor del mensaje */
		    border-radius: 10px; /* Bordes mÃ¡s redondeados */
		    color: white;
		    max-width: 90%;
		    min-width: 300px;
		    display: none;
		    z-index: 1000;
		    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3); /* Agregar sombra para dar profundidad */
		    font-family: Arial, sans-serif;
		}
		
		/* Estilo del contenido dentro del popup */
		.message-popup .message-popup-content {
		    font-size: 16px;
		    padding: 10px;
		    text-align: center; /* Centrar el texto */
		}
		
		/* Estilo del encabezado dentro del popup */
		.message-popup .message-popup-header {
		    font-size: 20px;
		    font-weight: bold;
		    margin-bottom: 15px;
		    text-align: center;
		    color: #f5f5f5;
		}
		
		/* Estilo del botÃ³n para cerrar el popup */
		.message-popup .message-popup-close-btn {
		    background: #ff5e57;
		    border: none;
		    color: white;
		    padding: 8px 16px;
		    font-size: 18px;
		    cursor: pointer;
		    border-radius: 5px;
		    display: block;
		    margin: 20px auto 0; /* Centrar y separar de la parte superior */
		    text-align: center;
		}
		
		/* Cambio de color al pasar el ratÃ³n sobre el botÃ³n de cerrar */
		.message-popup .message-popup-close-btn:hover {
		    background: #ff3830;
		}
		
		/* Ocultar el popup por defecto */
		.message-popup {
		    display: none; /* AsegÃºrate de que estÃ© oculto por defecto */
		}
		
		/* Mostrar el popup cuando tiene la clase .show */
		.message-popup.show {
		    display: block; /* Se muestra cuando tiene la clase .show */
		}
  </style>
</head>
<body>

<header>
  <div class="header-left">
    <h1 class="typewriter" data-text="CRACKOFF MACHINE"></h1>
  </div>
  <div class="window-buttons">
    <button class="minimize">🗕</button>
    <button class="maximize">🗖</button>
    <button onclick="window.location.href='<%= request.getContextPath() %>/dockerpwned/home_directory_dockerpwned/home_dockerpwned.jsp?page=0'" class="close">✖</button>
  </div>
</header>

<main>
	<!-- Popup para mostrar el mensaje -->
    <div id="popupMessage" class="message-popup">
        <div class="message-popup-header">Mensaje</div>
        <div class="message-popup-content" id="popupContent">
            <p><%= request.getAttribute("mensaje") %></p>
        </div>
        <button class="message-popup-close-btn"><a href="<%= request.getContextPath() %>/dockerpwned/labs/crackoff.jsp" style="text-decoration: none; color: white;">Cerrar</a></button>
    </div>
    <br>
	<!-- POPUP MODAL -->
		<div id="labPopup-modal" class="labPopup-modal">
		    <div class="labPopup-content">
		        <span class="labPopup-close" id="labPopup-closeBtn">&times;</span>
		
		        <!-- CONTENIDO -->
		        <div class="labPopup-wrapper">
		
		            <!-- FORMULARIO PARA ENVIAR WRITEUP -->
		            <form class="labPopup-form" action="<%= request.getContextPath() %>/WriteupControladorDockerpwned" method="post">
		                <input type="hidden" name="lab_id" value="<%= labId %>">
		                <input type="hidden" name="user_id" value="<%= usuarioJWT.getUserId() %>">
		                <input type="hidden" name="username" value="<%= usuarioJWT.getUsuario() %>">
		                <label for="url_writeup">Enviar enlace del Writeup:</label>
		                <input type="url" name="url_writeup" id="url_writeup" required>
		                <button class="labPopup-btn" type="submit">Enviar Writeup</button>
		            </form>
		
		            <!-- FORMULARIO PARA INGRESAR FLAG -->
		            <form class="labPopup-form" action="<%= request.getContextPath() %>/validarFlagDockerpwned" method="get">
		                <input type="hidden" name="user_id" value="<%= usuarioJWT.getUserId() %>">
		                <input type="hidden" name="lab_id" value="<%= labId %>">
		                <label for="flag">Ingrese la FLAG:</label>
		                <input type="text" id="flag" name="flag" required>
		                <button class="labPopup-btn" type="submit">Enviar FLAG</button>
		            </form>
		
		        </div>
		    </div>
		</div>

  <!-- INTRO -->
  <section class="lab-intro">
    <div class="lab-img">
      <img src="<%= request.getContextPath() %>/img/img_dockerpwned/crackoff.png" alt="MÃ¡quina CTF">
    </div>
    <div class="lab-info">
      <h2 class="typewriter" data-text="CRACKOFF MACHINE: DOCKERPWNED"></h2>
      <p><strong>Autor:</strong> D1se0</p>
      <p><strong>Descripción:</strong> Aprende a realizar un SQLi, realizar fuerza bruta, crear una tunelizacion de puertosm, etc...</p>
      <p><strong>Fecha de creación:</strong> 10/02/2025</p>
      <button class="nivel-btn">Difícil</button>
    </div>
  </section>

  <!-- TECNICAS -->
  <section class="lab-tecnica">
    <h3 class="tecnica-titulo">Técnicas Utilizadas</h3>
    <ul class="tecnica-grid">
      <li>🔍 Escaneo de Puertos</li>
      <li>💉 SQL Injection</li>
      <li>🔨 Fuerza Bruta</li>
      <li>🔌 Tunelización de Puertos</li>
      <li>🗝️ KeePassXC</li>
      <li>👀 Observación de Procesos para Ver Qué Root Está¡ Ejecutando en Bucle</li>
      <li>👤 Atención a Permisos del Usuario en los Archivos</li>
    </ul>
  </section>

  <!-- CERTIFICACIONES -->
  <section class="lab-certificados">
    <h3 class="certificados-titulo">Certificaciones Adecuadas</h3>

    <div class="certificado-item">
      <img src="<%= request.getContextPath() %>/img/img_dockerpwned/eCPPT.png" alt="eCPPT" width="50px" height="65px">
      <p>eCPPT - Penetration Tester Profesional por eLearnSecurity</p>
    </div>

    <div class="certificado-item">
      <img src="<%= request.getContextPath() %>/img/img_dockerpwned/eCPTX.png" alt="eCPTX" width="60px" height="50px">
      <p>eCPTX - Experto en Pentesting Avanzado por eLearnSecurity</p>
    </div>
  </section>
  
  <!-- BOTONES -->
  <div class="botones">
	  <button id="labPopup-openBtn" data-text="Enviar Writeup / FLAG">ㅤㅤㅤㅤㅤ</button>
	  <!--<button data-text="Enviar Writeups">ㅤㅤㅤㅤㅤㅤ</button>-->
	  <button data-text="Ver Writeups"><a href="<%= request.getContextPath() %>/verWriteupsDockerpwned?lab_id=<%= labId %>">ㅤㅤㅤㅤㅤㅤ</a></button>
	
	  <div class="submenu-container">
	    <button class="window-btn" data-text="Social">ㅤㅤ</button>
	    <div class="submenu-rrss">
	      <a href="https://github.com/D1seo" target="_blank">GitHub D1seo</a>
	      <a href="https://github.com/Manu" target="_blank">GitHub Manu</a>
	    </div>
	  </div>
	</div>
  
  <!-- DOWNLOAD -->
  <section class="download-section">
  	<h3>============================DOWNLOAD============================</h3>
  	<br><br>
    <button class="download-btn" onclick="window.open('https://drive.google.com/file/d/1zMH1DN9jQRsVaGbjXdcQ5C8yKysmT179/view?usp=sharing', '_blank')">⬇️ Descargar Máquina</button>
    <br><br>
    <h3>================================================================</h3>
  </section>

</main>

<footer>
  <p>Â© 2025 CrackOff Labs. Todos los derechos reservados.</p>
</footer>

<script>
	//Popup Botones de Enviar Flag/Enviar Writeup
	const popup = document.getElementById("labPopup-modal");
	const openBtn = document.getElementById("labPopup-openBtn");
	const closeBtn = document.getElementById("labPopup-closeBtn");
	
	openBtn.onclick = () => popup.style.display = "flex";
	closeBtn.onclick = () => popup.style.display = "none";
	window.onclick = (e) => {
	    if (e.target === popup) popup.style.display = "none";
	};
	// FunciÃ³n para mostrar el popup
    function showPopup(message) {
        var popup = document.getElementById("popupMessage");
        var content = document.getElementById("popupContent");
        content.innerHTML = message; // Ponemos el mensaje en el popup
        popup.classList.add('show'); // Hacemos visible el popup
    }

    // FunciÃ³n para cerrar el popup
    function closePopup() {
        var popup = document.getElementById("popupMessage");
        popup.classList.remove('show'); // Ocultamos el popup
        window.location.href = "<%= request.getContextPath() %>/dockerpwned/labs/crackoff.jsp"; // Redirigimos
    }

    // Si el mensaje no es nulo, mostramos el popup con el mensaje
    <%
        if (resultadoFlag != null) { 
    %>
        showPopup("<%= resultadoFlag %>"); // Mostrar el mensaje en el popup
    <% 
        }
    %>
    
  const btnRRSS = document.querySelector('.submenu-container .window-btn');
  const submenuRRSS = document.querySelector('.submenu-rrss');

  btnRRSS.addEventListener('click', () => {
    submenuRRSS.style.display = submenuRRSS.style.display === 'block' ? 'none' : 'block';
  });
  
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