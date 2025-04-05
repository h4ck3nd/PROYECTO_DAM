
<%
String usuario = request.getParameter("usuario");
String cookie = request.getParameter("cookie");

if (usuario == null) {
	usuario = "Invitado";
}

if (cookie == null) {
	cookie = "No hay cookie";
}
%>
<html>
<head>
<title>Página de Inicio</title>
</head>
<body>
	<h1>
		Bienvenido,
		<%=usuario%></h1>
	<h1>HOME INDEX</h1>
	<a href="ProductoControlador?opcion=crearTabla">Crear tabla PRODUCTO</a>
	<br>
	<a href="logout.jsp">Cerrar sesion</a>
	<br>
	<p>
		Cookie:
		<%=cookie%></p>

	<!-- Botón para editar perfil -->
	<form action="editarPerfil.jsp" method="get">
		<input type="hidden" name="cookie" value="<%=cookie%>"> <input
			type="submit" value="Editar Perfil">
	</form>

	<script>
        function editProfile() {
            // Redirige al perfil en la aplicación Flet, pasando la cookie para identificar al usuario
            window.location.href = "http://localhost:4308/edit_profile?cookie=<%=cookie%>
		";
		}
	</script>

</body>
</html>
