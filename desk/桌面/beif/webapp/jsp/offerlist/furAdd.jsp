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
    <title>index</title>
	<jsp:include page="../common/head_css.jsp"/>
<%--     <link rel="stylesheet" href="${prc }/common/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="${prc }/common/css/build.css"/> --%>
    <style>
    	 @-moz-document url-prefix(){
    	 	.furTable.nolist{border-collapse: separate !important;}
    	 }
    </style>
</head>
<body style="background-color: transparent;height:auto;" class="offerFurList-page">

  <div class="furListBox">
     <div class="row head-inp margin-b-20">
         <div class="col-sm-3 col-md-3 col-lg-3">
          	<input type="text" id="areaName" name="areaName" class="form-control" value="${area.areaName}"  placeholder="区域名称" onblur="updateAreaName();" onfocus="changeAreaName();" />
          	<input type="hidden" id="areaNameCp" value="${area.areaName}">
         </div>
         <div class="col-sm-1 col-md-1 col-lg-1">
            <p class="text-right"><button type="button" style="background-color: #fff;border-color: #ff9999;color: #ff9999;" onclick="$(window.parent.$('#areaDistributionFrame'))[0].contentWindow.deleteArea('${area.fid}','${area.offerId}')" class="btn btn-default btn1">删除区域</button></p></div>
         <div class="col-sm-1 col-md-1 col-lg-1">
             <p class="text-right"><button type="button" style="background-color: #fff;border-color: #ff9999;color: #ff9999;" onclick="deleteSaleProdBatch()" class="btn btn-default btn2">批量删除产品</button></p>
         </div>
         <div class="fr padding-r-15">
           <a id="offerFurSetPrice" class="btn btn-primary" style="width:100px">编辑报价</a>
         </div>
     </div>
     <div class="row">
         <div class="col-sm-12 col-md-12 col-lg-12">
             <div class="well well-sm ajustTab" style="padding-bottom: 0;">
             <form id="recommendForm" class="form-horizontal padding-r-1" action="${prc}/offerListCreate/toUpdateProdByArea" method="post" onsubmit="return checkrecommendForm();">
	            <input type="hidden" id="offerId" name="offerId" value="${area.offerId }"/>
				<input type="hidden" id="areaFid" name="fid" value="${area.fid}">
				<input type="hidden" name="functionArea" value="${area.functionArea}">
				<input type="hidden" name="areaName" value="${area.areaName}">
				<c:forEach items="${user.compDealerAuths}" var="compAuth">
	               <input type="hidden" id="buyRate_${compAuth.company}" value="${compAuth.buyRate}"/>
	            </c:forEach>
                 <table class="table table-bordered recommendTab" height="58px">
                     <tbody><tr>
                         <td class="bg-gray" style="vertical-align: middle;">户型面积</td>
                         <td style="vertical-align: middle;">
                             <input type="text" name="length" placeholder="长" value="${area.lengthToM}" onfocus="conditionFocus('length');" onblur="conditionBlur('length')" onkeyup='clearNoNum(this)'/>
                             <i class="ride-ico">X</i>
                         	 <input type="text" name="width" placeholder="宽"  value="${area.widthToM}" onfocus="conditionFocus('width');" onblur="conditionBlur('width')" onkeyup='clearNoNum(this)'/><span>m</span>
                         </td>
                         <td class="bg-gray" style="vertical-align: middle;">员工数</td>
                         <td style="vertical-align: middle;">
                             <nobr>
                             	 <input type="text" name="staffCount" placeholder="员工数" value="${area.staffCount}"  onfocus="conditionFocus('staffCount');" onblur="conditionBlur('staffCount')"  onkeyup="this.value=this.value.replace(/[^0-9]/g,'')" onafterpaste="this.value=this.value.replace(/[^0-9]/g,'')"/>
                             <span>人</span>
                             </nobr>
                         </td>
                         <td class="bg-gray" style="vertical-align: middle;">成本预算</td>
                         <td style="vertical-align: middle;"><nobr><input type="text" class="inp1" name="budget" placeholder="成本预算" value="${area.budget}" onfocus="conditionFocus('budget');" onblur="conditionBlur('budget')" onkeyup='clearNoNum(this)'/><span>元</span></nobr></td>                       									
                         <td class="bg-gray" style="vertical-align: middle;">推荐方案</td>
                         <td style="vertical-align: middle;">
                         	<select name="recommendderTemplID">
								<c:forEach items="${recommendTempls}" var="temp">
									<c:if test="${temp.fid eq area.recommendderTemplID}">
										<option value="${temp.fid }" selected="selected">${temp.name }</option>
									</c:if>
									<c:if test="${temp.fid ne area.recommendderTemplID}">
										<option value="${temp.fid }" >${temp.name }</option>
									</c:if>
								</c:forEach>
							</select>
                         </td>
                         <td style="vertical-align: middle;text-align: center;"><button type="submit" class="btn btn-default btn-blue" style="width:70px;height:30px;line-height:30px;padding:0">确认推荐</button></td>
                     </tr>               
                 </tbody></table>
             </form>
             </div>
         </div>
     </div>
     <div class="furList padding-r-1">
         <form id="form01" class="form-horizontal table-img-aotu table-textArea-aotu table-select-aotu" role="form"  action="${prc}/offerList/saveProdData" method="post" height="100%">
           	 <input type="hidden" name="offerId" id="offerId" value="${area.offerId }"/>
             <input type="hidden" name="areaId" id="areaId" value="${area.fid}">
          	 <input type="hidden" name="areaName" value="${area.areaName}">
             <table class="table table-bordered furTable" id="sort" style="border-collapse: collapse;border-spacing: 0;">
                 <thead>
                     <tr width="100%">
                         <th width="32px"><input type="checkbox" name="saleSelectedAll" onclick="saleSelectedAllClick()"/></th>
                         <th width="48px">序号</th>
                         <th width="14%">实物照</th>
                         <th width="16%">名称</th>
                         <th width="12%">材质</th>
                         <th width="12%">颜色</th>
                         <th width="12%">尺寸(W*D*H)</th>
                         <th width="12%">其他属性</th>
                         <th width="100px">数量</th>
                         <th width="12%">成本/元</th>
                         <th width="104px">其他操作</th>
                     </tr>
                 </thead>
                 <tbody class="tabledata">
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
                              <%--其他属性--%>
                              <input type="hidden" name="prods[${salePInd.index}].otherPropValue" value="${salP.otherPropValue}"/>
                              
                               <td><input type="checkbox" name="salecheckbox" value="${salP.fid}"/></td>
                                <td class="index">
                                    <div class="wp">${salePInd.index+1}</div>
                                </td>
                                 <td>
		                             <div class="wp">
		                               <div class="imgWp">
		                               	 <img src="${filepath}${salP.picPath}" id="prods[${salePInd.index}].picPath"/><input type="hidden" name="prods[${salePInd.index}].picPath" value="${salP.picPath}"/>
		                               </div>	                                 
		                             </div>
		                         </td>
		                         
                                <td><div title="${salP.prodName}" class="wp prodName">${salP.prodName}</div></td>
                                <td class="loadDealwith">
                                	<div class="wp">
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
		                            </div>
                                </td>
                                <td class="loadDealwith">
                                	<div class="wp">
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
		                             </div>
                                    
                                </td>
                                <td class="loadDealwith">
                                	<div class="wp">
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
		                             </div>
                                    
                                </td>
                                <td style="vertical-align: middle;">
                                	<div class="wp">
		                                 <c:if test="${not empty salP.otherPropValue}">
		                                     <span class="setOtherAttr" onclick="setOtherAttr(this)" title="${salP.otherPropValue}">${salP.otherPropValue}</span>
	                                    </c:if>
	                                    <c:if test="${empty salP.otherPropValue}">
		                                    <span class="setOtherAttr" title="" onclick="setOtherAttr(this)">设置</span>
	                                    </c:if>
		                             </div>
                                </td>
                                <td class="textOverflow">                	
                                	<div class="wp">
		                                 <input type="text" name="prods[${salePInd.index}].count" value="${salP.count}" onchange="parent.totalCosts();" onfocus="conditionFocus('prods[${salePInd.index}].count');" onblur="conditionBlur('prods[${salePInd.index}].count')" onkeyup="this.value=this.value.replace(/[^0-9]/g,'')" onafterpaste="this.value=this.value.replace(/[^0-9]/g,'')"/>
		                             </div>
                                </td>
                                <td name="cost">
                                	<div class="wp"><fmt:formatNumber value="${salP.cost}" type="number" maxFractionDigits="0" /></div>
                                </td>
                                
                                
                                <td>
		                             <div class="wp handle-link">
		                                 <a href="javascript:void(0)" onclick="replCurrentRow(this,'${salP.fid}')">替换</a>
		                                 <a href="javascript:void(0);" onclick="deleteCurrentRow(this,'${salP.fid}');">删除</a>
		                                 <label>
		                                     <c:if test="${salP.backup eq '1'}">
			                                    <input type="checkbox" class="styled styled-primary" name="prods[${salePInd.index}].backup" value="1" checked="checked"/>
			                                 </c:if>
			                                 <c:if test="${salP.backup eq '0'}">
			                                    <input type="checkbox" class="styled styled-primary" name="prods[${salePInd.index}].backup" value="1"/>
			                                 </c:if>
		                                     <span>备选</span>
		                                 </label>
		                                 <a class="hangdle-remark">备注</a>
		                                 <input type="hidden" name="prods[${salePInd.index}].remark" value="${salP.remark}"/>
                                    	 <input type="hidden" name="prods[${salePInd.index}].sequNum" value="${salePInd.index+1}"/>
		                             </div>
		                         </td>                              
                            </tr>
                        </c:forEach>
                    </c:if>
                     
                 </tbody>
                 <tfoot>
                     <tr>
                         <td colspan="11" style="text-align:cneter">
                         	<%-- <button type="button" class="btn btn-primary addFurBtn" data-toggle="modal" data-target="#myModal" onclick="content.window.showProdLibMsg('all',1,true,'${area.fid}','${area.offerId}');">+ 添加家具</button> --%>
                         	<button type="button" class="btn btn-primary addFurBtn" onclick="window.top.openProdLibPop('all',1,true,'${area.fid}','${area.offerId}');">+ 添加家具</button>
                         </td>
                     </tr>
                     <tr>
                         <td colspan="11" style="text-align:right">
                         	<input type="hidden" id="totalProdCost" value="${totalProdCost}"/>
                			小计：<span id="areaMinCost">0</span> 元
                         </td>
                     </tr>
                     <tr>
                         <td colspan="11" style="text-align:right">各区域合计：<span id="allAreaCost">0</span> 元</td>
                     </tr>
                 </tfoot> 
             </table>
         </form>
     </div>
 </div>



    
    <%-- <div class="row">
    	<div class="col-sm-12 col-md-12 col-lg-12" >
    		<div class="navbar-inner navbar-content-center navbar-right" style="margin-right: 0%;">
            		<button type="button" class="btn btn-default" onclick="saveSaleProd('ok')">保存</button>
            		<button type="button" class="btn btn-default">预览</button>
            		<button type="button" class="btn btn-default" onclick="exportExcel()">导出</button>
            		<button type="button" class="btn btn-default" id="sendToEmial">发到邮箱</button>
            			&nbsp;&nbsp;&nbsp;
        		</div>
    	</div>
    </div> --%>

 <!-- 模态框（Modal） -->
    <%-- <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" style="width:1100px;height:auto;margin-top:auto">
            <div class="modal-content">
                <div class="modal-header" style="padding: 8px;">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h5 class="modal-title" id="myModalLabel" style="text-align: center">
                        产品库
                    </h5>
                </div>
                <div class="modal-body" style="padding: 7px;">
                    <iframe id="content" src="${prc }/jsp/offerlist/productLib.jsp" name="content" frameborder="0"
                            scrolling="no" style="min-height: 780px;" height="100%" width="100%" ></iframe>
                </div>
           </div>
        </div> 
    </div> --%>
 <!-- /.modal -->
