package controlador;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.xml.parsers.*;
import javax.xml.xpath.*;
import org.w3c.dom.*;
import java.io.*;
// Anotación para mapear el servlet a la URL /LoginCinehubControlador
@WebServlet("/LoginCinehubControlador")
public class LoginCinehubControlador extends HttpServlet {
    // Método que responde a solicitudes POST (por ejemplo, de un formulario de login)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Recupera los parámetros "username" y "password" del formulario
        String usuario = request.getParameter("username");
        String password = request.getParameter("password");

        // Ruta absoluta del archivo XML dentro del proyecto web
        String path = getServletContext().getRealPath("/labs/cinehub/users.xml");
        // Comienza el proceso de carga y análisis del XML
        try {
            File archivo = new File(path);
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(archivo);
            doc.getDocumentElement().normalize();

            // ⚠️ Consulta XPath vulnerable a inyección
            XPath xpath = XPathFactory.newInstance().newXPath();
            // ❗ Expresión XPath vulnerable a inyección de datos del usuario
            // Si un usuario malicioso pone ' or '1'='1 en el campo, podrá saltarse el login
            String expression = "/usuarios/usuario[nombre='" + usuario + "' and clave='" + password + "']";
            // Evalúa la expresión XPath y busca un nodo que coincida
            Node node = (Node) xpath.evaluate(expression, doc, XPathConstants.NODE);
            // Si encontró un nodo, significa que las credenciales son válidas
            if (node != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", usuario);
                response.sendRedirect(request.getContextPath() + "/labs/cinehub/cinehub.jsp");
            // Si no hay coincidencia, muestra mensaje de error
            } else {
                response.getWriter().println("Credenciales inválidas.");
            }
        // Manejo de errores al leer el archivo XML o procesar XPath
        } catch (Exception e) {
            e.printStackTrace(response.getWriter());
        }
    }
}
