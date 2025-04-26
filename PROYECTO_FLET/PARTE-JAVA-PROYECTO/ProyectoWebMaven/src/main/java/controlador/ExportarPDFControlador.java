package controlador;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.openhtmltopdf.pdfboxout.PdfRendererBuilder;

@WebServlet("/exportarPDF")
public class ExportarPDFControlador extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

        // Obtener los datos del formulario mediante GET
        String usuarioNombre = request.getParameter("usuarioNombre");
        String usuarioApellidos = request.getParameter("usuarioApellidos");
        String usuarioEmail = request.getParameter("usuarioEmail");

        // Verificar si los valores de puntos son null o vacíos antes de convertirlos
        int puntosHackingWeb = obtenerValorParametro(request, "puntosHackingWeb");
        int puntosTotalesLab1 = obtenerValorParametro(request, "puntosTotalesLab1");
        int puntosDockerPwned = obtenerValorParametro(request, "puntosDockerPwned");
        int puntosTotalesLab2 = obtenerValorParametro(request, "puntosTotalesLab2");
        int puntosOvaLabs = obtenerValorParametro(request, "puntosOvaLabs");
        int puntosTotalesLab3 = obtenerValorParametro(request, "puntosTotalesLab3");
        int puntosTimelabs = obtenerValorParametro(request, "puntosTimelabs");
        int puntosTotalesLab4 = obtenerValorParametro(request, "puntosTotalesLab4");

        // Crear la plantilla HTML con los datos obtenidos del formulario
        String html = "<html><head><style>" +
                "body { font-family: Arial, sans-serif; padding: 20px; }" +
                "h1 { color: #2c3e50; }" +
                ".lab { margin-bottom: 25px; padding: 10px; background-color: #f5f5f5; border-left: 5px solid #3498db; }" +
                "</style></head><body>" +

                "<h1>Informe de Progreso</h1>" +

                "<p><strong>Nombre:</strong> " + usuarioNombre + " " + usuarioApellidos + "</p>" +
                "<p><strong>Email:</strong> " + usuarioEmail + "</p>" +

                "<div class='lab'><h2>Hacking Web</h2>" +
                "<p>Puntuación: " + puntosHackingWeb + " / " + puntosTotalesLab1 + "</p></div>" +

                "<div class='lab'><h2>DockerPwned</h2>" +
                "<p>Puntuación: " + puntosDockerPwned + " / " + puntosTotalesLab2 + "</p></div>" +

                "<div class='lab'><h2>OvaLabs</h2>" +
                "<p>Puntuación: " + puntosOvaLabs + " / " + puntosTotalesLab3 + "</p></div>" +
                
				"<div class='lab'><h2>Timelabs</h2>" +
				"<p>Puntuación: " + puntosTimelabs + " / " + puntosTotalesLab4 + "</p></div>" +

                "</body></html>";

        // Generación del PDF
        ByteArrayOutputStream pdfStream = new ByteArrayOutputStream();

        try {
            PdfRendererBuilder builder = new PdfRendererBuilder();
            builder.useFastMode();
            builder.withHtmlContent(html, null);
            builder.toStream(pdfStream);
            builder.run();

            // Configuración de la respuesta HTTP
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=\"informe_usuario.pdf\"");
            response.getOutputStream().write(pdfStream.toByteArray());

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error generando PDF: " + e.getMessage());
        }
    }

    // Método para obtener un valor de parámetro y manejar si es null o vacío
    private int obtenerValorParametro(HttpServletRequest request, String parametro) {
        String valor = request.getParameter(parametro);
        if (valor != null && !valor.isEmpty()) {
            try {
                return Integer.parseInt(valor);
            } catch (NumberFormatException e) {
                // Si no es un número válido, se puede loggear o asignar un valor predeterminado
                return 0; // Valor predeterminado en caso de error
            }
        }
        return 0; // Valor predeterminado si el parámetro es null o vacío
    }
}
