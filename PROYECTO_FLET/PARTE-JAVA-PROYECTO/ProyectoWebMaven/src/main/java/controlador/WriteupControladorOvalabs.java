package controlador;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.WriteupDAO;

@WebServlet("/WriteupControladorOvalabs")
public class WriteupControladorOvalabs extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int labId = Integer.parseInt(request.getParameter("lab_id"));
        int userId = Integer.parseInt(request.getParameter("user_id"));
        String username = request.getParameter("username");
        String url = request.getParameter("url_writeup");

        WriteupDAO dao = new WriteupDAO();
        boolean insertado = dao.insertWriteupOvalabs(labId, userId, url, username);

        if (insertado) {
            response.sendRedirect(request.getContextPath() + "/sendWriteups.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }
}