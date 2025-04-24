<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>CINEHUB+</title>
  <style>
/* Reset básico */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

html, body {
  height: 100%;
  background-color: #0d0d0d;
  font-family: 'Segoe UI', sans-serif;
  color: white;
}

.wrapper {
  min-height: 100%;
  display: flex;
  flex-direction: column;
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 40px;
  background-color: #000;
  border-bottom: 1px solid #222;
}

.header h1 {
  font-size: 1.8rem;
  color: #ff0050;
}

.header h1 span {
    font-size: 1.8rem;
    color: #fff;
}

.header ul {
  list-style: none;
  display: flex;
  gap: 20px;
}

.header li {
  cursor: pointer;
  font-weight: 500;
}

/*Barra de navegacion*/
.search-section {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 20px;
}

.search-container {
  display: flex;
  align-items: center;
  background-color: white;
  border-radius: 50px;
  padding: 5px 20px;
}

.search-bar {
  width: 300px;
  height: 40px;
  border: none;
  outline: none;
  font-size: 16px;
  padding: 0 10px;
  border-radius: 50px;
}

.search-btn {
  background-color: #f00; /* Color de fondo del botón */
  color: white;
  border: none;
  padding: 10px 20px;
  margin-left: 10px;
  font-size: 16px;
  border-radius: 50px;
  cursor: pointer;
}

.search-btn:hover {
  background-color: #ea1414; /* Cambio de color al pasar el cursor */
}

.search-bar:focus {
  box-shadow: 0 0 8px rgba(255, 0, 0, 0.6); /* Efecto de foco */
}

/*Card de estrenos*/
.main {
  flex: 1;
  padding: 40px;
}

.estrenos-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 25px;
  text-align: center;
}

.card {
  background: #1a1a1a;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 0 15px rgba(255, 0, 80, 0.2);
  transition: opacity 0.5s ease, transform 0.5s ease;
}

.card:hover {
  transform: scale(1.03);
}

.card img {
  width: 100%;
  height: auto;
  display: block;
}

