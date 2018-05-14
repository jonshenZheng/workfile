<%@page import="java.lang.Exception"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="prc" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>500</title>
    <style>
        body{
            margin:0 auto;
            text-align: center;
        }
    </style>
    
</head>
<body>
    <img src="${prc}/jsp/errors/image/500.jpg" style="width: 900px;margin-top: 50px;"/>
    <div style="display:none;">
    <%
      System.out.print("========================服务器发生异常=========================");
      exception.printStackTrace();
  	%>
  	</div>
</body>
</html>
