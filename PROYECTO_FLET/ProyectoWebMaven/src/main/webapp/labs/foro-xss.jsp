<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    // Flag que queremos ocultar y capturar
    String flag = "CTF{XSS_Vulnerable_Flag_1234}"; // Esta es la flag oculta

    // Obtener comentario desde parámetro GET
    String comentario = request.getParameter("comentario");
    if (comentario == null) {
        comentario = "";
    }

    // Detectar intento de XSS simple
    boolean mostrarFlag = false;
    String comentarioLower = comentario.toLowerCase();
    if (comentarioLower.contains("<script") || comentarioLower.contains("alert(") || comentarioLower.contains("document.")) {
        mostrarFlag = true;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Foro Hacker - XSS Laboratorio</title>
  <style>
    body {
      background-color: #0d1117;
      font-family: 'Courier New', monospace;
      color: #e6edf3;
      padding: 0;
      margin: 0;
    }
    .header {
      background-color: #161b22;
      padding: 20px;
      text-align: center;
    }
    .header h1 {
      color: #00ffcc;
    }
    .content {
      max-width: 800px;
      margin: auto;
      padding: 20px;
    }
    textarea, input[type="submit"] {
      display: block;
      width: 100%;
      margin-top: 10px;
      padding: 10px;
      font-family: monospace;
      font-size: 1rem;
      border-radius: 6px;
      border: 1px solid #30363d;
      background-color: #161b22;
      color: #e6edf3;
    }
    .comentario {
      margin-top: 20px;
      background-color: #1e1e1e;
      padding: 15px;
      border: 1px solid #333;
      border-radius: 6px;
    }
    #link-inocente {
      display: none; /* Escondemos el link por defecto */
    }
  </style>

  <%-- Solo incluir el archivo JS si se detecta intento XSS --%>
  <% if (mostrarFlag) { %>
    <script src="../js/foro-xss.js"></script>
  <% } %>
</head>
<body>
  <div class="header">
    <h1>💻 Laboratorio XSS - Reflejado (.jsp)</h1>
    <p>Simula una vulnerabilidad XSS reflejada en un entorno inseguro</p>
  </div>

  <div class="content">
    <form method="get" action="foro-xss.jsp">
      <label for="comentario">Escribe tu comentario:</label>
      <textarea id="comentario" name="comentario" rows="4" placeholder="Ej: &lt;script&gt;alert('XSS')&lt;/script&gt;"></textarea>
      <input type="submit" value="Enviar">
    </form>

    <% if (!comentario.trim().isEmpty()) { %>
      <div class="comentario">
        <strong>Usuario anónimo dice:</strong><br><br>
        <!-- Reflejo sin sanitizar -->
        <%= comentario %>
      </div>
    <% } %>

    <%-- Enlace oculto con la flag, solo si detectamos intento de XSS --%>
    <% if (mostrarFlag) { %>
      <div style="display:none;">
        <a id="link-inocente" data-flag="<%= flag %>"></a>
      </div>
    <% } %>
  </div>
</body>
</html>
