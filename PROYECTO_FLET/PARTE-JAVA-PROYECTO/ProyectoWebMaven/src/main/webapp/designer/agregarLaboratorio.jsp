<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="dao.LaboratorioDAO" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/img/icono/icono_cinco_hackend.ico">
    <title>AGREGAR LABORATORIO</title>
    <style>
        body {
            font-family: 'Courier New', Courier, monospace;
            background: #2d2d2d;
            color: #f0f0f0;
            padding: 20px;
            margin: 0;
        }

        h1 {
            text-align: center;
            color: #f0f0f0;
            font-size: 2em;
            margin-bottom: 30px;
        }

        form {
            background-color: #333;
            border: 1px solid #444;
            border-radius: 10px;
            padding: 25px;
            max-width: 600px;
            margin: 0 auto 30px auto;
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
            color: #f0f0f0;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 5px;
            border: 1px solid #555;
            background-color: #222;
            color: #fff;
        }

        button {
            background-color: #4f4f4f;
            color: #f0f0f0;
            font-family: 'Courier New', Courier, monospace;
            padding: 10px 20px;
            border: 1px solid #444;
            border-radius: 5px;
            font-size: 1em;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            margin-top: 20px;
        }

        button:hover {
            background-color: #777;
            transform: translateY(-2px);
        }

        button:active {
            background-color: #333;
            transform: translateY(0);
        }

        .mensaje {
            text-align: center;
            font-size: 1.1em;
            margin-bottom: 20px;
            color: #87ff87;
        }

        .btn-volver {
            display: block;
            background-color: #4f4f4f;
            color: #f0f0f0;
            text-decoration: none;
            text-align: center;
            font-family: 'Courier New', Courier, monospace;
            padding: 10px 20px;
            border: 1px solid #444;
            border-radius: 5px;
            width: fit-content;
            margin: 0 auto;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .btn-volver:hover {
            background-color: #777;
            transform: translateY(-2px);
        }

        .btn-volver:active {
            background-color: #333;
            transform: translateY(0);
        }
    </style>
</head>
<body>

    <h1>Agregar Nuevo Laboratorio</h1>

    <%
        String mensaje = (String) request.getAttribute("mensaje");
        if (mensaje != null) {
    %>
        <div class="mensaje"><%= mensaje %></div>
    <%
        }
    %>

    <form action="<%= request.getContextPath() %>/agregarLaboratorio" method="POST">
        <label for="nombre">Nombre del Laboratorio:</label>
        <input type="text" id="nombre" name="nombre" required>

        <label for="flag">Flag:</label>
        <input type="text" id="flag" name="flag" required>

        <label for="puntos">Puntos:</label>
        <input type="number" id="puntos" name="puntos" required>

        <button type="submit">Agregar Laboratorio</button>
    </form>

    <a href="<%= request.getContextPath() %>/designer/admin-panel.jsp" class="btn-volver">Volver</a>

</body>
</html>
