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
						<img src="<%= request.getContextPath() %>/img/img_amashop/Teclado-Mecanico-RGB.png"
							alt="Smartwatch Z50" class="product-image">
						<div class="product-info">
							<h1>Teclado MecÃ¡nico Gaming</h1>
							<p>
								El <strong>Teclado MecÃ¡nico Gaming</strong> es la herramienta
								definitiva para llevar tu experiencia de juego a otro nivel.
								DiseÃ±ado para jugadores serios, este teclado ofrece una
								respuesta rÃ¡pida y precisa con sus interruptores mecÃ¡nicos, lo
								que garantiza un rendimiento sin igual en cada pulsaciÃ³n. Ya sea
								que estÃ©s jugando a nivel competitivo o disfrutando de una
								partida casual, su durabilidad y capacidad de respuesta te darÃ¡n
								la ventaja en cada momento.
							</p>
							<ul>
								<li>Interruptores mecÃ¡nicos para mayor precisiÃ³n y
									durabilidad.</li>
								<li>RetroiluminaciÃ³n RGB personalizable.</li>
								<li>Teclas programables para acceso rÃ¡pido a funciones.</li>
								<li>DiseÃ±o ergonÃ³mico para largas sesiones de juego.</li>
								<li>ConstrucciÃ³n robusta y resistente.</li>
								<li>Compatibilidad con PC, laptops y consolas.</li>
							</ul>
							<button class="add-to-cart" onclick="window.location.href='comprar.jsp'">Comprar ahora</button>
						</div>
					</div>
					<div class="product-description">
						<h2>ð® Teclado MecÃ¡nico Gaming â PrecisiÃ³n, Estilo y
							Rendimiento</h2>
						<p>
							El <strong>Teclado MecÃ¡nico Gaming</strong> es la herramienta
							definitiva para jugadores que buscan la mayor precisiÃ³n,
							velocidad y comodidad en sus sesiones de juego. Con sus
							interruptores mecÃ¡nicos de alta calidad, cada pulsaciÃ³n se siente
							rÃ¡pida y precisa, lo que te otorga una ventaja competitiva en
							cada partida. Su construcciÃ³n robusta y su diseÃ±o ergonÃ³mico
							garantizan horas de juego sin molestias, mientras que las teclas
							programables te permiten personalizar cada comando a tu gusto.
						</p>
						<p>Con retroiluminaciÃ³n RGB completamente personalizable,
							puedes elegir entre una amplia gama de colores y efectos para
							adaptar el teclado a tu estilo. Ya sea para crear el ambiente
							perfecto en la oscuridad o simplemente para aÃ±adir un toque de
							estilo, la iluminaciÃ³n del teclado estÃ¡ diseÃ±ada para
							impresionar.</p>
						<p>AdemÃ¡s, la compatibilidad con todas las plataformas
							principales (PC, laptops y consolas) asegura que puedas disfrutar
							de un rendimiento excepcional en cualquier dispositivo. Con un
							diseÃ±o compacto pero funcional, este teclado se adapta
							perfectamente a cualquier espacio de juego.</p>
						<p>
							<strong>CaracterÃ­sticas principales:</strong>
						<ul>
							<li><strong>Interruptores mecÃ¡nicos de alto
									rendimiento:</strong> Teclas que responden con precisiÃ³n para un control
								absoluto.</li>
							<li><strong>RetroiluminaciÃ³n RGB personalizable:</strong>
								Elige entre miles de colores y efectos para crear el ambiente
								perfecto.</li>
							<li><strong>Teclas programables:</strong> Accede rÃ¡pidamente
								a tus macros y comandos mÃ¡s usados.</li>
							<li><strong>DiseÃ±o ergonÃ³mico:</strong> Comodidad total
								durante largas horas de juego.</li>
							<li><strong>ConstrucciÃ³n robusta:</strong> Durabilidad
								garantizada para sesiones de juego intensas.</li>
							<li><strong>Compatibilidad universal:</strong> Compatible
								con PC, laptops y consolas.</li>
						</ul>
						</p>
						<p>
							Con el <strong>Teclado MecÃ¡nico Gaming</strong>, cada partida
							serÃ¡ una experiencia mejorada. Â¡Consigue el tuyo y domina el
							juego con estilo y precisiÃ³n!
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
