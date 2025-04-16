<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/img/icono/icono_cinco_hackend.ico">
    <title>PANEL DE LOGS</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/verLogs.css">
    <script>
        function loadLogs() {
            $.ajax({
                url: "<%= request.getContextPath() %>/getLogs",
                type: "GET",
                success: function(data) {
                    $('#logsTable').html(data);
                    window.scrollTo(0, document.body.scrollHeight);
                },
                error: function(error) {
                    console.error("Error al obtener logs: ", error);
                }
            });
        }

        $(document).ready(function() {
            loadLogs();
            setInterval(loadLogs, 5000); // Refresca cada 5 segundos
        });
    </script>
</head>
<body>
    <h2>Últimos Logs</h2>

    <form method="post" action="<%= request.getContextPath() %>/designer/admin-panel.jsp">
        <button type="submit" class="back-button">Volver</button>
    </form>

    <table id="logsTable">
        <!-- Los logs se cargarán aquí dinámicamente -->
    </table>
</body>
</html>
