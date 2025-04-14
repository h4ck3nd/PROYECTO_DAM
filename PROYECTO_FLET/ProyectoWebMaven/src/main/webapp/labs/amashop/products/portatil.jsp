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
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="icon" type="image/png" href="<%= request.getContextPath() %>/img/icono/icono_cinco_hackend.ico">
<title>AmaShop</title>
<style>
html, body {
	height: 100%;
	margin: 0;
}

* {
	box-sizing: border-box;
}

body {
	display: flex;
	flex-direction: column;
	font-family: Arial, sans-serif;
	background-color: #f3f3f3;
}

.page-wrapper {
	display: flex;
	flex-direction: column;
	min-height: 100vh;
}

.main-container {
	display: flex;
	flex: 1;
}

.sidebar {
	width: 200px;
	background-color: white;
	padding: 20px;
	border-right: 1px solid #ddd;
	flex-shrink: 0;
}

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

.product-detail {
	flex: 1;
	display: flex;
	flex-direction: column;
}

.product-card {
	width: 100%;
	max-width: none;
	background-color: #ffffff;
	padding: 30px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	flex: 1; /* Ã°ÂÂÂ¥ Esto lo hace crecer verticalmente */
	display: flex;
	flex-direction: column;
}

.product-header {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	margin-bottom: 20px;
}

.product-image {
	max-width: 300px;
	border-radius: 10px;
}

.product-info {
	flex: 1;
}

.product-info h1 {
	margin-top: 0;
	font-size: 28px;
}

.product-info p {
	font-size: 16px;
	color: #444;
}

.product-info ul {
	margin: 15px 0;
	padding-left: 20px;
}

.product-info li {
	margin-bottom: 8px;
}

.product-description h2 {
	margin-top: 0;
	font-size: 22px;
}

.product-description p {
	font-size: 15px;
	color: #333;
	margin-bottom: 15px;
}

.add-to-cart {
	background-color: #ffd814;
	border: 1px solid #fcd200;
	color: #111;
	padding: 12px 24px;
	font-size: 16px;
	font-weight: bold;
	border-radius: 8px;
	cursor: pointer;
	transition: background-color 0.2s ease, box-shadow 0.2s ease;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.add-to-cart:hover {
	background-color: #f7ca00;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
}

footer {
	background-color: #232f3e;
	color: white;
	text-align: center;
	padding: 15px;
}
</style>
</head>
<body>
	<div class="page-wrapper">

		<header>
			<div class="logo">AmaShop</div>
			<input type="text" placeholder="Buscar productos..."
				class="search-bar">
			<nav>
				<a href="../amashop.jsp" id="cart-btn">Volver</a>
			</nav>
		</header>

		<div class="main-container">
			<aside class="sidebar">
				<h3>CategorÃÂ­as</h3>
				<ul>
					<li><a href="#">TecnologÃÂ­a</a></li>
					<li><a href="#">Hogar</a></li>
					<li><a href="#">Ropa</a></li>
					<li><a href="#">Deportes</a></li>
					<li><a href="#">Libros</a></li>
				</ul>
			</aside>

			<div class="product-detail">
				<div class="product-card">
					<div class="product-header">
						<img src="<%= request.getContextPath() %>/img/img_amashop/Laptop-Gaming-X300.png"
							alt="Smartwatch Z50" class="product-image">
						<div class="product-info">
							<h1>Laptop Gaming X300</h1>
							<p>
								La <strong>Laptop Gaming X300</strong> está diseñada para
								ofrecerte un rendimiento superior en todos tus juegos. Equipado
								con un procesador de última generación, tarjeta gráfica avanzada
								y una pantalla de alta resolución, esta laptop es perfecta para
								gamers que buscan la mejor experiencia de juego en todo momento.
							</p>
							<ul>
								<li>Procesador Intel i7 de 10ª generación para un
									rendimiento sin interrupciones.</li>
								<li>Tarjeta gráfica NVIDIA GeForce RTX 3060 para una
									experiencia visual impresionante.</li>
								<li>Pantalla Full HD de 15.6 pulgadas con una tasa de
									refresco de 144Hz.</li>
								<li>Teclado retroiluminado RGB personalizable.</li>
								<li>Almacenamiento SSD de 1TB para un inicio rápido y una
									carga eficiente.</li>
								<li>Duración de batería de hasta 8 horas para sesiones de
									juego prolongadas.</li>
							</ul>
							<button class="add-to-cart" onclick="window.location.href='comprar.jsp'">Comprar ahora</button>
						</div>
					</div>
					<div class="product-description">
						<h2>🌟 Laptop Gaming X300 – Potencia y Estilo en un Solo
							Dispositivo</h2>
						<p>
							La <strong>Laptop Gaming X300</strong> es todo lo que necesitas
							para jugar sin límites. Con un procesador Intel i7 de 10ª
							generación y una tarjeta gráfica NVIDIA GeForce RTX 3060, puedes
							esperar gráficos de alta calidad, renderizado fluido y velocidad
							inigualable. Ya sea para juegos AAA o para streamings en alta
							resolución, esta laptop está lista para llevarte al siguiente
							nivel.
						</p>
						<p>La pantalla Full HD de 15.6 pulgadas con una tasa de
							refresco de 144Hz te brinda una visualización clara y fluida,
							permitiéndote disfrutar de tus juegos sin desfases ni
							interrupciones. Además, el teclado retroiluminado RGB se adapta a
							tu estilo, permitiéndote personalizar la iluminación según tus
							preferencias.</p>
						<p>Con 1TB de almacenamiento SSD, tendrás espacio más que
							suficiente para instalar todos tus juegos favoritos y acceder a
							ellos rápidamente. Su batería de larga duración de hasta 8 horas
							garantiza que puedas jugar durante largas sesiones sin
							interrupciones.</p>
						<p>
							<strong>Características principales:</strong>
						<ul>
							<li><strong>Procesador Intel i7 de 10ª generación:</strong>
								Velocidad y eficiencia para juegos sin interrupciones.</li>
							<li><strong>Tarjeta gráfica NVIDIA GeForce RTX
									3060:</strong> Gráficos impresionantes y rendimiento sin igual.</li>
							<li><strong>Pantalla Full HD de 15.6 pulgadas:</strong>
								Visualización nítida y tasa de refresco de 144Hz.</li>
							<li><strong>Teclado retroiluminado RGB:</strong>
								Personalización total de la iluminación.</li>
							<li><strong>Almacenamiento SSD de 1TB:</strong> Acceso
								rápido a tus juegos y archivos.</li>
							<li><strong>Duración de batería de hasta 8 horas:</strong>
								Juega por más tiempo sin necesidad de cargar.</li>
						</ul>
						</p>
						<p>
							La <strong>Laptop Gaming X300</strong> es la opción perfecta para
							quienes buscan potencia, velocidad y diseño. ¡Hazla tuya y lleva
							tu experiencia de juego a nuevas alturas!
						</p>
					</div>
				</div>
			</div>
		</div>

		<footer>
			<p>&copy; 2025 AmaShop. Todos los derechos reservados.</p>
		</footer>
	</div>
</body>
</html>
