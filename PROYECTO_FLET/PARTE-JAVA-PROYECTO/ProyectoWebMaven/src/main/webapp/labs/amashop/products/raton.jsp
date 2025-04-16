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
						<img src="<%= request.getContextPath() %>/img/img_amashop/Raton-Gaming-Pro.png"
							alt="Smartwatch Z50" class="product-image">
						<div class="product-info">
							<h1>RatÃ³n Gaming Pro</h1>
							<p>
								El <strong>RatÃ³n Gaming Pro</strong> estÃ¡ diseÃ±ado para los
								gamers mÃ¡s exigentes que buscan precisiÃ³n, velocidad y
								comodidad. Con un sensor de alta resoluciÃ³n y una construcciÃ³n
								ergonÃ³mica, este ratÃ³n te brinda el control absoluto en cada
								partida. Su diseÃ±o moderno y elegante no solo es atractivo, sino
								que tambiÃ©n optimiza el rendimiento para que puedas dominar en
								tus juegos favoritos.
							</p>
							<ul>
								<li>Sensor de alta precisiÃ³n para un control exacto.</li>
								<li>DiseÃ±o ergonÃ³mico para largas sesiones de juego sin
									molestias.</li>
								<li>Botones programables para personalizar tu experiencia.</li>
								<li>RetroiluminaciÃ³n RGB personalizable.</li>
								<li>ConstrucciÃ³n robusta y duradera.</li>
								<li>Alta tasa de sondeo para una respuesta ultra rÃ¡pida.</li>
							</ul>
							<button class="add-to-cart" onclick="window.location.href='comprar.jsp'">Comprar ahora</button>
						</div>
					</div>
					<div class="product-description">
						<h2>ð® RatÃ³n Gaming Pro â Control Total en Cada Partida</h2>
						<p>
							El <strong>RatÃ³n Gaming Pro</strong> es la herramienta perfecta
							para alcanzar la victoria en tus juegos mÃ¡s competitivos.
							Equipado con un sensor de alta precisiÃ³n y una tasa de sondeo
							ultra rÃ¡pida, te permitirÃ¡ ejecutar cada movimiento con exactitud
							y sin retrasos. Su diseÃ±o ergonÃ³mico, pensado para sesiones de
							juego largas, asegura que tu mano se mantenga cÃ³moda y en su
							lugar durante todo el tiempo.
						</p>
						<p>Con sus botones programables, puedes asignar macros y
							comandos rÃ¡pidamente, brindÃ¡ndote la ventaja de ejecutar acciones
							de manera mÃ¡s eficiente. AdemÃ¡s, la retroiluminaciÃ³n RGB
							personalizable no solo mejora la estÃ©tica del ratÃ³n, sino que
							tambiÃ©n te permite adaptarlo a tu estilo de juego y preferencias
							personales.</p>
						<p>
							Su construcciÃ³n robusta estÃ¡ diseÃ±ada para resistir intensas
							jornadas de juego, garantizando durabilidad y fiabilidad. Ya sea
							que seas un jugador casual o competitivo, el <strong>RatÃ³n
								Gaming Pro</strong> te brindarÃ¡ la ventaja que necesitas para destacar en
							cualquier juego.
						</p>
						<p>
							<strong>CaracterÃ­sticas principales:</strong>
						<ul>
							<li><strong>Sensor de alta precisiÃ³n:</strong> Para un
								control exacto y sin latencia.</li>
							<li><strong>DiseÃ±o ergonÃ³mico:</strong> Comodidad y soporte
								durante largas sesiones de juego.</li>
							<li><strong>Botones programables:</strong> Personaliza tu
								experiencia con macros y comandos rÃ¡pidos.</li>
							<li><strong>RetroiluminaciÃ³n RGB personalizable:</strong>
								Ajusta la iluminaciÃ³n a tu estilo.</li>
							<li><strong>ConstrucciÃ³n robusta:</strong> Resistente y
								duradera para sesiones intensas.</li>
							<li><strong>Alta tasa de sondeo:</strong> Respuesta
								instantÃ¡nea en cada movimiento.</li>
						</ul>
						</p>
						<p>
							Con el <strong>RatÃ³n Gaming Pro</strong>, cada movimiento serÃ¡
							mÃ¡s preciso, cada victoria mÃ¡s segura. Â¡Hazte con el tuyo y lleva
							tu experiencia de juego al siguiente nivel!
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
