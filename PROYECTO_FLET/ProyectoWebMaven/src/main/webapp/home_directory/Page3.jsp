<%@ page import="com.auth0.jwt.JWT" %>
<%@ page import="com.auth0.jwt.algorithms.Algorithm" %>
<%@ page import="com.auth0.jwt.interfaces.DecodedJWT" %>
<%@ page import="com.auth0.jwt.interfaces.JWTVerifier" %>
<%@ page import="com.auth0.jwt.exceptions.JWTVerificationException" %>
<%@ page import="io.jsonwebtoken.Claims" %>
<%@ page import="io.jsonwebtoken.Jwts" %>
<%@ page import="io.jsonwebtoken.ExpiredJwtException" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    String token = request.getParameter("token");

    if (token == null || token.isEmpty()) {
        out.println("<p>Error: Token no proporcionado.</p>");
        return;
    }

    String SECRET_KEY = "clave_super_secreta";

    String nombre = "";
    String apellidos = "";
    String rol = "";
    String email = "";
    String ultimoLogin = "";
    String usuario = "";
    String cookie = "";

    try {
        Claims claims = Jwts.parser()
            .setSigningKey(SECRET_KEY.getBytes(StandardCharsets.UTF_8))
            .parseClaimsJws(token)
            .getBody();

        nombre = (String) claims.get("nombre");
        apellidos = (String) claims.get("apellidos");
        rol = (String) claims.get("rol");
        email = (String) claims.get("email");
        ultimoLogin = (String) claims.get("ultimo_login");
        usuario = (String) claims.get("usuario");
        cookie = (String) claims.get("cookie");

    } catch (ExpiredJwtException e) {
        out.println("<p>Error: El token ha expirado.</p>");
        return;
    } catch (Exception e) {
        out.println("<p>Error: Token invÃ¡lido (" + e.getMessage() + ")</p>");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buscador Web</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/js/all.min.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="../css/home.css">
</head>
<body>

    <header class="header">
        <!--<div class="profile-icon"></div>-->
        <a href="../profile.jsp?token=<%= token %>">
	  <img src="../img/Profile.png" class="profile-image" alt="Imagen Usuario">
	   </a>
	   <img src="../img/hackendLogoUpdateTransparent.png" class="logo-image" alt="Imagen Logo">
       <!--<div class="logo">Google</div>-->
    </header>

    <div class="nav-container">
        <nav class="nav-menu">
            <a href="#">Todo</a>
            <a href="#">Imagenes</a>
            <a href="#">Videos</a>
            <a href="#">Noticias</a>
            <a href="#">Maps</a>
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
		                <a href="#">Pingüino de Mario</a>
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
    <div class="results"></div> <!-- AquÃ­ se inyecta el contenido dinÃ¡mico -->

    <!-- PAGINACIÃN -->
    <div class="pagination">
        <div class="google-logo">G<span>o</span><span>o</span><span>o</span><span>o</span><span>o</span><span>o</span>gle</div>
        <a href="home.jsp?token=<%= token %>&page=0" class="page-link">1</a>
        <a href="Page1.jsp?token=<%= token %>&page=1" class="page-link">2</a>
        <a href="Page2.jsp?token=<%= token %>&page=2" class="page-link">3</a>
        <a href="Page3.jsp?token=<%= token %>&page=3" class="page-link">4</a>
        <a href="Page4.jsp?token=<%= token %>&page=4" class="page-link">5</a>
        <button class="next" id="nextPageButton">Siguiente</button>
    </div>

    <!-- FOOTER -->
    <div class="footer">
        <p>Los resultados estÃ¡n personalizados - <a href="#">Probar sin personalizaciÃ³n</a></p>
        <p><a href="#">Ayuda</a> â¢ <a href="#">Enviar comentarios</a> â¢ <a href="#">Privacidad</a> â¢ <a href="#">TÃ©rminos</a></p>
    </div>

    <script>
 // ⬇️ Definimos estos dos globalmente para que estén disponibles en todo el script
	const resultsContainer = document.querySelector('.results');
	const searchResults = [
		{ url: "http://xss.com", title: "Curso de Hacking Web", description: "Conoce las bases del hacking web, los principales ataques y cómo prevenirlos.", image: "../img/xss.png", tags: ["xss", "web", "seguridad"] },
		{ url: "http://sqlinjection.com", title: "Curso Advanced Web Hacking", description: "Curso de nivel avanzado con laboratorios de hacking y vulnerabilidades reales.", image: "../img/sqlinjection.png", tags: ["sql", "inyeccion", "hacking"] },
		{ url: "http://csrf.com", title: "Hacking Web Technologies 3ª Silver Edition", description: "Libro sobre fuzzing en aplicaciones web y detección de vulnerabilidades.", image: "../img/csrf.png", tags: ["csrf", "fuzzing", "libro"] },
		{ url: "http://bac.com", title: "Pack Hacking Web", description: "Formación avanzada en hacking contra API REST y aplicaciones web.", image: "../img/bac.png", tags: ["api", "rest", "web"] }
	];

	document.addEventListener("DOMContentLoaded", function () {
	    console.log("DOM completamente cargado");

	    if (!resultsContainer) {
	        console.error("No se encontró el contenedor .results");
	        return;
	    } else {
	        console.log("Contenedor .results encontrado");
	    }

	    console.log("Total de resultados:", searchResults.length);

	    searchResults.forEach((result, index) => {
	        console.log(`Procesando resultado ${index + 1}: ${result.title}`);

	        const resultItem = document.createElement('div');
	        resultItem.classList.add('result-item');

	        const favicon = document.createElement('img');
	        favicon.src = result.image;
	        favicon.onerror = function () {
	            favicon.src = '../img/default.png';
	        };
	        favicon.alt = "favicon";
	        favicon.classList.add('result-icon');

	        const resultContent = document.createElement('div');
	        resultContent.classList.add('result-content');

	        const urlSpan = document.createElement('span');
	        urlSpan.classList.add('url');
	        urlSpan.textContent = result.url;

	        const titleLink = document.createElement('a');
	        titleLink.href = result.url;
	        titleLink.target = "_blank";
	        titleLink.textContent = result.title;

	        const descriptionParagraph = document.createElement('p');
	        descriptionParagraph.textContent = result.description;

	        // Crear contenedor de tags debajo de la descripción
	        const tagsContainer = document.createElement('div');
	        tagsContainer.classList.add('tags');
	        
	        result.tags.forEach(tag => {
	            const tagSpan = document.createElement('span');
	            tagSpan.classList.add('tag');
	            tagSpan.textContent = `#${tag}`;
	            tagsContainer.appendChild(tagSpan);
	        });

	        // Añadir todos los elementos
	        resultContent.appendChild(urlSpan);
	        resultContent.appendChild(document.createElement('br'));
	        resultContent.appendChild(titleLink);
	        resultContent.appendChild(descriptionParagraph);
	        resultContent.appendChild(tagsContainer); // Los tags se colocan al final (debajo de la descripción)

	        resultItem.appendChild(favicon);
	        resultItem.appendChild(resultContent);

	        resultsContainer.appendChild(resultItem);
	        
	        searchInput.value = "";
	        searchInput.dispatchEvent(new Event("input"));
	    });

	    console.log("Todos los resultados fueron agregados al DOM");
	});

	
	// Función para obtener el identificador de la página actual desde la URL
	function getPageIdentifier() {
		const urlParams = new URLSearchParams(window.location.search);
		const pageParam = urlParams.get('page');
		// Si no existe el parámetro 'page', asumimos que estamos en home.jsp y comenzamos desde la página 1
		return pageParam ? parseInt(pageParam) : 'home';
	}

	// Función para actualizar el estilo del número de página activo
	function highlightCurrentPage() {
		const currentPage = getPageIdentifier();
		const pageLinks = document.querySelectorAll(".pagination a");

		// Resaltar el número de página activo con subrayado
		pageLinks.forEach(link => {
			if (parseInt(link.textContent) === currentPage) {
				link.classList.add("active-page"); // Añade la clase de subrayado
			} else {
				link.classList.remove("active-page");
			}
		});

		// Cambiar solo la letra "O" correspondiente a la página activa
		const logoSpans = document.querySelectorAll(".google-logo span");
		logoSpans.forEach((span, index) => {
			if (index + 1 === currentPage) {
				span.classList.add("active");
			} else {
				span.classList.remove("active");
			}
		});
	}

	// Función para redirigir a la siguiente página
	function nextPage() {
		const currentPage = getPageIdentifier();
		let nextPageNumber;

		// Si estamos en home.jsp, redirige a Page1.jsp
		if (currentPage === 0) {
			nextPageNumber = 1;
			window.location.href = `Page1.jsp?token=<%= token %>&page=1`;
		}
		// Si estamos en Page1.jsp, redirige a Page2.jsp
		else if (currentPage === 1) {
			nextPageNumber = 2;
			window.location.href = `Page2.jsp?token=<%= token %>&page=2`;
		}
		// Si estamos en Page2.jsp, redirige a Page3.jsp
		else if (currentPage === 2) {
			nextPageNumber = 3;
			window.location.href = `Page3.jsp?token=<%= token %>&page=3`;
		}
		// Si estamos en Page3.jsp, redirige a Page4.jsp
		else if (currentPage === 3) {
			nextPageNumber = 4;
			window.location.href = `Page4.jsp?token=<%= token %>&page=4`;
		}
		// Si estamos en Page4.jsp, redirige a home.jsp
		else if (currentPage === 4) {
			window.location.href = `home.jsp?token=<%= token %>&page=0`;
		}
	}

	// Llamar a la función al cargar la página para resaltar la letra correspondiente
	document.addEventListener("DOMContentLoaded", function() {
		highlightCurrentPage();

		// Añadir un manejador de eventos para el botón "Siguiente"
		document.getElementById("nextPageButton").addEventListener("click", nextPage);
	});
	</script>
	<script src="../js/home.js"></script>

</body>
</html>