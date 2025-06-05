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
    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/vistas/img/icono/icono_cinco_hackend.ico">
    <title>PANEL ADMINISTRADOR</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/vistas/css/admin-panel.css">
</head>
<body>

    <h1>Panel de Administración - Usuario: <%= usuarioJWT.getUsuario() %></h1>
    
    <div id="usuarios-container">
	</div>
    
    <div class="panel">
        <h2>Insertar, Eliminar, Actualizar Tablas en la DDBB</h2>
        <div class="btn-container">
            <form method="post" action="<%= request.getContextPath() %>/vistas/designer/manageTables.jsp">
                <button type="submit">Gestionar DDBB</button>
            </form>
        </div>
    </div>

    <form method="post" action="<%= request.getContextPath() %>/vistas/home_directory/home.jsp" class="btn-container">
        <button type="submit" class="back-button">Volver</button>
    </form>

<script>
	window.onload = async function() {
	  try {
	    const response = await fetch("http://localhost:5000/usuariosPDF");
	    const usuarios = await response.json();
	
	    const contenedor = document.getElementById("usuarios-container");
	
	    // Crear un solo formulario
	    const form = document.createElement("form");
	    form.method = "post";  // Usa POST para datos grandes
	    form.action = "http://localhost:8089/exportarTodoPDF";
	    form.className = "form-exportar-update";
	
	    // Crear un input oculto con todos los usuarios en formato JSON
	    const inputUsuarios = document.createElement("input");
	    inputUsuarios.type = "hidden";
	    inputUsuarios.name = "usuariosJSON";
	    inputUsuarios.value = JSON.stringify(usuarios);  // toda la info
	    form.appendChild(inputUsuarios);
	
	    // Crear botón de envío
	    const boton = document.createElement("button");
	    boton.type = "submit";
	    boton.className = "btn-exportar-update";
	    boton.textContent = "📄 Exportar TODOS los usuarios a PDF";
	
	    form.appendChild(boton);
	    contenedor.appendChild(form);
	
	  } catch (error) {
	    console.error("Error al obtener usuarios:", error);
	  }
	};
</script>

</body>
</html>
