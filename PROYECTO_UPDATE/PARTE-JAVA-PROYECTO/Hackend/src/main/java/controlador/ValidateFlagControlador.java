package controlador;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.LaboratorioDAO;
import dao.ValidateFlagDAO;
import utils.JWTUtils;
import utils.UsuarioJWT;

@WebServlet("/validarFlag")
public class ValidateFlagControlador extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String mensaje = "";
        int labId = -1;

        try {
            // Obtener el userId desde el JWT
            UsuarioJWT usuario = JWTUtils.obtenerUsuarioDesdeRequest(request);
            String userId = usuario.getUserId();

            // Obtener lab_id desde los parámetros de la URL
            String labIdParam = request.getParameter("lab_id");
            labId = Integer.parseInt(labIdParam);

            // Verificar si el usuario ya ha validado la flag
            boolean flagValidada = ValidateFlagDAO.hasFlagBeenValidated(Integer.parseInt(userId), labId);
            if (flagValidada) {
                mensaje = "Ya has validado esta flag.";
            } else {
                // Comprobar flag
                String flagIngresada = request.getParameter("flag");
                String flagCorrecta = LaboratorioDAO.obtenerFlagPorLaboratorio(labId);

                if (flagIngresada != null && flagIngresada.equals(flagCorrecta)) {
                    int puntos = LaboratorioDAO.obtenerPuntosPorLaboratorio(labId);
                    ValidateFlagDAO.registerFlagValidation(Integer.parseInt(userId), labId, flagIngresada, puntos);
                    mensaje = "Flag validada con exito. Puntos: " + puntos;
                } else {
                    mensaje = "Flag incorrecta, intenta nuevamente.";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            mensaje = "Hubo un error al validar la flag.";
        }

        // Redirección según el labId
        String redireccion;
        switch (labId) {
            case 1:
                redireccion = "/vistas/labs/foro-xss-lab.jsp";
                break;
            case 2:
                redireccion = "/vistas/labs/separo/separo-lab.jsp";
                break;
            default:
                redireccion = "/vistas/home_directory/home.jsp"; // Ruta por defecto si no coincide
                break;
        }

        response.sendRedirect(request.getContextPath() + redireccion + "?mensaje=" + mensaje);
    }
}
