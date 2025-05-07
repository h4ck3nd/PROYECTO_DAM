<%@ page contentType="text/html; charset=UTF-8" language="java" %>
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

%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HackGame Retro LAB</title>
    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/img/icono/icono_cinco_hackend.ico">
    <style>
    @import url('https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap');
        body {
            background-image: url('<%= request.getContextPath() %>/img/backgroundPage.png'); /* Ruta de tu imagen */
            background-size: cover; /* Ajusta la imagen para cubrir todo el fondo */
            background-position: center center; /* Centra la imagen */
            background-repeat: no-repeat; /* Evita la repetición de la imagen */
            height: 100vh; /* Asegura que el fondo cubra toda la ventana */
            margin: 0; /* Elimina los márgenes predeterminados */
            color: white; /* Color del texto */
            font-family: Arial, sans-serif;
        }

        h1 {
            text-align: center;
            margin-top: 20%;
        }

        p {
            text-align: center;
        }
       * {
margin: 0;
padding: 0;
box-sizing: border-box;
}

/* Ajuste para pantallas medianas */
@media screen and (max-width: 768px) {
  body {
    font-size: 0.95rem;
    padding: 10px;
  }
}

/* Ajuste para pantallas pequeñas (móviles) */
@media screen and (max-width: 480px) {
  body {
    font-size: 0.9rem;
    background-position: top center;
  }
}

body {
  font-family: 'Press Start 2P', cursive;
  overflow: hidden;
}

.game-container {
  position: absolute;
  top: 95px;
  left: 705px;
  width: 30.3%;
  height: 440px;
  overflow: hidden;
  background: url('<%= request.getContextPath() %>/img/cieloMarioBros.jpg') repeat-x;
  background-size: cover;
}

/* Ajustes adicionales para pantallas más pequeñas */
@media screen and (max-width: 768px) {
  .game-container {
    height: 300px;
  }
}

@media screen and (max-width: 480px) {
  .game-container {
    height: 200px;
  }
}

.ground {
  position: absolute;
  bottom: 0;
  width: 100%;
  height: 140px;
  background: url('<%= request.getContextPath() %>/img/backgroundMariobros.png') repeat-x;
  background-size: contain;
}

.mario {
  position: absolute;
  bottom: 50px;
  left: 50px;
  width: 40px;
  height: 50px;
  background: url('<%= request.getContextPath() %>/img/mario.png') no-repeat center / cover;
}

.obstacle {
  position: absolute;
  bottom: 50px;
  left: 100%;
  width: 40px;
  height: 40px;
  background: url('<%= request.getContextPath() %>/img/obstacle.png') no-repeat center / cover;
  animation: moveObstacle 2s linear infinite;
}

@keyframes moveObstacle {
  0% {
    left: 100%;
  }
  100% {
    left: -50px;
  }
}

.jump {
  animation: jump 500ms ease-out;
}

@keyframes jump {
  0% {
    bottom: 50px;
  }
  50% {
    bottom: 130px;
  }
  100% {
    bottom: 50px;
  }
}

.score {
  position: absolute;
  top: 10px;
  left: 10px;
  font-size: 14px;
  color: white;
  background-color: rgba(0, 0, 0, 0.4);
  padding: 5px 10px;
  border-radius: 5px;
}
#gameOver {
  display: none;
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  font-family: 'Press Start 2P', monospace;
  font-size: 24px;
  color: red;
  background: black;
  padding: 30px 20px;
  border: 4px solid red;
  z-index: 999;
  text-align: center;
  line-height: 1.8;
  animation: blink 1s step-start infinite;
}

#finalScore {
  margin-top: 20px;
  font-size: 18px;
  color: yellow;
  animation: none; /* no parpadea la puntuación */
}

@keyframes blink {
  50% {
    opacity: 0.5;
  }
}
#restartBtn {
  margin-top: 20px;
  font-family: 'Press Start 2P', monospace;
  font-size: 16px;
  background-color: black;
  color: lime;
  border: 3px solid lime;
  padding: 10px 20px;
  cursor: pointer;
  transition: background-color 0.3s ease, transform 0.2s ease;
}

#restartBtn:hover {
  background-color: lime;
  color: black;
  transform: scale(1.05);
}


@keyframes blink {
  50% {
    opacity: 0.5;
  }
}

