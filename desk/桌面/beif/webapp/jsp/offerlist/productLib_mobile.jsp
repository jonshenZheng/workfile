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
	<jsp:include page="../common/head_css.jsp"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>index</title>
    <link href="${prc }/common/css/bootstrap-treeview.css" rel="stylesheet">
    <link rel="stylesheet" href="${prc }/common/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="${prc }/common/css/build.css"/>
    <link rel="stylesheet" href="${prc }/common/pager/kkpager_blue.css"/>
	<link rel="stylesheet" href="${prc }/common/css/prodLib_slectArea.css"/>
	<link rel="stylesheet" href="${prc }/common/lib/jquery-lightbox-0.5/css/jquery.lightbox-0.5.css"/>
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
        .container{
            width:100%;
        }
        .form-horizontal .has-feedback .form-control-feedback{
            pointer-events: auto;
            color:white;
            right:0px;
            padding-top: inherit;
        }
        .rowtitle{
            border-bottom: #d8d6d6;
            border-bottom-style: solid;
            border-bottom-width: thin;
        }
        .table>tbody>tr>td{
            border-bottom: 1px solid #ddd;
            border-top: none;
            padding: 3px;
        }
        .zxx_text_overflow_1{
            width:12em;
            white-space:nowrap;
            text-overflow:ellipsis;
            -o-text-overflow:ellipsis;
            overflow:hidden;
            display: block;
            float: left;
            position: absolute;
        }
        .col-lg-1, .col-lg-10, .col-lg-11, .col-lg-12, .col-lg-2, .col-lg-3, .col-lg-4, .col-lg-5, .col-lg-6, .col-lg-7, .col-lg-8, .col-lg-9, .col-md-1, .col-md-10, .col-md-11, .col-md-12, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-sm-1, .col-sm-10, .col-sm-11, .col-sm-12, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-sm-8, .col-sm-9, .col-xs-1, .col-xs-10, .col-xs-11, .col-xs-12, .col-xs-2, .col-xs-3, .col-xs-4, .col-xs-5, .col-xs-6, .col-xs-7, .col-xs-8, .col-xs-9 {
            position: relative;
            min-height: 1px;
            padding-right: 15px;
            padding-left: 1px;
        }
        .textOverflow{
            overflow:hidden;
            white-space:nowrap;
            text-overflow:ellipsis;
            padding: 2px;
            vertical-align: middle!important;
        }
        .dask{width:160px;height:118px;position:absolute;vertical-align: middle;left:0;top:0;padding:4px 0 0 0}
        .dask .daskBtn{float: right; width: 30px; height: 30px; margin-left: 5px;position:relative;}
        .dask .btn_add{background:url('${prc }/common/img/prodlib_dask_add.png') no-repeat;}
        .dask .btn_detail{background:url('${prc }/common/img/prodlib_dask_detial.png') no-repeat;}
        
        .dask p{
            color:#fff;
            margin-top: 110px;
            margin-left: 35px;
        }
        .dask a{color:green;text-decoration:none}
        #prodTypeListDiv ul{margin:0}
        
        .showProdLibAnddetail_btn{position:fixed;right:0;top: 50%;width:72px;height:72px;margin-top: -36px;background:url('${prc }/common/img/prodlib_selectedProduct_btn.png') no-repeat;}
        .showProdLibAnddetail_btn .selectProdlNum{font-size:12px;position:absolute;right:2px;top:-8px;width:24px;height:24px;border-radius: 50%;background-color: #f60;color:#fff;line-height: 24px;text-align: center;} 
        /* 产品详情及产品选择弹窗 */
		.ProdLibAnddetailBox{position:relative;z-index: 2;}
		.ProdLibAnddetail-bg{background-color: #000;position:fixed;left:0;top:0;width:100%;height:100%;opacity: 0.15;display:none;}
		.rightMune{position:fixed;width:310px;height:100%;right:-320px;top:0;transition:transform 0.6s ease 0.01s;-webkit-transition:-webkit-transform 0.6s ease 0.01s;background-color:#fff}
		.ProdLibAnddetailBox.active .ProdLibAnddetail-bg{display:block;}
		.ProdLibAnddetailBox.active .rightMune{transform:translateX(-300px);-webkit-transform:translateX(-300px);}
		
		
		.rightMune .mune-cont{position:relative;height:100%;width:300px;box-shadow: 5px 0px 5px rgba(0, 0, 0, 0.349019607843137);background-color: #fff;}
		.rightMune .mune-til{line-height: 44px;border-bottom:1px solid #ddd;font-size: 16px;color:#333;text-align: center;position:absolute;left:0;top:0;width:100%;z-index: 2;}
		.rightMune .mune-til .ico{color: #337ab7; margin-left: 5px;}
		.rightMune .mune-list{position:absolute;left:0;top:44px;bottom:72px;width:100%;}
		.rightMune .cont-scrol{overflow: scroll;height:100%;width:292px;border-bottom: 1px solid #ddd;}
		
		.rightMune .mune-back-box{position:absolute;left:0;bottom:0;width:100%;}
		.rightMune .mune-back-btn{display:block;line-height: 34px;text-align: center;font-size: 13px;color:#fff;background-color: #337ab7;z-index: 2;}
		.rightMune .selectProd{text-align: right;padding-right: 15px;color:#999;font-size: 14px;}
        .rightMune .selectProd span{color:#0066CC;padding: 0 3px;}
        .rightMune .prodlib_panel{display:none}
		/* 产品详情及产品选择弹窗  end */
        
        .list-group-item{padding: 6px 15px;}
        .ajust-inpandsele input[type="text"]{box-sizing:content-box;height:18px;line-height:18px;padding:1px 5px}
        
        .dask .daskBtn:before{content:'';position:absolute;left:0;top:0;z-index:-1;width:30px;height:30px;background-color: #000;opacity: 0.4;border-radius: 50%;transition: all 0.5s;}
        .dask .daskBtn.active:before{animation: btnScale .5s forwards;-webkit-animation: btnScale .4s forwards;}
        @keyframes btnScale
        {
            from {transform:scale(1,1);-webkit-transform:scale(1,1);opacity: 0.4;z-index:0}
            to {transform:scale(1.5,1.5);-webkit-transform:scale(1.5,1.5);opacity: 0;z-index:0}
        }
        .dask .daskImg{position:absolute;width:100%;height:100%;left:0;top:0;cursor: url(../../common/img/zoomin.cur), pointer !important;}
        .dask p{position:relative;}
        #lightbox-container-image-box{max-width:440px !important;max-height:340px;margin:0 auto;padding:0;overflow:hidden}
        #lightbox-container-image{max-width:420px !important;max-height:320px;margin:10px;padding:0;overflow:hidden}
        #lightbox-container-image-data-box{max-width:420px !important;}
        #lightbox-container-image.wid-img img{max-width:400px;max-height:320px;}
        #lightbox-container-image.hei-img img{max-width:186px;max-height:273px;}
        .thumbnail{overflow:hidden;position:relative}
        .thumbnail .imgWp{width:170px;height:87px;overflow:hidden;display:table-cell;text-align:center;vertical-align:middle;box-sizing:content-box;-webkit-box-sizing:content-box;}
        .thumbnail img{max-width:100%;max-height:100%;}
        

   		.container .addTisBox{position:absolute;left:0;top:0;width:100%;height:30px;z-index:11;display:none;}
        .container .addTisBox .bg{position:absolute;left:0;top:0;height:100%;width:100%;background-color:#337ab7;opcity:0.9;}
        .container .addTisBox .txtc{position:relative;text-align:center;line-height:30px;color:#fff;font-size:14px;}

    </style>
    
</head>
<body>
<input type="hidden" name="filepath" value="${filepath}"/>
<!--<span>全部分类</span><span>全部产品</span>-->
<div class="container">
    <!-- <div class="row">
        <div class="col-sm-2 col-md-2 col-lg-2 rowtitle">
            <span>全部分类</span>
        </div>
        <div class="rowtitle fl">
            <span>全部产品&gt;</span>
        </div>
    </div> -->
    <div class="addTisBox" id="addTisBox">
		<div class="bg" ></div>
		<div class="txtc">已添加</div>
	</div>
    <div class="row" style="margin-top: 5px;">
        <%--左侧：产品分类--%>
        <div style="width: initial;float:left">
            <%--<p class="rowtitle" style="margin-top: 13px;"><a href="javascript:showProdLibMsg('all',1);">全部产品</a></p>--%>
            <div id="prodTypeListDiv" style="width:200px;height:415px;overflow-y:scroll; overflow-x:scroll;"></div>
        </div>
        <%--右侧：产品--%>
        <div style="width:600px;padding-left:15px;height:435px;overflow:auto;float:left;text-align: -moz-center;">
             <div class="" style="wdith:580px;overflow:hidden">
                 <form id="form">            
		            <div class="table-formBox selectAreaBox noselect ipad">
		            	<input type="hidden" name="areaId" id="areaId">
		             	<input type="hidden" name="offerId" id="offerId">
		                <input type="hidden" id="prodTypeId">
		                <c:forEach items="${user.compDealerAuths}" var="compAuth">
		                 	<input type="hidden" id="buyRate_${compAuth.company}" value="${compAuth.buyRate}"/>
		                </c:forEach>
		                <table>
		                    <tbody id="selectAreaBox">        
		                        
		                    </tbody>
		                </table>
		            </div> 
		        </form>
             </div>
             <div class="" style="width:580px;overflow:hidden;margin-top:10px">
                 <table id="prodPicTable" style="border:none;width:580px;" >
                     <tbody></tbody>
                 </table>
                 <div id="kkpager" style="padding-bottom:15px">
                 </div>
             </div>
             
        </div>
        <!--  产品详情及产品选择弹窗 -->
        <span class="showProdLibAnddetail_btn" id="showProdLibAnddetail_btn">
        	<i class="selectProdlNum">0</i>
        </span>
        <div class="ProdLibAnddetailBox">
            <div class="ProdLibAnddetail-bg"></div>
            <div class="rightMune">
                <div class="mune-cont">
                	<div class="prodlib_panel" style="display:none">
                		<p class="mune-til">已选产品列表</p>
	                    <div class="mune-list">
	                        <div class="cont-scrol">
			                    <table class="table" style="align:center;margin-top: 9px;text-align: center;" id="prodSelectedTable">	     
			                    </table>
	                        </div>
	                    </div>
	                    
	                    <div class="mune-back-box">
	                    	<p class="selectProd">已选<span id="selectNum">0</span>件家具 </p>
	                        <a class="mune-back-btn" ontouchstart="addAllSelectedProd()">全部添加</a>
	                    </div>
                	</div>                  
                	<div class="prodlib_panel">
                		<p class="mune-til">产品信息<span ontouchstart="displayProdList();" class="ico glyphicon glyphicon-remove-sign"></span></p>
	                    <div class="mune-list">
	                        <div class="cont-scrol">
	                        	<table class="table" style="align:center;margin-top: 9px;text-align: center;border-collapse:separate;border-spacing:0px 10px;" id="selectFurDetailTable">
                    			</table>
	                        </div>
	                    </div>
	                    <div class="mune-back-box">
	                        <a class="mune-back-btn" id="selectThisProd">选择</a>
	                    </div>
                	</div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer_js.jsp" />
<script src="${prc }/common/js/bootstrap-treeview.js"></script>
<script src="${prc }/common/pager/kkpager.min.js"></script>
<script src="${prc }/common/lib/jquery-lightbox-0.5/js/jquery.lightbox-0.5.js"></script>
<script>

	/* 家具点击效果 */
	var furBtnAllToken = false;
	
	$('#prodPicTable').on('touchstart','.daskBtn.btn_add',function(){
		var that = $(this);
		if(!furBtnAllToken){
			furBtnAllToken = true;
			that.addClass('active');
            setTimeout(function(){
                that.removeClass('active');
                furBtnAllToken = false;
            },500);
		}
	});
	
	
	var saleProdArray = [];
	var delSaleProdId = '';
    var filepath = $('input[name="filepath"]').val();
    
    var treeMuneDataList;
    function ReSetTreeMune(fid){
    	var dataNodes = cpResult(treeMuneDataList,fid),
    		nodeId;
        
        $('#prodTypeListDiv').treeview({
            data: dataNodes, // 数据源
            showCheckbox: false, //是否显示复选框
            highlightSelected: true, //是否高亮选中
            //nodeIcon: 'glyphicon glyphicon-user', //节点上的图标 glyphicon-globe
            /*nodeIcon: 'glyphicon',*/
            expandIcon:'glyphicon-plus',
            collapseIcon:'glyphicon-minus',
            emptyIcon: 'glyphicon', //没有子节点的节点图标
            multiSelect: false, //多选
            onNodeSelected: function (event, data) {
            	
            	var lev;

            	if(!data.path){
            		is_topLevel = 'yes';
            	}
            	else{
            		lev = data.path.split(';');
            		if(lev.length == 1){
            			is_topLevel = 'yes';
            		}
            		else if(lev.length == 2 && !lev[1]){
            			is_topLevel = 'yes';
            		}
            	}
            	                    	                           	
                //选中的分类data.fid 显示对应的产品图片信息等
                removeSelectArea();
                showProdLibMsg(data.fid,1);
            }
        });
        nodeId = $('#prodTypeListDiv').find('li.node-selected').data('nodeid');
        $('#prodTypeListDiv').treeview('collapseAll', { silent: true });
        $('#prodTypeListDiv').treeview('revealNode', [ nodeId, { silent: true } ]);

    }
    
    $(function(){
        $.ajax({
            type: "Post",
            async:false,
            url:"${prc }/product/queryParentProdType",
            contentType: "application/json; charset=utf-8",
            success: function(result) {
                var proTypeList = result.proTypeList;
                //加载一级分类
                treeMuneDataList = [].concat(proTypeList);
                var dataNodes = cpResult(proTypeList);
                
                $('#prodTypeListDiv').treeview({
                    data: dataNodes, // 数据源
                    showCheckbox: false, //是否显示复选框
                    highlightSelected: true, //是否高亮选中
                    //nodeIcon: 'glyphicon glyphicon-user', //节点上的图标 glyphicon-globe
                    /*nodeIcon: 'glyphicon',*/
                    expandIcon:'glyphicon-plus',
                    collapseIcon:'glyphicon-minus',
                    emptyIcon: 'glyphicon', //没有子节点的节点图标
                    multiSelect: false, //多选
                    onNodeSelected: function (event, data) {
                    	var lev;

                    	if(!data.path){
                    		is_topLevel = 'yes';
                    	}
                    	else{
                    		lev = data.path.split(';');
                    		if(lev.length == 1){
                    			is_topLevel = 'yes';
                    		}
                    		else if(lev.length == 2 && !lev[1]){
                    			is_topLevel = 'yes';
                    		}
                    	}
                        //选中的分类data.fid 显示对应的产品图片信息等
                        removeSelectArea();
                        showProdLibMsg(data.fid,1);
                    }
                });
                //折叠所有的节点，折叠整个树
                $('#prodTypeListDiv').treeview('collapseAll', { silent: true });
                
            },
            error: function(err) {
            	 var opt = {};
  	    		opt.btnName = ['关闭'];
  	    		opt.til = '提示';
  	    		opt.tpls = '<div class="textAli-c">加载产品分类类目失败!'+err+'</div>';
  	    		opt.btnNum = 1;
  	    		window.top.runHomePublicPop(opt);
            }

        });
    });
    function showProdLibMsg_setVal(fid,isReflash,areaId,offerId,replSaleProdId){
    	if(areaId){
    		$("#areaId").val(areaId);
    	}
        if(offerId){
            $("#offerId").val(offerId);
        }
    	
        if(isReflash){
            // 清空购物车
            $("#prodSelectedTable").html("");
        }
        
        if(replSaleProdId){
        	delSaleProdId = replSaleProdId;
        }
        
        $("#prodTypeId").val(fid);    	
    }
    //根据选中的分类data.fid 显示对应的产品图片信息等
    function showProdLibMsg(fid,startPage,isReflash,areaId,offerId,replSaleProdId){

    	showProdLibMsg_setVal(fid,isReflash,areaId,offerId,replSaleProdId);
        
        if( fid === 'all'){
        	is_topLevel = 'yes';
        }
        
        function selectTreeNode(fid){
        	ReSetTreeMune(fid);
        }
        
        var dataForm = {"prodTypeId":fid,"startPage":startPage};
        
        $.ajax({
            url:"${prc }/product/toListProduces",
            type: "Post",
            async:false,
            dataType:"json",
            contentType: "application/json; charset=utf-8",
            data:JSON.stringify(dataForm),
            success: function(result) {
            	/* 动态查询区域 */
                selectAreaBoxForm(result.proPropertyVals);
                //展示产品信息
                showProdPic(result.produces);
                showPageInfo(fid,result.producesCount);
                $('#prodPicTable td .daskImg').lightBox();
            },
            error: function(err) {
            	var opt = {};
   	    		opt.btnName = ['关闭'];
   	    		opt.til = '提示';
   	    		opt.tpls = '<div class="textAli-c">加载产品信息失败!!</div>';
   	    		opt.btnNum = 1;
   	    		window.top.runHomePublicPop(opt);
            }
        });

    }
    function showProdLibMsg_fy(fid,startPage,isReflash,areaId,offerId,replSaleProdId){

    	showProdLibMsg_setVal(fid,isReflash,areaId,offerId,replSaleProdId);
        
        var dataForm = {"prodTypeId":fid,"startPage":startPage};
        
        $.ajax({
            url:"${prc }/product/toListProduces",
            type: "Post",
            async:false,
            dataType:"json",
            contentType: "application/json; charset=utf-8",
            data:JSON.stringify(dataForm),
            success: function(result) {
                //展示产品信息
                showProdPic(result.produces);
                showPageInfo(fid,result.producesCount);
                $('#prodPicTable td .daskImg').lightBox();
            },
            error: function(err) {
            	var opt = {};
   	    		opt.btnName = ['关闭'];
   	    		opt.til = '提示';
   	    		opt.tpls = '<div class="textAli-c">加载产品信息失败!!</div>';
   	    		opt.btnNum = 1;
   	    		window.top.runHomePublicPop(opt);
            }
        });

    }
   /*  function mouseoverEvent(obj){
        $(obj).find(".dask").css('display','block');
    }
    function onmouseoutEvent(obj){
        $(obj).find(".dask").css('display','none');
    } */
    
    var $kkpager = $('#kkpager'),
	$prodPicTable_tbody = $('#prodPicTable tbody');
    
    //展示产品信息（第一条sku图片+产品名称）
    function showProdPic(produces){
        $("#prodPicTable tbody").html("");
        
        //产品数
        var prodsLen = produces.length;
        //总共有rowcount行
        var rowcount = Math.ceil(prodsLen/3);
        
        if(!prodsLen){
        	$prodPicTable_tbody.html('<td style="width:200px;height:175px;padding-bottom: 5px;margin-right:80px;text-align:center;font-size:22px" title="">暂无数据</td>');
        	$kkpager.html('');
        	return;
        }

        var thumbnail = "<div style=\"width:170px;height:119px;margin-bottom: 0px;position:relative\" class=\"thumbnail\">";
        var caption = "<div style=\"width:126px;padding:5px 0px;line-height:normal \" class=\"caption\"><nobr>";
        var tail = "</div></nobr></div>";

            var $tr;
            for(var j = 0;j<prodsLen;j++){
                
                var img = "";
                var checkboxe0 = "";
                var content = "";
                var content2 = "";
                var htmltext = "";
                loop:for(var k=0;k<produces[j].skuList.length;k++){
                    var sku = produces[j].skuList[k];
                    var havaPic = false;
                    if(null != sku.files&& "" != sku.files){
                        for(var i=0;i<sku.files.length;i++){
                            if("02" == sku.files[i].type){
                                havaPic = true;
                                img += "<div class='imgWp'><img style=\"position:relative;\" src=\""+filepath+""+sku.files[i].path+"\" alt=\"\"></div>";
                                checkboxe0 += "<div class=\"\" style=\"margin-left: 173px;\"><input type=\"checkbox\" class=\"styled styled-primary\" id=\""+produces[j].fid+"\" name=\"productsCheckBox\" value=\""+produces[j].fid+"\" onclick=\"\" style=\"display:none\"/><label></label></div>";
                                content += "<span class=\"zxx_text_overflow_1\" name=\"produceName\" title=\""+produces[j].produceName+"\">"+produces[j].produceName+"</span><input type='hidden' name=\"modelNo\" value=\""+sku.modelNo+"\" /><input type='hidden' name=\"cost\" value=\""+sku.price+"\" /><input type='hidden' name=\"prodTypeId\" value=\""+produces[j].prodTypeId+"\" /><input type='hidden' name=\"companyId\" value=\""+produces[j].companyId+"\" />";
                               /*  content2 = "<div class=\"dask\"><p><button type=\"button\" onclick=\"selectFurDetail(this)\" class=\"btn btn-primary\">详情</button>&nbsp;&nbsp;&nbsp;<button name=\"picbtn\" type=\"button\" onclick=\"picChecked(this)\" class=\"btn btn-primary\">添加</button></p></div>"; */
                                content2 = "<div class=\"dask\"><a href=\""+filepath+""+sku.files[i].path+"\" class=\"daskImg\"></a><span class='daskBtn btn_add' ontouchstart=\"picChecked(this)\"></span><span class='daskBtn btn_detail' ontouchstart=\"selectFurDetail(this)\"></span></div>";
                               htmltext += thumbnail + img + caption + content + checkboxe0 + content2 + tail;
                                $td = $('<td style="width:140px;height:118px;padding-bottom: 5px;overflow:hidden;" title="" name="proimg"></td>');
                                $td.html(htmltext);
                                var tdCounttmp = 0;
                                if(null != $tr && "" != $tr){
                                    tdCounttmp = $tr[0].childNodes.length;
                                }
                                var newrowsign = tdCounttmp%3;
                                if(0 == newrowsign){
                                    $tr = $('<tr></tr>');
                                }
                                $tr.append($td);
                                $("#prodPicTable tbody").append($tr);
                                break loop;
                            }
                        }
                    }
                    /*无图片*/
                    if(!havaPic){
                        img += "<div class='imgWp'><img style=\"cursor:pointer;\" src=\"\" alt=\"无图片\"></div>";
                        checkboxe0 += "<div class=\"\" style=\"margin-left: 173px;\"><input type=\"checkbox\" class=\"styled styled-primary\" id=\""+produces[j].fid+"\" name=\"productsCheckBox\" value=\""+produces[j].fid+"\" onclick=\"\"  style=\"display:none\"/><label></label></div>";
                        content += "<span class=\"zxx_text_overflow_1\" name=\"produceName\" title=\""+produces[j].produceName+"\">"+produces[j].produceName+"</span><input type='hidden' name=\"modelNo\" value=\""+sku.modelNo+"\" /><input type='hidden' name=\"cost\" value=\""+sku.price+"\" /><input type='hidden' name=\"prodTypeId\" value=\""+produces[j].prodTypeId+"\" /><input type='hidden' name=\"companyId\" value=\""+produces[j].companyId+"\" />";
                        
                        content2 = "<div class=\"dask\"><a href=\""+filepath+""+sku.files[i].path+"\" class=\"daskImg\"></a><span class='daskBtn btn_add' ontouchstart=\"picChecked(this)\"></span><span class='daskBtn btn_detail' ontouchstart=\"selectFurDetail(this)\"></span></div>";
                        htmltext += thumbnail + img + caption + content + checkboxe0 + content2 +  tail;
                        $td = $('<td style="width:140px;height:118px;padding-bottom: 5px;" title="" name="proimg"></td>');
                        $td.html(htmltext);
                        var tdCounttmp = 0;
                        if(null != $tr && "" != $tr){
                            tdCounttmp = $tr[0].childNodes.length;
                        }
                        var newrowsign = tdCounttmp%3;
                        if(0 == newrowsign){
                            $tr = $('<tr></tr>');
                        }
                        $tr.append($td);
                        $("#prodPicTable tbody").append($tr);
                        break;
                    }
                }
                
            }
        //补充缺少的td
        var lastTrTdCount = $("#prodPicTable tbody tr:eq("+($("#prodPicTable tbody tr").length - 1)+") td").size();
        if(3 != lastTrTdCount && null != $tr){
            var tmp = 3 - lastTrTdCount;
            var $ltd = $('<td style="width:200px;height:175px;padding-bottom: 5px;" title=""></td>');
            for(var j=0;j<tmp;j++){
                $tr.append($ltd);
            }
        }
        //补充一行,使得分页显示位置不变
        /*  if($("#prodPicTable tbody tr").length < 2){
            var apptr = 2- $("#prodPicTable tbody tr").length;
            for(var k=0;k<apptr;k++){
                $tr = $('<tr></tr>');
                var $ltd = $('<td style="width:200px;height:195px;padding-bottom: 5px;" title=""></td>');
                $tr.append($ltd);
                $("#prodPicTable tbody").append($tr);
            }
        }  */
    }
    
    //复制对象数组
    function cpResult(arr){
        var newArray = [];
        var allProduct = {fid:"all",text:"全部产品",nodes:""};
        arr.unshift(allProduct);
        for(var i=0;i<arr.length;i++){
            newArray.push(arr[i]);
        }
        var datastr = JSON.stringify(newArray);
        datastr = datastr.replace(/name/g,"text");
        datastr = datastr.replace(/children/g,"nodes");
        newArray = JSON.parse(datastr);
        return newArray;
    }
    
    //获取选中的产品
    function getCheckedProds(){
        var prodSeleted = [];
        /*$('input[name="productsCheckBox"]:checked').each(function(){
            prodSeleted.push($(this).val());
        });*/
        $("#prodSelectedTable tr").each(function(){
            prodSeleted.push($(this).attr("fid"));
        });
        return prodSeleted;
    }
    
    var $selectProdlNum = $('.showProdLibAnddetail_btn .selectProdlNum');
    
    //改变选中的个数
    function selectNum(){
        var prodSeleted = getCheckedProds();
        $("#selectNum").html(prodSeleted.length);
        $selectProdlNum.html(prodSeleted.length);
    }
   /*  产品库关闭时清空件数 */
    function clearCountItem(){
    	$("#selectNum").html(0);
    	$selectProdlNum.html(0);
    }
    
    //显示家具详情
    function displayDetail(){
        $(".selectFurList").css('display','none');
        $(".selectFurDetail").css('display','block');
    }
    //显示已选产品列表
    function displayProdList(){
    	hiddenLeftMune();
    	showLeftMune(0);
        /* $(".selectFurList").css('display','block');
        $(".selectFurDetail").css('display','none'); */
    }
    var matSizeColInfo;
    function getProdSkuInfo(produceId){
        $.ajax({
            type: "GET",
            async:false,
            url:"${prc }/product/getMatSizeColArray",
            data:"produceId="+produceId,
            success: function(result) {
                matSizeColInfo = result;
            },
            error: function(err) {
            	var opt = {};
	    		opt.btnName = ['关闭'];
	    		opt.til = '提示';
	    		opt.tpls = '<div class="textAli-c">加载产品详情信息失败！</div>';
	    		opt.btnNum = 1;
	    		window.top.runHomePublicPop(opt);
            }
        });
    }
    function addCurrProInfo(name,value){
        var modelVal = "";
        var Html = "<span style=\"word-break:normal; width:auto; display:block; white-space:pre-wrap;word-wrap : break-word ;overflow: hidden ;padding-left: 8px;\">"+name+"：";
        var spanTail = "</span>";
        if("型号" == name){
            var j = 0;
            for(var i=0;i<value.length;i++){
                if(null != value[i]){
                    if(0 != j && 0 == j%3){
                        modelVal += value[i] + "<br>";
                    }else{
                        modelVal += value[i] + " ; ";
                    }
                    j++;
                }
            }
            Html += modelVal + spanTail;
        }else{
            Html += value + spanTail;
        }
        var $tr = $('<tr style="text-align: left;"></tr>');
        $td = $('<td style="width: 200px;"></td>');
        $td.html(Html);
        $tr.append($td);
        $("#selectFurDetailTable").append($tr);
    }
    function addmatSizeColInfo(name,arr){
        var Header;
        var Tail;
        var sparet;
        if("尺寸" == name){
            Header = "<div style=\"position:relative;padding-left: 8px;\">尺寸：<p style=\"position:absolute;margin-left:40px;float:left;margin-top: -20px;\">";
            Tail = "</p></div>";
            sparet = "<br>";
        }else{
            Header = "<p style=\"padding-left: 8px;\">"+name+"：";
            Tail = "</p>";
            sparet = "&nbsp;"
        }
        //颜色/材质/尺寸
        var span = "";
        for(var i = 0;i<arr.length;i++){
            if("风格" == name){
                span += arr[i].designId + sparet;
            }else{
                span += arr[i].optValue + sparet;
            }
        }
        var Html = Header + span + Tail;
        var $tr = $('<tr style="text-align: left;"></tr>');
        $td = $('<td style="width: 200px;"></td>');
        $td.html(Html);
        $tr.append($td);
        $("#selectFurDetailTable").append($tr);
    }
    
    /*  添加产品提示 */
    var $addTisBox = $('#addTisBox');
    function showAddProdTis(){
    	$addTisBox.show();
    	$addTisBox.stop().animate({opacity:0.9},300,function(){
    		$addTisBox.stop().animate({opacity:0},600,function(){
    			$addTisBox.hide();
    		});
    	});
    }
    
    //家具详情
    function selectFurDetail(currobj){
        $('#selectThisProd').click(function(){picChecked(currobj);
            displayProdList();
        });
        $("#selectFurDetailTable").html("");
        //显示家具详情
        displayDetail();
        obj = $(currobj).parents(".thumbnail").find('img')[0];
        //获取图片的src
        var imgsrc = obj.src;
        //获取家具编号
        var fid = $(obj).parents(".thumbnail").find('input[name="productsCheckBox"]')[0].value;
        //获取家具名称
        var proname = $(obj).parents(".thumbnail").find('span[name="produceName"]')[0].title;
        //获取家具型号
        var modelNo = $($(obj).parents(".thumbnail").find('input[name="modelNo"]')[0]).val();

        //添加第一行图片
        var imgTd = "<img src=\""+imgsrc+"\" style=\"width:200px;height:135px\"/>";
        var $tr1 = $('<tr style=""></tr>');
        $td1 = $('<td style="width: 200px;"></td>');
        $td1.html(imgTd);
        $tr1.append($td1);
        $("#selectFurDetailTable").append($tr1);
        //名称
        addCurrProInfo("名称",proname);
        //型号
        /*addCurrProInfo("型号",modelNo);*/
        //查询sku信息
        getProdSkuInfo(fid);
        addCurrProInfo("型号",matSizeColInfo.modelNoList);
        //风格
        addmatSizeColInfo("风格",matSizeColInfo.prodDesignList);
        //颜色
        addmatSizeColInfo("颜色",matSizeColInfo.colorList);
        //材质
        addmatSizeColInfo("材质",matSizeColInfo.materialList);
        //尺寸
        addmatSizeColInfo("尺寸",matSizeColInfo.sizeList);
    
        showLeftMune(1);
       
    }
    //添加家具
    function picChecked(currobj){
        //显示已选产品列表
        //displayProdList();
        obj = $(currobj).parents(".thumbnail").find('img')[0];
        //获取图片的src
        //错误写法(出现中文乱码)：var imgsrc = obj.src;
        var imgsrc = $(obj).attr('src');
        //获取家具编号
        var fid = $(obj).parents('.thumbnail').find('input[name="productsCheckBox"]')[0].value;
        //获取家具名称
        var proname = $(obj).parents('.thumbnail').find('span[name="produceName"]')[0].title;
      //获取家具型号
        var modelNo = $($(obj).parents('.thumbnail').find('input[name="modelNo"]')[0]).val();
      //产品企业
      	var companyId = $($(obj).parents('.thumbnail').find('input[name="companyId"]')[0]).val();
      
        var cost = $($(obj).parents('.thumbnail').find('input[name="cost"]')[0]).val() * $("#buyRate_"+companyId).val();
        
        //获取产品分类ID
        var prodTypeId = $($(obj).parents('.thumbnail').find('input[name="prodTypeId"]')[0]).val();

        var imgTd = "<img src=\""+imgsrc+"\" style=\"width:66px;height:50px\"/>";
        var pronameHtml = "<span class=\"textOverflow\" style='width:130px;display: block;' title=\""+proname+"\">"+proname+"</span>";
        var del = "<span></span><a href=\"javascript:void(0);\" onclick=\"delProduct(this,'"+fid+"')\" style='float: right;color: red;'>删除</a>";
        var proDel = pronameHtml + del;
        
        var div0 = "<div>";
        var $tr = $('<tr fid="'+fid+'" style="border-bottom: 1px solid #999999;"></tr>');
        $td = $('<td style="width: 74px;height: 55px;"></td>');
        $td.html(imgTd);
        $tr.append($td);
        $td2 = $('<td style="" class=""></td>');
        $td2.html(proDel);
        $tr.append($td2);
        $("#prodSelectedTable").append($tr);
        
        var picSrc = imgsrc.substring(imgsrc.indexOf(filepath)+filepath.length,imgsrc.length);
        
        var saleProd={
    			prodName:proname,
    			modelNo:modelNo,
    			prodId:fid,
    			picPath:picSrc,
    			modelNo:modelNo,
    			cost:cost,
    			prodTypeId:prodTypeId,
    			sellCompany:companyId
    			
    	};
        
        saleProdArray.push(saleProd);
        
        showAddProdTis();
        selectNum();

    }
    //删除已选的家具
    function delProduct(obj,fid){
        var tr=obj.parentNode.parentNode;
        var table=tr.parentNode;
        table.removeChild(tr);
        selectNum();
        // 清除数组
        for(var i = 0; i<saleProdArray.length;i++){
        	var saleProd = saleProdArray[i];
        	if(saleProd.prodId == fid){
        		saleProdArray.splice(i,1);
        		break;
        	}
        }
    }
    
    var tmpfid;
    //根据fid显示页码
    function showPageInfo(fid,producesCount){
        
        $("#kkpager").html("");
        var pageCount = Math.ceil(producesCount/6);
        //切换分类,重新生成分页
        if(tmpfid != fid){
            tmpfid = fid;
            $.getScript('${prc }/common/pager/kkpager.min.js',function(){
                //生成分页控件
                kkpager.generPageHtml({
                    pno : 1,
                    mode : 'click', //设置为click模式
                    //总页码
                    total : pageCount,
                    //总数据条数
                    totalRecords : producesCount,
                    isShowCurrPage:false,
                    isShowTotalRecords:true,
                    //点击页码、页码输入框跳转、以及首页、下一页等按钮都会调用click
                    //适用于不刷新页面，比如ajax
                    click : function(n){

                        //这里可以做自已的处理
                        showProdLibMsg_fy(tmpfid,n);
                        //处理完后可以手动条用selectPage进行页码选中切换
                        this.selectPage(n);
                    },
                    //getHref是在click模式下链接算法，一般不需要配置，默认代码如下
                    getHref : function(n){
                        return '#';
                    }

                });
            });
            
        }else{
            //生成分页控件
            kkpager.generPageHtml({
                pno : 1,
                mode : 'click', //设置为click模式
                //总页码
                total : pageCount,
                //总数据条数
                totalRecords : producesCount,
                isShowCurrPage:false,
                isShowTotalRecords:true,
                //点击页码、页码输入框跳转、以及首页、下一页等按钮都会调用click
                //适用于不刷新页面，比如ajax
                click : function(n){

                    //这里可以做自已的处理
                    showProdLibMsg_fy(tmpfid,n);
                    //处理完后可以手动条用selectPage进行页码选中切换
                    this.selectPage(n);
                },
                //getHref是在click模式下链接算法，一般不需要配置，默认代码如下
                getHref : function(n){
                    return '#';
                }

            });
        }
        
    }
    
    window.onresize = function () {
        parent.SetOffWinHeight();
    };
    
    function doSubmit(addParam){
    	var width = $("#width").val();
    	var depth = $("#depth").val();
    	var heigth = $("#heigth").val();
    	var prodTypeId = $("#prodTypeId").val();
    	var minMoney = $("#minMoney").val();
    	var maxMoney = $("#maxMoney").val();
    	var material = $('input[name="materialRadio"]:checked').val();
    	var produceName = $("#produceName").val();
    	dataForm = {"prodTypeId":prodTypeId,
    				"width":width,
    				"depth":depth,
    				"heigth":heigth,
    				"minMoney":minMoney,
    				"maxMoney":maxMoney,
    				"material":material,
    				"produceName":produceName,
                    "startPage" :1
    				};
    	if(addParam){
    		if( !publicIsType('array',addParam)){
    			return;
    		} 
    		dataForm['dynamicCondition'] = addParam;
    	}
        $.ajax({
            type: "Post",
            async:false,
            url:"${prc }/product/toListProduces",
            data:JSON.stringify(dataForm),
            dataType:"json",
            contentType: "application/json; charset=utf-8",
            success: function(result) {
                //展示产品信息
                showProdPic(result.produces);
                if(!result.produces.length){
                	return;
                }
                showPageInfoBydataForm(dataForm,result.producesCount);
            },
            error: function(err) {
            	var opt = {};
	    		opt.btnName = ['关闭'];
	    		opt.til = '提示';
	    		opt.tpls = '<div class="textAli-c">加载产品详情信息失败！</div>';
	    		opt.btnNum = 1;
	    		window.top.runHomePublicPop(opt);
            }
        });
    }
    function showProdLibMsgBydataForm(dataForm){
        $.ajax({
            type: "Post",
            async:false,
            url:"${prc }/product/toListProduces",
            data:JSON.stringify(dataForm),
            dataType:"json",
            contentType: "application/json; charset=utf-8",
            success: function(result) {

            	/* 动态查询区域 */
                selectAreaBoxForm(result.proPropertyVals);
                //展示产品信息
                showProdPic(result.produces);
                showPageInfo(fid,result.producesCount);
            },
            error: function(err) {
            	var opt = {};
	    		opt.btnName = ['关闭'];
	    		opt.til = '提示';
	    		opt.tpls = '<div class="textAli-c">加载产品详情信息失败！</div>';
	    		opt.btnNum = 1;
	    		window.top.runHomePublicPop(opt);
            }
        });
    }
    var dataFormtmp;
    //根据fid显示页码
    function showPageInfoBydataForm(dataForm,producesCount){
        $("#kkpager").html("");
        var pageCount = Math.ceil(producesCount/6);
        //切换分类,重新生成分页
        if(dataFormtmp != dataForm){
            dataFormtmp = dataForm;
            $.getScript('${prc }/common/pager/kkpager.min.js',function(){
                //生成分页控件
                kkpager.generPageHtml({
                    pno : 1,
                    mode : 'click', //设置为click模式
                    //总页码
                    total : pageCount,
                    //总数据条数
                    totalRecords : producesCount,
                    isShowCurrPage:false,
                    isShowTotalRecords:true,
                    //点击页码、页码输入框跳转、以及首页、下一页等按钮都会调用click
                    //适用于不刷新页面，比如ajax
                    click : function(n){
                    	//这里可以做自已的处理
                        showProdLibMsg(tmpfid,n);
                        //处理完后可以手动条用selectPage进行页码选中切换
                        this.selectPage(n);
                    },
                    //getHref是在click模式下链接算法，一般不需要配置，默认代码如下
                    getHref : function(n){
                        return '#';
                    }

                });
            });

        }else{
            //生成分页控件
            kkpager.generPageHtml({
                pno : 1,
                mode : 'click', //设置为click模式
                //总页码
                total : pageCount,
                //总数据条数
                totalRecords : producesCount,
                isShowCurrPage:false,
                isShowTotalRecords:true,
                //点击页码、页码输入框跳转、以及首页、下一页等按钮都会调用click
                //适用于不刷新页面，比如ajax
                click : function(n){
                	//这里可以做自已的处理
                    showProdLibMsg(tmpfid,n);
                    //处理完后可以手动条用selectPage进行页码选中切换
                    this.selectPage(n);
                },
                //getHref是在click模式下链接算法，一般不需要配置，默认代码如下
                getHref : function(n){
                    return '#';
                }
            });
        }
    }
    
    function addAllSelectedProd(){
    	if(delSaleProdId!=''){
    		replSaleProd();
    	}
    	
    	form = {"prods":saleProdArray,
				"areaId":$("#areaId").val(),
            	"offerId":$("#offerId").val()
			   };
    	
    	 $.ajax({
             type: "Post",
             async:true,
             url:"${prc}/offerList/toSaveProdSelected",
             data:JSON.stringify(form),
             dataType:"json",
             contentType: "application/json; charset=utf-8",
             success: function(result) {
            	 parent.parent.selectSaleProd($("#areaId").val());
            	 window.parent.closeMyModalPop();
             },
             error: function(err) {
            	 var opt = {};
 	    		opt.btnName = ['关闭'];
 	    		opt.til = '提示';
 	    		opt.tpls = '<div class="textAli-c">加载产品详情信息失败！'+err+'</div>';
 	    		opt.btnNum = 1;
 	    		window.top.runHomePublicPop(opt);
             }
         });
    }
    
    function replSaleProd(){
    	$.ajax({
            type: "GET",
            async:true,
            url:"${prc }/offerList/deleteSaleProd",
            data:"saleProdId="+delSaleProdId,
            success: function(result) {
           	
            },
            error: function(err) {
            }
        });
    }
    
    /* 选择产品时清除查询表单的内容 */
    
    var $form_el = $('#form');
    
    function removeSelectArea(){
    	$form_el[0].reset();
    }
    
    /* 产品信息及添加产品菜单 */
    var $leftMune = $('.ProdLibAnddetailBox');
        $leftMune_btn = $('#showProdLibAnddetail_btn'),
        $prodPanel = $leftMune.find('.prodlib_panel'),
        $leftMune_bg = $('.ProdLibAnddetail-bg');

    $leftMune_btn.on('touchstart',function(e){
    	e.stopPropagation();
        if($leftMune.hasClass('active')){
            hiddenLeftMune();
        }
        else{
            showLeftMune(0);
        }

    });

    function hiddenLeftMune(){
        $leftMune.removeClass('active');
        $prodPanel.hide();
    }

    function showLeftMune(ind){
    	$prodPanel.eq(ind).show();
        $leftMune.addClass('active');
    }
	
    $leftMune_bg.on('touchstart',function(e){
        e.stopPropagation();
        $leftMune_bg.animate({opacity:0},300,'linear',function(){
        	hiddenLeftMune();
        	$leftMune_bg.css({opacity:0.15});
        });
    });
   
    

	/* 动态筛选 */
	
    var $prodTypeId_sl = $('#prodTypeId'),
        prodTypeId_sl,
        $slectAreaBox_sl = $('#selectAreaBox'),
        MaxColNum_sl = 4,
        multy_single_sel,
        is_topLevel = 'no',
        is_paging = 'no',
        tpls_size = '',
        tpls_cost = '',
        tpls_prodName = '',
        tpls_material_strat = '',
        tpls_material_btn = '',
        tpls_material_end = '',
        tpls_material_more='',
        tpls_submit_btn = '';


    tpls_size += '<tr>';
        tpls_size += '<td>';
            tpls_size += '<label class="opt-til"><span>尺寸/mm：</span></label> ';     
        tpls_size += '</td>';
        tpls_size += '<td class="clearfix ">';
            tpls_size += '<div class="input-size">';
                tpls_size += '<input class="sm-inp" type="text" id="width" placeholder="长度" value="" style="width:110px" >';
                tpls_size += '<span>-</span>';
                tpls_size += '<input class="sm-inp" type="text" id="depth" placeholder="宽度" value="" style="width:110px">';
                tpls_size += '<span>-</span>';
                tpls_size += '<input class="sm-inp" type="text" id="heigth" placeholder="高度" value="" style="width:110px">';
            tpls_size += '</div>';
        tpls_size += '</td>';
    tpls_size += '</tr>';
    
    tpls_cost += '<tr>';
        tpls_cost += '<td>';
            tpls_cost += '<label class="opt-til"><span>成本/元：</span></label>';      
        tpls_cost += '</td>';
        tpls_cost += '<td class="clearfix ">';
            tpls_cost += '<div class="input-size">';
                tpls_cost += '<input class="sm-inp" type="text" id="minMoney" placeholder="￥" value="" style="width:110px">';
                tpls_cost += '<span>-</span>';
                tpls_cost += '<input class="sm-inp" type="text" id = "maxMoney" placeholder="￥" value="" style="width:110px">';
            tpls_cost += '</div>';
        tpls_cost += '</td>';
    tpls_cost += '</tr>';

    tpls_prodName += '<tr>';
        tpls_prodName += '<td>';
            tpls_prodName += '<label class="opt-til"><span>产品名称：</span></label>';      
        tpls_prodName += '</td>';
        tpls_prodName += '<td class="clearfix ">';
            tpls_prodName += '<div class="input-size">';
                tpls_prodName += '<input class="big-inp" type="text" id="produceName" placeholder="产品名称" value="" style="width:362px">';
            tpls_prodName += '</div>';
        tpls_prodName += '</td>';
    tpls_prodName += '</tr>';
    
    tpls_submit_btn += '<tr>';
        tpls_submit_btn += '<td class="submit-btn" colspan="2">';
            tpls_submit_btn += '<a ontouchstart="selectAareaSub()">筛选</a>';      
        tpls_submit_btn += '</td>';
    tpls_submit_btn += '</tr>';

    tpls_material_strat += '<tr>';
        tpls_material_strat += '<td>';
            tpls_material_strat += '<label class="opt-til"><span>材质：</span></label>';      
        tpls_material_strat += '</td>';
        tpls_material_strat += '<td class="clearfix ">';
            tpls_material_strat += '<div class="valueWrap">';
                tpls_material_strat += '<div class="opt-box"> ';                                       
                tpls_material_btn += '</div>';
                tpls_material_btn += '<div class="more-btn-box">';
                tpls_material_btn += '<a class="multy-btn" ontouchstart="SelectMultyShowFn(this)" ><i></i>多选</a>';
                    tpls_material_more += '<a class="more-btn" ontouchstart="SelectShowToggleFn(this);" data-isopen="no"><span class="down">更多</span><span class="up">收起</span><i></i></a>';
                tpls_material_end += '</div>';
                tpls_material_end += '<div class="multyBtnBox">';
                    tpls_material_end += '<span class="btn-true" ontouchstart="multyChoose(this)">确定</span>';
                    tpls_material_end += '<span class="btn-fasle" ontouchstart="SelectMultyHideFn(this)">取消</span>';
                tpls_material_end += '</div>';
            tpls_material_end += '</div>';
        tpls_material_end += '</td>';
    tpls_material_end += '</tr>';
    
    function selectAreaBoxForm(data_obj){
        
        var res = data_obj,
            tpls = '',
            list_len = res.length,
            val,
            val_len,
            temp,
            temp2,
            temp_i = 0,
            temp_k,
            material_arr,
            temp_k = 0;
        
        for(;temp_k < list_len;temp_k++){
            if( data_obj[temp_k].name === '材质'){
                material_arr = data_obj[temp_k].values;
                break;
            }
        }
            
        if(is_topLevel === 'yes'){
            for(;temp_k < list_len;temp_k++){
                if( data_obj[temp_k].name === '材质'){
                    material_arr = data_obj[temp_k].values;
                    break;
                }
            }
            
            selectArea_randle({boxId:$slectAreaBox_sl,insetText:['size','cost','material[0]','prodName','submintBtn'],otherEl:[material_arr]});
            is_topLevel = 'no';
        }
        else{
            
            for(;temp_i < list_len;temp_i++){
                
                temp = res[temp_i];
                    
                tpls += '<tr>';
                    tpls += '<td>';
                        tpls += '<label class="opt-til"><span>'+temp.name+'：</span></label>';      
                    tpls += '</td>';
                    tpls += '<td class="clearfix">';
                        tpls += '<div class="valueWrap">';
                            tpls += '<div class="opt-box">';
                            
                                temp2 = temp.values;
                                val_len = temp2.length;
                                temp_k = 0;
                                for(;temp_k < val_len;temp_k++){
                                    tpls += '<label class="option-l" style="width:110px;"><span ontouchstart="screen_single(event)" style="max-width:110px;">'+temp2[temp_k]+'<i class="clo"></i></span></label>';
                                }          
               
                            tpls += '</div>';
                            tpls += '<div class="more-btn-box">';
                                tpls += '<a class="multy-btn" ontouchstart="SelectMultyShowFn(this)" ><i></i>多选</a>';
                            
                            if(val_len > MaxColNum_sl){
                                tpls += '<a class="more-btn" ontouchstart="SelectShowToggleFn(this);" data-isopen="no"><span class="down">更多</span><span class="up">收起</span><i></i></a>';
                            }  
                                
                            tpls += '</div>';
                            tpls += '<div class="multyBtnBox">';
                                tpls += '<span class="btn-true" ontouchstart="multyChoose(this)">确定</span>';
                                tpls += '<span class="btn-fasle" ontouchstart="SelectMultyHideFn(this)">取消</span>';
                            tpls += '</div>';
                        tpls += '</div>';
                    tpls += '</td>';
                tpls += '</tr>';
        
            }           
            
            selectArea_randle({boxId:$slectAreaBox_sl,insetText:['size','cost','other','prodName','submintBtn'],otherEl:[tpls]});
            is_topLevel = 'no';
        } 
        
    }   
    
    function selectAareaSub(){
        var val = getSelectAllVal();
        if(val.length){
            doSubmit(val);
        }
        else{
            doSubmit();
        }
    }
    
    function multyChoose(obj_js){
        var $self = $(obj_js),
            $wrapVal = $self.parents('.valueWrap'),
            $sel_el,
            temp_str = '',
            val = [],
            len;

        if( !$wrapVal.hasClass('multy-open') ){
            return;
        }

        val = getSelectAllVal();
        if(!val.length){
            return;
        }
        doSubmit(val);
        SelectMultyHideFn(obj_js);
    }
    
    function getSelectAllVal(){
        var $valWrap = $slectAreaBox_sl.find('.valueWrap'),
            $valEl,
            $_el,
            temp_len,
            temp_el,
            temp ='',
            val = [],
            len = $valWrap.length;
       
        for(;len--;){
            $_el = $valWrap.eq(len);
            temp = '';
            if($_el.hasClass('multy-select')){
                temp_el = $_el.find('.on-sel');
                temp_len = temp_el.length;
                if(!temp_len){
                
                }
                else{
                    for(;temp_len--;){
                        temp += ';'+temp_el.eq(temp_len).find('span').text();
                    }
                    temp = temp.substr(1);
                    val[val.length] = temp;
                }
                
            }
            else{   
                temp_el = $_el.find('.on-sel span');
                if(!temp_el.length){
                    continue;
                }
                val[val.length] = temp_el.text();
            }
            
        }
        return val;
    }
    
    
    function screen_single(e){

        var ent = e || window.event,
            obj_js = ent.currentTarget || e.srcElement,
            $self = $(obj_js),
            $opt_l = $self.parent(),
            $valueWrap = $self.parents('.valueWrap'),
            len,
            val=[],
            $self_span,
            $valEl;
    
        if(ent.stopPropagation){
            ent.stopPropagation();
        }
        else{
            ent.cancelable = true;
        } 
               
       if( $valueWrap.hasClass('multy-open') ){
            
           //多选
           if($opt_l.hasClass('on-sel')){
               $opt_l.removeClass('on-sel');               
                
               len = $valueWrap.find('.on-sel').length;
        
               if(len == 0){
                   $valueWrap.removeClass('multy-select');
               }
           }
           else{
               $opt_l.addClass('on-sel');   
               $valueWrap.addClass('multy-select');
           }
           
       }
       else{
                   
           if($opt_l.hasClass('on-sel')){
               $valueWrap.find('.on-sel').removeClass('on-sel');
           }
           else{
               $valueWrap.find('.on-sel').removeClass('on-sel');
               $opt_l.addClass('on-sel');   
           }
           
           //单选  查找产品 

           val = getSelectAllVal();
           if(!val.length){
        	   doSubmit();
           }
           else{
        	   doSubmit(val);		   
           }
            
       }
            
    }
    
      function multyRemoveSleFn(e){
           var ent = e || window.event,
               obj_js = ent.currentTarget || e.srcElement,
               $self = $(obj_js),
               $valueWrap = $self.parents('.valueWrap'),
               len;
    
           if(ent.stopPropagation){
               ent.stopPropagation();
           }
           else{
               ent.cancelable = true;
           }    
    
           $self.parents('.option-l').removeClass('on-sel');
    
           len = $valueWrap.find('.on-sel').length;
    
           if(len == 0){
               $valueWrap.removeClass('multy-select');
           }
       }

    
       var $selectAreaBox = $('#selectAreaBox');
    
       function SelectMultyShowFn(obj_js){
           var $self = $(obj_js),
               $valueWrap = $self.parents('.valueWrap'),
               temp_ind = '',
               old_len;
           
           $valueWrap.addClass('multy-open');
           SelectShowMoreFn($self);
       }
    
       function SelectMultyHideFn(obj_js){
           var $self = $(obj_js),
               $valueWrap = $self.parents('.valueWrap'),
               $temp_el,
               $old_el,
               old_ind,
               old_ind_arr = [],
               old_in_len;
    
           $valueWrap.removeClass('multy-open');
           SelectHideMoreFn($self);
       }
    
       function SelectShowToggleFn(obj_js){
           var $self = $(obj_js),
               token = $self.data('isopen');
    
           if(token === 'no'){
               SelectShowMoreFn($self);
               token = 'yes';
           }
           else{
               SelectHideMoreFn($self);
               token = 'no';
           }
    
           $self.data('isopen',token);
    
       }
    
       function SelectShowMoreFn(obj_jq){
    
           var $self = obj_jq,
               $valueWrap = $self.parents('.valueWrap');
    
           $valueWrap.addClass('valBox-open');
       }
    
       function SelectHideMoreFn(obj_jq){
    
           var $self = obj_jq,
               $opt_box = $self.parent().prev('.opt-box'),
               $valueWrap = $self.parents('.valueWrap');

           $opt_box.scrollTop(0);
           $valueWrap.removeClass('valBox-open');
    
       }
       
       function selectArea_randle(opt){

           if( !publicIsType('object',opt) ){
               opt = {};
           }

           var opts = {
                   boxId : '',
                   insetText : 'all',
                   otherEl : '',
               },
               $dynamicSearchBox,
               type = false,
               tpls = '',
               temp,
               temp_i = 0,
               temp_len,
               joinTpl,
               dealwithOther,
               dealwithMaterial,
               init;

           init = function(){
               _selfMagerParm(opts,opt);

               if( publicIsType('object',opts.boxId) ){
                   $dynamicSearchBox = opts.boxId;
               }
               else if( publicIsType('string',opts.boxId) ){
                   opts.boxId = publicRegxMethod.contOneSpace(opts.boxId);
                   temp = opts.boxId.split(' ');

                   if(temp.length > 1){
                       $dynamicSearchBox = $(opts.boxId);
                   }
                   else{
                       $dynamicSearchBox = $('#'+opts.boxId);
                   }   
               }
           };

           dealwithMaterial = function(str){
               var ind,
                   i = 0,
                   tpls_material_temp='',
                   temp,
                   isMore = '',
                   len;

               if( str.indexOf('[') !== -1 ){
                   if( !publicIsType('array',opts.otherEl) ){
                       return;
                   }
                   ind = str.split('[')[1].split(']')[0];
                   if(!opts.otherEl[ind] || !publicIsType('array',opts.otherEl[ind] )){
                       return;
                   }

                   len = opts.otherEl[ind].length;
                   temp = opts.otherEl[ind];
                   
                   if(len > MaxColNum_sl){
                       isMore = tpls_material_more;
                   }

                   for(;i<len;i++){
                       tpls_material_temp += '<label style="width:110px;" class="option-l"><span style="max-width:110px;" ontouchstart="screen_single(event)">'+temp[i]+'<i class="clo"></i></span></label>';
                   }
                    
               }

               tpls += tpls_material_strat+tpls_material_temp+tpls_material_btn+isMore+tpls_material_end;
           };

           dealwithOther = function (str){

               if(str.indexOf('material[') !== -1){
                   dealwithMaterial(str);
                   return;
               }

               var ind;

               if( str.indexOf('other') === -1 ){
                   return;
               }

               if( str.indexOf('[') !== -1 ){
                   if( !publicIsType('array',opts.otherEl) ){
                       return;
                   }
                   ind = str.split('[')[1].split(']')[0];
                   if(!opts.otherEl[ind]){
                       return;
                   }
                   tpls += opts.otherEl[ind];
               }
               else{
                   tpls += opts.otherEl[0];
               }
           };

           joinTpl = function(type){

               switch(type){
                   case 'size' : tpls += tpls_size;
                       break;
                   case 'cost' : tpls += tpls_cost;
                       break;
                   case 'prodName' : tpls += tpls_prodName;
                       break;
                   case 'submintBtn' : tpls += tpls_submit_btn;
                       break;
                   default : dealwithOther(type);
                       break;
               }

           };

           init();

           if(opts.insetText !== 'all'){
               if(!publicIsType('array',opts.insetText)){
                   return;
               }        
           }
                  
           if(opts.insetText === 'all'){
               tpls += tpls_size+tpls_cost+tpls_material+tpls_prodName;
           }
           else{
               temp_len = opts.insetText.length;

               for(;temp_i<temp_len;temp_i++){
                   joinTpl(opts.insetText[temp_i]);
               }
           }

           $dynamicSearchBox.html('');
           $dynamicSearchBox.append(tpls);

       }
       
    
    /* 动态筛选 end*/
    
   
	
</script>
</body>
</html>
