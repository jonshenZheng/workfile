<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="prc" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
  	<jsp:include page="../common/head_css.jsp"/>
    <title>青岛白泽数据有限公司后台管理系统</title>
    <script>
	    /* 设置iframe的高度 */
	    function SetWinHeight() {
	        var obj = document.getElementById("content");
	        var win = obj;
	        if (win && !window.opera) {
	            if (win.contentDocument && win.contentDocument.body.offsetHeight)
	                win.height = win.contentDocument.body.offsetHeight + 20;
	            else if (win.Document && win.Document.body.scrollHeight)
	                win.height = win.Document.body.scrollHeight + 20;
	        }
	    }
    </script>	
  </head>
  <body class="iframe-left-bg">
  
  	<div class="home-content">
        <header class="clearfix header">
            <div class="fl"><a class="logo"></a></div>
            <nav class="fl clearfix header-nav">
                <ul>
                    <%-- <li><a href="${prc }/jsp/home/index.jsp" class="active" target="content">首页</a></li> --%>
                    <c:forEach items="${permissions}" var="permission">
						<li><a>${permission.name}</a></li>
              		</c:forEach>
                </ul>
            </nav>
            <div class="header-user">
                <div class="mune">
                    <a class="head-user-ico"></a>
                    <ul class="dropdownPane">
                      <li><a>个人中心</a></li>
                      <li><a id="dropdown-update-btn">重置密码</a></li>
                      <li role="separator" class="divider"></li>
                      <li><a href="javascript: location.replace('${prc}/logout')">退出</a></li>
                    </ul>
                </div>
            </div>
        </header>
        <div class="home-warp">
        	<!-- 报价清单 -->
            <div class="clearfix offer-content-box">
                <div class="fl offer-mune">
                    <ul class="offerlist-scroll">
                    	<c:forEach items="${permissions}" var="permission">
							<div class="left_listPane">
	                         	<c:forEach items="${permission.children}" var="Pchildren">
	                        		<a href="${prc}${Pchildren.requestURL}" target="content"><i class="ico-list ${Pchildren.imgURL}"></i><span>${Pchildren.name}</span></a>
	                        	</c:forEach>
		                    </div>    	
              			</c:forEach>
						<!-- <a href="/bzms/html/product/prodLib.html" target="content"><i class="ico-list"></i><span>产品库</span></a> -->
						<a href="/bzms/html/product/auditProd.html" target="content"><i class="ico-list"></i><span>产品审核</span></a>
                        <a href="/bzms/html/product/editProdRecord.html?pid=MSXIXljRnOFeJ2vj4J8aw" target="content"><i class="ico-list"></i><span>产品编辑</span></a>
						<%--<a href="/bzms/jsp/product/addProdRecordSuccess.jsp" target="content"><i class="ico-list"></i><span>cg</span></a>--%>
                        <!-- <a href="" class="active"><i class="ico-list"></i><span>我的清单列表</span></a>
                        <a href=""><i class="ico-addlist"></i><span>创建报价清单</span></a> -->
                    </ul>
                </div>
                <div class="offer-content">
                	<%-- <iframe id="content" src="${prc }/offerList/toListOfferList" name="content" onload="SetWinHeight()" frameborder="0"
                	scrolling="no" style="min-height: 700px;" height="100%" width="100%"></iframe> --%>
                	<iframe id="content" src="" name="content" onload="SetWinHeight()" frameborder="0"
                	scrolling="no" style="min-height: 700px;" height="100%" width="100%"></iframe>
             	</div>
            </div>    
            <!-- 报价清单 -->   
  			
  		</div>
    </div>
    <div class="homeLoadding" id="homeLoadding">
       <img src="${prc }/common/img/loading.gif" alt="加载" />
       <div class="bg"></div>
   	</div>
   	
	<div class="modal fade hone_prodlib_pop hone_prodlib_pop2018" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" style="width:1100px;height:94%;margin-top:auto">
            <div class="modal-content">
            	<div class="prodlib_leftMune_line" id="prodlib_leftMune_line"></div>
                <!-- <div class="modal-header" style="padding: 8px;">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h5 class="modal-title" id="myModalLabel" style="text-align: center">
                        产品库
                    </h5>
                </div> -->
                <div class="modal-body" style="padding: 0px;font-size:0;">
                    <!-- <iframe id="content_prodlib" src="${prc }/jsp/offerlist/productLib.jsp" name="content" frameborder="0"
                            scrolling="no" style="min-height: 780px;" height="100%" width="100%" ></iframe>-->
                    <%-- <iframe id="content_prodlib" src="${prc }/jsp/offerlist/productLib_new.jsp" name="content" frameborder="0"
                   scrolling="no" style="min-height: 94%" height="100%" width="100%" ></iframe> --%>
                   <iframe id="content_prodlib" src="${prc }/customProdType/queryProdType.th" name="content" frameborder="0"
                   scrolling="no" style="min-height: 94%" height="100%" width="100%" ></iframe>
                </div>
           </div>
        </div> 
    </div>
    <!-- 订单记录 -->
    <div class="easyPopBg" id="easyPopBg"></div>
	<div class="orderRecord shadow" id="easyPop">
		<a class="close">x</a>
		<div class="topPan">
			<div class="til">订单情况纪录</div>
			<div class="itembox">
				<!--<div class="item">
					<p class="time">2018-01-08 12:34</p>
					<p class="text"><span class="name">管理员A：</span><span class="sendMsg">桌子不要不锈钢脚的。</span></p>
				</div>-->
			</div>	
		</div>
		<div class="botPan">
			<div id="writePan" class="writePan">
				<textarea name="" id="" cols="30" rows="6" placeholder="请输入订单记录"></textarea>
			</div>
			<div class="btnBox">
				<a class="cancleBtn" id="cancleBtn">关闭</a>
				<a class="trueBtn" id="trueBtn">确定提交</a>
			</div>
		</div>

	</div>
	<!-- 订单记录 -->
	<!-- 更改订单状态 -->
	<div class="changeOrderStatus" id="changeOrderStatus">
		<div class="popBg"></div>
		<div class="cont popshadow">
			<h4 class="til">更改订单状态</h4>
			<form action="">
				<div>
					<span class="lab">订单状态：</span>
					<select name="" id="">
						<!--<option value="">全部</option>
						<option value="">11</option>-->
					</select>	
				</div>
				<div class="tarea">
					<textarea name="" placeholder="请输入更改订单状态的理由.." id=""></textarea>
				</div>
				<div class="btnn">
					<a class="cancle">取消</a><a class="subBtn">提交</a>
				</div>
			</form>
		</div>	
	</div>
	<!-- 更改订单状态 -->
	<!-- 取消订单 -->
	<div class="weixinpop" id="weixinpop">
		<div class="popBg" style="opacity:0.01;filter:alpha(opacity=1)"></div>
		<div class="cont popshadow">
			<h4 class="til">提示</h4>
			<div class="text">真的要取消这张订单吗？</div>
			<div class="btnnBox">
				<a class="cancle">取消</a>
				<a class="subBtn">确定</a>
				<i class="line"></i>
			</div>
		</div>
	</div>
	
	<!-- 取消订单 -->
    <div id="offerListHideVal" data-sereachval=""></div>
    <jsp:include page="../common/footer_js.jsp" />
    <script src="${prc }/common/js/config.js"></script>
    <script type="text/javascript"> 
    
    	/* 取消订单 */
	    var $weixinpop = $('#weixinpop'),
	    	weixinpop_oid,
	    	weixinpop_status,
	    	weixinpop_cb,
			$weixinpop_cancel = $weixinpop.find('.cancle'),
			$weixinpop_subBtn = $weixinpop.find('.subBtn'); 
		
		
		function showWeixinpop(oid,status,cb){
			weixinpop_oid = oid;
	    	weixinpop_status = status;
	    	weixinpop_cb = cb ? cb : function(){};
			$weixinpop.show();
		}
		
		$weixinpop_cancel.click(function(event) {
			hideWeixinpop();
		});
		
		$weixinpop_subBtn.click(function(event) {
			
			var obj = {cancelStatusCode:weixinpop_oid,OrderStatusInfo:weixinpop_status};
			
			$.ajax({
				url: fullPath('mall/order/updateOrderInfo'),
				type : 'PUT',
				data : JSON.stringify(obj),
	            dataType : 'text', //返回值类型 一般设置为json
	            contentType: "application/json; charset=utf-8",
				success : function(r){
					r = JSON.parse(r);
					if(r.meta && r.meta.code === 200){
						alert('取消订单成功');
						hideWeixinpop();
						weixinpop_cb();
					}
					else{
						alert(r.meta.msg);
					}
				},
				error : function() {
					alert('取消订单失败');
				}
			});
			
			
		});
		
		function hideWeixinpop(){
			$weixinpop.hide();
		}
		/* 取消订单 end*/
    
        /* 更改订单状态  */
    	var $changeOrderStatus = $('#changeOrderStatus'),
			$changeOrderStatus_select = $changeOrderStatus.find('select'),
			$changeOrderStatus_textarea = $changeOrderStatus.find('textarea'),
			$changeOrderStatus_false = $changeOrderStatus.find('.cancle'),
			changeOrderStatus_cb,
			changeOrderStatus_str = '',
			changeOrderStatus_orderId = '',
			changeOrderStatus_fromStatus = '',
			$changeOrderStatus_true = $changeOrderStatus.find('.subBtn');
		
		function showChangeOrderStatus(oid,oldStu,optData,cb){
		
			var len = optData.length,
				i = 0;
		
			changeOrderStatus_str = '';
			 
			for(;i<len;i++){
				if(optData[i].disable){
					continue;
				}
				if(optData[i].value === oldStu){
					changeOrderStatus_str +=  '<option selected="true" value="'+optData[i].value+'">'+optData[i].name+'</option>';
				}
				else{
					changeOrderStatus_str +=  '<option value="'+optData[i].value+'">'+optData[i].name+'</option>';	
				}
			} 
	
			$changeOrderStatus_select.html(changeOrderStatus_str);
		
			
		
			//$changeOrderStatus_select.find('option:contains('+oldStu+')').attr('selected','true');
		
			$changeOrderStatus.show();
			
			if(!cb){
				cb = function(a){
					
				};
			}
			
			changeOrderStatus_cb = cb;
			changeOrderStatus_orderId = oid;
			changeOrderStatus_fromStatus = oldStu;
		
		}
		
		function hideChangeOrderStatus(){
			$changeOrderStatus.hide();
			$changeOrderStatus_textarea.val('');
		}
		
		$changeOrderStatus_false.click(function(event) {
			 hideChangeOrderStatus();
		});
		
		$changeOrderStatus_true.click(function(event) {

			var a1 = $changeOrderStatus_select.val(),
				a2 = $changeOrderStatus_textarea.val(),
				a3 = $changeOrderStatus_select.find('option:selected').text(),
				obj;
		
			if(!a2){
				alert('请输入更改订单状态的理由');
				return;
			}	
		
			obj = { orderId : changeOrderStatus_orderId,fromStatus: changeOrderStatus_fromStatus,status: a1,memo:a2 };
			
			$.ajax({
				url: fullPath('mall/order/orderStatusChange'),
				type : 'POST',
				data : JSON.stringify(obj),
	            dataType : 'text', //返回值类型 一般设置为json
	            contentType: "application/json; charset=utf-8",
				success : function(r){
					r = JSON.parse(r);
					if(r.meta && r.meta.code === 200){
						alert('更改订单状态成功');
						hideChangeOrderStatus();
						changeOrderStatus_cb(a3,a1,r.data);
					}
				},
				error : function() {
					alert('更改订单状态失败');
				}
			})
		
		});
		 /* 更改订单状态  */
    
  		//获取搜索内容的值
		var $SereachValBox = $(window.top.document.getElementById('offerListHideVal'));
		
		function getSereachVal(){
			var val = $SereachValBox.data('sereachval');
			return val;
		}
		
		function setSereachVal(nVal){
			$SereachValBox.data('sereachval',nVal);
		}
    
		function showHomeLoading(){
			publicLoadingShow();
		}
		
		function hideHomeLoading(){
			publicLoadingHide();
		}
    
    	var $homeMyModal = $('#myModal'),
    		$saleProdFrame_ifr = document.getElementById('content_prodlib').contentWindow;
    	
    	$homeMyModal.on('shown.bs.modal',function(){
	    	//重新设置高度
	    	document.getElementById('content_prodlib').contentWindow.resetIfrHei();
	    });
    	
    	$homeMyModal.on('hidden.bs.modal',function(){
	    	//重新设置高度
	    	var content_prodlib_js = document.getElementById('content_prodlib').contentWindow;
	    	content_prodlib_js.showCagrage();
	    	content_prodlib_js.resetIfrHei();
	    	$saleProdFrame_ifr.location.reload();
	    });
    
    	/* 打开产品库 */
    	function openProdLibPop(fid,startPage,isReflash,areaId,offerId,replSaleProdId,num){
    		
    		$homeMyModal.modal('show');
    		if(replSaleProdId){
    			$saleProdFrame_ifr.showProdLibMsg(fid,startPage,isReflash,areaId,offerId,replSaleProdId,num);
    		}
    		else{
    			$saleProdFrame_ifr.showProdLibMsg(fid,startPage,isReflash,areaId,offerId);	
    		}
    	}
    	
    	function hideProdLibPop(){
    		$homeMyModal.modal('hide');
    	}
    	
    	
    	
    
	    /*顶部导航点击样式*/
	    var $header_nav_a = $('.header-nav a'),
	    	header_nav_a_len = $header_nav_a.length,
	    	header_nav_a_ind,
	    	$header_nav_a_self;
	    $header_nav_a.on('click',function(){
	      $header_nav_a.removeClass('active');
	      $header_nav_a_self = $(this);
	      $header_nav_a_self.addClass('active');
	      header_nav_a_ind = $header_nav_a_self.parent('').index();
	      $listmunePane.hide();
	      $listmunePane.eq(header_nav_a_ind).show();
	      //触发第一个
	      $listmunePane.eq(header_nav_a_ind).find('a').eq(0)[0].click();
	      
	    });
	    
	    /* 手动设置顶部导航选中样式 */
	    var $listmunePane = $('.offer-mune .offerlist-scroll .left_listPane');
	    if(header_nav_a_len === 1){
	    	$header_nav_a.eq(0).addClass('active');
	    	$listmunePane.eq(0).show();
	    	$listmunePane.eq(0).find('a:eq(0)').addClass('active');
	    	$listmunePane.eq(0).find('a:eq(0)')[0].click();
	    }
	    else{
	    	$header_nav_a.eq(1).addClass('active');
	    	$listmunePane.eq(1).show();
	    	$listmunePane.eq(1).find('a:eq(0)').addClass('active');
	    	$listmunePane.eq(1).find('a:eq(0)')[0].click();
	    }

	    
	   /*  左边菜单点击样式 */
	   var $leftMune_a = $('.offer-mune .offerlist-scroll a');
	   $leftMune_a.on('click',function(){
		   var self = $(this);
		   self.addClass('active').siblings().removeClass('active');
	   });
	   
    
	    /*个人中心展开*/
	    var $UserIco = $('.header-user .head-user-ico'),
	        $userCenterPane = $('.header-user .dropdownPane'),
	        $docJq = $(document);
	
	    $UserIco.on('click',function(e){
	      var e = e || window.event;
	
	      if(e.stopPropagation){
	        e.stopPropagation();
	      }
	      else{
	        e.cancelBubble = true;
	      }
	
	      $userCenterPane.show();
	
	    });    
	
	
	    $docJq.on('click',function(e){
	      if(e.stopPropagation){
	        e.stopPropagation();
	      }
	      else{
	        e.cancelBubble = true;
	      }
	
	      $userCenterPane.hide();  
	
	    });
	    

        window.onresize = function () {
             SetWinHeight();
            };
        
       /*将要废弃*/
       function runIframeFn(fn){
    	   if(Object.prototype.toString.call(fn) === '[object Function]'){
    		   try{
    			   fn();
    		   }
    		   catch(e){
    			   
    		   }  		   
    	   }
       }

       function runHomePublicPop(opt_obj){
    	   if(Object.prototype.toString.call(opt_obj) === '[object Object]'){
    		   PublicPop(opt_obj);
    	   }
       }
       
       /* 修改密码 */
       var $dropdown_update_btn = $('#dropdown-update-btn');      
       $dropdown_update_btn.on('click',function(){
    	   updatePassword();
       });
       
       function updatePassword(){
	   		var tpl_str = '',
	   			opt = {};
	   		
	   		tpl_str += '<form class="form-horizontal">';
	   			tpl_str +='<p style="height:20px;color:red;" class="fontSz-14 textAli-c" id="tempTip"></p>';
	   			tpl_str += '<div class="row">';
	   				tpl_str += '<label class="col-xs-3 text-right control-label">';
	   					tpl_str += '<span class="text-danger">*</span><span>原密码：</span>';
	   				tpl_str += '</label>';
	   				tpl_str += '<div class="col-xs-8 row">';
	   					tpl_str += '<input class="form-control" id="temp-oldPwd" type="password" placeholder="请输入原密码">';
	   				tpl_str += '</div>';
	   			tpl_str += '</div>';
	   			tpl_str += '<div class="row margin-t-16">';
	   				tpl_str += '<label class="col-xs-3 text-right control-label">';
	   					tpl_str += '<span class="text-danger">*</span><span>新密码：</span>';
	   				tpl_str += '</label>';
	   				tpl_str += '<div class="col-sm-8 row">';
	   					tpl_str += '<input class="form-control" id="temp-newPwd" type="password" placeholder="密码由8-16位数字+字符组成">';
	   					tpl_str += '<div class="password_strength" id="password_strength">';
	   						tpl_str += '<div class="pw_bar"></div>';
   							tpl_str += '<div class="pw_letter">';
   								tpl_str += '<span class="tsl" data-phase-id="r_1_8">弱</span>';
   								tpl_str += '<span class="tsl" data-phase-id="r_1_9">中</span>';
   								tpl_str += '<span class="tsl" data-phase-id="r_1_10">强</span>';
   							tpl_str += '</div>';
	   					tpl_str += '</div>';
	   				tpl_str += '</div>';
	   			tpl_str += '</div>';
	   		tpl_str += '<div class="row margin-t-16">';
   				tpl_str += '<label class="col-xs-3 text-right control-label">';
   					tpl_str += '<span class="text-danger">*</span><span>确认密码：</span>';
   				tpl_str += '</label>';
   				tpl_str += '<div class="col-sm-8 row">';
   					tpl_str += '<input class="form-control" id="temp-RenewPwd" type="password" placeholder="确认密码">';
   				tpl_str += '</div>';
   			tpl_str += '</div>';
	   			tpl_str +='<div class="form-conmit-btn textAli-r margin-t-16"><a class="btn btn-primary" STYLE="margin-right: 10px;" id="tempTrueBtn">确认</a><a id="tempFalseBtn" class="btn btn-default btn-fasle">取消</a></div>';	   			
	   		tpl_str += '</form>';
	   		
	   		opt.til = '重置密码';
	   		opt.tpls = tpl_str;
	   		opt.btnNum = 0;
			opt.ready = function(Pop_self_obj){
	   			
	   			var uId = '${user.fid}',
	   				account = '${user.account}',
	   				oldPwd,
	   				newPwd,
	   				reNewPwd,
	   				$password_strength = $('#password_strength .pw_bar'),
	   				$oldPwd = $("#temp-oldPwd"),
	   				$newPwd = $('#temp-newPwd'),
	   				$reNewPwd = $('#temp-RenewPwd'),
	   				$tempTip = $('#tempTip'),
	   				$tempTrueBtn = $('#tempTrueBtn'),
	   				$tempFalseBtn = $('#tempFalseBtn'),
	   				pwd_power;
	   				
	   			function passwordFn(val){
	   				return publicRegx.password.test(val);
	   			}
	   			
	   			function checkPassword(val){
	   				if(val.length < 8){
	   					$tempTip.html('新密码的长度至少要8位');
	   					return false;
	   				}
	   				if(val.length > 16){
	   					$tempTip.html('新密码的长度不能超过16位');
	   					return false;
	   				}
	   				
	   				if(!passwordFn(val)){
	   					$tempTip.html('密码不能为纯数字或纯英文');
	   					return false;
	   				}
	   				$tempTip.html('');
	   				return true;	   				
	   			}
	   			
	   			$newPwd.bind('input propertychange',function(){
	   				var val = $newPwd.val(),
	   					ccc;
	   				ccc = ckeckPwd_checkStrong(val);
					switch(ccc){
						case 0: $password_strength.css({'width':'0px','background':'#FF0000'});
						case 1: $password_strength.css({'width':'70px','background':'#FF0000'});
						break;
						case 2: $password_strength.css({'width':'141px','background':'#FF9900'});
						break;
						case 3: $password_strength.css({'width':'212px','background':'#33CC00'});
						break;
						default: $password_strength.css({'width':'212px','background':'#33CC00'});
					}
	   			});
	   				
	   			$newPwd.blur(function(){
	   				var val = $newPwd.val();
	   				checkPassword(val);
	   			});
	
	   			$tempFalseBtn.click(function(){
	   				Pop_self_obj.close();
	   			});
	   						
	   			$tempTrueBtn.click(function(){	   				
	   				
	   				oldPwd = $oldPwd.val();
	   				newPwd = $newPwd.val();
	   				reNewPwd = $reNewPwd.val();
	   				
	   				if(!oldPwd){
	   					$tempTip.html('请输入原密码');
	   					return;
	   				}
	   				
	   				if(!newPwd){
	   					$tempTip.html('请输入新密码');
	   					return;
	   				}
	   				
	   				if(oldPwd === newPwd){
	   					$tempTip.html('新密码不能与原密码一致');
	   					return;
	   				}
	   				
	   				if(!reNewPwd){
	   					$tempTip.html('请输入确认密码');
	   					return;
	   				}
	   				
	   				if(newPwd !== reNewPwd){
	   					$tempTip.html('新密码与确认密码不一致');
	   					return;
	   				}
	   				
	   				if(!checkPassword(newPwd)){
	   					return;
	   				}
	   					   				
	   				$.ajax({
   		               type: "post",
   		               url:"${prc }/user/resetPwd",
   		               data : {"userId":uId,"account":account,"oldPwd":oldPwd,"newPwd":newPwd},
   		               dataType:"text",
   		               contentType: "application/x-www-form-urlencoded; charset=utf-8",
   		               success: function(result) {
   		            	   
   		            	   if("false" == result){	   		       
   								alert("原密码错误");		            		   
   		            	   }else if("true" == result){
   		            		   Pop_self_obj.close();
   		               			alert('重置密码成功');
   		            	   }
   		               }
	   		         }); 
	   				
	   			});	
	   			
	   		};
	   		runHomePublicPop(opt);
	   	}
       
       publicLoadingHide();

       var contIframe = document.getElementById('content');
       function changeIframeHeiFur(hei){
    	   var furIframe = contIframe.contentWindow.document.getElementById('saleProdFrame'),
    	   	   heiTem= hei+300;
    	   
    	   if(hei < 596){
    		   heiTem = 900;
    	   }
    	   
    	   furIframe.height = hei+50;
    	   contIframe.height = heiTem;
       }
       
       function runFnInHome(fnName,parm){
    	   var returnVal,
    	   	   temp;
    	   if(fnName){
    		   try{
    			   
    			   if(parm.handerType === 'variable'){
    				   
    				   temp = fnName.split('.');
    				   
    				   returnVal = window[temp[0]][temp[1]](parm);
    			   }
    			   else{
    				   returnVal = window[fnName](parm);   
    			   }
    			   
    			   
    			   //非异步回掉
    			   if(parm.cb && typeof parm.cb === 'function'){
    				   parm.cb(returnVal);
    			   }
    			   return returnVal;	   
    		   }
    		   catch(e){
    			   console.log(e);
    		   }
    		   
    	   }
    	   
       }
       
       /*自适应调整centent高度*/
       var device_info = {
			screen_width : 0,
			screen_height: 0
       }
       
       /* 框架一些基础信息 */
       var iframeHomeInfo = {
    		   
       }
       
       function ajustCententHei(hei){
    	   
       }
       
       
       

    </script>
  </body>
</html>