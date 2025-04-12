package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import conexionDDBB.ConexionDDBB;

public class LaboratorioDAO {

	// Método para asegurarse de que la tabla 'laboratorios' exista, si no la crea
    public static void ensureTableExists() throws SQLException {
        String checkTableQuery = "SELECT COUNT(*) FROM information_schema.tables WHERE table_name = 'laboratorios'";

        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement ps = conn.prepareStatement(checkTableQuery)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) == 0) {
                // Si la tabla no existe, crearla
                String createTableQuery = "CREATE TABLE laboratorios ("
                        + "lab_id SERIAL PRIMARY KEY, "
                        + "nombre VARCHAR(255) NOT NULL, "
                        + "flag VARCHAR(255) NOT NULL, "
                        + "puntos INT NOT NULL)";
                
                try (Statement stmt = conn.createStatement()) {
                    stmt.executeUpdate(createTableQuery);
                    System.out.println("Tabla 'laboratorios' creada exitosamente.");
                }
            }
        }
    }
	
	// Método para obtener el ID del laboratorio con nombre "foro-xss" (fijo)
    public static int obtenerIdLaboratorioForoXss() {
        int labId = -1;  // Valor predeterminado si no se encuentra el laboratorio
        String query = "SELECT lab_id FROM laboratorios WHERE nombre = 'foro-xss'";  // Nombre fijo

        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    labId = rs.getInt("lab_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return labId;
    }
    
    // Método para obtener el ID del laboratorio con nombre "Amashop" (fijo)
    public static int obtenerIdLaboratorioAmashop() {
        int labId = -1;  // Valor predeterminado si no se encuentra el laboratorio
        String query = "SELECT lab_id FROM laboratorios WHERE nombre = 'amashop'";  // Nombre fijo

        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    labId = rs.getInt("lab_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return labId;
    }
    
    // Método para agregar un nuevo laboratorio a la base de datos
    public static boolean agregarLaboratorio(String nombre, String flag, int puntos) {
        boolean exito = false;
        String query = "INSERT INTO laboratorios (nombre, flag, puntos) VALUES (?, ?, ?)";

        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, nombre);
            stmt.setString(2, flag);
            stmt.setInt(3, puntos);

            // Ejecutar la consulta
            int filasAfectadas = stmt.executeUpdate();
            if (filasAfectadas > 0) {
                exito = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return exito;
    }
	
    // Obtener la flag del laboratorio
    public static String obtenerFlagPorLaboratorio(int labId) {
        String flag = null;
        String query = "SELECT flag FROM laboratorios WHERE lab_id = ?";
        
        // Crea una instancia de ConexionDDBB
        ConexionDDBB conexionDB = new ConexionDDBB();
        
        try (Connection conn = conexionDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, labId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    flag = rs.getString("flag");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return flag;
    }
    
    public static String obtenerNombreLaboratorio(int labId) {
        String nombre = "";
        String query = "SELECT nombre FROM laboratorios WHERE lab_id = ?";
        
        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, labId);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                nombre = rs.getString("nombre");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return nombre;
    }
    
    // Obtener los puntos del laboratorio
    public static int obtenerPuntosPorLaboratorio(int labId) {
        int puntos = 0;
        String query = "SELECT puntos FROM laboratorios WHERE lab_id = ?";
        
        // Crea una instancia de ConexionDDBB
        ConexionDDBB conexionDB = new ConexionDDBB();
        
        try (Connection conn = conexionDB.conectar();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, labId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    puntos = rs.getInt("puntos");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return puntos;
    }
}
