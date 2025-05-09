<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>CINEHUB+ | CHERNOBYL</title>
  <style>
    body {
  margin: 0;
  font-family: 'Segoe UI', sans-serif;
  background-color: #111;
  color: #fff;
}

.wrapper {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

.header {
  background-color: #000;
  padding: 15px 30px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
}

.header h1 {
  font-size: 28px;
  color: #fff;
}

.header h1 span {
  color: #ff0000;
}

.header nav ul {
  list-style: none;
  display: flex;
  gap: 20px;
}

.header nav li {
  cursor: pointer;
  font-size: 16px;
  color: #ccc;
  transition: color 0.3s;
}

.header nav ul li > a {
  text-decoration: none;
  color: #fff;
  font-weight: bold;
}

.header nav li:hover {
  color: #fff;
}

.pelicula-container {
  padding: 40px 20px;
  max-width: 900px;
  margin: 0 auto;
}

.video-container {
  position: relative;
  padding-bottom: 56.25%;
  height: 0;
  overflow: hidden;
  border-radius: 10px;
  box-shadow: 0 0 15px rgba(255, 0, 0, 0.2);
}

.video-container iframe {
  position: absolute;
  top: 0; left: 0;
  width: 100%;
  height: 100%;
  border: none;
}

.info-pelicula {
  margin-top: 30px;
}

.info-pelicula h2 {
  font-size: 28px;
  margin-bottom: 10px;
  color: #ff0000;
}

.info-pelicula p {
  font-size: 16px;
  line-height: 1.6;
  margin-bottom: 10px;
}

.ver-btn {
  margin: 10px 15px 15px 15px;
  padding: 10px 20px;
  background-color: #ff0050;
  color: white;
  border: none;
  border-radius: 8px;
  font-weight: bold;
  cursor: pointer;
  transition: background 0.3s;
}

.ver-btn:hover {
  background-color: #ff3366;
}

/* Footer */
.footer {
  background: #0c0c0c;
  padding: 20px;
  display: flex;
  justify-content: center;
  align-items: center;
  position: relative;
  flex-direction: column;
  text-align: center;
  border-top: 1px solid #222;
}

/* Botón de info */
.info-btn {
  position: absolute;
  bottom: 20px;
  right: 20px;
  background: #ff0050;
  border: none;
  color: white;
  font-size: 22px;
  padding: 14px;
  border-radius: 50%;
  cursor: pointer;
  box-shadow: 0 0 12px rgba(255, 0, 80, 0.5);
  transition: background 0.3s;
}

.info-btn:hover {
  background: #ff3366;
}

/* Popup */
.popup {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.7);
  display: none;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.popup-content {
  background-color: #1a1a1a;
  color: white;
  padding: 2rem;
  border-radius: 10px;
  width: 90%;
  max-width: 400px;
  box-shadow: 0 0 15px rgba(0,0,0,0.9);
  position: relative;
  text-align: center;
}

.popup-content h3 {
  color: #ff0050;
  margin-bottom: 1rem;
}

.popup-content p {
  font-size: 1rem;
  color: #ccc;
}

/* Botón cerrar */
.close-btn {
  position: absolute;
  top: 10px;
  right: 15px;
  font-size: 1.5rem;
  color: #ff0050;
  cursor: pointer;
}

  </style>
</head>
<body>
  <div class="wrapper">
    <!-- Header -->
    <header class="header">
      <h1>CINEHUB <span>+</span></h1>
      <nav>
        <ul>
          <li><a href="<%= request.getContextPath() %>/labs/cinehub/cinehub.jsp">Inicio</a></li>
          <li>Netflix</li>
          <li>HBO</li>
          <li>Amazon Prime</li>
          <li>Atresplayer</li>
        </ul>
      </nav>
    </header>

    <!-- Contenido principal -->
    <main class="pelicula-container">
      <div class="video-container">
	  <iframe width="560" height="315" src="https://www.youtube.com/embed/s9APLXM9Ei8?si=vw41r5BOKNkPaZTo" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
      </div>

 <section class="info-pelicula">
  <h2>CHERNOBYL</h2>
  <p class="descripcion">
    <strong>Sinopsis:</strong> 
    Esta aclamada miniserie dramatiza los eventos reales del desastre nuclear ocurrido en la central de Chernóbil en 1986, uno de los peores accidentes provocados por el hombre en la historia. La serie explora las causas del accidente, la valentía de quienes intentaron mitigar sus consecuencias, y el encubrimiento gubernamental que amplificó la tragedia.
  </p>
  <p><strong>Creador:</strong> Craig Mazin</p>
  <p><strong>Actores:</strong> Jared Harris, Stellan Skarsgård, Emily Watson, Paul Ritter, Jessie Buckley</p>
</section>
</main>

    <!-- Footer -->
    <footer class="footer">
        <p>© CINEHUB+ Todos los derechos reservados</p>
        <button id="infoBtn" class="info-btn" type="button" title="¿Qué es XPath?">
          💡
        </button>
      </footer>

    <div id="popup" class="popup">
    <div class="popup-content">
      <span id="closePopup" class="close-btn">&times;</span>
      <h3>¿Qué es XPath?</h3>
      <p>XPath es un lenguaje usado para navegar y seleccionar nodos en un documento XML. Se utiliza comúnmente para extraer información específica dentro de estructuras XML o para hacer consultas sobre los datos almacenados.</p>
    </div>
  </div>

  <!-- Script popup -->
  <script>
    const infoBtn = document.getElementById("infoBtn");
        const popup = document.getElementById("popup");
        const closePopup = document.getElementById("closePopup");
      
        infoBtn.addEventListener("click", () => {
          popup.style.display = "flex";
        });
      
        closePopup.addEventListener("click", () => {
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