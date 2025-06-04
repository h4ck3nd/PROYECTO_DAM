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
        photoPath = "img/Profile.png";  // Ruta de la imagen por defecto
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/png" href="<%= request.getContextPath() %>/vistas/img/icono/icono_cinco_hackend.ico">
<title>EDITAR PERFIL</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/vistas/css/cssEditarPerfil.jsp">
<link rel="stylesheet" href="<%= request.getContextPath() %>/vistas/css/dynamicFonts.jsp" />
</head>
<body>
  <div class="background">
    <div class="monitor">
      <div class="screen" id="pantalla">
        <form action="<%= request.getContextPath() %>/actualizarPerfil" method="post" class="formulario" id="formulario">
          <div class="ventana-macos">
            <a href="profile.jsp" class="boton rojo"></a>
            <span class="boton amarillo"></span>
            <span class="boton verde"></span>
          </div>
		  <br>
          <h2 style="font-size: 30px !important">Editar Perfil</h2>
	        <input type="hidden" name="token" value="<%= usuarioJWT.getToken() %>">
	        
	        <label for="nombre">Nombre: </label>
	        <input type="text" name="nombre" value="<%= usuarioJWT.getNombre() %>"><br>
	         
	        <label for="apellidos">Apellidos: </label>
	        <input type="text" name="apellidos" value="<%= usuarioJWT.getApellidos() %>"><br>
	         
	        <label for="email">Email: </label>
	        <input type="email" name="email" value="<%= usuarioJWT.getEmail() %>"><br>
	         
	        <label for="usuario">Usuario: </label>
	        <input type="text" name="usuario" value="<%= usuarioJWT.getUsuario() %>"><br>
	         
		    <!-- Nuevo campo para la contraseña actual -->
		    <label for="currentPassword">Password Actual: </label>
		    <input type="password" name="currentPassword"><br>
		
		    <!-- Nueva contraseña y confirmación de nueva contraseña -->
		    <label for="newPassword">Nueva Password: </label>
		    <input type="password" name="newPassword"><br>
		
		    <label for="confirmNewPassword">Confirmar Nueva Password: </label>
		    <input type="password" name="confirmNewPassword"><br>
	         
	        <button type="submit">Guardar Cambios</button>
        </form>
        <div class="screen" id="pantalla">
        <form action="<%= request.getContextPath() %>/SubirFotoPerfil?user_id=<%= usuarioJWT.getUserId() %>" method="post" class="formulario" enctype="multipart/form-data">
        <div class="ventana-macos">
		    <a href="profile.jsp" class="boton rojo"></a>
		    <span class="boton amarillo"></span>
		    <span class="boton verde"></span>
		</div>
          <br>
          <h2 style="font-size: 30px !important">Cambiar Foto de Perfil</h2>
          <br>
		  <input type="file" id="profilePhoto" name="profilePhoto">
		  <button type="submit">Subir Foto</button>
    	  <button type="submit" name="eliminar" value="true">Eliminar Foto de Perfil</button>
		</form>
      </div>
      </div>
      <!-- Capa de arrastrar -->
	<div id="dropOverlay" class="drop-overlay">
	    <div class="drop-text">Suelta la imagen aquí para subir</div>
	</div>
      <div class="stand"></div>
      <div class="base"></div>
      <div class="ground"></div>
    </div>
  </div>
  <script>
	  const dropOverlay = document.getElementById('dropOverlay');
	  const profilePhotoInput = document.getElementById('profilePhoto');
	
	  // Mostrar overlay cuando se arrastra algo
	  document.addEventListener('dragover', (e) => {
	      e.preventDefault();
	      dropOverlay.style.display = 'flex';
	  });
	
	  // Ocultar overlay si se sale
	  document.addEventListener('dragleave', (e) => {
	      if (e.clientX <= 0 || e.clientY <= 0 || e.clientX >= window.innerWidth || e.clientY >= window.innerHeight) {
	          dropOverlay.style.display = 'none';
	      }
	  });
	
	  // Soltar archivo
	  document.addEventListener('drop', (e) => {
	      e.preventDefault();
	      dropOverlay.style.display = 'none';
	
	      const files = e.dataTransfer.files;
	      if (files.length > 0) {
	          profilePhotoInput.files = files; // Cargamos archivo en el input
	          // Ya no hacemos submit automático.
	      }
	  });
  </script>
</body>
</html>
