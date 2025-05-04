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
  <link rel="icon" href="favicon.html" />
  <link rel="canonical" href="index.jsp" />
  <title>El blog de d1se0</title>

  <link rel="stylesheet" href="css/bootstrap.css" />
  <link rel="stylesheet" href="css/bootstrap-responsive.css" />
  <link rel="stylesheet" href="css/style.css" />
</head>

<body>
  <nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
      <div class="container">
        <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"></button>
        <a class="brand" href="index.jsp">El blog de d1se0</a>
        <div class="nav-collapse collapse">
          <ul class="nav">
            <li><a href="cv/index.jsp"><span>Curriculum Vitae</span></a></li>
            <li><a href="about/index.jsp"><span>Sobre mí</span></a></li>
          </ul>
        </div>
      </div>
    </div>
  </nav>

  <div id="content" class="container">
    <div class="row-fluid navmargin">
      <div class="page-header">
        <h1>El blog de d1se0</h1>
      </div>
    </div>

    <div class="row-fluid">
      <div class="span9 bs-docs-sidebar">
        <p class="lead">
          Blog personal donde cuento algunas de las investigaciones que he hecho, además de algún que otro tutorial o recomendaciones varias.
        </p>
        <hr class="soften" />
        <ul>
          <li><a href="https://dise0.gitbook.io/h4cker_b00k">Sitio Web GitBook</a></li>
          <li><a href="https://github.com/D1se0">GitHub Principal</a></li>
          <li><a href="https://github.com/h4ck3nd">GitHub Secundario</a></li>
        </ul>
      </div>

      <div class="span3 bs-docs-sidebar">
        <ul class="nav nav-list bs-docs-sidenav">
          <li><a href="categories/libros/index.jsp">Libros</a></li>
        </ul>
      </div>
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

  <script src="js/jquery.js"></script>
  <script src="js/bootstrap-386.js"></script>
  <script src="js/bootstrap-transition.js"></script>
  <script src="js/bootstrap-alert.js"></script>
  <script src="js/bootstrap-modal.js"></script>
  <script src="js/bootstrap-dropdown.js"></script>
  <script src="js/bootstrap-scrollspy.js"></script>
  <script src="js/bootstrap-tab.js"></script>
  <script src="js/bootstrap-tooltip.js"></script>
  <script src="js/bootstrap-popover.js"></script>
  <script src="js/bootstrap-button.js"></script>
  <script src="js/bootstrap-collapse.js"></script>
  <script src="js/bootstrap-carousel.js"></script>
  <script src="js/bootstrap-typeahead.js"></script>
  <script src="js/bootstrap-affix.js"></script>
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
