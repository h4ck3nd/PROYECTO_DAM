<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Panel de Configuración - Router OS</title>
  <style>
    /* Dashboard Layout */
body.dashboard-body {
  margin: 0;
  font-family: Arial, sans-serif;
  display: flex;
  background-color: #f5f7fa;
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

/* Main Content */
.main-content {
  flex-grow: 1;
  padding: 1rem 2rem;
}

.topbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: #e4eaf1;
  padding: 1rem;
  border-bottom: 1px solid #ccc;
}

.user-info {
  font-weight: bold;
  color: #333;
}

/* Status Content */
.content {
  padding: 2rem 0;
}

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

  </style>
</head>
<body class="dashboard-body">
  <div class="sidebar">
    <div class="sidebar-header">
      <img src="<%= request.getContextPath() %>/img/routeros-logo.png" alt="RouterOS" class="sidebar-logo" />
      <h3>RouterOS</h3>
    </div>
    <ul class="sidebar-menu">
      <li class="active"><a href="<%= request.getContextPath() %>/labs/router/dashboard.jsp">Estado</a></li>
      <li><a href="<%= request.getContextPath() %>/labs/router/wifi.jsp">WiFi</a></li>
      <li><a href="<%= request.getContextPath() %>/labs/router/lan.jsp">Red LAN</a></li>
      <li><a href="<%= request.getContextPath() %>/labs/router/wan.jsp">Red WAN</a></li>
      <li><a href="<%= request.getContextPath() %>/labs/router/firewall.jsp">Seguridad</a></li>
      <li><a href="<%= request.getContextPath() %>/labs/router/admin.jsp">Administración</a></li>
    </ul>
  </div>

  <div class="main-content">
    <header class="topbar">
      <h2>Panel de Configuración</h2>
      <span class="user-info">admin</span>
    </header>

    <section class="content">
      <h3>Estado del Sistema</h3>
      <div class="status-grid">
        <div class="status-box">
          <h4>Conexión</h4>
          <p><strong>Estado:</strong> Conectado</p>
          <p><strong>IP Pública:</strong> 192.168.200.1</p>
        </div>
        <div class="status-box">
          <h4>WiFi</h4>
          <p><strong>SSID:</strong> RouterOS_1234</p>
          <p><strong>Canal:</strong> 6</p>
        </div>
        <div class="status-box">
          <h4>LAN</h4>
          <p><strong>Dispositivos:</strong> 3 conectados</p>
          <p><strong>IP Interna:</strong> 192.168.200.1</p>
        </div>
      </div>
    </section>
  </div>
</body>
</html>
