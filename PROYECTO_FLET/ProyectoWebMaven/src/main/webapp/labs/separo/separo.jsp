<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>SEPARO - Servicio Público de Ayuda y Recursos Online</title>
  <style>
/* Reset básico */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

html, body {
  height: 100%;
  font-family: Arial, sans-serif;
  background-color: #f5f7fa;
  color: #333;
}

/* Contenedor general que asegura que el footer esté al fondo */
.contenedor {
  min-height: 100%;
  display: flex;
  flex-direction: column;
}

main {
  flex: 1;
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
  padding: 1rem 2rem;
}

.logo h1 {
  font-size: 1.8rem;
  color: #ffd700;
}

.buscador input {
  padding: 0.4rem;
  border: none;
  border-radius: 4px 0 0 4px;
}

.buscador button {
  padding: 0.45rem 0.6rem;
  background-color: #ffd700;
  border: none;
  border-radius: 0 4px 4px 0;
  cursor: pointer;
}

/* Menú principal */
.menu-principal {
  background-color: #002855;
}

.menu-principal ul {
  list-style: none;
  display: flex;
  justify-content: center;
}

.menu-principal li {
  margin: 0.8rem;
}

.menu-principal a {
  color: white;
  text-decoration: none;
  font-weight: bold;
  padding: 0.4rem 1rem;
  transition: background-color 0.3s;
}

.menu-principal a:hover {
  background-color: #004080;
  border-radius: 4px;
}

/* Accesos rápidos */
.accesos-rapidos {
  padding: 2rem;
  background-color: #ffffff;
}

.accesos-rapidos h2 {
  margin-bottom: 1rem;
  color: #002855;
}

.cards {
  display: flex;
  gap: 1rem;
  flex-wrap: wrap;
}

.card {
  flex: 1 1 200px;
  background-color: #e6f0ff;
  padding: 1rem;
  border-radius: 6px;
  text-align: center;
  text-decoration: none;
  color: #003366;
  font-weight: bold;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  transition: background-color 0.2s;
}

.card:hover {
  background-color: #cce0ff;
}

/* Noticias */
.destacados {
  padding: 2rem;
}

.destacados h2 {
  margin-bottom: 1rem;
  color: #002855;
}

.destacados article {
  background-color: #fff;
  padding: 1rem;
  margin-bottom: 1rem;
  border-left: 5px solid #004080;
  box-shadow: 0 2px 4px rgba(0,0,0,0.05);
}

/* Popup dentro del footer */
.popup-wrapper {
  position: absolute;
  left: 1rem;
  bottom: 1rem;
}

#abrirPopup {
  background-color: #00ffff;
  color: #003366;
  border: none;
  padding: 10px;
  border-radius: 4px;
  cursor: pointer;
  font-weight: bold;
}

.popup {
  display: none;
  position: fixed;
  bottom: 80px;
  left: 1rem;
  width: 300px;
  background-color: #ffffff;
  border: 2px solid #003366;
  border-radius: 6px;
  box-shadow: 0 4px 8px rgba(0,0,0,0.2);
  z-index: 1000;
}

.popup-content {
  padding: 1rem;
  color: #003366;
}

.popup h4 {
  margin-bottom: 0.5rem;
}

.cerrar {
  float: right;
  font-size: 1.2rem;
  cursor: pointer;
  color: #003366;
}

/* Footer */
footer {
  background-color: #003366;
  color: white;
  padding: 1rem 2rem;
  text-align: center;
}

.footer-links {
  margin-top: 0.5rem;
}

.footer-links a {
  color: #ffd700;
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
        <input type="text" placeholder="Buscar en SEPARO..." />
        <button>BUSCAR</button>
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

  <main>
    <section class="accesos-rapidos">
      <h2>Accesos Rápidos</h2>
      <div class="cards">
        <a href="#" class="card">Cita Previa</a>
        <a href="#" class="card">Prestaciones</a>
        <a href="buscar-empleo.jsp" class="card">Buscar Empleo</a>
        <a href="#" class="card">Cursos</a>
      </div>
    </section>

    <section class="destacados">
      <article>
        <h3>Nuevo programa de ayuda al empleo juvenil</h3>
        <p>Conoce el nuevo plan de apoyo para jóvenes en búsqueda activa de empleo.</p>
      </article>
    
      <article>
        <h3>Ampliación del subsidio por desempleo</h3>
        <p>Consulta si cumples los requisitos para acceder a esta nueva medida.</p>
      </article>
    
      <article>
        <h3>Convocatoria abierta para cursos online gratuitos</h3>
        <p>Inscríbete en los nuevos cursos de formación sin coste para desempleados y trabajadores.</p>
      </article>
    
      <article>
        <h3>Actualización del sistema de cita previa</h3>
        <p>Ahora podrás pedir y gestionar tu cita con SEPARO desde cualquier dispositivo móvil.</p>
      </article>
    
      <article>
        <h3>Guía para solicitar prestaciones paso a paso</h3>
        <p>Consulta nuestra nueva guía digital con imágenes y vídeos explicativos.</p>
      </article>
    
      <article>
        <h3>SEPARO lanza su nueva App oficial</h3>
        <p>Descárgala ya y realiza tus trámites de forma rápida, segura y sencilla.</p>
      </article>
    </section>
  </main>

  <footer>
    <div class="popup-wrapper">
      <button id="abrirPopup">SOLUCION</button>
    
      <div id="popup" class="popup">
        <div class="popup-content">
          <span id="cerrarPopup" class="cerrar">&times;</span>
          <h4>Solucion</h4>
          <p>Esta página es parte del proyecto SEPARO. La información aquí mostrada es solo de ejemplo.</p>
        </div>
      </div>
    </div>
    
    <p>&copy; 2025 SEPARO - Servicio Público de Ayuda y Recursos Online</p>
    <div class="footer-links">
      <a href="#">Aviso Legal</a>
      <a href="#">Política de Privacidad</a>
      <a href="#">Contacto</a>
    </div>
  </footer>
</div>
<script>
  const abrir = document.getElementById("abrirPopup");
  const cerrar = document.getElementById("cerrarPopup");
  const popup = document.getElementById("popup");

  abrir.addEventListener("click", () => {
    popup.style.display = "block";
  });

  cerrar.addEventListener("click", () => {
    popup.style.display = "none";
  });

  window.addEventListener("click", (e) => {
    if (e.target === popup) {
      popup.style.display = "none";
    }
  });
</script>
</body>
</html>
