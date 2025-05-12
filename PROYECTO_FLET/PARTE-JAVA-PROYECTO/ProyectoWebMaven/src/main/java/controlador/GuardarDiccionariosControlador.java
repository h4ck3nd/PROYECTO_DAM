package controlador;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
// Definición del servlet con la URL que lo invoca
@WebServlet("/GuardarDiccionariosControlador")
public class GuardarDiccionariosControlador extends HttpServlet {
    // Manejo de solicitudes POST
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener los parámetros "usuarios" y "contrasenas" del formulario
        String usuarios = request.getParameter("usuarios");
        String contrasenas = request.getParameter("contrasenas");
        // Obtener la ruta absoluta dentro del servidor donde se guardarán los archivos
        String rutaUsuarios = getServletContext().getRealPath("/labs/retroGame/users.txt");
        String rutaContrasenas = getServletContext().getRealPath("/labs/retroGame/pass.txt");
        // Guardar el contenido del campo "usuarios" en users.txt
        try (PrintWriter writer = new PrintWriter(new FileWriter(rutaUsuarios))) {
            writer.write(usuarios != null ? usuarios : "");
        }
        // Guardar el contenido del campo "contrasenas" en pass.txt
        try (PrintWriter writer = new PrintWriter(new FileWriter(rutaContrasenas))) {
            writer.write(contrasenas != null ? contrasenas : "");
        }
        // Redirigir al usuario de vuelta a la interfaz principal
        response.sendRedirect(request.getContextPath() + "/labs/retroGame/bruteForce.jsp"); // Vuelve a la interfaz principal
    }
}
