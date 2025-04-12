package controlador;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import conexionDDBB.ConexionDDBB;

@WebServlet("/SubirFotoPerfil")
@MultipartConfig
public class FotoControlador extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // POST: Recibe imagen y obtiene user_id desde la URL (GET)
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("POST - Procesando subida de foto...");

        // user_id viene por GET, como parámetro en la URL
        String userId = request.getParameter("user_id");
        System.out.println("POST - user_id (por GET): " + userId);

        if (userId == null || userId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de usuario no proporcionado.");
            return;
        }

        // Obtener imagen subida
        Part filePart = request.getPart("profilePhoto");
        String fileName = extractFileName(filePart);
        System.out.println("POST - Imagen recibida: " + fileName);

        if (fileName == null || fileName.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No se proporcionó una foto de perfil.");
            return;
        }

     // Definir la carpeta "uploads" dentro del contexto de la aplicación
        String relativePath = "uploads";
        String absolutePath = getServletContext().getRealPath(relativePath);  // Ruta absoluta relativa a /webapp/uploads

        // Crear el directorio si no existe
        File uploadDir = new File(absolutePath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
            System.out.println("Directorio creado en: " + absolutePath);
        }

        // Ruta completa del archivo a guardar
        String uploadPath = absolutePath + File.separator + fileName;

        try {
            filePart.write(uploadPath);  // Guardar archivo
            System.out.println("Archivo guardado en: " + uploadPath);
        } catch (IOException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al guardar el archivo.");
            return;
        }

        // Guardar en BD
        actualizarFotoEnBD(userId, fileName, response);

        response.sendRedirect("profile.jsp");
    }

    // Actualiza o inserta la foto en BD
    private void actualizarFotoEnBD(String userId, String fileName, HttpServletResponse response) throws IOException {
        ConexionDDBB conexion = new ConexionDDBB();
        try (Connection conn = conexion.conectar()) {
            // Verificar si el user_id ya tiene entrada en profile
            String checkSql = "SELECT COUNT(*) FROM profile WHERE user_id = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setInt(1, Integer.parseInt(userId));
                ResultSet rs = checkStmt.executeQuery();
                rs.next();
                int count = rs.getInt(1);

                if (count > 0) {
                    // Si ya existe, hacer UPDATE
                    String updateSql = "UPDATE profile SET photo_path = ? WHERE user_id = ?";
                    try (PreparedStatement stmt = conn.prepareStatement(updateSql)) {
                        stmt.setString(1, "uploads/" + fileName);
                        stmt.setInt(2, Integer.parseInt(userId));
                        stmt.executeUpdate();
                        System.out.println("Foto actualizada para user_id = " + userId);
                    }
                } else {
                    // Si no existe, hacer INSERT
                    String insertSql = "INSERT INTO profile (user_id, photo_path) VALUES (?, ?)";
                    try (PreparedStatement stmt = conn.prepareStatement(insertSql)) {
                        stmt.setInt(1, Integer.parseInt(userId));
                        stmt.setString(2, "uploads/" + fileName);
                        stmt.executeUpdate();
                        System.out.println("Foto insertada para user_id = " + userId);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error en la base de datos.");
        }
    }

    // Extraer nombre real del archivo subido
    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String cd : contentDisposition.split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 2, cd.length() - 1);
            }
        }
        return null;
    }
}
