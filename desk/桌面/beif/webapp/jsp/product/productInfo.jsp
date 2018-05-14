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
        <div class="col-sm-12 col-md-12 col-lg-12">
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class = "form-group">
                        <label class="col-sm-1 col-md-1 col-lg-1 control-label">产品名称</label>
                        <div class="col-sm-2 col-md-2 col-lg-2">
                            <span>${produce.produceName}</span>
                        </div>
                    </div>
                    <br/>
                    <div class = "form-group">
                        <label class="col-sm-1 col-md-1 col-lg-1 control-label">产品型号</label>
                        <div class="col-sm-2 col-md-2 col-lg-2">
                            <span>${produce.modelNo}</span>
                        </div>
                    </div>
                    <br/>
                    <div class = "form-group">
                        <label class="col-sm-1 col-md-1 col-lg-1 control-label">状态</label>
                        <div class="col-sm-2 col-md-2 col-lg-2">
                            <span>
                                <%--由于后台是字符类型,1的字符编码--%>
                                <c:if test="${produce.status == 49}">有效</c:if>
                                <c:if test="${produce.status == 48}">无效</c:if>
                            </span>
                        </div>
                    </div>
                    <br/>
                    <div class = "form-group">
                        <label class="col-sm-1 col-md-1 col-lg-1 control-label">创建时间</label>
                        <div class="col-sm-2 col-md-2 col-lg-2">
                            <span><fmt:formatDate value="${produce.createTime}" pattern="yyyy-MM-dd" /></span>
                        </div>
                    </div>
                    <br/>
                    <div class = "form-group">
                        <label class="col-sm-1 col-md-1 col-lg-1 control-label">产品类型</label>
                        <div class="col-sm-2 col-md-2 col-lg-2">
                            <span>${produce.proTypeBean.name}</span>
                        </div>
                    </div>
                    <br/>
                    <div class = "form-group">
                        <label class="col-sm-1 col-md-1 col-lg-1 control-label">企业</label>
                        <div class="col-sm-2 col-md-2 col-lg-2">
                            <span>${produce.companyBean.name}</span>
                        </div>
                    </div>
                    <br/>
                    <div class = "form-group">
                        <label class="col-sm-1 col-md-1 col-lg-1 control-label">产品风格</label>
                        <div class="col-sm-2 col-md-2 col-lg-2">
                            <c:forEach items="${prodDesignList}" var="prodesign" >
                                <p>${prodesign.designId}</p>
                            </c:forEach>
                        </div>
                    </div>
                    
                    <br/>
                    <div class = "form-group">
                        <%--<label class="col-sm-1 col-md-1 col-lg-1 control-label"></label>--%>
                        <div class="col-sm-12 col-md-12 col-lg-12">
                            <table class="table table-hover table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th width="10%">序号</th>
                                        <th width="17%">数量</th>
                                        <th width="17%">成本(元)</th>
                                        <th width="17%">属性</th>
                                        <th width="17%">标签</th>
                                        <th width="20%">产品描述</th>
                                        <th width="17%">创建时间</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${produceSKUs}" var="prodsku" varStatus="prodskuindex">
                                        <tr>
                                            <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;">${prodskuindex.index +1}</td>
                                            <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="${prodsku.count}">${prodsku.count}</td>
                                            <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="${prodsku.price}">${prodsku.price}</td>
                                            <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="${prodsku.propertiesValues}">${prodsku.propertiesValues}</td>
                                            <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="${prodsku.label}">${prodsku.label}</td>
                                            <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="${prodsku.memo}">${prodsku.memo}</td>
                                            <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;" title="<fmt:formatDate value="${prodsku.createDate}" pattern="yyyy-MM-dd" />"><fmt:formatDate value="${prodsku.createDate}" pattern="yyyy-MM-dd" /></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../common/footer_js.jsp" />
</body>
</html>
