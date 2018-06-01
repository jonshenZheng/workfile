<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="prc" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="../common/head_css.jsp"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>index</title>
    <%-- <link rel="stylesheet" href="${prc }/common/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="${prc }/common/css/build.css"/>--%>
    <link rel="stylesheet" href="${prc }/common/css/layer-animate.css"/>
    <style>
        .msg-layer.showAlert{
            top:325px !important;
        }

        .offerFurList-page .addAreaBox{
            position:relative;
        }
        .offerFurList-page .lock-icon{
            position:absolute;
            right:0;
            top:-5px;
            width:20px;
            height:20px;
            background-color:#f60;
        }

        .offerFurList-page .lock-icon.active{
            background-color:#333;
        }

    </style>
    <script>
        function changeFrameHeight(id){
            var ifm = document.getElementById(id);
            ifm.height=document.documentElement.clientHeight;
        }
    </script>
</head>
<body class="offer-content-box" style="background-color:#f0f2f8;">

<input type="hidden" id="offerId" value="${offerListFid}">
<input type="hidden" id="prodsKey" value="">
<div class="offerlist-tab offerlist-tab2018">
    <ul id="myTab" class="Nav-tab2018">
        <li onclick="swichTab(0)"><a href="#offerheader" data-toggle="tab">清单抬头</a></li>
        <li><span class="tri">></span></li>
        <li class="active" onclick="swichTab(1)">
            <a href="#furniturelist" data-toggle="tab">家具清单</a>
        </li>
        <li><span class="tri">></span></li>
        <li class="dropdown" onclick="swichTab(2);openEditTabel()">
            <a href="#editTable" data-toggle="tab">编辑报价</a>
        </li>
        <li><span class="tri">></span></li>
        <li class="dropdown" onclick="swichTab(3);">
            <a href="#offerend" data-toggle="tab">清单尾项</a>
        </li>
    </ul>
    <div class="fr">
        <a class="btn btn-primary" id="offerFurSave">保存</a>
        <a class="btn btn-primary margin-l-14"  id="offerFurexportBtn">导出</a>
        <shiro:hasPermission name="EXPORT_COST_EXCEL">
            <a class="btn btn-primary margin-l-14"  id="costexportBtn">导出成本核算表</a>
        </shiro:hasPermission>
        <a class="btn btn-primary margin-l-14" id="offerFurSendEmial">发到邮箱</a>
    </div>
</div>
<div id="myTabContent" class="tab-content">
    <!-- 家具列表 -->
    <div class="tab-pane fade active in" id="furniturelist">
        <div class="table-box clearfix offerFurList-page row">
            <div class="col-sm-2 addAreaBox">
                <!-- <a class="lock-icon active" id="lock-icon"></a> -->
                <iframe id="areaDistributionFrame" name="areaDistributionFrame" src="${prc}/offerList/toQueryAreaByCondition?offerID=${offerListFid}" frameborder="0" scrolling="no" width="100%" height="560"
                ></iframe>
            </div>
            <div class="col-sm-10 furListBox">
                <iframe id="saleProdFrame" src="" name="saleProdFrame"
                        frameborder="0" scrolling="no" width="100%" height="922"></iframe>
            </div>
        </div>
        <!--             <div class="handle-btn-box textAli-r padding-r-20">
                         <a class="btns btns-defualt" id="offerFurSave">保存</a>
                         <a class="btns btns-defualt">预览</a>
                         <a class="btns btns-defualt" id="offerFurexportBtn">导出</a>
                         <a class="btns btns-defualt" id="offerFurSendEmial">发到邮箱</a>
                     </div> -->
    </div>
    <!-- 家具列表 end-->
    <!-- 清单抬头 -->
    <div class="tab-pane fade" id="offerheader" style="height: 100%">
        <%-- <iframe id="offerheaderFrame" src="${prc}/offerList/initCompany?offerListId=${offerListFid}" name="offerheaderFrame"
                        frameborder="0" scrolling="no" width="100%" height="100%" onload="changeFrameHeight('offerheaderFrame')"></iframe> --%>
        <iframe id="offerheaderFrame" src="${prc}/offerList/initCompany?offerListId=${offerListFid}" name="offerheaderFrame"
                frameborder="0" scrolling="no" width="100%" height="500"></iframe>
    </div>
    <!-- 清单抬头 end-->
    <!-- 编辑报价 -->
    <div class="tab-pane fade" id="editTable" style="height: 100%">
        <iframe id="baojiaIfr" src="" name="offerheaderFrame" frameborder="0" scrolling="no" width="100%" height="100%"></iframe>
    </div>
    <!-- 编辑报价 end-->
    <!-- 清单尾项 -->
    <div class="tab-pane fade" id="offerend" style="min-height: 100%">
        <iframe id="offerTailFrame" name="offerTailFrame" src="${prc}/offerList/queryOfferListEnd?offerId=${offerListFid}" frameborder="0" scrolling="no" width="100%" height="700"
        ></iframe>
    </div>
