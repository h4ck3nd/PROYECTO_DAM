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
						<img src="<%= request.getContextPath() %>/img/img_amashop/auriculares-bluetooth.png"
							alt="Auriculares Bluetooth" class="product-image">
						<div class="product-info">
							<h1>Auriculares Bluetooth</h1>
							<p>
								Los <strong>Auriculares Bluetooth</strong> ofrecen una calidad
								de sonido impresionante con un diseÃ±o ergonÃ³mico y moderno. Con
								cancelaciÃ³n de ruido activa, baterÃ­a de larga duraciÃ³n y
								conectividad rÃ¡pida, son ideales para cualquier persona que
								busque disfrutar de su mÃºsica o realizar llamadas sin
								interrupciones.
							</p>
							<ul>
								<li>Conectividad Bluetooth 5.0</li>
								<li>CancelaciÃ³n activa de ruido</li>
								<li>Hasta 20 horas de baterÃ­a</li>
								<li>DiseÃ±o ergonÃ³mico y cÃ³modo</li>
								<li>Compatibles con dispositivos iOS y Android</li>
								<li>MicrÃ³fono incorporado para llamadas</li>
							</ul>
							<button class="add-to-cart" onclick="window.location.href='comprar.jsp'">Comprar ahora</button>
						</div>
					</div>
					<div class="product-description">
						<h2>ð§ Auriculares Bluetooth â Sonido Premium y Confort</h2>
						<p>
							Los <strong>Auriculares Bluetooth</strong> estÃ¡n diseÃ±ados
							para quienes buscan una experiencia sonora inigualable, sin
							comprometer la comodidad ni la durabilidad. Con la mÃ¡s avanzada
							tecnologÃ­a de cancelaciÃ³n activa de ruido, podrÃ¡s sumergirte
							completamente en tu mÃºsica o llamadas sin preocuparte por los
							ruidos externos. Ya sea que estÃ©s en una oficina, en el
							transporte pÃºblico o en un ambiente ruidoso, los X100 eliminan
							las distracciones y te ofrecen una calidad de sonido excepcional.
						</p>
						<p>
							En cuanto al diseÃ±o, los <strong>Auriculares Bluetooth
							</strong> cuentan con un diseÃ±o ergonÃ³mico y ligero que garantiza un
							ajuste cÃ³modo incluso durante largas horas de uso. Sus
							almohadillas de espuma viscoelÃ¡stica se adaptan perfectamente a
							la forma de tus oÃ­dos, brindÃ¡ndote una sensaciÃ³n de confort que
							te permitirÃ¡ disfrutar de tus canciones, podcasts o llamadas
							durante todo el dÃ­a sin molestias. AdemÃ¡s, son lo suficientemente
							ligeros como para ser transportados cÃ³modamente en tu mochila o
							bolso.
						</p>
						<p>
							La baterÃ­a de estos auriculares es uno de sus puntos fuertes, ya
							que ofrece hasta <strong>20 horas de reproducciÃ³n
								continua</strong> con una sola carga. Esto significa que puedes disfrutar
							de tus actividades diarias, ya sea viajando, haciendo ejercicio o
							trabajando, sin tener que preocuparte por quedarte sin baterÃ­a.
							Cuando sea necesario cargar los auriculares, la carga rÃ¡pida te
							permitirÃ¡ volver a usarlos en muy poco tiempo.
						</p>
						<p>
							Los <strong>Auriculares Bluetooth</strong> no solo ofrecen
							una calidad de sonido superior, sino tambiÃ©n un micrÃ³fono
							integrado de alta calidad para realizar llamadas. Gracias a su
							sistema de cancelaciÃ³n de ruido en el micrÃ³fono, las llamadas se
							escuchan claramente y sin interferencias, incluso en entornos
							ruidosos. Esto los convierte en una opciÃ³n ideal para quienes
							necesitan hacer o recibir llamadas mientras estÃ¡n en movimiento,
							ya sea en la calle, en el gimnasio o en el trabajo.
						</p>
						<p>
							Ya sea que seas un amante de la mÃºsica que disfruta de la mejor
							calidad de sonido, un profesional que hace llamadas frecuentes o
							alguien que simplemente busca un dispositivo fiable para uso
							diario, los <strong>Auriculares Bluetooth X100</strong> son la
							opciÃ³n perfecta. Con un sonido impresionante, un diseÃ±o
							ergonÃ³mico, una baterÃ­a de larga duraciÃ³n y un micrÃ³fono de
							calidad, estos auriculares estÃ¡n listos para acompaÃ±arte en todas
							tus actividades.
						</p>
						<p>
							<strong>CaracterÃ­sticas principales:</strong>
						<ul>
							<li><strong>Bluetooth 5.0:</strong> ConexiÃ³n rÃ¡pida y
								estable, con mayor alcance y eficiencia energÃ©tica.</li>
							<li><strong>CancelaciÃ³n activa de ruido:</strong> AÃ­sla el
								sonido exterior para una experiencia mÃ¡s inmersiva.</li>
							<li><strong>Hasta 20 horas de duraciÃ³n de baterÃ­a:</strong>
								ReproducciÃ³n continua durante todo el dÃ­a sin necesidad de
								recargar.</li>
							<li><strong>MicrÃ³fono de alta calidad:</strong> Para
								llamadas claras y nÃ­tidas, incluso en entornos ruidosos.</li>
							<li><strong>DiseÃ±o ergonÃ³mico y cÃ³modo:</strong>
								Almohadillas de espuma viscoelÃ¡stica para un ajuste perfecto.</li>
							<li><strong>Controles tÃ¡ctiles intuitivos:</strong> FÃ¡cil
								manejo de mÃºsica y llamadas con solo deslizar el dedo.</li>
							<li><strong>Compatibilidad universal:</strong> Funciona con
								dispositivos iOS, Android, tabletas, laptops y mÃ¡s.</li>
						</ul>
						</p>
						<p>
							Con los <strong>Auriculares Bluetooth</strong>, tu
							experiencia auditiva serÃ¡ mÃ¡s completa, cÃ³moda y de alta calidad.
							Â¡Hazte con ellos hoy mismo y lleva tu mÃºsica y comunicaciones al
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
