//常用正则表达式
var publicRegx = {
    chinese : /[\u4e00-\u9fa5]/,
    emial : /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/,
    password : /(^.*?[a-zA-Z]+.*?\d+.*?$)|(^.*?\d+.*?[a-zA-Z]+.*?$)/,  //密码不能为纯数字或纯英文且不能为中文
    trim : /^\s+|\s+$/g,
    contOneSpace : /\s+/g,
    phone : ''
};


function strReverse(str){
  return str.split('').reverse().join('');
}

function lastIndexOfInd(str,v){
  
  if(!str && str !== 0){
	return -1;
  }
	
  var temp = strReverse(str),
      st;

  if(v.length > 1){
    st = strReverse(v);
  }    

  return temp.indexOf(st);

}

//返回e很当前节点 后面缓存单例
function EvenFn(e,IsStopPreventDefault){
	var ev = e || window.e;

	if(e.stopPropagation){
		e.stopPropagation();
	}
	else{
		e.cancelBubble = true;
	}

	if(IsStopPreventDefault){
		if(e.preventDefault){
			e.preventDefault();
		}
		else{
			e.returnValue = false;
		}
		
	}

	return {
		e : e,
		el : e.currentTarget
	}

}

//是哪个浏览器或版本
function whichBroser(version){
    var Browser = {
      ie6 : 'MSIE 6.0',
      ie7 : 'MSIE 7.0',
      ie8 : 'MSIE 8.0',
      ie9 : 'MSIE 9.0',
      ie10 : 'MSIE 10.0',
      FF : 'Firefox',
      Chrome : 'Chrome'
    },
    BroserVersion = navigator.userAgent,
    regx;

    if(!Browser[version]){
    	return;
    }

    regx = new RegExp(Browser[version]);

    return regx.test(BroserVersion);
}

var easyTree = (function(opt){

	var defualt = {
		isShowALL : false,
		speed : 500,
	},
	fn,
	tree; 

	function slideUp(o){
		o.animate({height: 'toggle'}, defualt.speed,function(){
		    $(this).hide();
		});
	}
	
	if(whichBroser('ie7')){
	  	fn = function(el_jq){
	  		if(!el_jq.hasClass('showB')){
	  			if(!defualt.isShowALL) {
	  				el_jq.parent('li').siblings().find('.showB').removeClass('showB').siblings('ul').hide();
	  			}
			  	el_jq.addClass('showB').siblings('ul').show(); 
			}
			else{
				slideUp(el_jq.removeClass('showB').siblings('ul'));
			}
	  	}
	}
	else{
	  	fn = function(el_jq){
	  		
	  		if(!el_jq.hasClass('showB')){
	  			if(!defualt.isShowALL){
	  				slideUp(el_jq.parent('li').siblings().find('.showB').removeClass('showB').siblings('ul'));
	  			}
				el_jq.addClass('showB').siblings('ul').slideDown(function(){
					$(this).css('display','block');
				}); 
			}
			else{
				slideUp(el_jq.removeClass('showB').siblings('ul'));
			}
	  	}
	}

	tree = function(opt){
		
		if( Object.prototype.toString.call(opt) === '[object Object]' ){
			defualt = $.extend(true, defualt, opt);
		}

		var tpl = '',
			countInd = -1;
			activeInd = 0;


		function randerFn(arr,depth){
			
		    var len = arr.length,
		        temp,
		        depth_i = depth,
		        i = 0;
		    
		    for(;i<len;i++){
		    	countInd++;
		        temp = arr[i];
		        tpl += '<li class="count'+countInd+' level'+depth_i+'">';
		        	if( temp.nodes && temp.nodes.length > 0 ){

		        		if( countInd == activeInd){
		        			tpl += '<a class="list-group-item node-prodTypeListDiv active level'+(depth_i+1)+' tree-dropdown-toggle-js" data-fid="'+temp.fid+'" data-path="'+temp.path+'" data-depath="'+depth_i+'"><i class="icon expand-icon glyphicon-plus"></i>'+temp.text+'<span class="nav_tri"></span></a>';		                
		        		}
		        		else{
		        			tpl += '<a class="list-group-item node-prodTypeListDiv level'+(depth_i+1)+' tree-dropdown-toggle-js" data-fid="'+temp.fid+'" data-path="'+temp.path+'" data-depath="'+depth_i+'"><i class="icon expand-icon glyphicon-plus"></i>'+temp.text+'<span class="nav_tri"></span></a>';			                
		        		}
		                tpl += '<ul class="submenu">';
		                randerFn(temp.nodes,depth_i+1);
		                tpl += '</ul>';

		            }
		            else{
		            	if( countInd == activeInd){
		            	    tpl += '<a class="list-group-item node-prodTypeListDiv active level'+(depth_i+1)+' tree-dropdown-toggle-js" data-fid="'+temp.fid+'" data-path="'+temp.path+'" data-depath="'+depth_i+'" >'+temp.text+'</a>';
				            
		            	}
		            	else{
		            	    tpl += '<a class="list-group-item node-prodTypeListDiv level'+(depth_i+1)+' tree-dropdown-toggle-js" data-fid="'+temp.fid+'" data-path="'+temp.path+'" data-depath="'+depth_i+'" >'+temp.text+'</a>';
				            
		            	}
		            	
		            }

		        tpl += '</li>';

		    }	

		}
		
		//渲染数据
		if(opt.data){

			randerFn(opt.data,0);

			opt.target.html(tpl);

			$('.tree-dropdown-toggle-js').click(function(){
				var that = $(this); 

				if(typeof opt.beforDoFn === 'function'){
					opt.beforDoFn(that);
				}

				fn(that);
				$('.tree-dropdown-toggle-js').removeClass('active');
				that.addClass('active');
				
				if(typeof opt.doFn === 'function'){
					opt.doFn(that);
				}

			});

		}

		//绑定节点

		return fn;


	}


  return tree;

})();



var publicRegxMethod = {
    
    trim : function(str){
        return str.replace(publicRegx.trim,'');
    },
    contOneSpace : function(str){
        str = this.trim(str);
        return str.replace(publicRegx.contOneSpace,' ');
    },
    inputOnlyNum : function(jq_el){
    	
    	var val = jq_el.val();
    	//var val = parseInt(jq_el.val());
    	
    	if(val.indexOf('.') !== -1){
    		val = parseFloat(val);
    	}
    	else{
    		val = parseInt(val);
    	}

		if( isNaN(val)){
			val = '';
		}
		jq_el.val(val);
    },
    getFileName : function(filePath,type){
    	var fName,
    		ind,
    		extName;
    	
    	if( !publicIsType('string',filePath) ){
    		return;
    	}	
    	
    	ind = filePath.lastIndexOf('/');
    	
    	if(ind === -1){
    		fName = filePath.split('.');
    		if(fName.length >= 1){
    			return;
    		}
    		extName = fName[1];
    		fName = fName[0];
    		
    	}
    	else{
    		fName = filePath.slice(-ind).split('.');
    		extName = fName[1];
    		fName = fName[0];
    	}
    	
    	if(type){
    		return {fName:fName+'.'+extName,name:fName,ext:extName};
    	}
    	else{
    		return fName+'.'+extName;
    	}
 
    },
    formatIndSrt : function(arr){
    	if(!publicIsType('array',arr)){
    		return '';
    	}
    	
    	return ';'+(arr.join(';'))+';';
    	
    }
    
};

