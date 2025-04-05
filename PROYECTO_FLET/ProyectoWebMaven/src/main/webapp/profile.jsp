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
    <style>
    	* {
          font-family: 'JetBrains Mono', monospace;
          /*font-family: 'console', monospace;*/
    	}
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('img/BackgroundProfile.jpg') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .window {
            background: #e3e3e3;
            width: 400px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.5);
            border: 1px solid #a1a1a1;
            position: relative;
            overflow: hidden;
        }

        .title-bar {
            background: linear-gradient(to bottom, #2a64c0, #1d4f91);
            color: white;
            padding: 8px 10px;
            font-weight: bold;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #15396b;
        }

        .title-bar-buttons {
            display: flex;
            gap: 5px;
        }

        .title-bar-button {
            width: 15px;
            height: 15px;
            background: #ccc;
            border-radius: 50%;
            cursor: pointer;
            box-shadow: inset 1px 1px 2px rgba(0, 0, 0, 0.3);
        }

        .title-bar-button.close { background: #e81123; }
        .title-bar-button.minimize { background: #f8d800; }
        .title-bar-button.maximize { background: #3ea74a; }

        .content {
            padding: 20px;
            text-align: center;
        }

        .profile-img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            border: 3px solid white;
            margin-bottom: 10px;
            box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
        }

        .username {
            font-size: 22px;
            font-weight: bold;
            margin-top: 5px;
            color: #0044cc;
        }

        .info {
            font-size: 14px;
            color: #333;
            margin: 5px 0;
        }

        .button {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            background: linear-gradient(to bottom, #0078d7, #005fa3);
            color: white;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.3);
        }

        .button:hover {
            background: linear-gradient(to bottom, #005fa3, #003d75);
        }

        .logout-button {
            background: linear-gradient(to bottom, #ff3b30, #c92b21);
        }

        .logout-button:hover {
            background: linear-gradient(to bottom, #c92b21, #a5211a);
        }

        .edit-button {
            margin-top: 15px;
            padding: 10px 20px;
            background: #0078D7;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }

        .edit-button:hover {
            background: #005a9e;
        }
    </style>
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
