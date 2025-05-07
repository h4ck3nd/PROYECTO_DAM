<%@ page contentType="application/json;charset=UTF-8" language="java" %>
<%
    String ip = request.getParameter("ip");
    String port = request.getParameter("port");

    String ncKey = "nc-" + port;
    Boolean listenerActive = (Boolean) application.getAttribute(ncKey);

    response.setContentType("application/json");
    if (listenerActive != null && listenerActive) {
        application.setAttribute("shell-conectada", true);
        application.setAttribute("shell-ip", ip);
        application.setAttribute("shell-port", port);
        out.print("{\"status\":\"connected\"}");
    } else {
        out.print("{\"status\":\"failed\"}");
    }
%>