function publicIsType(type,obj){
    
    var ObjProtoStr =  Object.prototype.toString;
    
    if(!type || ObjProtoStr.call(obj) === '[object String]'){
        return;
    }
    
    switch(type){
    
        case 'string' : return ObjProtoStr.call(obj) === '[object String]';
            break;
        case 'object' : return ObjProtoStr.call(obj) === '[object Object]';
            break;
        case 'array' : return ObjProtoStr.call(obj) === '[object Array]';
            break;
    
    }   
    
}
    

//校验表单方法
/*
function validateRequire(className,name){
    var val = obj.val();
    if("" == val){
        alert(name+" 不能为空!");
        return false;
    }
    return true;
}*/
//校验手机号/固话
function validatePhone(tel){
    var mobile = /^1[3|5|8]\d{9}$/;
    var phone = /^0\d{2,3}-?\d{7,8}$/;
    return mobile.test(tel) || phone.test(tel);
}

//检查是否是中文
function isChinese(str){
    var s = ''+str;
    return publicRegx.chinese.test(s);
}

function _selfMagerParm(opts,optParm){
    
    if( Object.prototype.toString.call(opts) !== '[object Object]' || Object.prototype.toString.call(optParm) !== '[object Object]' ){
        return;
    }
    
    var key;
    
    for (key in opts) {

        if(opts.hasOwnProperty(key)){

            if( Object.prototype.toString.call(key) === '[object Aarray]'){
                var len = key.length;

                for(;len--;){
                    if(optParm[key][len]){
                        opts[key][len] = optParm[key][len];
                    }
                }
            }
            else if(optParm[key] || optParm[key] === 0){
                opts[key] = optParm[key];
            }

        }
    }
}


/*
* bootstrap 弹窗方法
* 参数
*   opt 类型为 obeject
*
* 参数说明
*   til 标题
*   msg、 tpls模板
*   btnNum 按钮数量 0为没有按钮
*   size  弹窗尺寸 值为'wide'时为宽尺寸
*   btnName 按钮名字 小标为零的为确认按钮，小标为1的为取消按钮 类型为数组 (只有一个按钮的情况下默认按钮名为确定，改功能未测试) 换名字的时候 opt.btnName = ['关闭']；此时btnNum的值一定为1，不然超过1就会报错
*   ready 弹窗展示时执行的回调
*   fasleFn 点击弹窗取消按钮的回调  (回调报错是能关闭弹窗，改功能未测试)
*   trueFn 点击弹窗确认按钮的回调 (回调报错是能关闭弹窗，改功能未测试)
*   cb 弹窗关闭执行的回调（有两个个按钮的情况下，点击确定按钮才能执行回调）
* 
*/
function PublicPop(opt){
    
    if(!opt || Object.prototype.toString.call(opt) !== '[object Object]' ){
        return;
    }

    var opts = {
            til : '提示',
            msg : '',
            tpls : '',
            size : '',
            btnName : ['确定','取消'],
            btnNum : 2,
            ready : function(tplJqObj){},
            fasleFn : function(){},
            trueFn : function(){},
            cb : function(){}
        },
        key,
        btnObj,
        $content = null;

    function runFn(fn){
        try{
            return fn();
        }
        catch(e){
            console.log(e.message);//不支持IE6，如要支持if(console){console.log(e.message);}else{alert(e.message);}
            return false;
        }
    }

    for (key in opts) {

        if(opts.hasOwnProperty(key)){

            if( Object.prototype.toString.call(key) === '[object Aarray]'){
                var len = key.length;

                for(;len--;){
                    if(opt[key][len]){
                        opts[key][len] = opt[key][len];
                    }
                }

            }
            else if(opt[key] || opt[key] === 0){
                opts[key] = opt[key];
            }

        }
    }
    if(opts.btnNum === 2){
        btnObj = [{
            label: opts.btnName[0],
            cssClass: 'btn-primary',
            action: function (dialog) {

                if(!runFn(opts.trueFn)){
                    dialog.close();
                }  

                opts.cb();

            }
        }, {
            label: opts.btnName[1],
            action: function (dialog) {

                if( !runFn(opts.fasleFn)){
                    dialog.close();
                }
   
            }
        }];
    }
    else if(opts.btnNum === 1){ 
        btnObj = [{
            label: opts.btnName[0],
            cssClass: 'btn-primary',
            action: function (dialog) {
                dialog.close();
            }
        }];
    }
    else if(opts.btnNum == 0){ 
        btnObj = [];
    }

    BootstrapDialog.show({
        title: opts.til,
        message: function (dialog){
            
            if(opts.tpls){
                $content = opts.tpls;
            }
            else if(opts.msg){
                $content = $(opts.msg);
            }

            if(opts.size === 'wide'){
                dialog.setSize(BootstrapDialog.SIZE_WIDE);
            }
            return $content;
        },
        onshown: function(dialogRef){
            opts.ready(dialogRef,$content);
        },
        buttons: btnObj
    });
}

function publicIsEmail(email){
    return publicRegx.emial.test(email);
}



/*获取密码强度*/

//测试某个字符是属于哪一类
function ckeckPwd_CharMode(iN) {
   if (iN>=48 && iN <=57) //数字
    return 1;
   if (iN>=65 && iN <=90) //大写字母
    return 2;
   if (iN>=97 && iN <=122) //小写
    return 4;
   else
    return 8; //特殊字符
}
//bitTotal函数
//计算出当前密码当中一共有多少种模式
function ckeckPwd_bitTotal(num) {
   modes=0;
   for (i=0;i<4;i++) {
    if (num & 1) modes++;
     num>>>=1;
    }
   return modes;
}
//sPW密码，len至少要达到的长度，默认为0
//返回值false表示长度达不到，数值表示强度

function ckeckPwd_checkStrong(sPW,len) {
    var str_len = len || 0,
        Modes = 0; 
    
    if (sPW.length < str_len){
        return false; //密码太短
    }
        
    
    for (i=0;i<sPW.length;i++) {
     //测试每一个字符的类别并统计一共有多少种模式
     Modes|=ckeckPwd_CharMode(sPW.charCodeAt(i));
   }
   return ckeckPwd_bitTotal(Modes);
}
/*获取密码强度 end*/


/*加载遮罩*/
var $honeLoading = $('#homeLoadding');

function publicLoadingShow(cb){
    $honeLoading.show();
    if(typeof cb === 'function'){
    	cb();
    }
}

function publicLoadingHide(){
    $honeLoading.hide();
}


function publicSupport_css3(prop){
   var div = document.createElement('div'),
       vendors = 'Ms O Moz Webkit'.split(' '),
       len = vendors.length;
   
   if ( prop in div.style ) return true;
   
   prop = prop.replace(/^[a-z]/, function(val) {
      return val.toUpperCase();
   });
   
   while(len--) {
       if ( vendors[len] + prop in div.style ) {
          return true;
       } 
   }
   return false;
   
}

