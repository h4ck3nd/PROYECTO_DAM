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

    // Verificar si el usuario está autenticado mirando si existe el atributo 'username' en la sesión
    String username = (String) session.getAttribute("username");

    if (username == null) {
        // Si no existe el atributo 'username' en la sesión, redirigir al login
        response.sendRedirect(request.getContextPath() + "/labs/retroGame/retroGame-login.jsp");
        return;
    }

    // Si el usuario está autenticado, podemos continuar con la página
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PANEL DE ADMINISTRADOR</title>
</head>
<body>
    <h1>Bienvenido al Panel de Administrador, <%= username %>!</h1>
    <p>PANEL DE ADMINISTRADOR</p>
    <a href="<%= request.getContextPath() %>/labs/retroGame/logout.jsp">Cerrar sesión</a>
</body>
</html>
