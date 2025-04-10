<%@ include file="dbConnection.jspf" %>
<%
    // Obtener los últimos 100 logs
    String sql = "SELECT * FROM logs ORDER BY fecha DESC LIMIT 100";
    PreparedStatement stmt = conn.prepareStatement(sql);
    ResultSet rs = stmt.executeQuery();

    // Crear la tabla de logs en formato HTML
    StringBuilder table = new StringBuilder();
    table.append("<tr>");
    table.append("<th>ID</th>");
    table.append("<th>Usuario</th>");
    table.append("<th>Acción</th>");
    table.append("<th>Fecha</th>");
    table.append("</tr>");
    
    while (rs.next()) {
        table.append("<tr>");
        table.append("<td>").append(rs.getInt("id")).append("</td>");
        table.append("<td>").append(rs.getString("usuario")).append("</td>");
        table.append("<td>").append(rs.getString("accion")).append("</td>");
        table.append("<td>").append(rs.getTimestamp("fecha")).append("</td>");
        table.append("</tr>");
    }
    out.print(table.toString()); // Devuelve la tabla generada al frontend
    conn.close();
%>
