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
	    // Redirigir al servlet de logout en vez de al .jsp
	    response.sendRedirect(request.getContextPath() + "/logout");
	    return;
	}	

	RankingControlador rankingController = new RankingControlador();
    List<RankingEntry> ranking = rankingController.obtenerRankingUsuarios();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Ranking de Usuarios</title>
    <style>
        body {
            background: linear-gradient(to right, #1e1e2f, #2b2b3c);
            font-family: 'Segoe UI', sans-serif;
            color: #fff;
            margin: 0;
            padding: 0;
        }
        .ranking-container {
            max-width: 900px;
            margin: 50px auto;
            background: #3a3a4f;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
        }
        h1 {
            text-align: center;
            color: #ffd700;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #22223b;
            color: #ffd700;
        }
        tr:nth-child(even) {
            background-color: #2b2b3c;
        }
        tr:nth-child(odd) {
            background-color: #1e1e2f;
        }
    </style>
</head>
<body>
<div class="ranking-container">
    <h1>Ranking de Usuarios</h1>
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
           for (RankingEntry entry : ranking) { %>
            <tr>
                <td><%= posicion++ %></td>
                <td><%= entry.getUsername() %></td>
                <td><%= entry.getTotalPoints() %></td>
            </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
