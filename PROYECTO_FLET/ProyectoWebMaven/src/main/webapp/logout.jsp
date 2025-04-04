<%@ page import="java.sql.*" %>
<%
    String userCookie = (String) session.getAttribute("user_cookie"); // Obtener la cookie de sesión

    if (userCookie != null) {
        // Solo invalidar la sesión, no tocar la cookie en la BD
        session.invalidate(); // Cierra la sesión actual

        // Eliminar la cookie del navegador (para que no siga logueado automáticamente)
        Cookie authCookie = new Cookie("user_cookie", "");
        authCookie.setMaxAge(0); // Expira la cookie en el navegador
        response.addCookie(authCookie);
    }

    // Redirigir al login de Flet
    response.sendRedirect("http://localhost:4308");
%>
