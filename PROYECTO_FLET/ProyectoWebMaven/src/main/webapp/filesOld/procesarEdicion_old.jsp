<%@ page import="java.sql.*"%>
<%
    // Depuración: Verificar los parámetros recibidos
    String queryString = request.getQueryString();
    System.out.println("📩 Parámetros recibidos: " + queryString);

    // Obtener parámetros desde la URL
    String cookie = request.getParameter("cookie");
    String usuario = request.getParameter("usuario");
    String nombre = request.getParameter("nombre");
    String apellidos = request.getParameter("apellidos");
    String email = request.getParameter("email");

    // Verificar que todos los valores están presentes
    if (cookie == null || cookie.trim().isEmpty() || 
        usuario == null || usuario.trim().isEmpty() ||
        nombre == null || nombre.trim().isEmpty() || 
        apellidos == null || apellidos.trim().isEmpty() || 
        email == null || email.trim().isEmpty()) {
        
        response.sendRedirect("index.jsp?mensaje=Error: Todos los campos son obligatorios");
        return;
    }

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Conectar a la base de datos PostgreSQL
        Class.forName("org.postgresql.Driver");
        conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/appusers", "postgres", "1234");

        // Depuración: Mostrar la cookie recibida
        System.out.println("✅ Cookie recibida: " + cookie);

        // Actualizar los datos del usuario usando la cookie
        String sql = "UPDATE usuarios SET nombre = ?, apellidos = ?, email = ?, usuario = ? WHERE cookie = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, nombre);
        stmt.setString(2, apellidos);
        stmt.setString(3, email);
        stmt.setString(4, usuario);
        stmt.setString(5, cookie);

        int filasAfectadas = stmt.executeUpdate();

        if (filasAfectadas > 0) {
            System.out.println("✅ Edición exitosa: " + filasAfectadas + " fila(s) actualizada(s).");
            response.sendRedirect("index.jsp?usuario=" + usuario + "&cookie=" + cookie);
        } else {
            System.out.println("⚠️ Error: No se encontró el usuario con esa cookie.");
            response.sendRedirect("index.jsp?mensaje=Error: No se encontró el usuario con esa cookie");
        }
    } catch (Exception e) {
        System.out.println("❌ Error de base de datos: " + e.getMessage());
        response.sendRedirect("index.jsp?mensaje=Error de base de datos: " + e.getMessage());
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
