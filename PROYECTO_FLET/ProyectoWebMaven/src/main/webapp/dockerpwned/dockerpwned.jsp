<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>DOCKERPWNED</title>
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
      background-color: #121212;
      color: #f0f0f0;
    }

    header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 15px 30px;
      background-color: #1e1e1e;
      border-bottom: 1px solid #333;
    }

    .logo-text {
      display: flex;
      align-items: center;
      font-size: 20px;
      font-weight: bold;
      color: #00d1b2;
    }

    .logo-text img {
      height: 28px;
      margin-right: 10px;
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

    section {
      max-width: 1000px;
      margin: 50px auto;
      padding: 0 20px;
    }

    h1, h2 {
      color: #00d1b2;
    }

    p {
      font-size: 18px;
      line-height: 1.7;
      margin-bottom: 20px;
    }

    .benefits, .how-it-works {
      margin-top: 60px;
    }

    .benefits ul, .how-it-works ol {
      padding-left: 20px;
    }

    .benefits li, .how-it-works li {
      margin-bottom: 12px;
      font-size: 17px;
    }

    .cta {
  background-color: #1a1a1a;
  padding: 50px 20px;
  border-radius: 12px;
  margin-top: 80px;
  text-align: center;
}

.cta h2 {
  color: #00d1b2;
  font-size: 2em;
  margin-bottom: 20px;
}

.cta p {
  color: #ddd;
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
      margin-top: 60px;
      background-color: #1e1e1e;
      border-top: 1px solid #333;
      font-size: 14px;
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
    <div class="logo-text">
      <img src="https://www.docker.com/wp-content/uploads/2022/03/vertical-logo-monochromatic.png" alt="logo" />
      DOCKERPWNED
    </div>
    <div class="window-buttons">
		<button class="minimize" title="Minimizar">🗕</button>
		<button class="maximize" title="Maximizar">🗖</button>
		<button onclick="window.location.href='<%= request.getContextPath() %>/dockerpwned/dockerpwned_home.jsp'" class="close" title="Cerrar">✕</button>
	</div>
  </header>

  <section>
  <h1 class="typewriter" data-text="DOCKERPWNED"></h1>
  <p>
    DOCKERPWNED es una plataforma centrada en la formación práctica en seguridad web ofensiva, con laboratorios reproducibles en contenedores Docker.
    Nos inspiramos en la simplicidad, flexibilidad y potencia de Docker para crear entornos controlados donde puedas aprender hacking ético de forma responsable.
  </p>
  <p>
    Desde laboratorios de iniciación hasta escenarios avanzados, cada entorno está diseñado con una única misión:
    enseñarte a identificar y explotar vulnerabilidades reales en un entorno seguro, legal y educativo.
  </p>
</section>

<section>
  <h2 class="typewriter" data-text="🗂️ ¿Por qué usar DOCKERPWNED?"></h2>
  <ul>
    <li>Laboratorios 100% aislados, sin riesgos para tu equipo ni red local.</li>
    <li>Escenarios realistas y actualizados con tecnologías modernas.</li>
    <li>Sin necesidad de instalaciones complicadas: descarga y ejecuta con Docker.</li>
    <li>Perfecto para preparar certificaciones, CTFs o mejorar tus habilidades ofensivas.</li>
    <li>Enfoque educativo y ético: aprende cómo se explotan y cómo se mitigan vulnerabilidades.</li>
  </ul>
</section>

<section>
  <h2 class="typewriter" data-text="🛠️ ¿Cómo funciona?"></h2>
  <ol>
    <li>Explora el catálogo de laboratorios (disponible próximamente).</li>
    <li>Descarga el contenedor con un solo clic.</li>
    <li>Levanta el entorno con Docker en tu máquina.</li>
    <li>Sigue las instrucciones y empieza a atacar legalmente.</li>
    <li>Aprende, rompe, repara y repite.</li>
  </ol>
</section>

<section>
  <h2 class="typewriter" data-text="Empieza tu viaje en el hacking ético"></h2>
  <p>
    <strong>DOCKERPWNED</strong> está diseñado para que puedas practicar técnicas de hacking web en un entorno completamente seguro y controlado.
    Aprende cómo piensan los atacantes, mejora tus habilidades defensivas y experimenta con entornos realistas desde tu propio equipo.
  </p>
  <p>
    Próximamente podrás descargar los primeros laboratorios desde esta misma página.
    Mantente atento y prepárate para poner a prueba tu conocimiento.
  </p>
</section>

<footer>
  <strong>© HACKEND 2025 | DOCKERPWNED</strong>
</footer>
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