function PublicCopyObj(obj){
	if( Object.prototype.toString.call(obj) !== '[object Object]' ){
        return;
    }
	var c = {},key;
	
	for(key in obj){
		c[key] = obj.key;
	}
	
	return c;
	
}


function setIntNumber(self,isBlur){
    var temp;

    if(isBlur && temp == ''){
        temp  = 0;
    }

    if(self.value.length==1){
        self.value=self.value.replace(/[^1-9]/g,'');
    }
    else{
        temp = parseInt(self.value.replace(/\D/g,''));
        if(isNaN(temp)){
            temp = '';
        }
        self.value=temp;
    }

}




function PublicSetSelfIframeHei(opt){

    if( Object.prototype.toString.call(opt) !== '[object Object]' ){
        return;
    }
    
    /*var opts = {
     * 
     	parent : 'window.parent.document'
        ifm_id : '',
        set_hei : '',
        ajust_hei : ''
    }*/
    
    if( (!opt.parent && !opt.ifm_id) || ( (!opt.set_hei && opt.set_hei != 0) && !opt.ajust_hei)){
        return;
    }
    
    var temp = opt.ajust_hei ? opt.ajust_hei : opt.set_hei,
        fullHei = $(window.top.document).find('.consoleWarpBox').height();
    
    temp = opt.ajust_hei ? String(fullHei - opt.ajust_hei) :  ''+temp;
  
    if( temp.indexOf('%') === -1 ){
        if(temp.indexOf('px') === -1){
            temp += 'px';
        }
    }

    if(opt.parent){
    	opt.parent.style.height = temp;
    }
    else{
    	window.parent.contentWindow.document.getElementById(opt.ifm_id).style.height = temp;
    }
     
}

function PublicSetSelfIframeHeiTop(opt){

    if( Object.prototype.toString.call(opt) !== '[object Object]' ){
        return;
    }
    
    if( (!opt.parent && !opt.ifm_id) || ( (!opt.set_hei && opt.set_hei != 0) && !opt.ajust_hei)){
        return;
    }
    
    var temp = opt.ajust_hei ? opt.ajust_hei : opt.set_hei,
    	temp2,
        fullHei = $(window.top.document).find('.consoleWarpBox').height();
    
    temp = opt.ajust_hei ? String(fullHei - opt.ajust_hei) :  ''+temp;
    
    temp2 = ( parseInt(temp) + 100);
    
    if( temp.indexOf('%') === -1 ){
        if(temp.indexOf('px') === -1){
            temp += 'px';
        }
    }

    if(opt.parent){
    	opt.parent[0].height = temp;
    }
    else{
    	window.parent.contentWindow.document.getElementById(opt.ifm_id).height = temp;
    }
    
    window.top.document.getElementById('content').height = temp2;
     
}

function PublicSetSelfIframeHeiFf(ind){
	
	if(ind === 2){
		return;
	}
	
	var indArr = ['offerheaderFrame','saleProdFrame','baojiaIfr','offerTailFrame'],
		$ifr = $('#'+indArr[ind]),
		bodyHei = $ifr.contents().find('body').height()+50;
		
    PublicSetSelfIframeHeiTop({
    	set_hei: bodyHei,
    	parent: $ifr
    });
	
}

var easyPop = (function(){

	var _unique;
	
	function _easyPop(opt){
		
		if(Object.prototype.toString.call(opt) !== '[object Object]'){
			return;
		};
		var self = this;
		this.init = true;
		this.act = 'active';
		this.bg = $('#easyPopBg');
		this.box = $('#easyPop');
		this.itemBox = this.box.find('.itembox');
		this.textArea = this.box.find('textarea');
		this.cancleBtn = this.box.find('.cancleBtn');
		this.trueBtn = this.box.find('.trueBtn');

		this.showBox = function(){
			this.bg.addClass(this.act);
			this.box.addClass(this.act);
		};
		this.hidenBox = function(){
			this.bg.removeClass(this.act);
			this.box.removeClass(this.act);
		};

		this.close = this.box.find('.close');
		
		this.doFn = function(){};
		
		this.extent = {};
		this.run = function(){};
		
		this.init = function(){
			this.close.click(function() {
				self.hidenBox();
			});

			this.bg.click(function(){
				self.hidenBox();
			});

			this.cancleBtn.click(function() {
				if( typeof opt.cancleFn === 'function'){
					opt.cancleFn(self);
				}
			});

			this.trueBtn.click(function() {
				if( typeof opt.trueFn === 'function'){
					opt.trueFn(self);
				}
			});
			
			this.textArea.on('keydown',function(e){
				var e = e || window.event;
				if( (e.altKey || e.ctrlKey) && e.keyCode === 13){
					self.extent.sentMsg(self.extent.oid);
				}
			});
			
			if( Object.prototype.toString.call(opt.extent) === '[object Object]'){
				this.extent = opt.extent;
				this.extent.__proto__ = this;
			}
			
			if(typeof opt.doFn === 'function'){
				this.doFn = opt.doFn;
			}		
			
		};
		

		this.init_befor = function(){
		}

		this.init();

	}
	
	return function(opt){
		if(!_unique){
			_unique = new _easyPop(opt);
		}
		
		return _unique;
	};
	
})();


