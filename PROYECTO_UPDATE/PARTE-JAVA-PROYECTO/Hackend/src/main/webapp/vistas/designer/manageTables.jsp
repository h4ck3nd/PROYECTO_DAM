<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="utils.JWTUtils" %>
<%@ page import="utils.UsuarioJWT" %>
<%@ page import="dao.TablaDAO" %>
<%@ page import="java.util.*" %>

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

    String tablaSeleccionada = request.getParameter("tabla");
    TablaDAO dao = new TablaDAO();

    List<String> tablas = dao.getListaTablas();
    List<Map<String, String>> datosTabla = null;
    List<String> columnas = null;

    if (tablaSeleccionada != null && !tablaSeleccionada.isEmpty()) {
        columnas = dao.getColumnas(tablaSeleccionada);
        datosTabla = dao.getDatos(tablaSeleccionada);
    }
    
    // Determinar el nombre de la clave primaria según la tabla seleccionada
    String clavePrimaria = "id";  // Valor por defecto
    if ("laboratorios".equals(tablaSeleccionada)) {
        clavePrimaria = "lab_id";  // Clave primaria específica para la tabla "laboratorios"
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/vistas/img/icono/icono_cinco_hackend.ico">
    <title>GESTION DE TABLAS</title>
    <style>
        body {
            font-family: 'Courier New', Courier, monospace;
            background-color: #2d2d2d;
            color: #f0f0f0;
            padding: 20px;
        }

        h1 {
            text-align: center;
        }

        select, input[type=text], input[type=number] {
            padding: 5px;
            margin: 5px;
            border-radius: 5px;
            border: 1px solid #555;
            background-color: #444;
            color: #f0f0f0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #555;
        }

        th, td {
            padding: 8px;
        }

        tr:nth-child(even) {
            background-color: #3b3b3b;
        }

        .btn {
            background-color: #4f4f4f;
            color: #f0f0f0;
            padding: 6px 12px;
            margin: 5px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #777;
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

<h1>Gestión de Tablas</h1>

<form method="post" action="<%= request.getContextPath() %>/vistas/designer/admin-panel.jsp" class="btn-container">
	<button type="submit" class="btn-volver">Volver</button>
</form>

<!-- Selección de tabla -->
<form method="get">
    <label for="tabla">Selecciona una tabla:</label>
    <select name="tabla" id="tabla" onchange="this.form.submit()">
        <option value="">-- Selecciona --</option>
        <% for (String tabla : tablas) { %>
            <option value="<%= tabla %>" <%= tabla.equals(tablaSeleccionada) ? "selected" : "" %>><%= tabla %></option>
        <% } %>
    </select>
</form>

<% if (tablaSeleccionada != null && columnas != null) { %>

<!-- Mostrar datos actuales -->
<h3>Contenido actual de <%= tablaSeleccionada %></h3>
<table>
    <tr>
        <% for (String col : columnas) { %>
            <th><%= col %></th>
        <% } %>
        <th>Acciones</th>
    </tr>
    <% for (Map<String, String> fila : datosTabla) { %>
        <tr>
            <% for (String col : columnas) { %>
                <td><%= fila.get(col) %></td>
            <% } %>
            <td>
                <!-- Formulario para eliminar -->
                <form action="<%= request.getContextPath() %>/TablaController" method="post" style="display:inline;">
                    <% 
                        // Obtener el valor de la clave primaria según la tabla seleccionada
                        String valorClave = fila.get(clavePrimaria); 
                    %>
                    <input type="hidden" name="<%= clavePrimaria %>" value="<%= valorClave %>" /> <!-- Valor clave primaria -->
                    <% for (String col : columnas) { %>
                        <input type="hidden" name="<%= col %>" value="<%= fila.get(col) %>"/>
                    <% } %>
                    <input type="hidden" name="tabla" value="<%= tablaSeleccionada %>"/>
                    <input type="hidden" name="accion" value="delete"/>
                    <button class="btn" type="submit">Eliminar</button>
                </form>

                <!-- Formulario para actualizar -->
				<form action="<%= request.getContextPath() %>/TablaController" method="post" style="display:inline;">
				    <% 
				        // Prellenar el formulario con los valores actuales de la fila
				        for (String col : columnas) {
				            String valorColumna = fila.get(col);
				    %>
				        <label><%= col %>:</label>
				        <input type="text" name="<%= col %>" value="<%= valorColumna %>" /> <!-- Prellenar con los valores actuales -->
				    <% } %>
				    
				    <input type="hidden" name="<%= clavePrimaria %>" value="<%= fila.get(clavePrimaria) %>" /> <!-- Valor clave primaria -->
				    <input type="hidden" name="tabla" value="<%= tablaSeleccionada %>"/> <!-- Tabla seleccionada -->
				    <input type="hidden" name="accion" value="update"/> <!-- Acción update -->
				    
				    <button class="btn" type="submit">Actualizar</button>
				</form>
            </td>
        </tr>
    <% } %>
</table>

<!-- Formulario para insertar nuevo -->
<h3>Insertar nuevo registro</h3>
<form action="<%= request.getContextPath() %>/TablaController" method="post">
    <input type="hidden" name="tabla" value="<%= tablaSeleccionada %>"/>
    <input type="hidden" name="accion" value="insert"/>
    <% for (String col : columnas) { %>
        <label><%= col %>: </label>
        <input type="text" name="<%= col %>" />
    <% } %>
    <br>
    <button class="btn" type="submit">Insertar</button>
</form>

<% } %>

</body>
</html>
