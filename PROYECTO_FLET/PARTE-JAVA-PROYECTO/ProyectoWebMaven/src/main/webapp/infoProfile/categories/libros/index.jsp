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
    <title>El blog de d1se0</title>
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
            <a class="brand" href="<%= request.getContextPath() %>/infoProfile/index.jsp">El blog de d1se0</a>
            <div class="nav-collapse collapse">
                <ul class="nav">
                    <li><a href="<%= request.getContextPath() %>/infoProfile/cv/"><span>Curriculum Vitae</span></a></li>
                    <li><a href="<%= request.getContextPath() %>/infoProfile/about/index.jsp"><span>Sobre mí</span></a></li>
                </ul>
            </div>
        </div>
    </div>
</nav>

<div id="content" class="container">
    <article class="row-fluid navmargin">
        <header class="page-header">
            <h1>Libros</h1>
        </header>
    </article>
    <ul>
        <li>
            <a href="<%= request.getContextPath() %>/infoProfile/post/hackstory/index.jsp">
                2020-06-08 | Hackstory: La historia jamás contada del mundo underground hacker en España
            </a>
        </li>
    </ul>
</div>

<footer class="container">
    <hr class="soften">
    <p>&copy; Adrián <span id="thisyear"><%= java.time.Year.now() %></span> | El blog de d1se0</p>
    <p class="text-center">
        <a href="https://www.linkedin.com/in/adriaangaarcialopez">LinkedIn</a>
        <a href="https://github.com/D1se0">GitHub</a>
        <a href="https://dise0.gitbook.io/h4cker_b00k">GitBook</a>
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
