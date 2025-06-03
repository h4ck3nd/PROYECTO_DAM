<%@ page contentType="text/html; charset=UTF-8" language="java"%>
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
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/vistas/img/icono/icono_cinco_hackend.ico">
  <title>SEPARO - Servicio Público de Ayuda y Recursos Online</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/vistas/css/separo.css">
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
    .forum-container {
		padding: 20px;
		max-width: 800px;
		margin: auto;
		flex-grow: 1;
		overflow-y: auto;
	}
  </style>
</head>
<body>
  <div class="contenedor">
  <header>
    <div class="top-bar">
      <div class="logo">
        <h1><a href="<%= request.getContextPath() %>/vistas/labs/separo/separo-lab.jsp" style="text-decoration: none; color: #ffd700;">SEPARO</a></h1>
      </div>
      <div class="buscador">
        <input type="text" placeholder="Buscar en SEPARO..." />
        <button>BUSCAR</button>
      </div>
    </div>
    <nav class="menu-principal">
      <ul>
        <li><a href="separo.jsp">Inicio</a></li>
        <li><a href="empresas.jsp">Empresas</a></li>
        <li><a href="buscar-empleo.jsp">Empleo</a></li>
        <li><a href="#">Formación</a></li>
        <li><a href="#">Prestaciones</a></li>
      </ul>
    </nav>
  </header>

  <main>
    <section class="accesos-rapidos">
      <h2>Accesos Rápidos</h2>
      <div class="cards">
        <a href="#" class="card">Cita Previa</a>
        <a href="#" class="card">Prestaciones</a>
        <a href="buscar-empleo.jsp" class="card">Buscar Empleo</a>
        <a href="#" class="card">Cursos</a>
      </div>
    </section>

    <section class="destacados">
      <article>
        <h3>Nuevo programa de ayuda al empleo juvenil</h3>
        <p>Conoce el nuevo plan de apoyo para jóvenes en búsqueda activa de empleo.</p>
      </article>
    
      <article>
        <h3>Ampliación del subsidio por desempleo</h3>
        <p>Consulta si cumples los requisitos para acceder a esta nueva medida.</p>
      </article>
    
      <article>
        <h3>Convocatoria abierta para cursos online gratuitos</h3>
        <p>Inscríbete en los nuevos cursos de formación sin coste para desempleados y trabajadores.</p>
      </article>
    
      <article>
        <h3>Actualización del sistema de cita previa</h3>
        <p>Ahora podrás pedir y gestionar tu cita con SEPARO desde cualquier dispositivo móvil.</p>
      </article>
    
      <article>
        <h3>Guía para solicitar prestaciones paso a paso</h3>
        <p>Consulta nuestra nueva guía digital con imágenes y vídeos explicativos.</p>
      </article>
    
      <article>
        <h3>SEPARO lanza su nueva App oficial</h3>
        <p>Descárgala ya y realiza tus trámites de forma rápida, segura y sencilla.</p>
      </article>
    </section>
  </main>

  <footer>
    
    <p>&copy; 2025 SEPARO - Servicio Público de Ayuda y Recursos Online</p>
    <div class="footer-links">
      <a href="#">Aviso Legal</a>
      <a href="#">Política de Privacidad</a>
      <a href="#">Contacto</a>
    </div>
  </footer>
  <!-- Botón para mostrar la solución -->
	<button class="solution-btn" type="button" onclick="showPopupSolution()">💡</button>
	
	<!-- Popup de solución -->
	<div id="popup-solution" class="popup-minimalista hidden">
	  <div class="popup-header">
	    <h2>💡 Solución</h2>
	    <button class="btn-close" onclick="closePopupSolution()">✖</button>
	  </div>
	  <div class="popup-content">
	    <p>Estamos trabajando con una página web que presenta una vulnerabilidad de tipo <b>Open Redirect</b>. Esta vulnerabilidad permite redirigir a los usuarios hacia sitios externos maliciosos sin una validación adecuada por parte del servidor.</p>
	    <br>
	    <p>El problema ocurre porque la aplicación confía ciegamente en un parámetro de URL (por ejemplo, <code>?url=</code>) y lo utiliza directamente para redireccionar, sin verificar si el destino pertenece a un dominio permitido.</p>
		<br>
	    <p><b>EJEMPLOS:</b></p>
		<br>
	    <p>
	      <span class="code-example">http://test.com/?url=http://attacker.com/payload</span>
	      <span class="code-comment"># Redirige directamente al atacante, ya que no se valida el dominio del parámetro <code>url</code>.</span>
	    </p>
		<br>
	    <p>
	      <span class="code-example">http://test.com/?url=http://test.com@attacker.com/payload</span>
	      <span class="code-comment"># Aunque parece legítimo por comenzar con test.com, en realidad lleva al dominio del atacante.</span>
	    </p>
	    <br>
	    <p>Desde el robots.txt podremos ver una ruta de un archivo secret.jsp pero que no podemos entrar de forma directa, por lo que tendremos que entrar con un Open Redirect</p>
	    <br>
	    <p>
	      <span class="code-example">http://IP-Domain/PATH/labs/separo/buscar-empleo.jsp?url=http://IP-Domain/PATH/labs/separo/secret.jsp</span>
	      <span class="code-comment"># Aqui mostramos la solucion de como se resolveria este laboratorio llendonos a buscar-empleo.jsp y poner los parametros "?url=" para seguidamente poner la URL a donde queremos que nos redirija.</span>
	    </p>
		<br>
	    <p>Este tipo de vulnerabilidad puede ser utilizado en ataques de <b>phishing</b>, permitiendo al atacante disfrazar enlaces maliciosos como si fueran legítimos, engañando al usuario.</p>
		<br>
	    <p>Al probar correctamente estos redireccionamientos en el laboratorio, lograremos explotar la vulnerabilidad y obtener la <b>FLAG</b>.</p>
	</div>
	  <button class="btn-close-popup" onclick="closePopupSolution()">Cerrar</button>
	</div>
</div>
<script>
	//Mostrar el popup de solución
	function showPopupSolution() {
	 document.getElementById("popup-solution").classList.remove("hidden");
	}
	
	// Cerrar el popup de solución
	function closePopupSolution() {
	 document.getElementById("popup-solution").classList.add("hidden");
	}
</script>
</body>
</html>
