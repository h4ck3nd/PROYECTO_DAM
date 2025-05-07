<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>El blog de M4nu</title>
    <meta charset="utf-8">
    <meta http-equiv="encoding" content="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <meta name="format-detection" content="telephone=no">
    <meta name="theme-color" content="#000084">
    <link rel="icon" href="<%= request.getContextPath() %>/infoProfile/favicon.html">
    <link rel="canonical" href="<%= request.getContextPath() %>/infoProfile/index.jsp">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/infoProfile/css/bootstrap.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/infoProfile/css/bootstrap-responsive.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/infoProfile/css/style.css">
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container">
            <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"></button>
            <a class="brand" href="<%= request.getContextPath() %>/infoProfile2/index.jsp">El blog de M4nu</a>
            <div class="nav-collapse collapse">
                <ul class="nav">
                    <li><a href="<%= request.getContextPath() %>/infoProfile2/cv/"><span>Curriculum Vitae</span></a></li>
                    <li><a href="<%= request.getContextPath() %>/infoProfile2/about/index.jsp"><span>Sobre mí</span></a></li>
                </ul>
            </div>
        </div>
    </div>
</nav>

<div id="content" class="container">
    <div class="row-fluid navmargin">
        <div class="page-header">
            <h1>Hackstory: La historia jamás contada del mundo underground hacker en España - Lun, 8 Jun, 2020</h1>
        </div>
        <p class="lead">Un libro que nos cuenta la historia del mundo underground hacker, sus grupos, cómo surgió todo...</p>
        <p><img src="<%= request.getContextPath() %>/infoProfile/img/cover_hackstory.jpg" alt="Portada Hackstory"></p>
        <p>Conozcamos a Mercè Molist, a.k.a morgana, M&amp;M o merce.</p>
        <p>Una chica de pueblo que en 1995 entró en el oscuro mundo de Internet.</p>
        <p>Es, como explica el wiki que le fue origen, Hackstory.net, “lo que sabemos sobre la historia de los hackers”.</p>
        <p>En definitiva, un libro que os recomiendo si queréis escapar de las tardes de aburrimiento.</p>
        <p><a href="https://hackstory.es/ebook/epub">Descarga el libro en EPUB</a></p>
        <p><a href="https://hackstory.es/ebook/pdf">Descarga el libro en PDF</a></p>
        <p><a href="https://hackstory.es/ebook/mobi">Descarga el libro en MOBI</a></p>
        <p><a href="http://www.amazon.es/Hackstory-es-historia-contada-underground-Península-ebook/dp/B00N1T40OO">Descarga el libro en formato Kindle</a></p>
    </div>
</div>

<footer class="container">
    <hr class="soften">
    <p>&copy; M4nu <span id="thisyear"><%= java.time.Year.now() %></span> | El blog de M4nu</p>
    <p class="text-center">
        <a href="https://github.com/ManuDev664">GitHub</a>
    </p>
</footer>

<script src="<%= request.getContextPath() %>/infoProfile/js/jquery.js"></script>
<script src="<%= request.getContextPath() %>/infoProfile/js/bootstrap-386.js"></script>
<script src="<%= request.getContextPath() %>/infoProfile/js/bootstrap-transition.js"></script>
<script src="<%= request.getContextPath() %>/infoProfile/js/bootstrap-alert.js"></script>
<script src="<%= request.getContextPath() %>/infoProfile/js/bootstrap-modal.js"></script>
<script src="<%= request.getContextPath() %>/infoProfile/js/bootstrap-dropdown.js"></script>
<script src="<%= request.getContextPath() %>/infoProfile/js/bootstrap-scrollspy.js"></script>
<script src="<%= request.getContextPath() %>/infoProfile/js/bootstrap-tab.js"></script>
<script src="<%= request.getContextPath() %>/infoProfile/js/bootstrap-tooltip.js"></script>
<script src="<%= request.getContextPath() %>/infoProfile/js/bootstrap-popover.js"></script>
<script src="<%= request.getContextPath() %>/infoProfile/js/bootstrap-button.js"></script>
<script src="<%= request.getContextPath() %>/infoProfile/js/bootstrap-collapse.js"></script>
<script src="<%= request.getContextPath() %>/infoProfile/js/bootstrap-carousel.js"></script>
<script src="<%= request.getContextPath() %>/infoProfile/js/bootstrap-typeahead.js"></script>
<script src="<%= request.getContextPath() %>/infoProfile/js/bootstrap-affix.js"></script>
</body>
</html>