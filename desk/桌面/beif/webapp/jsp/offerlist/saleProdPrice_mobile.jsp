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
    <link rel="stylesheet" href="${prc }/common/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="${prc }/common/css/build.css"/>
	<jsp:include page="../common/footer_js.jsp" />
	<script src="${prc }/common/js/json2.js"></script>
    <!-- Bootstrap end-->
    
     <style>
     	html,body{height:100%;}
     	.warpbox{position:relative;height:100%;overflow-y:scroll}
       table{  
		    width:100px;  
		    table-layout:fixed;/* 只有定义了表格的布局算法为fixed，下面td的定义才能起作用。 */  
	   }  
	   table th{text-align: center;vertical-align: middle !important;}
	   td{  
		    word-break:keep-all;/* 不换行 */  
		    white-space:nowrap;/* 不换行 */  
		    overflow:hidden;/* 内容超出宽度时隐藏超出部分的内容 */  
		    text-overflow:ellipsis;/* 当对象内文本溢出时显示省略标记(...) ；需与overflow:hidden;一起使用*/  
		}
	   .dropdown-menu li,.dropdown-menu .btn{
		   margin-left: 6px;
	   }
	   table .imgWrap{height:60px;overflow:hidden}
	   table img{display:block;width:100%}
	   .width-inp{width:120px;margin-right:5px}
    </style>
