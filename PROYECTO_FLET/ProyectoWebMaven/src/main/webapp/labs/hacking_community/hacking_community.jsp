<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="dao.LaboratorioDAO" %>
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

 	// Obtener el lab_id de "hacking_community" desde la base de datos
    int labId = LaboratorioDAO.obtenerIdLaboratorioHacking_community();
    String mensaje = "";

    // Recuperamos el mensaje desde la URL
    String resultadoFlag = request.getParameter("mensaje");
%>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/img/icono/icono_cinco_hackend.ico">
  <title>HACKING COMMUNITY | Blog</title>
  <style>
	/* Estilo del mensaje emergente */
		.message-popup {
		    position: fixed;
		    top: 50%;
		    left: 50%;
		    transform: translate(-50%, -50%);
		    background-color: rgba(0, 0, 0, 0.85); /* Un poco más oscuro para más énfasis */
		    padding: 25px 40px; /* Más espacio alrededor del mensaje */
		    border-radius: 10px; /* Bordes más redondeados */
		    color: white;
		    max-width: 90%;
		    min-width: 300px;
		    display: none;
		    z-index: 1000;
		    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3); /* Agregar sombra para dar profundidad */
		    font-family: Arial, sans-serif;
		}
		
		/* Estilo del contenido dentro del popup */
		.message-popup .message-popup-content {
		    font-size: 16px;
		    padding: 10px;
		    text-align: center; /* Centrar el texto */
		}
		
		/* Estilo del encabezado dentro del popup */
		.message-popup .message-popup-header {
		    font-size: 20px;
		    font-weight: bold;
		    margin-bottom: 15px;
		    text-align: center;
		    color: #f5f5f5;
		}
		
		/* Estilo del botón para cerrar el popup */
		.message-popup .message-popup-close-btn {
		    background: #ff5e57;
		    border: none;
		    color: white;
		    padding: 8px 16px;
		    font-size: 18px;
		    cursor: pointer;
		    border-radius: 5px;
		    display: block;
		    margin: 20px auto 0; /* Centrar y separar de la parte superior */
		    text-align: center;
		}
		
		/* Cambio de color al pasar el ratón sobre el botón de cerrar */
		.message-popup .message-popup-close-btn:hover {
		    background: #ff3830;
		}
		
		/* Ocultar el popup por defecto */
		.message-popup {
		    display: none; /* Asegúrate de que esté oculto por defecto */
		}
		
		/* Mostrar el popup cuando tiene la clase .show */
		.message-popup.show {
		    display: block; /* Se muestra cuando tiene la clase .show */
		}
  </style>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/hacking_community.css">
