<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="prc" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <jsp:include page="../common/head_css.jsp"/>
    <title>报价清单</title>
    <link rel="stylesheet" href="${prc }/common/css/offerList_mobile.css" />
    <link rel="stylesheet" href="${prc }/common/css/font-awesome.min.css">
    <link rel="stylesheet" href="${prc }/common/css/build.css">
    <style>


        /*	#openNewPop{position:absolute;left:50%;transform:translateX(-50%);-webkit-transform:translateX(-50%);top:0;height:0}
            .bootstrap-dialog .modal-dialog{top:45% !important;left:50% !important;-webkit-transform: translateX(-50%);-ms-transform: translateX(-50%);-o-transform: translateX(-50%);transform: translateX(-50%);}
        */
    </style>
    <jsp:include page="../common/footer_js.jsp" />
    <script>

        var offerlist_offset_top = 0;
        function changeFrameHeight(id){

            var ifm = document.getElementById(id),
                $ifm = $(ifm),
                temp_hei,
                set_hei,
                hei,
                o_hei,
                offset_top;

            temp_hei = hei = screen.availHeight;

            o_hei = $($ifm).contents().find('body').height();
            if(!offerlist_offset_top){
                offerlist_offset_top = $ifm.offset().top;
            }

            set_hei = hei - offerlist_offset_top - 32;

            if(set_hei<o_hei){
                set_hei = o_hei;
            }
            ifm.style.height = set_hei+'px';

        }
        /*  设置Iframe的高度 */
        function loadedSetIframeHeight(){
            changeFrameHeight('saleProdFrame');
        }
        //到产品界面
        function selectSaleProd(areaId){
            if(!areaId){
                return;
            }
            $("#saleProdFrame").attr("src","${prc}/mOfferList/viewSaleProd?areaId="+areaId+'&mark=new');

        }

        function SetOffWinHeight() {
            var obj = document.getElementById("content");
            var win = obj;
            if (win && !window.opera) {
                if (win.contentDocument && win.contentDocument.body.offsetHeight)
                    win.height = win.contentDocument.body.offsetHeight + 20;
                else if (win.Document && win.Document.body.scrollHeight)
                    win.height = win.Document.body.scrollHeight + 20;
            }
        }
    </script>

    <style>

        .hone_prodlib_pop2018 .modal-dialog{
            width: 94% !important;
            max-width: 1258px !important;
            height: 94% !important;
        }


    </style>


</head>
<body>
<div class="modal fade hone_prodlib_pop hone_prodlib_pop2018" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog" style="width:1100px;height:94%;margin-top:auto;overflow:auto">
        <div class="modal-content">
            <div class="prodlib_leftMune_line" id="prodlib_leftMune_line"></div>
            <div class="modal-body" style="padding: 0px;font-size:0;">
                <iframe id="content_prodlib" src="${prc }/customProdType/queryProdType.th" name="content" frameborder="0" style="min-height: 94%" height="100%" width="100%" ></iframe>
            </div>
        </div>
    </div>
</div>
<div class="topBox">
    <div class="cent clearfix">
        <h3>报价清单</h3>
        <a class="topBox-btn"></a>
        <!-- <a class="backbtn">&lt; 返回平面布局</a> -->
        <div class="fr">
            <a class="top-save-btn" id="top_saveBtn">保存</a>
        </div>
    </div>
</div>
<div class="muneBox">
    <div class="leftMune-bg"></div>
    <div class="leftMune">
        <div class="mune-cont">
            <p class="mune-til">菜单栏</p>
            <div class="mune-list">
                <div class="cont-scrol">
                    <dl class="listbox">
                        <dt>编辑报价</dt>
                        <dd>
                            <ul>
                                <a id="editofferid" class="li-a">按区域编辑<i class="tri-ico"></i></a>
                                <!-- <a href="" class="li-a">按类目编辑<i class="tri-ico"></i></a> -->
                            </ul>
                        </dd>
                    </dl>
                    <dl class="listbox">
                        <dt>其他功能</dt>
                        <dd>
                            <ul>
                                <a href="" class="li-a">发送至邮箱<i class="tri-ico"></i></a>
                            </ul>
                        </dd>
                    </dl>

                </div>
            </div>
            <div class="mune-back-box">
                <!-- <a class="mune-back-btn">&lt; 返回平面布局</a> -->
            </div>
        </div>
    </div>
