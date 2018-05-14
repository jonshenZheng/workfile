<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="prc" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="../common/head_css.jsp"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>index</title>
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
        
        
        /* 添加的样式 */
        body{background-color: #f2f2f2;}
        ul{list-style: none;padding:0;margin:0;}
        .table td input {
            width: 100%;
            border: none;
        }
        #tailform table{background-color: #fff;}
        #tailform table td{height:24px;padding:7px 8px 7px 15px;border:1px solid #ddd;}
        .RemarksList li{line-height: 37px;height:37px;padding-left: 15px;position:relative;}
        .RemarksList li + li{border-top: 1px solid #ddd;}
        .RemarksList li input{width:70%;margin-left: 5px;height:20px;}
        .RemarksList span, .RemarksList input{display:inline-block;vertical-align: middle;}
        .RemarksList .remove-btn{position:absolute;top:50%;right:10px;width:30px;height:30px;margin-top: -15px;text-align: center;line-height: 30px;}

        #tailform .nameInfo li{float:left;width:65%;}
        #tailform .nameInfo li:first-child{width:35%;border-right: 1px solid #ddd;}
        #tailform .nameInfo input{height:21px;padding:8px 0;text-align: center;box-sizing: content-box;}
        .addRemakUl{height:auto !important;line-height:normal !important;border:0 none;padding-left:0 !important}
        .addRemakUl li{line-height: 37px !important;height:37px !important;border-bottom:1px solid #ddd}
        .addRemakUl li + li{border-top:0 !important}
        #tailform .noBorder{border: 0 none !important}
    </style>
<link href="${prc }/common/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css"></head>
<body>
<div>

    <form id="tailform" class="form-horizontal" role="form" method="post" action="${prc}/mOfferList/saveListEnd">
        <input type="hidden" name="offerListEnd.fid"  value="${offerListEnd.fid}">
		<input type="hidden" name="offerListEnd.offerId" id="offerId" value="${offerListFid}">
        <table class="table" cellspacing="0" cellpadding="0">
            <tbody>
                <tr>
                    <td width="20%">付款方式：</td>
                    <td width="80%" colspan="4">
                        <input type="text" name="offerListEnd.payment" value="${offerListEnd.payment}">
                    </td>
                </tr>
                <tr>
                    <td width="20%">报价有效日期：</td>
                    <td width="80%" colspan="4">
                        <input type="text" readonly name="offerListEnd.expiryDate" onclick="WdatePicker()" value="<fmt:formatDate type='date' value='${offerListEnd.expiryDate}' />" >
                    </td>
                </tr>
                <tr>
                    <td width="20%">保修日期：</td>
                    <td width="80%" colspan="4">
                        <input type="text" readonly name="offerListEnd.maintenancePeriod" onclick="WdatePicker()" value="<fmt:formatDate type='date' value='${offerListEnd.maintenancePeriod}' />" >
                    </td>
                </tr>
                <tr>
                
                    <td width="20%" id="tableattention" style="vertical-align: middle;">注意事项：</td>
                    <td width="80%" colspan="4" style="text-align: left;padding:0">
                        <ul class="RemarksList">
                        	<c:forEach items="${offerListEnd.remarks}" var="remak" varStatus="remakInd">
                        		<li>
                        			<span class="remarckInd">${remakInd.index+1}.</span>
                        			<input type="text" remarkId="${remak.fid}" name="offerListEnd.remarks[${remakInd.index}].remark" value="${remak.remark}"/>
                        			<input type="hidden" name="offerListEnd.remarks[${remakInd.index}].fid" value="${remak.fid}"/>
                        			<span class="remove-btn" ontouchstart="deleteRemark(this);" title="删除备注"><i class="glyphicon glyphicon-remove-sign"></i></span>
                        		</li>                      	
                        	</c:forEach>                        	
                            <li class="addRemakUl">
                            	<ul id="addRemak"></ul>
                            </li>
                            <li class="noBorder"><a class="addList" id="addList">添加备注事项</a></li>
                        </ul>
                    </td>
                </tr>
            </tbody>
        </table>
        <p><span style="color:#999;font-size:13px">账户信息</span></p>
        <table class="table" cellspacing="0" cellpadding="0">
            <tbody>
                <tr>
                   <td width="20%">账户名称：</td>
                   <td width="30%"><input type="text" name="offerListEnd.accountName" value="${offerListEnd.accountName}"></td>
                   <td width="20%">开户银行：</td>
                   <td width="30%"><input type="text" name="offerListEnd.bank" value="${offerListEnd.bank}"></td>
               </tr>
               <tr>
                   <td width="20%">汇入账户：</td>
                   <td width="30%"><input type="text" name="offerListEnd.accountNo" value="${offerListEnd.accountNo}" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"></td>
                   <td width="20%">订货日期：</td>
                   <td width="30%"><input type="text" readonly name="offerListEnd.orderDate" type="text" onClick="WdatePicker()" value="<fmt:formatDate type="date" value="${offerListEnd.orderDate}" />"/></td>
               </tr>   
               <tr>
                   <td width="20%">交货日期：</td>
                   <td width="30%"><input name="offerListEnd.sellDate" readonly type="text" onClick="WdatePicker()" value="<fmt:formatDate type="date" value="${offerListEnd.sellDate}" />" /></td>
                   <td width="20%">经手人：</td>
                   <td width="30%"><input type="text" name="offerListEnd.client" value="${offerListEnd.client}" /></td>
               </tr>        
            </tbody>
        </table>
        <!--<table class="table" cellspacing="0" cellpadding="0">
            <tbody>
                <tr>
                   <td width="20%">购货单位(签章)：</td>
                   <td width="30%"><input type="text" name="" value=""></td>
                   <td width="20%">供货单位(签章)：</td>
                   <td width="30%"><input type="text" name="" value=""></td>
               </tr>
               <tr>
                   <td width="20%">经手人：</td>
                   <td width="30%"><input type="text" name="" value=""></td>
                   <td width="20%">经手人：</td>
                   <td width="30%" style="padding:0">
                       <ul class="nameInfo clearfix">
                           <li><input type="text" placeholder="姓名"/></li>
                           <li><input type="text" placeholder="电话"/></li>
                       </ul>
                   </td>
               </tr> 
               <tr>
                   <td width="20%">日期：</td>
                   <td width="30%"><input type="text" name="" value=""></td>
                   <td width="20%">日期：</td>
                   <td width="30%"><input type="text" name="" value=""></td>
               </tr>
            </tbody>
        </table>-->
    </form>
</div>

<jsp:include page="../common/footer_js.jsp" />
<script src="${prc }/common/js/json2.js"></script>
<script src="${prc }/common/My97DatePicker/WdatePicker.js"></script>

<script>

	function saveOfferEnd(){
		var token = validateForm();
		if(!token){
			return false;
		}
		var opt = {};
		opt.btnName = ['关闭'];
		opt.til = '提示';
		opt.tpls = '<div class="textAli-c">保存成功</div>';
		opt.btnNum = 1;
		window.top.runHomePublicPop(opt);
		$('#tailform').submit();
	}

	function validateForm(){
	    var str = $('input[name="offerListEnd.orderDate"]').val();
	    var str2 = $('input[name="offerListEnd.sellDate"]').val();
	    var orderDate = new Date(str.replace(/-/g,   "/"));
	    var deliveryDate = new Date(str2.replace(/-/g,   "/"));
	    
	    var opt = {};
			
		opt.til = '提示';
		opt.btnNum = 1;
	    
	    if("" ==str){
	    	opt.tpls = '<div style="max-height:80px;overflow:aotu">请选择订货日期</div>';
	    	window.top.runHomePublicPop(opt);
	        return false;
	    }
	    if("" ==str2){
	    	opt.tpls = '<div style="max-height:80px;overflow:aotu">请选择交货日期</div>';
	    	window.top.runHomePublicPop(opt);
	        return false;
	    }
	    if("" !=str && "" !=str2 && orderDate >= deliveryDate){
	    	opt.tpls = '<div style="max-height:80px;overflow:aotu">订货日期 不能大于等于 交货日期</div>';
	    	window.top.runHomePublicPop(opt);
	        return false;
	    }
	    return true;
	}
	
    //添加备注
    var $addRemarkBox = $('#addRemak');
    function addRemak(){
       
        var el_str = '',
        	len = $('.RemarksList li').length - 2;
        	showInd = len + 1;
        
        el_str += '<li>';
        	el_str += '<span class="remarckInd">'+showInd+'.</span>';
            el_str += '<input type="text" name="offerListEnd.remarks['+len+'].remark"/>';
            el_str += '<input type="hidden" name="offerListEnd.remarks['+len+'].fid" />';
            el_str += '<span class="remove-btn" ontouchstart="deleteRemark(this);" title="删除备注"><i class="glyphicon glyphicon-remove-sign"></i></span>';
        el_str += '</li>';
          
        $addRemarkBox.append(el_str);

    }
 
    //删除备注
    function deleteRemark(obj){
        var remarkId = $(obj.parentElement).find('input').attr("remarkId");
        var remarkVal = $(obj.parentElement).find('input').val();
        
        //移除该条备注
        $(obj).parent('li').remove();
        
        if(null != remarkId && "" != remarkId){
            //库移除该条备注
            $.ajax({
                type: "GET",
                async:true,
                url:"${prc}/offerList/deleteRemark",
                data:{"remarkId":remarkId},
                success: function(result) {
                },
                error: function(err) {
                }
            });
        }
        //新排序
        sortRemark();
    }
    //备注序号重新排序
    function sortRemark(){
    	var $remarknum_el = $('.RemarksList .remarckInd'),
    		len = $remarknum_el.length;
    	
    	for(;len--;){
    		$remarknum_el.eq(len).html((len+1)+'.');
    	}
    }
    
    var $addRemark_a = $('#addList');
    
    $addRemark_a.on('touchstart',function(){
    	addRemak();
    });
    
</script>


</body>
</html>