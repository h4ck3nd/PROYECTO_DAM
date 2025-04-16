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

	// Verificar si el parámetro 'url' está presente en la URL
    String url = request.getParameter("url");

    // Si el parámetro 'url' no está presente, mostrar un 403 Forbidden
    if (url == null || url.isEmpty()) {
        response.sendError(403, "Acceso no autorizado");
        return;
    }

    // Si 'url' está presente, permitir el acceso
    // Aquí podrías realizar una validación adicional si deseas, como verificar la URL que se pasa.
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/img/icono/icono_cinco_hackend.ico">
    <title>FLAG Secreta</title>
    <style>
        body {
            background-color: #1a1a2e;
            color: #f5f5f5;
            font-family: 'Courier New', monospace;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .flag-box {
            border: 2px dashed #00ffcc;
            padding: 30px;
            background: #16213e;
            border-radius: 10px;
            text-align: center;
        }
        .flag-box h1 {
            color: #00ffcc;
        }
    </style>
</head>
<body>
    <div class="flag-box">
        <h1>🎉 FLAG: FLAG{separo_flag}</h1>
        <p>Has accedido correctamente desde el flujo vulnerable.</p>
    </div>
</body>
</html>
