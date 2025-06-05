package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conexionDDBB.ConexionDDBB;
import modelo.Writeup;

public class WriteupUserDAO {

	public static List<Writeup> obtenerWriteupsPorLabId(int labId) {
	    List<Writeup> lista = new ArrayList<>();
	    ConexionDDBB db = new ConexionDDBB();
	    Connection con = null;

	    String sql = "SELECT w.url_writeup, w.username, l.nombre " +
	                 "FROM writeups w " +
	                 "JOIN laboratorios l ON w.lab_id = l.lab_id " +
	                 "WHERE w.lab_id = ?";

	    try {
	        con = db.conectar();
	        PreparedStatement stmt = con.prepareStatement(sql);
	        stmt.setInt(1, labId);
	        ResultSet rs = stmt.executeQuery();

	        while (rs.next()) {
	            String url = rs.getString("url_writeup");
	            String username = rs.getString("username");
	            String nombreLab = rs.getString("nombre");

	            lista.add(new Writeup(username, url, nombreLab));
	        }

	        rs.close();
	        stmt.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        db.cerrarConexion();
	    }

	    return lista;
	}
}