<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>WhatsApp Fake</title>
  <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/img/icono/icono_cinco_hackend.ico">
  <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
  <style>
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
      font-family: 'Roboto', sans-serif;
    }

    body {
      background: linear-gradient(to right, #0f2027, #203a43, #2c5364);
      height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    
  .header-main {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  z-index: 9999;
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: transparent;
  color: #fff;
  padding: 10px 20px;
  font-family: Arial, sans-serif;
}

.header-left {
  font-size: 18px;
  font-weight: bold;
}

.header-right {
  display: flex;
  gap: 5px;
}

.window-btn {
  background-color: #2e2e2e;
  border: none;
  color: white;
  padding: 5px 10px;
  font-size: 14px;
  cursor: pointer;
  border-radius: 2px;
  transition: background-color 0.2s ease;
}

.window-btn:hover {
  background-color: #444;
}

.window-btn.close:hover {
  background-color: #e81123;
}

    .iphone-container {
      width: 390px;
      height: 844px;
      background-color: #000;
      border-radius: 60px;
      padding: 16px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.6);
      position: relative;
      /* ✅ Añade esto: */
  	  margin-top: 110px;
    }
	
	.back {
	  margin-left: 200px;
	  text-decoration: none;
	  color: white;
	}
	
    .notch {
      position: absolute;
      top: 12px;
      left: 50%;
      transform: translateX(-50%);
      width: 160px;
      height: 30px;
      background-color: #111;
      border-radius: 20px;
      z-index: 2;
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 0 10px;
      margin-top: 10px;
    }

    .camera {
      width: 12px;
      height: 12px;
      background-color: #000;
      border-radius: 50%;
      border: 2px solid #333;
    }

    .sensor {
      width: 8px;
      height: 8px;
      background-color: #333;
      border-radius: 50%;
    }

    .whatsapp-ui {
      background-color: #e5ddd5;
      border-radius: 40px;
      overflow: hidden;
      height: 100%;
      display: flex;
      flex-direction: column;
      position: relative;
      z-index: 1;
    }

    .header {
      background-color: #075e54;
      padding: 30px;
      color: white;
      display: flex;
      align-items: center;
      justify-content: start;
      font-size: 18px;
      font-weight: bold;
    }

    .contacts-view {
      flex: 1;
      overflow-y: auto;
      padding: 10px;
      background-color: #ffffff;
      display: flex;
      flex-direction: column;
    }

    .contact-item {
      display: flex;
      align-items: center;
      padding: 12px;
      border-bottom: 1px solid #ddd;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    .contact-item:hover {
      background-color: #f1f1f1;
    }

    .contact-item img {
      width: 50px;
      height: 50px;
      border-radius: 50%;
      margin-right: 12px;
    }

    .contact-item strong {
      font-size: 16px;
      color: #000;
    }

    .contact-item .status {
      font-size: 12px;
      color: #888;
    }

    .contact-item .status.online {
      color: green;
    }

    .contact-item .status.last-seen {
      color: #aaa;
    }

    .contact-item .message-icon {
      margin-left: auto;
      font-size: 18px;
      color: #075e54;
    }

    .fab-button {
      position: absolute;
      bottom: 30px;
      right: 30px;
      background-color: #25d366;
      color: white;
      border: none;
      border-radius: 50%;
      width: 60px;
      height: 60px;
      display: flex;
      align-items: center;
      justify-content: center;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
      font-size: 30px;
      cursor: pointer;
      transition: transform 0.3s ease;
    }

    .fab-button:hover {
      transform: scale(1.1);
    }

  </style>
</head>
<body>
  <header class="header-main">
  <div class="header-left">WHATSAPP FAKE</div>
  <div class="header-right">
    <button class="window-btn minimize">−</button>
    <button class="window-btn maximize">☐</button>
    <button class="window-btn close" onclick="window.location.href='<%= request.getContextPath() %>/labs/whatsapp_fake/whatsapp_fake_lab.jsp'">✕</button>
  </div>
</header>

  
  <div class="iphone-container">
    <div class="notch">
      <div class="camera"></div>
      <div class="sensor"></div>
    </div>
    <div class="whatsapp-ui">
      <!-- Header -->
      <div class="header">
      Contactos
      </div>
	
      <!-- Vista de Contactos -->
      <div class="contacts-view" id="contactsView">
        <div class="contact-item" onclick="window.location.href='<%= request.getContextPath() %>/labs/whatsapp_fake/chat.jsp'">
          <img src="https://randomuser.me/api/portraits/women/44.jpg" alt="Sra. Jonshon">
          <div>
            <strong>Sra. Jonshon</strong>
            <span class="status online">En línea</span>
          </div>
          <span class="message-icon">💬</span>
        </div>
        <div class="contact-item" onclick="openChat('Mr. Smith')">
          <img src="https://randomuser.me/api/portraits/men/46.jpg" alt="Mr. Smith">
          <div>
            <strong>Mr. Smith</strong>
            <span class="status last-seen">Última vez: ayer</span>
          </div>
          <span class="message-icon">💬</span>
        </div>
      
        <!-- Contactos adicionales -->
        <div class="contact-item" onclick="openChat('Laura Pérez')">
          <img src="https://randomuser.me/api/portraits/women/65.jpg" alt="Laura Pérez">
          <div>
            <strong>Laura Pérez</strong>
            <span class="status online">En línea</span>
          </div>
          <span class="message-icon">💬</span>
        </div>
        <div class="contact-item" onclick="openChat('Carlos Díaz')">
          <img src="https://randomuser.me/api/portraits/men/38.jpg" alt="Carlos Díaz">
          <div>
            <strong>Carlos Díaz</strong>
            <span class="status last-seen">Últ. vez: hoy</span>
          </div>
          <span class="message-icon">💬</span>
        </div>
        <div class="contact-item" onclick="openChat('Ana Torres')">
          <img src="https://randomuser.me/api/portraits/women/12.jpg" alt="Ana Torres">
          <div>
            <strong>Ana Torres</strong>
            <span class="status last-seen">Últ. vez: 9:45</span>
          </div>
          <span class="message-icon">💬</span>
        </div>
        <div class="contact-item" onclick="openChat('Jorge Ramos')">
          <img src="https://randomuser.me/api/portraits/men/52.jpg" alt="Jorge Ramos">
          <div>
            <strong>Jorge Ramos</strong>
            <span class="status last-seen">Últ. vez: hoy</span>
          </div>
          <span class="message-icon">💬</span>
        </div>
        <div class="contact-item" onclick="openChat('María López')">
          <img src="https://randomuser.me/api/portraits/women/33.jpg" alt="María López">
          <div>
            <strong>María López</strong>
            <span class="status online">En línea</span>
          </div>
          <span class="message-icon">💬</span>
        </div>
        <div class="contact-item" onclick="openChat('Luis García')">
          <img src="https://randomuser.me/api/portraits/men/41.jpg" alt="Luis García">
          <div>
            <strong>Luis García</strong>
            <span class="status last-seen">Últ. vez: ayer</span>
          </div>
          <span class="message-icon">💬</span>
        </div>
        <div class="contact-item" onclick="openChat('Sandra Beltrán')">
          <img src="https://randomuser.me/api/portraits/women/27.jpg" alt="Sandra Beltrán">
          <div>
            <strong>Sandra Beltrán</strong>
            <span class="status last-seen">Últ. vez: 10:02</span>
          </div>
          <span class="message-icon">💬</span>
        </div>
        <div class="contact-item" onclick="openChat('Pedro Molina')">
          <img src="https://randomuser.me/api/portraits/men/14.jpg" alt="Pedro Molina">
          <div>
            <strong>Pedro Molina</strong>
            <span class="status online">En línea</span>
          </div>
          <span class="message-icon">💬</span>
        </div>
        <div class="contact-item" onclick="openChat('Camila Herrera')">
          <img src="https://randomuser.me/api/portraits/women/20.jpg" alt="Camila Herrera">
          <div>
            <strong>Camila Herrera</strong>
            <span class="status last-seen">Últ. vez: 8:30</span>
          </div>
          <span class="message-icon">💬</span>
        </div>
        <div class="contact-item" onclick="openChat('José Ortega')">
          <img src="https://randomuser.me/api/portraits/men/18.jpg" alt="José Ortega">
          <div>
            <strong>José Ortega</strong>
            <span class="status online">En línea</span>
          </div>
          <span class="message-icon">💬</span>
        </div>
        <div class="contact-item" onclick="openChat('Isabel Rivas')">
          <img src="https://randomuser.me/api/portraits/women/19.jpg" alt="Isabel Rivas">
          <div>
            <strong>Isabel Rivas</strong>
            <span class="status last-seen">Últ. vez: hoy</span>
          </div>
          <span class="message-icon">💬</span>
        </div>
        <div class="contact-item" onclick="openChat('Mateo Vidal')">
          <img src="https://randomuser.me/api/portraits/men/28.jpg" alt="Mateo Vidal">
          <div>
            <strong>Mateo Vidal</strong>
            <span class="status last-seen">Últ. vez: 7:15</span>
          </div>
          <span class="message-icon">💬</span>
        </div>
        <div class="contact-item" onclick="openChat('Natalia Ruiz')">
          <img src="https://randomuser.me/api/portraits/women/35.jpg" alt="Natalia Ruiz">
          <div>
            <strong>Natalia Ruiz</strong>
            <span class="status online">En línea</span>
          </div>
          <span class="message-icon">💬</span>
        </div>
        <div class="contact-item" onclick="openChat('Tomás Benítez')">
          <img src="https://randomuser.me/api/portraits/men/30.jpg" alt="Tomás Benítez">
          <div>
            <strong>Tomás Benítez</strong>
            <span class="status last-seen">Últ. vez: 6:50</span>
          </div>
          <span class="message-icon">💬</span>
        </div>
        <div class="contact-item" onclick="openChat('Valeria Cano')">
          <img src="https://randomuser.me/api/portraits/women/26.jpg" alt="Valeria Cano">
          <div>
            <strong>Valeria Cano</strong>
            <span class="status online">En línea</span>
          </div>
          <span class="message-icon">💬</span>
        </div>
        <div class="contact-item" onclick="openChat('Andrés Pardo')">
          <img src="https://randomuser.me/api/portraits/men/12.jpg" alt="Andrés Pardo">
          <div>
            <strong>Andrés Pardo</strong>
            <span class="status last-seen">Últ. vez: 9:10</span>
          </div>
          <span class="message-icon">💬</span>
        </div>
        <div class="contact-item" onclick="openChat('Elena Castro')">
          <img src="https://randomuser.me/api/portraits/women/22.jpg" alt="Elena Castro">
          <div>
            <strong>Elena Castro</strong>
            <span class="status online">En línea</span>
          </div>
          <span class="message-icon">💬</span>
        </div>
      </div>      

      <!-- Botón flotante de WhatsApp (nuevo chat o grupo) -->
      <button class="fab-button" onclick="createGroup()">
        <span>+</span>
      </button>
    </div>
  </div>

  <script>
    function openChat(name) {
      alert("Abrir chat con " + name);
    }

    function createGroup() {
      alert("Crear un nuevo grupo");
    }

    // ordenar usuarios
    function ordenarContactos() {
    const container = document.getElementById("contactsView");
    const items = Array.from(container.getElementsByClassName("contact-item"));

    const obtenerPrioridad = (item) => {
      const statusEl = item.querySelector(".status");
      const texto = statusEl?.textContent?.toLowerCase() || "";

      if (texto.includes("en línea")) return { prioridad: 0, minutos: 0 };
      
      const matchHora = texto.match(/(\d{1,2}):(\d{2})/);
      if (matchHora) {
        const horas = parseInt(matchHora[1], 10);
        const minutos = parseInt(matchHora[2], 10);
        return { prioridad: 1, minutos: horas * 60 + minutos };
      }

      return { prioridad: 2, minutos: Infinity }; // "ayer" o sin hora
    };

    items.sort((a, b) => {
      const aInfo = obtenerPrioridad(a);
      const bInfo = obtenerPrioridad(b);

      if (aInfo.prioridad !== bInfo.prioridad) {
        return aInfo.prioridad - bInfo.prioridad;
      }

      // Si ambos son de prioridad 1 (última vez), ordenar del más reciente al menos
      return aInfo.minutos - bInfo.minutos;
    });

    // Limpiar y volver a añadir en orden
    container.innerHTML = "";
    items.forEach(item => container.appendChild(item));
  }

  // Ejecutar al cargar
  ordenarContactos();
</script>

</body>
</html>
