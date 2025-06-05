package controlador;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.WriteupUserDAO;
import modelo.Writeup;

@WebServlet("/verWriteups")
public class WriteupTablaControlador extends HttpServlet {
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int labId = Integer.parseInt(request.getParameter("lab_id"));
        List<Writeup> writeups = WriteupUserDAO.obtenerWriteupsPorLabId(labId);

        request.setAttribute("writeups", writeups);
        request.getRequestDispatcher("/vistas/tablaWriteups.jsp").forward(request, response);
    }
}