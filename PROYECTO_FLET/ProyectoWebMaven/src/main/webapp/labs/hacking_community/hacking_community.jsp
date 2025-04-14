<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="dao.LaboratorioDAO" %>
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

 // Obtener el lab_id de "amashop" desde la base de datos
    int labId = LaboratorioDAO.obtenerIdLaboratorioHacking_community();
    String mensaje = "";

    // Recuperamos el mensaje desde la URL
    String resultadoFlag = request.getParameter("mensaje");
%>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>HACKING COMMUNITY | Blog</title>
  <style>
	* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

html, body {
  height: 100%;
  font-family: 'Inter', sans-serif;
  background-color: #1e212d;
  color: #fff;
  line-height: 1.6;
}

body {
  display: flex;
  flex-direction: column;
}

.wrapper {
  flex: 1;
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
  display: flex;
  flex-direction: column;
}

.logo {
  font-size: 1.8rem;
  font-weight: 800;
  color: #00ffae;
  margin-bottom: 10px;
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

/* Artículo destacado */
.featured-article {
  background-color: #2e323d;
  border-radius: 10px;
  overflow: hidden;
  box-shadow: 0 6px 12px rgba(0, 255, 174, 0.2);
  margin-bottom: 50px;
}

.featured-article img {
  width: 100%;
  height: auto;
  display: block;
}

.featured-article .post-content {
  padding: 25px;
}

.featured-article h1 {
  font-size: 2rem;
  margin-bottom: 15px;
}

.featured-article .intro-text {
  font-size: 1.1rem;
  margin-bottom: 20px;
}

.featured-article .read-more {
  color: #00ffae;
  font-weight: 600;
  text-decoration: none;
}

.featured-article .read-more:hover {
  text-decoration: underline;
}

/* Últimos artículos */
.blog-posts {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(500px, 1fr));
  gap: 30px;
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


.flag-input-section {
  margin-top: 40px;
  padding: 20px;
  background-color: #2e323d;
  border-radius: 8px;
  box-shadow: 0 4px 10px rgba(0, 255, 174, 0.15);
  text-align: center;
}

.flag-input-section h3 {
  color: #00ffae;
  margin-bottom: 15px;
  font-size: 1.2rem;
}

.flag-input-section input[type="text"] {
  padding: 10px 15px;
  border: none;
  border-radius: 5px;
  width: 60%;
  max-width: 400px;
  font-size: 1rem;
  margin-right: 10px;
  text-align: center;
}

.flag-input-section button {
  padding: 10px 20px;
  background-color: #00ffae;
  color: #1e212d;
  border: none;
  border-radius: 5px;
  font-weight: bold;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.flag-input-section button:hover {
  background-color: #00e6a0;
}

footer {
  background-color: #0a0c11;
  padding: 20px;
  text-align: center;
  color: #888;
}
  </style>
</head>
<body>
  <div class="wrapper">
    <header>
      <div class="container">
        <div class="logo">HACKING COMMUNITY</div>
        <nav>
          <ul>
            <li><a href="hacking_community.jsp">Inicio</a></li>
            <li><a href="contacto.jsp">Contacto</a></li>
          </ul>
        </nav>
      </div>
    </header>

  <div class="flag-input-section">
  <h3>Introduce la flag del laboratorio</h3>
  <form action="<%= request.getContextPath() %>/validarFlag" method="get" class="flag-form">
            <input type="hidden" name="user_id" value="<%= usuarioJWT.getUserId() %>">
            <input type="hidden" name="lab_id" value="<%= labId %>">
            <label for="flag">Ingrese la FLAG:</label>
            <input type="text" id="flag" name="flag" required>
            <button class="flag-btn" type="submit" class="style-button-flag">Enviar FLAG</button>
        </form>
</div>
<br>

    <main class="container">
      <!-- Artículo principal -->
      <section class="featured-article">
        <img src="<%= request.getContextPath() %>/img/img-main-article.avif" alt="Artículo principal">
        <div class="post-content">
          <h1>Cómo empezar en el hacking ético en 2025</h1>
          <p class="intro-text">
            Descubre las herramientas, metodologías y plataformas esenciales para iniciar tu camino como hacker ético.
            En esta guía aprenderás cómo funcionan los entornos de laboratorio, qué debes estudiar y dónde practicar.
          </p>
          <a href="main-article.jsp" class="read-more">Leer artículo completo +</a>
        </div>
      </section>

      <!-- Últimos artículos -->
      <h2 style="margin-top: 50px;">Últimos artículos</h2>
      <section class="blog-posts">
        <article class="post">
          <img src="<%= request.getContextPath() %>/img/img-article-one.jpeg" alt="Artículo 1">
          <div class="post-content">
            <h2><a href="article-one.jsp">Top 5 plataformas para practicar hacking web</a></h2>
            <p>Te presentamos las mejores plataformas gratuitas y de pago donde puedes mejorar tus habilidades en hacking web.</p>
            <a href="article-one.jsp" class="read-more">Leer más +</a>
          </div>
        </article>
        <article class="post">
          <img src="<%= request.getContextPath() %>/img/img-article-two.webp" alt="Artículo 2">
          <div class="post-content">
            <h2><a href="article-two.jsp">¿Qué es un CTF y por qué deberías participar?</a></h2>
            <p>Conoce los beneficios de competir en CTFs, cómo prepararte y dónde encontrar los mejores retos para empezar.</p>
            <a href="article-two.jsp" class="read-more">Leer más +</a>
          </div>
        </article>
        <article class="post">
          <img src="<%= request.getContextPath() %>/img/img-article-three.png" alt="Artículo 3">
          <div class="post-content">
            <h2><a href="article-three.jsp">Los comandos básicos de Linux que todo hacker debe saber</a></h2>
            <p>Aprende a dominar la terminal de Linux desde cero. Comandos esenciales, navegación y trucos para pentesters.</p>
            <a href="article-three.jsp" class="read-more">Leer más +</a>
          </div>
        </article>
		<article class="post">
			<img src="<%= request.getContextPath() %>/img/img-article-four.png" alt="Artículo 4">
			<div class="post-content">
			  <h2><a href="article-four.jsp">Cómo explotar una vulnerabilidad XSS paso a paso</a></h2>
			  <p>Aprende a detectar, explotar y mitigar ataques de Cross-Site Scripting con ejemplos reales en laboratorios de práctica.</p>
			  <a href="article-four.jsp" class="read-more">Leer más +</a>
			</div>
		  </article>
      </section>
    </main>
  </div>

  <footer>
    <div class="container">
      <p>&copy; 2025 HACKING COMMUNITY. Todos los derechos reservados.</p>
    </div>
  </footer>
</body>
</html>