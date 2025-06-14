<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="dao.FotoDAO" %>
<%@ page import="utils.JWTUtils" %>
<%@ page import="utils.UsuarioJWT" %>

<%
    UsuarioJWT usuarioJWT = null;

	try {
	    usuarioJWT = JWTUtils.obtenerUsuarioDesdeRequest(request);
	} catch (Exception e) {
	    // Redirigir al servlet de logout en vez de al .jsp
	    response.sendRedirect(request.getContextPath() + "/logout");
	    return;
	}

    // Validar que userId no sea null ni vacío
    if (usuarioJWT.getUserId() == null || usuarioJWT.getUserId().isEmpty()) {
        out.println("<p>Error: El ID de usuario no está disponible en el token.</p>");
        return;
    }

    // Crear una instancia del DAO y obtener la foto de perfil
    FotoDAO fotoDAO = new FotoDAO();
    String photoPath = fotoDAO.obtenerRutaFotoPerfil(usuarioJWT.getUserId());

    // Si no tiene foto de perfil, establecer una imagen por defecto
    if (photoPath == null || photoPath.isEmpty()) {
        photoPath = "vistas/img/Profile.png";  // Ruta de la imagen por defecto
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/vistas/img/icono/icono_cinco_hackend.ico">
    <title>PERFIL DE <%= usuarioJWT.getUsuario() %></title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/vistas/css/editarPerfilUpdate.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/vistas/css/cssProfile.jsp">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/vistas/css/dynamicFonts.jsp" />
</head>
<body>
<!-- Popup personalizado para confirmar eliminación de cuenta -->
				<div id="popup-confirm" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background-color:rgba(0,0,0,0.75); z-index:9999; justify-content:center; align-items:center;">
				  <div style="background:#111; padding:30px; border:2px solid #ff5f57; border-radius:10px; text-align:center; max-width:400px;">
				    <p style="color:white; margin-bottom:20px;">¿Estás seguro de que deseas eliminar tu cuenta?<br>Esta acción es irreversible.</p>
				    <button id="confirm-btn" style="margin-right:10px; padding:8px 20px; background-color:#b92500; color:white; border:none; border-radius:5px; cursor:pointer;">Confirmar</button>
				    <button id="cancel-btn" style="padding:8px 20px; background-color:#333; color:white; border:none; border-radius:5px; cursor:pointer;">Cancelar</button>
				  </div>
				</div>
	<div class="background">
    <div class="monitor">
      <div class="screen" id="pantalla">
        <form class="formulario" id="formulario">
          <div class="ventana-macos">
            <a href="<%= request.getContextPath() %>/vistas/home_directory/home.jsp" class="boton rojo"></a>
            <span class="boton amarillo"></span>
            <span class="boton verde"></span>
	          </div>
	          <br><br>
	          <div class="content">
			  <div class="profile-header">
			    <img src="<%= request.getContextPath() %>/<%= photoPath %>" alt="Foto de perfil" class="profile-img">
			    <div class="user-info">
			      <h2 class="username"><%= usuarioJWT.getUsuario() %></h2>
			      <p class="role">Rol: <%= usuarioJWT.getRol() %></p>
			    </div>
			  </div>
			
			  <div class="profile-details">
			    <p><strong>Correo:</strong> <%= usuarioJWT.getEmail() %></p>
			    <p><strong>Nombre:</strong> <%= usuarioJWT.getNombre() %></p>
			    <p><strong>Apellido:</strong> <%= usuarioJWT.getApellidos() %></p>
			    <p><strong>Último Login:</strong> <%= usuarioJWT.getUltimoLogin() != null ? usuarioJWT.getUltimoLogin() : "Nunca ha iniciado sesión" %></p>
			  </div>
			
			  <div class="profile-actions">
			    <a href="editarPerfil.jsp" class="btn editar" style="text-decoration: none; color: white;">Editar Perfil</a>
			    <a href="<%= request.getContextPath() %>/logout" class="btn cerrar" style="text-decoration: none; color: white;">Cerrar Sesion</a>
			  </div>
				<!-- Botón sin anidaciones raras -->
				<button type="button" class="btn danger" data-userid="<%= usuarioJWT.getUserId() %>" onclick="eliminarCuenta(event)">
				  Eliminar cuenta
				</button>
				
			</div>
        </form>
        
        <div class="contenedor-exportar">
				  <form method="get" action="http://localhost:8090/exportarPDF" class="form-exportar-update">
				    <input type="hidden" name="user_id" value="<%= usuarioJWT.getUserId() %>">
				    <input type="hidden" name="usuarioNombre" value="<%= usuarioJWT.getNombre() %>">
				    <input type="hidden" name="usuarioApellidos" value="<%= usuarioJWT.getApellidos() %>">
				    <input type="hidden" name="usuarioEmail" value="<%= usuarioJWT.getEmail() %>">
				
				    <button type="submit" class="btn-exportar-update">📄 Exportar a PDF</button>
				  </form>
				</div>
      </div>
      <div class="stand"></div>
      <div class="base"></div>
      <div class="ground"></div>
    </div>
  </div>
  
  <script>
	  // Variable global para almacenar el userId temporalmente
	  let userIdToDelete = null;
	
	  function eliminarCuenta(event) {
	    event.preventDefault();
	
	    const button = event.currentTarget;
	    userIdToDelete = button.getAttribute("data-userid");
	
	    // Mostramos el popup
	    const popup = document.getElementById("popup-confirm");
	    popup.style.display = "flex";
	  }
	
	  window.addEventListener("DOMContentLoaded", () => {
	    const confirmBtn = document.getElementById("confirm-btn");
	    const cancelBtn = document.getElementById("cancel-btn");
	    const popup = document.getElementById("popup-confirm");
	
	    confirmBtn.addEventListener("click", function () {
	      if (userIdToDelete) {
	        // Hacemos la llamada al servlet Java
	        fetch('<%= request.getContextPath() %>/eliminar-cuenta-cascade', {
	          method: "POST",
	          headers: {
	            "Content-Type": "application/json"
	          },
	          body: JSON.stringify({ userId: userIdToDelete })
	        })
	        .then(response => response.json())
	        .then(data => {
	          if (data.mensaje) {
	            window.location.href = "http://localhost:30050/"; // Redirección a home o login
	          } else {
	            alert("Error al eliminar la cuenta: " + (data.error || "desconocido"));
	          }
	        })
	        .catch(error => {
	          console.error("Error en la solicitud:", error);
	          alert("Error al comunicarse con el servidor.");
	        });
	      }
	    });
	
	    cancelBtn.addEventListener("click", function () {
	      popup.style.display = "none";
	      userIdToDelete = null;
	    });
	  });
</script>
</body>
</html>
