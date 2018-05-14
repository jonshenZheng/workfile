<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="prc" value="${pageContext.request.contextPath}"/>
<%
	String ossOuterPath = application.getInitParameter("ossOuterPath");
%>
<c:set var="filepath" value="<%=ossOuterPath%>"/>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>index</title>
	<jsp:include page="../common/head_css.jsp"/>
	<%-- <link rel="stylesheet" href="${prc }/common/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="${prc }/common/css/build.css"/> --%>

</head>
<body style="background-color:#f0f2f8;min-height:0">

<div class="margin-20 bg-white offerheader-page">
	<form id="form" class="form-horizontal" role="form" action="${prc}/offerList/saveHeader" method="post" onsubmit="return validateForm()">
		<input type="hidden" name="offerListHeader.offerListId" value="${offerListHeader.offerListId}">
		<input type="hidden" name="offerListHeader.fid" value="${offerListHeader.fid}">
		<input type="hidden" name="client.fid" value="${client.fid}">
		<input type="hidden" name="offerList.fid" value="${offerList.fid}">
		<table class="table table-bordered" style="border-collapse: collapse;cellspacing:0">
			<tbody>
			<tr>
				<td rowspan="3">
					<img style="width:100px;height:50px;border:1px solid red" src="${filepath}${company.logo}"/>
					<input type="hidden" name="company.logo" value="${company.logo}"/>
				</td>
				<td width="50%" colspan="3">
	                      <span name="company.name">
	                          <b class="fontSz-14">${company.name}<input type="hidden" name="company.name" value="${company.name}"/></b>
	                      </span>
				</td>
				<td width="30%" colspan="2"><b>订货单INDENG</b></td>
			</tr>
			<tr>
				<td width="50%" colspan="3">
	                  <span name="company.englishName">
	                      <font size="1"><b class="fontSz-14">${company.englishName}<input type="hidden" name="company.englishName" value="${company.englishName}"/></b></font>
	                  </span>
				</td>
				<td width="30%" colspan="2" rowspan="2">
					<input type="text" name="offerList.num" value="${offerList.num}"  style="padding:19px 8px"/>
				</td>
			</tr>
			<tr>
				<td width="50%" colspan="3">
					<input type="hidden" name="company.phone1" value="${company.phone1}"/>
					<input type="hidden" name="company.phone2" value="${company.phone2}"/>
					<input type="hidden" name="company.faxAddress" value="${company.faxAddress}"/>
					<font size='1'><b class="fontSz-14"><span>Tel:&nbsp;${company.phone1}&nbsp;${company.phone2}&nbsp;
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
				<td width="15%">
					<input name="client.contactPhone" type="text" value="${client.contactPhone}" />
				<td width="10%">联系人：</td>
				<td width="15%">
					<input name="client.contact" type="text" value="${client.contact}"  />
				</td>
			</tr>
			<tr>
				<td width="10%">传真：</td>
				<td width="35%">
					<input name="client.fax" type="text" value="${client.fax}" />
				</td>
				<td width="10%">交货地址：</td>
				<td width="15%">
					<input name="client.address" type="text" value="${client.address}"/>
				</td>
				<td width="10%">币种：</td>
				<td width="15%" colspan="3"><input type="text" name="offerListHeader.currency" value="${offerListHeader.currency}" />
				</td>
			</tr>
			</tbody>
		</table>
	</form>
</div>
<!-- <div class="handle-btn-box textAli-r padding-r-20">
    <a class="btns btns-defualt" id="offerHeadSave" >保存</a>
    <a class="btns btns-defualt">预览</a>
    <a class="btns btns-defualt" id="headexportBtn">导出</a>
    <a class="btns btns-defualt" id="headeSendEmial">发到邮箱</a>
</div> -->


<!-- <button type="submit" class="btn btn-default">保存</button> -->


<jsp:include page="../common/footer_js.jsp" />
<script src="${prc }/common/js/json2.js"></script>
<script src="${prc }/common/My97DatePicker/WdatePicker.js"></script>
<c:if test="${status eq 'success'}">
	<script>
        if(window.parent.headerSaveFromTisHandle && !window.parent.isHeaderSubimit){
            alert("保存成功.");
        }
	</script>
</c:if>
<script>

    var reloadthisPage = false;

    /* 底下操作按钮 */
    var $headsaveBtn = $('#offerHeadSave'),
        $headexportBtn = $('#headexportBtn'),
        $headeSendEmial = $('#headeSendEmial'),
        furListIframe_el = window.parent.document.getElementById('saleProdFrame'),
        $offerHeadForm = $('#form');
    /*保存*/
    $headsaveBtn.on('click',function(){
        $offerHeadForm.submit();
    });
    /*导出*/
    $headexportBtn.on('click',function(){
        furListIframe_el.contentWindow.exportExcel();
    });
    /* 发送邮箱 */
    $headeSendEmial.on('click',function(){
        furListIframe_el.contentWindow.validateBeforeSendEmail();
    });


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
        if(tel == ''){
            /*if(window.parent.headerSaveFromTisHandle){
                alert('电话号码不能为空');
            }
            return false;*/
        }
        else if(!validatePhone(tel)){
            if(window.parent.headerSaveFromTisHandle){
                alert("电话号码不符合要求.");
            }
            return false;
        }

        reloadthisPage = true;

        return true;
    }

    /* function validateFormFn(){
    	var val = validateForm();
    	window.parent.headerSaveFromTisHandle = true;
    	if(val){
    		window.parent.isHeaderSubimit = true;
    	}
    	return val;
    } */


    var $thisform = $('#form');

    function formSubmitFn(){

        $thisform.submit();

        window.parent.headerSaveFromTisHandle = true;
        if(reloadthisPage){
            window.parent.isHeaderSubimit = true;
        }
    }

    window.parent.isHeaderSubimit = false;

</script>
</body>
</html>
