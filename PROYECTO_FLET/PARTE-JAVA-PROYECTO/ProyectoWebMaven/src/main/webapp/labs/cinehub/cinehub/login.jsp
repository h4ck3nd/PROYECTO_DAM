<%@ page contentType="text/html; charset=UTF-8" language="java"%>
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
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Login - CINEHUB+</title>
  <style>
    * {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  background-color: #0e0e0e;
  font-family: 'Segoe UI', sans-serif;
  color: white;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
}

.container {
  width: 100%;
  max-width: 400px;
  padding: 2rem;
}

.login-box {
  background-color: #1a1a1a;
  padding: 2rem;
  border-radius: 10px;
  box-shadow: 0 0 10px #000;
}

.login-box h1 {
  color: #ff0050;
  text-align: center;
  font-size: 2rem;
  margin-bottom: 1rem;
}

.login-box h2 {
  font-size: 1.2rem;
  margin-bottom: 1rem;
  text-align: center;
}

form input {
  width: 100%;
  padding: 12px;
  margin: 10px 0;
  background: #333;
  border: none;
  color: white;
  border-radius: 5px;
}

form button {
  width: 100%;
  padding: 12px;
  background: #ff0050;
  color: white;
  border: none;
  border-radius: 5px;
  font-weight: bold;
  cursor: pointer;
}

form .link {
  text-align: center;
  margin-top: 1rem;
}

form .link a {
  color: #ff0050;
  text-decoration: none;
}

/* Botón de información */
.info-btn {
  position: fixed;
  bottom: 20px;
  right: 20px;
  background-color: #ff0050;
  color: white;
  border: none;
  font-size: 1.5rem;
  width: 50px;
  height: 50px;
  border-radius: 50%;
  cursor: pointer;
  box-shadow: 0 0 15px rgba(255, 0, 80, 0.6);
  display: flex;
  justify-content: center;
  align-items: center;
  transition: background 0.3s, transform 0.3s;
  z-index: 1001;
}

.info-btn:hover {
  background-color: #e60045;
  transform: scale(1.1);
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
  <div class="container">
    <div class="login-box">
      <h1>CINEHUB+</h1>
      <h2>Inicia sesión</h2>
      <form action="<%= request.getContextPath() %>/LoginCinehubControlador" method="post">
	    <input type="text" name="username" placeholder="Correo electrónico" required />
	    <input type="password" name="password" placeholder="Contraseña" required />
	    <button type="submit">Entrar</button>
	    <p class="link">¿No tienes cuenta? <a href="<%= request.getContextPath() %>/labs/cinehub/registro.jsp">Regístrate</a></p>
	</form>
    </div>
  </div>
  <button id="infoBtn" class="info-btn" type="button">
    💡
  </button>
  
  <div id="popup" class="popup">
    <div class="popup-content">
	    <span id="closePopup" class="close-btn">&times;</span>
	    <h3>¿Qué es XPath?</h3>
	    <p>XPath es un lenguaje para navegar documentos XML y buscar datos específicos. Por ejemplo, puedes buscar un nombre de usuario en un archivo XML.</p>
	    <br>
	    <h3>¿Qué es XPath Injection?</h3>
	    <p>Es una vulnerabilidad donde un atacante manipula consultas XPath, como al poner <code>' or '1'='1</code> en el login, para entrar sin credenciales.</p>
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
  </script>
  
</body>
</html>