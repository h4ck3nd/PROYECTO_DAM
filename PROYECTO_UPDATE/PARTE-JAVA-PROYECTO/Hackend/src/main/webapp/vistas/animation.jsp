<%
/**
 * Importaci�n de clases utilitarias necesarias para:
 * - Manejo de tokens JWT (JWTUtils)
 * - Representaci�n del usuario autenticado (UsuarioJWT)
 */
%>
<%@ page import="utils.JWTUtils" %>
<%@ page import="utils.UsuarioJWT" %>
<%
/**
 * Se declara una variable de tipo UsuarioJWT para almacenar la informaci�n
 * del usuario que ser� extra�da desde el token JWT presente en la solicitud.
 */
%>
<%
    UsuarioJWT usuarioJWT = null;

	/**
	 * Se intenta obtener el usuario desde el token JWT enviado en la petici�n.
	 * Si el token es v�lido, se asigna a la variable usuarioJWT.
	 */

	try {
	    usuarioJWT = JWTUtils.obtenerUsuarioDesdeRequest(request);
	} catch (Exception e) {
	    // Redirigir al servlet de logout en vez de al .jsp
	    response.sendRedirect(request.getContextPath() + "/logout");
	    return;
	}

	/**
	 * Si ocurre una excepci�n al obtener el token (por ejemplo, si est� vencido,
	 * es inv�lido o no existe), se redirige autom�ticamente al servlet de logout
	 * para cerrar sesi�n de forma segura.
	 */

%>
<%
/**
 * Estructura HTML principal de la p�gina. Se configura:
 * - Codificaci�n UTF-8
 * - T�tulo de la pesta�a del navegador
 * - �cono personalizado (favicon)
 * - Fuente de estilo retro (VT323)
 * - Redirecci�n autom�tica luego de 4 segundos al home.jsp
 */
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>HACKEND</title>
<link rel="icon" type="image/png" href="<%= request.getContextPath() %>/vistas/img/icono/icono_cinco_hackend.ico">
<link rel="stylesheet" href="<%= request.getContextPath() %>/vistas/css/animation.css">
<!-- Redirigir autom�ticamente despu�s de 4 segundos -->
<meta http-equiv="refresh" content="4; url=home_directory/home.jsp">
<link href="https://fonts.googleapis.com/css2?family=VT323&display=swap" rel="stylesheet">
<style>
	* {
			font-family: 'VT323', monospace !important;
			font-size: 22px !important;
		}
</style>
</head>
<body>

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
	 <!-- Inclusi�n del script de animaci�n para simular el entorno gr�fico -->
	 <script src="<%= request.getContextPath() %>/vistas/js/animation.js"></script>
	 
</body>
</html>