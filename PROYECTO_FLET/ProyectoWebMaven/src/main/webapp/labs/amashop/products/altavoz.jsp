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
						<img src="<%= request.getContextPath() %>/img/img_amashop/Altavoces-Bluetooth.png"
							alt="Smartwatch Z50" class="product-image">
						<div class="product-info">
							<h1>Altavoces Bluetooth</h1>
							<p>
								Los <strong>Altavoces Bluetooth</strong> son la solución
								perfecta para disfrutar de tu música en cualquier lugar. Con un
								diseño portátil, elegante y sonido de alta calidad, estos
								altavoces te ofrecen la libertad de conectarte sin cables y
								llevar la música a todas partes. Son ideales para escuchar
								música en casa, en la playa o mientras haces ejercicio.
							</p>
							<ul>
								<li>Conexión Bluetooth 5.0 para una transmisión de sonido
									rápida y estable.</li>
								<li>Sonido estéreo de alta calidad con graves profundos y
									agudos claros.</li>
								<li>Resistente al agua con certificación IPX7, perfecto
									para exteriores.</li>
								<li>Batería de larga duración, hasta 12 horas de
									reproducción continua.</li>
								<li>Función manos libres para responder llamadas sin
									desconectar el altavoz.</li>
								<li>Diseño compacto y portátil, fácil de llevar a todas
									partes.</li>
							</ul>
							<button class="add-to-cart" onclick="window.location.href='comprar.jsp'">Comprar ahora</button>
						</div>
					</div>
					<div class="product-description">
						<h2>🔊 Altavoces Bluetooth – Música en todas partes</h2>
						<p>
							Los <strong>Altavoces Bluetooth</strong> ofrecen una experiencia
							de sonido increíble en cualquier lugar. Con la conectividad
							Bluetooth 5.0, puedes disfrutar de una transmisión estable y
							rápida sin cables. Ya sea que estés en casa, en el parque o en la
							playa, estos altavoces están diseñados para adaptarse a tu estilo
							de vida activo.
						</p>
						<p>Disfruta de un sonido estéreo de alta calidad, con graves
							profundos y agudos nítidos que harán que tu música suene mejor
							que nunca. Además, su diseño compacto y portátil te permite
							llevarlo donde quieras, asegurando que siempre tengas la música
							que amas al alcance de tu mano.</p>
						<p>Con la clasificación de resistencia al agua IPX7, estos
							altavoces son perfectos para su uso al aire libre, resistiendo la
							lluvia, las salpicaduras e incluso una inmersión breve en el
							agua. La batería de larga duración garantiza hasta 12 horas de
							reproducción continua, por lo que puedes disfrutar de tus
							canciones favoritas durante todo el día sin preocuparte por
							quedarte sin carga.</p>
						<p>Además, la función manos libres permite que puedas
							responder tus llamadas sin desconectar el altavoz, haciendo que
							sea una opción práctica para cualquier ocasión.</p>
						<p>
							<strong>Características principales:</strong>
						<ul>
							<li><strong>Bluetooth 5.0:</strong> Conexión rápida y
								estable para una experiencia de sonido fluida.</li>
							<li><strong>Sonido estéreo de alta calidad:</strong> Graves
								profundos y agudos nítidos.</li>
							<li><strong>Resistencia al agua IPX7:</strong> Perfecto para
								uso en exteriores y actividades al aire libre.</li>
							<li><strong>Batería de larga duración:</strong> Hasta 12
								horas de reproducción continua.</li>
							<li><strong>Función manos libres:</strong> Responde llamadas
								sin desconectar el altavoz.</li>
							<li><strong>Diseño portátil:</strong> Compacto y fácil de
								transportar.</li>
						</ul>
						</p>
						<p>
							¡Hazte con tus <strong>Altavoces Bluetooth</strong> hoy mismo y
							lleva la música donde quieras! Conéctalos fácilmente y disfruta
							de la mejor calidad de sonido, estés donde estés.
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
