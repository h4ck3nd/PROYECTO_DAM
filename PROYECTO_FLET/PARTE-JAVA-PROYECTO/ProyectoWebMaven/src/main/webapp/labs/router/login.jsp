<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="utils.JWTUtils" %>
<%@ page import="utils.UsuarioJWT" %>

<%

	String lang = request.getHeader("Accept-Language");
	
	if (lang != null && lang.toLowerCase().startsWith("ru")) {
	    // Simulamos un fallo de idioma: la traducción da un string vacío
	    String mensaje = ""; // aquí estaría el error de codificación real
	
	    // Vulnerabilidad lógica: si el mensaje está vacío, asume login válido
	    if (mensaje.isEmpty()) {
	        session.setAttribute("auth", true); // 🔓 acceso otorgado sin autenticación
	        response.sendRedirect(request.getContextPath() + "/labs/router/dashboard.jsp");
	        return;
	    }
	}

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
    <title>Router Smart WiFi 6 Go</title>
    <style>
      * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    background-color: #f2f3f2;
    display: flex;
    flex-direction: column;
    min-height: 100vh;
}

.header {
    background-color: white;
    padding: 10px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.logo {
    height: 40px;
}

.title {
    color: #70b21c;
    font-size: 24px;
}

.main {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px;
}

.login-box {
    background-color: #f2f3f2;
    text-align: center;
    max-width: 600px;
}

.login-box p {
    margin-bottom: 20px;
    font-size: 14px;
    color: #333;
}

.login-box a {
    color: #4169e1;
    text-decoration: none;
}

.login-form {
    display: flex;
    justify-content: center;
    gap: 10px;
    margin-bottom: 20px;
}

.login-form input {
    padding: 10px;
    font-size: 16px;
    width: 300px;
}

.login-form button {
    background-color: #70b21c;
    color: white;
    border: none;
    padding: 10px 20px;
    font-size: 16px;
    cursor: pointer;
}

.login-form button:hover {
    background-color: #5a9218;
}

.image-guide img {
    margin-top: 20px;
    max-width: 100%;
    height: auto;
}

.footer {
    background-color: white;
    text-align: center;
    padding: 10px;
    font-size: 12px;
    color: #555;
}

    </style>
</head>
<body>
    <header class="header">
        <img src="<%= request.getContextPath() %>/img/routeros-logo.png" alt="RouterOS" class="logo">
        <h1 class="title">Router Smart WiFi 6 Go</h1>
    </header>

    <main class="main">
        <section class="login-box">
            <p>Bienvenido al configurador de tu router Fibra Óptica. Por favor, para poder configurar tu router debes introducir la contraseña que encontrarás en la pegatina situada debajo de tu router denominada "Datos de acceso al equipo", siempre que no la hayas modificado anteriormente. En este caso, deberás introducir la nueva contraseña de acceso. 
            <a href="#">¿Has olvidado tu contraseña?</a></p>

            <form class="login-form">
                <input type="password" placeholder="Introduce la contraseña" required>
                <button type="submit">Entrar</button>
            </form>

            <div class="image-guide">
                <img src="<%= request.getContextPath() %>/img/guia-router.png" alt="Ubicación de la contraseña">
            </div>
        </section>
    </main>

    <footer class="footer">
        <p>UNA MARCA DE HACKEND</p>
        <p>© RouterOS de España S.A.U. Todos los derechos reservados. | 2.0</p>
        <!-- Botón de solución -->
<button id="solucionBtn" style="position: fixed; bottom: 20px; right: 20px; background-color: #fff; border: 2px solid #70b21c; color: #70b21c; font-size: 24px; padding: 15px 15px; border-radius: 50%; cursor: pointer;" title="Ver solución">💡</button>

<!-- Popup de solución -->
<div id="popupSolucion" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: white; border: 2px solid #70b21c; padding: 30px; z-index: 1000; max-width: 400px; text-align: center; border-radius: 10px; box-shadow: 0 4px 10px rgba(0,0,0,0.2);">
    <p style="font-size: 16px; color: #333;">Este laboratorio debe realizarse con <strong>Burp Suite</strong>. Asegúrate de interceptar la petición correctamente.</p>
    <button onclick="document.getElementById('popupSolucion').style.display='none'" style="margin-top: 20px; padding: 8px 20px; background-color: #70b21c; color: white; border: none; border-radius: 5px; cursor: pointer;">Cerrar</button>
</div>
<script>
    document.getElementById('solucionBtn').addEventListener('click', function() {
        document.getElementById('popupSolucion').style.display = 'block';
    });
</script>
    </footer>
</body>
</html>
