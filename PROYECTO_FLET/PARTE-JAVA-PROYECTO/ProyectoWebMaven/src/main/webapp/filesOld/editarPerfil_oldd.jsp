<%@ page import="com.auth0.jwt.JWT" %>
<%@ page import="com.auth0.jwt.algorithms.Algorithm" %>
<%@ page import="com.auth0.jwt.interfaces.DecodedJWT" %>
<%@ page import="com.auth0.jwt.interfaces.JWTVerifier" %>
<%@ page import="com.auth0.jwt.exceptions.JWTVerificationException" %>
<%@ page import="io.jsonwebtoken.Claims" %>
<%@ page import="io.jsonwebtoken.Jwts" %>
<%@ page import="io.jsonwebtoken.ExpiredJwtException" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="javax.servlet.http.Cookie" %>

<%
    // Buscar el token en las cookies
    String token = null;
    Cookie[] cookies = request.getCookies();  // Obtener todas las cookies

    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("token".equals(cookie.getName())) {
                token = cookie.getValue();  // Si encontramos la cookie con el nombre "token", obtenemos su valor
                break;
            }
        }
    }

    // Verificar si el token est� presente
    if (token == null || token.isEmpty()) {
        // Si no hay token, redirigir al logout.jsp
        response.sendRedirect("http://localhost:8080/ProyectoWebMaven/logout.jsp");
        return;
    }

    String SECRET_KEY = "clave_super_secreta";  // La misma clave secreta que usaste para firmar el JWT

    String nombre = "";
    String apellidos = "";
    String rol = "";
    String email = "";
    String ultimoLogin = "";
    String usuario = "";
    String cookie = "";

    try {
        // Intentar decodificar el JWT utilizando io.jsonwebtoken (JJWT)
        Claims claims = Jwts.parser()
            .setSigningKey(SECRET_KEY.getBytes(StandardCharsets.UTF_8))  // Usamos la clave secreta
            .parseClaimsJws(token)  // Parseamos el token JWT
            .getBody();  // Extraemos el cuerpo del token (claims)

        // Obtener los valores del token (JWT)
        nombre = (String) claims.get("nombre");
        apellidos = (String) claims.get("apellidos");
        rol = (String) claims.get("rol");
        email = (String) claims.get("email");
        ultimoLogin = (String) claims.get("ultimo_login");
        usuario = (String) claims.get("usuario");
        cookie = (String) claims.get("cookie");

    } catch (ExpiredJwtException e) {
        // Si el token ha expirado, redirigir al logout.jsp
        response.sendRedirect("http://localhost:8080/ProyectoWebMaven/logout.jsp");
        return;
    } catch (JWTVerificationException e) {
        out.println("<p>Error: Token inv�lido (" + e.getMessage() + ")</p>");
        return;
    } catch (Exception e) {
        out.println("<p>Error al procesar el token: " + e.getMessage() + "</p>");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Perfil</title>
    <link rel="stylesheet" href="css/editarPerfil_old.css">
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
	         
		    <!-- Nuevo campo para la contrase�a actual -->
		    <label for="currentPassword">Contrase�a Actual: </label>
		    <input type="password" name="currentPassword"><br>
		
		    <!-- Nueva contrase�a y confirmaci�n de nueva contrase�a -->
		    <label for="newPassword">Nueva Contrase�a: </label>
		    <input type="password" name="newPassword"><br>
		
		    <label for="confirmNewPassword">Confirmar Nueva Contrase�a: </label>
		    <input type="password" name="confirmNewPassword"><br>
	         
	        <button type="submit">Guardar Cambios</button>
	    </form>
    </div>

</body>
</html>
