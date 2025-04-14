<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SQL Injection: C�mo funciona y c�mo protegerse</title>
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
        <img src="<%= request.getContextPath() %>/img/img-article-four.png" alt="SQL Injection" />
        <div class="post-content">
          <h1>SQL Injection: C�mo funciona y c�mo protegerse</h1>
          <p class="intro-text">
            Una de las vulnerabilidades m�s antiguas y peligrosas en aplicaciones web: el SQL Injection puede comprometer toda tu base de datos.
          </p>
          <p>
            SQL Injection ocurre cuando un atacante puede inyectar sentencias SQL maliciosas en formularios o par�metros URL, manipulando la consulta enviada a la base de datos.
          </p>

          <p><strong>Ejemplo b�sico:</strong></p>
          <pre>
Usuario: ' OR '1'='1
Consulta resultante: SELECT * FROM usuarios WHERE usuario = '' OR '1'='1'
          </pre>

          <p>Esto permite a un atacante eludir la autenticaci�n o incluso obtener datos confidenciales.</p>

          <p><strong>Consecuencias de un SQLi:</strong></p>
          <ul>
            <li>Robo de datos sensibles.</li>
            <li>Modificaci�n o eliminaci�n de registros.</li>
            <li>Acceso total al sistema si se combina con otras vulnerabilidades.</li>
          </ul>

          <p><strong>�C�mo prevenirlo?</strong></p>
          <ul>
            <li>Usar consultas preparadas o par�metros (prepared statements).</li>
            <li>Validar y sanitizar todas las entradas del usuario.</li>
            <li>Evitar construir consultas SQL directamente con entradas del usuario.</li>
          </ul>

          <p>
            SQL Injection es cr�tica, pero f�cil de prevenir con buenas pr�cticas de desarrollo seguro. �No subestimes su impacto!
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