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
	<title>编辑报价</title>
	<%--    <link rel="stylesheet" href="${prc }/common/css/font-awesome.min.css"/>
       <link rel="stylesheet" href="${prc }/common/css/build.css"/> --%>

	<jsp:include page="../common/footer_js.jsp" />
	<script src="${prc }/common/js/json2.js"></script>

</head>
<body class="offer-setPrice-box" style="background-color:#f0f2f8;min-height:0">
<form method="post" action="${prc }/offerList/updateOfferPrice" id="prodForm" onsubmit="return validateForm();">
	<input type="hidden" name="exportType" value="${exportType}">
	<input type="hidden" name="offerId" value="${offerId}">

	<div class="cont">
		<div class="downMuneBox">
			<!-- <h3 class="page-til">编辑价格</h3> -->
			<div class="downMune">
				<button type="button" class="btn dropdown-toggle btn-primary" id="dropdownMenu1" data-toggle="dropdown">
					一键设置利润率
					<span class="caret"></span>
				</button>
				<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1" style="width: 200px;left: 0;padding: 5px 0px 14px 6px;box-sizing: content-box;">
					<li role="presentation" data-stopPropagation="true">
						<p style="color: gray;" class="padding-b-10"><b>选择需要设置毛利率的区域</b></p>
					</li>
					<li data-stopPropagation="true">
						<p class="padding-b-10">
							<select id="areaselect">
								<option value="0"><b>全部区域</b></option>
								<c:forEach items="${areas}" var="area" varStatus="status">
									<option value="${status.index+1}"><b>${area.areaName }</b></option>
								</c:forEach>
							</select>
						</p>
					</li>
					<li role="presentation" data-stopPropagation="true">
						<p style="color: gray;" class="padding-b-10"><b>选择需要设置毛利率的区域</b></p>
					</li>
					<li data-stopPropagation="true">
						<p class="padding-b-10"><input type="text" id="setRate" name="setRate" onchange="validateSetRate();" onfocus="conditionFocus('setRate')" onblur="conditionBlur('setRate')" onkeyup="clearNoNum(this)"/><b>%</b></p>
					</li>
					<p><button type="button" class="btn btn-primary" style="width: 90%;" onclick="setRatefun()" data-stopPropagation="true">确定</button></p>
				</ul>
				<!-- <a class="btn btn-primary">一键设置利润率</a>
                <div class="downlow list"></div> -->
			</div>
		</div>

		<c:forEach items="${areas}" var="area" varStatus="status">
			<div class="title" style="height:50px;line-height:50px">${area.areaName }</div>
			<input type="hidden" class="areaid-js" name="areas[${status.index}].fid" value="${area.fid}">
			<div class="well" style="background-color:#fff;margin:0">
				<table class="table tablelist table1 saleprodTable" id="saleprodTable${status.index}">
					<thead>
					<tr>
						<th title="序号" width="50px">序号</th>
						<th title="实物照" width="10%">实物照</th>
						<th title="名称" width="10%">名称</th>
						<th title="产品规格" width="10%">产品规格</th>
						<th title="尺寸/mm" width="8%">尺寸/mm</th>
						<th title="颜色" width="8%">颜色</th>
						<th title="其他属性" width="10%">其他属性</th>
						<th title="数量" width="8%">数量</th>
						<th title="成本/元" width="11%">成本/元</th>
						<th title="单价/元" width="11%">单价/元</th>
						<th title="利润率/%" width="11%">利润率/%</th>
					</tr>
					</thead>
					<tbody>

					<c:forEach items="${area.saleProdList}" var="prod" varStatus="prodStatus">
					<tr>
                        <input type="hidden" class="skuid-js" value="${prod.skuId}"/>
						<input type="hidden" name="areas[${status.index}].saleProdList[${prodStatus.index }].fid" value="${prod.fid}"/>
						<input type="hidden" name="areas[${status.index}].saleProdList[${prodStatus.index }].count" value="${prod.count}"/>
						<td>
							<div class="wp">${prodStatus.index + 1 }</div>
						</td>
						<td>
							<div class="wp">
								<div class="imgWp">
									<img src="${filepath}${prod.picPath}">
								</div>
							</div>
						</td>
						<td name="prodName">
							<div class="wp fontSz-12 prodName wordBreck">${prod.prodName }</div>
						</td>
						<td>
							<div class="wp fontSz-12 resetWp wordBreck" title="${prod.prodSpecification}">${prod.prodSpecification}</div>
						</td>
						<td name="standard" ><div class="wp">${prod.standard }</div></td>
						<td name="color" ><div class="wp">${prod.color }</div></td>
						<td ><div class="wp">${prod.otherPropValue }</div></td>
						<td name="count" ><div class="wp count-td">${prod.count}</div></td>
						<td name="cost" >
							<div class="wp cost-td" name="prodCost"><fmt:formatNumber value="${prod.cost}" pattern="#"></fmt:formatNumber></div>
						</td>
						<td>
							<input type="text" class="inp1 price-js" priceClass="price" id="prodPrice" name="areas[${status.index}].saleProdList[${prodStatus.index }].price" onchange="changeMoney(this,'price')" value="<fmt:parseNumber type="number" value="${prod.price}" />" onkeyup="clearNoNum(this)" onfocus="conditionFocus('areas[${status.index}].saleProdList[${prodStatus.index }].price')" onblur="conditionBlur('areas[${status.index}].saleProdList[${prodStatus.index }].price')"/>
							<input type="hidden" class="inp1 prodProfit-js" id="prodProfit" name="areas[${status.index}].saleProdList[${prodStatus.index }].profit"  value="${prod.profit}" />
						</td>

						<td>
							<input type="text" class="inp1 prodProfitRate-js" id="prodProfitRate" name="areas[${status.index}].saleProdList[${prodStatus.index }].profitRate" onchange="changeMoney(this,'profitRate')" value="${prod.profitRate}" onkeyup="clearNoNum(this)" onfocus="conditionFocus('areas[${status.index}].saleProdList[${prodStatus.index }].profitRate')" onblur="conditionBlur('areas[${status.index}].saleProdList[${prodStatus.index }].profitRate')"/>
						</td>
					</tr>
					</c:forEach>
					<tfoot>
					<tr id="last">
						<td colspan="11">
							<div class="clearfix">
								<p class="fr">利润<label name="tableTotalProfitMoney" id="tableTotalProfitMoney">0</label>元</p>
								<p class="fr padding-r-24 tableSumMoney">总价<label name="tableTotalMoney" id="tableTotalMoney">0</label>元</p>
							</div>
						</td>
					</tr>
					</tfoot>
					</tbody>
				</table>
			</div>
		</c:forEach>

		<div class="title">其他费用设置</div>
		<div class="well" style="margin:0;border-bottom:0">
			<table class="table table2">
				<tbody>
				<tr>
					<td width="20%" style="text-align: right"><input type="checkbox"
                        <c:if test="${client.transMoney gt 0}">
                            checked="true"
                        </c:if>
                        onchange="inpDisableFn(this,1)">运输费，安装服务费等<input type="hidden" id="tran" name="includeTrans" value="1"></td>
					<td width="30%">
                        <input type="text"
                            <c:if test="${empty client.transMoney}">
                                value="0"
                                class="inp1 showCost-js-1"
                            </c:if>
                            <c:if test="${ not empty client.transMoney}">
                                value="${client.transMoney}"
                                <c:if test="${client.transMoney le 0}">
                                    class="inp1 showCost-js-1"
                                    dd = "2"
                                </c:if>
                                <c:if test="${client.transMoney gt 0}">
                                       class="inp1 showCost-js-1 display-n"
                                </c:if>
                            </c:if>
							   onfocus="conditionFocus('transMoney')"
                               disabled="true">
						<input type="text" id="transMoney" name="transMoney" onchange="sumMoney()"
                            <c:if test="${empty client.transMoney}">
                                value="0.00"
                                class="inp1 showCost-js-1 display-n"
                            </c:if>
                            <c:if test="${ not empty client.transMoney}">
                                value="${client.transMoney}"
                                <c:if test="${client.transMoney le 0}">
                                    class="inp1 showCost-js-1 display-n"
                                    dd = "2"
                                </c:if>
                                <c:if test="${client.transMoney gt 0}">
                                    class="inp1 showCost-js-1"
                                </c:if>
                            </c:if>
                            onkeyup="value=value.replace(/[^\d.]/g,'')" onfocus="conditionFocus('transMoney')" onblur="conditionBlur('transMoney')"/>元</td>
					<td width="20%" style="text-align: right">
                        <input type="checkbox"
                            <c:if test="${client.taxRate gt 0}">
                                   checked="true"
                            </c:if>
                            onchange="inpDisableFn(this,2)"><span>税率</span></td>
					<td width="30%">
                        <input type="text"
                            <c:if test="${empty client.taxRate}">
                                   value="0.00"
                                   class="inp1 showCost-js-2"
                            </c:if>
                            <c:if test="${ not empty client.taxRate}">
                                   value="${client.taxRate}"
                                <c:if test="${client.taxRate le 0}">
                                       class="inp1 showCost-js-2"
                                       dd = "2"
                                </c:if>
                                <c:if test="${client.taxRate gt 0}">
                                       class="inp1 showCost-js-2 display-n"
                                </c:if>
                            </c:if>
							   onfocus="conditionFocus('taxRate')"
                               disabled="true">
                        <input type="text" id="taxRate" name="taxRate" onchange="validatetaxRate();sumMoney();"

                                <c:if test="${empty client.taxRate}">
                                    value="0"
                                    class="inp1 showCost-js-2 display-n"
                                </c:if>
                                <c:if test="${ not empty client.taxRate}">
                                    value="${client.taxRate}"
                                    <c:if test="${client.taxRate le 0}">
                                        class="inp1 showCost-js-2 display-n"
                                        dd = "2"
                                    </c:if>
                                    <c:if test="${client.taxRate gt 0}">
                                        class="inp1 showCost-js-2"
                                    </c:if>
                                </c:if>
                                      onkeyup="clearNoNum(this)" onfocus="conditionFocus('taxRate')" onblur="conditionBlur('taxRate')"/>%</td>
				</tr>
				</tbody>
			</table>
		</div>
		<div class="title">合计</div>
		<div class="well" style="margin:0;border-bottom:0">
			<table class="table table2">
				<tbody>
				<tr>
					<td width="20%" class="cr">总成本</td>
					<td width="30%"><label id="totalCost" class="inp1 noinp1"></label>元</td>
					<td width="20%" class="ct">总利润</td>
					<td width="30%"><label id="areaTotalProfit" class="inp1 noinp1"></label>元</td>
				</tr>
				<tr>
                    <td width="20%" class="cr">合计总价<span id="showCost-text-js" class="display-n">（含运输费，安装服务费等）</span></td>
					<td width="30%"><label id="totalMoney" class="inp1 noinp1"></label>元</td>
					<td width="20%" class="ct">含税合计</td>
					<td width="30%"><input id="totalMoneyMultRate" type="text" readonly="true" style="cursor:not-allowed" class="inp1" name="totalMoneyMultRate" value="${client.totalMoneyMultRate}"/>元</td>
				</tr>
				</tbody>
			</table>
		</div>
		<!-- <div class="btnwp textAli-r">
          <button type="submit" class="btn btn-primary" onclick="doFormSubmit()">保存价格设置</button>
        </div>-->

		<!-- <div class="handle-btn-box textAli-r padding-r-20">
            <a class="btns btns-defualt">保存</a>
            <a class="btns btns-defualt">预览</a>
            <a class="btns btns-defualt">导出</a>
            <a class="btns btns-defualt">发到邮箱</a>
        </div> -->
	</div>
