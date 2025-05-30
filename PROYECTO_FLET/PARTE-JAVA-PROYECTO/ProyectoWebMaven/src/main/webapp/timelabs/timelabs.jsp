<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="dao.FotoDAO" %>
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

    // Validar que userId no sea null ni vacío
    if (usuarioJWT.getUserId() == null || usuarioJWT.getUserId().isEmpty()) {
        out.println("<p>Error: El ID de usuario no está disponible en el token.</p>");
        return;
    }

    // Crear una instancia del DAO y obtener la foto de perfil
    FotoDAO fotoDAO = new FotoDAO();
    String photoPath = fotoDAO.obtenerRutaFotoPerfil(usuarioJWT.getUserId());

    // Si no tiene foto de perfil, establecer una imagen por defecto
    if (photoPath == null || photoPath.isEmpty()) {
        photoPath = "img/Profile.png";  // Ruta de la imagen por defecto
    }
    
 	// Obtener el lab_id de "test" desde la base de datos
    int labId = LaboratorioDAO.obtenerIdLaboratorioCineHack();
    String mensaje = "";

    // Recuperamos el mensaje desde la URL
    String resultadoFlag = request.getParameter("mensaje");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/img/timelabs/timelabs-logo-update.ico">
    <title>HACKEND</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/js/all.min.js" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/home.css">
	<link href="https://fonts.googleapis.com/css2?family=VT323&display=swap" rel="stylesheet">
	<style>
	* {
			font-family: 'VT323', monospace !important;
			font-size: 18px !important;
		}
		.logo-image {
		  width: 165px;
		  height: 70px;
		  position: relative;
		}
		.profile-image-update {
			width: 40px;
			height: 40px;
			border-radius: 30px;
		}
		.result-icon {
		  width: 25px; /* o el tamaÃ±o que quieras */
		  height: 25px;
		  object-fit: contain; /* evita que se deforme */
		  margin-right: 10px; /* opcional, para separaciÃ³n del texto */
		}
		.img-hackend {
		  object-fit: contain;
  		  vertical-align: middle;
		}
		.img-dockerpwned {
		  object-fit: contain;
  		  vertical-align: middle;
		}
		.img-ovalabs {
		  object-fit: contain;
  		  vertical-align: middle;
		}
		.img-ranking {
		  object-fit: contain;
  		  vertical-align: middle;
		}
		.img-document {
		  object-fit: contain;
  		  vertical-align: middle;
		}
		.img-timelabs {
		  object-fit: contain;
  		  vertical-align: middle;
		}
		.results {
			max-width: 800px;
			margin: auto;
			padding: 20px;
			transform: translateX(150px); /* Mueve el contenido 20px hacia la derecha */
		}
		.style-link-number {
			color: white !important;
			text-decoration: underline !important;
			font-weight: bold !important;
		}
		/* FLIP CLOCK - ESTILO HORIZONTAL */
		.flip-clock {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    gap: 8px; /* Reduje el espacio entre los elementos */
		    margin-top: 0px; /* Reduje el margen superior */
		}
		
		.flip-unit {
		    background-color: #2d2d2d;
		    color: #fff;
		    font-family: 'Courier New', Courier, monospace;
		    font-size: 1.5em; /* Reduje el tamaño de la fuente */
		    width: 40px; /* Reducí el ancho */
		    height: 60px; /* Reduje la altura */
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    border-radius: 8px;
		    border: 2px solid #444;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.6); /* Reducí el tamaño de la sombra */
		}

		/* Botón del diseñador */
		.designer-button {
		    background-color: #4f4f4f;
		    color: #f0f0f0;
		    font-family: 'Courier New', Courier, monospace;
		    padding: 5px 10px;
		    margin-top: 0px;
		    border: 1px solid #444;
		    border-radius: 5px;
		    font-size: 1em;
		    text-decoration: none;
		    display: inline-block;
		    font-weight: bold;
		    transition: background-color 0.3s ease, transform 0.2s ease;
		}
		
		.designer-button:hover {
		    background-color: #777;
		    transform: translateY(-2px);
		}
		
		.designer-button:active {
		    background-color: #333;
		    transform: translateY(0);
		}
		.drop-word {
		    color: gray;
		    transition: all 0.5s ease;
		}
		
		.drop-word.active {
		    color: red;
		    font-weight: bold;
		    animation: blink 1s infinite;
		}
		
		@keyframes blink {
		    0%, 100% { opacity: 1; }
		    50% { opacity: 0.3; }
		}
		.tiempo-agotado-banner {
		    position: absolute;
		    top: 70px;
		    left: 0;
		    right: 0; /* Aseguramos que ocupe todo el ancho del contenedor */
		    background: rgba(231, 76, 60, 0.8); /* Rojo semi-transparente */
		    color: white;
		    font-weight: bold;
		    padding: 10px 40px;
		    transform: rotate(10deg);
		    font-size: 16px;
		    z-index: 1000;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
		    text-align: center;
		    max-width: 60%;  /* Limita el ancho al 100% del contenedor */
		    width: 150%;  /* Hacemos que sea 1.5 veces el ancho del contenedor */
		    left: -8%; /* Lo movemos un poco hacia la izquierda para que se alargue */
		    clip-path: inset(0 0 0 0); /* Evita que sobresalga del contenedor */
		    border-radius: 20px;
		}
		  .tiempo-agotado-disabled {
		    pointer-events: none;
		    background-color: #999 !important;
		    color: white !important;
		    opacity: 0.6;
		    cursor: not-allowed;
		  }
		  /* Estilo del mensaje emergente */
		.message-popup {
		    position: fixed;
		    top: 50%;
		    left: 50%;
		    transform: translate(-50%, -50%);
		    background-color: rgba(0, 0, 0, 0.85); /* Un poco más oscuro para más énfasis */
		    padding: 25px 40px; /* Más espacio alrededor del mensaje */
		    border-radius: 10px; /* Bordes más redondeados */
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
		
		/* Estilo del botón para cerrar el popup */
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
		
		/* Cambio de color al pasar el ratón sobre el botón de cerrar */
		.message-popup .message-popup-close-btn:hover {
		    background: #ff3830;
		}
		
		/* Ocultar el popup por defecto */
		.message-popup {
		    display: none; /* Asegúrate de que esté oculto por defecto */
		}
		
		/* Mostrar el popup cuando tiene la clase .show */
		.message-popup.show {
		    display: block; /* Se muestra cuando tiene la clase .show */
		}
		/* Estilo para el modal */
		.custom-popup-modal {
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
		
		/* Estilo para el contenido del modal */
		.custom-popup-content {
		    background-color: #2d2d2d;
		    padding: 30px;
		    border-radius: 10px;
		    width: 90%;
		    max-width: 600px;
		    box-shadow: 0 0 10px #000;
		    position: relative;
		}
		
		/* Estilo para el botón de cierre */
		.custom-popup-close {
		    color: #aaa;
		    position: absolute;
		    top: 15px;
		    right: 20px;
		    font-size: 28px;
		    font-weight: bold;
		    cursor: pointer;
		}
		
		.custom-popup-close:hover {
		    color: #fff;
		}
		
		/* Estilo para el contenedor */
		.custom-popup-wrapper {
		    display: flex;
		    flex-direction: column;
		    align-items: center;
		}
		
		/* Estilo para el formulario */
		.custom-popup-form {
		    width: 100%;
		    display: flex;
		    flex-direction: column;
		    gap: 10px;
		    margin-bottom: 25px;
		}
		
		/* Estilo para las etiquetas del formulario */
		.custom-popup-form label {
		    color: #f0f0f0;
		    font-weight: bold;
		}
		
		/* Estilo para los inputs del formulario */
		.custom-popup-form input {
		    padding: 10px;
		    background: #222;
		    border: 1px solid #555;
		    border-radius: 5px;
		    color: #fff;
		}
		
		/* Estilo para el botón del formulario */
		.custom-popup-btn {
		    background-color: #4f4f4f;
		    color: #f0f0f0;
		    padding: 10px 20px;
		    border: 1px solid #444;
		    border-radius: 5px;
		    cursor: pointer;
		    font-family: 'Courier New', Courier, monospace;
		    transition: background-color 0.3s ease, transform 0.2s ease;
		}
		
		.custom-popup-btn:hover {
		    background-color: #777;
		    transform: translateY(-2px);
		}
		
		.custom-popup-btn:active {
		    background-color: #333;
		    transform: translateY(0);
		}
		.hidden {
		  display: none;
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
	.google-logo {
			font-size: 45px !important;
			font-weight: bold;
			color: white;
			letter-spacing: 2px;
		}
		.google-logo span {
			font-size: 45px !important;
			color: #8ab4f8;
		}
		.pagination .page-link {
			font-size: 25px !important;
		}
		.pagination .next {
			font-size: 25px !important;
		}
		.result-item a {
			font-size: 22px !important;
		}
		
		.result-item .url {
			font-size: 17px !important;
		}
		
		.result-item p {
			font-size: 17px !important;
		}
		.log-entry:hover {
		  transform: scale(1.02);
		  box-shadow: 0 0 12px rgba(0,255,204,0.2);
		}
	</style>
</head>
<body>
	<!-- <a href="?page=0&lang=es">🇪🇸 Español</a> | <a href="?page=0&lang=en">🇬🇧 English</a> -->
    <header class="header">
        <!--<div class="profile-icon"></div>-->
        <a href="<%= request.getContextPath() %>/profile.jsp">
	  <img src="<%= request.getContextPath() %>/<%= photoPath %>" alt="Foto de perfil" class="profile-image-update">
	   </a>
	   <!-- Validar que el usuario tenga el ROL "designer" -->
		<% if ("designer".equalsIgnoreCase(usuarioJWT.getRol())) { %>
		    <div style="text-align: center;">
		        <a href="<%= request.getContextPath() %>/designer/admin-panel.jsp" class="designer-button">Ir al Panel</a>
		    </div>
		
		    <style>
		        .designer-button {
		            background-color: #4f4f4f;
		            color: #f0f0f0;
		            font-family: 'Courier New', Courier, monospace;
		            padding: 5px 10px;
		            margin-top: 0px;
		            border: 1px solid #444;
		            border-radius: 5px;
		            font-size: 1em;
		            text-decoration: none;
		            display: inline-block;
		            font-weight: bold;
		            transition: background-color 0.3s ease, transform 0.2s ease;
		        }
		
		        .designer-button:hover {
		            background-color: #777;
		            transform: translateY(-2px);
		        }
		
		        .designer-button:active {
		            background-color: #333;
		            transform: translateY(0);
		        }
		    </style>
		<% } %>
		<!-- CONTADOR CUENTA ATRÁS -->
		<% if ("designer".equalsIgnoreCase(usuarioJWT.getRol())) { %>
		    <div>
		        <button id="startCountdown" class="designer-button">Iniciar Cuenta Atrás</button>
		        <button id="resetCountdown" class="designer-button" style="background-color: #d9534f;">Resetear</button>
		    </div>
		<% } %>
		
		<div id="countdown" class="flip-clock">
		    <div class="flip-unit">
		        <span id="hours" style="font-size: 40px !important">00</span>
		    </div>
		    <div class="flip-unit">
		        <span id="minutes" style="font-size: 40px !important">00</span>
		    </div>
		    <div class="flip-unit">
		        <span id="seconds" style="font-size: 40px !important">00</span>
		    </div>
		</div>
		<!-- LOGO DE LA PAGINA -->
	   <img src="<%= request.getContextPath() %>/img/timelabs/banner-update-timelabs.png" class="logo-image" alt="Imagen Logo">
       <!--<div class="logo">Google</div>-->
    </header>

    <div class="nav-container">
        <nav class="nav-menu">
            <a href="<%= request.getContextPath() %>/home_directory/home.jsp?page=0"><img src="<%= request.getContextPath() %>/img/logo-test-6-update.png" class="img-hackend" width="22px" height="22px"> Hackend</a>
            <a href="<%= request.getContextPath() %>/dockerpwned/home_directory_dockerpwned/home_dockerpwned.jsp?page=0"><img src="<%= request.getContextPath() %>/img/dockerpwned.png" class="img-dockerpwned" width="25px" height="15px"> DockerPwned</a>
            <a href="<%= request.getContextPath() %>/ovalabs/home_directory_ovalabs/home_ovalabs.jsp?page=0"><img src="<%= request.getContextPath() %>/img/ovalabs.png" class="img-ovalabs" width="20px" height="20px"> OVAlabs</a>
            <a href="<%= request.getContextPath() %>/timelabs/timelabs.jsp"><img src="<%= request.getContextPath() %>/img/timelabs/timelabs-logo-update.png" class="img-timelabs" width="20px" height="20px"> <span id="dropStatus" class="drop-word">TimeLabs</span></a>
            <a href="<%= request.getContextPath() %>/ranking.jsp"><img src="<%= request.getContextPath() %>/img/ranking-logo.png" class="img-ranking" width="20px" height="20px"> Ranking</a>
            <a href="#" id="more-button"></a>
        </nav>
    </div>
    <nav class="search-bar">
	    <input type="text" class="search-input" id="liveSearch" placeholder="Buscar en HackEnd">
	    <div class="search-icons">
	        <a href="#" id="clearSearch"><i class="fas fa-times"></i></a>
	        <a href="#"><i class="fas fa-microphone"></i></a>
	        <a href="#"><i class="fas fa-camera"></i></a>
	    </div>
	</nav>
	<!-- Popup para mostrar el mensaje -->
    <div id="popupMessage" class="message-popup">
        <div class="message-popup-header">Mensaje</div>
        <div class="message-popup-content" id="popupContent">
            <p><%= request.getAttribute("mensaje") %></p>
        </div>
        <button class="message-popup-close-btn"><a href="<%= request.getContextPath() %>/timelabs/timelabs.jsp" style="text-decoration: none; color: white;">Cerrar</a></button>
    </div>
    <br>
	<!-- POPUP MODAL -->
	<div id="custom-popup-modal" class="custom-popup-modal">
	    <div class="custom-popup-content">
	        <span class="custom-popup-close" id="custom-popup-closeBtn">&times;</span>
	
	        <!-- CONTENIDO -->
	        <div class="custom-popup-wrapper">
	
	            <!-- FORMULARIO PARA ENVIAR WRITEUP -->
	            <form class="custom-popup-form" action="<%= request.getContextPath() %>/WriteupControladorTimelabs" method="post">
	                <input type="hidden" name="lab_id" value="<%= labId %>">
	                <input type="hidden" name="user_id" value="<%= usuarioJWT.getUserId() %>">
	                <input type="hidden" name="username" value="<%= usuarioJWT.getUsuario() %>">
	                <label for="url_writeup">Enviar enlace del Writeup:</label>
	                <input type="url" name="url_writeup" id="url_writeup" required>
	                <button class="custom-popup-btn" type="submit">Enviar Writeup</button>
	            </form>
	
	            <!-- FORMULARIO PARA INGRESAR FLAG -->
	            <form class="custom-popup-form" action="<%= request.getContextPath() %>/validarFlagTimelabs" method="get">
	                <input type="hidden" name="user_id" value="<%= usuarioJWT.getUserId() %>">
	                <input type="hidden" name="lab_id" value="<%= labId %>">
	                <label for="flag">Ingrese la FLAG:</label>
	                <input type="text" id="flag" name="flag" required>
	                <button class="custom-popup-btn" type="submit">Enviar FLAG</button>
	            </form>
	
	        </div>
	    </div>
	</div>
    <div class="results">
    	
    </div> <!-- AquÃÂ­ se inyecta el contenido dinÃÂ¡mico -->
    <div class="botones">
	  <button id="custom-popup-openBtn" data-text="Enviar Writeup / FLAG" style="font-size: 20px !important;">ㅤㅤㅤㅤㅤ</button>
	  <button data-text="Ver Writeups"><a href="<%= request.getContextPath() %>/verWriteupsTimelabs?lab_id=<%= labId %>" style="text-decoration: none;">ㅤㅤㅤㅤㅤㅤ</a></button>
	</div>
	<!-- COMPROBACIONES CTF -->
  
  <div style="margin-left: 170px; padding-right: 50px; margin-top: -300px;">
    <p style="text-shadow: 1px 1px 2px gray;"><strong>MD5:</strong> NULL</p> <!-- OBTENER HASH MD5 UTILIZANDO UN COMANDO EN CMD EN WINDOWS (CertUtil -hashfile C:\<PATH>\machine.ova MD5) / EN LINUX (md5sum machine.iso) -->
    <p style="text-shadow: 1px 1px 2px gray;"><strong>Root:</strong> <span id="flagCount">Cargando...</span></p>
  </div>
  <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
  <div>
  	<h3 style="margin-left: 520px; padding-right: 50px;">======================================================LOGS FLAGS======================================================</h3>
  	<br>
  	<div id="logs-container">
  	</div>
  	<br>
  	<h3 style="margin-left: 520px; padding-right: 50px;">======================================================================================================================</h3>
  </div>
  
    <!--  <div class="search-result-container">
	  <div class="search-result">
	    <img src="../img/logo-test-17-update.png" alt="INACTIVE" width="30px" height="30px"/>
	    <h3>INACTIVE</h3>
	    <p>Espera hasta que el nuevo evento comience...</p>
	  </div>
	</div>
	<button id="labPopup-openBtn" data-text="Enviar Writeup / FLAG">ㅤㅤㅤㅤㅤ</button>-->
	<br><br>
    <!-- PAGINACIÃâN -->
    <div class="pagination">
        <div class="google-logo">T<span>i</span><span>i</span><span>i</span><span>i</span><span>i</span><span>i</span>melabs</div>
        <a href="timelabs.jsp" class="page-link style-link-number">1</a>
    </div>

    <!-- FOOTER -->
	<footer class="footer">
	  <div class="footer-top">
	    <p>Todos los derechos reservados <a href="#">d1se0 y m4nu</a></p>
	  </div>
	  <div class="footer-bottom">
	    <a href="#">Ayuda</a>
	    <a href="#">Enviar comentarios</a>
	    <a href="#">Privacidad</a>
	    <a href="#">Terminos</a>
	  </div>
	</footer>
    
	<!-- https://www.iemoji.com/view/emoji/932/travel-places/building-construction (Para sacar EMOTES en modo CODIGO) -->
	
	<!-- BOTONES Y ESTILO DE PAYPAL -->
	
	<script src="https://www.paypal.com/sdk/js?client-id=AZhxo4ppFH_hdjNyNZHOY4Mal9NUtrh_kuyapQYgZNiejRweC-PuLGFCDJ_luaINIRdpYoTlu_Nag6zD"></script>
	<!-- Botón flotante de PayPal -->
	<button id="open-paypal" style="position: fixed; bottom: 20px; left: 20px; background-color: #003087; border: none; border-radius: 50%; width: 60px; height: 60px; cursor: pointer; box-shadow: 0 0 10px rgba(0,0,0,0.3); z-index: 1000;">
	  <img src="https://www.paypalobjects.com/webstatic/icon/pp258.png" alt="PayPal" style="width: 30px; height: 30px;">
	</button>
	
	<!-- Overlay y Popup ocultos -->
	<div id="paypal-overlay" style="display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.7); z-index: 999;">
	  <div id="paypal-popup" style="
	      position: relative;
	      margin: 50px auto;
	      background: #2b2b2b;
	      padding: 40px;
	      border-radius: 16px;
	      box-shadow: 0 0 20px rgba(0,0,0,0.5);
	      width: 90%;
	      max-width: 800px;
	      color: white;
	      display: flex;
	      flex-direction: column;
	      max-height: 80vh; /* Limita altura para activar scroll */
	      overflow-y: auto; /* El scroll va aquí */
	      text-align: center;
	    ">
	    <button id="close-paypal" style="
	        position: absolute;
	        top: 15px;
	        right: 20px;
	        background: none;
	        border: none;
	        font-size: 24px;
	        color: white;
	        cursor: pointer;
	      ">✖</button>
	    <h2 style="margin-top: 0; font-size: 1.8rem;">💸 Donativo con PayPal</h2>
	    <p>¡Gracias por apoyar el proyecto!</p>
	    <!-- Campo para introducir la cantidad -->
	    <p>INTRODUCE LA CANTIDAD A DONAR (POR DEFECTO ES 1€)</p>
		<input id="donation-amount" type="number" min="1" placeholder="Introduce el monto" style="padding: 10px; margin-bottom: 20px; border-radius: 6px; border: 1px solid #ccc; background: #b8b8b8;">
	    <div id="paypal-button-container" style="margin-top: 30px;"></div>
	  </div>
	</div>

	<!-- VIDEO DE REFERENCIA (https://www.youtube.com/watch?v=nAz8xRQaPZQ) -->
	
	<script>
	  paypal.Buttons({
	    style: {
	    	shape: 'pill',
	    	label: 'pay',
	    },
	    createOrder: function(data, actions) {
	        // Obtenemos la cantidad introducida
	        const amount = document.getElementById("donation-amount").value || "1.00";

	        return actions.order.create({
	          purchase_units: [{
	            amount: {
	              value: amount
	            }
	          }]
	        });
	      },
	    onApprove: function(data, actions) {
	    	  return actions.order.capture().then(function (detalles){
	    	    // Guarda en localStorage los datos para usarlos luego en successful.jsp
	    	    const paymentInfo = {
	    	      id: detalles.id,
	    	      buyer: detalles.payer.name.given_name + ' ' + detalles.payer.name.surname,
	    	      email: detalles.payer.email_address,
	    	      amount: detalles.purchase_units[0].amount.value + ' ' + detalles.purchase_units[0].amount.currency_code,
	    	      date: new Date().toLocaleString()
	    	    };

	    	    localStorage.setItem('paypalDetails', JSON.stringify(paymentInfo));

	    	    // Redirige
	    	    window.location.href = "<%= request.getContextPath() %>/successful.jsp";
	    	  });
	    	},
	    onCancel: function(data) {
	    	alert("Pago cancelado");
	    	console.log(data);
	    }
	  }).render('#paypal-button-container');
	</script>
	
	<!-- SCRIPTS GENERALES -->
	
	<script>
	window.onload = function() {
	    const links = document.querySelectorAll("a[target='_blank']");
	    links.forEach(link => {
	      link.setAttribute("target", "_self");
	    });
	  };
	  
	// Ã¢Â¬â¡Ã¯Â¸Â Definimos estos dos globalmente para que estÃÂ©n disponibles en todo el script
	const resultsContainer = document.querySelector('.results');
	const searchResults = [
		{ url: "cinehack.jsp", title: "CineHack", description: "Ponte a prueba en tiempo limita a hackear esta maravillosa maquina...", image: "../img/logo-test-17-update.png", tags: ["timelabs", "hacking", "cinehack", "tiempo limite", "lab", "medio","d1se0"] },
		//{ url: "inactive.jsp", title: "INACTIVE", description: "Espera hasta que el nuevo evento comience...", image: "../img/logo-test-17-update.png", tags: ["timelabs", "hacking", "lab", "facil","d1se0"] },
	];

	document.addEventListener("DOMContentLoaded", function () {
	    console.log("DOM completamente cargado");
		
	 	// Forzar la cinta para test
	    //mostrarTiempoAgotado(); // 👈 añade esto arriba del resto
	    
	    if (!resultsContainer) {
	        console.error("No se encontrÃÂ³ el contenedor .results");
	        return;
	    } else {
	        console.log("Contenedor .results encontrado");
	    }

	    console.log("Total de resultados:", searchResults.length);

	    searchResults.forEach((result, index) => {
	        console.log(`Procesando resultado ${index + 1}: ${result.title}`);

	        const resultItem = document.createElement('div');
	        resultItem.classList.add('result-item');

	        const favicon = document.createElement('img');
	        favicon.src = result.image;
	        favicon.onerror = function () {
	            favicon.src = '../img/default-error.png';
	        };
	        favicon.alt = "favicon";
	        favicon.classList.add('result-icon');

	        const resultContent = document.createElement('div');
	        resultContent.classList.add('result-content');

	        const urlSpan = document.createElement('span');
	        urlSpan.classList.add('url');
	        urlSpan.textContent = result.url;

	        const titleLink = document.createElement('a');
	        titleLink.href = result.url;
	        titleLink.target = "_self";
	        titleLink.textContent = result.title;

	        const descriptionParagraph = document.createElement('p');
	        descriptionParagraph.textContent = result.description;

	        // Crear contenedor de tags debajo de la descripciÃÂ³n
	        const tagsContainer = document.createElement('div');
	        tagsContainer.classList.add('tags');
	        
	        result.tags.forEach(tag => {
	            const tagSpan = document.createElement('span');
	            tagSpan.classList.add('tag');
	            tagSpan.textContent = `#${tag}`;
	            tagsContainer.appendChild(tagSpan);
	        });

	        // AÃÂ±adir todos los elementos
	        resultContent.appendChild(urlSpan);
	        resultContent.appendChild(document.createElement('br'));
	        resultContent.appendChild(titleLink);
	        resultContent.appendChild(descriptionParagraph);
	        resultContent.appendChild(tagsContainer); // Los tags se colocan al final (debajo de la descripciÃÂ³n)

	        resultItem.appendChild(favicon);
	        resultItem.appendChild(resultContent);

	        resultsContainer.appendChild(resultItem);
	        
	        searchInput.value = "";
	        searchInput.dispatchEvent(new Event("input"));
	    });

	    console.log("Todos los resultados fueron agregados al DOM");
	});
	
	//PAYPAL BUTTON
		const paypalOpenBtn = document.getElementById("open-paypal");
		const overlay = document.getElementById("paypal-overlay");
		const paypalcloseBtn = document.getElementById("close-paypal");
		
		paypalOpenBtn.addEventListener("click", () => {
		  overlay.style.display = "block";
		});
		
		paypalcloseBtn.addEventListener("click", () => {
		  overlay.style.display = "none";
		});
	  
	  // LOGICA CONTADOR

	const DEFAULT_COUNTDOWN_SECONDS = 24 * 60 * 60 + 0 * 60 + 0; // 24h 0m 0s
		let countdownInterval = null;
		
		function pad(n) {
		    return n.toString().padStart(2, '0');
		}
		
		function updateDisplay(h, m, s) {
		    document.getElementById('hours').textContent = pad(h);
		    document.getElementById('minutes').textContent = pad(m);
		    document.getElementById('seconds').textContent = pad(s);
		}
		
		function startCountdown(targetTime) {
		    clearInterval(countdownInterval);
		    countdownInterval = setInterval(() => {
		        const now = new Date();
		        const diff = Math.floor((targetTime - now) / 1000);
		
		        if (diff <= 0) {
		            clearInterval(countdownInterval);
		            updateDisplay(0, 0, 0);
		            //mostrarTiempoAgotado(); // 🧠 nueva función
		            resetCountdownEnServidor();  // Llamar al servidor para poner target_time en null
		            return;
		        }
		
		        const h = Math.floor(diff / 3600);
		        const m = Math.floor((diff % 3600) / 60);
		        const s = diff % 60;
		        updateDisplay(h, m, s);
		    }, 1000);
		}
		
		async function fetchTargetTime() {
		    try {
		        const res = await fetch('<%= request.getContextPath() %>/countdown');
		        if (!res.ok) throw new Error("No countdown set");
		        const data = await res.json();
		        if (!data.targetTime || data.targetTime === 0) return null;
		        return new Date(data.targetTime);
		    } catch (err) {
		        console.warn("Error al obtener countdown:", err);
		        return null;
		    }
		}
		
		async function iniciarCountdownEnServidor() {
		    const res = await fetch('<%= request.getContextPath() %>/countdown', {
		        method: 'POST',
		        headers: { 'Content-Type': 'application/json' },
		        body: JSON.stringify({ durationSeconds: DEFAULT_COUNTDOWN_SECONDS })
		    });
		    const data = await res.json();
		    return new Date(data.targetTime);
		}
		
		async function resetCountdownEnServidor() {
		    const res = await fetch('<%= request.getContextPath() %>/countdown', {
		        method: 'DELETE'
		    });
		
		    if (res.ok) {
		        updateDisplay(0, 0, 0);
		        clearInterval(countdownInterval);
		
		        const startBtn = document.getElementById('startCountdown');
		        if (startBtn) {
		            startBtn.textContent = "Iniciar Cuenta Atrás";
		            startBtn.disabled = false;
		        }
		        
		        //ocultarTiempoAgotado(); // 👈 Opcional: limpia visualmente la cinta y botones
		    } else {
		        console.error("Error al resetear el contador");
		    }
		}
		
		document.addEventListener('DOMContentLoaded', async () => {
		    // Inicializar el contador con el valor actual si ya está configurado
		    const existingTarget = await fetchTargetTime();
		    if (existingTarget) {
		        startCountdown(existingTarget);
		    }
		
		    // Botón de iniciar la cuenta atrás
		    const startBtn = document.getElementById('startCountdown');
		    if (startBtn) {
		        startBtn.addEventListener('click', async () => {
		            const newTarget = await iniciarCountdownEnServidor();
		            startCountdown(newTarget);
		            startBtn.textContent = "Cuenta Atrás Iniciada";
		            startBtn.disabled = true;
		        });
		    }
		
		    // Botón de reiniciar la cuenta atrás
		    const resetBtn = document.getElementById('resetCountdown');
		    if (resetBtn) {
		        resetBtn.addEventListener('click', async () => {
		            const confirmReset = confirm("¿Estás seguro de resetear la cuenta atrás?");
		            if (confirmReset) {
		                await resetCountdownEnServidor();
		            }
		        });
		    }
		});
		
		// SABER SI EL TIEMPO ESTA A NULL O CON UN VALOR

		async function verificarEstadoCountdown() {
		    try {
		        const res = await fetch('<%= request.getContextPath() %>/countdown?status=true');
		        const data = await res.json();
		        const dropEl = document.getElementById('dropStatus');
		        const submitBtn = document.getElementById("custom-popup-openBtn");

		        if (dropEl) {
		            if (data.activo) {
		                dropEl.classList.add('active');
		                ocultarTiempoAgotado(submitBtn);
		            } else {
		                dropEl.classList.remove('active');
		                mostrarTiempoAgotado(submitBtn);
		            }
		        }
		    } catch (err) {
		        console.error("Error consultando estado del countdown", err);
		    }
		}

		document.addEventListener("DOMContentLoaded", () => {
		    verificarEstadoCountdown();
		    setInterval(verificarEstadoCountdown, 5000);
		});

		// MOSTRAR CINTA ROJA CUANDO SE AGOTA EL TIEMPO

		function mostrarTiempoAgotado(submitBtn) {
		    const container = document.querySelector(".results");
		    if (container && !document.querySelector('.tiempo-agotado-banner')) {
		        const banner = document.createElement("div");
		        banner.classList.add("tiempo-agotado-banner");
		        banner.textContent = "TIEMPO AGOTADO";
		        container.style.position = "relative";
		        container.appendChild(banner);
		    }

		    if (submitBtn) {
		        submitBtn.setAttribute("data-text", "TIEMPO AGOTADO");
		        submitBtn.textContent = "TIEMPO AGOTADO";
		        submitBtn.classList.add("tiempo-agotado-disabled");
		        submitBtn.setAttribute("disabled", "true");
		    }

		    const flagSection = document.querySelector('[data-text]');
		    if (flagSection) {
		        flagSection.classList.add("disabled");
		        flagSection.querySelectorAll("textarea, input, button").forEach(el => {
		            el.disabled = true;
		        });
		    }
		}

		// RESTAURAR LA FUNCIONALIDAD CUANDO EL TIEMPO ESTÁ ACTIVO

		function ocultarTiempoAgotado(submitBtn) {
		    const banner = document.querySelector('.tiempo-agotado-banner');
		    if (banner) banner.remove();

		    if (submitBtn) {
		        submitBtn.setAttribute("data-text", "Enviar Writeup / FLAG");
		        submitBtn.textContent = "Enviar Writeup / FLAG";
		        submitBtn.classList.remove("tiempo-agotado-disabled");
		        submitBtn.removeAttribute("disabled");
		    }

		    const flagSection = document.querySelector('[data-text]');
		    if (flagSection) {
		        flagSection.classList.remove("disabled");
		        flagSection.querySelectorAll("textarea, input, button").forEach(el => {
		            el.disabled = false;
		        });
		    }
		}

		// Lógica para abrir el popup solo si el tiempo está activo
		const openBtn = document.getElementById("custom-popup-openBtn");
		const popup = document.getElementById("custom-popup-modal");
		const closeBtn = document.getElementById("custom-popup-closeBtn");

		openBtn.addEventListener('click', function () {
		    if (!openBtn.classList.contains("tiempo-agotado-disabled")) {
		        popup.style.display = "flex";
		    }
		});

		closeBtn.addEventListener('click', function () {
		    popup.style.display = "none";
		});

		window.addEventListener('click', function (e) {
		    if (e.target === popup) {
		        popup.style.display = "none";
		    }
		});

		// Función para mostrar el popup
	    function showPopup(message) {
	        var popup = document.getElementById("popupMessage");
	        var content = document.getElementById("popupContent");
	        content.innerHTML = message; // Ponemos el mensaje en el popup
	        popup.classList.add('show'); // Hacemos visible el popup
	    }

	    // Función para cerrar el popup
	    function closePopup() {
	        var popup = document.getElementById("popupMessage");
	        popup.classList.remove('show'); // Ocultamos el popup
	        window.location.href = "<%= request.getContextPath() %>/timelabs/timelabs.jsp"; // Redirigimos
	    }

	    // Si el mensaje no es nulo, mostramos el popup con el mensaje
	    <%
	        if (resultadoFlag != null) { 
	    %>
	        showPopup("<%= resultadoFlag %>"); // Mostrar el mensaje en el popup
	    <% 
	        }
	    %>
	    
	 // ENVIAR PETICION PARA OBTENER TODAS LAS FLAGS DE ROOT
	    
	    document.addEventListener("DOMContentLoaded", function () {
	      const labId = <%= labId %>;  // Asegúrate de que labId esté correctamente inyectado aquí.

	      fetch(`<%= request.getContextPath() %>/getFlagRootTimelabsCount?lab_id=<%= labId %>`)
	          .then(response => {
	              if (!response.ok) {
	                  throw new Error("Error al obtener el número de flags.");
	              }
	              return response.text(); // La respuesta ahora es un texto (número).
	          })
	          .then(data => {
	              document.getElementById("flagCount").innerText = data; // Mostrar el número de flags

	          })
	          .catch(error => {
	              document.getElementById("flagCount").innerText = "Error"; // Mensaje de error en caso de fallo
	              console.error(error);
	          });
	  });
	 
	 // OBTENER LA INFORMACION DE LOS LOGS DE LOS WRITEUPS
	    
	    window.addEventListener('DOMContentLoaded', () => {
	        fetch('<%= request.getContextPath() %>/FlagLogTimelabsControlador?lab_id=<%= labId %>')
	            .then(response => response.text())
	            .then(html => {
	                document.getElementById('logs-container').innerHTML = html;
	            })
	            .catch(error => {
	                console.error("Error al cargar los logs:", error);
	            });
	    });
	</script>
	<script src="<%= request.getContextPath() %>/js/home.js"></script>
</body>
</html>