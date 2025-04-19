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
	<style>
		.logo-image {
		  width: 125px;
		  height: 50px;
		  position: relative;
		}
		.profile-image-update {
			width: 40px;
			height: 40px;
			border-radius: 30px;
		}
		.result-icon {
		  width: 25px; /* o el tamaÃ±o que quieras */
		  height: 25px;
		  object-fit: contain; /* evita que se deforme */
		  margin-right: 10px; /* opcional, para separaciÃ³n del texto */
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
		.style-link-number {
			color: white !important;
			text-decoration: underline !important;
			font-weight: bold !important;
		}
		/* FLIP CLOCK - ESTILO HORIZONTAL */
		.flip-clock {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    gap: 8px; /* Reduje el espacio entre los elementos */
		    margin-top: 0px; /* Reduje el margen superior */
		}
		
		.flip-unit {
		    background-color: #2d2d2d;
		    color: #fff;
		    font-family: 'Courier New', Courier, monospace;
		    font-size: 1.5em; /* Reduje el tamaño de la fuente */
		    width: 40px; /* Reducí el ancho */
		    height: 60px; /* Reduje la altura */
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    border-radius: 8px;
		    border: 2px solid #444;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.6); /* Reducí el tamaño de la sombra */
		}

		/* Botón del diseñador */
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
</head>
<body>
	<!-- <a href="?page=0&lang=es">🇪🇸 Español</a> | <a href="?page=0&lang=en">🇬🇧 English</a> -->
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
		<!-- CONTADOR CUENTA ATRAS + BOTON -->
		<% if ("designer".equalsIgnoreCase(usuarioJWT.getRol())) { %>
		    <div style="text-align: center;">
		        <button id="startCountdown" class="designer-button">Iniciar Cuenta Atrás</button>
		    </div>
		<% } %>
		<!-- DIV DEL CONTADOR -->
		<div id="countdown" class="flip-clock">
		    <div class="flip-unit">
		        <span id="hours">00</span>
		    </div>
		    <div class="flip-unit">
		        <span id="minutes">00</span>
		    </div>
		    <div class="flip-unit">
		        <span id="seconds">00</span>
		    </div>
		</div>
		<!-- LOGO DE LA PAGINA -->
	   <img src="<%= request.getContextPath() %>/img/timelabs/timelabs.png" class="logo-image" alt="Imagen Logo">
       <!--<div class="logo">Google</div>-->
    </header>

    <div class="nav-container">
        <nav class="nav-menu">
            <a href="home.jsp?page=0"><img src="<%= request.getContextPath() %>/img/logo-test-6-update.png" class="img-hackend" width="22px" height="22px"> Hackend</a>
            <a href="<%= request.getContextPath() %>/dockerpwned/home_directory_dockerpwned/home_dockerpwned.jsp?page=0"><img src="<%= request.getContextPath() %>/img/dockerpwned.png" class="img-dockerpwned" width="25px" height="15px"> DockerPwned</a>
            <a href="<%= request.getContextPath() %>/ovalabs/home_directory_ovalabs/home_ovalabs.jsp?page=0"><img src="<%= request.getContextPath() %>/img/ovalabs.png" class="img-ovalabs" width="20px" height="20px"> OVAlabs</a>
            <a href="<%= request.getContextPath() %>/timelabs/timelabs.jsp"><img src="<%= request.getContextPath() %>/img/timelabs/timelabs-logo.png" class="img-timelabs" width="20px" height="20px"> TimeLabs</a>
            <a href="<%= request.getContextPath() %>/ranking.jsp"><img src="<%= request.getContextPath() %>/img/ranking-logo.png" class="img-ranking" width="20px" height="20px"> Ranking</a>
            <a href="#" id="more-button"></a>
        </nav>
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
	<br><br><br><br><br><br><br><br><br><br><br>
    <!-- PAGINACIÃâN -->
    <div class="pagination">
        <div class="google-logo">T<span>i</span><span>i</span><span>i</span><span>i</span><span>i</span><span>i</span>melabs</div>
        <a href="timelabs.jsp" class="page-link style-link-number">1</a>
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
    
	<!-- https://www.iemoji.com/view/emoji/932/travel-places/building-construction (Para sacar EMOTES en modo CODIGO) -->
	
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
	  
	// Ã¢Â¬â¡Ã¯Â¸Â Definimos estos dos globalmente para que estÃÂ©n disponibles en todo el script
	const resultsContainer = document.querySelector('.results');
	const searchResults = [
		{ url: "inactive.jsp", title: "INACTIVE", description: "Espera hasta que el nuevo evento comience...", image: "../img/logo-test-17-update.png", tags: ["timelabs", "hacking", "lab", "facil","d1se0"] },
	];

	document.addEventListener("DOMContentLoaded", function () {
	    console.log("DOM completamente cargado");

	    if (!resultsContainer) {
	        console.error("No se encontrÃÂ³ el contenedor .results");
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
	            favicon.src = '../img/default-error.png';
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
	        titleLink.target = "_self";
	        titleLink.textContent = result.title;

	        const descriptionParagraph = document.createElement('p');
	        descriptionParagraph.textContent = result.description;

	        // Crear contenedor de tags debajo de la descripciÃÂ³n
	        const tagsContainer = document.createElement('div');
	        tagsContainer.classList.add('tags');
	        
	        result.tags.forEach(tag => {
	            const tagSpan = document.createElement('span');
	            tagSpan.classList.add('tag');
	            tagSpan.textContent = `#${tag}`;
	            tagsContainer.appendChild(tagSpan);
	        });

	        // AÃÂ±adir todos los elementos
	        resultContent.appendChild(urlSpan);
	        resultContent.appendChild(document.createElement('br'));
	        resultContent.appendChild(titleLink);
	        resultContent.appendChild(descriptionParagraph);
	        resultContent.appendChild(tagsContainer); // Los tags se colocan al final (debajo de la descripciÃÂ³n)

	        resultItem.appendChild(favicon);
	        resultItem.appendChild(resultContent);

	        resultsContainer.appendChild(resultItem);
	        
	        searchInput.value = "";
	        searchInput.dispatchEvent(new Event("input"));
	    });

	    console.log("Todos los resultados fueron agregados al DOM");
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
	  
	// CUENTA DE LA PAGINA LOGICA
	  const DEFAULT_COUNTDOWN_SECONDS = 2 * 60 * 60 + 3 * 60 + 5; // 2h 3m 5s
	  let countdownInterval;

	  // Recuperar o reiniciar cuenta regresiva
	  function getTargetTime() {
	      const saved = localStorage.getItem('dropTargetTime');
	      if (saved) return new Date(parseInt(saved));
	      return null;
	  }

	  // Establecer nuevo tiempo objetivo
	  function setTargetTimeFromNow(seconds) {
	      const now = new Date();
	      const target = new Date(now.getTime() + seconds * 1000);
	      localStorage.setItem('dropTargetTime', target.getTime());
	      return target;
	  }

	  // Mostrar tiempo en formato 2 dígitos
	  function pad(n) {
	      return n.toString().padStart(2, '0');
	  }

	  // Actualizar visualmente los números
	  function updateDisplay(h, m, s) {
	      document.getElementById('hours').textContent = pad(h);
	      document.getElementById('minutes').textContent = pad(m);
	      document.getElementById('seconds').textContent = pad(s);
	  }

	  // Iniciar la cuenta regresiva
	  function startCountdown(targetTime) {
	      // Cambiar texto del botón cuando comienza la cuenta atrás
	      const btn = document.getElementById('startCountdown');
	      if (btn) {
	          btn.textContent = "Cuenta Atrás Iniciada"; // Cambiar el texto
	          btn.disabled = true; // Deshabilitar el botón para evitar múltiples clics
	      }

	      clearInterval(countdownInterval);
	      countdownInterval = setInterval(() => {
	          const now = new Date();
	          let diff = Math.floor((targetTime - now) / 1000);

	          if (diff <= 0) {
	              // Reiniciar cuando termina
	              targetTime = setTargetTimeFromNow(DEFAULT_COUNTDOWN_SECONDS);
	              diff = DEFAULT_COUNTDOWN_SECONDS;
	              restoreCounter(); // Restaurar contador cuando llegue a 0
	          }

	          const h = Math.floor(diff / 3600);
	          const m = Math.floor((diff % 3600) / 60);
	          const s = diff % 60;
	          updateDisplay(h, m, s);
	      }, 1000);
	  }

	  // Restaurar el contador a su valor original
	  function restoreCounter() {
	      const btn = document.getElementById('startCountdown');
	      if (btn) {
	          btn.textContent = "Iniciar Cuenta Atrás"; // Restaurar el texto original
	          btn.disabled = false; // Volver a habilitar el botón
	      }
	      // Restaurar visualmente los valores del contador
	      updateDisplay(0, 0, 0);
	      localStorage.removeItem('dropTargetTime'); // Eliminar el valor guardado en localStorage
	  }

	  // Iniciar al cargar si ya hay una cuenta activa
	  document.addEventListener('DOMContentLoaded', () => {
	      const savedTarget = getTargetTime();
	      if (savedTarget) {
	          startCountdown(savedTarget);
	      }

	      const btn = document.getElementById('startCountdown');
	      if (btn) {
	          btn.addEventListener('click', () => {
	              const newTarget = setTargetTimeFromNow(DEFAULT_COUNTDOWN_SECONDS);
	              startCountdown(newTarget);
	          });
	      }
	  });
	</script>
	<script src="<%= request.getContextPath() %>/js/home.js"></script>
</body>
</html>