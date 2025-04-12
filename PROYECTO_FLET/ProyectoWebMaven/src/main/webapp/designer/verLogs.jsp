<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel de Logs</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        body {
            background-color: #121212;
            color: #fff;
            font-family: monospace;
            padding: 20px;
        }

        h2 {
            margin-bottom: 20px;
        }

        #logsTable {
            width: 100%;
            border-collapse: collapse;
            background-color: #1e1e1e;
        }

        #logsTable tr:nth-child(even) {
            background-color: #2a2a2a;
        }

        #logsTable td {
            padding: 8px 12px;
            border: 1px solid #444;
            white-space: pre-wrap;
            word-break: break-word;
        }
    </style>

    <script>
        function loadLogs() {
            $.ajax({
                url: "<%= request.getContextPath() %>/getLogs", // 🔥 Cambiado al Servlet
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
    <table id="logsTable">
        <!-- Los logs se cargarán aquí dinámicamente -->
    </table>
</body>
</html>
