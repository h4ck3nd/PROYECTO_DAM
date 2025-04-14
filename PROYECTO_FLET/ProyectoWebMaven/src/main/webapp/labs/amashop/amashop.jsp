<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>AmaShop</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/amashop.css">
</head>
<body>
	
	<header>
		<div class="logo">AmaShop</div>
		<input type="text" placeholder="Buscar productos..." class="search-bar">
		<nav>
			<button id="open-cart-btn">Ver Carrito</button>
		</nav>
	</header>

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
   <script src="<%= request.getContextPath() %>/js/amashop.js"></script>
</body>
</html>