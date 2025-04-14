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
						<img src="<%= request.getContextPath() %>/img/img_amashop/Mochila-Gamer.png"
							alt="Smartwatch Z50" class="product-image">
						<div class="product-info">
							<h1>Mochila Gamer</h1>
							<p>
								La <strong>Mochila Gamer</strong> es el accesorio perfecto para
								llevar todo lo que necesitas para tus sesiones de juego, ya sea
								en casa o fuera de ella. Con un diseño moderno, resistente y
								lleno de compartimientos, esta mochila está pensada para gamers
								que buscan comodidad, organización y estilo.
							</p>
							<ul>
								<li>Diseño ergonómico con correas acolchonadas para mayor
									comodidad.</li>
								<li>Amplios compartimentos para laptop, headset, cables y
									otros accesorios.</li>
								<li>Material resistente al agua, ideal para condiciones
									climáticas adversas.</li>
								<li>Espacio adicional para botellas de agua, snacks y otros
									objetos personales.</li>
								<li>Estilo moderno con detalles que destacan tu pasión por
									los videojuegos.</li>
							</ul>
							<button class="add-to-cart" onclick="window.location.href='comprar.jsp'">Comprar ahora</button>
						</div>
					</div>
					<div class="product-description">
						<h2>🎮 Mochila Gamer – Tu compañera ideal para cada aventura</h2>
						<p>
							La <strong>Mochila Gamer</strong> es perfecta para aquellos que
							necesitan llevar su equipo de juego a todas partes. Con un diseño
							exclusivo y cómodo, esta mochila cuenta con compartimientos
							especiales para guardar tu laptop, headset, controladores y todos
							tus accesorios, asegurando que tu equipo esté protegido y
							organizado.
						</p>
						<p>Además de su gran capacidad, la mochila está fabricada con
							materiales resistentes al agua, por lo que podrás llevarla sin
							preocupaciones incluso en días lluviosos. Sus correas
							acolchonadas aseguran una experiencia cómoda, incluso cuando
							transportas equipo pesado, mientras que su estilo moderno
							reflejará tu pasión por los videojuegos.</p>
						<p>Con una variedad de compartimientos, la mochila también te
							permitirá guardar tus objetos personales como botellas de agua,
							snacks, y otros accesorios que necesites durante tus sesiones de
							juego o mientras te desplazas a eventos de gaming.</p>
						<p>
							<strong>Características principales:</strong>
						<ul>
							<li><strong>Diseño ergonómico:</strong> Correaje acolchonado
								para mayor comodidad y soporte.</li>
							<li><strong>Compartimientos amplios:</strong> Espacio para
								laptop, headset, controles y más.</li>
							<li><strong>Material resistente al agua:</strong> Ideal para
								todo clima.</li>
							<li><strong>Estilo gamer único:</strong> Diseño que refleja
								tu pasión por los videojuegos.</li>
							<li><strong>Comodidad y organización:</strong> Guarda y
								organiza todos tus accesorios de manera eficiente.</li>
						</ul>
						</p>
						<p>
							La <strong>Mochila Gamer</strong> es el compañero ideal para
							llevar tu equipo de juego con estilo y comodidad. ¡Hazte con la
							tuya y prepárate para llevar tus aventuras de gaming al siguiente
							nivel!
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
