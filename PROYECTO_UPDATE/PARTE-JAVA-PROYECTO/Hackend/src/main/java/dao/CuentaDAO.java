package dao;

import conexionDDBB.ConexionDDBB;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class CuentaDAO {

    public void eliminarCuentaCascade(int userId) throws Exception {
        ConexionDDBB conexionDDBB = new ConexionDDBB();
        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;
        PreparedStatement ps3 = null;

        try {
            conn = conexionDDBB.conectar();

            ps1 = conn.prepareStatement("DELETE FROM validate_flag WHERE user_id = ?");
            ps2 = conn.prepareStatement("DELETE FROM writeups WHERE user_id = ?");
            ps3 = conn.prepareStatement("DELETE FROM profile WHERE user_id = ?");

            ps1.setInt(1, userId);
            ps2.setInt(1, userId);
            ps3.setInt(1, userId);

            ps1.executeUpdate();
            ps2.executeUpdate();
            ps3.executeUpdate();

        } finally {
            if (ps1 != null) ps1.close();
            if (ps2 != null) ps2.close();
            if (ps3 != null) ps3.close();
            if (conn != null) conexionDDBB.cerrarConexion();
        }
    }
}