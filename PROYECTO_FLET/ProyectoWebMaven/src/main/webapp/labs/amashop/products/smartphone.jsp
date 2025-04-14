<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
	flex: 1; /* 🔥 Esto lo hace crecer verticalmente */
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
				<h3>Categorías</h3>
				<ul>
					<li><a href="#">Tecnología</a></li>
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
							<p>El Smartphone X100 combina diseño elegante con alto
								rendimiento. Equipado con una pantalla AMOLED de 6.5 pulgadas,
								128 GB de almacenamiento interno y una cámara triple de 48 MP, 8
								MP y 2 MP.</p>
							<ul>
								<li>Pantalla AMOLED 6.5"</li>
								<li>Procesador Octa-Core 2.2GHz</li>
								<li>128GB almacenamiento / 6GB RAM</li>
								<li>Batería de 4500mAh</li>
								<li>Cámara triple: 48MP + 8MP + 2MP</li>
								<li>Android 12</li>
							</ul>
							<button class="add-to-cart" onclick="window.location.href='comprar.jsp'">Comprar ahora</button>
						</div>
					</div>
					<div class="product-description">
						<h2>📱 Smartphone X100 – Elegancia, Potencia y Tecnología
							Avanzada al Alcance de tu Mano</h2>
						<p>
							El <strong>Smartphone X100</strong> es la combinación perfecta
							entre diseño sofisticado y rendimiento de vanguardia. Este
							dispositivo ha sido creado pensando en quienes buscan la máxima
							experiencia móvil, sin comprometer la elegancia ni la potencia.
							Con un cuerpo delgado y moderno, el X300 está diseñado para
							destacar en cualquier situación, fusionando estilo con tecnología
							avanzada para adaptarse a tu ritmo de vida.
						</p>
						<p>
							En su interior, el <strong>Smartphone X100</strong> alberga una <strong>pantalla
								AMOLED de 6.5 pulgadas</strong>, que ofrece una experiencia visual
							impresionante, ideal para ver tus series y películas favoritas
							con colores vibrantes y negros profundos. Esta pantalla te
							brindará una calidad de imagen inigualable para que disfrutes
							cada detalle en alta definición, desde tus redes sociales hasta
							juegos de alta demanda.
						</p>
						<p>
							Potenciado por un <strong>procesador Octa-Core de 2.2
								GHz</strong>, el X300 garantiza un rendimiento ágil y fluido en todo
							momento. Ya sea que tengas varias aplicaciones abiertas, estés
							trabajando en múltiples tareas o jugando títulos exigentes, el
							X300 responde sin esfuerzo, brindándote una experiencia sin
							interrupciones. Además, con <strong>6 GB de RAM</strong>, puedes
							disfrutar de una multitarea sin demoras, asegurando que cada
							acción sea rápida y eficiente.
						</p>
						<p>
							La autonomía no es un problema con su batería de <strong>4500
								mAh</strong>, que te acompañará durante todo el día sin necesidad de
							recargar. Ya sea que estés viendo videos, navegando por internet
							o utilizando apps de manera intensiva, el X300 está diseñado para
							seguir el ritmo de tu vida.
						</p>
						<p>
							En el apartado fotográfico, el <strong>Smartphone X100</strong>
							cuenta con una <strong>cámara triple de 48 MP + 8 MP + 2
								MP</strong>, ofreciendo una calidad de imagen excepcional en cualquier
							situación. La cámara principal de 48 MP captura fotos nítidas y
							detalladas, mientras que el lente ultra gran angular de 8 MP te
							permite tomar fotos panorámicas con una vista amplia. Además, el
							sensor de 2 MP te ofrece la capacidad de capturar detalles y
							efectos de profundidad para darle un toque profesional a tus
							fotos. Ya sea de día o de noche, podrás capturar momentos con una
							claridad impresionante.
						</p>
						<p>
							Con <strong>Android 12</strong> como sistema operativo, el X100
							te ofrece una interfaz intuitiva, mayor seguridad y las últimas
							funciones para que disfrutes de una experiencia fluida y
							personalizada. Además, con actualizaciones regulares, tu
							dispositivo estará siempre a la vanguardia de la tecnología.
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