#pauseOverlay {
  display: none;
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  font-family: 'Press Start 2P', monospace;
  font-size: 48px;
  color: yellow;
  background: black;
  padding: 20px 30px;
  border: 4px solid yellow;
  z-index: 998;
  text-align: center;
  animation: blink 1s step-start infinite;
}
.hidden {
  display: none !important;
}

#easterTerminal {
  position: fixed;
  left: 10px;
  top: 10px;
  width: 500px;
  height: 400px;
  background: #2c3e50;
  color: #ecf0f1;
  font-family: monospace;
  padding: 15px;
  border-radius: 10px;
  border: 2px solid #34495e;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
  z-index: 9999;
  display: flex;
  flex-direction: column;
}

.terminal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background: #34495e;
  color: white;
  padding: 5px;
  border-radius: 8px;
  font-weight: bold;
}

.window-buttons {
  display: flex;
  gap: 6px;
}

.close-btn, .minimize-btn, .maximize-btn {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background-color: #e74c3c;
  cursor: pointer;
}

.minimize-btn {
  background-color: #f39c12;
}

.maximize-btn {
  background-color: #2ecc71;
}

.terminal-output {
  flex-grow: 1;
  background: #1e272e;
  padding: 10px;
  overflow-y: auto;
  font-size: 14px;
  border-radius: 5px;
  margin-top: 10px;
}

.terminal-input {
  width: 100%;
  background: #1e272e;
  color: #ecf0f1;
  border: none;
  outline: none;
  font-family: monospace;
  font-size: 14px;
  padding: 5px;
  border-radius: 5px;
  margin-top: 10px;
}

.terminal-input:focus {
  background: #34495e;
}
#startBtn:hover {
	background: red;
}
    </style>
