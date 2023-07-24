<%-- 
    Document   : index
    Created on : Jul 18, 2023, 2:17:06 PM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang chu</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    <u1>
        <c:forEach items = "${categories}" var="p">
            <li>${p.id} - ${p.name} </li>
        </c:forEach>
    </u1>
</body>
</html>
