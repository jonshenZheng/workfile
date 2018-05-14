<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="prc" value="${pageContext.request.contextPath}"/>

<!--[if !IE]> -->
    <script src="${prc }/common/js/jQuery-2.2.0.min.js"></script>
<!-- <![endif]-->

<!--[if lte IE 8]>
     <script src="${prc }/common/js/jquery-1.12.4.min.js"></script>
<![endif]-->

 <!--[if gt IE 8]>
     <script src="${prc }/common/js/jQuery-2.2.0.min.js"></script>
<![endif]-->

<script src="${prc }/common/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="${prc }/common/lib/dialog/bootstrap-dialog.min.js"></script>
<script src="${prc }/common/lib/swiper/swiper.min.js"></script>
<script src="${prc }/common/js/commonJs.js"></script>