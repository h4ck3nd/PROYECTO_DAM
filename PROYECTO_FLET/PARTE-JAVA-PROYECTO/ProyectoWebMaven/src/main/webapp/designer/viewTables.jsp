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
    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/img/icono/icono_cinco_hackend.ico">
    <title>VISTA DE TABLAS DDBB</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/viewTables.css">
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
	<form method="post" action="<%= request.getContextPath() %>/designer/admin-panel.jsp" class="centered-form">
	    <button type="submit" class="back-button">Volver</button>
	</form>
    <div id="tablesContainer">
        <!-- Las tablas serán cargadas aquí por AJAX -->
    </div>

</body>
</html>
