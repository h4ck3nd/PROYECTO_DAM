<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="modelo.RankingEntry" %>
<%@ page import="controlador.RankingControlador" %>
<%@ page import="utils.JWTUtils" %>
<%@ page import="utils.UsuarioJWT" %>

<%
    UsuarioJWT usuarioJWT = null;

    try {
        usuarioJWT = JWTUtils.obtenerUsuarioDesdeRequest(request);
    } catch (Exception e) {
        response.sendRedirect(request.getContextPath() + "/logout");
        return;
    }

    RankingControlador rankingController = new RankingControlador();
    List<RankingEntry> ranking = rankingController.obtenerRankingUsuarios();
%>

<!DOCTYPE html>
<html>
<head>
	<link rel="icon" type="image/png" href="<%= request.getContextPath() %>/vistas/img/icono/icono_cinco_hackend.ico">
    <title>RANKING DE USUARIOS</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/vistas/css/cssRanking.jsp">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/vistas/css/dynamicFonts.jsp" />
</head>
<body>
<div class="ranking-container">
    <h1>🏆 Ranking de Usuarios</h1>
    <table>
        <thead>
            <tr>
                <th>Posición</th>
                <th>Usuario</th>
                <th>Puntos Totales</th>
            </tr>
        </thead>
        <tbody>
        <% int posicion = 1;
           for (RankingEntry entry : ranking) {
               String claseFila = "";
               String emote = "";

               switch (posicion) {
                   case 1:
                       claseFila = "gold";
                       emote = "🥇 ";
                       break;
                   case 2:
                       claseFila = "silver";
                       emote = "🥈 ";
                       break;
                   case 3:
                       claseFila = "bronze";
                       emote = "🥉 ";
                       break;
                   default:
                       claseFila = "";
               }
        %>
            <tr class="<%= claseFila %>">
                <td><%= emote + posicion %></td>
                <td><%= entry.getUsername() %></td>
                <td><%= entry.getTotalPoints() %></td>
            </tr>
        <% posicion++; } %>
        </tbody>
    </table>

    <div class="volver-container">
        <a class="btn-volver" href="<%= request.getContextPath() %>/vistas/home_directory/home.jsp">Volver al Inicio</a>
    </div>
</div>
</body>
</html>
