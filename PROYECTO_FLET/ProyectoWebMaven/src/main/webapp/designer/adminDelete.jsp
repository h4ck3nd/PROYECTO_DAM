<%@ include file="dbConnection.jspf" %>
<%
    String tabla = request.getParameter("tabla");
    String condicion = request.getParameter("condicion");

    if (tabla.contains(";") || condicion.contains(";")) {
        out.println("<p>Entrada no válida.</p>");
        return;
    }

    String sql = "DELETE FROM " + tabla + " WHERE " + condicion;
    Statement stmt = conn.createStatement();
    int rows = stmt.executeUpdate(sql);

    out.println("<p>Eliminados " + rows + " registros de " + tabla + ".</p>");
    conn.close();
%>
