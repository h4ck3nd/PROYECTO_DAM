<%@ page import="com.auth0.jwt.JWT" %>
<%@ page import="com.auth0.jwt.algorithms.Algorithm" %>
<%@ page import="com.auth0.jwt.interfaces.DecodedJWT" %>
<%@ page import="com.auth0.jwt.interfaces.JWTVerifier" %>
<%@ page import="com.auth0.jwt.exceptions.JWTVerificationException" %>
<%@ page import="io.jsonwebtoken.Claims" %>
<%@ page import="io.jsonwebtoken.Jwts" %>
<%@ page import="io.jsonwebtoken.ExpiredJwtException" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="dao.FotoDAO" %>

<%
    // Buscar el token en las cookies
    String token = null;
    Cookie[] cookies = request.getCookies();  // Obtener todas las cookies

    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("token".equals(cookie.getName())) {
                token = cookie.getValue();  // Si encontramos la cookie con el nombre "token", obtenemos su valor
                break;
            }
        }
    }

    // Verificar si el token est� presente
    if (token == null || token.isEmpty()) {
        // Si no hay token, redirigir al logout.jsp
        response.sendRedirect("http://localhost:8080/ProyectoWebMaven/logout.jsp");
        return;
    }

    String SECRET_KEY = "clave_super_secreta";  // La misma clave secreta que usaste para firmar el JWT

    // Variables de los claims
    String nombre = "";
    String apellidos = "";
    String rol = "";
    String email = "";
    String ultimoLogin = "";
    String usuario = "";
    String cookie = "";

    Claims claims = null;  // Aseguramos que `claims` est� accesible en el bloque

    try {
        // Intentar decodificar el JWT utilizando io.jsonwebtoken (JJWT)
        claims = Jwts.parser()
            .setSigningKey(SECRET_KEY.getBytes(StandardCharsets.UTF_8))  // Usamos la clave secreta
            .parseClaimsJws(token)  // Parseamos el token JWT
            .getBody();  // Extraemos el cuerpo del token (claims)

        // Obtener los valores del token (JWT)
        nombre = (String) claims.get("nombre");
        apellidos = (String) claims.get("apellidos");
        rol = (String) claims.get("rol");
        email = (String) claims.get("email");
        ultimoLogin = (String) claims.get("ultimo_login");
        usuario = (String) claims.get("usuario");
        cookie = (String) claims.get("cookie");

    } catch (ExpiredJwtException e) {
        // Si el token ha expirado, redirigir al logout.jsp
        response.sendRedirect("http://localhost:8080/ProyectoWebMaven/logout.jsp");
        return;
    } catch (JWTVerificationException e) {
        out.println("<p>Error: Token inv�lido (" + e.getMessage() + ")</p>");
        return;
    } catch (Exception e) {
        out.println("<p>Error al procesar el token: " + e.getMessage() + "</p>");
        return;
    }

    // Obtener el ID del usuario desde el token (ahora claims es accesible)
    Object userIdObject = claims.get("user_id");  // Obtener el valor de user_id
    String userId = null;

    // Verificar si el valor de user_id es un Integer
    if (userIdObject instanceof Integer) {
        userId = String.valueOf(userIdObject);  // Convertir a String si es un Integer
    } else if (userIdObject instanceof String) {
        userId = (String) userIdObject;  // Si ya es un String, no es necesario hacer el cast
    }

    // Validar que userId no sea null ni vac�o
    if (userId == null || userId.isEmpty()) {
        out.println("<p>Error: El ID de usuario no est� disponible en el token.</p>");
        return;
    }

    // Crear una instancia del DAO y obtener la foto de perfil
    FotoDAO fotoDAO = new FotoDAO();
    String photoPath = fotoDAO.obtenerRutaFotoPerfil(userId);

    // Si no tiene foto de perfil, establecer una imagen por defecto
    if (photoPath == null || photoPath.isEmpty()) {
        photoPath = "img/Profile.png";  // Ruta de la imagen por defecto
    }

    // Usar `photoPath` para mostrar la imagen en la p�gina
    out.println("<img src='" + photoPath + "' alt='Foto de perfil' />");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Perfil de <%= usuario %></title>
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
	  cursor: none; /* Inicialmente, el cursor no ser� visible */
	}
	.ground {
	  width: 100%;
	  height: 155px;
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
	  animation: woodEffect 15s infinite linear; /* Animaci�n sutil para el efecto de madera */
	}
	
	/* Animaci�n sutil para el movimiento de las vetas de la madera */
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
</style>
</head>
<body>
	<div class="background">
    <div class="monitor">
      <div class="screen" id="pantalla">
        <form class="formulario" id="formulario">
          <div class="ventana-macos">
            <a href="home_directory/home.jsp?page=0" class="boton rojo"></a>
            <span class="boton amarillo"></span>
            <span class="boton verde"></span>
	          </div>
	          <br><br>
	          <div class="content">
			  <div class="profile-header">
			    <img src="<%= photoPath %>" alt="Foto de perfil" class="profile-img">
			    <div class="user-info">
			      <h2 class="username"><%= usuario %></h2>
			      <p class="role">Rol: <%= rol %></p>
			    </div>
			  </div>
			
			  <div class="profile-details">
			    <p><strong>Correo:</strong> <%= email %></p>
			    <p><strong>Nombre:</strong> <%= nombre %></p>
			    <p><strong>Apellido:</strong> <%= apellidos %></p>
			    <p><strong>�ltimo Login:</strong> <%= ultimoLogin != null ? ultimoLogin : "Nunca ha iniciado sesi�n" %></p>
			    <p><strong>Cookie:</strong> <%= cookie %></p>
			    <p><strong>Token:</strong> <%= token %></p>
			  </div>
			
			  <div class="profile-actions">
			    <button class="btn editar"><a href="editarPerfil.jsp" style="text-decoration: none; color: white;">Editar Perfil</a></button>
			    <button class="btn editar"><a href="subirFotoPerfil.jsp" style="text-decoration: none; color: white;">Subir Foto de Perfil</a></button>
			    <button class="btn cerrar"><a href="logout.jsp" style="text-decoration: none; color: white;">Cerrar sesi�n</a></button>
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