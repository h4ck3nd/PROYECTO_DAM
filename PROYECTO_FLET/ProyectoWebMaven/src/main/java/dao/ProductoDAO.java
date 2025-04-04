package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import conexionDDBB.ConexionDDBB;

public class ProductoDAO {
	private ConexionDDBB conexion = new ConexionDDBB();
	private Connection connection;
	private Statement sentencia;
	private PreparedStatement sentenciaParametrizada;
	private ResultSet resultSet;

	public boolean createTable() {
		String queryCreate = "CREATE TABLE producto(" 
				     + "idProducto serial PRIMARY KEY,"
				     + "nombre VARCHAR(100),"
				     + "cantidad int,"
				     + "precio DECIMAL(5,2),"
				     + "fechaCreacion DATE,"
				     + "fechaActualizacion DATE"
				     + ");";
		try {
			sentencia = connection.createStatement();
			sentencia.executeUpdate(queryCreate);
			return true;
		} catch (SQLException e) {
			System.out.println("Error al crear la tabla producto");
			e.printStackTrace();
			return false;
		}
	}

}
