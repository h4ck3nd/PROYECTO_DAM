<%@ include file="dbConnection.jspf" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Logs</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        // Función que actualiza los logs cada 5 segundos
        function loadLogs() {
            $.ajax({
                url: "getLogs.jsp",  // Llamada a otro JSP que devolverá los logs
                type: "GET",
                success: function(data) {
                    $('#logsTable').html(data);  // Actualiza el contenido de la tabla con los logs
                },
                error: function(error) {
                    console.error("Error al obtener logs: ", error);
                }
            });
        }

        // Cargar logs cada 5 segundos (5000ms)
        setInterval(loadLogs, 5000);

        // Cargar los logs cuando la página se carga por primera vez
        $(document).ready(function() {
            loadLogs();
        });
    </script>
</head>
<body>
    <h2>Últimos Logs</h2>
    <table id="logsTable" border="1" style="width: 100%; background: #222; color: #fff;">
        <!-- Los logs se cargarán aquí -->
    </table>
</body>
</html>