</head>
<body>
  <div class="wrapper">
    <header>
      <div class="container">
        <div class="logo">HACKING COMMUNITY</div>
        <nav>
          <ul>
            <li><a href="<%= request.getContextPath() %>/home_directory/home.jsp?page=0">Inicio</a></li>
            <li><a href="contacto.jsp">Contacto</a></li>
          </ul>
        </nav>
      </div>
    </header>
	<!-- Popup para mostrar el mensaje -->
    <div id="popupMessage" class="message-popup">
        <div class="message-popup-header">Mensaje</div>
        <div class="message-popup-content" id="popupContent">
            <p><%= request.getAttribute("mensaje") %></p>
        </div>
        <button class="message-popup-close-btn"><a href="<%= request.getContextPath() %>/labs/hacking_community/hacking_community.jsp" style="text-decoration: none; color: white;">Cerrar</a></button>
    </div>
	  <div class="flag-input-section">
		  <h3>Introduce la flag del laboratorio</h3>
		  <form action="<%= request.getContextPath() %>/validarFlag" method="get" class="flag-form">
			  <input type="hidden" name="user_id" value="<%= usuarioJWT.getUserId() %>">
			  <input type="hidden" name="lab_id" value="<%= labId %>">
			  <label for="flag">Ingrese la FLAG:</label>
			  <input type="text" id="flag" name="flag" required>
			  <button class="flag-btn" type="submit" class="style-button-flag">Enviar FLAG</button>
		  </form>
	</div>
	<br>
    <main class="container">
      <!-- Artículo principal -->
      <section class="featured-article">
        <img src="<%= request.getContextPath() %>/img/img-main-article.avif" alt="Artículo principal">
        <div class="post-content">
          <h1>Cómo empezar en el hacking ético en 2025</h1>
          <p class="intro-text">
            Descubre las herramientas, metodologías y plataformas esenciales para iniciar tu camino como hacker ético.
            En esta guía aprenderás cómo funcionan los entornos de laboratorio, qué debes estudiar y dónde practicar.
          </p>
          <a href="main-article.jsp" class="read-more">Leer artículo completo +</a>
        </div>
      </section>

      <!-- Últimos artículos -->
      <h2 style="margin-top: 50px;">Últimos artículos</h2>
      <section class="blog-posts">
        <article class="post">
          <img src="<%= request.getContextPath() %>/img/img-article-one.jpeg" alt="Artículo 1">
          <div class="post-content">
            <h2><a href="article-one.jsp">Top 5 plataformas para practicar hacking web</a></h2>
            <p>Te presentamos las mejores plataformas gratuitas y de pago donde puedes mejorar tus habilidades en hacking web.</p>
            <a href="article-one.jsp" class="read-more">Leer más +</a>
          </div>
        </article>
        <article class="post">
          <img src="<%= request.getContextPath() %>/img/img-article-two.webp" alt="Artículo 2">
          <div class="post-content">
            <h2><a href="article-two.jsp">¿Qué es un CTF y por qué deberías participar?</a></h2>
            <p>Conoce los beneficios de competir en CTFs, cómo prepararte y dónde encontrar los mejores retos para empezar.</p>
            <a href="article-two.jsp" class="read-more">Leer más +</a>
          </div>
        </article>
        <article class="post">
          <img src="<%= request.getContextPath() %>/img/img-article-three.png" alt="Artículo 3">
          <div class="post-content">
            <h2><a href="article-three.jsp">Los comandos básicos de Linux que todo hacker debe saber</a></h2>
            <p>Aprende a dominar la terminal de Linux desde cero. Comandos esenciales, navegación y trucos para pentesters.</p>
            <a href="article-three.jsp" class="read-more">Leer más +</a>
          </div>
        </article>
		<article class="post">
			<img src="<%= request.getContextPath() %>/img/img-article-four.png" alt="Artículo 4">
			<div class="post-content">
			  <h2><a href="article-four.jsp">Cómo explotar una vulnerabilidad XSS paso a paso</a></h2>
			  <p>Aprende a detectar, explotar y mitigar ataques de Cross-Site Scripting con ejemplos reales en laboratorios de práctica.</p>
			  <a href="article-four.jsp" class="read-more">Leer más +</a>
			</div>
		  </article>
      </section>
    </main>
  </div>

  <footer>
    <div class="container">
      <p>&copy; 2025 HACKING COMMUNITY. Todos los derechos reservados.</p>
    </div>
  </footer>
  <script>
        // Función para mostrar el popup
        function showPopup(message) {
            var popup = document.getElementById("popupMessage");
            var content = document.getElementById("popupContent");
            content.innerHTML = message; // Ponemos el mensaje en el popup
            popup.classList.add('show'); // Hacemos visible el popup
        }

        // Función para cerrar el popup
        function closePopup() {
            var popup = document.getElementById("popupMessage");
            popup.classList.remove('show'); // Ocultamos el popup
            window.location.href = "<%= request.getContextPath() %>/labs/foro-xss.jsp"; // Redirigimos
        }

        // Si el mensaje no es nulo, mostramos el popup con el mensaje
        <%
            if (resultadoFlag != null) { 
        %>
            showPopup("<%= resultadoFlag %>"); // Mostrar el mensaje en el popup
        <% 
            }
        %>
    </script>
</body>
</html>