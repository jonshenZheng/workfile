<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="prc" value="${pageContext.request.contextPath}"/>
<%
	String ossOuterPath = application.getInitParameter("ossOuterPath");
%>
<c:set var="filepath" value="<%=ossOuterPath%>"/>
<!DOCTYPE html>
<html><head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>index</title>
	<jsp:include page="../common/head_css.jsp"/>
    <link rel="stylesheet" href="${prc }/common/css/font-awesome.min.css">
    <link rel="stylesheet" href="${prc }/common/css/build.css">

    
    <style>
        /*滚动条宽度*/
        ::-webkit-scrollbar {
            width: 3px;
        }
        /* 轨道样式 */
        ::-webkit-scrollbar-track {
        }
        /* Handle样式 */
        ::-webkit-scrollbar-thumb {
            border-radius: 10px;
            background: rgba(0,0,0,0.2);
        }
        /*当前窗口未激活的情况下*/
        ::-webkit-scrollbar-thumb:window-inactive {
            background: rgba(0,0,0,0.1);
        }
        /*hover到滚动条上*/
        ::-webkit-scrollbar-thumb:vertical:hover{
            background-color: rgba(0,0,0,0.3);
        }
        /*滚动条按下*/
        ::-webkit-scrollbar-thumb:vertical:active{
            background-color: rgba(0,0,0,0.7);
        }
        body{
            /*min-height: 750px;*/
            /*font-size: 10px;*/
        }
        .container{
            width:100%;
        }
        .form-horizontal .has-feedback .form-control-feedback{
            pointer-events: auto;
            color:white;
            right:0px;
            padding-top: inherit;
        }
        .sidebarTabel tr td {
            text-align: center;
        }
        .sidebarTabel tr td  a{
            color:#f0ad4e;
        }
        .sidebarTabel tr td  a:hover{
            color:#8a6d3b;
        }
        .sibartr{
            background-color: #337ab7!important;
            color: white;
        }
        .textOverflow{
            height:50px;
            overflow:hidden;
            white-space:nowrap;
            text-overflow:ellipsis;
            padding: 2px;
            line-height: 50px;
            vertical-align: middle!important;
        }
        /*后面写的*/
        .table td{
             border: 1px solid #ddd;
             text-align:center;
        }
        .table td input{
            width:100%;
            border: none;
        }
    </style>
<link href="${prc }/common/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css"></head>
<body>
<div>
    <form id="form" class="form-horizontal" role="form" action="${prc}/mOfferList/saveHeader" method="post" onsubmit="return validateForm()">
         <input type="hidden" name="offerListHeader.offerListId" value="${offerListHeader.offerListId}">
         <input type="hidden" name="offerListHeader.fid" value="${offerListHeader.fid}">
         <input type="hidden" name="client.fid" value="${client.fid}">
         <input type="hidden" name="offerList.fid" value="${offerList.fid}">
        <table class="table" style="align:center">
                                <tr>
							  		<td rowspan="3">
							  			<img style="width:100px;height:50px;border:1px solid red" src="${filepath}${company.logo}"/>
										<input type="hidden" name="company.logo" value="${company.logo}"/>
									</td>
							  		<td width="50%" colspan="3" >
										<span name="company.name">
											<b>
												${company.name}
												<input type="hidden" name="company.name" value="${company.name}"/>
											</b>
										</span>
									</td>
							  		<td width="30%" colspan="2" style="text-align: left;"><b>订货单INDENG</b></td>
							  	</tr>
							  	<tr>
									<td width="50%" colspan="3" style="padding:0px">
										<span name="company.englishName">
											<font size='1'>
											<b>
												${company.englishName}
												<input type="hidden" name="company.englishName" value="${company.englishName}"/>
											</b>
											</font>
										</span>
									</td>
							  		<td width="30%" colspan="2" rowspan="2" style="padding:0px">
                                        <input type="text" class="padding-t-8 padding-b-8" name="offerList.num" value="${offerList.num}" required oninvalid="setCustomValidity('必须填写！');" oninput="setCustomValidity('');"/>
							  		</td>
							  	</tr>
							  	<tr>
							  		<td width="50%" colspan="3" style="padding:0px">
										<input type="hidden" name="company.phone1" value="${company.phone1}"/>
										<input type="hidden" name="company.phone2" value="${company.phone2}"/>
										<input type="hidden" name="company.faxAddress" value="${company.faxAddress}"/>
                                        <font size='1'><b><span>Tel:&nbsp;${company.phone1}&nbsp;${company.phone2}&nbsp;
                                            Fax:&nbsp;${company.faxAddress}</span>
                                        </b></font>
                                    </td>
							  		
							  	</tr>
							  	<!---->
							  	<tr>
							  		<td width="15%">购货单位：</td>
							  		<td width="35%">
                                        <input name="client.buyUnit" type="text" value="${client.buyUnit}"/>
							  		</td>
							  		<td width="10%">电话：</td>
							  		<td width="35%" colspan="3">
                                        <input name="client.contactPhone" type="number" value="${client.contactPhone}"  required oninvalid="setCustomValidity('必须填写！');" oninput="setCustomValidity('');"/>
							  		</td>
							  	</tr>
							  	<tr>
							  		<td width="15%">联系人：</td>
							  		<td width="35%">
                                        <input name="client.contact" type="text" value="${client.contact}"  required oninvalid="setCustomValidity('必须填写！');" oninput="setCustomValidity('');"/>
							  		</td>
							  		<td width="10%">传真：</td>
							  		<td width="35%" colspan="3">
                                        <input name="client.fax" type="number" value="${client.fax}"  required oninvalid="setCustomValidity('必须填写！');" oninput="setCustomValidity('');"/>
							  		</td>							  		
							  	</tr>
							  	<tr>
							  		<td width="15%">交货地址：</td>
							  		<td width="35%">
                                        <input name="client.address" type="text" value="${client.address}"  required oninvalid="setCustomValidity('必须填写！');" oninput="setCustomValidity('');"/>
							  		</td>
							  		<td width="15%">币种：</td>
							  		<td width="35%" colspan="3"><input type="text" name="offerListHeader.currency" value="${offerListHeader.currency}"  required oninvalid="setCustomValidity('必须填写！');" oninput="setCustomValidity('');"/></td>
							  	
							  		</td>
							  	</tr>
                </table>
        <!-- 顶部有保存按钮  点击顶部保存按钮 查找显示的面板 找到对应的表单节点，触发这个节点的提交按钮-->
        <!-- <button type="submit" class="btn btn-default">保存</button> -->
    </form>
</div>

<jsp:include page="../common/footer_js.jsp" />
<script src="${prc }/common/js/json2.js"></script>
<script src="${prc }/common/My97DatePicker/WdatePicker.js"></script>

<script>
    function validateForm(){
        /*var str = $('input[name="offerListHeader.orderDate"]').val();
        var str2 = $('input[name="offerListHeader.deliveryDate"]').val();
        var orderDate = new Date(str.replace(/-/g,   "/"));
        var deliveryDate = new Date(str2.replace(/-/g,   "/"));
        if("" ==str){
            alert("请选择订货日期");
            return false;
        }
        if("" ==str2){
            alert("请选择交货日期");
            return false;
        }
        if("" !=str && "" !=str2 && orderDate >= deliveryDate){
            alert("订货日期 不能大于等于 交货日期");
            return false;
        }*/
        //校验手机号/固话
        var tel = $('input[name="client.contactPhone"]').val();
        if(!validatePhone(tel)){
            alert("电话号码不符合要求.");
            return false;
        }
        return true;
    }
    
</script>


</body></html>