<%@ page import="java.net.*, java.io.*" %>
<%
    String token = request.getParameter("token");
    String nombre = request.getParameter("nombre");
    String apellidos = request.getParameter("apellidos");
    String email = request.getParameter("email");
    String usuario = request.getParameter("usuario");

    if (token == null || nombre == null || apellidos == null || email == null || usuario == null ||
        token.isEmpty() || nombre.isEmpty() || apellidos.isEmpty() || email.isEmpty() || usuario.isEmpty()) {
        
        response.sendRedirect("index.jsp?mensaje=Error: Todos los campos son obligatorios");
        return;
    }

    try {
        URL url = new URL("http://localhost:5000/actualizar-datos");
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("POST");
        con.setRequestProperty("Content-Type", "application/json");
        con.setDoOutput(true);

        String jsonInputString = "{"
            + "\"token\": \"" + token + "\","
            + "\"nombre\": \"" + nombre + "\","
            + "\"apellidos\": \"" + apellidos + "\","
            + "\"email\": \"" + email + "\","
            + "\"usuario\": \"" + usuario + "\""
            + "}";

        try (OutputStream os = con.getOutputStream()) {
            byte[] input = jsonInputString.getBytes("utf-8");
            os.write(input, 0, input.length);
        }

     // Después de enviar la petición a Flask
        BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
        StringBuilder responseText = new StringBuilder();
        String responseLine;
        while ((responseLine = br.readLine()) != null) {
            responseText.append(responseLine.trim());
        }

        // Parsear el JSON para obtener el nuevo token
        String nuevoToken = "";
        try {
            org.json.JSONObject jsonResponse = new org.json.JSONObject(responseText.toString());
            nuevoToken = jsonResponse.getString("token");
        } catch (Exception e) {
            response.sendRedirect("profile.jsp?mensaje=Error al leer token");
            return;
        }

        // Redirigir al index con el nuevo token
        response.sendRedirect("profile.jsp?token=" + URLEncoder.encode(nuevoToken, "UTF-8"));

    } catch (Exception e) {
        response.sendRedirect("profile.jsp?mensaje=Error: " + e.getMessage());
    }
%>