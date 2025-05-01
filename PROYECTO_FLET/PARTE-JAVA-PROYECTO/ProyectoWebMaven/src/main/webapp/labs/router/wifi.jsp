<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="utils.JWTUtils" %>
<%@ page import="utils.UsuarioJWT" %>

<%
	//Obtener el header 'Accept-Language' de la solicitud
	String lang = request.getHeader("Accept-Language");
	
	// Verificar si el idioma es 'ru'
	if (lang == null || !lang.toLowerCase().startsWith("ru")) {
	    // Si no es ruso, redirigir a otra página (por ejemplo, login.jsp)
	    response.sendRedirect(request.getContextPath() + "/labs/router/login.jsp");
	    return;
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
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Configuración WiFi - Router Movistar</title>
  <style>
    /* ======= Reset básico ======= */
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  font-family: Arial, sans-serif;
  background-color: #f5f7fa;
  color: #333;
}

/* ======= Layout principal ======= */
.dashboard-body {
  display: flex;
  min-height: 100vh;
}

/* ======= Sidebar ======= */
.sidebar {
  width: 240px;
  background-color: #004a8f;
  color: white;
  min-height: 100vh;
  padding: 1rem 0;
  box-shadow: 2px 0 5px rgba(0,0,0,0.1);
  display: flex;
  flex-direction: column;
  align-items: center;
}

.sidebar-header {
  text-align: center;
  margin-bottom: 2rem;
}

.sidebar-logo {
  width: 60px;
  margin-bottom: 0.5rem;
}

.sidebar h3 {
  font-size: 1.1rem;
  margin: 0;
}

.sidebar-menu {
  list-style: none;
  padding: 0;
  width: 100%;
}

.sidebar-menu li {
  padding: 0.75rem 1.5rem;
  cursor: pointer;
  transition: background 0.3s;
}

.sidebar-menu li a {
  color: white;
  text-decoration: none;
  display: block;
}

.sidebar-menu li:hover,
.sidebar-menu .active,
.sidebar-menu .active a {
  background-color: #0066cc;
}

/* ======= Contenido principal ======= */
.main-content {
  flex-grow: 1;
  padding: 1rem 2rem;
}

/* ======= Topbar ======= */
.topbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: #e4eaf1;
  padding: 1rem;
  border-bottom: 1px solid #ccc;
}

.topbar h2 {
  margin: 0;
  font-size: 1.5rem;
  color: #004a8f;
}

.user-info {
  font-weight: bold;
  color: #004a8f;
}

/* ======= Sección de contenido ======= */
.content {
  padding: 2rem 0;
}

/* ======= Cuadros de estado ======= */
.status-grid {
  display: flex;
  gap: 1rem;
  flex-wrap: wrap;
}

.status-box {
  background-color: white;
  padding: 1rem;
  border: 1px solid #d1d9e6;
  border-radius: 8px;
  flex: 1 1 250px;
  box-shadow: 0 0 5px rgba(0,0,0,0.05);
}

.status-box h4 {
  margin-top: 0;
  color: #004a8f;
}

/* ======= Formularios ======= */
form {
  max-width: 600px;
  background: #fff;
  padding: 2rem;
  border-radius: 8px;
  border: 1px solid #d1d9e6;
  box-shadow: 0 0 5px rgba(0,0,0,0.05);
}

.form-group {
  margin-bottom: 1.5rem;
  display: flex;
  flex-direction: column;
}

.form-group label {
  font-weight: bold;
  margin-bottom: 0.5rem;
  color: #004a8f;
}

.form-group input,
.form-group select {
  padding: 0.5rem;
  border: 1px solid #ccd6e0;
  border-radius: 4px;
  font-size: 1rem;
}

button[type="submit"] {
  background-color: #0070cc;
  color: white;
  border: none;
  padding: 0.75rem 1.2rem;
  border-radius: 4px;
  font-size: 1rem;
  cursor: pointer;
  transition: background 0.3s;
}

button[type="submit"]:hover {
  background-color: #005fa3;
}

/* ======= Responsive básico ======= */
@media (max-width: 768px) {
  .dashboard-body {
    flex-direction: column;
  }

  .sidebar {
    width: 100%;
    flex-direction: row;
    overflow-x: auto;
  }

  .sidebar-menu {
    display: flex;
    flex-direction: row;
    justify-content: space-around;
  }

  .main-content {
    padding: 1rem;
  }

  form {
    width: 100%;
  }
}

  </style>
</head>
<body class="dashboard-body">
  <div class="sidebar">
    <div class="sidebar-header">
        <img src="<%= request.getContextPath() %>/img/routeros-logo.png" alt="RouterOS" class="sidebar-logo" />
        <h3>RouterOS</h3>
    </div>
    <ul class="sidebar-menu">
     <li><a href="<%= request.getContextPath() %>/labs/router/dashboard.jsp">Estado</a></li>
      <li class="active"><a href="<%= request.getContextPath() %>/labs/router/wifi.jsp">WiFi</a></li>
      <li><a href="<%= request.getContextPath() %>/labs/router/lan.jsp">Red LAN</a></li>
      <li><a href="<%= request.getContextPath() %>/labs/router/wan.jsp">Red WAN</a></li>
      <li><a href="<%= request.getContextPath() %>/labs/router/firewall.jsp">Seguridad</a></li>
      <li><a href="<%= request.getContextPath() %>/labs/router/admin.jsp">Administración</a></li>
    </ul>
  </div>

  <div class="main-content">
    <header class="topbar">
      <h2>Configuración WiFi</h2>
      <span class="user-info">admin</span>
    </header>

    <section class="content">
      <form method="post" action="#">
        <div class="form-group">
          <label for="ssid">Nombre de la red (SSID):</label>
          <input type="text" id="ssid" name="ssid" value="RouterOS_1234" />
        </div>

        <div class="form-group">
          <label for="password">Contraseña WiFi:</label>
          <input type="text" id="password" name="password" value="12345678" />
        </div>

        <div class="form-group">
          <label for="channel">Canal:</label>
          <select id="channel" name="channel">
            <option value="1">1</option>
            <option value="6" selected>6</option>
            <option value="11">11</option>
          </select>
        </div>

        <div class="form-group">
          <label for="security">Tipo de seguridad:</label>
          <select id="security" name="security">
            <option>WPA2-PSK</option>
            <option>WPA3</option>
            <option>Abierta (no recomendado)</option>
          </select>
        </div>

        <button type="submit">Guardar Cambios</button>
      </form>
    </section>
  </div>
</body>
</html>