<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<%
    // Invalidar la sesión
    session.invalidate();
    // Redirigir al login
    response.sendRedirect(request.getContextPath() + "/labs/retroGame/retroGame-login.jsp");
%>