var iframeHomeMethod = {
    //没有做到按输什么格式返回什么格式
    formatDate : function(time,noSecond) {
        var now;
        if(time){
            now = new Date(time);
        }
        else{
            now = new Date();
        }
        var year=now.getFullYear();
        var month=now.getMonth()+1;
        var date=now.getDate();
        var hour=now.getHours();
        var minute=now.getMinutes();
        var second= now.getSeconds();

        month = month >= 10 ? month : '0'+month;
        date = date >= 10 ? date : '0'+date;
        hour = hour >= 10 ? hour : '0'+hour;
        minute = minute >= 10 ? minute : '0'+minute;
        second = second >= 10 ? second : '0'+second;

        if(noSecond){
            return year+"-"+month+"-"+date+" "+hour+":"+minute;
        }
        else{
            return year+"-"+month+"-"+date+" "+hour+":"+minute+":"+second;
        }

    },

	resetIFRheight : function (target_jq,ifr_jq,Fncb,setBeforeDataFn){

		var temp_data = {
				bodyHei : '',
				ajust : 300,
			},
			windowHeight = $(window.top).height();
		
		if( typeof setBeforeDataFn === 'function'){
			setBeforeDataFn(temp_data);
		}
		
		temp_data.bodyHei = target_jq.height();			
			
		if(windowHeight >= temp_data.bodyHei){
			temp_data.bodyHei = windowHeight;
		}

		ifr_jq[0].height = temp_data.bodyHei;		
		
		if( typeof Fncb === 'function'){
			Fncb(temp_data);
		}
		
	},	
	showProdDetailPop_case : null,
	showProdDetailPop: function(data){
	
		function pop(data,source){

		    this.source = source;

			this.init = function(data){
				
				var str = '',
					that = this;
				str += '<div class="prodlibDetailPop" id="prodlibDetailPop">';
					str += '<div class="popBg"></div>';
					str += '<div class="popCent popshadow">';
						str += '<div class="prodlibDetail" id="prodlibDetail">';
							str += '<div class="pdname"><span class="pdNameBox"></span><i class="popClose">x</i></div>';
							str += '<div class="centerBOX clearfix">';
								str += '<div class="fl prototype"></div>';
								str += '<div class="fr detial"></div>';
							str += '</div>';
						str += '</div>';
					str += '</div>';
				str += '</div>';
				
				$('body').append(str);
				
				
				var $popBox = $('#prodlibDetailPop'),
				$closeBtn = $popBox.find('.popClose');
				
				/* 产品详情展示 */
				this.pdName = $popBox.find('.pdNameBox');
				this.pd_proto = $popBox.find('.prototype');
				this.pd_detial = $popBox.find('.detial');
				
				
				this.Box = $popBox;
				this.close_btn = $closeBtn;
				
				$closeBtn.click(function(){
					that.hide();
				});
				
				this.rander(data);
				
			};
			
			this.checkDisabel = function(){
				
				var $el = this.pd_proto.find('dl').eq(0).find('.opt.select').eq(0),
					ind = $el.index(),
					el = $el.eq(0);
				this.protoSel(0,ind,el,true);
			};
						
			this.protoSel = function(i1,i2,self,isCheck){

				var $el = $(self),
			    	that = this,
			    	$all_dl_el = $el.parents('.prototype').find('dl'),
			    	properties,
			    	propertyIndex = i1,
			    	propertyValueIndex = i2,
			    	propertyDisabled = $el.hasClass('disabled'),
			    	compositions,
			    	isPreView = false,
			    	isSelect = $el.hasClass('select');



			    if(this.source.showType && this.source.showType === 'preView'){
			    	properties = this.prodlibDetail_data.skuOpt;
			    	compositions = this.prodlibDetail_data.composition;
			    	isPreView = true;
			    }
			    else{
			    	properties = this.prodlibDetail_data.goodsSelection.properties;
			    	compositions = this.prodlibDetail_data.goodsSelection.composition;
			    }


			    //首先属性应该是可选的,不可选则直接返回
			    if (propertyDisabled) {
			      console.log('propertyDisabled');
			      return;
			    }

			    // 取消该属性下的所有值的选中状态+设置当前选中状态
			    if(!isCheck){
			    	$el.siblings('.opt').removeClass('select');
				    if(isSelect){
				    	$el.removeClass('select');
				    }
				    else{
				    	$el.addClass('select');	
				    }
			    }

			    // 检查当下的选择
			    var checkRes = this.checkSelection($all_dl_el);
			    var selectedPropertyStr = checkRes.selectedPropertyStr;
			    var selectedPropertyIndexs = checkRes.selectedPropertyIndexs;
			    prodlibDetail_index = selectedPropertyIndexs;

			    // 重新计算disable
			    
			    //当第i个属性未确定,其余均取当前选择的结果,那么看第i个属性所有的值有哪些是存在于组合的
			    
			    for (var i = 0; i < selectedPropertyIndexs.length; i++) {      
			      var tmpCompProp = selectedPropertyIndexs.slice(0);
			      // 将未选中项替换为对应的正则\\d+
			      for (var j = 0; j < tmpCompProp.length; j++){
			        if (j != i && tmpCompProp[j] == -1)
			          tmpCompProp[j] = '\\d+';
			      }
			      // 遍历第i个属性的所有取值
			      var propValue = properties[i].values;
			      for (var j = 0; j < propValue .length; j++) {
			        tmpCompProp[i] = j;//第i个属性取第j个值
			        var exp = new RegExp('^' + tmpCompProp.toString() + "$");//生成对应的正则
			        var disabled = true;
			        var compProp;
			        for (var k = 0; k < compositions.length; k++) {
			        	if(isPreView){
			        		compProp = compositions[k];
			        	}
			        	else{
			        		compProp = compositions[k].properties;
			        	}
			          
			          var meet = exp.test(compProp.toString());//判断
			          if (meet) {
			            disabled = false;
			            break;
			          }
			        };
			        if(disabled){
			        	$all_dl_el.eq(i).find('span.opt').eq(j).addClass('disabled');	
			        }
			        else{
			        	$all_dl_el.eq(i).find('span.opt').eq(j).removeClass('disabled');
			        }
			        
			      }
			    }
			    
			    if(isCheck){
			    	return;
			    }

			    // 更新商品详情
			    
			    if(isPreView){
			    	if(checkRes.skuInd || checkRes.skuInd === 0 ){
			    		this.prodlibDetail_data.defualSelect = checkRes.skuInd;
			    		that.DetailrightInfo(that.prodlibDetail_data,that,that.prodlibDetail_data);
			    	}
			    } 
			    else{
			    	var skuId = checkRes.skuId;
				    if (skuId) {

				      $.ajax({
				    	 url: fullPath('prodLib/prod/'+this.prodlibDetail_data.pid+'/sku/'+skuId+'/detail/1'),
				    	 datatype : 'json',
				    	 success : function(r){
				    		 
				    		if(r.meta && r.meta.code !== 200){
				    			alert(r.meta.msg);
				    			return;
				    		}
				    		 
				    		that.DetailrightInfo(r.data.goodsDetail,that,that.prodlibDetail_data);
				    		
				    	 },
				    	 error : function(){
				    		 alert('加载失败');
				    	 }
				      });	

				    }	
			    }

			};

			this.checkSelection = function($dl){
				
				// 获取所有的选中规格尺寸数据
			    var properties;
			    var needSelectNum;
			    var curSelectNum = 0;
			    var selectedPropertyIndexs = [];
			    var selectedPropertyStr = "";
			    var skuInd;
			    var isPreView = false;
			    var comp;

			    if(this.source.showType && this.source.showType === 'preView'){
			    	properties = this.prodlibDetail_data.skuOpt;
			    	comp = this.prodlibDetail_data.composition;
			    	isPreView = true;
			    }
			    else{
			    	properties = this.prodlibDetail_data.goodsSelection.properties;
			    	comp = this.prodlibDetail_data.goodsSelection.composition;
			    }

			    needSelectNum = properties.length;


			    for (var i = 0; i < properties.length; i++) {
			      var childs = properties[i].values;
			      var s = false;
			      for (var j = 0; j < childs.length; j++) {
			    	
			    	if($dl.eq(i).find('span.opt').eq(j).hasClass('select')){
			          curSelectNum++;
			          s = true;
			          selectedPropertyIndexs.push(j);
			          selectedPropertyStr = selectedPropertyStr + childs[j].name + "，";
			        }
			      }
			      if (!s)
			        selectedPropertyIndexs.push(-1);
			    }
			    if (selectedPropertyStr.lastIndexOf("，") !== -1)
			      selectedPropertyStr = selectedPropertyStr.substr(0, selectedPropertyStr.length-1)

			    var skuId = '';
			    if (needSelectNum == curSelectNum) {
			      isAllSkuSelect = true;
			      
			      for (var i = 0; i < comp.length; i++) {
			        var value = comp[i];
			        
			        if(isPreView){
			        	if(value.toString() == selectedPropertyIndexs.toString()) {
				          skuId = value.id;
				          skuInd = i;
				          break;
				        }
			        }
			        else{
			        	if(value.properties.toString() == selectedPropertyIndexs.toString()) {
				          skuId = value.id;
				          skuInd = i;
				          break;
				        }
			        }
			        
			        
			      };
			    }
			    else{
			    	isAllSkuSelect = false;
			    }

			    return {
			      "skuId": skuId,
			      "selectedPropertyIndexs": selectedPropertyIndexs,
			      "selectedPropertyStr": selectedPropertyStr,
			      skuInd : skuInd
			    };
			    
			};
			
			this.rander = function(data){
				
				if(this.source.showType && this.source.showType === "preView"){
					
					this.prodlibDetail_data = data;
					
					var skuInd = data.defualSelect,
						curSku = data.skuData[skuInd];
					
					this.pdName.html(curSku.basicInfo.name);

					this.pd_proto.html('');
					this.pd_detial.html('');
					
					var goodsDetail = curSku,
						specification = goodsDetail.specification,
						selected = goodsDetail.keyArr,
			            properties = data.skuOpt,
			            properties_len = properties.length;
					
					
					for (var i = 0; i < properties_len; i++) {
			          	var idx = selected[i];
			            properties[i].values[idx].selected = true;
			        }
						
					
			        prodlibDetail_index = selected;
			        
			        //渲染
					var tpl_proto = '',
						proto_len = properties_len,
						proto_opt_len,
						tpl_detial = '',
						detial_len = specification.length,
						detial_opt_len,
						detial_opt_v_len,
						img_len,
						i1,
						i2,
						temp,
						temp2,
						ishui = '',
						randomNum = Math.floor(Math.random()*1000),
						canme = '';
				
					
					i1 = 0;	
					for(;i1<proto_len;i1++){

						temp = properties[i1];
						temp2 = temp.values;
						
						tpl_proto += '<dl>';
							tpl_proto += '<dt>'+temp.name+'</dt>';
							tpl_proto += '<dd>';

								proto_opt_len = temp2.length;
								i2 = 0;
								for(;i2<proto_opt_len;i2++){
									canme = '';
									if(temp2[i2].selected){
										canme = 'select';
									}
									else if(temp2[i2].disabled){
										canme = 'disabled';
									}
									tpl_proto += '<span onclick="iframeHomeMethod.showProdDetailPop_case.protoSel('+i1+','+i2+',this)" class="opt noselect '+canme+'" >'+temp2[i2].name+'</span>';
								}

							tpl_proto += '</dd>';
						tpl_proto += '</dl>';

					}
					
					
					this.pd_proto.html(tpl_proto);
					
					this.checkDisabel();
					
					this.DetailrightInfo(data,this);
					
					this.show();
										
					
				}
				else{
					
					this.prodlibDetail_data = data;
					
					this.pdName.html(data.goodsDetail.basicInfo.name);

					this.pd_proto.html('');
					this.pd_detial.html('');
					
					var goodsDetail = data.goodsDetail,
						specification = goodsDetail.specification,
						selection = data.goodsSelection,
			            selected = selection.selected,
			            properties = selection.properties,
			            properties_len = properties.length;
					
					
					for (var i = 0; i < properties_len; i++) {
			         	var idx = selected.properties[i];
			            properties[i].values[idx].selected = true;
			        }
						
					
			        prodlibDetail_index = selected.properties;
			        
			        //渲染
					var tpl_proto = '',
						proto_len = properties_len,
						proto_opt_len,
						tpl_detial = '',
						detial_len = specification.length,
						detial_opt_len,
						detial_opt_v_len,
						img_len,
						i1,
						i2,
						temp,
						temp2,
						ishui = '',
						randomNum = Math.floor(Math.random()*1000),
						canme = '';
				
					
					i1 = 0;	
					for(;i1<proto_len;i1++){

						temp = properties[i1];
						temp2 = temp.values;
						
						tpl_proto += '<dl>';
							tpl_proto += '<dt>'+temp.name+'</dt>';
							tpl_proto += '<dd>';

								proto_opt_len = temp2.length;
								i2 = 0;
								for(;i2<proto_opt_len;i2++){
									canme = '';
									if(temp2[i2].selected){
										canme = 'select';
									}
									else if(temp2[i2].disabled){
										canme = 'disabled';
									}
									tpl_proto += '<span onclick="iframeHomeMethod.showProdDetailPop_case.protoSel('+i1+','+i2+',this)" class="opt noselect '+canme+'" >'+temp2[i2].name+'</span>';
								}

							tpl_proto += '</dd>';
						tpl_proto += '</dl>';

					}
										
					this.pd_proto.html(tpl_proto);
					
					this.DetailrightInfo(data.goodsDetail,this,source);
					
					this.show();
					
					
				}


			};
			
			this.DetailrightInfo = function(data,that){
				
				var goodsDetail,
					specification,
					proto_opt_len,
					detial_opt_v_len,
					tpl_detial = '',
					detial_len,
					randomNum = Math.floor(Math.random()*1000),
					img_len,
					i1,
					i2,
                    noFn = function () {};
                    btn1Fn = noFn,
                    btn2Fn = noFn,
					isScroll = true;

			    if(typeof this.source.btn1Fn === 'function'){
                    btn1Fn = this.source.btn1Fn;
                }

                if(typeof this.source.btn2Fn === 'function'){
                    btn2Fn = this.source.btn2Fn;
                }

                this.btn1Fn = btn1Fn;
                this.btn2Fn = btn2Fn;
				
				if(this.source.showType && this.source.showType === 'preView'){
					var curInd = source.data.defualSelect,
						curSku = source.data.skuData[curInd];
					goodsDetail = curSku;
					specification = goodsDetail.specification;
				}
				else{
					goodsDetail = data;
					specification = goodsDetail.specification;

				}
				
				detial_len = specification.length;
				
				tpl_detial += '<div class="imgBox">';
					tpl_detial += '<div class="swiper-container" id="swiperId'+randomNum+'">';
				    	tpl_detial += '<div class="swiper-wrapper">';
				    	i1 = 0;
				    	
				    	img_len = goodsDetail.pics.length;
				    	for(;i1<img_len;i1++){
				    		tpl_detial += '<div class="swiper-slide">';
				    		
				    			if(this.source.showType && this.source.showType === 'preView'){
				    				tpl_detial += '<img src="'+goodsDetail.pics[i1]+'" alt="" />';
				    			}
				    			else{
				    				tpl_detial += '<img src="https://baize-webresource.oss-cn-shenzhen.aliyuncs.com/'+goodsDetail.pics[i1]+'" alt="" />';
				    			}
				    							       
					        tpl_detial += '</div>';
				    	}
				    	
				    	if(!img_len){
				    		isScroll = false;
				    		tpl_detial += '<div class="swiper-slide">';
					        	tpl_detial += '<img src="common/img/noPic.png" alt="" />';
					        tpl_detial += '</div>';
				    	}
				    	
			
				    	tpl_detial += '</div>'; 
				    tpl_detial += '<div class="swiper-pagination"></div>';
				    							    
					tpl_detial += '</div>';
				tpl_detial += '</div>';
			
			
				tpl_detial += '<dl style="margin-top: 10px;background-color: #ffe5cc;">';
					tpl_detial += '<dt><span class="dtTil" style="color: #FF9966;" >产品类别：</span></dt>';
					tpl_detial += '<dd>';

						var Pdtype;
						
						function getName(o){
							
							if(o.name){
								tpl_detial += o.name+' - ';
								if(o.children.length){
									getName(o.children[0]);
								}
							}
							
						}

						
						if(this.source.showType && this.source.showType === 'preView'){
							tpl_detial += that.prodlibDetail_data.prodTypeTree
						}
						else{
							Pdtype = that.prodlibDetail_data.prodTypeTree[0];
							getName(Pdtype);
							
							if( lastIndexOfInd(tpl_detial,'- ') === 0){
								tpl_detial = tpl_detial.slice(0,-2);
							}
						}
						
						
					tpl_detial += '</dd>';
				tpl_detial += '</dl>';
				
				tpl_detial += '<dl>';
					tpl_detial += '<dt><span class="dtTil">厂商：</span></dt>';
					tpl_detial += '<dd>'+goodsDetail.basicInfo.factoryName+'</dd>';
				tpl_detial += '</dl>';
				
				tpl_detial += '<dl>';
					tpl_detial += '<dt><span class="dtTil">产品说明：</span></dt>';
					tpl_detial += '<dd>'+goodsDetail.basicInfo.briefDesc+'</dd>';
				tpl_detial += '</dl>';
				
				tpl_detial += '<dl>';
					tpl_detial += '<dt><span class="dtTil">产品详情：</span></dt>';
					tpl_detial += '<dd>';
				
						proto_opt_len = specification.length;
						i1 = 0;
						for(;i1<proto_opt_len;i1++){
							tpl_detial += '<p><span class="til_l">'+specification[i1].name+'：</span><span class="val_l">';
							
							i2 = 0;
							detial_opt_v_len = specification[i1].values.length;
							
							for(;i2<detial_opt_v_len;i2++){
								tpl_detial += specification[i1].values[i2].name+' ';
							}
							
							tpl_detial += '</span></p>';
						}
				
					tpl_detial += '</dd>';
				tpl_detial += '</dl>';
			
				
				tpl_detial += '<div class="costBox">';
					if(goodsDetail.basicInfo.marketPrice){
						tpl_detial += '<span class="dtTil">面价：</span><span class="v">'+goodsDetail.basicInfo.marketPrice+'元</span>';
					}
					if(goodsDetail.basicInfo.sellPrice){
						tpl_detial += '<span class="dtTil">售价：</span><span class="v">'+goodsDetail.basicInfo.sellPrice+'元</span>';
					}
					if(goodsDetail.basicInfo.factoryPrice){
						tpl_detial += '<span class="dtTil">成本价：</span><span class="v">'+goodsDetail.basicInfo.factoryPrice+'元</span>';
					}
				tpl_detial += '</div>';

				tpl_detial += '<div class="btnBox">';

				    if(this.source.showType === 'preView'){
                        tpl_detial += '<a onclick="iframeHomeMethod.showProdDetailPop_case.btn1Fn(iframeHomeMethod.showProdDetailPop_case)">提交产品</a>';
                    }
                    else if(this.source.showType === 'audit'){
                        tpl_detial += '<a onclick="iframeHomeMethod.showProdDetailPop_case.btn1Fn(iframeHomeMethod.showProdDetailPop_case)">编辑产品</a>';
                        tpl_detial += '<a onclick="iframeHomeMethod.showProdDetailPop_case.btn2Fn(iframeHomeMethod.showProdDetailPop_case)">审核通过</a>';
                    }
                    else{
				        //产品库
                    }

				tpl_detial += '</div>';		
			
				that.pd_detial.html(tpl_detial);
			
				new Swiper ('#swiperId'+randomNum, {
				    direction: 'horizontal',
				    autoplay : isScroll,
				    loop: isScroll,
				    
				    // 如果需要分页器
				    pagination: {
				      el: '.swiper-pagination',
				    }
			   
				});

			};
			
			this.hide = function(){
				this.Box.hide();
			};
			
			this.show = function(){
				this.Box.show();
			}
			
			this.init(data,source);
			
			
		}
		
		
		if(iframeHomeMethod.showProdDetailPop_case){
			iframeHomeMethod.showProdDetailPop_case.rander(data.data);
			return;
		}
		else{
			iframeHomeMethod.showProdDetailPop_case = new pop(data.data,data);
		}
		
	},
		
		
		
}













