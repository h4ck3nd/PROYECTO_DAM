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

    // Obtener el lab_id de "foro-xss" desde la base de datos
    int labId = LaboratorioDAO.obtenerIdLaboratorioForoXss();
    String mensaje = "";

    // Recuperamos el mensaje desde la URL
    String resultadoFlag = request.getParameter("mensaje");
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="icon" type="image/png" href="<%= request.getContextPath() %>/img/icono/icono_cinco_hackend.ico">
<title>FORO HACKER - LABORATORIO XSS</title>
<script>
        <%
            // Inyectar código JavaScript desde el backend de forma oculta
            String jsHook = "const originalAlert = window.alert;" +
                            "window.alert = function(msg) {" +
                            "  originalAlert(msg);" +
                            "  originalAlert('¡Lab completado! Flag: FLAG{lo_lograste}');" +
                            "};";
        %>
        <%= jsHook %>
    </script>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/foro-xss.css">
	<style>
		.style-button-flag button {
		  margin-left: 100px; /* Para dar espacio entre los botones */
		}
		.logo {
			width: 60px;
			height: 60px;
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
		/* Estilo del formulario */
.flag-form {
    display: flex;
    align-items: center; /* Alinea los elementos verticalmente */
    gap: 10px; /* Espacio entre los elementos */
    flex-wrap: nowrap; /* Asegura que no se rompan en varias líneas */
}

/* Estilo de la etiqueta */
.flag-label {
    font-size: 14px;
    color: #333;
    margin-right: 5px; /* Espacio entre la etiqueta y el campo de entrada */
}

/* Estilo del campo de entrada */
.flag-input {
    padding: 8px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 4px;
    width: 200px; /* Controla el tamaño del campo de entrada */
}

/* Estilo del botón */
.flag-btn {
    padding: 8px 12px;
    background-color: #4CAF50;
    color: white;
    font-size: 14px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.flag-btn:hover {
    background-color: #45a049;
}
/* Popup estilo minimalista */
.popup-minimalista {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background-color: #ffffff;
  border-radius: 10px;
  padding: 25px 20px;
  width: 400px;
  max-width: 90%;
  z-index: 1000;
  font-family: 'Segoe UI', sans-serif;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
  animation: popupFade 0.3s ease-in-out;
  overflow: hidden; /* Evitar el desbordamiento fuera del popup */
}

.popup-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-bottom: 1px solid #e0e0e0;
  padding-bottom: 10px;
  margin-bottom: 15px;
}

.popup-header h2 {
  color: #333;
  font-size: 1.2rem;
  margin: 0;
}

.btn-close {
  background: none;
  border: none;
  color: #888;
  font-size: 1.2rem;
  cursor: pointer;
}

/* Área de contenido del popup con scroll */
.popup-content {
  color: #444;
  font-size: 0.95rem;
  line-height: 1.5;
  margin-bottom: 20px;
  max-height: 300px; /* Define el tamaño máximo del contenido */
  overflow-y: auto; /* Agrega scroll vertical si el contenido excede el tamaño */
  padding-right: 10px; /* Da espacio para el scrollbar */
}

.code-example {
  font-family: 'Courier New', monospace;
  background-color: #ababab;
  padding: 3px 6px;
  border-radius: 4px;
  color: #000;
}

.code-comment {
  color: #555;
  font-style: italic;
  margin-left: 5px;
}

.btn-close-popup {
  background-color: #1976d2;
  color: white;
  border: none;
  padding: 10px 16px;
  border-radius: 4px;
  font-weight: 500;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.btn-close-popup:hover {
  background-color: #1565c0;
}

/* Botón de solución */
.solution-btn {
  position: fixed;
  bottom: 10px;
  left: 10px;
  background-color: #1976d2;
  color: #fff;
  border: none;
  font-size: 1.5rem;
  border-radius: 50%;
  width: 50px;
  height: 50px;
  cursor: pointer;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
  transition: transform 0.2s ease;
  z-index: 1000;
}

.solution-btn:hover {
  transform: scale(1.1);
}

.hidden {
  display: none;
}

@keyframes popupFade {
  from {
    opacity: 0;
    transform: translate(-50%, -50%) scale(0.95);
  }
  to {
    opacity: 1;
    transform: translate(-50%, -50%) scale(1);
  }
}
	</style>
</head>
<body>
	<header class="window-header">
		<div class="title-bar">
			<img src="../img/logo-foro-xss.png" alt="Logo" class="logo"/>
			<h1 id="page-title">FORO CROSS</h1>
		</div>
		<div class="window-controls">
			<button class="win-btn minimize">—</button>
			<button class="win-btn maximize">□</button>
			<button onclick="window.location.href='<%= request.getContextPath() %>/home_directory/home.jsp?page=0'" class="win-btn close">✕</button>
		</div>
	</header>
	<!-- Popup para mostrar el mensaje -->
    <div id="popupMessage" class="message-popup">
        <div class="message-popup-header">Mensaje</div>
        <div class="message-popup-content" id="popupContent">
            <p><%= request.getAttribute("mensaje") %></p>
        </div>
        <button class="message-popup-close-btn"><a href="foro-xss.jsp" style="text-decoration: none; color: white;">Cerrar</a></button>
    </div>
	<div class="forum-container">
		<%-- Comentarios precargados de ejemplo (puedes reemplazar por bucles de Java si se conecta a base de datos) --%>
		<!-- Formulario para ingresar la FLAG -->
        <form action="<%= request.getContextPath() %>/validarFlag" method="get" class="flag-form">
            <input type="hidden" name="user_id" value="<%= usuarioJWT.getUserId() %>">
            <input type="hidden" name="lab_id" value="<%= labId %>">
            <label for="flag">Ingrese la FLAG:</label>
            <input type="text" id="flag" name="flag" required>
            <button class="flag-btn" type="submit" class="style-button-flag">Enviar FLAG</button>
        </form>
        <br><br>
		<section class="comment-box">
			<div class="user-info">
				<img src="https://i.imgur.com/1X4R6Yt.png" alt="Avatar"
					class="avatar" /> <span class="username">DevMaster</span> • <span
					class="time">hace 10 minutos</span>
			</div>
			<p class="comment-text">¿Alguien tiene un ejemplo de XSS en una
				página en vivo?</p>
			<div class="comment-actions">
				<button type="button">
					👍 <span class="like-count">3</span>
				</button>
				<button>Responder</button>
			</div>
		</section>
		<section class="comment-box">
			<div class="user-info">
				<img src="https://i.imgur.com/1X4R6Yt.png" alt="Avatar"
					class="avatar" /> <span class="username">Admin</span> • <span
					class="time">hace 5 minutos</span>
			</div>
			<p class="comment-text">¡Recuerden que deben tener cuidado al
				ejecutar códigos de fuentes desconocidas!</p>
			<div class="comment-actions">
				<button type="button">
					👍 <span class="like-count">5</span>
				</button>
				<button>Responder</button>
			</div>
		</section>
		<section class="comment-box">
			<div class="user-info">
				<img src="https://i.imgur.com/1X4R6Yt.png" alt="Avatar"
					class="avatar" /> <span class="username">Hacker123</span> • <span
					class="time">hace 2 minutos</span>
			</div>
			<p class="comment-text">Me parece que esto se podría explotar de
				una forma más eficiente... 🤔</p>
			<div class="comment-actions">
				<button type="button">
					👍 <span class="like-count">2</span>
				</button>
				<button>Responder</button>
			</div>
		</section>
		<section class="comment-box">
			<div class="user-info">
				<img src="https://i.imgur.com/1X4R6Yt.png" alt="Avatar"
					class="avatar" /> <span class="username">Tú</span> • <span
					class="time">hace 1 minuto</span>
			</div>
			<p class="comment-text">¡Qué interesante tema! 👀</p>
			<div class="comment-actions">
				<button type="button">
					👍 <span class="like-count">0</span>
				</button>
				<button>Responder</button>
			</div>

			<div id="comments-list"></div>


		</section>
	</div>

	<!-- Barra de comentarios -->
	<form id="comment-form" class="comment-form">
		<input type="text" id="new-comment"
			placeholder="Escribe tu comentario..." />
		<button type="submit">Comentar</button>
	</form>

	<!-- Botón para mostrar la solución -->
	<button class="solution-btn" type="button" onclick="showPopupSolution()">💡</button>
	
	<!-- Popup de solución -->
	<div id="popup-solution" class="popup-minimalista hidden">
	  <div class="popup-header">
	    <h2>💡 Solución</h2>
	    <button class="btn-close" onclick="closePopupSolution()">✖</button>
	  </div>
	  <div class="popup-content">
	    <p>Estamos trabajando con una página web que presenta una vulnerabilidad de tipo <b>XSS (Cross-Site Scripting)</b>. Esta vulnerabilidad permite inyectar código HTML, CSS, JavaScript, y más, dentro de una página web.</p>
	    <p>El problema ocurre porque el servidor no valida adecuadamente las entradas del usuario, lo que permite que el código enviado por el usuario sea ejecutado e interpretado como parte del HTML de la página.</p>
	    
	    <p><b>EJEMPLOS:</b></p>
	
	    <p>
	      <span class="code-example">&lt;h1&gt;XSS&lt;/h1&gt;</span>
	      <span class="code-comment"># Esto genera un título grande que dice "XSS", interpretando el código HTML.</span>
	    </p>
	    
	    <p>
	      <span class="code-example">&lt;img src=x onerror="alert('XSS')"&gt;</span>
	      <span class="code-comment"># Con esta línea, generamos una alerta de JavaScript cuando la imagen falla en cargarse.</span>
	    </p>
	    
	    <p>Al ejecutar estos ejemplos, habremos completado el laboratorio y obtenido la <b>FLAG</b>.</p>
	  </div>
	  <button class="btn-close-popup" onclick="closePopupSolution()">Cerrar</button>
	</div>

	<script>
		//Mostrar el popup de solución
	   function showPopupSolution() {
	     document.getElementById("popup-solution").classList.remove("hidden");
	   }
	
	   // Cerrar el popup de solución
	   function closePopupSolution() {
	     document.getElementById("popup-solution").classList.add("hidden");
	   }
	
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
            window.location.href = "<%= request.getContextPath() %>/labs/foro-xss.jsp"; // Redirigimos
        }

        // Si el mensaje no es nulo, mostramos el popup con el mensaje
        <%
            if (resultadoFlag != null) { 
        %>
            showPopup("<%= resultadoFlag %>"); // Mostrar el mensaje en el popup
        <% 
            }
        %>
    </script>
	<script src="<%= request.getContextPath() %>/js/foro-xss.js"></script>
</body>
</html>