<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="prc" value="${pageContext.request.contextPath}"/>
<%
    String ossOuterPath = application.getInitParameter("ossOuterPath");
%>
<c:set var="filepath" value="<%=ossOuterPath%>"/>
<!DOCTYPE html>
<html><head>
    <jsp:include page="../common/head_css.jsp"/>
    <title>家具列表</title>
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
            min-height: 750px;
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
            -moz-text-overflow: ellipsis; /* for Firefox,mozilla */
        }

        .furTable thead tr th{
            text-align: center;
        }

        /* 添加的样式 */
        .topSelectBox .selectProd{width:120px;}

        ul{padding:0;margin:0;list-style: none;}
        .topSelectBox .chooseBox{float:left;margin-left: 15px;padding-right: 20px;max-width: 200px;position:relative;}
        .topSelectBox .chooseTil{float:left;width:160px;height:28px;line-height: 28px;padding-bottom: 10px;border-bottom: 1px solid #ccc;}
        .topSelectBox .select-btn{position:relative;padding:0 25px 0 12px;height:32px;line-height: 32px;border-radius: 4px;border:1px solid #ccc;box-shadow: inset 0 1px 1px rgba(0,0,0,.075);display:block;}

        .topSelectBox .ico{position:absolute;width:16px;height:16px;background:url('img/tri_down.png') no-repeat 2px 5px;top:50%;right:5px;margin-top: -8px;}
        .topSelectBox .downMune{display:none;}
        .topSelectBox .chooseBox.active .ico{background-image: url('img/tri_up.png');}
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

        .table-img-aotu td img{display:block;}
        .table-textArea-aotu td textarea{display:block;width:100%;}
        .table-select-aotu td select{display:block;width:100%;max-width: 85px;margin:0 auto;}
        .table-head-midle th{vertical-align: middle !important;}
        .topSelectBox .selectProdBtn{float: right; line-height: 34px; border-radius: 4px; padding: 0 10px; background-color: #337ab7; color: #fff; margin-left: 5px;text-decoration: none;}
        .topSelectBox .selectProdBtn:active{background-color: #2689de;}

        #recommendForm .min-input{width:52px;margin-right:5px}
        #recommendForm .input-smm{width:68px;margin-right:5px}
        #form01 .hangdle-td{text-align:center;}
        #form01 .hangdle-td a,#form01 .hangdle-td label{display:inline-block;padding:3px 4px;margin-bottom:5px}

        #form01 .hangdle-td label:after{display:none}
        #form01 .hangdle-td label span,#form01 .hangdle-td label input{display:inline-block;vertical-align: middle;}
        #form01 .hangdle-td label input{margin:0}
        .furTable select{background-color:#fff !important}

        .setOtherAttr{color:#337ab7;white-space: nowrap;text-overflow: ellipsis;overflow:hidden;display:block}
        .prodName-ico{display:inline-block;width:24px;height:24px;margin-right:3px;background:url('${prc }/common/img/pad_furlist_prodname.png') no-repeat;}
        .prodName-ico,.prodName-ico+span{vertical-align:middle}

        .furList{background-color: #f6f6f6 !important;}
        .furList table{table-layout: fixed;}
        .furList th{font-weight: normal;border-bottom: 0;}
        .furList td,.furList th{vertical-align: middle;text-align: center;font-size: 14px;color:#666;}
        .furList th:first-child input[type="checkbox"],.furList td input[name="salecheckbox"]{border:1px solid #ccc;width:18px;height:18px;cursor: pointer;}

        .furList .handle-link{white-space: normal !important;}
        .furList table a,.furList .handle-link label{display: inline-block; padding: 3px 4px; margin-bottom: 5px;color:#3c82c2;font-size: 12px !important;font-weight:normal;cursor:pointer;}
        .furList table a,.furList .handle-link label,.furList .handle-link label input{vertical-align: middle;}
        .furList .handle-link label input{margin:-1px 0 0 0;}
        .furList .imgWp{max-height: 80px;max-width: 100px;margin:5px;overflow:hidden;display:inline-block;}
        .furList .imgWp img{max-width: 100px;max-height: 80px;}
        .furList select{width:100%;display:inline-block;}
        .furList .prodName,.offer-setPrice-box .saleprodTable .prodName{text-overflow: ellipsis;overflow:hidden;white-space: normal;word-break:break-all;word-wrap:break-word;max-height:100px;}
        .furList .resetWp,.offer-setPrice-box .saleprodTable .resetWp{overflow:visible;text-overflow:clip;white-space:normal}
        .furList input[type="text"]{width:80%;height:18px;line-height: 18px;padding:5px 5px;box-sizing: content-box;border:1px solid #ccc;border-radius: 2px;}
        .furList table a:first-child{margin-left:15px}
        .setOtherAttr{color:#3c82c2;cursor:pointer;}

        .furTable tr{display:table-row !important;}


        .furProdlist .num-box{
            width:120px;
        }
        .furProdlist .num-box .num-jian,
        .furProdlist .num-box .num-jia{
            width: 24px;
            height: 24px;
            line-height: 22px;
            text-align: center;
            border: 1px solid #eee;
        }
        .furProdlist .num-box .num-input{
            font-size: 12px;
        }
        .furProdlist .num-box .num-input input{
            height: 18px;
            padding:4px 0;
            border:0;
            width: 100%;
            text-align: center;
            color:#999;
            font-size: 14px;
            box-sizing: content-box;
        }

        .furProdlist .num-box .num-input{
            width: 60px;
            text-align: center;
        }

        .furProdlist .num-box .hui{
            background-color: #f5f5f9;
            cursor:not-allowed;
        }


        .furProdlist table{
            table-layout: fixed;
            width:100%;
        }


        .furProdlist{
            border:1px solid rgba(246, 246, 246, 1);
        }

        .furProdlist .boxtil{
            line-height: 32px;
            background-color: #f6f6f6;
            font-size: 12px;
            color:#999;
            padding-left: 10px;
        }

        .furProdlist .tabSelIco{
            display:block;
            width:18px;
            height:18px;
            margin: 0 auto;
            background:url(${prc}/common/img/product/furlist_tab_selItem.png);
            cursor:pointer;
        }

        .furProdlist .tabSelIco.active{
            background-position: top right;
        }

        .furProdlist td{
            padding: 7px 0;
            border-bottom: 1px solid #f2f2f2;
        }

        .furProdlist .prodIcoBox{
            width:250px;
        }

        .furProdlist .prodIcoBox .imgbox{
            width: 128px;
            height: 72px;
            overflow: hidden;
        }

        .furProdlist .imgbox img{
            max-width: 128px;
            max-height: 72px;
            display:block;
            margin: 0 auto;
        }

        .furProdlist .prodIcoBox .prodName{
            width:110px;
            padding-left: 10px;
            word-break: break-all;
            word-wrap: break-word;
            font-size: 12px;
            color: #999;
        }

        .furProdlist .protype div{
            float: left;
            width: 47%;
            font-size: 12px;
            color: #999;
        }

        .furProdlist .protype div:first-child{
            margin-right: 6%;
        }

        .furProdlist .costBox .number{
            font-size: 16px;
            color: #666;
        }

        .furProdlist .costBox .expl{
            font-size: 12px;
            color: #999;
        }

        .furProdlist .costBox{
            text-align: center;
        }

        .furProdlist .handtd a{
            display: block;
            font-size: 12px;
        }

        .furProdlist .handtd label input{
            margin: 0;
            vertical-align: middle;
        }
        .furProdlist .handtd label span{
            display:inline-block;
            vertical-align: middle;
            font-size:12px;
            font-weight:normal;
        }

        .furProdlist .tabSel input{
            display:none;
        }

        .ajustTab2018{
            border-radius: 5px;
            border:1px solid #f0f2f5 !important;
            margin-bottom: 20px;
            box-shadow: 1px 1px 1px #ddd;
        }

        .recommendTab2018{
            margin-bottom: 0 !important;
        }

        .recommendTab2018 .hasBg{
            background-color: #f0f2f5;
        }

        .recommendTab2018 td{
            border: 0 !important;
        }



    </style>
</head>
<body>
<div class="container-fluid">

    <%--<div class="" style="height:480px;overflow-y:scroll; overflow-x:scroll;">
        <form id="form01" class="form-horizontal table-img-aotu table-textArea-aotu table-select-aotu" role="form" action="${prc}/offerList/saveProdData" method="post" height="100%">
             <%--<input type="hidden" name="offerId" id="offerId" value="${area.offerId }"/>
       		 <input type="hidden" name="areaId" id="areaId" value="${area.fid}">
       		 <input type="hidden" name="areaName" value="${area.areaName}">

            <table class="table table-hover table-bordered table-striped furTable table-head-midle table-td-midle" id="sort" style="text-align: center;table-layout: fixed;">
                <thead style="height:30px;">
                <tr>
                    <!-- <th width="3%"><input type="checkbox" name="saleSelectedAll" style="zoom:138%;vertical-align: middle;" onclick="saleSelectedAllClick()"></th> -->
                    <th width="4%" class="index">序号</th>
                    <th width="8%">实物照</th>
                    <th width="10%">名称</th>
                    <th width="8%">材质</th>
                    <th width="8%">颜色</th>
                    <th width="9%">尺寸(W*D*H)</th>
                    <th width="8%">其他属性</th>
                    <!-- <th width="4%">产品说明</th> -->
                    <th width="8%">数量</th>
                    <th width="10%">操作</th>
                </tr>
                </thead>

                <tbody class="tabledata" style="">
                	<c:if test="${'' != area}">
                        <c:forEach items="${area.saleProdList}" var="salP" varStatus="salePInd">
                          <tr id="${salP.prodId}" class="sortTR">
                              <input type="hidden" name="prods[${salePInd.index}].prodName" value="${salP.prodName}">
                              <input type="hidden" name="prods[${salePInd.index}].fid" value="${salP.fid}">
                              <input type="hidden" name="prods[${salePInd.index}].prodId" value="${salP.prodId}">
                              <input type="hidden" name="prods[${salePInd.index}].cost" value="${salP.cost}" />
                              <input type="hidden" name="prods[${salePInd.index}].modelNo" value="${salP.modelNo}"/>
                              <input type="hidden" name="prods[${salePInd.index}].prodTypeId" value="${salP.prodTypeId}"/>
                              <input type="hidden" name="prods[${salePInd.index}].sellCompany" value="${salP.sellCompany}"/>
                              <input type="hidden" id="oldcost${salePInd.index}" value="${salP.cost}"/>
                              <input type="hidden" name="prods[${salePInd.index}].clearTag" value="0"/>
                              <!-- 其他属性 -->
                              <input type="hidden" name="prods[${salePInd.index}].otherPropValue" value="${salP.otherPropValue}"/>
                              <!-- <td style="vertical-align: middle;"><input type="checkbox" name="salecheckbox" value="${salP.fid}" style="zoom:138%;"/></td> -->
                                <td class="textOverflow index">
                                        ${salePInd.index+1}
                                </td>
                                <td style="vertical-align: middle;"><img src="${filepath}${salP.picPath}" /><input type="hidden" name="prods[${salePInd.index}].picPath" value="${salP.picPath}"/></td>
                                <td class="textOverflow" style="text-align:left"><i class="prodName-ico" ontouchstart='showProdFullname("${salP.prodName}")'></i><span ontouchstart='showProdFullname("${salP.prodName}")'>${salP.prodName}</span></td>
                                <!-- <td class="textOverflow" title="${salP.modelNo}">${salP.modelNo}</td> -->
                                <td style="vertical-align: middle;" class="loadDealwith">
                                 	<select name="prods[${salePInd.index}].meterial" style="height: 30px;">
                                        <c:forEach items="${proProValueMap}" var="proProValue">
                                            <c:if test="${proProValue.key eq salP.prodId}">
                                                <c:forEach items="${proProValue.value[0]}" var="item">
                                                	<c:if test="${item.optValue eq salP.meterial}">
                                                		<option selected >${item.optValue}</option>
                                                	</c:if>
                                                	<c:if test="${item.optValue ne salP.meterial}">
                                                    	<option >${item.optValue}</option>
                                                	</c:if>
                                                </c:forEach>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td style="vertical-align: middle;" class="loadDealwith">
                                    <select name="prods[${salePInd.index}].color" style="height: 30px;">
                                        <c:forEach items="${proProValueMap}" var="proProValue">
                                            <c:if test="${proProValue.key eq salP.prodId}">
                                                <c:forEach items="${proProValue.value[1]}" var="item">
                                                	<c:if test="${item.optValue eq salP.color}">
                                                    	<option selected>${item.optValue}</option>
                                                    </c:if>
                                                    <c:if test="${item.optValue ne salP.color}">
                                                    	<option >${item.optValue}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td style="vertical-align: middle;" class="loadDealwith">
                                    <select name="prods[${salePInd.index}].standard" style="height: 30px;" onchange="valiadSku(this)">
                                        <c:forEach items="${proProValueMap}" var="proProValue">
                                            <c:if test="${proProValue.key eq salP.prodId}">
                                                <c:forEach items="${proProValue.value[2]}" var="item">
                                                	<c:if test="${item.optValue eq salP.standard}">
                                                    	<option selected>${item.optValue}</option>
                                                    </c:if>
                                                    <c:if test="${item.optValue ne salP.standard}">
                                                    	<option >${item.optValue}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td style="vertical-align: middle;">
                                	<c:if test="${not empty salP.otherPropValue}">
	                                     <span class="setOtherAttr" ontouchstart="setOtherAttr(this)">${salP.otherPropValue}</span>
                                    </c:if>
                                    <c:if test="${empty salP.otherPropValue}">
	                                    <span class="setOtherAttr" ontouchstart="setOtherAttr(this)">设置</span>
                                    </c:if>

                                </td>
                                <!--<td style="vertical-align: middle;">
                                	<a href="javascript:prodIntroduction('${salP.memo}')"><span class="glyphicon glyphicon-info-sign" title="${salP.memo}" style="font-size: large;"></span></a>
                                </td>-->
                                <td class="textOverflow">
                                	<input type="text" class="form-control" name="prods[${salePInd.index}].count" value="${salP.count}" onchange="parent.totalCosts();" onfocus="conditionFocus('prods[${salePInd.index}].count');" onblur="conditionBlur('prods[${salePInd.index}].count')" onkeyup="this.value=this.value.replace(/[^0-9]/g,'')" onafterpaste="this.value=this.value.replace(/[^0-9]/g,'')"/>
                                </td>

                                <td class="hangdle-td" style="vertical-align: middle;">
                                	<a href="javascript:void(0)" onclick="replCurrentRow(this,'${salP.fid}')">替换</a>
                                	<a href="javascript:void(0);" onclick="deleteCurrentRow(this,'${salP.fid}');">删除</a>
                                	<label>
                                		<span>备选</span>
                                		<c:if test="${salP.backup eq '1'}">
		                                    <input type="checkbox" class="styled styled-primary" name="prods[${salePInd.index}].backup" value="1" checked="checked"/><label></label>
	                                    </c:if>
	                                    <c:if test="${salP.backup eq '0'}">
	                                        <input type="checkbox" class="styled styled-primary" name="prods[${salePInd.index}].backup" value="1"/><label></label>
	                                    </c:if>
                                	</label>
                                	<a class="hangdle-remark">备注</a>
                                    <input type="hidden" name="prods[${salePInd.index}].remark" value="${salP.remark}"/>
                                	<input type="hidden" name="prods[${salePInd.index}].sequNum" value="${salePInd.index+1}"/>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>

                </tbody>
                <tbody style="border-top:none;">
                     <tr>
                         <td colspan="9" align="center"> <button type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal" onclick="showProdBob();">+ 添加家具</button></td>
                     </tr>
                 </tbody>
            </table>
        </form>
          <div style="margin-top: -13px;padding-bottom: 17px;text-align:right;padding-right:10px">
                <input type="hidden" id="totalProdCost" value="${totalProdCost}"/>
                小计：<span id="areaMinCost">0</span> 元
            </div>
    </div>--%>



    <div class="furProdlist">
        <div class="boxtil"><%--<span class="selectAll" style="display:inline-block;width:40px"><i class="tabSelIco" onclick="selectAll(this)" style="display: inline-block;margin-top: 0px;vertical-align: middle;margin-left: 6px;"></i></span>--%>产品清单</div>
        <div class="tablist">
            <form id="form01" class="form-horizontal table-img-aotu table-textArea-aotu table-select-aotu" role="form"  action="${prc}/offerList/saveProdData" method="post" height="100%">
                <input type="hidden" name="offerId" id="offerId" value="${area.offerId }"/>
                <input type="hidden" name="areaId" id="areaId" value="${area.fid}">
                <input type="hidden" name="areaName" value="${area.areaName}">
                <input type="hidden" name="isfurAddNew" value="true">

                <table class="furTable" id="sort">

                    <tbody>
                    <c:if test="${'' != area}">
                        <c:forEach items="${area.saleProdIntro}" var="salP" varStatus="salePInd">

                            <tr id="${salP.prodId}" class="sortTR">

                                    <%--<input type="hidden" name="prods[${salePInd.index}].prodName" value="${salP.prodName}">
                                    <input type="hidden" name="prods[${salePInd.index}].fid" value="${salP.fid}">
                                    <input type="hidden" name="prods[${salePInd.index}].prodId" value="${salP.prodId}">
                                    <input type="hidden" class="cost-js" name="prods[${salePInd.index}].cost" value="${salP.cost}" />
                                    <input type="hidden" name="prods[${salePInd.index}].prodTypeId" value="${salP.prodTypeId}" class="prodTypeId-js"/>
                                    <input type="hidden" name="prods[${salePInd.index}].sellCompany" value="${salP.sellCompany}"/>
                                    <input type="hidden" id="oldcost${salePInd.index}" value="${salP.cost}"/>
                                    <input type="hidden" name="prods[${salePInd.index}].clearTag" value="0"/>
                                    <!-- 其他属性 -->
                                    <input type="hidden" name="prods[${salePInd.index}].otherPropValue" value="${salP.otherPropValue}"/>--%>

                                <input type="hidden" name="prods[${salePInd.index}].prodName" value="${salP.prodName}">
                                <input type="hidden" name="prods[${salePInd.index}].skuId" value="${salP.skuId}">
                                <input type="hidden" name="prods[${salePInd.index}].fid" value="${salP.fid}">
                                <input type="hidden" name="prods[${salePInd.index}].prodId" value="${salP.prodId}">
                                <input type="hidden" class="cost-js" name="prods[${salePInd.index}].cost" value="${salP.cost}" />
                                <input type="hidden" name="prods[${salePInd.index}].modelNo" value="${salP.modelNo}"/>
                                <input type="hidden" name="prods[${salePInd.index}].prodTypeId" value="${salP.prodTypeId}" class="prodTypeId-js"/>
                                <input type="hidden" name="prods[${salePInd.index}].sellCompany" value="${salP.sellCompany}"/>
                                <input type="hidden" id="oldcost${salePInd.index}" value="${salP.cost}"/>
                                <input type="hidden" name="prods[${salePInd.index}].clearTag" value="0"/>

                                <td width="250px">
                                    <div class="clearfix prodIcoBox">
                                        <div class="fl imgbox">
												<span class="tableC">
													<img src="${filepath}${salP.picPath}" id="prods[${salePInd.index}].picPath"/>
													<input type="hidden" name="prods[${salePInd.index}].picPath" value="${salP.picPath}"/>
												</span>
                                        </div>
                                        <div class="tableBox">
												<span class="tableC">
													<span class="fl prodName">${salP.prodName}</span>
												</span>
                                        </div>
                                    </div>
                                </td>

                                <td width="40%">
                                    <div class="protype clearfix">
                                        <div class="fl" style="width:88%;padding-left: 5%">
                                            <c:forEach items="${salP.propertyValue}" var="property" varStatus="pInd" >
                                            <c:if test="${pInd.index eq 4 }">
                                        </div>
                                        <div class="fl" style="width:88%;padding-left: 5%">
                                            </c:if>
                                            <p><span class="proTil">${property.key }：</span><span class="proVal">${property.value }</span></p>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </td>

                                <td width="15%" name="cost">
                                    <div class="costBox">
                                        <div class="midBox">
                                            <span class="number"><span class="number"><fmt:formatNumber value="${salP.cost}" type="number" maxFractionDigits="0" /></span>元</span>
                                            <p class="expl">成本价</p>
                                        </div>
                                    </div>
                                </td>

                                <td width="120px">

                                    <div class="num-box clearfix">
                                        <a class="num-jian fl <c:if test="${salP.count le 1}">hui</c:if> noselect" onclick="changeNum(this)">-</a>
                                        <div class="num-input fl">
                                            <input type="text" class="count-js" readonly="true" name="prods[${salePInd.index}].count" value="${salP.count}" />
                                        </div>
                                        <a class="num-jia fl <c:if test="${salP.count ge 999}">hui</c:if> noselect" onclick="changeNum(this)">+</a>
                                    </div>

                                </td>

                                <td class="handtd" width="60px">
                                    <a class="del" onclick="deleteCurrentRow(this,'${salP.fid}');">删除</a>
                                    <a class="replace" onclick="replCurrentRow(this,'${salP.fid}')">重选</a>
                                    <label>
                                        <c:if test="${salP.backup eq '1'}">
                                            <input type="checkbox" class="styled styled-primary" name="prods[${salePInd.index}].backup" value="1" checked="checked"/>
                                        </c:if>
                                        <c:if test="${salP.backup eq '0'}">
                                            <input type="checkbox" class="styled styled-primary" name="prods[${salePInd.index}].backup" value="1"/>
                                        </c:if>
                                        <span>备选</span>
                                    </label>

                                    <a class="beizhu hangdle-remark">备注</a>
                                    <input type="hidden" class="remarkVal-js" name="prods[${salePInd.index}].remark" value="${salP.remark}"/>
                                    <input type="hidden" name="prods[${salePInd.index}].sequNum" value="${salePInd.index+1}"/>
                                </td>

                            </tr>

                        </c:forEach>
                    </c:if>

                    </tbody>
                </table>
            </form>
        </div>
        <div class="textAli-c padding-10">
            <button type="button" class="btn btn-primary addFurBtn" onclick="window.top.openProdLibPop('',1,true,'${area.fid}','${area.offerId}');">+ 添加家具</button>
        </div>
        <div class="bo-btom" style="text-align: right;line-height: 30px;border-top: 1px solid #f6f6f6;padding-right: 10px">

            <input type="hidden" id="totalProdCost" value="${totalProdCost}"/>小计：<span id="areaMinCost">${totalProdCost}</span> 元
            <%--<input type="hidden" id="totalProdCost" value="${otherAreaProdCost}"/>小计：<span id="areaMinCost">0</span> 元--%>
        </div>
        <%-- <div class="bo-btom">
             各区域合计：<span id="allAreaCost">0</span> 元
         </div>--%>

    </div>




</div>

<div style="display:none" id="recommendTempls">
    <c:forEach items="${recommendTempls}" var="type">
        <option value="${type.fid}">${type.name}</option>
    </c:forEach>
</div>

<%--保存状态--%>
<input type="hidden" id="savestatus" value="${status}"/>

<jsp:include page="../common/footer_js.jsp" />
<script src="${prc }/common/js/json2.js"></script>
<script src="${prc }/common/js/jquery.form.js"></script>
<script src="${prc }/common/js/jquery-ui.min.js"></script>
<script>

    var $dealwithSl_td = $('#form01 .loadDealwith'),
        $dealwithSl_sl = $('#form01 .loadDealwith select'),
        $dealwithSl_len = $dealwithSl_td.length;

    for(;$dealwithSl_len--;){
        if($dealwithSl_sl.eq($dealwithSl_len).find('option').length == 0){
            $dealwithSl_td.eq($dealwithSl_len).html('/');
        }
    }

    function showProdFullname(name){
        var opt = {},
            e = window.event;

        e.stopPropagation();
        e.preventDefault();

        opt.btnName = ['关闭'];
        opt.til = '名称';
        opt.tpls = '<div class="textAli-c">'+name+'</div>';
        opt.btnNum = 1;
        window.top.runHomePublicPop(opt);
    }


    function setOtherAttrPop(tpl,Fn,showFn){
        var opt = {};
        opt.til = '家具的其他属性设置';
        opt.tpls = tpl;
        opt.btnNum = 2;
        opt.cb = Fn;
        opt.ready = showFn;
        window.top.runHomePublicPop(opt);
    }


    /* 设置其他属性 */
    function setOtherAttr(that){
        var e = window.event;
        e.stopPropagation();
        e.preventDefault();
        var self = $(that),
            oldVal = self.html(),
            oldVal_len = 1,
            temp_oldVal_len,
            //prodId = '05DxMZn1QdaqCnXx6KdzA';
            prodId = self.parents('tr').find('input[name$=".prodId"]').val();

        $.ajax({
            type: "GET",
            async:true,
            url:"${prc }/prodProperty/getOtherProperty",
            data:"prodId="+prodId,
            dataType:'text',
            success: function(result) {

                var tpl = '',
                    result = JSON.parse(result),
                    dataArr = result.otherProPropertyVal,
                    data_Arr_len = dataArr.length,
                    data_Arr_len_t = data_Arr_len,
                    item,
                    item_len,
                    fntemp,
                    cbFn,
                    temp,
                    showFn;

                tpl += '<div class="form-horizontal" id="SelectTempPop">';

                if(!data_Arr_len_t){
                    tpl += '<div class="textAli-c">无可添加的其他属性</div>';
                    fntemp = true;
                }
                else{
                    tpl += '<form id="tempForm">';
                    if(oldVal === '设置'){
                        oldVal = false;
                    }
                    else{
                        oldVal = oldVal.split('/');
                        oldVal_len = oldVal.length;
                    }

                    for(;data_Arr_len--;){
                        temp = dataArr[data_Arr_len];
                        tpl += '<div class="form-group row margin-top-3">';
                        tpl += '<label class="col-xs-4 text-right control-label">';
                        tpl += '<span>'+temp.name+'：</span>';
                        tpl += '</label>';

                        if(temp.prodProValueRefs){
                            item = temp.prodProValueRefs;
                            item_len = item.length;

                            tpl += '<div class="col-xs-6 row">';
                            tpl += '<select class="form-control ">';
                            tpl += '<option>请选择</option>';
                            for(;item_len--;){
                                temp_oldVal_len = oldVal_len;
                                tpl += '<option ';
                                if(oldVal){
                                    for(;temp_oldVal_len--;){

                                        if(oldVal[temp_oldVal_len] === item[item_len].propValue){
                                            tpl += 'selected="selected"';
                                        }
                                    }
                                }
                                tpl += '>'+item[item_len].propValue+'</option>';
                            }

                            tpl += '</select>';
                            tpl += '</div>';

                        }

                        tpl += '</div>';

                    }
                    tpl += '<div class="form-group row margin-top-3"><label class="col-xs-4 text-right control-label"></label><div class="col-xs-6 row"><button class="btn btn-primary" type="button" id="resetTemp">重置</button></div></div>';
                    tpl += '</form>';

                }

                tpl += '</div>';

                if(!fntemp){
                    cbFn = function(){
                        var $tempSle = $(window.top.document.getElementById('SelectTempPop')).find('select'),
                            len = $tempSle.length,
                            reStr = '',
                            isAllReset = true,
                            text,
                            i = 0;
                        for(;i<len;i++){
                            text = $tempSle.eq(i).find('option:selected').text();
                            if(text !== '请选择'){
                                reStr +=  '/' + text;
                                isAllReset = false;
                            }
                        }

                        if(reStr.length>1){
                            reStr = reStr.substr(1);
                        }

                        if(isAllReset){
                            reStr = '设置';
                        }

                        self.html(reStr);
                        self.parents('tr').find('input[name$="].otherPropValue"]').val(reStr);
                    };
                }
                else{
                    cbFn = function(){};
                }

                showFn = function(){

                    var $tempBox = $(window.top.document.getElementById('SelectTempPop')),
                        $resetBtn = $tempBox.find('#resetTemp'),
                        $getSelect = $tempBox.find('select'),
                        select_len = $getSelect.length,
                        $getForm = $tempBox.find('#tempForm');


                    $resetBtn.on('touchstart',function(e){
                        var e = e || window.event,
                            tempLen = select_len;

                        if(e.stopPropagation){
                            e.stopPropagation()
                        }
                        else{
                            e.cancelBubble = true;
                        }
                        if(tempLen < 0){
                            return;
                        }
                        for(;tempLen--;){
                            $getSelect.eq(tempLen).find('option:selected').removeAttr('selected');
                        }
                        $getForm[0].reset();
                    });
                };

                setOtherAttrPop(tpl,cbFn,showFn);
            },
            error: function(err) {
            }
        });
    }






    /* 产品说明 */
    function prodIntroduction(text){
        var tpl_str = '',
            opt = {};

        tpl_str += '<div style="max-height:80px;overflow:aotu">'+text+'</div>';

        opt.til = '产品说明';
        opt.tpls = tpl_str;
        opt.btnNum = 1;
        window.top.runHomePublicPop(opt);
    }

    /* 备注操作 */
    $('#form01').on('touchstart','.hangdle-remark',function(e){
        e.stopPropagation();
        e.preventDefault();
        var $hide_el = $(this).next('input[type="hidden"]'),
            val = $hide_el.val(),
            opt = {},
            tpl_str = '',
            temp;

        tpl_str += '<div class="form-group row margin-top-3">';
        tpl_str += '<label class="col-xs-2 text-right control-label"><span>备注：</span></label>';
        tpl_str += '<div class="col-xs-10 row"><textarea class="form-control" rows="4" id="tempTextarea">'+val+'</textarea></div>';
        tpl_str += '</div>';

        opt.til = '备注信息';
        opt.msg = tpl_str;
        opt.btnNum = 2;
        opt.cb = function(){

            var val = $(window.top.document.getElementById('tempTextarea')).val();
            $hide_el.val(val);
        };
        window.top.runHomePublicPop(opt);

    });

    /*打开产品库*/
    function showProdBob(){
        window.parent.showParentProdLib('all',1,true,'${area.fid}','${area.offerId}');
        //window.parent.showProdLibMsg('all',1,true,'${area.fid}','${area.offerId}');
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

    $('#myModal').on('hidden.bs.modal',function(){
        var el = $("#content")[0].contentWindow.document.getElementById('jquery-overlay');
        if(el){
            el.click();
        }

    });


    //替换当前产品
    function replCurrentRow(obj,replSaleProdId){

        //先保存当前产品信息
        saveSaleProd();
        var tr=obj.parentNode.parentNode.parentNode;

        var tr=$(obj).parents('tr');

        var prodTypeId = tr.find('.prodTypeId-js').val();

        //$('#myModal').modal('show');

        //获取数量
        var prodNum = $(obj).parents('tr').find('.count-js').val();

        if(!prodNum){
            prodNum = 0;
        }

        $.ajax({
            url: '${prc}/offerList/customProdType/'+replSaleProdId,
            success : function(r){

                var id = r;
                //弹出模态框
                window.top.openProdLibPop(id,1,true,'${area.fid}','${area.offerId}',replSaleProdId,prodNum);
            },
            error : function(){
                alert('替换失败');
            }
        });
    }

    //删除当前产品
    function deleteCurrentRow(obj,fid){

        var opt = {},
            tpl_str = '';

        tpl_str = '<div>确定要删除？</div>';

        opt.til = '删除家具';
        opt.msg = tpl_str;
        opt.btnNum = 2;
        opt.cb = function(){

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
            parent.totalCosts();

        };
        window.top.runHomePublicPop(opt);

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

    /* 设置iframe的高度 */
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
        /*  $("#sort tbody:eq(0)").sortable({
              helper: fixHelperModified,
              stop: updateIndex
         }).disableSelection(); */
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

    //家具列表数量变化
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

        //重新计算区域总价
        window.parent.totalCosts();

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
            })
        }
    }

    $recommendTempls = $('#recommendTempls');
    setTimeout(function () {
        var ifr = window.parent.document.getElementById('areaDistributionFrame').contentWindow;

        if(!ifr.hasRanderTuijian){
            ifr.hasRanderTuijian = true;
            ifr.document.getElementById('recommendProd_selet').innerHTML = $recommendTempls.html();
        }
        window.parent.loadedSetIframeHeight();
    },100);




</script>


</body></html>