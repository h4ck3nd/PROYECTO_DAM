<%@ include file="dbConnection.jspf" %>
<%
    String tabla = request.getParameter("tabla");
    String valores = request.getParameter("valores");

    // Seguridad básica
    if (tabla.contains(";") || valores.contains(";")) {
        out.println("<p>Entrada no válida.</p>");
        return;
    }

    String sql = "INSERT INTO " + tabla + " VALUES (" + valores + ")";
    Statement stmt = conn.createStatement();
    int rows = stmt.executeUpdate(sql);

    out.println("<p>Insertados " + rows + " registros en " + tabla + ".</p>");
    conn.close();
%>
