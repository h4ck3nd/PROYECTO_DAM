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
						<img src="<%= request.getContextPath() %>/img/img_amashop/Cargador-Inalambrico.png"
							alt="Smartwatch Z50" class="product-image">
						<div class="product-info">
							<h1>Cargador InalÃ¡mbrico</h1>
							<p>
								El <strong>Cargador InalÃ¡mbrico</strong> es la soluciÃ³n perfecta
								para mantener tus dispositivos siempre cargados sin la necesidad
								de cables. Con un diseÃ±o compacto y elegante, este cargador
								inalÃ¡mbrico es compatible con la mayorÃ­a de los smartphones y
								dispositivos habilitados para carga Qi.
							</p>
							<ul>
								<li>Compatible con dispositivos Qi como iPhone, Samsung,
									entre otros.</li>
								<li>DiseÃ±o compacto y elegante que se adapta a cualquier
									entorno.</li>
								<li>Carga rÃ¡pida de hasta 15W para una experiencia sin
									interrupciones.</li>
								<li>ProtecciÃ³n contra sobrecalentamiento, sobrecarga y
									cortocircuito.</li>
								<li>Base antideslizante para mantener el dispositivo seguro
									mientras se carga.</li>
								<li>Indicador LED para mostrar el estado de carga.</li>
							</ul>
							<button class="add-to-cart" onclick="window.location.href='comprar.jsp'">Comprar ahora</button>
						</div>
					</div>
					<div class="product-description">
						<h2>â¡ Cargador InalÃ¡mbrico â La comodidad de cargar sin
							cables</h2>
						<p>
							El <strong>Cargador InalÃ¡mbrico</strong> ofrece una forma rÃ¡pida
							y eficiente de cargar tus dispositivos sin la molestia de los
							cables. Solo coloca tu smartphone o dispositivo compatible en la
							base y disfruta de una carga rÃ¡pida y segura. Este cargador es
							compatible con una amplia gama de dispositivos, desde iPhones
							hasta Samsung Galaxy y otros telÃ©fonos con tecnologÃ­a Qi.
						</p>
						<p>Su diseÃ±o moderno y elegante se adapta perfectamente a
							cualquier ambiente, ya sea en tu hogar o en la oficina. AdemÃ¡s,
							cuenta con una base antideslizante que asegura que tu dispositivo
							permanezca en su lugar durante todo el proceso de carga.</p>
						<p>La carga rÃ¡pida de hasta 15W garantiza que tu dispositivo
							se cargue en menos tiempo, lo que te permite mantenerte siempre
							conectado sin largos tiempos de espera. La protecciÃ³n avanzada
							contra sobrecalentamiento, sobrecarga y cortocircuito asegura que
							tu dispositivo estÃ© seguro durante el proceso de carga.</p>
						<p>
							<strong>CaracterÃ­sticas principales:</strong>
						<ul>
							<li><strong>Compatibilidad Qi:</strong> Funciona con una
								variedad de dispositivos habilitados para carga inalÃ¡mbrica.</li>
							<li><strong>Carga rÃ¡pida de hasta 15W:</strong> Menos tiempo
								cargando, mÃ¡s tiempo usando tu dispositivo.</li>
							<li><strong>DiseÃ±o elegante y compacto:</strong> Perfecto
								para cualquier entorno y fÃ¡cil de transportar.</li>
							<li><strong>ProtecciÃ³n avanzada:</strong>
								Sobrecalentamiento, sobrecarga y cortocircuito estÃ¡n protegidos.</li>
							<li><strong>Base antideslizante:</strong> Mantiene tu
								dispositivo en su lugar mientras carga.</li>
							<li><strong>Indicador LED:</strong> Te muestra el estado de
								carga en tiempo real.</li>
						</ul>
						</p>
						<p>
							Con el <strong>Cargador InalÃ¡mbrico</strong>, disfruta de la
							comodidad de cargar tus dispositivos sin cables, manteniendo tu
							espacio organizado y libre de desorden. Â¡Hazte con el tuyo hoy y
							experimenta la carga del futuro!
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