</div>

<!--  <div class="bottemBTNBox">

    <div class="handle-btn-box textAli-r padding-r-20">
        <a class="btns btns-defualt" id="offerFurSave">保存</a>-->
<!-- <a class="btns btns-defualt">预览</a> -->
<!--<a class="btns btns-defualt" id="offerFurexportBtn">导出</a>
<a class="btns btns-defualt" id="offerFurSendEmial">发到邮箱</a>
</div>

</div>-->





<!-- 家具列表有用到 -->
<!--  <div class="row">
     <div class="col-sm-12 col-md-12 col-lg-12" style="text-align: right;">
         <div class="dropdown pull-right">
             <button type="button" class="btn dropdown-toggle" id="dropdownMenu1"
                     data-toggle="dropdown">
                 编辑报价
                 <span class="caret"></span>
             </button>
             <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                 <li role="presentation">
                     <a role="menuitem" tabindex="-1" id="" href="javascript:areaEdit()" >按区域编辑</a>
                 </li>
                 <li role="presentation">
                     <a role="menuitem" tabindex="-1" href="#">按类目编辑</a>
                 </li>
             </ul>
         </div>
     </div>
 </div> -->

<%--产品库--%>
<div class="modal fade hone_prodlib_pop hone_prodlib_pop2018" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog" style="width:1100px;height:94%;margin-top:auto">
        <div class="modal-content">
            <div class="prodlib_leftMune_line" id="prodlib_leftMune_line"></div>
            <div class="modal-body" style="padding: 0px;font-size:0;">
                <iframe id="content_prodlib" src="${prc }/customProdType/queryProdType.th" name="content" frameborder="0"
                        scrolling="no" style="min-height: 94%" height="100%" width="100%" ></iframe>
            </div>
        </div>
    </div>
</div>


<jsp:include page="../common/footer_js.jsp" />
<script src="${prc }/common/js/json2.js"></script>
<script src="${prc }/common/js/method.js"></script>
<script src="${prc }/common/js/currencyFormatter.min.js"></script>
<script src="${prc }/common/My97DatePicker/WdatePicker.js"></script>
<script src="${prc }/common/js/commonJs.js"></script>
<c:if test="${navTag eq 'furAdd'}">
    <script  type="text/javascript">
        //$('#myTab li:eq(1) a').tab('show');
    </script>
