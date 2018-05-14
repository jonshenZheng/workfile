<%@ page import="com.baize.fileSystem.IFileSystem" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="prc" value="${pageContext.request.contextPath}"/>
<%
    String ossOuterPath = application.getInitParameter("ossOuterPath");
%>
<c:set var="filepath" value="<%=ossOuterPath%>"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<center>
    <form id="ff" action="${prc}/company/updateConpany" method="post" enctype="multipart/form-data" onsubmit="return submitValidate()">
        <input type="hidden" name="fid" value="${company4updadte.fid }"/>
        <table>
            <tr>
                <td>企业名:</td>
                <td><input type="text" name="name" value="${company4updadte.name }" required></input></td>
            </tr>
            <tr>
                <td>企业英文名:</td>
                <td><input type="text" name="englishName" value="${company4updadte.englishName }" ></input></td>
            </tr>
            <tr>
                <td>地址:</td>
                <td><input type="text" name="address" value="${company4updadte.address }" required/></input></td>
            </tr>
            <tr>
                <td>法人:</td>
                <td><input type="text" name="legalPerson" value="${company4updadte.legalPerson }" required/></td>
            </tr>
            <tr>
                <td>企业代号:</td>
                <td><input type="text" name="code" value="${company4updadte.code }" required/></td>
            </tr>
            <tr>
                <td>联系方式1:</td>
                <td><input type="text" name="phone1" id="phone1" value="${company4updadte.phone1 }" required/></td>
            </tr>
            <tr>
                <td>联系方式2:</td>
                <td><input type="text" name="phone2" id="phone2" value="${company4updadte.phone2 }" required/></td>
            </tr>
            <tr>
                <td>联系人:</td>
                <td><input type="text" name="linkMan" value="${company4updadte.linkMan }" required/></td>
            </tr>
            <tr>
                <td>邮箱地址:</td>
                <td><input type="email" name="email" value="${company4updadte.email }" required/></td>
            </tr>
            <tr>
                <!-- <td>状态:</td> -->
                <td><input type="hidden" name="status" value="1"/></td>
            </tr>
            <tr>
                <td>公司简介:</td>
                <td><input type="text" name="summary" value="${company4updadte.summary }" required/></td>
            </tr>
            <tr>
                <td>传真地址:</td>
                <td><input type="text" name="faxAddress" value="${company4updadte.faxAddress }" required/></td>
            </tr>
            <tr>
                <td>公司图标:</td>
                <td>
                    <div id="localImag">
                        <%--预览，默认图片  以后用于图片查看--》 src="<%=request.getContextPath()%>${logo }"--%>
                        <img id="preview" alt="预览图片"  src="${filepath }${company4updadte.logo }" style="width: 200px; height: 200px;" required />
                        <input type="hidden" id="logo" name="logo" value="${company4updadte.logo }"/>
                    </div>
                    <div>
                                                                 选择图片:<input id="idFile" style="width:224px" name="logofile" onchange="setImagePreview(this,localImag,preview);" type="file" />
                    </div>
                </td>
            </tr>
            <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
            <tr>
                <td></td>
                <td><input type="submit" value="Submit"></input></td>
            </tr>
        </table>
    </form>
</center>
</body>
<script type="text/javascript" src="<%=request.getContextPath()%>/common/js/imagePreview.js"></script>
<script>
    function submitValidate(){
        var imgsrc = $("#preview").attr("src");
        if("" == imgsrc){
            alert("请上传一个logo.");
            return false;
        }
    }
</script>

</html>