</head>
<body>
	<div class="padding-16 warpbox">
	<form method="post" action="${prc }/offerList/updateOfferPrice" class="padding-b-20" id="prodForm" onsubmit="return validateForm();">
	<input type="hidden" name="exportType" value="${exportType}">
	<input type="hidden" name="offerId" value="${offerId}">
	<div class="fr padding-l-10"><span class="btn btn-primary" id="closePopWrap">关闭区域编辑页面</spsan></div>
	<div class="dropdown pull-right" >
		<button type="button" class="btn dropdown-toggle" id="dropdownMenu1" 
				data-toggle="dropdown">
			一键设置毛利率
			<span class="caret"></span>
		</button>
		<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1" style="width: 200px;">
			 <li role="presentation" data-stopPropagation="true">
                	<p style="color: gray;"><b>选择需要设置毛利率的区域</b></p>
             </li>
             <li data-stopPropagation="true">
				 <p>
             	<select id="areaselect">
					<option value="0"><b>全部区域</b></option>
					<c:forEach items="${areas}" var="area" varStatus="status">
						<option value="${status.index+1}"><b>${area.areaName }</b></option>
					</c:forEach>
             	</select>
				 </p>
             </li>
             <li role="presentation" data-stopPropagation="true">
				 <p style="color: gray;"><b>选择需要设置毛利率的区域</b></p>
             </li>
             <li data-stopPropagation="true">
				 <p ><input type="text" class="width-inp" id="setRate" name="setRate" onchange="validateSetRate();" onfocus="conditionFocus('setRate')" onblur="conditionBlur('setRate')" onkeyup="clearNoNum(this)"/><b>%</b></p>
             </li>
			<p><button type="button" class="btn btn-primary" style="width: 90%;" onclick="setRatefun()" data-stopPropagation="true">确定</button></p>
		</ul>
	</div>
	<c:forEach items="${areas}" var="area" varStatus="status">
		<label>${area.areaName }</label>
		<input type="hidden" name="areas[${status.index}].fid" value="${area.fid}">
		<table class="table table-bordered saleprodTable margin-t-24" id="saleprodTable${status.index}">
			<thead>
				<tr>
					<th width="40px">序号</th>
					<th width="10%">实物照</th>
					<th width="10%">名称</th>
					<!--<th width="8%">型号</th>-->
					<th width="8%">材质</th>
					<th width="8%">颜色</th>
					<th width="10%">规格（W*D*H）</th>
					<!--<th width="10%">产品说明</th>-->
					<th width="50px">数量</th>
					<th width="10%">成本（元）</th>
					<th width="10%">单价（元）</th>
					<th width="10%">单个产品利润（元）</th>
					<th width="10%">毛利率（%）</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${area.saleProdList}" var="prod" varStatus="prodStatus">
					<tr>
						<input type="hidden" name="areas[${status.index}].saleProdList[${prodStatus.index }].fid" value="${prod.fid}"/>
						<input type="hidden" name="areas[${status.index}].saleProdList[${prodStatus.index }].count" value="${prod.count}"/>
						<td align="center" valign="middle" >${prodStatus.index + 1 }</td>
						<td align="middle"  valign="middle" >
						   <div class="imgWrap">
						    	<img src="${filepath}${prod.picPath}" />
						   </div>
						</td>
						<td align="center" valign="middle" name="prodName" >${prod.prodName }</td>
						<!--<td align="center" valign="middle" name="modelNo" >${prod.modelNo }</td>-->
						<td align="center" valign="middle" name="meterial" >${prod.meterial }</td>
						<td align="center" valign="middle" name="color" >${prod.color }</td>
						<td align="center" valign="middle" name="standard" >${prod.standard }</td>
						<!--<td align="center" valign="middle" name="memo" title="${prod.memo }">${prod.memo }</td>-->
						<td align="center" valign="middle" name="count" >${prod.count}</td>
						<td align="center" valign="middle" name="cost" ><label name="prodCost"><fmt:formatNumber value="${prod.cost}" pattern="#"></fmt:formatNumber></label></td>
						<td>
							<input type="text" class="form-control" priceClass="price" id="prodPrice" name="areas[${status.index}].saleProdList[${prodStatus.index }].price" onchange="changeMoney(this,'price')" value="${prod.price}" onkeyup="value=value.replace(/[^\d.]/g,'')" onfocus="conditionFocus('areas[${status.index}].saleProdList[${prodStatus.index }].price')" onblur="conditionBlur('areas[${status.index}].saleProdList[${prodStatus.index }].price')"/></td>
						<td><input type="text" class="form-control" id="prodProfit" name="areas[${status.index}].saleProdList[${prodStatus.index }].profit" onchange="changeMoney(this,'profit')" value="${prod.profit}" onkeyup="value=value.replace(/[^\d.]/g,'')" onfocus="conditionFocus('areas[${status.index}].saleProdList[${prodStatus.index }].profit')" onblur="conditionBlur('areas[${status.index}].saleProdList[${prodStatus.index }].profit')"/></td>
						<td><input type="text" class="form-control" id="prodProfitRate" name="areas[${status.index}].saleProdList[${prodStatus.index }].profitRate" onchange="changeMoney(this,'profitRate')" value="${prod.profitRate}" onkeyup="clearNoNum(this)" onfocus="conditionFocus('areas[${status.index}].saleProdList[${prodStatus.index }].profitRate')" onblur="conditionBlur('areas[${status.index}].saleProdList[${prodStatus.index }].profitRate')"/></td>
					</tr>
				</c:forEach>
				<tr id="last">
					<td align="right" colspan="11" class="tableSumMoney">总价：<label name="tableTotalMoney" id="tableTotalMoney">0</label> 元，利润：<label name="tableTotalProfitMoney" id="tableTotalProfitMoney">0</label> 元</td>
				</tr>
			</tbody>
		</table>
		</c:forEach>
		<table  class="table table-bordered">
			<label>其他费用设置</label>
			<tr>
				<td width="25%">
					<label>
						<c:if test="${client.includeTrans eq '1'}">
							<input type="checkbox" id="tran" name="includeTrans" onchange="chanegeIncludeTrans()" checked="checked" value="1">
						</c:if>
						<c:if test="${client.includeTrans ne '1'}">
							<input type="checkbox" id="tran" name="includeTrans" onchange="chanegeIncludeTrans()" value="0">
						</c:if>
						 运输费，安装服务费
					</label>
				</td>
				<td colspan="3" width="75%">
				<c:if test="${client.includeTrans ne '1'}">
				 	<input type="text" class="form-control" id="transMoney" name="transMoney" disabled="disabled" onchange="sumMoney()" style="width:10%;display: inline;" onkeyup="value=value.replace(/[^\d.]/g,'')" onfocus="conditionFocus('transMoney')" onblur="conditionBlur('transMoney')"/>
				</c:if>
				<c:if test="${client.includeTrans eq '1'}">
					<input type="text" class="form-control" id="transMoney" name="transMoney" onchange="sumMoney()" value="${client.transMoney}"  style="width:10%;display: inline;" onkeyup="value=value.replace(/[^\d.]/g,'')" onfocus="conditionFocus('transMoney')" onblur="conditionBlur('transMoney')"/>
				</c:if>
					<label>元</label>
				</td>
			</tr>
			<tr>
				<td>
					<label>
						税率：
					</label>
				</td>
				<td colspan="3">
					<input type="text" class="form-control" id="taxRate" name="taxRate" onchange="sumMoney();validatetaxrate()" value="${client.taxRate}" onkeyup='clearNoNum(this)' style="width:10%;display: inline;" onfocus="conditionFocus('taxRate')" onblur="conditionBlur('taxRate')"/>
					<label>%</label>
				</td>
			</tr>
		</table>
		<table  class="table table-bordered">
			<label>合计</label>
			<tr>
				<td width="25%">
					<label>
						总成本：
					</label>
				</td>
				<td widht="75%">
				 	<label id="totalCost"></label><label>元</label> 
				</td>
			</tr>
			<tr>
				<td>
					<label>
						总利润：
					</label>
				</td>
				<td>
				 	<label id="areaTotalProfit"></label><label>元</label> 
				</td>
			</tr>
			
			<tr>
				<td >
					<label id="totalMoneyLabel">
						合计总价：
					</label>
				</td>
				<td>
				 	<label id="totalMoney"></label><label>元</label> 
				</td>
			</tr>
			<tr>
				<td>
					<label>
						含税合计：
					</label>
					 
				</td>
				<td>
					<input id="totalMoneyMultRate" name="totalMoneyMultRate" value="${client.totalMoneyMultRate}"/><label>元</label>
				</td>
			</tr>
		</table>
		<div class="textAli-r">
			<button type="button" class="btn btn-primary" onclick="doFormSubmit()">保存价格设置</button>
		</div> 
		
		
	</form>
	</div>
	<c:if test="${statues eq 'ok'}">
		<script>
			window.close();
		</script>
	</c:if>
