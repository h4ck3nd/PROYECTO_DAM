<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>AmaShop</title>
<style>
/* Asegura que el layout ocupe toda la altura de la pantalla */
html, body {
	height: 100%;
	margin: 0;
	display: flex;
	flex-direction: column;
}

/* Hace que el contenedor principal crezca y empuje el footer abajo */
.main-container {
	display: flex;
	flex: 1;
}

* {
	box-sizing: border-box;
}

body {
	font-family: Arial, sans-serif;
	background-color: #f3f3f3;
}

/* Header */
header {
	background-color: #232f3e;
	color: white;
	padding: 10px 20px;
	display: flex;
	align-items: center;
	justify-content: space-between;
	flex-wrap: wrap;
}

.logo {
	font-size: 1.5em;
	font-weight: bold;
}

.search-bar {
	width: 40%;
	padding: 8px;
	border: none;
	border-radius: 4px;
}

nav a {
	color: white;
	margin-left: 15px;
	text-decoration: none;
}

/* Aside del carrito */
.cart-sidebar {
	position: fixed;
	top: 0;
	right: -100%;
	width: 300px;
	height: 100%;
	background-color: white;
	box-shadow: -2px 0 5px rgba(0, 0, 0, 0.3);
	padding: 20px;
	transition: right 0.3s ease-in-out;
	z-index: 1000;
}

.cart-sidebar.active {
	right: 0;
}

.cart-sidebar h3 {
	margin-top: 0;
}

.close-btn {
	background: none;
	border: none;
	font-size: 20px;
	cursor: pointer;
	position: absolute;
	top: 10px;
	right: 15px;
}

/* Sidebar */
.sidebar {
	width: 200px;
	background-color: white;
	padding: 20px;
	border-right: 1px solid #ddd;
}

.sidebar h3 {
	margin-bottom: 10px;
}

.sidebar ul {
	list-style: none;
	padding: 0;
}

.sidebar li {
	margin: 8px 0;
}

.sidebar a {
	text-decoration: none;
	color: #333;
}

/* Productos */
.products {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
	gap: 20px;
	padding: 20px;
	flex: 1;
}

/* Tarjeta de producto */
.product-card {
	background-color: white;
	padding: 15px;
	border: 1px solid #ddd;
	text-align: center;
	border-radius: 6px;
	box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.product-card img {
	max-width: 100%;
	height: auto;
}

.product-card h4 {
	margin: 10px 0;
}

.product-card p {
	font-size: 1.1em;
	color: #007600;
	margin-bottom: 10px;
}

/* Botones */
.buttons {
	display: flex;
	flex-direction: column;
	gap: 8px;
}

.product-card button {
	background-color: #ffa41c;
	border: none;
	padding: 10px;
	cursor: pointer;
	border-radius: 4px;
	transition: background-color 0.3s;
}

.product-card button.view-product {
	background-color: #0073e6;
	color: white;
}

.product-card button:hover {
	background-color: #cc8500;
}

.product-card button.view-product:hover {
	background-color: #005bb5;
}

/* PRODUCTOS EN EL CARRITO */
#toggle-carrito {
  position: fixed;
  top: 20px;
  right: 20px;
  z-index: 1000;
  padding: 10px;
  background: #000;
  color: #fff;
  border: none;
  border-radius: 50px;
  cursor: pointer;
}

#carrito {
  position: fixed;
  top: 0;
  right: -320px;
  width: 300px;
  height: 100%;
  background: #f2f2f2;
  padding: 20px;
  overflow-y: auto;
  box-shadow: -2px 0 10px rgba(0,0,0,0.2);
  transition: right 0.3s ease;
  z-index: 999;
}

#carrito.abierto {
  right: 0;
}

#cerrar-carrito {
  background-color: red;
  color: white;
  border: none;
  padding: 5px 10px;
  cursor: pointer;
  float: right;
  font-size: 16px;
}

.item-carrito {
  margin-bottom: 10px;
}

.item-carrito img {
  width: 50px;
  margin-right: 10px;
  vertical-align: middle;
}

.eliminar {
  background-color: red;
  color: white;
  border: none;
  padding: 5px;
  cursor: pointer;
  margin-left: 10px;
}

