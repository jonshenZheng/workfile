<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="prc" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="../common/head_css.jsp"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>index</title>
    <link rel="stylesheet" href="${prc }/common/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="${prc }/common/css/build.css"/>

    
    <style>
        body{background-color: white;}
        .container{
            width:100%;
        }
        
        .form-horizontal .has-feedback .form-control-feedback{
            pointer-events: auto;
            color:white;
            right:0px;
            padding-top: inherit;
        }
        .form-horizontal .has-feedback a:hover{
            color:red;
        }
        .checkbox-inline+.checkbox-inline, .radio-inline+.radio-inline{
            margin-left: 0px;
        }
        
        .col-lg-1, .col-lg-10, .col-lg-11, .col-lg-12, .col-lg-2, .col-lg-3, .col-lg-4, .col-lg-5, .col-lg-6, .col-lg-7, .col-lg-8, .col-lg-9, .col-md-1, .col-md-10, .col-md-11, .col-md-12, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-sm-1, .col-sm-10, .col-sm-11, .col-sm-12, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-sm-8, .col-sm-9, .col-xs-1, .col-xs-10, .col-xs-11, .col-xs-12, .col-xs-2, .col-xs-3, .col-xs-4, .col-xs-5, .col-xs-6, .col-xs-7, .col-xs-8, .col-xs-9 {
            position: relative;
            min-height: 1px;
            padding-right: 15px;
            padding-left: 0px;
        }
    
    </style>
</head>
<body>
<div class="container">
    <br/>
    <div class="row">
        <div class="col-sm-12 col-md-12 col-lg-12">
            <form id="form01" class="form-horizontal" role="form" action="${prc }/product/addProductInfo" method="post" onsubmit="return submitValid()" enctype="multipart/form-data">
                <div class="form-group" id="properdiv">
                    <label class="col-sm-1 col-md-1 col-lg-1 control-label">分类<font color="red">*</font></label>
                    <div class="col-sm-2 col-md-2 col-lg-2">
                        <select class="form-control" id="topProtype0" onchange="changeProper('topProtype0')">
                            <option value ="none">--请选择--</option>
                            <c:forEach items="${topProTypes }" var="tp">
                                <option value ="${tp.fid }">${tp.name }</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                
                <fieldset>
                    <div class="panel-group" id="accordion" >
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" data-parent=""
                                       href="#collapseOne" >
                                        产品信息
                                    </a>
                                </h4>
                            </div>
                            <div id="collapseOne" class="panel-collapse collapse in">
                                <div class="panel-body">
                                    <div class = "form-group">
                                        <label class="col-sm-1 col-md-1 col-lg-1 control-label" for = "produceName">产品名称</label>
                                        <div class="col-sm-2 col-md-2 col-lg-2">
                                            <input type="text" class="form-control" name="produce.produceName" id = "produceName" placeholder = "" />
                                            <%--企业.companyId--%>
                                            <input type="hidden" class="form-control" name="produce.companyId" id = "companyId" value="${user.companyId}"  />
                                        </div>
                                    </div>
                                    <div class = "form-group">
                                        <label class="col-sm-1 col-md-1 col-lg-1 control-label" for = "modelNo">产品型号</label>
                                        <div class="col-sm-2 col-md-2 col-lg-2">
                                            <input type="text" class="form-control" name="produce.modelNo" id = "modelNo" placeholder = "" />
                                        </div>
                                    </div>
                                    <div class = "form-group">
                                        <label class="col-sm-1 col-md-1 col-lg-1 control-label" >产品风格</label>
                                        <div class="col-sm-5 col-md-5 col-lg-5">
                                            <c:forEach items="${designlist}" var="design" varStatus="ind">
                                                <div class="checkbox checkbox-primary checkbox-inline">
                                                    <input type="checkbox" class="form-control" name="designs" id = "designId${ind.index}" value="${design.fid}"/>&nbsp;&nbsp;&nbsp;
                                                    <label for="designId${ind.index}">${design.name}</label>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-info" >
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" data-parent=""
                                       href="#collapseTwo" >
                                        销售属性
                                    </a>
                                </h4>
                            </div>
                            <div id="collapseTwo" class="panel-collapse collapse">
                                <div class="panel-body" id="propertyValDiv">
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-info" >
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" data-parent=""
                                       href="#collapseThree" >
                                        库存
                                    </a>
                                </h4>
                            </div>
                            <div id="collapseThree" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <!-- Table -->
                                    <%--放组合表格--%>
                                </div>
                            </div>
                        </div>
                    
                    </div>
                
                </fieldset>
                
                <div class="form-group">
                    <label class="col-sm-1 col-md-1 col-lg-1 control-label">&nbsp;</label>
                    <div class="col-sm-2 col-md-2 col-lg-2">
                        <button class="btn btn-default" type="submit">保存</button>
                    </div>
                
                </div>
            </form>
        
        </div>
    </div>
