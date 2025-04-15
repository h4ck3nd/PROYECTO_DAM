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
		/* Popup estilo minimalista */
		.popup-solucion {
		  position: fixed;
		  top: 50%;
		  left: 50%;
		  transform: translate(-50%, -50%);
		  background-color: #ffffff;
		  border-radius: 10px;
		  padding: 25px 20px;
		  width: 400px;
		  max-width: 90%;
		  z-index: 1000;
		  font-family: 'Segoe UI', sans-serif;
		  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
		  animation: popupFade 0.3s ease-in-out;
		}
		
		.popup-header-solucion {
		  display: flex;
		  justify-content: space-between;
		  align-items: center;
		  border-bottom: 1px solid #e0e0e0;
		  padding-bottom: 10px;
		  margin-bottom: 15px;
		}
		
		.popup-header-solucion h2 {
		  color: #333;
		  font-size: 1.2rem;
		  margin: 0;
		}
		
		.cerrar-btn {
		  background: none;
		  border: none;
		  color: #888;
		  font-size: 1.2rem;
		  cursor: pointer;
		}
		
		.popup-contenido-solucion {
		  color: #444;
		  font-size: 0.95rem;
		  line-height: 1.5;
		  margin-bottom: 20px;
		}
		
		.codigo-solucion {
		  font-family: 'Courier New', monospace;
		  background-color: #ababab;
		  padding: 3px 6px;
		  border-radius: 4px;
		  color: #000;
		}
		
		.comentario-codigo {
		  color: #555;
		  font-style: italic;
		  margin-left: 5px;
		}
		
		.btn-cerrar-solucion {
		  background-color: #1976d2;
		  color: white;
		  border: none;
		  padding: 10px 16px;
		  border-radius: 4px;
		  font-weight: 500;
		  cursor: pointer;
		  transition: background-color 0.3s ease;
		}
		
		.btn-cerrar-solucion:hover {
		  background-color: #1565c0;
		}
		
		/* Botón de solución */
		.solution-btn {
		  position: fixed;
		  bottom: 10px;
		  left: 10px;
		  background-color: #1976d2;
		  color: #fff;
		  border: none;
		  font-size: 1.5rem;
		  border-radius: 50%;
		  width: 50px;
		  height: 50px;
		  cursor: pointer;
		  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
		  transition: transform 0.2s ease;
		  z-index: 1000;
		}
		
		.solution-btn:hover {
		  transform: scale(1.1);
		}
		
		.hidden {
		  display: none;
		}
		
		@keyframes popupFade {
		  from {
		    opacity: 0;
		    transform: translate(-50%, -50%) scale(0.95);
		  }
		  to {
		    opacity: 1;
		    transform: translate(-50%, -50%) scale(1);
		  }
		}
		.writeup-input-section {
			margin-top: 40px;
			padding: 20px;
			background-color: #2e323d;
			border-radius: 8px;
			box-shadow: 0 4px 10px rgba(0, 255, 174, 0.15);
			text-align: center;
		}
		
		.writeup-input-section h3 {
			color: #00ffae;
			margin-bottom: 15px;
			font-size: 1.2rem;
		}
		
		.writeup-input-section input[type="url"] {
			padding: 10px 15px;
			border: none;
			border-radius: 5px;
			width: 60%;
			max-width: 400px;
			font-size: 1rem;
			margin-right: 10px;
			text-align: center;
		}
		
		.writeup-input-section button {
			padding: 10px 20px;
			background-color: #00ffae;
			color: #1e212d;
			border: none;
			border-radius: 5px;
			font-weight: bold;
			cursor: pointer;
			transition: background-color 0.3s ease;
		}
		
		.writeup-input-section button:hover {
			background-color: #00e6a0;
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
    <!-- FORMULARIO PARA ENVIAR WRITEUP -->
		<form class="writeup-input-section" action="<%= request.getContextPath() %>/WriteupControlador" method="post">
			<h3>Enviar Writeup</h3>
		    <input type="hidden" name="lab_id" value="<%= labId %>">
		    <input type="hidden" name="user_id" value="<%= usuarioJWT.getUserId() %>">
		    <label for="url_writeup">Enviar enlace del Writeup:</label>
		    <input type="url" name="url_writeup" id="url_writeup" required>
		    <button type="submit">Enviar Writeup</button>
		</form>
	<!-- FORMULARIO PARA ENVIAR FLAG -->
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
  <!-- Botón para mostrar la solución -->
	<button class="solution-btn" type="button" onclick="showPopupSolution()">💡</button>
	
	<!-- Popup de solución -->
	<div id="popup-solution" class="popup-solucion hidden">
	  <div class="popup-header-solucion">
	    <h2>💡 Solución</h2>
	    <button class="cerrar-btn" onclick="closePopupSolution()">✖</button>
	  </div>
	  <div class="popup-contenido-solucion">
		  <p>En este laboratorio identificamos una vulnerabilidad del tipo <b>BAC (Broken Access Control)</b>, donde no hay control de acceso adecuado a recursos sensibles.</p>
		  <p>Al explorar el archivo <span class="codigo-solucion">/robots.txt</span>, encontramos una ruta restringida que no debería ser visible:</p>
		  <p><span class="codigo-solucion">/labs/hacking_community/admin-panel-secret.jsp</span></p>
		  <p>Al acceder a esta ruta, notamos que no se requiere autenticación ni validación de permisos, lo que permite que cualquier usuario entre al panel de administrador.</p>
		  <p>Dentro de este panel, podemos visualizar directamente la <b>FLAG</b> del laboratorio sin ninguna restricción.</p>
		  <p>Este es un claro ejemplo de mala implementación de control de acceso combinado con una mala práctica al exponer rutas sensibles en archivos públicos.</p>
		</div>
	  <button class="btn-cerrar-solucion" onclick="closePopupSolution()">Cerrar</button>
	</div>

  <footer>
    <div class="container">
      <p>&copy; 2025 HACKING COMMUNITY. Todos los derechos reservados.</p>
    </div>
  </footer>
  <script>
		//Mostrar el popup de solución
		  function showPopupSolution() {
		    document.getElementById("popup-solution").classList.remove("hidden");
		  }
		
		  // Cerrar el popup de solución
		  function closePopupSolution() {
		    document.getElementById("popup-solution").classList.add("hidden");
		  }
  
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
            window.location.href = "<%= request.getContextPath() %>/labs/hacking_community/hacking_community.jsp"; // Redirigimos
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