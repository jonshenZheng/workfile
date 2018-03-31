/* 
* @Author: RainCloud
* @Date:   2018-01-30 09:52:08
* @Last Modified by:   RainCloud
* @Last Modified time: 2018-03-31 18:55:02
*/

/*需要引用工具类tool.js*/


/*聊天弹窗（没有防止xss攻击）*/
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


/*树状分类*/
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
	
	if(UiMethod.whichBroser('ie7')){
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
			activeInd = 0,
			activeName = opt.activeName || '';


		function randerFn(arr,depth){
		    var len = arr.length,
		        temp,
		        depth_i = depth,
		        i = 0;

		    for(;i<len;i++){
		    	countInd++;
		        temp = arr[i];
		        tpl += '<li class="count'+countInd+' level'+depth_i+'">';
		            if( temp.children && temp.children.length > 0 ){

		            	if(countInd == activeInd){
		                	tpl += '<a class="dropdown-toggle '+activeName+'  tree-dropdown-toggle-js" data-fid="'+temp.fid+'" data-path="'+temp.path+'" data-depath="'+depth_i+'"><i class="bordL"></i>'+temp.name+'<span class="nav_tri"></span></a>';
		            	}
		            	else{
		            		tpl += '<a class="dropdown-toggle tree-dropdown-toggle-js" data-fid="'+temp.fid+'" data-path="'+temp.path+'" data-depath="'+depth_i+'"><i class="bordL"></i>'+temp.name+'<span class="nav_tri"></span></a>';
		            	}

		              	tpl += '<ul class="submenu">';
		                randerFn(temp.children,depth_i+1);
		                tpl += '</ul>';

		            }
		            else{

		            	if(countInd == activeInd){
		            		tpl += '<a class="nav_link '+activeName+' tree-dropdown-toggle-js" data-fid="'+temp.fid+'" data-path="'+temp.path+'" data-depath="'+depth_i+'" >'+temp.name+'</a>';
		            	}
		            	else{
		            		tpl += '<a class="nav_link tree-dropdown-toggle-js" data-fid="'+temp.fid+'" data-path="'+temp.path+'" data-depath="'+depth_i+'" >'+temp.name+'</a>';
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

				$('.tree-dropdown-toggle-js').removeClass('active');
				that.addClass('active');

				fn(that);

				if(typeof opt.doFn === 'function'){
					opt.doFn(that);
				}

			});

		}

		return fn;

	}

  return tree;

})();

/**
 *  树状分类使用方法
 *  //下面是在客户端执行
 *	var categorySlider = easyTree({
		isShowALL : true,
		target : $('#prodTypeListDiv'),
		data : dataNodes,
		doFn : function(el_jq){}, //展开树后执行的方法
		beforDoFn : funtion(){} //展开树前执行的方法
	});

	//服务端先渲染节点，下面就只需要绑定事件即可
	var categorySlider = easyTree({
	    isShowALL : true
	  });


	$('.tree-dropdown-toggle-js').click(function(){
	  var that = $(this); 

	  //插入要执行的代码

	  fn(that);
	  $('.tree-dropdown-toggle-js').removeClass('active');
	  that.addClass('active');

	  //插入要执行的代码


	});
 *
 * 
 */