</div>
<div class="wrapBox">

    <!-- 测试PAD专用节点 -->
    <!-- div id="debugger_info"></div> -->


    <div class="container-fluid">
        <div class="padding-t-30 clearfix">
            <ul id="myTab" class="nav nav-pills tempNavBox clearfix padding-b-30">
                <li class="active nav-li1">
                    <a href="#offerheader" data-toggle="tab">清单抬头</a>
                </li>
                <li class="nav-li2" onclick="resetHeightOnce()"><a href="#furniturelist" data-toggle="tab">家具列表</a></li>
                <li class="dropdown nav-li3">
                    <a href="#offerend" data-toggle="tab">清单尾项</a>
                </li>
            </ul>
        </div>

        <div class="row">
            <div class="col-sm-12 col-md-12 col-lg-12">
                <div id="myTabContent" class="tab-content">
                    <!-- 抬头 -->
                    <div class="tab-pane fade active in" id="offerheader" style="height: 100%">
                        <!-- <iframe id="offerheaderFrame" src="${prc}/mOfferList/initCompany?offerListId=${offerListFid}" name="offerheaderFrame" frameborder="0" scrolling="no" width="100%" height="610" onload="javascript:changeFrameHeight('offerheaderFrame')"></iframe> -->
                        <iframe id="offerheaderFrame" src="${prc}/mOfferList/initCompany?offerListId=${offerListFid}" name="offerheaderFrame" frameborder="0" scrolling="no" width="100%" min-height="500px" ></iframe>
                    </div>
                    <!-- <div id="debuger-info"></div>
                    <div style="height:200px;background:red"></div>-->
                    <!-- 数据列表 -->
                    <div class="tab-pane fade" id="furniturelist" style="height: 100%;background-color:#fff">
                        <!-- 数据列表 -->
                        <iframe id="areaDistributionFrame" name="areaDistributionFrame" src="${prc}/mOfferList/queryArea?offerListId=${offerListFid}" frameborder="0" scrolling="no" width="100%" height="56px"
                        ></iframe>
                        <iframe id="saleProdFrame" src="" onload="changeFrameHeight('saleProdFrame')" name="saleProdFrame" frameborder="0" scrolling="no" width="100%" ></iframe>
                    </div>
                    <!-- 尾项 -->
                    <div class="tab-pane fade" id="offerend">
                        <iframe id="offerTailFrame" name="offerTailFrame" src="${prc}/mOfferList/queryOfferListEnd?offerId=${offerListFid}" frameborder="0" scrolling="no" width="100%" onload="changeFrameHeight('offerTailFrame')"></iframe>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
<div class="openNewPopWrap" id="openNewPopWrap">
    <div class="openNewPopBg"></div>
    <iframe id="openNewPop" class="openNewPop" name="offerTailFrame" src="" frameborder="0" scrolling="no" width="100%" ></iframe>
</div>

<!-- 产品库 -->
<%--<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width:820px;height:500px;margin-top:auto;top: 50%;left:50%">
        <div class="modal-content">
            <div class="modal-header" style="padding: 8px;">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h5 class="modal-title" id="myModalLabel" style="text-align: center">产品库</h5>
            </div>
            <div class="modal-body" style="padding: 5px 7px;">
                 <iframe id="content" src="${prc }/jsp/offerlist/productLib_mobile.jsp" name="content" frameborder="0"scrolling="no" style="max-height: 440px;" height="100%" width="100%" ></iframe>
            </div>
       </div>
    </div>
</div>--%>
<!-- 产品库  end-->

