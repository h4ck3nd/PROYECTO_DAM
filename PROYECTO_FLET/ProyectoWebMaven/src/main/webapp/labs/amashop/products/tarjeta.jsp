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
						<img src="<%= request.getContextPath() %>/img/img_amashop/MicroSD-128-GB.png"
							alt="Smartwatch Z50" class="product-image">
						<div class="product-info">
							<h1>MicroSD 128GB</h1>
							<p>
								La <strong>MicroSD 128GB</strong> es la solución perfecta para
								expandir el almacenamiento de tus dispositivos móviles, cámaras,
								y otros dispositivos electrónicos. Con una gran capacidad de
								almacenamiento y una alta velocidad de transferencia, te permite
								guardar más fotos, videos y aplicaciones sin preocuparte por
								quedarte sin espacio.
							</p>
							<ul>
								<li>Capacidad de almacenamiento de 128GB para guardar una
									gran cantidad de datos.</li>
								<li>Velocidad de transferencia rápida para una experiencia
									de uso eficiente.</li>
								<li>Compatibilidad con dispositivos que admiten tarjetas
									MicroSD, como teléfonos, cámaras y más.</li>
								<li>Resistente a las condiciones extremas, incluyendo
									temperaturas altas y bajas.</li>
								<li>Ideal para grabación de videos en 4K, fotografía de
									alta resolución y aplicaciones de gran tamaño.</li>
								<li>Fácil de usar, simplemente inserta la tarjeta en el
									dispositivo y comienza a almacenar.</li>
							</ul>
							<button class="add-to-cart" onclick="window.location.href='comprar.jsp'">Comprar ahora</button>
						</div>
					</div>
					<div class="product-description">
						<h2>💾 MicroSD 128GB – Expande tu almacenamiento</h2>
						<p>
							La <strong>MicroSD 128GB</strong> es perfecta para quienes
							necesitan más espacio de almacenamiento en sus dispositivos. Ya
							sea para tu teléfono, cámara, dron o cualquier otro dispositivo
							compatible, esta tarjeta ofrece una gran capacidad para guardar
							fotos, videos, música, y aplicaciones, asegurando que nunca te
							quedes sin espacio.
						</p>
						<p>Con una alta velocidad de transferencia, puedes almacenar y
							acceder a tus archivos rápidamente. Es ideal para grabar videos
							en alta definición o 4K, así como para aplicaciones que requieren
							un gran espacio de almacenamiento, como juegos o software de
							edición multimedia.</p>
						<p>
							Además, la <strong>MicroSD 128GB</strong> es resistente a
							condiciones extremas como temperaturas extremas, lo que asegura
							su durabilidad en ambientes difíciles. Ya sea que la uses para
							una cámara de acción o para tu smartphone, puedes contar con su
							confiabilidad y rendimiento superior.
						</p>
						<p>
							<strong>Características principales:</strong>
						<ul>
							<li><strong>Capacidad de 128GB:</strong> Amplio espacio para
								fotos, videos, aplicaciones y más.</li>
							<li><strong>Alta velocidad de transferencia:</strong> Rápida
								lectura y escritura de archivos.</li>
							<li><strong>Compatibilidad universal:</strong> Funciona con
								dispositivos que admiten tarjetas MicroSD.</li>
							<li><strong>Resistente a temperaturas extremas:</strong>
								Ideal para condiciones difíciles y grabación al aire libre.</li>
							<li><strong>Perfecta para grabación en 4K:</strong>
								Compatible con video de alta resolución.</li>
						</ul>
						</p>
						<p>
							Con la <strong>MicroSD 128GB</strong>, tendrás el almacenamiento
							adicional que necesitas para todos tus dispositivos. ¡Hazte con
							la tuya y nunca más te quedes sin espacio!
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
