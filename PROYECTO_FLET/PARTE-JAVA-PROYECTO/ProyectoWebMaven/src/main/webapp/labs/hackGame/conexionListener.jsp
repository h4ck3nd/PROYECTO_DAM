<%@ page language="java" contentType="text/plain; charset=UTF-8" %>
<%
    String port = request.getParameter("port");
    if (port != null) {
        application.setAttribute("nc-" + port, true); // Marcar el puerto como "escuchando"
        out.print("OK");
    }
%>
