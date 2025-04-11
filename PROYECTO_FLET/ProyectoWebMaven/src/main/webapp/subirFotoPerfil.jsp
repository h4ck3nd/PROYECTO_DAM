<%@ page import="com.auth0.jwt.JWT" %>
<%@ page import="com.auth0.jwt.algorithms.Algorithm" %>
<%@ page import="com.auth0.jwt.interfaces.DecodedJWT" %>
<%@ page import="com.auth0.jwt.interfaces.JWTVerifier" %>
<%@ page import="com.auth0.jwt.exceptions.JWTVerificationException" %>
<%@ page import="io.jsonwebtoken.Claims" %>
<%@ page import="io.jsonwebtoken.Jwts" %>
<%@ page import="io.jsonwebtoken.ExpiredJwtException" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    // Verificar si el usuario tiene un token válido, si no redirigir al login
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

    if (token == null || token.isEmpty()) {
        // Si no hay token, redirigir al logout.jsp
        response.sendRedirect("logout.jsp");
        return;
    }

    // Obtener el user_id desde el token
    String SECRET_KEY = "clave_super_secreta";  // La misma clave secreta que usaste para firmar el JWT
    String userId = "";

    try {
        Claims claims = Jwts.parser()
            .setSigningKey(SECRET_KEY.getBytes(StandardCharsets.UTF_8))  // Usamos la clave secreta
            .parseClaimsJws(token)  // Parseamos el token JWT
            .getBody();

        Object userIdObject = claims.get("user_id");
        if (userIdObject != null) {
            userId = userIdObject instanceof Integer ? String.valueOf(userIdObject) : (String) userIdObject;
        }

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
    <title>Subir Foto de Perfil</title>
    <link rel="stylesheet" href="css/editarPerfilUpdate.css">
    <style>
        body, html {
            font-family: sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-container {
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h2 {
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        input[type="file"] {
            padding: 10px;
            font-size: 14px;
        }

        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }

        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<form action="SubirFotoPerfil?user_id=<%= userId %>" method="post" enctype="multipart/form-data">
  <input type="file" name="profilePhoto" required>
  <button type="submit">Subir Foto</button>
</form>




</body>
</html>
