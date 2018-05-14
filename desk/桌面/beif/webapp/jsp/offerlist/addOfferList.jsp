<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="prc" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%-- <link rel="stylesheet" href="${prc}/common/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="${prc}/common/css/build.css"/> --%>
	<jsp:include page="../common/head_css.jsp"/>
	<jsp:include page="../common/footer_js.jsp" />
	
<title>创建报价单</title>
</head>
<body class="offer-create-content-box">
	 <h3 class="page-til">创建报价清单</h3>
     <div class="cont">
         <form action="${prc}/offerListCreate/toSaveClientCompany" method="post" height="100%" onsubmit="return validateSubmit();">
             <div class="clearfix createAreaName">
               <span style="float:left;padding-top:1px"><span class="required-red">*</span>清单名称</span>
               <div class="col-sm-3">
               <p><input type="text" id="offerListName" name="offerListName" placeholder="请输入名字" required></p>
               </div>
             </div>
             <div class="public-infoTab public-tabBox selectCpInfo">
               <div class="title"><span class="font-s-16" style="width:180px">客户企业信息(必填项)</span></div>
               <div class="clearfix tow-cols" id="CustomerInfo">
                   <div class="wp_box col-xs-6">
                     <dl>
                           <dt><span class="required-red">*</span>企业类型</dt>
                           <dd>
                               <select class="select" name="companyType">
		                            <option value="0" selected="selected">请选择企业类型</option>
		                            <c:forEach items="${offerCompanyTypes}" var="type">
					        			<option value="${type.fid}">${type.name}</option>
						        	</c:forEach>
		                        </select>
                           </dd>
                       </dl>
                   </div>    
                   <div class="wp_box col-xs-6">
                       <dl>
                           <dt>员工数</dt>
                           <dd><input type="text" name="staffCount" onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"><span class="danwei">人</span></dd>
                       </dl>
                   </div> 

                   <div class="wp_box col-xs-6">
                       <dl>
                           <dt>户型面积</dt>
                           <dd><input type="text" name="area" onkeyup="value=value.replace(/[^\d.]/g,'')"><span class="danwei">m²</span></dd>
                       </dl>
                   </div> 
                   <div class="wp_box col-xs-6">
                       <dl>
                           <dt>总预算</dt>
                           <dd><input type="text" name="budget" onkeyup="value=value.replace(/[^\d.]/g,'')"><span class="danwei">元</span></dd>
                       </dl>
                   </div> 
                       
               </div>  
             </div>
             <div class="public-infoTab public-tabBox ajust-botton">
                 <div class="title">需要的功能区域(至少填一项)</div>
                 <div class="clearfix three-cols">
                   	 <c:forEach items="${functionAreas}" var="functionArea" varStatus="status">
			            <div class="wp_box col-lg-4 col-xs-4">
			                <dl>
			                    <dt>${functionArea.name}：</dt>
			                    <dd>
			                    	<input type="hidden" name="areas" value="${functionArea.fid}::0::${functionArea.name}" index="${status.index}">
									<a id="min${status.index}" class="addOrcurBtn curBtn disable" onclick="subtract(${status.index})" disabled="disabled"></a> 
									<input id="text_box${status.index}" class="inputEl areaInp-js" name="fid" type="text" value="0" style="width:30px;text-align: center" onkeyup="selectAreaNum(this);"> 							
			                    	<a id="add${status.index}" class="addOrcurBtn addBtn" onclick="add(${status.index})"></a>
			                    </dd>
			                </dl>
			            </div>  
			         </c:forEach> 	              
 
                 </div>  
             </div>
             <div style="text-align: center;" class="margin-b-26">
               <button type="submit" class="btn btn-primary submit-btn">下一步</button>
             </div>
         </form>
     </div>

<script>

	var areaMaxlimit = 99,
		$areaItem = $('.areaInp-js'),
		areaLen = $areaItem.length;

	function checkAreaLimit(el_jq){
		
		var total = 0,
			num,
			i = 0;
		
		for(;i<areaLen;i++){
			num = $areaItem.eq(i).val();
			num = num !== '' ? parseInt(num) : 0;
			total += num;
		}
		
		if(total > areaMaxlimit){
			if(el_jq){
				$(el_jq).val(0);
			}
			alert('区域数量超过'+areaMaxlimit+'限制');
			return false;
		}
		
		return true;
		
	}


	$areaItem.change(function(){
		checkAreaLimit($(this));
	});


