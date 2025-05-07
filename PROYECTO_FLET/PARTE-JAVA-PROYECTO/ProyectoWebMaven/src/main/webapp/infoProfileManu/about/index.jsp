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
  <link rel="canonical" href="<%= request.getContextPath() %>/infoProfileManu/index.jsp" />
  <title>El blog de M4nu</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/infoProfile/css/bootstrap.css" />
  <link rel="stylesheet" href="<%= request.getContextPath() %>/infoProfile/css/bootstrap-responsive.css" />
  <link rel="stylesheet" href="<%= request.getContextPath() %>/infoProfile/css/style.css" />
</head>

<body>
  <nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
      <div class="container">
        <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"></button>
        <a class="brand" href="<%= request.getContextPath() %>/infoProfileManu/index.jsp">El blog de M4nu</a>
        <div class="nav-collapse collapse">
          <ul class="nav">
            <li><a href="<%= request.getContextPath() %>/infoProfileManu/cv/index.jsp"><span>Curriculum Vitae</span></a></li>
            <li><a href="<%= request.getContextPath() %>/infoProfileManu/about/index.jsp"><span>Sobre mí</span></a></li>
          </ul>
        </div>
      </div>
    </div>
  </nav>

  <div id="content" class="container">
    <div class="row-fluid navmargin">
      <div class="page-header">
        <h1>Sobre mí - Miércoles, Mayo 7, 2025</h1>
      </div>

      <p class="lead">Sobre mí, quién soy, de dónde vengo y hacia dónde voy</p>
<p>Nací en el año 2004, un año emocionante para los fanáticos del automovilismo, marcado por el dominio de Michael Schumacher y Ferrari en la Fórmula 1. Desde muy pequeño sentí curiosidad por la tecnología; con apenas dos años ya cogía los teléfonos de mis familiares para jugar a Bounce Tales, uno de mis juegos favoritos de la infancia.</p>
<p>Mi primera consola fue una Nintendo DS a los siete años. Con el tiempo llegaron nuevas etapas: una PSP, luego una PlayStation 3 —que se rompió tras una mudanza— y finalmente una PlayStation 4, que aún conservo junto a las otras, salvo la PS3. Aunque hoy en día juego menos, el boom de Fortnite marcó una etapa muy divertida con mis amigos.</p>
<p>Mi primer contacto con un ordenador fue en 2010, usando el equipo de mi padre con Windows Vista para jugar al Buscaminas y al Paintball. En sexto de primaria recibí mi primer portátil para hacer trabajos escolares, y en 2020 obtuve mi primer ordenador de sobremesa gaming, con el que empecé a experimentar más en el mundo digital.</p>
<p>Siempre me he considerado una persona curiosa, con ganas de aprender. Actualmente me interesan especialmente los avances en inteligencia artificial y las nuevas herramientas de desarrollo web. Me apasiona investigar sobre la creación de chatbots, GPTs y la automatización de procesos con plataformas como MAKE.</p>
<p>En cuanto a formación, tengo el Grado Medio en Sistemas Microinformáticos y Redes (SMR), y actualmente curso el primer año del Grado Superior en Desarrollo de Aplicaciones Web.</p>
<p>También disfruto leyendo libros técnicos y de desarrollo personal. Uno que me ha marcado es "Rompe la barrera del NO", el cual me ayudó a entender mejor la comunicación y la negociación. En cuanto a series, Mr. Robot me dejó una gran impresión; la vi en 2021 cuando estaba en mi primer año del Grado Medio, y me inspiró aún más a seguir aprendiendo sobre informática.</p>
<p>En mi vida personal, siempre me han gustado los perros. De pequeño tuvimos un dóberman, y desde entonces mi raza favorita es el labrador. Además, soy un gran aficionado al mundo del motor, especialmente a marcas como Mercedes y Porsche.</p>


      <p><strong>Medios de contacto:</strong></p>
      <p>Correo electrónico: yta-manu@gmail.com</p>
    </div>
  </div>

  <footer class="container">
    <hr class="soften" />
    <p>
      &copy; M4nu <span id="thisyear">2025</span> | El blog de M4nu
    </p>
    <p class="text-center">
        <a href="https://github.com/ManuDev664">GitHub</a>
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
