<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="dao.LaboratorioDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.LaboratorioDAO" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Laboratorio</title>
    <style>
    	.btn.volver {
		  background-color: #e7431e;
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
		  width: fit-content; /* o puedes darle un ancho fijo si prefieres */
		}
		
		.btn.volver:hover {
		  background-color: #e7431e;
		}
    </style>
</head>
<body>
    <h1>Agregar Nuevo Laboratorio</h1>
    
    <!-- Mostrar mensaje de éxito o error -->
    <div>
        <%
            String mensaje = (String) request.getAttribute("mensaje");
            if (mensaje != null) {
        %>
            <p><%= mensaje %></p>
        <%
            }
        %>
    </div>

    <!-- Formulario para agregar laboratorio -->
    <form action="<%= request.getContextPath() %>/agregarLaboratorio" method="POST">
        <label for="nombre">Nombre del Laboratorio:</label>
        <input type="text" id="nombre" name="nombre" required><br><br>

        <label for="flag">Flag:</label>
        <input type="text" id="flag" name="flag" required><br><br>

        <label for="puntos">Puntos:</label>
        <input type="number" id="puntos" name="puntos" required><br><br>

        <button type="submit">Agregar Laboratorio</button>
    </form>
    <br>
    <a href="<%= request.getContextPath() %>/designer/admin-panel.jsp" class="btn volver" style="text-decoration: none; color: black;">Volver</a>
</body>
</html>
