package controlador;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import dao.CuentaDAO;

@WebServlet("/eliminar-cuenta-cascade")
public class EliminacionCascadeController extends HttpServlet {

    private CuentaDAO cuentaDAO;

    @Override
    public void init() {
        cuentaDAO = new CuentaDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            // Leer JSON del cuerpo de la petición
            StringBuilder sb = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }

            JSONObject json = new JSONObject(sb.toString());
            int userId = json.getInt("userId");

            // 1. Eliminar datos en cascada
            cuentaDAO.eliminarCuentaCascade(userId);

            // 2. Llamar a Flask para eliminar el usuario
            String flaskUrl = "http://localhost:5000/eliminar-cuenta?userId=" + userId + "&internal=true";
            HttpURLConnection conn = (HttpURLConnection) new URL(flaskUrl).openConnection();
            conn.setRequestMethod("GET");
            conn.setConnectTimeout(3000);
            conn.setReadTimeout(3000);

            int flaskResponseCode = conn.getResponseCode();
            if (flaskResponseCode != 302 && flaskResponseCode != 200) {
                throw new IOException("Flask devolvió código: " + flaskResponseCode);
            }

            JSONObject success = new JSONObject();
            success.put("mensaje", "Eliminación completa (Java + Python)");
            out.print(success);

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JSONObject error = new JSONObject();
            error.put("error", "Fallo en la eliminación: " + e.getMessage());
            out.print(error);
        }

        out.flush();
    }
}