<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Qué es CSRF y cómo evitarlo en tu sitio web</title>
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
        <img src="<%= request.getContextPath() %>/img/img-article-three.png" alt="Ataque CSRF" />
        <div class="post-content">
          <h1>Qué es CSRF y cómo evitarlo en tu sitio web</h1>
          <p class="intro-text">
            CSRF es una técnica de ataque que explota la confianza que un sitio web tiene en el navegador del usuario.
          </p>
          <p>
            Un ataque CSRF (Cross-Site Request Forgery) ocurre cuando un atacante engaña a un usuario autenticado para que ejecute acciones no deseadas en una aplicación en la que está autenticado.
          </p>
          <p><strong>¿Cómo funciona?</strong></p>
          <ul>
            <li>El usuario inicia sesión en un sitio web (por ejemplo, su banco).</li>
            <li>Sin cerrar la sesión, el usuario visita un sitio malicioso.</li>
            <li>Ese sitio ejecuta una petición a la web legítima usando las cookies activas del usuario.</li>
          </ul>
          <p><strong>Ejemplo:</strong></p>
          <pre>
&lt;img src="https://tubanco.com/transferir?destino=12345&cantidad=1000"&gt;
          </pre>
          <p><strong>¿Cómo prevenirlo?</strong></p>
          <ul>
            <li>Incluir tokens CSRF en todos los formularios y solicitudes importantes.</li>
            <li>Verificar la cabecera `Origin` o `Referer`.</li>
            <li>Usar SameSite cookies para limitar el envío desde terceros.</li>
          </ul>
          <p>
            CSRF puede pasar desapercibido pero sus consecuencias son críticas. Implementa medidas desde el inicio del desarrollo.
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