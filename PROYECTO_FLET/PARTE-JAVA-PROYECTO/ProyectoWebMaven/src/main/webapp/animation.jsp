<%
/**
 * Importación de clases utilitarias necesarias para:
 * - Manejo de tokens JWT (JWTUtils)
 * - Representación del usuario autenticado (UsuarioJWT)
 */
%>
<%@ page import="utils.JWTUtils" %>
<%@ page import="utils.UsuarioJWT" %>
<%
/**
 * Se declara una variable de tipo UsuarioJWT para almacenar la información
 * del usuario que será extraída desde el token JWT presente en la solicitud.
 */
%>
<%
    UsuarioJWT usuarioJWT = null;

	/**
	 * Se intenta obtener el usuario desde el token JWT enviado en la petición.
	 * Si el token es válido, se asigna a la variable usuarioJWT.
	 */

	try {
	    usuarioJWT = JWTUtils.obtenerUsuarioDesdeRequest(request);
	} catch (Exception e) {
	    // Redirigir al servlet de logout en vez de al .jsp
	    response.sendRedirect(request.getContextPath() + "/logout");
	    return;
	}

	/**
	 * Si ocurre una excepción al obtener el token (por ejemplo, si está vencido,
	 * es inválido o no existe), se redirige automáticamente al servlet de logout
	 * para cerrar sesión de forma segura.
	 */

%>
<%
/**
 * Estructura HTML principal de la página. Se configura:
 * - Codificación UTF-8
 * - Título de la pestaña del navegador
 * - Ícono personalizado (favicon)
 * - Fuente de estilo retro (VT323)
 * - Redirección automática luego de 4 segundos al home.jsp
 */
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
	<!--
        Sección de video de fondo opcional, actualmente comentado.
        Puede utilizarse para mostrar animación retro tipo Windows XP.
    	-->
	<!-- Video de fondo -->
	<!--<video class="background-video" autoplay loop muted>
		<source src="img/WINXPANIMATED.mp4" type="video/mp4">
		Tu navegador no soporta este tipo de archivo de video.
	</video>-->

	<!-- Icono tipo escritorio que simula acceso directo al navegador -->
	<div class="desktop-icon" id="icono-navegador">
		<img
			src="img/chrome.png"
			alt="Icono navegador">
		<div>Navegador</div>
	</div>
	<!-- Elemento personalizado que representa el cursor animado -->
	<div class="cursor" id="cursor"></div>
	<!-- Ventana de navegador ficticia con encabezado y contenido -->
	<div class="browser-window" id="navegador">
		<div class="browser-header">Mi Navegador</div>
		<div style="padding: 20px;">Cargando...</div>
	</div>
	 <!-- Inclusión del script de animación para simular el entorno gráfico -->
	 <script src="<%= request.getContextPath() %>/js/animation.js"></script>
	 
</body>
</html>
