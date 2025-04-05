<%@ page import="java.sql.*" %>
<%
    String cookie = request.getParameter("cookie");

    if (cookie == null || cookie.isEmpty()) {
        out.println("<p>Error: No se recibió la cookie</p>");
        return;
    }

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("org.postgresql.Driver");
        conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/appusers", "postgres", "1234");

        String sql = "SELECT nombre, apellidos, email, usuario FROM usuarios WHERE cookie = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, cookie);
        rs = stmt.executeQuery();

        if (rs.next()) {
%>
            <h2>Editar Perfil</h2>
            <form action="procesarEdicion.jsp" method="post">
                <input type="hidden" name="cookie" value="<%= cookie %>">
                Nombre: <input type="text" name="nombre" value="<%= rs.getString("nombre") %>"><br>
                Apellidos: <input type="text" name="apellidos" value="<%= rs.getString("apellidos") %>"><br>
                Email: <input type="email" name="email" value="<%= rs.getString("email") %>"><br>
                Usuario: <input type="text" name="usuario" value="<%= rs.getString("usuario") %>"><br>
                <input type="submit" value="Guardar Cambios">
            </form>
<%
        } else {
            out.println("<p>Error: No se encontró usuario con esa cookie</p>");
        }
    } catch (Exception e) {
        out.println("<p>Error de base de datos: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
