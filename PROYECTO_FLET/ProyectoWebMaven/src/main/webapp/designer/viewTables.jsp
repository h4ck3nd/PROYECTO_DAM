<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="utils.UsuarioJWT" %>
<%@ page import="utils.JWTUtils" %>

<%
    // Verificar que el usuario esté autorizado
    UsuarioJWT usuarioJWT = null;
    try {
        usuarioJWT = JWTUtils.obtenerUsuarioDesdeRequest(request);
    } catch (Exception e) {
        response.sendRedirect(request.getContextPath() + "/logout");
        return;
    }

    String rol = usuarioJWT.getRol();
    if (!"designer".equals(rol)) {
        out.println("<div class='error-message'>No autorizado.</div>");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Vista de Tablas de la Base de Datos</title>
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

        .table-container {
            margin: 20px 0;
            background-color: #333;
            border: 1px solid #444;
            padding: 10px;
        }

        .table-container h3 {
            color: #f0f0f0;
            font-size: 1.5em;
            margin-bottom: 10px;
        }

        .table-container table {
            width: 100%;
            border-collapse: collapse;
            font-size: 1em;
            color: #f0f0f0;
        }

        .table-container table th,
        .table-container table td {
            padding: 8px;
            border: 1px solid #444;
            text-align: left;
        }

        .table-container table th {
            background-color: #4f4f4f;
            font-weight: bold;
        }

        .table-container table tr:nth-child(even) {
            background-color: #3b3b3b;
        }

        .table-container table tr:nth-child(odd) {
            background-color: #333;
        }

        .table-container table tr:hover {
            background-color: #575757;
        }

        .error-message {
            text-align: center;
            color: #ff6f6f;
            font-size: 1.2em;
            margin-top: 20px;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function loadTables() {
            $.ajax({
                url: "<%= request.getContextPath() %>/getTables", // Llamada al Servlet para obtener las tablas
                type: "GET",
                success: function(data) {
                    $('#tablesContainer').html(data); // Actualizamos el contenedor con los datos recibidos
                    window.scrollTo(0, document.body.scrollHeight); // Hacer scroll a la parte más baja
                },
                error: function(error) {
                    console.error("Error al obtener tablas: ", error);
                }
            });
        }

        $(document).ready(function() {
            loadTables(); // Cargar las tablas al inicio
        });
    </script>
</head>
<body>

    <h1>Vista de Tablas de la Base de Datos</h1>

    <div id="tablesContainer">
        <!-- Las tablas serán cargadas aquí por AJAX -->
    </div>

</body>
</html>
