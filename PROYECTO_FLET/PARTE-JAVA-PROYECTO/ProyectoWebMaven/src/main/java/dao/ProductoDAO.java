package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import conexionDDBB.ConexionDDBB;
import modelo.Producto;

public class ProductoDAO {
	
	private ConexionDDBB conexion = new ConexionDDBB();
	private Connection connection;
	private Statement sentencia;
	private PreparedStatement sentenciaParametrizada;
	private ResultSet resultSet;

	public ProductoDAO() {
		this.connection = conexion.conectar();
	}
	
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
	
	public boolean insertar(Producto producto) {
		if(producto != null) {
			String queryInsert = "INSERT INTO producto"
								 + "(nombre, cantidad, precio, fechaCreacion) "
								 + "VALUES (?, ?, ?, ?);";
			try {
				sentenciaParametrizada = connection.prepareStatement(queryInsert);
				sentenciaParametrizada.setString(1, producto.getNombre());
				sentenciaParametrizada.setInt(2, producto.getCantidad());
				sentenciaParametrizada.setDouble(3, producto.getPrecio());
				sentenciaParametrizada.setDate(4, producto.getFechaCreacion());
				
				sentenciaParametrizada.executeUpdate();
				return true;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return false;
	}
	
	public ArrayList<Producto> consultarProductos() {
		ArrayList<Producto> productos = new ArrayList<Producto>();
		String querySelect = "SELECT * FROM producto ORDER BY idProducto;";
		try {
			sentencia = connection.createStatement();
			resultSet = sentencia.executeQuery(querySelect);
			while(resultSet.next()) {
				productos.add(new Producto(
						resultSet.getInt("idProducto"),
						resultSet.getString("nombre"), 
						resultSet.getInt("cantidad"),
						resultSet.getDouble("precio"), 
						resultSet.getDate("fechaCreacion"),
						resultSet.getDate("fechaActualizacion")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return productos;
	}
	
	public void editar(Producto producto) {
		if(producto != null) {
			String queryUpdate = "UPDATE producto SET nombre = ?, "
					+ "cantidad = ?, precio = ? "
					+ "WHERE idProducto = ?;";
		try {
			sentenciaParametrizada = connection.prepareStatement(queryUpdate);
			sentenciaParametrizada.setString(1, producto.getNombre());
			sentenciaParametrizada.setInt(1, producto.getCantidad());
			sentenciaParametrizada.setDouble(1, producto.getPrecio());
			sentenciaParametrizada.setInt(1, producto.getIdProducto());
			
			sentenciaParametrizada.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		}
	}
	
	public Producto obtenerProductos(int idProducto) {
		Producto producto = null;
		String querySelect = "SELECT * FROM producto ORDER BY idProducto;";
		try {
			sentenciaParametrizada = connection.prepareStatement(querySelect);
			sentenciaParametrizada.setInt(1, idProducto);
			resultSet = sentenciaParametrizada.executeQuery();
			while(resultSet.next()) {
				producto = new Producto(
						resultSet.getInt("idProducto"),
						resultSet.getString("nombre"), 
						resultSet.getInt("cantidad"),
						resultSet.getDouble("precio"), 
						resultSet.getDate("fechaCreacion"),
						resultSet.getDate("fechaActualizacion"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return producto;
	}
	
	public ConexionDDBB getConexion() {
		return conexion;
	}

	public void setConexion(ConexionDDBB conexion) {
		this.conexion = conexion;
	}
	
}