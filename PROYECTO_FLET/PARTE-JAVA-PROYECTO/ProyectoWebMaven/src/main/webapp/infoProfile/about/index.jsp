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

      <p class="lead">Sobre mí, quién soy, de dónde vengo y hacia dónde voy</p>
      <p>Nací en el año del mundial de Estados Unidos, el de 1994, y a los dos o tres años me regalaron el balón del mundial de fútbol, el cual, acabé perdiendo o calándolo, no sé exactamente cuál de las dos.</p>
      <p>Me gustaba la informática desde bien pequeñito, tendría unos cinco años cuando toqué mi primer ordenador, el viejo 386 de mi padre.</p>
      <p>Hablando de videojuegos, tengo en posesión una NES, y me dejaron una Nintendo 64.</p>
      <p>Vi el nacimiento de varias consolas actuales, como la Playstation (incluyendo la 3), la primera Xbox, la Nintendo Gamecube, la Wii…</p>
      <p>Tengo guardado en el trastero la primera Playstation, y un Spectrum ZX+2 de mi padre que también le he dado uso.</p>
      <p>Siempre he sido muy alegre, inquieto, curioso, algo soñador… De ahí que me llamen mucho la atención ciertas cosas, como por ejemplo saber cómo funcionaba un ordenador, cuáles eran sus componentes, etc.</p>
      <p>Tengo un Grado Medio en SMR y el Grado Superior en Desarrollo de Aplicaciones Web.</p>
      <p>Lo del hacking y demás cosas (programación, etc.) lo aprendí de forma autodidacta.</p>
      <p>Formé parte de la comunidad sobre seguridad informática, Whihax Security, haciendo la labor de administrador de sistemas.</p>
      <p>Dirigí el canal de Telegram sobre seguridad informática, Security News for Everyone, junto con otros miembros de Whihax Security.</p>
      <p>Tras la disolución de Whihax Security, empecé un nuevo proyecto, Chaos as a Service, en el cual, he puesto de nuevo todos mis esfuerzos en él.</p>
      <p>Me encanta leer, sobre todo libros técnicos o novelas de misterio. Sobre las series, he visto demasiadas, pero mi favorita es Mr. Robot.</p>
      <p>También me gusta el anime y el manga, además de ser un gran aficionado al mundo del motor.</p>

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
      <a href="https://twitter.com/TFujiwara86">Twitter</a>
      <a href="https://www.linkedin.com/in/cgarciaquevedo/">LinkedIn</a>
      <a href="https://github.com/TFujiwara">GitHub</a>
      <a href="https://gitlab.com/TFujiwara">GitLab</a>
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
