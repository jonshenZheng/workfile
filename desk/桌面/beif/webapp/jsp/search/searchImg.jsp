<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="prc" value="${pageContext.request.contextPath}"/>
<%
    String ossOuterPath = application.getInitParameter("ossOuterPath");
%>
<c:set var="filepath" value="<%=ossOuterPath%>"/>
<html>
<head>
    <title>以图搜图</title>
    <link rel="stylesheet" href="${prc }/common/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="${prc }/common/css/build.css"/>
</head>
<style>
    body{
        margin-top: 50px;
    }
</style>
<body>
<center>
    <form role="form" id="searchForm" name="searchForm" action="${prc}/searchImg/getsearchResultByHash" method="post" enctype="multipart/form-data">
        <div id="localImag">
            <img id="preview" src="${prc}/test/${imgfile }" alt="预览图片" style="width: 200px; height: 200px;" required />
        </div>
        <div>
            选择图片:<input id="idFile" style="width:224px" name="imgfile" onchange="setImagePreview(this,localImag,preview);" type="file"  required/>
        </div>
        
        <p><button type="submit" class="btn btn-default">搜索</button></p>
    </form>
    <p>搜索结果，共：${imgs.size()}条记录</p>
</center>
<div>
    <c:forEach items="${imgs}" var="img">
        <img src='${prc}/test/${img.imgPath}' class="img-rounded" width="100px" height="100px">
    </c:forEach>
</div>
</body>
<script type="text/javascript" src="<%=request.getContextPath()%>/common/js/imagePreview.js"></script>
<script src="${prc }/common/js/json2.js"></script>
<script src="${prc }/common/js/jquery.form.js"></script>
<script src="${prc }/common/js/jquery-ui.min.js"></script>
</html>
