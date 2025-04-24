package controlador;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.nio.file.*;
import java.util.concurrent.TimeUnit;

@WebServlet("/EjecutarBruteForceControlador")
public class EjecutarBruteForceControlador extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getParameter("path");
        String jsession = request.getParameter("jsession");
        String token = request.getParameter("token");

        // Verificar si los parámetros son null y asignar un valor predeterminado
        if (path == null) {
            path = ""; // O asigna un valor por defecto
        }
        if (jsession == null) {
            jsession = ""; // O asigna un valor por defecto
        }
        if (token == null) {
            token = ""; // O asigna un valor por defecto
        }

        String scriptOriginal = getServletContext().getRealPath("/labs/retroGame/bruteForce.py");
        String scriptTemp = getServletContext().getRealPath("/labs/retroGame/tempBrute.py");

        String rutaUsuarios = getServletContext().getRealPath("/labs/retroGame/users.txt");
        String rutaContrasenas = getServletContext().getRealPath("/labs/retroGame/pass.txt");

        String scriptContenido = new String(Files.readAllBytes(Paths.get(scriptOriginal)));
        
        // Reemplazar solo si los valores no son nulos
        scriptContenido = scriptContenido.replace("<PATH_HTTP>", path)
                                         .replace("<JSESSIONID>", jsession)
                                         .replace("<TOKEN>", token);

        try (PrintWriter out = new PrintWriter(new FileWriter(scriptTemp))) {
            out.print(scriptContenido);
        }

        ProcessBuilder pb = new ProcessBuilder("python", scriptTemp, "-u", rutaUsuarios, "-w", rutaContrasenas);
        pb.redirectErrorStream(true);

        Process p = pb.start();
        BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream()));

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        String line;
        while ((line = reader.readLine()) != null) {
            out.println(line);
        }
    }
}
