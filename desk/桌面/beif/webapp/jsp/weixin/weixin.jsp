<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="prc" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<meta charset="utf-8" />
	<title>申请服务</title>
	<!-- 优先使用 IE 最新版本和 Chrome -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	
	<!-- 开启响应式 -->
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
	
	<!-- SEO页面关键词 -->
	<meta name="keywords" content="">
	
	<!-- SEO页面描述 -->
	<meta name="description" content="">
	<link rel="stylesheet" type="text/css" href="${prc }/common/lib/mobileSelect.js/css/mobileSelect.css"> 
	<script>
		function setRem(){
			var windowWid = window.screen.width > 640 ? 640 : window.screen.width,
			 	htmlSz =   windowWid/320*625+'%';
			document.getElementsByTagName('html')[0].style.fontSize = htmlSz;
		}
		setRem();
	</script>
	<style>

		body,h1,h2,h3,h4,h5,h6,dl,dd,ul,ol,pre,p,ul{margin: 0}
		ul{list-style: none}
		ol,ul{padding-left: 0}
		th,td,option{padding: 0}
		img{border:0;}

		input[type="submit"],input[type="button"],button{cursor:pointer;padding:0;}
		input[type="text"],input[type="email"],input[type="number"],input[type="password"]{padding:0 0 0 5px;}
		:focus,input,select,textarea,button{outline:none;}
		textarea{resize:none}

		a{text-decoration: none;color: #000;outline:none;cursor:pointer;}

		article,aside,details,figcaption,figure,footer,header,hgroup,menu,nav,section{display:block}
		.clearfix:after{visibility:hidden;display:block;font-size:0;content:" ";clear:both;height:0;}
		.clearfix{*zoom:1;}

		html{font-size: 625%;}

		body{font-size: 0.1rem;background-color: #f0f2f5;}

		.uploadimg{margin:.1rem;}
		.uploadimg .imgarea{border:1px dashed #ccc;position: relative;height:1.5rem;background-color: #fff;overflow:hidden;}
		.uploadimg .imgarea .cio{position:absolute;left:50%;top:50%;text-align: center;width:.9rem;height:.45rem;margin:-.225rem 0 0 -.45rem;font-size: .1rem;}
		.uploadimg .imgarea .icoBox{display:block;position:relative;height:0.14rem;width:0.14rem;margin: 0 auto .1rem;}
		.uploadimg .imgarea .icoBox i{position:absolute;background-color: #ccc;}
		.uploadimg .imgarea .icoBox .i1{width:0.02rem;height:100%;left:50%;top:0;margin-left: -.01rem;}
		.uploadimg .imgarea .icoBox .i2{width:100%;height:0.02rem;left:0;top:50%;margin-top: -.01rem;}

		.uploadimg .imgarea input[type="file"]{position:absolute;width:800%;height:800%;font-size: 100px;right:0;top: 0;opacity: 0;filter:alpha(1);cursor:pointer;}
		.uploadimg .imgarea .imgShow{text-align: center;width:100%;height:100%;position:relative;text-align: center;}
		.uploadimg .imgarea .imgShow img{max-height: 100%;max-height:100%;display:inline-block !important;position:relative;top:50%;-webkit-transform: translateY(-50%); -moz-transform: translateY(-50%); -ms-transform: translateY(-50%); -o-transform: translateY(-50%); transform: translateY(-50%);}

		.aplayTrial .title{margin: 0.22rem 0 .04rem;color:#999;}

		.selectareaNum{background-color: #fff;border-bottom: 1px solid #ccc;}
		.selectareaNum .listRow{border-top:1px solid #ccc;padding: 0 0.1rem;height:.44rem;}
		.aplayTrial .til{float: left;width:1.9rem;line-height: .44rem;;overflow:hidden;text-overflow: ellipsis;white-space: nowrap;}
		.selectareaNum .btnselect{float:right;padding-top: .1rem;}
		.selectareaNum .btnselect a,.selectareaNum .btnselect span{display:inline-block;vertical-align: middle;}
		.selectareaNum .btnselect a{-webkit-tap-highlight-color:transparent;width:.22rem;height:.22rem;text-align: center;line-height: .22rem;font-size: 0.1rem;border:1px solid #8d8d8d;border-radius: 50%;}
		.selectareaNum .btnselect span{width:.5rem;text-align: center;}

		.aplayTrial .pub-item{height:.44rem;background-color: #fff;border-top:1px solid #ccc;border-bottom:1px solid #ccc;margin:.15rem 0;padding: 0 .1rem;}

		.selectcost .costBtn{float: right;margin-top: .14rem;line-height: .14rem;padding-right: .12rem;background:url('${prc}/common/img/weixin-u313.png') no-repeat right center;background-size: .07rem .12rem;}
		.selectcost .costBtn img{width:.07rem;height:0.12rem;margin-left: 0.05rem;}
		.selectcost .costBtn img,.selectcost .costBtn span{vertical-align: middle;display:inline-block;}
		.phoneNum input{border:0;height:0.18rem;padding:0.12rem 0.05rem;width:96%;box-sizing: content-box;}
		.submitBtn{margin:.15rem .1rem;}
		.submitBtn a{display:block;height:.42rem;line-height: .42rem;;background-color:#00cc00;border-radius: .05rem;border:1px solid #21a675;text-align: center;font-size: .14rem;color:#fff;outline:none;}
	</style>
	<%-- <c:if test="${status eq '1'}">
		<script>
			alert("申请成功！");
		</script>
	</c:if>
	<c:if test="${status eq '0'}">
		<script>
			alert("申请失败！");
		</script>
	</c:if> --%>
</head>
<body>

	<form action="${prc }/weChat/toApplyService" class="aplayTrial" id="aplayTrial" onsubmit="return checkForm();" enctype="multipart/form-data" method="post">
		<div class="uploadimg">
			<div class="imgarea">
				<div class="cio"><span class="icoBox"><i class="i1"></i><i class="i2"></i></span>点击添加户型图</div>
				<div class="imgShow" id="localImag">
					<img id="preview" src="${prc}/common/img/noImg.png" alt="" />
				</div>
				<input type="file" name="imagefile" onchange="setImagePreview(this,localImag,preview,['doc','docx','xls','xlsx','ppt','pptx','dwg','zip','rar'],'${prc }/common/img/file_ico.jpg');" id="imgareaInp" required/>
			</div>
			 
		</div>	
		<p class="title"></p>
		<div class="selectareaNum">
			<!-- <input type="hidden" name="areas" id="selectareaNumInp"/> -->
			<div class="list">
				<div class="listRow clearfix">
					<div class="til">独立办公室</div>
					<div class="btnselect">
						<input type="hidden" name="areas" value="独立办公室:0"/>
						<a class="btn crr">-</a>
						<span class="valB">0个</span>
						<a class="btn add">+</a>	
					</div>
				</div>
				<div class="listRow clearfix">
					<div class="til">办公区</div>
					<div class="btnselect">
						<input type="hidden" name="areas" value="办公区:0"/>
						<a class="btn crr">-</a>
						<span class="valB">0个</span>
						<a class="btn add">+</a>	
					</div>
				</div>
				<div class="listRow clearfix">
					<div class="til">会议室</div>
					<div class="btnselect">
						<input type="hidden" name="areas" value="会议室:0"/>
						<a class="btn crr">-</a>
						<span class="valB">0个</span>
						<a class="btn add">+</a>	
					</div>
				</div>
				<div class="listRow clearfix">
					<div class="til">其他</div>
					<div class="btnselect">
						<input type="hidden" name="areas" value="其他:0"/>
						<a class="btn crr">-</a>
						<span class="valB">0个</span>
						<a class="btn add">+</a>	
					</div>
				</div>
			</div>
		</div>
		<div class="selectcost pub-item">
			<input type="hidden" id="costInp" name="cost" value=""/>
			<div class="list">
				<div class="til">成本预算</div>
				<div class="costBtn" id="selectcostBtn"><span>点击设置成本预算</span></div>
			</div>
		</div>
		<div class="phoneNum pub-item">
			<input type="number" placeholder="请输入手机号码，获得一对一的顾问咨询" id="phoneNum" name="phoneNumber"/>
		</div>

		<div class="submitBtn">
			<a id="submitBtn">提交</a>
		</div>
	</form>


	<script src="${prc }/common/js/jQuery-2.2.0.min.js"></script>
	<script type="text/javascript" src="${prc }/common/js/imagePreview.js"></script>
	<script type="text/javascript" src="${prc }/common/lib/mobileSelect.js/js/mobileSelect.min.js"></script>
	<script>
	
		var $imgFileInp = $('#imgareaInp'),
			$imgFileText = $('.imgarea .cio');	
		
		$imgFileInp.one('change',function(){
			$imgFileText.hide();
		});
	

		var weekdayArr=['1-2万','3-4万','5-6万','7-8万'],
			$costInp = $('#costInp');

		var mobileSelect1 = new MobileSelect({
		    trigger: '#selectcostBtn', 
		    title: '成本预算',  
		    wheels: [
		                {data: weekdayArr}
		            ],
		    position:[2], //初始化定位 打开时默认选中的哪个 如果不填默认为0
		    transitionEnd:function(indexArr, data){
		         
		    },
		    callback:function(indexArr, data){
		    	console.log(data);
		        $costInp.val(data);
		        
		    }
		});



		/*区域数量选择*/
		var $btn_crr = $('.selectareaNum .crr'),
			$btn_add = $('.selectareaNum .add'),
			selectareaV1 = 0,
			selectareaV2 = 0,
			selectareaV3 = 0,
			selectareaV4 = 0,
			$selectareaNumInp = $('#selectareaNumInp'),
			temp,
			solit_k;


		function setSelectareaNumData(ind,val){
			var str = '';
			
			switch(ind){
				case 0 : selectareaV1 = val;
					break;
				case 1 : selectareaV2 = val;
					break;
				case 2 : selectareaV3 = val;
					break;
				case 3 : selectareaV4 = val;
					break;
			}

			str += '["独立办公室":"'+selectareaV1+'","办公区":"'+selectareaV2+'","会议室":"'+selectareaV3+'","其他":"'+selectareaV4+'"]';
			return str;
		}


		$btn_crr.on('touchstart',function(){

			var self = $(this),
				$inp = self.siblings('input[type="hidden"]'),
				ind = self.parents('.listRow').index(),
				solit_k = $inp.val(),
				solit_v,
				//val = parseInt($inp.val()),
				val,
				temp;

			val = parseInt(solit_k.split(':')[1]);
			
			if(isNaN(val)){
				val = 0;
			}	

			if(val <= 0){
				return;
			}

			val--;

			self.siblings('.valB').html(val+'个');
			
			switch(ind){
				case 0 : solit_v = '独立办公室:'+val;
					break;
				case 1 : solit_v = '办公区:'+val;
					break;
				case 2 : solit_v = '会议室:'+val;
					break;
				case 3 : solit_v = '其他:'+val;
					break;
			}
			
			$inp.val(solit_v);
			/* temp = setSelectareaNumData(ind,val);
			$selectareaNumInp.val(temp); */

		});

		$btn_add.on('touchstart',function(){

			var self = $(this),
				$inp = self.siblings('input[type="hidden"]'),
				ind = self.parents('.listRow').index(),
				solit_k = $inp.val(),
				solit_v,
				//val = parseInt($inp.val()),
				val,
				temp;
			
			val = parseInt(solit_k.split(':')[1]);

			if(isNaN(val)){
				val = 0;
			}	

			val++;

			self.siblings('.valB').html(val+'个');
			
			switch(ind){
				case 0 : solit_v = '独立办公室:'+val;
					break;
				case 1 : solit_v = '办公区:'+val;
					break;
				case 2 : solit_v = '会议室:'+val;
					break;
				case 3 : solit_v = '其他:'+val;
					break;
			}
			
			$inp.val(solit_v);
			/* temp = setSelectareaNumData(ind,val);
			$selectareaNumInp.val(temp); */

		});

		var $imgareaInp = $('#imgareaInp'),
			$phoneNum = $('#phoneNum');

		function checkForm(){
			var v1 = $imgareaInp.val(),
				v2 = $phoneNum.val();

			/* if(!v1){
				alert('请上传户型图');
				return false;
			}	 */

			if(!v2){
				alert('请填写手机号');
				return false;
			}

			if(!(/^[1][3,4,5,7,8][0-9]{9}$/.test(v2))){
				alert('请填写正确的手机号');
				return false;
			}

			alert('提交成功');
		}

		/*表单提交*/
		var $submitBtn = $('#submitBtn'),	
			$form = $('#aplayTrial');

		$submitBtn.on('click',function(){
			$form.submit();
		});	

	</script>
</body>
</html>