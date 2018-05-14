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
    <%-- <link rel="stylesheet" href="${prc }/common/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="${prc }/common/css/build.css"/> --%>

</head>
<body style="background-color:#f0f2f8;min-height:0"">

<div class="margin-20 bg-white offerend-page">
    <form id="tailform" class="form-horizontal" role="form" action="${prc}/offerList/saveListEnd" method="POST" onsubmit="return validateForm()">
        <input type="hidden" name="offerListEnd.fid"  value="${offerListEnd.fid}">
        <input type="hidden" name="offerListEnd.offerId" id="offerId" value="${offerListFid}">
        <table class="table table-bordered" style="border-collapse: collapse;cellspacing:0">
            <tbody>
            <tr>
                <td class="table-title textHidden">付款方式：</td>
                <td width="80%" colspan="3">
                    <input type="text" name="offerListEnd.payment" value="${offerListEnd.payment}"/>
                </td>
            </tr>
            <tr>
                <td class="table-title textHidden">报价有效日期：</td>
                <td width="80%" colspan="3">
                    <input type="text" name="offerListEnd.expiryDate" onClick="WdatePicker({isShowClear:false,readOnly:true})" value="<fmt:formatDate type='date' value='${offerListEnd.expiryDate}' />"/>
                </td>
            </tr>
            <tr>
                <td class="table-title textHidden">保修日期：</td>
                <td width="80%" colspan="3">
                    <input type="text" name="offerListEnd.maintenancePeriod" onClick="WdatePicker({isShowClear:false,readOnly:true})" value="<fmt:formatDate type='date' value='${offerListEnd.maintenancePeriod}' />"/>
                </td>
            </tr>
            <tr>
                <td class="table-title textHidden" id="tableattention" style="vertical-align: middle;">注意事项：</td>
                <td width="80%" colspan="3" style="text-align: left;">
                    <table class="remaks" width="100%" id="remarks">
                        <c:forEach items="${offerListEnd.remarks}" var="remak" varStatus="remakInd">
                            <tr>
                                <td width="2%" style="text-align: left;">${remakInd.index+1}</td>
                                <td width="98%">
                                    <input type='text' remarkId="${remak.fid}" name="offerListEnd.remarks[${remakInd.index}].remark" value="${remak.remark}" style="width: 98%;"/>
                                    <input type="hidden" name="offerListEnd.remarks[${remakInd.index}].fid" value="${remak.fid}"/>
                                    <a href="javascript:void(0)" onclick="deleteRemark(this);" title="删除备注"><span class="glyphicon glyphicon-remove-sign"></span></a>
                                </td>
                            </tr>
                        </c:forEach>
                        <tr id="addRemak">
                            <td width="100%" style="text-align: left;" colspan="2">
                                <a href="javascript:addRemak();" class="add">
                                    添加备注事项
                                </a>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="textHidden all-tile" colspan="4">账户信息</td>
            </tr>
            <tr>
                <td class="table-title textHidden">账户名称：</td>
                <td width="30%">
                    <input type="text" name="offerListEnd.accountName" value="${offerListEnd.accountName}" />
                </td>
                <td class="table-title textHidden">开户银行：</td>
                <td width="30%">
                    <input type="text" name="offerListEnd.bank" value="${offerListEnd.bank}" />
                </td>
            </tr>
            <tr>
                <td class="table-title textHidden">汇入账户：</td>
                <td width="30%">
                    <input type="text" name="offerListEnd.accountNo" value="${offerListEnd.accountNo}" />
                </td>
                <td class="table-title textHidden">订货日期：</td>
                <td width="30%">
                    <input name="offerListEnd.orderDate" type="text" onClick="WdatePicker({isShowClear:false,readOnly:true})" value="<fmt:formatDate type="date" value="${offerListEnd.orderDate}" />"/>
                </td>
            </tr>
            <tr>
                <td class="textHidden all-tile" colspan="4">&nbsp;</td>
            </tr>
            <tr>
                <td class="table-title textHidden">交货日期：</td>
                <td width="30%">
                    <input name="offerListEnd.sellDate" type="text" onClick="WdatePicker({isShowClear:false,readOnly:true})" value="<fmt:formatDate type="date" value="${offerListEnd.sellDate}" />" />
                </td>
                <td class="table-title textHidden">经手人：</td>
                <td width="30%">
                    <input type="text" name="offerListEnd.client" value="${offerListEnd.client}">
                    <input type="hidden" placeholder="姓名" name="offerListEnd.sales" value="${offerListEnd.sales}"/>
                    <input type="hidden" name="offerListEnd.buyUnit"  value="${offerListEnd.buyUnit}" />
                    <input type="hidden" name="offerListEnd.sellUnit" value="${offerListEnd.sellUnit}" />
                    <input type="hidden" placeholder="手机号" name="offerListEnd.salesPhone" value="${offerListEnd.salesPhone}"/>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