/* Footer */
footer {
	background-color: #232f3e;
	color: white;
	text-align: center;
	padding: 15px;
}
</style>
</head>
<body>

	<header>
		<div class="logo">AmaShop</div>
		<input type="text" placeholder="Buscar productos..."
			class="search-bar">
		<nav>
			<a href="#" id="toggle-carrito">Carrito</a>
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

			<!-- Producto 1 -->
			<div class="product-card">
				<img src="<%= request.getContextPath() %>/img/img_amashop/smartphone-x100.png"
					alt="Smartphone X100" />
				<h4>Smartphone X100</h4>
				<p>299.99€</p>
				<div class="buttons">
					<button class="add-to-cart">Agregar al carrito</button>
					<button class="view-product" onclick="window.location.href='products/smartphone.jsp'">Ver Producto</button>
				</div>
			</div>

			<!-- Producto 2 -->
			<div class="product-card">
				<img src="<%= request.getContextPath() %>/img/img_amashop/auriculares-bluetooth.png"
					alt="Auriculares Bluetooth" />
				<h4>Auriculares Bluetooth</h4>
				<p>59.99€</p>
				<div class="buttons">
					<button class="add-to-cart">Agregar al carrito</button>
					<button class="view-product" onclick="window.location.href='products/auriculares.jsp'">Ver Producto</button>
				</div>
			</div>

			<!-- Producto 3 -->
			<div class="product-card">
				<img src="<%= request.getContextPath() %>/img/img_amashop/Smartwatch-Z50.png"
					alt="Smartwatch Z50" />
				<h4>Smartwatch Z50</h4>
				<p>199.99€</p>
				<div class="buttons">
					<button class="add-to-cart">Agregar al carrito</button>
					<button class="view-product" onclick="window.location.href='products/smartwatch.jsp'">Ver Producto</button>
				</div>
			</div>

			<!-- Producto 4 -->
			<div class="product-card">
				<img src="<%= request.getContextPath() %>/img/img_amashop/Teclado-Mecanico-RGB.png"
					alt="Teclado Mecánico RGB" />
				<h4>Teclado Mecánico RGB</h4>
				<p>99.99€</p>
				<div class="buttons">
					<button class="add-to-cart">Agregar al carrito</button>
					<button class="view-product" onclick="window.location.href='products/teclado.jsp'">Ver Producto</button>
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
					<button class="view-product" onclick="window.location.href='products/raton.jsp'">Ver Producto</button>
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
					<button class="view-product" onclick="window.location.href='products/monitor.jsp'">Ver Producto</button>
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
					<button class="view-product" onclick="window.location.href='products/camara.jsp'">Ver Producto</button>
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
					<button class="view-product" onclick="window.location.href='products/portatil.jsp'">Ver Producto</button>
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
					<button class="view-product" onclick="window.location.href='products/cargador.jsp'">Ver Producto</button>
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
					<button class="view-product" onclick="window.location.href='products/altavoz.jsp'">Ver Producto</button>
				</div>
			</div>

			<!-- Producto 11 -->
			<div class="product-card">
				<img src="<%= request.getContextPath() %>/img/img_amashop/MicroSD-128-GB.png" alt="MicroSD 128GB" />
				<h4 class="">MicroSD 128GB</h4>
				<p>19.99€</p>
				<div class="buttons">
					<button class="add-to-cart">Agregar al carrito</button>
					<button class="view-product" onclick="window.location.href='products/tarjeta.jsp'">Ver Producto</button>
				</div>
			</div>

			<!-- Producto 12 -->
			<div class="product-card">
				<img src="<%= request.getContextPath() %>/img/img_amashop/Mochila-Gamer.png" alt="Mochila Gamer" />
				<h4>Mochila Gamer</h4>
				<p>39.99€</p>
				<div class="buttons">
					<button class="add-to-cart">Agregar al carrito</button>
					<button class="view-product" onclick="window.location.href='products/mochila.jsp'">Ver Producto</button>
				</div>
			</div>

		</main>
	</div>
	<!-- Aside del carrito -->
  <aside id="carrito">
    <button id="cerrar-carrito">✖</button>
    <h2>Carrito</h2>
    <div id="contenido-carrito"></div>
    <p><strong>Total:</strong> $<span id="total-carrito">0.00</span></p>
  </aside>
	<footer>
		<p>&copy; 2025 AmaShop. Todos los derechos reservados.</p>
	</footer>
	<script>
	document.addEventListener('DOMContentLoaded', () => {
		  const botonesAgregar = document.querySelectorAll('.add-to-cart');
		  const contenidoCarrito = document.getElementById('contenido-carrito');
		  const totalCarrito = document.getElementById('total-carrito');
		  const botonToggleCarrito = document.getElementById('toggle-carrito');
		  const botonCerrarCarrito = document.getElementById('cerrar-carrito');
		  const carrito = document.getElementById('carrito');

		  let total = 0;

		  botonesAgregar.forEach(boton => {
		    boton.addEventListener('click', () => {
		      const producto = boton.closest('.product-card');
		      const nombre = producto.querySelector('h4').textContent;
		      const precioTexto = producto.querySelector('p').textContent;
		      const precio = parseFloat(precioTexto.replace('€', '').trim());
		      const imagen = producto.querySelector('img').src;

		      const item = document.createElement('div');
		      item.classList.add('item-carrito');
		      item.innerHTML = `
		        <div style="display: flex; align-items: center; justify-content: space-between;">
		          <img src="${imagen}" alt="${nombre}" style="width: 50px; margin-right: 10px;">
		          <div style="flex-grow:1; margin-left: 10px;">
		            <strong>${nombre}</strong><br>
		            <span class="precio-item">${precio.toFixed(2)}€</span>
		          </div>
		          <button class="eliminar">X</button>
		        </div>
		        <hr>
		      `;

		      contenidoCarrito.appendChild(item);

		      // Actualizar total
		      total += precio;
		      actualizarTotal();

		      // Eliminar producto del carrito
		      item.querySelector('.eliminar').addEventListener('click', () => {
		        total -= precio;
		        item.remove();
		        actualizarTotal();
		      });
		    });
		  });

		  function actualizarTotal() {
		    totalCarrito.textContent = total.toFixed(2);
		  }

		  // Mostrar/Ocultar carrito
		  botonToggleCarrito.addEventListener('click', () => {
		    carrito.classList.toggle('abierto');
		  });

		  botonCerrarCarrito.addEventListener('click', () => {
		    carrito.classList.remove('abierto');
		  });
		});

</script>

</body>
</html>