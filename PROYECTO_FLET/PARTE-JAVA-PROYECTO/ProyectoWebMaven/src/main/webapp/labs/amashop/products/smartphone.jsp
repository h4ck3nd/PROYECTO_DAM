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
						<img src="<%= request.getContextPath() %>/img/img_amashop/smartphone-x100.png"
							alt="Smartphone X300" class="product-image">
						<div class="product-info">
							<h1>Smartphone X100</h1>
							<p>El Smartphone X100 combina diseÃ±o elegante con alto
								rendimiento. Equipado con una pantalla AMOLED de 6.5 pulgadas,
								128 GB de almacenamiento interno y una cÃ¡mara triple de 48 MP, 8
								MP y 2 MP.</p>
							<ul>
								<li>Pantalla AMOLED 6.5"</li>
								<li>Procesador Octa-Core 2.2GHz</li>
								<li>128GB almacenamiento / 6GB RAM</li>
								<li>BaterÃ­a de 4500mAh</li>
								<li>CÃ¡mara triple: 48MP + 8MP + 2MP</li>
								<li>Android 12</li>
							</ul>
							<button class="add-to-cart" onclick="window.location.href='comprar.jsp'">Comprar ahora</button>
						</div>
					</div>
					<div class="product-description">
						<h2>ð± Smartphone X100 â Elegancia, Potencia y TecnologÃ­a
							Avanzada al Alcance de tu Mano</h2>
						<p>
							El <strong>Smartphone X100</strong> es la combinaciÃ³n perfecta
							entre diseÃ±o sofisticado y rendimiento de vanguardia. Este
							dispositivo ha sido creado pensando en quienes buscan la mÃ¡xima
							experiencia mÃ³vil, sin comprometer la elegancia ni la potencia.
							Con un cuerpo delgado y moderno, el X300 estÃ¡ diseÃ±ado para
							destacar en cualquier situaciÃ³n, fusionando estilo con tecnologÃ­a
							avanzada para adaptarse a tu ritmo de vida.
						</p>
						<p>
							En su interior, el <strong>Smartphone X100</strong> alberga una <strong>pantalla
								AMOLED de 6.5 pulgadas</strong>, que ofrece una experiencia visual
							impresionante, ideal para ver tus series y pelÃ­culas favoritas
							con colores vibrantes y negros profundos. Esta pantalla te
							brindarÃ¡ una calidad de imagen inigualable para que disfrutes
							cada detalle en alta definiciÃ³n, desde tus redes sociales hasta
							juegos de alta demanda.
						</p>
						<p>
							Potenciado por un <strong>procesador Octa-Core de 2.2
								GHz</strong>, el X300 garantiza un rendimiento Ã¡gil y fluido en todo
							momento. Ya sea que tengas varias aplicaciones abiertas, estÃ©s
							trabajando en mÃºltiples tareas o jugando tÃ­tulos exigentes, el
							X300 responde sin esfuerzo, brindÃ¡ndote una experiencia sin
							interrupciones. AdemÃ¡s, con <strong>6 GB de RAM</strong>, puedes
							disfrutar de una multitarea sin demoras, asegurando que cada
							acciÃ³n sea rÃ¡pida y eficiente.
						</p>
						<p>
							La autonomÃ­a no es un problema con su baterÃ­a de <strong>4500
								mAh</strong>, que te acompaÃ±arÃ¡ durante todo el dÃ­a sin necesidad de
							recargar. Ya sea que estÃ©s viendo videos, navegando por internet
							o utilizando apps de manera intensiva, el X300 estÃ¡ diseÃ±ado para
							seguir el ritmo de tu vida.
						</p>
						<p>
							En el apartado fotogrÃ¡fico, el <strong>Smartphone X100</strong>
							cuenta con una <strong>cÃ¡mara triple de 48 MP + 8 MP + 2
								MP</strong>, ofreciendo una calidad de imagen excepcional en cualquier
							situaciÃ³n. La cÃ¡mara principal de 48 MP captura fotos nÃ­tidas y
							detalladas, mientras que el lente ultra gran angular de 8 MP te
							permite tomar fotos panorÃ¡micas con una vista amplia. AdemÃ¡s, el
							sensor de 2 MP te ofrece la capacidad de capturar detalles y
							efectos de profundidad para darle un toque profesional a tus
							fotos. Ya sea de dÃ­a o de noche, podrÃ¡s capturar momentos con una
							claridad impresionante.
						</p>
						<p>
							Con <strong>Android 12</strong> como sistema operativo, el X100
							te ofrece una interfaz intuitiva, mayor seguridad y las Ãºltimas
							funciones para que disfrutes de una experiencia fluida y
							personalizada. AdemÃ¡s, con actualizaciones regulares, tu
							dispositivo estarÃ¡ siempre a la vanguardia de la tecnologÃ­a.
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
