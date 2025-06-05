package controlador;

import java.sql.Connection;
import java.util.List;

import conexionDDBB.ConexionDDBB;
import dao.RankingDAO;
import modelo.RankingEntry;

public class RankingControlador {

    public List<RankingEntry> obtenerRankingUsuarios() {
        ConexionDDBB db = new ConexionDDBB();
        Connection conn = null;

        try {
            conn = db.conectar();
            RankingDAO dao = new RankingDAO();
            return dao.getRankingFromAllTables(conn);
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        } finally {
            if (conn != null) {
                db.cerrarConexion();
            }
        }
    }
}