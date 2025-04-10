<%@ include file="dbConnection.jspf" %>
<%
    String tabla = request.getParameter("tabla");
    String setQuery = request.getParameter("setQuery");
    String condicion = request.getParameter("condicion");

    if (tabla.contains(";") || setQuery.contains(";") || condicion.contains(";")) {
        out.println("<p>Entrada no válida.</p>");
        return;
    }

    String sql = "UPDATE " + tabla + " SET " + setQuery + " WHERE " + condicion;
    Statement stmt = conn.createStatement();
    int rows = stmt.executeUpdate(sql);

    out.println("<p>Modificados " + rows + " registros en " + tabla + ".</p>");
    conn.close();
%>
