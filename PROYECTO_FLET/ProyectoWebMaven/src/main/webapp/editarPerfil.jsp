<%@ page import="io.jsonwebtoken.*" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.util.Date" %>
<%@ page import="javax.servlet.http.Cookie" %>

<%
    String token = null;

    // Buscar el token en las cookies
    Cookie[] cookies = request.getCookies();  // Obtener todas las cookies

    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("token".equals(cookie.getName())) {
                token = cookie.getValue();  // Si encontramos la cookie con el nombre "token", obtenemos su valor
                break;
            }
        }
    }

    if (token == null || token.isEmpty()) {
        out.println("<p>Error: Token no proporcionado.</p>");
        return;
    }

    String SECRET_KEY = "clave_super_secreta";

    // Decodificar y verificar el token JWT
    String nombre = "";
    String apellidos = "";
    String email = "";
    String usuario = "";
    int userId = -1;

    try {
        Claims claims = Jwts.parser()
            .setSigningKey(SECRET_KEY.getBytes("UTF-8"))
            .parseClaimsJws(token)
            .getBody();

        userId = ((Number) claims.get("user_id")).intValue();  // CORRECCIÓN AQUÍ
        nombre = (String) claims.get("nombre");
        apellidos = (String) claims.get("apellidos");
        email = (String) claims.get("email");
        usuario = (String) claims.get("usuario");

    } catch (ExpiredJwtException e) {
        out.println("<p>Error: El token ha expirado.</p>");
        return;
    } catch (Exception e) {
        out.println("<p>Error: Token inválido (" + e.getMessage() + ")</p>");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Perfil</title>
    <link rel="stylesheet" href="css/editarPerfil.css">
</head>
<body>
	
	<div class="profile-container">
	    <h2>Editar Perfil</h2>
	    <form action="procesarEdicion.jsp" method="post">
	        <input type="hidden" name="token" value="<%= token %>">
	         
	        <label for="nombre">Nombre: </label>
	        <input type="text" name="nombre" value="<%= nombre %>"><br>
	        
	        <label for="apellidos">Apellidos: </label>
	        <input type="text" name="apellidos" value="<%= apellidos %>"><br>
	        
	        <label for="email">Email: </label>
	        <input type="email" name="email" value="<%= email %>"><br>
	        
	        <label for="usuario">Usuario: </label>
	        <input type="text" name="usuario" value="<%= usuario %>"><br>
	         
		    <!-- Nuevo campo para la contraseña actual -->
		    <label for="currentPassword">Contraseña Actual: </label>
		    <input type="password" name="currentPassword"><br>
		
		    <!-- Nueva contraseña y confirmación de nueva contraseña -->
		    <label for="newPassword">Nueva Contraseña: </label>
		    <input type="password" name="newPassword"><br>
		
		    <label for="confirmNewPassword">Confirmar Nueva Contraseña: </label>
		    <input type="password" name="confirmNewPassword"><br>
	         
	        <button type="submit">Guardar Cambios</button>
	    </form>
    </div>

</body>
</html>
