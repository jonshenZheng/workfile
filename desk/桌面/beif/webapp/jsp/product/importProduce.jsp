<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="prc" value="${pageContext.request.contextPath}"/>
<html>
<script src="${prc }/common/js/jquery-1.12.4.min.js"></script>
<script src="${prc }/common/js/ajaxfileupload.js"></script>
<head>
    <title>导入excel</title>
    <style>

            *{margin:0;padding:0;}
			
			body{padding-bottom:100px}
            h3{padding:30px 0;text-align: center;font-size: 36px;font-weight: normal;}
            .statusBox,.statusBox2{padding:20px 0;text-align: center;}
            .statusBox span,.statusBox2 span{display:inline-block;width:100px;color: #ddd;font-size: 24px;}
            .statusBox span.active,.statusBox2 span.active{
                color:#333;
            }

            form{
                padding:20px 0;
                text-align: center;
            }

            a{text-decoration: none;cursor: pointer;}

            .resultBox{
                display:none;
                width:800px;
                border:1px solid #ddd;
                border-radius: 5px;
                margin: 0 auto;
            }

            .resultBox .msg{
                padding: 10px;
                font-size: 16px;
                line-height: 20px;
                color:#333;
            }

            .resultBox p span{
                display:inline-block;
                vertical-align: top;
            }

            .resultBox .til{
                width:90px;
            }

            .resultBox .til +span{
                width:600px;
            }

            .download{
                text-align: right;
                border-bottom: 1px solid #ddd;
                padding-right: 10px;
            }

            .download a{
                display:inline-block;
                height:36px;
                line-height: 36px;
                padding:0 20px;
                background-color: #337ab7;
                font-size: 18px;
                color:#fff;
                border-radius: 6px;
                display:none;
            }
            .download a:hover,.btnBox .bton:hover{
                background-color: #286090;
            }

            .btnBox{text-align: center;padding-top: 20px;}
            .btnBox .bton{
                display:inline-block;
                height:36px;
                line-height: 36px;
                padding:0 20px;
                background-color: #337ab7;
                font-size: 18px;
                color:#fff;
                border-radius: 6px;
            }

			.homeLoadding{display:none;position:fixed;left:0;top: 0;width:100%;height:100%;z-index:1150}
			.homeLoadding .bg{position:absolute;left:0;top:0;width:100%;height:100%;filter:alpha(opacity=15);background: #000;opacity: 0.15;}
			.homeLoadding img{width:32px;height:32px;position:absolute;left:50%;top:50%;margin:-16px 0 0 -16px;}
			
			.fengeline{margin:60px auto;width:80%;border-top:3px solid #ddd}
			
			.form2 .lab, .form2 .lab+input{vertical:middle;}
			.form2 .lab{display:inline-block;width:90px;text-align:left;}
			
			.cont2{width:290px;margin:0 auto;padding-right:40px;position:relative;}
			.cont2 .mapImgBtn{position: absolute;
			    top: 0;
			    right: 0;
			    width: 44px;
			    height: 46px;
			    line-height: 22px;
			    font-size: 16px;
			    border-radius: 6px;
			    background-color: #337ab7;
			    color: #fff;
			    padding: 2px;
			 }
			.cont2 .mapImgBtn:hover{background-color:#286090}
        </style>
</head>
<body>

	<h3>上传Excel</h3>
    <div class="statusBox">
        <span class="sp1 active">上传</span>
        <span class="sp1 active">--&gt;</span>
        <span class="sp2">验证</span>
        <span class="sp2">--&gt;</span>
        <span class="sp3">导数</span>
        <span class="sp3">--&gt;</span>
        <span class="sp4">上传结果</span>
    </div>
    <div class="resultBox" id="resultBox">
        <div class="download">
            <a href="" target="_blank" download rel="noopener">下载</a>
        </div>
        <div class="msg"></div>
    </div>
    <div class="btnBox" id="btnBox">
    </div>
	<form  id="form" action="http://192.168.0.111:5000/recognize" method="post" enctype="multipart/form-data" >
		<div id="picTip" style="height:40px"></div>
		<input type="file" name="file" id="file" />
		<input type="button" onclick="submitPic(1);" value="提交" />
	</form>

	<div class="fengeline"></div>


	<h3>上传压缩包</h3>
    <div class="statusBox2">
        <span class="sp1 active">上传</span>
        <span class="sp1 active">--&gt;</span>
        <span class="sp2">解压</span>
        <span class="sp2">--&gt;</span>
        <span class="sp3">关联图片</span>
        <span class="sp3">--&gt;</span>
        <span class="sp4">结果</span>
    </div>
    <div class="resultBox" id="resultBox2">
        <div class="msg"></div>
    </div>
    <div class="btnBox" id="btnBox2">
    </div>
	<form  id="form2" class="form2" action="http://192.168.0.111:5000/recognize" method="post" enctype="multipart/form-data" >
		
		<div class="cont2">
			<!--<p>
				<span class="lab">销售企业：</span><input type="text" name="sellCompany" id="sellCompany" value="青岛白泽数据有限公司"/>
			</p>
			<p>
				<span class="lab">厂家：</span><input type="text" name="factoryCompany" id="factoryCompany" value="白泽华旦"/>
			</p>-->
			<p>
				<span class="lab">销售企业：</span><input type="text" name="sellCompany" id="sellCompany"/>
			</p>
			<p>
				<span class="lab">厂家：</span><input type="text" name="factoryCompany" id="factoryCompany"/>
			</p>
			<a class="mapImgBtn" id="mapImgBtn" >直接关联</a>
		</div>
		

		<div id="picTip2" style="height:40px"></div>
		<input type="file" name="picZip" id="picZip" />
		<input type="button" onclick="submitPic(2);" value="提交" />
	</form>










<!-- 上传窗口 -->
    <!--<div id="uploadPicWindow" class="easyui-window" title="上传excel文件"  style="width:420px;height:220px;padding:20px;background:#fafafa;" data-options="iconCls:'icon-save',closable:true, collapsible:true,minimizable:true,maximizable:true">
    <form id="picForm" action="" method="post">
        <div style="margin-bottom:20px">
            文件名称:
            <input type="text" name="name" id="picName" class="easyui-textbox" style="width:80%" data-options="required:true,validType:'stringCheck'"/>
        </div>
        <br/>
        <div style="margin-bottom:20px">
            上传文件:
            <input type="file" name="file" id="file" data-options="prompt:'Choose a file...'" style="width:80%"/>
        </div>
        <div id="picTip"></div>
        <div id="formWindowfooterPic1" style="padding:5px;text-align:right;">
            <a href="#" onclick="submitPic();" class="easyui-linkbutton" data-options="iconCls:'icon-save'">提交</a>
        </div>
    </form>
</div>-->
	<div class="homeLoadding" id="homeLoadding">
       <img src="${prc }/common/img/loading.gif" alt="加载" />
       <div class="bg"></div>
   	</div>
</body>

<script>

	function publicLoadingShow(){
	    $honeLoading.show();
	}
	
	function publicLoadingHide(){
	    $honeLoading.hide();
	}

	function nextStep(f){
		
		var c = confirm('是否要删除之前的数据');
		
		c = c ? 1 : 0;
		publicLoadingShow();
		$btn.hide();
		$sp3.addClass('active');
		step++;
		
		$.ajax({
			type : 'POST',
			url : '${prc}/product/import/'+f+'/'+c,
            //url : '/import/'+f+c{fileId}/{chearData}',
            success : function(r){
            	if(r.meta && r.meta.code ==200){
            		uploadSuccess(r.data);	
            	}
            	else{
            		alert(r.meta.msg);
            	}
            	
            },
            error : function(){
                alert('查询结果失败');
            },
            complete : function(){
            	publicLoadingHide();
            }
        });
	}


	var $honeLoading = $('#homeLoadding'),
		logUrl,
		step = 1,
		$form = $('#form'),
		$sp2 = $('.statusBox .sp2'),
		$sp3 = $('.statusBox .sp3'),
		$sp4 = $('.statusBox .sp4'),
		$resultBox = $('#resultBox'),
		$btn = $resultBox.find('.download a'),
		$btnBox = $('#btnBox'),
		$msg = $resultBox.find('.msg'),
		fileId,
		chearData,
		$sellCompany = $('#sellCompany'),
		$factoryCompany = $('#factoryCompany');
	
	//上传成功
	function uploadSuccess(data){
	
		$form.hide();
		
		$resultBox.show();
		
		var text,a1,a2,a3,a4,a5,temp;
		
		step++;
		
		text = '';	    
	    a1 = data.sellCompany ? data.sellCompany : '';
	    a2 = data.factoryCompany ? data.factoryCompany : '';
	    a3 = data.errorMsg ? data.errorMsg : '';
	    a4 = data.warnMsg ? data.warnMsg : '';
	    a5 = data.result ? data.result : '';
	    
	    text += '<p><span class="til">销售企业：</span><span>'+a1+'</span></p>';
	    text += '<p><span class="til">厂家：</span><span>'+a2+'</span></p>';
	    text += '<p><span class="til">错误日志：</span><span>'+a3+'</span></p>';
	    text += '<p><span class="til">警告信息：</span><span>'+a4+'</span></p>';
		
		if(step === 2){
		    
		    $sellCompany.val(a1);
		    $factoryCompany.val(a2);
		    		  
		    if(data.success){
		    	temp = '<a class="bton" onclick="nextStep(\''+fileId+'\')">下一步</a>';
		    }
		    else{
		    	temp = '<a class="bton" href="javascript:window.location.reload()" ">上一步</a>';
		    }
		    
		    $btnBox.html(temp);		 
		}
		else if(step === 4){
			$btnBox.html('');	
		    $sp4.addClass('active');
		    text += '<p><span class="til">上传结果：</span><span>'+a5+'</span></p>';
		}

		if(data.logPath){
			logUrl = data.logPath;
		    $btn.attr('href','${prc}'+data.logPath);
		    $btn.html('下载日志');
		    $btn.show();
		}
		else{
		    $btn.hide();
		}
		
		$msg.html(text);
	
	}    

    //新建或编辑 保存提交
    function submitPic(type){
    	
    	var f,
    		$tip,
    		tipText,
    		extname,
    		fn;
    	
    	//上传EXCEL
    	if(type === 1){
    		f = $("#file").val();
    		$tip = $("#picTip");
    		tipText = '只支持excel格式！';
    		fn = ajaxFileUploadPic;
    	}
    	else if(type === 2){
    		f = $("#picZip").val();
    		$tip = $("#picTip2");
    		tipText = '只支持zip、rar格式！';
    		fn = ajaxFileUploadPic2;
    		
    		if(!$sellCompany.val()){
    			alert('销售企业不能为空');
    			return;
    		}
    		if(!$factoryCompany.val()){
    			alert('厂家不能为空');
    			return;
    		}
    		
    	}

        if(f==null||f==""){
        	$tip.html("<span style='color:Red'>错误提示:上传文件不能为空,请重新选择文件</span>");
            return false;
        }
        

        extname = f.substring(f.lastIndexOf(".")+1,f.length);
        
        extname = extname.toLowerCase();//处理了大小写
        
        if( (extname!= "xls"&&extname!= "xlsx") && type === 1 ){
        	$tip.html("<span style='color:Red'>错误提示:格式不正确,"+tipText+"</span>");
            return false;
        }
        
        if( (extname!= "zip"&&extname!= "rar") && type === 2 ){
        	$tip.html("<span style='color:Red'>错误提示:格式不正确,"+tipText+"</span>");
            return false;
        }
        
        /*var file = document.getElementById("file").files;
        var size = file[0].size;*/
        publicLoadingShow();
        //ajaxFileUploadPic();
        fn();
    }
    
    //上传EXCEL
    function ajaxFileUploadPic() {
        $.ajaxFileUpload({
            url : '${prc}/product/upload', //用于文件上传的服务器端请求地址
            secureuri : false, //一般设置为false
            fileElementId : '#file', //文件上传空间的id属性  <input type="file" id="file" name="file" />
            type : 'POST',
            dataType : 'application/json', //返回值类型 一般设置为json
            contentType: "application/json; charset=utf-8",
            success : function(data, status) //服务器成功响应处理函数
            {
                var res,
                    reg = /^<pre.+?>/g,
                    datas,
                    dataInd;
                dataInd = data.indexOf('{');
                res = data.slice(dataInd,-6);
                datas = JSON.parse(res);
                if(datas.meta.code!=200){
                    alert(datas.meta.msg);
                    return;
                }
                
                fileId = datas.data;
                $sp2.addClass('active');
                $.ajax({
            		url : '${prc}/product/check/'+fileId,
            		success : function(r){
            			if(r.meta && r.meta.code ==200){
            				uploadSuccess(r.data);	
            			}
            			else{
            				alert(r.meta.msg);
            			}
            		},
            		error : function(){
            			alert('查询验证失败');
            		},
                    complete : function(){
                    	publicLoadingHide();
                    }
            	});

            },
            error : function(data, status, e)//服务器响应失败处理函数
            {
            	publicLoadingHide();
            	alert(data.msg);
            }
        });
        return false;
    }
        
        
    var $form2 = $('#form2'),
		$sp2_2 = $('.statusBox2 .sp2'),
		$sp2_3 = $('.statusBox2 .sp3'),
		$sp2_4 = $('.statusBox2 .sp4'),
		$resultBox2 = $('#resultBox2'),
		$btnBox2 = $('#btnBox2'),
		$msg2 = $resultBox2.find('.msg'),
		zipId;    
    

    //上传压缩包    
    function ajaxFileUploadPic2() {
        $.ajaxFileUpload({
            url : '${prc}/product/uploadPicZip', //用于文件上传的服务器端请求地址
            secureuri : false, //一般设置为false
            fileElementId : '#picZip', //文件上传空间的id属性  <input type="file" id="file" name="file" />
            type : 'POST',
            dataType : 'application/json', //返回值类型 一般设置为json
            contentType: "application/json; charset=utf-8",
            success : function(data, status) //服务器成功响应处理函数
            {
            	        
            	var res,
                    reg = /^<pre.+?>/g,
                    datas,
                    dataInd,
                    obj;
                dataInd = data.indexOf('{');
                res = data.slice(dataInd,-6);
                datas = JSON.parse(res);
                if(datas.meta.code!=200){
                    alert(datas.meta.msg);
                    return;
                }
                
                $form2.hide();
                obj = { sellCompany : $sellCompany.val(),zipId : datas.data};
                
                $sp2_2.addClass('active');
                
                $.ajax({
            		url : '${prc}/product/unzip',
            		type : 'POST',
            		data : JSON.stringify(obj),
            		contentType: "application/json; charset=utf-8",
            		success : function(r){
            			if(r.meta && r.meta.code ==200){
            				
            				$sp2_3.addClass('active');
            				
            				obj = {sellCompany: $sellCompany.val(),factoryCompany:$factoryCompany.val()};
            				
            				$.ajax({
            					url : '${prc}/product/refPic',
            					type : 'POST',
            					contentType: "application/json; charset=utf-8",
            					data : JSON.stringify(obj),
            					success : function(r){          						
            						$resultBox2.show();
            						$sp2_4.addClass('active');
            						$msg2.html('<h4 style="text-align:center">关联成功</h4>');
            					},
            					complete : function(){
            						publicLoadingHide();
            					}
            					
            				});
            				
            			}
            			else{
            				alert(r.meta.msg);
            			}
            		},
            		error : function(){
            			publicLoadingHide();          
            			alert('查询解压缩失败');
            		}
            	});

            },
            error : function(data, status, e)//服务器响应失败处理函数
            {
            	publicLoadingHide();
            	alert(data.msg);
            }
        });
        return false;
    }
        
    //直接关联图片
    var $mapImgBtn = $('#mapImgBtn');
    
    $mapImgBtn.click(function(){
    	mapImgFn();
    });  
    
    function mapImgFn(){
    	if(!$sellCompany.val()){
			alert('销售企业不能为空');
			return;
		}
		if(!$factoryCompany.val()){
			alert('厂家不能为空');
			return;
		}
		
		$sp2_2.addClass('active');
		$sp2_3.addClass('active');
		
		publicLoadingShow();
		
		var obj = {sellCompany: $sellCompany.val(),factoryCompany:$factoryCompany.val()};
		
		$.ajax({
			url : '${prc}/product/refPic',
			type : 'POST',
			contentType: "application/json; charset=utf-8",
			data : JSON.stringify(obj),
			success : function(r){
				$form2.hide();
				$resultBox2.show();
				$sp2_4.addClass('active');
				$msg2.html('<h4 style="text-align:center;line-height:100px">关联成功</h4>');
			},
			complete : function(){
				publicLoadingHide();
			}
			
		});
		
    }
        

    
</script>
</html>
