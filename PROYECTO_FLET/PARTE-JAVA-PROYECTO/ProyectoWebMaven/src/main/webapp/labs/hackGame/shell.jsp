<%@ page contentType="text/html;charset=UTF-8" %>
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
<html>
<head>
  <meta charset="UTF-8">
  <title>Reverse Shell - root</title>
  <style>
    body {
      background: #000;
      color: #33ff33;
      font-family: monospace;
      margin: 0;
      padding: 10px;
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
<div class="output" id="output"></div>
<div class="input-line">
  <span class="prompt" id="prompt">root@victim:/#</span>
  <input type="text" id="input" autofocus />
</div>
<script>
  const output = document.getElementById('output');
  const input = document.getElementById('input');
  const prompt = document.getElementById('prompt');

  input.addEventListener('keydown', function (e) {
    if (e.key === 'Enter') {
      const cmd = input.value;
      output.innerHTML += '<div>' + prompt.textContent + ' ' + cmd + '</div>';
      let response = '';
      switch (cmd.trim()) {
        case 'whoami': response = 'root'; break;
        case 'id': response = 'uid=0(root) gid=0(root)'; break;
        case 'hostname': response = 'victim'; break;
        case 'pwd': response = '/root'; break;
        case 'ls': response = 'flag.txt  .bashrc  exploit.c'; break;
        case 'ls /root': response = 'flag.txt  .bashrc  exploit.c'; break;
        case 'cat flag.txt': response = 'CTF{hackGame_flag}'; break;
        case 'hostname -I': response = + ip; break;
        case 'clear': output.innerHTML = ''; input.value = ''; return;
        default: response = cmd + ': comando no encontrado';
      }
      output.innerHTML += '<div>' + response + '</div>';
      input.value = '';
      window.scrollTo(0, document.body.scrollHeight);
    }
  });
</script>
</body>
</html>
