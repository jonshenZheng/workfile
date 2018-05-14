<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="prc" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<jsp:include page="../common/head_css.jsp"/>
	<jsp:include page="../common/footer_js.jsp" />
	<script src="${prc }/common/js/jquery.form.js"></script>
    <link rel="stylesheet" href="${prc }/common/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="${prc }/common/css/build.css"/>
<title>区域</title>
</head>    
<body>
    <h6 style="height: 400px;line-height: 400px;text-align: center;font-size: 50px;">请在左边“+”按钮添加区域</h6>
</body>


</html>