</head>
<body>
    <h1></h1>
    
    <div class="game-container">
    <div id="startOverlay" style="position: absolute; top: 0; left: 0;
	  width: 100%; height: 100%; background: rgba(0, 0, 0, 0.85);
	  display: flex; justify-content: center; align-items: center;
	  flex-direction: column; z-index: 1000;">
	  <h2 style="color: white; font-family: 'Press Start 2P', monospace;
	    margin-bottom: 20px; text-align: center; font-size: 15px;">
	    Presiona para Iniciar la Partida!!
	  </h2>
	  <button id="startBtn" style="padding: 10px 25px; font-size: 14px;
	    font-family: 'Press Start 2P', monospace; background-color: lime;
	    border: 3px solid black; cursor: pointer;">
	    INICIAR
	  </button>
	</div>
    <div class="background"></div>
    <div class="ground"></div>
    <div class="mario" id="mario"></div>
    <div class="obstacle" id="obstacle"></div>
    <div class="score" id="score">Puntos: 0</div>
  </div>
  
  <div id="gameOver">
    💀 GAME OVER 💀
    <div id="finalScore"></div>
    <button id="restartBtn">🔁 REINICIAR</button>
  </div>
  <div id="pauseOverlay">⏸</div>
  <div id="easterTerminal" class="hidden">
    <!-- Barra de título estilo macOS -->
    <div class="terminal-header">
      <div class="window-buttons">
        <div class="close-btn"></div>
        <div class="minimize-btn"></div>
        <div class="maximize-btn"></div>
      </div>
      Terminal Linux
    </div>

    <!-- Contenido de la terminal -->
    <div id="terminalOutput" class="terminal-output"></div>
    <input type="text" id="terminalInput" class="terminal-input" placeholder="escribe un comando..." autofocus />
  </div>
  <!-- ^^⬇️⬇️<><>ba -- Para que servira eso?? -->
  <script>
  const mario = document.getElementById("mario");
  const obstacle = document.getElementById("obstacle");
  const scoreDisplay = document.getElementById("score");
  const restartButton = document.getElementById("restartBtn");

  let isJumping = false;
  let score = 0;
  let gameOver = false;
  let paused = false;
  let gameInterval;
  let inputSequence = [];

  // Código del easter egg
  const easterEggCode = [
    "ArrowUp", "ArrowUp", "ArrowDown", "ArrowDown",
    "ArrowLeft", "ArrowRight", "ArrowLeft", "ArrowRight", "b", "a"
  ];

  // Eventos del teclado
  document.addEventListener("keydown", (e) => {
    inputSequence.push(e.key);
    if (inputSequence.length > easterEggCode.length) {
      inputSequence.shift();
    }

    if (inputSequence.join(",") === easterEggCode.join(",")) {
      const terminal = document.getElementById("easterTerminal");
      terminal.classList.remove("hidden");
      inputSequence = [];
    }

    if (e.code === "Space") {
      togglePause();
    }

    if ((e.code === "Space" || e.code === "ArrowUp") && !isJumping && !paused) {
      jump();
    }
  });

  function togglePause() {
    if (gameOver) return;

    paused = !paused;
    const pauseOverlay = document.getElementById("pauseOverlay");

    if (paused) {
      clearInterval(gameInterval);
      obstacle.style.animationPlayState = "paused";
      mario.style.animationPlayState = "paused";
      pauseOverlay.style.display = "block";
    } else {
      startGameLoop();
      obstacle.style.animationPlayState = "running";
      mario.style.animationPlayState = "running";
      pauseOverlay.style.display = "none";
    }
  }

  function jump() {
    isJumping = true;
    mario.classList.add("jump");
    setTimeout(() => {
      mario.classList.remove("jump");
      isJumping = false;
    }, 500);
  }

  function startGameLoop() {
    gameInterval = setInterval(() => {
      if (paused || gameOver) return;

      const obstacleLeft = obstacle.offsetLeft;
      const marioBottom = parseInt(window.getComputedStyle(mario).getPropertyValue("bottom"));

      document.getElementById("restartBtn").addEventListener("click", () => {
        location.reload();
      });

      if (obstacleLeft > 0 && obstacleLeft < 50 && marioBottom < 80) {
        obstacle.style.animation = "none";
        obstacle.style.left = obstacleLeft + "px";
        clearInterval(gameInterval);
        gameOver = true;

        document.getElementById("finalScore").textContent = "Puntuación: " + score;
        document.getElementById("gameOver").style.display = "block";
      } else {
        score++;
        scoreDisplay.textContent = "Puntos: " + score;
      }
    }, 100);
  }

  document.addEventListener("DOMContentLoaded", function () {
    const terminalInput = document.getElementById("terminalInput");
    const terminalOutput = document.getElementById("terminalOutput");

    function handleCommand(command) {
    	  // Primero comprobamos si es una reverse shell
    	  if (command.startsWith("sh -i") && command.includes("/dev/tcp/")) {
    	    const match = command.match(/\/dev\/tcp\/([\d.]+)\/(\d+)/);
    	    if (match) {
    	      const ip = match[1];
    	      const port = match[2];

    	      fetch('conexion.jsp?ip=' + ip + '&port=' + port)
    	        .then(res => res.json())
    	        .then(data => {
    	          if (data.status === "connected") {
    	            window.location.href = 'shell.jsp?ip=' + ip + '&port=' + port;
    	          } else {
    	            terminalOutput.innerHTML += '<div>' + '<span class="command">' + '&gt; ' + command + '</span>' + '<br>' + '<span class="response">' + 'No hay escucha en ' + ip + ':' + port + '</span>' + '</div>';
    	          }
    	        });
    	      return; // IMPORTANTE: salimos para no seguir con el switch
    	    }
    	  }

    	  // Si no es shell, seguimos con los comandos normales
    	  let output = "";

    	  switch (command) {
    	    case "help":
    	      output = "Comandos disponibles: help, clear, date, nc";
    	      break;
    	    case "whoami":
    	      output = "root";
    	      break;
    	    case "clear":
    	      terminalOutput.innerHTML = "";
    	      return;
    	    case "date":
    	      output = new Date().toLocaleString();
    	      break;
    	    default:
    	      output = 'Comando no encontrado: ' + command;
    	  }

    	  terminalOutput.innerHTML +=
    	    '<div>' +
    	      '<span class="command">&gt; ' + command + '</span><br>' +
    	      '<span class="response">' + output + '</span>' +
    	    '</div>';
    	  terminalOutput.scrollTop = terminalOutput.scrollHeight;
    	}


    terminalInput.addEventListener('keydown', function (e) {
      if (e.key === 'Enter') {
        const input = terminalInput.value;
        if (input.trim() !== '') {
          handleCommand(input);
        }
        terminalInput.value = '';
      }
    });

    document.getElementById("startBtn").addEventListener("click", () => {
      document.getElementById("startOverlay").style.display = "none";
      startGameLoop();
    });
  });
</script>

</body>
</html>
