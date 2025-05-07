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
  <link rel="icon" href="<%= request.getContextPath() %>/infoProfile/favicon.html" />
  <link rel="canonical" href="<%= request.getContextPath() %>/infoProfile/index.jsp" />
  <title>El blog de d1se0</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/infoProfile/css/bootstrap.css" />
  <link rel="stylesheet" href="<%= request.getContextPath() %>/infoProfile/css/bootstrap-responsive.css" />
  <link rel="stylesheet" href="<%= request.getContextPath() %>/infoProfile/css/style.css" />
</head>

<body>
  <nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
      <div class="container">
        <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"></button>
        <a class="brand" href="<%= request.getContextPath() %>/infoProfile/index.jsp">El blog de d1se0</a>
        <div class="nav-collapse collapse">
          <ul class="nav">
            <li><a href="<%= request.getContextPath() %>/infoProfile/cv/index.jsp"><span>Curriculum Vitae</span></a></li>
            <li><a href="<%= request.getContextPath() %>/infoProfile/about/index.jsp"><span>Sobre mí</span></a></li>
          </ul>
        </div>
      </div>
    </div>
  </nav>

  <div id="content" class="container">
    <div class="row-fluid navmargin">
      <div class="page-header">
        <h1>Sobre mí - Mon, Jun 8, 2020</h1>
      </div>

      <p class="lead">Sobre mí</p>
		<p>Soy hacker ético y apasionado del mundo del hacking desde muy joven. Siempre me ha fascinado entender cómo funcionan los sistemas, explorar sus límites y descubrir vulnerabilidades de forma responsable.</p>
		<p>Con el tiempo, he desarrollado múltiples proyectos relacionados con la ciberseguridad, tanto personales como colaborativos, y he adquirido diversas certificaciones que respaldan mis conocimientos en el área.</p>
		<p>Me considero una persona autodidacta, inquieta y comprometida con la mejora continua. En mi día a día toco todos los aspectos del hacking: pentesting, análisis de malware, OSINT, ingeniería inversa, hardening, etc.</p>
		<p>Además, produzco contenido educativo en forma de vídeos donde explico técnicas, herramientas y conceptos del mundo de la seguridad informática, contribuyendo así a la formación y concienciación de la comunidad.</p>
		<p>Estoy constantemente involucrado en nuevos retos y proyectos que me permitan seguir aprendiendo y compartiendo lo que sé.</p>


      <p><strong>Medios de contacto:</strong></p>
      <p>Correo electrónico: ciberseguridad12345@gmail.com</p>
      <p>Linkedin: <a href="https://www.linkedin.com/in/adriaangaarcialopez" target="_blank">Linkedin Mío</a></p>
    </div>
  </div>

  <footer class="container">
    <hr class="soften" />
    <p>
      &copy; Adrián <span id="thisyear">2025</span> | El blog de d1se0
    </p>
    <p class="text-center">
        <a href="https://www.linkedin.com/in/adriaangaarcialopez">LinkedIn</a>
        <a href="https://github.com/D1se0">GitHub</a>
        <a href="https://dise0.gitbook.io/h4cker_b00k">GitBook</a>
    </p>
  </footer>

  <script src="../js/jquery.js"></script>
  <script src="../js/bootstrap-386.js"></script>
  <script src="../js/bootstrap-transition.js"></script>
  <script src="../js/bootstrap-alert.js"></script>
  <script src="../js/bootstrap-modal.js"></script>
  <script src="../js/bootstrap-dropdown.js"></script>
  <script src="../js/bootstrap-scrollspy.js"></script>
  <script src="../js/bootstrap-tab.js"></script>
  <script src="../js/bootstrap-tooltip.js"></script>
  <script src="../js/bootstrap-popover.js"></script>
  <script src="../js/bootstrap-button.js"></script>
  <script src="../js/bootstrap-collapse.js"></script>
  <script src="../js/bootstrap-carousel.js"></script>
  <script src="../js/bootstrap-typeahead.js"></script>
  <script src="../js/bootstrap-affix.js"></script>
  <script>
    _386 = {
      fastLoad: false,
      onePass: false,
      speedFactor: 1
    };
    function ThisYear() {
      document.getElementById("thisyear").innerHTML = (new Date()).getFullYear();
    }
    ThisYear();
  </script>
</body>
</html>
