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
<title>OVALABS - Máquinas Virtuales para Hacking Web</title>
<style>
body {
	background-color: #111;
	color: #ff9933;
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
}

header {
	background-color: #1a1a1a;
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 15px 30px;
	position: relative;
}

.logo {
	display: flex;
	align-items: center;
	gap: 10px;
}

.logo img {
	height: 40px;
}

.logo span {
	font-size: 1.5em;
	font-weight: bold;
	color: #ff9933;
}

.window-buttons {
	display: flex;
	gap: 8px;
	position: absolute;
	right: 20px;
}

.window-buttons button {
	background: transparent;
	border: none;
	color: #ccc;
	font-size: 16px;
	cursor: pointer;
	padding: 4px 8px;
	transition: background 0.2s ease, color 0.2s ease;
	border-radius: 4px;
}

.window-buttons button:hover {
	background-color: #333;
}

.window-buttons .close:hover {
	background-color: #c0392b;
	color: #fff;
}

.window-buttons .minimize:hover, .window-buttons .maximize:hover {
	background-color: #555;
	color: #fff;
}

.intro {
	max-width: 800px;
	margin: 80px auto 40px auto;
	padding: 0 20px;
	text-align: center;
}

.intro h1 {
	color: #ff9933;
	font-size: 2.5em;
	margin-bottom: 20px;
}

.intro p {
	color: #ffffff;
	font-size: 1.1em;
	margin-bottom: 15px;
}

.benefits {
	max-width: 800px;
	margin: 60px auto;
	padding: 0 20px;
	text-align: center;
}

.benefits h2 {
	color: #ff9933;
	margin-bottom: 20px;
}

.benefits ul {
	list-style: none;
	padding: 0;
}

.benefits li {
	font-size: 1.1em;
	margin: 10px 0;
	color: #ffffff;
}

.cta {
	background-color: #1a1a1a;
	padding: 50px 20px;
	border-radius: 12px;
	margin: 60px auto;
	text-align: center;
	max-width: 1000px;
}

.cta h2 {
	color: #ff9933;
	font-size: 2em;
	margin-bottom: 20px;
}

.cta p {
	color: #ffffff;
	font-size: 1.1em;
	margin-bottom: 15px;
	max-width: 800px;
	margin-left: auto;
	margin-right: auto;
}

.cta img {
	max-width: 100%;
	margin-top: 30px;
	border-radius: 12px;
	box-shadow: 0 0 10px #000;
}

footer {
	text-align: center;
	padding: 20px;
	color: #999;
	background-color: #1a1a1a;
	font-size: 0.9em;
	margin-top: 80px;
}
.typewriter-cursor::after {
      content: '_';
      animation: blink 1s step-start infinite;
      display: inline-block;
    }

    @keyframes blink {
      50% { opacity: 0; }
    }
</style>
</head>
<body>
	<header>
		<div class="logo">
			<img src="<%= request.getContextPath() %>/img/ovalabs.png" alt="Logo" /> <span>OVALABS</span>
		</div>
		<div class="window-buttons">
			<button class="minimize" title="Minimizar">🗕</button>
			<button class="maximize" title="Maximizar">🗖</button>
			<button onclick="window.location.href='<%= request.getContextPath() %>/ovalabs/home_directory_ovalabs/home_ovalabs.jsp?page=0'" class="close" title="Cerrar">✕</button>
		</div>
	</header>

	<main>
		<section class="intro">
			<h1 class="typewriter" data-text="Máquinas Virtuales para Hacking Web"></h1>
			<p>DOCKERPWNED te ofrece un catálogo de máquinas virtuales (.ova)
				diseñadas para entrenar tus habilidades en ciberseguridad ofensiva.
				Importa, lanza, explora y aprende en entornos realistas creados
				específicamente para simular vulnerabilidades comunes en
				aplicaciones web.</p>
			<p>
				Estas máquinas están listas para ejecutarse en <strong>VirtualBox</strong>
				y no requieren configuración adicional. Cada una incluye
				documentación básica sobre el escenario, las tecnologías
				involucradas y los vectores de ataque recomendados.
			</p>
		</section>

		<section class="benefits">
			<h2 class="typewriter" data-text="¿Qué obtienes con nuestras máquinas .OVA?"></h2>
			<ul>
				<li>✅ Entornos realistas y reproducibles para práctica libre.</li>
				<li>✅ Escenarios enfocados en OWASP Top 10, bypasses de
					autenticación, LFI, RCE, XSS y más.</li>
				<li>✅ Máquinas creadas para todos los niveles: desde
					introducción hasta pruebas avanzadas.</li>
				<li>✅ Documentación incluida con cada entorno.</li>
			</ul>
		</section>

		<section class="cta">
			<img src="https://cdn.pixabay.com/photo/2019/12/18/05/19/hacker-4703109_640.jpg" alt="Máquina virtual para ciberseguridad" width="380px" height="300px"/>
			<h2 class="typewriter" data-text="Explora, aprende y domina el hacking web"></h2>
			<p>Las máquinas estarán disponibles muy pronto. Prepárate para
				importar .ova directamente en tu VirtualBox y comenzar a
				experimentar con configuraciones vulnerables sin afectar tu equipo
				principal.</p>
			<p>Todos los entornos están pensados para el aprendizaje
				autodidacta y el perfeccionamiento profesional. Síguenos para estar
				al tanto del lanzamiento.</p>
		</section>
	</main>

	<footer> © HACKEND 2025 | OVALABS </footer>
	<script>
  document.addEventListener("DOMContentLoaded", () => {
    const elements = document.querySelectorAll(".typewriter");

    elements.forEach((el) => {
      const text = el.getAttribute("data-text");
      let index = 0;

      const cursorSpan = document.createElement("span");
      cursorSpan.className = "typewriter-cursor";
      el.appendChild(cursorSpan);

      const type = () => {
        if (index < text.length) {
          el.insertBefore(document.createTextNode(text.charAt(index)), cursorSpan);
          index++;
          setTimeout(type, 70); // velocidad de escritura
        }
      };

      type();
    });
  });
</script>
</body>
</html>