</div>

<c:if test="${status eq 'success'}">
    <script>
        alert("录入成功.");
    </script>
</c:if>

<jsp:include page="../common/footer_js.jsp" />
<script src="${prc }/common/js/json2.js"></script>


<script type="text/javascript">
    //保存已经加载了的下拉框的第一个值
    var selecttmp = [];
    //把属性的位置和列号保存一一对应关系，拼接属性值需要用到
    var proPropertiesTdNum = [];
    //保存属性
    var proProperties = [];
    //保存属性值
    var proPropertiesVal = [];

    //按属性归类选择的属性值保存到一个二维数组
    //var tmparr = [];
    var tmparrhave = 0;
    //属性值组合
    //var array = tmparr;
    //var results = [];
    var indexs = {};
    
    //选项类型名字
    var optionTitle = [];

    function changeProper(num){
        //清理该select后面的所有select
        var ind = num.substring(10,11);
        var selelen = selecttmp.length;
        for(var i = ind*1+1;i<=ind*1+selelen*1;i++){
            //删除数组里面的元素，下次重复添加
            var selectId = document.getElementById("topProtype"+i);
            if(null != selectId){
                var firstvalue = selectId.options[1].value;
                selecttmp.remove(firstvalue);
                //删除该下来选择框
                $("#protypediv"+i).remove();
            }
        }
        
        $.ajax({
            url : "${prc}/product/getchildProType",
            async: false,
            type : "POST",
            data:{"id":$("#"+num).val()},
            success : function(result) {
                var childProTypeList = result.childProType;
                //每次初始化
                $('#collapseThree').html("");
                //results = [];
                //tmparr.length = 0;
                tmparrhave = 0;
                if(0 == childProTypeList.length){
                    //清空销售属性下的所有内容
                    $("#propertyValDiv").empty();
                    parent.SetWinHeight();
                    //最后一级分类时,查询该分类的所有属性
                    queryProperties($("#"+num).val());
                }
                if(0 != childProTypeList.length){
                    var boo = 0;
                    for(var i = 0;i<selecttmp.length;i++){
                        if(childProTypeList[0].fid == selecttmp[i]){
                            //避免重复添加
                            boo = 1;
                        }
                    }
                    if(boo == 0){
                        //避免重复添加
                        selecttmp.push(childProTypeList[0].fid);

                        var opt="";

                        var def = "<option value =\"none\">--请选择--</option>";
                        var head = "<div class=\"col-sm-2 col-md-2 col-lg-2\" id=\"protypediv"+selecttmp.length+"\""+"><select class=\"form-control\" id=\"topProtype"+selecttmp.length+"\" onchange=\"changeProper('topProtype"+selecttmp.length+"')\" >"+def;
                        var teal = "</select>";
                        for(var i=0;i<childProTypeList.length;i++){
                            opt += "<option value =\""+childProTypeList[i].fid+"\">"+childProTypeList[i].name+"</option>";
                        }
                        var selecthtml = head + opt + teal;
                        //拼接下拉选择框
                        $("#properdiv").append(selecthtml);
                    }
                }
            },
            error:function(msg){
                alert("初始化数据失败.");
            }
        })
    }

    //查询该分类下面所有的属性
    function queryProperties(parentId){
        $.ajax({
            url : "${prc }/prodProperty/queryPropertiesVal",
            async: false,
            type : "POST",
            data:{"prodTypeId":parentId},
            success : function(result) {

                proProperties = result.proPropertyVals;
                
                //创建库存表格头
                addAtockTable(proProperties);
                
                //生成选项
                randleOptionVal(proProperties);
            },
            error:function(msg){
                alert("初始化数据失败.");
            }
        })
    }

    //查询属性值
    function queryPropertiesVal(propertiesId){
        var proPropertiesval = [];
        $.ajax({
            url : "${prc}/prodProperty/queryPropertiesVal",
            async: false,
            type : "POST",
            data:{"propertiesId":propertiesId},
            success : function(result) {
                proPropertiesval = result.proPropertyVallist;
            },
            error:function(msg){
                alert("初始化数据失败.");
            }
        });
        return proPropertiesval;
    }

    //数组删除元素，参数：要删除的元素
    Array.prototype.remove = function(val) {
        var index = this.indexOf(val);
        if (index > -1) {
            this.splice(index, 1);
        }
    };

    //提交表单前的校验
    function submitValid(){
        var boo = true;
        //校验分类选择是否合法
        for(var i = 0;i<=selecttmp.length;i++){
            var val = $("#topProtype"+i+" option:selected").val();
            if('none' == val){
                alert("请检查选择的分类是否合法.");
                boo = false;
                return boo;
            }
        }

        //校验产品信息
        if(!validateProInfo()){
            boo = false;
            return false;
        }

        //校验销售属性
        if(!validateProPros()){
            boo = false;
            return false;
        }

        //校验产品风格
        if(!validateProDesign()){
            boo = false;
            return false;
        }

        if(true == boo){
            //给最后一个select添加name,获取该select的选中值作为产品类型
            $("#topProtype"+selecttmp.length).attr("name","produce.prodTypeId");
        }
        return boo;
    }
    
    /*校验产品信息*/
    function validateProInfo(){
        var produceName = $("#produceName").val();
        var modelNo = $("#modelNo").val();
        if("" == produceName){
            alert("产品名称不能为空");
            return false;
        }
        if("" == modelNo){
            alert("产品型号不能为空");
            return false;
        }
        return true;
    }

    //校验产品风格
    function validateProDesign(){
        if($("input[name='designs']:checked").length == 0){
            alert("请选择一个产品风格");
            return false;
        }
        return true;
    }

    //销售属性都要勾
    function validateProPros(){
        var tb = true;
        for(var i=0;i<proProperties.length;i++){
            var tname = proProperties[i].fid;
            if($("input[name="+tname+"]:checked").length == 0){
                alert("请检查销售属性是否全部勾选.");
                tb = false;
                break;
            }
        }

        return tb;
    }

    /**
     * 生成一个用不重复的ID
     */
    function GenNonDuplicateID(randomLength){
        return Number(Math.random().toString().substr(3,randomLength) + Date.now()).toString(36)
    }

    function textachange(){
        parent.SetWinHeight();
    }

    //全部展开
    $(function () { $('#collapseTwo').collapse('show')});
    $(function () { $('#collapseThree').collapse('toggle')});
    $(function () { $('#collapseOne').collapse('show')});
    
    /*当折叠元素对用户可见时触发该事件（将等待 CSS 过渡效果完成）。*/
    $('#collapseOne').on('shown.bs.collapse', function () {
        parent.SetWinHeight();
    });
    $('#collapseTwo').on('shown.bs.collapse', function () {
        parent.SetWinHeight();
    });
    $('#collapseThree').on('shown.bs.collapse', function () {
        parent.SetWinHeight();
    });

    function deleteCurrentRow(obj)
    {
    	var $tr = $(obj).parents('tr'),
    		row_num = $tr.index(),
    		$tr_list = $('#collapseThree tbody tr'),
    		del_val,
    		del_val_len,
    		del_til,
    		del_opt,
    		temp,
    		del_val_ind = [],
    		tr_selectVal,
    		tr_list_len = $tr_list.length,
    		el_wp,
    		el_type,
    		select_val,
    		val_ind;
    	
    	del_val = $tr_list.eq(row_num).data('trval');

    	del_val = del_val.substr(1).slice(0,-1);
    	del_val = del_val.split(';');
    	del_val_len = del_val.length;
    	
    	if(del_val_len === 0){
    		return;
    	}
    	
    	if(tr_list_len<=0){
    		return;
    	}

    	for(;tr_list_len--;){
    		if(tr_list_len !== row_num){
    			
    			tr_selectVal = $tr_list.eq(tr_list_len).data('trval');
    			del_val_len = del_val.length;
    			for(var kkb=0;kkb<del_val_len;kkb++){
    				if( tr_selectVal.indexOf(';'+del_val[kkb]+';') !== -1 ){
    					if( !del_val_ind[kkb] ){
    						del_val_ind[kkb] = kkb;
    					}
    				}
    			}

    		}
    	}
    
    	if(del_val_ind.length){
			del_val_ind.sort();
			del_val_len = del_val_ind.length;
			if(del_val_len <= 0){
				return;
			}
		    for(;del_val_len--;){
		    	if(!del_val_ind[del_val_len] && del_val_ind[del_val_len]!= 0){
		    		continue;
		    	}
				del_val.splice( del_val_ind[del_val_len],1 );
			} 
			
		}
    	
    	$tr.remove();
    	
    	//要去勾选的属性
    	del_val_len = del_val.length;
    	
    	if(!del_val_len){
    		return;
    	} 
    	
    	var $selecItem = $('#propertyValDiv .proto_list'),
    		$opt_el;
    	
    	for(;del_val_len--;){
    		temp = del_val[del_val_len].split('#');
    		del_til = temp[0];
    		del_opt = temp[1];
    		$opt_el = $selecItem.eq(del_til).find('input[value="'+del_opt+'"]'),
    		el_type = $opt_el[0].type;
    		
    		if($opt_el.length == 0){
    			continue;
    		}
    		
    		el_wp = $opt_el.parents('.proto_list');
    		
    		//多选类型
    		if( el_type === 'checkbox' ){
    			$opt_el.attr("checked", false);
    			select_val = el_wp.data('selectval');
    			val_ind = select_val.indexOf(';'+del_opt+';');
    			
    			if(val_ind >= 0){
    				select_val = select_val.replace(';'+del_opt,'');
    			}
    			
    			el_wp.data('selectval',select_val);
    		}
    		//单选类型
    		else if(el_type === 'radio'){
    			$opt_el.attr("checked", false);
    			el_wp.data('selectval','');
    		}
    		//输入框类型
    		else if(el_type === 'text' ){
    			$opt_el.val('');
    			el_wp.data('selectval','');
    		}
    	}

    }
    
    //拼接选项属性值
    function randleOptionVal(proProperties){
    	
    	var str_tpl = '',
    		len_opt  = 0,
    		title = '',
    		len_item = proProperties.length,
    		len_item_i = 0,
    		temp,
    		opt_i = 0;
    		
    	for(;len_item_i<len_item;len_item_i++){
    		str_tpl += '<div data-selectval="" class="form-group proto_list">';
    			str_tpl += '<label class="col-sm-1 col-md-1 col-lg-1 control-label">'+proProperties[len_item_i].name+'</label>';	
      	        str_tpl += '<div class="col-sm-6 col-md-6 col-lg-6">';
    			
   			//单选或多选
   			if(proProperties[len_item_i].proProperty.isChoiceProperties == 1){
   				
   				opt_i = 0;
   	            temp = proProperties[len_item_i].values;
   	            len_opt = temp.length;
   				
   				//单选
   				if(proProperties[len_item_i].proProperty.isSingle == 1){

       	            for(;opt_i<len_opt;opt_i++){
       	            	title = temp[opt_i];
       	            	str_tpl += '<div class="radio radio-info radio-inline"><input type="radio"  value="'+title+'" onclick="getElem(this)" /><label>'+title+'</label></div>';
       	            }
   				}
   				else{
  
       	            for(;opt_i<len_opt;opt_i++){
       	            	title = temp[opt_i];
       	            	str_tpl += '<div class="checkbox checkbox-primary checkbox-inline"><input type="checkbox" class="styled styled-primary"  value="'+title+'" onclick="getElem(this)" /><label>'+title+'</label></div>';
       	            } 	       	                            

   				}
   				
   				
   			}
   			else{
   				
   				//数字类型
   				if(proProperties[len_item_i].proProperty.isNum == 1){
   					str_tpl += '<font size="1" color="red">只能数字</font><div class="col-sm-4 col-md-4 col-lg-4"><input type="text" class="form-control" onfocus="clearInpVal(this);" onblur="setInpVal(this)" onkeyup="this.value=this.value.replace(/[^0-9]/g,\'\')" onafterpaste="this.value=this.value.replace(/[^0-9]/g,\'\')" /></div>';
   				}
   				else{
   					str_tpl += '<div class=\"col-sm-4 col-md-4 col-lg-4\"><input type="text"  class="form-control" onfocus="clearInpVal(this);" onblur="setInpVal(this)"/></div>';
   				}
   				
   				
   			}
   				str_tpl += '</div>';

    	    str_tpl += '</div>';
    	}
    	
    	$("#propertyValDiv").append(str_tpl);
        parent.SetWinHeight();

    }

    //但选择销售属性时：加载库存
    function addAtockTable(proProperties){
    	optionTitle = [];
    	
    	var srt_tpl = '',
    		len;
    	len = proProperties.length;
    	
        srt_tpl += '<table class="table table-hover table-striped table-bordered">';
            srt_tpl += '<thead>';
                srt_tpl += '<tr>';
                    srt_tpl += '<th width="5%">'+"操作"+'</th>';
				for(var i=0;i<len;i++){
					srt_tpl += '<th width="10%">'+proProperties[i].name+'</th>';
					optionTitle[optionTitle.length] = proProperties[i].name;
				}	

                    srt_tpl += '<th width="10%">存量</th>';
                    srt_tpl += '<th width="10%">成本(元)</th>';
                    srt_tpl += '<th width="10%">标签</th>';
                    srt_tpl += '<th width="10%">产品描述</th>';
                    srt_tpl += '<th width="10%">模型</th>';
                    srt_tpl += '<th width="10%">图片</th>';
                srt_tpl += '</tr>';
            srt_tpl += '</thead>';
            srt_tpl += '<tbody></tbody>';
        srt_tpl += '</table>';
        
      	$("#collapseThree").append(srt_tpl);
        parent.SetWinHeight();

    }

    //属性值：n X m X k...组合
    function combination(current){
		var $el= $(current),
			$el_wp = $el.parents('.proto_list'),
			selectVal='',
			elVal= '',
			temp,
			ind;

        var nameVal = {"name":current.name,"value":current.value};
        var ifcheckbox = 9999;

        if("radio" == current.type){
        	
        	if($el.is(':checked')){
        		elVal = $el.val();
        		selectVal = $el_wp.data('selectval',';'+elVal+';');
        	}
        	else{
        		$el_wp.data('selectval','');
        	}
 
        }
        else{
        	
        	elVal = $el.val();
    		selectVal = $el_wp.data('selectval');
        	
        	//选中
        	if($el.is(':checked')){
        		
        		if(selectVal){
        			if(selectVal.indexOf(';'+elVal+';') === -1){
        				selectVal += elVal+';';
        			}
        		}
        		else{
        			selectVal = ';'+elVal+';';
        		}
        		$el_wp.data('selectval',selectVal);
        	}
        	else{
        		 
        		if(selectVal){
        			ind = selectVal.indexOf(';'+elVal+';');
        			if(ind !== -1){
        				temp = selectVal.split(';').length;
        				if( temp <= 3 ){
        					selectVal = '';
        				}
        				else{
        					selectVal = selectVal.replace(';'+elVal,'');      					
        				}
        				
        			}
        			$el_wp.data('selectval',selectVal);
        		}
        		        		
        	}
        }	
        	
    }
    function MyMap(arr) {
        var newArray = new Array(arr.length);
        for(var i=0;i<arr.length;i++){
            newArray[i] = [];
            for(var j=0;j<arr[i].length;j++){
                newArray[i].push(arr[i][j]);
            }
        }
        return newArray;
    }

    function specialSort(start,array) {
        var len = array.length;
        start++;
        if (start > len - 1) {
            return;
        }
        if (!indexs[start]) {
            indexs[start] = 0;
        }
        if (!(array[start] instanceof Array)) {
            array[start] = [array[start]];
        }
        for (indexs[start] = 0; indexs[start] < array[start].length; indexs[start]++) {
            specialSort(start,array);
            if (start == len - 1) {
                var temp = [];
                for (var i = len - 1; i >= 0; i--) {
                    if (!(array[start - i] instanceof Array)) {
                        array[start - i] = [array[start - i]];
                    }
                    temp.push(array[start - i][indexs[start - i]]);
                }
                //results.push(temp);
            }
        }
    }

    //表格体拼接
    function addAtockTableTr(){
        //上一步组合好的结果为results
        var currRow = $("#atockTable tbody").find("tr").length;
        
        var getAllVal = [],
        	$data_list = $('#propertyValDiv .proto_list'),
        	temp_val,
        	temp_getval,
        	temp_getval_len,
        	temp_cow,
        	temp_contnum,
        	data_len = $data_list.length,
        	total_row = 1,
        	total_valArr = [],
        	val_arr = [],
        	isNullList = true,
        	col_num = proProperties.length,
        	col_i,
        	str_tpl = '',
        	temp_i1,
        	temp_i2,
        	arr_ind;
        
        if(data_len<=0){
        	return;
        }
              
        temp_cow = data_len;
        temp_i1 = 0;
        
        for(;temp_i1<data_len;temp_i1++){
        	val_arr[temp_i1] = [];
        	temp_val = $data_list.eq(temp_i1).data('selectval');
        	if(!temp_val){
        		continue;
        	}
        	temp_getval = temp_val.substr(1).slice(0,-1);
        	temp_getval = temp_getval.split(';');
        	temp_getval_len = temp_getval.length;
        	
        	if(temp_getval_len == 0){
        		continue;
        	}
        	for(;temp_getval_len--;){
        		arr_ind = val_arr[temp_i1].length;
        		val_arr[temp_i1][arr_ind] = temp_getval[temp_getval_len];
        	}       	
  	
        }
              
        for(;temp_cow--;){
        	temp_contnum = val_arr[temp_cow].length;
        	if(!temp_contnum){
        		temp_contnum = 1;
        	}
        	else{
        		isNullList = false;
        	}
        	total_row *= temp_contnum;
        }
        
        if(isNullList){
        	//一个都没勾选
        	$("#collapseThree tbody").html('');
        	return;
        }
        
        var results = [],
	    	result = {},
	    	hasVal,
	    	ajust = 0;
        
        function concatObj(addinObj,Obj){
		    for(var k in Obj){
		        addinObj[k] = Obj[k];
		    }
		    return addinObj;
		}
        
        function doExchange(arr, depth){
			if( arr[depth] && arr[depth].length === 0){
				if(arr[depth+1]){
					ajust++;
					doExchange(arr,depth+1);
				}
				else{
					total_valArr.push(concatObj({},result));
				}
			}
			else{

				for (var i = 0; i < arr[depth].length; i++) {
			        result[depth] = arr[depth][i];
			        if (depth != arr.length - 1) {
			            doExchange(arr, depth + 1);
			        } else {
			        	total_valArr.push(concatObj({},result));
			        }
			    }

			}
		}
              
	    doExchange(val_arr, 0);
	         
        for(;total_row--;){
        	col_i = 0;

        	hasVal = ';';
        	for(var key in total_valArr[total_row]){
        		hasVal += key+'#'+total_valArr[total_row][key]+';'
        	}
        	str_tpl += '<tr data-trval="'+hasVal+'"><td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="" class="del"><a href="javascript:;" onclick="deleteCurrentRow(this);"><font color="red">删除</font></a></td>';
        	for(;col_i < col_num;col_i++){
     
        		if(total_valArr[total_row][col_i]){
        			str_tpl += '<td title="">'+total_valArr[total_row][col_i]+'</td>'; 
        		}
        		else{
        			str_tpl += '<td title=""></td>'; 
        		}       		
        	}
        	str_tpl += '<td style="" title=""><input type="text" name="skuList[0].count" id="countps_101" class="form-control" onkeyup="this.value=this.value.replace(/[^0-9]/g,\'\')" onafterpaste="this.value=this.value.replace(/[^0-9]/g,\'\')" required="required" oninvalid="setCustomValidity(\'必须填写,且为数值！\');" oninput="setCustomValidity(\'\');" value="0"></td>';
        	str_tpl += '<td style="" title=""><input type="text" name="skuList[0].price" id="priceps_101" class="form-control" value="0"></td>';
        	str_tpl += '<td style="" title=""><input type="text" name="skuList[0].label" id="labelps_101" class="form-control"></td>';
        	str_tpl += '<td style="" title=""><textarea type="text" name="skuList[0].memo" id="memops_101" class="form-control" rows="2" cols="25" style="resize:none"></textarea></td>';
        	str_tpl += '<td style="" title=""><input type="file" id="promodelps_101" name="moduleFile" class="btn btn-default"></td>';
        	str_tpl += '<td style="" title=""><input type="file" id="propicps_101" name="imageFile" class="btn btn-default"></td><td style="display:none" title=""><input type="text" name="skuList[0].propertiesId" id="propertiesId0" value="ps_101;" class="form-control"></td><td style="display:none" title=""><input type="text" name="skuList[0].propertiesValues" id="propertiesValues" value="W2000D1700H750;" class="form-control"></td>';
            str_tpl += '</tr>';
        }
        $("#collapseThree tbody").html('');	
        $("#collapseThree tbody").append(str_tpl);

        parent.SetWinHeight();
    }
    
    var beforeoldInpVal = '';
    
    function clearInpVal(el){
    	var $self = $(el);
    	beforeoldInpVal = $self.val();
    	$self.val('');
    }
    
    function setInpVal(el){
    	
    	var $self = $(el),
    		$parent,
    		new_val = $self.val();
    	
    	if(!new_val){
    		return;
    	}
    	
    	if(beforeoldInpVal === new_val){
    		return;
    	}
    	
    	$parent = $self.parents('.proto_list');
    	
    	$parent.data('selectval',';'+new_val+';');
    	
    	addAtockTableTr();
    }

    //获取当前单击事件的信息:主要用来处理单选按钮和多选框
    function getElem(current){
		
        //组合选择的属性值
        combination(current);
        //拼接表格体
        addAtockTableTr();
    }

</script>

</body>
</html>