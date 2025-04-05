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
        out.println("<p>Error: Token inválido (" + e.getMessage() + ")</p>");
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
    <style>
    	* {
          font-family: 'JetBrains Mono', monospace;
          /*font-family: 'console', monospace;*/
    	}
        body {
            background-color: #121212;
            color: white;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            background-color: #1e1e1e;
        }
        .logo {
            font-size: 24px;
            font-weight: bold;
        }
        .profile-image {
            width: 40px;
            height: 40px;
        }
        .logo-image {
        	width: 120px;
            height: 50px;
        }
        .profile-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: gray;
        }
        .search-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #2a2a2a;
            padding: 10px;
            border-radius: 25px;
            width: 600px;
            margin: 20px auto;
            border: 1px solid #5f6368;
        }
        .search-input {
            flex: 1;
            background: none;
            border: none;
            color: white;
            font-size: 18px;
            outline: none;
            padding: 5px 10px;
        }
        .search-icons {
            display: flex;
            gap: 15px;
        }
        .search-icons a {
            text-decoration: none;
            cursor: pointer;
            color: #fff;
        }
        .search-icons i {
            color: #bbb;
            font-size: 20px;
            cursor: pointer;
        }
        .search-icons i:hover {
            color: white;
            cursor: pointer;
        }
        .nav-menu {
            display: flex;
            justify-content: center;
            gap: 20px;
            padding: 10px;
            border-bottom: 1px solid #333;
        }
        .nav-menu a {
            color: #ccc;
            text-decoration: none;
            font-size: 14px;
        }
        .nav-menu a:hover {
            color: #8ab4f8;
        }

        /* MENÚ DESPLEGABLE PRINCIPAL */
        .dropdown-menu {
        display: none;
        position: relative; /* Cambiado de absolute a relative */
        width: 100%;
        background-color: #1e1e1e;
        border-top: 1px solid #333;
        padding: 10px 0;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
        z-index: 10;
        text-align: center;
        }

        .nav-container.active .dropdown-menu {
        display: flex;
        justify-content: center;
        gap: 20px;
        text-align: center;
        }

        /* Nueva clase para empujar el contenido hacia abajo cuando el menú está abierto */
        .body-expanded {
            margin-top: 200px; /* Ajusta el valor según sea necesario */
        }
        .dropdown-item {
            position: relative;
            color: #ccc;
            padding: 8px 15px;
            font-size: 14px;
            cursor: pointer;
        }
        .dropdown-item:hover {
            background-color: #333;
            color: white;
        }

        /* SUBMENÚS EN FILA */
        .submenu-container {
        display: flex;
        gap: 10px;
        justify-content: center;
        }

    .submenu {
        display: none;
        position: relative; /* Cambiado de absolute a relative */
        background-color: #262626;
        padding: 10px;
        border-radius: 5px;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
        flex-direction: row; /* Asegura que los elementos estén en fila */
        gap: 10px;
        }

    .submenu a {
        color: #bbb;
        padding: 8px 12px;
        font-size: 13px;
        text-decoration: none;
        }

    .submenu a:hover {
    background-color: #444;
    color: white;
    }

        .results {
            max-width: 800px;
            margin: auto;
            padding: 20px;
        }
        .result-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 20px;
            padding: 10px;
        }
        .result-icon {
            width: 16px;
            height: 16px;
            margin-right: 10px;
        }
        .result-content {
            flex: 1;
        }
        .result-item a {
            color: #8ab4f8;
            text-decoration: none;
            font-size: 18px;
            font-weight: bold;
        }
        .result-item .url {
            color: #8d8d8d;
            font-size: 14px;
            margin-top: 3px;
        }
        .result-item p {
            font-size: 14px;
            color: #ccc;
            margin-top: 5px;
        }
        /* PAGINACIÓN */
        .pagination {
        text-align: center; /* Centra el contenido */
        padding: 20px;
        font-size: 20px;
        }
        .pagination a {
            color: #8ab4f8;
            text-decoration: none;
            margin: 5px;
            font-size: 18px;
            cursor: pointer;
        }
        .pagination a:hover {
            text-decoration: underline;
        }
        .pagination a.active-page {
        text-decoration: underline;
        font-weight: bold;
        color: white;
        }
        .google-logo {
            font-size: 32px;
            font-weight: bold;
            color: white;
            letter-spacing: 2px;
        }
        .google-logo span {
            color: #8ab4f8;
        }

    .next {
    padding: 10px 5px;
    margin: 0 2px;
    background-color: transparent;
    border: none;
    color: #8ab4f8; /* Color azul similar al de un enlace */
    font-size: 16px;
    cursor: pointer;
    text-decoration: none;
    transition: color 0.3s;
}

.next:hover {
    text-decoration: underline; /* Azul más oscuro al pasar el ratón */
}

