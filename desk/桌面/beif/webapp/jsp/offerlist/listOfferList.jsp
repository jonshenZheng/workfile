<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="prc" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
	<jsp:include page="../common/head_css.jsp"/>
    <%-- <link href="${prc }/common/css/awesome-bootstrap-checkbox.css" rel="stylesheet">
    <link rel="stylesheet" href="${prc }/common/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="${prc }/common/css/build.css"/>
    <link rel="stylesheet" href="${prc }/common/pager/kkpager_blue.css"/> --%>
    <!-- Bootstrap end-->
   
    
</head>
<body class="offer-mylist-content-box" style="background-color:#f0f2f8;">

	<div class="tilbox">
      <h3 class="page-til">我的清单列表</h3>  
      <div class="sereachBox">
      	<form action="${prc }/offerList/toListOfferList" method="get" id="sereachFlistForm">
	        <input type="text" class="baseInp" placeholder="快速搜索清单" name="offerListname"/>
	        <i class="ico"></i>
	    </form>
      </div>
    </div>
    
    <div class="cont">
        <form action="">
            <table class="table" style="table-layout:fixed">
              <thead>
                <tr>
                    <th width="25%" align="center">清单名称</th>
                    <th width="155px" align="center">最后修改时间</th>
                    <th width="88px" align="center">状态</th>
                    <th width="120px" align="center">操作</th>
                    <th width="40%" align="center">备注</th>
                </tr>
              </thead>
              <tbody>
              	<c:if test="${fn:length(offers) eq 0}">
           <tr>
               <td colspan="5" style="text-align: center">
                  		 无结果 !
               </td>
           </tr>
       </c:if>
       <c:forEach items="${offers}" var="offer" varStatus="offerIndex">
     			<tr>
            <td>
                      <div class="wp"><a href="${prc}/offerList/toOfferListDetail?offerId=${offer.fid}"> ${offer.name}</a></div>
                  </td>
            <td>
                      <div class="wp"><fmt:formatDate value="${offer.createDate}" pattern="yyyy-MM-dd HH:mm" /></div>
                  </td>
            <td>
                      <div class="wp">${offer.statusName}</div>
                  </td>
                  <td>
                      <div class="wp">
                        <%-- <a class="handle-btn del" onclick="deleteCurrentOffer('${offer.fid}');"></a>
                        <a class="handle-btn export" href="javascript:exportExcel('${offer.fid}');"></a> --%>
                        <a class="handle-btn" onclick="deleteCurrentOffer('${offer.fid}');">删除</a>
                        <a class="handle-btn" href="javascript:exportExcel('${offer.fid}');">导出</a>
                      </div>
                  </td>
                  <td>
                      <div class="wp">${offer.remark }</div>
                  </td>
        </tr>	
     		</c:forEach>	
              </tbody>
            </table>

        </form>

        <div class="iframe-pagingBox padding-l-20 padding-r-20 clearfix">        
            <div class="pageing" id="kkpager">  
            </div>
        </div>

    </div>



<jsp:include page="../common/footer_js.jsp" />
<script src="${prc }/common/js/kkpager.js"></script>
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
            total : Math.ceil(${offersCount/size}),
            //总数据条数
            totalRecords : ${offersCount},
            isShowCurrPage:false,
            isShowGoPageNum: false,
            isShowTotalRecords:true,
            //点击页码、页码输入框跳转、以及首页、下一页等按钮都会调用click
            //适用于不刷新页面，比如ajax
            click : function(n){
                //这里可以做自已的处理
                
                var sVal = window.top.getSereachVal();
                
                window.location.href = "${prc }/offerList/toListOfferList?startRow="+n+"&offerListname="+sVal;
                //处理完后可以手动条用selectPage进行页码选中切换
                //this.selectPage(n);
            },
            //getHref是在click模式下链接算法，一般不需要配置，默认代码如下
            getHref : function(n){
                return '#';
            },
            isShowTotalRecords : false,
            lang				: {
    			firstPageText			: '',
    			firstPageTipText		: '',
    			lastPageText			: '',
    			lastPageTipText			: '',
    			prePageText				: '',
    			prePageTipText			: '',
    			nextPageText			: '',
    			nextPageTipText			: '',
    			totalPageBeforeText		: '共',
    			totalPageAfterText		: '页',
    			currPageBeforeText		: '当前第',
    			currPageAfterText		: '页',
    			totalInfoSplitStr		: '/',
    			totalRecordsBeforeText	: '共',
    			totalRecordsAfterText	: '条数据',
    			gopageBeforeText		: ' 到',
    			gopageButtonOkText		: '确定',
    			gopageAfterText			: '页',
    			buttonTipBeforeText		: '第',
    			buttonTipAfterText		: '页'
    		}

        });
        kkpager.selectPage(${pageNum});
    });
    
    //导出excel
    function exportExcel(offerId){
        $.ajax({
            type: "GET",
            async:false,
            url:"${prc}/offerList/doValidateOfferExcel",
            data:"offerListId="+offerId,
            beforeSend: function () {
                // 禁用按钮防止重复提交，发送前响应
                $(".exportExcelbtn").attr({ disabled: "disabled" });
            },
            success: function(result) {
                if("false" == result){
                    alert("没有设置报价单，请设置报价！");
                }else{
                    window.location.href = "${prc}/offerList/downloadExcel?offerListId="+offerId;
                }
            },
            complete: function () {//完成响应
                $(".exportExcelbtn").removeAttr("disabled");
            },
            error: function(err) {
                alert("导出失败!");
            }
        });
    }
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
    function deleteCurrentOffer(offerId){
        var isDelete=confirm("确定要删除吗？");
        if(isDelete)
        {
            window.location.href = "${prc}/offerList/doDeleteOfferList?offerId="+offerId;
        }
    }
    
    //搜索清单
    var $sereachList_form = $('#sereachFlistForm'),
    	$sereachList_inp = $sereachList_form.find( 'input[name="offerListname"]' ),
    	$sereachList_btn = $sereachList_form.find('.ico');
    
    $sereachList_inp.on('keydown',function(e){
    	var e = e || window.event;
    	
    	if(e.keyCode === 13){
    		if(e.preventDefault){
        		e.preventDefault()
        	}
        	else{
        		e.cancelable = true;
        	}
    		sereachListSubmit();
    	}
    	
    });
    
    $sereachList_btn.on('click',function(){
    	sereachListSubmit();
    });
    
    function sereachListSubmit(){
		var val = $sereachList_inp.val();
    	if(!val){
    		/* alert('请输入搜索内容');
    		return; */
    		val = '';
    	}
    	window.top.setSereachVal(val);
    	$sereachList_form.submit();
    }
    
    
    
    
</script>
</body>
</html>
