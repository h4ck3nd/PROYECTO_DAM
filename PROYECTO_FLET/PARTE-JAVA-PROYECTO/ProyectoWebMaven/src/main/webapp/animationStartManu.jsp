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
  <meta charset="UTF-8" />
  <title>Starting System...</title>
  <style>
    html, body {
      margin: 0;
      padding: 0;
      background: #000;
      height: 100%;
      overflow: hidden;
      font-family: 'Courier New', Courier, monospace;
      color: #00FF00;
    }

    .screen {
      position: relative;
      width: 100vw;
      height: 100vh;
      padding: 40px;
      box-sizing: border-box;
      background: #000;
      display: flex;
      align-items: center;
      justify-content: center;
      filter: contrast(1.2) brightness(1.1);
    }

    .terminal {
      width: 90%;
      max-width: 1000px;
      height: 90%;
      padding: 20px;
      background: rgba(0, 0, 0, 0.9);
      box-shadow:
        inset 0 0 60px rgba(0,255,0,0.3),
        0 0 20px rgba(0,255,0,0.4);
      overflow: hidden;
      position: relative;
      border-radius: 8px;
      transform: perspective(800px) rotateX(3deg) scale(1.05);
    }

    .terminal::after {
      content: "";
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: repeating-linear-gradient(
        to bottom,
        rgba(0,255,0,0.03) 0px,
        rgba(0,255,0,0.03) 2px,
        transparent 2px,
        transparent 4px
      );
      pointer-events: none;
      z-index: 2;
    }

    .fisheye {
      position: absolute;
      width: 100%;
      height: 100%;
      pointer-events: none;
      background: radial-gradient(ellipse at center, rgba(0,255,0,0.03) 0%, transparent 80%);
      mix-blend-mode: overlay;
      z-index: 3;
    }

    #output {
      white-space: pre-wrap;
      font-size: 16px;
      line-height: 1.5;
      z-index: 1;
      position: relative;
      color: #00FF00;
      text-shadow: 0 0 2px #0f0;
    }

    .cursor {
      display: inline-block;
      width: 10px;
      height: 20px;
      background: #00ff00;
      margin-left: 2px;
      animation: blink 0.8s steps(2, start) infinite;
    }

    @keyframes blink {
      to { visibility: hidden; }
    }

    .glitch {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: repeating-linear-gradient(to bottom, rgba(0,255,0,0.05) 0px, transparent 2px);
      opacity: 0.2;
      animation: flicker 0.15s infinite;
      z-index: 4;
    }

    @keyframes flicker {
      0% { opacity: 0.2; transform: scaleX(1); }
      50% { opacity: 0.25; transform: scaleX(1.01); }
      100% { opacity: 0.2; transform: scaleX(1); }
    }
  </style>
</head>
<body>
  <div class="screen">
    <div class="terminal">
      <div class="glitch"></div>
      <div class="fisheye"></div>
      <div id="output"></div><span class="cursor"></span>
    </div>
  </div>

  <script>
    const lines = [
      "Phoenix BIOS v4.0 Release 6.0    ",
      "Copyright 1985-2005 Phoenix Technologies Ltd.",
      "All Rights Reserved",
      "",
      "Detecting IDE drives...",
      "Primary Master: ST380011A",
      "Primary Slave:   Not Detected",
      "Secondary Master: TSSTcorp CD/DVDW",
      "Secondary Slave: Not Detected",
      "",
      "Booting from hard drive...",
      "Loading operating system...",
      "Starting Windows XP...",
      "",
      "Initializing services...",
      "Authenticating user...",
      "System successfully started.",
      "",
      "Welcome."
    ];

    const output = document.getElementById("output");
    let lineIndex = 0;
    let charIndex = 0;

    function typeLine() {
      if (lineIndex >= lines.length) {
        setTimeout(() => {
          window.location.href = "<%= request.getContextPath() %>/infoProfile/indexManu.jsp";
        }, 1000);
        return;
      }

      const line = lines[lineIndex];
      if (charIndex < line.length) {
        output.innerHTML += line.charAt(charIndex);
        charIndex++;
        setTimeout(typeLine, 30); // velocidad de escritura por caracter
      } else {
        output.innerHTML += "\n";
        lineIndex++;
        charIndex = 0;
        setTimeout(typeLine, 150); // pausa entre líneas
      }
    }

    window.onload = () => {
      typeLine();
    };
  </script>
</body>
</html>
