<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="utils.JWTUtils" %>
<%@ page import="utils.UsuarioJWT" %>

<%
    UsuarioJWT usuarioJWT = null;

    try {
        usuarioJWT = JWTUtils.obtenerUsuarioDesdeRequest(request);
    } catch (Exception e) {
        response.sendRedirect(request.getContextPath() + "/logout");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Writeup Enviado</title>
    <link href="https://fonts.googleapis.com/css2?family=VT323&display=swap" rel="stylesheet"> <!-- Fuente estilo retro -->
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            font-family: 'VT323', monospace;
            background-color: #16161c;
            color: #f4f4f4;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .lab-confirm-container {
		    background-color: #1e1e26;
		    border: 2px solid #00ff99;
		    padding: 50px;
		    border-radius: 20px;
		    box-shadow: 0 0 40px rgba(0, 255, 153, 0.4); /* Cambiado a verde */
		    text-align: center;
		    max-width: 500px;
		}

        .lab-confirm-container h1 {
            color: #00ffcc;
            font-size: 2.5rem;
            margin-bottom: 30px;
            text-shadow: 0 0 5px #00ffcc;
        }

        .lab-btn-back {
		    display: inline-block;
		    padding: 12px 30px;
		    background-color: transparent;
		    color: #00ff99;
		    border: 2px solid #00ff99;
		    border-radius: 10px;
		    text-decoration: none;
		    font-size: 1.2rem;
		    transition: all 0.3s ease;
		}
		
		.lab-btn-back:hover {
		    background-color: #00ff99;
		    color: #1e1e26;
		    box-shadow: 0 0 10px #00ff99;
		}

        .lab-btn-back:active {
            transform: scale(0.95);
        }
    </style>
</head>
<body>

<div class="lab-confirm-container">
    <h1>✔ WRITEUP ENVIADO</h1>
    <a class="lab-btn-back" href="<%= request.getContextPath() %>/home_directory/home.jsp?page=0">← Volver al Home</a>
</div>

</body>
</html>
