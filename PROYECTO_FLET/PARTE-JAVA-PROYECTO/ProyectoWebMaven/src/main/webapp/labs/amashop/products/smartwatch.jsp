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
						<img src="<%= request.getContextPath() %>/img/img_amashop/Smartwatch-Z50.png"
							alt="Smartwatch Z50" class="product-image">
						<div class="product-info">
								<h1>SMARTWATCH Z50</h1>
							<p>
								El <strong>Smartwatch Z50</strong> es el compaÃ±ero perfecto para mantenerte conectado y activo todo el dÃ­a. Con su diseÃ±o elegante y moderno, este reloj inteligente ofrece una experiencia de usuario excepcional, tanto para quienes buscan un dispositivo para llevar un seguimiento de su actividad fÃ­sica como para aquellos que desean mantenerse al tanto de las notificaciones de su telÃ©fono sin necesidad de sacarlo.
							</p>
							<ul>
								<li>Pantalla tÃ¡ctil a color de 1.4 pulgadas</li>
								<li>Monitoreo de frecuencia cardÃ­aca en tiempo real</li>
								<li>Resistencia al agua (IP67)</li>
								<li>Notificaciones de llamadas, mensajes y aplicaciones</li>
								<li>Seguimiento de actividad fÃ­sica (pasos, calorÃ­as, distancia)</li>
								<li>BaterÃ­a de hasta 7 dÃ­as de duraciÃ³n</li>
							</ul>
							<button class="add-to-cart" onclick="window.location.href='comprar.jsp'">Comprar ahora</button>
						</div>
					</div>
					<div class="product-description">
						<h2>â Smartwatch Z50 â Tu compaÃ±ero perfecto para el dÃ­a a dÃ­a</h2>
						<p>
							El <strong>Smartwatch Z50</strong> es un reloj inteligente que combina estilo y funcionalidad. Equipado con una pantalla tÃ¡ctil a color de 1.4 pulgadas, este dispositivo te permite acceder a tus notificaciones de manera rÃ¡pida y sencilla, sin necesidad de sacar tu telÃ©fono. AdemÃ¡s, su diseÃ±o moderno y elegante lo convierte en el accesorio ideal para cualquier ocasiÃ³n.
						</p>
						<p>
							Con el monitoreo continuo de la frecuencia cardÃ­aca, el Z50 te permite mantener un control preciso sobre tu salud en todo momento. Ya sea que estÃ©s haciendo ejercicio o simplemente llevando tu rutina diaria, el smartwatch registra todos tus datos de actividad y te ayuda a mantenerte motivado.
						</p>
						<p>
							El <strong>Smartwatch Z50</strong> es resistente al agua con clasificaciÃ³n IP67, lo que significa que puedes usarlo incluso en la lluvia o durante el ejercicio intenso sin preocupaciones. Su baterÃ­a de larga duraciÃ³n te garantiza hasta <strong>7 dÃ­as de uso continuo</strong>, lo que te permite olvidarte de cargarlo constantemente.
						</p>
						<p>
							AdemÃ¡s, el Z50 es totalmente compatible con dispositivos iOS y Android, permitiÃ©ndote recibir llamadas, mensajes y notificaciones de aplicaciones directamente en tu muÃ±eca. Con su fÃ¡cil acceso a funciones de salud, notificaciones y entretenimiento, el Z50 es la herramienta ideal para mantenerte conectado y en forma.
						</p>
						<p>
							<strong>CaracterÃ­sticas principales:</strong>
						<ul>
							<li><strong>Pantalla tÃ¡ctil a color de 1.4 pulgadas:</strong> VisualizaciÃ³n clara y fÃ¡cil de usar.</li>
							<li><strong>Monitoreo de frecuencia cardÃ­aca:</strong> Para un control en tiempo real de tu salud.</li>
							<li><strong>Resistencia al agua IP67:</strong> Usable en lluvia, piscina o durante cualquier actividad.</li>
							<li><strong>Notificaciones inteligentes:</strong> Recibe llamadas, mensajes y actualizaciones de apps.</li>
							<li><strong>Seguimiento de actividad fÃ­sica:</strong> Mide tus pasos, calorÃ­as quemadas y distancia recorrida.</li>
							<li><strong>BaterÃ­a de larga duraciÃ³n:</strong> Hasta 7 dÃ­as de uso sin necesidad de recargar.</li>
							<li><strong>Compatibilidad universal:</strong> Funciona con dispositivos iOS y Android.</li>
						</ul>
						</p>
						<p>
							Con el <strong>Smartwatch Z50</strong>, tendrÃ¡s todo lo que necesitas en la palma de tu mano. Â¡Hazte con el tuyo y lleva tu estilo de vida al siguiente nivel!
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
