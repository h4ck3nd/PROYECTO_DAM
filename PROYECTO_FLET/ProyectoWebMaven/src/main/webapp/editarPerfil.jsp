<%@ page import="io.jsonwebtoken.*" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.util.Date" %>

<%
    String token = request.getParameter("token");

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

        .profile-container {
            width: 400px;
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            margin: auto;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.3);
        }

        input {
            width: 90%;
            padding: 8px;
            margin: 10px 0;
            border-radius: 5px;
            border: none;
            font-size: 14px;
        }

        button {
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

        button:hover {
            background: #005a9e;
        }

        .cancel-button {
            background: #ff4757;
        }

        .cancel-button:hover {
            background: #e84118;
        }
    </style>
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
	        
	        <button type="submit">Guardar Cambios</button>
	    </form>
    </div>

</body>
</html>