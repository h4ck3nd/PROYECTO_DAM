<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="org.json.JSONObject" %>
<%
    // Obtener el token directamente desde la cookie
    String token = null;
    javax.servlet.http.Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (javax.servlet.http.Cookie cookie : cookies) {
            if (cookie.getName().equals("token")) {
                token = cookie.getValue();
                break;
            }
        }
    }

    if (token == null || token.isEmpty()) {
        response.sendRedirect("editarPerfil.jsp?mensaje=Error: Token no proporcionado");
        return;
    }

    // Obtener los parámetros enviados desde el formulario
    String nombre = request.getParameter("nombre");
    String apellidos = request.getParameter("apellidos");
    String email = request.getParameter("email");
    String usuario = request.getParameter("usuario");
    String currentPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");
    String confirmNewPassword = request.getParameter("confirmNewPassword");

    // Verificar contraseñas
    if (newPassword != null && !newPassword.isEmpty() && !newPassword.equals(confirmNewPassword)) {
        response.sendRedirect("editarPerfil.jsp?mensaje=Las contraseñas no coinciden");
        return;
    }

    try {
        // Llamada al servidor Flask para actualizar los datos
        URL url = new URL("http://localhost:5000/actualizar-datos");
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("POST");
        con.setRequestProperty("Content-Type", "application/json");
        con.setRequestProperty("Cookie", "token=" + token);  // Asegurarse de enviar el token correctamente en la cookie
        con.setDoOutput(true);

        // Crear el JSON con los datos del formulario
        String jsonInputString = "{"
            + "\"nombre\": \"" + nombre + "\","
            + "\"apellidos\": \"" + apellidos + "\","
            + "\"email\": \"" + email + "\","
            + "\"usuario\": \"" + usuario + "\","
            + "\"currentPassword\": \"" + currentPassword + "\","
            + "\"newPassword\": \"" + newPassword + "\""
            + "}";

        // Enviar los datos en el cuerpo de la solicitud
        try (OutputStream os = con.getOutputStream()) {
            byte[] input = jsonInputString.getBytes("utf-8");
            os.write(input, 0, input.length);
        }

        // Leer la respuesta del servidor
        BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
        StringBuilder responseText = new StringBuilder();
        String responseLine;
        while ((responseLine = br.readLine()) != null) {
            responseText.append(responseLine.trim());
        }

        // Parsear la respuesta JSON para obtener el nuevo token
        String nuevoToken = "";
        try {
            JSONObject jsonResponse = new JSONObject(responseText.toString());
            nuevoToken = jsonResponse.getString("token");
        } catch (Exception e) {
            response.sendRedirect("editarPerfil.jsp?mensaje=Error al leer token");
            return;
        }

        // Eliminar la cookie antigua (si existe)
        javax.servlet.http.Cookie cookieAntigua = new javax.servlet.http.Cookie("token", "");
        cookieAntigua.setMaxAge(0);  // Establecer la edad máxima a 0 para eliminar la cookie
        cookieAntigua.setPath("/");  // Asegurarse de que se elimine en todo el sitio
        response.addCookie(cookieAntigua);

        // Guardar el nuevo token en la cookie
        javax.servlet.http.Cookie nuevoCookie = new javax.servlet.http.Cookie("token", nuevoToken);
        nuevoCookie.setMaxAge(3600);  // Duración de 1 hora para la cookie
        nuevoCookie.setHttpOnly(true);  // Asegurarse de que la cookie no se pueda acceder por JavaScript
        nuevoCookie.setPath("/");  // Para que esté disponible en todo el dominio
        response.addCookie(nuevoCookie);

        // Redirigir al perfil o página de éxito con el nuevo token
        response.sendRedirect("profile.jsp");

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("editarPerfil.jsp?mensaje=Error: No se pudo actualizar el perfil.");
    }
%>
