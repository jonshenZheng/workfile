<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="prc" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>index</title>
    <jsp:include page="../common/head_css.jsp"/>
</head>
<body>
    
    <div class="container">
        <div class="row">
            <div class="col-sm-12 col-md-12">
                <div class="jumbotron">
                  <h1>主页</h1>
                  <%--<p>...</p>
                  <p><a class="btn btn-primary btn-lg" href="#" role="button">更多...</a></p>--%>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../common/footer_js.jsp" />
    <script type="text/javascript">
        if (window.parent.SetWinHeight){
            window.parent.SetWinHeight();
        }
    </script>
</body>
</html>