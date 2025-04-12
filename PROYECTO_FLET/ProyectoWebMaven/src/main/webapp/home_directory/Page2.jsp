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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buscador Web</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/js/all.min.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/home.css">
    <style>
		.logo-image {
		  width: 125px;
		  height: 50px;
		  position: relative;
		  top: -10px; /* Ajusta el valor segÃºn sea necesario */
		}
		.profile-image-update {
			width: 40px;
			height: 40px;
			border-radius: 30px;
		}
		.result-icon {
		  width: 25px; /* o el tamaño que quieras */
		  height: 25px;
		  object-fit: contain; /* evita que se deforme */
		  margin-right: 10px; /* opcional, para separación del texto */
		}
		.img-hackend {
		  object-fit: contain;
  		  vertical-align: middle;
		}
		.img-dockerpwned {
		  object-fit: contain;
  		  vertical-align: middle;
		}
		.img-ovalabs {
		  object-fit: contain;
  		  vertical-align: middle;
		}
		.results {
			max-width: 800px;
			margin: auto;
			padding: 20px;
			transform: translateX(150px); /* Mueve el contenido 20px hacia la derecha */
		}
		.style-letters-hackend {
			color: #00ffff !important;
		}
		.style-link-number {
			color: white !important;
			text-decoration: underline !important;
			font-weight: bold !important;
		}
	</style>
