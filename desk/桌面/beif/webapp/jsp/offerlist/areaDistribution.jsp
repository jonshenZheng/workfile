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
	<%--   <link rel="stylesheet" href="${prc }/common/css/font-awesome.min.css"/>
      <link rel="stylesheet" href="${prc }/common/css/build.css"/> --%>
	<title>区域</title>
	<style type="text/css">
		#sort .ui-sortable-helper td{
			display:block;
		}

		.lock-icon{
			text-align:center;
			vertical-align:middle;
		}
		.lock-icon.active i{
			background:url('${prc}/common/img/offetlist/offer-lock-on.png');
		}

		.lock-icon i{
			display:inline-block;
			vertical-align:middle;
			width:16px;
			height:25px;
			background:url('${prc}/common/img/offetlist/offer-lock-off.png');
		}

		.lock-icon span{
			display:inline-block;
			vertical-align:middle;
			font-size:12px;
			color:#3c82c2;
		}

		.lock-icon.active:hover i{
			background:url('${prc}/common/img/offetlist/offer-lock-on-hover.png');
		}

		.lock-icon:hover i{
			background:url('${prc}/common/img/offetlist/offer-lock-off-hover.png');
		}

		.lock-icon:hover span{
			color:#fff;
		}

		.sidebarTabel{
			table-layout:auto !important;
		}

	</style>

</head>
<body style="background-color: transparent" class="offerFurList-page">
<form class="form-horizontal" role="form" action="" method="post" id="areaForm">
	<input type="hidden" name="areaName" id="areaName">
	<input type="hidden" name="offerId" id="offerId">
	<input type="hidden" name="functionArea" id="functionArea">
	<div class="addAreaBox" style="height:500px">
		<table id="sort" class="table table-hover table-bordered table-striped sidebarTabel" style="border-collapse: collapse;cellspacing:0">
			<tbody>
			<c:forEach items="${areas}" var="area" varStatus="status">
				<tr class="sortTR" id="area${status.index}" data-aid="${area.fid }" trSelectStyle="${area.fid}"><td colspan="2" name="area" areaid="${area.fid}" onclick="toSelectSaleProd('${area.fid}')">${area.areaName }</td></tr>
			</c:forEach>
			<!--  <tr id="add"><td id="addArea" onclick="addArea()" align="center"><i class="add-ico"></i></td></tr>-->
			</tbody>
			<tfoot>
			<tr id="add">
				<td style="width:33.333%" class="lock-icon active" id="lock-icon">
					<i></i><span>拖拽可排序</span>
				</td>
				<td style="width:66.666%" id="addArea"  class="addAreaBtn" onclick="addArea()" align="center"><i class="add-ico"></i><span>添加区域</span></td>
			</tr>
			</tfoot>
		</table>
	</div>
</form>

<%-- <form class="form-horizontal" role="form" action="" method="post" id="areaForm">
    <input type="hidden" name="areaName" id="areaName">
    <input type="hidden" name="offerId" id="offerId">
    <input type="hidden" name="functionArea" id="functionArea">
    <table class="table table-hover table-bordered table-striped sidebarTabel" >
    <c:forEach items="${areas}" var="area" varStatus="status">
        <tr id="area${status.index}" trSelectStyle="${area.fid}"><td name="area" areaid="${area.fid}" onclick="toSelectSaleProd('${area.fid}')">${area.areaName }</td></tr>
    </c:forEach>
        <tr id="add" ><td id="addArea" onclick="addArea()" align="center"><B> + </B></td></tr>
    </table>
    <div style="margin-top: -13px;padding-bottom: 17px;">
        区域合计：<span id="allAreaCost"></span> 元
    </div>
</form> --%>

</body>



