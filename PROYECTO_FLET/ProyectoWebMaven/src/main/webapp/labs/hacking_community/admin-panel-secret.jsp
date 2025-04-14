<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Panel de Administrador | Hacking Community</title>
  <style>
    * {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body, html {
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
  flex: 1;
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

h1 {
  font-size: 2rem;
  margin: 30px 0 10px;
  text-align: center;
}

.intro-text {
  margin-bottom: 30px;
  font-size: 1.1rem;
  color: #ccc;
}

.panel-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 30px;
}

.panel-card {
  background-color: #2e323d;
  border: 1px solid #3b3f4c;
  border-radius: 8px;
  padding: 20px;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  box-shadow: 0 4px 10px rgba(0, 255, 174, 0.1);
}

.panel-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 6px 15px rgba(0, 255, 174, 0.2);
}

.panel-card h2 {
  font-size: 1.3rem;
  margin-bottom: 10px;
  color: #00ffae;
}

.panel-card p {
  color: #bbb;
  margin-bottom: 15px;
}

.btn-panel {
  display: inline-block;
  background-color: #00ffae;
  color: #000;
  padding: 10px 18px;
  border-radius: 5px;
  font-weight: 600;
  text-decoration: none;
  transition: background-color 0.3s ease;
}

.btn-panel:hover {
  background-color: #00e3a0;
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
  <header>
    <div class="container">
      <div class="logo">HACKING COMMUNITY</div>
      <nav>
        <ul>
          <li><a href="hacking_community.jsp">Inicio</a></li>
          <li><a href="admin.jsp">Panel</a></li>
        </ul>
      </nav>
    </div>
  </header>

  <main class="container">
    <h1>Panel de Administrador</h1>
    <p class="intro-text">Bienvenido al panel de administración. Aquí puedes gestionar tus artículos, ver estadísticas y controlar el contenido del blog.</p>

    <div class="panel-grid">
      <div class="panel-card">
        <h2>Crear nuevo artículo</h2>
        <p>Redacta y publica un nuevo artículo para el blog.</p>
        <a href="#" class="btn-panel">Crear</a>
      </div>

      <div class="panel-card">
        <h2>Editar artículos</h2>
        <p>Modifica artículos existentes o elimina los que ya no necesites.</p>
        <a href="#" class="btn-panel">Editar</a>
      </div>

      <div class="panel-card">
        <h2>Estadísticas</h2>
        <p>Consulta las métricas de tráfico y actividad del blog.</p>
        <a href="#" class="btn-panel">Ver estadísticas</a>
      </div>

      <div class="panel-card">
        <h2>Configuración</h2>
        <p>Ajusta las opciones del sistema y del sitio web.</p>
        <a href="#" class="btn-panel">Configurar</a>
      </div>
      <div class="panel-card">
        <h2>Laboratorio de pruebas</h2>
        <p>Administra los retos y vulnerabilidades disponibles para practicar hacking.</p>
        <a href="#" class="btn-panel">Gestionar</a>
      </div>
    
      <div class="panel-card">
        <h2>Comentarios de usuarios</h2>
        <p>Modera y responde a los comentarios recibidos en el blog.</p>
        <a href="#" class="btn-panel">Ver comentarios</a>
      </div>
    </div>
  </main>
  <footer>
    <p>&copy; 2025 Hacking Community. Todos los derechos reservados.</p>
  </footer>
</body>
</html>
