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
    <link rel="stylesheet" href="${prc }/common/lib/swiper/swiper.min.css"/>
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
            width:100%;
            white-space:nowrap;
            text-overflow:ellipsis;
            -o-text-overflow:ellipsis;
            overflow:hidden;
            display: block;
            position: absolute;
            text-align: center;
    		padding-top: 5px;
    		border-top: 1px solid #666;
    		color:#666;
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
        /* .thumbnail:hover{border-color:#28b5d6} */
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
        .thumbnail{overflow:hidden;position:relative;cursor:pointer;border:0;}
        .thumbnail .imgWp{width:190px;height:160px;overflow:hidden;display:table-cell;text-align:center;vertical-align:middle;}
        .thumbnail img{max-width:100%;max-height:100%;}
        .ProdLibAnddetailBox .mune-cont td{border-bottom:1px solid #999;padding: 4px 0 4px;}
        
        .container .addTisBox{position:absolute;left:0;top:0;width:100%;height:30px}
        .container .addTisBox .bg{position:absolute;left:0;top:0;heihgt:100%;width:100%;background-color:#337ab7}
        .container .addTisBox .txtc{position:relative;text-align:center;line-height:30px;color:#fff;font-size:14px;}
        
        #prodTypeListDiv li.count0 a{padding:0;height:50px;line-height:50px;border-top:0;}
        .leftMune .list-group-item:first-child span{display:none}
        .leftMune .list-group-item .glyphicon-plus,.leftMune .list-group-item .glyphicon-minus{font-size:0;overflow:hidden;text-indent:-999px;}
        .leftMune .list-group-item .glyphicon-plus{width:12px;height:16px;background:url('${prc}/common/img/offetlist/prodlib_leftMune_ico.png') no-repeat -12px 2px;position:absolute;right:5px;top:50%;margin-top: -8px;}
    	.leftMune .list-group-item .glyphicon-minus{width:16px;height:12px;background:url('${prc}/common/img/offetlist/prodlib_leftMune_ico.png') no-repeat 2px 2px;position:absolute;right:5px;top:50%;margin-top: -6px;}
    	.leftMune .list-group-item{text-align:center;} 
    	.leftMune .list-group-item .indent,.leftMune .list-group-item .node-icon{display:none;}
    	
    	#prodTypeListDiv .list-group-item.active{
    		background: #428bca;
    		color: #fff;
    	}
    	
    	.leftMune .list-group-item{margin-bottom:0 !important;border:0 !important;border-bottom:1px solid #ddd !important}
    	
    	.leftMune .list-group-item.level2{background-color:#f1f1f1;}
    	.leftMune .list-group-item.level2 .expand-icon{display:none;}
    
    	.leftMune .list-group-item.active.showB .glyphicon-plus{
		    width: 16px;
		    height: 12px;
		    background: url(/bzms/common/img/offetlist/prodlib_leftMune_ico.png) no-repeat -27px 2px;
		    position: absolute;
		    right: 5px;
		    top: 50%;
		    margin-top: -6px;
		}
		
		.leftMune .list-group-item.showB .glyphicon-plus{
		    width: 16px;
		    height: 12px;
		    background: url(/bzms/common/img/offetlist/prodlib_leftMune_ico.png) no-repeat 2px 2px;
		    position: absolute;
		    right: 5px;
		    top: 50%;
		    margin-top: -6px;
		}
		
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
  
  		
    	.leftMune .list-group-item.level1:first-child,.leftMune .list-group-item.level1:last-child{border-radius:0;}
    	
    	#prodTypeListDiv .submenu{display:none}
    	
    	.leftMune .list-group-item{border-left: 0;border-right: 0;}
    	    
    	.prodlibTil{height:50px;line-height:50px;text-align:center;}    
    	.prodlibTil .til{font-size:16px;color:#333;}	
    	
    	#prodRightBox .close{position:absolute;right:4px;top:4px;width:30px;height:30px;}
    
    	#prodRightBox .table-formBox td{border-color:#ddd;}
    	
    	#prodRightBox .table-formBox tr td:first-child{background-color:#fff;}
    	
    	.prodlibImgtabBox2018{padding:0 10px;}
    	
    	.prodlibDetail{
    		display:none;
			position:absolute;
			width:100%;
			left:0px;
			top: 51px;
			bottom: 0;
			background-color: #fff;
		}

		.prodlibDetail .cetBox{
			margin: 0 .6%;
		    height: 100%;
		    overflow-x: hidden;
		    overflow-y: auto;
		    padding: 0 12% 30px;
		}

		.prodlibDetail .pdname{
			position: relative;
			line-height: 46px;
			height:46px;
			text-align: center;
			font-size: 20px;
			color: #666;
			border-bottom: 1px solid #e4e4e4;
		}

		.prodlibDetail .pdname .backToPLib{
			position: absolute;
			height: 46px;
			font-size: 14px;
			color: #999;
			left:0;
			top: 0;
		}	

		.prodlibDetail .centerBOX{
			margin-top: 20px;
			overflow-x:hidden;
			overflow-y: auto;
		}
	
		.prodlibDetail .centerBOX .prototype{
			width:56%;
		}
	
		.prodlibDetail .centerBOX .detial{
			width:400px;
		}

		.prodlibDetail .prototype dl{
			margin-bottom: 30px;
		}

		.prodlibDetail .prototype dt{
			margin-bottom: 5px;
			font-size: 16px;
			color: #999;
			font-weight: normal;
		}

		.prodlibDetail .prototype .opt{
			display: inline-block;
			line-height: 28px;
			padding: 0 5px;
			border: 1px solid #e4e4e4;
			border-radius: 5px;
			font-size: 14px;
			color: #333;
			margin:0 10px 8px 0;
			cursor:pointer;
		}
		
		.prodlibDetail .prototype .opt.select{
			color:#fff;
			border:1px solid #39c;
			background-color: #39c;
		}

		.prodlibDetail .prototype .opt.disabled{
			border:1px solid #ddd;
			color:#a1a1a1;
			/* background-color:#f7f7f7; */
		}

		.prodlibDetail .prototype .opt.disabled{
			/* cursor:not-allowed; */
		}

		@media (max-width: 1234px) {
			.prodlibDetail .centerBOX .prototype{
				width:100%;
			}
			.prodlibDetail .centerBOX .detial{
				width:100%;
			}
		}

		.prodlibDetail .detial .imgBox{
			width: 400px;
			height:244px;
			overflow:hidden;
		}
		
		.prodlibDetail .detial .swiper-container{
			width: 400px;
			height:244px;
			overflow:hidden;
		}

		.prodlibDetail .detial .imgBox img{
			display:block;
			max-width: 400px;
			max-height: 224px;
			margin:0 auto;
		}

		.prodlibDetail .detial dl,.prodlibDetail .detial .costBox,.prodlibDetail .detial .selNum,.prodlibDetail .detial .btnBox{
			margin-bottom: 15px;
		}
		.prodlibDetail .detial dt{
			margin-bottom: 5px;
			font-weight:normal;
		}

		.prodlibDetail .detial .dtTil{
			display:inline-block;
			vertical-align: middle;
			font-weight: normal;
			font-size: 14px;
			min-width: 80px;
			color:#ccc;
		}

		.prodlibDetail .detial dd,.prodlibDetail .detial dd p{
			font-size: 12px;
			color:#666;
		}

		.prodlibDetail .detial dd p{
			position: relative;
		}

		.prodlibDetail .detial dd .til_l,.prodlibDetail .detial dd .val_l{
			display:inline-block;
			vertical-align: top;
		}

		.prodlibDetail .detial dd .til_l{
			width:70px;
			overflow:hidden;
			text-overflow: ellipsis;
			white-space: nowrap;
			position:absolute;
			left:0;
			top:0;
		}

		.prodlibDetail .detial dd .val_l{
			margin-left: 70px;
		}

		.prodlibDetail .detial .costBox .v{
			color:#f66;
			font-size: 14px;
		}

		.prodlibDetail .detial .btnBox{
			text-align: center;
			font-size: 0;
		}

		.prodlibDetail .detial .btnBox a{
			display: inline-block;
			width:190px;
			line-height: 40px;
			font-size: 14px;
			border:1px solid #39c;
			border-radius: 5px;
			color:#39c;
		}

		.prodlibDetail .detial .btnBox a:hover{
			background-color: #09f;
			color:#fff;
		}

		.prodlibDetail .detial .btnBox a:first-child{
			margin-right: 10px;
			border-color: #f90;
			color:#f90;
		}

		.prodlibDetail .detial .btnBox a:first-child:hover{
			background-color: #f90;
			color:#fff;
		}

		.prodlibDetail .detial .backBot{
			width:392px;
			line-height: 40px;
			border:1px solid #ccc;
			font-size: 14px;
			color:#999;
			text-align: center;
			margin: 0 auto;
			display:block;
			border-radius: 5px;
		}

		.prodlibDetail .detial .backBot:hover{
			background-color: #ccc;
		}
		
		.prodlibDetail .detial .num-box{float: left;}

		.prodlibDetail .detial .num-box{
		     width:160px;
		}
		.prodlibDetail .detial .num-box .num-jian,
		.prodlibDetail .detial .num-box .num-jia{
		  width: 36px;
		  height: 36px;
		  line-height: 34px;
		  text-align: center;
		  border: 1px solid #eee;
		}
		.prodlibDetail .detial .num-box .num-input{
		  font-size: 12px;
		}
		.prodlibDetail .detial .num-box .num-input input{
		  height: 18px;
		  padding:9px 0;
		  border:0;
		  width: 100%;
		  text-align: center;
		  color:#999;
		  font-size: 18px;
		  box-sizing: content-box;
		}
	
		.prodlibDetail .detial .num-box .num-input{
			width: 85px;
			text-align: center;
		}
		 
		.prodlibDetail .detial .num-box .hui{
		  background-color: #f5f5f9;
		  cursor:not-allowed;
		}

		.prodlibDetail .detial .selNum .dtTil{
			float: left;
		}
		
		.leftMuneScroll .justMask{
			position: absolute;
		    left: 0;
		    top: 0;
		    width: 175px;
		    height: 51px;
		    border-bottom: 1px solid #c9d4da;
		    background-color: #fff;
		    z-index: 2;
		    display:none;
    	}
    	
    	.showAddProdTips{
    		position: absolute;
		    left: 0;
		    top: -36px;
		    width: 100%;
		    height: 36px;
		    line-height: 36px;
		    font-size: 14px;
		    color: #fff;
		    text-align: center;
		    background-color: #3c82c26b;
		    opacity:0;
		    z-index:3;
    	}
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
            	<div class="justMask" id="justMask"></div>
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
             <div class="clearfix prodlibImgtabBox prodlibImgtabBox2018">
             	<div style="overflow-x:auto;overflow-y:hidden">
             		<table id="prodPicTable" style="border:none;width:100%;" >
	                     <tbody></tbody>
	                 </table>
             	</div>
                 
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

<div class="prodlibDetail" id="prodlibDetail">
	<div class="cetBox">
		<div class="pdname"><span></span><a class="backToPLib" onclick="hideProdlibDetail()" >&lt;返回</a></div>
		<div class="centerBOX clearfix">
			<div class="fl prototype"></div>
			<div class="fr detial"></div>
		</div>

	</div>

</div>

<div class="showAddProdTips" id="showAddProdTips">
	<span>添加成功</span>
</div>


<jsp:include page="../common/footer_js.jsp" />
<script src="${prc }/common/js/bootstrap-treeview.js"></script>
<script src="${prc }/common/js/kkpager.js"></script>
<script src="${prc }/common/lib/jquery-lightbox-0.5/js/jquery.lightbox-0.5.js"></script>
<script src="${prc }/common/pager/kkpager.min.js"></script>
<script src="${prc }/common/js/ajaxfileupload.js"></script>
<script src="${prc }/common/js/imagePreview.js"></script>
<script src="${prc }/common/lib/swiper/swiper.min.js"></script>
<script src="${prc }/common/js/commonJs.js"></script>

<script>

	//添加成功提示效果
	var $showAddProdTips = $('#showAddProdTips'),
		showAddProdTips_finise = true;
	
	function showAddProdTipsFn(){
		$showAddProdTips.stop().animate({top:'0px',opacity:1},400,'swing',function(){
			
			if(!showAddProdTips_finise){
				return;
			}
			showAddProdTips_finise = false;
			setTimeout(function(){
				showAddProdTips_finise = true;
				$showAddProdTips.css({top:'-36px',opacity:0});	
			},1000);
			
		});
	}


	/*隐藏显示分类*/
	var $justMask = $('#justMask'),
		$leftLine = $(window.parent.document.getElementById('prodlib_leftMune_line'));
	function hideCagrage(){
		$justMask.show();
		$leftLine.hide();
	}
	
	function showCagrage(){
		$justMask.hide();
		$leftLine.show();
	}


	/* 产品详情展示 */
	var $prodlibDetail =$('#prodlibDetail'),
			$prodlibDetail_til = $prodlibDetail.find('.pdname span'),
			$prodlibDetail_proto = $prodlibDetail.find('.prototype'),
			$prodlibDetail_detial = $prodlibDetail.find('.detial'),
			prodlibDetail_data,
			$prodlibDetail_el,
			prodlibDetail_index;
	
	function showProdlibDetail(){
		$prodlibDetail.show();
		hideCagrage();
	}
	
	function hideProdlibDetail(){
		$prodlibDetail.hide();
		showCagrage();
	}
	
	function DetailrightInfo(data){
		
		var goodsDetail = data,
			specification = goodsDetail.specification,
			proto_opt_len,
			detial_opt_v_len,
			tpl_detial = '',
			detial_len = specification.length,
			randomNum = Math.floor(Math.random()*1000),
			img_len,
			i1,
			i2;
		
		tpl_detial += '<div class="imgBox">';
			tpl_detial += '<div class="swiper-container" id="swiperId'+randomNum+'">';
		    	tpl_detial += '<div class="swiper-wrapper">';
		    	i1 = 0;
		    	img_len = goodsDetail.pics.length;
		    	for(;i1<img_len;i1++){
		    		tpl_detial += '<div class="swiper-slide">';
			        	tpl_detial += '<img src="https://baize-webresource.oss-cn-shenzhen.aliyuncs.com/'+goodsDetail.pics[i1]+'" alt="" />';
			        tpl_detial += '</div>';
		    	}
	
		    	tpl_detial += '</div>'; 
		    tpl_detial += '<div class="swiper-pagination"></div>';
		    							    
			tpl_detial += '</div>';
		tpl_detial += '</div>';
	
	
		tpl_detial += '<dl>';
			tpl_detial += '<dt><span class="dtTil">厂商：</span></dt>';
			tpl_detial += '<dd>'+goodsDetail.basicInfo.factoryName+'</dd>';
		tpl_detial += '</dl>';
		
		tpl_detial += '<dl>';
			tpl_detial += '<dt><span class="dtTil">产品说明：</span></dt>';
			tpl_detial += '<dd>'+goodsDetail.basicInfo.briefDesc+'</dd>';
		tpl_detial += '</dl>';
		
		
		
		tpl_detial += '<dl>';
			tpl_detial += '<dt><span class="dtTil">产品详情：</span></dt>';
			tpl_detial += '<dd>';
		
				proto_opt_len = specification.length;
				i1 = 0;
				for(;i1<proto_opt_len;i1++){
					tpl_detial += '<p><span class="til_l">'+specification[i1].name+'：</span><span class="val_l">';
					
					i2 = 0;
					detial_opt_v_len = specification[i1].values.length;
					
					for(;i2<detial_opt_v_len;i2++){
						tpl_detial += specification[i1].values[i2].name+' ';
					}
					
					tpl_detial += '</span></p>';
				}
		
			tpl_detial += '</dd>';
		tpl_detial += '</dl>';
	
		
		tpl_detial += '<div class="costBox"><span class="dtTil">成本价：</span><span class="v">'+goodsDetail.basicInfo.factoryPrice+'元</span></div>';
		tpl_detial += '<div class="selNum clearfix">';
			tpl_detial += '<span class="dtTil">数量</span>';
			tpl_detial += '<div class="num-box clearfix">';
		
				tpl_detial += '<a class="num-jian fl hui noselect" onclick="changeNum(this)">-</a>';
				tpl_detial += '<div class="num-input fl">';
					tpl_detial += '<input type="text" readonly="true" value="1" />';
				tpl_detial += '</div>';
		
				tpl_detial += '<a class="num-jia fl noselect" onclick="changeNum(this)">+</a>';
			tpl_detial += '</div>';
		tpl_detial += '</div>';
		tpl_detial += '<div class="btnBox">';
			tpl_detial += '<a onclick="addTolist_a(false)">加入清单列表（留在本页）</a>';
			tpl_detial += '<a onclick="addTolist_a(true)">加入清单列表（关闭本页）</a>';
		tpl_detial += '</div>';
		tpl_detial += '<a onclick="hideProdlibDetail()" class="backBot">返回产品库</a>';
	
	
		$prodlibDetail_detial.html(tpl_detial);
	
		new Swiper ('#swiperId'+randomNum, {
		    direction: 'horizontal',
		    autoplay : true,
		    loop: true,
		    
		    // 如果需要分页器
		    pagination: {
		      el: '.swiper-pagination',
		    }
	   
		});
		
		
		
	}
	
	//加入清单列表
	function addTolist_a(close){	
		
		if(!isAllSkuSelect){
			alert('请选完产品属性');
			return;
		}
		
        var imgsrc = $prodlibDetail_el.find('.imgWp img').attr('src');
        //获取家具编号
        var fid = $prodlibDetail_el.find('input[name="productsCheckBox"]')[0].value;
        //获取家具名称
        var proname = $prodlibDetail_el.find('span[name="produceName"]')[0].title;
      //获取家具型号
        var modelNo = $prodlibDetail_el.find('input[name="modelNo"]').val();
      //产品企业
      	var companyId = $prodlibDetail_el.find('input[name="companyId"]').val();

        var cost = $prodlibDetail_el.find('input[name="cost"]').val() * $("#buyRate_"+companyId).val();  
        
        //获取产品分类ID
        var prodTypeId = $prodlibDetail_el.find('input[name="prodTypeId"]').val();
        
		var picSrc = imgsrc.substring(imgsrc.indexOf(filepath)+filepath.length,imgsrc.length);
		var countNum = $('#prodlibDetail').find('.num-input input').val();
		
		var skuId = '';

	      var comp = prodlibDetail_data.goodsSelection.composition;
	      for (var i = 0; i < comp.length; i++) {
	        var value = comp[i];
	        if (value.properties.toString() == prodlibDetail_index.toString()) {
	          skuId = value.id;
	          break;
	        }
	      };
	    
		
        var saleProd={
   			prodName:proname,
   			modelNo:modelNo,
   			prodId:fid,
   			picPath:picSrc,
   			cost:cost,
   			prodTypeId:prodTypeId,
   			sellCompany:companyId,
   			count : countNum,
   			skuId : skuId
    	};
        
        saleProdArray.push(saleProd);
        
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
           	  	  saleProdArray = [];
            	  window.top.document.getElementById('content').contentWindow.selectSaleProd($("#areaId").val());
            	  
             },
             error: function(err) {
                 alert("加载产品信息失败!"+err);
             }
         });
		
    	 
		if(close){
			window.top.hideProdLibPop();
		}
		else{
			showAddProdTipsFn();
		}
		
	}
	
	var publicprodId;
	
	function gotoPductDetail(self){

		var that = $(self),
		prodId = that.find('.hideVal').val();
		publicprodId = prodId;
		$prodlibDetail_el = that;
		isAllSkuSelect = true;
		
		$.ajax({
			url : '${prc}/prodLib/prod/'+prodId+'/detail',
			dataType : 'json',
			headers: { "with-selection": "true" },
			success : function(r){			
					
					if(r.meta && r.meta.code !== 200){
						alert(r.meta.msg);
						return;
					}
				
						
					prodlibDetail_data = r.data;

					$prodlibDetail_til.html(r.data.goodsDetail.basicInfo.name);

					$prodlibDetail_proto.html('');
					$prodlibDetail_detial.html('');
	
					var goodsDetail = r.data.goodsDetail,
						specification = goodsDetail.specification,
						selection = r.data.goodsSelection,
			            selected = selection.selected,
			            properties = selection.properties,
			            properties_len = properties.length;
			        
					
			        for (var i = 0; i < properties_len; i++) {
			         	let idx = selected.properties[i];
			            properties[i].values[idx].selected = true
			        }
						
					
			        prodlibDetail_index = selected.properties;
			        
					//渲染
					var tpl_proto = '',
						proto_len = properties_len,
						proto_opt_len,
						tpl_detial = '',
						detial_len = specification.length,
						detial_opt_len,
						detial_opt_v_len,
						img_len,
						i1,
						i2,
						temp,
						temp2,
						ishui = '',
						randomNum = Math.floor(Math.random()*1000),
						canme = '';

					i1 = 0;	
					for(;i1<proto_len;i1++){

						temp = properties[i1];
						temp2 = temp.values;
						
						tpl_proto += '<dl>';
							tpl_proto += '<dt>'+temp.name+'</dt>';
							tpl_proto += '<dd>';

								proto_opt_len = temp2.length;
								i2 = 0;
								for(;i2<proto_opt_len;i2++){
									canme = '';
									if(temp2[i2].selected){
										canme = 'select';
									}
									else if(temp2[i2].disabled){
										canme = 'disabled';
									}
									tpl_proto += '<span onclick="protoSel('+i1+','+i2+',this)" class="opt noselect '+canme+'" >'+temp2[i2].name+'</span>';
								}

							tpl_proto += '</dd>';
						tpl_proto += '</dl>';

					}

					$prodlibDetail_proto.html(tpl_proto);
					
					checkDisabel();
					
					DetailrightInfo(r.data.goodsDetail);
					
					showProdlibDetail();	

			},
			error: function(){
				alert('加载详情失败');
			}

		});

		function checkDisabel(){
			
			var $el = $('#prodlibDetail .prototype dl').eq(0).find('.opt.select').eq(0),
				ind = $el.index(),
				el = $el.eq(0);
			protoSel(0,ind,el,true);
		}
		
		
		//渲染
		showProdlibDetail();	

	}
	
	//标记有没有全部选中Sku属性
	var isAllSkuSelect = true;
	
	//选中产品属性
	function protoSel(i1,i2,self,isCheck){
		
		var $el = $(self),
	    	$all_dl_el = $el.parents('.prototype').find('dl'),
	    	properties = prodlibDetail_data.goodsSelection.properties,
	    	propertyIndex = i1,
	    	propertyValueIndex = i2,
	    	propertyDisabled = $el.hasClass('disabled'),
	    	isSelect = $el.hasClass('select'),
	    	opt_len = prodlibDetail_data.goodsSelection.properties.length,
	    	temp_str,
	    	temp_i,
	    	temp_arr = [],
	    	temp_arr2,
	    	compositions = prodlibDetail_data.goodsSelection.composition,
	    	exp,
	    	propValue,
	    	disabled;
	
	    //首先属性应该是可选的,不可选则直接返回
	    /* 
	    2018-4-16修改 仿造京东不可选也可以选
	    if (propertyDisabled) {
	      console.log('propertyDisabled');
	      return;
	    } */
	
	    // 取消该属性下的所有值的选中状态+设置当前选中状态
	    if(!isCheck){
	    	$el.siblings('.opt').removeClass('select');
	 	    if(isSelect){
	 	    	$el.removeClass('select');
	 	    }
	 	    else{
	 	    	$el.addClass('select');	
	 	    } 	
	    }
	
	    if(propertyDisabled){
	    	
	    	$el.removeClass('disabled');
	    	temp_i = 0;
	    	opt_len = prodlibDetail_data.goodsSelection.properties.length; //多少条属性标题
	    	temp_str = '';
	    	
	    	for(;temp_i<opt_len;temp_i++){
	    		if(temp_i ==  i1){
	    			temp_arr.push(i2);
	    		}
	    		else{
	    			temp_arr.push('\\d');
	    		}
	    	}	   
	    	
	    	exp = new RegExp(temp_str);
	    	
	    	temp_i = 0;
	    	for(;temp_i<opt_len;temp_i++){
	    		if(temp_i == i1){
	    			$el.siblings().removeClass('disabled');
	    			continue;
	    		}	    	
	    		temp_arr2 = temp_arr.slice();
	    		propValue = properties[temp_i].values;	
	    		for (var j = 0; j < propValue.length; j++) {
	    			
	    			temp_arr2[temp_i] = j;
	    	        exp = new RegExp('^' + temp_arr2.toString() + "$");
			        disabled = true;
			        for (var k = 0; k < compositions.length; k++) {
			          var compProp = compositions[k].properties;
			          var meet = exp.test(compProp.toString());
			          if (meet) {
			            disabled = false;
			            break;
			          }
			        };
			        if(disabled){
			        	$all_dl_el.eq(temp_i).find('span.opt').eq(j).removeClass('select').addClass('disabled');	
			        }
			        else{
			        	$all_dl_el.eq(temp_i).find('span.opt').eq(j).removeClass('disabled select');
			        }
			        
			      }
	
	    	}
	    		    	
	    	return;
	    }
	
	    // 检查当下的选择
	    var checkRes = checkSelection($all_dl_el);
	    var selectedPropertyStr = checkRes.selectedPropertyStr;
	    var selectedPropertyIndexs = checkRes.selectedPropertyIndexs;
	    prodlibDetail_index = selectedPropertyIndexs;
	
	    // 重新计算disable
	    //当第i个属性未确定,其余均取当前选择的结果,那么看第i个属性所有的值有哪些是存在于组合的
	    
	    for (var i = 0; i < selectedPropertyIndexs.length; i++) {      
	      var tmpCompProp = selectedPropertyIndexs.slice(0);
	      // 将未选中项替换为对应的正则\\d+
	      for (var j = 0; j < tmpCompProp.length; j++){
	        if (j != i && tmpCompProp[j] == -1)
	          tmpCompProp[j] = '\\d+';
	      }
	      // 遍历第i个属性的所有取值
	      propValue = properties[i].values;
	      for (var j = 0; j < propValue.length; j++) {
	        tmpCompProp[i] = j;//第i个属性取第j个值
	        exp = new RegExp('^' + tmpCompProp.toString() + "$");//生成对应的正则
	        disabled = true;
	        for (var k = 0; k < compositions.length; k++) {
	          var compProp = compositions[k].properties;
	          var meet = exp.test(compProp.toString());//判断
	          if (meet) {
	            disabled = false;
	            break;
	          }
	        };
	        if(disabled){
	        	$all_dl_el.eq(i).find('span.opt').eq(j).addClass('disabled');	
	        }
	        else{
	        	$all_dl_el.eq(i).find('span.opt').eq(j).removeClass('disabled');
	        }
	        
	      }
	    }
	    
	    if(isCheck){
	    	return;
	    }
	
	    // 更新商品详情
	    var skuId = checkRes.skuId;
	    if (skuId) {
	    	
	      $.ajax({
	    	 url: '${prc}/prodLib/prod/'+publicprodId+'/sku/'+skuId+'/detail',
	    	 datatype : 'json',
	    	 success : function(r){
	    		 
	    		if(r.meta && r.meta.code !== 200){
	    			alert(r.meta.msg);
	    			return;
	    		}
	    		 
	    		DetailrightInfo(r.data.goodsDetail);
	    		
	    	 },
	    	 error : function(){
	    		 alert('加载失败');
	    	 }
	      });	
	
	    }	
		
		
	}
	

	function checkSelection($dl) {
		// 获取所有的选中规格尺寸数据
	    var properties = prodlibDetail_data.goodsSelection.properties;
	    var needSelectNum = properties.length;
	    var curSelectNum = 0;
	    var selectedPropertyIndexs = [];
	    var selectedPropertyStr = "";
	    for (var i = 0; i < properties.length; i++) {
	      var childs = properties[i].values;
	      var s = false;
	      for (var j = 0; j < childs.length; j++) {
	    	
	    	if($dl.eq(i).find('span.opt').eq(j).hasClass('select')){
	          curSelectNum++;
	          s = true;
	          selectedPropertyIndexs.push(j);
	          selectedPropertyStr = selectedPropertyStr + childs[j].name + "，";
	        }
	      }
	      if (!s)
	        selectedPropertyIndexs.push(-1);
	    }
	    if (selectedPropertyStr.lastIndexOf("，") !== -1)
	      selectedPropertyStr = selectedPropertyStr.substr(0, selectedPropertyStr.length-1)

	    var skuId = '';
	    if (needSelectNum == curSelectNum) {
	      isAllSkuSelect = true;
	      let comp = prodlibDetail_data.goodsSelection.composition;
	      for (var i = 0; i < comp.length; i++) {
	        let value = comp[i];
	        if (value.properties.toString() == selectedPropertyIndexs.toString()) {
	          skuId = value.id;
	          break;
	        }
	      };
	    }
	    else{
	    	isAllSkuSelect = false;
	    }

	    return {
	      "skuId": skuId,
	      "selectedPropertyIndexs": selectedPropertyIndexs,
	      "selectedPropertyStr": selectedPropertyStr,
	    };
	  }
	
	
	
	
	//数量变化
	function changeNum(self){
		
		var $btn = $(self),
			$btn_add,
			$btn_cur,
			$valEl,
			val,
			change = 1,
			max = 999;
	
		if($btn.hasClass('hui')){
			return;
		}	
	
		if($btn.hasClass('num-jian')){
			change = -1;
			$btn_cur = $btn;
			$btn_add = $btn.siblings('.num-jia');
		}
	
		if(!$btn.hasClass('num-jian')){
			$btn_add = $btn;
			$btn_cur = $btn.siblings('.num-jian');
		}
	
		$valEl = $btn.siblings('.num-input').find('input');
		val = parseInt($valEl.val());
	
		val += change;
	
		$btn_add.removeClass('hui');
		$btn_cur.removeClass('hui');
	
		if(val <= 1){
			$btn_cur.addClass('hui');
			$btn_add.removeClass('hui');
		}
		else if(val >= max){
			$btn_add.addClass('hui');
			$btn_cur.removeClass('hui');
		}
		
		$valEl.val(val);
	
	}




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

                	 
                 	 showProdPic(datas.prodLibProds);
                 	 if(!datas.produces.length){
                 		 return;
                 	 }
                 	 
                 	 $fingerprint.val(datas.imgUuid);
                 	 
                 	 if(pid == ''){
                 		 pid = 'all';
                 	 }
                 	  
                     showPageInfo(pid,datas.producesCount,true);
                     //$('#prodPicTable td .daskImg').lightBox();
 
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
                 
                /*var categorySlider = easyTree({
        			isShowALL : true,
        			target : $('#prodTypeListDiv'),
        			data : dataNodes,
        			doFn : function(el_jq){
        				     			
        				$fingerprint.val('');
                    	$('#preViweImg').attr('src','');
                    	                  	                    	
                    	var lev,
                    		name = el_jq.html(),
                    		depath = el_jq.data('depath'),
                    		fid = el_jq.data('fid');

                    	if(depath == 0){
                    		is_topLevel = 'yes';
                    	}                                      	         
                    	
                    	$prodlibTilName.html(name);
                    	
                        //选中的分类data.fid 显示对应的产品图片信息等
                        removeSelectArea();
                        
                        showProdLibMsg(fid,1);
                        
                        isSereachbyImg_token = false;
                        
        			}
        		});*/
                
                $('#prodTypeListDiv').treeview({
                    data: dataNodes, // 数据源
                    showCheckbox: false, //是否显示复选框
                    highlightSelected: true, //是否高亮选中
                    iconInd : 'r',
                    //nodeIcon: 'glyphicon glyphicon-user', //节点上的图标 glyphicon-globe
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
    
    var isFirstInprodLib = true;
    
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
                //厂商
                addFatoryName(result.companys);
                //展示产品信息
                showProdPic(result.prodLibProds);             
                showPageInfo(fid,result.producesCount);
                if(isFirstInprodLib){
                	resetIfrHei();	
                }
                isFirstInprodLib = false;
                //$('#prodPicTable td .daskImg').lightBox();
				
            },
            error: function(err) {
                alert("加载产品信息失败!");
            }
        });

    }
    //分页用
    function showProdLibMsg_fy(fid,startPage,isReflash,areaId,offerId,replSaleProdId){
    	   
    	showProdLibMsg_setVal(fid,isReflash,areaId,offerId,replSaleProdId);
    	
    	 var dataForm = {},
    		fingerprint= $fingerprint.val();
    	
    	 
    	if(fingerprint){
    		dataForm["imgUuid"] = fingerprint;
    	}
    	
    	dataForm["prodTypeId"] = fid;
		dataForm["startPage"] = startPage;
		dataForm["pageSize"] = pageImgCountNum;
    	
        
        $.ajax({
            url:"${prc }/product/toListProduces",
            type: "Post",
            async:false,
            dataType:"json",
            contentType: "application/json; charset=utf-8",
            data:JSON.stringify(dataForm),
            success: function(result) {
				
                //展示产品信息
                showProdPic(result.prodLibProds);
                
				/* if(isResetImg_token){
					isResetImg_token = false;
					isSereachbyImg_token = false;
					showPageInfo(fid,result.producesCount,true);
				} */
                
                //$('#prodPicTable td .daskImg').lightBox();
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
        	colNum = 5; //每行多少个图片
        
        
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

        var thumbnail = "<div style=\"width:200px;height:190px;margin: 0px auto;\" class=\"thumbnail\" onclick='gotoPductDetail(this)'>";
        var caption = "<div style=\"width:190px;height:10px;padding: 0px;\" class=\"caption\"><nobr>";
        var tail = "</div></nobr></div>";
			
            var $tr;
            for(var j = 0;j<prodsLen;j++){
                
                var img = "";
                var checkboxe0 = "";
                var content = "";
                var content2 = "";
                var htmltext = "";
                var prodId = '<input type="hidden" class="hideVal" value="'+produces[j].id+'"/>';

                img += "<div class='imgWp'><img style=\"position:relative;\" src='"+filepath+produces[j].picPath+"' alt=''></div>";
                checkboxe0 += "<div class=\"\" style=\"margin-left: 173px;\"><input type=\"checkbox\" class=\"styled styled-primary\"  name=\"productsCheckBox\" value='' onclick=\"\" style=\"display:none\"/><label></label></div>";
                content += "<span class=\"zxx_text_overflow_1\" name=\"produceName\" title=\""+produces[j].prodName+"\">"+produces[j].prodName+"</span><input type='hidden' name=\"modelNo\" value='' /><input type='hidden' name=\"cost\" value='' /><input type='hidden' name=\"prodTypeId\" value='' /><input type='hidden' name=\"companyId\" value='' />";
                //content2 = "<div class=\"dask\"><a href=\""+filepath+""+sku.files[i].path+"\" class=\"daskImg\"></a><p><button type=\"button\" onclick=\"selectFurDetail(event)\" class=\"btn btn-primary\">详情</button>&nbsp;&nbsp;&nbsp;<button name=\"picbtn\" type=\"button\" onclick=\"picChecked(event)\" class=\"btn btn-primary\">添加</button></p></div>";
                htmltext += thumbnail + prodId + img + caption + content + checkboxe0 + content2 + tail;
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
        var allProduct = {fid:"all",text:"全部产品",path:'',nodes:"",state: {selected: true}},
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
        var pageCount = Math.ceil(producesCount/pageImgCountNum);
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
    
    var pageImgCountNum = 15; //每页显示数量
    
    function doSubmit(addParam){
    	
    	var width = $("#width").val();
    	var depth = $("#depth").val();
    	var heigth = $("#heigth").val();
    	var prodTypeId = $("#prodTypeId").val();
    	var minMoney = $("#minMoney").val();
    	var maxMoney = $("#maxMoney").val();
    	var material = $('input[name="materialRadio"]:checked').val();
    	var produceName = $("#produceName").val();
    	var factoryName = $('#factoryName').val();
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
    	
    	if(factoryName){
    		dataForm['companyIds'] = [];
    		dataForm['companyIds'].push(factoryName);
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
                //展示产品信息、
                
                showProdPic(result.prodLibProds);
                if(!result.prodLibProds.length){
                	return;
                }
                showPageInfoBydataForm(dataForm,result.producesCount);
                //$('#prodPicTable td .daskImg').lightBox();
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
                showProdPic(result.prodLibProds);
                //$('#prodPicTable td .daskImg').lightBox();
            },
            error: function(err) {
                alert("加载产品信息失败!");
            }
        });
    }
    var dataFormtmp;
    //根据fid显示页码
    function showPageInfoBydataForm(dataForm,producesCount){
        $("#kkpager").html("");
        var isbyImg = $('#sereachImgInp').val() ? true: 0;
        var pageCount = Math.ceil(producesCount/pageImgCountNum);
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
    
    function addFatoryName(companys){
    	//厂商
    	var factory_tpl = '',
    		len = companys.length,
    		i = 0;
    	factory_tpl += '<option value="">请选择</option>';
      
    	for(;i<len;i++){
    		factory_tpl += '<option value="'+companys[i].id+'">'+companys[i].name+'</option>';
    	}
    	
    	$('#factoryName').html(factory_tpl);
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
        tpls_factory = '',
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
    
    tpls_factory += '<tr>';
	    tpls_factory += '<td>';
	        tpls_factory += '<label class="opt-til"><span>厂商：</span></label>';      
	    tpls_factory += '</td>';
	    tpls_factory += '<td class="clearfix ">';
			tpls_factory += '<div style="padding:7px 0 0 14px;width:488px"><select style="margin:0;outline:none;box-shadow:none !important" class="form-control" name="" id="factoryName"></select></div>';
	    tpls_factory += '</td>';
	tpls_factory += '</tr>';

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
        	tpls_prodName += '<div id="showSereachImg" class="showSereachImg"><div class="ajust2018DivBtns" style="padding-top:46px"><a class="btns ajust2018Btns" onclick="multyChoose(this)" >筛选</a></div><!--<img src="" alt="图片预览" id="preViweImg" />--></div>';
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
	                	/*m_tpls += '<a class="btns" onclick="multyChoose(this)">筛选</a>';
	                    m_tpls += '<a class="btns" onclick="showLeftMune(0);">已选产品</a>';*/
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
			
			selectArea_randle({boxId:$slectAreaBox_sl,insetText:['prodName','size','cost','factory','other'],otherEl:[material_arr]});
			is_topLevel = 'no';
		}
		else{

			choseArr = setArrInd(['材质','颜色'],data_obj);
			
			tpls = seteasyTpl(choseArr);
			
			//selectArea_randle({boxId:$slectAreaBox_sl,insetText:['size','cost','other','prodName','submintBtn'],otherEl:[tpls]});
			selectArea_randle({boxId:$slectAreaBox_sl,insetText:['prodName','size','cost','factory','other'],otherEl:[tpls]});
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
                   case 'factory' :  tpls += tpls_factory;   
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
		$modal_dialog = $topWindow.find('.modal-dialog'),
		thisPopMinheight = 951;
	
	
	
	 function resetIfrHei(){
		var bodyHei,
			ajust = 300;
		
		if(window.parent.document.getElementById('myModal').className.indexOf(' in') === -1){
			bodyHei = $(document.getElementsByClassName('prodLibheiBox')[0]).height()-200;

			if(thisPopMinheight > bodyHei){
				bodyHei = thisPopMinheight;
			}
			
			window.parent.document.getElementById('content_prodlib').height = bodyHei;
		}
		else{
			
		
			bodyHei = $(document.getElementsByClassName('prodLibheiBox')[0]).height();			
				
			if(thisPopMinheight >= bodyHei){
				bodyHei = thisPopMinheight;
			}

			window.top.document.getElementById('content_prodlib').height = bodyHei;
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
