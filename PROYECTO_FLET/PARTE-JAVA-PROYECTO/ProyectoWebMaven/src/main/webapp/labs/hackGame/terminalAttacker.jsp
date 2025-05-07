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
  <title>Terminal Linux</title>
  <style>
  	body {
  background: #000;
  color: #33ff33;
  font-family: monospace;
  margin: 0;
  padding: 0;
  height: 100vh;
}

.terminal {
  padding: 10px;
  height: 100%;
  overflow-y: auto;
}

.output {
  white-space: pre-wrap;
}

.input-line {
  display: flex;
  align-items: center;
}

.prompt {
  margin-right: 5px;
}

input {
  background: transparent;
  border: none;
  color: #33ff33;
  outline: none;
  font-family: monospace;
  font-size: 1em;
  width: 100%;
}
  	
  </style>
</head>
<body>
  <div class="terminal" id="terminal">
    <div class="output" id="output"></div>
    <div class="input-line">
      <span class="prompt" id="prompt">root@attacker:~$</span>
      <input type="text" id="input" autofocus autocomplete="off" />
    </div>
  </div>
  <script>
  const input = document.getElementById('input');
  const output = document.getElementById('output');
  const terminal = document.getElementById('terminal');

  let username = 'root';
  let hostname = 'attacker';
  let path = '~';
  let history = [];
  let historyIndex = -1;

  function printOutput(text) {
    output.innerHTML += text + '\n';
    terminal.scrollTop = terminal.scrollHeight;
  }

  function processCommand(command) {
	  const args = command.trim().split(' ');
	  const main = args[0];
	  let result = '';

	  if (main === 'nc' && args[1] === '-lvnp' && args[2]) {
	    const port = args[2];
	    sessionStorage.setItem('nc-port', port); // guardar escucha local
	    fetch('conexionListener.jsp?port=' + port); // informar al backend
	    result = `Escuchando en el puerto ${port}...`;
	  } else {
	    switch (main) {
	      case 'whoami': result = username; break;
	      case 'pwd': result = '/home/' + username; break;
	      case 'ls': result = 'documentos  descargas  música  escritorio'; break;
	      case 'hostname': result = 'attacker'; break;
	      case 'clear': output.innerHTML = ''; return;
	      case '': result = ''; break;
	      default: result = main + ': comando no encontrado';
	    }
	  }

	  // Mostrar comando y resultado como un bloque nuevo
	  output.innerHTML += '<div>' + '<span class="prompt">' + username + '@' + hostname + ':' + path + '$' + '</span> ' + command + '</div>';
	  if (result) {
	    output.innerHTML += '<div>' + result + '</div>';
	  }
	  terminal.scrollTop = terminal.scrollHeight;
	}

	input.addEventListener('keydown', function (e) {
	  if (e.key === 'Enter') {
	    const command = input.value;
	    history.push(command);
	    historyIndex = history.length;
	    processCommand(command);
	    input.value = '';
	  } else if (e.key === 'ArrowUp') {
	    if (historyIndex > 0) {
	      historyIndex--;
	      input.value = history[historyIndex];
	    }
	  } else if (e.key === 'ArrowDown') {
	    if (historyIndex < history.length - 1) {
	      historyIndex++;
	      input.value = history[historyIndex];
	    } else {
	      input.value = '';
	    }
	  }
	});
  </script>
</body>
</html>