<script src="${prc }/common/js/jquery-ui.min.js"></script>
<script>

    var $sortLockText = $('#lock-icon span');

    $('#lock-icon').click(function(){

        var $el = $(this),
            isDontMove = false;

        if($el.hasClass('active')){
            $el.removeClass('active');
            isDontMove = false;
            $sortLockText.text('排序已锁定');
        }
        else{
            $el.addClass('active');
            isDontMove = true;
            $sortLockText.text('拖拽可排序');
        }

        MoveTabelTr(isDontMove);

    });


    var areaId = '${areaDistributionFid}';

    function selectProdcall(areaId){
        addTrStyle(areaId);
        parent.selectSaleProd(areaId);
    }

    function toSelectSaleProd(areaId){
        //添加选中样式
        var bool = exitremoveStyle();
        if(bool){
            $(window.parent.$("#saleProdFrame"))[0].contentWindow.saveSaleProd();
        }
        window.setTimeout("selectProdcall('"+areaId+"');",200);
    }

    //移除样式/判断是否存在样式
    function exitremoveStyle(){
        var bool = false;
        $(".sidebarTabel").find('tr').each(function(){
            if($(this).hasClass("sibartr")){
                $(this).removeClass("sibartr");
                bool = true;
            }
        });
        return bool;
    }
    //添加选中样式
    function addTrStyle(areaId){
        exitremoveStyle();
        $('.sidebarTabel tr[trSelectStyle="'+areaId+'"]').addClass("sibartr");
    }

    function addArea(){
        var saleProdFrame_jsEl = $(window.parent.$("#saleProdFrame"))[0],
            saleProdFrame_src = saleProdFrame_jsEl.src;
        if(areaId){
            saleProdFrame_jsEl.contentWindow.saveSaleProd();
        }
        parent.addAreaContent();
    }

    function saveArea(area){
        $("#areaName").val(area.areaName);
        $("#offerId").val(area.offerId);
        $("#functionArea").val(area.functionArea);

        $("#areaForm").attr("action","${prc}/offerList/saveArea");

        $("#areaForm").submit();
    }

    /**
     *Description:复制区域
     *Author: lixinhui 2018/3/28
     */
    function copyArea(currentAreaId){
        window.location.href = "${prc}/area/copy/"+currentAreaId;
    }

    //删除区域
    function deleteArea(areaId,offerId){
        var isDelete=confirm("确定要删除该区域吗？");
        if(isDelete){
            window.location.href = "${prc}/offerList/deleteArea?areaId="+areaId+"&offerId="+offerId;
        }
    }

    window.onload = function(){
        if(areaId != ''){
            toSelectSaleProd(areaId);
            return;
        }

        if($('#areaForm tr').length > 1){
            $("td:first").click();
        }
        else{
            $(window.parent.document.getElementById('saleProdFrame')).attr("src","${prc}/offerList/areaNullTips");
        }

    };

    var $sortTable = $('#sort'),
        $sortTabel =  $("#sort tbody:eq(0)");

    $(document).ready(function(){
        var fixHelperModified = function(e, tr) {

                $sortTable[0].style.tableLayout='auto';
                var $originals = tr.children(".sortTR");
                var $helper = tr.clone();
                $helper.children().each(function(index) {
                    //var wid = tr.parents('.furTable').width();
                    //$(this).width(wid);
                });
                return $helper;
            },
            updateIndex = function(e, ui) {

                var areaId = [];
                $('#sort .sortTR').each(function (i) {
                    areaId.push($(this).data('aid'));
                });

                $.ajax({
                    url :  '${prc}/offerList/area/sort',
                    method : 'POST',
                    contentType: "application/json; charset=utf-8",
                    data : JSON.stringify(areaId),
                    success : function(r){

                        if(r.meta && r.meta.code !== 200){
                            alert(r.meta.msg);
                            window.location.reload();
                        }

                    },
                    error : function(){
                        alert('排序操作失败');
                        window.location.reload();
                    }
                });

            };

        $sortTabel.sortable({
            helper: fixHelperModified,
            stop: updateIndex,
            beforeStop: function( event, ui ) {$sortTable[0].style.tableLayout='fixed';$sortTable[0].width='100%';}
        }).disableSelection();


        /* $("#sort tbody:eq(0)").on('mousedown',function(){
            $('.furTable input[type="text"]').blur();
        }); */


    });


    function MoveTabelTr(isMove){

        if(isMove){
            $sortTabel.sortable({
                disabled: false
            });
        }
        else{
            $sortTabel.sortable({
                disabled: true
            });
        }
    }


</script>

</html>