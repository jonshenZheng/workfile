/* 
* @Author: RainCloud
* @Date:   2018-01-30 09:52:08
* @Last Modified by:   RainCloud
* @Last Modified time: 2018-01-31 09:43:35
*/

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