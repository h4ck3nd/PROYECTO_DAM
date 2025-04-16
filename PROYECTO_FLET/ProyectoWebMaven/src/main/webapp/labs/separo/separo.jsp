<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="utils.JWTUtils" %>
<%@ page import="utils.UsuarioJWT" %>
<%@ page import="dao.LaboratorioDAO" %>

<%
    UsuarioJWT usuarioJWT = null;

	try {
	    usuarioJWT = JWTUtils.obtenerUsuarioDesdeRequest(request);
	} catch (Exception e) {
	    // Redirigir al servlet de logout en vez de al .jsp
	    response.sendRedirect(request.getContextPath() + "/logout");
	    return;
	}
	
	// Obtener el lab_id de "foro-xss" desde la base de datos
    int labId = LaboratorioDAO.obtenerIdLaboratorioSeparo();
    String mensaje = "";

    // Recuperamos el mensaje desde la URL
    String resultadoFlag = request.getParameter("mensaje");
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/img/icono/icono_cinco_hackend.ico">
  <title>SEPARO - Servicio Público de Ayuda y Recursos Online</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/separo.css">
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
		.btn-dark {
        display: inline-block;
        padding: 10px 20px;
        background-color: #4f4f4f;
        color: #f0f0f0;
        text-decoration: none;
        border: 1px solid #444;
        border-radius: 5px;
        font-family: 'Courier New', Courier, monospace;
        transition: background-color 0.3s ease, transform 0.2s ease;
    }

    .btn-dark:hover {
        background-color: #777;
        transform: translateY(-2px);
    }

    .btn-dark:active {
        background-color: #333;
        transform: translateY(0);
    }
    .forum-container {
		padding: 20px;
		max-width: 800px;
		margin: auto;
		flex-grow: 1;
		overflow-y: auto;
	}
	.labPopup-modal {
	    display: none;
	    position: fixed;
	    z-index: 9999;
	    left: 0;
	    top: 0;
	    width: 100vw;
	    height: 100vh;
	    background-color: rgba(0, 0, 0, 0.6);
	    justify-content: center;
	    align-items: center;
	}
	
	.labPopup-content {
	    background-color: #2d2d2d;
	    padding: 30px;
	    border-radius: 10px;
	    width: 90%;
	    max-width: 600px;
	    box-shadow: 0 0 10px #000;
	    position: relative;
	}
	
	.labPopup-close {
	    color: #aaa;
	    position: absolute;
	    top: 15px;
	    right: 20px;
	    font-size: 28px;
	    font-weight: bold;
	    cursor: pointer;
	}
	
	.labPopup-close:hover {
	    color: #fff;
	}
	
	.labPopup-wrapper {
	    display: flex;
	    flex-direction: column;
	    align-items: center;
	}
	
	.labPopup-form {
	    width: 100%;
	    display: flex;
	    flex-direction: column;
	    gap: 10px;
	    margin-bottom: 25px;
	}
	
	.labPopup-form label {
	    color: #f0f0f0;
	    font-weight: bold;
	}
	
	.labPopup-form input {
	    padding: 10px;
	    background: #222;
	    border: 1px solid #555;
	    border-radius: 5px;
	    color: #fff;
	}
	
	.labPopup-btn {
	    background-color: #4f4f4f;
	    color: #f0f0f0;
	    padding: 10px 20px;
	    border: 1px solid #444;
	    border-radius: 5px;
	    cursor: pointer;
	    font-family: 'Courier New', Courier, monospace;
	    transition: background-color 0.3s ease, transform 0.2s ease;
	}
	
	.labPopup-btn:hover {
	    background-color: #777;
	    transform: translateY(-2px);
	}
	
	.labPopup-btn:active {
	    background-color: #333;
	    transform: translateY(0);
	}

  </style>
</head>
<body>
	<!-- POPUP MODAL -->
		<div id="labPopup-modal" class="labPopup-modal">
		    <div class="labPopup-content">
		        <span class="labPopup-close" id="labPopup-closeBtn">&times;</span>
		
		        <!-- CONTENIDO -->
		        <div class="labPopup-wrapper">
		
		            <!-- FORMULARIO PARA ENVIAR WRITEUP -->
		            <form class="labPopup-form" action="<%= request.getContextPath() %>/WriteupControlador" method="post">
		                <input type="hidden" name="lab_id" value="<%= labId %>">
		                <input type="hidden" name="user_id" value="<%= usuarioJWT.getUserId() %>">
		                <input type="hidden" name="username" value="<%= usuarioJWT.getUsuario() %>">
		                <label for="url_writeup">Enviar enlace del Writeup:</label>
		                <input type="url" name="url_writeup" id="url_writeup" required>
		                <button class="labPopup-btn" type="submit">Enviar Writeup</button>
		            </form>
		
		            <!-- FORMULARIO PARA INGRESAR FLAG -->
		            <form class="labPopup-form" action="<%= request.getContextPath() %>/validarFlag" method="get">
		                <input type="hidden" name="user_id" value="<%= usuarioJWT.getUserId() %>">
		                <input type="hidden" name="lab_id" value="<%= labId %>">
		                <label for="flag">Ingrese la FLAG:</label>
		                <input type="text" id="flag" name="flag" required>
		                <button class="labPopup-btn" type="submit">Enviar FLAG</button>
		            </form>
		
		        </div>
		    </div>
		</div>
	<!-- Popup para mostrar el mensaje -->
    <div id="popupMessage" class="message-popup">
        <div class="message-popup-header">Mensaje</div>
        <div class="message-popup-content" id="popupContent">
            <p><%= request.getAttribute("mensaje") %></p>
        </div>
        <button class="message-popup-close-btn"><a href="<%= request.getContextPath() %>/labs/separo/separo.jsp" style="text-decoration: none; color: white;">Cerrar</a></button>
    </div>
  <div class="contenedor">
  <header>
    <div class="top-bar">
      <div class="logo">
        <h1><a href="<%= request.getContextPath() %>/home_directory/home.jsp?page=0" style="text-decoration: none; color: #ffd700;">SEPARO</a></h1>
      </div>
      <!-- Botón para abrir el popup -->
		<button id="labPopup-openBtn" class="labPopup-btn">Enviar Writeup / FLAG</button>
		<!-- BOTON PARA VER WRITEUPS -->
    	<a class="btn-dark" href="<%= request.getContextPath() %>/verWriteups?lab_id=<%= labId %>">Ver Writeups</a>
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
	//Popup Botones de Enviar Flag/Enviar Writeup
	const popup = document.getElementById("labPopup-modal");
	const openBtn = document.getElementById("labPopup-openBtn");
	const closeBtn = document.getElementById("labPopup-closeBtn");
	
	openBtn.onclick = () => popup.style.display = "flex";
	closeBtn.onclick = () => popup.style.display = "none";
	window.onclick = (e) => {
	    if (e.target === popup) popup.style.display = "none";
	};
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