</c:if>
<script type="text/javascript">

    //publicRHeight(0);
    function publicRHeight(ind){

        /* setTimeout(function(){
            PublicSetSelfIframeHeiFf(ind);
        },350); */

    }

    function openEditTabel(){

        var trCount = $("#saleProdFrame").contents().find(".furTable tbody tr").length-1;
        var offerId = $("#offerId").val();
        if(trCount>0){
            saleProdFrame.window.saveSaleProd();
        }

        window.setTimeout("setEditSRC('"+offerId+"');",300);
        //window.setTimeout("refreshOffer('"+offerId+"');",301);
    }

    var $baojiaIfr = $('#baojiaIfr');

    function setEditSRC(offerId){
        $baojiaIfr.attr('src','${prc}/offerList/toOfferPirce.action?offerId='+offerId+'&exportType=1&mark=new');
    }


    /* 底下操作按钮 */
    var $offerFurSave = $('#offerFurSave'),
        $offerFurexportBtn = $('#offerFurexportBtn'),
        $offerFurSendEmial = $('#offerFurSendEmial'),
        $myTab = $('#myTab'),
        offerHeadIfr = $('#offerheaderFrame'),
        offertailIfr = $('#offerTailFrame'),
        offerBaojia = $('#baojiaIfr')[0].contentWindow,
        furListIframe_el = document.getElementById('saleProdFrame');
        $costexportBtn = $('#costexportBtn');
    /*保存*/
    $offerFurSave.on('click',function(){
        var ind =  $myTab.find('li.active').index()/2;

        switch(ind){
            case 0: offerHeadIfr.contents().find('#form').submit();
                break;
            case 1: furListIframe_el.contentWindow.saveSaleProd('ok');
                break;
            case 2: offerBaojia.doFormSubmit();
                break;
            case 3: offertailIfr.contents().find('#tailform').submit();
                break;
        }

    });

    //导出
    $offerFurexportBtn.on('click',function(){
        furListIframe_el.contentWindow.exportExcel();
    });
    //发送邮箱
    $offerFurSendEmial.on('click',function(){
        furListIframe_el.contentWindow.validateBeforeSendEmail();
    });

    //导出成本核算表
    $costexportBtn.on('click',function(){
        furListIframe_el.contentWindow.exportCostExcel();
    });

    var isHeaderSubimit = false,
        istailSubimit = false,
        iseditSubimit = false,
        headerSaveFromTisHandle = true,
        tailsaveFromTisHandle = true,
        editsaveFromTisHandle = true;


    //切换Tab保存
    var beforeSwichTabInd = 0;
    function swichTab(ind){

        switch(beforeSwichTabInd){
            case 0: headerSaveFromTisHandle = false;offerHeadIfr[0].contentWindow.formSubmitFn();
                break;
            case 1: furListIframe_el.contentWindow.saveSaleProd();
                break;
            case 2: editsaveFromTisHandle = false;offerBaojia.doFormSubmitFn();
                break;
            case 3: tailsaveFromTisHandle = false;offertailIfr[0].contentWindow.formSubmitFn();
                break;
        }
        beforeSwichTabInd = ind;
    }


    var content = '${prc}';
    function changeFrameHeight(id){
        var ifm = document.getElementById(id);
        ifm.height=document.documentElement.clientHeight;
    }

    window.onresize=function(){
        changeFrameHeight('offerheaderFrame');
    };

    //计算每个区域的小计
    function totalCosts(){

        var trCount = $("#saleProdFrame").contents().find(".furTable tbody").find("tr").length;
        var totalProdCost = $("#saleProdFrame").contents().find("#totalProdCost").val();
        var allAreaCost;
        if("" == totalProdCost){
            totalProdCost = 0;
        }else{
            totalProdCost = Math.round(totalProdCost);
        }

        if(trCount>0){
            var total = 0;

            $("#saleProdFrame").contents().find(".furTable").find("tr").each(function(){
                var count = $(this).find('.count-js').val();
                if("" == count){
                    $(this).find('.count-js').val(0);
                    count = 0;
                }
                var cost = $(this).find('.cost-js').val();
                total += cost * count;
            });
            total = Math.round(total);
            //区域小计
            $("#saleProdFrame").contents().find("#areaMinCost").html(formatMoney(total,0));
            totalProdCost = parseInt(totalProdCost)+parseInt(total);
        }else{
            $("#saleProdFrame").contents().find("#areaMinCost").html(0);
        }
        $("#saleProdFrame").contents().find("#allAreaCost").html(formatMoney(totalProdCost,0));
    }

    //到产品界面
    function selectSaleProd(areaId){
        $("#saleProdFrame").attr("height",document.documentElement.clientHeight);
        //$("#saleProdFrame").attr("src","${prc}/offerList/viewSaleProd?areaId="+areaId);
        $("#saleProdFrame").attr("src","${prc}/offerList/viewSaleProd?areaId="+areaId+'&mark=new');
    }

    function addAreaContent(){
        var areaOptions = [];
        $.ajax({
            type: "GET",
            async:true,
            url:"${prc }/offerListCreate/toQueryFunctionAreas",
            data:'',
            contentType: "application/json;charset=utf-8",
            success: function(result) {
                if(result){
                    areaOptions = result.functionAreas;
                    showLayer(areaOptions);
                }
            },
            error: function(err) {
                alert("校验失败!");
            }
        });

    }

    function showLayer(areaOptions){

        var option ="",
            defaultVal = '';

        if(areaOptions.length){
            defaultVal = areaOptions[0].name;
        }

        for(var i = 0; i<areaOptions.length; i++){
            option +="<option value='"+areaOptions[i].fid+"'>"+areaOptions[i].name+"</option>";
        }

        var obj={
            type:"layer-spread",
            title:"设置区域属性",
            content:"<table>"+
            '<tr><td colspan="2" id="tempTip" style="color:red;padding-bottom:10px"></td></tr>'+
            "<tr><td width='25%'>区域名称：</td><td width='75%'><input style='padding-left:17px' type='text' id='areaName' value='"+defaultVal+"' class='form-control'></td></tr>"+
            "<tr><td>区域分类：</td><td><select class='form-control' id='functionArea'>"
            +option+
            "</select></td></tr>"+
            "</table>",
            area:["350px","250px"],
            btn:["取消","提交"],
            afterCreate : function(content){

                var $valInp = $('#areaName');

                $('#functionArea').on('change',function(){
                    var val = $(this).find('option:selected').text();
                    $valInp.val(val);
                })
            }
        };
        method.msg_layer(obj);
    }

    function doLayerSubmit(){
        var areaName = $("#areaName").val(),
            areaName_all = '',
            $areaName_tr = $('#areaDistributionFrame').contents().find('table tr'),
            len = $areaName_tr.length-1;

        areaName = areaName.replace(publicRegx.trim,'');
        if(!areaName){
            $('#tempTip').html('区域名不能为空');
            return;
        }

        for(;len--;){
            areaName_all += ';'+$areaName_tr.eq(len).find('td').text();
        }
        if(areaName_all){
            areaName_all += ';';
            if(areaName_all.indexOf(';'+areaName+';') != -1){
                $('#tempTip').html('该区域名已存在，请重新命名');
                return;
            }
        }

        var offerId = $("#offerId").val();
        var functionArea = $("#functionArea").val();
        var area={"areaName":areaName,
            "offerId":offerId,
            "functionArea":functionArea
        };
        $("#areaDistributionFrame")[0].contentWindow.saveArea(area);
        method.msg_close();
    }

    var areaCostMap = {};
    //各区域总价
    function addAreaTotalCost(currTr,currCost){
        var areaCost = 0;
        areaCostMap[currTr] = currCost;
        for(var key in areaCostMap){
            areaCost += areaCostMap[key];
        }

        $("#allAreaCost").html("<p>各区域合计：</p>" + formatMoney(areaCost) + " 元");
    }

    function toOfferPirce(offerId)
    {
        //window.open("${prc}/offerList/toOfferPirce.action?offerId="+offerId+"&exportType=1");
        window.open("${prc}/offerList/toOfferPirce.action?offerId="+offerId+"&exportType=1&mark=new");
    }

    function areaEdit(){

        var trCount = $("#saleProdFrame").contents().find(".furTable tbody tr").length-1;
        var offerId = $("#offerId").val();
        if(trCount>0){
            saleProdFrame.window.saveSaleProd();
        }

        window.setTimeout("toOfferPirce('"+offerId+"');",300);
        window.setTimeout("refreshOffer('"+offerId+"');",301);
    }

    function refreshOffer(offerId){
        window.location.href = "${prc}/offerList/toOfferListDetail?offerId="+offerId+"&navTag=furAdd";
    }

    //格式化货币
    function formatMoney(number, places, symbol, thousand, decimal) {
        number = number || 0;
        places = !isNaN(places = Math.abs(places)) ? places : 2;
        symbol = symbol !== undefined ? symbol : "￥";
        thousand = thousand || ",";
        decimal = decimal || ".";
        var negative = number < 0 ? "-" : "",
            i = parseInt(number = Math.abs(+number || 0).toFixed(places), 10) + "",
            j = (j = i.length) > 3 ? j % 3 : 0;
        return symbol + negative + (j ? i.substr(0, j) + thousand : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thousand) + (places ? decimal + Math.abs(number - i).toFixed(places).slice(2) : "");
    }

    function saveTips(str){
        if("ok" == str){
            alert("保存成功.");
        }
    }

    function loadHeionece(){
        document.getElementById("saleProdFrame").contentWindow.resetFurHEI();
    }

    $('#myTab a[href="#furniturelist"]').one('click',function(){
        setTimeout('loadHeionece()',300);
    });

    var $areaIfr = $('#areaDistributionFrame')[0];

    $('#lock-icon').click(function(){

        var $el = $(this),
            isDontMove = false;

        if($el.hasClass('active')){
            $el.removeClass('active');
            isDontMove = false;
        }
        else{
            $el.addClass('active');
            isDontMove = true;
        }

        $areaIfr.contentWindow.MoveTabelTr(isDontMove);

    });

    //移动端跳转用的产品调用方式

    function changeIframeHeiFur(hei){
        var furIframe = document.getElementById('saleProdFrame'),
            heiTem= hei+300;

        if(hei < 596){
            heiTem = 900;
        }

        furIframe.height = hei+50;
    }

    var $homeMyModal = $('#myModal'),
        $saleProdFrame_ifr = document.getElementById('content_prodlib').contentWindow;

    $homeMyModal.on('shown.bs.modal',function(){
        //重新设置高度
        document.getElementById('content_prodlib').contentWindow.resetIfrHei();
    });

    $homeMyModal.on('hidden.bs.modal',function(){
        //重新设置高度
        var content_prodlib_js = document.getElementById('content_prodlib').contentWindow;
        content_prodlib_js.showCagrage();
        content_prodlib_js.resetIfrHei();
        $saleProdFrame_ifr.location.reload();
    });

    /* 打开产品库 */
    function openProdLibPop(fid,startPage,isReflash,areaId,offerId,replSaleProdId,num){

        $homeMyModal.modal('show');
        if(replSaleProdId){
            $saleProdFrame_ifr.showProdLibMsg(fid,startPage,isReflash,areaId,offerId,replSaleProdId,num);
        }
        else{
            $saleProdFrame_ifr.showProdLibMsg(fid,startPage,isReflash,areaId,offerId);
        }
    }

    function hideProdLibPop(){
        $homeMyModal.modal('hide');
    }

</script>
</body>
</html>
