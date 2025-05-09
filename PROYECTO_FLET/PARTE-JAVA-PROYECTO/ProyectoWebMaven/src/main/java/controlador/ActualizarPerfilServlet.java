package controlador;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureException;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;

// Definición del servlet y la ruta donde se escucha
@WebServlet("/actualizarPerfil")
public class ActualizarPerfilServlet extends HttpServlet {

    // Clave secreta utilizada para verificar el JWT
    private static final String SECRET_KEY = "clave_super_secreta";

    // Método que maneja peticiones POST (actualización de perfil)
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("token".equals(cookie.getName())) {
                    token = cookie.getValue();
                    break;
                }
            }
        }

        // Obtener token JWT desde las cookies
        if (token == null || token.isEmpty()) {
            response.sendRedirect("editarPerfil.jsp?mensaje=Error: Token no proporcionado");
            return;
        }

        // Intentar extraer el ID del usuario del JWT
        String userId = null;
        try {
            Claims claims = Jwts.parser()
                    .setSigningKey(SECRET_KEY.getBytes())
                    .parseClaimsJws(token)
                    .getBody();
            userId = claims.getSubject();
        } catch (SignatureException e) {
            response.sendRedirect("editarPerfil.jsp?mensaje=Error: Token no válido");
            return;
        } catch (Exception e) {
            response.sendRedirect("editarPerfil.jsp?mensaje=Error: No se pudo verificar el token");
            return;
        }

        // Obtener los parámetros del formulario enviados por el usuario
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String email = request.getParameter("email");
        String usuario = request.getParameter("usuario");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmNewPassword = request.getParameter("confirmNewPassword");

        // Validar que las nuevas contraseñas coincidan si se proporcionan
        if (newPassword != null && !newPassword.isEmpty() && !newPassword.equals(confirmNewPassword)) {
            response.sendRedirect("editarPerfil.jsp?mensaje=Las contraseñas no coinciden");
            return;
        }

        // Intentar enviar los datos al backend (Flask en localhost:5000)
        try {
            URL url = new URL("http://localhost:5000/actualizar-datos");
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/json");
            con.setRequestProperty("Cookie", "token=" + token);
            con.setDoOutput(true);

        // Crear JSON con los datos del usuario a actualizar
            JSONObject json = new JSONObject();
            json.put("nombre", nombre);
            json.put("apellidos", apellidos);
            json.put("email", email);
            json.put("usuario", usuario);
            json.put("currentPassword", currentPassword);
            json.put("newPassword", newPassword);

            // Enviar el JSON como cuerpo de la solicitud
            try (OutputStream os = con.getOutputStream()) {
                byte[] input = json.toString().getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            // Leer la respuesta del backend
            BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
            StringBuilder responseText = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                responseText.append(line.trim());
            }

            // Procesar respuesta (espera un nuevo token JWT)
            JSONObject jsonResponse = new JSONObject(responseText.toString());
            String nuevoToken = jsonResponse.getString("token");

            // Eliminar la cookie antigua
            Cookie cookieAntigua = new Cookie("token", "");
            cookieAntigua.setMaxAge(0);
            cookieAntigua.setPath("/");
            response.addCookie(cookieAntigua);

            // Crear nueva cookie
            Cookie nueva = new Cookie("token", nuevoToken);
            nueva.setHttpOnly(true);
            nueva.setPath("/");
            nueva.setMaxAge(3600);
            response.addCookie(nueva);

            // Redirigir a la página de perfil
            response.sendRedirect("profile.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("editarPerfil.jsp?mensaje=Error: No se pudo actualizar el perfil.");
        }
    }
}
