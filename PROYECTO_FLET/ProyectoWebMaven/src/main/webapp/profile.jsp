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
    <title>Perfil de <%= usuarioJWT.getUsuario() %></title>
	<link rel="stylesheet" href="css/profileUpdate.css">
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
	.btn.cerrar {
	  background-color: #ff5f57;
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
	
	.btn.cerrar:hover {
	  background-color: #cc4b45;
	}
	.btn.progreso {
	  background-color: #00aaff;
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
	
	.btn.progreso:hover {
	  background-color: #007acc;
	}
</style>
</head>
<body>
	<div class="background">
    <div class="monitor">
      <div class="screen" id="pantalla">
        <form class="formulario" id="formulario">
          <div class="ventana-macos">
            <a href="<%= request.getContextPath() %>/home_directory/home.jsp?page=0" class="boton rojo"></a>
            <span class="boton amarillo"></span>
            <span class="boton verde"></span>
	          </div>
	          <br><br>
	          <div class="content">
			  <div class="profile-header">
			    <img src="<%= photoPath %>" alt="Foto de perfil" class="profile-img">
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
			    <p><strong>Cookie:</strong> <%= usuarioJWT.getCookie() %></p>
			    <p><strong>Token:</strong> <%= usuarioJWT.getToken() %></p>
			  </div>
			
			  <div class="profile-actions">
			    <a href="editarPerfil.jsp" class="btn editar" style="text-decoration: none; color: white;">Editar Perfil</a>
			    <a href="progreso.jsp" class="btn progreso" style="text-decoration: none; color: white;">Ver Progreso</a>
			    <!--<button class="btn editar"><a href="subirFotoPerfil.jsp" style="text-decoration: none; color: white;">Subir Foto de Perfil</a></button>-->
			    <a href="<%= request.getContextPath() %>/logout" class="btn cerrar" style="text-decoration: none; color: white;">Cerrar Sesion</a>
			  </div>
			</div>
        </form>
      </div>
      <div class="stand"></div>
      <div class="base"></div>
      <div class="ground"></div>
    </div>
  </div>
</body>
</html>