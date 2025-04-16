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
    <style>
        body {
            background-color: #1e1e1e;
            color: #d4d4d4;
            font-family: 'Courier New', Courier, monospace;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .lab-confirm-container {
            background-color: #2d2d2d;
            padding: 40px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 0 20px rgba(0, 255, 128, 0.2);
            border: 1px solid #444;
        }

        .lab-confirm-container h1 {
            color: #87ff87;
            font-size: 2rem;
            margin-bottom: 30px;
        }

        .lab-btn-back {
            display: inline-block;
            padding: 12px 24px;
            background-color: #4f4f4f;
            color: #f0f0f0;
            text-decoration: none;
            font-family: 'Courier New', Courier, monospace;
            border-radius: 6px;
            border: 1px solid #555;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .lab-btn-back:hover {
            background-color: #777;
            transform: translateY(-2px);
        }

        .lab-btn-back:active {
            background-color: #333;
            transform: translateY(0);
        }
    </style>
</head>
<body>

<div class="lab-confirm-container">
    <h1>✅ ¡WRITEUP ENVIADO CON ÉXITO!</h1>
    <a class="lab-btn-back" href="<%= request.getContextPath() %>/home_directory/home.jsp?page=0">← Volver al Home</a>
</div>

</body>
</html>
