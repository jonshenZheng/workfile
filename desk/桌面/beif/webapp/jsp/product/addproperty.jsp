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
    </style>
</head>
<body>
    <div class="container">
    <br/>
        <div class="row">
            <div class="col-sm-12 col-md-12 col-lg-12">
                <form class="form-horizontal" role="form" action="${prc }/prodProperty/insertProper" method="post" onsubmit="return submitValid()">
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
                  
                  <div class="form-group">
                       <label for="name" class="col-sm-1 col-md-1 col-lg-1 control-label">属性名<font color="red">*</font></label>
                       <div class="col-sm-2 col-md-2 col-lg-2">
                           <input type="text" class="form-control" name="name" value="" id="name" required>
                       </div>
                  </div>

                  <div class="form-group">
                       <label class="col-sm-1 col-md-1 col-lg-1 control-label">是否销售属性</label>
                       <div class="col-sm-2 col-md-2 col-lg-2">
                            <div class="radio radio-info radio-inline">
                                <input type="radio" id="is_sku_properties1" value="1" name="isSkuProperties" >
                                <label > 是 </label>
                            </div>
                            <div class="radio radio-inline">
                                <input type="radio" id="is_sku_properties2" value="0" name="isSkuProperties" checked>
                                <label> 否 </label>
                            </div>
                       </div>
                       
                  </div>
                  
                  <div class="form-group">
                       <label class="col-sm-1 col-md-1 col-lg-1 control-label">是否基本属性</label>
                       <div class="col-sm-2 col-md-2 col-lg-2">
                            <div class="radio radio-info radio-inline">
                                <input type="radio" id="is_base_properties1" value="1" name="isBaseProperties" >
                                <label > 是 </label>
                            </div>
                            <div class="radio radio-inline">
                                <input type="radio" id="is_base_properties2" value="0" name="isBaseProperties" checked>
                                <label > 否 </label>
                            </div>
                       </div>
                  </div>
                  
                  <div class="form-group">
                       <label class="col-sm-1 col-md-1 col-lg-1 control-label">是否关键属性</label>
                       <div class="col-sm-2 col-md-2 col-lg-2">
                            <div class="radio radio-info radio-inline">
                                <input type="radio" id="is_key_properties1" value="1" name="isKeyProperties" >
                                <label > 是 </label>
                            </div>
                            <div class="radio radio-inline">
                                <input type="radio" id="is_key_properties2" value="0" name="isKeyProperties" checked>
                                <label > 否 </label>
                            </div>
                       </div>
                  </div>
                  
                  <div class="form-group">
                       <label class="col-sm-1 col-md-1 col-lg-1 control-label">是否通用属性</label>
                       <div class="col-sm-2 col-md-2 col-lg-2">
                            <div class="radio radio-info radio-inline">
                                <input type="radio" id="is_common1" value="1" name="isCommon" >
                                <label> 是 </label>
                            </div>
                            <div class="radio radio-inline">
                                <input type="radio" id="is_common2" value="0" name="isCommon" checked>
                                <label> 否 </label>
                            </div>
                       </div>
                  </div>
                  
                  <div class="form-group">
                       <label class="col-sm-1 col-md-1 col-lg-1 control-label">是否选择属性</label>
                       <div class="col-sm-2 col-md-2 col-lg-2">
                            <div class="radio radio-info radio-inline">
                                <input type="radio" id="is_choice_properties1" value="1" name="isChoiceProperties" >
                                <label> 是 </label>
                            </div>
                            <div class="radio radio-inline">
                                <input type="radio" id="is_choice_properties2" value="0" name="isChoiceProperties" checked>
                                <label> 否 </label>
                            </div>
                       </div>
                  </div>
                  
                  <div class="form-group">
                       <label class="col-sm-1 col-md-1 col-lg-1 control-label">是否必填</label>
                       <div class="col-sm-2 col-md-2 col-lg-2">
                            <div class="radio radio-info radio-inline">
                                <input type="radio" id="is_necessary1" value="1" name="isNecessary" >
                                <label> 是 </label>
                            </div>
                            <div class="radio radio-inline">
                                <input type="radio" id="is_necessary2" value="0" name="isNecessary" checked>
                                <label> 否 </label>
                            </div>
                       </div>
                  </div>
                  
                  <div class="form-group">
                       <label class="col-sm-1 col-md-1 col-lg-1 control-label">是否单选</label>
                       <div class="col-sm-2 col-md-2 col-lg-2">
                            <div class="radio radio-info radio-inline">
                                <input type="radio" id="is_single1" value="1" name="isSingle" >
                                <label> 是 </label>
                            </div>
                            <div class="radio radio-inline">
                                <input type="radio" id="is_single2" value="0" name="isSingle" checked>
                                <label> 否 </label>
                            </div>
                       </div>
                  </div>
                  <div class="form-group">
                       <label class="col-sm-1 col-md-1 col-lg-1 control-label">是否数值</label>
                       <div class="col-sm-2 col-md-2 col-lg-2">
                            <div class="radio radio-info radio-inline">
                                <input type="radio" id="is_num1" value="1" name="isNum" >
                                <label> 是 </label>
                            </div>
                            <div class="radio radio-inline">
                                <input type="radio" id="is_num2" value="0" name="isNum" checked>
                                <label > 否 </label></div>
                       </div>
                  </div>
                    <div class="form-group">
                        <label class="col-sm-1 col-md-1 col-lg-1 control-label">是否固定属性</label>
                        <div class="col-sm-2 col-md-2 col-lg-2">
                            <div class="radio radio-info radio-inline">
                                <input type="radio" id="is_Fix_Properties1" value="1" name="isFixProperties" >
                                <label> 是 </label>
                            </div>
                            <div class="radio radio-inline">
                                <input type="radio" id="is_Fix_Properties2" value="0" name="isFixProperties" checked>
                                <label> 否 </label></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 col-md-1 col-lg-1 control-label">是否筛选属性</label>
                        <div class="col-sm-2 col-md-2 col-lg-2">
                            <div class="radio radio-info radio-inline">
                                <input type="radio" id="is_Query_Attributes" value="1" name="isQueryAttributes" >
                                <label> 是 </label>
                            </div>
                            <div class="radio radio-inline">
                                <input type="radio" id="is_Query_Attributes2" value="0" name="isQueryAttributes" checked>
                                <label> 否 </label>
                                <font size="1"> [ 产品库筛选属性 ]</font>
                            </div>
                        </div>
                    </div>
                  
                  <div class="form-group">
                       <%--<label for="order_num" class="col-sm-1 col-md-1 col-lg-1 control-label">属性排序<font color="red">*</font></label>--%>
                       <div class="col-sm-2 col-md-2 col-lg-2">
                            <input type="hidden" title="数值类型" class="form-control" name="orderNum" value="1" id="orderNum" onkeyup="this.value=this.value.replace(/[^0-9]/g,'')" onafterpaste="this.value=this.value.replace(/[^0-9]/g,'')" required/>
                       </div>
                  </div>
                  
                  <div class="form-group">
                        <label for="" class="col-sm-1 col-md-1 col-lg-1 control-label">&nbsp;</label>
                        <div class="col-sm-2 col-md-2 col-lg-2">
                            <button type="submit" class="btn btn-default">保存</button>
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
    <script type="text/javascript">
    //计数器
    var counter = 0;
    //保存属性值
    var propvalue = [];
    //保存已经加载了的下拉框的第一个值
    var selecttmp = [];
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
            type : "POST",
            data:{"id":$("#"+num).val()},
            success : function(result) {
                var childProTypeList = result.childProType;
                
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
    
    //数组删除元素，参数：要删除的元素
    Array.prototype.remove = function(val) {
        var index = this.indexOf(val);
        if (index > -1) {
            this.splice(index, 1);
        }
    };
    
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
        
        if(true == boo){
            //给最后一个select添加name,获取该select的选中值作为产品类型
            $("#topProtype"+selecttmp.length).attr("name","prodTypeId");
        }
        
        return boo;
    }
    
    </script>
    
</body>
</html>