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
        out.println("<p>Error: Token inv√°lido (" + e.getMessage() + ")</p>");
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
            <a href="#">Im√°genes</a>
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
                        <a href="#">Ping√ºino de Mario</a>
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
            <a href="#"><i class="fas fa-times"></i></a><!-- √çcono de limpiar -->
            <a href="#"><i class="fas fa-microphone"></i></a> <!-- √çcono de b√∫squeda por voz -->
            <a href="#"><i class="fas fa-camera"></i></a> <!-- √çcono de Google Lens -->
        </div>
    </nav>
    <div class="results"></div> <!-- Aqu√≠ se inyecta el contenido din√°mico -->

    <!-- PAGINACI√ìN -->
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
        <p>Los resultados est√°n personalizados - <a href="#">Probar sin personalizaci√≥n</a></p>
        <p><a href="#">Ayuda</a> ‚Ä¢ <a href="#">Enviar comentarios</a> ‚Ä¢ <a href="#">Privacidad</a> ‚Ä¢ <a href="#">T√©rminos</a></p>
    </div>

    <script>
	// FunciÛn para obtener el identificador de la p·gina actual desde la URL
	function getPageIdentifier() {
		const urlParams = new URLSearchParams(window.location.search);
		const pageParam = urlParams.get('page');
		// Si no existe el par·metro 'page', asumimos que estamos en home.jsp y comenzamos desde la p·gina 1
		return pageParam ? parseInt(pageParam) : 'home';
	}

	// FunciÛn para actualizar el estilo del n˙mero de p·gina activo
	function highlightCurrentPage() {
		const currentPage = getPageIdentifier();
		const pageLinks = document.querySelectorAll(".pagination a");

		// Resaltar el n˙mero de p·gina activo con subrayado
		pageLinks.forEach(link => {
			if (parseInt(link.textContent) === currentPage) {
				link.classList.add("active-page"); // AÒade la clase de subrayado
			} else {
				link.classList.remove("active-page");
			}
		});

		// Cambiar solo la letra "O" correspondiente a la p·gina activa
		const logoSpans = document.querySelectorAll(".google-logo span");
		logoSpans.forEach((span, index) => {
			if (index + 1 === currentPage) {
				span.classList.add("active");
			} else {
				span.classList.remove("active");
			}
		});
	}

	// FunciÛn para redirigir a la siguiente p·gina
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

	// Llamar a la funciÛn al cargar la p·gina para resaltar la letra correspondiente
	document.addEventListener("DOMContentLoaded", function() {
		highlightCurrentPage();

		// AÒadir un manejador de eventos para el botÛn "Siguiente"
		document.getElementById("nextPageButton").addEventListener("click", nextPage);
	});
	</script>
	<script src="../js/home.js"></script>

</body>
</html>