(function(){
    var $inputEl = $('.public-infoTab .inputEl');
    $inputEl.blur(function(){
        var that = $(this),
            $prve = that.prev(),
            ind = this.id.split('text_box')[1],
            $hideEL = $("[index="+ind+"]"),
            value,
            areaCountArray,
            val = parseInt(that.val());
        if(!val || val < 0){
            val = 0;
            $prve.attr('disabled',true);
        }
        that.val(val);
        value = $hideEL.val();
        areaCountArray = value.split("::");
        $hideEL.val(areaCountArray[0]+"::"+val+"::"+areaCountArray[2]);
    });
    
    var $inp = $('#CustomerInfo input[type="text"]');
    
    	/* $inp.on('blur',function(){
    		var $sf = $(this),
    			val = parseInt($sf.val());
    		if( isNaN(val)){
    			val = '';
    		}
    		$sf.val(val);
    	}); */
    
    	$inp.on('blur',function(){
 			var $sf = $(this);
 			publicRegxMethod.inputOnlyNum($sf);	
    	});
    	
    	

})();


function selectAreaNum(el_js){
	var self = $(el_js),
		val = self.val().replace(/[^\d.]/g,''),
		$cur = self.siblings('.curBtn');
	
	self.val(val);
	
	if(val > 0){
		$cur.attr('disabled',false);
		$cur.removeClass('disable'); 
	}
	else{
		$cur.attr('disabled',true);
		$cur.addClass('disable');
	}
	
	//value=value.replace(/[^\d.]/g,'');

	
}



//加
function add(index){
	var t = $('#text_box'+index),
		val = parseInt(t.val()),
        $hideEL = $("[index="+index+"]"),
		value,
		$selfEl = $('#min'+index),
		areaCountArray;

	if(!val || val < 0){
		val = 0;
	}
	val++;
	t.val(val);
	
	if( !checkAreaLimit(t) ){
		val = 0;
		t.val(val);		
	}
	
	if(!val || val < 0){
        $('#min'+index).attr('disabled',true);
        $selfEl.addClass('disable');
	}
	else{
		$('#min'+index).attr('disabled',false);
	    $selfEl.removeClass('disable');		
	}

	value = $hideEL.val();
	areaCountArray = value.split("::");
	$hideEL.val(areaCountArray[0]+"::"+val+"::"+areaCountArray[2]);
}
//减
function subtract(index){
	
	var t = $('#text_box'+index),
		val = parseInt(t.val()),
		value,
		areaCountArray,
		$selfEl = $('#min'+index);
	
	if($selfEl.hasClass('disable')){
		return;
	}

	if(!val || val < 0){
		val = 0;
	}
	val--;
	if(val==0){
		$('#min'+index).attr('disabled',true);
		$selfEl.addClass('disable');
	}
	t.val(val);
	value = $("[index="+index+"]").val();
	areaCountArray = value.split("::");
	$("[index="+index+"]").val(areaCountArray[0]+"::"+val+"::"+areaCountArray[2]);
}

function validateSubmit(){
	
	var $CustomerInfo_inp = $('#CustomerInfo input[type="text"]'),
		CustomerInfo_inp_len = $CustomerInfo_inp.length,
		temp;
	
    if(0 == $('select[name="companyType"] option:selected').val()){
        alert("请选择一种企业类型");
        return false;
	}
	if(!validateAreaCount()){
        alert("至少选一项功能区域");
        return false;
	}
	
	for(;CustomerInfo_inp_len--;){
		temp = $CustomerInfo_inp.eq(CustomerInfo_inp_len).val();
		if(!temp){
			$CustomerInfo_inp.eq(CustomerInfo_inp_len).val(0);
		}
	}
	
	if(!checkAreaLimit()){
		return false;
	}
	
	return true;
}
function validateAreaCount(){
    var bool = false;
    $('input[name="fid"]').each(function(){
        if(0!=$(this).val()){
        	bool = true;
        	
		}
	});
    return bool;
}
</script>

</body>
</html>