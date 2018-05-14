<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="prc" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>404</title>
    <style>
        body{
            margin:0 auto;
            text-align: center;
        }
    </style>
</head>
<body>
<img src="${prc}/jsp/errors/image/404.jpg" style="width: 900px;margin-top: 50px;"/>
</body>
</html>
