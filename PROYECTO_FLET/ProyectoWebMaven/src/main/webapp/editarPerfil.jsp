<%@ page import="dao.FotoDAO" %>
<%@ page import="utils.JWTUtils" %>
<%@ page import="utils.UsuarioJWT" %>

<%
    UsuarioJWT usuarioJWT = null;

    try {
        usuarioJWT = JWTUtils.obtenerUsuarioDesdeRequest(request);
    } catch (Exception e) {
        response.sendRedirect(request.getContextPath() + "/logout.jsp");
        return;
    }

    // Puedes crear variables individuales si quieres
    String usuario = usuarioJWT.getUsuario();
    String nombre = usuarioJWT.getNombre();
    String apellidos = usuarioJWT.getApellidos();
    String email = usuarioJWT.getEmail();
    String token = usuarioJWT.getToken();
    String ultimoLogin = usuarioJWT.getUltimoLogin();
    String rol = usuarioJWT.getRol();
    String cookie = usuarioJWT.getCookie();
    String userId = usuarioJWT.getUserId();

    // Validar que userId no sea null ni vacío
    if (userId == null || userId.isEmpty()) {
        out.println("<p>Error: El ID de usuario no está disponible en el token.</p>");
        return;
    }

    // Crear una instancia del DAO y obtener la foto de perfil
    FotoDAO fotoDAO = new FotoDAO();
    String photoPath = fotoDAO.obtenerRutaFotoPerfil(userId);

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
<title>Editar Perfil</title>
<link rel="stylesheet" href="css/editarPerfilUpdate.css">
<style>
	body, html {
	  height: 100%;
	  font-family: sans-serif;
	  background: linear-gradient(to bottom, #333, #222);
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  transition: all 0.3s ease;
	  cursor: none; /* Inicialmente, el cursor no será visible */
	}
	.ground {
	  width: 100%;
	  height: 105px;
	  background: linear-gradient(90deg, 
	    #4d3620 10%, 
	    #3a2c19 30%, 
	    #5e412e 50%, 
	    #3a2c19 70%, 
	    #4d3620 90%
	  );
	  background-repeat: no-repeat;
	  background-size: 200% 100%;
	  box-shadow: 0 3px 10px rgba(0, 0, 0, 0.5), 0 -2px 6px rgba(0, 0, 0, 0.2);
	  position: absolute;
	  bottom: 0;
	  left: 0;
	  z-index: 1;
	  border-top: 2px solid #2d2118; /* Borde superior para mayor contraste */
	  animation: woodEffect 15s infinite linear; /* Animación sutil para el efecto de madera */
	}
	
	/* Animación sutil para el movimiento de las vetas de la madera */
	@keyframes woodEffect {
	  0% {
	    background-position: 0 0;
	  }
	  50% {
	    background-position: 100% 0;
	  }
	  100% {
	    background-position: 0 0;
	  }
	}
	.screen {
	  width: 840px;
	  height: 460px;
	  background-color: #111;
	  border: 8px solid #000;
	  border-radius: 6px;
	  overflow: hidden;
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  position: relative;
	  transition: box-shadow 0.3s, border-color 0.3s;
	  cursor:default;
	}
</style>
</head>
<body>
  <div class="background">
    <div class="monitor">
      <div class="screen" id="pantalla">
        <form action="procesarEdicion.jsp" method="post" class="formulario" id="formulario">
          <div class="ventana-macos">
            <a href="profile.jsp" class="boton rojo"></a>
            <span class="boton amarillo"></span>
            <span class="boton verde"></span>
          </div>
		  <br>
          <h2>Editar Perfil</h2>
	        <input type="hidden" name="token" value="<%= token %>">
	        
	        <label for="nombre">Nombre: </label>
	        <input type="text" name="nombre" value="<%= nombre %>"><br>
	         
	        <label for="apellidos">Apellidos: </label>
	        <input type="text" name="apellidos" value="<%= apellidos %>"><br>
	         
	        <label for="email">Email: </label>
	        <input type="email" name="email" value="<%= email %>"><br>
	         
	        <label for="usuario">Usuario: </label>
	        <input type="text" name="usuario" value="<%= usuario %>"><br>
	         
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
        <form action="SubirFotoPerfil?user_id=<%= userId %>" method="post" class="formulario" enctype="multipart/form-data">
        <div class="ventana-macos">
            <a href="profile.jsp" class="boton rojo"></a>
            <span class="boton amarillo"></span>
            <span class="boton verde"></span>
          </div>
          <br>
          <h2>Cambiar Foto de Perfil</h2>
          <br>
		  <input type="file" name="profilePhoto" required>
		  <button type="submit">Subir Foto</button>
		</form>
      </div>
      </div>
      <div class="stand"></div>
      <div class="base"></div>
      <div class="ground"></div>
    </div>
  </div>
</body>
</html>