<%--保存状态--%>
<input type="hidden" id="savestatus" value="${status}"/>
<jsp:include page="../common/footer_js.jsp" />
<script src="${prc }/common/js/json2.js"></script>
<script src="${prc }/common/js/jquery.form.js"></script>
<script src="${prc }/common/js/jquery-ui.min.js"></script>

<script>


	/* 兼容火狐 */
	var $furlistTab = $('.furTable')
		furtbodyItemNum = $furlistTab.find('.tabledata tr').length;

	if(!furtbodyItemNum){
		furlistTabAddCName();
	} 
	
	function furlistTabAddCName(){
		$furlistTab.addClass('nolist');
	}
	
	
	/* 检查推荐产品中是否有宽高 */
	function checkrecommendForm(){
		var tab = $('.recommendTab'),
			heival = tab.find('input[name="width"]').val(),
			widval = tab.find('input[name="length"]').val();
		
		if(!widval && !widval || (widval == 0 && heival == 0)){
			alert('请输入户型面积');
			return false;
		}
		else if(!widval || widval == 0){
			alert('请输入户型面积的长度');
			return false;
		}
		else if(!heival || heival == 0){
			alert('请输入户型面积的宽度');
			return false;
		}

	}


	/* 编辑报价 */
	var $offerFurSetPrice = $('#offerFurSetPrice');
	
	$offerFurSetPrice.on('click',function(){
		saveSaleProd();
		window.parent.areaEdit();
	});
	
	
	/* 备注操作 */
	$('#form01').on('click','.hangdle-remark',function(e){
		var e = e || window.event;
		if(e.stopPropagation){
			e.stopPropagation();
		}
		else{
			e.cancelbubble = true;
		}

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


	var $dealwithSl_td = $('#form01 .loadDealwith'),
		$dealwithSl_sl = $('#form01 .loadDealwith select'),
		$dealwithSl_len = $dealwithSl_td.length;

	for(;$dealwithSl_len--;){
		if($dealwithSl_sl.eq($dealwithSl_len).find('option').length == 0){
			$dealwithSl_td.eq($dealwithSl_len).html('/');
		}
	}
	
	/* 设置其他属性 */
	function setOtherAttrPop(tpl,Fn,showFn){
		var opt = {};
		opt.tpls = tpl;
		opt.btnNum = 2;
		opt.cb = Fn;
		opt.ready = showFn;
		window.top.runHomePublicPop(opt);
	}
	
	function setOtherAttr(that){
		var self = $(that),
			oldVal = self.html(),
			oldVal_len = 1,
			temp_oldVal_len,
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
			        	self.attr('title',reStr);
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
		        		
		        	$resetBtn.on('click',function(e){
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
	/* 设置其他属性 end */





	/* 发送到邮箱 */
	var $sendToEmial = $('#sendToEmial');
	
	function showEmialPop(){
		var tpl_str = '',
			offerID = '${area.offerId }';
			opt = {};
		tpl_str +='<form action="${prc }/offerListEmail/send" class="form-horizontal padding-l-30 padding-r-40">'; 
			tpl_str +='<p style="height:20px;color:red;font-size:14px" id="tempTip"></p>'; 
			tpl_str +='<div class="form-group margin-top-3">'; 
				tpl_str +='<label class="col-xs-3 text-right control-label"><span>收件人邮箱：</span></label>';
				tpl_str +='<div class="col-xs-9" row"="" style="padding-left:0">'; 
					tpl_str +='<input class="form-control" type="text" name="receiver" placeholder="多个邮箱请用  ; 隔开" id="tempEmial">'; 
				tpl_str +='</div>'; 
			tpl_str +='</div>';
			tpl_str +='<div class="form-conmit-btn" style="text-align: right;padding-top: 10px;"><a class="btn btn-primary sendEmailbtn" STYLE="margin-right: 10px;" id="tempTrueBtn">确认</a><a id="tempFalseBtn" class="btn btn-default btn-fasle">取消</a></div>';
		tpl_str +='</form>';
		
		opt.til = '发到邮箱';
		opt.tpls = tpl_str;
		opt.btnNum = 0;
		opt.ready = function(Pop_self_obj){
			
			var thatWindow = window.top.document,
				$tempemial = $(thatWindow.getElementById('tempEmial')),
				$tempTip = $(thatWindow.getElementById('tempTip')),
				$tempTrueBtn = $(thatWindow.getElementById('tempTrueBtn')),
				$tempFalseBtn = $(thatWindow.getElementById('tempFalseBtn')),
				emial;
			
			$tempemial.on('keydown',function(e){
				if(e.keyCode == 13){
					e.preventDefault();
					$tempTrueBtn.click();
				}
			});

			$tempFalseBtn.click(function(){
				Pop_self_obj.close();
			});
						
			$tempTrueBtn.click(function(){

				emial = $tempemial.val();
				if(!emial){
					$tempTip.html('请输入邮箱');
					return;
				}
				
				var emial_arr_len,
					temp1,
					temp2,
					token = false;
				
				temp1 = emial.split(';');
				temp2 = emial.split('；');

				if(temp1.length >= 2){
					emial_arr_len = temp1.length;
					for(;emial_arr_len--;){
						if(!temp1[emial_arr_len]){
							continue;
						}						
						if(!publicIsEmail(temp1[emial_arr_len])){
							$tempTip.html('第'+(emial_arr_len+1)+'邮箱地址格式不对');
							return;
						}
					}						
				}
				else if(temp2.length >= 2){
					emial_arr_len = temp1.length;
					for(;emial_arr_len--;){
						if(!temp1[emial_arr_len]){
							continue;
						}
						if(!publicIsEmail(temp2[emial_arr_len])){
							$tempTip.html('第'+(emial_arr_len+1)+'邮箱地址格式不对');
							return;
						}
					}
				}
				else{
					if(!publicIsEmail(emial)){
						$tempTip.html('请输入正确的邮箱地址');
						return;
					}
				}	
				
				window.top.publicLoadingShow();
				
				$.ajax({
		               type: "GET",
		               url:"${prc }/offerListEmail/send",
		               data:'receiver='+emial+'&offerListId='+offerID,
		               dataType:"text",
		               success: function(result) {
		            	   window.top.publicLoadingHide();
		            	   if("false" == result){
		            		   /* window.parent.parent.runHomePublicPop({
		            			   til:'提示',
		            			   msg:'没有可以发送的报价单',
		            			   btnNum:1
		            		   }); */
								alert("没有可以发送的报价单.");		            		   
		            	   }else if("true" == result){
		            		   Pop_self_obj.close();
		            		   /* window.parent.parent.runHomePublicPop({
		            			   til:'提示',
		            			   msg:'发送成功',
		            			   btnNum:1
		            		   }); */
		               			alert('发送成功');
		            	   }
		               		
		               },
		               error :function(){
						   alert('发送失败');
		            	   window.top.publicLoadingHide();
		               }
		         });
				
			});	
			
		};
		window.parent.parent.runHomePublicPop(opt);
	}
	
	$sendToEmial.on('click',function(){
        validateBeforeSendEmail();
		//window.parent.parent.runIframeFn(showEmialPop);
	});	

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
    
   /*  $('#myModal').on('shown.bs.modal',function(){
    	//重新设置高度
    	$("#content")[0].contentWindow.resetIfrHei();
    	
    }); */
    
    $('#myModal').on('hidden.bs.modal',function(){
    	var el = $("#content")[0].contentWindow.document.getElementById('jquery-overlay');
    	if(el){
    		el.click();
    	}
    	resetFurHEI();
    });
    
    //替换当前产品
    function replCurrentRow(obj,replSaleProdId){

        //先保存当前产品信息
        saveSaleProd();
        var tr=obj.parentNode.parentNode.parentNode;
        var prodIndex = $(tr).find("td:eq(1) .wp").html()-1;
        var prodTypeId = $('input[name="prods['+prodIndex+'].prodTypeId"]').val();
        
        //$('#myModal').modal('show');
        
        //弹出模态框
        window.top.openProdLibPop(prodTypeId,1,true,$("#areaFid").val(),$("#offerId").val(),replSaleProdId)
        //$("#content")[0].contentWindow.showProdLibMsg(prodTypeId,1,true,$("#areaFid").val(),$("#offerId").val(),replSaleProdId);

    }
   
    //删除当前产品
    function deleteCurrentRow(obj,fid)
    {
        var isDelete=confirm("确定要删除吗？");
        if(isDelete)
        {
            var tr= $(obj).parents('tr')[0];
            var tbody=tr.parentNode;
            tbody.removeChild(tr);         
            
            if( !$furlistTab.find('.tabledata tr').length ){
            	furlistTabAddCName();
            }
            //重新计算小计
           // parent.totalCosts();
            
            var deleId = fid;
            if(null != deleId && "" != deleId){
                $.ajax({
                    type: "GET",
                    async:true,
                    url:"${prc }/offerList/deleteSaleProd",
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
        resetFurHEI();
    }
    //重新排序序号
    function reCount(){
        var index = 0;
        $(".furTable tbody").find("tr").each(function(){
//            if("furTabletr0" != $(this).attr("id")){

            if(index== $(".furTable tbody").find("tr").length){
                return;
            }
            //重设编号
            var tdArr = $(this).children();
            var preIndex = $(this).find("td:eq(1) .wp").html() - 1;
            $(this).find("td:eq(1) .wp").html(index + 1);
            //重设input name
            /*$(this).find("input").each(function(){
                var newName = $(this).attr("name").replace(preIndex,index);
                $(this).attr("name", newName)
            });
            $(this).find("select").each(function(){
                var newName = $(this).attr("name").replace(preIndex,index);
                $(this).attr("name", newName)
            });
            $(this).find("textarea").each(function(){
                var newName = $(this).attr("name").replace(preIndex,index);
                $(this).attr("name", newName)
            });*/
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
        var tr = $(selectedObj).parents('tr');
        //产品id
        var prodId = tr.find('input[name$=".prodId"]').val();
        //材质
        var material = tr.find('select[name$=".meterial"]').val();
        //颜色
        var color = tr.find('select[name$=".color"]').val();
        //尺寸
        var size = tr.find('select[name$=".standard"]').val();

        // 成本
        var cost = tr.find('input[name$=".cost"]');
        var modelNoInput = tr.find('input[name$=".modelNo"]');
        
        var sellCompany = tr.find('input[name$=".sellCompany"]').val();

        //sku图片
        var imghidden = tr.find('input[name$=".picPath"]');
        var imgshow = tr.find('img[id$=".picPath"]');
        
        $.ajax({
            type: "GET",
            async:false,
            url:"${prc }/product/getProdSku",
            data:{"material":material,"size":size,"color":color,"prodId":prodId},
            success: function(result) {
                if(null == result.sku){
                    skulegel = false;
                    alert("不存在该sku组合");
                }else{
                    imghidden.val(result.sku.imgPath);
                    $(imgshow).attr('src',"${filepath}"+result.sku.imgPath);
                    if(!result.sku.imgPath){
                    	$(imgshow).attr('alt','无图片');
                    }
                    var buyRate = $("#buyRate_"+sellCompany).val();
                    var priceAfterRate = Math.round(parseInt(result.sku.price) * buyRate);
                    cost.val(priceAfterRate);

                    tr.find("td[name='cost'] .wp").html(priceAfterRate);
                    //成本变动
                    var oldcost = Math.round(tr.find('input[id^="oldcost"]').val());
                    if(oldcost != priceAfterRate){
                        tr.find('input[name$=".clearTag"]').val("1");
                    }else{
                        tr.find('input[name$=".clearTag"]').val("0");
                    }
                    
                    var modelNo =result.sku.modelNo;
                    if(null ==  modelNo|| "" == modelNo){
                        modelNo ="N/A";
                    }
                    modelNoInput.val(modelNo);
                    //$(tr).children("td:eq(4)").html(modelNo);
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
    
    function exportExceltmp(type){

    	window.top.publicLoadingShow();
    	var offerId = $("#offerId").val();
        $.ajax({
            type: "GET",
            async:false,
            url:"${prc}/offerList/doValidateOfferExcel",
            data:"offerListId="+offerId,
            beforeSend: function () {
                //$(".sendEmailbtn").attr({ disabled: "disabled" });
            },
            success: function(result) {

				window.top.publicLoadingHide();

             	if("false" == result){
                     alert("没有设置报价单，请设置报价！");
                 }else{
                     if("export" == type){
                         window.location.href = "${prc}/offerList/exportExcel?offerListId="+offerId;
                     }else if("sendToEmail" == type){
                         //允许弹框发送邮件
                         showEmialPop();
                     }
                 }

            },
            complete: function () {//完成响应
                //$(".sendEmailbtn").removeAttr("disabled");
            },
            error: function(err) {
            	window.top.publicLoadingHide();
            	alert("导出失败!");
            }
        });
    }
    //导出excel
    function exportExcel(){
        saveSaleProd();
        window.setTimeout("exportExceltmp('export');",200);
    }
    
    //把excel发到邮箱
    function validateBeforeSendEmail(){
        saveSaleProd();
        window.setTimeout("exportExceltmp('sendToEmail');",200);
    }
    
   function saveSaleProd(str){
	   $("#form01").submit();
       window.parent.saveTips(str);	
   }
    
   $(document).ready(function(){
	   var fixHelperModified = function(e, tr) {
	      var $originals = tr.children(".sortTR");
	      var $helper = tr.clone();
	      $helper.children().each(function(index) {
	      	var wid = tr.parents('.furTable').width();
	      	$(this).width(wid);
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
	   
	   
	   $("#sort tbody:eq(0)").on('mousedown',function(){
		   $('.furTable input[type="text"]').blur();
	   });
	   
	   
	   
	});
    
   //重新修改区域名称
   function updateAreaName(){
       var areaName = $("#areaName").val(),
       	   areaName_all = '',
	       $areaName_tr = $(window.parent.document.getElementById('areaDistributionFrame')).contents().find('table tr'),
	       len = $areaName_tr.length-1;
       areaName = areaName.replace(publicRegx.trim,'');
       if(!areaName || "" == areaName){
           $("#areaName").val(areaNametmp);
           return;
       }
       
       for(;len--;){
			areaName_all += ';'+$areaName_tr.eq(len).find('td').text();
		}
		if(areaName_all){
			areaName_all += ';';
			if(areaName_all.indexOf(';'+areaName+';') != -1){
				alert('该区域名已存在，请重新命名');
				$("#areaName").val(areaNametmp);
				return;
			}
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
        tem = parseInt(tmp); 
        if("" == tmp || isNaN(tem)){
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
                resetFurHEI();
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
            })
        }
    }
    
    function resetHeiTimeFn(){
    	var hei = $('.furListBox').height();
    	window.top.changeIframeHeiFur(hei);
    }
    
    function resetFurHEI(){
    	setTimeout('resetHeiTimeFn()',50);
    }   
    
    $(function(){
    	setTimeout('resetFurHEI()',300);
    });
    
</script>
</body>
</html>
