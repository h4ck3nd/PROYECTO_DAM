<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Writeup" %>
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

    List<Writeup> writeups = (List<Writeup>) request.getAttribute("writeups");
    String nombreLaboratorio = writeups != null && !writeups.isEmpty() ? writeups.get(0).getNombreLaboratorio() : "Desconocido";
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/vistas/img/icono/icono_cinco_hackend.ico">
    <title>WRITEUPS DE <%= nombreLaboratorio %></title>
    <link href="https://fonts.googleapis.com/css2?family=VT323&display=swap" rel="stylesheet">
    <style>
    * {
			font-family: 'VT323', monospace;
			font-size: 22px;
		}
        body {
            font-family: 'Courier New', Courier, monospace;
            background: #2d2d2d;
            color: #f0f0f0;
            padding: 20px;
            margin: 0;
        }

        h1 {
            text-align: center;
            color: #f0f0f0;
            font-size: 2em;
            margin-bottom: 30px;
        }

        table {
            width: 90%;
            max-width: 900px;
            margin: 0 auto 30px auto;
            border-collapse: collapse;
            background-color: #333;
            border: 1px solid #444;
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid #555;
        }

        th {
            background-color: #444;
            color: #87ff87;
        }

        tr:nth-child(even) {
            background-color: #2f2f2f;
        }

        tr:hover {
            background-color: #3c3c3c;
        }

        a {
            color: #87ceeb;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .mensaje {
            text-align: center;
            font-size: 1.1em;
            margin-bottom: 20px;
            color: #87ff87;
        }

        .btn-volver {
            display: block;
            background-color: #4f4f4f;
            color: #f0f0f0;
            text-decoration: none;
            text-align: center;
            padding: 10px 20px;
            border: 1px solid #444;
            border-radius: 5px;
            width: fit-content;
            margin: 0 auto;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .btn-volver:hover {
            background-color: #777;
            transform: translateY(-2px);
        }

        .btn-volver:active {
            background-color: #333;
            transform: translateY(0);
        }
    </style>
</head>
<body>

<h1>Writeups del laboratorio: <%= nombreLaboratorio %></h1>

<% if (writeups == null || writeups.isEmpty()) { %>
    <p class="mensaje">No hay writeups para este laboratorio aún.</p>
<% } else { %>
    <table>
        <tr>
            <th>Autor</th>
            <th>Enlace al Writeup</th>
        </tr>
        <% for (Writeup w : writeups) { %>
            <tr>
                <td><%= w.getUsername() %></td>
                <td><a href="<%= w.getUrl() %>" target="_blank">Ver Writeup</a></td>
            </tr>
        <% } %>
    </table>
<% } %>

<a class="btn-volver" href="javascript:history.back()">← Volver al laboratorio</a>

</body>
</html>
