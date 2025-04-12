package dao;

import conexionDDBB.ConexionDDBB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ValidateFlagDAO {

    // Verificar si el usuario ya ha validado la flag para el laboratorio
    public static boolean hasFlagBeenValidated(int userId, int labId) throws SQLException {
        boolean result = false;
        String query = "SELECT COUNT(*) FROM validate_flag WHERE user_id = ? AND lab_id = ?";
        
        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setInt(2, labId);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                result = true;
            }
        }
        
        return result;
    }

    // Registrar la validación de la flag para el usuario
    public static void registerFlagValidation(int userId, int labId, String flag, int puntos) throws SQLException {
        String query = "INSERT INTO validate_flag (user_id, lab_id, flag, puntos) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = new ConexionDDBB().conectar();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setInt(2, labId);
            ps.setString(3, flag);
            ps.setInt(4, puntos);
            
            ps.executeUpdate();
        }
    }
}
