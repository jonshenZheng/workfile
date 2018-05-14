<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="prc" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>index</title>
    <jsp:include page="../common/head_css.jsp"/>
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
    
    <!-- <script type="text/javascript">
        /* 初始化企业信息 */
        function querycomps(){
            $.ajax({
                url : "${prc}/company/companyQuery",
                type : "POST",
                contentType: "application/json;charset=utf-8",
                success : function(result) {
                  if (result == "success") {
                    alert("初始化数据成功.");
                  }
                },
                error:function(msg){
                    alert("初始化数据失败.");
                }
              })
        }
    </script> onload="javascript:querycomps()"-->
</head>
<body >
    
    <div class="container">
        <div class="row">
            <div class="col-sm-3 col-md-3 col-lg-3">
                <a class="btn btn-default" href="${prc}/jsp/company/insertcompany.jsp">+ 新增</a>
            </div>
            <div class="col-sm-3 col-md-3 col-lg-3">
                <form class="navbar-form navbar-left" action="${prc}/company/companyQuery" method="get">
                    <div class="form-group">
                      <input type="text" name="name" class="form-control" placeholder="企业名称" value="${name}">
                    </div>
                    <button type="submit" class="btn btn-default">Search</button>
                </form>
            </div>
        </div>
        <p></p>
        <div class="row">
            <div class="col-sm-12 col-md-12 col-lg-12">
                <div class="panel panel-default">
                  <!-- Default panel contents -->
                  <div class="panel-heading">企业信息列表</div>

                  <!-- Table -->
                  <table class="table table-hover table-bordered table-striped" >
                     <thead>
                        <tr>
                          <th width="3%">
                               <div class="checkbox">
                                    <input id="checkbox1" class="styled" type="checkbox" name="cbAll">
                                </div>
                          </th>
                          <th width="10%">企业代码</th>
                          <th width="17%">企业名称</th>
                          <th width="10%">法人</th>
                          <th width="10%">联系人</th>
                          <th width="15%">联系电话</th>
                          <th width="15%">联系地址</th>
                          <th width="10%">状态</th>
                          <th width="10%">操作</th>
                        </tr>
                      </thead>
                      <tbody>
                      <c:if test="${fn:length(companylist) eq 0}">
                        <tr>
                            <td colspan="9" style="text-align: center">
                                                                                        无结果 !
                            </td>
                        </tr>
                    </c:if>
                    <c:forEach items="${companylist }" var="company" varStatus="companyidex">
                       <tr>
                          <td><input type="checkbox" name="cbox"/></td>
                          <td title="${company.code}">${company.code}</td>
                          <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="${company.name}">${company.name}</td>
                          <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="${company.legalPerson}">${company.legalPerson}</td>
                          <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="${company.linkMan}">${company.linkMan}</td>
                          <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="${company.phone1}">${company.phone1}</td>
                          <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="${company.address}">${company.address}</td>
                          <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="${company.status}">${company.statusCN}</td>
                          <td>
                            &nbsp;&nbsp;
                            <a type="button"  class="btn btn-default btn-xs" href="${prc}/company/getCompanyInfo?fid=${company.fid}">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                            </a>
                            <%-- <button type="button" click="editCompany(${companyidex.index })" class="btn btn-default btn-xs" data-toggle="modal" data-target="#editModal${companyidex.index }">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                            </button> --%>
                            &nbsp;&nbsp;
                            <a type="button" class="btn btn-default btn-xs" href="${prc}/company/deleteCompany?fid=${company.fid}">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                            </a>
                          </td>
                        </tr>

                        <!-- 模态框（Modal） -->
                        <div class="modal fade" id="editModal${companyidex.index }" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                            &times;
                                        </button>
                                        <h4 class="modal-title" id="myModalLabel">
                                            详细信息
                                        </h4>
                                    </div>
                                    <div class="modal-body">

                                          <form class="form-horizontal" role="form" action="${prc }/company/queryConpany" method="post" enctype="multipart/form-data" onsubmit="return submitbtn()">
                                            <div class="form-group">
                                                <label for="name" class="col-sm-3 col-md-3 col-lg-3 control-label">企业名</label>
                                                <div class="col-sm-9 col-md-9 col-lg-9">
                                                    <input type="text" class="form-control" id="name" name="name" value="${company.name }" >
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="address" class="col-sm-3 col-md-3 col-lg-3 control-label">地址</label>
                                                <div class="col-sm-9 col-md-9 col-lg-9">
                                                    <input type="text" class="form-control" name="address" value="${company.address }" id="address" >
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="legalPerson" class="col-sm-3 col-md-3 col-lg-3 control-label">法人</label>
                                                <div class="col-sm-9 col-md-9 col-lg-9">
                                                    <input type="text" class="form-control" name="legalPerson" value="${company.legalPerson }" id="legalPerson" >
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="code" class="col-sm-3 col-md-3 col-lg-3 control-label">企业代号</label>
                                                <div class="col-sm-9 col-md-9 col-lg-9">
                                                    <input type="text" class="form-control" name="code" value="${company.code }" id="code" >
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="phone1" class="col-sm-3 col-md-3 col-lg-3 control-label">联系方式1</label>
                                                <div class="col-sm-9 col-md-9 col-lg-9">
                                                    <input type="text" class="form-control" name="phone1" value="${company.phone1 }" id="phone1" >
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="phone2" class="col-sm-3 col-md-3 col-lg-3 control-label">联系方式2</label>
                                                <div class="col-sm-9 col-md-9 col-lg-9">
                                                    <input type="text" class="form-control" name="phone2" value="${company.phone2 }" id="phone2" >
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="linkMan" class="col-sm-3 col-md-3 col-lg-3 control-label">联系人</label>
                                                <div class="col-sm-9 col-md-9 col-lg-9">
                                                    <input type="text" class="form-control" name="linkMan" value="${company.linkMan }" id="linkMan" >
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="email" class="col-sm-3 col-md-3 col-lg-3 control-label">邮箱地址</label>
                                                <div class="col-sm-9 col-md-9 col-lg-9">
                                                    <input type="text" class="form-control" name="email" value="${company.email }" id="email" >
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="status" class="col-sm-3 col-md-3 col-lg-3 control-label">状态</label>
                                                <div class="col-sm-9 col-md-9 col-lg-9">
                                                    <input type="text" class="form-control" name="status" value="${company.status }" id="status" >
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="summary" class="col-sm-3 col-md-3 col-lg-3 control-label">公司简介</label>
                                                <div class="col-sm-9 col-md-9 col-lg-9">
                                                    <textarea  class="form-control"  name="summary" id="summary" >
                                                        ${company.summary }
                                                    </textarea>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="faxAddress" class="col-sm-3 col-md-3 col-lg-3 control-label">传真地址</label>
                                                <div class="col-sm-9 col-md-9 col-lg-9">
                                                    <input type="text" class="form-control" name="faxAddress" value="${company.faxAddress }" id="faxAddress" >
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="logo" class="col-sm-3 col-md-3 col-lg-3 control-label">公司图标</label>
                                                <div class="col-sm-9 col-md-9 col-lg-9">
                                                    <%--<img alt="logo" src="${prc }${company.logo }">--%>
                                                </div>
                                            </div>

                                        </form>

                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                                        </button>
                                        <button type="button" class="btn btn-primary">
                                            提交更改
                                        </button>
                                    </div>
                                </div><!-- /.modal-content -->
                          </div><!-- /.modal -->
                    </c:forEach>

                      </tbody>
                  </table>
                </div>
            </div>
            <!-- <div class="col-sm-1 col-md-1"></div> -->
        </div>
        <div class="row">
            <div class="col-sm-12 col-md-12 col-lg-12">
                <%--<button type="button" class="btn btn-default btn-xs">
                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
                </button>--%>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12 col-md-12 col-lg-12">
                <div style="" id="kkpager"></div>
            </div>
        </div>
    </div>
    
    
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="${prc }/common/js/jQuery-2.2.0.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="${prc }/common/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script src="${prc }/common/pager/kkpager.min.js"></script>
    <script type="text/javascript">
        $(function(){
            $("#kkpager").html("");
            //生成分页控件
            kkpager.generPageHtml({
                pno : 1,
                mode : 'click', //设置为click模式
                //总页码
                total : Math.ceil(${companyCount/size}),
                //总数据条数
                totalRecords : ${companyCount},
                isShowCurrPage:false,
                isShowTotalRecords:true,
                //点击页码、页码输入框跳转、以及首页、下一页等按钮都会调用click
                //适用于不刷新页面，比如ajax
                click : function(n){
                    //这里可以做自已的处理
                    window.location.href = "${prc }/company/companyQuery?startRow="+n;
                },
                //getHref是在click模式下链接算法，一般不需要配置，默认代码如下
                getHref : function(n){
                    return '#';
                }

            });
            kkpager.selectPage(${pageNum});
        })
    </script>
</body>
</html>