//产品详情弹窗  已弃用
/*var showProdDetailPop = (function (){
	
	var _unique;

	function ProdDetailPop(data){

		var noop = function(a,b,c){};

		this.defultOpt = {
			title : '产品详情',
			btnName : ['删除','编辑']
		};

		this.close = function(){
			this.popBox.hide();
		};

		this.show = function(){
			this.popBox.show();
		};

		this.randomNum = 0;

		this.ready = function(self,data){
			new Swiper ('#swiperId'+self.randomNum, {
			    direction: 'horizontal',
			    autoplay : data.img.length > 1 ? true : false,
			    loop: true,
			    
			    // 如果需要分页器
			    pagination: {
			      el: '.swiper-pagination',
			    },
			   
		  	});
		};

		this.randerBefor = noop;

		this.rander = function(data){

			this.randerBefor(this,data);

			this.imgBox.html('');
			this.textBox.html('');

			var imgTpl = '',
				imglen,
				textTpl = '',
				textlen,
				optlen,
				i,
				i2,
				temp;

			this.randomNum = Math.floor(Math.random()*1000);

			imgTpl += '<div class="swiper-container" id="swiperId'+this.randomNum+'">';
			    imgTpl += '<div class="swiper-wrapper">';

			    	temp = data.img;

			    	if(Object.prototype.toString.call(temp) === '[object Array]'){

			    		imglen = temp.length;
			    		i = 0;
			    		for(;i < imglen;i++){
			    			imgTpl += '<div class="swiper-slide">';
					        	imgTpl += '<img src="'+temp[i]+'" alt="" />';
					        imgTpl += '</div>';
			    		}

			    	}

			    imgTpl += '</div>';
			    imgTpl += '<div class="swiper-pagination"></div>';
			imgTpl += '</div>';

			this.imgBox.append(imgTpl);
			
			temp = data.text;
			textlen = temp.length;
			i = 0;
			
			
			textTpl += '<dl>';
				textTpl += '<dt>产品名称：</dt>';
					textTpl += '<dd>'+data.name+'</dd>';
			textTpl += '</dl>';
			
			textTpl += '<dl>';
				textTpl += '<dt>产品价格：</dt>';
					textTpl += '<dd>';
						if(data.factoryPrice || data.factoryPrice == 0){
							textTpl += '<span class="priceVal">￥'+data.factoryPrice+'<em>（成本）</em></span>';
						}
						if(data.price || data.price == 0){
							textTpl += '<span class="priceVal">￥'+data.price+'<em>（面价）</em></span>';
						}
						if(data.sellPrice || data.sellPrice == 0){
							textTpl += '<span class="priceVal">￥'+data.sellPrice+'<em>（售价）</em></span>';
						}					
					textTpl += '</dd>';
			textTpl += '</dl>';
			

			for(;i<textlen;i++){

				textTpl += '<dl>';
					textTpl += '<dt>'+temp[i].name+'：</dt>';

					if( Object.prototype.toString.call(temp[i].val) === '[object Array]' ){

						textTpl += '<dd>';

						optlen = temp[i].val.length;
						i2 = 0;

						for(;i2<optlen;i2++){
							textTpl += '<span class="opt">'+temp[i].val[i2]+'</span>';
						}

						textTpl += '</dd>';

					}
					else{
						textTpl += '<dd>'+temp[i].val+'</dd>';
					}

					
				textTpl += '</dl>';

			}
			
			this.textBox.append(textTpl);

			this.ready(this,data);

			this.show();

		};

		this.init = function(data){

			if(Object.prototype.toString.call(data) !== '[object Object]'){
				return;
			}

			if(data.setting){
				this.defultOpt = jQuery.extend(this.defultOpt,data.setting);
			}

			if(Object.prototype.toString.call(data.ready) === '[object Function]'){
				this.ready = data.ready;
			}

			if(Object.prototype.toString.call(data.randerBefor) === '[object Function]'){
				this.randerBefor = data.randerBefor;
			}

			var tpl = '',
				self = this,
				popBox;

			tpl += '<div class="showProdDetailPop" id="showProdDetailPop">';
				tpl += '<div class="popBg"></div>';
				tpl += '<div class="contBoxPop">';
					tpl += '<div class="midlebox">';
						tpl += '<div class="popshadow">';
							tpl += '<div class="top">';
								tpl += '<h4 class="til">'+this.defultOpt.title+'</h4>';
								tpl += '<i class="close_ico"></i>';
							tpl += '</div>';
							tpl += '<div class="content clearfix">';
								tpl += '<div class="fl showImg">';
									tpl += '<div class="imgBox"></div>';	
								tpl += '</div>';
								tpl += '<div class="fr showtext">';
									tpl += '<div class="textBox"></div>';
								tpl += '</div>';
							tpl += '</div>';	
							tpl += '<div class="bottom">';
								tpl += '<a class="btn1">'+this.defultOpt.btnName[0]+'</a>';
								tpl += '<a class="btn2">'+this.defultOpt.btnName[1]+'</a>';
							tpl += '</div>';	
						tpl += '</div>';
						
					tpl += '</div>';
				tpl += '</div>';
			tpl += '</div>';


			$('body').append(tpl);

			popBox = this.popBox = $('#showProdDetailPop');

			this.closeBtn = popBox.find('.close_ico');

			this.imgBox = popBox.find('.content .imgBox');

			this.textBox = popBox.find('.textBox');

			this.botomBtn1 = popBox.find('.bottom .btn1');

			this.botomBtn2 = popBox.find('.bottom .btn2');

			this.closeBtn.click(function(){
				self.close();
			});

			this.botomBtn1.click(function(event) {
				//删除
				self.close();
			});

			this.botomBtn2.click(function(event) {					
				//编辑
				window.location.href = '';

			});

			this.rander(data);

		};

		this.init(data);


	}

	return function(data){
		
		if(!_unique){
			_unique = new ProdDetailPop(data);
		}
		else{
			_unique.rander(data);
		}
		
		return _unique;
	};

})();*/

