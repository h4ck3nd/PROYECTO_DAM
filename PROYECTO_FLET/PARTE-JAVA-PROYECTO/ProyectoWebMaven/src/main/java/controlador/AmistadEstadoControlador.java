package controlador;

import dao.AmistadDAO;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import org.json.JSONObject;
import java.sql.SQLException;
// Define el endpoint accesible mediante /amistadEstado
@WebServlet("/amistadEstado")
public class AmistadEstadoControlador extends HttpServlet {
    // Maneja solicitudes GET al endpoint
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtiene los parámetros userId y userIdDestino de la URL
        String userIdParam = request.getParameter("userId");
        String userIdDestinoParam = request.getParameter("userIdDestino");
        // Establece el tipo de contenido de respuesta como JSON
        response.setContentType("application/json");
        // Prepara el escritor para enviar la respuesta
        PrintWriter out = response.getWriter();
        // Crea un objeto JSON para la respuesta
        JSONObject jsonResponse = new JSONObject();
        // Intenta convertir los parámetros a enteros y consultar el estado de amistad
        try {
            int userId = Integer.parseInt(userIdParam);
            int userIdDestino = Integer.parseInt(userIdDestinoParam);
            // Crea instancia del DAO de amistad
            AmistadDAO amistadDAO = new AmistadDAO();
            // Consulta el estado de amistad entre los dos usuarios
            String estadoAmistad = amistadDAO.obtenerEstadoAmistad(userId, userIdDestino);
            // Agrega el estado al JSON de respuesta
            jsonResponse.put("estado", estadoAmistad);
        // Captura errores de formato numérico o SQL
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            jsonResponse.put("estado", "error");
        }
        // Escribe el JSON en la salida y la envía
        out.print(jsonResponse.toString());
        out.flush();
    }
}
