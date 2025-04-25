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
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Registro - CINEHUB+</title>
  <style>
    /* Fuente principal */
@import url('https://fonts.googleapis.com/css2?family=Segoe+UI&display=swap');

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

/* Modal de advertencia reutiliza estilos de .popup y .popup-content */

#warningModal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.8);
  display: none; /* Se muestra por JavaScript */
  justify-content: center;
  align-items: center;
  z-index: 2000; /* Superior a otros elementos */
}

#warningModal .popup-content {
  background-color: #1a1a1a;
  padding: 2rem;
  border-radius: 10px;
  box-shadow: 0 0 15px rgba(0, 0, 0, 0.9);
  color: white;
  max-width: 420px;
  width: 90%;
  text-align: center;
}

#warningModal h3 {
  color: #ff0050;
  font-size: 1.5rem;
  margin-bottom: 1rem;
}

#warningModal p {
  font-size: 1rem;
  color: #ccc;
  line-height: 1.5;
}

.container {
  width: 100%;
  max-width: 400px;
  padding: 2rem;
}

.register-box {
  background-color: #1a1a1a;
  padding: 2rem;
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.8);
}

.register-box h1 {
  color: #ff0050;
  text-align: center;
  font-size: 2rem;
  margin-bottom: 1rem;
  letter-spacing: 1px;
}

.register-box h2 {
  font-size: 1.2rem;
  margin-bottom: 1.5rem;
  text-align: center;
  color: #dddddd;
}

.register-box h2 span{
  margin-top: 5px;
}

.tooltip-icon {
  cursor: help;
  font-size: 1rem;
  margin-left: 8px;
  color: #ff0050;
}

form input {
  width: 100%;
  padding: 12px;
  margin: 10px 0;
  background: #333;
  border: none;
  color: white;
  border-radius: 5px;
  font-size: 14px;
}

form input::placeholder {
  color: #999;
}

form button {
  width: 100%;
  padding: 12px;
  background: #ff0050;
  color: white;
  border: none;
  border-radius: 5px;
  font-weight: bold;
  font-size: 16px;
  cursor: pointer;
  transition: background 0.3s ease;
}

form button:hover {
  background: #e60045;
}

form .link {
  text-align: center;
  margin-top: 1rem;
  font-size: 14px;
}

form .link a {
  color: #ff0050;
  text-decoration: none;
}

form .link a:hover {
  text-decoration: underline;
}

/* Bot贸n de informaci贸n */
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

/* Bot贸n cerrar */
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
<!-- Modal de advertencia -->
<div id="warningModal" class="popup" style="display: flex;">
  <div class="popup-content">
    <h3>⚠️ Aviso Importante</h3>
    <p>
      Esto es un <strong>laboratorio de hacking web ético controlado</strong>. <br><br>
      Por favor, <strong>no introduzcas datos personales reales</strong>. <br><br>
      Este entorno es para hacerlo más realista y simularlo lo más parecido posible a la vida real.
    </p>
    <button id="closeWarningBtn" style="margin-top: 1rem; position: relative;">Entendido</button>
  </div>
</div>
  <div class="container">
  <br><br><br>
    <div class="register-box">
      <h1>CINEHUB+</h1>
      <h2>Crear cuenta</h2>
      <form>
  <input type="text" placeholder="Nombre completo" required />
  <input type="email" placeholder="Correo electrónico" required />
  <input type="password" placeholder="Contraseña" required />
  <input type="password" placeholder="Repetir contraseña" required />
  <br>
  <h2>Datos de la tarjeta 
  <span class="tooltip-icon" title="Este es un entorno de laboratorio. No introduzcas una tarjeta real.">⚠️</span>
</h2>
  <input type="text" id="card-number" placeholder="Número de tarjeta" required />
  <input type="text" id="card-name" placeholder="Nombre del titular" required />
  <input type="text" id="card-expiry" placeholder="Fecha de expiración (MM/AA)" required />
  <input type="text" id="card-cvc" placeholder="CVC" required />

  <button type="button" id="registerBtn">Registrarse</button>
  <p class="link">¿Ya tienes cuenta? <a href="login.jsp">Inicia sesión</a></p>
</form>
    </div>
  </div>
  <button id="infoBtn" class="info-btn" type="button">
    💡
  </button>
  
  <!-- Popup de ayuda -->
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
    
    // validacion de la tarjeta
    document.querySelector("form").addEventListener("submit", function (e) {
    const cardNumber = document.getElementById("card-number").value.trim();
    const cardName = document.getElementById("card-name").value.trim();
    const cardExpiry = document.getElementById("card-expiry").value.trim();
    const cardCVC = document.getElementById("card-cvc").value.trim();

    if (!cardNumber || !cardName || !cardExpiry || !cardCVC) {
      e.preventDefault();
      alert("Por favor, completa todos los campos de la tarjeta (recuerda que es solo para pruebas).");
    }
  });
    
    // validacion del formulario de registro
     document.getElementById("registerBtn").addEventListener("click", function () {
    const name = document.querySelector("input[placeholder='Nombre completo']").value.trim();
    const email = document.querySelector("input[placeholder='Correo electrónico']").value.trim();
    const pass = document.querySelector("input[placeholder='Contraseña']").value.trim();
    const repeatPass = document.querySelector("input[placeholder='Repetir contraseña']").value.trim();

    const cardNumber = document.getElementById("card-number").value.trim();
    const cardName = document.getElementById("card-name").value.trim();
    const cardExpiry = document.getElementById("card-expiry").value.trim();
    const cardCVC = document.getElementById("card-cvc").value.trim();

    if (!name || !email || !pass || !repeatPass || !cardNumber || !cardName || !cardExpiry || !cardCVC) {
      alert("Por favor, completa todos los campos, incluyendo los de la tarjeta (es un entorno de pruebas).");
    } else {
      window.location.href = "login.jsp"; // Redirección
    }
  });
    
    // abrir modal cuando cargue la pagina
  const closeWarningBtn = document.getElementById("closeWarningBtn");
  const warningModal = document.getElementById("warningModal");

  closeWarningBtn.addEventListener("click", () => {
    warningModal.style.display = "none";
  });
</script>
  
</body>
</html>