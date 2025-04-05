<%@ page import="com.auth0.jwt.JWT" %>
<%@ page import="com.auth0.jwt.algorithms.Algorithm" %>
<%@ page import="com.auth0.jwt.interfaces.DecodedJWT" %>
<%@ page import="com.auth0.jwt.interfaces.JWTVerifier" %>
<%@ page import="com.auth0.jwt.exceptions.JWTVerificationException" %>
<%@ page import="io.jsonwebtoken.Claims" %>
<%@ page import="io.jsonwebtoken.Jwts" %>
<%@ page import="io.jsonwebtoken.ExpiredJwtException" %>
<%@ page import="java.nio.charset.StandardCharsets" %>


<%
    String token = request.getParameter("token");

    if (token == null || token.isEmpty()) {
        out.println("<p>Error: Token no proporcionado.</p>");
        return;
    }

    String SECRET_KEY = "clave_super_secreta";  // Cambia esto por tu clave secreta.

    // Decodificar el token JWT
    String nombre = "";
    String apellidos = "";
    String rol = "";
    String email = "";
    String ultimoLogin = "";
    String usuario = "";
    String cookie = "";

    try {
        // Usando la versi�n 0.9.1 de jjwt
        Claims claims = Jwts.parser()
            .setSigningKey(SECRET_KEY.getBytes(StandardCharsets.UTF_8)) // Configuraci�n de la clave
            .parseClaimsJws(token)  // Analizar el JWT
            .getBody();  // Obtener el cuerpo del JWT (claims)

        // Obtener la informaci�n del token
        nombre = (String) claims.get("nombre");
        apellidos = (String) claims.get("apellidos");
        rol = (String) claims.get("rol");
        email = (String) claims.get("email");
        ultimoLogin = (String) claims.get("ultimo_login");
        usuario = (String) claims.get("usuario");
        cookie = (String) claims.get("cookie");

    } catch (ExpiredJwtException e) {
        out.println("<p>Error: El token ha expirado.</p>");
        return;
    } catch (Exception e) {
        out.println("<p>Error: Token inv�lido (" + e.getMessage() + ")</p>");
        return;
    }
%>
<html>
<head>
    <title>P�gina de Inicio</title>
    <style>
    	* {
          font-family: 'JetBrains Mono', monospace;
          /*font-family: 'console', monospace;*/
    	}
    </style>
</head>
<body>
    <h1>Bienvenido, <%=usuario%></h1>
    <h1>HOME INDEX</h1>
    <a href="ProductoControlador?opcion=crearTabla">Crear tabla PRODUCTO</a><br>
    <a href="logout.jsp">Cerrar sesi�n</a><br>
    
    <!-- Mostrar la informaci�n del usuario -->
    <p>Nombre: <%= nombre %></p>
    <p>Apellidos: <%= apellidos %></p>
    <p>Rol: <%= rol %></p>
    <p>Email: <%= email %></p>
    <p>�ltimo inicio de sesi�n: <%= ultimoLogin %></p>
    
    <p>Cookie: <%=cookie%></p>
    <p>TOKEN: <%=token%></p>

    <!-- Bot�n para editar perfil -->
    <form action="profile.jsp" method="get">
        <input type="hidden" name="token" value="<%=token%>">
        <input type="submit" value="Perfil">
    </form>
</body>
</html>