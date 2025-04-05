<%@ page import="java.sql.*" %>
<%@ page import="java.net.URI" %>
<%@ page import="java.net.http.HttpClient" %>
<%@ page import="java.net.http.HttpRequest" %>
<%@ page import="java.net.http.HttpResponse" %>
<%
    // Obtener el par�metro token desde la URL
    String token = request.getParameter("token");

    if (token != null && !token.isEmpty()) {
        // Invalidar la sesi�n
        session.invalidate(); // Cierra la sesi�n actual

        // Eliminar la cookie del navegador (para que no siga logueado autom�ticamente)
        Cookie authCookie = new Cookie("user_cookie", "");
        authCookie.setMaxAge(0); // Expira la cookie en el navegador
        authCookie.setPath("/"); // Aseg�rate de que la cookie se elimine en todas las rutas
        response.addCookie(authCookie);  // Elimina la cookie en el navegador

        // Realizar una petici�n HTTP al endpoint Flask para eliminar la cookie de la base de datos
        String logoutUrl = "http://localhost:5000/logout"; // URL del endpoint Flask

        try {
            // Crear un cliente HTTP
            HttpClient client = HttpClient.newHttpClient();
            
            // Crear la solicitud HTTP (GET) con el token como par�metro
            HttpRequest logoutRequest = HttpRequest.newBuilder()
                .uri(URI.create(logoutUrl + "?token=" + token))  // Incluye el token en la URL
                .GET()  // M�todo GET
                .build();

            // Enviar la solicitud y obtener la respuesta
            HttpResponse<String> responseFlask = client.send(logoutRequest, HttpResponse.BodyHandlers.ofString());
            
            // Si la respuesta es exitosa, redirigir al login
            if (responseFlask.statusCode() == 200) {
                // Redirigir al login de Flet
                response.sendRedirect("http://localhost:30050"); // Redirige al login de Flet
            } else {
                // Si la solicitud al backend Flask falla, redirigir igualmente al login
                response.sendRedirect("http://localhost:30050");
            }
        } catch (Exception e) {
            // Si ocurre un error durante la solicitud HTTP, podemos imprimirlo para diagn�stico
            System.out.println("Error al llamar al endpoint Flask: " + e.getMessage());
            response.sendRedirect("http://localhost:30050");  // Redirige al login de Flet por si hay error
        }
    } else {
        // Si no hay token en la URL, redirigir al login de Flet
        response.sendRedirect("http://localhost:30050");
    }
%>
