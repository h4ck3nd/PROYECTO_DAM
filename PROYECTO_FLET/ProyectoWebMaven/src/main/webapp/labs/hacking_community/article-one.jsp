<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Cómo crear un laboratorio de hacking en tu PC</title>
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

.wrapper {
  flex: 1;
}

/* CONTENEDOR GENERAL */
.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}

/* HEADER */
header {
  background-color: #0a0c11;
  padding: 20px 0;
  border-bottom: 1px solid #212430;
  display: flex;
  flex-direction: column;
  gap: 20px;
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

/* TEXTO PRINCIPAL */
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

/* ARTÍCULO DESTACADO Y PÁGINAS INDIVIDUALES */
.featured-article img {
  width: 100%;
  height: auto;
  border-radius: 8px;
  margin-bottom: 20px;
}

.featured-article .post-content {
  background-color: #2e323d;
  padding: 30px;
  border-radius: 8px;
  box-shadow: 0 4px 10px rgba(0, 255, 174, 0.2);
}

.featured-article .post-content h1 {
  font-size: 2.2rem;
  color: #00ffae;
  margin-bottom: 15px;
}

.featured-article .post-content p {
  margin-bottom: 15px;
  color: #ccc;
}

.featured-article .post-content strong {
  color: #00ffae;
}

.featured-article .post-content ul {
  margin: 10px 0 20px 20px;
  list-style: disc;
}

.featured-article .post-content li {
  margin-bottom: 10px;
  color: #bbb;
}

.featured-article .read-more {
  display: inline-block;
  margin-top: 20px;
  color: #00ffae;
  font-weight: 600;
  text-decoration: none;
}

.featured-article .read-more:hover {
  text-decoration: underline;
}

/* BLOG POSTS GRID (para index.html) */
.blog-posts {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(500px, 1fr));
  gap: 30px;
  margin-top: 40px;
}

.post {
  background-color: #2e323d;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 4px 10px rgba(0, 255, 174, 0.2);
  transition: transform 0.3s ease;
}

.post:hover {
  transform: translateY(-5px);
}

.post img {
  width: 100%;
  height: auto;
}

.post-content {
  padding: 20px;
}

.post-content h2 {
  font-size: 1.4rem;
  margin-bottom: 10px;
}

.post-content h2 a {
  text-decoration: none;
  color: inherit;
}

.post-content p {
  color: #bbb;
  margin-bottom: 15px;
}

.read-more {
  color: #00ffae;
  font-weight: 600;
  text-decoration: none;
}

.read-more:hover {
  text-decoration: underline;
}

/* PAGINACIÓN (si la necesitas más adelante) */
.pagination {
  display: flex;
  justify-content: space-between;
  margin-top: 30px;
}

.page-link {
  color: #00ffae;
  font-weight: 600;
  text-decoration: none;
}

.page-link:hover {
  text-decoration: underline;
}

/* FOOTER */
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
          <img src="<%= request.getContextPath() %>/img/img-article-one.jpeg" alt="Herramientas de escaneo" />
          <div class="post-content">
            <h1>Top 5 herramientas de escaneo para hacking ético</h1>
            <p class="intro-text">
              Estas herramientas te ayudarán a descubrir puertos abiertos, servicios activos y vulnerabilidades potenciales.
            </p>
            <p>
              En el mundo del hacking ético, el reconocimiento es una fase esencial. Por eso, contar con buenas herramientas de escaneo puede marcar la diferencia entre una prueba efectiva y una superficial.
            </p>
            <p><strong>1. Nmap:</strong> El rey del escaneo de puertos. Puede detectar sistemas operativos, servicios y versiones.</p>
            <p><strong>2. Masscan:</strong> Ideal para escaneos ultra rápidos a gran escala. Similar a Nmap pero mucho más veloz.</p>
            <p><strong>3. Nikto:</strong> Escáner de vulnerabilidades web centrado en servidores HTTP/HTTPS. Muy útil para auditorías rápidas.</p>
            <p><strong>4. WhatWeb:</strong> Herramienta de reconocimiento web que identifica tecnologías usadas en sitios web (CMS, frameworks, etc.).</p>
            <p><strong>5. Shodan:</strong> No es una herramienta local, sino un motor de búsqueda que permite encontrar dispositivos conectados a internet.</p>
            <p>
              Estas herramientas combinadas te ofrecen una visión amplia del entorno objetivo. Recuerda siempre usarlas de manera ética y legal.
            </p>
            <a href="hacking_community.jsp" class="read-more"> Volver al blog</a>
          </div>
        </article>
      </main>
    </div>
  
    <footer>
      &copy; 2025 HACKING COMMUNITY. Todos los derechos reservados.
    </footer>
</body>
</html>
