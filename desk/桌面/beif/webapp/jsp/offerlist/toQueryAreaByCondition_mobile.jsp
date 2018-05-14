<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="prc" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="../common/head_css.jsp"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="${prc }/common/css/font-awesome.min.css">
	<link rel="stylesheet" href="${prc }/common/css/build.css">
	<jsp:include page="../common/footer_js.jsp" />
	<script src="${prc }/common/js/jquery.form.js"></script>
	<title>区域</title>
	<style>
		.sibartr{
			background-color: #337ab7!important;
			color: white;
		}
		.topSelectBox .selectProd{width:120px;}

		ul{padding:0;margin:0;list-style: none;}
		.topSelectBox .chooseBox{float:left;margin-left: 15px;padding-right: 20px;max-width: 200px;position:relative;}
		.topSelectBox .chooseTil{float:left;width:160px;margin:4px 0 0;border-bottom: 1px solid #ccc;}
		.topSelectBox .select-btn{position:relative;padding:0 25px 0 12px;height:32px;line-height: 32px;border-radius: 4px;border:1px solid #ccc;box-shadow: inset 0 1px 1px rgba(0,0,0,.075);display:block;}

		.topSelectBox .ico{position:absolute;width:16px;height:16px;background:url('${prc }/common/img/tri_down.png') no-repeat 2px 5px;top:50%;right:5px;margin-top: -8px;}
		.topSelectBox .downMune{display:none;}
		.topSelectBox .chooseBox.active .ico{background-image: url('${prc }/common/img/tri_up.png');}
		.topSelectBox .downMune{
			position: absolute;
			top: 100%;
			left: 0;
			z-index: 1000;
			display: none;
			float: left;
			min-width: 160px;
			padding: 5px 0;
			margin: 2px 0 0;
			list-style: none;
			background-color: #fff;
			border: 1px solid #ccc;
			border: 1px solid rgba(0,0,0,0.2);
			-webkit-border-radius: 6px;
			-moz-border-radius: 6px;
			border-radius: 6px;
			-webkit-box-shadow: 0 5px 10px rgba(0,0,0,0.2);
			-moz-box-shadow: 0 5px 10px rgba(0,0,0,0.2);
			box-shadow: 0 5px 10px rgba(0,0,0,0.2);
			-webkit-background-clip: padding-box;
			-moz-background-clip: padding;
			background-clip: padding-box;
			margin-top: 10px;
		}
		.topSelectBox .downMune:before {
			position: absolute;
			top: -7px;
			left: 35px;
			display: inline-block;
			border-right: 7px solid transparent;
			border-bottom: 7px solid #ccc;
			border-left: 7px solid transparent;
			border-bottom-color: rgba(0,0,0,0.2);
			content: '';
		}
		.topSelectBox .downMune:after {
			position: absolute;
			top: -6px;
			left: 36px;
			display: inline-block;
			border-right: 6px solid transparent;
			border-bottom: 6px solid #fff;
			border-left: 6px solid transparent;
			content: '';
		}
		.topSelectBox .downMune li{padding:6px 8px;}
		.topSelectBox .downMune li + li{border-top:1px solid #ccc;}
		.table-td-midle td{vertical-align: middle !important;}
		.table-td-midle select{padding: 6px 0; border-color: #ccc; border-radius: 4px;}

		.table-img-aotu td img{width:100%;display:block;height:auto;max-height: 50px;}
		.table-textArea-aotu td textarea{display:block;width:100%;}
		.table-select-aotu td select{display:block;width:100%;max-width: 85px;margin:0 auto;}
		.table-head-midle th{vertical-align: middle !important;}
		.topSelectBox .selectProdBtn{float: right; line-height: 34px; border-radius: 4px; padding: 0 10px; background-color: #337ab7; color: #fff; margin-left: 5px;text-decoration: none;}
		.topSelectBox .selectProdBtn:active{background-color: #2689de;}
	</style>
</head>
<body>
<div class="topSelectBox clearfix padding-t-12 padding-l-16 padding-r-16">
	<div class="fl">
		<!-- <form class="form-horizontal" action="${prc}/offerList/saveProdData" method="post" > -->
		<p class="chooseTil" >
			<input id="areaTil" name="areaId" data-oldName="" name="recommendderTemplID" onblur="updateAreaName();" onfocus="changeAreaName();" type="text" style="border:0 none;padding: 6px 5px 6px 2px;width:155px;line-height: normal;" />
			<input id="areaTil_hidden" type="hidden" name="fid" />
		</p>
		<!-- </form> -->
		<div class="chooseBox">
			<select class="form-control" id="selectArea">
				<c:forEach items="${areas}" var="area">
					<option value="${area.fid}">${area.areaName }</option>
				</c:forEach>
			</select>
		</div>

	</div>
	<a class="selectProdBtn" id="selectProdBtn">确定</a>
	<div class="fr selectProd">
		<select class="form-control" name="" id="recommendProd_selet">
			<c:forEach items="${recommendTempls}" var="type">
				<option value="${type.fid}">${type.name}</option>
			</c:forEach>
		</select>
	</div>
</div>

<!--<form class="form-horizontal" role="form" action="" method="post" id="areaForm">

    <input type="hidden" name="areaName" id="areaName">
    <input type="hidden" name="offerId" id="offerId">
    <input type="hidden" name="functionArea" id="functionArea">
     <table class="table table-hover table-bordered table-striped sidebarTabel">

        <tbody><tr id="area0" trselectstyle="NwrLJluzT5WxwKPvSDHrYg" class="sibartr"><td name="area" areaid="NwrLJluzT5WxwKPvSDHrYg" onclick="toSelectSaleProd('NwrLJluzT5WxwKPvSDHrYg')">zc</td></tr>

        <tr id="area1" trselectstyle="kCph0AyrTGW0jTvf1qKlug"><td name="area" areaid="kCph0AyrTGW0jTvf1qKlug" onclick="toSelectSaleProd('kCph0AyrTGW0jTvf1qKlug')">开发办公区</td></tr>

        <tr id="add"><td id="addArea" onclick="addArea()" align="center"><b> + </b></td></tr>
    </tbody></table>
    <div style="margin-top: -13px;padding-bottom: 17px;">
        区域合计：<span id="allAreaCost">￥7,885.00</span> 元
    </div> -->
</form>



<script>

    var hasRanderTuijian = false;

    /* 第一次加载 */

    var $areaTil = $('#areaTil'),
        $select_el = $('#selectArea'),
        $select_el_hide = $('#areaTil_hidden'),
        selectTxt,
        selectVal;

    selectTxt = $select_el.find("option:eq(0)").text();
    selectVal = $select_el.find("option:eq(0)").val();

    selectTxt = $select_el.find("option:eq(0)").text();
    selectVal = $select_el.find("option:eq(0)").val();
    function setArearName(){
        $areaTil.val(selectTxt);
        $select_el_hide.val(selectVal);
    }

    setArearName();
    window.parent.selectSaleProd(selectVal);


    /* 选择区域 */
    $select_el.on('change',function(){
        selectVal = $(this).find("option:selected").val();
        selectTxt = $(this).find("option:selected").text();

        setArearName();
        window.parent.selectSaleProd(selectVal);
    });

    var areaNametmp;
    //区域名称输入框获得光标事件
    function changeAreaName(){
        areaNametmp = $areaTil.val();
        //$areaTil.val("");
    }

    //重新修改区域名称
    function updateAreaName(){
        var areaName = $areaTil.val();
        if(!areaName){
            $areaTil.val(areaNametmp);
            return;
        }else if(areaName===areaNametmp){
            return;
        }

        //$('input[name="areaName"]').val(areaName);
        //该区域id
        var areaFid = $select_el_hide.val();

        var area = {"fid":areaFid,"areaName":areaName};
        window.parent.iframeUpdateAreaName(area,areaName,areaFid);
    }



    /* 选择推荐产品 */

    var $selectProdBtn = $('#selectProdBtn'),
        $recommendProd_selet = $('#recommendProd_selet');

    $selectProdBtn.on('touchstart',function(){
        var tjProdId = $recommendProd_selet.val(),
            areaId = $select_el_hide.val();

        $.ajax({
            type: "POST",
            url: "${prc}/mOfferList/suggestProd",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: {"areaId":areaId,"recommendderTemplID":tjProdId},
            success: function(msg){
                window.parent.reloadIframe('saleProdFrame');
            }
        });

    });



    var areaId = '';
    window.onload = function(){
        if(areaId != ''){
            toSelectSaleProd(areaId);
            return;
        }
        $("td:first").click();

    };

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
        $(window.parent.$("#saleProdFrame"))[0].contentWindow.saveSaleProd();
        parent.addAreaContent();
    }

    function saveArea(area){
        $("#areaName").val(area.areaName);
        $("#offerId").val(area.offerId);
        $("#functionArea").val(area.functionArea);

        $("#areaForm").attr("action","/BGManage/offerList/saveArea");

        $("#areaForm").submit();
    }

    //删除区域
    function deleteArea(areaId,offerId){
        var isDelete=confirm("确定要删除该区域吗？");
        if(isDelete){
            window.location.href = "/BGManage/offerList/deleteArea?areaId="+areaId+"&offerId="+offerId;
        }
    }

</script>

</body></html>