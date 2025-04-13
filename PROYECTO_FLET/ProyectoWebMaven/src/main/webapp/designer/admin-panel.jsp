<%@ page import="utils.JWTUtils" %>
<%@ page import="utils.UsuarioJWT" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
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
    <title>Panel de Administración</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin-panel.css">
</head>
<body>

    <h1>Panel de Administración - Usuario: <%= usuarioJWT.getUsuario() %></h1>

    <div class="panel">
        <h2>Revisar Logs del Sistema</h2>
        <div class="btn-container">
            <form method="post" action="<%= request.getContextPath() %>/designer/verLogs.jsp">
                <button type="submit">Ver Últimos Logs</button>
            </form>
        </div>
    </div>

    <div class="panel">
        <h2>Insertar Laboratorios en la DDBB de "laboratorios"</h2>
        <div class="btn-container">
            <form method="post" action="<%= request.getContextPath() %>/designer/agregarLaboratorio.jsp">
                <button type="submit">Insertar LABs</button>
            </form>
        </div>
    </div>

    <div class="panel">
        <h2>Visualizar DDBB Hackend (TABLAS)</h2>
        <div class="btn-container">
            <form method="post" action="<%= request.getContextPath() %>/designer/viewTables.jsp">
                <button type="submit">Ver Tablas</button>
            </form>
        </div>
    </div>

    <form method="post" action="<%= request.getContextPath() %>/home_directory/home.jsp?page=0" class="btn-container">
        <button type="submit" class="back-button">Volver</button>
    </form>

</body>
</html>
