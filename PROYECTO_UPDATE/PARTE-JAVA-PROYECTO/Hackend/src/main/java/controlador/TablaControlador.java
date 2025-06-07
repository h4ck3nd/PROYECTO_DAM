package controlador;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.TablaDAO;

@WebServlet("/TablaController")
public class TablaControlador extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tabla = request.getParameter("tabla");
        String accion = request.getParameter("accion");
        TablaDAO dao = new TablaDAO();

        // Determinar la columna clave primaria según la tabla
        String columnaClave = "id";
        if ("laboratorios".equalsIgnoreCase(tabla)) {
            columnaClave = "lab_id";
        }

        switch (accion) {
            case "insert":
                Map<String, String> valoresInsert = new HashMap<>();
                Enumeration<String> nombresInsert = request.getParameterNames();
                while (nombresInsert.hasMoreElements()) {
                    String param = nombresInsert.nextElement();
                    // Excluir acción, tabla y la clave primaria para que el ID se asigne automáticamente
                    if (!param.equals("accion") && !param.equals("tabla") && !param.equals(columnaClave)) {
                        valoresInsert.put(param, request.getParameter(param));
                    }
                }
                dao.insertar(tabla, valoresInsert);
                break;

            case "delete":
                String valorClave = request.getParameter(columnaClave);
                if (valorClave != null) {
                    dao.eliminar(tabla, columnaClave, valorClave);
                } else {
                    response.getWriter().write("No se ha proporcionado el valor de la clave primaria para eliminar.");
                    return;
                }
                break;

            case "update":
                String valorClaveUpdate = request.getParameter(columnaClave);
                if (valorClaveUpdate != null) {
                    Map<String, String> valoresUpdate = new HashMap<>();
                    Enumeration<String> nombresUpdate = request.getParameterNames();
                    while (nombresUpdate.hasMoreElements()) {
                        String param = nombresUpdate.nextElement();
                        // Excluir acción, tabla y la clave primaria
                        if (!param.equals("accion") && !param.equals("tabla") && !param.equals(columnaClave)) {
                            valoresUpdate.put(param, request.getParameter(param));
                        }
                    }
                    dao.actualizar(tabla, valoresUpdate, valorClaveUpdate);
                } else {
                    response.getWriter().write("No se proporcionó la clave primaria para la actualización.");
                    return;
                }
                break;
        }

        response.sendRedirect("vistas/designer/manageTables.jsp?tabla=" + tabla);
    }
}
