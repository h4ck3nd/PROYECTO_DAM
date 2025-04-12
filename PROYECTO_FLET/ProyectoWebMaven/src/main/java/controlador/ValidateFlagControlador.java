package controlador;

import dao.LaboratorioDAO;
import dao.ValidateFlagDAO;
import utils.JWTUtils;
import utils.UsuarioJWT;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/validarFlag")
public class ValidateFlagControlador extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Obtener el userId desde el JWT
            UsuarioJWT usuario = JWTUtils.obtenerUsuarioDesdeRequest(request);
            String userId = usuario.getUserId(); // Obtener el userId del JWT

            // Obtener lab_id desde los parámetros de la URL
            String labIdParam = request.getParameter("lab_id");
            int labId = Integer.parseInt(labIdParam); // Convertir a int

            // Verificar si el usuario ya ha validado la flag
            boolean flagValidada = ValidateFlagDAO.hasFlagBeenValidated(Integer.parseInt(userId), labId);
            if (flagValidada) {
                // Si ya se validó la flag, mostrar mensaje
                request.setAttribute("mensaje", "Ya has validado esta flag.");
            } else {
                // Si no se ha validado la flag, comprobar si la flag ingresada es correcta
                String flagIngresada = request.getParameter("flag");
                String flagCorrecta = LaboratorioDAO.obtenerFlagPorLaboratorio(labId);

                if (flagIngresada != null && flagIngresada.equals(flagCorrecta)) {
                    // Aquí obtienes los puntos del laboratorio
                    int puntos = LaboratorioDAO.obtenerPuntosPorLaboratorio(labId);

                    // Registrar en la base de datos la validación de la flag
                    ValidateFlagDAO.registerFlagValidation(Integer.parseInt(userId), labId, flagIngresada, puntos);

                    // Mostrar mensaje de éxito
                    request.setAttribute("mensaje", "Flag validada con éxito. Puntos: " + puntos);
                } else {
                    // Si la flag es incorrecta
                    request.setAttribute("mensaje", "Flag incorrecta, intenta nuevamente.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensaje", "Hubo un error al validar la flag.");
        }

        // Obtener el mensaje de la solicitud
        String mensaje = (String) request.getAttribute("mensaje");

        // Redirigir al JSP con el mensaje en la URL
        response.sendRedirect(request.getContextPath() + "/labs/foro-xss.jsp?mensaje=" + mensaje);
    }
}