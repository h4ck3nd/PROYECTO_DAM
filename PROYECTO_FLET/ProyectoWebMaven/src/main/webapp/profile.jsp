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
    <title>Perfil de <%= usuario %></title>
	<link rel="stylesheet" href="css/profileUpdate.css">
	<link rel="stylesheet" href="css/editarPerfilUpdate.css">
	<style>
	body, html {
	  height: 100%;
	  font-family: sans-serif;
	  background: linear-gradient(to bottom, #333, #222);
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  transition: all 0.3s ease;
	  cursor: none; /* Inicialmente, el cursor no ser� visible */
	}
</style>
</head>
<body>
	<div class="background">
    <div class="monitor">
      <div class="screen" id="pantalla">
        <form class="formulario" id="formulario">
          <div class="ventana-macos">
            <a href="home_directory/home.jsp?page=0" class="boton rojo"></a>
            <span class="boton amarillo"></span>
            <span class="boton verde"></span>
	          </div>
	          <br><br>
	          <div class="content">
			  <div class="profile-header">
			    <img src="img/Profile.png" class="profile-img" alt="Perfil">
			    <div class="user-info">
			      <h2 class="username"><%= usuario %></h2>
			      <p class="role">Rol: <%= rol %></p>
			    </div>
			  </div>
			
			  <div class="profile-details">
			    <p><strong>Correo:</strong> <%= email %></p>
			    <p><strong>Nombre:</strong> <%= nombre %></p>
			    <p><strong>Apellido:</strong> <%= apellidos %></p>
			    <p><strong>�ltimo Login:</strong> <%= ultimoLogin != null ? ultimoLogin : "Nunca ha iniciado sesi�n" %></p>
			    <p><strong>Cookie:</strong> <%= cookie %></p>
			    <p><strong>Token:</strong> <%= token %></p>
			  </div>
			
			  <div class="profile-actions">
			    <button class="btn editar"><a href="editarPerfil.jsp" style="text-decoration: none; color: white;">Editar Perfil</a></button>
			    <button onclick="window.location.href='logout.jsp'" class="btn cerrar">Cerrar sesi�n</button>
			  </div>
			</div>
        </form>
      </div>
      <div class="stand"></div>
      <div class="base"></div>
    </div>
  </div>
</body>
</html>
