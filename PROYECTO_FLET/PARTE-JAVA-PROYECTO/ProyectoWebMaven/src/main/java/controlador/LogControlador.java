package controlador;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.nio.file.*;
// Definición del servlet y asignación de la ruta de acceso
@WebServlet("/getLogs")
public class LogControlador extends HttpServlet {
    // Método para manejar peticiones GET
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Ruta al archivo .log de Eclipse
        String logFilePath = System.getProperty("user.home") + "/eclipse-workspace/.metadata/.log";
        
        // Lee el archivo y lo devuelve
        File logFile = new File(logFilePath);
        // Verifica si el archivo existe y es un archivo válido
        if (logFile.exists() && logFile.isFile()) {
            try (BufferedReader reader = Files.newBufferedReader(logFile.toPath())) {
                StringBuilder logContent = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    logContent.append(line).append("<br>");
                }
                // Configura el tipo de contenido y envía la respuesta
                response.setContentType("text/html");
                response.getWriter().write(logContent.toString());
            }
            // Si el archivo no existe o no es accesible
        } else {
            response.getWriter().write("No se puede acceder al archivo de log.");
        }
    }
}
