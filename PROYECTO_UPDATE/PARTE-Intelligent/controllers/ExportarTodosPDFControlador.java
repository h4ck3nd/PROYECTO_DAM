package dam.informesmusica.controllers;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import dam.informesmusica.conexionDDBB.ConexionDDBB;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class ExportarTodosPDFControlador {

    @PostMapping("/exportarTodoPDF")
    public ResponseEntity<byte[]> exportarTodoPDF(@RequestParam("usuariosJSON") String usuariosJSON) {
        ConexionDDBB conexionDDBB = new ConexionDDBB();

        try (Connection conn = conexionDDBB.conectar();
             FileInputStream jasperStream = new FileInputStream("C:/Users/clipd/eclipse-workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/Hackend/vistas/reports/reportUsuarios.jasper")) {

            ObjectMapper mapper = new ObjectMapper();
            List<Map<String, Object>> usuarios = mapper.readValue(usuariosJSON, new TypeReference<>() {});

            ByteArrayOutputStream baos = new ByteArrayOutputStream();

            for (Map<String, Object> usuario : usuarios) {
                Map<String, Object> parametros = new HashMap<>();
                parametros.put("user_id", usuario.get("id"));
                parametros.put("nombre", usuario.get("nombre"));
                parametros.put("apellidos", usuario.get("apellidos"));
                parametros.put("usuario", usuario.get("usuario"));
                parametros.put("rol", usuario.get("rol"));
                parametros.put("fecha_registro", usuario.get("fecha_registro"));

                JasperPrint jasperPrint = JasperFillManager.fillReport(jasperStream, parametros, conn);

                // Agrega cada reporte a un solo PDF final (si lo necesitas así)
                JasperExportManager.exportReportToPdfStream(jasperPrint, baos);
            }

            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_PDF)
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=UsuariosExportados.pdf")
                    .body(baos.toByteArray());

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError()
                    .body(("Error generando PDF: " + e.getMessage()).getBytes());
        }
    }
}