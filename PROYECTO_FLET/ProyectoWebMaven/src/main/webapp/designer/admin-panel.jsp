<%@ page import="java.sql.*" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="io.jsonwebtoken.Claims" %>
<%@ page import="io.jsonwebtoken.Jwts" %>
<%@ page import="io.jsonwebtoken.ExpiredJwtException" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // === VALIDACIÓN DEL TOKEN ===
    String token = null;
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("token".equals(cookie.getName())) {
                token = cookie.getValue();
                break;
            }
        }
    }

    if (token == null || token.isEmpty()) {
        response.sendRedirect("logout.jsp");
        return;
    }

    String SECRET_KEY = "clave_super_secreta";

    String rol = "";
    String usuario = "";
    try {
        Claims claims = Jwts.parser()
            .setSigningKey(SECRET_KEY.getBytes(StandardCharsets.UTF_8))
            .parseClaimsJws(token)
            .getBody();

        rol = (String) claims.get("rol");
        usuario = (String) claims.get("usuario");

        // Validar si el rol es "designer"
        if (!"designer".equals(rol)) {
            out.println("<div style='color: red; text-align: center; font-family: monospace; margin-top: 50px;'>"
                + "<h3>No autorizado.</h3></div>");
            return;
        }

    } catch (ExpiredJwtException e) {
        response.sendRedirect("logout.jsp");
        return;
    } catch (Exception e) {
        out.println("<p>Error al validar el token.</p>");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Panel de Administración</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #111;
            color: #eee;
            padding: 40px;
        }
        h1 {
            color: #00ffcc;
        }
        .panel {
            border: 1px solid #00ffcc;
            padding: 20px;
            margin-bottom: 30px;
            background-color: #1a1a1a;
            border-radius: 10px;
        }
        input, button, select, textarea {
            padding: 10px;
            margin: 5px 0;
            border-radius: 6px;
            border: 1px solid #444;
            background-color: #222;
            color: #fff;
            width: 100%;
        }
        button {
            background-color: #00ffcc;
            color: #000;
            font-weight: bold;
            cursor: pointer;
        }
        .btn.insertar {
		  background-color: #42beba;
		  color: #fff;
		  display: flex;
		  justify-content: center;
		  align-items: center;
		  text-align: center;
		  border-radius: 6px;
		  font-weight: bold;
		  border: none;
		  cursor: pointer;
		  transition: background-color 0.3s ease;
		  width: fit-content; /* o puedes darle un ancho fijo si prefieres */
		}
		
		.btn.insertar:hover {
		  background-color: #276c6a;
		}
    </style>
</head>
<body>
    <h1>Panel de Administración - Usuario: <%= usuario %></h1>

    <!-- 📄 Ver registros (logs) -->
    <div class="panel">
        <h2>Revisar Logs del Sistema</h2>
        <form method="post" action="verLogs.jsp">
            <button type="submit">Ver Últimos Logs</button>
        </form>
    </div>

    <!-- 📥 Insertar registros -->
    <div class="panel">
        <h2>Insertar Laboratorios en la DDBB de "laboratorios"</h2>
        <a href="<%= request.getContextPath() %>/designer/agregarLaboratorio.jsp" class="btn insertar" style="text-decoration: none; color: white;">Insertar Informacion</a>
    </div>

    <!-- 🛠️ Modificar datos -->
    <div class="panel">
        <h2>Modificar Registros</h2>
        <form method="post" action="adminUpdate.jsp">
            <input type="text" name="tabla" placeholder="Nombre de la tabla" required>
            <input type="text" name="setQuery" placeholder="SET campo=valor" required>
            <input type="text" name="condicion" placeholder="WHERE condición" required>
            <button type="submit">Modificar</button>
        </form>
    </div>

    <!-- ❌ Eliminar registros -->
    <div class="panel">
        <h2>Eliminar Registros</h2>
        <form method="post" action="adminDelete.jsp">
            <input type="text" name="tabla" placeholder="Nombre de la tabla" required>
            <input type="text" name="condicion" placeholder="WHERE condición" required>
            <button type="submit">Eliminar</button>
        </form>
    </div>

</body>
</html>
