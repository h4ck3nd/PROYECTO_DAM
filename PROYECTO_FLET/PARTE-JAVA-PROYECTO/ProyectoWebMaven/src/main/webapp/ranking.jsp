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
	<link rel="icon" type="image/png" href="<%= request.getContextPath() %>/img/icono/icono_cinco_hackend.ico">
    <title>RANKING DE USUARIOS</title>
    <link href="https://fonts.googleapis.com/css2?family=VT323&display=swap" rel="stylesheet">
    <style>
    * {
			font-family: 'VT323', monospace;
			font-size: 22px !important;
		}
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
            font-size: 40px !important;
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

        .gold {
            background-color: #FFD70033;
            font-weight: bold;
            color: #FFD700;
        }

        .silver {
            background-color: #C0C0C033;
            font-weight: bold;
            color: #C0C0C0;
        }

        .bronze {
            background-color: #CD7F3233;
            font-weight: bold;
            color: #CD7F32;
        }

        .btn-volver {
            display: inline-block;
            margin-top: 30px;
            padding: 10px 20px;
            background-color: #ffd700;
            color: #000;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background 0.3s ease;
        }

        .btn-volver:hover {
            background-color: #e6c200;
        }

        .volver-container {
            text-align: center;
        }
    </style>
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
        <a class="btn-volver" href="<%= request.getContextPath() %>/home_directory/home.jsp?page=0">Volver al Inicio</a>
    </div>
</div>
</body>
</html>
