<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Writeup" %>

<%
    List<Writeup> writeups = (List<Writeup>) request.getAttribute("writeups");
    String nombreLaboratorio = writeups != null && !writeups.isEmpty() ? writeups.get(0).getNombreLaboratorio() : "Desconocido";
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Writeups de <%= nombreLaboratorio %></title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f4f4;
            padding: 2rem;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        table {
            width: 90%;
            max-width: 900px;
            margin: 2rem auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid #e0e0e0;
        }

        th {
            background-color: #3a8bcd;
            color: #fff;
        }

        tr:hover {
            background-color: #f0f8ff;
        }

        a {
            color: #3a8bcd;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 30px;
        }
    </style>
</head>
<body>

<h2>Writeups del laboratorio: <%= nombreLaboratorio %></h2>

<% if (writeups == null || writeups.isEmpty()) { %>
    <p style="text-align:center;">No hay writeups para este laboratorio aún.</p>
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

<div class="back-link">
    <a href="javascript:history.back()">← Volver al laboratorio</a>
</div>

</body>
</html>
