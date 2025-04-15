<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Buscar Empleo | SEPARO</title>
<style>
/* General */
body {
	margin: 0;
	font-family: Arial, sans-serif;
	background-color: #f4f6f9;
	color: #003366;
}

.contenedor {
	display: flex;
	flex-direction: column;
	min-height: 100vh;
}

/* Header */
header {
	background-color: #003366;
	color: white;
}

.top-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 1rem;
	flex-wrap: wrap;
}

.logo h1 {
	margin: 0;
	font-size: 1.8rem;
}

.buscador {
	display: flex;
	gap: 0.5rem;
}

.buscador input {
	padding: 0.5rem;
	border-radius: 4px;
	border: none;
	width: 200px;
}

.buscador button {
	background-color: #ffd700;
	color: #003366;
	border: none;
	padding: 0.5rem 1rem;
	cursor: pointer;
	font-weight: bold;
	border-radius: 4px;
}

nav.menu-principal {
	background-color: #002244;
}

nav.menu-principal ul {
	list-style: none;
	display: flex;
	justify-content: center;
	margin: 0;
	padding: 0.5rem;
	flex-wrap: wrap;
}

nav.menu-principal li {
	margin: 0 1rem;
}

nav.menu-principal a {
	color: white;
	text-decoration: none;
	font-weight: bold;
	padding: 0.5rem;
}

nav.menu-principal a:hover {
	background-color: #00509e;
	border-radius: 4px;
}

/* Página Buscar Empleo */
.buscar-empleo {
	flex: 1;
	padding: 2rem;
	background-color: #ffffff;
}

.formulario-cv {
	max-width: 600px;
	margin: 0 auto;
	background-color: #e6f0ff;
	padding: 2rem;
	border-radius: 8px;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}

.formulario-cv h2 {
	color: #002855;
	margin-bottom: 1rem;
}

.formulario-cv label {
	font-weight: bold;
	color: #003366;
}

.formulario-cv input[type="text"], .formulario-cv input[type="email"],
	.formulario-cv input[type="file"] {
	width: 100%;
	padding: 0.5rem;
	margin-top: 0.3rem;
	margin-bottom: 1rem;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.formulario-cv button {
	background-color: #003366;
	color: #fff;
	padding: 0.6rem 1.2rem;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-weight: bold;
}

.formulario-cv button:hover {
	background-color: #004080;
}

/* Footer */
footer {
	background-color: #003366;
	color: white;
	text-align: center;
	padding: 1rem;
	position: relative;
}

.footer-links {
	margin-top: 0.5rem;
}

.footer-links a {
	color: white;
	margin: 0 0.5rem;
	text-decoration: none;
}

.footer-links a:hover {
	text-decoration: underline;
}
</style>
</head>
<body>
	<div class="contenedor">
		<header>
			<div class="top-bar">
				<div class="logo">
					<h1>SEPARO</h1>
				</div>
				<div class="buscador">
					<input type="text" placeholder="Buscar...">
					<button>Buscar</button>
				</div>
			</div>

			<nav class="menu-principal">
				<ul>
					<li><a href="separo.jsp">Inicio</a></li>
					<li><a href="empresas.jsp">Empresas</a></li>
					<li><a href="buscar-empleo.jsp">Empleo</a></li>
					<li><a href="#">Formación</a></li>
					<li><a href="#">Prestaciones</a></li>
				</ul>
			</nav>
		</header>

		<main class="buscar-empleo">
			<section class="formulario-cv">
				<h2>Sube tu Currículum</h2>
				<p>Envía tu currículum y te notificaremos cuando haya una oferta
					adecuada a tu perfil.</p>

				<form action="#" method="post" enctype="multipart/form-data">
					<label for="nombre">Nombre completo:</label><br> <input
						type="text" id="nombre" name="nombre" required><br>
					<br> <label for="email">Correo electrónico:</label><br> <input
						type="email" id="email" name="email" required><br>
					<br> <label for="archivo">Selecciona tu currículum:</label><br>
					<input type="file" id="archivo" name="archivo"
						accept=".pdf,.doc,.docx" required><br>
					<br>

					<button type="submit">Enviar Currículum</button>
				</form>
			</section>
		</main>

		<footer>
			<p>&copy; 2025 SEPARO. Todos los derechos reservados.</p>
			<div class="footer-links">
				<a href="#">Aviso legal</a> <a href="#">Política de privacidad</a> <a
					href="#">Accesibilidad</a>
			</div>
		</footer>
	</div>
</body>
</html>