</form>


<c:if test="${statues eq 'ok'}">
	<script>
        if(window.parent.editsaveFromTisHandle && !window.parent.iseditSubimit){
            alert("保存成功.");
        }

        //window.close();
	</script>
</c:if>
<script type="text/javascript">


    function inpDisableFn(self,ind){

        var $showEl = $('.showCost-js-'+ind),
            $text = $('#showCost-text-js'),
            canWrite = $(self).is(':checked');
        debugger
        if(canWrite){
            $showEl.eq(1).val(  $showEl.eq(0).val()  );

            if(ind == 1){
                $text.show();
            }
            else{
                validatetaxRate();
            }
            sumMoney();
            $showEl.eq(0).hide();
            $showEl.eq(1).show();
        }
        else{
            $showEl.eq(0).val(  $showEl.eq(1).val()  );
            $showEl.eq(1).val(0.00);

            if(ind == 1){
                $text.hide();
            }
            else{
                validatetaxRate();
            }
            sumMoney();
            $showEl.eq(1).hide();
            $showEl.eq(0).show();
        }

    }


    var reloadthisPage = false;

    var firstTimetmp = 0;
    //计算总成本
    window.onload = function(){

        var totalCost = 0;
        $(".saleprodTable").each(function(){
            var tr = $(this).find('tbody').children("tr");
            $(tr).each(function(){
                var num = $(this).find(".count-td").text(); // 获取数量
                var cost = $(this).find(".cost-td").text(); // 获取成本
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
        var tr =$(inputObj).parents('tr'); // 获取当前行对象
        var money = $(inputObj).val(); // 当前金额
        var cost = tr.find('.cost-td').text(); // 获取成本
        var num = tr.find('.count-td').text(); // 获取数量

        if(type == 'price'){
            var profit = (money - cost);
            var profitRate = profit * 100.0 / money;
            profitRate = profitRate.toFixed(2);
            $(tr).find(".prodProfit-js").val(profit); // 利润
            $(tr).find(".prodProfitRate-js").val(profitRate); // 利润率
        }else if(type == 'profit'){
            var price = parseInt(money) + parseInt(cost);
            price = price.toFixed(0);
            var profitRate = money * 100.0 / price;
            profitRate = profitRate.toFixed(2);
            $(tr).find(".price-js").val(price); // 单价
            $(tr).find(".prodProfitRate-js").val(profitRate); // 利润率
        }else if(type == 'profitRate'){
            var price = cost / (1 - money*0.01);
            price = price.toFixed(0);
            var profit = price - cost;
            $(tr).find(".prodProfit-js").val(profit); // 利润
            $(tr).find(".price-js").val(price); // 单价
        }

        var tab = $(tr).parents('table'); // 获取当前table对象
        var tab_tr = $(tab).find("tbody tr"),
            tfoot = tab.find('tfoot tr');
        sumTableMoney(tab_tr,tfoot);  //计算当前区域金额
        sumAllAreaMoney(); // 计算所有区域金额
        sumMoney();  //计算含税总价
    }

    //合计当前区域金额
    function sumTableMoney(tr,tfoot){
        var totalMoney = 0;
        var totalProfit = 0;

        $(tr).each(function(){
            var price = $(this).children("td").find("#prodPrice").val(); // 获取单价
            var num = $(this).find(".count-td").text(); // 获取数量
            var profit = $(this).find("td").find("#prodProfit").val(); // 获取利润
            if(price){
                totalMoney = parseInt(totalMoney) + (parseInt(price) * num);
            }
            if(profit){
                totalProfit = parseInt(totalProfit) + (parseInt(profit) * num);
            }

        });

        tfoot.find("#tableTotalMoney").text(totalMoney);
        tfoot.find("#tableTotalProfitMoney").text(totalProfit);
    }

    //遍历各个区域tabel
    function caleachareaTable(){
        $(".saleprodTable").each(function(){
            var tr = $(this).find('tbody').children("tr"),
                tfoot = $(this).find('tfoot').children("tr");
            sumTableMoney(tr,tfoot);
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
        result = true;
        $("input[priceClass=price]").each(function(){
            var value = $(this).val();
            if(!value || value ==0){
                result = false;
                return false;
            }
        });
        if(!result){
            if(window.parent.editsaveFromTisHandle){
                alert("请检查产品单价是否合法！");
            }

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

        //含税为空
        if(!($('#totalMoneyMultRate').val())){
            alert('含税总计不能为空');
            return false;
        }

        reloadthisPage = true;

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
            if(!preval){
                preval = 0;
            }
            $("#taxRate").val(preval);
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
        if(preval === '0.00'){
            $('input[name="'+curr+'"]').val("");
		}
        //$('input[name="'+curr+'"]').val("");
    }
    //price prodProfit prodProfitRate taxRate输入框失去光标事件
    function conditionBlur(curr){
        var tmp = $('input[name="'+curr+'"]').val();
        tem = parseInt(tmp);
        if("" == tmp || isNaN(tem)){
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
                var cost = $(this).find(".cost-td").text();//成本
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

    /* 禁止所有输入框的的回车事件 */
    $('body input[type="text"]').on('keydown',function(e){
        var e = e || window.event;
        if(e.keyCode == 13){
            if(e.preventDefault){
                e.preventDefault();
            }
            else{
                e.returnValue = false;
            }
            $(e.currentTarget)[0].blur();
        }
    });

    var bodyHei = $('body').height()+150;


    /* setTimeout(function(){
        PublicSetSelfIframeHeiTop({
            set_hei: bodyHei,
            parent: $(window.parent.document.getElementById('baojiaIfr')),
        });
 },300);	 */

    $(function(){
        if(window.parent.editsaveFromTisHandle && !window.parent.iseditSubimit){
            setTimeout(function(){
                PublicSetSelfIframeHeiTop({
                    set_hei: bodyHei,
                    parent: $(window.parent.document.getElementById('baojiaIfr')),
                });
            },350);
        }
	});

    //检验产品价格是否唯一（保存的时候用）
    function checkProdPrice2(){
        var arr = [],
            arr_ind,
            areaid = [],
            $areaid = $('.areaid-js'),
            $table =  $('.well table.saleprodTable'),
            $tr_all,
            $tr,
            skuid,
            price,
            isBreck = false,
            temp,
            noSaveSwich = false,
            cbFn = function () {};

        $areaid.each(function (i) {
            areaid.push($(this).val());
        });

        $table.each(function (i) {
            $tr_all = $(this).find('tbody tr');

            $tr_all.each(function (k) {
                $tr = $(this);
                arr_ind = arr.length;
                arr[arr_ind] = {};
                temp = arr[arr_ind];
                temp['areaId'] = areaid[i];
                temp['skuId'] = $tr.find('.skuid-js').val();
                price = parseInt($tr.find('.price-js').val());
                //temp['price'] = $tr.find('.price-js').val();

                if(isNaN(price)){
                    price = '';
                }

                if(price == ''|| price === '0'){
                    isBreck = true;
                    return false;
                }
                temp['price'] = Number(price.toFixed(2));
            });

            if(isBreck){
                return false;
            }

        });

        if(!arr.length){
            return;
        }

        if(isBreck){
            return;
        }

        $.ajax({
            contentType:"application/json",
            url : '${prc }/offerList/checkAllAreaSameProdPrice',
            method : 'POST',
            data : JSON.stringify(arr),
            success : function (r) {
                if(r.data){
                    alert(r.data);
                    return false;
                }
                $('#prodForm').submit();
            },
            error : function () {
                alert('校验产品单价是否一致失败');
                return false;
            }
        });
    }


    //检验产品价格是否唯一
    function checkProdPrice(cb,ind){
        var arr = [],
            arr_ind,
			areaid = [],
			$areaid = $('.areaid-js'),
			$table =  $('.well table.saleprodTable'),
            $tr_all,
            $tr,
            skuid,
            price,
            isBreck = false,
            temp,
            noSaveSwich = false,
			cbFn = function () {};

        if(typeof cb === 'function'){
            cbFn = cb;
        }

        $areaid.each(function (i) {
            areaid.push($(this).val());
        });

        $table.each(function (i) {
            $tr_all = $(this).find('tbody tr');

            $tr_all.each(function (k) {
                $tr = $(this);
                arr_ind = arr.length;
                arr[arr_ind] = {};
                temp = arr[arr_ind];
                temp['areaId'] = areaid[i];
                temp['skuId'] = $tr.find('.skuid-js').val();
                price = parseInt($tr.find('.price-js').val());
                //temp['price'] = $tr.find('.price-js').val();

                if(isNaN(price)){
                    price = '';
                }

                if(price == ''|| price === '0'){
                    if(confirm('产品单价不合法，数据不会保存，是否继续进行切换')){
                        noSaveSwich = true;
                    }
                    isBreck = true;
                    return false;
                }
                temp['price'] = Number(price.toFixed(2));
            });

            if(isBreck){
                return false;
            }

        });

        if(noSaveSwich){
            window.parent.isNoSaveFormTab = true;
            cbFn(ind);
            return;
        }

        if(!arr.length){
            cbFn(ind);
            return;
        }

        if(isBreck){
            return;
        }

        $.ajax({
            contentType:"application/json",
            url : '${prc }/offerList/checkAllAreaSameProdPrice',
            method : 'POST',
            data : JSON.stringify(arr),
            //data : JSON.stringify({areaProdInfos:arr}),
            success : function (r) {
                if(r.data){
                    if(confirm( r.data+'\n数据未保存，是否要继续进行切换')){
                    //if(confirm( '检验单价失败，数据未保存，是否要继续进行切换')){
                        window.parent.isNoSaveFormTab = true;
                        cbFn(ind);

                    }
                    return;
                }
                cbFn(ind);
            },
            error : function () {
                //alert('校验产品单价是否一致，校验失败');
                if(confirm('校验单价致失败，数据未保存，是否要继续进行切换')){
                    window.parent.isNoSaveFormTab = true;
                    cbFn(ind);
                }
            }
        });
    }


    function doFormSubmitFn(){

        doFormSubmit();
        window.parent.editsaveFromTisHandle = true;
        if(reloadthisPage){
            window.parent.iseditSubimit = true;
        }
    }

    window.parent.iseditSubimit = false;

    sumMoney();

</script>
</body>
</html>
