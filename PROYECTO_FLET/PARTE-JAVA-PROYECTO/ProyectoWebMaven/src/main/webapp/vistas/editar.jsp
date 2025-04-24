<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Editar Producto</title>
    <style>
    	* {
          font-family: 'JetBrains Mono', monospace;
          /*font-family: 'console', monospace;*/
    	}
    </style>
</head>
<body>
	<h2>EDITAR PRODUCTO</h2>
    <form action="ProductoControlador" method="post">
    	<c:set var="producto" value="${producto}"></c:set>
		<input type="hidden" name="opcion" value="editar">
		<input name="idProducto" value="${producto.idProducto}">
		<table>
			<tr>
				<td>Nombre:</td>
				<td><input type="text" name="nombre" size="50"
				value="${producto.nombre}"></td>
			</tr>
			<br>
			<tr>
				<td>Cantidad:</td>
				<td><input type="text" name="cantidad" size="50"
				value="${producto.cantidad}"></td>
			</tr>
			<br>
			<tr>
				<td>Precio:</td>
				<td><input type="text" name="precio" size="50"
				value="${producto.precio}"></td>
			</tr>
		</table>
		<br>
		<input type="submit" value="Modificar">
	</form>
</body>
</html>