.card p {
  padding: 15px;
  font-size: 1rem;
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
        <header class="header">
            <h1>CINEHUB <span>+</span></h1>
            <nav>
              <ul>
                <li><a href="<%= request.getContextPath() %>/labs/cinehub/cinehub-lab.jsp">Inicio</a></li>
                <li data-filter="all">Ver Todo</li>
                <li data-filter="netflix">Netflix</li>
                <li data-filter="hbo">HBO</li>
                <li data-filter="amazon">Amazon Prime</li>
                <li data-filter="atresplayer">Atresplayer</li>
              </ul>
            </nav>
          </header>
        <section class="search-section">
            <div class="search-container">
              <input type="text" class="search-bar" placeholder="Buscar en CINEHUB+">
              <button class="search-btn">🔍</button>
            </div>
          </section>
        <main class="main">
            <section class="estrenos-grid">
                <!-- Card 1: Netflix -->
                <article class="card netflix">
                  <img src="https://via.placeholder.com/300x170?text=Netflix+Estreno" alt="Netflix">
                  <p>Netflix: El Agente Nocturno</p>
                  <button class="ver-btn" onclick="window.location.href='<%= request.getContextPath() %>/labs/cinehub/peliculas/netflix/agentenocturno.jsp'">Ver ahora</button>
                </article>
                
                <!-- Card 2: HBO -->
                <article class="card hbo">
                  <img src="https://via.placeholder.com/300x170?text=HBO+Estreno" alt="HBO">
                  <p>HBO: The Last of Us</p>
                  <button class="ver-btn" onclick="window.location.href='<%= request.getContextPath() %>/labs/cinehub/peliculas/hbo/thelastoffast.jsp'">Ver ahora</button>
                </article>
              
                <!-- Card 3: Amazon Prime -->
                <article class="card amazon">
                  <img src="https://via.placeholder.com/300x170?text=Amazon+Prime" alt="Amazon Prime">
                  <p>Amazon Prime: Jack Ryan</p>
                  <button class="ver-btn" onclick="window.location.href='<%= request.getContextPath() %>/labs/cinehub/peliculas/amazon/jack-ryan.jsp'">Ver ahora</button>
                </article>
              
                <!-- Card 4: Atresplayer -->
                <article class="card atresplayer">
                  <img src="https://via.placeholder.com/300x170?text=Atresplayer" alt="Atresplayer">
                  <p>Atresplayer: Sueños de Libertad</p>
                  <button class="ver-btn" onclick="window.location.href='<%= request.getContextPath() %>/labs/cinehub/peliculas/atresplayer/sueñosdelibertad.jsp'">Ver ahora</button>
                </article>
              
                <!-- Card 5: Netflix -->
                <article class="card netflix">
                  <img src="https://via.placeholder.com/300x170?text=Netflix+Estreno" alt="Netflix">
                  <p>Netflix: La Diplomática</p>
                  <button class="ver-btn" onclick="window.location.href='<%= request.getContextPath() %>/labs/cinehub/peliculas/netflix/ladiplomatica.jsp'">Ver ahora</button>
                </article>
              
                <!-- Card 6: HBO -->
                <article class="card hbo">
                  <img src="https://via.placeholder.com/300x170?text=HBO+Estreno" alt="HBO">
                  <p>HBO: Succession</p>
                  <button class="ver-btn" onclick="window.location.href='<%= request.getContextPath() %>/labs/cinehub/peliculas/hbo/succession.jsp'">Ver ahora</button>
                </article>
              
                <!-- Card 7: Amazon Prime -->
                <article class="card amazon">
                  <img src="https://via.placeholder.com/300x170?text=Amazon+Prime" alt="Amazon Prime">
                  <p>Amazon Prime: Reacher</p>
                  <button class="ver-btn" onclick="window.location.href='<%= request.getContextPath() %>/labs/cinehub/peliculas/amazon/reacher.jsp'">Ver ahora</button>
                </article>
              
                <!-- Card 8: Atresplayer -->
                <article class="card atresplayer">
                  <img src="https://via.placeholder.com/300x170?text=Atresplayer" alt="Atresplayer">
                  <p>Atresplayer: La Novia Gitana</p>
                  <button class="ver-btn" onclick="window.location.href='<%= request.getContextPath() %>/labs/cinehub/peliculas/atresplayer/lanoviagitana.jsp'">Ver ahora</button>
                </article>
              
                <!-- Card 9: Netflix -->
                <article class="card netflix">
                  <img src="https://via.placeholder.com/300x170?text=Netflix+Estreno" alt="Netflix">
                  <p>Netflix: Bienvenidos a Edén</p>
                  <button class="ver-btn" onclick="window.location.href='<%= request.getContextPath() %>/labs/cinehub/peliculas/netflix/bienvenidosaeden.jsp'">Ver ahora</button>
                </article>
              
                <!-- Card 10: HBO -->
                <article class="card hbo">
                  <img src="https://via.placeholder.com/300x170?text=HBO+Estreno" alt="HBO">
                  <p>HBO: Chernobyl</p>
                  <button class="ver-btn" onclick="window.location.href='<%= request.getContextPath() %>/labs/cinehub/peliculas/hbo/chernobyl.jsp'">Ver ahora</button>
                </article>
              
                <!-- Card 11: Amazon Prime -->
                <article class="card amazon">
                  <img src="https://via.placeholder.com/300x170?text=Amazon+Prime" alt="Amazon Prime">
                  <p>Amazon Prime: El Consultor</p>
                  <button class="ver-btn" onclick="window.location.href='<%= request.getContextPath() %>/labs/cinehub/peliculas/amazon/elconsultor.jsp'">Ver ahora</button>
                </article>
              
                <!-- Card 12: Atresplayer -->
                <article class="card atresplayer">
                  <img src="https://via.placeholder.com/300x170?text=Atresplayer" alt="Atresplayer">
                  <p>Atresplayer: Alba</p>
                  <button class="ver-btn" onclick="window.location.href='<%= request.getContextPath() %>/labs/cinehub//peliculas/atresplayer/alba.jsp'">Ver ahora</button>
                </article>
              
                <!-- Card 13: Netflix -->
                <article class="card netflix">
                  <img src="https://via.placeholder.com/300x170?text=Netflix+Estreno" alt="Netflix">
                  <p>Netflix: Pálpito</p>
                  <button class="ver-btn" onclick="window.location.href='<%= request.getContextPath() %>/labs/cinehub//peliculas/netflix/palpito.jsp'">Ver ahora</button>
                </article>
              
                <!-- Card 14: HBO -->
                <article class="card hbo">
                  <img src="https://via.placeholder.com/300x170?text=HBO+Estreno" alt="HBO">
                  <p>HBO: Euphoria</p>
                  <button class="ver-btn" onclick="window.location.href='<%= request.getContextPath() %>/labs/cinehub/peliculas/hbo/euphoria.jsp'">Ver ahora</button>
                </article>
              
                <!-- Card 15: Amazon Prime -->
                <article class="card amazon">
                  <img src="https://via.placeholder.com/300x170?text=Amazon+Prime" alt="Amazon Prime">
                  <p>Amazon Prime: Hunters</p>
                  <button class="ver-btn" onclick="window.location.href='<%= request.getContextPath() %>/labs/cinehub/peliculas/amazon/hunters.jsp'">Ver ahora</button>
                </article>
              </section>                    
        </main>
    
        <footer class="footer">
          <p>© CINEHUB+ Todos los derechos reservados</p>
          <button id="infoBtn" class="info-btn" type="button" title="¿Qué es XPath?">
            💡
          </button>
        </footer>
      </div>
    
       <div id="popup" class="popup">
    <div class="popup-content">
      <span id="closePopup" class="close-btn">&times;</span>
      <h3>¿Qué es XPath?</h3>
      <p>XPath es un lenguaje usado para navegar y seleccionar nodos en un documento XML. Se utiliza comúnmente para extraer información específica dentro de estructuras XML o para hacer consultas sobre los datos almacenados.</p>
    </div>
  </div>
    
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

        /*Script para filtrar desde el header por plataformas de Streaming*/
        document.addEventListener("DOMContentLoaded", function() {
    const navItems = document.querySelectorAll("header nav ul li");
    const cards = document.querySelectorAll(".estrenos-grid .card");

    // Filtrar las cards según la selección del menú
    navItems.forEach(item => {
      item.addEventListener("click", function() {
        const filter = this.getAttribute("data-filter");

        // Mostrar todas las cards si "Inicio" es clickeado
        if (filter === "all") {
          cards.forEach(card => {
            card.style.display = "block";
          });
        } else {
          // Mostrar solo las cards correspondientes a la sección seleccionada
          cards.forEach(card => {
            if (card.classList.contains(filter)) {
              card.style.display = "block";
            } else {
              card.style.display = "none";
            }
          });
        }
      });
    });
  });

  // Funcion para que la barra de busqueda funcione al igual que el header
  document.addEventListener('DOMContentLoaded', () => {
    const searchInput = document.querySelector('.search-bar');
    const searchBtn   = document.querySelector('.search-btn');
    const cards       = document.querySelectorAll('.estrenos-grid .card');

    function filterCards() {
      const query = searchInput.value.trim().toLowerCase();

      cards.forEach(card => {
        const title = card.querySelector('p').textContent.toLowerCase();
        if (title.includes(query)) {
          card.style.display = 'block';
        } else {
          card.style.display = 'none';
        }
      });
    }

    // Filtrado en tiempo real al escribir
    searchInput.addEventListener('input', filterCards);

    // Filtrado al pulsar el botón de búsqueda
    searchBtn.addEventListener('click', (e) => {
      e.preventDefault();
      filterCards();
    });
  });
      </script>      
</body>
</html>