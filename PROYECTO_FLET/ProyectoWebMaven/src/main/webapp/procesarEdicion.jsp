<%@ page import="java.net.*, java.io.*, org.json.JSONObject" %>
<%
    String token = request.getParameter("token");
    String nombre = request.getParameter("nombre");
    String apellidos = request.getParameter("apellidos");
    String email = request.getParameter("email");
    String usuario = request.getParameter("usuario");
    String currentPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");
    String confirmNewPassword = request.getParameter("confirmNewPassword");

    // Verificación de campos
    if (token == null || nombre == null || apellidos == null || email == null || usuario == null ||
        token.isEmpty() || nombre.isEmpty() || apellidos.isEmpty() || email.isEmpty() || usuario.isEmpty()) {
        response.sendRedirect("index.jsp?mensaje=Error: Todos los campos son obligatorios");
        return;
    }

    if (newPassword != null && !newPassword.isEmpty() && !newPassword.equals(confirmNewPassword)) {
        response.sendRedirect("editarPerfil.jsp?token=" + token + "&mensaje=Las contraseñas no coinciden");
        return;
    }

    try {
        // Llamada al servidor Flask para actualizar los datos
        URL url = new URL("http://localhost:5000/actualizar-datos");
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("POST");
        con.setRequestProperty("Content-Type", "application/json");
        con.setDoOutput(true);

        // Crear el JSON con los datos del formulario
        String jsonInputString = "{"
            + "\"token\": \"" + token + "\","
            + "\"nombre\": \"" + nombre + "\","
            + "\"apellidos\": \"" + apellidos + "\","
            + "\"email\": \"" + email + "\","
            + "\"usuario\": \"" + usuario + "\","
            + "\"currentPassword\": \"" + currentPassword + "\","
            + "\"newPassword\": \"" + newPassword + "\""
            + "}";

        try (OutputStream os = con.getOutputStream()) {
            byte[] input = jsonInputString.getBytes("utf-8");
            os.write(input, 0, input.length);
        }

        // Después de enviar la petición
        BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
        StringBuilder responseText = new StringBuilder();
        String responseLine;
        while ((responseLine = br.readLine()) != null) {
            responseText.append(responseLine.trim());
        }

        // Parsear el JSON de la respuesta
        String nuevoToken = "";
        try {
            JSONObject jsonResponse = new JSONObject(responseText.toString());
            nuevoToken = jsonResponse.getString("token");
        } catch (Exception e) {
            response.sendRedirect("profile.jsp?mensaje=Error al leer token");
            return;
        }

        // Redirigir al perfil con el nuevo token
        response.sendRedirect("profile.jsp?token=" + URLEncoder.encode(nuevoToken, "UTF-8"));
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("index.jsp?mensaje=Error: No se pudo actualizar el perfil.");
    }
%>
