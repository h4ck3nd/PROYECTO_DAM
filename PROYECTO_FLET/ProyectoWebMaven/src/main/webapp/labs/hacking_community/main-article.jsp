<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SQL Injection: Cómo funciona y cómo protegerse</title>
    <style>
  * {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

html, body {
  font-family: 'Inter', sans-serif;
  background-color: #1e212d;
  color: #fff;
  line-height: 1.6;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}

header {
  background-color: #0a0c11;
  padding: 20px 0;
  border-bottom: 1px solid #212430;
  text-align: center;
}

.logo {
  font-size: 1.8rem;
  font-weight: 800;
  color: #00ffae;
}

nav ul {
  list-style: none;
  display: flex;
  gap: 30px;
  justify-content: center;
}

nav a {
  color: #fff;
  text-decoration: none;
  font-weight: 600;
  transition: color 0.3s ease-in-out;
}

nav a:hover {
  color: #00ffae;
}

main h1 {
  font-size: 2rem;
  margin: 30px 0;
  color: #fff;
}

.intro-text {
  margin-top: 20px;
  font-size: 1.1rem;
  color: #ccc;
}

.featured-article img {
  width: 100%;
  border-radius: 8px;
  margin-bottom: 20px;
}

.post-content {
  padding: 20px 0;
}

.post-content h1 {
  font-size: 2rem;
  margin-bottom: 20px;
}

.post-content p {
  margin-bottom: 15px;
  color: #bbb;
}

.post-content ul {
  margin-left: 20px;
  margin-bottom: 15px;
  color: #bbb;
}

.post-content pre {
  background-color: #111;
  padding: 15px;
  border-radius: 6px;
  overflow-x: auto;
  margin-bottom: 20px;
  color: #0f0;
  font-family: monospace;
}

.read-more {
  display: inline-block;
  margin-top: 20px;
  color: #00ffae;
  font-weight: 600;
  text-decoration: none;
}

.read-more:hover {
  text-decoration: underline;
}

footer {
  background-color: #0a0c11;
  padding: 20px;
  text-align: center;
  color: #888;
  margin-top: auto;
}
  
  </style>
</head>
<body>
  <div class="wrapper">
    <header class="container">
      <div class="logo">HACKING COMMUNITY</div>
      <nav>
        <ul>
          <li><a href="hacking_community.jsp">Inicio</a></li>
          <li><a href="contacto.jsp">Contacto</a></li>
        </ul>
      </nav>
    </header>

    <main class="container">
      <article class="featured-article">
        <img src="<%= request.getContextPath() %>/img/img-main-article.avif" alt="Laboratorio de Hacking" />
        <div class="post-content">
          <h1>Cómo crear un laboratorio de hacking en tu PC</h1>
          <p class="intro-text">
            Configura un entorno seguro para practicar hacking ético desde tu ordenador personal.
          </p>
          <p>
            Si quieres iniciarte en el mundo del hacking ético, crear tu propio laboratorio en casa es el mejor primer paso. Este entorno te permite probar vulnerabilidades, explotar máquinas virtuales y aprender sin poner en riesgo a otros usuarios.
          </p>
          <p>
            <strong>¿Qué necesitas?</strong>
            <ul>
              <li>Una máquina con al menos 8 GB de RAM</li>
              <li>VirtualBox o VMware</li>
              <li>Kali Linux como sistema atacante</li>
              <li>Máquinas vulnerables como Metasploitable, OWASP Broken Web Apps, o DVWA</li>
            </ul>
          </p>
          <p>
            Asegúrate de aislar tu red virtual para que las máquinas solo puedan comunicarse entre sí. Esto evita exponer servicios vulnerables a tu red doméstica.
          </p>
          <p>
            Una vez configurado tu entorno, empieza con pruebas básicas como escaneo de puertos con Nmap, escaneos de vulnerabilidades con Nikto o explotación con Metasploit.
          </p>
          <p>
            Con el tiempo, puedes ir agregando nuevos objetivos, simulando escenarios reales y mejorando tus habilidades.
          </p>
          <p>
            La práctica constante es la clave para dominar el hacking ético. ¡Nunca dejes de aprender!
          </p>
          <a href="hacking_community.jsp" class="read-more">Volver al blog</a>
        </div>
      </article>
    </main>
  </div>

  <footer>
    &copy; 2025 HACKING COMMUNITY. Todos los derechos reservados.
  </footer>
</body>
</html>