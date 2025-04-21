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
<title>HACKEND</title>
<link rel="icon" type="image/png" href="<%= request.getContextPath() %>/img/icono/icono_cinco_hackend.ico">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/animation.css">
<!-- Redirigir automáticamente después de 4 segundos -->
<meta http-equiv="refresh" content="4; url=home_directory/home.jsp?page=0">
<link href="https://fonts.googleapis.com/css2?family=VT323&display=swap" rel="stylesheet">
<style>
	* {
			font-family: 'VT323', monospace !important;
			font-size: 22px !important;
		}
</style>
</head>
<body>

	<!-- Video de fondo -->
	<!--<video class="background-video" autoplay loop muted>
		<source src="img/WINXPANIMATED.mp4" type="video/mp4">
		Tu navegador no soporta este tipo de archivo de video.
	</video>-->


	<div class="desktop-icon" id="icono-navegador">
		<img
			src="img/chrome.png"
			alt="Icono navegador">
		<div>Navegador</div>
	</div>

	<div class="cursor" id="cursor"></div>

	<div class="browser-window" id="navegador">
		<div class="browser-header">Mi Navegador</div>
		<div style="padding: 20px;">Cargando...</div>
	</div>
	 
	 <script src="<%= request.getContextPath() %>/js/animation.js"></script>
	 
</body>
</html>
