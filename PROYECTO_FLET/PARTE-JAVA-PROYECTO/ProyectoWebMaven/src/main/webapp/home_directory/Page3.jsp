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
        photoPath = "img/Profile.png";  // Ruta de la imagen por defecto
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/img/icono/icono_cinco_hackend.ico">
    <title>HACKEND</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/js/all.min.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/home.css">
    <link href="https://fonts.googleapis.com/css2?family=VT323&display=swap" rel="stylesheet">
    <style>
    * {
			font-family: 'VT323', monospace !important;
			font-size: 18px !important;
		}
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
		.img-ranking {
		  object-fit: contain;
  		  vertical-align: middle;
		}
		.img-document {
		  object-fit: contain;
  		  vertical-align: middle;
		}
		.img-timelabs {
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
		.drop-word {
		    color: gray;
		    transition: all 0.5s ease;
		}
		
		.drop-word.active {
		    color: red;
		    font-weight: bold;
		    animation: blink 1s infinite;
		}
		
		@keyframes blink {
		    0%, 100% { opacity: 1; }
		    50% { opacity: 0.3; }
		}
		.google-logo {
			font-size: 45px !important;
			font-weight: bold;
			color: white;
			letter-spacing: 2px;
		}
		.google-logo span {
			font-size: 45px !important;
			color: #8ab4f8;
		}
		.pagination .page-link {
			font-size: 25px !important;
		}
		.pagination .next {
			font-size: 25px !important;
		}
		.result-item a {
			font-size: 22px !important;
		}
		
		.result-item .url {
			font-size: 17px !important;
		}
		
		.result-item p {
			font-size: 17px !important;
		}
	</style>
</head>
<body>

    <header class="header">
        <!--<div class="profile-icon"></div>-->
        <a href="<%= request.getContextPath() %>/profile.jsp">
	  <img src="<%= request.getContextPath() %>/<%= photoPath %>" alt="Foto de perfil" class="profile-image-update">
	   </a>
	   <!-- Validar que el usuario tenga el ROL "designer" -->
		<% if ("designer".equalsIgnoreCase(usuarioJWT.getRol())) { %>
		    <div style="text-align: center;">
		        <a href="<%= request.getContextPath() %>/designer/admin-panel.jsp" class="designer-button">Ir al Panel</a>
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
	   <img src="<%= request.getContextPath() %>/img/hackendLogoUpdate.png" class="logo-image" alt="Imagen Logo">
       <!--<div class="logo">Google</div>-->
    </header>

    <div class="nav-container">
        <nav class="nav-menu">
            <a href="home.jsp?page=0"><img src="<%= request.getContextPath() %>/img/logo-test-6-update.png" class="img-hackend" width="22px" height="22px"> Hackend</a>
            <a href="<%= request.getContextPath() %>/dockerpwned/home_directory_dockerpwned/home_dockerpwned.jsp?page=0"><img src="<%= request.getContextPath() %>/img/dockerpwned.png" class="img-dockerpwned" width="25px" height="15px"> DockerPwned</a>
            <a href="<%= request.getContextPath() %>/ovalabs/home_directory_ovalabs/home_ovalabs.jsp?page=0"><img src="<%= request.getContextPath() %>/img/ovalabs.png" class="img-ovalabs" width="20px" height="20px"> OVAlabs</a>
            <a href="<%= request.getContextPath() %>/timelabs/timelabs.jsp"><img src="<%= request.getContextPath() %>/img/timelabs/timelabs-logo-update.png" class="img-timelabs" width="20px" height="20px"> <span id="dropStatus" class="drop-word">TimeLabs</span></a>
            <a href="<%= request.getContextPath() %>/ranking.jsp"><img src="<%= request.getContextPath() %>/img/ranking-logo.png" class="img-ranking" width="20px" height="20px"> Ranking</a>
            <a href="https://dise0.gitbook.io/h4cker_b00k/proyecto-dam/documentacion-proyecto_dam"><img src="<%= request.getContextPath() %>/img/document.png" class="img-document" width="20px" height="20px"> Documentación</a>
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
    <div class="results"></div> <!-- AquÃƒÂ­ se inyecta el contenido dinÃƒÂ¡mico -->

    <!-- PAGINACIÃ“N -->
    <div class="pagination">
        <div class="google-logo">H<span>a</span><span>a</span><span class="style-letters-hackend">a</span><span>a</span><span>a</span><span>a</span>ckend</div>
        <a href="home.jsp?page=0" class="page-link">1</a>
        <a href="Page1.jsp?page=1" class="page-link">2</a>
        <a href="Page2.jsp?page=2" class="page-link">3</a>
        <a href="Page3.jsp?page=3" class="page-link style-link-number">4</a>
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
	
	<!-- BOTONES Y ESTILO DE PAYPAL -->
	
	<script src="https://www.paypal.com/sdk/js?client-id=AZhxo4ppFH_hdjNyNZHOY4Mal9NUtrh_kuyapQYgZNiejRweC-PuLGFCDJ_luaINIRdpYoTlu_Nag6zD"></script>
	<!-- Botón flotante de PayPal -->
	<button id="open-paypal" style="position: fixed; bottom: 20px; left: 20px; background-color: #003087; border: none; border-radius: 50%; width: 60px; height: 60px; cursor: pointer; box-shadow: 0 0 10px rgba(0,0,0,0.3); z-index: 1000;">
	  <img src="https://www.paypalobjects.com/webstatic/icon/pp258.png" alt="PayPal" style="width: 30px; height: 30px;">
	</button>
	
	<!-- Overlay y Popup ocultos -->
	<div id="paypal-overlay" style="display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.7); z-index: 999;">
	  <div id="paypal-popup" style="
	      position: relative;
	      margin: 50px auto;
	      background: #2b2b2b;
	      padding: 40px;
	      border-radius: 16px;
	      box-shadow: 0 0 20px rgba(0,0,0,0.5);
	      width: 90%;
	      max-width: 800px;
	      color: white;
	      display: flex;
	      flex-direction: column;
	      max-height: 80vh; /* Limita altura para activar scroll */
	      overflow-y: auto; /* El scroll va aquí */
	      text-align: center;
	    ">
	    <button id="close-paypal" style="
	        position: absolute;
	        top: 15px;
	        right: 20px;
	        background: none;
	        border: none;
	        font-size: 24px;
	        color: white;
	        cursor: pointer;
	      ">✖</button>
	    <h2 style="margin-top: 0; font-size: 1.8rem;">💸 Donativo con PayPal</h2>
	    <p>¡Gracias por apoyar el proyecto!</p>
	    <!-- Campo para introducir la cantidad -->
	    <p>INTRODUCE LA CANTIDAD A DONAR (POR DEFECTO ES 1€)</p>
		<input id="donation-amount" type="number" min="1" placeholder="Introduce el monto" style="padding: 10px; margin-bottom: 20px; border-radius: 6px; border: 1px solid #ccc; background: #b8b8b8;">
	    <div id="paypal-button-container" style="margin-top: 30px;"></div>
	  </div>
	</div>

	<!-- VIDEO DE REFERENCIA (https://www.youtube.com/watch?v=nAz8xRQaPZQ) -->
	
	<script>
	  paypal.Buttons({
	    style: {
	    	shape: 'pill',
	    	label: 'pay',
	    },
	    createOrder: function(data, actions) {
	        // Obtenemos la cantidad introducida
	        const amount = document.getElementById("donation-amount").value || "1.00";

	        return actions.order.create({
	          purchase_units: [{
	            amount: {
	              value: amount
	            }
	          }]
	        });
	      },
	    onApprove: function(data, actions) {
	    	  return actions.order.capture().then(function (detalles){
	    	    // Guarda en localStorage los datos para usarlos luego en successful.jsp
	    	    const paymentInfo = {
	    	      id: detalles.id,
	    	      buyer: detalles.payer.name.given_name + ' ' + detalles.payer.name.surname,
	    	      email: detalles.payer.email_address,
	    	      amount: detalles.purchase_units[0].amount.value + ' ' + detalles.purchase_units[0].amount.currency_code,
	    	      date: new Date().toLocaleString()
	    	    };

	    	    localStorage.setItem('paypalDetails', JSON.stringify(paymentInfo));

	    	    // Redirige
	    	    window.location.href = "<%= request.getContextPath() %>/successful.jsp";
	    	  });
	    	},
	    onCancel: function(data) {
	    	alert("Pago cancelado");
	    	console.log(data);
	    }
	  }).render('#paypal-button-container');
	</script>
	
	<!-- SCRIPTS GENERALES -->
	
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
	//PAYPAL BUTTON
	const openBtn = document.getElementById("open-paypal");
	  const overlay = document.getElementById("paypal-overlay");
	  const closeBtn = document.getElementById("close-paypal");

	  openBtn.addEventListener("click", () => {
	    overlay.style.display = "block";
	  });

	  closeBtn.addEventListener("click", () => {
	    overlay.style.display = "none";
	  });
	  
	// SABER SI EL TIEMPO ESTA A NULL O CON UN VALOR
	  
	  async function verificarEstadoCountdown() {
		    try {
		        const res = await fetch('<%= request.getContextPath() %>/countdown?status=true');
		        const data = await res.json();
		        const dropEl = document.getElementById('dropStatus');
		        if (dropEl) {
		            if (data.activo) {
		                dropEl.classList.add('active');
		            } else {
		                dropEl.classList.remove('active');
		            }
		        }
		    } catch (err) {
		        console.error("Error consultando estado del countdown", err);
		    }
		}

		document.addEventListener("DOMContentLoaded", () => {
		    verificarEstadoCountdown();
		    setInterval(verificarEstadoCountdown, 5000); // Revisa cada 5 seg si ha cambiado
		});
	</script>
	<script src="<%= request.getContextPath() %>/js/home.js"></script>

</body>
</html>