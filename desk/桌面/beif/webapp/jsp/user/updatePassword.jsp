<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="prc" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>修改密码</title>

    <!-- Bootstrap -->
    <link href="${prc }/common/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${prc }/common/lib/dialog/bootstrap-dialog.min.css"/>
    <link href="${prc }/common/css/console.css" rel="stylesheet">
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page attachmentfile:// -->
    <!--[if lt IE 9]>
      <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="${prc }/common/js/respond.min.js"></script>
    <![endif]-->
    <!-- Bootstrap end-->

  </head>
  <body>

	<form class="form-horizontal">
		<div class="row margin-top-3">
            <label class="col-xs-2 text-right control-label">
                <span class="text-danger">*</span><span>密码：</span>
            </label>
            <div class="col-sm-4 row">
                <input class="form-control" type="text" placeholder="请输入密码">
            </div>
            <div class="col-sm-4 form-control-static"></div>
        </div>
        <div class="row margin-top-3">
            <label class="col-xs-2 text-right control-label">
                <span class="text-danger">*</span><span>确认密码：</span>
            </label>
            <div class="col-sm-4 row">
                <input class="form-control" type="text" placeholder="请输入密码">
            </div>
            <div class="col-sm-4 form-control-static"></div>
        </div>
	</form>
	
  </body>
</html>