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
  <title>Administración - Router Movistar</title>
  <style>
    /* Reset general */
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  font-family: Arial, sans-serif;
  background-color: #f4f6f9;
  color: #333;
  display: flex;
}

/* Sidebar */
.sidebar {
  width: 240px;
  background-color: #004a8f;
  color: white;
  min-height: 100vh;
  padding: 1rem 0;
  box-shadow: 2px 0 5px rgba(0,0,0,0.1);
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

/* Main Content*/
.main-content {
  flex: 1;
  padding: 20px;
}

.topbar {
  background-color: #ffffff;
  padding: 15px 20px;
  border-bottom: 1px solid #d1d9e6;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.topbar h2 {
  font-size: 20px;
  color: #004a8f;
}

.user-info {
  font-size: 14px;
  color: #555;
}

/* Formulario */
form {
  background-color: #ffffff;
  padding: 20px;
  margin-top: 20px;
  border: 1px solid #d1d9e6;
  border-radius: 5px;
}

.form-group {
  margin-bottom: 15px;
}

.form-group label {
  display: block;
  font-weight: bold;
  margin-bottom: 6px;
  color: #004a8f;
}

.form-group input,
.form-group button {
  width: 100%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
}

button[type="submit"],
button[type="button"] {
  background-color: #004a8f;
  color: white;
  padding: 10px 20px;
  border: none;
  font-weight: bold;
  border-radius: 4px;
  cursor: pointer;
}

button[type="submit"]:hover,
button[type="button"]:hover {
  background-color: #006fd6;
}

/* Tablas */
table {
  width: 100%;
  border-collapse: collapse;
  background-color: white;
  border: 1px solid #d1d9e6;
  margin-top: 1rem;
}

table th,
table td {
  padding: 0.75rem;
  border: 1px solid #d1d9e6;
  text-align: left;
}

table th {
  background-color: #e4eaf1;
  color: #004a8f;
  font-weight: bold;
}

table tbody tr:hover {
  background-color: #f0f4f9;
}

/* Responsive */
@media (max-width: 768px) {
  body {
    flex-direction: column;
  }

  .sidebar {
    width: 100%;
    min-height: auto;
    padding: 10px;
  }

  .main-content {
    padding: 10px;
  }

  .topbar {
    flex-direction: column;
    align-items: flex-start;
  }
}
.flag{
	align-content: center;
	align-items: center;
	text-align: center;
	margin-left: 550px;
	font-weight: bold;
	font-size: 40px;
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
      <li><a href="<%= request.getContextPath() %>/labs/router/wifi.jsp">WiFi</a></li>
      <li><a href="<%= request.getContextPath() %>/labs/router/lan.jsp">Red LAN</a></li>
      <li><a href="<%= request.getContextPath() %>/labs/router/wan.jsp">Red WAN</a></li>
      <li><a href="<%= request.getContextPath() %>/labs/router/firewall.jsp">Seguridad</a></li>
      <li class="active"><a href="<%= request.getContextPath() %>/labs/router/admin.jsp">Administración</a></li>
    </ul>
  </div>

  <div class="main-content">
    <header class="topbar">
      <h2>Panel de Administración</h2>
      <span class="user-info">admin</span>
    </header>

    <section class="content">
      <h3>Opciones de Administración</h3>

      <form method="post" action="#">
        <div class="form-group">
          <label for="admin-password">Cambiar Contraseña de Administrador:</label>
          <input type="password" id="admin-password" name="admin-password" placeholder="Nueva Contraseña" />
        </div>

        <div class="form-group">
          <label for="reboot-router">Reiniciar Router:</label>
          <button type="button" id="reboot-router">Reiniciar</button>
        </div>

        <div class="form-group">
          <label for="restore-factory">Restaurar Ajustes de Fábrica:</label>
          <button type="button" id="restore-factory">Restaurar</button>
        </div>

        <button type="submit">Guardar Cambios</button>
      </form>

      <h3>Configuración de Usuarios</h3>
      <table class="admin-table">
        <thead>
          <tr>
            <th>ID</th>
            <th>Nombre de Usuario</th>
            <th>Acción</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>1</td>
            <td>admin</td>
            <td><button type="button">Eliminar</button></td>
          </tr>
          <tr>
            <td>2</td>
            <td>usuario1</td>
            <td><button type="button">Eliminar</button></td>
          </tr>
        </tbody>
      </table>
      <br><br><br>
      <a class="flag">FLAG: FLAG{idor_flag}</a>
    </section>
  </div>
</body>
</html>