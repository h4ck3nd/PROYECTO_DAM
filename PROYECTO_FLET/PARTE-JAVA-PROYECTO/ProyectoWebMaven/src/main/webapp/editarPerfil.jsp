<%
/**
 * Configuración de la página:
 * - Tipo de contenido: HTML con codificación UTF-8
 * - Lenguaje: Java
 */
%>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="dao.FotoDAO" %>
<%@ page import="utils.JWTUtils" %>
<%@ page import="utils.UsuarioJWT" %>
<%
/**
 * Importación de clases necesarias:
 * - FotoDAO: Acceso a datos para gestión de fotos de perfil
 * - JWTUtils: Utilidades para manejo de tokens JWT
 * - UsuarioJWT: Representación del usuario autenticado
 */
%>
<%

/**
 * Extracción y validación del usuario a partir del token JWT.
 * En caso de error o token inválido, redirige al servlet de logout.
 */

    UsuarioJWT usuarioJWT = null;

	try {
	    usuarioJWT = JWTUtils.obtenerUsuarioDesdeRequest(request);
	} catch (Exception e) {
	    // Redirigir al servlet de logout en vez de al .jsp
	    response.sendRedirect(request.getContextPath() + "/logout");
	    return;
	}

     /**
     * Validación adicional para asegurarse de que el ID de usuario esté presente en el token.
     * Si no está, se muestra un mensaje de error.
     */

    // Validar que userId no sea null ni vacío
    if (usuarioJWT.getUserId() == null || usuarioJWT.getUserId().isEmpty()) {
        out.println("<p>Error: El ID de usuario no está disponible en el token.</p>");
        return;
    }

    /**
     * Uso del DAO para obtener la ruta de la foto de perfil del usuario.
     * Si no tiene foto, se asigna una imagen por defecto.
     */

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
<link rel="icon" type="image/png" href="<%= request.getContextPath() %>/img/icono/icono_cinco_hackend.ico">
<title>EDITAR PERFIL</title>
<link rel="stylesheet" href="css/editarPerfilUpdate.css">
<link href="https://fonts.googleapis.com/css2?family=VT323&display=swap" rel="stylesheet">
<!-- Estilos generales y visuales del formulario de edición -->
<style>
* {
			font-family: 'VT323', monospace !important;
			font-size: 20px;
		}
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
	/* Capa para arrastrar archivo */
	.drop-overlay {
	    display: none;
	    position: fixed;
	    top: 0;
	    left: 0;
	    right: 0;
	    bottom: 0;
	    background: rgba(0, 0, 0, 0.7);
	    z-index: 1000;
	    align-items: center;
	    justify-content: center;
	    flex-direction: column;
	    color: white;
	    font-size: 24px;
	    font-weight: bold;
	}
	
	/* Estilo de texto dentro de la capa */
	.drop-text {
	    text-align: center;
	}
</style>
</head>
<body>
<!-- Estructura de pantalla editable -->
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
        <form action="SubirFotoPerfil?user_id=<%= usuarioJWT.getUserId() %>" method="post" class="formulario" enctype="multipart/form-data">
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
	<!-- Capa de sobreposición visual al arrastrar archivo -->
	<div id="dropOverlay" class="drop-overlay">
	    <div class="drop-text">Suelta la imagen aquí para subir</div>
	</div>
	<!-- Elementos decorativos de base -->
      <div class="stand"></div>
      <div class="base"></div>
      <div class="ground"></div>
    </div>
  </div>
<!-- Script para manejar subida arrastrando imagen -->
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
