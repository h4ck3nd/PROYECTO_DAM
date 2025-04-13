<%@ page import="utils.JWTUtils" %>
<%@ page import="utils.UsuarioJWT" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    UsuarioJWT usuarioJWT = null;

    try {
        // Intentamos obtener el usuario desde el JWT en las cookies
        usuarioJWT = JWTUtils.obtenerUsuarioDesdeRequest(request);
    } catch (Exception e) {
        // Si ocurre un error (token inválido o expirado), redirigimos al logout
        response.sendRedirect(request.getContextPath() + "/logout");
        return;
    }

    // Extraemos el rol del usuario
    String rol = usuarioJWT.getRol();

    // Verificamos si el rol es "designer"
    if (!"designer".equals(rol)) {
        out.println("<div class='error-message'>No autorizado.</div>");
        return;
    }

%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel de Administración</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap" rel="stylesheet">
    <style>
        /* Reset some default styling */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Roboto', sans-serif;
            background: #121212;
            color: #e0e0e0;
            padding: 40px;
            margin: 0;
        }

        h1 {
            color: #00bcd4;
            text-align: center;
            margin-bottom: 30px;
            font-weight: 500;
        }

        /* Error message styles */
        .error-message {
            color: #ff3d00;
            text-align: center;
            font-weight: 500;
            font-size: 18px;
            margin-top: 50px;
        }

        .panel {
            background-color: #1f1f1f;
            border: 1px solid #333;
            border-radius: 10px;
            padding: 30px;
            margin-bottom: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            max-width: 900px;
            margin-left: auto;
            margin-right: auto;
        }

        .panel h2 {
            color: #00bcd4;
            font-size: 22px;
            margin-bottom: 20px;
        }

        .panel form {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-direction: column;
        }

        /* Button Styles */
        button {
            background-color: #00bcd4;
            color: #fff;
            border: none;
            padding: 12px 24px;
            border-radius: 6px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            width: 100%;
            text-align: center;
        }

        button:hover {
            background-color: #008c9e;
            transform: translateY(-2px);
        }

        .btn-container {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 20px;
        }

        /* Styles for each button in the btn-container */
        .btn.insertar {
            background-color: #42beba;
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
            border-radius: 6px;
            font-weight: bold;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
            width: 100%;
            padding: 12px 24px;
        }

        .btn.insertar:hover {
            background-color: #276c6a;
        }

        .panel .form-group {
            margin-bottom: 20px;
        }

        /* Styling for form inputs */
        input, select, textarea {
            padding: 10px;
            margin: 8px 0;
            border-radius: 6px;
            border: 1px solid #444;
            background-color: #222;
            color: #fff;
            width: 100%;
        }

    </style>
</head>
<body>
    <h1>Panel de Administración - Usuario: <%= usuarioJWT.getUsuario() %></h1>

    <!-- Panel para ver registros -->
    <div class="panel">
        <h2>Revisar Logs del Sistema</h2>
        <div class="btn-container">
            <form method="post" action="<%= request.getContextPath() %>/designer/verLogs.jsp">
                <button type="submit">Ver Últimos Logs</button>
            </form>
        </div>
    </div>

    <!-- Panel para insertar registros -->
    <div class="panel">
        <h2>Insertar Laboratorios en la DDBB de "laboratorios"</h2>
        <div class="btn-container">
            <form method="post" action="<%= request.getContextPath() %>/designer/agregarLaboratorio.jsp">
                <button type="submit">Insertar LABs</button>
            </form>
        </div>
    </div>
    
    <!-- Panel Ver Tablas de DDBB hackend -->
    <div class="panel">
        <h2>Visualizar DDBB Hackend (TABLAS)</h2>
        <div class="btn-container">
            <form method="post" action="<%= request.getContextPath() %>/designer/viewTables.jsp">
                <button type="submit">Ver Tablas</button>
            </form>
        </div>
    </div>
    
    <form method="post" action="<%= request.getContextPath() %>/home_directory/home.jsp">
    	<button type="submit">Volver</button>
    </form>
</body>
</html>
