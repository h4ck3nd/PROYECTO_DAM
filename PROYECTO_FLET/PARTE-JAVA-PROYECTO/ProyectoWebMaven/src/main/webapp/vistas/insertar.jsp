<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>INSERTAR PRODUCTO</title>
</head>
<body>
	<h1>INSERTAR PRODUCTO</h1>
	<form action="ProductoControlador" method="post">
		<input type="hidden" name="opcion" value="insertar">
		<table>
			<tr>
				<td>Nombre:</td>
				<td><input type="text" name="nombre" size="50"></td>
			</tr>
			<br>
			<tr>
				<td>Cantidad:</td>
				<td><input type="text" name="cantidad" size="50"></td>
			</tr>
			<br>
			<tr>
				<td>Precio:</td>
				<td><input type="text" name="precio" size="50"></td>
			</tr>
		</table>
		<br>
		<input type="submit" value="Insertar">
	</form>
</body>
</html>