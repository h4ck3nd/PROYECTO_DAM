<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Consultar Producto</title>
    <style>
    	* {
          font-family: 'JetBrains Mono', monospace;
          /*font-family: 'console', monospace;*/
    	}
    </style>
</head>
<body>
	<h2>CONSULTAR PRODUCTOS</h2>
	<table border="1">
		<tr>
			<td>IdProducto</td>
			<td>Nombre</td>
			<td>Cantidad</td>
			<td>Precio</td>
			<td>Fecha Creacion</td>
			<td>Fecha Actualizacion</td>
		</tr>
		<c:forEach var="producto" items="${lista}">
			<tr>
				<td><c:out value="${producto.nombre}"></c:out></td>
				<td><c:out value="${producto.cantidad}"></c:out></td>
				<td><c:out value="${producto.precio}"></c:out></td>
				<td><c:out value="${producto.fechaCreacion}"></c:out></td>
				<td><c:out value="${producto.fechaActualizacion}"></c:out></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>