<script type="text/javascript">
    var firstTimetmp = 0;
	//计算总成本
	window.onload = function(){
        
        var totalCost = 0;
        $(".saleprodTable").each(function(){
            var tr = $(this).find('tbody').children("tr");
            $(tr).each(function(){
                var num = $(this).children("td:eq(6)").text(); // 获取数量
                var cost = $(this).children("td:eq(7)").find("label[name=prodCost]").text(); // 获取成本
                if("" != cost){
                    totalCost += parseInt(cost) * num;
                }
            });
        });
        $("#totalCost").text(totalCost);


        $('.dropdown-menu a.removefromcart').click(function(e) {
            e.stopPropagation();
        });
        $("ul.dropdown-menu").on("click", "[data-stopPropagation]", function(e) {
            e.stopPropagation();
        });
	};
    caleachareaTable();

	//金额改变事件
	function changeMoney(inputObj,type){
		var tr =$(inputObj).parents(); // 获取当前行对象
		var money = $(inputObj).val(); // 当前金额
		var cost = $(tr).children("td:eq(7)").text(); // 获取成本
		var num = $(tr).children("td:eq(6)").text(); // 获取数量
		if(type == 'price'){
			var profit = (money - cost);
			var profitRate = profit * 100.0 / money;
			profitRate = profitRate.toFixed(2);
			$(tr).children("td").find("input").eq(1).val(profit); // 利润
			$(tr).children("td").find("input").eq(2).val(profitRate); // 利润率
		}else if(type == 'profit'){
			var price = parseInt(money) + parseInt(cost);
			price = price.toFixed(0);
			var profitRate = money * 100.0 / price;
			profitRate = profitRate.toFixed(2);
			$(tr).children("td").find("input").eq(0).val(price); // 单价
			$(tr).children("td").find("input").eq(2).val(profitRate); // 利润率
		}else if(type == 'profitRate'){
			var price = cost / (1 - money*0.01);
			price = price.toFixed(0);
			var profit = price - cost;
			$(tr).children("td").find("input").eq(1).val(profit); // 利润
			$(tr).children("td").find("input").eq(0).val(price); // 单价
		}
        var tab = $(tr).parents(); // 获取当前table对象
        var tr = $(tab).children("tr");
		sumTableMoney(tr);  //计算当前区域金额
		sumAllAreaMoney(); // 计算所有区域金额
		sumMoney();  //计算含税总价
	}
	
	//合计当前区域金额
	function sumTableMoney(tr){
		var totalMoney = 0;
		var totalProfit = 0;
		
		$(tr).each(function(){
			var price = $(this).children("td").find("#prodPrice").val(); // 获取单价
			var num = $(this).children("td:eq(6)").text(); // 获取数量
			var profit = $(this).children("td").find("#prodProfit").val(); // 获取利润
			if(price){
				totalMoney = parseInt(totalMoney) + (parseInt(price) * num);
			}
			if(profit){
				totalProfit = parseInt(totalProfit) + (parseInt(profit) * num);
			}

		});

		$(tr).find("#tableTotalMoney").text(totalMoney);
		$(tr).find("#tableTotalProfitMoney").text(totalProfit);
	}
	
	//遍历各个区域tabel
	function caleachareaTable(){
	    $(".saleprodTable").each(function(){
            var tr = $(this).find('tbody').children("tr");
            sumTableMoney(tr);
		});
        sumAllAreaMoney(); // 计算所有区域金额
		
		sumMoney();//计算含税总价
	}
	
	// 计算区域总利润
	function sumAllAreaMoney(){
		var totalAreaProfit=0;
		
		$("label[name=tableTotalProfitMoney]").each(function(){
			var tableProfitlMoney = $(this).text();
			if(tableProfitlMoney){
				totalAreaProfit += parseInt(tableProfitlMoney);
			}
		});
		
		$("#areaTotalProfit").text(totalAreaProfit);
	}

	// 计算含税总价
	function sumMoney(){
		var totalMoneyMultRate = 0;
		var totalMoney = 0;
		
		// 每个表格成本小计
		$("label[name=tableTotalMoney]").each(function(){
			var tableTotalMoney = $(this).text();
			if(tableTotalMoney){
				totalMoney += parseInt(tableTotalMoney);
			}
		});
		
		var tranFee = $("#transMoney").val();
		if(tranFee){
			totalMoney += parseInt(tranFee);
		}
		$("#totalMoney").text(totalMoney);
		var taxRate = $("#taxRate").val();
		if(taxRate){
			totalMoneyMultRate = totalMoney * (1+(taxRate/100));
			totalMoneyMultRate = totalMoneyMultRate.toFixed(0)
		}else{
			totalMoneyMultRate = totalMoney;
		}
		if(0 != firstTimetmp){
            $("#totalMoneyMultRate").val(totalMoneyMultRate);
        }
        firstTimetmp++;
	}
	
	//是否包含运输费事件
	function chanegeIncludeTrans(){
		if($("#tran").get(0).checked){
			$("#totalMoneyLabel").text("合计总价（含运输费，安装服务费等）：");
			$("#transMoney").attr("disabled",false);
			$("#transMoney").val(0);
		}else{
			$("#totalMoneyLabel").text("合计总价：");
			$("#transMoney").attr("disabled",true);
			$("#transMoney").val(0);
		}
		sumMoney();
	}
	
	//提交表单
	function doFormSubmit(){
		$("#prodForm").submit();
	}
	
	function validateForm(){
        var result = true;
		$("input[priceClass=price]").each(function(){
			var value = $(this).val();
			if(!value || value ==0){
				
				//alert("请检查产品单价是否合法！");
				result = false;
				return false;
			}
		});
		if(!result){

			var tpl_str = '',
				opt = {};
				
			tpl_str += '<div style="max-height:80px;overflow:aotu">请检查产品单价是否合法！</div>';
			
			opt.til = '提示';
			opt.tpls = tpl_str;
			opt.btnNum = 1;
			window.top.runHomePublicPop(opt);
			
            return false;
		}

        //校验税率输入
        if(!validatetaxRate()){
            return false;
		}

		//校验毛利率
  		if(!validateprofitRate()){
            return false;
		}
		
  		window.top.closeNewPopWrap();
		
		return true;
	}
 
    //校验毛利率
	function validateprofitRate(){
	    var boo = true;
        var errormsg = "毛利率不合法,不能超过100.";
	    $('input[name$=".profitRate"]').each(function(){
	    	var profitRate = $(this).val();
            if(!validateNum(profitRate,errormsg)){
                boo = false;
            	
			}
		});
	    return boo;
	}

    //校验税率输入
	function validatetaxRate(){
        var errormsg = "税率不合法,不能超过100.";
        var taxRate = $("#taxRate").val();
        if(!validateNum(taxRate,errormsg)){
            return false;
		}
        return true;
	}
	
    //校验100以内包括小数
    function validateNum(text,errormsg){
        var reg = /^\d{0,2}(\.\d{0,2})?$/g;
        if(!reg.test(text)){
            alert(errormsg);
            return false;
        }
        return true;
    }

    function clearNoNum(obj) {
        obj.value = obj.value.replace(/[^\d.]/g,""); //清除"数字"和"."以外的字符
        obj.value = obj.value.replace(/^\./g,""); //验证第一个字符是数字而不是
        obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的
        obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
        obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3'); //只能输入两个小数
    }

    var preval;
    //price prodProfit prodProfitRate transMoney taxRate输入框获得光标事件
    function conditionFocus(curr){
        preval = $('input[name="'+curr+'"]').val();
        $('input[name="'+curr+'"]').val("");
    }
    //price prodProfit prodProfitRate taxRate输入框失去光标事件
    function conditionBlur(curr){
        var tmp = $('input[name="'+curr+'"]').val();

        if("" == tmp){
            $('input[name="'+curr+'"]').val(preval);
        }
    }

    function setRatefun(){
        var index = $("#areaselect").val();
        if(validateSetRate()){
            //输入值合法
            if(0 == index){
                //设置全部区域毛利率
                setAllAreaRate();
			}else{
                //设置该区域毛利率
				index = index - 1;
                setCurrAreaRate(index);
			}
            calcPriceProfit();
            caleachareaTable();
        }
	}

    //脚本触发利润率改变时
    function calcPriceProfit(){
        $(".saleprodTable").each(function(){
            var tr = $(this).find('tbody').children("tr");
            $(tr).each(function(){
                var cost = $(this).children("td:eq(7)").find("label[name=prodCost]").text();//成本
                var profitRate = $(this).children("td").find("#prodProfitRate").val(); // 获取利润率
                var price = cost / (1 - profitRate*0.01);
                price = price.toFixed(0);
                var profit = price - cost;
                $(this).children("td").find("input").eq(1).val(profit); // 利润
                $(this).children("td").find("input").eq(0).val(price); // 单价
            })
        });
    }
    
    //一键设置该区域毛利率
	function setCurrAreaRate(index){
        var setRate = $("#setRate").val();
		$("#saleprodTable"+index).find('input[name$="].profitRate"]').each(function(){
            $(this).val(setRate);
        });
	}
	
	//一键设置全部区域毛利率
	function setAllAreaRate(){
        var setRate = $("#setRate").val();
        $('input[name$=".profitRate"]').each(function(){
            $(this).val(setRate);
        });
	}
	
    //校验一键设置毛利率的输入值
    function validateSetRate(){
        var errormsg = "毛利率不合法,不能超过100.";
        var setRate = $("#setRate").val();
        if(!validateNum(setRate,errormsg)){
            return false;
        }
        return true;
    }
    
    $('#closePopWrap').on('touchstart',function(){
    	window.top.closeNewPopWrap();
    })
    
</script>
</body>
</html>