var addProdSetOrtherPropotyPop_case,
	addProdSetOrtherPropotyPop = (function(){

	var _unique;

	function Pop(data){

		var noop = function(a,b,c){};

		this.close = function(){
			this.popBox.hide();
		};

		this.show = function(){
			this.popBox.show();
		};

		this.randerBefor = noop;

		this.selOrtherProtyPop = function selOrtherProtyPop(self){
			var that = $(self);
			if(that.hasClass('active')){
				that.removeClass('active');
			}
			else{
				that.addClass('active');
			}
		};

		this.addProtyBySelfItem = function (){

			var $addBox = this.textBox,
				len = $addBox.find('li').length+1,
				tpl = '';

			tpl += '<li class="clearfix">';
				tpl += '<span class="ind">'+len+'.</span>';
				tpl += '<input type="text" placeholder="请在这里输入你想要的产品属性值" />';
			tpl += '</li>';

			$addBox.append(tpl);

		};

		this.rander = function(data){
			
			this.valEl = data.ValEl;

			this.randerBefor(this,data);

			this.slectBox.html('');
			//this.textBox.html('');

			var imgTpl = '',
				imgTpl_data = data.data,
				imglen = imgTpl_data.length,
				valOpt,
				valOpt_len,
				textTpl = '',
				textlen,
				optlen,
				i,
				i2,
				oldVal = data.ValEl.val(),
				oldVal_temp = {},
				key_temp,
				oldvalArr = [],
				temp;

			
			if(oldVal){
				temp = oldVal.split(';');
				i1 = 0;
				i2 = temp.length;
				
				for(;i1<i2;i1++){
					oldvalArr.push(temp[i1].split('#'));
					key_temp = 'ind'+oldvalArr[i1][0];
					oldVal_temp[key_temp] = oldvalArr[i1][1];
				}
			}
			
			
			
			i=0;	
			for(;i<imglen;i++){
				
				imgTpl += '<li class="fl">';
					key_temp = 'ind'+i;
					if( oldVal_temp[key_temp] ){
						imgTpl += '<a onclick="addProdSetOrtherPropotyPop_case.selOrtherProtyPop(this)" class="active">';
							imgTpl += '<i class="sel_ico"></i>';
							imgTpl += '<span class="textHidden">'+imgTpl_data[i].name+'</span>';
						imgTpl += '</a>';
						
						imgTpl += '<div class="putTxtBox">';
							imgTpl += '<input type="text" value="'+oldVal_temp[key_temp]+'" onclick="addProdSetOrtherPropotyPop_case.showSelectBox(event,this)" oninput="addProdSetOrtherPropotyPop_case.likeSereach(event,this,\''+imgTpl_data[i].id+'\')" onporpertychange="addProdSetOrtherPropotyPop_case.likeSereach(event,this,\''+imgTpl_data[i].id+'\')" />';
							imgTpl += '<div class="slectVal">';
							imgTpl += '</div>';
						imgTpl += '</div>';
					}
					else{
						imgTpl += '<a onclick="addProdSetOrtherPropotyPop_case.selOrtherProtyPop(this)">';
							imgTpl += '<i class="sel_ico"></i>';
							imgTpl += '<span class="textHidden">'+imgTpl_data[i].name+'</span>';
						imgTpl += '</a>';
						
						imgTpl += '<div class="putTxtBox">';
							imgTpl += '<input type="text" onclick="addProdSetOrtherPropotyPop_case.showSelectBox(event,this,\''+imgTpl_data[i].id+'\')" oninput="addProdSetOrtherPropotyPop_case.likeSereach(event,this,'+i+')" onporpertychange="addProdSetOrtherPropotyPop_case.likeSereach(event,this,'+i+')" />';
							imgTpl += '<div class="slectVal">';
							imgTpl += '</div>';
						imgTpl += '</div>';
						
						/*imgTpl += '<select>';
							valOpt = imgTpl_data[i].values;
							valOpt_len = valOpt.length;
							i2 = 0;
							for(;i2<valOpt_len;i2++){
								imgTpl += '<option value="'+valOpt[i2].id+'">'+valOpt[i2].name+'</option>';
							}
						imgTpl += '</select>';*/
					}
				
					
				imgTpl += '</li>';

			}					

			this.slectBox.append(imgTpl);

			textTpl += '<li class="clearfix">';
				textTpl += '<span class="ind">1.</span>';
				textTpl += '<input type="text" placeholder="请在这里输入你想要的产品属性值"/>';
			textTpl += '</li>';
			
			//this.textBox.append(textTpl);

			this.show();

		};
		
		this.otherValSelectObj;
		
		this.showSelectBox = function(e,self,id){
					
			var e = e || window.event;

			if(e.stopPropagation){
				e.stopPropagation();
			}
			else{
				e.cancelBubble = true;
			}

			var that = $(self),
				parent = that.parent(),
				dataV = this.likeSereachData,
				$li = parent.parent(),
				ind,
				key;
			
			$li.siblings('li').find('.putTxtBox').removeClass('active');
			ind = $li.index();
			key = 'k'+ind;

			if(parent.hasClass('active')){
				return;
			}

			parent.addClass('active');			
			this.otherValSelectObj = parent;
			
			if(dataV[key]){
				this.likeSereach(e,self,id,key);
				return;
			}			
			this.getOtherValData(e,self,id,key);
			
		};
		
		this.stoplikeSereach = false;
		
		this.likeSereach = function(e,self,ind){
			
			this.stoplikeSereach = true;
			var $el = $(self),
				val = $el.val(),
				ind = $el.parents('li').index(),
				key = 'k'+ind,
				data = this.likeSereachData[key],
				len = data.length,
				i = 0,
				res = [];
			
			this.stoplikeSereach = false;
			
			if(!val){
				this.randerOtherValFn(data,$el);
				return;
			}
			
			for(;i<len;i++){
				
				if(this.stoplikeSereach){
					return;
				}
				
				if(data[i].propertiesValue.indexOf(val) !== -1){
					res.push(data[i]);
				}				
			}
			
			this.randerOtherValFn(res,$el);
			
			
		};
		
		this.randerOtherValFn = function(data,$el){
			
			var str = '',
				len = data.length,
				i = 0;
			for(;i<len;i++){
				str += '<p class="v-item" onclick="addProdSetOrtherPropotyPop_case.slectOtherVal(this)">'+data[i].propertiesValue+'</p>';
			}
	
			$el.siblings('.slectVal').html(str);
			
		};


		this.getOtherValData = function(e,self,id,ind){
			
			var that = this,
				$el = $(self),
				val = $el.val(),
				data = {
					propertiesId : id,
					propertiesValue : val
				};

			$.ajax({
				url : fullPath('prodProperty/matchPropertyVal'),
				method : 'POST',
				contentType: "application/json; charset=utf-8",
				data : JSON.stringify(data),
				success : function(r){
					
					if(r.meta && r.meta.code !== 200){
						return;
					}
					//请求成功之后
					
					if(!that.likeSereachData[ind]){
						that.likeSereachData[ind] = r.data;
					}
					
					/*var str = '',
						len = r.data.length,
						i = 0;
					for(;i<len;i++){
						str += '<p class="v-item" onclick="addProdSetOrtherPropotyPop_case.slectOtherVal(this)">'+r.data[i].propertiesValue+'</p>';
					}

					that.siblings('.slectVal').html(str);*/
					that.randerOtherValFn(r.data,$el);
					
				}
			});			

		};


		this.slectOtherVal = function(self){
			var that = $(self);
			that.parent().siblings('input').val(that.html());
		};

		this.init = function(data){

			this.likeSereachData = {};
			
			var that = this;
			
			if(Object.prototype.toString.call(data) !== '[object Object]'){
				return;
			}

			if(Object.prototype.toString.call(data.randerBefor) === '[object Function]'){
				this.randerBefor = data.randerBefor;
			}

			var tpl = '',
				self = this,
				popBox;

			tpl += '<div class="addProdSetOrtherPropotyPop" id="addProdSetOrtherPropotyPop">';
				tpl += '<div class="popBg"></div>';
				tpl += '<div class="content">';
					tpl += '<div class="tilBox">请填写该产品的其他属性</div>';
					tpl += '<ul class="protyList clearfix"></ul>';
					/*tpl += '<p class="addByselfTips">如无所需要的属性，请在下方手动填写</p>';
					tpl += '<ul id="addProtyBySelf" class="addProtyBySelf"></ul>';
					tpl += '<a class="addProty_btn" onclick="addProdSetOrtherPropotyPop_case.addProtyBySelfItem()">继续新增</a>';*/
					tpl += '<div class="BtnCent">';
						tpl += '<a class="btn-ib cancel">取消</a>';
						tpl += '<a class="btn-ib subBtn">确定</a>';
					tpl += '</div>';
				tpl += '</div>';
			tpl += '</div>';


			$('body').append(tpl);

			popBox = this.popBox = $('#addProdSetOrtherPropotyPop');

			this.closeBtn = popBox.find('.cancel');

			this.slectBox = popBox.find('.protyList');

			//this.textBox = popBox.find('.addProtyBySelf');

			this.subBtn = popBox.find('.subBtn');

			this.closeBtn.click(function(){
				self.close();
			});

			this.subBtn.click(function(){
				
				var valStr = '',
					$list = that.slectBox.find('li'),
					len = $list.length,
					temp,
					i = 0;
				
				for(;i<len;i++){
					
					if( $list.eq(i).find('a').hasClass('active')){
						temp = $.trim($list.eq(i).find('input[type="text"]').val());
						if(temp || temp === 0){
							valStr += i+'#'+temp+';';
						}
						
					}
					
				}
					
				valStr = valStr.slice(0,-1);
				
				that.valEl.val(valStr);
				self.close();
			});
			
			$(document).on('click',function(e){
				
				var e = e || window.event;

				if(e.stopPropagation){
					e.stopPropagation();
				}
				else{
					e.cancelBubble = true;
				}

				if(that.otherValSelectObj){
					that.otherValSelectObj.removeClass('active');
					that.otherValSelectObj = null;
				}

			});

			this.rander(data);

		};

		this.init(data);


	}

	return function(data){

		if(!_unique){
			_unique = new Pop(data);
		}
		else{
			_unique.rander(data);
		}
		
		return _unique;
	};

})();


























