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
  <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/img/icono/icono_cinco_hackend.ico">
  <title>Panel de Administrador | Hacking Community</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin-panel-secret.css">
</head>
<body>
  <header>
    <div class="container">
      <div class="logo">HACKING COMMUNITY</div>
      <nav>
        <ul>
          <li><a href="hacking_community.jsp">Inicio</a></li>
          <li><a href="admin.jsp">Panel</a></li>
        </ul>
      </nav>
    </div>
  </header>
  <h1>---------------------------------------&gt; FLAG{flag_bac} &lt;---------------------------------------</h1>
  <main class="container">
    <h1>Panel de Administrador</h1>
    <p class="intro-text">Bienvenido al panel de administración. Aquí puedes gestionar tus artículos, ver estadísticas y controlar el contenido del blog.</p>

    <div class="panel-grid">
      <div class="panel-card">
        <h2>Crear nuevo artículo</h2>
        <p>Redacta y publica un nuevo artículo para el blog.</p>
        <a href="#" class="btn-panel">Crear</a>
      </div>

      <div class="panel-card">
        <h2>Editar artículos</h2>
        <p>Modifica artículos existentes o elimina los que ya no necesites.</p>
        <a href="#" class="btn-panel">Editar</a>
      </div>

      <div class="panel-card">
        <h2>Estadísticas</h2>
        <p>Consulta las métricas de tráfico y actividad del blog.</p>
        <a href="#" class="btn-panel">Ver estadísticas</a>
      </div>

      <div class="panel-card">
        <h2>Configuración</h2>
        <p>Ajusta las opciones del sistema y del sitio web.</p>
        <a href="#" class="btn-panel">Configurar</a>
      </div>
      <div class="panel-card">
        <h2>Laboratorio de pruebas</h2>
        <p>Administra los retos y vulnerabilidades disponibles para practicar hacking.</p>
        <a href="#" class="btn-panel">Gestionar</a>
      </div>
    
      <div class="panel-card">
        <h2>Comentarios de usuarios</h2>
        <p>Modera y responde a los comentarios recibidos en el blog.</p>
        <a href="#" class="btn-panel">Ver comentarios</a>
      </div>
    </div>
  </main>
  <footer>
    <p>&copy; 2025 Hacking Community. Todos los derechos reservados.</p>
  </footer>
</body>
</html>
