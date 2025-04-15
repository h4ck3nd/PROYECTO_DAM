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
	flex: 1; /* ÃÂ°ÃÂÃÂÃÂ¥ Esto lo hace crecer verticalmente */
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
				<h3>CategorÃÂÃÂ­as</h3>
				<ul>
					<li><a href="#">TecnologÃÂÃÂ­a</a></li>
					<li><a href="#">Hogar</a></li>
					<li><a href="#">Ropa</a></li>
					<li><a href="#">Deportes</a></li>
					<li><a href="#">Libros</a></li>
				</ul>
			</aside>

			<div class="product-detail">
				<div class="product-card">
					<div class="product-header">
						<img src="<%= request.getContextPath() %>/img/img_amashop/Camara-Digital-4K.png"
							alt="Smartwatch Z50" class="product-image">
						<div class="product-info">
							<h1>CÃ¡mara Digital 4K</h1>
							<p>
								La <strong>CÃ¡mara Digital 4K</strong> es la herramienta perfecta
								para capturar momentos con una calidad de imagen impresionante.
								DiseÃ±ada para los entusiastas de la fotografÃ­a y los creadores
								de contenido, esta cÃ¡mara ofrece una resoluciÃ³n de 4K para
								lograr detalles nÃ­tidos y colores vibrantes en cada toma.
							</p>
							<ul>
								<li>ResoluciÃ³n 4K para videos de alta calidad.</li>
								<li>Sensor avanzado para una mejor captura de imÃ¡genes con
									poca luz.</li>
								<li>EstabilizaciÃ³n de imagen para vÃ­deos suaves y sin
									sacudidas.</li>
								<li>Conectividad Wi-Fi para compartir y transmitir tus
									imÃ¡genes fÃ¡cilmente.</li>
								<li>Pantalla LCD articulada para facilitar tomas desde
									diferentes Ã¡ngulos.</li>
								<li>BaterÃ­a de larga duraciÃ³n para sesiones fotogrÃ¡ficas
									prolongadas.</li>
							</ul>
							<button class="add-to-cart" onclick="window.location.href='comprar.jsp'">Comprar ahora</button>
						</div>
					</div>
					<div class="product-description">
						<h2>ð CÃ¡mara Digital 4K â Captura el Mundo con Calidad
							Profesional</h2>
						<p>
							La <strong>CÃ¡mara Digital 4K</strong> ofrece un rendimiento
							superior con una calidad de imagen excepcional. Ya sea que estÃ©s
							grabando un video o capturando una fotografÃ­a, esta cÃ¡mara estÃ¡
							diseÃ±ada para entregar resultados impresionantes con resoluciÃ³n
							4K, lo que te garantiza una claridad y detalle excepcionales en
							cada captura.
						</p>
						<p>Gracias a su sensor avanzado, podrÃ¡s obtener fotos nÃ­tidas
							incluso en condiciones de poca luz, asegurando que cada momento
							se capture con precisiÃ³n. La estabilizaciÃ³n de imagen integrada
							te permite grabar videos sin movimientos bruscos, lo que resulta
							en grabaciones suaves y profesionales.</p>
						<p>AdemÃ¡s, su conectividad Wi-Fi te permite compartir tus
							fotos y videos al instante, y la pantalla LCD articulada facilita
							la captura de imÃ¡genes desde Ã¡ngulos complicados, brindÃ¡ndote una
							flexibilidad total. Con su baterÃ­a de larga duraciÃ³n, podrÃ¡s
							disfrutar de largas sesiones sin preocuparte por quedarte sin
							energÃ­a.</p>
						<p>
							<strong>CaracterÃ­sticas principales:</strong>
						<ul>
							<li><strong>ResoluciÃ³n 4K:</strong> Captura imÃ¡genes y
								videos con una calidad profesional.</li>
							<li><strong>Sensor avanzado:</strong> Mejora las capturas en
								condiciones de baja luz.</li>
							<li><strong>EstabilizaciÃ³n de imagen:</strong> Videos suaves
								y sin sacudidas.</li>
							<li><strong>Conectividad Wi-Fi:</strong> Comparte y
								transmite tus imÃ¡genes de manera instantÃ¡nea.</li>
							<li><strong>Pantalla LCD articulada:</strong> Toma fotos
								desde Ã¡ngulos difÃ­ciles con facilidad.</li>
							<li><strong>BaterÃ­a de larga duraciÃ³n:</strong> Perfecta
								para largas sesiones de grabaciÃ³n o fotografÃ­a.</li>
						</ul>
						</p>
						<p>
							La <strong>CÃ¡mara Digital 4K</strong> es la herramienta ideal
							para capturar la esencia de cada momento con calidad de nivel
							profesional. Â¡Hazte con la tuya y lleva tus proyectos de
							fotografÃ­a y video al siguiente nivel!
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
