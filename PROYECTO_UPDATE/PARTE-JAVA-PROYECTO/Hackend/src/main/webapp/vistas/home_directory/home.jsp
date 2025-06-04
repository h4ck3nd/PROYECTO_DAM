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
        photoPath = "vistas/img/Profile.png";  // Ruta de la imagen por defecto
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/vistas/img/icono/icono_cinco_hackend.ico">
    <title>HACKEND</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/js/all.min.js" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/vistas/css/cssHome.jsp">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/vistas/css/dynamicFonts.jsp" />
</head>
<body>
    <header class="header">
        <a href="<%= request.getContextPath() %>/vistas/profile.jsp">
	  <img src="<%= request.getContextPath() %>/<%= photoPath %>" alt="Foto de perfil" class="profile-image-update">
	   </a>
	   <!-- Validar que el usuario tenga el ROL "designer" -->
		<% if ("designer".equalsIgnoreCase(usuarioJWT.getRol())) { %>
		    <div style="text-align: center;">
		        <a href="<%= request.getContextPath() %>/vistas/designer/admin-panel.jsp" class="designer-button">Ir al Panel</a>
		    </div>
		
		    <style>
		        .designer-button {
		            background-color: #4f4f4f;
		            color: #f0f0f0;
		            font-family: 'Courier New', Courier, monospace;
		            padding: 5px 10px;
		            margin-top: 0px;
		            border: 1px solid #444;
		            border-radius: 5px;
		            font-size: 1em;
		            text-decoration: none;
		            display: inline-block;
		            font-weight: bold;
		            transition: background-color 0.3s ease, transform 0.2s ease;
		        }
		
		        .designer-button:hover {
		            background-color: #777;
		            transform: translateY(-2px);
		        }
		
		        .designer-button:active {
		            background-color: #333;
		            transform: translateY(0);
		        }
		    </style>
		<% } %>
	   <img src="<%= request.getContextPath() %>/vistas/img/hackendLogoUpdate.png" class="logo-image" alt="Imagen Logo">
       <!--<div class="logo">Google</div>-->
    </header>

    <div class="nav-container">
        <nav class="nav-menu">
            <a href="home.jsp"><img src="<%= request.getContextPath() %>/vistas/img/logo-test-6-update.png" class="img-hackend" width="22px" height="22px"> Hackend</a>
            <a href="<%= request.getContextPath() %>/vistas/ranking.jsp"><img src="<%= request.getContextPath() %>/vistas/img/ranking-logo.png" class="img-ranking" width="20px" height="20px"> Ranking</a>
            <a href="https://dise0.gitbook.io/h4cker_b00k/proyecto-dam/documentacion-proyecto_dam"><img src="<%= request.getContextPath() %>/vistas/img/document.png" class="img-document" width="20px" height="20px"> Documentación</a>
            <a href="#" id="more-button">Herramientas<i class="fas fa-plus"></i></a>
        </nav>

        <div class="dropdown-menu" id="dropdown-menu">
		    <div class="dropdown-item" id="types-dropdown">
		        Tipos <i class="fas fa-chevron-down"></i>
		        <div class="submenu-container">
		            <div class="submenu">
		                <a href="#" class="filter-item " data-filter-type="tipo" data-filter-value="xss">XSS</a>
		                <a href="#" class="filter-item " data-filter-type="tipo" data-filter-value="sql">SQL INJECTION</a>
		                <a href="#" class="filter-item " data-filter-type="tipo" data-filter-value="bac">BAC</a>
		                <a href="#" class="filter-item " data-filter-type="tipo" data-filter-value="csrf">CSRF</a>
		            </div>
		        </div>
		    </div>
		
		    <div class="dropdown-item">
		        Dificultad <i class="fas fa-chevron-down"></i>
		        <div class="submenu-container">
		            <div class="submenu">
		                <a href="#">Facil</a>
		                <a href="#">Media</a>
		                <a href="#">Dificil</a>
		            </div>
		        </div>
		    </div>
		
		    <div class="dropdown-item" id="tags-dropdown">
		        TAGS <i class="fas fa-chevron-down"></i>
		        <div class="submenu-container">
		            <div class="submenu">
		                <a href="#" class="filter-item " data-filter-type="tag" data-filter-value="ddbb">DDBB</a>
		                <a href="#" class="filter-item " data-filter-type="tag" data-filter-value="html">HTML</a>
		                <a href="#" class="filter-item " data-filter-type="tag" data-filter-value="xml">XML</a>
		                <a href="#" class="filter-item " data-filter-type="tag" data-filter-value="url">URL</a>
		                <a href="#" class="filter-item " data-filter-type="tag" data-filter-value="seguridad">SEGURIDAD</a>
		                <a href="#" class="filter-item " data-filter-type="tag" data-filter-value="web">WEB</a>
		            </div>
		        </div>
		    </div>
		
		    <div class="dropdown-item">
		        Creadores <i class="fas fa-chevron-down"></i>
		        <div class="submenu-container">
		            <div class="submenu">
		                <a href="#">Pinguino de Mario</a>
		                <a href="#">S4vitar</a>
		                <a href="#">D1se0</a>
		            </div>
		        </div>
		    </div>
		</div>
    </div>
    <nav class="search-bar">
	    <input type="text" class="search-input" id="liveSearch" placeholder="Buscar en HackEnd">
	    <div class="search-icons">
	        <a href="#" id="clearSearch"><i class="fas fa-times"></i></a>
	        <a href="#"><i class="fas fa-microphone"></i></a>
	        <a href="#"><i class="fas fa-camera"></i></a>
	    </div>
	</nav>
    <div class="results"></div> <!-- AquÃÂ­ se inyecta el contenido dinÃÂ¡mico -->

    <!-- PAGINACIÃâN -->
    <div class="pagination">
        <div class="google-logo">H<span>a</span><span>a</span><span>a</span><span>a</span><span>a</span><span>a</span>ckend</div>
        <a href="home.jsp?page=0" class="page-link style-link-number">1</a>
        <button class="next" id="nextPageButton">Siguiente</button>
    </div>

    <!-- FOOTER -->
	<footer class="footer">
	  <div class="footer-top">
	    <p>Todos los derechos reservados d1se0 y m4nu</p>
	  </div>
	  <div class="footer-bottom">
	    <a href="#">Ayuda</a>
	    <a href="#">Enviar comentarios</a>
	    <a href="#">Privacidad</a>
	    <a href="#">Terminos</a>
	  </div>
	</footer>
	
	<!-- SCRIPTS GENERALES -->
	
	<script>
	window.onload = function() {
	    const links = document.querySelectorAll("a[target='_blank']");
	    links.forEach(link => {
	      link.setAttribute("target", "_self");
	    });
	  };
	  
	// Ã¢Â¬â¡Ã¯Â¸Â Definimos estos dos globalmente para que estÃÂ©n disponibles en todo el script
	const resultsContainer = document.querySelector('.results');
	const searchResults = [
	    { url: "../labs/foro-xss-lab.jsp", title: "Foro Cross", description: "Conoce a gente nueva en este foro tan espectacular.", image: "../img/logo-test-2-update.png", tags: ["xss", "web", "seguridad", "hacking", "facil", "d1se0"] },
	    { url: "../labs/separo/separo-lab.jsp", title: "SEPARO Web", description: "Ahora buscar empleo es mucho mas facil.", image: "../img/logo-test-3-update.png", tags: ["idor", "web", "bypass", "hacking", "medio", "d1se0"] }
	];

	document.addEventListener("DOMContentLoaded", function () {
	    console.log("DOM completamente cargado");

	    if (!resultsContainer) {
	        console.error("No se encontrÃÂ³ el contenedor .results");
	        return;
	    } else {
	        console.log("Contenedor .results encontrado");
	    }

	    searchResults.forEach((result, index) => {
	        console.log(`Procesando resultado ${index + 1}: ${result.title}`);

	        const resultItem = document.createElement('div');
	        resultItem.classList.add('result-item');

	        const favicon = document.createElement('img');
	        favicon.src = result.image;
	        favicon.onerror = function () {
	            favicon.src = '../img/default-error.png';
	        };

	    });
	});

	
	</script>
	<script src="<%= request.getContextPath() %>/vistas/js/home.js"></script>
	
</body>
</html>