.next:active {
    color: #8ab4f8; /* El color no cambia al hacer clic */
}
        /* FOOTER */
        .footer {
            background-color: #1e1e1e;
            padding: 15px;
            text-align: center;
            font-size: 14px;
            color: #888;
        }
        .footer a {
            color: #8ab4f8;
            text-decoration: none;
            margin: 0 10px;
        }
        .footer a:hover {
            text-decoration: underline;
        }
    </style>
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
            <a href="#">Imágenes</a>
            <a href="#">Videos</a>
            <a href="#">Noticias</a>
            <a href="#">Maps</a>
            <a href="#" id="more-button">Herramientas<i class="fas fa-plus"></i></a>
        </nav>

        <div class="dropdown-menu" id="dropdown-menu">
            <div class="dropdown-item">
                Tipos <i class="fas fa-chevron-down"></i>
                <div class="submenu-container">
                    <div class="submenu">
                        <a href="#">SQL INJECTION</a>
                        <a href="#">XSS</a>
                        <a href="#">SSRF</a>
                        <a href="#">CSRF</a>
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

            <div class="dropdown-item">
                Recientes <i class="fas fa-chevron-down"></i>
                <div class="submenu-container">
                    <div class="submenu">
                        <a href="#">IDOR</a>
                        <a href="#">XXE</a>
                        <a href="#">RFI</a>
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
        <input type="text" class="search-input" placeholder="Buscar en HackEnd">
        <div class="search-icons">
            <a href="#"><i class="fas fa-times"></i></a><!-- Ícono de limpiar -->
            <a href="#"><i class="fas fa-microphone"></i></a> <!-- Ícono de búsqueda por voz -->
            <a href="#"><i class="fas fa-camera"></i></a> <!-- Ícono de Google Lens -->
        </div>
    </nav>
    <div class="results"></div> <!-- Aquí se inyecta el contenido dinámico -->

<script>
    console.log("Script cargado correctamente");

    document.addEventListener("DOMContentLoaded", function () {
        console.log("DOM completamente cargado");

        const resultsContainer = document.querySelector('.results');
        if (!resultsContainer) {
            console.error("No se encontró el contenedor .results");
            return;
        } else {
            console.log("Contenedor .results encontrado");
        }

        const searchResults = [
            { url: "https://udemy.com", title: "Curso de Pentesting Web", description: "Aprende técnicas de pentesting y explotación de vulnerabilidades web.", image: "../img/udemy.png" },
            { url: "https://hackthebox.com", title: "Hack The Box Web Challenges", description: "Resuelve desafíos reales de hacking web en un entorno seguro.", image: "../img/hackthebox.png" },
            { url: "https://tryhackme.com", title: "Web Hacking en TryHackMe", description: "Plataforma de aprendizaje con laboratorios de hacking web.", image: "../img/tryhackme.png" },
            { url: "https://mozilla.org", title: "Guía de Seguridad Web - Mozilla", description: "Buenas prácticas de desarrollo seguro para aplicaciones web.", image: "../img/mozilla.png" }
        ];

        console.log("Total de resultados:", searchResults.length);

        searchResults.forEach((result, index) => {
            console.log(`Procesando resultado ${index + 1}: ${result.title}`);
            
            const resultItem = document.createElement('div');
            resultItem.classList.add('result-item');

            // Asignar la imagen específica para cada URL
            const favicon = document.createElement('img');
            favicon.src = result.image;  // Ruta específica de la imagen
            favicon.onerror = function () {
                favicon.src = '../img/default.png'; // Imagen por defecto en caso de error
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

            resultContent.appendChild(urlSpan);
            resultContent.appendChild(document.createElement('br'));
            resultContent.appendChild(titleLink);
            resultContent.appendChild(descriptionParagraph);

            resultItem.appendChild(favicon);
            resultItem.appendChild(resultContent);

            resultsContainer.appendChild(resultItem);
        });

        console.log("Todos los resultados fueron agregados al DOM");
    });
</script>

    <!-- PAGINACIÓN -->
    <div class="pagination">
        <div class="google-logo">G<span>o</span><span>o</span><span>o</span><span>o</span><span>o</span><span>o</span>gle</div>
        <a href="home.jsp?token=<%= token %>&page=0" class="page-link">1</a>
        <a href="Page1.jsp?token=<%= token %>&page=1" class="page-link">2</a>
        <a href="Page2.jsp?token=<%= token %>&page=2" class="page-link">3</a>
        <a href="Page3.jsp?token=<%= token %>&page=3" class="page-link">4</a>
        <a href="Page4.jsp?token=<%= token %>&page=4" class="page-link">5</a>
        <button class="next" id="nextPageButton">Siguiente</button>
    </div>

    <script>
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


    <!-- FOOTER -->
    <div class="footer">
        <p>Los resultados están personalizados - <a href="#">Probar sin personalización</a></p>
        <p><a href="#">Ayuda</a> • <a href="#">Enviar comentarios</a> • <a href="#">Privacidad</a> • <a href="#">Términos</a></p>
    </div>

    <script>
             const moreButton = document.getElementById("more-button");
const dropdownMenu = document.getElementById("dropdown-menu");
const navContainer = document.querySelector(".nav-container");
const dropdownItems = document.querySelectorAll(".dropdown-item");
const body = document.body; // Selecciona el cuerpo del documento

// Mostrar / ocultar menú principal con clic y hacer espacio en el diseño
moreButton.addEventListener("click", function(event) {
    event.preventDefault();
    const isActive = navContainer.classList.toggle("active");
    dropdownMenu.style.display = isActive ? "flex" : "none";
    
    // Agregar o quitar la clase .body-expande al body
    if (isActive) {
        body.classList.add("body-expande");
    } else {
        body.classList.remove("body-expande");
    }
});

// Mostrar / ocultar submenús dentro del menú desplegable al hacer clic
dropdownItems.forEach(item => {
    item.addEventListener("click", function(event) {
        event.stopPropagation(); // Evita que el evento se propague al padre
        const submenu = this.querySelector(".submenu");
        if (submenu) {
            submenu.style.display = submenu.style.display === "flex" ? "none" : "flex";
        }
    });
});
    </script>

</body>
</html>