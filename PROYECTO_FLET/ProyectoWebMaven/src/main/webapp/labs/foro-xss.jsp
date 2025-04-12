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
<title>Foro Hacker - Laboratorio XSS</title>
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
		<button class="solution-btn" type="button" onclick="showPopup()">💡</button>
	</form>

	<!-- Popup de solución -->
	<div id="popup-solution" class="popup hidden">
		<div class="popup-header">
			<h2>💡 Solución</h2>
			<button class="close-btn" onclick="closePopup()">✖</button>
		</div>
		<div class="popup-content">
			<p>Vemos una pagina normal y corriente, pero tiene una vulnerabilidad llamada XSS la cual permite inyectar codigo HTML, CSS, JS... de forma</p>
			<p>que el servidor no sanitiza bien la entrada y se lo traga lo que el usuario envie incrustandolo en el propio codigo e implementandose</p>
			<p>EJEMPLO:</p>
			<p><a class="code-xss">&lt;h1&gt;XSS&lt;/h1&gt;</a> <a class="comment-code">#Con esto veremos que se muestra la palabra "XSS" de forma grande interpretenado codigo HTML</a></p>
			<p><a class="code-xss">&lt;img src=x onerror="alert('XSS')"&gt;</a> <a class="comment-code">#Con esto lo que hacemos es generar una alerta en JavaScript</a></p>
			<p>Echo esto habremos completado el Laboratorio de forma exitosa y habremos obtenido la <b>FLAG</b></p>
		</div>
		<button class="btn-solution" onclick="closePopup()">Cerrar</button>
	</div>
	<script>
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