<!-- <div class="handle-btn-box textAli-r padding-r-20">
    <a class="btns btns-defualt" id="offerEndSave">保存</a>
    <a class="btns btns-defualt">预览</a>
    <a class="btns btns-defualt" id="offerEndexportBtn">导出</a>
    <a class="btns btns-defualt" id="offerEndSendEmial">发到邮箱</a>
</div> -->

<!-- <button type="submit" class="btn btn-default">保存</button> -->


<jsp:include page="../common/footer_js.jsp" />
<script src="${prc }/common/js/json2.js"></script>
<script src="${prc }/common/My97DatePicker/WdatePicker.js"></script>
<c:if test="${status eq 'success'}">
    <script>
        if(window.parent.tailsaveFromTisHandle && !window.parent.istailSubimit){
            alert("保存成功.");
        }
    </script>
</c:if>
<script>

    var reloadthisForm = false;

    /* 底下操作按钮 */
    var $offerEndSave = $('#offerEndSave'),
        $offerEndexportBtn = $('#offerEndexportBtn'),
        $offerEndSendEmial = $('#offerEndSendEmial'),
        furListIframe_el = window.parent.document.getElementById('saleProdFrame'),
        $offerEndForm = $('#tailform');
    /*保存*/
    $offerEndSave.on('click',function(){
        $offerEndForm.submit();
    });
    /*导出*/
    $offerEndexportBtn.on('click',function(){
        furListIframe_el.contentWindow.exportExcel();
    });
    /* 发送邮箱 */
    $offerEndSendEmial.on('click',function(){
        furListIframe_el.contentWindow.validateBeforeSendEmail();
    });


    function validateForm(){
        var str = $('input[name="offerListEnd.orderDate"]').val();
        var str2 = $('input[name="offerListEnd.sellDate"]').val();
        var orderDate = new Date(str.replace(/-/g,   "/"));
        var deliveryDate = new Date(str2.replace(/-/g,   "/"));
        /*if("" ==str){
        	if(window.parent.tailsaveFromTisHandle){
        		alert("请选择订货日期");
        	}
            return false;
        }
        if("" ==str2){
        	if(window.parent.tailsaveFromTisHandle){
        		alert("请选择交货日期");
        	}

            return false;
        }*/
        if("" !=str && "" !=str2 && orderDate >= deliveryDate){
            if(window.parent.tailsaveFromTisHandle){
                alert("订货日期 不能大于等于 交货日期");
            }
            return false;
        }
        reloadthisForm = true;
        return true;
    }

    //添加备注
    function addRemak(){
        var trlen = $(".remaks").find("tr").length -1;
        var $tr = $('<tr></tr>');
        var $tdleft = $('<td width="2%" style="text-align: left;"></td>');
        var $tdrigth = $('<td width="98%"></td>');
        var delePic = '<a href="javascript:void(0)" onclick="deleteRemark(this);" title="删除备注"><span class="glyphicon glyphicon-remove-sign"></span></a>	';
        var remarkInfo = "<input type='text' style='width: 98%;' name='offerListEnd.remarks["+trlen+"].remark' value=''/>";
        var remarkId = "<input type='hidden' name='offerListEnd.remarks["+trlen+"].fid' value=''/>";

        $tdleft.append(""+(trlen+1)+"</td>");
        $tdrigth.append(remarkInfo+remarkId+delePic);

        $tr.append($tdleft);
        $tr.append($tdrigth);

        $("#addRemak").before($tr);
    }

    //删除备注
    function deleteRemark(obj){
        var remarkId = $(obj.parentElement).find('input').attr("remarkId");
        var remarkVal = $(obj.parentElement).find('input').val();

        //移除该条备注
        $(obj).parent().parent().remove();

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
        var trlen = $("#remarks tr").length-1;
        var num = 1;
        $("#remarks").find("tr").each(function(){
            if(num > trlen) return;
            var tdArr = $(this).children();
            tdArr.eq(0).html(num);
            num++;
        });
    }


    var $thisform = $('#tailform');

    function formSubmitFn(){

        $thisform.submit();

        window.parent.tailsaveFromTisHandle = true;
        if(reloadthisForm){
            window.parent.istailSubimit = true;
        }
    }

    window.parent.istailSubimit = false;

</script>
</body>
</html>
