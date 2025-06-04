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
	
	// Obtener el lab_id de "Separo" desde la base de datos
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
  <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/vistas/img/icono/icono_cinco_hackend.ico">
  <title>SEPARO LAB</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/vistas/css/cssSeparo.jsp">
  <link href="https://fonts.googleapis.com/css2?family=Share+Tech+Mono&display=swap" rel="stylesheet">
</head>
<body>

<header>
  <div class="header-left">
    <h1 class="typewriter" data-text="SEPARO LAB"></h1>
  </div>
  <div class="window-buttons">
    <button class="minimize">🗕</button>
    <button class="maximize">🗖</button>
    <button onclick="window.location.href='<%= request.getContextPath() %>/vistas/home_directory/home.jsp'" class="close">✖</button>
  </div>
</header>

<main>
	<!-- Popup para mostrar el mensaje -->
    <div id="popupMessage" class="message-popup">
        <div class="message-popup-header">Mensaje</div>
        <div class="message-popup-content" id="popupContent">
            <p><%= request.getAttribute("mensaje") %></p>
        </div>
        <button class="message-popup-close-btn"><a href="<%= request.getContextPath() %>/vistas/labs/separo/separo-lab.jsp" style="text-decoration: none; color: white;">Cerrar</a></button>
    </div>
    <br>
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

  <!-- INTRO -->
  <section class="lab-intro">
    <div class="lab-img">
      <img src="<%= request.getContextPath() %>/vistas/img/logo-test-3-update.png" alt="Máquina CTF">
    </div>
    <div class="lab-info">
      <h2 class="typewriter" data-text="SEPARO LAB: HACKING WEB"></h2>
      <p><strong>Autor:</strong> D1se0</p>
      <p><strong>Descripción:</strong> Estas cansado de buscar empleo, en Separo encontraras lo que quieras al lado de tu casa, aprende a realizar un Open Redirect.</p>
      <p><strong>Fecha de creación:</strong> 09/04/2025</p>
      <button class="nivel-btn">Facil</button>
    </div>
  </section>
  
  <!-- TECNICAS -->
  <section class="lab-tecnica">
    <h3 class="tecnica-titulo">Técnicas Utilizadas</h3>
    <ul class="tecnica-grid">
      <li>🔍 Escaneo de Puertos</li>
      <li>🔄 Open Redirect</li>
      <li>🖥️ WEB</li>
      <li>📜 Fuzzing</li>
      <li>🔓 Bypass</li>
    </ul>
  </section>

  <!-- CERTIFICACIONES -->
  <section class="lab-certificados">
    <h3 class="certificados-titulo">Certificaciones Adecuadas</h3>

    <div class="certificado-item">
      <img src="<%= request.getContextPath() %>/vistas/img/img_dockerpwned/eJPT.png" alt="eJPT" width="50px" height="65px">
      <p>eJPT - Junior Penetration Tester por eLearnSecurity</p>
    </div>

    <div class="certificado-item">
      <img src="<%= request.getContextPath() %>/vistas/img/img_dockerpwned/eCPTX.png" alt="eCPTX" width="60px" height="50px">
      <p>eCPTX - Experto en Pentesting Avanzado por eLearnSecurity</p>
    </div>
  </section>
  
  <!-- BOTONES -->
  <div class="botones">
	  <button id="labPopup-openBtn" data-text="Enviar Writeup / FLAG">ㅤㅤㅤㅤㅤ</button>
	  <!--<button data-text="Enviar Writeups">ㅤㅤㅤㅤㅤㅤ</button>-->
	  <button data-text="Ver Writeups"><a href="<%= request.getContextPath() %>/verWriteups?lab_id=<%= labId %>">ㅤㅤㅤㅤㅤㅤ</a></button>
	
	  <div class="submenu-container">
	    <button class="window-btn" data-text="Social">ㅤㅤ</button>
	    <div class="submenu-rrss">
	      <a href="https://github.com/D1seo" target="_blank">GitHub D1seo</a>
	      <a href="https://github.com/Manu" target="_blank">GitHub Manu</a>
	    </div>
	  </div>
	</div>
  
  <!-- DOWNLOAD -->
  <section class="download-section">
  	<h3>============================LABORATORIO============================</h3>
  	<br><br>
    <button class="download-btn" onclick="window.location.href='<%= request.getContextPath() %>/vistas/labs/separo/separo.jsp'">⬇️ Ir a Separo (LAB)</button>
    <br><br>
    <h3>===================================================================</h3>
  </section>

</main>

<footer>
  <p>© 2025 SEPARO Labs. Todos los derechos reservados.</p>
</footer>

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
        window.location.href = "<%= request.getContextPath() %>/labs/separo/separo-lab.jsp"; // Redirigimos
    }

    // Si el mensaje no es nulo, mostramos el popup con el mensaje
    <%
        if (resultadoFlag != null) { 
    %>
        showPopup("<%= resultadoFlag %>"); // Mostrar el mensaje en el popup
    <% 
        }
    %>
    
  const btnRRSS = document.querySelector('.submenu-container .window-btn');
  const submenuRRSS = document.querySelector('.submenu-rrss');

  btnRRSS.addEventListener('click', () => {
    submenuRRSS.style.display = submenuRRSS.style.display === 'block' ? 'none' : 'block';
  });
  
  document.addEventListener("DOMContentLoaded", () => {
	    const elements = document.querySelectorAll(".typewriter");

	    elements.forEach((el) => {
	      const text = el.getAttribute("data-text");
	      let index = 0;

	      const cursorSpan = document.createElement("span");
	      cursorSpan.className = "typewriter-cursor";
	      el.appendChild(cursorSpan);

	      const type = () => {
	        if (index < text.length) {
	          el.insertBefore(document.createTextNode(text.charAt(index)), cursorSpan);
	          index++;
	          setTimeout(type, 70); // velocidad de escritura
	        }
	      };

	      type();
	    });
	  });
</script>

</body>
</html>
