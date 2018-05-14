<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="prc" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="../common/head_css.jsp"/>
    <title>Title</title>
    <link href="${prc }/common/css/awesome-bootstrap-checkbox.css" rel="stylesheet">
    <link rel="stylesheet" href="${prc }/common/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="${prc }/common/css/build.css"/>
    <link rel="stylesheet" href="${prc }/common/pager/kkpager_blue.css"/>
    
    <style>
        .container{
            width:100%;
        }
        .container table{
            table-layout:fixed;
        }
    </style>
    
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-sm-3 col-md-3 col-lg-3">
            <%--<a class="btn btn-default" href="${prc}/jsp/company/insertcompany.jsp">+ 新增</a>--%>
        </div>
        <%--<div class="col-sm-3 col-md-3 col-lg-3">
            <form class="navbar-form navbar-left" action="${prc}/company/companyQuery" method="get">
                <div class="form-group">
                    <input type="text" name="name" class="form-control" placeholder="企业名称">
                </div>
                <button type="submit" class="btn btn-default">Search</button>
            </form>
        </div>--%>
    </div>
    <p></p>
    <div class="row">
        <div class="col-sm-12 col-md-12 col-lg-12">
            <div class="panel panel-default">
                <!-- Default panel contents -->
                <div class="panel-heading">产品列表</div>
                
                <!-- Table -->
                <table class="table table-hover table-bordered table-striped" >
                    <thead>
                    <tr>
                        <th width="3%">
                            <div class="checkbox">
                                <input id="checkbox1" class="styled" type="checkbox" name="cbAll">
                            </div>
                        </th>
                        <th width="10%">名称</th>
                        <th width="17%">型号</th>
                        <th width="10%">产品类型</th>
                        <th width="15%">企业</th>
                        <th width="10%">创建时间</th>
                        <th width="10%">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:if test="${fn:length(produceList) eq 0}">
                        <tr>
                            <td colspan="7" style="text-align: center">
                                无结果 !
                            </td>
                        </tr>
                    </c:if>
                    <c:forEach items="${produceList }" var="produce" varStatus="produceidex">
                    <tr>
                        <td><input type="checkbox" name="cbox"/></td>
                        <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="${produce.produceName}">${produce.produceName}</td>
                        <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="${produce.modelNo}">${produce.modelNo}</td>
                        <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="${produce.proTypeBean.name}">${produce.proTypeBean.name}</td>
                        <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="${produce.companyBean.name}">${produce.companyBean.name}</td>
                        <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="${produce.createTime}"><fmt:formatDate value="${produce.createTime}" pattern="yyyy-MM-dd" /></td>
                        <td>
                            &nbsp;&nbsp;
                            <a type="button"  class="btn btn-default btn-xs" href="${prc}/product/getProductInfo?fid=${produce.fid}">
                                详情
                            </a>
                            &nbsp;&nbsp;
                            <a type="button"  class="btn btn-default btn-xs" href="#">
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                            </a>
                            &nbsp;&nbsp;
                            <a type="button" class="btn btn-default btn-xs" href="#">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                            </a>
                        </td>
                    </tr>
                        </c:forEach>
                    
                    </tbody>
                </table>
            </div>
        </div>
        <!-- <div class="col-sm-1 col-md-1"></div> -->
    </div>
    <div class="row">
        <div class="col-sm-12 col-md-12 col-lg-12">
            <button type="button" class="btn btn-default btn-xs">
                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
            </button>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12 col-md-12 col-lg-12">
            <div style="" id="kkpager"></div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer_js.jsp" />
<script src="${prc }/common/pager/kkpager.min.js"></script>
<script>
    $(function(){
        $("#kkpager").html("");
        //var producesCount = ${producesCount};
        //var pageCount = Math.ceil(${producesCount/6});
        //切换分类,重新生成分页
        //生成分页控件
        kkpager.generPageHtml({
            pno : 1,
            mode : 'click', //设置为click模式
            //总页码
            total : Math.ceil(${producesCount/size}),
            //总数据条数
            totalRecords : ${producesCount},
            isShowCurrPage:false,
            isShowTotalRecords:true,
            //点击页码、页码输入框跳转、以及首页、下一页等按钮都会调用click
            //适用于不刷新页面，比如ajax
            click : function(n){
                //这里可以做自已的处理
                window.location.href = "${prc }/product/getProductList?num="+n;
                //处理完后可以手动条用selectPage进行页码选中切换
                //this.selectPage(n);
            },
            //getHref是在click模式下链接算法，一般不需要配置，默认代码如下
            getHref : function(n){
                return '#';
            }

        });
        kkpager.selectPage(${pageNum});
    });
    /*function getProList(queryProdBean){
        $.ajax({
            url:"${prc }/product/toListProduces",
            type: "Post",
            async:false,
            dataType:"json",
            contentType: "application/json; charset=utf-8",
            data:JSON.stringify(queryProdBean),
            success: function(result) {
            
            },
            error: function(err) {
            }
        });
    }*/
</script>
</body>
</html>
