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
                <form class="form-horizontal" role="form" action="${prc }/prodProperty/insertProperVal" method="post" onsubmit="return submitValid()">
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
                     <label class="col-sm-1 col-md-1 col-lg-1 control-label">属性<font color="red">*</font></label>
                     <div class="col-sm-2 col-md-2 col-lg-2">
                         <select class="form-control" id="propertiesId" name="propertiesId">
                            <option value ="none">--请选择--</option>
                         </select>
                     </div>
                   </div>
                  
                  <div class="form-group">
                     <label for="propertiesValue" class="col-sm-1 col-md-1 col-lg-1 control-label">属性值<font color="red">*</font></label>
                     <div class="col-sm-3 col-md-3 col-lg-3">
                          <input type="text" class="form-control" value="" id="inputProperValue" onblur="addTag()"/>
                          <input type="hidden" name="propertiesValue" value="" id="propertiesValue" />
                     </div>
                   </div>
                      
                  <div class="row">
                      <div class="col-sm-1 col-md-1 col-lg-1"></div>
                      <div class="col-sm-6 col-md-6 col-lg-6" id="tagDivRow">
                        <!-- <div class="form-group" id="tagDiv0">
                             <div class="has-feedback label label-info" style="margin-left:15px;">
                                  <span>信息标签0001110dfdf</span>&nbsp;&nbsp;&nbsp;&nbsp;
                                  删除按钮
                                  <a id="deltag" class="glyphicon glyphicon-remove btn form-control-feedback" ></a>
                              </div>
                        </div> -->
                      </div>
                  </div>
                  
                  <div class="form-group">
                        <label class="col-sm-1 col-md-1 col-lg-1 control-label">&nbsp;</label>
                        <div class="col-sm-2 col-md-2 col-lg-2">
                            <button type="button" class="btn btn-default">保存</button>
                            <button type="submit" class="btn btn-default">提交</button>
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
    //查询下一级分类
    function changeProper(num){
        emptyProperties();
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
                
                if(0 == childProTypeList.length){
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
    
    //清空属性
    function emptyProperties(){
        $("#propertiesId").empty();
        var defaultVal = '<option value ="none">--请选择--</option>';
        $("#propertiesId").append(defaultVal);
    }
    //查询属性
    function queryProperties(parentId){
        emptyProperties();
        $.ajax({
            url : "${prc}/prodProperty/queryProperties",
            type : "POST",
            data:{"prodTypeId":parentId},
            success : function(result) {
                var proProperties = result.proProperty;
                
                var opt = "";
                
                for(var i=0;i<proProperties.length;i++){
                    opt += "<option value =\""+proProperties[i].fid+"\">"+proProperties[i].name+"</option>";
                }
              //拼接下拉选择框
                $("#propertiesId").append(opt);
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
                return false;
            }
        }
        
        //校验属性是否选中
        if('none' == $("#propertiesId option:selected").val()){
            alert("请选择一个属性.");
            return false;
        }
        
        if(0 == propvalue.length){
            alert("请输入属性值.");
            return false;
        }else{
          //获取属性值列表
            $("#propertiesValue").val(propvalue);
        }
        
        return true;
    }
    
    function addTag(){
        //获取输入框的值
        var porval = trimStr($("#inputProperValue").val());
        
        if(0 != porval.length){
            
            var result= $.inArray(porval, propvalue);
            if(-1 == result){
                var addrowhead = "<div class=\"form-group\" id=\"deltagdiv"+counter+"\">";
                var addrowtail = "</div>";
                var head = "<div class=\"has-feedback label label-info\" id=\"deltag"+counter+"\" style=\"margin-left:15px;\"><span>";
                var tail = "</span>&nbsp;&nbsp;&nbsp;&nbsp;<a onclick=\"delfun('"+counter+","+porval+"')\" class=\"glyphicon glyphicon-remove btn form-control-feedback\" ></a></div>";
                var taghtml = head + porval + tail;
                
                if(!(propvalue.length % 6)){
                  //添加新行
                    taghtml = addrowhead + taghtml + addrowtail;
                    $("#tagDivRow").append(taghtml);
                    
                }else{
                    var tg = $('#tagDivRow>div:last')[0].id;
                    
                  //每行放6个标签
                    $("#"+tg).append(taghtml);
                }
                
                //保存属性值
                propvalue.push(porval);
                counter += 1 ;
                
                $("#inputProperValue").val("");
                
                //重置父页面的高度
                parent.SetWinHeight();
            }else{
                alert("请勿重复添加.");
            }
            
            
        }
    }
    
    //删除标签
    function delfun(num){
        var str = num;
        var strs = [];
        strs = str.split(","); 
        $("#deltag"+strs[0]).remove();
        propvalue.remove(strs[1]);
        
        //删除行
        if(0 == $("#deltagdiv"+strs[0]).find("div").length){
            $("#deltagdiv"+strs[0]).remove();
        }
    }
    
    //去除输入框首尾空格,解决浏览器不兼容的问题
    function trimStr(str){
        return str.replace(/(^\s*)|(\s*$)/g,"");
    }
    </script>
    
</body>
</html>