package controlador;

import dao.FlagLogDAO;
import modelo.FlagLog;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
// Define el endpoint accesible para este servlet
@WebServlet("/FlagLogControlador")
public class FlagLogControlador extends HttpServlet {
    // Método GET que responde con un listado HTML de logs del laboratorio indicado
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Establece el tipo de contenido de la respuesta
        response.setContentType("text/html;charset=UTF-8");
        // Obtiene el parámetro 'lab_id' desde la URL
        String labIdParam = request.getParameter("lab_id");
        // Valida que se haya recibido el parámetro
        if (labIdParam == null || labIdParam.isEmpty()) {
            response.getWriter().write("<p style='color:red;'>No se especificó lab_id.</p>");
            return;
        }
        // Intenta convertir lab_id a entero y recuperar logs desde la base de datos
        try {
            int labId = Integer.parseInt(labIdParam);

            FlagLogDAO dao = new FlagLogDAO();
            List<FlagLog> logs = dao.getLogsByLabId(labId); // <-- nuevo método
            // Construcción del HTML para mostrar los logs
            StringBuilder html = new StringBuilder();
            String contextPath = request.getContextPath();
            // Contenedor general estilizado
            html.append("<div class='log-wrapper' style='max-width: 800px; margin: 0 auto; padding: 40px 30px; background-color: #181818; border-radius: 12px; box-shadow: 0 0 15px rgba(0,255,204,0.1); border: 1px solid #2c2c2c;'>");
            // Título del bloque
            html.append("<h2 style='color: #00ffff; font-family: \"Share Tech Mono\", monospace; margin-bottom: 25px; text-align: center;'>Flag Log</h2>");

            // Lista de logs
            html.append("<div class='logs-container' style='display: flex; flex-direction: column; gap: 15px;'>");
            // Itera sobre cada log recuperado
            for (FlagLog log : logs) {
                html.append("<div class='log-entry' style='display: flex; align-items: center; background-color: #1e1e1e; border: 1px solid #333; padding: 12px 20px; border-radius: 10px; box-shadow: 0 0 8px rgba(0,255,204,0.05); transition: transform 0.2s;'>")
                    .append("<img src='").append(contextPath).append("/").append(log.getPhotoPath())
                    .append("' alt='Foto de perfil' class='profile-img' style='width: 45px; height: 45px; border-radius: 50%; margin-right: 15px; border: 2px solid #00ffff33; box-shadow: 0 0 6px #00ffff22;'>")
                    .append("<div class='log-text' style='color: #e0e0e0; font-family: \"Share Tech Mono\", monospace; font-size: 1rem;'>")
                    .append("<span style='color: #00ffff;'>").append(log.getUsername()).append("</span>")
                    .append(" <span style='color: #ccc;'>got root</span>")
                    .append("</div>")
                    .append("</div>");
            }

            html.append("</div>"); // cierre logs-container
            html.append("</div>"); // cierre log-wrapper
            
            response.getWriter().write(html.toString());
        // Manejo de error si lab_id no es un número
        } catch (NumberFormatException e) {
            response.getWriter().write("<p style='color:red;'>lab_id inválido.</p>");
        // Manejo de errores generales
        } catch (Exception e) {
            response.getWriter().write("<p style='color:red;'>Error al cargar logs.</p>");
            e.printStackTrace();
        }
    }
}
