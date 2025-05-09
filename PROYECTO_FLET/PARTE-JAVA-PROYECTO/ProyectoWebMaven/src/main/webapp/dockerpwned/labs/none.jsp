<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="utils.JWTUtils" %>
<%@ page import="utils.UsuarioJWT" %>

<%
/**
 * Importación de clases necesarias para:
 * - Decodificación y validación de JWT (JWTUtils)
 * - Representación del usuario autenticado (UsuarioJWT)
 */
%>
<%

   /**
   * Se intenta obtener la información del usuario a partir del token JWT presente en la solicitud.
   * Si falla, se redirige al servlet de logout para cerrar la sesión y evitar acceso no autorizado.
   */

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
    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/img/img_dockerpwned/logo-dockerpwned.ico">
    <title>CONSTRUCCION...</title>
    <link href="https://fonts.googleapis.com/css2?family=VT323&display=swap" rel="stylesheet">
    <style>
    * {
			font-family: 'VT323', monospace !important;
			font-size: 22px;
		}
        body {
            margin: 0;
            padding: 0;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            text-align: center;
            color: #333;
        }

        .container {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            max-width: 500px;
        }

        .emoji {
            font-size: 64px;
            margin-bottom: 20px;
        }

        h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
        }

        p {
            font-size: 1.1rem;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="emoji">🚧</div>
        <h1>¡Estamos trabajando en ello!</h1>
        <p>Esta sección aún está en construcción.<br>
           Vuelve pronto para ver las novedades.</p>
        <a href="<%= request.getContextPath() %>/dockerpwned/home_directory_dockerpwned/home_dockerpwned.jsp?page=0">Volver</a>
    </div>
</body>
</html>
