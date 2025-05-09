package controlador;

import dao.LaboratorioDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

// Mapea esta clase al endpoint /agregarLaboratorio
@WebServlet("/agregarLaboratorio")
public class AgregarLaboratorioControlador extends HttpServlet {
    // Identificador de versión del servlet (buena práctica para serialización)
    private static final long serialVersionUID = 1L;

    // Método que maneja solicitudes POST (cuando se envía el formulario)
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtiene los parámetros enviados desde el formulario HTML
        String nombre = request.getParameter("nombre");
        String flag = request.getParameter("flag");
        String puntosStr = request.getParameter("puntos");

        // Variable para almacenar el mensaje que se mostrará al usuario
        String mensaje = "";

        try {
            // Validar los puntos (debe ser un número entero positivo)
            int puntos = Integer.parseInt(puntosStr);
            // Verifica si el valor es positivo
            if (puntos <= 0) {
                mensaje = "Los puntos deben ser un número positivo.";
            } else {
                // Insertar el nuevo laboratorio en la base de datos
                boolean exito = LaboratorioDAO.agregarLaboratorio(nombre, flag, puntos);
                // Establece mensaje dependiendo del éxito
                if (exito) {
                    mensaje = "Laboratorio agregado con éxito.";
                } else {
                    mensaje = "Hubo un error al agregar el laboratorio.";
                }
            }
        } catch (NumberFormatException e) {
            // Si los puntos no son un número válido
            mensaje = "Los puntos deben ser un número válido.";
        }

        // Pasar el mensaje al JSP
        request.setAttribute("mensaje", mensaje);
        request.getRequestDispatcher("designer/agregarLaboratorio.jsp").forward(request, response);
    }
}
