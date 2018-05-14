<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<center>
    <div style="padding:3px 2px;border-bottom:1px solid #ccc">企业信息录入</div><br/>
    
    <form id="ff" action="<%=request.getContextPath()%>/company/insertConpany" method="post" enctype="multipart/form-data" onsubmit="return submitbtn()">
        <table>
            <tr>
                <td>企业名:</td>
                <td><input type="text" name="name" value="${company.name }" ></input></td>
            </tr>
            <tr>
                <td>企业英文名:</td>
                <td><input type="text" name="englishName" value="${company.englishName }"></input></td>
            </tr>
            <tr>
                <td>地址:</td>
                <td><input type="text" name="address" value="${company.address }" /></input></td>
            </tr>
            <tr>
                <td>法人:</td>
                <td><input type="text" name="legalPerson" value="${company.legalPerson }" /></td>
            </tr>
            <tr>
                <td>企业代号:</td>
                <td><input type="text" name="code" value="${company.code }" /></td>
            </tr>
            <tr>
                <td>联系方式1:</td>
                <td><input type="text" name="phone1" id="phone1" value="${company.phone1 }" /></td>
            </tr>
            <tr>
                <td>联系方式2:</td>
                <td><input type="text" name="phone2" id="phone2" value="${company.phone2 }" /></td>
            </tr>
            <tr>
                <td>联系人:</td>
                <td><input type="text" name="linkMan" value="${company.linkMan }" /></td>
            </tr>
            <tr>
                <td>邮箱地址:</td>
                <td><input type="email" name="email" value="${company.email }" /></td>
            </tr>
            <tr>
                <!-- <td>状态:</td> -->
                <td><input type="hidden" name="status" value="1"/></td>
            </tr>
            <tr>
                <td>公司简介:</td>
                <td><input type="text" name="summary" value="${company.summary }" /></td>
            </tr>
            <tr>
                <td>传真地址:</td>
                <td><input type="text" name="faxAddress" value="${company.faxAddress }" /></td>
            </tr>
            <tr>
                <td>公司图标:</td>
                <td>
                    <div id="localImag">
                        <%--预览，默认图片  以后用于图片查看--》 src="<%=request.getContextPath()%>${logo }"--%>
                        <img id="preview" alt="预览图片" style="width: 200px; height: 200px;" required />
                    </div>
                    <div>
                        选择图片:<input id="idFile" style="width:224px" name="logofile" onchange="setImagePreview(this,localImag,preview);" type="file"  required/>
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
<c:if test="${status eq 'success'}">
    <script>
    alert("录入成功.");
    </script>
</c:if>
</body>
<script type="text/javascript" src="<%=request.getContextPath()%>/common/js/imagePreview.js"></script>
<script>


/*手机号码合法性校验*/
function doValidate() {
    var phoneNumReg = /^1[3|4|5|7|8]\d{9}$/;
    <!--表示以1开头，第二位可能是3/4/5/7/8等的任意一个，在加上后面的\d表示数字[0-9]的9位，总共加起来11位结束。-->
    if(!phoneNumReg.test(document.getElementById("phone1").value)) {
        alert("手机号码有误，请检查，手机号码为11位数字,支持13/14/15/17/18开头的手机号码  !");
        return false;
    }
    if(!phoneNumReg.test(document.getElementById("phone2").value)) {
        alert("手机号码有误，请检查，手机号码为11位数字 !");
        return false;
    }
    return true;
}

</script>

</html>