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
    <!-- Bootstrap -->
    <link rel="stylesheet" href="${prc }/common/css/prodLib_slectArea.css"/>
	<jsp:include page="../common/head_css.jsp"/>
    <link href="${prc }/common/css/bootstrap-treeview.css" rel="stylesheet">
    <link rel="stylesheet" href="${prc }/common/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="${prc }/common/css/build.css"/>
    <%-- <link rel="stylesheet" href="${prc }/common/pager/kkpager_blue.css"/> --%>
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
            width:10em;
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
        .dask{width:190px;height:160px;/* background:rgba(232, 228, 228, 0.65); */position:absolute;vertical-align: middle;margin-top:-180px;display:none;}
        .dask p{
            color:#fff;
            margin-top: 110px;
            margin-left: 35px;
        }
        .dask a{color:green;text-decoration:none}
        .thumbnail:hover{border-color:#28b5d6}
        /* .cameraBox{position:relative;display:inline-block;*display:inline;*zoom:1}
        .cameraBox .cameraImg{position:absolute;widht: right:5px;top:50%;margin-top:-} */
        .cameraBox input[type="text"],.cameraBox .cameraImg{float:left}
        .showProdLibAnddetail_btn{position:fixed;right:0;top: 50%;width:72px;height:72px;margin-top: -36px;background:url('${prc }/common/img/prodlib_selectedProduct_btn.png') no-repeat;}
        .showProdLibAnddetail_btn:hover{cursor:pointer}
        .showProdLibAnddetail_btn .selectProdlNum{font-size:12px;position:absolute;right:2px;top:-8px;width:24px;height:24px;border-radius: 50%;background-color: #f60;color:#fff;line-height: 24px;text-align: center;font-size:14px;} 
        /* 产品详情及产品选择弹窗 */
		.ProdLibAnddetailBox{position:relative;z-index: 2;}
		.ProdLibAnddetail-bg{background-color: #000;position:fixed;left:0;top:0;width:100%;height:100%;opacity: 0.15;display:none;}
		.rightMune{position:fixed;width:310px;height:100%;right:-320px;top:0;transition:transform 0.6s ease 0.01s;-webkit-transition:-webkit-transform 0.6s ease 0.01s;background-color:#fff}
		.ProdLibAnddetailBox.active .ProdLibAnddetail-bg{display:block;}
		.ProdLibAnddetailBox.active .rightMune{transform:translateX(-300px);-webkit-transform:translateX(-300px);}
		
		
		.rightMune .mune-cont{position:relative;height:100%;width:300px;box-shadow: 5px 0px 5px rgba(0, 0, 0, 0.349019607843137);background-color: #fff;}
		.rightMune .mune-til{line-height: 44px;border-bottom:1px solid #ddd;font-size: 16px;color:#333;text-align: center;position:absolute;left:0;top:0;width:100%;z-index: 2;}
		.rightMune .mune-til .ico{color: #337ab7; margin-left: 5px;}
		.rightMune .mune-til .ico:hover{cursor:pointer}
		.rightMune .mune-list{position:absolute;left:0;top:44px;bottom:72px;width:100%;}
		.rightMune .cont-scrol{overflow-y: scroll;overflow-x:hidden;height:100%;width:292px;border-bottom: 1px solid #ddd;}
		
		.rightMune .mune-back-box{position:absolute;left:0;bottom:0;width:100%;}
		.rightMune .mune-back-btn{display:block;line-height: 34px;text-align: center;font-size: 13px;color:#fff;background-color: #337ab7;z-index: 2;}
		.rightMune .mune-back-btn:hover{cursor:pointer}
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
        .dask .daskImg{position:absolute;width:100%;height:100%;left:0;top:0;cursor: url(${prc}/common/img/zoomin.cur), pointer !important;}
        .dask p{position:relative;}
        #lightbox-container-image-box{max-width:620px !important;}
        #lightbox-container-image-data-box{max-width:600px !important;}
        #lightbox-container-image-box{max-height:480px}
        #lightbox-container-image.wid-img img{max-width:600px;max-height:490px;}
        #lightbox-container-image.hei-img img{max-width:280px;max-height:410px;}
        .thumbnail{overflow:hidden;position:relative}
        .thumbnail .imgWp{width:190px;height:160px;overflow:hidden;display:table-cell;text-align:center;vertical-align:middle;}
        .thumbnail img{max-width:100%;max-height:100%;}
        .ProdLibAnddetailBox .mune-cont td{border-bottom:1px solid #999;padding: 4px 0 4px;}
        
        .container .addTisBox{position:absolute;left:0;top:0;width:100%;height:30px}
        .container .addTisBox .bg{position:absolute;left:0;top:0;heihgt:100%;width:100%;background-color:#337ab7}
        .container .addTisBox .txtc{position:relative;text-align:center;line-height:30px;color:#fff;font-size:14px;}
        
        .leftMune .list-group-item:first-child{padding:0;heihgt:50px;line-height:50px;border-top:0;}
        .leftMune .list-group-item:first-child span{display:none}
        .leftMune .list-group-item .glyphicon-plus,.leftMune .list-group-item .glyphicon-minus{font-size:0;overflow:hidden;text-indent:-999px;}
        .leftMune .list-group-item .glyphicon-plus{width:12px;height:16px;background:url('${prc}/common/img/offetlist/prodlib_leftMune_ico.png') no-repeat -12px 2px;position:absolute;right:5px;top:50%;margin-top: -8px;}
    	.leftMune .list-group-item .glyphicon-minus{width:16px;height:12px;background:url('${prc}/common/img/offetlist/prodlib_leftMune_ico.png') no-repeat 2px 2px;position:absolute;right:5px;top:50%;margin-top: -6px;}
    	.leftMune .list-group-item{text-align:center;} 
    	.leftMune .list-group-item .indent,.leftMune .list-group-item .node-icon{display:none;}
    	
    	.leftMune .list-group-item.level2{background-color:#f1f1f1;}
    	.leftMune .list-group-item.level2 .expand-icon{display:none;}
    
    	.leftMune .list-group-item.node-selected .glyphicon-minus{background-position: -27px 2px;}
    	.leftMune .list-group-item.node-selected .glyphicon-plus{background-position: -45px 2px;}
    	
 		.prodLibheiBox .leftMuneScroll{position:absolute;width:160px;left: 0;top:0;bottom:0;overflow:hidden;}
    
    	.rightMune .prodlibInfoImg{max-width:200px;max-height:130px;}
    	.rightMune .moreShowBox{display:none;}
    	.rightMune .ShowinfoBox{float:left;width:215px;}
    	.rightMune .baseShowBox{position:relative;}
   		.rightMune .baseShowBox,.rightMune .moreShowBox{margin-right:15px} 
  		
  		.rightMune .showMoreProdInfo{color:#333;position:absolute;top:0;right:-12px;width:22px;height:15px;background:url('${prc}/common/img/offetlist/prodlib_ico.png') no-repeat -76px 4px;margin-left:5px;}
		.rightMune .showMoreProdInfo:hover{background-position: -97px 4px;} 	
  		.rightMune .showMoreProdInfo.active{background-position:7px 2px}
  		.rightMune .showMoreProdInfo.active:hover{background-position:-10px 3px}
  
    	
    	.leftMune .list-group-item:first-child,.leftMune .list-group-item:last-child{border-radius:0;}
    	.leftMune .list-group-item{border-left: 0;border-right: 0;}
    	    
    	.prodlibTil{height:50px;line-height:50px;text-align:center;}    
    	.prodlibTil .til{font-size:16px;color:#333;}	
    	
    	#prodRightBox .close{position:absolute;right:4px;top:4px;width:30px;height:30px;}
    
    	#prodRightBox .table-formBox td{border-color:#ddd;}
    	
    	#prodRightBox .table-formBox tr td:first-child{background-color:#fff;}
    	
    	.prodlibImgtabBox{width:830px;margin: 0 auto;}
    	img[src=""],img:not([src]){opacity:0}
    
    </style>
    
</head>
<body style="background-color:transparent">
<input type="hidden" name="filepath" value="${filepath}"/>
<%--<span>全部分类</span><span>全部产品</span>--%>
<div class="container position-r prodLibheiBox">
    <!-- <div class="row">
        <div class="col-sm-2 col-md-2 col-lg-2 rowtitle">
            <span>全部分类</span>
        </div>
        <div class="col-sm-10 col-md-10 col-lg-10 rowtitle">
            <span>全部产品&gt;</span>
        </div>
    </div> -->
    <div class="row" style="min-height:820px">
        <%--左侧：产品分类--%>
        <div style="width: initial;float:left" class="leftMune">
            <%--<p class="rowtitle" style="margin-top: 13px;"><a href="javascript:showProdLibMsg('all',1);">全部产品</a></p>--%>
          
            <div class="leftMuneScroll">
				<div id="prodTypeListDiv" style="height:100%;overflow-y:auto;"></div>
			</div>
            
        </div>
        <%--右侧：产品--%>
        <div style="margin-left:160px;overflow:hidden;text-align: -moz-center;" id="prodRightBox">
             <div class="" style="margin: 0 0 10px 0;">
             	 <button type="button" class="close" onclick="prodlib_closeBtn();" >
	                &times;
	             </button>
                 <div class="prodlibTil">
					<span class="til" id="prodlibTilName">全部产品</span>
				 </div>
                 <!-- 暂时不做<div class="crumbCon">
	                <ul class="clearfix">
	                    <li>
	                        <a href="" class="til-lab">全部产品</a><span class="til-lab">&gt;</span>
	                    </li>
	                </ul>
	            </div> -->
	            <form id="form" action="${prc }/imageSearch/searchSimialImage" method="post" enctype="multipart/form-data">            
		            <div class="table-formBox selectAreaBox noselect">
		            	<input type="hidden" name="areaId" id="areaId">
		             	<input type="hidden" name="offerId" id="offerId">
		                <input type="hidden" id="prodTypeId" name="proTypeId">
		                <input type="hidden" id="fingerprint">
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
             <div class="clearfix prodlibImgtabBox">
                 <table id="prodPicTable" style="border:none;width:100%;" >
                     <tbody></tbody>
                 </table>
                 <div class="iframe-pagingBox clearfix padding-t-15 padding-b-10">
		            <!-- <a class="firstPage-btn" onclick="return kkpager._clickHandler(1)" id="firstPage-btn">首页</a> -->
		            <div class="pageing" id="kkpager">  
		            </div>
		        </div>
             </div>
        </div>
        <!--  产品详情及产品选择弹窗 -->
        <!-- <span class="showProdLibAnddetail_btn" id="showProdLibAnddetail_btn">
        	<i class="selectProdlNum">0</i>
        </span> -->
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
	                        <a class="mune-back-btn" onclick="addAllSelectedProd()">全部添加</a>
	                    </div>
                	</div>                  
                	<div class="prodlib_panel">
                		<p class="mune-til">产品信息<span onclick="displayProdList();" class="ico glyphicon glyphicon-remove-sign"></span></p>
	                    <div class="mune-list">
	                        <div class="cont-scrol">
	                        	<table class="table" style="margin-top: 9px;text-align: center;border-collapse:collapse;border-spacing:0px;" id="selectFurDetailTable">
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
<script src="${prc }/common/js/kkpager.js"></script>
<script src="${prc }/common/lib/jquery-lightbox-0.5/js/jquery.lightbox-0.5.js"></script>
<script src="${prc }/common/pager/kkpager.min.js"></script>
<script src="${prc }/common/js/ajaxfileupload.js"></script>
<script src="${prc }/common/js/imagePreview.js"></script>

<script>

	//清除搜索图片
	function resetSubmitImg(){
		
		var hasImg = $('#sereachImgInp').val() ? true : false;
		
		$('#sereachImgInp').val('');
		$('#preViweImg').attr('src','');
		$('#fingerprint').val('');
		$('#select_imgPane .imgfileBox span').html('点击上传本地图片');
		/* isResetImg_token = true; */
		
		if(!hasImg){
			return;
		}
		var fid = $('#prodTypeId').val();
        showProdLibMsg(fid,1);
		
	}

	var isSereachbyImg_token = false,
		isResetImg_token = false;

	function submitImg(){
		
		var extname,
			size,
			$img = $('#sereachImgInp'),
			img_name = $img.val(),
			pid = $('#prodTypeId').val();
		
		if(!img_name){
 
			alert('请上传图片');
			return;
		}
		else{
			extname = img_name.substring(img_name.lastIndexOf(".")+1,img_name.length).toLowerCase(); 
			if( extname!= "jpeg" && extname!= "jpg"&& extname!= "gif" && extname!= "png"){  
	         	alert('格式不正确,支持的图片格式为：JPEG、jpg、GIF、PNG');  
	         	return false;  
	        }
			
			size = $img[0].files[0].size;
			if(size > 2097152){
				alert('图片大小不能超过2M');
				return false;
			}

		}
		
		if(!pid || pid === 'all'){
			pid = '';
		}
		
		$('#select_imgPane').slideUp();
		
		isSereachbyImg_token = true;
		
		window.top.showHomeLoading();
		
		$.ajaxFileUpload
        (
            {
                url: '${prc }/imageSearch/searchSimialImage', //用于文件上传的服务器端请求地址
                secureuri: false, //是否需要安全协议，一般设置为false
                fileElementId: 'sereachImgInp', //文件上传域的ID
                dataType: 'application/json', //返回值类型 一般设置为json
                proTypeId : pid,
                pageSize : pageImgCountNum,
                contentType: "application/json; charset=utf-8",
                success: function (data, status)  //服务器成功响应处理函数
                {
                	window.top.hideHomeLoading();
                	 var res,
                		reg = /^<pre.+?>/g,
                		datas,
                		dataInd;

                	dataInd = data.indexOf('{');
                	
                	 res = data.slice(dataInd,-6);	
                	 
                	 if(res == 'false'){
                		 alert('搜索失败');
                		 return false;
                	 }
                	 else{
                		 datas = JSON.parse(res);
                	 }

                	 
                 	 showProdPic(datas.produces);
                 	 if(!datas.produces.length){
                 		 return;
                 	 }
                 	 
                 	 $fingerprint.val(datas.imgUuid);
                 	 
                 	 if(pid == ''){
                 		 pid = 'all';
                 	 }
                 	  
                     showPageInfo(pid,datas.producesCount,true);
                     $('#prodPicTable td .daskImg').lightBox();
 
                },
                error: function (data, status, e)//服务器响应失败处理函数
                {
                	
                	window.top.hideHomeLoading();
                	if( data.responseText.indexOf('a damaged picture') !== -1){
                		alert('请上传正确的图片的格式');
                	}
                	else{
                		alert('搜索失败');	
                	}
                	
                	/* console.log(data);
                	console.log(status);
                	console.log(e); */
                }
            }
        )
        return false;
	}


	/* 关闭产品库 */
	function prodlib_closeBtn(){
		window.top.hideProdLibPop();
	}

	var //$firstPageBtn = $('#firstPage-btn'),      //产品库分页 的首页按钮
		$prodlibTilName = $('#prodlibTilName'),   //产品库标题
		$fingerprint = $('#fingerprint');         //图片指纹值
	
	var saleProdArray = [];
	var delSaleProdId = '';
    var filepath = $('input[name="filepath"]').val();
    
    var treeMuneDataList;
    
    var $treejqEl =  $('#prodTypeListDiv');
    
    function ReSetTreeMune(fid){
    	var dataNodes = cpResult(treeMuneDataList,fid),
    		nodeId;
        $('#prodTypeListDiv').treeview({
            data: dataNodes, // 数据源
            showCheckbox: false, //是否显示复选框
            highlightSelected: true, //是否高亮选中
            iconInd : 'r',
            //nodeIcon: 'glyphicon glyphicon-user', //节点上的图标 glyphicon-globe
            /*nodeIcon: 'glyphicon',*/
            expandIcon:'glyphicon-plus',
            collapseIcon:'glyphicon-minus',
            emptyIcon: 'glyphicon', //没有子节点的节点图标
            multiSelect: false, //多选
            onNodeSelected: function (event, data) {
            	
            	$fingerprint.val('');
            	$('#preViweImg').attr('src','');
            	
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
            	        
            	$treejqEl.treeview('expandNode', [ data.nodeId, { levels: 2, silent: true } ]);
            	$prodlibTilName.html(data.text);
                //选中的分类data.fid 显示对应的产品图片信息等
                removeSelectArea();
                showProdLibMsg(data.fid,1);
                
                isSereachbyImg_token = false;
            }
        });
        nodeId = $('#prodTypeListDiv').find('li.node-selected').data('nodeid');
        $('#prodTypeListDiv').treeview('collapseAll', { silent: true });
        $('#prodTypeListDiv').treeview('revealNode', [ nodeId, { iconInd : 'r',silent: true } ]);


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
                    iconInd : 'r',
                    //nodeIcon: 'glyphicon glyphicon-user', //节点上的图标 glyphicon-globe
                    /*nodeIcon: 'glyphicon',*/
                    expandIcon:'glyphicon-plus',
                    collapseIcon:'glyphicon-minus',
                    emptyIcon: 'glyphicon', //没有子节点的节点图标
                    multiSelect: false, //多选
                    onNodeSelected: function (event, data) {
 
                    	$fingerprint.val('');
                    	$('#preViweImg').attr('src','');
                    	
                    	
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
                    	         
                    	$treejqEl.treeview('expandNode', [ data.nodeId, { levels: 2, silent: true } ]);
                    	
                    	$prodlibTilName.html(data.text);
                    	
                        //选中的分类data.fid 显示对应的产品图片信息等
                        removeSelectArea();
                        
                        showProdLibMsg(data.fid,1);
                        
                        isSereachbyImg_token = false;
                    }
                });
                //折叠所有的节点，折叠整个树
                $('#prodTypeListDiv').treeview('collapseAll', { iconInd : 'r',silent: true });
                
            },
            error: function(err) {
                alert("加载产品分类类目失败!");
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
    
    function selectTreeNode(fid){
    	ReSetTreeMune(fid);
    }
    
    //根据选中的分类data.fid 显示对应的产品图片信息等
    function showProdLibMsg(fid,startPage,isReflash,areaId,offerId,replSaleProdId){

    	showProdLibMsg_setVal(fid,isReflash,areaId,offerId,replSaleProdId);
    	
        if( fid === 'all'){
        	is_topLevel = 'yes';
        }
        
        if(replSaleProdId){
        	selectTreeNode(fid);
        }
        
        var dataForm = {"prodTypeId":fid,"startPage":startPage,'pageSize':pageImgCountNum};
        
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
                alert("加载产品信息失败!");
            }
        });

    }
    //分页用
    function showProdLibMsg_fy(fid,startPage,isReflash,areaId,offerId,replSaleProdId){
    	   
    	showProdLibMsg_setVal(fid,isReflash,areaId,offerId,replSaleProdId);
    	
    	 var dataForm,
    		fingerprint= $fingerprint.val();
    	
    	 
    	if(fingerprint){
    		dataForm = {"prodTypeId":fid,"startPage":startPage,"imgUuid":fingerprint,"pageSize":pageImgCountNum};
    	}
    	else{
    		dataForm = {"prodTypeId":fid,"startPage":startPage,"pageSize":pageImgCountNum};
    	}
        
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
                
				/* if(isResetImg_token){
					isResetImg_token = false;
					isSereachbyImg_token = false;
					showPageInfo(fid,result.producesCount,true);
				} */
                
                $('#prodPicTable td .daskImg').lightBox();
            },
            error: function(err) {
                alert("加载产品信息失败!");
            }
        });

    }
    
    function sereachImgBypaging(pid,pNum){
    	var data,
    	    similarImgIds;
    	similarImgId = $('#fingerprint').val().split(',');
    	
    	data = {similarImgIds:similarImgId,pageNum:pNum,proTypeId:pid};
    	
    	data = JSON.stringify(data);
    	
    	$.ajax({
            url:"${prc }/imageSearch/turnPage",
            type: "get",
            async:false,
            dataType:"json",
            contentType: "application/json; charset=utf-8",
            data:data,
            success: function(result) {

                 console.log(result);
   
            },
            error: function(err) {
                alert("加载产品信息失败!");
            }
        });
    	
    }
    
    function mouseoverEvent(obj){
        $(obj).find(".dask").css('display','block');
    }
    function onmouseoutEvent(obj){
        $(obj).find(".dask").css('display','none');
    }
    
    var $kkpager = $('#kkpager'),
    	$prodPicTable_tbody = $('#prodPicTable tbody');
    
    //展示产品信息（第一条sku图片+产品名称）
    function showProdPic(produces){
   
        $("#prodPicTable tbody").html("");
        
        //产品数
        var prodsLen = produces.length,
        	colNum = 4; //每行多少个图片
        
        
        //总共有rowcount行
        /* var rowcount = Math.ceil(prodsLen/3); */
        var rowcount = Math.ceil(prodsLen/colNum);

        if(!prodsLen){
        	$prodPicTable_tbody.html('<td style="width:200px;height:175px;padding-bottom: 5px;margin-right:80px;text-align:center;font-size:22px" title="">暂无数据</td>');
        	$kkpager.html('');
        	//$firstPageBtn.hide();
        	return;
        }
        else{
        	//$firstPageBtn.show();
        }

        var thumbnail = "<div style=\"width:200px;height:190px;margin-bottom: 0px;\" class=\"thumbnail\" onmouseover='mouseoverEvent(this)' onmouseout='onmouseoutEvent(this)'>";
        var caption = "<div style=\"width:190px;height:10px;padding: 0px;\" class=\"caption\"><nobr>";
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
                                content2 = "<div class=\"dask\"><a href=\""+filepath+""+sku.files[i].path+"\" class=\"daskImg\"></a><p><button type=\"button\" onclick=\"selectFurDetail(event)\" class=\"btn btn-primary\">详情</button>&nbsp;&nbsp;&nbsp;<button name=\"picbtn\" type=\"button\" onclick=\"picChecked(event)\" class=\"btn btn-primary\">添加</button></p></div>";
                                htmltext += thumbnail + img + caption + content + checkboxe0 + content2 + tail;
                                $td = $('<td style="width:200px;height:175px;padding-bottom: 5px;overflow:hidden;" title="" name="proimg"></td>');
                                $td.html(htmltext);
                                var tdCounttmp = 0;
                                if(null != $tr && "" != $tr){
                                    tdCounttmp = $tr[0].childNodes.length;
                                }
                                var newrowsign = tdCounttmp%colNum;
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
                        content2 = "<div class=\"dask\"></a><p><button type=\"button\" onclick=\"selectFurDetail(event)\" class=\"btn btn-primary\">详情</button>&nbsp;&nbsp;&nbsp;<button type=\"button\" onclick=\"picChecked(event)\" class=\"btn btn-primary\">添加</button></p></div>";
                        htmltext += thumbnail + img + caption + content + checkboxe0 + content2 +  tail;
                        $td = $('<td style="width:200px;height:175px;padding-bottom: 5px;margin-right:80px" title="" name="proimg"></td>');
                        $td.html(htmltext);
                        var tdCounttmp = 0;
                        if(null != $tr && "" != $tr){
                            tdCounttmp = $tr[0].childNodes.length;
                        }
                        var newrowsign = tdCounttmp%colNum;
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
        if(colNum != lastTrTdCount && null != $tr){
            var tmp = colNum - lastTrTdCount;
            //var $ltd = $('<td style="width:200px;height:175px;padding-bottom: 5px;margin-right:80px" title=""></td>');
            
            for(var j=0;j<tmp;j++){
            	var ltd = document.createElement('td');
                ltd.style.cssText = 'width:200px;height:195px;padding-bottom: 5px;margin-right:80px';
                $tr[0].appendChild(ltd);
            }
        }
        //补充一行,使得分页显示位置不变
        if($("#prodPicTable tbody tr").length < 2){
            var apptr = 2- $("#prodPicTable tbody tr").length;
            for(var k=0;k<apptr;k++){
                $tr = $('<tr></tr>');
                //var $ltd = $('<td style="width:200px;height:195px;padding-bottom: 5px;margin-right:80px" title=""></td>');
                var ltd = document.createElement('td');
            	ltd.style.cssText = 'width:200px;height:195px;padding-bottom: 5px;margin-right:80px';
                $tr[0].appendChild(ltd);
                //$tr.append($ltd);
                $("#prodPicTable tbody").append($tr);
            }
        }
    }
    
    //复制对象数组
    function cpResult(arr,fid){
  	
        var newArray = [];
        var allProduct = {fid:"all",text:"全部产品",nodes:"",state: {selected: true}},
        	ind,
        	temp_srt,
        	temp_beg,
        	temp_end;
        
        if(!fid){
        	arr.unshift(allProduct);	
        }
        
        for(var i=0;i<arr.length;i++){
            newArray.push(arr[i]);
        }
        
        
        var datastr = JSON.stringify(newArray);
        datastr = datastr.replace(/name/g,"text");
        datastr = datastr.replace(/children/g,"nodes");
        
        if(fid && fid !== 0){
        	ind = datastr.indexOf('"fid":"'+fid+'"');
        	temp_beg = datastr.slice(0,ind);
        	temp_end = datastr.slice(ind);
        	temp_srt = '"state":{"expanded":"true","selected":"true"},';
        	datastr = temp_beg+temp_srt+temp_end;
        }
        
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
    
    //改变选中的个数
    function selectNum(){
        var prodSeleted = getCheckedProds();
        $("#selectNum").html("已选 " + prodSeleted.length +" 件家具");
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
                alert("加载产品详情信息失败!");
            }
        });
    }
    function addCurrProInfo(name,value){
        var modelVal = '<span style="float:left;width:225px">';
        var Html = "<span style=\"word-break:normal; width:auto; float:left;white-space:pre-wrap;word-wrap : break-word ;overflow: hidden ;padding-left: 8px;\">"+name+"：</span>";
     
        if("型号" == name){
            var j = 0;
            for(var i=0;i<value.length;i++){
                if(null != value[i]){
                    modelVal += value[i] + "</br>";
                    j++;
                }
            }
            Html += modelVal + '</span>';
        }else{
            Html += modelVal + value + '</span>';
        }
        var $tr = $('<tr style="text-align: left;"></tr>');
        $td = $('<td style="width: 200px;"></td>');
        $td.html(Html);
        $tr.append($td);
        $("#selectFurDetailTable").append($tr);
    }
    
    function showMoreProdInfo(js_el){
    	var self = $(js_el),
    		$moreShowBox = self.parents('.ShowinfoBox').find('.moreShowBox');
 
    	if( self.hasClass('active')){
    		self.removeClass('active');
    		$moreShowBox.slideUp();
    	}
    	else{
    		self.addClass('active');
    		$moreShowBox.slideDown();
    	}   	
    	
    }
    
    
    
    function addmatSizeColInfo(name,arr){
        var Header;
        var Tail;
        var sparet;
        
        var baseShowBox = '<div class="baseShowBox">',
        	moreShowBox = '<div class="moreShowBox">',
        	showInfoLimitNum = 6,
        	itemNum = arr.length,
        	str1 = '',
        	str2 = '',
        	tpl = '';
        	
        function magerStr(){
        		
       		if(showInfoLimitNum < itemNum){
           		
       			for(var i = 0;i<showInfoLimitNum;i++){
       				if("型号" == name){
       					str1 += arr[i]+'</br>';
       	            }else{
       	            	str1 += arr[i].optValue+'</br>';
       	            }      				
   				}
       			
       			baseShowBox += '<a class="showMoreProdInfo" onclick="showMoreProdInfo(this)"></a>'+ str1 + '</div>';
       			
       			for(var i = showInfoLimitNum;i<itemNum;i++){
        
       				if("型号" == name){
       					str2 += arr[i]+'</br>';
       	            }else{
       	            	str2 += arr[i].optValue+'</br>';
       	            }   
   				}
       			
       			moreShowBox += str2;
       			
       			tpl += '<div class="ShowinfoBox">'+baseShowBox + moreShowBox + '</div>';
       			
           	}
   			else{
   				
   				for(var i = 0;i<arr.length;i++){
   					if("型号" == name){
       					str1 += arr[i]+'</br>';
       	            }else{
       	            	str1 += arr[i].optValue+'</br>';
       	            } 
   				}
   				
   				baseShowBox += str1 + '</div>';
   				tpl += '<div class="ShowinfoBox">'+baseShowBox + '</div>';
   			}
  
        }
        
        
        
        
        
         if("尺寸" == name || '型号' == name){
            Header = "<div style=\"position:relative;padding-left: 8px;\"><span class=\"fl\">"+name+"：</span>";
        	Tail = "</div>";
        }else{
            Header = "<p style=\"padding-left: 8px;word-wrap: break-word;word-break: break-all;\">"+name+"：";
            Tail = "</p>";
            sparet = "&nbsp;"
        }
         
        var span = "";
        //颜色/材质
        
        if( name == '尺寸' || '型号' == name ){
        	magerStr();	
        }
        else{

        	span += '<span style="display:inline-block;word-wrap: break-word;word-break: break-all;width: 225px;vertical-align: top;">'	
            for(var i = 0;i<arr.length;i++){
            	
                if("风格" == name){
                    span += arr[i].designId + sparet;
                }else{
                    span += arr[i].optValue + sparet;
                }
            }

        	span += '</span>';
        }
        
        
          
        var Html = Header + tpl +span + Tail;
        //var Html = Header + tpl + Tail;
        var $tr = $('<tr style="text-align: left;"></tr>');
        $td = $('<td style="width: 200px;"></td>');
        $td.html(Html);
        $tr.append($td);
        $("#selectFurDetailTable").append($tr);
    }
    
    var select_obj;
    $('#selectThisProd').click(function(){picChecked(select_obj);
	    displayProdList();
	});
    //家具详情
    function selectFurDetail(currobj2){
    	
    	var ent,
			obj_js,
			currobj;

	    if(currobj2 instanceof Event){
	    	ent = currobj2 || window.event;
		    obj_js = ent.currentTarget || e.srcElement;
		    currobj = $(obj_js);
		
		    if(ent.stopPropagation){
		 	   ent.stopPropagation();
		    }
		    else{
		 	   ent.cancelable = true;
		    } 
	    }
	    else{
	    	currobj = currobj2;
	    }  
    	
    	select_obj = currobj;
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
        var imgTd = "<img src=\""+imgsrc+"\" class=\"prodlibInfoImg\" />";
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
        addmatSizeColInfo("型号",matSizeColInfo.modelNoList);
        //addCurrProInfo("型号",matSizeColInfo.modelNoList);
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
    function picChecked(currobj2){
        //显示已选产品列表
    	var ent,
    		obj_js,
    		currobj;
        
        if(currobj2 instanceof Event){
        	ent = currobj2 || window.event;
		    obj_js = ent.currentTarget || e.srcElement;
		    currobj = $(obj_js);
		
		    if(ent.stopPropagation){
		 	   ent.stopPropagation();
		    }
		    else{
		 	   ent.cancelable = true;
		    } 
        }
        else{
        	currobj = currobj2;
        }           				  
        		
        displayProdList();
        obj = $(currobj).parents(".thumbnail").find('img')[0];
        //获取图片的src
        //错误写法(出现中文乱码)：var imgsrc = obj.src;
        var imgsrc = $(obj).attr('src');
        //获取家具编号
        var fid = $(obj).parents(".thumbnail").find('input[name="productsCheckBox"]')[0].value;
        //获取家具名称
        var proname = $(obj).parents(".thumbnail").find('span[name="produceName"]')[0].title;
      //获取家具型号
        var modelNo = $($(obj).parents(".thumbnail").find('input[name="modelNo"]')[0]).val();
      //产品企业
      	var companyId = $($(obj).parents(".thumbnail").find('input[name="companyId"]')[0]).val();

        var cost = $($(obj).parents(".thumbnail").find('input[name="cost"]')[0]).val() * $("#buyRate_"+companyId).val();
        
        //获取产品分类ID
        var prodTypeId = $($(obj).parents(".thumbnail").find('input[name="prodTypeId"]')[0]).val();

        var imgTd = "<img src=\""+imgsrc+"\" style=\"width:66px;height:50px\"/>";
        var pronameHtml = "<span class=\"textOverflow\" style='width:130px;display: block;' title=\""+proname+"\">"+proname+"</span>";
        var del = "<span></span><a href=\"javascript:void(0);\" onclick=\"delProduct(this,'"+fid+"')\" style='float: right;color: red;'>删除</a>";
        var proDel = pronameHtml + del;
        
        var div0 = "<div>";
        var $tr = $('<tr fid="'+fid+'"></tr>');
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
    function showPageInfo(fid,producesCount,isbyImg){
       
        $("#kkpager").html("");
        var pageCount = Math.ceil(producesCount/pageImgCount);
        //切换分类,重新生成分页 
        if(isSereachbyImg_token){
        	isbyImg = true;
        }

        if(tmpfid != fid || isbyImg){
	
            tmpfid = fid;
            $.getScript('${prc }/common/js/kkpager.js',function(){
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
                    isShowGoPageNum: false,
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
                    },
                    isShowTotalRecords : false,
                    lang				: {
            			firstPageText			: '',
            			firstPageTipText		: '',
            			lastPageText			: '',
            			lastPageTipText			: '',
            			prePageText				: '',
            			prePageTipText			: '',
            			nextPageText			: '',
            			nextPageTipText			: '',
            			totalPageBeforeText		: '共',
            			totalPageAfterText		: '页',
            			currPageBeforeText		: '当前第',
            			currPageAfterText		: '页',
            			totalInfoSplitStr		: '/',
            			totalRecordsBeforeText	: '共',
            			totalRecordsAfterText	: '条数据',
            			gopageBeforeText		: ' 到',
            			gopageButtonOkText		: '确定',
            			gopageAfterText			: '页',
            			buttonTipBeforeText		: '第',
            			buttonTipAfterText		: '页'
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
                isShowGoPageNum: false,
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
                },
                isShowTotalRecords : false,
                lang				: {
        			firstPageText			: '',
        			firstPageTipText		: '',
        			lastPageText			: '',
        			lastPageTipText			: '',
        			prePageText				: '',
        			prePageTipText			: '',
        			nextPageText			: '',
        			nextPageTipText			: '',
        			totalPageBeforeText		: '共',
        			totalPageAfterText		: '页',
        			currPageBeforeText		: '当前第',
        			currPageAfterText		: '页',
        			totalInfoSplitStr		: '/',
        			totalRecordsBeforeText	: '共',
        			totalRecordsAfterText	: '条数据',
        			gopageBeforeText		: ' 到',
        			gopageButtonOkText		: '确定',
        			gopageAfterText			: '页',
        			buttonTipBeforeText		: '第',
        			buttonTipAfterText		: '页'
        		}

            });
        }
        
    }
    
    /* window.onresize = function () {
        window.top.SetOffWinHeight();
    }; */
    
    var pageImgCountNum = 8; //每页显示数量
    
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
                    "startPage" :1,
                    "pageSize" : pageImgCountNum
    				};
    	
    	if(addParam){
    		if( !publicIsType('array',addParam)){
    			return;
    		} 
    		dataForm['dynamicCondition'] = addParam;
    	}
    	
    	var fingerprint = $fingerprint.val();
    	
    	if(fingerprint){
    		dataForm['imgUuid'] = fingerprint;
    	}
    	
    	
        $.ajax({
            type: "Post",
            async:false,
            url:"${prc }/product/toListProduces",
            data:JSON.stringify(dataForm),
            dataType:"json",
            contentType: "application/json; charset=utf-8",
            success: function(result) {          
            	
            	/* 动态查询区域 */
                //selectAreaBoxForm(result.proPropertyVals);
                //展示产品信息
                showProdPic(result.produces);
                if(!result.produces.length){
                	return;
                }
                showPageInfoBydataForm(dataForm,result.producesCount);
                resetIfrHei();
                $('#prodPicTable td .daskImg').lightBox();
            },
            error: function(err) {
                alert("加载产品信息失败!");
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
                //展示产品信息
                showProdPic(result.produces);
                $('#prodPicTable td .daskImg').lightBox();
            },
            error: function(err) {
                alert("加载产品信息失败!");
            }
        });
    }
    var dataFormtmp,
    	pageImgCount = 8;
    //根据fid显示页码
    function showPageInfoBydataForm(dataForm,producesCount){
        $("#kkpager").html("");
        var isbyImg = $('#sereachImgInp').val() ? true: 0;
        var pageCount = Math.ceil(producesCount/pageImgCount);
        //切换分类,重新生成分页
        if(dataFormtmp != dataForm){
            dataFormtmp = dataForm;
            $.getScript('${prc }/common/js/kkpager.js',function(){
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
                    isShowGoPageNum: false,
                    //点击页码、页码输入框跳转、以及首页、下一页等按钮都会调用click
                    //适用于不刷新页面，比如ajax
                    click : function(n){
                        //这里可以做自已的处理
                        dataFormtmp.startPage = n;
                        showProdLibMsgBydataForm(dataFormtmp);
                        //处理完后可以手动条用selectPage进行页码选中切换
                        this.selectPage(n);
                    },
                    //getHref是在click模式下链接算法，一般不需要配置，默认代码如下
                    getHref : function(n){
                        return '#';
                    },
                    isShowTotalRecords : false,
                    lang				: {
            			firstPageText			: '',
            			firstPageTipText		: '',
            			lastPageText			: '',
            			lastPageTipText			: '',
            			prePageText				: '',
            			prePageTipText			: '',
            			nextPageText			: '',
            			nextPageTipText			: '',
            			totalPageBeforeText		: '共',
            			totalPageAfterText		: '页',
            			currPageBeforeText		: '当前第',
            			currPageAfterText		: '页',
            			totalInfoSplitStr		: '/',
            			totalRecordsBeforeText	: '共',
            			totalRecordsAfterText	: '条数据',
            			gopageBeforeText		: ' 到',
            			gopageButtonOkText		: '确定',
            			gopageAfterText			: '页',
            			buttonTipBeforeText		: '第',
            			buttonTipAfterText		: '页'
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
                isShowGoPageNum: false,
                //点击页码、页码输入框跳转、以及首页、下一页等按钮都会调用click
                //适用于不刷新页面，比如ajax
                click : function(n){
                    //这里可以做自已的处理
                    showProdLibMsgBydataForm(dataFormtmp);
                    //处理完后可以手动条用selectPage进行页码选中切换
                    this.selectPage(n);
                },
                //getHref是在click模式下链接算法，一般不需要配置，默认代码如下
                getHref : function(n){
                    return '#';
                },
                isShowTotalRecords : false,
                lang				: {
        			firstPageText			: '',
        			firstPageTipText		: '',
        			lastPageText			: '',
        			lastPageTipText			: '',
        			prePageText				: '',
        			prePageTipText			: '',
        			nextPageText			: '',
        			nextPageTipText			: '',
        			totalPageBeforeText		: '共',
        			totalPageAfterText		: '页',
        			currPageBeforeText		: '当前第',
        			currPageAfterText		: '页',
        			totalInfoSplitStr		: '/',
        			totalRecordsBeforeText	: '共',
        			totalRecordsAfterText	: '条数据',
        			gopageBeforeText		: ' 到',
        			gopageButtonOkText		: '确定',
        			gopageAfterText			: '页',
        			buttonTipBeforeText		: '第',
        			buttonTipAfterText		: '页'
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
            	  window.top.document.getElementById('content').contentWindow.selectSaleProd($("#areaId").val());
            	  saleProdArray = [];
            	  window.top.hideProdLibPop();
             },
             error: function(err) {
                 alert("加载产品信息失败!"+err);
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
    
	//var $selectProdlNum = $('.showProdLibAnddetail_btn .selectProdlNum');
    
    //改变选中的个数
    function selectNum(){
        var prodSeleted = getCheckedProds();
        $("#selectNum").html(prodSeleted.length);
        //$selectProdlNum.html(prodSeleted.length);
    }
   /*  产品库关闭时清空件数 */
    function clearCountItem(){
    	$("#selectNum").html(0);
    	//$selectProdlNum.html(0);
    }
    /* 选择产品时清除查询表单的内容 */
    
    var $form_el = $('#form');
    
    function removeSelectArea(){
    	$form_el[0].reset();
    }
    
    /* 产品信息及添加产品菜单 */
    var $leftMune = $('.ProdLibAnddetailBox');
        //$leftMune_btn = $('#showProdLibAnddetail_btn'),
        $prodPanel = $leftMune.find('.prodlib_panel'),
        $leftMune_bg = $('.ProdLibAnddetail-bg');

    /* $leftMune_btn.on('click',function(){

        if($leftMune.hasClass('active')){
            hiddenLeftMune();
        }
        else{
            showLeftMune(0);
        }

    }); */
    

    function hiddenLeftMune(){
        $leftMune.removeClass('active');
        $prodPanel.hide();
    }

    function showLeftMune(ind){
    	$prodPanel.eq(ind).show();
        $leftMune.addClass('active');
    }

    $leftMune_bg.on('click',function(e){
        e.stopPropagation();
        hiddenLeftMune();
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
        tpls_submit_btn = '',
        tpls_select_img = '';


	
	tpls_select_img += '<a class="select_imgBox" id="select_imgBox"><i></i><span>以图搜图</span></a>';
	    tpls_select_img += '<div id="select_img_downPane" class="img_downPane">';
	        tpls_select_img += '<div class="pane" id="select_imgPane">';
	            tpls_select_img += '<dl class="clearfix">';
	                tpls_select_img += '<dt>上传图片：</dt>';
	                tpls_select_img += '<dd>';
	                    tpls_select_img += '<div class="imgfileBox">';
	                        tpls_select_img += '<span>点击上传本地图片</span>';
	                        tpls_select_img += '<a><input type="attachment" name="imagefile" id="sereachImgInp" onchange="sereachImgChange(this);"/></a>';
	                    tpls_select_img += '</div>';
	                tpls_select_img += '</dd>';
	            tpls_select_img += '</dl>';
	           /*  tpls_select_img += '<dl class="clearfix">';
	                tpls_select_img += '<dt>搜索范围：</dt>';
	                tpls_select_img += '<dd>';
	                    tpls_select_img += '<select name="" id="">';
	                        tpls_select_img += '<option value="">全部分类</option>';
	                        tpls_select_img += '<option value="">类别1</option>';
	                        tpls_select_img += '<option value="">类别2</option>';
	                    tpls_select_img += '</select>';
	                tpls_select_img += '</dd>';
	            tpls_select_img += '</dl>'; */
	            tpls_select_img += '<div class="btnBox">';
	                tpls_select_img += '<a onclick="submitImg();">搜索</a>';
	                tpls_select_img += '<a onclick="resetSubmitImg();">重置</a>';
	            tpls_select_img += '</div>';
	        tpls_select_img += '</div>';    
	    tpls_select_img += '</div>';
	
	
	
    tpls_size += '<tr>';
        tpls_size += '<td>';
            tpls_size += '<label class="opt-til"><span>尺寸/mm：</span></label> ';     
        tpls_size += '</td>';
        tpls_size += '<td class="clearfix ">';
            tpls_size += '<div class="input-size">';
                tpls_size += '<input class="" type="text" id="width" placeholder="长度" value="">';
                tpls_size += '<span>-</span>';
                tpls_size += '<input class="" type="text" id="depth" placeholder="宽度" value="">';
                tpls_size += '<span>-</span>';
                tpls_size += '<input class="" type="text" id="heigth" placeholder="高度" value="">';
            tpls_size += '</div>';
        tpls_size += '</td>';
    tpls_size += '</tr>';
    
    tpls_cost += '<tr>';
        tpls_cost += '<td>';
            tpls_cost += '<label class="opt-til"><span>成本/元：</span></label>';      
        tpls_cost += '</td>';
        tpls_cost += '<td class="clearfix ">';
            tpls_cost += '<div class="input-size">';
                tpls_cost += '<input class="" type="text" id="minMoney" placeholder="￥" value="">';
                tpls_cost += '<span>-</span>';
                tpls_cost += '<input class="" type="text" id = "maxMoney" placeholder="￥" value="">';
            tpls_cost += '</div>';
        tpls_cost += '</td>';
    tpls_cost += '</tr>';

    tpls_prodName += '<tr>';
        tpls_prodName += '<td>';
            tpls_prodName += '<label class="opt-til"><span>产品名称：</span></label>';      
        tpls_prodName += '</td>';
        tpls_prodName += '<td class="clearfix " style="overflow:visible">';
            tpls_prodName += '<div class="input-size" style="position:relative">';
                tpls_prodName += '<input class="big-inp" type="text" id="produceName" placeholder="产品名称" value="">';//+tpls_select_img;
            tpls_prodName += '</div>';
        tpls_prodName += '</td>';
        tpls_prodName += '<td rowspan="3" width="220px">';
        	tpls_prodName += '<div id="showSereachImg" class="showSereachImg"><img src="" alt="图片预览" id="preViweImg" /></div>';
        tpls_prodName += '</td>';
    tpls_prodName += '</tr>';
    
    tpls_submit_btn += '<tr>';
    	tpls_submit_btn += '<td class="submit-btn" colspan="3">';
    		tpls_submit_btn += '<a onclick="selectAareaSub()">筛选</a>';      
    	tpls_submit_btn += '</td>';
    tpls_submit_btn += '</tr>';
 
	
	function seteasyTpl(arr_res){
		
		if(!publicIsType('array',arr_res)){
			return '';
		}
		
		var temp_i = 0,
			temp_j = 0,
			list_len = arr_res.length,
			item_len = 0,
			temp,
			m_tpls = '';
		
			
		m_tpls += '<tr>';
	        m_tpls += '<td class="PlibSereachBox" style="background-color:#fff;padding:0;" colspan="3">';
	            m_tpls += '<div class="upmuneBtnBox">';
	                m_tpls += '<div class="upmuneBtn">';
	                m_tpls += '<div class="upmunewp">';
	                    m_tpls += '<ul class="clearfix">';
	                    
	                    
	                    for(;temp_i < list_len;temp_i++){	                    
	                        m_tpls += '<li><a class="btnHd" onclick="showselectOption(event)">'+arr_res[temp_i].name+'<i class="cio"></i></a></li>';	                        
	                    }   
	                        
	                    m_tpls += '</ul>';
	                m_tpls += '</div>';
	            m_tpls += '</div>';
	            m_tpls += '<div class="showAndSelect">';
	                m_tpls += '<div class="rightPane">';
	                    m_tpls += '<a class="btns" onclick="multyChoose(this)">筛选</a>';
	                    m_tpls += '<a class="btns" onclick="showLeftMune(0);">已选产品</a>';
	                m_tpls += '</div>';
	                m_tpls += '<div class="showOpt">';
	                     
	                     temp_i = 0;
	                     
	                     for(;temp_i < list_len;temp_i++){	                    
	                    	 temp = arr_res[temp_i].values;	  
	                    	 item_len = temp.length;
	                    	 
	                    	 temp_j = 0;
	                    	 m_tpls += '<div class="optlistBox">';
	                    	 	m_tpls += '<div class="opt-box">';
	                    	 for(;temp_j < item_len ;temp_j++){
	                    		 m_tpls += '<label class="option-l"><span onclick="screen_single(event)"><i class="ico"></i>'+temp[temp_j]+'</span></label>';
	                    	 }
	                    	 	m_tpls += '</div> ';
		                        m_tpls += '<div class="multyBtnBox"><span class="btn-true" onclick="multyChoose(this)">确定</span><span class="btn-fasle" onclick="SelectMultyHideFn(this)">取消</span></div>';
		                    m_tpls += '</div>';
 
		                 } 
	
	                m_tpls += '</div>';
	            m_tpls += '</div>';
	        m_tpls += '</td>';
	    m_tpls += '</tr>';
 
		return m_tpls;
	}
	
	function setArrInd(arr_name,arr){
		
		var len =  arr.length,
			i = 0,
			pre = [],
			next = [],
			indName = publicRegxMethod.formatIndSrt(arr_name),
			temp;
		
		for(;i < len;i++){
			
			temp = ';'+(arr[i].name)+';';
			
			if(indName.indexOf(temp) !== -1){
				pre[pre.length] = arr[i];
			}
			else{
				next[next.length] = arr[i];
			}
			
		}
		
		return pre.concat(next);
		
	}
	
	
    
    function getArr(arr_name,ori_arr,spa_name){
    	
    	if(!publicIsType('array',arr_name) || !publicIsType('array',ori_arr) || arr_name.length === 0 || ori_arr.length === 0 ){
			return [];
		}
    	
    	if(spa_name){
    		if(!publicIsType('array',spa_name)){
    			return [];
    		}
    	}
    	
    	var formatArr = publicRegxMethod.formatIndSrt,
    		arr_k_str = formatArr(arr_name),
    		arr_sk_srr = formatArr(spa_name),
    		arr_k = [],
    		arr_sk = [],
    		len = ori_arr.length,
    		i = 0,
    		temp_name;
    	
    	for(;i<len;i++){
    		
    		temp_name = ';'+ori_arr[i].name+';';
    		if( arr_k_str.indexOf(temp_name) !== -1 ){
    			
    			if(arr_sk_srr && arr_sk_srr.indexOf(temp_name)){
    				arr_sk[arr_sk.length] = ori_arr[i];
    			}
    			else{
    				arr_k[arr_k.length] = ori_arr[i];
    			}
    			
    		}

    	}
    	
    	return arr_sk.concat(arr_k);
 
    }
 
	
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
			temp_k = 0,
			choseArr;
			
		if(is_topLevel === 'yes'){
			
			//selectArea_randle({boxId:$slectAreaBox_sl,insetText:['size','cost','material[0]','prodName','submintBtn'],otherEl:[material_arr]});
			
			choseArr = getArr(['材质','颜色'],data_obj);
			
			material_arr = seteasyTpl(choseArr);
			
			selectArea_randle({boxId:$slectAreaBox_sl,insetText:['prodName','size','cost','other'],otherEl:[material_arr]});
			is_topLevel = 'no';
		}
		else{

			choseArr = setArrInd(['材质','颜色'],data_obj);
			
			tpls = seteasyTpl(choseArr);
			
			//selectArea_randle({boxId:$slectAreaBox_sl,insetText:['size','cost','other','prodName','submintBtn'],otherEl:[tpls]});
			selectArea_randle({boxId:$slectAreaBox_sl,insetText:['prodName','size','cost','other'],otherEl:[tpls]});
			is_topLevel = 'no';
		} 
		
		/* 以图搜图 */
		var $select_imgBox = $('#select_imgBox'),
	        $select_imgPane = $('#select_imgPane'),
	        $select_showName = $select_imgPane.find('.imgfileBox span'),
	        $sereachImg_inp = $select_imgPane.find('input'); 

	    $select_imgBox.on('click',function(e){
	    	var e = e || window.event;
	    	if(e.stopPropagation){
	    		e.stopPropagation();
	    	}
	    	else{
	    		e.cancelBubble = true;
	    	}
	        select_imgPaneShow();
	    });
	    
	    $select_imgPane.on('click',function(e){
	    	var e = e || window.event;
	    	if(e.stopPropagation){
	    		e.stopPropagation();
	    	}
	    	else{
	    		e.cancelBubble = true;
	    	}
	    });
	    //搜索按钮
	    /* $select_imgPane.find('.btnBox a').on('click',function(e){
	    	var e = e || window.event,
	    		imgName = '';
	    	if(e.stopPropagation){
	    		e.stopPropagation();
	    	}
	    	else{
	    		e.cancelBubble = true;
	    	}
	    	imgName = $sereachImg_inp.val(); 
	    	if(!imgName){
	    		alert('请上传图片');
	    		return;
	    	}
	    	imgName = publicRegxMethod.getFileName(imgName);
	    	//window.open('${prc}/jsp/offerlist/sereachByImg.jsp?'+imgName);

	    }); */
	    
	    $(document).on('click',function(e){
	    	var e = e || window.event;
	    	if(e.stopPropagation){
	    		e.stopPropagation();
	    	}
	    	else{
	    		e.cancelBubble = true;
	    	}
	    	select_imgPaneHide();
	    });
	    
	    /* $sereachImg_inp.on('change',function(){
	    	var val = $(this).val();
	    	$select_showName.html(val);
	    }); */
	    

	    function select_imgPaneShow(){
	    	$select_imgPane.slideToggle();
	    }
	    function select_imgPaneHide(){
	    	$select_imgPane.slideUp();
	    }
		/* 以图搜图  end*/
		
		/* selectArea_randle({boxId:$slectAreaBox_sl,insetText:['size','cost','other','prodName','submintBtn'],otherEl:[tpls]}); */
		
	}	
	
 
	
	function sereachImgChange(el_js){
    	var val = $(el_js).val();
    	if(!val){
    		val = '点击上传本地图片';
    	}
    	
    	$('#select_imgPane .imgfileBox span').html(val);
    	
    	setImagePreview(el_js,showSereachImg,preViweImg);
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
			val = [];

		val = getSelectAllVal();

		/* if(!val.length){
			return;
		} */
		doSubmit(val);
		SelectMultyHideFn(obj_js);
	}
	
	function getSelectAllVal(){
		var $valWrap = $slectAreaBox_sl.find('.optlistBox'),
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

    		temp_el = $_el.find('.on-sel');
    		temp_len = temp_el.length;
    		if(temp_len <= 0){
    			continue;
    		}

   			for(;temp_len--;){
    			temp += ';'+temp_el.eq(temp_len).find('span').text();
    		}
    		temp = temp.substr(1);
    		val[val.length] = temp;
  
	    }
	    return val;
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
	   
	   function SelectMultyHideFn(obj_js){
	       var $self = $(obj_js),
	           ind = $self.parents('.optlistBox').index();
	       
	       SelectShowToggleFn(ind);
	   }
	
	   function SelectShowToggleFn(ind){
	       var $nav_li = $('.selectAreaBox .upmunewp a'),
	       	   $pot_pane = $('.selectAreaBox .showOpt .optlistBox');
	       
	       $nav_li.eq(ind).removeClass('active');

	       $pot_pane.eq(ind).slideUp();	
			
	       setTimeout('resetIfrHei()',400);
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
                       /* tpls_material_temp += '<label class="option-l" onclick="screen_single(event)"><span>'+temp[i]+'<i class="clo" onclick="multyRemoveSleFn(event)"></i></span></label>'; */   
                	   /* tpls_material_temp += '<label class="option-l" onclick="screen_single(event)"><span>'+temp[i]+'<i class="clo"></i></span></label>'; */
                	   tpls_material_temp += '<label class="option-l"><span onclick="screen_single(event)">'+temp[i]+'<i class="clo"></i></span></label>';
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
	
	var $topWindow = $(window.top.document),
		homeWindowHei = $(window.top.window).height(),
		$modal_dialog = $topWindow.find('.modal-dialog');
	
	
	
	 function resetIfrHei(){
		var bodyHei,
			ajust = 300;

		if(window.parent.document.getElementById('myModal').className.indexOf(' in') === -1){
			bodyHei = $(document.getElementsByClassName('prodLibheiBox')[0]).height()-200;
			window.parent.document.getElementById('content_prodlib').height = bodyHei;
			//window.parent.parent.document.getElementById('saleProdFrame').height = bodyHei;
			//window.top.document.getElementById('content').height = bodyHei;
		}
		else{
			bodyHei = $(document.getElementsByClassName('prodLibheiBox')[0]).height();
			window.top.document.getElementById('content_prodlib').height = bodyHei+50;
			//window.parent.parent.document.getElementById('saleProdFrame').height = bodyHei+ajust;
			//window.top.document.getElementById('content').height = bodyHei+ajust;	
		}
		
		if(homeWindowHei <= (bodyHei+150) ){
			$modal_dialog.addClass('sm');
		}
		else{
			$modal_dialog.removeClass('sm');
		}
		
	}
	
	//筛选区域下拉效果
     var showSelectOptListWp_ind;

     function showselectOption(e){
         var ent = e || window.event,
             obj_js = ent.currentTarget || e.srcElement,
             self = $(obj_js),
             wpind = self.parents('li').index(),
             $showSelectOptBtn = $('.upmuneBtn .btnHd'),
             $showSelectOptListWp = $('.optlistBox');

         if(ent.stopPropagation){
           ent.stopPropagation();
         }
         else{
           ent.cancelable = true;
         } 

         if(self.hasClass('active')){

           self.removeClass('active');

           $showSelectOptListWp.eq(showSelectOptListWp_ind).slideUp();

         }
         else{

           showSelectOptListWp_ind = wpind;

           $showSelectOptBtn.removeClass('active');
           self.addClass('active');

           $showSelectOptListWp.hide();

           $showSelectOptListWp.eq(wpind).slideDown('fast');

         }
         
         setTimeout('resetIfrHei()',200);
         
     } 
     
     function screen_single(e){
    	    
         var ent = e || window.event,
             obj_js = ent.currentTarget || e.srcElement,
             $self = $(obj_js),
             $parent = $self.parents('.option-l');
       
           if(ent.stopPropagation){
             ent.stopPropagation();
           }
           else{
             ent.cancelable = true;
           } 
                
           if($parent.hasClass('on-sel')){
             $parent.removeClass('on-sel');
           }
           else{
             $parent.addClass('on-sel');
           }
               
       } 
	
	
	
</script>
</body>
</html>
