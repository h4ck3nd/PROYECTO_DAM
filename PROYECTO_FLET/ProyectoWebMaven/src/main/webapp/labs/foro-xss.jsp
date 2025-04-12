<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="utils.JWTUtils" %>
<%@ page import="utils.UsuarioJWT" %>

<%
    UsuarioJWT usuarioJWT = null;

    try {
        usuarioJWT = JWTUtils.obtenerUsuarioDesdeRequest(request);
    } catch (Exception e) {
        response.sendRedirect(request.getContextPath() + "/logout.jsp");
        return;
    }

 	// Puedes crear variables individuales si quieres
    String usuario = usuarioJWT.getUsuario();
    String nombre = usuarioJWT.getNombre();
    String apellidos = usuarioJWT.getApellidos();
    String email = usuarioJWT.getEmail();
    String token = usuarioJWT.getToken();
    String ultimoLogin = usuarioJWT.getUltimoLogin();
    String rol = usuarioJWT.getRol();
    String cookie = usuarioJWT.getCookie();
    String userId = usuarioJWT.getUserId();
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
	<link rel="stylesheet" href="../css/foro-xss.css">
	<style>
		.style-button-flag button {
		  margin-left: 100px; /* Para dar espacio entre los botones */
		}
		.logo {
			width: 60px;
			height: 60px;
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
			<button onclick="window.location.href='../home_directory/home.jsp?page=0'" class="win-btn close">✕</button>
		</div>
	</header>

	<div class="forum-container">
		<%-- Comentarios precargados de ejemplo (puedes reemplazar por bucles de Java si se conecta a base de datos) --%>
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
		<button class="flag-btn" type="submit" onclick="sendFlag()" class="style-button-flag">Enviar FLAG</button>
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

	<script src="../js/foro-xss.js"></script>
</body>
</html>