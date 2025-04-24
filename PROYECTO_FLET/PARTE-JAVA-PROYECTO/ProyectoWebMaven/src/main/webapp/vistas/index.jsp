<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>DDBB APLICACION</title>
    <style>
    	* {
          font-family: 'JetBrains Mono', monospace;
          /*font-family: 'console', monospace;*/
    	}
    </style>
</head>
<body>
	<h2>CREAR TABLA CON DDBB</h2>
    <a href="<%= request.getContextPath() %>/ProductoControlador?opcion=crearTabla">Crear tabla PRODUCTO</a>
    <br>
    <h2>INSERTAR TABLA CON DDBB</h2>
    <a href="<%= request.getContextPath() %>/ProductoControlador?opcion=insertar">Insertar PRODUCTO</a>
    <br>
    <h2>CONSULTAR PRODUCTO CON DDBB</h2>
    <a href="<%= request.getContextPath() %>/ProductoControlador?opcion=consultar">Consultar PRODUCTO</a>
    <br>
    <h2>EDITAR PRODUCTO CON DDBB</h2>
    <input name="idProducto" value=" "><br><br><a href="<%= request.getContextPath() %>/ProductoControlador?opcion=editar">Editar PRODUCTO</a>
</body>
</html>