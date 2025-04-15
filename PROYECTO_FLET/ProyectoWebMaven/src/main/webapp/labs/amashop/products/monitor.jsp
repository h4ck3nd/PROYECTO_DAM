<%@ page contentType="text/html; charset=UTF-8" language="java"%>
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
						<img src="<%= request.getContextPath() %>/img/img_amashop/Monitor-Curvo-27.png"
							alt="Smartwatch Z50" class="product-image">
						<div class="product-info">
							<h1>Monitor Curvo 27 Pulgadas</h1>
							<p>
								El <strong>Monitor Curvo 27 Pulgadas</strong> es la opción ideal
								para quienes buscan una experiencia visual inmersiva y sin
								distracciones. Con su diseño curvado, este monitor te ofrece un
								ángulo de visión envolvente, ideal para el trabajo, el gaming y
								el entretenimiento. Su pantalla de alta definición garantiza
								colores vibrantes y detalles nítidos, mejorando cada actividad
								que realices en tu computador.
							</p>
							<ul>
								<li>Pantalla curva de 27 pulgadas para una visualización
									envolvente.</li>
								<li>Resolución Full HD (1920x1080) para imágenes claras y
									nítidas.</li>
								<li>Tecnología de reducción de parpadeo para menos fatiga
									visual.</li>
								<li>Tiempo de respuesta rápido para una experiencia sin
									interrupciones en juegos.</li>
								<li>Amplios ángulos de visión para que puedas ver la
									pantalla claramente desde cualquier lugar.</li>
								<li>Conectividad versátil con puertos HDMI y DisplayPort.</li>
							</ul>
							<button class="add-to-cart" onclick="window.location.href='comprar.jsp'">Comprar ahora</button>
						</div>
					</div>
					<div class="product-description">
						<h2>🌟 Monitor Curvo 27 Pulgadas – Una Experiencia Visual
							Incomparable</h2>
						<p>
							El <strong>Monitor Curvo 27 Pulgadas</strong> está diseñado para
							ofrecerte una experiencia visual totalmente envolvente. Con su
							pantalla curva, disfrutarás de un campo de visión más amplio, lo
							que te permitirá sumergirte por completo en juegos, películas o
							tareas laborales. Su resolución Full HD te garantiza imágenes de
							alta calidad, colores vibrantes y detalles excepcionales que
							mejoran tu productividad y entretenimiento.
						</p>
						<p>La tecnología de reducción de parpadeo del monitor está
							pensada para proteger tu vista durante largas sesiones frente a
							la pantalla. Además, su rápido tiempo de respuesta lo convierte
							en la opción ideal para jugadores que buscan precisión y
							velocidad. Los amplios ángulos de visión aseguran que obtendrás
							una visualización clara, sin importar desde qué ángulo mires la
							pantalla.</p>
						<p>
							Con puertos HDMI y DisplayPort, podrás conectar este monitor a
							una gran variedad de dispositivos, desde computadoras hasta
							consolas de videojuegos. Si estás buscando una pantalla que
							combine elegancia, rendimiento y tecnología avanzada, el <strong>Monitor
								Curvo 27 Pulgadas</strong> es la opción perfecta para ti.
						</p>
						<p>
							<strong>Características principales:</strong>
						<ul>
							<li><strong>Pantalla curva de 27 pulgadas:</strong> Te
								brinda una experiencia inmersiva, ideal para el gaming y el
								trabajo.</li>
							<li><strong>Resolución Full HD (1920x1080):</strong>
								Imágenes nítidas y detalles vibrantes.</li>
							<li><strong>Tecnología de reducción de parpadeo:</strong>
								Protege tu vista y reduce la fatiga ocular.</li>
							<li><strong>Tiempo de respuesta rápido:</strong> Perfecto
								para juegos sin interrupciones.</li>
							<li><strong>Amplios ángulos de visión:</strong> Disfruta de
								una visualización clara desde cualquier lugar.</li>
							<li><strong>Conectividad versátil:</strong> Incluye puertos
								HDMI y DisplayPort para una fácil conexión.</li>
						</ul>
						</p>
						<p>
							Mejora tu experiencia visual con el <strong>Monitor
								Curvo 27 Pulgadas</strong>. ¡Hazte con el tuyo y disfruta de imágenes
							impresionantes con la mayor comodidad!
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
