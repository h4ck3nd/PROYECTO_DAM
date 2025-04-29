<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>WhatsApp Mockup</title>
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
          <span class="back"><a href="contactos.jsp">←</a></span>
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
        <button onclick="sendMessage()">📤</button>
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
        </div>
      </div>
    </div>
  </div>

  <script>
    function sendMessage() {
      const input = document.getElementById("messageInput");
      const message = input.value.trim();
      if (message === "") return;

      const chatBody = document.getElementById("chatBody");

      const messageBlock = document.createElement("div");
      messageBlock.className = "message-block";

      const userMsg = document.createElement("div");
      userMsg.className = "message user";
      userMsg.innerHTML = `${message}<span class="time">✔✔ ${getTime()}</span>`;
      messageBlock.appendChild(userMsg);

      const response = document.createElement("div");
      response.className = "message bot";
      response.innerHTML = `Respuesta automática del servidor.<span class="time">${getTime()}</span>`;
      messageBlock.appendChild(response);

      chatBody.appendChild(messageBlock);
      chatBody.scrollTop = chatBody.scrollHeight;
      input.value = "";
    }

    function getTime() {
      const now = new Date();
      return now.getHours().toString().padStart(2, '0') + ":" +
             now.getMinutes().toString().padStart(2, '0');
    }

    function togglePopup() {
      const popup = document.getElementById("infoPopup");
      popup.classList.toggle("active");
    }
  </script>
</body>
</html>
