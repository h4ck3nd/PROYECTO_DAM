package controlador;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.PuntosDAO;

import java.io.*;
import java.sql.SQLException;

@WebServlet("/obtener-puntos")
public class PuntosUsuarioControlador extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el ID del usuario desde el formulario oculto
        String userIdStr = request.getParameter("userId");

        if (userIdStr != null) {
            try {
                // Convertir el ID a Integer
                int userId = Integer.parseInt(userIdStr);

                // Crear el objeto DAO y obtener los puntos de Hacking Web
                PuntosDAO puntosDAO = new PuntosDAO();
                int puntosHackingWeb = puntosDAO.obtenerPuntosHackingWeb(userId);

                // Pasar los puntos al JSP
                request.setAttribute("puntosHackingWeb", puntosHackingWeb);
                
                // Crear el objeto DAO y obtener los puntos de DockerPwned
                int puntosDockerPwned = puntosDAO.obtenerPuntosDockerPwned(userId);
                
                // Pasar los puntos al JSP
                request.setAttribute("puntosDockerPwned", puntosDockerPwned);
                
                // Crear el objeto DAO y obtener los puntos de OvaLabs
                int puntosOvaLabs = puntosDAO.obtenerPuntosOvaLabs(userId);

                // Pasar los puntos al JSP
                request.setAttribute("puntosOvaLabs", puntosOvaLabs);

                // También obtener los puntos totales del laboratorio 1
                int puntosTotalesLab1 = puntosDAO.obtenerPuntosTotalesDeLab1();
                request.setAttribute("puntosTotalesLab1", puntosTotalesLab1);
                
                // También obtener los puntos totales del laboratorio 2
                int puntosTotalesLab2 = puntosDAO.obtenerPuntosTotalesDeLab2();
                request.setAttribute("puntosTotalesLab2", puntosTotalesLab2);
                
                // También obtener los puntos totales del laboratorio 2
                int puntosTotalesLab3 = puntosDAO.obtenerPuntosTotalesDeLab3();
                request.setAttribute("puntosTotalesLab3", puntosTotalesLab3);

                // Redirigir a la página JSP para mostrar los puntos
                RequestDispatcher dispatcher = request.getRequestDispatcher("/progreso.jsp");
                dispatcher.forward(request, response);

            } catch (NumberFormatException e) {
                // Manejo de error si el ID no es válido
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            } catch (SQLException e) {
                // Manejo de error en la base de datos
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            }
        } else {
            // Manejo de error si no se encuentra el ID del usuario
            response.sendRedirect("error.jsp");
        }
    }
}