</head>
<body>

    <header class="header">
        <!--<div class="profile-icon"></div>-->
        <a href="<%= request.getContextPath() %>/profile.jsp">
	  <img src="<%= request.getContextPath() %>/<%= photoPath %>" alt="Foto de perfil" class="profile-image-update">
	   </a>
	   <img src="<%= request.getContextPath() %>/img/hackendLogoUpdate.png" class="logo-image" alt="Imagen Logo">
       <!--<div class="logo">Google</div>-->
    </header>

    <div class="nav-container">
        <nav class="nav-menu">
            <a href="home.jsp?page=0"><img src="../img/logo_hackend.png" class="img-hackend" width="20px" height="20px"> Hackend</a>
            <a href="dockerpwned.jsp?page=0"><img src="../img/dockerpwned.png" class="img-dockerpwned" width="25px" height="15px"> DockerPwned</a>
            <a href="ovalabs.jsp?page=0"><img src="../img/ovalabs.png" class="img-ovalabs" width="20px" height="20px"> OVAlabs</a>
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
    <div class="results"></div> <!-- AquÃ­ se inyecta el contenido dinÃ¡mico -->

   <!-- PAGINACIÃ“N -->
    <div class="pagination">
        <div class="google-logo">H<span>a</span><span class="style-letters-hackend">a</span><span>a</span><span>a</span><span>a</span><span>a</span>ckend</div>
        <a href="home.jsp?page=0" class="page-link">1</a>
        <a href="Page1.jsp?page=1" class="page-link">2</a>
        <a href="Page2.jsp?page=2" class="page-link style-link-number">3</a>
        <a href="Page3.jsp?page=3" class="page-link">4</a>
        <a href="Page4.jsp?page=4" class="page-link">5</a>
        <button class="next" id="nextPageButton">Siguiente</button>
    </div>

    <!-- FOOTER -->
	<footer class="footer">
	  <div class="footer-top">
	    <p>Todos los derechos reservados <a href="#">d1se0 y m4nu</a></p>
	  </div>
	  <div class="footer-bottom">
	    <a href="#">Ayuda</a>
	    <a href="#">Enviar comentarios</a>
	    <a href="#">Privacidad</a>
	    <a href="#">Terminos</a>
	  </div>
	</footer>
	
	<script>
	window.onload = function() {
	    const links = document.querySelectorAll("a[target='_blank']");
	    links.forEach(link => {
	      link.setAttribute("target", "_self");
	    });
	  };
	  
	// â¬‡ï¸ Definimos estos dos globalmente para que estÃ©n disponibles en todo el script
	const resultsContainer = document.querySelector('.results');
	const searchResults = [
	    { url: "../labs/none.jsp", title: "CONSTRUCCION... \u{1F6A7}", description: "Pagina en construccion...", image: "../img/default-error.png", tags: ["construccion"] },
	    { url: "../labs/none.jsp", title: "CONSTRUCCION... \u{1F6A7}", description: "Pagina en construccion...", image: "../img/default-error.png", tags: ["construccion"] },
	    { url: "../labs/none.jsp", title: "CONSTRUCCION... \u{1F6A7}", description: "Pagina en construccion...", image: "../img/default-error.png", tags: ["construccion"] },
	    { url: "../labs/none.jsp", title: "CONSTRUCCION... \u{1F6A7}", description: "Pagina en construccion...", image: "../img/default-error.png", tags: ["construccion"] },
	    { url: "../labs/none.jsp", title: "CONSTRUCCION... \u{1F6A7}", description: "Pagina en construccion...", image: "../img/default-error.png", tags: ["construccion"] },
	    { url: "../labs/none.jsp", title: "CONSTRUCCION... \u{1F6A7}", description: "Pagina en construccion...", image: "../img/default-error.png", tags: ["construccion"] },
	    { url: "../labs/none.jsp", title: "CONSTRUCCION... \u{1F6A7}", description: "Pagina en construccion...", image: "../img/default-error.png", tags: ["construccion"] },
	    { url: "../labs/none.jsp", title: "CONSTRUCCION... \u{1F6A7}", description: "Pagina en construccion...", image: "../img/default-error.png", tags: ["construccion"] }
	];

	document.addEventListener("DOMContentLoaded", function () {
	    console.log("DOM completamente cargado");

	    if (!resultsContainer) {
	        console.error("No se encontrÃ³ el contenedor .results");
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

	        // Crear contenedor de tags debajo de la descripciÃ³n
	        const tagsContainer = document.createElement('div');
	        tagsContainer.classList.add('tags');
	        
	        result.tags.forEach(tag => {
	            const tagSpan = document.createElement('span');
	            tagSpan.classList.add('tag');
	            tagSpan.textContent = `#${tag}`;
	            tagsContainer.appendChild(tagSpan);
	        });

	        // AÃ±adir todos los elementos
	        resultContent.appendChild(urlSpan);
	        resultContent.appendChild(document.createElement('br'));
	        resultContent.appendChild(titleLink);
	        resultContent.appendChild(descriptionParagraph);
	        resultContent.appendChild(tagsContainer); // Los tags se colocan al final (debajo de la descripciÃ³n)

	        resultItem.appendChild(favicon);
	        resultItem.appendChild(resultContent);

	        resultsContainer.appendChild(resultItem);
	        
	        searchInput.value = "";
	        searchInput.dispatchEvent(new Event("input"));
	    });

	    console.log("Todos los resultados fueron agregados al DOM");
	});

	// FunciÃ³n para obtener el identificador de la pÃ¡gina actual desde la URL
	function getPageIdentifier() {
		const urlParams = new URLSearchParams(window.location.search);
		const pageParam = urlParams.get('page');
		// Si no existe el parÃ¡metro 'page', asumimos que estamos en home.jsp y comenzamos desde la pÃ¡gina 1
		return pageParam ? parseInt(pageParam) : 'home';
	}

	// FunciÃ³n para actualizar el estilo del nÃºmero de pÃ¡gina activo
	function highlightCurrentPage() {
		const currentPage = getPageIdentifier();
		const pageLinks = document.querySelectorAll(".pagination a");

		// Resaltar el nÃºmero de pÃ¡gina activo con subrayado
		pageLinks.forEach(link => {
			if (parseInt(link.textContent) === currentPage) {
				link.classList.add("active-page"); // AÃ±ade la clase de subrayado
			} else {
				link.classList.remove("active-page");
			}
		});

		// Cambiar solo la letra "O" correspondiente a la pÃ¡gina activa
		const logoSpans = document.querySelectorAll(".google-logo span");
		logoSpans.forEach((span, index) => {
			if (index + 1 === currentPage) {
				span.classList.add("active");
			} else {
				span.classList.remove("active");
			}
		});
	}

	// FunciÃ³n para redirigir a la siguiente pÃ¡gina
	function nextPage() {
		const currentPage = getPageIdentifier();
		let nextPageNumber;

		// Si estamos en home.jsp, redirige a Page1.jsp
		if (currentPage === 0) {
			nextPageNumber = 1;
			window.location.href = `Page1.jsp?page=1`;
		}
		// Si estamos en Page1.jsp, redirige a Page2.jsp
		else if (currentPage === 1) {
			nextPageNumber = 2;
			window.location.href = `Page2.jsp?page=2`;
		}
		// Si estamos en Page2.jsp, redirige a Page3.jsp
		else if (currentPage === 2) {
			nextPageNumber = 3;
			window.location.href = `Page3.jsp?page=3`;
		}
		// Si estamos en Page3.jsp, redirige a Page4.jsp
		else if (currentPage === 3) {
			nextPageNumber = 4;
			window.location.href = `Page4.jsp?page=4`;
		}
		// Si estamos en Page4.jsp, redirige a home.jsp
		else if (currentPage === 4) {
			window.location.href = `home.jsp?page=0`;
		}
	}

	// Llamar a la funciÃ³n al cargar la pÃ¡gina para resaltar la letra correspondiente
	document.addEventListener("DOMContentLoaded", function() {
		highlightCurrentPage();

		// AÃ±adir un manejador de eventos para el botÃ³n "Siguiente"
		document.getElementById("nextPageButton").addEventListener("click", nextPage);
	});
	</script>
	<script src="<%= request.getContextPath() %>/js/home.js"></script>

</body>
</html>