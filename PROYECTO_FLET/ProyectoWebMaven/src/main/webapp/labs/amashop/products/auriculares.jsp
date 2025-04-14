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
	flex: 1; /* ð¥ Esto lo hace crecer verticalmente */
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
				<h3>CategorÃ­as</h3>
				<ul>
					<li><a href="#">TecnologÃ­a</a></li>
					<li><a href="#">Hogar</a></li>
					<li><a href="#">Ropa</a></li>
					<li><a href="#">Deportes</a></li>
					<li><a href="#">Libros</a></li>
				</ul>
			</aside>

			<div class="product-detail">
				<div class="product-card">
					<div class="product-header">
						<img src="<%= request.getContextPath() %>/img/img_amashop/auriculares-bluetooth.png"
							alt="Auriculares Bluetooth" class="product-image">
						<div class="product-info">
							<h1>Auriculares Bluetooth</h1>
							<p>
								Los <strong>Auriculares Bluetooth</strong> ofrecen una calidad
								de sonido impresionante con un diseño ergonómico y moderno. Con
								cancelación de ruido activa, batería de larga duración y
								conectividad rápida, son ideales para cualquier persona que
								busque disfrutar de su música o realizar llamadas sin
								interrupciones.
							</p>
							<ul>
								<li>Conectividad Bluetooth 5.0</li>
								<li>Cancelación activa de ruido</li>
								<li>Hasta 20 horas de batería</li>
								<li>Diseño ergonómico y cómodo</li>
								<li>Compatibles con dispositivos iOS y Android</li>
								<li>Micrófono incorporado para llamadas</li>
							</ul>
							<button class="add-to-cart" onclick="window.location.href='comprar.jsp'">Comprar ahora</button>
						</div>
					</div>
					<div class="product-description">
						<h2>🎧 Auriculares Bluetooth – Sonido Premium y Confort</h2>
						<p>
							Los <strong>Auriculares Bluetooth</strong> están diseñados
							para quienes buscan una experiencia sonora inigualable, sin
							comprometer la comodidad ni la durabilidad. Con la más avanzada
							tecnología de cancelación activa de ruido, podrás sumergirte
							completamente en tu música o llamadas sin preocuparte por los
							ruidos externos. Ya sea que estés en una oficina, en el
							transporte público o en un ambiente ruidoso, los X100 eliminan
							las distracciones y te ofrecen una calidad de sonido excepcional.
						</p>
						<p>
							En cuanto al diseño, los <strong>Auriculares Bluetooth
							</strong> cuentan con un diseño ergonómico y ligero que garantiza un
							ajuste cómodo incluso durante largas horas de uso. Sus
							almohadillas de espuma viscoelástica se adaptan perfectamente a
							la forma de tus oídos, brindándote una sensación de confort que
							te permitirá disfrutar de tus canciones, podcasts o llamadas
							durante todo el día sin molestias. Además, son lo suficientemente
							ligeros como para ser transportados cómodamente en tu mochila o
							bolso.
						</p>
						<p>
							La batería de estos auriculares es uno de sus puntos fuertes, ya
							que ofrece hasta <strong>20 horas de reproducción
								continua</strong> con una sola carga. Esto significa que puedes disfrutar
							de tus actividades diarias, ya sea viajando, haciendo ejercicio o
							trabajando, sin tener que preocuparte por quedarte sin batería.
							Cuando sea necesario cargar los auriculares, la carga rápida te
							permitirá volver a usarlos en muy poco tiempo.
						</p>
						<p>
							Los <strong>Auriculares Bluetooth</strong> no solo ofrecen
							una calidad de sonido superior, sino también un micrófono
							integrado de alta calidad para realizar llamadas. Gracias a su
							sistema de cancelación de ruido en el micrófono, las llamadas se
							escuchan claramente y sin interferencias, incluso en entornos
							ruidosos. Esto los convierte en una opción ideal para quienes
							necesitan hacer o recibir llamadas mientras están en movimiento,
							ya sea en la calle, en el gimnasio o en el trabajo.
						</p>
						<p>
							Ya sea que seas un amante de la música que disfruta de la mejor
							calidad de sonido, un profesional que hace llamadas frecuentes o
							alguien que simplemente busca un dispositivo fiable para uso
							diario, los <strong>Auriculares Bluetooth X100</strong> son la
							opción perfecta. Con un sonido impresionante, un diseño
							ergonómico, una batería de larga duración y un micrófono de
							calidad, estos auriculares están listos para acompañarte en todas
							tus actividades.
						</p>
						<p>
							<strong>Características principales:</strong>
						<ul>
							<li><strong>Bluetooth 5.0:</strong> Conexión rápida y
								estable, con mayor alcance y eficiencia energética.</li>
							<li><strong>Cancelación activa de ruido:</strong> Aísla el
								sonido exterior para una experiencia más inmersiva.</li>
							<li><strong>Hasta 20 horas de duración de batería:</strong>
								Reproducción continua durante todo el día sin necesidad de
								recargar.</li>
							<li><strong>Micrófono de alta calidad:</strong> Para
								llamadas claras y nítidas, incluso en entornos ruidosos.</li>
							<li><strong>Diseño ergonómico y cómodo:</strong>
								Almohadillas de espuma viscoelástica para un ajuste perfecto.</li>
							<li><strong>Controles táctiles intuitivos:</strong> Fácil
								manejo de música y llamadas con solo deslizar el dedo.</li>
							<li><strong>Compatibilidad universal:</strong> Funciona con
								dispositivos iOS, Android, tabletas, laptops y más.</li>
						</ul>
						</p>
						<p>
							Con los <strong>Auriculares Bluetooth</strong>, tu
							experiencia auditiva será más completa, cómoda y de alta calidad.
							¡Hazte con ellos hoy mismo y lleva tu música y comunicaciones al
							siguiente nivel!
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
