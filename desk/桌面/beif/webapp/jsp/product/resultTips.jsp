<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="prc" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <style>
        h4{
            font-size: 30px;
            font-weight: normal;
            margin : 10px 0;
        }

        a{
            display:inline-block;
            margin-right: 10px;
            color: #199ed8;
            font-size: 18px;
            text-decoration: none;
        }
    </style>
</head>
<body>

<h4>产品录入成功</h4>
<p><a href="${prc}/html/product/addProdRecord.html" target="content" >继续录入产品</a><a href="">进入编辑</a></p>

</body>
</html>