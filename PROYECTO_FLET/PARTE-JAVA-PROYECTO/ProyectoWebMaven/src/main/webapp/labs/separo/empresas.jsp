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
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/png" href="<%= request.getContextPath() %>/img/icono/icono_cinco_hackend.ico">
<title>Empresas | SEPARO</title>
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

/* Página Empresas */
.seccion-empresas {
	padding: 2rem;
	background-color: #ffffff;
}

.seccion-empresas h2 {
	color: #002855;
	text-align: center;
	margin-bottom: 1rem;
}

.seccion-empresas p {
	text-align: center;
	margin-bottom: 2rem;
	color: #003366;
}

.tarjetas-empresas {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
	gap: 1.5rem;
	max-width: 1000px;
	margin: 0 auto;
}

.empresa {
	background-color: #e6f0ff;
	border-radius: 8px;
	padding: 1.5rem;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}

.empresa h3 {
	margin-top: 0;
	color: #003366;
}

.empresa p {
	margin: 0.5rem 0 1rem;
	color: #003366;
}

.empresa a {
	display: inline-block;
	background-color: #003366;
	color: #fff;
	padding: 0.5rem 1rem;
	border-radius: 4px;
	text-decoration: none;
	font-weight: bold;
}

.empresa a:hover {
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

		<main class="seccion-empresas">
			<h2>Empresas que buscan talento</h2>
			<p>Estas empresas están activamente contratando y se publicitan
				en SEPARO para encontrar nuevos profesionales.</p>

			<div class="tarjetas-empresas">
				<div class="empresa">
					<h3>TechNova</h3>
					<p>Buscamos desarrolladores full-stack para nuevos proyectos
						tecnológicos. Modalidad híbrida.</p>
					<a href="#">Ver detalles</a>
				</div>

				<div class="empresa">
					<h3>Salud Vital</h3>
					<p>Centro médico privado busca personal de enfermería y
						recepción. Contrato fijo.</p>
					<a href="#">Ver detalles</a>
				</div>

				<div class="empresa">
					<h3>TransLogística</h3>
					<p>Se necesitan conductores con carnet C+E. Jornada completa.
						Trabajo nacional e internacional.</p>
					<a href="#">Ver detalles</a>
				</div>

				<div class="empresa">
					<h3>EcoAgrícola</h3>
					<p>Ofertas en mantenimiento agrícola, operarios y técnicos de
						campo. Zona rural.</p>
					<a href="#">Ver detalles</a>
				</div>
				<div class="empresa">
					<h3>SmartTech Solutions</h3>
					<p>Estamos buscando ingenieros de software para un proyecto
						innovador de IA. Modalidad remota.</p>
					<a href="#">Ver detalles</a>
				</div>

				<div class="empresa">
					<h3>FinanCorp</h3>
					<p>Consultora financiera requiere analistas de datos y asesores
						en finanzas corporativas. Trabajo a tiempo completo.</p>
					<a href="#">Ver detalles</a>
				</div>
			</div>
	</div>
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
