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
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="icon" type="image/png" href="<%= request.getContextPath() %>/vistas/img/icono/icono_cinco_hackend.ico">
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
	<link rel="stylesheet" href="<%= request.getContextPath() %>/vistas/css/foro-xss.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/vistas/css/cssForoXssLab.jsp">
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
			<button onclick="window.location.href='<%= request.getContextPath() %>/vistas/labs/foro-xss-lab.jsp'" class="win-btn close">✕</button>
		</div>
	</header>
	<div class="forum-container">
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
    </script>
	<script src="<%= request.getContextPath() %>/vistas/js/foro-xss.js"></script>
</body>
</html>