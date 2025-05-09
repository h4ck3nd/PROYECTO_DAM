package controlador;

import conexionDDBB.ConexionDDBB;
import com.google.gson.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
// Define el endpoint /countdown para este servlet
@WebServlet("/countdown")
public class CountdownControlador extends HttpServlet {
    // Identificador fijo de la fila del contador en la base de datos
    private static final int COUNTDOWN_ID = 1;
    // Maneja solicitudes GET para obtener el estado o el tiempo objetivo
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // Respuesta en formato JSON
        resp.setContentType("application/json");
        // Conectar a la base de datos
        ConexionDDBB db = new ConexionDDBB();
        Connection conn = db.conectar();
        
        try (PreparedStatement stmt = conn.prepareStatement("SELECT target_time FROM countdown WHERE id = ?")) {
            // Asigna el ID del contador y ejecuta la consulta
            stmt.setInt(1, COUNTDOWN_ID);
            ResultSet rs = stmt.executeQuery();
            // Si existe la fila, procesa el resultado
            if (rs.next()) {
                long targetTime = rs.getLong("target_time");

                JsonObject json = new JsonObject();

                // Si viene el parámetro ?status=true devolvemos si está activo o no
                if ("true".equalsIgnoreCase(req.getParameter("status"))) {
                    boolean activo = (targetTime > 0); // si hay tiempo, está activo
                    json.addProperty("activo", activo);
                } else {
                    // Si no hay parámetro, devolvemos el targetTime
                    json.addProperty("targetTime", targetTime);
                }
                // Envía el JSON al cliente
                resp.getWriter().write(json.toString());
            } else {
                // Si no existe la fila, devuelve 404
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException e) {
            // En caso de error de BBDD, devuelve 500 e imprime stacktrace en la respuesta
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            e.printStackTrace(resp.getWriter());
        } finally {
            // Cierra la conexión a la base de datos
            db.cerrarConexion();
        }
    }
    // Maneja solicitudes POST para iniciar o reiniciar el contador
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // Respuesta en JSON
        resp.setContentType("application/json");
        // Lee el cuerpo de la petición y mapea el JSON
        BufferedReader reader = req.getReader();
        JsonObject body = JsonParser.parseReader(reader).getAsJsonObject();
        // Obtiene la duración en segundos desde el JSON recibido
        int durationSeconds = body.get("durationSeconds").getAsInt();
        // Calcula el nuevo targetTime en milisegundos
        long targetTime = System.currentTimeMillis() + (durationSeconds * 1000L);
        // Conecta a la BBDD
        ConexionDDBB db = new ConexionDDBB();
        Connection conn = db.conectar();

        try (PreparedStatement stmt = conn.prepareStatement("UPDATE countdown SET target_time = ? WHERE id = ?")) {
            // Asigna parámetros y ejecuta la actualización
            stmt.setLong(1, targetTime);
            stmt.setInt(2, COUNTDOWN_ID);
            stmt.executeUpdate();
            // Prepara y envía JSON con el nuevo targetTime
            JsonObject json = new JsonObject();
            json.addProperty("targetTime", targetTime);
            resp.getWriter().write(json.toString());
            // Manejo de error SQL: devuelve 500 e imprime detalles
        } catch (SQLException e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            e.printStackTrace(resp.getWriter());
            // Cierra la conexión
        } finally {
            db.cerrarConexion();
        }
    }
    // Maneja solicitudes DELETE para resetear el contador
    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        // Respuesta en JSON
        ConexionDDBB db = new ConexionDDBB();
        Connection conn = db.conectar();
        
        try (PreparedStatement stmt = conn.prepareStatement("UPDATE countdown SET target_time = NULL WHERE id = ?")) {
            // Asigna el ID y ejecuta la actualización para resetear
            stmt.setInt(1, COUNTDOWN_ID);
            stmt.executeUpdate();

            JsonObject json = new JsonObject();
            // Envía mensaje de confirmación en JSON
            json.addProperty("message", "Contador reseteado");
            resp.getWriter().write(json.toString());
            // Manejo de error SQL: devuelve 500 e imprime detalles
        } catch (SQLException e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            e.printStackTrace(resp.getWriter());
        } finally {
            db.cerrarConexion();
        }
    }
}
