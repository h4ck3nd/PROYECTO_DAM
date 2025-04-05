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

<%
    String token = request.getParameter("token");

    if (token == null || token.isEmpty()) {
        out.println("<p>Error: Token no proporcionado.</p>");
        return;
    }

    String SECRET_KEY = "clave_super_secreta";

    String nombre = "";
    String apellidos = "";
    String rol = "";
    String email = "";
    String ultimoLogin = "";
    String usuario = "";
    String cookie = "";

    try {
        Claims claims = Jwts.parser()
            .setSigningKey(SECRET_KEY.getBytes(StandardCharsets.UTF_8))
            .parseClaimsJws(token)
            .getBody();

        nombre = (String) claims.get("nombre");
        apellidos = (String) claims.get("apellidos");
        rol = (String) claims.get("rol");
        email = (String) claims.get("email");
        ultimoLogin = (String) claims.get("ultimo_login");
        usuario = (String) claims.get("usuario");
        cookie = (String) claims.get("cookie");

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
    <title>Perfil de <%= usuario %></title>
	<link rel="stylesheet" href="css/profile.css">
</head>
<body>

    <div class="window">
        <div class="title-bar">
            <span>Perfil de Usuario</span>
            <div class="title-bar-buttons">
                <div class="title-bar-button minimize"></div>
                <div class="title-bar-button maximize"></div>
                <div class="title-bar-button close" onclick="window.location.href='home_directory/home.jsp?token=<%= token %>&page=0'"></div>
            </div>
        </div>

        <div class="content">
            <img src="img/Profile.png" class="profile-img" alt="Perfil">
            <p class="username"><%= usuario %></p>
            <p class="info">Correo: <%= email %></p>
            <p class="info">Nombre: <%= nombre %></p>
            <p class="info">Apellido: <%= apellidos %></p>
            <p class="info">Rol: <%= rol %></p>
            <p class="info">Último Login: <%= ultimoLogin != null ? ultimoLogin : "Nunca ha iniciado sesión" %></p>

            <form action="editarPerfil.jsp" method="get">
                <input type="hidden" name="token" value="<%= token %>">
                <button class="edit-button" type="submit">Editar Perfil</button>
            </form>

            <button class="logout-button button" onclick="window.location.href='logout.jsp?token=<%= token %>'">Cerrar sesión</button>

            <p class="info">Cookie: <%= cookie %></p>
            <p class="info">Token: <%= token %></p>
        </div>
    </div>

</body>
</html>