<%--<div class="modal fade hone_prodlib_pop hone_prodlib_pop2018" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog" style="width:1100px;height:94%;margin-top:auto;overflow:auto">
        <div class="modal-content">
            <div class="prodlib_leftMune_line" id="prodlib_leftMune_line"></div>
            <div class="modal-body" style="padding: 0px;font-size:0;">
                <iframe id="content_prodlib" src="${prc }/customProdType/queryProdType.th" name="content" frameborder="0" style="min-height: 94%" height="100%" width="100%" ></iframe>
            </div>
        </div>
    </div>
</div>--%>


</body>
<script src="${prc }/common/js/json2.js"></script>
<script src="${prc }/common/js/jquery.form.js"></script>
<script src="${prc }/common/js/jquery-ui.min.js"></script>

<script>


    function runHomePublicPop(opt_obj){
        if(Object.prototype.toString.call(opt_obj) === '[object Object]'){
            PublicPop(opt_obj);
        }
    }

    /* 区域编辑页面 */
    var $editofferid = $('#editofferid'),
        $openNewPopWrap = $('#openNewPopWrap'),
        openNewPopWrap_koken = false,
        $openNewPop = $('#openNewPop');

    $editofferid.on('touchstart',function(){
        if(openNewPopWrap_koken){
            return;
        }
        openNewPopWrap_koken = true;
        var offerId = $('#offerTailFrame').contents().find("#offerId").val(),
            //offerId = 'CrEWy4sTSmeMEWWOW4Yfgg',
            src = "${prc}/mOfferList/toOfferPirce?offerId="+offerId+"&exportType=1",
            width = screen.availWidth,
            height = screen.availHeight;

        $openNewPop[0].style.height = height+'px';
        $openNewPop[0].style.width = width+'px';
        $openNewPop[0].src = src;
        $openNewPopWrap.show();

        //hiddenLeftMune();

    });

    /*关闭区域编辑页面*/
    function closeNewPopWrap(){
        $openNewPopWrap.hide();
        openNewPopWrap_koken = false;
    }


    /* 子iframe更新区域名字 */

    function iframeUpdateAreaName(area,areaName,areaFid){
        $.ajax({
            type: "Post",
            //async:true,
            url:"${prc}/mOfferList/updateAreaName",
            data:JSON.stringify(area),
            dataType:"text",
            contentType: "application/json; charset=utf-8",
            success: function(msg) {
                $('#areaDistributionFrame').contents().find('#selectArea option[value='+areaFid+']').text(areaName);
                updateFurInputName(areaName);
            }
        });
    }


    /* 更新家具列表隐藏域name=areaName的值 */
    function updateFurInputName(newName){
        $('#saleProdFrame').contents().find('input[name="areaName"]').val(newName);
    }

    /* 重新加载 iframe*/
    function reloadIframe(iframeId){
        $('#'+iframeId)[0].contentWindow.location.reload();
    }

    /* 关闭弹窗 */

    function closeMyModalPop(){
        $('#myModal').on('hidden.bs.modal', function () {
            $("#content")[0].contentWindow.hiddenLeftMune();
        });
        $('#myModal').modal('hide');
    }

    /* 展示产品库 */
    function showParentProdLib(a,b,c,d,e,f){

        $('#myModal').modal();
        $('#myModal').on('hidden.bs.modal', function () {
            $("#content")[0].contentWindow.hiddenLeftMune();

            $("#content")[0].contentWindow.clearCountItem();
        });
        $("#content")[0].contentWindow.showProdLibMsg(a,b,c,d,e,f);
        //$("#content")[0].contentWindow.showProdLibMsg('all',1,true,'${area.fid}','${area.offerId}');
    }


    var globalFunc;
    $(document).ready(function () {
        //globalFunc = window.parent.globalcallback();
        $("#form01").ajaxForm(function(){
            //globalFunc();
            return false;
        });
        //输入框回车事件
        $("#areaName").keydown(function(e) {
            if (e.keyCode == 13) {
                $("#areaName").blur();
            }
        });

        //计算该区域产品的合计
        parent.totalCosts();
    });

    //替换当前产品
    function replCurrentRow(obj,replSaleProdId){
        //先保存当前产品信息
        saveSaleProd();
        var tr=obj.parentNode.parentNode;
        var prodIndex = $(tr).find("td").eq(1).html()-1;
        var prodTypeId = $('input[name="prods['+prodIndex+'].prodTypeId"]').val();

        $('#myModal').modal('show');
        //弹出模态框
        $("#content")[0].contentWindow.showProdLibMsg(prodTypeId,1,true,$("#areaFid").val(),$("#offerId").val(),replSaleProdId);

    }

    //删除当前产品
    function deleteCurrentRow(obj,fid)
    {
        var isDelete=confirm("确定要删除吗？");
        if(isDelete)
        {
            var tr=obj.parentNode.parentNode;
            var tbody=tr.parentNode;
            tbody.removeChild(tr);
            //重新计算小计
            // parent.totalCosts();

            var deleId = fid;
            if(null != deleId && "" != deleId){
                $.ajax({
                    type: "GET",
                    async:true,
                    url:"${prc}/offerList/deleteSaleProd",
                    data:"saleProdId="+deleId,
                    success: function(result) {
                    },
                    error: function(err) {
                    }
                });
            }
            reCount();
        }
        parent.totalCosts();
    }
    //重新排序序号
    function reCount(){
        var index = 0;
        $(".furTable tbody").find("tr").each(function(){
            //            if("furTabletr0" != $(this).attr("id")){
            if(index== $(".furTable tbody").find("tr").length - 1){
                return;
            }
            //重设编号
            var tdArr = $(this).children();
            var preIndex = $(this).find("td:eq(1)").html() - 1;
            $(this).find("td:eq(1)").html(index + 1);
            index ++ ;
        });
    }
    //提交表单前的校验
    function submitValid(){
        if(false == skulegel){
            alert("存在不合法的sku组合!");
            return false;
        }

    }
    //提交表单
    function saveProdData(callback){
        var trCount = $(".furTable tbody").find("tr").length-1;
        if(trCount > 0){
            gAddProductCallback = callback;
            $("#form01").submit();
        }
    }

    //判断sku是否合法
    var skulegel = true;
    function valiadSku(selectedObj){
        var tr = $(selectedObj).parents();
        //产品id
        var prodId = $(tr).eq(2).find('input[name$=".prodId"]').val();
        //材质
        var material = $(tr).eq(2).find('select[name$=".meterial"]').val();
        //颜色
        var color = $(tr).eq(2).find('select[name$=".color"]').val();
        //尺寸
        var size = $(tr).eq(2).find('select[name$=".standard"]').val();

        // 成本
        var cost = $(tr).eq(2).find('input[name$=".cost"]');
        var modelNoInput = $(tr).eq(2).find('input[name$=".modelNo"]');

        var sellCompany = $(tr).eq(1).find('input[name$=".sellCompany"]').val();

        $.ajax({
            type: "GET",
            async:true,
            url:"${prc}/product/getProdSku",
            data:{"material":material,"size":size,"color":color,"prodId":prodId},
            success: function(result) {
                if(null == result.sku){
                    skulegel = false;
                    alert("不存在该sku组合");
                }else{
                    //pic.src="${prc}/"+result.sku.
                    var buyRate = $("#buyRate_"+sellCompany).val();
                    var priceAfterRate = Math.round(parseInt(result.sku.price) * buyRate);
                    cost.val(priceAfterRate);
                    $(tr).children("td:eq(10)").html(priceAfterRate);

                    //成本变动
                    var oldcost = Math.round($(tr).eq(1).find('input[id^="oldcost"]').val());
                    if(oldcost != priceAfterRate){
                        $(tr).eq(1).find('input[name$=".clearTag"]').val("1");
                    }else{
                        $(tr).eq(1).find('input[name$=".clearTag"]').val("0");
                    }

                    var modelNo =result.sku.modelNo;
                    if(null ==  modelNo|| "" == modelNo){
                        modelNo ="N/A";
                    }
                    modelNoInput.val(modelNo);
                    $(tr).children("td:eq(4)").html(modelNo);
                    parent.totalCosts();
                }
            },
            error: function(err) {
                alert("校验失败!");
            }
        });
    }


    function hiddenModel(){
        $('#myModal').modal('hide');
    }

    function exportExceltmp(){
        var offerId = $("#offerId").val();
        $.ajax({
            type: "GET",
            async:false,
            url:"${prc}/offerList/doValidateOfferExcel",
            data:"offerListId="+offerId,
            beforeSend: function () {
            },
            success: function(result) {
                if("false" == result){
                    alert("没有设置报价单，请设置报价！");
                }else{
                    window.location.href = "${prc}/offerList/exportExcel?offerListId="+offerId;
                }
            },
            error: function(err) {
                alert("导出失败!");
            }
        });
    }
    //导出excel
    function exportExcel(){
        saveSaleProd();
        window.setTimeout("exportExceltmp();",200);
    }

    function saveSaleProd(str){
        $("#form01").submit();
    }

    $(document).ready(function(){
        var fixHelperModified = function(e, tr) {
                var $originals = tr.children(".sortTR");
                var $helper = tr.clone();
                $helper.children().each(function(index) {
                    $(this).width($originals.eq(index).width())
                });
                return $helper;
            },
            updateIndex = function(e, ui) {
                $('td.index', ui.item.parent()).each(function (i) {
                    $(this).html(i + 1);
                    $(this).parent().find('input[name$=".sequNum"]').val(i+1);
                });
            };
        $("#sort tbody:eq(0)").sortable({
            helper: fixHelperModified,
            stop: updateIndex
        }).disableSelection();
    });

    //重新修改区域名称
    function updateAreaName(){
        var areaName = $("#areaName").val();
        if("" == areaName){
            $("#areaName").val(areaNametmp);
            return;
        }
        $('input[name="areaName"]').val(areaName);
        //该区域id
        var areaFid = $('input[name="fid"]').val();
        $("#areaDistributionFrame",parent.document).contents().find('table.sidebarTabel tr td[areaid="'+areaFid+'"]').html(areaName);

        var area = {"fid":areaFid,"areaName":areaName};
        $.ajax({
            type: "Post",
            async:true,
            url:"${prc}/offerList/updateAreaName",
            data:JSON.stringify(area),
            dataType:"json",
            contentType: "application/json; charset=utf-8",
            success: function(result) {
            },
            error: function(err) {
            }
        });
    }

    var areaNametmp;
    //区域名称输入框获得光标事件
    function changeAreaName(){
        areaNametmp = $("#areaName").val();
        $("#areaName").val("");
    }

    var lwsb;
    //length width staffCount budget输入框获得光标事件
    function conditionFocus(curr){
        lwsb = $('input[name="'+curr+'"]').val();
        $('input[name="'+curr+'"]').val("");
    }
    //length width staffCount budget输入框失去光标事件
    function conditionBlur(curr){
        var tmp = $('input[name="'+curr+'"]').val();
        if("" == tmp){
            $('input[name="'+curr+'"]').val(lwsb);
        }
    }

    //计算该区域产品的合计
    function calcAreaMinCost(){
        var trlen = $(".furTable tbody").find("tr").length -1;
        var index = 0;
        var currareacost = 0;
        $(".furTable tbody").find('tr').each(function(){
            if(index > trlen-1){
                return;
            }
            var count = $(this).find('input[name="prods['+index+'].count"]').val();
            var cost = $(this).find('input[name="prods['+index+'].cost"]').val();
            currareacost += count*cost;
            index ++;
        });
        $("#areaMinCost").html(currareacost);
    }

    function clearNoNum(obj) {
        obj.value = obj.value.replace(/[^\d.]/g,""); //清除"数字"和"."以外的字符
        obj.value = obj.value.replace(/^\./g,""); //验证第一个字符是数字而不是
        obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的
        obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
        obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3'); //只能输入两个小数
    }

    /**
     * 批量删除产品
     */
    function deleteSaleProdBatch(){
        var saleProdArr = "";
        var salecout = 0;
        $('input[name="salecheckbox"]:checked').each(function(){
            saleProdArr += $(this).val() +";";
            salecout++;
        });

        if(saleProdArr.length>0){
            var isDelete=confirm("已选择 "+salecout+" 条数据 , "+"确定要删除吗？");
            if(isDelete) {
                var tr;
                var tbody;
                $('input[name="salecheckbox"]:checked').each(function(){
                    tr = $(this).parent().parent();
                    tbody = tr.parent();
                    tbody[0].removeChild(tr[0]);
                });

                $.ajax({
                    type: "GET",
                    async:true,
                    url:"${prc}/offerList/deleteSaleProdBatch",
                    data:"saleProdIds="+saleProdArr,
                    success: function(result) {
                    },
                    error: function(err) {
                    }
                });
                reCount();
                parent.totalCosts();
            }
        }
    }

    /**
     * 全选
     */
    function saleSelectedAllClick(){
        var isChecked = $('input[name="saleSelectedAll"]').is(":checked");
        if(isChecked){
            //全部选中
            $('input[name="salecheckbox"]').each(function(){
                $(this).prop('checked',true);
            })
        }else{
            //全部取消
            $('input[name="salecheckbox"]:checked').each(function(){
                $(this).prop('checked',false);
            });
        }
    }


    /* 展示产品库  end*/



    /* 顶部保存按钮 */
    var $top_saveBtn = $('#top_saveBtn');
    $top_saveBtn.on('touchstart',function(){
        var $ifr = $('#myTabContent .tab-pane.active iframe'),
            len = $ifr.length-1;
        if(len >= 1){
            isSuccess = $ifr.eq(len)[0].contentWindow.saveSaleProd('ok');
            var opt = {};
            opt.btnName = ['关闭'];
            opt.til = '提示';
            opt.tpls = '<div class="textAli-c">保存成功</div>';
            opt.btnNum = 1;
            window.top.runHomePublicPop(opt);
        }
        else{
            var $iframe = $ifr.eq(len),
                $form_el = $iframe.contents().find('form');

            if($form_el[0].id === 'tailform'){
                isSuccess = $iframe[0].contentWindow.saveOfferEnd();
            }
            else{
                var opt = {};
                opt.btnName = ['关闭'];
                opt.til = '提示';
                opt.tpls = '<div class="textAli-c">保存成功</div>';
                opt.btnNum = 1;
                window.top.runHomePublicPop(opt);
                isSuccess = $form_el.submit();
            }
        }

    });


    /* 左侧菜单 */
    var $leftMune = $('.muneBox'),
        $leftMune_btn = $('.topBox-btn'),
        $leftMune_a = $('.muneBox .li-a'),
        $leftMune_bg = $('.leftMune-bg'),
        $leftMune_cont = $leftMune.find('.leftMune'),
        //isSupPrortcss3 = publicSupport_css3('transition'),
        isAndrio6 = navigator.appVersion,
        hiddenLeftMune,
        showLeftMune;

    isAndrio6 = navigator.appVersion.split('Android ');

    if(isAndrio6.length < 2){
        isAndrio6 = 0;
    }
    else{
        isAndrio6 = parseInt(isAndrio6[1].split('.')[0]);
    }



    $leftMune_btn.on('touchstart',function(){

        if($leftMune.hasClass('active')){
            hiddenLeftMune();
        }
        else{
            showLeftMune();
        }

    });


    if(isAndrio6 >= 6 ){
        hiddenLeftMune = function(){
            $leftMune.removeClass('active');
        };
        showLeftMune = function(){
            $leftMune.addClass('active');
        };
    }
    else{
        hiddenLeftMune = function(){
            //$leftMune.removeClass('active');
            $leftMune_bg.hide();
            $leftMune_cont.animate({left:'-320px'},300);
        };
        showLeftMune = function(){
            //$leftMune.addClass('active');
            $leftMune_bg.show();
            $leftMune_cont.animate({left:0},300);
        };
    }

    $leftMune_bg.on('touchstart',function(e){
        e.stopPropagation();
        hiddenLeftMune();
    });

    $leftMune_bg.on('click',function(e){
        e.stopPropagation();
    });


    /* $leftMune_a.on('touchstart',function(){
        hiddenLeftMune();
    }); */

    var content = '${prc}';

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


    //计算每个区域的小计
    /*function totalCosts(){
        var trCount = $("#saleProdFrame").contents().find(".furTable tbody").find("tr").length-1;
        var totalProdCost = $("#saleProdFrame").contents().find("#totalProdCost").val();
        var allAreaCost;
        if("" == totalProdCost){
            totalProdCost = 0;
        }else{
            totalProdCost = Math.round(totalProdCost);
        }
        if(trCount>0){
            var total = 0;
            $("#saleProdFrame").contents().find(".furTable tbody.tabledata").find("tr").each(function(){
                var count = $(this).find('input[name$="].count"]').val();
                if("" == count){
                    $(this).find('input[name$="].count"]').val(0);
                    count = 0;
                }
                var cost = $(this).find('input[name$="].cost"]').val();
                total += cost * count;
            });
            total = Math.round(total);
            //区域小计
            $("#saleProdFrame").contents().find("#areaMinCost").html(formatMoney(total));
            totalProdCost = parseInt(totalProdCost) + total;
        }else{
            $("#saleProdFrame").contents().find("#areaMinCost").html(0);
        }
        $("#areaDistributionFrame").contents().find("#allAreaCost").html(formatMoney(totalProdCost));
    }  */

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
        var option ="";
        for(var i = 0; i<areaOptions.length; i++){
            option +="<option value='"+areaOptions[i].fid+"'>"+areaOptions[i].name+"</option>";
        }

        var obj={
            type:"layer-spread",
            title:"设置区域属性",
            content:"<table>"+
            "<tr><td width='25%'>区域名称：</td><td width='75%'><input type='text' id='areaName' class='form-control'></td></tr>"+
            "<tr><td>区域分类：</td><td><select class='form-control' id='functionArea'>"
            +option+
            "</select></td></tr>"+
            "</table>",
            area:["350px","250px"],
            btn:["取消","提交"]
        };
        method.msg_layer(obj);
    }

    function doLayerSubmit(){
        var areaName = $("#areaName").val();
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
        window.open("${prc}/offerList/toOfferPirce.action?offerId="+offerId+"&exportType=1");
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

    var $iframe_offerheaderFrame = $('#offerheaderFrame'),
        $ifrme_saleProdFrame = $('#saleProdFrame');

    $(function(){

        $iframe_offerheaderFrame[0].onload = changeFrameHeight('offerheaderFrame');
        loadedSetIframeHeight();
    });


    var $homeMyModal = $('#myModal'),
        $saleProdFrame_ifr = document.getElementById('content_prodlib').contentWindow;

    $homeMyModal.on('shown.bs.modal',function(){
        //重新设置高度
        //document.getElementById('content_prodlib').contentWindow.resetIfrHei();
    });

    $homeMyModal.on('hidden.bs.modal',function(){
        //重新设置高度
        var content_prodlib_js = document.getElementById('content_prodlib').contentWindow;
        content_prodlib_js.showCagrage();
        //content_prodlib_js.resetIfrHei();
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


    var resetHeightOnce_handel = false;

    function resetHeightOnce(){
        if(!resetHeightOnce_handel){
            resetHeightOnce_handel = true;
            setTimeout(function(){
                loadedSetIframeHeight();
            },200);
        }
    }

</script>


</html>