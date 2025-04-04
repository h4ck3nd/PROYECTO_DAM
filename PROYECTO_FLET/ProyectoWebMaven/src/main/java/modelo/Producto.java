package modelo;

import java.sql.Date;

public class Producto {
	
	private int idProducto;
	private String nombre;
	private String marca;
	private Date fechaProducto;
	private Date fechaActualizacion;
	
	public Producto(int idProducto, String nombre, String marca, Date fechaProducto, Date fechaActualizacion) {
		super();
		this.idProducto = idProducto;
		this.nombre = nombre;
		this.marca = marca;
		this.fechaProducto = fechaProducto;
		this.fechaActualizacion = fechaActualizacion;
	}

	public int getIdProducto() {
		return idProducto;
	}

	public void setIdProducto(int idProducto) {
		this.idProducto = idProducto;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getMarca() {
		return marca;
	}

	public void setMarca(String marca) {
		this.marca = marca;
	}

	public Date getFechaProducto() {
		return fechaProducto;
	}

	public void setFechaProducto(Date fechaProducto) {
		this.fechaProducto = fechaProducto;
	}

	public Date getFechaActualizacion() {
		return fechaActualizacion;
	}

	public void setFechaActualizacion(Date fechaActualizacion) {
		this.fechaActualizacion = fechaActualizacion;
	}

	@Override
	public String toString() {
		return "PRODUCTO: " + "\n"
				+ "\t" + "ID: " + this.idProducto + "\n"
				+ "\t" + "Nombre: " + this.nombre + "\n"
				+ "\t" + "Marca: " + this.marca + "\n"
				+ "\t" + "Fecha del Producto: " + this.fechaProducto + "\n"
				+ "\t" + "Fecha de Actualizacion: " + this.fechaActualizacion + "\n";
	}
	
}
